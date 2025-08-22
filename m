Return-Path: <linux-fsdevel+bounces-58809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5C6B31A71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83FA17099E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B3284B4E;
	Fri, 22 Aug 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xpx1SkY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81E3054EE
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870919; cv=none; b=np7wMeeI2c4UHbxG0TfiIyB4C7hy5wbcyVCv4vTe355OTKVe0Z/uV2kkT59crqoQeuxfA4DSLYXjAcJk59BJkEO/aot48a3bCb93S8Z9K84xb8mz5PFG8AYJsdOXWK9bHksN5GyknTZ8c8f9q/Riv5cUArbsWTUjI4+r08fD8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870919; c=relaxed/simple;
	bh=APQoGb7oJHGZ6Mj01fq5MbAELxwQW2xj4Pe4Rxnr6cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JP8RfMibrvTl+FBoePy1bdZngDkJjnhblmUKolzH8FMwgW10z1qNpU8SgAzqY1q3je3Ym2N9h4k7MtxoF9rjmMsk9FgfGxtilgyaR3VBzI8jI9X+ouSuY88pr0k0KrwTSdQss55FWg0TcmmS1RDt+9Q7SUWr1L5JLi8Ne5lfgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xpx1SkY5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78fb04cso279458266b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755870913; x=1756475713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NRu/0FoVw+bU0VwjyXzuUF8CXZhxspV/ZyS4JSE6Hqs=;
        b=Xpx1SkY5qQtr+Iar9h6L7oYytzb1a7wDxYe+lmKAigyliW9rMstrai2PzHkv2+0g+8
         aAQm1vGXuA3fON4m1NlbHmePGXnKPM3OZIlCBJj7mI3Wm2x5+kNOkR3xw4jT7A5Beq04
         M6FcY5SS9sK8WQf/l/HiBtqW4iE5X6IR7Fy8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870913; x=1756475713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRu/0FoVw+bU0VwjyXzuUF8CXZhxspV/ZyS4JSE6Hqs=;
        b=MP9/4iXSGSLydfmeofXcOin01ONU88NzJqKz4Pvvb8IXWMPNUrRGLwg1nJkP/HTLK7
         8Os+4kCaaDiwynynxyp+X/u4DQEVhhlTT1vQzImko14Ol2HNM9+PMQsee1auncyUKtN0
         niXPdVTsNyHiQNWXQBscqfyG1cTeORr1Yf72R4iQ1LAgY6Ag8EOqqvP4x8IfBYlU76Lp
         efy7KSRe2LpLuFbS1/wjjG7FBmTWfuhkHs+O3KEBISHX/rsB78uiM/l7OOipkvKACDsh
         CJQgKKMufMN9fa9ECvz9A7/pUXa26hRdyJwa3om74qgGuW9ieb6vwnRuLvRne0ceFPrj
         qvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV4yvBMNJ+Bjkcy4JowuIWmY3JASrgs4hK7IgcjEA4FfItQZ+ns/suPRxv8MAObIZmtLL0xuBlY3CMoTBY@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwln0clSltofLuRUhhktmVvMVXJjgC0FJ96TkpOCMUFFlsafW
	sGsg3azuMXRHk1iFCGX3yRVgd4Xs38q6NN7bsZZye0wZXd7y08n9nxYZ2QcJ4bt/XU+scAt+v2u
	8MWTtVML1FA==
X-Gm-Gg: ASbGncvVKNOZQKBD0JnOmKweQe+I2sp7nLx8NrhJe6Ej5zZvcyara7nolnrZbDjYnIw
	hQpxD8KcZOzR7hzPMcMa1Fq96dNHQtv+DAgCVqVX9y40Z0vtzLGGJFvXNhl22w3ycrCz59Lh759
	p+tngTfp9j+Zdp7kt1Ph83OQBal+wi/CJkrd0etMPoHxY82QsIuBB5BH8nFYkZjosB5UPQKO9Um
	SSTWPU5OE8SSCrkrBDUK/KqitL1PqgpgXbh3O9YYN2Nb2eq84YY65dyA1U1sO2+zt+a65uDeZQv
	xFudHxx+bqqULP1sGwRV4ZkIX905WxJ3VK6n677Bo8ld6HhnE6Mi6N2k7ryYOTH4TP8m74jKaBy
	7vyFa3CEN7RVTL4aYihWqo5DUKtDDw18EGpOpDPYFY0LGE1TndVDQ3CvDl6O+esI6HIN+aomH6g
	EJRhzbEHU=
X-Google-Smtp-Source: AGHT+IHHMePukKiqpPD1DbPaNZGa7sgYcrhI5AH8dwV8gCJsDuLP90TrolqLZtMXoK+Chk/9nW4EkA==
X-Received: by 2002:a17:907:7e82:b0:af9:2668:4c36 with SMTP id a640c23a62f3a-afe2963b037mr268108066b.48.1755870913010;
        Fri, 22 Aug 2025 06:55:13 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded30bf00sm617087166b.30.2025.08.22.06.55.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 06:55:12 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso16386065e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3ZW3Twp3qnLMaiY6tVKyH9/I4dtv0pW/AyNuQgFF2wNCSV9PfeXhFfl8DvYmnw1eKw6+iYYPe7DFKRNcx@vger.kernel.org
X-Received: by 2002:a05:6402:5110:b0:615:6481:d1c with SMTP id
 4fb4d7f45d1cf-61c1b450840mr2274281a12.1.1755870414406; Fri, 22 Aug 2025
 06:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755854833.git.christophe.leroy@csgroup.eu> <82b9c88e63a6f1f5926e39471364168b345d84cc.1755854833.git.christophe.leroy@csgroup.eu>
In-Reply-To: <82b9c88e63a6f1f5926e39471364168b345d84cc.1755854833.git.christophe.leroy@csgroup.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Aug 2025 09:46:37 -0400
X-Gmail-Original-Message-ID: <CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
X-Gm-Features: Ac12FXyg7aT4BFeJsiyaeWdfrE2FPhwu5xUJIJ1D8_vj4L1z_hVeZFuzgKfsNNk
Message-ID: <CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] uaccess: Add speculation barrier to copy_from_user_iter()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andre Almeida <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Aug 2025 at 05:58, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> The results of "access_ok()" can be mis-speculated.  The result is that
> you can end speculatively:
>
>         if (access_ok(from, size))
>                 // Right here

I actually think that we should probably just make access_ok() itself do this.

We don't have *that* many users since we have been de-emphasizing the
"check ahead of time" model, and any that are performance-critical can
these days be turned into masked addresses.

As it is, now we're in the situation that careful places - like
_inline_copy_from_user(), and with your patch  copy_from_user_iter() -
do maybe wethis by hand and are ugly as a result, and lazy and
probably incorrect places don't do it at all.

That said, I don't object to this patch and maybe we should do that
access_ok() change later and independently of any powerpc work.

                 Linus

