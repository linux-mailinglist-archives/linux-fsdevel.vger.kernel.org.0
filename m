Return-Path: <linux-fsdevel+bounces-34973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF31F9CF4D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802101F23B00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C831E0E03;
	Fri, 15 Nov 2024 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIhIc/KC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20141CEE97
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698999; cv=none; b=mn6BY8qzi0+yLtrMd7CBBwpFQjwzC8EtYvJfxvekcSdLb6ARgq5OsnsFW3st2zZ5iCamhDyc20VQqB43cS9Ce9A3bpnzoLlhJTvKFcrUG0rkxJlFpXX5D6QtRZjttOfHXz98AoTXXVcdItY5pragw0R6GwnMgEk2kWapbbOXl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698999; c=relaxed/simple;
	bh=1XEUtNvHfg77z1g9UMh9UlUWx/tdrIc8gqmOJJbuZng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpxGjTyKbbijwp8Zv1d6jWJj27Ba3EA1FZ+s88S6HYU8fNjkBPDy7pCB+NS5h7tLBkCbClwBEzT8RhxwCwPH/nDw38bzajWhcJr3dFUs8uV4tcf8lAdPv83oRVSgT5kLgZO0Y4us64SOIR0YvT69CGRzTv8LBefhXXNLltFWKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIhIc/KC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-432d86a3085so19266685e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731698996; x=1732303796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GhfIN+LkULB+WZf5fU16xjb/0U+SgdFkvvrswJbNuZE=;
        b=lIhIc/KCL41sC8FSnei7bZKiCkrY1UWV58TjqjwDbD2gKUmy+cW1zHOyJBVG3xT0q9
         Icfo5E7THYogf3bNGlztqqYNDC1VIvO4REopB4ROLktgzHoxigmc4YoikVkCk6FmX9ac
         mkb5WEBp8mW+JYxjdIJKw8TI26YcadCrAZwsNAYSGL/Y8S0Llp86PEVcy03+xv7vsHcR
         IS7XwK3HJQOsAffpUbnRXVCY1Imvm9lveBnej6IINMJ6mD7rsf/OJq24+kRTxGYzEBUe
         Mv0fLB0ECwwNvLXwSiRhLvpv0BQiP21YAzH9SogWnf8gPZSpaZNl/ki7KeBWEUnRiouL
         u6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731698996; x=1732303796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhfIN+LkULB+WZf5fU16xjb/0U+SgdFkvvrswJbNuZE=;
        b=vCsdM4vESjCGWVRHy9OSnsaOt79PclhOx6f6kdG+sDPt/aaOGk9LyHbB0CObPt9CiO
         oKh4j3SHdgQR4xUkzv+64FpKzpMnfijULolcVH8Ou7+CaPyWlPYQ5x+Y2SfDpn/2d1vx
         7M9HIakOinQ2lf15tLhYrcUudiS/5tT6e9vWaEZMWhWutJQxqpStk9dNWCeV2XZb4TD/
         r9hUj0gI4Eafr6NdCQNe7MAGNomChdzjnTGTqmONuxloYxMEvKus25ak+bLzKkV/ZuSG
         gLg7LSaqoLHDuAiypHQtOQf4GcxMSRTa+VKNnkl7ecTF7o0d6fAchNTXACMyQrjuNIWb
         YjyA==
X-Forwarded-Encrypted: i=1; AJvYcCWdb3BdwBr632zv16/6TKUx/D8MwhQGvHfZbNV4QGTBveKZnuRYe+o3GWJRbwcJq5bpvkkQ55aajW7FYLZ5@vger.kernel.org
X-Gm-Message-State: AOJu0YygJhqOFtAOLP0vaUg2Vuit96iKCm9ewb+hnurYN8ff9osBdVv4
	8uekIB3PItpe4jqdw/789lG+KEfpuS0SfhOT0zfP6lDZ2eDpxZUyDwkjVxT5NGM=
X-Google-Smtp-Source: AGHT+IFgDEsfELXvXpNZVepQwwAa4PnvGopmuOtuOA/DhVT4j0RCdFmy14xA8QRUdvZzCjPcHhp82Q==
X-Received: by 2002:a5d:584f:0:b0:381:e771:dc98 with SMTP id ffacd0b85a97d-38225a10a03mr2749825f8f.33.1731698996088;
        Fri, 15 Nov 2024 11:29:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae3128bsm5050408f8f.102.2024.11.15.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:29:55 -0800 (PST)
Date: Fri, 15 Nov 2024 22:29:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrei Vagin <avagin@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: prevent integer overflow in
 pagemap_scan_get_args()
Message-ID: <1b18cec7-3d58-4cdc-b653-fb5790d04879@stanley.mountain>
References: <39d41335-dd4d-48ed-8a7f-402c57d8ea84@stanley.mountain>
 <CAEWA0a5vMq4vGRj4FVQXUR2unN-xAmsFt5ymi4SL+H0yfNpdfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWA0a5vMq4vGRj4FVQXUR2unN-xAmsFt5ymi4SL+H0yfNpdfw@mail.gmail.com>

On Fri, Nov 15, 2024 at 10:49:44AM -0800, Andrei Vagin wrote:
> On Thu, Nov 14, 2024 at 12:59 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The "arg->vec_len" variable is a u64 that comes from the user at the
> > start of the function.  The "arg->vec_len * sizeof(struct page_region))"
> > multiplication can lead to integer wrapping.  Use size_mul() to avoid
> > that.
> >
> > Also the size_add/mul() functions work on unsigned long so for 32bit
> > systems we need to ensure that "arg->vec_len" fits in an unsigned long.
> >
> > Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Acked-by: Andrei Vagin <avagin@google.com>
> 
> > ---
> >  fs/proc/task_mmu.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index f57ea9b308bb..38a5a3e9cba2 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -2665,8 +2665,10 @@ static int pagemap_scan_get_args(struct pm_scan_arg *arg,
> >                 return -EFAULT;
> >         if (!arg->vec && arg->vec_len)
> >                 return -EINVAL;
> > +       if (UINT_MAX == SIZE_MAX && arg->vec_len > SIZE_MAX)
> 
> nit: arg->vec_len > SIZE_MAX / sizeof(struct page_region)

I don't like open coding integer overflow checks now that we have size_add().
Historically, we've done a poor job writing them correctly.

Probably the right thing is to add the > SIZE_MAX check to size_add/mul().

#define size_add(a, b) ({							\
	typeof(a) __a = (a);							\
	typeof(b) __b = (b);							\
	unsigned long __res;							\
	if (__a >= SIZE_MAX || __b >= SIZE_MAX)					\
		__res = ULONG_MAX;						\
	else									\
		__res = __size_add(__a, __b);					\
	__res;									\
})

But I think you'd trigger compiler warnings if a or b were a u32 so probably
we'd need to use a _Generic() or something.

regards,
dan carpenter


