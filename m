Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575D74C39BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 00:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiBXXjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 18:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiBXXjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:39:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E82628AD9B;
        Thu, 24 Feb 2022 15:38:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F478B829EC;
        Thu, 24 Feb 2022 23:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69D2C340E9;
        Thu, 24 Feb 2022 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645745928;
        bh=0YlZtDEXXCa3COT8WZeKMrEVvDz6clkGmIRXfpRf668=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vA6yCd+suLV0uq3BUfVhKaM/XtXRLzyVLhXep8F/cJjEpy3/6TzAqXCjioBQ/UKoi
         DI+S7LQ1bME5hYWSkBSly64n7ycKrirpX+6N+p4d04j3y3jMln26onm7g1o1I7IBc8
         R61gfONDNujTZXlAoji3iA/xt/sb2kqCnvDVE7uSBYNnF4h+AE3Jh2oFTLWloNeLGh
         F4+Q3P/u64EYmVji6D+NJXhKYDwNOJhlY0ubHgKd7K1WMTNDIunG+noshfuETssQ3d
         E6WGQh6LBvjT9Ue669XXKPfDRPjEILaLqrfW99jXwoENbBa1OKoAAnHDMpoOM3v49+
         CNQqZMchSz5fQ==
Date:   Thu, 24 Feb 2022 15:38:48 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
Message-ID: <20220224233848.GC8269@magnolia>
References: <164568221518.25116.18139840533197037520@noble.neil.brown.name>
 <893053D7-E5DD-43DB-941A-05C10FF5F396@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893053D7-E5DD-43DB-941A-05C10FF5F396@dilger.ca>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:31:28AM -0700, Andreas Dilger wrote:
> On Feb 23, 2022, at 22:57, NeilBrown <neilb@suse.de> wrote:
> > 
> > 
> > I added this:
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -87,6 +87,7 @@ xfs_inode_alloc(
> >    /* VFS doesn't initialise i_mode or i_state! */
> >    VFS_I(ip)->i_mode = 0;
> >    VFS_I(ip)->i_state = 0;
> > +    VFS_I(ip)->i_flags |= S_PAR_UPDATE;
> >    mapping_set_large_folios(VFS_I(ip)->i_mapping);
> > 
> >    XFS_STATS_INC(mp, vn_active);
> > 
> > and ran my highly sophisticated test in an XFS directory:
> > 
> > for i in {1..70}; do ( for j in {1000..8000}; do touch $j; rm -f $j ; done ) & done

I think you want something faster here, like ln to hardlink an existing
file into the directory.

> > This doesn't crash - which is a good sign.
> > While that was going I tried
> > while : ; do ls -l ; done
> > 
> > it sometimes reports garbage for the stat info:
> > 
> > total 0
> > -????????? ? ?    ?    ?            ? 1749
> > -????????? ? ?    ?    ?            ? 1764
> > -????????? ? ?    ?    ?            ? 1765
> > -rw-r--r-- 1 root root 0 Feb 24 16:47 1768
> > -rw-r--r-- 1 root root 0 Feb 24 16:47 1770
> > -rw-r--r-- 1 root root 0 Feb 24 16:47 1772
> > ....
> > 
> > I *think* that is bad - probably the "garbage" that you referred to?
> > 
> > Obviously I gets lots of 
> > ls: cannot access '1764': No such file or directory
> > ls: cannot access '1749': No such file or directory
> > ls: cannot access '1780': No such file or directory
> > ls: cannot access '1765': No such file or directory
> > 
> > but that is normal and expected when you are creating and deleting
> > files during the ls.
> 
> The "ls -l" output with "???" is exactly the case where the filename is
> in readdir() but stat() on a file fails due to an unavoidable userspace 
> race between the two syscalls and the concurrent unlink(). This is
> probably visible even without the concurrent dirops patch. 
> 
> The list of affected filenames even correlates with the reported errors:
> 1764, 1765, 1769
> 
> It looks like everything is working as expected. 

Here, yes.

A problem that I saw a week or two ago with online fsck is that an evil
thread repeatedly link()ing and unlink()ing a file into an otherwise
empty directory while racing a thread calling readdir() in a loop will
eventually trigger a corruption report on the directory namecheck
because the loop in xfs_dir2_sf_getdents that uses sfp->count as a loop
counter will race with the unlink decrementing sfp->count and run off
the end of the inline directory data buffer.

https://elixir.bootlin.com/linux/latest/source/fs/xfs/xfs_dir2_readdir.c#L121

The solution in that case was a forgotten acquisition of the directory
IOLOCK, but I don't see why the same principle wouldn't apply here.
It's probably not so hard to fix it (rewrite readdir to take the ILOCK
once, format the dirents to a buffer until it's full, save cursor, drop
ILOCK, copy buffer to userspace) but it's not as easy as setting
PAR_UPDATE.

(I am also not a fan of "PAR_UPDATE", since 'par' is already an English
word that doesn't mean 'parallel'.)

--D

> 
> Cheers, Andreas
> 
