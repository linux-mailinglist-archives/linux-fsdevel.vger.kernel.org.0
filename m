Return-Path: <linux-fsdevel+bounces-21928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03890F17D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 17:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44BA287275
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED816F303;
	Wed, 19 Jun 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cbcq5ers"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C42139CD;
	Wed, 19 Jun 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809234; cv=none; b=hLTtR2tDR3IT5EY3Cb527USd775+VxcvraVq/c04853btc1HuhoGofQXh4syFGrpvXpFxcDJxo/Zfm5u8hPHPlqoGce082ovsyeSB3r0VanafhzvFQlYrTW+dW1OHMjFh/tKhs6l0G5Q9MjPAWklqtbA+Kc8OQOtRbOX/68XAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809234; c=relaxed/simple;
	bh=J3Snj/0Qxvlt0FE7ajq+a7K2r9ULR6FYlHEjvEP9EvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szDzrrxRRRNrHwtRmPKYIyu5waN33qLmCBnUCEYa2PLy/otT1c8eJBq1xy4WpWf57IHzZXU6Uu1N6koTcc/+X0HewdauMFbpWFPuIBQhpX48lyjsehKL5FcTFjiOOP4tsu1eyctVmUxylyGCHn8uxmu2yuLTpCBhdVHtpjxE4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cbcq5ers; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5031d696dso4894306d6.3;
        Wed, 19 Jun 2024 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718809232; x=1719414032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSe7xh6KAt4sne8yLQr6PWQBZTumzGrh6Hd9VCen+Yc=;
        b=Cbcq5ers8rfiiDYJ3bhw3pV6zvCcdN9L2913Ly+xXDvSGl2XT9cUL+Na9+OImfuEj5
         JzvWl9Fo+/Wa/S3bd1ntXTZl5e3YUvVbK5a5AQZTMahJBtVag9zgT+49sgw01HXmvxWz
         oipUvP5seSoHjR4UmcxCEswPwH3R3cRxfm0wTZkACyK4ZtadbzurmOhUVEjcjl+Phphv
         FL4QUDBWSx6KiGfz/cHjzsVr0qKudYIE1I1B9zweLwj6F3ydo27R3jtEiD7wwl91YbMf
         fiv+CfuoswtDc/t/IihdsjcNzZy1VzxJyUdGiogQJeS9q4R6sQuyi3zXTXB4EMEf3FPE
         rKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718809232; x=1719414032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSe7xh6KAt4sne8yLQr6PWQBZTumzGrh6Hd9VCen+Yc=;
        b=esIDe/ni2adixxjphe8XdD7RhLzNyLF9Y3KVhb5ByU7bsnJI8mwFlTrI3prpjTZS0T
         T6BbrneZAwypfRaAw4AD5xgeRuvl59hJ/atXVV7RtvpqNImlomW9U8a72ywHT5iWpaxy
         KU6ZF1jJGBVacpsgOn6R78Ajj3wv2JTtSAHOcHeyOCc2Dd5PyMGL+ypIWO4ENGAkEFNw
         dAoE8leMYhn16T8RG1sqw+Za9gTtSnepP3oyemGMyIUtAG1qflSTi5yoKR9J/AvqAdEK
         WY+vRT1NaX2sGkw2hjSZ6p0dmB1iouSnHYTlVoEkBLhI0jFUv1lrUxYCoYO/RlnqiLEF
         VG/A==
X-Forwarded-Encrypted: i=1; AJvYcCUTckU2wFnBzajr3+k20GBIPUt5dc5IH6IY00p3yJ8bZtJZaZxU4FERV53updW6qvQ4OJO757tvkGBPqxgEFrShqQgvtGSvQauX1Y/0WPGHbVep9Z4YzBwwNIKrVIoLc/4LjE1O9KkycP1hYPAzUjcEojYLyV3ZZtJCvJvJxNOKWroho7eLhxqwRG1QbcCEwpm9yb78sTegt5w+h1BRguUmg3wLkSXUTQ==
X-Gm-Message-State: AOJu0YzbFF80al+u7bneZpzl5FbH9uQZYAHIaBIPemBzvdNp52/JPf5q
	9T6A7Fg+AmE1690GwsmOrx+4u9qNyNr8kBF1UbNENJUJSFkvkPY/
