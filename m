Return-Path: <linux-fsdevel+bounces-39130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDA2A103E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 11:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5E9163DCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEEB243351;
	Tue, 14 Jan 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqC4PSbL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD361ADC75;
	Tue, 14 Jan 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849955; cv=none; b=FVnIoZ0eihhHTsX1omFWZgjaJnOIVcJ2CS1dKXEcbM2AdfjIoNwyXF4Z3DF7XIdj7B3tkExk2qLb2iG6rI/jnW68N2aoRTgJeX0Qkhzarjrtr62vh8os8uglkA62i4X9ZcNDHpUFWEXtsocIPvS6vm+19Q1DiBq28OOuU7gTa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849955; c=relaxed/simple;
	bh=q8+FLNP8K3/tvgD1K+ljoVgtw7XOZBMJxQlzT7AEMMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ue5vyl7uFcxbZE83XqOoZp1aTcOqj8yFfI1eLICucIbsbCqj23kMJGZ756VdJJeHM683xpi1F+Dc7pAOZzeU8zke20lxcSnF+G6HsKrlMLb0B8VdXLQEG3XzHhwWQEKHr+Br0CWFaG4GDS/whggqqC8VN42hCcWFExQ2Do49qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqC4PSbL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d9f06f8cf2so2231486a12.3;
        Tue, 14 Jan 2025 02:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736849952; x=1737454752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=au+4nzSH0UlX4LucO2/pISWeQnVDf8eSFYGuYpAKTos=;
        b=CqC4PSbLl+UW/KtKj2B4vVZvf8iwQjAVztotF6ZiyanHE90IMNT6L8yHYVlllFiQqZ
         tyRy2n6RIx9OFkKCPbTDTe0sMt9jGL/TL5zXgsBP3MB0vl4JFBLM/LS3q474vMEPz+qB
         9V3MFE/733TGsKuMLi/beJ+QgDwSMeGuZ6Pg+X1gOK0lot+r5jfi1mFH5m52CI47EtaN
         0nPrMc0Rkz3HBWDQXDIvcOVFjbOynPN7jHHpcZlBLZ/xMdhUnzKw6CPVXBT/8IgCcOmg
         uR3Y0iyNeeA9m6Z9k8wzaiBqT/9fFdMX49hY+D3anqQhZGiz087g6d7+OkPajiCrVEU1
         +WAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736849952; x=1737454752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=au+4nzSH0UlX4LucO2/pISWeQnVDf8eSFYGuYpAKTos=;
        b=sV4XFku3UFG/DFZAHQxkUGiKrZMtn40F9lnkiLHp4FOpHzjGeuHJnnx5wzoQqL3HXk
         vJPRyWUEoBj9XyQnc76wp59NM9pjeYd26veprQq5HqmSqg31QS2P2NpjZ6c8mUs0OiQW
         HK/JywaxqCvD76yLvoKa6blozl1cm5AyEX1WGgx9liqu+vizRRpkXuBzh9T37WQw4vk9
         kZB85hj2h1wPMAY60LlJ0VhB1uPsRRsYeC5Do6p9pjCIrm3W7S542esC6eTbxVdfjj3H
         N7oeng3vZNXWraeylOdtyecQZNKY4x1aBpTXFYNLSjRtVhNeyHWaquJkv8g5tKcdSXFg
         1XHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSK27Zy5TdXFs9ArQ1jUWCEM5riY85QDsr//n4KrFgxWzNtu7ijlq1BHPLehPD57+zcFKPsnZD27+c2bD2@vger.kernel.org, AJvYcCVuJR0IBCanYBmafzn1ccFHV7sSaZNAGmANPXpNZNemqkuQH645PGfEsiKkD0YrGx0z4HKQMCe6@vger.kernel.org, AJvYcCXaLPSyuXwPNhtuGLReelv0FIZZGFBgm3AnNwsHTXaFLEDAJIM2+glucDNtrskNaizUKBC8ZTFeEMjCmrTW@vger.kernel.org
X-Gm-Message-State: AOJu0YwzgoCwSn+ucNNXVK4M5ULgynP91OF0vxkD/R5Z2adyexV+qVx2
	hVp3gJ/yHD8CmDwTvxQCAa+28JMucKJG61+MUa5/00tTYguQHv/9
