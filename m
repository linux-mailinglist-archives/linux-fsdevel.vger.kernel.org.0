Return-Path: <linux-fsdevel+bounces-30914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310B598FA39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 01:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1F22829E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 23:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538501CF7C9;
	Thu,  3 Oct 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FB5pVejv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C081CC16F
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996692; cv=none; b=jqDDCoEkrnS6hdPE8A3tAWN8pGt9ziWSR0fKuEyeSToixKyhnMeR1Iaqs9J3OyJmwIQBq9+0QZ1DtJWIy+uixO0VS9Sm7M2ah6IrTMX5bHZABBv6GDjJebInv9aUaCU/TM7OxU5xgvCuYKzxRR3jG6d6Gf+EdZ3LD7rG3p5kz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996692; c=relaxed/simple;
	bh=6FHqkRQuz3uxjkneqqwW6xoBxVKVyzxwgpRcDKWL8SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtcHLVf2qTdrrnZPN/419ouMaRZ6g1eXhciqsrleVildfe640n1Q7GpbzBfkfYDJJcLB0fb7SOyM24GF5CY7vi/xUGJqKlMzGZxNEQGAAehzLJxJI+AkEaHye7Ig2nP1/S87SNkVVnGjM773hE3FBqkD3pMlI+fAur6DucIcfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FB5pVejv; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a342bae051so6151595ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727996690; x=1728601490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6nfuUKflXlu0gy64XrlY7jGUy2rKVA8VyjGUfxntcw=;
        b=FB5pVejv5ItK6zYkPtB+PviRINede0U2H6tYLbueQqDygJvQgX6JiNKnjTXw/TbJRf
         pkrZ+JGPSJzLQXp3L59y8mGIgGSEFfsedv0XXfCXYSt1XUbxv5hzUCLaG86S3ugmfn7C
         KZaeOUAs+OmQaUFOnUSoGcvLJyJYj+iBe70qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727996690; x=1728601490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6nfuUKflXlu0gy64XrlY7jGUy2rKVA8VyjGUfxntcw=;
        b=Tytx3dJqTr7hU5ZFmj8y+v649wD7fl4OxxnENAwbHJdlr3weLbiafltVmQ86/kRWxe
         aB6rNooUZpde3I+ZowAkmZo0zkDTXSUlvSn0QzGQy2SPPxcU/DH0lr0hl3tYzWjyXFDf
         lev+MDTRdOL98VFWD940UwCh+w/NTNvHe3U1zP/RIbXHl/4cxrBGf6CrUEWHnv+dTwBW
         SVh499KxnZZAAvRPUa4GHJBhwk9+iAnfIHirxvvILDaj9YPmgPd2sfCKZw85IbZUF5M/
         BdA0+LuPtglfo38pGqPnAJm/7+xxoOWdVWKtIP4y+RbQ5r1kT0FPIZ3XN2WgNGSUbeJ+
         glZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVSEfokbn2jGXb05MoyXAH0RFc5URF3BwB2iXIWVKeE8xmA4rHb2mDBuXuzBhqCRxivK/UCuYUJ7gc5DaG@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSAQn+bQp+ukTBa8XrovjHjwtqUjOanIqp+lE06bJQpy5iwKz
	F1avn0iovf6yZJZlPS9W7hjM75ZdtZykoBSswbx1nlI4ClXuZkxuvecpmcpnSBw=
X-Google-Smtp-Source: AGHT+IEf92eF4XbI75+DDch6LT1NVeo6TRIQ29YwXnjI+iDeNTTSz8c4ISNOJ8P9ysseWA+UZhFJyQ==
X-Received: by 2002:a05:6e02:214d:b0:3a0:480c:6ac4 with SMTP id e9e14a558f8ab-3a375bd323emr8671095ab.22.1727996690235;
        Thu, 03 Oct 2024 16:04:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db5585f2ebsm482149173.4.2024.10.03.16.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 16:04:49 -0700 (PDT)
Message-ID: <cb25b144-a388-4535-869d-98220a601ebe@linuxfoundation.org>
Date: Thu, 3 Oct 2024 17:04:48 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] kselftest/riscv: kselftest for user mode cfi
To: Mark Brown <broonie@kernel.org>
Cc: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, rick.p.edgecombe@intel.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-33-3ba65b6e550f@rivosinc.com>
 <fdf602e9-a8b1-4f62-9e26-bb62a7202d22@linuxfoundation.org>
 <b4347055-46f7-4e06-b484-bbf147b80fe4@sirena.org.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b4347055-46f7-4e06-b484-bbf147b80fe4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 05:03, Mark Brown wrote:
> On Wed, Oct 02, 2024 at 05:18:36PM -0600, Shuah Khan wrote:
>> On 10/1/24 10:06, Deepak Gupta wrote:
> 
>>> +#ifndef __NR_prctl
>>> +#define __NR_prctl 167
>>> +#endif
> 
>>> +#ifndef __NR_map_shadow_stack
>>> +#define __NR_map_shadow_stack 453
> 
>> Why do we need to define these? Shouldn't including
>> asm-generic/unistd.h sufficient?
> 
> We have this issue on arm64 as well, there's some issue with directly
> pulling in the asm header interfering with libc in some situation (I
> can't immediately figure out which situation or which libc to remind
> myself what it is though...) so we've got local defines like we do for
> the NT_ defines for ptrace.  I see x86 is doing the same.

It would be nice to figure. There have been some issues reported due
to local defines - the test fails if the define happens to not match.

Does including <asm/unistd.h> fix the problem?

thanks,
-- Shuah

