Return-Path: <linux-fsdevel+bounces-60373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB6DB463DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 21:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D941188E3C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070E3285071;
	Fri,  5 Sep 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTS/deVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193D28312E;
	Fri,  5 Sep 2025 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101466; cv=none; b=eWXxE7eQT7fZTDh3svvEMG5aYd8MAQxzbjqWPT4Qw2jVTc/GE8h4P88EyH76uNZWqF3pAZ4jrd+20wijoQMidyWZSK81foRb19T7styPTRo9o0kv0cV5vAeu18WY1NlBWfgTzIu7GU9YqbOVuSsbgXO1ADyLRScJrEIrBZE6RxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101466; c=relaxed/simple;
	bh=Ym8w4HXDojSn4bdlotWab64OwdaXhDpeE1PilSeNtZ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NIG3DeHhDEiA5Q7Kd1MtXThzpjZ4wfcZtXMpu8bDLrjS+p4ZzudvbaED80q0l6s2zUWOBloLWlRCVee23B0TOLwmflKFNDKsWqhCnHsoolVLzrW55BCn2TUzBFn3iuOEB/5X2+0Ollh847p+8F4a7L8k+Tp6CvA0+TEuayvRGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTS/deVb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso12219935e9.2;
        Fri, 05 Sep 2025 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757101463; x=1757706263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gihNiL/JMk6H0925BlY7NHCybaKcuYV/h29UWRuqZU=;
        b=mTS/deVbpDtYn1/nGStTrH8GrN1s7samJnoW0KeaWOwDdYyyc/OrfEWB9XzxkbyK5v
         bY4O4VG+fKiFruAV0ELEGyYBr62oSnkTNiOpBpjFDWMuijg40Kr46YJOllRkAaa5sWTv
         n5VXeIWL9ni4+ibkSuTsTAOBsk3L/lwM69ren8rr7ad+wFzoyC0zMzQjSMTwoiqBt6MK
         gyL3755ZHcegECgWddM496mMYUiXs1FPdA5yGidhjBHibYONO4yTbecjKxHCsilkCQfN
         m6Pv61lB4zleJBT2kK/ICWmoCXpIZVn6S6T5+olPS0RbYusSFZz3+xgRmf9kDOhakgDl
         s28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101463; x=1757706263;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gihNiL/JMk6H0925BlY7NHCybaKcuYV/h29UWRuqZU=;
        b=qw9m4LAnVfjZ57ju5TGp3pwaQgsnWg5QcPuK4zvIVwKtypQbOuIf7w6fCo8lEDFQzg
         YuQ13AkkT91JJrhVXtkBc3MsCIp5U1W2UMc76OJR7uPhEBUbsq4i+PMKskpT/ZAYd8JV
         taoCtCwRT+oJxBR29oDNxn2UrSCFzvdbLyfVlC57BczHjMa1+ewdq3yPwD8HdHhWh6Um
         zTp4GkQDvzmrKj2htdmUsEwa2aNPfp9LNGIC2ivgNbsfJ4YBEQp+wZwlI+zX8Ve11nhI
         X8B6/LnqRvdqhmQuLBtRM9bUaZb8Y7vBXLHklXoGHJZ/ewAHUrnjA+ycD/VO1Qf55rsU
         rlKg==
X-Forwarded-Encrypted: i=1; AJvYcCUv8+YPrIgEIw2KW57EVFF3rBCkaxih+PSo9eGVWMTXBJylumKiT83bkPRpcWCr65Ze+OjVAntKioU=@vger.kernel.org, AJvYcCV4d87o+8huGaZl4m89jqqY3+CV/yThNTCmxnlg3QCp7qTYQKyIcQNaF1i5YJ4KiS5PzNwKE+VWM5u7Bosq@vger.kernel.org, AJvYcCW9yPs85dVbT2AESpvVnLnPZxpvQ0V3i55hd33M5yHxxUVnNEoGNh+G5lZUfiz1odyi0lIhsPgnhiQjCqsIxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZeCryUgwg7M3wPhQWXPOn8SbYvpvknQ0L/IR2BO+kj3cgadE
	q7i4zZ0CkTvFsqOkftET5+nwgECKh/Qab7c83qwkVpp8LmKZ0177D+kO
