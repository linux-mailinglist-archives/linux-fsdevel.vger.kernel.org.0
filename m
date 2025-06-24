Return-Path: <linux-fsdevel+bounces-52791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF4AE6CF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FA84A3FC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8E2E338F;
	Tue, 24 Jun 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRcqH/CW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F76157A6B;
	Tue, 24 Jun 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783811; cv=none; b=OaeS3Uy6syWlgCsBlS7NgjlXcZF8WOiBDk8iEaSsPzr8PATPQdzkL/7gQ7ZZ8H7uxiahLec8KCvzPCzOzJiocBv8SIXzcxmld2GKdXgZ3ZrIn29t9hYQAK2Qx74E3aeJ27+H3Umt6LlKAAsq5eld8qM1dqk40ywEZllHPF116C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783811; c=relaxed/simple;
	bh=A3ZBVkU52Nyhk/HLTgrSeZH/3gR4dsKnh3QElCBOqA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdAcW0F2Tt+IdxNhYLzWyve3J+1ma+AkpQpy6EH1ypEL9TVbiYjQ9mqAV9iapv0C2LbQ7IviAZQ7/ldFtfypfP2jaP1bFE+hmbq1mGiZIxY5UbMAF+c2vy0Fj3nts1tcA66NDkHysIkZUSU3j50PWNeXi1X5Se555Lki2Pq4jWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRcqH/CW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4536b8c183cso381855e9.0;
        Tue, 24 Jun 2025 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750783806; x=1751388606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e3hnOeuzSCQasYOAxsJ6u0yD/pA+ufnXI0wxwmTU+4=;
        b=bRcqH/CW0XL5o5Gnv9LhQEhgDuM7SHAxCwi/rCv77BgLnl/MtvnoSvkYuYHqI89Unp
         Lvw6q+aFxXpxKXvtbxemL32ojxf0T2g5tcbwb7VzMTLJRCZXmj+tvtK9h17sJO79dHQb
         hFAlstnotJ9dOAJLo78PJALig1yIAp7YLqUA8MD4iMk4UGsLEyHX2A5g3a3gcL2ermfy
         plVDRMeUvEw4CQf178xqB/UIUOCDrkE6efrCdHE3Rwk7Yh9KK2LXZQTHptYxrAclbepW
         Gpirm7PsmRwIbvVT8Chj6tGtVGDIo8vNv5PFw5hSsbdn1dwYZtIyI7KD9fMpkwfOv6n9
         8CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750783806; x=1751388606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+e3hnOeuzSCQasYOAxsJ6u0yD/pA+ufnXI0wxwmTU+4=;
        b=KZuT7Y+T1fp1hwx0p/hIJf/xlqf6R7rZsPZ8/GzjhHLj7RiPWhDQApZ/ENjp0uu6ny
         G7Wg3vM9gmtGGzGeDwdNLjoWPNR28YrhB0iasPlwPWXohIDxyzP4mSjXGkAYG8PGchCv
         3c3akdre9jHqLes94HbmdrBFTF4GIOV5+J8Ushdsq8lLPLiPOGa9TOChocRNa1/z2CRg
         yETr40/MCjExsUgA2iJKUuRrqcPT/4pBfpi2ulRJfH56px9JKf/MLhjQQqRg1I7WxEoB
         hEo/tTxGDQ/D2x3dSVv6D7hBLUuysWFI+uniklhWMXSFjO7DIjVjKRGXT+TtyG828vK5
         gC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5zcjBUA7jTlRjE+i8H8zSyr2fTPQIbF6NPbL/vd5npB8M0Prid307wet/24Drimtw8QYNekFYMlHESMHU@vger.kernel.org, AJvYcCV7d8BchYohVmViq89ElQuRwOHLoCbNysOw8OfiXCjUbMSg21R9FFaTMw5j1Lle6lbH8brFzxWIibyFrnS8@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnL7Luhevs30I8VnV/SKex5u7OGTwa1Q6tc3siVW/xzRDvrg7
	rxYkekkGS3Qu81Fui9i2qpekwvVr0O+7IBABcRSTUPwf0Ggigrt7x9B5
X-Gm-Gg: ASbGncuqbIOywuqdyEJj92zA5VijNEwQuYxXUQ2siatLjqU5XzUktFu1//UZ4i0bG0G
	hk/5hXQe9qLH2uoUAOdguJnryN+4FntRC/7/pYbp+tw6aaSLnvVirQBlJskWUfHqg8dQcsExRgk
	gIASde41PeQQiuNYXnujwYin/HVsR6AShnY6TAqU7wPRJeAg6QR9bcvSHPZDO0aiuTpkgRgjOen
	sLjnOt5QMRGfM6vi+8Lftx6dvrS1rZQD40SViUiQbCPezKjZAnb9ozQbEZrc+l/aGCvoTJLmUT2
	K/vOzmDeyxAjMDMTVexdhhy33MUJJskc7PMVdWvHYRcRK3OZNTcC+oRD75xiQAhNm5r05u23Z8M
	YmO7T9muH2TwLvgpCPhabRAaAFqkhQG+uNJg=
X-Google-Smtp-Source: AGHT+IH0NW2taYrThKs/rmne2sj+/2+7M+BO+nO8dYgCHBW+cVa/eP5sOMngFZpqksHY5KrlSUEikw==
X-Received: by 2002:a05:600c:4706:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-4537b79c3d0mr49670815e9.14.1750783805834;
        Tue, 24 Jun 2025 09:50:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646d1391sm147960395e9.9.2025.06.24.09.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:50:05 -0700 (PDT)
Date: Tue, 24 Jun 2025 17:50:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
Message-ID: <20250624175001.148a768f@pumpkin>
In-Reply-To: <20250624131714.GG17294@gate.crashing.org>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<20250622172043.3fb0e54c@pumpkin>
	<ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
	<20250624131714.GG17294@gate.crashing.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 08:17:14 -0500
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> On Tue, Jun 24, 2025 at 07:27:47AM +0200, Christophe Leroy wrote:
> > Ah ok, I overlooked that, I didn't know the cmove instruction, seem 
> > similar to the isel instruction on powerpc e500.  
> 
> cmove does a move (register or memory) when some condition is true.

The destination of x86 'cmov' is always a register (only the source can be
memory - an is probably always read).
It is a also a computational instruction.
It may well always do the register write - hard to detect.

There is a planned new instruction that would do a conditional write
to memory - but not on any cpu yet.

> isel (which is base PowerPC, not something "e500" only) is a
> computational instruction, it copies one of two registers to a third,
> which of the two is decided by any bit in the condition register.

Does that mean it could be used for all the ppc cpu variants?

> But sure, seen from very far off both isel and cmove can be used to
> implement the ternary operator ("?:"), are similar in that way :-)

Which is exactly what you want to avoid speculation.

	David

> 
> 
> Segher


