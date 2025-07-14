Return-Path: <linux-fsdevel+bounces-54871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58156B0453D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 18:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC32177C87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8B25F78D;
	Mon, 14 Jul 2025 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GAgMHi9R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422C1DE4E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509838; cv=none; b=lSaR3vroeyJVxFSOOhxgb6TKPToaScOs6809QmdSSU1L+6efGQOKnTomHhBbrMzOY5U4xqXVQS4QI5oSjfOM8UHVM89hg1vwoIHikpZuDCCE36H4YNX+YJ/rBLEXIMBnzHCb9EiNfSSwlnM/bJ+Yi7EXGItJ++M97mxMtmVUxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509838; c=relaxed/simple;
	bh=i/R26POJP4dDcBivK5gMdeMHp+1pQls5mGnd176yHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riYgYMwTw9GEhYeIfK7K0ETpOYbtUcAe+YuvKt+zOtgfoG3WFBRdwD0SdrFHSmB+EcINtKi+lgyAsWiy5c7SUGujxNBV7tUeNdW4YbfBORQZkFZ+woqwQHb/qtjkCNQBL71zSerkkYfIzVIJG2qwROAQa8YrxemQp0OpTZSC7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GAgMHi9R; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso8822595a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752509834; x=1753114634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEQq66OWWE9JtkTfXjKqpWkex8XQYQ6HwopNDNvjlsc=;
        b=GAgMHi9Rxhz7qIRL91J7AhF0PfqlEelnmfjTCmo1uANzbPk1uri08ap2OKvyN/ABZ4
         lUQ1k/6Jz4EoUCL64VljrJbmGPYzoI8rbCa2KvwrultNFNnvWxJqmz+lDIXBbvmiYoHj
         hojECvf50N7RerK5q1SZy6PyLyq8mM2LDdGYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509834; x=1753114634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEQq66OWWE9JtkTfXjKqpWkex8XQYQ6HwopNDNvjlsc=;
        b=QVFeSyRnFytYrBRJdRHtNDvsiTjQ0qQgVzyvDCJ3Rda2KtkGhumWUOKwmRygAI0S8W
         cpogrXpAA2w8nUIgYa4fXEM0b0/4/zvtWyw9M6Vbi0l4z4JdDsd0601RmMgMs8DAKK0N
         xCsz8diNQ/7PMXVOVPi1jZID6VYoz2gLqj9aKh/b5vbhJ5gNz3Raf0emqCC9K7YbWJGI
         DQqEg33dtpCwZaTMXwGmFJ9CPCFgud6hY5LQ5hkt4iTyTBAE7j++X8iUo6BL2XH+aGvy
         JGuB9HK+3y+nWwvnmDPtxM+w1u0sbU3x1z659RNvMdWXf0VAtD0fbEcH+nqBUYueggXE
         TQOA==
X-Forwarded-Encrypted: i=1; AJvYcCVyqT0gdgdzLaNujTT43RPbOC8owqZHoGG9ZkW/8xPEOzm2mklF9QFpzY6yl5SUlWKnZxZssfteKU2M1zuK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7SWjkiHFz8TbjTUQm3mdU5WmdEWeN2Fa3DnLok1TWYKubZgy
	gRlk605aD19ILDSPiM9zREdTHaoXfp8JwGsfTPUKkWGpfzxOy5MxbQ0l2eAr0O+hn2szs8KkTKl
	viEQ1sY4=
X-Gm-Gg: ASbGncu08IcIz7SOqu8FyktiHN4JSBFri/uahcvhWfS+CbMGvOfRqvZcuL+1djkNPTv
	sRzZomjB0OGoqAsu1zx96VP8LmEV5b0wrxM+4NjLtMTyZnyciK9lF0NvLYzGr+6UJN35xWLhkIV
	WJNb6IHBOG7L/I+vC+rd4Xd9KMk9l1S32XulHbzNAtCCkSWP8qHW5qNLfPzOqzbktPboOrOwwos
	qjlOAYJYziqD19abdMQW1z+d6dIHz1c+JkRxOZaeTEWIKRvhKKHrLytFKXpiws4LCVW+Io3UyBE
	H4HpdLI1ZQcWvq8F4UMzKbPxY6yeU4k7aLtBBgeyAA0IYpJ1NTetUhTy8nfxe0wW6vvFJapv7hS
	6OuZSPt7f7uPfdZIoPSevjDTOZZ9xpBthsKJ0psDkW+/3Qn+Y10r+PD51zWmN/xXdgzkMxQhB
