Return-Path: <linux-fsdevel+bounces-76162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAyZMvKggWkoIAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:17:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 495D5D5A37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D48313040696
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 07:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896520010C;
	Tue,  3 Feb 2026 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZHGnFYrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E502FB616
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102948; cv=none; b=hKJciyaLmjkNUYNjl6D7ExOj4ATM8ynfu97FkueAUix6MmIEA82X0hBf3MaOnQ+QRfmTci47uS3FZQ4VrQqsV7ZI9RLdK1eEnU2BZWlCz2XT367t7qxZ11Q0pz6lYtBZsOpuGNZ/TWSLUR2AfPCO7+SwrtYbtLvd2FtbWV8w5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102948; c=relaxed/simple;
	bh=rrnfMF5Gw/03Xz2iJfcPcj7unPPA1LlzMAHjHX9k970=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=A97t1Vh1eri16JQBKNx/VTU1CJZcymarPsTt2d3E9t1JX99pkOd5DhVO/jyPV2UCg2aH5RwzAVLCpJIGl7HjQuuv7r6DSbxa2rQ78D7C1GQxklShgiEO0uJ3z/vQsXh5uJ4g0pR0hXLTKoaBeJ/o5M1kZxgj8t23tDjlro66Bak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZHGnFYrs; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260203071543epoutp021587604e37bf21ca4b31c5f7f710db44~Qqz_irR8x0651606516epoutp02W
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 07:15:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260203071543epoutp021587604e37bf21ca4b31c5f7f710db44~Qqz_irR8x0651606516epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770102943;
	bh=mhDRh09aq7ene7b0Wx3I828jJ7FXb0oFahb4ybdLzdE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZHGnFYrsEGHR5WEdM3oYqTBo+J7B82HitMUTi8WIwBcuUu/2n+wKFyM/+J/Vgez4B
	 66099rLstqCeg5/X2je/TT2w1g9Gk6Ia8sspLmCVeunpHeDP9W4rXzJLW8hz9peKgJ
	 2en0g7XO9jasqwnIEJ9osw+zD4IdJ0n47j1M+HK0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260203071542epcas5p16fdef2bcb44947af20950be109a442ad~Qqz91U7801323313233epcas5p10;
	Tue,  3 Feb 2026 07:15:42 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4f4vs858Wdz3hhTF; Tue,  3 Feb
	2026 07:15:40 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260203071540epcas5p39a0e65b6e769f43b7ab430d99a160e6c~Qqz7mf75Z0178601786epcas5p3a;
	Tue,  3 Feb 2026 07:15:40 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260203071535epsmtip1f2a061d1861720ddc1b1d166faad35eb~Qqz2_Weqx1731617316epsmtip1x;
	Tue,  3 Feb 2026 07:15:34 +0000 (GMT)
Message-ID: <4a795b10-95ed-4bba-90c8-9fee57454948@samsung.com>
Date: Tue, 3 Feb 2026 12:45:33 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] xfs: add helpers to pack AG prediction info for
 per-folio tracking
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Content-Language: en-US
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <20260129004548.GB7712@frogsfrogsfrogs>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260203071540epcas5p39a0e65b6e769f43b7ab430d99a160e6c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101245epcas5p30269c6aa35784db67e6d6ca800a683a7
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	<CGME20260116101245epcas5p30269c6aa35784db67e6d6ca800a683a7@epcas5p3.samsung.com>
	<20260116100818.7576-3-kundan.kumar@samsung.com>
	<20260129004548.GB7712@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	TAGGED_FROM(0.00)[bounces-76162-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email,samsung.com:dkim,samsung.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kundan.kumar@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 495D5D5A37
X-Rspamd-Action: no action

On 1/29/2026 6:15 AM, Darrick J. Wong wrote:
> On Fri, Jan 16, 2026 at 03:38:14PM +0530, Kundan Kumar wrote:
>> Introduce helper routines to pack and unpack AG prediction metadata
>> for folios. This provides a compact and self-contained representation
>> for AG tracking.
>>
>> The packed layout uses:
>>   - bit 31	: valid
>>   - bit 24-30	: iomap type
>>   - bit 0-23	: AG number
> 
> There are only 5 iomap types, why do you need 7 bits for that?
> 
> Also, can you store more bits on a 64-bit system to avoid truncating the
> AG number?
> 
> --D

I’ll reduce the type field to 3 bits (8 values).

For the AG number, I can drop the artificial 24-bit cap by packing into 
an unsigned long and storing it via xa_mk_value(), which provides ~60 
bits on 64-bit systems and ~28 bits on 32-bit systems.

> 
>> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>   fs/xfs/xfs_iomap.h | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
>> index ebcce7d49446..eaf4513f6759 100644
>> --- a/fs/xfs/xfs_iomap.h
>> +++ b/fs/xfs/xfs_iomap.h
>> @@ -12,6 +12,37 @@ struct xfs_inode;
>>   struct xfs_bmbt_irec;
>>   struct xfs_zone_alloc_ctx;
>>   
>> +/* pack prediction in a u32 stored in xarray */
>> +#define XFS_AGP_VALID_SHIFT 31
>> +#define XFS_AGP_TYPE_SHIFT 24
>> +#define XFS_AGP_TYPE_MASK 0x7fu
>> +#define XFS_AGP_AGNO_MASK 0x00ffffffu
>> +
>> +static inline u32 xfs_agp_pack(u32 agno, u8 iomap_type, bool valid)
>> +{
>> +	u32 v = agno & XFS_AGP_AGNO_MASK;
>> +
>> +	v |= ((u32)iomap_type & XFS_AGP_TYPE_MASK) << XFS_AGP_TYPE_SHIFT;
>> +	if (valid)
>> +		v |= (1u << XFS_AGP_VALID_SHIFT);
>> +	return v;
>> +}
>> +
>> +static inline bool xfs_agp_valid(u32 v)
>> +{
>> +	return v >> XFS_AGP_VALID_SHIFT;
>> +}
>> +
>> +static inline u32 xfs_agp_agno(u32 v)
>> +{
>> +	return v & XFS_AGP_AGNO_MASK;
>> +}
>> +
>> +static inline u8 xfs_agp_type(u32 v)
>> +{
>> +	return (u8)((v >> XFS_AGP_TYPE_SHIFT) & XFS_AGP_TYPE_MASK);
>> +}
>> +
>>   int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
>>   		xfs_fileoff_t count_fsb, unsigned int flags,
>>   		struct xfs_bmbt_irec *imap, u64 *sequence);
>> -- 
>> 2.25.1
>>
>>
> 


