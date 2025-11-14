Return-Path: <linux-fsdevel+bounces-68531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1671C5E39C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99A0A4FFE63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBE32D0FF;
	Fri, 14 Nov 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJrZTm4F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A62727FE
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136937; cv=none; b=lCgVo/KQn7BjnfAyNihbWJ4Dzd4cL3+jvbdhlu1bduKOhlBmfgoFcgRQQmeePeApx1QrQr2P3fO+j1hkTUYsg1M/pt72VIDFZu8ZLappAsiGtCZ5VFVyoSX9Z/K/I2YrHgeb2JM+rliM6WS5EtWfLHpULF7SS5DfthTEXozLHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136937; c=relaxed/simple;
	bh=zmxCeEpKMg4TfVe4pMPpJGPOODmS7NBdibb2JJGax9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhgzbRkM5pFOrECSZ1vC2cVCo3okZnNpiaWiZZILDmT1bdXZtQmfE2gr0wvjW7PNCaLFho010CCVnVJkY0rPsJeJsCuhPwh1A4IurdnttLTf40vJBZ0QsD0mCDudM79tNG3NFWJPiwVs/8qJG6wY5r0tFyfuFoJJgd9XstMSFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJrZTm4F; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b53b336e6so255535f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 08:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763136934; x=1763741734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S8nPd1ENpMC4SYc9rvmT0Lp/u7FrcbdsZgoe2IcMKXs=;
        b=KJrZTm4FcQ5sqQizoi01GWH15fLpUysYUa3YDlL0iFpN7z5NKd8VXxNHT0OFXaCgtT
         meBB+hSkjkAqlF7ZMHqDyDEqzr8AuXemldpNqJi1EbyAZPuql3moE8unTgXmDuBVO2J7
         4F5HhqyvbZqSJuLRFIOBbYGywK9f031TkThSYiMMmOU+nSJ9BU/23mQq/alHrtwsMgHw
         7Mz7Vz5ERPntXqz4UfBcUrDzEVkISTVT94xnHyTDAxuIu8gqGr4LbuVq03yp7u6JzizJ
         amavSBNCRXdW5NhgkAO/tBwa1GIdO/wBdm/VuJwZa/xIHy534YzFGitZ/+girMigpWiu
         HBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136934; x=1763741734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8nPd1ENpMC4SYc9rvmT0Lp/u7FrcbdsZgoe2IcMKXs=;
        b=Jdp6iJeb2I7iQVbMBDDsc85WwZJNA9TjzyrJU+nxZ+FeL0OzF4d37eq32H1HqUrwED
         f6YYFIJZaVs+f0nfN/ISQ5uf75rfn9iNbknvc82nCki3dW6ynTQaCdIkKnbrZLy9Wcyo
         of0WjCoN1hvR6QCqyG7uOoNJ3TAQrh4KSpaqCKluXIRWqkDiI4GAKZ6kA5Qk2/xGlmq3
         va9WUuG4e/krEKocrPnzgl8+elTXJBEQr2UmoypK3cFO5qQlgYee5N078hDJvBC/D7qV
         4z0hJgK45XxtmEmqt0AmfreHdgDrHHh4xCE+9DvKlJxtLZ3BMJmnJio8EnRs8cr5MAqY
         HdBA==
X-Forwarded-Encrypted: i=1; AJvYcCXf3N66I6ilL2zsdek39oQVkVFyOOPt1VsrI06HH7aRk6dq7McGiCN2IKZ+Un023Yin0ee9O4e9Uh9SJQcG@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtGq4u9T4yx1YVz9+K1MBGIv7Tzv9tESNK+2MsJH8IGG/yqxQ
	xUZQLrYdlUVOAKBqhuNi71TIFf0AtReGOC7FZKvHv1NGl4NwuhqLSWWF
X-Gm-Gg: ASbGncu/yzzJTF/Fn7tmdXCnLdIO270BaRt97zVkdu5a2/doDy8xqaJhZArajCLbsl/
	CntMbT6dyJfHfexia9kiTqpzYwr0VZkGFUDQ3uOYuuic70VuIPdxCcqAjuUYBLObhDlSA9VOScd
	kA1MHTytK0Dq90scRzapyfYIByc+59RndxeZkMMdJBLRiaukQYvsogw8cYU/QNhNbaM/c5+gxZc
	EbkPqq9yEk84/cg1tdcJuUzvZBkJp89I8FNcx/1SeW9oNHRUr34WYHsKK4afv+EYNPRkuca5WNA
	lmWZljfxipc8pk4apNdLx0gHa4wxZvXlpxCBi7+ZTk/+RxGpVjP2e/SAjAVOZEcH4z/rnmyNrhN
	s87wOMYfnFYus5+0OddvUedM3AgzYbo51PIQWvCny/AZSiRAjtadwS77KSwFxSDfF1O/yyCUgrz
	LRQfwW02qZK1vCDr9GgsrI6Q==
X-Google-Smtp-Source: AGHT+IHIEVmILbrPNRdWMz77/A/ssX1n1EPNw1gYCxrGDM8+CBlgpu8eoLF1F2e1MggF54U/pSI5WA==
X-Received: by 2002:a5d:5846:0:b0:429:bde0:1da8 with SMTP id ffacd0b85a97d-42b5a983adamr1613364f8f.7.1763136933750;
        Fri, 14 Nov 2025 08:15:33 -0800 (PST)
Received: from [192.168.1.105] ([196.239.132.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f176basm10486460f8f.34.2025.11.14.08.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 08:15:33 -0800 (PST)
Message-ID: <1a2445d1-6fbb-4133-b5b7-72254e96d815@gmail.com>
Date: Fri, 14 Nov 2025 18:15:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/super: fix memory leak of s_fs_info on
 setup_bdev_super failure
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com, frank.li@vivo.com,
 glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, slava@dubeyko.com,
 syzkaller-bugs@googlegroups.com
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
 <20251114051215.526577-1-mehdi.benhadjkhelifa@gmail.com>
 <20251114-raubt-benoten-bf2d8f2317b2@brauner>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251114-raubt-benoten-bf2d8f2317b2@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/25 12:55 PM, Christian Brauner wrote:
> On Fri, Nov 14, 2025 at 06:12:12AM +0100, Mehdi Ben Hadj Khelifa wrote:
>> #syz test
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index 5bab94fb7e03..a99e5281b057 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -1690,6 +1690,11 @@ int get_tree_bdev_flags(struct fs_context *fc,
>>   		if (!error)
>>   			error = fill_super(s, fc);
>>   		if (error) {
>> +			/*
>> +			 * return back sb_info ownership to fc to be freed by put_fs_context()
>> +			 */
>> +			fc->s_fs_info = s->s_fs_info;
>> +			s->s_fs_info = NULL;
>>   			deactivate_locked_super(s);
>>   			return error;
>>   		}
>> -- 
>> 2.51.2
>>
> 
> No, either free it in hfs_fill_super() when it fails or add a wrapper
> around kill_block_super() for hfs and free it after ->kill_sb() has run.

Sorry for the noise,Resending with proper CCs:

I forgot to mention. I was giving back the ownership to the filesystem 
context because upon setup_bdev_super fails put_fs_context still gets 
called even if I would free s_fs_info in the kill_sb,so hfs_free_fc 
would get a NULL pointer to kfree as a result..I don't think that would 
be desirable.

I would be sending my patch out for more discussion.

Best Regards,
Mehdi Ben Hadj Khelifa