X-Google-Smtp-Source: AGHT+IFMO2mnnq/pKqebuYpxsv8DFlI+YICYEc0pIpoy8PluBhBbtM2i6uRQLvJpntCKJejZy2TOjA==
X-Received: by 2002:ad4:4433:0:b0:6b4:d299:e060 with SMTP id 6a1803df08f44-6b501eda83cmr26413976d6.64.1718809231655;
        Wed, 19 Jun 2024 08:00:31 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b4f7e0d927sm17249616d6.37.2024.06.19.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:00:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 031DA120006A;
	Wed, 19 Jun 2024 11:00:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 19 Jun 2024 11:00:30 -0400
X-ME-Sender: <xms:jfJyZiqcWeBDUVJGswcaHYY_pVr4V0xn99vCLGWzZBHSP8Smv3wvsg>
    <xme:jfJyZgpWI7MtG-dtPbD1DBtHetqmqrWAUpzdhlF62RJyuX65eBQtJvnzNHuXOvMQ8
    m-rwU9qZbElzNp-tA>
X-ME-Received: <xmr:jfJyZnP28Pm69xMI7Kj-TmRqq4HVV5SwIWk3gf_54icNfRBR8p4MXsbKRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeftddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:jfJyZh6t6xm7wl2n5p1feQOpcdTCJWFMiQQ6qhzVth2rlSXst6bv6Q>
    <xmx:jfJyZh5uzZ5RBWu_MGU9_tISr9HlI8gDgTd9aButBxygfsVSnnlCSA>
    <xmx:jfJyZhhz9TYzKMtzQruo6upFLG87EG9rf7Hx0aEShqB0qmn2mSXFPw>
    <xmx:jfJyZr4ip0hg4WXCzpOSav4RNDxhv9TWoAoiUuHTQaRy3KIquOEGYQ>
    <xmx:jfJyZsJLOextY4AJ_e8fShT5c2e8n3wmWkl5KVNOrvcK6G-NnwOPDdDu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jun 2024 11:00:28 -0400 (EDT)
Date: Wed, 19 Jun 2024 08:00:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Message-ID: <ZnLyi5mC8JtPMhun@Boquns-Mac-mini.home>
References: <20240612223025.1158537-3-boqun.feng@gmail.com>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me>
 <Zm7xySzPJcddF-I_@Boquns-Mac-mini.home>
 <f29cb2fd-651b-4bc5-8055-e3a412192e29@proton.me>
 <Zm8F7ZFnUFJkFGQ3@Boquns-Mac-mini.home>
 <0653b5d5-7a62-4baa-a500-4c110d816ba0@proton.me>
 <Zm8TPRK-h2mDUX0b@Boquns-Mac-mini.home>
 <d87c75d3-9557-4a9f-8fc2-a297a945ef2e@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87c75d3-9557-4a9f-8fc2-a297a945ef2e@proton.me>

On Wed, Jun 19, 2024 at 09:09:46AM +0000, Benno Lossin wrote:
[...]
> >>> Then I might mis-understand Gary? He said:
> >>>
> >>> "Can we avoid two types and use a generic `Atomic<T>` and then implement
> >>> on `Atomic<i32>` and `Atomic<i64>` instead?"
> >>>
> >>> , which means just replace `impl AtomicI32` with `impl Atomic<i32>` to
> >>> me.
> >>
> >> This is a fair interpretation, but what prevents you from merging the
> >> impls of functions that can be? I assumed that you would do that
> >> automatically.
> >>
> > 
> > I think you missed the point, Gary's suggestion at that time sounds
> > like: let's impl Atomic<i32> and Atomic<i64> first, and leave rest of
> > the work for later, that is a "do the design later" to me.
> 
> Hmm, but wouldn't that just be less work for you?
> 

