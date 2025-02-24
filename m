Return-Path: <linux-fsdevel+bounces-42489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F386FA42B9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F9F7A1BFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A66266568;
	Mon, 24 Feb 2025 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DNmokDhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712826618C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422197; cv=none; b=l8nF/AoLy6/NSFwjgLLztzW5XRb2nE7/8mdONK/Ya244Gv1HpcBlYyu0pa13smONaVstuUmTBDIQPuOzHBW/4YIdELKwnMbcI3UvmPUMKdqEEScofEl2V/Pf++2B2DjcJ4IDdrFO+p77lbM/XAtsx1HUVEsx1arL1w1oI+yYgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422197; c=relaxed/simple;
	bh=ZYpSCXidyUjMJOFUCDvYrtypRcnz0voN/kvAQYiPTZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3/umd+Xdz+YkImqDs6CMWK7qCk4BonFMWl5pjXgPag8l7cIpc5tF14zhr8w2DbxGGtl2T2u/UwQsjf/RNql3nTjrh6Qgf65wX758o3EqYg7PU+fl++OOBzEaUp3f2UpVgwvy76QwQ0Bd25JE03HUczYWbl1bHqXvVTj1Lkthog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DNmokDhn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso6377541a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740422192; x=1741026992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjxCPCmnXeGeJyPZ9rvFlcH8jgmw1PsMh4lSp0OiRPk=;
        b=DNmokDhnBUXaLcGJSK7v3bfcqN0DqSjX5WwX5JFWj4qGtvwdU8Vjixri5TjoochpTB
         8eVg7TUA4QsMd/0KvlaL2cUBBILn/rNC2+WCFokyv1RJUl1AsEWYI4rWsW0XDTFYlGdz
         ubSgnUzEAYT9cfRfj5jAmwfj4j63dTcY5Ph2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422192; x=1741026992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjxCPCmnXeGeJyPZ9rvFlcH8jgmw1PsMh4lSp0OiRPk=;
        b=XQZtuJjJcjOu5u2mGgLS/JGlgfj+eCFf4rrxhf1/NlJRWhOTqb3cRKtAvE8X7UJtaw
         RY00oGfXQU1CoEXFfgyH0Og7xcTdtq/7418L7JYCYszLDM3lIcP9XTFQK1DXKpL/Tb9D
         upexdXzBJLliuH3MD+i6i93She9QOtIxq1S7h016HvayUVY6K4TbZdH1dm2pntymOwzo
         v2PbQFVYNKF1ZZ6JPsr5c7bAyOK2qXnK4FJ0lYYEpjbA0uLml1gj86iEMYS26FyAEmdI
         PqjSeJPrGoKqCcQuy/BzGYVwgFiRvMKylT8B7u9xdN8dvUdMo/PYlGlGu4cTj/4AezjW
         CSXg==
X-Forwarded-Encrypted: i=1; AJvYcCWkOe9Rs63b2CrLHaOAB6HKbGRi3bHi1Qin2SE0ldSPIi6os2c3GDITlFrUT9xmsH/8KAUMSnlE+NXO2B9r@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1bGwvBpb2EwAa7A0L2iXJJKipUNOCO1rOmJDL2GMo4pLkhtM
	6huDZqyg5knBRfjRen/KzOD4HpfFA/DOIrAa7Yf1JKbLzi5DAyHhIRPok1MOH8Uo/rWqFVIKYOt
	Gvgg=
X-Gm-Gg: ASbGncuUTtTFtATQcPojumMQwRsJPbwvJZhF0l8BB6+Ds6jbYAca5vrp6XsJXbWXgi3
	RWd960gAZ5y8eC4LsGxUpMKfAnlto1o35Qmmhds2vEU9agVrngFTw0ugBBz3BMTUhdArsdx+pVS
	RHN7ODTb72HwTAbxPWiKxaF6KQR3TWRMXONJ4AZ1JjAqNR2/J8BgflR430Jn8p+zte7XoahAw4Q
	rs2nzXCqxB73hORvq3iPvAjKYeX+Zf0SoBa97PdnnTAyaCM8WaWf9OsJp6g5pPSK+rBYThhwZBW
	lDYLXhQhhheNuI/ykdWzkmrraw1dQ8fVHQXN4BHtOWskB2Zd4jFKdOZwJDj+MUvOjpWAUPVLVRz
	J
X-Google-Smtp-Source: AGHT+IHQ4S8LvNOeqzuYVOQcHCEiGNOzPfyVfsx0l+lQVsfEXaP07UQUiCXqr+GBdOM5IeH9VO9zKg==
X-Received: by 2002:a05:6402:26d1:b0:5d4:4143:c06c with SMTP id 4fb4d7f45d1cf-5e0b7222d3amr13707561a12.23.1740422191904;
        Mon, 24 Feb 2025 10:36:31 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece28808fsm18604874a12.75.2025.02.24.10.36.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 10:36:30 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso737554466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 10:36:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7GVjVenEFKl1G3a09EYbxeJZniFFdabO65hRrAFxmVVqQxaYwBLr79zDcJoqJXcT7kwRahzJitsoNElQG@vger.kernel.org
