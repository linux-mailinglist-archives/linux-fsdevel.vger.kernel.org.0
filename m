Return-Path: <linux-fsdevel+bounces-22687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F30FC91B0A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 22:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42408B21AD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ADD1A38FC;
	Thu, 27 Jun 2024 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1yALOX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732E1A2C25;
	Thu, 27 Jun 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520760; cv=none; b=bctYBOpwDNlMTjvMQ3uUcIcDi6hAXq6+1X+kMogEIE091FPpUpyDHmAtXRIHWK+NHbOKQo0M2unmcQ3qOuG2c5BBJiKqpUJnlGijnurRu7u8UY98YkGhhAs4TFrgCNDn5B07Ixj9Y3E4fKz+1bpGTkXdQ7nNKxjuP8HJNf9cVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520760; c=relaxed/simple;
	bh=ygOXSRJbnNQdyHCECIvl37zEXo8k5jpFmObJDlhAErw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpVcAahewqOVmj5V6UQMjaq7hFYUS43bpGpHszI5H/ZvW0YQ6T2BIjibM9FPfqc5PAs5mCsQS54hbNfc1d9xMyCbgHFkDiw5JqBP6OhkK9bU9dxManxwOSwMIj0VwQVmAXqv33G9eeW08yLNlOcurSS6i9JxrrT1XOeWaWjpykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1yALOX3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so68357665e9.2;
        Thu, 27 Jun 2024 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719520756; x=1720125556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxkqSPLSZ8WVJ8qA/5pMZTxdnGoTZa9LTxkjHCNUlZg=;
        b=B1yALOX3QkXX8Z6BG33wNzJKsBnV5l7wZUSgYbTRPs4w0ObcZCRQdeNWhLinmg8JMK
         ASCTC0ENiIvn5aWbZ9l6LxJS3WtPcR0//iPYctNHBm8s6mYQuCEt5LJQJYAcHi/6Iejt
         rlnpovxZsRiFOYR4yFs5A4CQbFbzB1HTAEahcKdJpVOr2E6znJsscEZq/08ekc51rFMS
         eigMJrVhdZRBUV8XGBDwmAtONcijC1b0DDChhm/Gx2w0z+fMcNCN6umoeqTmenCsAYY+
         3rk9VCKAdzWwJrYmPOI0SzYGOd72F3yDKQykGFuuCyOHORPS0WLaW+a3Hm2LpUDeO9xm
         uYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520756; x=1720125556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxkqSPLSZ8WVJ8qA/5pMZTxdnGoTZa9LTxkjHCNUlZg=;
        b=jhpooLdUPR2XV7Emp+i6nIYpBBVGeQADIjzZOrXV3wgDWNL8HHoKreW3VVN87pxXiH
         9K/9s7MYYwebcchtBuRkhkru37TQ4dA+lI3AO+TnPdKJPyxbFP/DDE8MlrLqtRRn7xBp
         Lf3KzX4ujcW7FinITifX+zQ6HFFwMYT1LB8foseIVzxdHLc+Jq+XjUiugJyk88gAnZYf
         kLF8tgKsWMP2N0OpMqR0hHX8s3SiQgxb85LzH8eVT+davuo+ExcpK8TRL9yLFCbLxDLi
         LoGcbDob1mZduGJZCJ/YgklnE50svbIzO0PHCZ9yQ5zcaN8uvXC0VQoIWkWUZeJqMja1
         aSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy/+d8S63jLYOd8s9mr2e8MZfnHmJ9fEjFqq/S8O/biq8+Zg35kHbPiPUZmYSukICgkiC+znI1hzqemgt+N6pbyVmjTPZ85AIMUtXr2DpPILbaXQhFbMF6G7D4uLq6W6pV+hQedHSeFJzJcg==
X-Gm-Message-State: AOJu0YyDmfpVjN+hLH6YrjMXKu+TSSQKF1CtIZLKVUja7fdRGHY7D1Tw
	8Bj7k5lOX4/aZdrNfXy2BasbQzH5YpDA3Q0w+G5uNK+wQAVa1E/P
