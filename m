Return-Path: <linux-fsdevel+bounces-65126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C34BFCE7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 17:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9901507FA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D72737E8;
	Wed, 22 Oct 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HMpPrdks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B80221FBF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147096; cv=none; b=Lu6wVOg3SNdPs27kqSNlb0tJQDUksVKwMtRsdYxFjC0flIWmZAP5HWUw/qsJ8yqMRAXowaLtu2xsccBZP1iAl0f6sbqWuC7pUthtiJvebXnGm53JPiUVqqi7fg/JZBJmdUHmDMst9gRhNK5FRYOhg+BGN/zwX6PSpsVj99t+rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147096; c=relaxed/simple;
	bh=frz6LwjYFBZol9A9scWqXd5jqp7+w+RmG5raT/3fNJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D06g32N7JGl7AszLe+6kMAwvsBop3Ur+Hvtf7TEBG5KDGUEWSrJBNTKBHY0YPKRawQwCw5JyQ0/8yggF2wN5+yi9zHSv4L3JLel0csWURsq+HRX8EOZ0NBDxFYsuSwg+9QLRIq3wJYYhI7Ygm12egfipl8b+dU0CsH9YKOK2Vg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HMpPrdks; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1368170866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761147092; x=1761751892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7W+TKsiVoFH6YSztkZcDFcv21KuO/v7xKh45svbjJc=;
        b=HMpPrdkscHQ6qDAiUATyNn4i+D3OHYYaQLEViZpRGspHay+lsOFhjj+N3JQNU5V8jJ
         /+7VOzZEx4P9Ng/Ug4EOorwIHVjg14g8QsyjLwU8sXgxIhOf3fYkhirFocCoacS6BHV4
         Bt1y6HCYFLVChpNCOmgAs/L0kpIR9igTn0fOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147092; x=1761751892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7W+TKsiVoFH6YSztkZcDFcv21KuO/v7xKh45svbjJc=;
        b=Pown70N5n6aJE2d6KfAXYTpUh+uPfGda5ATS21HS4ABKPU7RBMuFDrUO2Hx5SYDE87
         R+rrm330cjqkBoNVK3KVLD3MFuEcFa/7o/JnvLDm+CcqLXkVJDqqJGp4JYpAy6i63Im/
         lZRq6zVOAXXQHsBBr//ysZT4k6HW7BjYDetAX3ZF6P1nqJsyg+ACEsyzHYC8BN4K03WR
         MNifzOqsO5DS4xfWY2mg5sxFdgTtf5d7HKVhwo6SsekrAW+eDw9cMN8CHZpABxU7LydG
         gI2Bxbx18IU4j0p1//XtASNL5mXMLh9uKl9b4jpdWeNOyGSFvalh2tTiJdgfKRUSH2Rn
         kVDA==
X-Forwarded-Encrypted: i=1; AJvYcCW0qW+T2b1OcGSCHdwD/amSC5kiIx1cVICBnks/oxjke3DxTSUrqrhDD2gBIxa5UJLwO7bjsMK3t38EGCi3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5zMNzTwokjAAAwAF6ZLTn5xf35+tMcUB6Asa/sb0n0FFffskq
	A4QKzdCwCC7Jn1D4/UqeRDwbDYgu2AosExMnXu5Nmt1PIHW3ZL+aB8U6+RTHKMmxc51UQMEGKMP
	yd6ID0z8=
X-Gm-Gg: ASbGncvt5uTym0gQGtossMozKiQbOJ55y+yhuDX8O+GD407+xnYnofJbcBFzYegIMiu
	HWV7Xu3jjcFtr1vnFDEjuo2ZTMARLua6p7qzCGL6PIbZ6CqVAbZf/cYlz8I+OpymTsNbiHCtwPT
	yK5hlTGe9WDjBEqbNm1cOzSnpq8vgJDJz5cCB4J7h6IuJvekXBo0ClG50lA9F+GzLiHTAgItxgf
	ehjwT+fTSxTFtKCOhu/26injkN0Ce1US4hLrTuESHQSQqB1bcMfGXqcVT3ASdFI4wUhvdfmZ7ur
	y+BvRL/iewOpY0WQEwcdL1xkS0kOWyVlPLDbEQnnlMhc8jceKvl7jQSzqGeHXAFHSwi9JjAbHO0
	twowq69zDdnHJKJUbVhXvQLb8tCwoB4KMjQ4mjF2W2fVKP7cplkL4A/ndSGYCd6hKvYM8mU97z0
	C7aXh9r8zDgMhMRz8PBLotre7UqQ7yPvhA4i7kgZvWStg305Fn+w==
