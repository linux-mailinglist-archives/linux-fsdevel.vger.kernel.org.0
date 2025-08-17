Return-Path: <linux-fsdevel+bounces-58095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A96B293D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7295E207B2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D182E5426;
	Sun, 17 Aug 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNJF3g+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4E2D661E;
	Sun, 17 Aug 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444590; cv=none; b=e2ziq8CiA4+zyRYoau/tKTLjSK81OQPMg1FZ/+J4PwzIvHG5rLUU5XCKYx/ec8qumzcYY6CE+scrBvfj7btWhCaXLe8Jceys00zlvUa8DBpuZcv6oOpH2W9oA6Sy8ZtH4gQaxkFQQA853CdgCK6MXAZyDQH5GapHMmxVXw2/qKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444590; c=relaxed/simple;
	bh=ORgNpsPbbGzaR+Sl3YhShI7w5aioHRH3PTbk28B7N/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oip6e5K+ruI3/mVXAaCIKTwFUHIrR3CX7Vp5+mxqDyVBF0q82W4h9ZGXjD+SqFD06zc2GDWVNLDr7glWfYXqioQ8kgX79gAI3JQHJnGIzEuS8hCq+APlyZvteFe6A2Co6FAqJKaTEM0UxUmGRAe2iNE9Mc4Ul67sF55vPWuRirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNJF3g+/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso2559986f8f.0;
        Sun, 17 Aug 2025 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755444587; x=1756049387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yTHuHE5ww4jge6UHTnIQ3bluATGxTVCe1o4/JqSzM8=;
        b=eNJF3g+/F1mQXSMvqLnRPl8LSszHbtx0JrEQrJ6fotpe/E2GN4kNIeFRILb8RDWeNT
         zWbSXaWk+d5ptYpEYKTp9yXxBsAOS419gzKWjA/jeBUbP0uLNsUdNgXw58Mp6AJQtVfL
         iAXZ2orjrfcDrNtl0qa8fUSa1RsgmoelhcbMd8oPm1deXTMS/OYmt6Y85x2SkH7IORSn
         SUjsJo2lEICGmtxK1mDqbcYzOFqYjuPvQ0pWk1lWbNK6ZOvpE/nbX30mQ5qimIns0ucq
         5Hukh7dNgum06/AwccOPA+NVI9nnuoRJNNePZ9lMlVi6cbciekLLl0zx7tIxhzWc8TNl
         23mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755444587; x=1756049387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yTHuHE5ww4jge6UHTnIQ3bluATGxTVCe1o4/JqSzM8=;
        b=fvjGiCHhj9/zHIErk0pjn5k6D2fJqu82c3docVF75+8doGxMCSQLb04OezDS82zsSw
         W6DTYRkgeLJE5EhFyUZDxTclMibuMCwZy+P1QkVZ9L0OWsO7Dwb7jHnlh539G/QccfRe
         3bf2g0CpDldlfkUWYss5jrz8vzr888PO0LInqprndIwesEPChKp46D46F4rq2jzZfGvV
         zJoCZJHNNNVwP9ypGUP3qPkscY3KOz9b9XxT7HvSr4mnDqXx/VjtXIijziBoKOfeH1vm
         8QhBM+3b3/PLCKYKKjpTkObYP4OjMXbLhwsCA5+A36aiC1os3EPF9+CiqrWtGlDPCw9Q
         p7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2kZ3/xcz2+JRhd/SHZrDlVldcesI+iVr8R0Z3VlsXJE67SIwnihTMMhozHGaHr72a9lOQLQbnHlr7FlsM@vger.kernel.org, AJvYcCWKyuWf050Nq9XHfsHvzhoS7Xgn9YFP9Y8u9YA/vtCFAX88v7XZmboACD7K1GMCgu6C8PXuOiytpceLp0ET@vger.kernel.org
X-Gm-Message-State: AOJu0YyQiJ31t4GzXftIhsIDQQH/RSA4oHZUM07P9j5GWGODJ/pCoYN6
	S4XBioZGpxJhzuqwIfy5L18rgTNQwGf3B8o/qM9v3cgKW8O/+o8Uu4Zi
