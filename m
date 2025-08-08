Return-Path: <linux-fsdevel+bounces-57116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6858B1EDB6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FCDA0676D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107621C1F12;
	Fri,  8 Aug 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="a8M63Uui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F21B423B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673624; cv=none; b=ig7bceRnNaJK6fugvVu6hEO4uJ/yBViCa1xYeaNIIc6XD36mzjbwjHE4ymWScQKGNlKW7XKDBx9VUxRvmdJvgZm8eME9w/jfV3YkIvaGHlZ+VXww7K8kUvYcuQb1WnJL09VJT7mUpjFB9EK4dSx0McLx6LevOXlelvcsb8zMqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673624; c=relaxed/simple;
	bh=RqNZJ9llYxg5119nPvsoAte+UupsM8m84wjkhwHB7S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akQopT3CYypvUdr6fx45yPHla2Tz0LBpbnBjXuTp0/PX8jYuGRMMaWXGtHit7GSfIjjGIC1p7Y1oE8mXzGlSYCE2TjryIob7Lwp76EdlVx8GNzA8veN3Fdb2ryiEd6lYsoqM0LtlCpsceneEu7OWVU7FIRxdYC+sK3Bm/j2FttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=a8M63Uui; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so1606885a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754673622; x=1755278422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5KtmNZscqY46KvhQCHs24ev6RrXWd+1XTPfyk6qu6o=;
        b=a8M63UuieKcX26TzVIbNSA88Yn2tSAaxOYC3qXip6DTpLgrn22RYAPzvTl7GC4X9n7
         z/MTSt5RmjktrSErLR5LGgZ5yeeSVtDdy7r2tM2Vu46CreMC2xvBV/xJ4kk/9gTLtBME
         XD6iQ6/bTVbnM06BTpJ3Wqoamucgcv6vA+OIF0+0vPh9mB6sBnKW8qCfSS5KlftSo3az
         WCQrHVGt76H8CJWQDS7PnRtch2s5ptTFKFYwdOWhLRTPtvqtNEO2M2/DWyUucdKdhrXG
         PfX0jt+/QtWvkyBjDFhL2MK1WtIdbK19Ej4ghyPEM4jpSiVz2OOVtdPLEqDkQS/C0a4r
         xzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754673622; x=1755278422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5KtmNZscqY46KvhQCHs24ev6RrXWd+1XTPfyk6qu6o=;
        b=Oe70i0KUUwq0ASteQXTRKUfPNFuQL5h5hky7r2j/aO+8vBRDudXUCpixXJpjwajfr+
         Hof9WVL196dwSu7WgmwCBpx3o6qrPUUknELg2qd3vTQwbXW2Vp1UGWU4WVyXQs2bw4e3
         Dja8j+RLkfXGJvgnfqC6i/ty1oGDxo9mQ/UItTmRp+FQalKtnzcT82sSUp09igAD4aRI
         w15R4j1humDzXPClzA5rAlFdtXRN6kF4pTeeRt27HhmBwQBNoj9xXsUi/p2/hNGGdPZ6
         angH/CazbKxO4n2fiK058xqR5Q5dAsXd0Klfo9v/xpRxPJ3XE5dsBHdz6UyCkOT+8LRA
         qF2A==
X-Forwarded-Encrypted: i=1; AJvYcCVcKM5d4agkMeVuOZu7Bw/3r9eqNgwku4FrVGxCxefR2Kv6KLfk1rhISRgj4BDsCEi4/5e+F8p72KEnkmJD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rXR+8QDYX+82mOljD+gWbzFywwQRM7n93frAwZIPCoC6JX5A
	EyB0YRfPzCNIBt5NcVKbLR5qgXhy+UehEvkNSiv4QO38OnZKiml+LkwsFl1uCJMOKVw=
X-Gm-Gg: ASbGnctFKuFodeDxsvhHnnWRiuBYCuAqDq0LnYe3HNRkzWZXChbh6nwID2CI3U+Yr8L
	PATWJHvX9kGFPr7ignpdi4r6vd06y/ncZ6tbDqxpvxykM4btAL6+aLM01idl7rKvpdW6hLyqUgG
	36dqhUjLKX5xmtfrWxqNPQIB873oF6pY4ogWVZycpsHqZ9HJnL4BZLthItXIROXcxTjKAqIuwdX
	Z8/rwan188w9qz7vLpOqTR7ITbQKxTtm9v5wuwKqhmegtCSV/LWLg89SF97eTzTPXFZALcI0Ece
	TiyAQbKrDCMpPyaKxzqtHeXObMMtbo9eNX4p3377CH2rT1ZLr8SxjajXF4z1TsqIe/Q9/PCuxnY
	IbA+Tj+DqiECpFpJeCOLf3NYg1nmxdtk1V7JFjf+f9d0=
X-Google-Smtp-Source: AGHT+IEbXOfCcMMF+EKLeMi8xU3SNI8Lg4qkWBu83GI5zB4sNqf//XXj2WJssysLa22zlDPxSEkl6g==
X-Received: by 2002:a17:902:da82:b0:240:c678:c1ee with SMTP id d9443c01a7336-242c1ffb211mr57743355ad.11.1754673622272;
        Fri, 08 Aug 2025 10:20:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa77sm213263625ad.174.2025.08.08.10.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 10:20:21 -0700 (PDT)
Date: Fri, 8 Aug 2025 10:20:17 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: patchwork-bot+linux-riscv@kernel.org, linux-riscv@lists.infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
	brauner@kernel.org, peterz@infradead.org, oleg@redhat.com,
	ebiederm@xmission.com, kees@kernel.org, corbet@lwn.net,
	shuah@kernel.org, jannh@google.com, conor+dt@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, lossin@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	zong.li@sifive.com, david@redhat.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aJYx0Yi3rQcdY6se@debug.ba.rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
 <175450053775.2863135.11568399057706626223.git-patchwork-notify@kernel.org>
 <db4eb976-693c-426c-a867-66cadd3dd7d8@sirena.org.uk>
 <aJWz82F21pVTSVJi@debug.ba.rivosinc.com>
 <09081487-89ac-4f8d-b9fc-e563f09726d2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <09081487-89ac-4f8d-b9fc-e563f09726d2@sirena.org.uk>

On Fri, Aug 08, 2025 at 12:48:31PM +0100, Mark Brown wrote:
>On Fri, Aug 08, 2025 at 01:23:15AM -0700, Deepak Gupta wrote:
>> On Thu, Aug 07, 2025 at 01:28:36PM +0100, Mark Brown wrote:
>
>> > Do you have an update for my clone3() shadow
>
>> No I don't.
>
>> > stack series that I could roll in for when I repost that after the merge
>> > window, and/or instructions for how to run this stuff for RISC-V on some
>> > emulated platform?
>
>> I would want to write-up instructions. But I don't want you to go through
>> a lot of hassle of building toolchain and bunch of other stuff.
>> Let me see how I can make it easy for you. Will report back.
>
>Thanks.  FWIW I should already be sorted for the kernel build, unless
>there's a super new or specialist toolchain required for this feature

Unlike x86 shadow stack and arm's GCS, push on RISC-V shadow stack is done
using dedicated `sspush` instruction and pop is done using instruction
`sspopchk`. RISC-V vDSO has certain `C` files and they would need shadow stack
push and pop (along with landing pad on them). So that's why kernel compile
would require the toolchain. I'll point you to it.

>(I'd guess I should be fine for the shadow stacks bit?) - it's userspace
>and emulation for the extension I'm missing.

Qemu changes are upstream. I'll provide the command line option.
On userspace, I'll point you to something pre-compiled rootfs.