X-Gm-Gg: ASbGncv0QlWc7tx5udsUJf8X/BKM7j7vq631HN2Tys+IN/M9MNrc+IUe+7nppEmimXn
	KVZvaKu2Id8ZWQ819WvHG7p9T+Xc9UMSPbXLpQ0UbKWmS1cAub98NRDHPOYvqhcD772uRsy+SWQ
	9qjM38rEn4q77Kgi6WD8Vagq1WbgoTu+VRuiKCK6ohM+i+r/oOjQpvlC2Kq3gleKDxn0ev6iMBU
	7nHiMigeFUagE2aqdYFABDX85jVJG64NhzovMsDQMvS+E9rEcsFXHzYnzAMZQwlNE1bl2K/sW2Z
	wO+Vr9AID4lPKbJnkwQRSg0CKJOZ1k87dlOfXOO7/y1ontlo+kesfn8ucJQ9cUGZr4/536XYje5
	z5IjH9hCOHGXTjgR62+lxo+VRAvRgYCTih52Ht1nlNTDWPJRWXJ9bsY/7Mp5TAQ9RFnkeMMg3q+
	C8fy+SVWzDy5+v2SeOVvjng9H3d9M0
X-Google-Smtp-Source: AGHT+IHOGLoAlL1EKX3BuosEZEEa4UCTSyf5rfL5O6Lh/HionQYcDs1GP2npYPB94Jdvfm24zXfnfQ==
X-Received: by 2002:a05:6000:25ca:b0:3cd:93c5:eabc with SMTP id ffacd0b85a97d-3d1dcb7627emr16306265f8f.18.1757101462595;
        Fri, 05 Sep 2025 12:44:22 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm427283745e9.14.2025.09.05.12.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:44:22 -0700 (PDT)
Message-ID: <5a3fd8fd-d215-464c-9e84-b8051c16f07f@gmail.com>
Date: Fri, 5 Sep 2025 20:44:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] selftests: prctl: introduce tests for disabling
 THPs completely
Content-Language: en-GB
From: Usama Arif <usamaarif642@gmail.com>
To: Mark Brown <broonie@kernel.org>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com, Aishwarya.TCV@arm.com
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
 <c8249725-e91d-4c51-b9bb-40305e61e20d@sirena.org.uk>
 <5F7011AF-8CC2-45E0-A226-273261856FF0@nvidia.com>
 <620a27cc-7a5f-473f-8937-5221d257c066@sirena.org.uk>
 <abe39fc3-37a3-416d-b868-345f4e577427@gmail.com>
In-Reply-To: <abe39fc3-37a3-416d-b868-345f4e577427@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 20:40, Usama Arif wrote:
> 
> 
> On 05/09/2025 19:02, Mark Brown wrote:
>> On Fri, Sep 05, 2025 at 01:55:53PM -0400, Zi Yan wrote:
>>> On 5 Sep 2025, at 13:43, Mark Brown wrote:
>>
>>>> but the header there is getting ignored AFAICT.  Probably the problem is
>>>> fairly obvious and I'm just being slow - I'm not quite 100% at the
>>>> minute.
>>
>>> prctl_thp_disable.c uses “#include <sys/mman.h>” but asm-generic/mman-common.h
>>> is included in asm/mman.h. And sys/mman.h gets MADV_COLLAPSE from
>>> bits/mman-linux.h. Maybe that is why?
>>
>> Ah, of course - if glibc is reproducing the kernel definitions rather
>> than including the kernel headers to get them then that'd do it.
>> Probably the test needs to locally define the new MADV_COLLAPSE for
>> glibc compatibility, IME trying to directly include the kernel headers
>> when glibc doesn't normally use them tends to blow up on you sooner or
>> later.
>>
>> I knew it'd be something simple, thanks.
> 
> Hi Mark,
> 
> Thanks for raising this. I think doing 
> 
> diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
> index 89ed0d7db1c16..0afcdbad94f3d 100644
> --- a/tools/testing/selftests/mm/prctl_thp_disable.c
> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
> @@ -9,6 +9,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
> +#include <linux/mman.h>
>  #include <sys/prctl.h>
>  #include <sys/wait.h>
> 
> 
> should fix this issue?
> 
> Thanks
> Usama


If that fixes it, please feel free to send a patch or let me know and I will send it.

Thanks!
Usama