X-Gm-Gg: ASbGncvNY2cYc86Htyw5jJIPhJ8lgKgauoawIwQlzFwFnE5z7OTzPVkUiSjRDz+aUMw
	ceI3cFr9154AqS+K1pj7ZI8wr1s0sVCnJeCPXukpIaivw/HYKioG/PNUx49W31lkkkUgXmt8ude
	HZxDYgLAj7nAZYQV7B9YZMFcoKeEHk7QqPyVKhGHbmTgHKUXPeAKlMjmraj/M1/M/MYWIQAjbld
	TizPZrLoereQclPAeMvOjmionnH/gU0Ku3F1Kqr6RiN42FF7OsS5D4WPvKAuJ2Ucqgr6G8VMcLN
	pHaSY6YZajgQmVUtxUFmh+3wjq0ceYC4MsRPTnKCr5dSce+QpOZAVh22NlPFZVQr0gRxnYU5dbf
	7cAwIqRRy1pi68XWf2j8L5BlXQy7u3Ug2tGVP/VxBHSKJR1bu0xPySTYzp+wI
X-Google-Smtp-Source: AGHT+IHgsmH0hMubdi6x7XMRlTjBKxUwul3MRRgiwRc4EmKLcW9mFOg8cJ9x2JcckF2vyUVXUEYhbQ==
X-Received: by 2002:a05:6000:4027:b0:3a5:2599:4178 with SMTP id ffacd0b85a97d-3bc684d7b99mr5033090f8f.19.1755444587049;
        Sun, 17 Aug 2025 08:29:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6475863dsm9895754f8f.5.2025.08.17.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 08:29:46 -0700 (PDT)
Date: Sun, 17 Aug 2025 16:29:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <20250817162945.64c943e1@pumpkin>
In-Reply-To: <CAHk-=wjsACUbLM-dAikbHzHBy6RFqyB1TdpHOMAJiGyNYM+FHA@mail.gmail.com>
References: <20250813150610.521355442@linutronix.de>
	<20250817144943.76b9ee62@pumpkin>
	<CAHk-=wjsACUbLM-dAikbHzHBy6RFqyB1TdpHOMAJiGyNYM+FHA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 07:00:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 17 Aug 2025 at 06:50, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Linus didn't like it, but I've forgotten why.  
> 
> I think the reason I didn't love it is that it has a bit subtle
> semantics, and I think you just proved my point:

Just requiring the caller pass &user_ptr would make it more obvious.
The generated code (with 'src' -> *&src) will be the same.

> 
> > I'm also not convinced of the name.
> > There isn't any 'masking' involved, so it shouldn't be propagated.  
> 
> Sure there is. Look closer at that patch:
> 
> +       if (can_do_masked_user_access())                                \
> +               src = masked_user_access_begin(src);                    \
> 
> IOW, that macro changes the argument and masks it.

Except the change has never been a 'mask' in the traditional sense.
Neither the original cmp+sbb+or nor current cmp+cmov is really applying a mask.
I think the 'guard page' might even be the highest user page, so it isn't
even the case that kernel addresses get their low bits masked off.

The function could just be user_read_begin(void __user *addr, unsigned long len);
Although since it is the start of an unsafe_get_user() sequence perhaps
is should be unsafe_get_user_begin() ?

> 
> So it's actually really easy to use, but it's also really easy to miss
> that it does that.
> 
> We've done this before, and I have done it myself. The classic example
> is the whole "do_div()" macro that everybody hated because it did
> exactly the same thing

Divide is (well was, I think my zen5 has a fast divide) also slow enough that
I doubt it would have mattered.

- can you drop a 'must_check' on the div_u64() that people keep putting in
patches as a drop-in replacement for do_div()?

	David

> (we also have "save_flags()" etc that have this
> behavior).
> 
> So I don't love it - but I can't claim I've not done the same thing,
> and honestly, it does make it very easy to use, so when Thomas sent
> this series out I didn't speak out against it.
> 
>            Linus


