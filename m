Return-Path: <linux-fsdevel+bounces-76460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF7YHFHIhGk45QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:41:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ECFF55C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55025302C5E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EC439014;
	Thu,  5 Feb 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWtP1fOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025ED24113C;
	Thu,  5 Feb 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309412; cv=none; b=fu9k6LIKOLRMirfRI+HZ7CI/5Y7N8Mtsb+r6kcVT/CWqewdNv+BYIFYJiAJ8YRqkJbCvJn/zqPCIgZgynQwK3WgkE0+5HSq8f/5ymrGHKAEq+iyl+Vqli4wHJGt3KW3DFGQm1nTxgDfMZ6AgG/JABkMhYrwm3OnK1vmvvmpL4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309412; c=relaxed/simple;
	bh=PWHnFoAeT4ZzfE7wkU3YE+Odl1P4t4VqAmTRmpHKeo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdhxwKLFnI5QLPoSq3DcdlHAE4TpMlliRzzQ6pntfEcrcTnt8yXtfRqsGzAdzzKgdPYHwtldDzO/uuUDhu/2uoeTXffZDb5v6gvjFZ7D1nbt/pzIt968P7fJ4Gba+S36M7ZnX+ucxOcaQuJB2aW8MkzYWtIiyz+zqACB/yOEOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWtP1fOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E1EC4CEF7;
	Thu,  5 Feb 2026 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770309411;
	bh=PWHnFoAeT4ZzfE7wkU3YE+Odl1P4t4VqAmTRmpHKeo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWtP1fOVcPQAT9Fo8KQ8aRmSIzoMldtPfGwNQacpf5/psLTp6UXgIGdQPH3lKec6i
	 i/6GuaUz6oiAGlvrVJFmqVLcLHOu3b9sgVBNQOs/SUxniOlKoNuv8XfJ9Q/9VKlhsn
	 VZzdmbkwK5/mAJ/Gk8dbvxh5pMOb7aajOWgBgE4ipFapG5+80QmOGMOkbV1KN/Jmc0
	 i/qOy+5V/v4LK5O7o2QWqSq9TnsLcBHqczeLE2iIzS/3zkU07YYCY1q4bhG8nDvNvf
	 lvL5h7O/hxgoYX2Ie8aNnDkUCAqVMLqv+vg/JN85o4qaJLquRtp4/BbsFDIS4UkOQr
	 ionNxzswwX7bQ==
Date: Thu, 5 Feb 2026 08:36:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org,
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, dave@stgolabs.net, cem@kernel.org,
	wangyufei@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v3 3/6] xfs: add per-inode AG prediction map and dirty-AG
 bitmap
Message-ID: <20260205163650.GQ7712@frogsfrogsfrogs>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
 <CGME20260116101251epcas5p1cf5b48f2efb14fe4387be3053b3c3ebc@epcas5p1.samsung.com>
 <20260116100818.7576-4-kundan.kumar@samsung.com>
 <87a16d4d9c1e568a37fa07a97dda5777e14e9a8b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a16d4d9c1e568a37fa07a97dda5777e14e9a8b.camel@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76460-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[samsung.com,zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: D0ECFF55C0
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:06:19PM +0530, Nirjhar Roy (IBM) wrote:
> On Fri, 2026-01-16 at 15:38 +0530, Kundan Kumar wrote:
> > Add per-inode structures to track predicted AGs of dirty folios using
> > an xarray and bitmap. This enables efficient identification of AGs
> > involved in writeback.
> > 
> > Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > ---
> >  fs/xfs/xfs_icache.c | 27 +++++++++++++++++++++++++++
> >  fs/xfs/xfs_inode.h  |  5 +++++
> >  2 files changed, 32 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > index e44040206851..f97aa6d66271 100644
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -80,6 +80,25 @@ static inline xa_mark_t ici_tag_to_mark(unsigned int tag)
> >  	return XFS_PERAG_BLOCKGC_MARK;
> >  }
> >  
> > +static int xfs_inode_init_ag_bitmap(struct xfs_inode *ip)
> Similar comment as before:
> static int
> xfs_inode_init...()
> > +{
> > +	unsigned int bits = ip->i_mount->m_sb.sb_agcount;
> > +	unsigned int nlongs;
> > +
> > +	xa_init_flags(&ip->i_ag_pmap, XA_FLAGS_LOCK_IRQ);
> Nit: The name of the functions suggests that it is initializing the tracking bitmap which it does -
> however, the above line does slightly different thing? Maybe move the xarray init outside the bitmap
> init function? 

Or just call it something else?  xfs_inode_init_perag_wb?

> > +	ip->i_ag_dirty_bitmap = NULL;
> > +	ip->i_ag_dirty_bits = bits;
> > +
> > +	if (!bits)
> Umm, !bits means agcount is 0. Shouldn't we ASSERT that bits >= 2? Or am I missing something?

Technically you can have 1 AG, but you definitely can't mount a zero AG
filesystem.

> > +		return 0;
> > +
> > +	nlongs = BITS_TO_LONGS(bits);
> > +	ip->i_ag_dirty_bitmap = kcalloc(nlongs, sizeof(unsigned long),
> > +					GFP_NOFS);
> > +
> > +	return ip->i_ag_dirty_bitmap ? 0 : -ENOMEM;
> > +}
> > +
> >  /*
> >   * Allocate and initialise an xfs_inode.
> >   */
> > @@ -131,6 +150,8 @@ xfs_inode_alloc(
> >  	ip->i_next_unlinked = NULLAGINO;
> >  	ip->i_prev_unlinked = 0;
> >  
> > +	xfs_inode_init_ag_bitmap(ip);
> xfs_inode_init_ag_bitmap() returns int - error handling for -ENOMEM?
> > +
> >  	return ip;
> >  }
> >  
> > @@ -194,6 +215,12 @@ xfs_inode_free(
> >  	ip->i_ino = 0;
> >  	spin_unlock(&ip->i_flags_lock);
> >  
> > +	/* free xarray contents (values are immediate packed ints) */
> > +	xa_destroy(&ip->i_ag_pmap);
> Nit:Maybe have a small wrapper for freeing it the prediction map? No hard preferences though.
> > +	kfree(ip->i_ag_dirty_bitmap);
> > +	ip->i_ag_dirty_bitmap = NULL;
> Nit: Usually while freeing the pointers I prefer:
> t = ip->i_ag_dirty_bitmap;
> ip->i_ag_dirty_bitmap = NULL;
> kfree(t);
> In this way, the pointer(i_ag_dirty_bitmap in this case) that I am freeing never points to an
> already freed address.
> 
> > +	ip->i_ag_dirty_bits = 0;
> > +
> >  	__xfs_inode_free(ip);
> >  }
> >  
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index bd6d33557194..dee449168605 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -99,6 +99,11 @@ typedef struct xfs_inode {
> >  	spinlock_t		i_ioend_lock;
> >  	struct work_struct	i_ioend_work;
> >  	struct list_head	i_ioend_list;
> > +
> > +	/* AG prediction map: pgoff_t -> packed u32 */
> > +	struct xarray           i_ag_pmap;
> > +	unsigned long           *i_ag_dirty_bitmap;
> > +	unsigned int            i_ag_dirty_bits;
> Not sure but, I mostly see the typedefed versions of data types being used like uint32 etc. Darrick,
> hch, are the above fine?

Yes, please don't mix types.  Pick one type and stick with it.

(and yes I wish we could struct bitmap_t(unsigned long))

--D

> --NR
> >  } xfs_inode_t;
> >  
> >  static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
> 
> 

