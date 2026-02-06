Return-Path: <linux-fsdevel+bounces-76537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOj7N+CChWnpCgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:57:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D84FA81D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF735300DF6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37B32EBB89;
	Fri,  6 Feb 2026 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR0LqKAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6F279DAB;
	Fri,  6 Feb 2026 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357467; cv=none; b=NL09wYX7Sj4/5E9gJBQ+Jc+i1Wvz7D8EKaFSKO6ywOo/bfN+oOz3XapoROPwsTEenRRfC13tC2u36dKvTaYivhwUOv5Su+cDNhXfQgcAo9slPXFg2qjBRZenxa3dY3HYtwWvOC73kyVedDFx70xrJFi4sMT8PMWCkz4Dt+jVDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357467; c=relaxed/simple;
	bh=oYL20gj3/vQJmBknDkEoqDhmY9er8aGSnGFscJ9Oh6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9gKEIBuW/Z0ADSoGo6jxJ7sDJydWJYHfWJLZbiXQKFAVYGUkuBaTos+WHqZeOHqe2J2eBwNHkEkAp1s42735SQoKI982HPyKkBVN/7jU24R3OB51Ixz806ViORtEAkFoJJeruoaD7LHfRgcSxTHICEoeYDN0dqv54l1ALgVxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR0LqKAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8A4C116C6;
	Fri,  6 Feb 2026 05:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770357466;
	bh=oYL20gj3/vQJmBknDkEoqDhmY9er8aGSnGFscJ9Oh6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oR0LqKAcS9X16qr1qQJHruGs2nDKJ04RRniQXKwzP86qxGWh9O6h5b+I6htfXh26f
	 PkGET2RH+i4keAimTDz/3T5GSzSLqA1lU9cQrkiz8g8lm88AJ1Za9LLKSFHDPb99JG
	 +Cw6vZoOckf9/z9NnCjS0LBy7QCA4VUCuCfcZ9B5lNvtYN1B8khoe71nzPqMWEGftM
	 z2Ihc0zs6BuHsWQNJiz6b6i/o2eiU6V8wSb9QLYZrnqsF3/L4FqenwNygFcmB3Vsjr
	 5i/1wMOHalz3NSANkLmsooHp4jk5jpxGLUepeINn6KV4MRwO1FmnKYFgZyDodPK61w
	 mrUIqPcU8IPXA==
