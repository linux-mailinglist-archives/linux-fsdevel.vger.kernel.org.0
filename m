Return-Path: <linux-fsdevel+bounces-5363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3480AC48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188CBB20A5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92E47A70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Srx7Lw7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAA798
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 10:18:48 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ceda123d4fso827503b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 10:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702059528; x=1702664328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xrT35L8MTIhLwpdhO3H/c+pqRQCxCg0MNTO7FGS/OpU=;
        b=Srx7Lw7dfmby6qUy+IUZE6TayrZzauBxi67HlNAZ31Q6wc6z9lGZzYS5WsHOkqYG0C
         7kamCrAc8j+ZwlcOzVOqSbsK2jeXX/4eSe6NzJfp8MHf18llAeSUKM/VPZ5G+6o0FY9u
         CKEFjCink5viuqFDz+3ldtNywPMi+tECXnXRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059528; x=1702664328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrT35L8MTIhLwpdhO3H/c+pqRQCxCg0MNTO7FGS/OpU=;
        b=eWaCcmbOjysKU0sLfm7fF4Fc5miCVp9r4RoH3YCBglZ+BhmOm/NDO9hh3fkBXeBbXc
         H7XxZuHxLONRWjI4eIbLneHTHtj9AKNmlUGjvQ4AhVr/rVg2djOg++RVy40CpOCWaiho
         pfuY5SM6XU+5yBJsgh8oCIxMH/UL1OJwHPtux/pk2vcljdAcTaggnmivMPC/rUu8FdtE
         frtr/AapnFQYnaRrGS4Mqljvz2G8yeUbwGoIxvm8LXgm6JjB3z+EhNA1YIhhHZA/ohvo
         xWWoOxgq7bAZppxZHrttwM4NNaYn/MW2BUxvt9zlXcp5M29lMH0wJzx0oHhhbQ6VkjMI
         9llA==
X-Gm-Message-State: AOJu0Yyx6PSp1fQazv1wP3azpNLhKBYcDbm6TiNgoWZZKmts3Pl4g/Fp
	/BIIViR8tGew90fnIF1VGMRJVw==
X-Google-Smtp-Source: AGHT+IHcui7vMV2OdqCWva5dAEsJH2d+5AV5Uk+IvX+ZetEUSVVWsrmNmp2gSKs4GaolD2scYZHLig==
X-Received: by 2002:a05:6a20:8c1b:b0:190:20d:5b94 with SMTP id j27-20020a056a208c1b00b00190020d5b94mr372175pzh.27.1702059528236;
        Fri, 08 Dec 2023 10:18:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s7-20020a63f047000000b005c67dd98b15sm1867436pgj.74.2023.12.08.10.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:18:47 -0800 (PST)
Date: Fri, 8 Dec 2023 10:18:47 -0800
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
Message-ID: <202312080947.674CD2DC7@keescook>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <20231206123402.GE30174@noisy.programming.kicks-ass.net>
 <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
 <20231206134041.GG30174@noisy.programming.kicks-ass.net>
 <CANiq72kK97fxTddrL+Uu2JSah4nND=q_VbJ76-Rdc-R-Kijszw@mail.gmail.com>
 <20231208165702.GI28727@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208165702.GI28727@noisy.programming.kicks-ass.net>

On Fri, Dec 08, 2023 at 05:57:02PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 08, 2023 at 05:31:59PM +0100, Miguel Ojeda wrote:
> > On Wed, Dec 6, 2023 at 2:41 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Anywhoo, the longer a function is, the harder it becomes, since you need
> > > to deal with everything a function does and consider the specuation
> > > window length. So trivial functions like the above that do an immediate
> > > dereference and are (and must be) a valid indirect target (because
> > > EXPORT) are ideal.
> > 
> > We discussed this in our weekly meeting, and we would like to ask a
> > few questions:
> > 
> >   - Could you please describe an example attack that you are thinking
> > of? (i.e. a "full" attack, rather than just Spectre itself). For
> > instance, would it rely on other vulnerabilities?
> 
> There's a fairly large amount of that on github, google spectre poc and
> stuff like that.

tl;dr: I don't think the introduction of speculation gadgets is a
sufficient reason to block Rust interfaces like this.

Long version:

I think the question here is "what is the threat model?" If I break down
the objection, I understand it as:

1) The trivial wrappers-of-inlines are speculation gadgets.
2) They're exported, so callable by anything.

If the threat model is "something can call these to trigger
speculation", I think this is pretty strongly mitigated already;

1) These aren't syscall definitions, so their "reachability" is pretty
limited. In fact, they're already going to be used in places, logically,
where the inline would be used, so the speculation window is going to be
same (or longer, given the addition of the direct call and return).

2) If an attacker is in a position to directly call these helpers,
they're not going to use them: if an attacker already has arbitrary
execution, they're not going to bother with speculation.

Fundamentally I don't see added risk here. From the security hardening
perspective we have two goals: kill bug classes and block exploitation
techniques, and the former is a much more powerful defensive strategy
since without the bugs, there's no chance to perform an exploit.

In general, I think we should prioritize bug class elimination over
exploit technique foiling. In this case, we're adding a potential weakness
to the image of the kernel of fairly limited scope in support of stronger
bug elimination goals.

Even if we look at the prerequisites for mounting an attack here, we've
already got things in place to help mitigate arbitrary code execution
(KCFI, BTI, etc). Nothing is perfect, but speculation gadgets are
pretty far down on the list of concerns, IMO. We have no real x86 ROP
defense right now in the kernel, so that's a much lower hanging fruit
for attackers.

As another comparison, on x86 there are so many direct execution gadgets
present in middle-of-instruction code patterns that worrying about a
speculation gadget seems silly to me.

> [...]
> The thing at hand was just me eyeballing it.

I can understand the point you and Greg have both expressed here: "this
is known to be an anti-pattern, we need to do something else". I generally
agree with this, but in this case, I don't think it's the right call. This
is an area we'll naturally see improvement from on the Rust side since
these calls are a _performance_ concern too, so it's not like this will be
"forgotten" about. But blocking it until there is a complete and perfect
solution feels like we're letting perfect be the enemy of good.

All of our development is evolutionary, so I think we'd be in a much
better position to take these (currently ugly) work-arounds (visible
only in Rust builds) so that we gain the ability to evolve towards more
memory safe code.

-Kees

-- 
Kees Cook

