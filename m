Return-Path: <linux-fsdevel+bounces-76534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLozNyh/hWlmCgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:42:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F904FA661
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B90E6303503D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 05:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A259033A6F7;
	Fri,  6 Feb 2026 05:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtWKo1AU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9C33A6E9
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770356513; cv=none; b=mISTFbuDtLDDc68Hgc1Wnl/NX1JIjZcZP1vCw584ex0hF/5oEFHSuHXXxZAqES/6s76z4M6LfIrJHwzakA+jshF0wWPWgrjZxy3j92R+TPEkM524R7UnyKF1x0GMsd2plVraj9G16MIcIWcGW8vAKWlmO7RlRQGfHlmBJ0i5n0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770356513; c=relaxed/simple;
	bh=GqRttaOziVl7ls4Fij3x2ZnkHrXkXL4bDJJEMfcsWl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=boyj7V8c/nuPTyRXLAWMRsd8MMpxlxiXCAUOY+xj6+xKJ8p+hEGHYuPbr4WT9z72QxbG+hnioKsgxZiU0UL0nvwUXJPjamCuRKanUdcMfxX/9vrkQqZwSe4iXqTAcJ9nb/9yHr86Iq/xwZnNOvSIzORWuZOvR2qv8YHS9iybau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtWKo1AU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82311f4070cso1239109b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 21:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770356512; x=1770961312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MACMIIoQrOmHwo4XgAmQe5Pv+MCpYfJt20up7XQ2jCM=;
        b=mtWKo1AUKy0cJAMu7FeOD+S+c+UidziFpgHmaj0ArO2FFjLTBdc1wpmvuqq2peIHpx
         eVS+4wn9zmFWoDPQvfZCO5BHBJv0C2bRZcyUPkWoooJ504GcpSwIIw9T3dxTUNRiI8f1
         AOoeQ/GFps9tRqiDHIKc0XwMfAuepLFVowM12dYcJVSnVZQnnw7CJTtyFvLCJ2PSfQiZ
         vcBLnrHkfD/P05RVrke5sqOvRgubymB0uqeAAciiAAjijdU/Ow4cRabNZopML67zgkaq
         wiiciWHVGwHtdl0H4UF2Cb+sDMBs1Vsvt72KmL+HweR5fxC+Xe3aX/hEEppWeAcB3dxz
         h+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770356512; x=1770961312;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MACMIIoQrOmHwo4XgAmQe5Pv+MCpYfJt20up7XQ2jCM=;
        b=RSxa5yFKZ8UwGbH9OGthKzN3f6ImuNDwNlai63YyDjwbqFWRb9+9urvGYYYAv7mEZ4
         qEkwOmaR2PocxZ6kWlFeJSLr5/ItQhDzRuTR3/XyNdKngJEEL8lkiak1qZRQcB0F/U/2
         TTIhtAkwrb9l3vxf5MGrt3/jnzlOs20Jmv/J0gFBi54/13Ewon93100ENKp7u0m769pr
         UI/ZSyWKcMWMY7Sg6bfRfIXTteaSca/3ooy4hjNq/vbXd9kSDgH6xT/eHOPc0J/SRj02
         REBFNc/jZuQcz/c3J55dWje2PSfaw44tFeKgA76doPXtm7It01ud2S8NDijJbm4tuMtp
         XopQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZZjnL18ve+OXd271otPbqE8prUTm8bUnnOU6r02vhPQ99IN7pjmS8B4fFPi3LdQ+t0PpLfEE17Jwa5Xmj@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpPbFH7QpqDxtBwvdeUvfstUTeqp27DzVduJu1/LCAKwsHTOC
	C/g9bTB9qVL89jiwmRidlYO5PQmJEV/OIcCeOata8eH/Dt0lS812hwFB
X-Gm-Gg: AZuq6aKwyEwMGFy/KzyPVYB5x2LNCSZtUQPpD5EQakWs2vLYHkMPQLxj+RuRf+yE9IG
	+Qhx0A0JpsuHb3Frvkm2ybHWLFTsJSw/M6kdwd5DUKZu2sa6kFspURpaH7PUMQoBTozflZcDbhM
	iLD22FZMdo1e7BaWUVYiEwTCms7acWZLhBzguT81f+Mto6HeWkvVRK46zGykIHpdJlSxccLmK+D
	Xz+QrW/KtfZbthLYjwaYC1ylu4fncH4UOUhOL/E+AnUO14ObH1AnpgrcUlfzReJRTqO3plmql6u
	m/fPbxbq9ajFTdDwJrH4HOmXwm1Iu3upDE9ry6CNaO+4Xhm6TFbY9XtvLWBRap3gsJIbIyoKcBd
	jV1riKSsgcISDoG33RQvhnVN92jsnFS7A7FRW6iwawef0NjDta3vkfbfkLwHiICnO3TD4lBHPvU
	lTyDC8fImU62dhvf0KDUWrIaS1gwDgnr4uEWhlblOkKBNXD7AJQn/LIESlud/3hDSMpHNDKZBMv
	F8=
