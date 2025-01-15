Return-Path: <linux-fsdevel+bounces-39234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59AFA119AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 07:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BB3161F91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EFA22F3BF;
	Wed, 15 Jan 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db1c4JBY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AF232452;
	Wed, 15 Jan 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736922789; cv=none; b=COywbn1/AqF6Oiac4jyqLx+lgSLEfQde4h+mVUUgtlSQAHKFXmzvflBimTVi7+CrmNKlQb2wc4jpEBRvybdHHJzmN9ZKdlWpeWj7IBEHv1TZruUBOrhclf+iu5rowfSepz86hsSRdDTdFE7JV+NpQPL15fSiTsSzmwkTJy577co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736922789; c=relaxed/simple;
	bh=lfjXsleCSoen1Va0EPL9LUWEPAIJjAM9cYUi1EesKzo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EHIVUm5uNRk8WA4zgn5uKepTO3d53DZl1KQXLopC78m8+CXKsfVnupTInO0+QrQvOBW6DHtkguBVpjXULQKAxQjj+LP+LajZiZXgEqf9kX7+W1+6k81x2204rtXIsNMaw2/D4LjPJr6ammi3SPl9mratBRJjciZ88Oo1Y56HDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db1c4JBY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so12204231a12.1;
        Tue, 14 Jan 2025 22:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736922786; x=1737527586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jxQrGpSS/mlqdMZgX6wEfiDrmoLpRsdt15cJfe9sdfU=;
        b=Db1c4JBYfQDqRjo8qHDZO+Uh90GEvYWOm38o6oIJRtGiQOgQV/upQM8T1J8qHdwFdh
         Li2ZwW62uGDTF4TxgICc1higBmdmm6uo5D1nRX+LKFos8ZsZSev6qEv1mIafSdf4kpVP
         afs0G6e/C9YQXQpnHIYcYR0Dw8nyx5Ban47gB1Y59nm+RrZB5iYqNltUAwTRjIfGbNfT
         foFkHSbfMx8U98fz4Lr/LH1v64A5ZFWLFn/QJT4ZHvdZ74RxrCBIe28ruRSoaPkMfC+f
         JozZXXPzaFc4Tg9DQJaW89x7uwgRriSh6BcCUwTTFIGcHH/f/mBbPz+SSd7zvx/jwjtY
         uCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736922786; x=1737527586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxQrGpSS/mlqdMZgX6wEfiDrmoLpRsdt15cJfe9sdfU=;
        b=kw6Ot3E+EPpWj/zCrT9FEOshjkAraCim6EIkO/RmTI+VXxFPaADCjGw50KiOQZg9pu
         9rkefVK6/CH9nABCjaqj0x6uc6aTfXccMCTxcw4EdTVJ9EgPBRr0UNAi7w5xE2XTVj6P
         YZPRk0zYVNTg+vwtEsIBJDMqbrgAbYMEsIPIdpZsOnuTExFZIFBzJtfVcJjtg0t/AXKo
         6fTFVlnr0/LNeDB5fsGHhJPKDi7qQ7ksnd74pJoubcTKDpmMvKZef0Ca7oguEku1dXRe
         +/ygofCBUSn/UnAf2Hip+dqD8TXFql5Tq/bJnEhmWjFqlNB7ncxb5P/NNT8jjG6F3xCs
         Z6qg==
X-Forwarded-Encrypted: i=1; AJvYcCVWa+sYU9LiRWx/1qEfbNHcUj1odmVzJWuACsJXgN0SyfhLbAGO6+19M5GPebmKOFfV+CNtYBy6sSTtLmf/@vger.kernel.org, AJvYcCWJp9TTAux2BGIawT0RTVlCEiTRr5t1+XI2voGoWfthDw7oWwYMSq2CKqRCIdIlPrdpJL1XudY6@vger.kernel.org, AJvYcCWs9Xdmal94P+PVtnEDNf9rwEdh8xOXnsOCi6woPn/aZhONiot/AZKvDRgoVXLr0LnjckwzOfukyFec0gul@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/PIo0e+4YZZ1YTbiW/29zLl5sxLIohZ/W4acignp3JzUHVd+
	XyxoHMr//7ghAoMJHB+dSUfjgaiY5S48iN/KLgIvpJg1nxp11AexrE2uz1T6Zv0=
X-Gm-Gg: ASbGnctqq08NJLVKQ7YHuVj3JdQzX2jFZgBmrDuvhObgBrNBAdLMmSuWIMvSuPQSaTY
	wdx1nVcZBI3H4KlCCfIlp31fAixfB0Ons6gImS6JSKwGw4bvur3GX2H83GlMyozHeDNYjXIfUzB
	eYIWEPowmm1O1Mgn74j1+ngEzoFcxC/18ejbZ1rkEAbXD24Y+68KViJW3NlsM9VX/ozz0IIwI9C
	QQzgCdzscWwbenpZ482WApL+raXp/LvnLzr6sPoYh/hAy8pwdKIsDjMfpvTDZYGo+kwXQJsgdN5
	CWjRbOlrdw4gh6uoIeRmhCG/PdEZyUvZ04O9B5dgLO06335DrpooWo6hA92vyvoM9fwioE5YQVA
	DoSW9x882OHo28RUU0riHKw==
