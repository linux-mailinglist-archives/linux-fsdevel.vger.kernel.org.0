Return-Path: <linux-fsdevel+bounces-49487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C342ABD305
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 11:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E008A6673
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08426772C;
	Tue, 20 May 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2rq4/3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B022641EA
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732518; cv=none; b=ZogumLBjQaxRgA7k1jE15aZAohntbkU86t3koh1YgTBywaRVEJwD2SSKK54AXrr+HCh0d++da1ZJyMqghd+bQle6QOOdb/PRqvRZ5UKV+PgI7c38a8o8nLbqWegFKz9k6PpX0UXGtq4D38uGoXQWucDqhjXNAJz5UlyqXm1+t1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732518; c=relaxed/simple;
	bh=O6cWyhsHStT5Ag5OkXoQaH7X7ykROd2XjVvE6eEcmSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1mi97NeZOZw9L0Puz/ThYT93g3jUvR6kuPCJ5ytlATuwMF09j3ZfiJPyk5+Ida6UAXi+GXcBTcPaKOVZGChJ7xLganTcSYlsrvj7ntEFyWtVpdNElRE1tcOa1UuRrYP7uaUtlHYL5UfeawMSF2v3WXZfkTgCVh7cUz9EZ2o5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2rq4/3N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747732515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DQclSPssqKfzv1ED9H1sAsmNx0RuC8HY6/KzQCHlf14=;
	b=d2rq4/3N3RFLcFizAUQF5HYG/+h563QgG43qcp7LH0wOMS690t87mNG5hHH55qKJDLxd39
	NA5J5uf66h1wgrjXjpnnIZbxdI6cv43kOhQ+2SbWf4A6Fn9pU1OIiGpU5awOxyRbHok20J
	lwK03pwphetmiAtFijIcVmhogK7AtCw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-GyjDZVwJPzSSNsJ2pagltA-1; Tue, 20 May 2025 05:15:14 -0400
X-MC-Unique: GyjDZVwJPzSSNsJ2pagltA-1
X-Mimecast-MFC-AGG-ID: GyjDZVwJPzSSNsJ2pagltA_1747732513
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-445135eb689so16400815e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 02:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732513; x=1748337313;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DQclSPssqKfzv1ED9H1sAsmNx0RuC8HY6/KzQCHlf14=;
        b=xGoTkyVWElzd6voaDx7OFEP3CmWe/EAEbheyzJvk9t+EnIpXhQEC3wkUNRcR8oBl8a
         hpr6XaIaASJkUeAdh1HXxLbiFHXe3/i/v9loeE7+U9lcxzbPgR1hkLmus5wrI0JJOfN0
         xeN9xtOmWM4FNBxio32VQZ6HxOSmsOhe6VwKKH1wzxsPRqVr7Iz5gbNKA+iPoL/beKyX
         CRs8f9PIPFiExenuhC+y6P9+vKtHEZA8mPARDY85b/HhbX/OMwx1ttoUKOWp6F6Ak8cv
         vWZmcY6X9FDq5V5wTMu7o2Ok5HF80uyMz3k8z+GoC3+vIXnRo8887S0s2NC5wPM80+7v
         zeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvY7E5x3j653cROdVTobYIoHh6VgZOd54qi3mF3LDVQfmm5+mlr5yjq3+RNb4BXsiV3VcVpOBwE6iyuBPF@vger.kernel.org
X-Gm-Message-State: AOJu0YwmlFuQsK/jZfPwkyPFATCfNF5muJFpcrUslVp211pnV/B67gFZ
	GCkj5aFu1HtJ2zGhA9/U23790gbr1ZGyGfX/ta4c7BbLuObNmCmh9GZBTBaGkC9vaayJ48ohrRC
	OJUy8Kl8pXNNdzCNgwbjad5qvCnQecRJGEWsbfyXSN5ookWZrdkj2DpS476ZB9zq5Jz8=
X-Gm-Gg: ASbGncvCKH70Z1dWw6gb1lmsYXCNdI5FB+a1omIklJtX/bCp6mZBH211BA2xaJrx6Su
	lSDPlc2Tj/7cfcEAQLttkgBpHSl5X6iSdsj67U2XsO7hffDZTJMWBEve7C6ypXupLcy5fH2ac1n
	akWTLkzS0c6eKmJsQKKOwx4WPaNm6RW9OdGlBi3tHdkVvt0r8TDprGq4BbOL/y+qSp5auyAOvH7
	iFHTCnz4XdJ03YPMRfYbCXd91ERrI3vnGKaim2L83A2+Kll5IDBLVCij2RlWArUOcKc+1PTPVBU
	M1E8kGDB9uFrBtati5ts6gseIMZqFh2toCYVWlszOMHD0d/xX02vEtJgK0WwsoO0iNB8XyPTnbM
	17RxyvRBR6rmwVKF6Nc+5rIfs9O4wSGQeQ35IUPo=
X-Received: by 2002:a05:600c:1d96:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-442fd60b8ccmr144678875e9.7.1747732513121;
        Tue, 20 May 2025 02:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDGYnKAtYaTtcjuvMXr+O7qtxRfqAO3w9ORzRc+8Vi6r9F/kkDXnoXTRmpornrqmt65GhM8g==
X-Received: by 2002:a05:600c:1d96:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-442fd60b8ccmr144678175e9.7.1747732512693;
        Tue, 20 May 2025 02:15:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f16:e400:525a:df91:1f90:a6a8? (p200300d82f16e400525adf911f90a6a8.dip0.t-ipconnect.de. [2003:d8:2f16:e400:525a:df91:1f90:a6a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f18251c7sm23400405e9.3.2025.05.20.02.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:15:12 -0700 (PDT)
Message-ID: <b4fa1720-a7f5-48cc-bff0-5400b989d44d@redhat.com>
Date: Tue, 20 May 2025 11:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/27] mm: VM_SHADOW_STACK definition for riscv
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
 Zong Li <zong.li@sifive.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
 <20250502-v5_user_cfi_series-v15-1-914966471885@rivosinc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250502-v5_user_cfi_series-v15-1-914966471885@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.05.25 01:30, Deepak Gupta wrote:
> VM_HIGH_ARCH_5 is used for riscv
> 
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---


  Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