X-Received: by 2002:a05:6a00:ac86:b0:7a9:d8a8:992a with SMTP id d2e1a72fcca58-8242d42ef5emr5239630b3a.13.1770356512310;
        Thu, 05 Feb 2026 21:41:52 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.208.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418ff231sm1173972b3a.69.2026.02.05.21.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:41:51 -0800 (PST)
Message-ID: <c2a090bde81de463d3e2cc88f9ba06233e97cf5d.camel@gmail.com>
Subject: Re: [PATCH v3 3/6] xfs: add per-inode AG prediction map and
 dirty-AG bitmap
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, jack@suse.cz, willy@infradead.org, mcgrof@kernel.org, 
 clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
 hch@lst.de,  ritesh.list@gmail.com, dave@stgolabs.net, cem@kernel.org,
 wangyufei@vivo.com,  linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org,  gost.dev@samsung.com, anuj20.g@samsung.com,
 vishak.g@samsung.com,  joshi.k@samsung.com
Date: Fri, 06 Feb 2026 11:11:43 +0530
In-Reply-To: <20260205163217.GP7712@frogsfrogsfrogs>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	 <CGME20260116101251epcas5p1cf5b48f2efb14fe4387be3053b3c3ebc@epcas5p1.samsung.com>
	 <20260116100818.7576-4-kundan.kumar@samsung.com>
	 <20260129004404.GA7712@frogsfrogsfrogs>
	 <90870969cb6f04346d6dba603838abf993a42f5b.camel@gmail.com>
	 <20260205163217.GP7712@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76534-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[samsung.com,zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 9F904FA661
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 08:32 -0800, Darrick J. Wong wrote:
> On Thu, Feb 05, 2026 at 12:14:35PM +0530, Nirjhar Roy (IBM) wrote:
> > On Wed, 2026-01-28 at 16:44 -0800, Darrick J. Wong wrote:
> > > On Fri, Jan 16, 2026 at 03:38:15PM +0530, Kundan Kumar wrote:
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
> > > > +{
> > > > +	unsigned int bits = ip->i_mount->m_sb.sb_agcount;
> > > > +	unsigned int nlongs;
> > > > +
> > > > +	xa_init_flags(&ip->i_ag_pmap, XA_FLAGS_LOCK_IRQ);
> > > 
> > > This increases the size of struct xfs_inode by 40 bytes...
> > > 
> > > > +	ip->i_ag_dirty_bitmap = NULL;
> > > > +	ip->i_ag_dirty_bits = bits;
> > > > +
> > > > +	if (!bits)
> > > > +		return 0;
> > > > +
> > > > +	nlongs = BITS_TO_LONGS(bits);
> > > > +	ip->i_ag_dirty_bitmap = kcalloc(nlongs, sizeof(unsigned long),
> > > > +					GFP_NOFS);
> > > 
> > > ...and there could be hundreds or thousands of AGs for each filesystem.
> > > That's a lot of kernel memory to handle this prediction stuff, and I"m
> > > not even sure what ag_dirty_bitmap does yet.
> > > 
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
> > > 
> > > Unchecked return value???
> > > 
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
> > > > +	kfree(ip->i_ag_dirty_bitmap);
> > > > +	ip->i_ag_dirty_bitmap = NULL;
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
> > > 
> > > What about blocksize < pagesize filesystems?  Which packed agno do you
> > > associate with the pgoff_t?
> > Sorry but I am bit unfamiliar with the term packed agno? Can you please briefly explain does packed
> > agno mean?
> 
> I was talking about the "xfs_agp" numbers introduced in the previous
> patch, which seem to contain the bottom 25 bits of the ag number.
Okay, right. Thank you. 
> 
> Really I was just asking about multi-fsblock folios -- which block
> within that folio do we map to an AG for tagging purposes?
> 
> I think Kundan replied elsewhere that it's the first block.
Okay.
--NR
> 
> --D
> 
> > --NR
> > > Also, do you have an xarray entry for each pgoff_t in a large folio?
> > > 
> > > --D
> > > 
> > > > +	struct xarray           i_ag_pmap;
> > > > +	unsigned long           *i_ag_dirty_bitmap;
> > > > +	unsigned int            i_ag_dirty_bits;
> > > >  } xfs_inode_t;
> > > >  
> > > >  static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
> > > > -- 
> > > > 2.25.1
> > > > 
> > > > 


