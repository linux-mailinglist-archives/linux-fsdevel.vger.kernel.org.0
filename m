Return-Path: <linux-fsdevel+bounces-22456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D789174C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 01:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F192BB210C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 23:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F81802A9;
	Tue, 25 Jun 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/wG5oku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411F17F4F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358457; cv=none; b=f3aOgPB2NBjshBMzIeNF16jEpcRzzHuKy3KU4gjsbT3ndAMVulHArO18J7xg3zR2Pm06ofdTuegkLnYxcQPbVWIg1VLYh7r6zlP2CeKVFRPlHzz+6ldd+Q3+ROrq5gPzOBTTzAEYfV2E509WWFMwgXhay/JYtdkIrdtKpmUQKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358457; c=relaxed/simple;
	bh=JW5+38U/vcohXyeiKPUGkpLsj7sweQrd3uPWwGSP2dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pB95S9ouSwSuVD3bnu4V7nS2fkCN1BEhRszq/v9iWG45Fy2k83ABKYUOB4WAuoh1QVkZWLof3Zx7AGBhWU4XHKCFu4Xpwk7qLgUw1mM3A0EAY/NeLVzg485xPCQhUjw3KOX5x/1fVXPKyaeIUN64lyZKtyLjHp8inzUewowX/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/wG5oku; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7eb41831704so17351539f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 16:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719358455; x=1719963255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLoxHe91BqYGbErrOqOVZAihyCRQ1/q/QL1BRJCrC+o=;
        b=V/wG5okuWv18Vfa9pCOLL2nMRWl0biru0lnT4hzlLivPncC8sUFRvm6gMENvRd81ux
         QxzPGLVY1A39TY2Xzr/l8CPnCCX9uwuvpizox9qSO1liYdMtH4JUSn4TZnVi60Ig1RYx
         IIvjxXMb9wbIZszaG50NROd83GnyXknc7sdyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719358455; x=1719963255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLoxHe91BqYGbErrOqOVZAihyCRQ1/q/QL1BRJCrC+o=;
        b=peQ8kBhIURX6DZb30riQ6WxIr+NlM5h0vImMjP/CabeK+MQOXo+sD/VOEyHbkpZJ6+
         URXJajUeAbHp0t00BC7YZhqkrhCgVB+qTMB2GV/6JWFFfjT4bWLnbw2IjcWmcI3eRuzs
         WEWVXA5OTg+tE8uaD4KwBjUSu88dh06jk2pPFBrBJl7gEDA99agwQlLHb19jiKJ3AXEi
         lAg4IJXLd760LClZso9DXhmGhG1Yv7spJJm8uFPB5QZcxtlzZkxuH++gzC3C3M4HQj7F
         63Pnowo8ArWEV79S7qtEI433kwy++Z8mKs9Ypu9H6reaz+zTUl5DnD0pOEfF/ul8ajdI
         FHWA==
X-Forwarded-Encrypted: i=1; AJvYcCVwkYo4gZLkh48vfM889fesSOgySpEy+xy3LoQZATQGaUR1xWFD8ldO2+zGE0k50o6tHMSLGEqRYH9/QdYn16ne515MtHbHVUP1lJMQrA==
X-Gm-Message-State: AOJu0YyrA90IrxRU05T4iAMuAXmA1Q6p7ERX/FLlFQIskmMGSd6/tf25
	FjRIYoYHuARQDppSKsO2kH/QeAYqi53aeudQ2CFwnZgpBQQdTJBmQNQK5kbN6AM=
X-Google-Smtp-Source: AGHT+IHFxsdnrHHCJW39/Lbu9cUGENC+vnEtRYVDBjLq63CwNtPtBkCUmNgYxOl/tyW+mRbcBoYz8w==
X-Received: by 2002:a05:6602:3148:b0:7f3:9ef8:30a4 with SMTP id ca18e2360f4ac-7f39ef8334dmr991110139f.1.1719358455001;
        Tue, 25 Jun 2024 16:34:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb458ba8efsm645345173.8.2024.06.25.16.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 16:34:14 -0700 (PDT)
Message-ID: <f975fe76-92f4-4af0-a91d-0f3d8938f6b2@linuxfoundation.org>
Date: Tue, 25 Jun 2024 17:34:13 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Centralize _GNU_SOURCE definition into lib.mk
To: Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>
Cc: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 usama.anjum@collabora.com, seanjc@google.com, kernel-team@android.com,
 linux-mm@kvack.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-sgx@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240624232718.1154427-1-edliaw@google.com>
 <20240625135234.d52ef77c0d84cb19d37dc44f@linux-foundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625135234.d52ef77c0d84cb19d37dc44f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 14:52, Andrew Morton wrote:
> On Mon, 24 Jun 2024 23:26:09 +0000 Edward Liaw <edliaw@google.com> wrote:
> 
>> Centralizes the definition of _GNU_SOURCE into lib.mk and addresses all
>> resulting macro redefinition warnings.
>>
>> These patches will need to be merged in one shot to avoid redefinition
>> warnings.
> 
> Yes, please do this as a single patch and resend?

Since the change is limited to makefiles and one source file
we can manage it with one patch.

Please send single patch and I will apply to next and we can resolve
conflicts if any before the merge window rolls around.

thanks,
-- Shuah

