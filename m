Return-Path: <linux-fsdevel+bounces-21836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A0D90B7C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 19:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB30B2E42B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB30515F3E8;
	Mon, 17 Jun 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JWkKiRWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0015EFC7;
	Mon, 17 Jun 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641914; cv=none; b=Z/JoesGm4OkRW3x1LTkP6uhx5tQsp5ucV5mvPV7j+tU5htfEsNu2frSKObOqJ+vnGqBwxajNgl1GymhvOfP09wZe9shJSoghNoFBPYzJ09nYvkhw2ZO1hLKeM/C8z9ezdPgJp/vfoTP34IeoWTFXMCSv2BhZrlnkrQjsG4wL5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641914; c=relaxed/simple;
	bh=N/Is03mLCxdJCd/OOK+w/wlLamJmjEQxRrxdjj9UKRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+fgf/DZCp+NYUtsSU7NUSb95jWsTb137OrZRWoav/wmu9Ir1OSvO/RjGpDBnSghm/fByIbTLIKbAUmvmuiZs8YH+Xt1qMxMVpGd59v1PdvN1PvJDm2TgW+CwI7Hi83ssgSUH8F2ismS3Ed0fzxN9BI8EIZCK8jnZvG1FMQQyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JWkKiRWp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W2wPp2gXcz9sbq;
	Mon, 17 Jun 2024 18:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718641902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KuXIJ7LqfJ3Qb7t/gAz8A9hXQtRUtJOjtWlveOqVqMY=;
	b=JWkKiRWpGNhxs402fjJ1SGsC2FOtKPjRvo6mKa70tUJkaX1x+g+HSinnBkMxJvipXP6EOo
	HYkWfrYA0rxbNJvuyHEA48QNv6GtrcYKFVzJcr5Zf9j+oKLARU7yMDuusWVc4IcufP7b+s
	BxQvCVcHvH15El7O0iNZ3w91lfIsDlRFcEKK9KwDqV+jJFBHbSM9de2fCvYXGD8mKeaatI
	RPShWka2kHdS+p+bJTH69FL8xBeFnqwFPJyLWo5/vIa3Q6QXnT0zb684x2hvZ/kCxWFUCK
	nfybmgFIAvhP9gxxbyiIXcOsjpiCExUQP+qLJi9OOzLan/G2zXOtYI1H0nXQrA==
Date: Mon, 17 Jun 2024 16:31:36 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, djwong@kernel.org,
	chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 11/11] xfs: enable block size larger than page size
 support
Message-ID: <20240617163136.ozxrlxljmblcgny3@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-12-kernel@pankajraghav.com>
 <20240613084725.GC23371@lst.de>
 <Zm+RhjG6DUoat7lO@dread.disaster.area>
 <20240617065104.GA18547@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617065104.GA18547@lst.de>
X-Rspamd-Queue-Id: 4W2wPp2gXcz9sbq

On Mon, Jun 17, 2024 at 08:51:04AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 17, 2024 at 11:29:42AM +1000, Dave Chinner wrote:
> > > > +	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> > > > +		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
> > > > +	else
> > > > +		igeo->min_folio_order = 0;
> > > >  }
> > > 
> > > The minimum folio order isn't really part of the inode (allocation)
> > > geometry, is it?
> > 
> > I suggested it last time around instead of calculating the same
> > constant on every inode allocation. We're already storing in-memory
> > strunct xfs_inode allocation init values in this structure. e.g. in
> > xfs_inode_alloc() we see things like this:
> 
> While new_diflags2 isn't exactly inode geometry, it at least is part
> of the inode allocation.  Folio min order for file data has nothing
> to do with this at all.
> 
> > The only other place we might store it is the struct xfs_mount, but
> > given all the inode allocation constants are already in the embedded
> > mp->m_ino_geo structure, it just seems like a much better idea to
> > put it will all the other inode allocation constants than dump it
> > randomly into the struct xfs_mount....
> 
> Well, it is very closely elated to say the m_blockmask field in
> struct xfs_mount.  The again modern CPUs tend to get a you simple
> subtraction for free in most pipelines doing other things, so I'm
> not really sure it's worth caching for use in inode allocation to
> start with, but I don't care strongly about that.

But there will also be an extra conditional apart from subtraction
right? 

Initially it was something like this:

@@ -73,6 +73,7 @@ xfs_inode_alloc(
 	xfs_ino_t		ino)
 {
 	struct xfs_inode	*ip;
+	int			min_order = 0;
 
 	/*
 	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
@@ -88,7 +89,8 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
+	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
+	mapping_set_folio_orders(VFS_I(ip)->i_mapping, min_order, MAX_PAGECACHE_ORDER);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -313,6 +315,7 @@ xfs_reinit_inode(
 	dev_t			dev = inode->i_rdev;
 	kuid_t			uid = inode->i_uid;
 	kgid_t			gid = inode->i_gid;
+	int			min_order = 0;
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -323,7 +326,8 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	mapping_set_large_folios(inode->i_mapping);
+	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
+	mapping_set_folio_orders(inode->i_mapping, min_order, MAX_PAGECACHE_ORDER);
 	return error;
 }

It does introduce a conditional in the inode allocation hot path so I
went with what Chinner proposed as it is something we use when we
initialize an inode.

