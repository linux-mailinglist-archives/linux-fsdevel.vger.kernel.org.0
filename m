Return-Path: <linux-fsdevel+bounces-15476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C2488F076
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 21:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCAB1F2FD06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F042153503;
	Wed, 27 Mar 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WujNYFpC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1A1534F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572388; cv=none; b=YRF5oZoNapbdEUSWEMnx9fxr1t9xbdQ4xil26q/riG7rQZigFkizQz7zMHE37bz+Fec4j0GGPpkZh3iZleje8qgfbwo67oVfq6vYCzyisFNd4J72/uoAtZ66znGfRsizrL5giqkH8dG/xTNwxsnk1ka+2AzJv9loUC+MDb+0hHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572388; c=relaxed/simple;
	bh=RuCWKtbRzqJIEwrREMPn1YstKGaBmUG9LovdmLij8Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xvz3EvLdvtQV7Ncb1SZshSPFApzydZUFGFk+Hwxr/0EPWL/Y3gcayuGj1VrCKclDIIyJ7zbnEpObSyOW8GA+N0CtMQadP2hToXMyrNhRoAE0GDDvKoPs0mJkfbyDGH9SJ5x2LR/XXLCkh6WROrf/AaySaGwsYNYZHc7E+RvW+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WujNYFpC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d4515ec3aaso2363931fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711572384; x=1712177184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MmaskrdbVq30uGRTY87iYuCKuy48OuaJH0qBlabGSIs=;
        b=WujNYFpCVGty29BpRuw+e8G3DS8x7xuCd7pLX3Pw7czMhH+do/tOJ0d4MulwXLe+BS
         0fxWqjQ9KDA6JnUWawBUt7b3F+aC8EWZMqUrSze5dBeteKKcrGMOG4HWGcKCo7w7i6d9
         LBd9K4jtnBBHFnkAiLYI5eyGlZujk+e895Ajg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711572384; x=1712177184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmaskrdbVq30uGRTY87iYuCKuy48OuaJH0qBlabGSIs=;
        b=ZkHuy45H1saWPHWliPWN8JhUNqjD5hmHukfuHLmXTG0mHgzKWMtUv6DgR2sKdEMiNq
         uTHsDea0PA44dgLpLkZ6TToelQIW4unb8d4H0usL10E5vORdae0I6XNv4cI7qIl5YL9K
         OEtfRzn6SiWDLHJqO+LfiO0GYcH3Q8doQ6vHjC8KwJ/R943KAz16B43iHN6DY8yyRgRG
         9UAG+0BpDpgLnHtpfQngy8CYDIVdb6XIBxmKXHFoZ/Xq3hIeAET0UgAWG828CsVRwJ+r
         EiUienX82Gy7CokMSgMzIHHOrPv39b/gnTFhFMuB2ru5yaqZFR7vmWWZIiNBmyT+w0dR
         0atg==
X-Forwarded-Encrypted: i=1; AJvYcCVKigCbdpZMuRCiIPvlPjrR99PXYBsgb+0U1l2BoAVylWNySM2WQshKztA+g4ZBdJoUi7IWM7cJJ9mIlTALKyKuRw4g7p69LD0jFlm1GQ==
X-Gm-Message-State: AOJu0YxiBLM1WrYKwYO0L1KSfKVLYaubaxLmRZ8N/CiUTThTInlUdWhg
	mh8fnNRAMD+JTZChLFO5AEZfYPfAhIDYUspE75NkVtIV4HhpfQ47MnhxRIfzGX5BvwY2Kgw70Kv
	4kVMprg==
X-Google-Smtp-Source: AGHT+IE4jSm//IVo2bIKVvi5lxORm3c3+JnqCfjq7TAOydk6Aba/Vg4Fcdpw0fcoKslGWZ9vZRffnA==
X-Received: by 2002:a2e:9044:0:b0:2d6:c02a:6c37 with SMTP id n4-20020a2e9044000000b002d6c02a6c37mr103903ljg.7.1711572384235;
        Wed, 27 Mar 2024 13:46:24 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b8-20020a05651c032800b002d6df0714b3sm868338ljp.3.2024.03.27.13.46.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:46:23 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-514ba4e5640so1269448e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 13:46:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQNLc/lTnUn/9aXzgQH3eijW++/gMFqrjaUXfXORxini7rWwOQJnzM4I/w6zVkEC2OMJE12xM+pFw/r/UdbjyGiFLQR5iH3DAzUZKSFg==
X-Received: by 2002:a17:906:ca59:b0:a45:40e4:8c8 with SMTP id
 jx25-20020a170906ca5900b00a4540e408c8mr355615ejb.16.1711572362918; Wed, 27
 Mar 2024 13:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey> <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com> <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com> <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
In-Reply-To: <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 13:45:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com>
Message-ID: <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: comex <comexk@gmail.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
	Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 12:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> _But_: the lack of any aliasing guarantees means that writing through
> any pointer can invalidate practically anything, and this is a real
> problem.

It's actually much less of a problem than you make it out to be.

A lot of common aliasing information is statically visible (offsets
off the same struct pointer etc).

The big problems tend to be

 (a) old in-order hardware that really wants the compiler to schedule
memory operations

 (b) vectorization and HPC

and honestly, (a) is irrelevant, and (b) is where 'restrict' and
actual real vector extensions come in. In fact, the type-based
aliasing often doesn't help (because you have arrays of the same FP
types), and so you really just need to tell the compiler that your
arrays are disjoint.

Yes, yes, possible aliasing means that the compiler won't generate
nice-looking code in many situations and will end up reloading values
from memory etc.

AND NONE OF THAT MATTERS IN REALITY.

Performance issues to a close approximation come from cache misses and
branch mispredicts. The aliasing issue just isn't the horrendous issue
people claim it is. It's most *definitely* not worth the absolute
garbage that is C type-based aliasing.

And yes, I do think it might be nice to have a nicer 'restrict' model,
because yes, I look at the generated asm and I see the silly code
generation too. But describing aliasing sanely in general is just hard
(both for humans _and_ for some sane machine interface), and it's very
very seldom worth the pain.

            Linus

