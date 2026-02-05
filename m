Return-Path: <linux-fsdevel+bounces-76367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIOjHGY8hGmZ1gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 07:44:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA153EF11E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 07:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 391663016508
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 06:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240C355056;
	Thu,  5 Feb 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gToDat6V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0E355042
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273885; cv=none; b=BlEV1d6VktnoejGqDjNx7yfaWsiqUY2UIIiiiJ8CHHX9MXM7al57yobb8kOFllv8amT5ond75Uql0Oh9fASZitakMXsb1vhQhaUY4o2hGEBGDKDF6ZaBjHswcv0EY/ni9BF8TlCifN1Pm53ElpdTj+JefZbdCjSFxXgpDYrNRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273885; c=relaxed/simple;
	bh=JbdI1NUXLhuX1W4EIQ1XgOIvg6sAYwOqA29NQMsR6OU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=bT5NMXtRauX1DzTXx5RK7T/zY7lbnitOGotJ6l6gcy2IJyD1XtvDmlzDJYq454kYd4f9715MfdgN6MrJqqVu4a2e9ByT7qjIDsEQTk7TexAP/YU3p7nSU3/RganOLs5G+JiVPIFkTboTIP9SZGcvmpB73kriYeQd3YDLSNIWv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gToDat6V; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354a7b089bbso23012a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 22:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770273885; x=1770878685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNsGJHU6ZAGPYFrstJF6T+pTydSAytWmzby0uKhCanI=;
        b=gToDat6VENDaStkuG2l8JTQAoVMw7AFrmtKyj3b6i9QtX5IG0bTJeqAw8RCaGuoAZz
         J6BreB7285vtxAD3SbeQgVH0EjMh99Y0mGnJ62Palo+HNsa4qha+2mT6WewOWMHfyA5P
         rqT8cEoHSgjFFr2e+Arp6Tkhxi3AXCJogSmP4lZon0oY7R7EEXv2DiWb+IB5QE8VTKOO
         Rq2mRKLPitpmuYTVYMCbY/s9b39VGgTA5iFUSSUANGcGur6vPPU9hgaiEwy/MVXbYFLU
         ZU3of8SR4wlnmF17sYgMNCZcSI5v3Ky3ELUqHHdiAWCRUt24HEAtSbPvo7smirhvHP/F
         GwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770273885; x=1770878685;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNsGJHU6ZAGPYFrstJF6T+pTydSAytWmzby0uKhCanI=;
        b=c+Nuj2w6Ypde571cr2ExQZYGDwHmCP+ZKlh5hnx/us4Xr4Y+FGOztTkDel4saM3bEO
         Jq69y1Wyjbs3MisZw1qc+xBscymKAhof45KZ7mtde0AGdh3jNL/MLusYv6mH+pG+1dHv
         HPUqnP65lAn8Arf6H4jzehZf2T9QfYH6/BUqQUiUuBkuR+zHS0RmeqN1XnKOjPYFvDgM
         8TrDDR1wWzqiwacxjdG2Q6cGhqVN1VLTlUuPb9vUUwFi2B0UTSVyWxm69aQoeurW9HHg
         8pVF2Qg+NnLoFafL6ywo/Zeh/KOQian2R00vcbHfCBzEeXpECqAfbD2pLmnFHewqmMRP
         L6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHwwP6BDiHthfDu2F6wPAIFowgiiJhAwDGrAPbHbNIkS4ZE7DuJt66xE+OZ1sdw/vE61k7eq+JA/U2WDlw@vger.kernel.org
X-Gm-Message-State: AOJu0YwaaH0UIwO0gAlYDAHSo295OUURKQYeoT4UWp1e2/l5BOxZgOv1
	qcrGFyYVdIzt9gWkK0ybdsm/wSsD4N8YJsdJYUqlyan3u+DqeDcK8gUP