X-Received: by 2002:a17:907:3da0:b0:abb:83b9:4dbe with SMTP id
 a640c23a62f3a-abc0de4a335mr1505840766b.47.1740422190407; Mon, 24 Feb 2025
 10:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102140715.GA7091@redhat.com> <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
In-Reply-To: <20250224142329.GA19016@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Feb 2025 10:36:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+P5__7LfbTX66shvYC1X11G2ZdKcg4psi+k_pD3sO+w@mail.gmail.com>
X-Gm-Features: AWEUYZlNu7bWtzV6VF8g9lWbkb0aBzMmKrKcCBQur_JXZyZHklFDpxcYe_w5ic0
Message-ID: <CAHk-=wi+P5__7LfbTX66shvYC1X11G2ZdKcg4psi+k_pD3sO+w@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 06:25, Oleg Nesterov <oleg@redhat.com> wrote:
>
> OK, I gave up ;) I'll send the revert patch tomorrow (can't do this today)
> even if I still don't see how this patch can be wrong.

Let's think about this a bit before reverting.

Because I think I see at least one possible issue..

With that commit aaec5a95d596 ("pipe_read: don't wake up the writer if
the pipe is still full"), the rule for waking writers is pretty
simple: we only wake a writer if we update the tail pointer (so that
we made a new slot available) _and_ the pipe was full before we did
that.

And we do so while holding the pipe mutex, so we're guaranteed to be
serialized with writers that are testing whether they can write (using
the same pipe_full() logic).

Finally - we delay the actual wakeup until we actually sleep or are
done with the read(), and we don't hold the mutex at that point any
more, but we have updated the tail pointer and released the mutex, so
the writer is guaranteed to have either seen the updates, or will see
our wakeup.

All pretty simple and seems fool-proof, and the reader side logic
would seem solid.

But I think I see a potential problem.

Because there's an additional subtlety: the pipe wakeup code not only
wakes writers up only if it has freed an entry, it also does an
EXCLUSIVE wakeup.

Which means that the reader will only wake up *one* writer on the wait queue.

And the *WRITER* side then will wake up any others when it has
written, but *that* logic is

 (a) wake up the next writer only if we were on the wait-queue (and
could thus have been the sole recipient of a wakeup)
 (b) wake up the next writer only if the pipe isn't full

which also seems entirely sane. We must wake the next writer if we've
"used up" the wakeup, but only when it makes sense.

However, I see at least one case where this exclusive wakeup seems broken:

                /*
                 * But because we didn't read anything, at this point we can
                 * just return directly with -ERESTARTSYS if we're interrupted,
                 * since we've done any required wakeups and there's no need
                 * to mark anything accessed. And we've dropped the lock.
                 */
                if (wait_event_interruptible_exclusive(pipe->rd_wait,
pipe_readable(pipe)) < 0)
                        return -ERESTARTSYS;

and I'm wondering if the issue is that the *readers* got stuck,
Because that "return -ERESTARTSYS" path now basically will by-pass the
logic to wake up the next exclusive waiter.

Because that "return -ERESTARTSYS" is *after* the reader has been on
the rd_wait queue - and possibly gotten the only wakeup that any of
the readers will ever get - and now it returns without waking up any
other reader.

So then the pipe stays full, because no readers are reading, even
though there's potentially tons of them.

And maybe the "we had tons of extra write wakeups" meant that this was
a pre-existing bug, but it was basically hidden by all the extra
writers being woken up, and in turn waking up the readers that got
missed.

I dunno. This feels wrong. And looking at the hackbench code, I don't
see how it could actually be a problem on *that* load, because I don't
see any signals that could cause that ERESTARTSYS case to happen, and
if it did, the actual system call restart should get it all going
again.

So I think that early return is actually buggy, and I think that
comment is wrong (because "we didn't read anything" doesn't mean that
we might not need to finish up), but I don't see how this could really
cause the reported problems.

But maybe somebody sees some other subtle issue here.

The writer side does *not* have that early return case.  It also does
that wait_event_interruptible_exclusive() thing, but it will always
end up doing the "wake_next_writer" logic if it got to that point.

The bug would have made more sense on the writer side.

But I basically do wonder if there's some bad interaction with the
whole "exclusive wait" logic and the "we now only wake up one single
time". The fact that I found *one* thing that smells bad to me makes
me think maybe there's another that I didn't see.

               Linus

