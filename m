Return-Path: <linux-fsdevel+bounces-76539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLlNATaFhWmqCwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:07:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E83FA901
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE94E304EF6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE172F83B7;
	Fri,  6 Feb 2026 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9isw4yd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C1285041
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357836; cv=none; b=E5RiBOSLqWr71NC68WwncclgzAywMkejmQb9L9iWSYwJTQZ18BYPQo9/mhP8pivQoj28ryu3FjBvtm0vRNBv8dXm0fmq5/k079pk4t/A2A6kSuIkzTPeOnjU1J1ookxVbIDQ5/SH9cN89V/ISll2SRrI8QQVjnDlbCkmHlbwyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357836; c=relaxed/simple;
	bh=bu/F/VwIGbsQeg4jt+LgMRWQyHf6TkEBCdSLXZtiz/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiPaPYtBCJQ6aIyVF5asbvW+S+Dt5WZMzSyypVzwboNaQIg3sC33c/NyEiyTfQSD+ay0LdkfQ8CELKBgkt5auSfR0NiSrW1CLstSxjHH81yo+Ka9S2Z+xm/tGUrZQE2pKDMBq2YTHRApBUbVJ+Ul/NmNWwCLWHbiXceeWLm1ez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9isw4yd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7b23dd036so1563575ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 22:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770357836; x=1770962636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snv1+tdro/8nDsA6C8wgWM9ZO2V2RnvICdRidY8H0dI=;
        b=W9isw4ydHSj1mWEQQvn1LuySmKk4AIOrq0xQzKm9ZoM2zoBK4wRYHtVkOPmX6veAKR
         xexfc6nUYcXftmAQq2fPAruo0n+F7R8GWKhKXlhbRY+iwVNAYgVi7/uSCSN1k/IYw7FA
         m+tQXcIfaBf0Dc5dnHGDKQSzc1eU8IWFaxIb52uI7P7ngGq3EwWtYsAhlSqv9XxDRNOd
         j4DuL6hxTxlD+PJSNF4etgefssPrCwfUC/urbixrYpcpi0ZgkNXua7snZQ/CpNRohkKf
         eIPcksAc0/IetA2/eBsz0a+nIOdbLcFQoQEYEPggeLZuYBJmEeokC2PckNb2HNQUGmvu
         8hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770357836; x=1770962636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snv1+tdro/8nDsA6C8wgWM9ZO2V2RnvICdRidY8H0dI=;
        b=GGm3airTpU5c16Yjn3zywidGFs2elDvz1V0GM3x3l20e6u1J5L6SLXr5v0c3hVmrYh
         JKoM/NSl6QYOKnoHu1ExCCHb+Eqd3gLkK3sgfDdZHWL46SljWLk4yM/8dU3pmcFlzkKo
         4s5yYCfg4we+IJ9DiCm8+hG/AEZ5I+vavQnKV5VcuGay4hmvYIrjX8BRI6fuq8Gop0bo
         d9JS/Td0n2qnKBjUkIJFvg6DfwFIqxI2NwXiDX/QQ48c486mTE1ww/0zuDPmyCceXP6w
         BBDyuaSDqL16U3sjPvAQtHGXYUbrXLaJMl2EIGLNZTM7v+Z8uQxOKyLOuC+g3YIv8huu
         EFAA==
X-Forwarded-Encrypted: i=1; AJvYcCVNnkFGvVI3KZt/GSpOrx48GJFawSiPX6KrJEyrkwORobRz9UwjDM1b3O/NXlOoYWgtFZy9o3+DQhdWJnic@vger.kernel.org
X-Gm-Message-State: AOJu0Yz053nWzqIZOkZvRdEJc5ow238KPxftcW85kFJ05u0YEkKmdK63
	e/A/0orFFr0LqX8FSIEJcU+KlNiKPyVHz3gnSYlRG7vHUbdNEbEbsncD
