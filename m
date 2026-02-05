Return-Path: <linux-fsdevel+bounces-76463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIirIqPIhGk45QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:43:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC7F561A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E826730205FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964D439012;
	Thu,  5 Feb 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIHoEhLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB56F423143;
	Thu,  5 Feb 2026 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309759; cv=none; b=CZqKfEQOL6XW1MY8+xprRps5r76GWZ7KgxZyqRjV+sya5KG66KkiOnGf50d5JvNynedXeSOjxUuG3eEeIDKnabrCmsbWMm5p8JDQVYtgxCpETy8btc5cFd7eMG2Ij+z3PPh0aP1lakQWC1z1BpSNAdT6ZYtH3VhG1y4xgZgih5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309759; c=relaxed/simple;
	bh=qtCIuwxbUz6nAxAm44y57E2QMBh06l1dKLAKWSKgEDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzNeVyJKLGuLkoXwHu/hDBd5ure52/h/Ka6qZCql5mu9/ZuMAEZ71RGibrU6BGMACZh0gFd6lagnWU0lstoswntchXO5xMptDWp2BPFaRdyxq9hVjjCBIAZpJedCObpiCvydO5Dfgk6EsRiXtVvWVFCWlFR48CpgQ/WCK/6L5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIHoEhLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A177C4CEF7;
	Thu,  5 Feb 2026 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770309759;
	bh=qtCIuwxbUz6nAxAm44y57E2QMBh06l1dKLAKWSKgEDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIHoEhLfk5gLa6aiZb8rIG5WH5MvQz2EcqscXHWOJSfjO9XtyLKuihjRP4fkRIDuv
	 xQ5tqTAHKA7tlox5BoOiDOKTYW0zOvTxvWqnMz9Qk9kb+RBflXQnKCh3b9uPyhv6m6
	 NMXKGnyZJ9PlM1/e+12kS4IgXvVjWG9qnpSs55GwGz+obvdjAbjxLOJfoY9GE9A22j
	 IvLLS7PM5l7wfgzp/+Gqj8IIhKvGcMldeYPIXTFSfzSsNup6mjA3qymBryVRboUu3Z
	 iWcYvj3APifqtCh8ulKn0JM6Vxzm6tK1HNZp7+leExEEZYA9USJEbYOH4DYsEbIrYe
	 EVCVymgbXiqJQ==
Date: Thu, 5 Feb 2026 08:42:38 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	hch@lst.de, ritesh.list@gmail.com, dave@stgolabs.net,
	cem@kernel.org, wangyufei@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v3 3/6] xfs: add per-inode AG prediction map and dirty-AG
 bitmap
