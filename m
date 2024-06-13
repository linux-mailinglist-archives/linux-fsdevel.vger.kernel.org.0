Return-Path: <linux-fsdevel+bounces-21674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4352B907D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 22:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FE61F24EAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3213A275;
	Thu, 13 Jun 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTte/A1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A983A12;
	Thu, 13 Jun 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310337; cv=none; b=Nra0SlQRLm1e2JUncEVMW4wPtSjv3hos5mGWgw2oOlsOv+tq6QNxIC9UJrRfCDUTLIa9omgLzPbphPE0m2iNS+3CXYyVYbuVbi2GdpTuhD3ro4wW7rbH91Z5moBP1Jj32nZeW7ecP3WhFIiSnqefiB4ADmHndcmSwb9LAmNSWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310337; c=relaxed/simple;
	bh=XZMnBPtlkifS5Fdca+gG4KAFlQ4eMVf6o5s14uxWoGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMIz51rIJsW1wc842ilQC2XWhtzODoMVdemf9+96S9VzGFxz3jBTF+/U5t/sNNuWjQi+U5zd4C6onGsQ5Kw3Vc1euuh3ZvRD9BjTWBluopRw+IAbX33oVbYlvtcxx4HDpSu0PGpu07wbviLFmuwT5wK8zw91NhOdkLZUejd78EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTte/A1u; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7955c585af0so101523585a.2;
        Thu, 13 Jun 2024 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310335; x=1718915135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMz0ZFRHVHUChYlldLB+9O1uGefbqiAdPKIID9/kO3c=;
        b=XTte/A1ur7U4yPV8CpLWuoJfbuWjv0eH6hAe0zuYkJjv+CQXcsMliBV+kzJFAjm4eO
         6VdP6RjtHe1R2k80KPxR5xr3+9tXGDIxq/+IzSlyI7tWt/tLDJgDUT7Gb763ITIauxdn
         7kt0lyklucCd4jq5MV9JH7hiaepKdTGihH25qxPHmbU8XKsU3CvAJNV/cJcyJKPUbvLo
         DieUdtL1qet2oPhA/qG+KxCwBf4INgVKkG/Ar9FqAIgpiQVbCkQGDyXK9kS18fkIzIui
         ZJT0X8+I/tE30PCWdtHseqd6ikbtamxzWWdIX2BpcHjHKVYxTxcMvo/KOchmEY2BgBgQ
         ePMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310335; x=1718915135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMz0ZFRHVHUChYlldLB+9O1uGefbqiAdPKIID9/kO3c=;
        b=u7M+8EIVt+lxWSA6xdopu1lkKdXVE4eMXrUpvRu6oCYtRCr17GSPhecI8CiGRqLv42
         JdiNioVuUNgSXqa5Yf1hhLkxtJNs/xf6SmjL9mbaP3s5pG3ZqJbwWmaXCCHPcsVKB4N5
         n66jWjZfDjAF2rWL12hpFFa5mxUKOC+/mBzwS2V1DPK8AdTonPvCNVKFTQqHVdYeXziM
         qwg67QbrW4YMM4/Jum4juJ43BnyJT7e+kRSOmbi5+Ko1rwsN+UOU4gJ7k9qxcqb4vc39
         k76LMa6zAoIfOA7eFTk1DI5frfo2V0Z3O33W3+UP4JevKkACfrv4sLCrlYLdjKBXeG7/
         1rpA==
X-Forwarded-Encrypted: i=1; AJvYcCWhnf80OBNqZ/7DpRPleaLAVxJr5IDeIYgldyzxKwV1/rJap1Dc+RWHLGczKmG6MO5nxLSdsqXGA+WgQrtxq/mSgSJnXWDPKu3HlbSw1acyBH52u27Co1nTCix4p42s1Q5uy45cuCaluJ4p/OmqWlqrE0im8NxxJ539CHlO5skPYfyhH7mIFrg=
X-Gm-Message-State: AOJu0YwTH0Io9hr5Ir4dOnURrL777JdJzoMVc4heUjKgXkhVp0qmYLj8
	fLpiWz5z43Rr5Nxog3OuJXd0X07u2laGrgQja7UrXEd5GkJOchCf
X-Google-Smtp-Source: AGHT+IGpSoIULcvWez99JK7JK+Up8HU1l/s1FINDWZs8LC9tBJeQ3hxxZVJWnFEHKbk+02gDLzMs0Q==
X-Received: by 2002:a05:620a:4007:b0:797:e9f7:e924 with SMTP id af79cd13be357-798d26af852mr68059885a.65.1718310334648;
        Thu, 13 Jun 2024 13:25:34 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc468sm9379261cf.70.2024.06.13.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:25:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 283391200069;
	Thu, 13 Jun 2024 16:25:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 13 Jun 2024 16:25:33 -0400
X-ME-Sender: <xms:vFVrZgtyFF8uQGfrwFobOorS3vOPl_--u_9m9T3AhsbuxVq2xi72zw>
    <xme:vFVrZteMRM4PasZI_VHT9e2_LY__Y8z3ZnNYO3RfHb23AFY2Z913Tln8h8msbAnfB
    eYMqpyIJIRn0-XRBg>
X-ME-Received: <xmr:vFVrZrx5Tan5t4KnPFuuL5T2vPasCz-gKubfZx0xAmf_NUnPbp19npTIFsk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vVVrZjMpjzd4Kew3lRZR2cVcvzPaSrroXMn4v74PLBzfBsascPkW1Q>
    <xmx:vVVrZg8hQLget4rip9IgUQthGkKPjBxRow_6r2bsiNtYh8W7qBADYQ>
    <xmx:vVVrZrUpvA1qg1wcNJfzvK9OScd1f1tINnwbxniD6g1bzVvlFGZ-_w>
    <xmx:vVVrZpfxD8JRupYWW-fTnuQwYYUeIqAPuEbyfo7uRA5cNm_a5wxaeg>
    <xmx:vVVrZidUvKWatd8WUPO9_xQZFbBUTxfkOpnCNTkVq6SSFMg-qIW2TX_D>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 16:25:32 -0400 (EDT)
Date: Thu, 13 Jun 2024 13:25:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
 Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <ZmtVngqKZ0arLzL-@boqun-archlinux>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612223025.1158537-3-boqun.feng@gmail.com>

On Wed, Jun 12, 2024 at 03:30:25PM -0700, Boqun Feng wrote:
[...]
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 48e7029f1054..99e6e2b2867f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1601,6 +1601,8 @@ static bool
>  has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
>  {
>  	u64 val = read_scoped_sysreg(entry, scope);
> +	if (entry->capability == ARM64_HAS_LSE_ATOMICS)
> +		return false;
>  	return feature_matches(val, entry);
>  }
>  

Yeah, this part was mis-committed, will remove it in the next version.

Regards,
Boqun

[...]

