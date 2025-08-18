Return-Path: <linux-fsdevel+bounces-58146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA9B2A11E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6ED164B68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF927B32B;
	Mon, 18 Aug 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBy8G0E3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191023BCEE;
	Mon, 18 Aug 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518391; cv=none; b=LaqrI6AIBaFtqFzqgx+/h2x5Mc4K5aPZSjbpnKndaPdlU5NHzLZbNUVHP0Py/56THwV96sboI0d+orKAn5g0aCuEu6JhJdDzsd7Y12jlo8COTQjjEeuwZ1T5pquu/SfB8lSCCmsEdIkJFzdIR1JB4/8S2NIwKKQ4ZN2DypSmo1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518391; c=relaxed/simple;
	bh=AzX3X5Lj7aPjmUThYMPThWZO8JJwB9ysYql6Rl5waqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scrfaXN7p1zZg6tUGWVDSqlX9nmujKx0qGM3Yzzv5m35SjSoqqiGS2zT0gL1CBqZO0PgdndByCF4AwbdtSulIcW16qVihU93i4L4GKABugahPD50ngd5LuA11Oyb2b3C4TdfJzfdo6H/D5OZHLnMncLTmJE7wGd7x/lqzEy6J4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBy8G0E3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b05d252so27474545e9.1;
        Mon, 18 Aug 2025 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755518388; x=1756123188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mxjayu1PY4vc6luxGI5oMLA3DCA6ZC8TJQhtfZr7qSc=;
        b=TBy8G0E3DXbBojAjisAm9f+Gq68OMtcOQDjydVvI+NwPPQxtMyJrl6TDkHn76t5AwC
         NqYmKcbsE1pxAALIMjHeaICz6fDqmLzv69S0kXMDj1BCbXHIEiZ68BvW/c8rS1RTdsFq
         xElOKVyy2W5av/AxrOpa+pXSaLbl96FJgsRExLNJ85Fag1xEedeDctUER7dxJnY41BKH
         A7LVdPwC/mDLb40o5cRFoQ7qRMxkTiff+Ex1g0ne7i0mEbHPxdVEA/1cB01JcbjoYlK7
         Ba5gYlntN+Od4uWD3E7oceuWdBubOjtlXebqijGNBrV9haknZLoJvTZVvbFMcpph6bqX
         1D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518388; x=1756123188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mxjayu1PY4vc6luxGI5oMLA3DCA6ZC8TJQhtfZr7qSc=;
        b=wX3DNw0hnydEdIdjaPxeRai+LnAcDYVFzQ4u11k2MdPTGQCh/xYjjndYWB4+czzke8
         AgnSVIK1t3+ypZIOiKfhrY/7rrDDs0D6fVH/quq0EuNq+MyVdVGGtdXg3YlntbX9ss1V
         XK4HE/P0IczgBPZEptiZXL9YbDFJ4NwHcTkV4+ILodemh8xM10NYTmop/ttfYcnauUI4
         xat5HBaPdfEe9jQpnrIUl5igBNrPAqIQ15W1rCKbOGqZzX7sheMgD0NUyNlPfpFJwHNN
         wnDmnuCPil3xszwLeqHuWqmhccWrthOWHnX61bKiJKQ8ZFPLirZkg9eZMhUWCrrLFdhZ
         vdvg==
X-Forwarded-Encrypted: i=1; AJvYcCWEKLP8G+I2NQuLdFGjthd03FsS55L1u67p1BtMhnz3SPPwFgD7GAP99KTcWs2eHk8yDnW/MZgfM4/eETHW@vger.kernel.org, AJvYcCXjePs1HKD33iqYZBUeFqjYi31iQEEHKPT6gOKK96sbKbItgYc1EYwaTVLohaNQOdXSleb2LMbQewbKA0jx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/Vs2Wi+1Jm8g5jfI0hLomfkSsqs/Kep25EdtbWljbldLVCdb
	7t+d9Kr32XoA1sanflOL2jVKlvoAja32ukSsAZZdB12WaHkmthTxXqk3
