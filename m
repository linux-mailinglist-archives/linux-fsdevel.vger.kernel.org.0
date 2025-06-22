Return-Path: <linux-fsdevel+bounces-52396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B2AE30BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA4916C1A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296E1C1F12;
	Sun, 22 Jun 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzAFBn7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821D847B;
	Sun, 22 Jun 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750609251; cv=none; b=nEzvO7vIsYD5Bq++uBzbhQXyM66zV8XWvL9D/QjfgFwvpoFpdwLihHRPjkhUve0kSodP72Q/AnVxQojBvTCiPZgmcNDm7zeu1P2wGCfUw5sd/thmAFIGZcx0iJXATxpZvyN80KoIjzOCQIAbDwpRlJZ12WHYdaxHJPc6r6V9j/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750609251; c=relaxed/simple;
	bh=KgeA7oDZ67O0QhGSLso5xNvldIOlSQ7GNwGk9EZkG+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOrLLrFGGHABw8M52kP5slc3btgGimrOTs82Mlt3lokvPc055Rfa+8HnTOh0xvpa8Ypr75kdi7hReC4N5c6JjAWEH6hXBme1AcHnyrc92f5AJbFHKs5VcX2V1bSOHI0uMV16JTc/fOHfLUUl3n9AfxR/gwjto5SgMbzmKfqF3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzAFBn7z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso29165955e9.2;
        Sun, 22 Jun 2025 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750609247; x=1751214047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9UguERxuhFrRUQfvCGEwWcq0+7rxY/z2LNMvf2rwsc=;
        b=VzAFBn7zgvyiA6bB/PTrx+WHyUNZBfWHxW7ilg5mfoB0gD3/SLYf+1qU2KnrVLhf/b
         Te2g2Y/d99gtYDUoBIxtE5sGrSgMbRSUP6OxyalPOvEv7RpUd/U9PWEaUqdDKU7dJIg5
         6D+Zr06YF1G3i0uy23a46Sk3DPkNZ7YSL+7VKGFVI7kN6kICcPosTW5bF0WPePpp8kSB
         ASgtDddMlUx4G7pnzfrSUldCL4anjlTez73CKn7JIoivBEWCSjB7/Ut1lMm3lgzmEUNj
         y816Z8+7FeztN3qRx7SwQkKU1ILCbIozvZVUiAZ/4yjF3ecFlLgR5HhR1TEQOCAU5Zm5
         uxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750609247; x=1751214047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9UguERxuhFrRUQfvCGEwWcq0+7rxY/z2LNMvf2rwsc=;
        b=fH7Xl0qSBzWN3du13f082yBCtihqZ9HHnvjCXOiB7gVCJqqCcKfo/HJSDDwyZl/aI3
         A1ANYYJi3vTU4bkZo/5zBS4+/XFqcqNW1/zXgLt5JhsxTki+lRcl9XfTmy/xW26VJ91Y
         dJkKkzacUxhx9OJIoMe8HLP5jT7o3En/oXzgz4CJvhPX/M+QS1z0nB0yAGObi0jGfucy
         QwGVhualRc4X0Vwm3Or0x1FgVs4veVXl+Olow+1q0ZiacOtszX6rBIsEE6tLGbqq5OBb
         yFXS0KL5g2RFvgPNr/C9aRfTd7f/jP7H72v5CNS8ZXyyZ2HC4hW4lly4O7gFbw4Iaz0W
         kSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+GE9GiFiuJBd38imlMjxW6B5essgF75uJFUH/CxqvhcLlTSHj+mvhmSkh8qIhu6zTwv4vHBZ5QSKsux2D@vger.kernel.org, AJvYcCW7cBdv+GbhJZwsA2B8NVrCkooMhRWm7LvQIaO4QVSiFg1gw0Nt/jcD0o3uebt8s62jwobP9avndBO4N9fi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uM394juR89XZp4L061JheF5Un1FrWnCwsRC0i3Q/smZaJbLX
	cAWsKuk/RVp+GCPEXFUpeRxEozydZzH8cLVgOrpHf8g2Ow9njuCVrvJQ
X-Gm-Gg: ASbGncuhLWf81Q+U3DgJLfiBEdic+YyKaHl6HyptjfXHAzbFHXc3xexkbgbNnIlJ/x/
	cyG4BuDjGz+Z0lPfrJ68l57Qa11k+ZgGGYLUO7GmxU84h3hReN4Xb3eA5gogHLwRIJVKuKLIeD7
	KOF0YkuKSRqGBlgU4D8YWzd2YyvRuJgZfeXsqwp8gEeYxfGOfuPKqVEcy7kG6lkLe3tV2ZGmANv
	psA2I/4GvzUZZaoMG1MIB4Yzl2c2V9hUVQEpOHJA/UxDZfoOBt14UxUxka924Wz5QnK9Ew3dLWn
	pLx/3hjQFhF/4Yr1Wl1D+sxw2cGgivlm+L82B6f2b2TkbOY/CrhaMxk05BAMJ3JuIv/drY0/xiq
	sgNTWSZRQNwUElDFdn2gUg8QT
