Return-Path: <linux-fsdevel+bounces-39409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F520A13C43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68659188CD0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F46822ACD0;
	Thu, 16 Jan 2025 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py9QcZ/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220486328
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037846; cv=none; b=mkC1QspZ8AnZXbRtEHjJnV7Uj4TkP0Wk1JT5qjKAvQyKIltlCqndtLWkih67LPK56VUQMV6JXu4Dngn8ENi0XUGAgD/F6KEkutqKkcgy2nxAfm14MK6cyJj/DQ4zy8ZfAReicXYTy1GGrHoBLBHJbIsj+fbjoPzuWOwNCIzis2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037846; c=relaxed/simple;
	bh=QIK3mQe4K7FH/eHBcZ7DiEnvNZxJbMC6Z+6vZ8P2xxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2JRGUbfDOWnPkRX0eE3fIofJdi5ktl9yU3GeJgysAvd6zx4iCEHAexC1GbAAzYD0xzX3nO2QnYkIDz4HEDYdlNmIti98Z25RyKADQFGWrQW4XL/StQUNaNidShc4yye2oBo2I4KeTJVoDQKNR3ZMVPJGXxo59dk8ctkkIUPRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Py9QcZ/i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737037844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HezSLtbLt6I3kDFST2dooQpti29iMwi6cy67iAjHZZA=;
	b=Py9QcZ/iExnkIyxln5ZgSAfD+3YGa5p8xj3c4AI/BK9uFDc9m63YTSw3fAv40n0pLlEzsl
	NiWmHhoD4SlZ4SPW8VB38BcwfMrVxYtapjbMasuF5gOV12oBGacyXz5kg43twk9V6GeqJ7
	kSWXwpcddc1jftkKiKmQtChSFf9K1sc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-3WJIFexHOiq2Q9y7aPXP2w-1; Thu, 16 Jan 2025 09:30:42 -0500
X-MC-Unique: 3WJIFexHOiq2Q9y7aPXP2w-1
X-Mimecast-MFC-AGG-ID: 3WJIFexHOiq2Q9y7aPXP2w
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3862be3bfc9so595143f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 06:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737037841; x=1737642641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HezSLtbLt6I3kDFST2dooQpti29iMwi6cy67iAjHZZA=;
        b=rF5WIQWAeZJcDNVTAZU7drNoJ+pc0B+IpNbJcwZsNZu+Axdn+srA7jgBHVsHlGpmMX
         r10NHO9Mkzv7degmx+00UXdMwqHvI7bFmuBSMYPp54Gik0drO3bkVfYEipazDCvTqLcI
         x71xw7k1+j/xMhIAJGyYYwy9gjPtDBQjwN0GlGRtRNhsCgDw7tD7a6Z0a2kyD257dC0J
         Hon0YzfwzY/SrRUG0e7DT/P9ks7LjOjnpZWphPUZYy0Wfviqw5BAwxr9kQA5RbbyYsu9
         QO728DHXOSbjeob5Gi6kyfc1/dIr4+J1gLJEzYPF92E4UZsmLMrQ7bS8BUYFu5kHSr67
         xmGw==
X-Forwarded-Encrypted: i=1; AJvYcCUz+lxAZJQ91RmpZj2EzfegCPVW5K63lw1rEfuqyRr6T+Ha0Dm2DdsjV10s5ShLHbvyIbOiTCbQkX8D93jJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzu1hgdP3YzdObGWwFFZ5PQPvLXQanzrlKy0MPibSpixDchLlI
	CKo+WFstZWf6sF7pr5/0OW8+DDaevDgs3C07ovojlui1xXXWwQuh6RlPkVpSgs9lVhgcF+/sjqW
	5wZAh6srerrTRiPwkjRw/ulqPZUFFk6Lj1dMbMVG+gkkAy8nTEIPsJgfywzLd3Kc=
X-Gm-Gg: ASbGnctM7JSI3bZZljzwZ/IoW3SI4d7A2TvsjmaK/a1ovKk7lYakUKHRfnoyyCYkL8+
	AeY/Nre04qxYHxU56xqIevj8h0ec+l4pp5D+f6lrOvi6MtcW6y2yNDX1QKt79bJ2ZnBBDZancum
	hw3URAcvztyOPTabX1ENE+hvKWcO+vMslKohZvmq7EOvoS7LDZq6URjA7oGDJx2z4wq9HO5P8n6
	gug2OCjD7DKBDt4Y0ys0eZMTqczS2T7Z3/uKFpAqWjr5i0fQJoccnj0VJzEzKIUbj3kYHcqY8rO
	U90PQQAi+i5ycn3zSnWFhc/mhEFeMewPQmdFhF2S
X-Received: by 2002:a5d:6d0c:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-38bd7d2152bmr16922011f8f.2.1737037840709;
        Thu, 16 Jan 2025 06:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5blT5qJsPmn5YMfOhaY9D2QzZQ3/j9n+qpA+7oxjjuOMEuGsOLpy1own/fxtthhPqHcfg5w==
X-Received: by 2002:a5d:6d0c:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-38bd7d2152bmr16921963f8f.2.1737037840175;
        Thu, 16 Jan 2025 06:30:40 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32222ebsm23999f8f.40.2025.01.16.06.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 06:30:39 -0800 (PST)
Message-ID: <eb78dcaf-5acc-4317-911d-cff3b53e424d@redhat.com>
Date: Thu, 16 Jan 2025 14:30:38 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Kun Hu <huk23@m.fudan.edu.cn>, Andreas Gruenbacher <agruenba@redhat.com>
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
 <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
 <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
 <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
 <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn>
 <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
 <CAHc6FU63eqRqUnrPz0JHJdenfsCTWLgagX+2zywHNTcFoZA8XQ@mail.gmail.com>
 <A184824F-B892-46D3-B086-556E9ACF4EA0@m.fudan.edu.cn>
Content-Language: en-US
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <A184824F-B892-46D3-B086-556E9ACF4EA0@m.fudan.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/01/2025 10:41, Kun Hu wrote:
> 
>> 2025年1月15日 02:05，Andreas Gruenbacher <agruenba@redhat.com> 写道：
>> I've posted a fix and pushed it to for-next:
>>
>> https://lore.kernel.org/gfs2/20250114175949.1196275-1-agruenba@redhat.com/
>>
>> Thanks for reporting!
>>
>> Andreas
> 
>> Syzlang reproducer: https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT_yn-tzm6NqmcEW-/view?usp=sharing
> 
> Hi Andreas,
> 
> Thank you for the patch. I tested it using the syscall reproducer and was still able to reproduce the issue.
> 
> Crash log: Link: https://github.com/pghk13/Kernel-Bug/blob/main/0103_6.13rc5_%E6%9C%AA%E6%8A%A5%E5%91%8A/%E5%AE%8C%E5%85%A8%E6%97%A0%E8%AE%B0%E5%BD%95/32-KASAN_%20slab-out-of-bounds%20Write%20in%20__bh_read/crashlog_0116_rc7%2Bpatch.txt
> 

That's not the slab-out-of-bounds failure. It's failing to mount with:

"kobject: kobject_add_internal failed for syz:syz with -EEXIST, don't 
try to register things with the same name in the same directory."

This can happen when a gfs2 fs is mounted with the same locktable twice, 
so I expect it's a problem in the test. Please make sure you're running 
the same reproducer from the original report, in the same way. The patch 
fixes both reproducers for me.

Andy


