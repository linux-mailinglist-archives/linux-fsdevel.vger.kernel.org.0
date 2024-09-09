Return-Path: <linux-fsdevel+bounces-28951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FE971CA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 16:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8752EB2244B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210731BA28D;
	Mon,  9 Sep 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RIB3PDzc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yzwzEdcE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89031B5EB7
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892294; cv=none; b=f8fBHyHF+3yBgSTxdoISSa4vnbbvj84oswkGmfzu3ncFFkKchE+cV+8oGnlQPGuWEWUM+XchnYwtj7UkC7arngF4VcQcXUbFArE+Zc262NWyKN+yIBEN4M7mseQgRb9ra1YtiLC4/f2uYlDmLcKOFpUKjzpUtXNOid1rtGyf36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892294; c=relaxed/simple;
	bh=CuQIm6FLrEA9fua7xpZ69cTS+/Kj/s+Oh71sz7ub44E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BDv55MBQTVh19MyTnqZLsHOHw3tHQDvOHvFsRA5+KgEbRixlHi2+WHgYyKq7pq6bNV7/SzMDtYbJtzMfWRjTZDnz9bGB8NCLTZi1Lub5o76SAWwn0TN+ECmRhc4cCsbAQqcOu8Asf13u38zqmlTlOwRbD4gFjyOOUAzdICO9sbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RIB3PDzc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yzwzEdcE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725892290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p2DzKilptjmCGepX1IgkvLR+a5gWmN0aU0k+31PBodc=;
	b=RIB3PDzcOjbWVApDvjxxJMZ+aOWvLfUui1JhYQ7L+x4T2D8Ct/KNx9YOJBFrBAHiKMi9p8
	gZqb/O1AhK5eUGoJaADl2M/JvxaQj0WtyBBpQOuTguhcrVWa1y/JUJxqwW3DGk3cJpPWwa
	jwYLXqyRhS10KIM04WN8bcEHisk3TS5nZ1ankjqTHPeoPE2yyUjI0zGEnH9ROIZyRcKtRL
	6E27tltmLpmzBFWOaM35J3FthtKrty+WY4O7m0EubmZwpU7N6gqKe4wsjm6goTT16Vfq41
	zCVMbONPszjUxntPK6vjPCuNiucDrZhWcigqFElQFtgD9PGJSduxdjaQV5gJxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725892290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p2DzKilptjmCGepX1IgkvLR+a5gWmN0aU0k+31PBodc=;
	b=yzwzEdcE8zf0zoihvT/bDslO7NDo2F17T3q5Eqlj0FOfxGZlRUGimkx4ICjSePrj3tEBun
	We9BHmBE4Q1biJBA==
To: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Matthew
 Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: copying from/to user question
In-Reply-To: <d3b12900-f936-4c94-881d-8679bb8c878e@app.fastmail.com>
References: <4psosyj7qxdadmcrt7dpnk4xi2uj2ndhciimqnhzamwwijyxpi@feuo6jqg5y7u>
 <20240909-zutrifft-seetang-ad1079d96d70@brauner>
 <d3b12900-f936-4c94-881d-8679bb8c878e@app.fastmail.com>
Date: Mon, 09 Sep 2024 16:31:30 +0200
Message-ID: <87zfogc30d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 09 2024 at 12:14, Arnd Bergmann wrote:
> On Mon, Sep 9, 2024, at 09:18, Christian Brauner wrote:
>> On Mon, Sep 09, 2024 at 10:50:10AM GMT, Christian Brauner wrote:
>>> 
>>> This is another round of Christian's asking sus questions about kernel
>>> apis. I asked them a few people and generally the answers I got was
>>> "Good question, I don't know." or the reasoning varied a lot. So I take
>>> it I'm not the only one with that question.
>>> 
>>> I was looking at a potential epoll() bug and it got me thinking about
>>> dos & don'ts for put_user()/copy_from_user() and related helpers as
>>> epoll does acquire the epoll mutex and then goes on to loop over a list
>>> of ready items and calls __put_user() for each item. Granted, it only
>>> puts a __u64 and an integer but still that seems adventurous to me and I
>>> wondered why.
>>> 
>>> Generally, new vfs apis always try hard to call helpers that copy to or
>>> from userspace without any locks held as my understanding has been that
>>> this is best practice as to avoid risking taking page faults while
>>> holding a mutex or semaphore even though that's supposedly safe.
>>> 
>>> Is this understanding correct? And aside from best practice is it in
>>> principle safe to copy to or from userspace with sleeping locks held?
>
> I would be very suspicious if it's an actual __put_user() rather
> than the normal put_user() since at least on x86 that skips the
> __might_fault() instrumentation.

epoll_put_uevent() uses __put_user(). __put_user() does neither have
might_fault() nor does it check the destination pointer. It's documented
that the caller needs to have validated it via access_ok(), which
happens in do_epoll_wait().

> With the normal put_user() at least I would expect the
> might_lock_read(&current->mm->mmap_lock) instrumentation
> in __might_fault() to cause a lockdep splat if you are holding
> a mutex that is also required during a page fault, which
> in turn would deadlock if your __user pointer is paged out.

Right. But an actual page fault would still trip over that if there is a
lock dependency chain because pagefaults are enabled.

Coming back to your general question.

It is generally safe to fault with a sleeping lock held when there is no
invers lock chain vs. mmap_lock.

Whether it's a good idea is a different question, which depends on the
context of what the mutex is protecting and what consequences result in
holding it for a extended period of time, e.g. due to a swapped out
page.

Thanks,

        tglx