X-Google-Smtp-Source: AGHT+IGm8Jkkiej/C+jG1pvkrtKONtBC9in64FwHFjGEl4tQBWrNcO7v48A3YibfheGLyTPhwgFPNg==
X-Received: by 2002:a05:600c:45cb:b0:444:34c7:3ed9 with SMTP id 5b1f17b1804b1-453659f8288mr77140725e9.26.1750609247175;
        Sun, 22 Jun 2025 09:20:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb57fsm85091375e9.1.2025.06.22.09.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 09:20:46 -0700 (PDT)
Date: Sun, 22 Jun 2025 17:20:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, "Andre Almeida" <andrealmeid@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
Message-ID: <20250622172043.3fb0e54c@pumpkin>
In-Reply-To: <cover.1750585239.git.christophe.leroy@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 11:52:38 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Masked user access avoids the address/size verification by access_ok().
> Allthough its main purpose is to skip the speculation in the
> verification of user address and size hence avoid the need of spec
> mitigation, it also has the advantage to reduce the amount of
> instructions needed so it also benefits to platforms that don't
> need speculation mitigation, especially when the size of the copy is
> not know at build time.

It also removes a conditional branch that is quite likely to be
statically predicted 'the wrong way'.

> Unlike x86_64 which masks the address to 'all bits set' when the
> user address is invalid, here the address is set to an address in
> the gap. It avoids relying on the zero page to catch offseted
> accesses. On book3s/32 it makes sure the opening remains on user
> segment. The overcost is a single instruction in the masking.

That isn't true (any more).
Linus changed the check to (approx):
	if (uaddr > TASK_SIZE)
		uaddr = TASK_SIZE;
(Implemented with a conditional move)
Replacing the original version that used cmp, sbb, or to get 'all bits set'.
Quite likely the comments are wrong!

I thought there was a second architecture that implemented it - and might
still set ~0u?
As you noted returning 'TASK_SIZE' (or, at least, the base of a page that
is guaranteed to fault) means that the caller only has to do 'reasonably
sequential' accesses, and not guarantee to read offset zero first.

As a separate patch, provided there is a guard page between user and kernel,
and user accesses are 'reasonably sequential' even access_ok() need not
check the transfer length. Linus wasn't that brave :-)

I think some of the 'API' is still based on the original 386 code where
the page tables had to be checked by hand for CoW.

	David

> 
> First patch adds masked_user_read_access_begin() and
> masked_user_write_access_begin() to match with user_read_access_end()
> and user_write_access_end().
> 
> Second patch adds speculation barrier to copy_from_user_iter() so that
> the barrier in powerpc raw_copy_from_user() which is redundant with
> the one in copy_from_user() can be removed.
> 
> Third patch removes the redundant barrier_nospec() in
> raw_copy_from_user().
> 
> Fourth patch removes the unused size parameter when enabling/disabling
> user access.
> 
> Last patch implements masked user access.
> 
> Christophe Leroy (5):
>   uaccess: Add masked_user_{read/write}_access_begin
>   uaccess: Add speculation barrier to copy_from_user_iter()
>   powerpc: Remove unused size parametre to KUAP enabling/disabling
>     functions
>   powerpc: Move barrier_nospec() out of allow_read_{from/write}_user()
>   powerpc: Implement masked user access
> 
>  arch/powerpc/Kconfig                         |   2 +-
>  arch/powerpc/include/asm/book3s/32/kup.h     |   2 +-
>  arch/powerpc/include/asm/book3s/64/kup.h     |   4 +-
>  arch/powerpc/include/asm/kup.h               |  24 ++--
>  arch/powerpc/include/asm/nohash/32/kup-8xx.h |   2 +-
>  arch/powerpc/include/asm/nohash/kup-booke.h  |   2 +-
>  arch/powerpc/include/asm/uaccess.h           | 140 ++++++++++++++++---
>  fs/select.c                                  |   2 +-
>  include/linux/uaccess.h                      |   8 ++
>  kernel/futex/futex.h                         |   4 +-
>  lib/iov_iter.c                               |   7 +
>  lib/strncpy_from_user.c                      |   2 +-
>  lib/strnlen_user.c                           |   2 +-
>  13 files changed, 158 insertions(+), 43 deletions(-)
> 