X-Google-Smtp-Source: AGHT+IFp6wy4V+XJozxcZ1RwiAljDE5gB959PiYO/3inJwovYyKVDd1cYakxkcuEl7/1ZPYf6tfKpg==
X-Received: by 2002:a05:600c:3b16:b0:425:52c7:1f14 with SMTP id 5b1f17b1804b1-42552c71f73mr37988875e9.24.1719520755859;
        Thu, 27 Jun 2024 13:39:15 -0700 (PDT)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097bd6sm6892345e9.30.2024.06.27.13.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:39:14 -0700 (PDT)
Date: Thu, 27 Jun 2024 21:39:14 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 6/7] tools: separate out shared radix-tree components
Message-ID: <4b4361cc-3a29-4dbf-ad47-a1d8d05e7781@lucifer.local>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <c23f1b80c62bc906267a8b144befe7ac96daa88c.1719481836.git.lstoakes@gmail.com>
 <3kswdhugo2jmlkejboymem4yhakird5fvmnbschicaldwjwu7x@6c6z5lk4ctvy>
 <c2797b55-59cd-4731-899f-015631c1e553@lucifer.local>
 <mqqoj4c2777ypdmj2o5xyofvitytijfuxwjqujnaww7y22zrob@rof2tmdb7hwl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mqqoj4c2777ypdmj2o5xyofvitytijfuxwjqujnaww7y22zrob@rof2tmdb7hwl>

On Thu, Jun 27, 2024 at 04:03:21PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [240627 15:47]:
> > On Thu, Jun 27, 2024 at 01:59:18PM -0400, Liam R. Howlett wrote:
> > > * Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:39]:
> > > > The core components contained within the radix-tree tests which provide
> > > > shims for kernel headers and access to the maple tree are useful for
> > > > testing other things, so separate them out and make the radix tree tests
> > > > dependent on the shared components.
> > > >
> > > > This lays the groundwork for us to add VMA tests of the newly introduced
> > > > vma.c file.
> > >
> > > This separation and subsequent patch requires building the
> > > xarray-hsared, radix-tree, idr, find_bit, and bitmap .o files which are
> > > unneeded for the target 'main'.  I'm not a build expert on how to fix
> > > this, but could that be reduced to the minimum set somehow?
> >
> > I'm confused, the existing Makefile specified:
> >
> > CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
> > 			 slab.o maple.o
> >
> > OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
> > 	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
> > 	 iteration_check_2.o benchmark.o
> >
> > main:	$(OFILES)
> >
> > Making all of the files you mentioned dependencies of main no? (xarray-shared
> > being a subset of xarray.o which requires it anyway)
>
> After replacing main with vma and dropping the vma.c, I can generate the
> vma executable. I had to generate map-shift.h and bit-lenght.h, then
> execute:
>
> cc -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined -c -o vma.o vma.c
> cc -c -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined ../shared/linux.c -o linux.o
> cc -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined -c -o slab.o ../../lib/slab.c
> cc -c -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined ../shared/maple-shim.c -o maple-shim.o
> cc -O2 -g -Wall -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined -c -o vma_stub.o vma_stub.c
> cc -fsanitize=address -fsanitize=undefined vma.o linux.o slab.o maple-shim.o vma_stub.o -lpthread -lurcu -o vma
>
> Dropping a number of the pre-built items.  When I looked at the list, it
> seemed too numerous for what we were doing (why do we need idr, and
> radix-tree?)  So I tried removing as many as I could.

I did see link errors at some point when radix-tree wasn't included there,
I'll take another look and see if we can reduce to a smaller subset if
posible.

>
> >
> > I'm not sure this is a huge big deal as these are all rather small :)
>
> Yeah, maybe not worth the effort.
>
> Cheers,
> Liam