Not really ;-) Committing to a generic interface without a vision/design
is going to be a maintenace nightmare. I will need to deal the soundness
issues and different ideas about what can be put in <..>. So I'd suggest
we take great caution before we make our decision, and I may even ask
for a formal proof of the soundness of a generic interface for key
components such as atomics. Because last time I check, safety is what
Rust brings on the table, right?

Someone may say that non generic atomics is one of the biggest mistakes
that Rust ever made. But I disagree. In fact when I saw this, my first
impression was "these guys know their stuff": there are only a few types
and operations that make sense, so putting them in a generic interface
would be over-engineer (at least at the beginning). It's better correct
than convenient/popular/aesthetical.

So would you and Gary be interested at working on such a design and
proof? Maybe someone else Cced would also be interested. Eventually we
will need the tool of soundness proof for other types as well, that's
going to be very vaulable. And having that would be the real "less work
for me" ;-)

Right now, I still plan to do in the current way (i.e. non-generic
atomcis for i32, i64, isize) because there are already users [1], 
the correctness is easy to confirm and we won't confuse users with
half-baked generic design. But should we have a sound Atomic<T> design,
I'm happy to adopt it ;-)

[...]
> >> Also to be aligned on the vision, I think we should rather talk about
> >> the vision and not the design, since the design that we want to have now
> >> can be different from the vision. On that note, what do you envision the
> >> future of the atomic API?
> >>
> > 
> > Mine is simple, just providing AtomicI32 and AtomicI64 first, since
> > there are immediate users right now, and should we learn more needs from
> > the users, we get more idea about what a good API is, and we evolve from
> > there.
> 
> That is fine, but since we want to get generics in the future anyways, I
> think it would be good to already implement them now to also gather
> feedback on them.
> 
[...]
> > 
> > You mean you said it's a non-issue but gave me two counteract? If it's
> > really a non-issue, you won't need a couneraction, right? In other words
> > non-generic atomics do provide some value.
> 
> The second counteractions would provide exactly the same API surface as
> your non-generic version, so I don't see how going non-generic provides
> any value over going generic.
> The first approach was intended for a future in which we are not scared
> of people using generic atomics in their structs. I don't know if we are
> going to be in that future, so I think we should go with the second
> approach for the time being.
> 

Not going to reply the above right now, because I'm leaning more
torwards switching when we have a sound Atomic<T> design, but I want you
to know I appreciate your input and explanation.

> >> argument? Because I don't see anything else.
> >>
> >>>> - I don't think that we should resort to a script to generate the Rust
> >>>>   code since it prevents adding good documentation & examples to the
> >>>>   various methods. AFAIU you want to generate the functions from
> >>>>   `scripts/atomic/atomics.tbl` to keep it in sync with the C side. I
> >>>>   looked at the git log of that file and it hasn't been changed
> >>>>   significantly since its inception. I don't think that there is any
> >>>>   benefit to generating the functions from that file.
> >>>
> >>> I'll leave this to other atomic maintainers.
> >>>
> >>>> - most of the documented functions say "See `c_function`", I don't like
> >>>>   this, can we either copy the C documentation (I imagine it not
> >>>>   changing that often, or is that assumption wrong?) or write our own?
> >>>
> >>> You're not wrong. AN in C side, we do have some documentation template
> >>> to generate the comments (see scripts/atomic/kerneldoc). But first the
> >>> format is for doxygen(I guess?), and second as you just bring up, the
> >>> templates are tied with the bash script.
> >>
> >> I see a bash script similarly to how Wedson sees proc macros ;)
> >> We should try *hard* to avoid them and only use them when there is no
> >> other way.
> >>
> > 
> > I will just start with the existing mechanism and try to evolve, whether
> > it's a script or proc macro, I don't mind, I want to get the work done
> > and most relevant people can understand in the way the they prefer and
> > step-by-step, move it to the place I think is the best for the project.
> 
> I don't think that we need a script or a proc macro. A few declarative
> macros probably suffice if we go the way of generics.
> 

Ah right. And even without generics we could use some declarative
macros, and I'm happy to take a look at this and provide the alternative
approach so we can choose a better one.

[1]: https://lore.kernel.org/rust-for-linux/20240611114551.228679-2-nmi@metaspace.dk/

Regards,
Boqun

