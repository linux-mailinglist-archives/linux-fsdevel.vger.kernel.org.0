Return-Path: <linux-fsdevel+bounces-21783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75547909E18
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E131F21531
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789914AB2;
	Sun, 16 Jun 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn+vI0FO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C149443;
	Sun, 16 Jun 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718550912; cv=none; b=eyM2JNomrJAqa3dD+4JJGcPAxSXcvNm3L6BstoZD3BMvwlHUg/2Ge1foY7loXYxvhZhkLseiejcDzST+ZOUnZT9whLu+T0ATJJBsQmi6JLkEfwwvvZlwpM+sw9PP3ssUHTas+YVNbNOY7u/fHlAWUjS3ROZ7Jp0T2eVW8LLz0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718550912; c=relaxed/simple;
	bh=RAT6eJkvQNBYzHrJe9vp69HJtSQHPhlPr8onQuHx9II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZawWCmk1fkutoZPsqkBB3mz1Flrr0QwD/9XOypJerIZB2MgPsfodAsdzJ+RSO7cnf/qh3jiBz2qA6/AcPm1pSnl1hbG0PVFPPDWcshVNrWoPO8mMtlQ14MvNfpybInsGJVPFJo4n142nLlnRAYQQ3bUyUOMEiYe7fipw0ko0i4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn+vI0FO; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-681ad26f4a5so2200738a12.2;
        Sun, 16 Jun 2024 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718550909; x=1719155709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAT6eJkvQNBYzHrJe9vp69HJtSQHPhlPr8onQuHx9II=;
        b=Cn+vI0FO8HN825BO2YR0BELvhGj/4TuSwbchUKRnIz8muQwUXKpQyY3BneSOs67XL7
         H/nFgDvDnPsW8DxmwHrS9I34+lFEAyzc7/29HubQxQqn1TFntj9F2CCgYU1WqXDY0nAF
         BKTVxFSZyyleo6Sva/6Mt+yUw9ULc3yIJyB3+IvE9sCbTC5TH8I/cEF/pyDubeBltb/P
         6oYiByNzkFm/+JzVkYnu83XyjIYuDuJ9KtZZGE+8kaC6PnYvsoyTrro9jsWeE3GVsk55
         xXMvrg2JtmaDBnTQQWBSwfUUqn2iP7L02cVL9QOng8EEmRdhxJKmWqQtaiyKWI2fchdq
         izHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718550909; x=1719155709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAT6eJkvQNBYzHrJe9vp69HJtSQHPhlPr8onQuHx9II=;
        b=r7PiqcB34w2G/T997jk5TRIbcnd5jlwq0yL7aIVFt8DDIlVQaDhGcQk0jpNNINmAV1
         959xCIqc1Wyalvot66/hKTOgVsqUfekGHGv/MFYICs5kEjN3d6ymLpc18d7ApN5ma/19
         jYH/fjP+5SNMt9jqmaSfAITvJAVq2egaHnJk0cE7v2J9qLBIEWA6v5LmyEUG6eESP3qc
         W//J9pyGHsbQsIN8YyGW+S4CrgxBKe4pMkhAee8K2tOoXWve+TUjTymKy+mRhdFD5zwZ
         QYBXMxOjW4/io5GESgRXoiWuRABJxc8cBQafeiP61WyMHhy3nOmFH6FOzF0qkXqR8h7H
         1BhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSSSaSpVzHrRB6+deWp5BcbT8qKkg+TkaZGXdQrpQ1fiW/ZsjyJ0h4mzvxa/w9t7KCxbRegSVk7bRTQ/4V6IUI3X3rQ0fAJ7Bw/r5Ld7yLphEJVLRGJRW6bumlH9t3YCcnzwaxh/MLuqrY+j/zJA3YNPlP6F8XCy9pYlMHqY7OEJ/Hb7jiCSKN8TYesH2hoZs3SK124uBxpIrZpr9LODKPc2ZlAKuD8w==
X-Gm-Message-State: AOJu0YzhzPx6OAqkOAGXKY3BJXwcZu4gE3HkzylbzYtUtfElvQxxGPwu
	Gxci+71HGW9iMhSzL5um4iHZOuH/9qZVw+T78LnmC4tECtT0KW7b7sN7bQTJFlPIEN1Xe8IGLd6
	CJeUt0V1C9iU14PcrfJBhJeoiaJk=
X-Google-Smtp-Source: AGHT+IExmw4UHjrDbI2Fok1Zstrtac7O3xd+idP6ayK7NE1EvBrJI1L9WqD6wi1jWXgLJrEp0r+SENj7fdmcskqJ//Q=
X-Received: by 2002:a05:6a20:4924:b0:1bc:9a9e:364c with SMTP id
 adf61e73a8af0-1bc9a9e3735mr472152637.49.1718550909151; Sun, 16 Jun 2024
 08:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmseosxVQXdsQjNB@boqun-archlinux> <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux> <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home> <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home> <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home> <5lwylk6fhlvqfgxmt7xdoxdrhtvmplo5kazpdbt3kxpnlltxit@v5xbpiv3dnqq>
 <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
In-Reply-To: <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 16 Jun 2024 17:14:56 +0200
Message-ID: <CANiq72mz=OzzHJJyOPeWcxEtppP+v0KUq63_u5NB7-R84avaPg@mail.gmail.com>
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Benno Lossin <benno.lossin@proton.me>, 
	Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, dakr@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 4:16=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hmm? Have you seen the email I replied to John, a broader Rust community
> seems doesn't appreciate the idea of generic atomics.

I don't think we can easily draw that conclusion from those download
numbers / dependent crates.

portable-atomic may be more popular simply because it provides
features for platforms the standard library does not. The interface
being generic or not may have nothing to do with it. Or perhaps
because it has a 1.x version, while the other doesn't, etc.

In fact, the atomic crate is essentially about providing `Atomic<T>`,
so one could argue that all those downloads are precisely from people
that want a generic atomic.

Moreover, I noticed portable-atomic's issue #1 in GitHub is,
precisely, adding `Atomic<T>` support. The maintainer has a PR for
that updated over time, most recently a few hours ago.

There is also `AtomicCell<T>` from crossbeam, which is the first
feature listed in its docs.

Anyway...

The way I see it, both approaches seem similar (i.e. for what we are
going to use them for today, at least) and neither apparently has a
major downside today for those use cases (apart from needed refactors
later to go to another approach).

(By the "generic approach", by the way, I mean just providing
`Atomic<{i32,i64}>`, not a complex design)

So it is up to you on what you send for the non-RFC patches, of
course, and if nobody has the time / wants to do the work for the
"simple" generic approach, then we can just go ahead with this for the
moment. But I think it would be nice to at least consider the "simple"
generic approach to see how much worse it would be.

Other bits to consider, that perhaps give you arguments for one or the
other: consequences on the compilation time, on inlining, on the error
messages for new users, on the generated documentation, on how easy to
grep they are, etc.

Cheers,
Miguel

