Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C64C51F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 00:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiBYXQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 18:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYXQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:16:55 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BA361E5A65;
        Fri, 25 Feb 2022 15:16:22 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7FFB6530304;
        Sat, 26 Feb 2022 10:16:19 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nNjow-00GQk8-BA; Sat, 26 Feb 2022 10:16:18 +1100
Date:   Sat, 26 Feb 2022 10:16:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>, NeilBrown <neilb@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
Message-ID: <20220225231618.GQ3061737@dread.disaster.area>
References: <164568221518.25116.18139840533197037520@noble.neil.brown.name>
 <893053D7-E5DD-43DB-941A-05C10FF5F396@dilger.ca>
 <20220224233848.GC8269@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224233848.GC8269@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62196344
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=fKKHiC7PVA1Wypr2PesA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:38:48PM -0800, Darrick J. Wong wrote:
> On Thu, Feb 24, 2022 at 09:31:28AM -0700, Andreas Dilger wrote:
> > On Feb 23, 2022, at 22:57, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > 
> > > I added this:
> > > --- a/fs/xfs/xfs_icache.c
> > > +++ b/fs/xfs/xfs_icache.c
> > > @@ -87,6 +87,7 @@ xfs_inode_alloc(
> > >    /* VFS doesn't initialise i_mode or i_state! */
> > >    VFS_I(ip)->i_mode = 0;
> > >    VFS_I(ip)->i_state = 0;
> > > +    VFS_I(ip)->i_flags |= S_PAR_UPDATE;
> > >    mapping_set_large_folios(VFS_I(ip)->i_mapping);
> > > 
> > >    XFS_STATS_INC(mp, vn_active);
> > > 
> > > and ran my highly sophisticated test in an XFS directory:
> > > 
> > > for i in {1..70}; do ( for j in {1000..8000}; do touch $j; rm -f $j ; done ) & done
> 
> I think you want something faster here, like ln to hardlink an existing
> file into the directory.
> 
> > > This doesn't crash - which is a good sign.
> > > While that was going I tried
> > > while : ; do ls -l ; done
> > > 
> > > it sometimes reports garbage for the stat info:
> > > 
> > > total 0
> > > -????????? ? ?    ?    ?            ? 1749
> > > -????????? ? ?    ?    ?            ? 1764
> > > -????????? ? ?    ?    ?            ? 1765
> > > -rw-r--r-- 1 root root 0 Feb 24 16:47 1768
> > > -rw-r--r-- 1 root root 0 Feb 24 16:47 1770
> > > -rw-r--r-- 1 root root 0 Feb 24 16:47 1772
> > > ....
> > > 
> > > I *think* that is bad - probably the "garbage" that you referred to?
> > > 
> > > Obviously I gets lots of 
> > > ls: cannot access '1764': No such file or directory
> > > ls: cannot access '1749': No such file or directory
> > > ls: cannot access '1780': No such file or directory
> > > ls: cannot access '1765': No such file or directory
> > > 
> > > but that is normal and expected when you are creating and deleting
> > > files during the ls.
> > 
> > The "ls -l" output with "???" is exactly the case where the filename is
> > in readdir() but stat() on a file fails due to an unavoidable userspace 
> > race between the two syscalls and the concurrent unlink(). This is
> > probably visible even without the concurrent dirops patch. 
> > 
> > The list of affected filenames even correlates with the reported errors:
> > 1764, 1765, 1769
> > 
> > It looks like everything is working as expected. 
> 
> Here, yes.
> 
> A problem that I saw a week or two ago with online fsck is that an evil
> thread repeatedly link()ing and unlink()ing a file into an otherwise
> empty directory while racing a thread calling readdir() in a loop will
> eventually trigger a corruption report on the directory namecheck
> because the loop in xfs_dir2_sf_getdents that uses sfp->count as a loop
> counter will race with the unlink decrementing sfp->count and run off
> the end of the inline directory data buffer.

Ah, shortform dirs might need the readdir moved inside the

	lock_mode = xfs_ilock_data_map_shared(dp);

section so that the ILOCK is held while readdir is pulling the
dirents out of the inode - there's no buffer lock to serialise that
against concurrent modifications like there are for block/leaf/node
formats.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