X-Gm-Gg: AZuq6aJ0VamcNzxN9NrfWiGfqHZ95KCxOBUedtAiYw1NjQT52OtQm+DPfMW9HC9Eyz/
	nBQ1FOVgqZad0wg7WiupqDCiX2df7C/A90qSBfiG8Hps3i7pNVdukX2yITbPRy2yPhvdeCsYyXp
	bAR1xQlQuqDUdnjEXCcFSQhXWdvEckoWN0jkjvMZlz/NakklmfRWX/rvW4eNiQZaiTgYu+RYXK3
	KJHKIwuO5cS6c/IOgW2SKXTwtbLH/aZyr20vZ2Cytyundyni38IBYEC6J1IkKlP+AvniXHYXEce
	+N0juvicqfLFwbTD9ON1LQQn4GmVjVqswh3hykMScWL6ZTMeTEvlDrDuho/fFmRgoG6d06V2tFA
	cmhawqXz+WjvBBz7depAWF95Tjj0mgNNS2Exoe+4Mk0G2zvHBb4muA64BSD6F4bwMXCbc8mqUCv
	IMI7T5+kf4HSmeJVK2zi5HJB4VvgAp4jnEwLhz/sL75shsGkal85Ty8BoDWt6Ka9ED
X-Received: by 2002:a17:90b:5201:b0:353:100:2f20 with SMTP id 98e67ed59e1d1-354870eb37bmr4927223a91.10.1770273885118;
        Wed, 04 Feb 2026 22:44:45 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.208.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c28204esm1389041a91.10.2026.02.04.22.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 22:44:44 -0800 (PST)
Message-ID: <90870969cb6f04346d6dba603838abf993a42f5b.camel@gmail.com>
Subject: Re: [PATCH v3 3/6] xfs: add per-inode AG prediction map and
 dirty-AG bitmap
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Kundan Kumar
	 <kundan.kumar@samsung.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
 willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, 
 amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, 
 dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org,  gost.dev@samsung.com, anuj20.g@samsung.com,
 vishak.g@samsung.com,  joshi.k@samsung.com
Date: Thu, 05 Feb 2026 12:14:35 +0530
In-Reply-To: <20260129004404.GA7712@frogsfrogsfrogs>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	 <CGME20260116101251epcas5p1cf5b48f2efb14fe4387be3053b3c3ebc@epcas5p1.samsung.com>
	 <20260116100818.7576-4-kundan.kumar@samsung.com>
	 <20260129004404.GA7712@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76367-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nirjharroylists@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: CA153EF11E
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 16:44 -0800, Darrick J. Wong wrote:
> On Fri, Jan 16, 2026 at 03:38:15PM +0530, Kundan Kumar wrote:
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
> > +{
> > +	unsigned int bits = ip->i_mount->m_sb.sb_agcount;
> > +	unsigned int nlongs;
> > +
> > +	xa_init_flags(&ip->i_ag_pmap, XA_FLAGS_LOCK_IRQ);
> 
> This increases the size of struct xfs_inode by 40 bytes...
> 
> > +	ip->i_ag_dirty_bitmap = NULL;
> > +	ip->i_ag_dirty_bits = bits;
> > +
> > +	if (!bits)
> > +		return 0;
> > +
> > +	nlongs = BITS_TO_LONGS(bits);
> > +	ip->i_ag_dirty_bitmap = kcalloc(nlongs, sizeof(unsigned long),
> > +					GFP_NOFS);
> 
> ...and there could be hundreds or thousands of AGs for each filesystem.
> That's a lot of kernel memory to handle this prediction stuff, and I"m
> not even sure what ag_dirty_bitmap does yet.
> 
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
> 
> Unchecked return value???
> 
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
> > +	kfree(ip->i_ag_dirty_bitmap);
> > +	ip->i_ag_dirty_bitmap = NULL;
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
> 
> What about blocksize < pagesize filesystems?  Which packed agno do you
> associate with the pgoff_t?
Sorry but I am bit unfamiliar with the term packed agno? Can you please briefly explain does packed
agno mean?
--NR
> 
> Also, do you have an xarray entry for each pgoff_t in a large folio?
> 
> --D
> 
> > +	struct xarray           i_ag_pmap;
> > +	unsigned long           *i_ag_dirty_bitmap;
> > +	unsigned int            i_ag_dirty_bits;
> >  } xfs_inode_t;
> >  
> >  static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
> > -- 
> > 2.25.1
> > 
> > 


