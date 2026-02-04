Return-Path: <linux-fsdevel+bounces-76265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKguGEj3gml2fwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 08:37:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 062BCE2BDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 08:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65FF5301858E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7A38E5C5;
	Wed,  4 Feb 2026 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2jQkx3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9127E04C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190655; cv=none; b=FguQH+hoVKSllpmme/CvyJq/9eZmEDQ3/63L67J2+ltU2AxgC3GQSxBWq8TjAnfJApKt6P0yyhNkJmk8DlUM/2OEWL1ILtGJkzwL052sIN+LpwL6CIqibjNjq7i0XyKVNCMSoiEiOB4ATaeJRZ3CxWvtwGJqVEqGFDfI8mZTyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190655; c=relaxed/simple;
	bh=3vD2v8ghz50UyVzLCs0ItxZ4n09cD5uGcNPjMaFsbBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=fmepmwxjtnjtjOXmA8wCN8Dv8ePcmeUin0wuNVAmRYvLjeqr9o3Bo22hAn9K238qu6gqRlrMGtCDubgnBFHyx8+4OBBWYHr2vhMKMmjrUssMCPBiYdXBVIGC5jejfjW4Neu+EjGvzvfPR5b1u+d1lmmCycEnhss787Z+DH7kzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2jQkx3u; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso3573140b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 23:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770190655; x=1770795455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xKiGXhAf0POKtC5HLVPhalwQmNgPksjY3TFJBTsNxc=;
        b=d2jQkx3uRXrOlrBfrU8H7EA41jwi4Q+uIEDFMrePyh+65QU5k5v33zP/l961k4NVPV
         xUbgKOpmtY3o09SHAlq//in71B9fFwISYizek2Him588NMhDDJyGf6EfRCCXu3JiZHEr
         dH+sv+lLhWvhsDzNF8sDo6zxkWb9PVfxOEQSB7YAaGhTuyDdPHzQhwghVVdkHPHKbakh
         HwYGo2UwlGSOJsAJMC6sZyEQSxvDvRswW9W/w2qJcDzO+3VZ8E4M3T166O0eTLB5ErrV
         EAXBaUQGKUD1vYnuSPNFbboxDaDvD/cOYdDUp5RgEdRvlWNyDDsar+EuYhPJ7tYxj1qI
         zNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770190655; x=1770795455;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xKiGXhAf0POKtC5HLVPhalwQmNgPksjY3TFJBTsNxc=;
        b=ZtHc51D51pwMOYqnm6CVorG5XuHDczyE7fTIokPZZkf2XEtj2NSwRqCmj2Fa940jCu
         opkWgTm0QyBsU/zRnrFnwCb/qT/rrCesC5dCAIOusNZcfWGRf2XM9QnZkAvoWjanuqL6
         APYQVjcj9dXZ8mgAbFrtrDOaGxmbYFAwQbaPzvKcQs5eZMzl04AAlZ6+XPdSSqMGuPDV
         lQesB5H14fmd+GjrtUPwREJIUNMnLoLWPaJ7QXLmNiWpsgvVnvCzC1c0lqKC4YIec9Fd
         TAuqS5vXzCx2A3v1vp797KqWxgztgIFUeBAhoux31ZbCapMxq3fjyghWICSlXfy18oar
         YEOw==
X-Gm-Message-State: AOJu0YzIB+N7Cfdsfmp0p5F1BaamViC9FY+MrYXOXSsGiJmZ9TMz3iFK
	QBbdjHROP2DyWw6U9I/GER1YEPpGunkcrFVKHPyzxbZAPOkESBv2/JaM
X-Gm-Gg: AZuq6aLwwJ1011M9iTi5CLhkEPK7DmmAzMvGNDZzjeJfMVLqyAr4eWMKubaJusfllEC
	fV3mzgYiiWnzF+SIJpw5dhvoSMk3dF3eI5vBk/gl12nRDxntKAeLCDeZf/CACmh+zT+N7kN4Lc1
	7ZivRWdwNFJh9p1P/rSJuPn6CNCQW0SfUBb48LYFjhy5NsjeUfpqXgLduuzsUXLY3WKwd3WzSLV
	I2mNKVpm9Xq3sHm0FExCK+JX/3NOJ9YAyL3WMR/TugrlWRZMXMyWVIu0QTJ75L04c2E9dl8j9cj
	Xgr2wjCdmpEuo0Z5h9FFhcN71hWuplL8NB/ryH5xWowF+wH2KEhDd5X0+MtsrCNe0MmxPbqyTTw
	7b67J3vFdyCn6/2NlgqwIQzYnc0xm9HExFPDSmhLvVUqxmVVb3VMuQmllhBHJw4+VeP1fhi7eyf
	MgiEzwY67jAOSYvxtyp5bwEtZV9N/RazyJdR6+rf+7LfCohXI6u2kRl/Cl73op
