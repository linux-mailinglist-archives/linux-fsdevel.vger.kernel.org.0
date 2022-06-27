Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A955D9B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiF0OKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiF0OKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:10:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C6D13E15;
        Mon, 27 Jun 2022 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LzAnuHwwUJ6LdcbOlmZ//SGplp0xj1L9V6mRYE0195Q=; b=nqb88zVq/RA6sKlL8JH9plcQD8
        ocDWm8M2RNyZRk783mEuQcIt1qqvjDAdnlrsnZHAJiwJwcvAvGIoRS1tF6TOXUEMI4beDEtAjTQ60
        bV8iUHmwq+YPuwoXGFW+9wjZBk8QxwncrlmeiHQqxwEkuy3EdlwU8Wuni51Td3Vyo0K6UepEO5dRr
        wtm9u1jMF8DCS9/XgQ9B1q+60S4yc9IiGJu6OGzbBGjJsEdqk9uTVpgA8I5i1BDq+DYrgEAivY/48
        MdNLjiDiB6cir4SQeVor8b+zKpY2LkNH/a/g3wHnJIO+L+g9svP+NrN3Nc/mscTZRXZynQqX3yw58
        NayyVyfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5pRo-00BQ2y-Vw; Mon, 27 Jun 2022 14:10:41 +0000
Date:   Mon, 27 Jun 2022 15:10:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 25/25] xfs: Support large folios
Message-ID: <Yrm6YM2uS+qOoPcn@casper.infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-26-willy@infradead.org>
 <YrO243DkbckLTfP7@magnolia>
 <Yrku31ws6OCxRGSQ@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrku31ws6OCxRGSQ@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
> 
> So I guess I have a blunt force fix if we can't figure this one out
> before 5.19 final, but I'd really rather not.  Will keep trying this
> week.

I'm on holiday for the next week, so I'm not going to be able to spend
any time on this until then.  I have a suspicion that this may be the
same bug Zorro is seeing here:

https://lore.kernel.org/linux-mm/20220613010850.6kmpenitmuct2osb@zlang-mailbox/

At least I hope it is, and finding a folio that has been freed would
explain (apparent) file corruption.
