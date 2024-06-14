Return-Path: <linux-fsdevel+bounces-21722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01067909351
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 22:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7107B1F24841
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A496184130;
	Fri, 14 Jun 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIg8yIK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806D8145B34;
	Fri, 14 Jun 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718396416; cv=none; b=dxXch9Tjg+/ViMl0nzKB87/csECfGmnlgE6AnUplrzQj1N9NSZK/a7fAGdL+np8nAxlpugev7UHOboL0rnscMMYrZln4LuHtLQevT+kpiZRk0jOVDiGZiaKshD5FDWOoFQwYA+oU5JdlmjTZ6vQbNJyt97NrkykxbfZ78v2Ny+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718396416; c=relaxed/simple;
	bh=SL3LXdGpVn93N29tSyCl+OiuXnNiv14zHiXAfmhinnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7ozrrxYX1nWRQzVpASTNLR04Ikmrd/zbI80/8z6sFsvI/+yjpQ5hSDTxGgGpfr1ghslzueLOyb4g7y5iVrM94wVcnkE2tAPNQ80/C25c277YiPkxhmn+uon/NhHLmAqX30XpURhOUXmvjU9gXCT8XdrMKkFGUef0K/tskg2kEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIg8yIK1; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48c390a1054so998931137.0;
        Fri, 14 Jun 2024 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718396413; x=1719001213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CUAuynBVyz1fHYaZykoo5xpEFYTJwiFVf5avH/YD40=;
        b=gIg8yIK115uTTUk6Knl8X4yYT3ORsqGyRqxJzfuSilSPvo2KFCKHg0cqx34R/X99Kg
         wpGPpT5oOhUBGRY1UP5yOuLIRIU+p2JEgBjXaZO9oIBTVazF7Mv6K3jrWxINr5rCDBJH
         85lmarozL1wlH6Nr1fRsoZwXZrGcGq/fYjk8Zl4OWdz/Ai1+rhlQGeLxeQ/kizMTbGB7
         ZnNN94slUpGhzjRjxXLpJvAOds6lAI1C6M8iQXz8b0Ji57vEePKGDB+qsUSSAoiCSyqs
         dHESC9NVI7zlFqf20TvTWCcT8OhUPm3uip+iTTQvfhu+8xWjSUVoV45/wKF6ATyUZ8u+
         25fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718396413; x=1719001213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CUAuynBVyz1fHYaZykoo5xpEFYTJwiFVf5avH/YD40=;
        b=L62D5aZ7KBIZFiiNGTilcy+dAvkXNrX/DvMCX7vSJEyoyj7ZvkyCzRE47zTB0Rv5Ph
         ujMtN6lAPGBIm84RUx1AlVBSfKD9GNpeZy5xKaFlM9tmc6BfGVmnvJBVFnzlHi66yvhO
         bYi6aUwYQj6DqgK1Sh87jPqVT53LmU34vu8MOEJc6xnmbx+PMGX0Eay11cXnceNOPDb8
         RvI2MOKaU+NVok+l0X+53D7C6Jp9fa6vQOYav6C5wuqxZJ3H02utkPHLuPysaZ57OwxZ
         IRBbL+1Avm02JGVX9XLhy/1OrDbFK+IPPMXJRQYVa44MrODWIvYb/tIeFt8DSYLjZBKD
         hKag==
X-Forwarded-Encrypted: i=1; AJvYcCU4SbKGQdm1XXFpDz92bpqjINc4uAaqlZf5Teb3V7JKEZU3sao0GTSUcS262vv5eqVGr6N76tlZ9fLRwYGzTfuATix9rgeH7DeJvgAetXwiSaKjQwlcaMEUg7CxYmBTBCq9e0PpLVC4iSsRqaBM/czTtKa9WFlx06Yx6bZ8dTrDl8a4aUVxAzw=
X-Gm-Message-State: AOJu0Yz8p6PS2s6I4owtyaP6fdhpODAl3tSbwHPbIdI390ZEsulgoTGk
	nU/P4e5wCCkkmnaIR1HYQ7LFoJp76LkKH2RnZc7Q20yTXd1Xp+bT
X-Google-Smtp-Source: AGHT+IHeZPt+coJs0UUjzvIRyH7KLBAHbOKzSy3UT6stagMTqVFlSqoIJw6X4dKYtBRry1sNMWpzuw==
X-Received: by 2002:a67:e249:0:b0:48d:9792:5bfe with SMTP id ada2fe7eead31-48dae34a5b9mr4308573137.16.1718396413309;
        Fri, 14 Jun 2024 13:20:13 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe69dffsm176912385a.126.2024.06.14.13.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 13:20:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id D8BE1120006C;
	Fri, 14 Jun 2024 16:20:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 14 Jun 2024 16:20:10 -0400