X-Received: by 2002:a05:6a00:4b47:b0:821:807a:e427 with SMTP id d2e1a72fcca58-8241c1dfd96mr2358341b3a.21.1770190655016;
        Tue, 03 Feb 2026 23:37:35 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d163fb2sm1561632b3a.14.2026.02.03.23.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:37:34 -0800 (PST)
Message-ID: <abe69ec973a115015d998907e9f7fd4d3c45f38a.camel@gmail.com>
Subject: Re: [PATCH v3 2/6] xfs: add helpers to pack AG prediction info for
 per-folio tracking
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Kundan Kumar <kundan.kumar@samsung.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, jack@suse.cz, willy@infradead.org, mcgrof@kernel.org, 
 clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
 hch@lst.de,  ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
 cem@kernel.org,  wangyufei@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com, 
	vishak.g@samsung.com, joshi.k@samsung.com
Date: Wed, 04 Feb 2026 13:07:27 +0530
In-Reply-To: <20260116100818.7576-3-kundan.kumar@samsung.com>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	 <CGME20260116101245epcas5p30269c6aa35784db67e6d6ca800a683a7@epcas5p3.samsung.com>
	 <20260116100818.7576-3-kundan.kumar@samsung.com>
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76265-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[samsung.com,zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email]
X-Rspamd-Queue-Id: 062BCE2BDA
X-Rspamd-Action: no action

On Fri, 2026-01-16 at 15:38 +0530, Kundan Kumar wrote:
> Introduce helper routines to pack and unpack AG prediction metadata
> for folios. This provides a compact and self-contained representation
> for AG tracking.
> 
> The packed layout uses:
>  - bit 31	: valid
>  - bit 24-30	: iomap type
>  - bit 0-23	: AG number
# AG limited to 2^24 - is this a reasonable assumption?
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/xfs/xfs_iomap.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index ebcce7d49446..eaf4513f6759 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -12,6 +12,37 @@ struct xfs_inode;
>  struct xfs_bmbt_irec;
>  struct xfs_zone_alloc_ctx;
>  
> +/* pack prediction in a u32 stored in xarray */
Nit: Maybe some brief comment about what these are doing and their significance?
> +#define XFS_AGP_VALID_SHIFT 31
> +#define XFS_AGP_TYPE_SHIFT 24
> +#define XFS_AGP_TYPE_MASK 0x7fu
> +#define XFS_AGP_AGNO_MASK 0x00ffffffu
> +
> +static inline u32 xfs_agp_pack(u32 agno, u8 iomap_type, bool valid)
Nit: Maybe use xfs_agnumber_t instead of u32 for agno?
Nit: I think xfs style is like 
static inline u32
<function name, parameters etc>
> +{
> +	u32 v = agno & XFS_AGP_AGNO_MASK;
> +
> +	v |= ((u32)iomap_type & XFS_AGP_TYPE_MASK) << XFS_AGP_TYPE_SHIFT;
> +	if (valid)
> +		v |= (1u << XFS_AGP_VALID_SHIFT);
> +	return v;
> +}
> +
> +static inline bool xfs_agp_valid(u32 v)
> +{
> +	return v >> XFS_AGP_VALID_SHIFT;
> +}
> +
> +static inline u32 xfs_agp_agno(u32 v)
> +{
> +	return v & XFS_AGP_AGNO_MASK;
> +}
> +
> +static inline u8 xfs_agp_type(u32 v)
> +{
> +	return (u8)((v >> XFS_AGP_TYPE_SHIFT) & XFS_AGP_TYPE_MASK);
> +}
Again Nit:
We are introducing functions here but using it in the upcoming patches, any reason why can't we
introduce and use the functions in the same patch? In that way we can also look into the definitions
and usages in the same patch instead of this where we have to switch between 2 patches - one to look
into the definitions and another to look into the usages/call-sites? Again no hard preferences here
- just a suggestion.
--NR
> +
>  int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
>  		xfs_fileoff_t count_fsb, unsigned int flags,
>  		struct xfs_bmbt_irec *imap, u64 *sequence);