X-Gm-Gg: AZuq6aI1p+mNkP5mdWqZClyKHNcVxKwY/rlhWm9DjKWhdxCyIx6FsE8HQYD3jorkqEX
	nz9HdEaY5KTBBXMZ5C1AgOWqM38RbqGLLJdYY3Vv6pMh5rehxmxMyArj8pt+/1DGCBlLmJyag+E
	Jks2iDfB8ReqzGEGgGD4IB5A73Ibfu87SJZ0qbiWiETpYrhd5IpPyoHggY1MiM+cLvsTbnT/COX
	iNl4aIdcElL6VDYszGFynJ1x4NZnGzHFOT8DUkcecjBhFXBaOV8ayPWLrNQ9D4/kICo5XlCSBAU
	Vd4CQod8Q9c0qox4XXmMdG/ifIn3bsiS2+saN4kh0ABy6Iy0nOHwnCb0JbSapNjNqkCRTy1GLcP
	Xoc/FztkqsrMnSEohEDSDKE1T3+fb1i4kx3lkkAPTxksHZCqD4KYpk3nD1WI14YINXAKYHIgrE7
	0vLScshq3+f7fSfr1RefZZYdJcCoSC1wQw
X-Received: by 2002:a17:902:d503:b0:2a0:993b:d72a with SMTP id d9443c01a7336-2a951608a13mr19199085ad.4.1770357835617;
        Thu, 05 Feb 2026 22:03:55 -0800 (PST)
