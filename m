Return-Path: <linux-fsdevel+bounces-52408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C974AE31EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 22:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1015C189038A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 20:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0811F3BB0;
	Sun, 22 Jun 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7/bT2/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301CC156236;
	Sun, 22 Jun 2025 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750623540; cv=none; b=CMQZg0j+O/m0hSqWy6RhvuLNOgzoHxNwW1K2zPy3RFVdbe+jJpSHSopyFb+4jEsbCluhpjKMdjoBJdRYpHAj1r+NtY538NJLu5oV0jt62gBfiIi3Twh+aBSkPgt0MQuG50mmn1nejoyR1UqyW8KX4BnDMAHADd4cytWtZ27FD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750623540; c=relaxed/simple;
	bh=grNl6/h5s+IghpKefWldlkiyx24EtQYBEfwr6VrmO+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tf8oXMpfc+eQ4lbxWLOwDUH4DUFpggJbtpqmwCD8DcVdsPVgknqmnkRsvpFTatij8SBpuDCJH94IHhA8EuMEw6vppVWRZDQLQMG9M3YeyQgBTDIIBc3pHlvkydIiHG+NjHJEeCLlNhEEsY3kLAkYJUZJhhMpCefdEvQbIIvpVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7/bT2/1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453643020bdso19030665e9.1;
        Sun, 22 Jun 2025 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750623537; x=1751228337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr4/VSOPhXARWL+bOVMhVKBcRaNKG6LoHmVnJev7O/o=;
        b=Z7/bT2/1re0gIpe7N/Cff6cKQFXkVqsSr/Kis13eErfQBe2D8fF244EcU5B7/OL8eh
         4MjZLnkT4dCr5lRw3jY6FUj+hOr37ggxrJMjHx9+C/NMO8BxtHQStAvNSaduRagZSEq6
         AVO3h9XGEle1t8c2eoCKapq99PQxSM2hg+VH6UmbVuOtYwsC6HJsnggKmdC5ShAw76n6
         V5uRssQNpF3A7l9N7BxJK1tG9pB651/LSc9a6mG2RogbOLiqyHXRYm5BK5JkQ6zD/DhS
         kdb7LW9Wy1lJloIlr42IdiZ91L4gEc1mZhf+ix0FfbnHXXQnm1vFC0D+QYTNb4v0bEqy
         Ia1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750623537; x=1751228337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pr4/VSOPhXARWL+bOVMhVKBcRaNKG6LoHmVnJev7O/o=;
        b=byFvK2KVAFogSdUQlWEKh4q7ponrR2ZsNDi7o2o7uBBr1Dvzv3kIHtTRauIX8VB7lz
         87UKcOTH6zLh66o5w1cI26FlI4psE8N7emueMQYWfArpXkwh53hm2BLYYI7BvH5bDlE9
         jEkkfxJEwSZXmc4nyZZBDJgQrT/I6GfaCZGV6HWuRIV+e17ua6ecyxXhh29gzWtoPoEB
         FGELVWMB3ETIfy5U0cVVLsrQDApB/wg/m8plh2VhF0TIMnBucSD3ZpD9xOgMdylJmuMp
         GSeYQPGFEyhuKqBYAzcD86vck8Egc1dhbiugn+jYEFfg4gwBCu92BTm5HegybVCbMdid
         jTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF3F/l+SbZnP17izoxvpCKxcnLQO9B/iV6IjGoqbGYnLUO1EW+jrr2DdRgBkThkbMpeo4ece/yQA9/QyZh@vger.kernel.org, AJvYcCX+WL4nky6H5rBevWxqXl6aNQMrVuQYYkavtMKbIGtS7f8iU8c79xlNSCYA4whXDOeLYCRxTKROuVGUPXSP@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBMEQX9+9v90EhiPbg5buLla5Pmio75WQZoltdQ9cnk+jtYKt
	MvS4WCjBLVfL6wSbgxbhud4RiAwKzUrxDTKeTH/kCVtvl9sOotbKndHi
X-Gm-Gg: ASbGncuIKscmz6VaFWBsw962ZzsCCCOhr/oyfqPu0lp3TMQPiJOalqH9tATOSGSMI/U
	3BgJdACXT0O/IoHPkTtI+aZM25tdILkQLgNqC6fVYQw2hOPIkhMpc6forf+thLl9925gQWE9Q7s
	LZJ6+E4L/brjQkI39AgRlT2KfCDXvYXpCG1WwNsILpVe7EncQdUx8JYS2QJ/33SV52oUPkj/Fab
	FMUxE6XG1zLvYpJASRJEH9t7MIHHXLyWeBid//VgMoWxCF5DhzWZyJp5k+yWCGTZl5+OXnx0YY2
	QDo8CrwNaLbRskRo+ZHbuoRYvRuVps5IB1Xa8uCdfi8Sanzcv1jIj0s1uxdfRy+bpnJoj5JzXAa
	wIA46iz3GFal0BVQQ3WcbWrPW
X-Google-Smtp-Source: AGHT+IElsMZ2fJjwqKXfyVpdKdO8zPbMehF7uv/JZtWl4fvT4tyhNfUZ6+9Rb0gPk0YEsBVPO/RZ8A==
X-Received: by 2002:a05:600c:4452:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-453716b567bmr20424905e9.7.1750623537213;
        Sun, 22 Jun 2025 13:18:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e98b48asm123388755e9.16.2025.06.22.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 13:18:56 -0700 (PDT)
Date: Sun, 22 Jun 2025 21:18:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 2/5] uaccess: Add speculation barrier to
 copy_from_user_iter()
Message-ID: <20250622211855.7e5b97ab@pumpkin>
In-Reply-To: <CAHk-=wj4P6p1kBVW7aJbWAOGJZkB7fXFmwaXLieBRhjmvnWgvQ@mail.gmail.com>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
	<CAHk-=wj4P6p1kBVW7aJbWAOGJZkB7fXFmwaXLieBRhjmvnWgvQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 09:57:20 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 22 Jun 2025 at 02:52, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> > The results of "access_ok()" can be mis-speculated.
> 
> Hmm. This code is critical. I think it should be converted to use that
> masked address thing if we have to add it here.

If access_ok() is mis-speculated then you get a read from the user-specified
kernel address - I don't think that matters.
The hacker would need to find somewhere where the read value was used
in a test or memory access so that side effects (typically cache line
evictions) can be detected.
But copy_from_user_iter() is pretty much always used for 'data' not
'control pane' - so you'd be hard pushed to find somewhere 'useful'.
Not only that the cpu would have to return from copy_from_user_iter()
before correcting the mis-speculation.
I can't imagine that happening - even without all the 'return thunk' stuff.

The same might be true for copy_from_user().
It might only be get_user() that actually has any chance of being exploited.

> 
> And at some point this access_ok() didn't even exist, because we check
> the addresses at iter creation time. So this one might be a "belt and
> suspenders" check, rather than something critical.

IIRC there was a patch to move the access_ok() much nearer the use copy.
But it didn't go as far as removing the one from import_iovec().
Although removing that one might make sense.
(I've also looked about whether the 'direction' is needed in the 'iter'.
98% of the code knows what it should be - and may contain pointless
checks, but some bits seem to rely on it.)

	David

> 
> (Although I also suspect that when we added ITER_UBUF we might have
> created cases where those user addresses aren't checked at iter
> creation time any more).
> 
>              Linus