X-Google-Smtp-Source: AGHT+IHvCkSawfbPVz39/Es2gRF6U/CAkWzUCiqmVAPUCF+fAkbvW7PRdcOVNbdmy0ZUrIphMysG/w==
X-Received: by 2002:a05:6402:3493:b0:5d0:e73c:b7f2 with SMTP id 4fb4d7f45d1cf-5d972dfcb29mr26042097a12.7.1736922785465;
        Tue, 14 Jan 2025 22:33:05 -0800 (PST)
Received: from ?IPV6:2001:4c4e:11ce:6a00:a792:9302:127a:3d95? (20014C4E11CE6A00A7929302127A3D95.dsl.pool.telekom.hu. [2001:4c4e:11ce:6a00:a792:9302:127a:3d95])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d98fe8f68csm7049365a12.0.2025.01.14.22.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 22:33:04 -0800 (PST)
Message-ID: <777961db-4fa7-4776-9a3e-8038f96cf406@gmail.com>
Date: Wed, 15 Jan 2025 07:33:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hfs/hfsplus: fix slab-out-of-bounds in
 hfs_bnode_read_key
From: Attila Szasz <szasza.contact@gmail.com>
To: Vasiliy Kovalev <kovalev@altlinux.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
 syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20241207121726.1058037-1-kovalev@altlinux.org>
 <5c1ba4db-1c15-459a-b7b5-ce3f22db7e39@gmail.com>
Content-Language: en-US
In-Reply-To: <5c1ba4db-1c15-459a-b7b5-ce3f22db7e39@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I still think so.

On 1/14/25 11:19, Attila Szasz wrote:
> This is exploitable for LPE and it should be fixed.
>
> On 12/7/24 13:17, Vasiliy Kovalev wrote:
>> Syzbot reported an issue in hfs subsystem:
>>
>> BUG: KASAN: slab-out-of-bounds in memcpy_from_page 
>> include/linux/highmem.h:423 [inline]
>> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 
>> [inline]
>> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 
>> fs/hfs/bnode.c:70
>> Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102
>>
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:94 [inline]
>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>   print_address_description mm/kasan/report.c:377 [inline]
>>   print_report+0x169/0x550 mm/kasan/report.c:488
>>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>>   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>>   __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
>>   memcpy_from_page include/linux/highmem.h:423 [inline]
>>   hfs_bnode_read fs/hfs/bnode.c:35 [inline]
>>   hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
>>   hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
>>   hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
>>   hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
>>   vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
>>   do_mkdirat+0x264/0x3a0 fs/namei.c:4280
>>   __do_sys_mkdir fs/namei.c:4300 [inline]
>>   __se_sys_mkdir fs/namei.c:4298 [inline]
>>   __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7fbdd6057a99
>>
>> Add validation for key length in hfs_bnode_read_key to prevent
>> out-of-bounds memory access. Invalid key lengths, likely caused
>> by corrupted file system images (potentially due to malformed
>> data during image generation), now result in clearing the key
>> buffer, enhancing stability and reliability.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-by: syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
>> ---
>> v2: add more information to the commit message regarding the purpose 
>> of the patch.
>> ---
>>   fs/hfs/bnode.c     | 6 ++++++
>>   fs/hfsplus/bnode.c | 6 ++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
>> index 6add6ebfef8967..cb823a8a6ba960 100644
>> --- a/fs/hfs/bnode.c
>> +++ b/fs/hfs/bnode.c
>> @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, 
>> void *key, int off)
>>       else
>>           key_len = tree->max_key_len + 1;
>>   +    if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
>> +        memset(key, 0, sizeof(hfs_btree_key));
>> +        pr_err("hfs: Invalid key length: %d\n", key_len);
>> +        return;
>> +    }
>> +
>>       hfs_bnode_read(node, key, off, key_len);
>>   }
>>   diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
>> index 87974d5e679156..079ea80534f7de 100644
>> --- a/fs/hfsplus/bnode.c
>> +++ b/fs/hfsplus/bnode.c
>> @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, 
>> void *key, int off)
>>       else
>>           key_len = tree->max_key_len + 2;
>>   +    if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
>> +        memset(key, 0, sizeof(hfsplus_btree_key));
>> +        pr_err("hfsplus: Invalid key length: %d\n", key_len);
>> +        return;
>> +    }
>> +
>>       hfs_bnode_read(node, key, off, key_len);
>>   }

