Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957CF55CAF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiF0WI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 18:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242707AbiF0WH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:07:58 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E8EB1EAF7;
        Mon, 27 Jun 2022 15:07:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id ACE1C10E8AAB;
        Tue, 28 Jun 2022 08:07:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o5wss-00BprG-R5; Tue, 28 Jun 2022 08:07:06 +1000
Date:   Tue, 28 Jun 2022 08:07:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 25/25] xfs: Support large folios
Message-ID: <20220627220706.GE227878@dread.disaster.area>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-26-willy@infradead.org>
 <YrO243DkbckLTfP7@magnolia>
 <Yrku31ws6OCxRGSQ@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrku31ws6OCxRGSQ@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62ba2a0f
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=zWDtqcPLiWjt79Nc-aUA:9 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 26, 2022 at 09:15:27PM -0700, Darrick J. Wong wrote:
> On Wed, Jun 22, 2022 at 05:42:11PM -0700, Darrick J. Wong wrote:
> > [resend with shorter 522.out file to keep us under the 300k maximum]
> > 
> > On Thu, Dec 16, 2021 at 09:07:15PM +0000, Matthew Wilcox (Oracle) wrote:
> > > Now that iomap has been converted, XFS is large folio safe.
> > > Indicate to the VFS that it can now create large folios for XFS.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  fs/xfs/xfs_icache.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > > index da4af2142a2b..cdc39f576ca1 100644
> > > --- a/fs/xfs/xfs_icache.c
> > > +++ b/fs/xfs/xfs_icache.c
> > > @@ -87,6 +87,7 @@ xfs_inode_alloc(
> > >  	/* VFS doesn't initialise i_mode or i_state! */
> > >  	VFS_I(ip)->i_mode = 0;
> > >  	VFS_I(ip)->i_state = 0;
> > > +	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> > >  
> > >  	XFS_STATS_INC(mp, vn_active);
> > >  	ASSERT(atomic_read(&ip->i_pincount) == 0);
> > > @@ -320,6 +321,7 @@ xfs_reinit_inode(
> > >  	inode->i_rdev = dev;
> > >  	inode->i_uid = uid;
> > >  	inode->i_gid = gid;
> > > +	mapping_set_large_folios(inode->i_mapping);
> > 
> > Hmm.  Ever since 5.19-rc1, I've noticed that fsx in generic/522 now
> > reports file corruption after 20 minutes of runtime.  The corruption is
> > surprisingly reproducible (522.out.bad attached below) in that I ran it
> > three times and always got the same bad offset (0x6e000) and always the
> > same opcode (6213798(166 mod 256) MAPREAD).
> > 
> > I turned off multipage folios and now 522 has run for over an hour
> > without problems, so before I go do more debugging, does this ring a
> > bell to anyone?
> 
> I tried bisecting, but that didn't yield anything productive and
> 5.19-rc4 still fails after 25 minutes; however, it seems that g/522 will
> run without problems for at least 3-4 days after reverting this patch
> from -rc3.

Took 63 million ops and just over 3 hours before it failed here with
a similar 16 byte map read corruption on the first 16 bytes of a
page. Given the number of fallocate operations that lead up to the
failure - 14 of last 23, plus 3 clone, 2 copy, 2 map read, 1 skip
and the map write that it suggests the stale data came from - this
smells of an invalidation issue...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