X-ME-Sender: <xms:-qVsZn4233Bg4h8CYciH-FYwf6Gd12xjqfEGsTdjl6QA5jiAcw4ReQ>
    <xme:-qVsZs6DHWLHgvPwKH4wyGRTfgSw01mIhxwTBlTIOJkXTp3HWoLZV6KFbALJxxSMK
    t1BbeXfZ5y4dvV26Q>
X-ME-Received: <xmr:-qVsZueKRGiocyoZPU9yTmkb-TzOXfOx9x7K3UtbwfYZTdsWmddqC-r9yBoD9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduledgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:-qVsZoIa0p0SKpKTSsAdGKByO2AuK-qzOcW7xWgZLMx3YekiPfSWaA>
    <xmx:-qVsZrLZYV6LKYERiZtQkYoB6vb1NFvDsznJ78aIyxbfmnzIfp1Juw>
    <xmx:-qVsZhw5PqYPcfLuoSIZmOxvOfNIIe3xQJU3vf0n6hkYt2nxA0ftpg>
    <xmx:-qVsZnIKOxAH2U6xyQmhe7kWJruyFTswUX4up4tIPdDPv0C96gCLOQ>
    <xmx:-qVsZmarTnrWkXSGtpILPx652VtRHGbOAmhFWRu-w1s9q7OeOT1evxcf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 16:20:08 -0400 (EDT)
Date: Fri, 14 Jun 2024 13:20:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
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
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
 Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <Zmyl9OHjIarJIIYi@boqun-archlinux>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
 <ZmweL12SL7Unlfpe@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmweL12SL7Unlfpe@J2N7QTR9R3.cambridge.arm.com>

On Fri, Jun 14, 2024 at 11:40:47AM +0100, Mark Rutland wrote:
[...]
> > +#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, ty, int, raw, arg...)
> > +gen_proto_order_variant()
> > +{
> > +	local meta="$1"; shift
> > +	local pfx="$1"; shift
> > +	local name="$1"; shift
> > +	local sfx="$1"; shift
> > +	local order="$1"; shift
> > +	local atomic="$1"; shift
> > +	local ty="$1"; shift
> > +	local int="$1"; shift
> > +	local raw="$1"; shift
> > +
> > +	local fn_name="${raw}${pfx}${name}${sfx}${order}"
> > +	local atomicname="${raw}${atomic}_${pfx}${name}${sfx}${order}"
> > +
> > +	local ret="$(gen_ret_type "${meta}" "${int}")"
> > +	local params="$(gen_params "${int}" $@)"
> > +	local args="$(gen_args "$@")"
> > +	local retstmt="$(gen_ret_stmt "${meta}")"
> > +
> > +cat <<EOF
> > +    /// See \`${atomicname}\`.
> > +    #[inline(always)]
> > +    pub fn ${fn_name}(&self${params}) ${ret}{
> > +        // SAFETY:\`self.0.get()\` is a valid pointer.
> > +        unsafe {
> > +            ${retstmt}${atomicname}(${args});
> > +        }
> > +    }
> > +EOF
> > +}
> 
> AFAICT the 'ty' argument (AtomicI32/AtomicI64) isn't used and can be
> removed.
> 

Good catch.

> Likewise for 'raw'.
> 
> > +
> > +cat << EOF
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Generated by $0
> > +//! DO NOT MODIFY THIS FILE DIRECTLY
> > +
> > +use super::*;
> > +use crate::bindings::*;
> > +
> > +impl AtomicI32 {
> > +EOF
> > +
> > +grep '^[a-z]' "$1" | while read name meta args; do
> > +	gen_proto "${meta}" "${name}" "atomic" "AtomicI32" "i32" "" ${args}
> 
> With 'ty' and 'raw' gone, this'd be:
> 
> 	gen_proto "${meta}" "${name}" "atomic" "i32" ${args}
> 
> > +done
> > +
> > +cat << EOF
> > +}
> > +
> > +impl AtomicI64 {
> > +EOF
> > +
> > +grep '^[a-z]' "$1" | while read name meta args; do
> > +	gen_proto "${meta}" "${name}" "atomic64" "AtomicI64" "i64" "" ${args}
> 
> With 'ty' and 'raw' gone, this'd be:
> 
> 	gen_proto "${meta}" "${name}" "atomic64" "i64" ${args}
> 

All fixed locally, thanks!

Regards,
Boqun

> Mark.
> 
> > +done
> > +
> > +cat << EOF
> > +}
> > +
> > +EOF
> > -- 
> > 2.45.2
> > 

