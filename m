Return-Path: <linux-fsdevel+bounces-340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B907C8D59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 20:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0E5282E7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3A21360;
	Fri, 13 Oct 2023 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ep4CvS6/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555EB1CFA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 18:55:09 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229C95
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 11:55:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b64b98656bso385354266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697223306; x=1697828106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTnCuQhHu4vMJ5ozMAEPYZByiFfPswag7KkaGVloQKk=;
        b=ep4CvS6/1Xdn0SH7J+1/pSuEckCQ4aAsk8bxJjhC/0KXGpr9xQa1/vlSRplymfvkUd
         hG5HAnbwdJ9H4hE4gyHhw3MdD6QWiyF2e4T2mL0OKGzqfu7Q1TVng98UTwz0BbM9qNay
         VZsl5SMAx1WJog4JQ96Zn2qR9B96Gdl9mQmIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697223306; x=1697828106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTnCuQhHu4vMJ5ozMAEPYZByiFfPswag7KkaGVloQKk=;
        b=ITsniiCoa+bJnc8IGjabtWhwswPCJ5NfJskDBGJuiwi78D5MxwvusK5KXOV0yvyw3E
         WxptJc8o+UiXIrnOLQgFgjpCdwh9j4uLO47YiLVJvxXXaUzbDdxbbQYln7HyMYURjo/3
         AZuNcjr0/zk2+xs218RztpXw0DhHYJChujmxeodfnwxjIMYIDLEmcrDGhOOK8r23a1bx
         oCvBONEbsrF/758w7CxZdCN+Vq+pGriCLM+8UxJZZKsCGWeq3iyFnUCdHddpCyl9+lsG
         srsjrg+I1Xm57srjEw8RznMXRx1W2O7jzgakpA0nwtNrFkHZmalYV4xLyXPs8+3oMKhY
         Z8aw==
X-Gm-Message-State: AOJu0Yz19Q25D6CMWKEEMevSBPBP+2+Apz53spB98n5cd6AMZjEOaM3F
	+DdrE5lXidqjUAMiIStiyLYe5GuJ85vpFWoizIXAlw==
X-Google-Smtp-Source: AGHT+IFe8lWq213ZE4cQbgME9NkxJ8GHF2TyH6OwQPD5zvy3kDk7ESvwxUjuokRK+iGxsIhBqVhFGA==
X-Received: by 2002:a17:906:23ea:b0:9b7:37de:601a with SMTP id j10-20020a17090623ea00b009b737de601amr22462789ejg.49.1697223305911;
        Fri, 13 Oct 2023 11:55:05 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id ce24-20020a170906b25800b0098669cc16b2sm12598629ejb.83.2023.10.13.11.55.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 11:55:05 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9bda758748eso119657566b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 11:55:03 -0700 (PDT)
X-Received: by 2002:a17:906:2189:b0:9ae:6ad0:f6db with SMTP id
 9-20020a170906218900b009ae6ad0f6dbmr23995223eju.71.1697223303355; Fri, 13 Oct
 2023 11:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
 <20231012104741.GN6307@noisy.programming.kicks-ass.net> <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com>
 <202310121130.256F581823@keescook> <CAOcBZOTed1a1yOimdUN9yuuysZ1h6VXa57+5fLAE99SZxCwBMQ@mail.gmail.com>
 <20231013075005.GB12118@noisy.programming.kicks-ass.net> <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com>
In-Reply-To: <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Oct 2023 11:54:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com>
Message-ID: <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To: Ramon de C Valle <rcvalle@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, patches@lists.linux.dev, 
	Jarkko Sakkinen <jarkko@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@google.com>, David Gow <davidgow@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 13 Oct 2023 at 05:18, Ramon de C Valle <rcvalle@google.com> wrote:
>
> Both C and repr(C) Rust structs have this encoding, but I understand
> the problems with doing this in C since it doesn't have
> repr(transparent) structs so there would be a lot of casting back and
> forth. Maybe there is an alternative or this could be done for less
> used function pairs?

We actually have some C variations of what I think people want to use
"repr(transparent) struct" for in Rust.

Of course, that is depending on what kind of context you want to use
it for, and I might have lost some background. But I'm assuming you're
talking about the situation where you want to treat two or more types
as being "compatible" within certain contexts.

There's the actual standard C "_Generic()" alternative, which allows
you to make macros etc that use different types transparently.

It's not very widely used in the kernel, because we only fairly
recently moved to require recent enough compiler versions, but we do
use it now in a couple of places.

And there's the much more traditional gcc extension in the form of the
__attribute__((__transparent_union__)) thing. In the kernel, that one
is even less used, and that one use is likely going away since the
need for it is going away.

But while it's not standard C, it's actually been supported by
relevant compilers for much longer than "_Generic" has, and is
designed exactly for the "I have a function that can take arguments of
different types", either because the types are bitwise identical (even
if _conceptually_ not the same), or simply because you have a
different argument that describes the type (the traditional C union
model).

I suspect, for example, that we *should* have used those transparent
unions for the "this function can take either a folio or a page" case,
instead of duplicating functions for the two uses.

But probably because few people aren familiar with the syntax, that's
not what happened.

             Linus

