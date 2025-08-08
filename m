Return-Path: <linux-fsdevel+bounces-57041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBE4B1E455
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 10:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7138621661
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BE325DB1A;
	Fri,  8 Aug 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cvPx8n4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B8A25A34F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641402; cv=none; b=o+lEaktEoyIlrk6JRLnnaEFZEe14CuZAfAMHi2w5/pCbBkalcnfcON1E/ciVIVmueAJfu7Qk+hl4aA1QW6AUXPLogkSscsszodPyK3JOlmSv+84nuLrvbvfmknP1I4vfB3G40rZZMcvSZwrNo7I2e0EL6gH1GofFrGvtK8WLji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641402; c=relaxed/simple;
	bh=bsh/7R5V9XNvtRBgbRptJnuST96CsEj614d/3uw/SME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAAXwt44sO7b4BiDa5fD+tzTReKJGvn+6Vn2FBlG1sh8dPp2+CeHFj4X/UXlt3msqj4xAn1QXAD0AeqNc2HtwUQDnEtIw4V5506XI5XAJfYUhzvM/7DURhOrjaabvaiPxksG5hY4u90peRuxM7FTw2J9/nGsV+ffsfJh6R4w18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cvPx8n4T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2406fe901c4so12368845ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754641399; x=1755246199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqclBjlpReb8Zh2xzaAy1Tthw4Ak4Apujt4wspR+yjo=;
        b=cvPx8n4Ts3zqRUY2xG6AtHoEFC+hNzZ5gHKFw2TMNfy3bMZrzR2d8hpL+kqLbwSmYR
         WQt08ukI6iwh0c7HnzBCxequGbVbH3ag+m2JMvUnAqXZzmRxkDtRxIacrlNlCyXthOUH
         IgzoduBNZj2S3jD5DSUfLv/zUJPROXyNTcLEU5meK8kRSXnpt9FYN8vypJKpbls9GeYI
         JWhE/0YwY8hwXhJggsRr8VCuj9vpNEERGnUvxPn5WjXqo0915MLiSCeLVHUdpmlKIZV7
         vzHWIsMCoZDofevhvGraylyWzfrqJd+KwOaoQU11M1rDPanciQKQbvHVUHKgHOex1zgP
         WGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754641399; x=1755246199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqclBjlpReb8Zh2xzaAy1Tthw4Ak4Apujt4wspR+yjo=;
        b=FOiki6V5fqDVNd9qDp7MW1l8x5JH2CIoN6KsYEbTdlGnzn5W3iNTcB3sqGWoT2ahIZ
         0N74HmROIzvgWmNIogUIwOm8CQFIAfgzKbvrZ8rw953Q7EbGg1CmPvdkqIeXpg3N0wrN
         2FteG8nB48lIulItb6DcAxrP07JtLsBIKIVDM58ETe58At3TYnYxc0RjI9+8ZU03H8jH
         4XeYcEmbCqS9ShIA+DXZQtNrvCAAYN+eDiqe3PxMXQGjYF+A06EBoN21Qpuy9P+pdMRs
         zazKSiiODauLyAEDpyzOuFH3bmNOMc69KBfyAiFgug4mjEXxXfsgph32O5kFQ4OspY4o
         NYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9m4K+DsOF+BCmEoHmaW5mw4vHLcV6h258dzdMjLd+rcyl1QEYjVEijzz89/IUowNNHrb3BNuuMb0mQoki@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FIsMDrZ8Tv2853mhMCIR000aD6CV0wRquLrTK5/CKlH6VVRX
	Qz42g9ZCTcuw7toKNUMNWcwZvy6aNNm3Twvrs79ow67XxYhxl3LanyMZWhRhyd1xZ7s=
X-Gm-Gg: ASbGnctHHLYVXNJT6BKerYk2dHOu1NfsXaMGrXBhFqfDtL0KLuA0Iri9RwWnpgxCc2B
	GkQk1GY8c48czqOXY/76vvxRI/8aVr8jHNkDRvr8iTqam2N9skXnjXB8T2FO4ENQQHRRqZevZyt
	LhtWsKBeGRpiSjzHNpk0ysc7QKIDfHx/Mpqw46H+FMWeZOc5flRZmCiCoH6qP3Ca6SizqwOTtvS
	6iqAF7y2C9ixfZtd9Tnhd1KVRvfJgRm2S3og0JJ0SrAldlsxu77CsFej+3QRFOIVPXeWjLsjoVT
	DYaSIqdCAouvpe/G1Sl03Bk94Kmr1QJwWsEeOfFrw+AeGE3Ujbbh49e1AtBhIjfpYSDgNWuuDW2
	+C1rkyZIjzK6hJDNEktkSVSIxCDwuyhIXM+ieWRhmY4c=
X-Google-Smtp-Source: AGHT+IFzkjQpJ+CBSP5FDKaUMlIyJFyzXkrgnGdlTX6xXb/Zh2Ht/mDaf4SC0H4gKEAF5ZgXVLVJMA==
X-Received: by 2002:a17:903:1207:b0:23f:f6ca:6a3 with SMTP id d9443c01a7336-242c2245139mr30852795ad.43.1754641399054;
        Fri, 08 Aug 2025 01:23:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5934sm202807465ad.21.2025.08.08.01.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:23:18 -0700 (PDT)
Date: Fri, 8 Aug 2025 01:23:15 -0700
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
Message-ID: <aJWz82F21pVTSVJi@debug.ba.rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
 <175450053775.2863135.11568399057706626223.git-patchwork-notify@kernel.org>
 <db4eb976-693c-426c-a867-66cadd3dd7d8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <db4eb976-693c-426c-a867-66cadd3dd7d8@sirena.org.uk>

On Thu, Aug 07, 2025 at 01:28:36PM +0100, Mark Brown wrote:
>On Wed, Aug 06, 2025 at 05:15:37PM +0000, patchwork-bot+linux-riscv@kernel.org wrote:
>
>> This series was applied to riscv/linux.git (for-next)
>> by Alexandre Ghiti <alexghiti@rivosinc.com>:
>
>>   - [v19,11/27] riscv/shstk: If needed allocate a new shadow stack on clone
>>     https://git.kernel.org/riscv/c/9c72a71321a6
>>   - [v19,12/27] riscv: Implements arch agnostic shadow stack prctls
>>     https://git.kernel.org/riscv/c/52eff0ab5f8e
>
>Congratulations Deepak!  

Thank you. Happy that its going in.

> Do you have an update for my clone3() shadow
No I don't.

>stack series that I could roll in for when I repost that after the merge
>window, and/or instructions for how to run this stuff for RISC-V on some
>emulated platform?
I would want to write-up instructions. But I don't want you to go through
a lot of hassle of building toolchain and bunch of other stuff.
Let me see how I can make it easy for you. Will report back.

-Deepak