Received: from [192.168.0.120] ([49.207.208.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c38fa4fsm4870105a91.13.2026.02.05.22.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 22:03:55 -0800 (PST)
Message-ID: <a0850469-51f5-41f4-b7da-4eb61d6a8606@gmail.com>
Date: Fri, 6 Feb 2026 11:33:45 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] xfs: add per-inode AG prediction map and dirty-AG
 bitmap
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, willy@infradead.org, mcgrof@kernel.org,
 clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
 hch@lst.de, ritesh.list@gmail.com, dave@stgolabs.net, cem@kernel.org,
 wangyufei@vivo.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com,
 vishak.g@samsung.com, joshi.k@samsung.com
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
 <CGME20260116101251epcas5p1cf5b48f2efb14fe4387be3053b3c3ebc@epcas5p1.samsung.com>
 <20260116100818.7576-4-kundan.kumar@samsung.com>
 <87a16d4d9c1e568a37fa07a97dda5777e14e9a8b.camel@gmail.com>
 <20260205163650.GQ7712@frogsfrogsfrogs>
 <a017b49e0fb5b9f1a4f6929d7fb23897c98e2595.camel@gmail.com>
 <20260206055745.GV7712@frogsfrogsfrogs>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20260206055745.GV7712@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76539-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[samsung.com,zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nirjharroylists@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57E83FA901
X-Rspamd-Action: no action


On 2/6/26 11:27, Darrick J. Wong wrote:
> On Fri, Feb 06, 2026 at 11:06:03AM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2026-02-05 at 08:36 -0800, Darrick J. Wong wrote:
>>> On Thu, Feb 05, 2026 at 12:06:19PM +0530, Nirjhar Roy (IBM) wrote:
>>>> On Fri, 2026-01-16 at 15:38 +0530, Kundan Kumar wrote:
>>>>> Add per-inode structures to track predicted AGs of dirty folios using
>>>>> an xarray and bitmap. This enables efficient identification of AGs
>>>>> involved in writeback.
>>>>>
>>>>> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
>>>>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>>>>> ---
>>>>>   fs/xfs/xfs_icache.c | 27 +++++++++++++++++++++++++++
>>>>>   fs/xfs/xfs_inode.h  |  5 +++++
>>>>>   2 files changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
>>>>> index e44040206851..f97aa6d66271 100644
>>>>> --- a/fs/xfs/xfs_icache.c
>>>>> +++ b/fs/xfs/xfs_icache.c
>>>>> @@ -80,6 +80,25 @@ static inline xa_mark_t ici_tag_to_mark(unsigned int tag)
>>>>>   	return XFS_PERAG_BLOCKGC_MARK;
>>>>>   }
>>>>>   
>>>>> +static int xfs_inode_init_ag_bitmap(struct xfs_inode *ip)
>>>> Similar comment as before:
>>>> static int
>>>> xfs_inode_init...()
>>>>> +{
>>>>> +	unsigned int bits = ip->i_mount->m_sb.sb_agcount;
>>>>> +	unsigned int nlongs;
>>>>> +
>>>>> +	xa_init_flags(&ip->i_ag_pmap, XA_FLAGS_LOCK_IRQ);
>>>> Nit: The name of the functions suggests that it is initializing the tracking bitmap which it does -
>>>> however, the above line does slightly different thing? Maybe move the xarray init outside the bitmap
>>>> init function?
>>> Or just call it something else?  xfs_inode_init_perag_wb?
>>>
>>>>> +	ip->i_ag_dirty_bitmap = NULL;
>>>>> +	ip->i_ag_dirty_bits = bits;
>>>>> +
>>>>> +	if (!bits)
>>>> Umm, !bits means agcount is 0. Shouldn't we ASSERT that bits >= 2? Or am I missing something?
>>> Technically you can have 1 AG, but you definitely can't mount a zero AG
>>> filesystem.
>> Okay, but:
>> /home/ubuntu$ mkfs.xfs -f  -d agcount=1 /dev/loop0
>> Filesystem must have at least 2 superblocks for redundancy!
>> Usage: mkfs.xfs
>> Or maybe this restriction is just at the userspace tool level?
> Yeah.  If the only super dies then the filesystem is completely
> unrecoverable, which is why you have to really fight mkfs to spit out
> single-AG filesystems.

Okay. But I think there are certain places in the kernel code where 1 AG 
is treated as an -EINVAL. For instance [1]

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/xfs/xfs_fsops.c#n140

--NR

>
> --D
>
>>>>> +		return 0;
>>>>> +
>>>>> +	nlongs = BITS_TO_LONGS(bits);
>>>>> +	ip->i_ag_dirty_bitmap = kcalloc(nlongs, sizeof(unsigned long),
>>>>> +					GFP_NOFS);
>>>>> +
>>>>> +	return ip->i_ag_dirty_bitmap ? 0 : -ENOMEM;
>>>>> +}
>>>>> +
>>>>>   /*
>>>>>    * Allocate and initialise an xfs_inode.
>>>>>    */
>>>>> @@ -131,6 +150,8 @@ xfs_inode_alloc(
>>>>>   	ip->i_next_unlinked = NULLAGINO;
>>>>>   	ip->i_prev_unlinked = 0;
>>>>>   
>>>>> +	xfs_inode_init_ag_bitmap(ip);
>>>> xfs_inode_init_ag_bitmap() returns int - error handling for -ENOMEM?
>>>>> +
>>>>>   	return ip;
>>>>>   }
>>>>>   
>>>>> @@ -194,6 +215,12 @@ xfs_inode_free(
>>>>>   	ip->i_ino = 0;
>>>>>   	spin_unlock(&ip->i_flags_lock);
>>>>>   
>>>>> +	/* free xarray contents (values are immediate packed ints) */
>>>>> +	xa_destroy(&ip->i_ag_pmap);
>>>> Nit:Maybe have a small wrapper for freeing it the prediction map? No hard preferences though.
>>>>> +	kfree(ip->i_ag_dirty_bitmap);
>>>>> +	ip->i_ag_dirty_bitmap = NULL;
>>>> Nit: Usually while freeing the pointers I prefer:
>>>> t = ip->i_ag_dirty_bitmap;
>>>> ip->i_ag_dirty_bitmap = NULL;
>>>> kfree(t);
>>>> In this way, the pointer(i_ag_dirty_bitmap in this case) that I am freeing never points to an
>>>> already freed address.
>>>>
>>>>> +	ip->i_ag_dirty_bits = 0;
>>>>> +
>>>>>   	__xfs_inode_free(ip);
>>>>>   }
>>>>>   
>>>>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>>>>> index bd6d33557194..dee449168605 100644
>>>>> --- a/fs/xfs/xfs_inode.h
>>>>> +++ b/fs/xfs/xfs_inode.h
>>>>> @@ -99,6 +99,11 @@ typedef struct xfs_inode {
>>>>>   	spinlock_t		i_ioend_lock;
>>>>>   	struct work_struct	i_ioend_work;
>>>>>   	struct list_head	i_ioend_list;
>>>>> +
>>>>> +	/* AG prediction map: pgoff_t -> packed u32 */
>>>>> +	struct xarray           i_ag_pmap;
>>>>> +	unsigned long           *i_ag_dirty_bitmap;
>>>>> +	unsigned int            i_ag_dirty_bits;
>>>> Not sure but, I mostly see the typedefed versions of data types being used like uint32 etc. Darrick,
>>>> hch, are the above fine?
>>> Yes, please don't mix types.  Pick one type and stick with it.
>>>
>>> (and yes I wish we could struct bitmap_t(unsigned long))
>>>
>>> --D
>>>
>>>> --NR
>>>>>   } xfs_inode_t;
>>>>>   
>>>>>   static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


