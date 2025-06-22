Return-Path: <linux-fsdevel+bounces-52399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D104AE30E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DDF168845
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81E1F4CAB;
	Sun, 22 Jun 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WHHUAzGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C2193079
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750611462; cv=none; b=qD5sIL+ij871QMn0uY8YpkW2MpqRoBpI+82CE4mw2zbl4M2yHhFhJYkYuwBRm6Hl9FpyNO19YZj7beS2++dJ4I+j+Y4by3C8h03P2VtqOG/CRGudf92197IRYi13QVYVzs5J0kL2/rnTR7my35L4thCwSoIiBPqyX6L2jawHtf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750611462; c=relaxed/simple;
	bh=1zZuv+eB2qla/l9yYAzq0vGiZJhKLWAqb60fO58Zdrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sq7lFfBJaNUNwLNF8YoELYMZBLItP5uJ0/5Pivd2zmZJvNfC48KzQZe6nOKn2PQXqQgZEtkXjbzP1auOZ12EHrQ+8TgJA1I/gSZrN3ZkDlFVuFhBpwCLqdsUK+kzwwrnmwma5dlfIIIAbwqorj7jWzEsKPoGH4R7R718YFKrtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WHHUAzGU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade5ca8bc69so593102166b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750611459; x=1751216259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kH6SnANQ47m1wSFT64o9y3OjbbEmJRBS7PRTptJ1lvQ=;
        b=WHHUAzGU8EO5M6WwP2107O4YFDPUy9y4sxiLxJS3tToXnNbLHlaUfGGSp9naq6jicW
         uEGMw0exfjWb8+mPDfcWHxQbTABwBjpuBBtRk/GgazRJ3wzZH9YrSB0VD4akWgJhNuVK
         3hJww7w0iq6O6UEtQdV/4kn2maKuyNR4EkmFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750611459; x=1751216259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kH6SnANQ47m1wSFT64o9y3OjbbEmJRBS7PRTptJ1lvQ=;
        b=InSJkZry/fCeRr/NZp1Zue9TGBPWzUOSfKmDn68v35ttDE1pVwXbN8sRXlPRwhpea5
         UwPrpGaHDBWtRyDdkPaNmsMuOfJxRxasvPpmUgxrRUAi51jIRTcIBU0Z5vZFamK0Cucl
         cb3bY16yW7pVWWP1nxBTcX9Pq4c94linZFT2RT6tRkhPLojfJ6HNaHfJ+eNJFXfRXcTT
         JEFSqkEQ97OYi6zgVGD9Za/huvkQ4pZonkFGfdrU0+EFAwbpjUb9ABbX15OA8wdCJzy4
         +ueW4wl6d9yr5YLoggUn6vjeCeaZmb0PuRq0WliI4eyElz3lrQoStz89VcJuoMmulHz3
         wd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWJ9vh/7rb8J9G12HXRe/MHWmNB9xkENE4nZN06eEyDLNZhDsSiI/qSURuUeZ0zLn+qnzIOOYLR4RyLwuU@vger.kernel.org
X-Gm-Message-State: AOJu0YzYw35uWjIS4osLFFZ2Jj9mPQhorj6g3DqTY/tEpfdtIoH7inHf
	tZp4qbce70aEr7eSdo5E++L85nMk+6QtAfA1xRI76iN1NdjS76+nyGGv78/zjxFO3epROwUKSoq
	ZKR8KgzI=
X-Gm-Gg: ASbGnctdnXbZT/4rDuG8pDpws4G+xG4iacNMqqkK3MBMDm7UuCLQ4M+OGwMRGILl6P0
	XTO+4ZinlwUJO7ECfn+msCyW4gtFM9hQqn4VIYNpKntVaa/Ehx9L6+y0es16eZ+eDz1Sh21QHOE
	6Pi7I23EMbYDs83ioYWxBAdvaKC/APctnMOrRIEwInNxZDnYbdg0Mn4Gf8PgW+s/NqkJekP3Al5
	DZpeXl1dcpycEzjNlAcAj2plsJ9qiuH2SAmwtcolrQVjHTIFO7wAAXBfEtqv2ZMgIRymIt7sbla
	1nL/odjvEl6AzxiFpSWDQMTEiXemsbHCfKwKaEjLm1NOdVgFwxxeId6V+MjM38khx8C9oMOLBd1
	jyZaHzCL1D4+uCqQrbnwUckvbffBbqOPQNtml
X-Google-Smtp-Source: AGHT+IFGhGQ9mC03rHVblAoSHo2qUeAnzgTboVkWkM37jkz8qDt10/5PZKAuhJJ6JgMVIbOOTKJKmw==
X-Received: by 2002:a17:907:3f90:b0:ad5:3a97:8438 with SMTP id a640c23a62f3a-ae057b4584cmr974850966b.41.1750611458905;
        Sun, 22 Jun 2025 09:57:38 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054080a54sm565345866b.102.2025.06.22.09.57.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 09:57:36 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso6640409a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 09:57:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnXyKcVC46EozpwmIzl+/TdA8Id8ZXNo8CS1poijxp7B9kOWTrT/ZusYHLp4xRpZgCLTnuP0kBWBams4oU@vger.kernel.org
X-Received: by 2002:a05:6402:1e90:b0:608:3571:6942 with SMTP id
 4fb4d7f45d1cf-60a1cca9d65mr7384121a12.1.1750611456313; Sun, 22 Jun 2025
 09:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750585239.git.christophe.leroy@csgroup.eu> <f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Jun 2025 09:57:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4P6p1kBVW7aJbWAOGJZkB7fXFmwaXLieBRhjmvnWgvQ@mail.gmail.com>
X-Gm-Features: AX0GCFts7S7trAg95_9iRhGDGkpXCnUtzlq1LLaD_2GFvkl-rWcgRNFXTCHwODg
Message-ID: <CAHk-=wj4P6p1kBVW7aJbWAOGJZkB7fXFmwaXLieBRhjmvnWgvQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] uaccess: Add speculation barrier to copy_from_user_iter()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Jun 2025 at 02:52, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> The results of "access_ok()" can be mis-speculated.

Hmm. This code is critical. I think it should be converted to use that
masked address thing if we have to add it here.

And at some point this access_ok() didn't even exist, because we check
the addresses at iter creation time. So this one might be a "belt and
suspenders" check, rather than something critical.

(Although I also suspect that when we added ITER_UBUF we might have
created cases where those user addresses aren't checked at iter
creation time any more).

             Linus