X-Gm-Gg: ASbGncvj+TRvc2qneQwBO+FtD4Kzv/67mC1Lpr/tm5WXw81hzay9sk8MwVqgdTIL618
	Z8K7jj+k21rDYZeVP8bp7qBNdFgwx5G1ZM4AoYAONtTDMEmFx0x3R0lxtnzTXTK8k/O5/PBGbGl
	mzVJF+54ugaqyZWO66Vi+S5h3j9GC6fDjIUfSs5e7ov2yGCxlfmyNibOM33n3z1+VcPBQ3zeKJ7
	DR3FppJes2MOSCHKeK1Igx/YqlyEs/Xomzhs/B5kw+bb+wUS2CZdhynUuofCR66voMtwMvbydDe
	rLuSPzm3SsyFH683BPs9KiUAjGEeF1NgEt9j9LocP41iXTBm0a2W9uthHSTyLeQ9akDuagi5qTL
	q/dz4M5gm/qdmnxw5BHjXGg==
X-Google-Smtp-Source: AGHT+IGehqA9xVupJMVpA4Cfk+IpdeF34C6tia8qD9Vr+uaKzMnOgSdI1DwUAPRlexmP8jPjGwcqPA==
X-Received: by 2002:a17:907:368c:b0:aa6:9624:78fd with SMTP id a640c23a62f3a-ab2abc78a71mr2414171566b.48.1736849951491;
        Tue, 14 Jan 2025 02:19:11 -0800 (PST)
Received: from ?IPV6:2001:4c4e:11ce:6a00:d364:8993:3481:1e06? (20014C4E11CE6A00D364899334811E06.dsl.pool.telekom.hu. [2001:4c4e:11ce:6a00:d364:8993:3481:1e06])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905ed87sm605318166b.28.2025.01.14.02.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 02:19:10 -0800 (PST)
Message-ID: <5c1ba4db-1c15-459a-b7b5-ce3f22db7e39@gmail.com>
Date: Tue, 14 Jan 2025 11:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfs/hfsplus: fix slab-out-of-bounds in
 hfs_bnode_read_key
To: Vasiliy Kovalev <kovalev@altlinux.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
 syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20241207121726.1058037-1-kovalev@altlinux.org>
Content-Language: en-US
From: Attila Szasz <szasza.contact@gmail.com>
In-Reply-To: <20241207121726.1058037-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is exploitable for LPE and it should be fixed.

On 12/7/24 13:17, Vasiliy Kovalev wrote:
> Syzbot reported an issue in hfs subsystem:
>
> BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
> Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102
>
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>   __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
>   memcpy_from_page include/linux/highmem.h:423 [inline]
>   hfs_bnode_read fs/hfs/bnode.c:35 [inline]
>   hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
>   hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
>   hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
>   hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
>   vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
>   do_mkdirat+0x264/0x3a0 fs/namei.c:4280
>   __do_sys_mkdir fs/namei.c:4300 [inline]
>   __se_sys_mkdir fs/namei.c:4298 [inline]
>   __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbdd6057a99
>
> Add validation for key length in hfs_bnode_read_key to prevent
> out-of-bounds memory access. Invalid key lengths, likely caused
> by corrupted file system images (potentially due to malformed
> data during image generation), now result in clearing the key
> buffer, enhancing stability and reliability.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
> Cc: stable@vger.kernel.org
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
> v2: add more information to the commit message regarding the purpose of the patch.
> ---
>   fs/hfs/bnode.c     | 6 ++++++
>   fs/hfsplus/bnode.c | 6 ++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 6add6ebfef8967..cb823a8a6ba960 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
>   	else
>   		key_len = tree->max_key_len + 1;
>   
> +	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
> +		memset(key, 0, sizeof(hfs_btree_key));
> +		pr_err("hfs: Invalid key length: %d\n", key_len);
> +		return;
> +	}
> +
>   	hfs_bnode_read(node, key, off, key_len);
>   }
>   
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 87974d5e679156..079ea80534f7de 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
>   	else
>   		key_len = tree->max_key_len + 2;
>   
> +	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> +		memset(key, 0, sizeof(hfsplus_btree_key));
> +		pr_err("hfsplus: Invalid key length: %d\n", key_len);
> +		return;
> +	}
> +
>   	hfs_bnode_read(node, key, off, key_len);
>   }
>   

