Return-Path: <linux-fsdevel+bounces-58854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1487BB32277
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 20:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457EAA06447
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAD12C08C2;
	Fri, 22 Aug 2025 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjn4XveT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7E1A0BE0;
	Fri, 22 Aug 2025 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888793; cv=none; b=kQDOavcFK0CLX73rphVkWrcxGeIuUGzjNtDKrNb0C+fnbKCHG64iHvF2ihUwTyROWc5qC23IBPCNIT73Oxd0HCiaJBIrOGPmOt04V117z90iMLptMXvYpH6AezpjTSx7qQdYcK3OtBG5wgTYCLJOHQWME42d5L3uMYYvgUURwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888793; c=relaxed/simple;
	bh=o1DP4NTDT2hpHWzi15ZfKL3uEkjLv//VbMHRkL7Xv2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQlbmdkfnAh5ZztrMvXqETu/dz5NAf80ymmT7l7zBu4OC8I4IYXggAFoUCwbKKfCBrMvYOx1YsL9Fl8niRqsLfSIhHstPGLZ3ycuPHRbRF6HveoEjYqEXFdmX63dmdExIQPE3F4vKYuOK/UYMbG4QUxPhni/Iox9XPPFgi5Rv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjn4XveT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso12327405e9.3;
        Fri, 22 Aug 2025 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755888789; x=1756493589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgQUn5CtNABDqKDSDivPq45BncqGSev+VDo5NGeADv8=;
        b=gjn4XveTr1ZCAjw4BlC1nueMJcVb+RBE4n1s2OD7vm+79EmNd2SG8C51xRTDCzT5QR
         DEgBXUJQyWf98hQ3+weEEOh9YcyOJ/L4NLd2IWyDac0PuK7+Bk7sEw6AAvR1LHwlS6q6
         UBjAak6yPFLjtZmTqNj4Q5UWIj1PxcfeZLsKYgd5ZzkW39JR4+g6sceXjMUnBL5HX/Dr
         RIxOYGa2DeO6F6F0D3lkVMKh1DYqLZyLMfCU2BaRpTRcmdNOyBTS4BSb4LVFOk86WOgX
         HUzTp8CSoEgINs/cyvr1cdWS2nn6TfjjZ7iaq5H0SlRBRnxWaVztDlwTT40XCZni/a1a
         jb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755888789; x=1756493589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgQUn5CtNABDqKDSDivPq45BncqGSev+VDo5NGeADv8=;
        b=Wfz9hrgYCvU1JzbcdxjR0Jr8wc2PExgvEiZ0TKqQNKQhAY0B6lF37qGo/iNb9wgzp8
         rTWxR2Gw2uk56JoiKQJH9WYBHwp1AunAz06TYb3Jo95VXPYvsIiniKJeUdfmzUBrG/CU
         9Qp3GqkrY5faXTjXHQ7LNaalj+m6wGPXkDeMhncW8M/gZNPpzdjWDzwgOW66GYtvX3zu
         Iw3yJ3nnSz+uUeH8Ln2vsV0GW5Bq1MRfF1kmv0F0XJ1kXTCernPnuekUMl5MTFSN46WH
         XXZ7fPQj7OMxTFE5EV9Nadx7OfWVIGlahyfM0kD1VRqTRbP2AKDND6JEBNcsHEn4wht9
         A89w==
X-Forwarded-Encrypted: i=1; AJvYcCVtGfLNGpt5SzcM5FJIOYkQs4CacaLUkHTVYLk3xdYIupv4hPYRnGs3RhcLjsLTXLIaPAi20GjozxAbbw==@vger.kernel.org, AJvYcCVvqruZQmnL/VTxZ6/OsNYaE93d04FroVPT846nDDcZIo/WwXVBFuCetENDtf2vTxdigdNKcLHmD3TMIM56hA==@vger.kernel.org, AJvYcCW0XAmdpBb8j0AR4gajFR7lYXLR5i2VTSOhdIevq74y/y6xIvQkxHiqO6PyPu4N5y6QAOXZ2NjHwr2QVw3O@vger.kernel.org
X-Gm-Message-State: AOJu0YyluKFtvhSScb9Q2ei4R94ylY9oAe3prLpSll6oOPUQ7eZJpGT9
	Z8DeUoRQPT+mhoSu95Bf5dHn71ZIFxmCVAEUM0DM40i81Bh/WK5qqGYz
X-Gm-Gg: ASbGncugAT7u6toksWaqXcnwN3poi+BaSLZx0p1hQCPD7U49CHZhrdTo5w7hUAOeit+
	q2UfCzXFkmt0rLhUPaggAzxHFRdeuFaPHWhbovMqIlUygEwBSSUnWgNd1un/GodlnBTuyDdsQFr
	T9pcZd+2PKV2PaYYTqmakFKpB1y79cmHaz8eQdTsnZx4jvNIjz+uku+w/M8sNtITvhrHOedZiDf
	J2PWmoYjKVkZMuPd0PHUYn5oxC3iv+9eNqW4w2ioYN5sKWhXjeSM/gdqOL4X0nlB3CW9L58ACe0
	Z7wziyMX4ST+5Tf0j5+N2TMZ1WQOIjlgUYFxFsk/AExsaX7RpWEFrffEVA8oxt3Eq+j1lSCGA71
	rPA9E4AgbO+yAAaeS6HzkVizrfVfF7wtiDjrpezzU/3kKUsgySlGHyXLz5rvItgQF
X-Google-Smtp-Source: AGHT+IH2CJD7uzzmkgj7levHo8yeRDnD2Rey6jjYpn4mLRK/SjHZtD8Mo7fIGKErdyaVDFxn1SiP2A==
X-Received: by 2002:a05:600c:1d02:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-45b5178e6d8mr38320405e9.8.1755888788475;
        Fri, 22 Aug 2025 11:53:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f238640sm527339f8f.26.2025.08.22.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:53:08 -0700 (PDT)
Date: Fri, 22 Aug 2025 19:53:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Daniel Borkmann
 <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 02/10] uaccess: Add speculation barrier to
 copy_from_user_iter()
Message-ID: <20250822195303.0d9fb6eb@pumpkin>
In-Reply-To: <CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
	<82b9c88e63a6f1f5926e39471364168b345d84cc.1755854833.git.christophe.leroy@csgroup.eu>
	<CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 09:46:37 -0400
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 22 Aug 2025 at 05:58, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> > The results of "access_ok()" can be mis-speculated.  The result is that
> > you can end speculatively:
> >
> >         if (access_ok(from, size))
> >                 // Right here
> 
> I actually think that we should probably just make access_ok() itself do this.

You'd need to re-introduce the read/write parameter.
And you'd want it to be compile time.
Although going through the code changing them to read_access_ok()
and write_access_ok() would probably leave you with a lot fewer calls.

> We don't have *that* many users since we have been de-emphasizing the
> "check ahead of time" model, and any that are performance-critical can
> these days be turned into masked addresses.

Or aim to allocate a guard page on all archs, support 'masked' access
on all of them, and then just delete access_ok().
That'll make it look less ugly.
Perhaps not this week though :-)

	David

> 
> As it is, now we're in the situation that careful places - like
> _inline_copy_from_user(), and with your patch  copy_from_user_iter() -
> do maybe wethis by hand and are ugly as a result, and lazy and
> probably incorrect places don't do it at all.
> 
> That said, I don't object to this patch and maybe we should do that
> access_ok() change later and independently of any powerpc work.
> 
>                  Linus