X-Gm-Gg: ASbGncsg5oy285+M9f76lny77pzvvzNybcV2Lz7uHwZW3BxjWEHoQdQVCGsWyX8imtn
	FGa8URdy4CQ980Ta/NAdBhvxU+yPZjTLckHKuBAOmZ9HyETv9l7IN9+qQf6vJcDj71SW8VgPw6+
	a2cxG+G0FJzJyRPtFwWOICggk/NKN64qQ8oAc/h9wflbMX16cs8mQJHUHaiHoO7bxUsB9E63764
	3TJce5NMrAamfTfO6nEjeybSt7AOstgY0eC/ASlz7l8iTU5LgW1xWFk3fZAvyCMrBEyQnhpgR8a
	kkQoG+tO8jWO+b7QdhHzuKLeCtp6AC/If+yErPzbRcCqFHhLzGp7PlE+nZktmm5FtOx9fopXTfc
	69ulZz6QsqMqjG3l+a/QO0TAFL6n0M0U2NlTIX+k5hRrWEhIOhoRIDSubkVSc
X-Google-Smtp-Source: AGHT+IFC8kP8yyWakmj8wsexciRHRWNTaRQZn037C5OH8vUmsEElmL4oAFSP2sc7FPRe5nJOi5TJyw==
X-Received: by 2002:a05:600c:474d:b0:456:1ac8:cac8 with SMTP id 5b1f17b1804b1-45a2180b6aemr106438045e9.15.1755518387386;
        Mon, 18 Aug 2025 04:59:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b8963casm91158345e9.6.2025.08.18.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:59:47 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:59:43 +0100
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
Message-ID: <20250818125943.7c0cba5a@pumpkin>
In-Reply-To: <CAHk-=wgpAJiSSU-pVr297PX5kax_VvftXhDaKSrx8mpPxyfHRg@mail.gmail.com>
References: <20250813150610.521355442@linutronix.de>
	<20250817144943.76b9ee62@pumpkin>
	<CAHk-=wjsACUbLM-dAikbHzHBy6RFqyB1TdpHOMAJiGyNYM+FHA@mail.gmail.com>
	<20250817162945.64c943e1@pumpkin>
	<CAHk-=wgpAJiSSU-pVr297PX5kax_VvftXhDaKSrx8mpPxyfHRg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 08:36:05 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 17 Aug 2025 at 08:29, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Just requiring the caller pass &user_ptr would make it more obvious.
> > The generated code (with 'src' -> *&src) will be the same.  
> 
> I personally absolutely detest passing pointers in and then hoping the
> compiler will fix it up and not make the assembler do the stupid thing
> that the source code does.

I do generally dislike passing integers and pointers by reference.
It typically generates horrid code further down the function as well
as all the costs of the memory references themselves.

But hidden updates to variables are worse.
And we know (and can verify) that the generated code here is sane.

A possible problem with the 'hidden update' is that someone could easily
write code (eg in an ioctl handler) where the user pointer is in a buffer
that gets written back to user space.
Passing the pointer by reference makes it rather more obvious it can get
changed.

> That's actually true in general - I strive to make the source code and
> the generated code line up fairly closely, rather than "compilers fix
> up the mistakes in the source code".

Especially when you are trying to code what it thinks is 'a mistake' :-)

> > > We've done this before, and I have done it myself. The classic example
> > > is the whole "do_div()" macro that everybody hated because it did
> > > exactly the same thing  
> >
> > Divide is (well was, I think my zen5 has a fast divide) also slow enough that
> > I doubt it would have mattered.  
> 
> It mattered for code generation quality and smaller simpler code to look at.
> 
> I still look at the generated asm (not for do_div(), but other
> things), and having compiler-generated code that makes sense and
> matches the source is a big plus in my book.

Don't worry I also keep looking at generated code, some of it is
stunningly bad (and seems to get worse with each new compiler version).
Don't even think about what happens for C++ std::ostringstream.

	David

> 
>                  Linus