X-Google-Smtp-Source: AGHT+IFk0khUHw893bixULLS61yhiN50a1Rqthq4KDf3kv8dD5aSPNajA7Q+NZps4hHZI6Wo60IeXg==
X-Received: by 2002:a17:907:1c0d:b0:ae0:a351:49b with SMTP id a640c23a62f3a-ae6fbf26350mr1392269966b.34.1752509833998;
        Mon, 14 Jul 2025 09:17:13 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8265bbesm832950266b.80.2025.07.14.09.17.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:17:13 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so7533574a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 09:17:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp6WPprfHdlqG1QFu/DZ3z7Xs8YyDsMKpyDyOLx1X2E0Qnk0TyM1U4OygviQm4r9k8a9jpv0SM8MB9FKDq@vger.kernel.org
X-Received: by 2002:aa7:d78f:0:b0:602:201:b46e with SMTP id
 4fb4d7f45d1cf-611e84f8dd6mr9695286a12.31.1752509833354; Mon, 14 Jul 2025
 09:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710034805.4FtG7AHC@linutronix.de> <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de> <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de> <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de> <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <20250711095008.lBxtWQh6@linutronix.de> <20250714-leumund-sinnen-44309048c53d@brauner>
In-Reply-To: <20250714-leumund-sinnen-44309048c53d@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Jul 2025 09:16:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whniDdvSeCEQD5aUzr79HnhZ=A+ftzr0p_mY+n_f0AMHg@mail.gmail.com>
X-Gm-Features: Ac12FXxWB0yp1KMBo5BvpABIxBDtYWLONaWyJRXqnq_-Wkoa7_1NLpHwfbQeSac
Message-ID: <CAHk-=whniDdvSeCEQD5aUzr79HnhZ=A+ftzr0p_mY+n_f0AMHg@mail.gmail.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
To: Christian Brauner <brauner@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, 
	Joe Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 02:00, Christian Brauner <brauner@kernel.org> wrote:
>
> I was on the fence myself and I juggled the commit between vfs.fixes and
> vfs-6.17.misc because I wasn't sure whether we should consider such
> priority inversion fix something that's urgent or not.

Well, this time it actually helped that it didn't come in through the
merge window, because it made the bisection much shorter.

But in general, I do think that eventpoll should be considered to be
something that needs to die, rather than something that needs to be
improved upon. It's horrendous.

The indirections it does have been huge problems, even if they are
"powerful", because we've had lots of issues with recursion and loops,
which are all bad for reference counting - and not using reference
counting for lifetimes is just fundamentally a design bug.

For example, the vfs file close thing has a special
"eventpoll_release()" thing just because epoll can't use file
references for the references it holds (because that would just cause
recursive refs), and dammit, that's just the result of a fundamental
mis-design. And this is all after all the years of fixing outright
bugs (with hidden ones still lurking - unusually we had *another*
long-standing epoll bug fixed last week)

(Don't get me wrong: unix domain fd passing has caused all these
problems and more, so it's not like epoll is the *only* thing that
causes these kinds of horrendous issues, but unix domain fd passing
was something we did due to external reasons, not some self-inflicted
pain)

So this is just a heads-up that I will *NOT* be taking any epoll
patches AT ALL unless they are

 (a) obvious bug fixes

 (b) clearly separated into well-explained series with each individual
patch simple and obvious.

Because it was really a mistake to take that big epoll patch. That was
not a "small and obvious" fix to a big bug. That was literally a
"makes things worse" thing.

I didn't react very much to that patch because epoll has been fairly
calm for the last decade, and I had forgotten how much of a pain it
could be. So I was "whatever".

But this all re-awakened my "epoll is horrendous" memories.

Nam - please disregard performance as a primary thing in epoll. The
*only* thing that matters is "make it simpler, fix bugs".

Because long-term, epoll needs to die, or at least be seen as a legacy
interface that should be cut down, not something to be improved upon.

And yes, I hate epoll. It has caused *so* many problems over the
years. And it causes problems *outside* of epoll, ie we have that
horrendous pipe hackery:

         * Epoll nonsensically wants a wakeup whether the pipe
         * was already empty or not.

and the pipe code has that "poll_usage" flag just to deal with the
fallout of bad epoll fallout.

THAT was fun too.

Not.

              Linus