X-Google-Smtp-Source: AGHT+IH+5UZHHpz7SZo7lRJyLEPb+RBFPoHgIUx5T/7diCUWkYP5S2C0oA1HI7DcP7LcNu7YBNl2ww==
X-Received: by 2002:a17:906:c102:b0:b3d:73e1:d810 with SMTP id a640c23a62f3a-b6475123636mr2228224666b.49.1761147091819;
        Wed, 22 Oct 2025 08:31:31 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb0365e1sm1372062966b.48.2025.10.22.08.31.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:31:30 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4aed12cea3so1164101766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 08:31:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBqXF7l0p9reg1RCCjw1Sw2aTvJoKBpP85ximBDA/h2vc73Q91B33h8A6eBCrb0y8IXxViQV6rH4WYL0/m@vger.kernel.org
X-Received: by 2002:a17:907:980f:b0:b3c:3c8e:189d with SMTP id
 a640c23a62f3a-b6474b37113mr2725824966b.32.1761147088921; Wed, 22 Oct 2025
 08:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
 <aPgZthYaP7Flda0z@dread.disaster.area> <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
 <aPiPG1-VDV7ZV2_F@dread.disaster.area>
In-Reply-To: <aPiPG1-VDV7ZV2_F@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Oct 2025 05:31:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjVOhYTtT9pjzAqXoXdinrV9+uiYfUyoQ5RFmTEvua-Jg@mail.gmail.com>
X-Gm-Features: AS18NWBLPYl4FSdSEwqLouztsANoG3qy-LQaVLkVbPvmlrLzgiJvczojC-Vgh9A
Message-ID: <CAHk-=wjVOhYTtT9pjzAqXoXdinrV9+uiYfUyoQ5RFmTEvua-Jg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Dave Chinner <david@fromorbit.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 22:00, Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Oct 21, 2025 at 06:25:30PM -1000, Linus Torvalds wrote:
> >
> > The sequence number check should take care of anything like that. Do
> > you have any reason to believe it doesn't?
>
> Invalidation doing partial folio zeroing isn't covered by the page
> cache delete sequence number.

Correct - but neither is it covered by anything else in the *regular* read path.

So the sequence number protects against the same case that the
reference count protects against: hole punching removing the whole
page.

Partial page hole-punching will fundamentally show half-way things.

> > Yes, you can get the "before or after or between" behavior, but you
> > can get that with perfectly regular reads that take the refcount on
> > the page.
>
> Yes, and it is the "in between" behaviour that is the problem here.
>
> Hole punching (and all the other fallocate() operations) are
> supposed to be atomic w.r.t. user IO. i.e. you should see either the
> non-punched data or the punched data, never a mix of the two. A mix
> of the two is a transient data corruption event....

That "supposed" comes from documentation that has never been true and
as such is just a bedtime story.

And no, iI'd argue that it's not even documenting desirable behavior,
because that bedtime story has never been true because it's
prohibitively expensive.

In some cases the documentation may have been historically "more true"
than it is today just because the documentation was written so long
ago that people used a single lock for everything (not talking about
the Linux big kernel lock, but about old BSD model of "single inode
lock for all IO").

End result: you say it would be desirable, and that might be true in a
high-level way when you ignore other issues.

POSIX is full of these bedtime stories that depend on a simplified
version of the truth, where the simplifications means that the
documentation just approximates reality at a high level.

I think it would be much better to fix the documentation, but that's
generally out of our hands.

            Linus

