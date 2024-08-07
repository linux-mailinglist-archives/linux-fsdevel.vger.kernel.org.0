Return-Path: <linux-fsdevel+bounces-25358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146B394B2E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 00:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4197D1C21720
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C31552EB;
	Wed,  7 Aug 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuUaSKxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194C1534EC;
	Wed,  7 Aug 2024 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068852; cv=none; b=ZqsAlV2UT53dw+2JnAL9P2hpm7XFT59wg0NKm0uUgGUWZH3EgJm67NbAx5UF/Oldbf6EshVF6OB2sZM7Y3to0XhsM2/IwBEn8bagdYa7+1gLU8gLshpI0+lUbMLkEOH6+gt0z9Ii1T7g2v5Z8WLiMXP2X08US2iW4IL0W1Jly7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068852; c=relaxed/simple;
	bh=Tb1TfEuJXqmiSMygvBBV/dXo9gu79yu0IulnaA/6aEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/qs90lx5tukLL5n7RtNL3wN6jo0GkqR4jOxCkz3nUmSOnuQB6vlKOY3qK7f0pHwStgKQ/nJ+jMxXyBc4LT0a3kq/MLhF+LM0UZ5UPxqZPPAounRFnXyUhyOAVq97iCp44zQt616zNfJptC6sK9B4jJ+uGAjrZDwgJzbNTzyvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuUaSKxm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so379866a12.3;
        Wed, 07 Aug 2024 15:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723068850; x=1723673650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tRh+NoxCveeEorJqzKApgxOU2SIwA28KM+/8Iw5opFM=;
        b=JuUaSKxmPZUdrAsq2I7ufS7vU01CY+7yCZ+Gm7V8oHsj+Of7NvCTap71+ynLrWxjdg
         f2nRdh/lVc5N65A/NdFgLBPxFCK1R9GpV+avm9tnJWuCPjQlewvJXquCTnYzfCr4wvVg
         J0yJklfE4XJuVFRw1i+8Ulk1Ndz12waFaxHKWBGLo7h7cXzsqA2byQHdDQrEjYbLr0qN
         GoXU2jg3fVKyeb+ol8HMjMY412R1aTvyxrvNdYhQs1nVBQe4w3H3sfcAfrTdKZZe4yRw
         8Mnsy+6iMQdgegg+AnGBgVH/GGbKJpOvtNLc3o6pFtI8Ms7FDmCPKWFyOAVxrHVzQu+S
         WGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723068850; x=1723673650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRh+NoxCveeEorJqzKApgxOU2SIwA28KM+/8Iw5opFM=;
        b=fme+s78aKj+iLLXE9sGUmizX/L/nymPE0Siu+4gIrXDbfC462zGkgtCJBUPiT23xeV
         //vMXfk3J55mJPjWwV6YCp1CovoEfcfHILjBfmvySGQpe7cqgOzQT2GDolUYOjGeLg+O
         MdHSgj7YapYbt2YZ6u07ablOsP45magShM8T95i15u5oTbVH6QGqCUDAW8mrYxiXtw8I
         KW84dqDbDnFJxaRKq5tdOZGMWVmUVWCQlL1fjSWBKNIVtasYn5lYeRKnJRx7MfKYmV2Y
         FnPLglA9mLOvWlyLPHLAtB1eKRbT5jH4wk6FlDHDWeR7NQ6EFr7P0aMzUCU27EcJAZXh
         1vDg==
X-Forwarded-Encrypted: i=1; AJvYcCUHd2up30JXMG8jcAyaa+VDpFzP5JDzJNNZfVr2uuAtUH+p5nGS4DL1hwpQWLHIK+5NsMM7PeMqi7JlwIr19kyk5lKdVhaGxv6xe6RLeHt46a8M1FnsNAbGeVKez2jBJHHjzncSGHvyS+SOyA==
X-Gm-Message-State: AOJu0YxbwpfWgenepvcG6r3D30GegmNpV3E/jZOVrhoFOlLQoWFCOJmV
	hCiXcox7YTUThTBVkzte4BizIrxTzI7rAiHYCEI8egG0qQdXaaP/3fIbR6ZMMHmOHgLR7kLPy3m
	8+cQ1xKfBqiOm6vfohUc+HkfaHzQ=
X-Google-Smtp-Source: AGHT+IEqHLQRGsdg1JTxQcGTt6dR3uLD/D6++NZXGdXYPR3B9yBoK8nfKMkgW7wPL52R5TeN48O2HyGbKKAxEI89sMA=
X-Received: by 2002:a17:907:9406:b0:a7a:abd8:77ae with SMTP id
 a640c23a62f3a-a7dc4dc49cemr1418463566b.7.1723068849357; Wed, 07 Aug 2024
 15:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805100109.14367-1-rgbi3307@gmail.com> <2024080635-neglector-isotope-ea98@gregkh>
 <CAHOvCC4-298oO9qmBCyrCdD_NZYK5e+gh+SSLQWuMRFiJxYetA@mail.gmail.com>
 <2024080615-ointment-undertone-9a8e@gregkh> <CAHOvCC7OLfXSN-dExxSFrPACj3sd09TAgrjT1eC96idKirrVJw@mail.gmail.com>
 <ZrLuelS7yx92SKk7@casper.infradead.org>
In-Reply-To: <ZrLuelS7yx92SKk7@casper.infradead.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 8 Aug 2024 07:13:56 +0900
Message-ID: <CAHOvCC4bYNkoku_HWDadEBNfWNJGFkVVmz5XcAeMe0EAT_5HEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
To: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <levinsasha928@gmail.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, Matthew
Thank you so much for the advice above.
I've been analyzing your XArray for years now and it's helped me a lot.
Finding an index through bit shifting in XArray seems to very ingenious way.
If you have time, Could you talk a bit more on the dcache advice you gave above?
My guess is that it has to do with the memory cache associated with the MMU.

On Wed, 7 Aug 2024 at 12:48, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Aug 07, 2024 at 09:21:12AM +0900, JaeJoon Jung wrote:
> > Performance comparison when the number of indexes(nr) is 1M stored:
> > The numeric unit is cycles as calculated by get_cycles().
> >
> > Performance  store    find    erase
> > ---------------------------------------------
> > XArray            4          6        14
> >
> > Maple Tree     7          8        23
> >
> > Hash Tree      5          3        12
> > ---------------------------------------------
> >
> > Please check again considering the above.
>
> I would suggest that you find something to apply your new data structure
> to.  My suggestion would be the dcache, as I did with rosebush.  That let
> us find out that rosebush was not good for that application, and so I
> abandoned work on it.