Date: Thu, 5 Feb 2026 21:57:45 -0800
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
Message-ID: <20260206055745.GV7712@frogsfrogsfrogs>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
 <CGME20260116101251epcas5p1cf5b48f2efb14fe4387be3053b3c3ebc@epcas5p1.samsung.com>
 <20260116100818.7576-4-kundan.kumar@samsung.com>
 <87a16d4d9c1e568a37fa07a97dda5777e14e9a8b.camel@gmail.com>
 <20260205163650.GQ7712@frogsfrogsfrogs>
 <a017b49e0fb5b9f1a4f6929d7fb23897c98e2595.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a017b49e0fb5b9f1a4f6929d7fb23897c98e2595.camel@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76537-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 89D84FA81D
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:06:03AM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2026-02-05 at 08:36 -0800, Darrick J. Wong wrote:
> > On Thu, Feb 05, 2026 at 12:06:19PM +0530, Nirjhar Roy (IBM) wrote:
> > > On Fri, 2026-01-16 at 15:38 +0530, Kundan Kumar wrote:
> > > > Add per-inode structures to track predicted AGs of dirty folios using
> > > > an xarray and bitmap. This enables efficient identification of AGs
> > > > involved in writeback.
> > > > 
> > > > Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> > > > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > > > ---
> > > >  fs/xfs/xfs_icache.c | 27 +++++++++++++++++++++++++++
> > > >  fs/xfs/xfs_inode.h  |  5 +++++
> > > >  2 files changed, 32 insertions(+)
> > > > 
> > > > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > > > index e44040206851..f97aa6d66271 100644
> > > > --- a/fs/xfs/xfs_icache.c
> > > > +++ b/fs/xfs/xfs_icache.c
> > > > @@ -80,6 +80,25 @@ static inline xa_mark_t ici_tag_to_mark(unsigned int tag)
> > > >  	return XFS_PERAG_BLOCKGC_MARK;
> > > >  }
> > > >  
> > > > +static int xfs_inode_init_ag_bitmap(struct xfs_inode *ip)
> > > Similar comment as before:
> > > static int
> > > xfs_inode_init...()
> > > > +{
> > > > +	unsigned int bits = ip->i_mount->m_sb.sb_agcount;
> > > > +	unsigned int nlongs;
> > > > +
> > > > +	xa_init_flags(&ip->i_ag_pmap, XA_FLAGS_LOCK_IRQ);
> > > Nit: The name of the functions suggests that it is initializing the tracking bitmap which it does -
> > > however, the above line does slightly different thing? Maybe move the xarray init outside the bitmap
> > > init function? 
> > 
> > Or just call it something else?  xfs_inode_init_perag_wb?
> > 
> > > > +	ip->i_ag_dirty_bitmap = NULL;
> > > > +	ip->i_ag_dirty_bits = bits;
> > > > +
> > > > +	if (!bits)
> > > Umm, !bits means agcount is 0. Shouldn't we ASSERT that bits >= 2? Or am I missing something?
> > 
> > Technically you can have 1 AG, but you definitely can't mount a zero AG
> > filesystem.
> Okay, but:
> /home/ubuntu$ mkfs.xfs -f  -d agcount=1 /dev/loop0
> Filesystem must have at least 2 superblocks for redundancy!
> Usage: mkfs.xfs
> Or maybe this restriction is just at the userspace tool level?

Yeah.  If the only super dies then the filesystem is completely
unrecoverable, which is why you have to really fight mkfs to spit out
single-AG filesystems.

--D

> > > > +		return 0;
> > > > +
> > > > +	nlongs = BITS_TO_LONGS(bits);
> > > > +	ip->i_ag_dirty_bitmap = kcalloc(nlongs, sizeof(unsigned long),
> > > > +					GFP_NOFS);
> > > > +
> > > > +	return ip->i_ag_dirty_bitmap ? 0 : -ENOMEM;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Allocate and initialise an xfs_inode.
> > > >   */
> > > > @@ -131,6 +150,8 @@ xfs_inode_alloc(
> > > >  	ip->i_next_unlinked = NULLAGINO;
> > > >  	ip->i_prev_unlinked = 0;
> > > >  
> > > > +	xfs_inode_init_ag_bitmap(ip);
> > > xfs_inode_init_ag_bitmap() returns int - error handling for -ENOMEM?
> > > > +
> > > >  	return ip;
> > > >  }
> > > >  
> > > > @@ -194,6 +215,12 @@ xfs_inode_free(
> > > >  	ip->i_ino = 0;
> > > >  	spin_unlock(&ip->i_flags_lock);
> > > >  
> > > > +	/* free xarray contents (values are immediate packed ints) */
> > > > +	xa_destroy(&ip->i_ag_pmap);
> > > Nit:Maybe have a small wrapper for freeing it the prediction map? No hard preferences though.
> > > > +	kfree(ip->i_ag_dirty_bitmap);
> > > > +	ip->i_ag_dirty_bitmap = NULL;
> > > Nit: Usually while freeing the pointers I prefer:
> > > t = ip->i_ag_dirty_bitmap;
> > > ip->i_ag_dirty_bitmap = NULL;
> > > kfree(t);
> > > In this way, the pointer(i_ag_dirty_bitmap in this case) that I am freeing never points to an
> > > already freed address.
> > > 
> > > > +	ip->i_ag_dirty_bits = 0;
> > > > +
> > > >  	__xfs_inode_free(ip);
> > > >  }
> > > >  
> > > > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > > > index bd6d33557194..dee449168605 100644
> > > > --- a/fs/xfs/xfs_inode.h
> > > > +++ b/fs/xfs/xfs_inode.h
> > > > @@ -99,6 +99,11 @@ typedef struct xfs_inode {
> > > >  	spinlock_t		i_ioend_lock;
> > > >  	struct work_struct	i_ioend_work;
> > > >  	struct list_head	i_ioend_list;
> > > > +
> > > > +	/* AG prediction map: pgoff_t -> packed u32 */
> > > > +	struct xarray           i_ag_pmap;
> > > > +	unsigned long           *i_ag_dirty_bitmap;
> > > > +	unsigned int            i_ag_dirty_bits;
> > > Not sure but, I mostly see the typedefed versions of data types being used like uint32 etc. Darrick,
> > > hch, are the above fine?
> > 
> > Yes, please don't mix types.  Pick one type and stick with it.
> > 
> > (and yes I wish we could struct bitmap_t(unsigned long))
> > 
> > --D
> > 
> > > --NR
> > > >  } xfs_inode_t;
> > > >  
> > > >  static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
> 
> 

