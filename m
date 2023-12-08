Return-Path: <linux-fsdevel+bounces-5375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA6C80AE67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D491F21360
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B93250259;
	Fri,  8 Dec 2023 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PRTW3BZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543E19AA
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 12:57:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0a5422c80so22383195ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 12:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702069059; x=1702673859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tys/vW6TJrvqB1xe5pT6Lgn/PsDKvZ4BwsQlECLsYBs=;
        b=PRTW3BZCfbXCMbIbbjF0R2L8LA7Rn1g9VuJIVK5dZwH/WiNsRPjf/4jsvdnNXVJdlw
         eNquk2M244ZrHbTzsS4ZDV/0qCadMIZXIQb9drDLfvjfeJ9jDxh2MrcbC9awGCXYKjqY
         RpjbVGc0c8Ssr9nw3Nf55/N4DPq1EuKooGaf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069059; x=1702673859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tys/vW6TJrvqB1xe5pT6Lgn/PsDKvZ4BwsQlECLsYBs=;
        b=VSlb8pR2jQYsGO43dqPM1Jr3/UU/3X09jfbiiiR92QfzIUm4u33rNNdnQPZdLvzDa1
         nBCMHe0VjEEtSc4iiVirEmVJowBw/4cy+zW2na9/od6QR5r6iJPOGHHtmc4Jm+oljy8l
         6xSAF4z3f1VjlRSth+PxSqqQfJnka3ZWtPaWhiZPRTLs5tBFyadZ3WrvtgtBle4y3XI4
         ckAwa2YK+M/FqbzlgahdB8emmsy1JELH4JxHQ6zp8IzuLqYUJGbTVMp6DZsqakYlDfG0
         weUqdZVsZwW3TkoHLVLb+ZU4LwAcaKnyLFa87A5uMjBG7YwMC2ScDajQ+0srv7zGiSVP
         MaRg==
X-Gm-Message-State: AOJu0YztOjOnWBsHeUiJT2FPHkjfLntv58eFpAFu75NUqAAE0IdEaxWT
	m35hCHArZ5raKpfpvfc+s9qD3w==
X-Google-Smtp-Source: AGHT+IGBI3DTSz3M2P/N3EoKLc20ALho3WNNQ9FkBDmD8W5/Jq1bLWYaPm1D7IkQUUnQMxuOVi4Hng==
X-Received: by 2002:a17:903:2585:b0:1d0:6ffe:9f1 with SMTP id jb5-20020a170903258500b001d06ffe09f1mr611230plb.79.1702069059024;
        Fri, 08 Dec 2023 12:57:39 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d0511c990csm2131874plo.237.2023.12.08.12.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:57:38 -0800 (PST)
Date: Fri, 8 Dec 2023 12:57:38 -0800
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <202312081251.A5D363C0@keescook>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <20231206123402.GE30174@noisy.programming.kicks-ass.net>
 <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
 <20231206134041.GG30174@noisy.programming.kicks-ass.net>
 <CANiq72kK97fxTddrL+Uu2JSah4nND=q_VbJ76-Rdc-R-Kijszw@mail.gmail.com>
 <20231208165702.GI28727@noisy.programming.kicks-ass.net>
 <202312080947.674CD2DC7@keescook>
 <20231208204501.GJ28727@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208204501.GJ28727@noisy.programming.kicks-ass.net>

On Fri, Dec 08, 2023 at 09:45:01PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 08, 2023 at 10:18:47AM -0800, Kees Cook wrote:
> 
> > Even if we look at the prerequisites for mounting an attack here, we've
> > already got things in place to help mitigate arbitrary code execution
> > (KCFI, BTI, etc). Nothing is perfect, but speculation gadgets are
> > pretty far down on the list of concerns, IMO. We have no real x86 ROP
> > defense right now in the kernel, so that's a much lower hanging fruit
> > for attackers.
> 
> Supervisor shadow stacks, as they exist today, just can't work on Linux.

Yeah, totally agreed. I still wonder if we can extend KCFI to cover
return paths (i.e. emitting cookies for return destinations and doing
pre-return cookie checking for return destinations).

> Should get fixed with FRED, but yeah, this is all somewhat unfortunate.

Agreed.

> > As another comparison, on x86 there are so many direct execution gadgets
> > present in middle-of-instruction code patterns that worrying about a
> > speculation gadget seems silly to me.
> 
> FineIBT (or even IBT) limits the middle of function gadgets
> significantly.

Right -- for indirect calls we are at least able to restrict to
same-prototype (KCFI) or "actual function" (IBT).

Regardless, for the case at hand, it seems like the Rust wrappers are
still not "reachable" since we do BTB stuffing to defang these kinds of
speculation gadgets.

-Kees

-- 
Kees Cook