Message-ID: <20260205164238.GS7712@frogsfrogsfrogs>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
 <CGME20260116101251epcas5p1cf5b48f2efb14fe4387be3053b3c3ebc@epcas5p1.samsung.com>
 <20260116100818.7576-4-kundan.kumar@samsung.com>
 <20260129004404.GA7712@frogsfrogsfrogs>
 <2c485586-83c9-4697-91fc-7b0cee697704@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c485586-83c9-4697-91fc-7b0cee697704@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76463-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 1ACC7F561A
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:50:53PM +0530, Kundan Kumar wrote:
> On 1/29/2026 6:14 AM, Darrick J. Wong wrote:
> > On Fri, Jan 16, 2026 at 03:38:15PM +0530, Kundan Kumar wrote:
> >> Add per-inode structures to track predicted AGs of dirty folios using
> >> an xarray and bitmap. This enables efficient identification of AGs
> >> involved in writeback.
> >>
> >> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> >> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> >> ---
> >>   fs/xfs/xfs_icache.c | 27 +++++++++++++++++++++++++++
> >>   fs/xfs/xfs_inode.h  |  5 +++++
> >>   2 files changed, 32 insertions(+)
> >>
> >> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> >> index e44040206851..f97aa6d66271 100644
> >> --- a/fs/xfs/xfs_icache.c
> >> +++ b/fs/xfs/xfs_icache.c
> >> @@ -80,6 +80,25 @@ static inline xa_mark_t ici_tag_to_mark(unsigned int tag)
> >>   	return XFS_PERAG_BLOCKGC_MARK;
> >>   }
> >>   
> >> +static int xfs_inode_init_ag_bitmap(struct xfs_inode *ip)
> >> +{
> >> +	unsigned int bits = ip->i_mount->m_sb.sb_agcount;
> >> +	unsigned int nlongs;
> >> +
> >> +	xa_init_flags(&ip->i_ag_pmap, XA_FLAGS_LOCK_IRQ);
> > 
> > This increases the size of struct xfs_inode by 40 bytes...
> > 
> 
> I’ll make this lazy and sparse: move AG writeback state behind a pointer
> allocated on first use, and replace the bitmap with a sparse dirty-AG
> set(xarray keyed by agno) so memory scales with AGs actually touched by
> the inode.
> 
> >> +	ip->i_ag_dirty_bitmap = NULL;
> >> +	ip->i_ag_dirty_bits = bits;
> >> +
> >> +	if (!bits)
> >> +		return 0;
> >> +
> >> +	nlongs = BITS_TO_LONGS(bits);
> >> +	ip->i_ag_dirty_bitmap = kcalloc(nlongs, sizeof(unsigned long),
> >> +					GFP_NOFS);
> > 
> > ...and there could be hundreds or thousands of AGs for each filesystem.
> > That's a lot of kernel memory to handle this prediction stuff, and I"m
> > not even sure what ag_dirty_bitmap does yet.
> > 
> 
> The bit for an AG is set in ag_dirty_bitmap at write time. During
> writeback, we check which AG bits are set, wake only those AG-specific
> workers, and each worker scans the page cache, filters folios tagged for
> its AG, and submits the I/O.
> 
> >> +
> >> +	return ip->i_ag_dirty_bitmap ? 0 : -ENOMEM;
> >> +}
> >> +
> >>   /*
> >>    * Allocate and initialise an xfs_inode.
> >>    */
> >> @@ -131,6 +150,8 @@ xfs_inode_alloc(
> >>   	ip->i_next_unlinked = NULLAGINO;
> >>   	ip->i_prev_unlinked = 0;
> >>   
> >> +	xfs_inode_init_ag_bitmap(ip);
> > 
> > Unchecked return value???
> 
> Will correct in next version
> 
> > 
> >> +
> >>   	return ip;
> >>   }
> >>   
> >> @@ -194,6 +215,12 @@ xfs_inode_free(
> >>   	ip->i_ino = 0;
> >>   	spin_unlock(&ip->i_flags_lock);
> >>   
> >> +	/* free xarray contents (values are immediate packed ints) */
> >> +	xa_destroy(&ip->i_ag_pmap);
> >> +	kfree(ip->i_ag_dirty_bitmap);
> >> +	ip->i_ag_dirty_bitmap = NULL;
> >> +	ip->i_ag_dirty_bits = 0;
> >> +
> >>   	__xfs_inode_free(ip);
> >>   }
> >>   
> >> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> >> index bd6d33557194..dee449168605 100644
> >> --- a/fs/xfs/xfs_inode.h
> >> +++ b/fs/xfs/xfs_inode.h
> >> @@ -99,6 +99,11 @@ typedef struct xfs_inode {
> >>   	spinlock_t		i_ioend_lock;
> >>   	struct work_struct	i_ioend_work;
> >>   	struct list_head	i_ioend_list;
> >> +
> >> +	/* AG prediction map: pgoff_t -> packed u32 */
> > 
> > What about blocksize < pagesize filesystems?  Which packed agno do you
> > associate with the pgoff_t?
> > 
> > Also, do you have an xarray entry for each pgoff_t in a large folio?
> > 
> > --D
> > 
> 
> pgoff_t here is the pagecache index (folio->index), i.e. file offset in
> PAGE_SIZE units, not a filesystem block index. So blocksize < PAGE_SIZE
> doesn’t change the association, the packed agno is attached to the folio
> at that pagecache index.

Ok, so the tag is entirely determined by the AG of the first fsblock
within the folio.

> We store one xarray entry per folio index (the start of the folio). We 
> do not create entries for each base-page inside a large folio. If a 
> large folio could span multiple extents/AGs, we’ll treat the hint as 
> advisory and tag it invalid (fallback to normal writeback routing) 
> rather than trying to encode per-subpage AGs.

Oh, ok, so if you have the mapping and the folio at the same time you
can determine that the entire large folio maps to a single extent, and
tag the whole large folio as belonging to a single AG.  That clears
things up, thank you.

It's only in the case of extreme fragmentation that a large folio gets
flung at the old writeback paths, which is probably good enough anyway.

--D

> >> +	struct xarray           i_ag_pmap;
> >> +	unsigned long           *i_ag_dirty_bitmap;
> >> +	unsigned int            i_ag_dirty_bits;
> >>   } xfs_inode_t;
> >>   
> >>   static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
> >> -- 
> >> 2.25.1
> >>
> >>
> > 
> 
> 

