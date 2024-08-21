Return-Path: <linux-fsdevel+bounces-26562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8C295A7E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C54B217E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 22:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8772717B500;
	Wed, 21 Aug 2024 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qj7axJWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC21D1509A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724280473; cv=none; b=fzj3FyASYWK2/crp5AoAklIVmqz3VCUZa71oqThbNMLDhLItXHgftkjDAKTifBqssoXyTxm/kSKrQg+KKnHSUiG/ihZzMVe43ftqDqyn5HdjsGoscw08GefTDujeDEynZdQf/RnscSO7crvMgCQwrm/SYpsZWAR2GMZbB6StU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724280473; c=relaxed/simple;
	bh=NdalNagNvNCviKT/MfsKwgYInEUyLBPXO5i2hlVGEgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7dLO5q4rvh/hm8UC3BNNFuWiXH0tB7izQnlZZtlbl2MkEuiMhRvUnhVzeBwO/m/5YugkFSY1p1ukoOuNitIacirfFL4C7939b9Vyqeb2q9dbPW0P9dIYreOngFz+V9ygZMitnzVrgHbklCs10XAoHH0cu7sh2Wee3xqkVB0tEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qj7axJWH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8643235f99so23599166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724280470; x=1724885270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw86hX23EFNAtiYY1Ed/9iltoTASNXjR4NLVA2Yz0Zw=;
        b=Qj7axJWHNrCbgEr+WS1w4zs8Or1BOElrFzZ3WuTWFqtBPA080wKhgq6UKlxIgOLa6x
         xkwYCbpmbebpYVCwZfkeNGzxYJ4ki/XXs2r5+Dto9wpLN7KsVy0ZF4Bc+H3X5WwS26by
         +b9P43t1XO4ZJqHGrtFnJ73/teSq46vSeYLa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724280470; x=1724885270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sw86hX23EFNAtiYY1Ed/9iltoTASNXjR4NLVA2Yz0Zw=;
        b=eS7af0mJZPHJM10YODMzraojkfNwMieChA3EtCM+oOh+U4ocQmjhF0Qjx7Dh9I5sCl
         4gBKYIhazQFwgSoqBe35NAVZauIbMwtcGKuOCEktKnBcm4zVcHpWdZc6ueulakTol++j
         /ndOAp7I6nCktF7A75enFunqeitUgI7fngz0FQwlFfvV2uu2ljVq0oEgzCICOmS065HP
         XKHHwAiJY0zdLhPFdGWiXjehSRXC5wHqk9farAFGCYyISVC8YVxBpYpmdcKiXI2j33Cq
         Kpau1Z9LaGNugIlzx38ZTWwr64gtvGi0F7lHXg/SV2/ys3GpZmuvXcPZdPeL78DL223V
         SoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmAAAtQ8eh2QbpQicYuLmGxrEvRFRMBFUdtEX2jGBIzc4Wf8cdlwtegzRyF1OfABfpTButpkZQLxpBzi0K@vger.kernel.org
X-Gm-Message-State: AOJu0YyxfBqc6ymZM0d+y4aXH77HtA/+A9i5T8PM2X3PBR0gJ90E/Z9t
	l7drJpwyPFrjwKLYK34sgOPKfPE6q2hbeXkCibmv2tPLCf+d0I3L2nMESKBRE8bZYM8jZrgGSp5
	SwKuQag==
X-Google-Smtp-Source: AGHT+IGLwS8ifDRpVOBoNN47F5qbVDRW5zaUaQB81zsMA1SAr0aI/9pHYrN/UL6L3R0xj3W4NAJKCg==
X-Received: by 2002:a17:907:7f1e:b0:a86:7983:a4a7 with SMTP id a640c23a62f3a-a867983b93cmr273848866b.38.1724280469707;
        Wed, 21 Aug 2024 15:47:49 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47c579sm21359866b.153.2024.08.21.15.47.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 15:47:48 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso287292a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:47:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW17zbX1Ul+j2zWBJoxZ7cZCchGkqXpZF+ijRRmRXbLseKdmQmC7OPdXtobcvBpHMOudG1/VefWFib6oMXR@vger.kernel.org
X-Received: by 2002:a05:6402:430c:b0:5be:fa58:8080 with SMTP id
 4fb4d7f45d1cf-5bf1f09b94dmr2851980a12.3.1724280467964; Wed, 21 Aug 2024
 15:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-1-67244769f102@kernel.org> <172427833589.6062.8614016543522604940@noble.neil.brown.name>
In-Reply-To: <172427833589.6062.8614016543522604940@noble.neil.brown.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 06:47:30 +0800
X-Gmail-Original-Message-ID: <CAHk-=whucKrDiS6JyDLrapC1wJAsTHihqO8QiF4FfRfvCLyBjg@mail.gmail.com>
Message-ID: <CAHk-=whucKrDiS6JyDLrapC1wJAsTHihqO8QiF4FfRfvCLyBjg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 06:12, NeilBrown <neilb@suse.de> wrote:
>
> So this barrier isn't about the bit.  This barrier is about the
> wait_queue.  In particular it is about waitqueue_active() call

Correct. The waitqueue_active() call is basically very racy, but it's
also often a huge deal for performance.

In *most* cases, wakeups happen with nobody waiting for them at all,
and taking the waitqueue spinlock just to see that there are no
waiters is hugely expensive and easily causes lots of pointless cache
ping-pong.

So the waitqueue_active() is there to basically say "if there are no
waiters, don't bother doing anything".

But *because* it is done - by definition - without holding the
waitqueue lock, it means that a new waiter might have just checked for
the condition, and is about to add itself to the wait queue.

Now, waiters will then re-check *after* they have added themselves to
the waitqueue too (that's what all the wait_for_event etc stuff does),
and the waiter side will have barriers thanks to the spinlocks on the
waitqueue.

But the waker still needs to make sure it's ordered wrt "I changed the
condition that the waiter is waiting for" and the lockless
waitqueue_active() test.

If waiters and wakers are mutually serialized by some external lock,
there are no races.

But commonly, the waker will just do an atomic op, or maybe it holds a
lock (as a writer) that the waiting side does not hold, and the
waiting side just does a "READ_ONCE()" or a "smp_load_acquire()" or
whatever.

So the waker needs to make sure that its state setting is serialized
with the waiter. If it uses our atomics, then typically a
smp_mb__after_atomic() is appropriate (which often ends up being a
no-op).

But commonly you end up needing a smp_mb(), which serializes whatever
action the waker did with the waker then doing that optimistic
lockless waitqueue_active().

>    /* no barrier needs as both waker and waiter are in spin-locked regions */

If all the inode state waiters do indeed hold the lock, then that is fine.

               Linus

