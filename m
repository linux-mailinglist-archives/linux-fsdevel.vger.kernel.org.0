Return-Path: <linux-fsdevel+bounces-35742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ADD9D798F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 01:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8DEB2225B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 00:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E967B64A;
	Mon, 25 Nov 2024 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BbWtf/l/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055DD4A28
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496042; cv=none; b=LbxkzHzSe0gFPZdVDZWHyHHRjof7My0kSqaOJwVBj623f6Z6vlTcvl0Enur1Du+eRJzIuz6iwQDeS01HRU/83aNnC3pvcCIUlSI4tGbFAhVtax7kUOZvJRV6wvLvVOjrS+f6meNhX7zDI1EIoQsZzUpVHxJxT7MGzzoAL7bjo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496042; c=relaxed/simple;
	bh=hV6b252LM7V4424h3/YzSAq24BYPWuAcF95EXgeanbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKqFHpopMo+l40jxknKthDIbWAI+Ii6KHr8axkasVw22Av7kCQmfHCB8RtADFWJop0dNP0tbIrbX6maLydpRcQC99EMefdc1dObj6b5vkdK3hZCyTd4Cpof6lozxwRlLEhco5AFma02XWxcOAMogp41y+j2Wutb12O5Sj1Q5qGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BbWtf/l/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso5088600a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 16:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732496039; x=1733100839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OaDErhfkpfqjfvyPli0HLvhV5o1yp7FB0uhP3zkxd5U=;
        b=BbWtf/l/VaR/WxzScIxcK7XBHAstrQB4IL6LqX/H+lPfNuhhj39tLXu+TtZMTAnW65
         1noc9VZI26WNbspicmtT5UWEAmhpRARgkUizHEvuNJhTtUT7z1ZaLbHZU4vOLFglAN8G
         zSGjylSKgy6H7/Gw0ONdJ0cetPL8YAq09dwlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496039; x=1733100839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaDErhfkpfqjfvyPli0HLvhV5o1yp7FB0uhP3zkxd5U=;
        b=MPrIgxvrBIwV8wk9Z6OrOHVCXRj7KRWJyymlNmXNNl0i7N9hpNtxgtXyQqPhECaG50
         J4QQ+CMBvJjZj+oEKPWDA0qZRncZ1AWxOklrwADymF2hAGyKEOP3mwji1JYqktQMerAY
         oSoclJsP0Z2qafUdbaACg5TNh06a72qCeYReQi1z7YVbuo+AXZNUNEv5GzdwwhX8mXo+
         tdL+yZCnI6S9cHD9WKn9YYrNf7UNOzww4egHrbAvGusQy20xaxpyoDRpMY/ZA8w2SzJG
         hVwViQBBSvG0wzUE5gcrlB1Un6Y/HqMwehtdCbXKdNITKXVJSGqZSaj0TPC0XIWjsRgH
         FI2g==
X-Forwarded-Encrypted: i=1; AJvYcCXAbimThAvHqHf5pQshxyiyUTI9VO1+treOGxefnoFIoqqV4+KGNa+EmSN73yxyDSX8dGS+HUeHVO/REEzf@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkdDG8+2HNmXwm7YZliLCOE78YQp9hkl6IIcr5gNpCUwtmfNY
	Uc9XAiZdsWd3EsSeRTc7AatvUCEGMUv6BqLYSd00v2S5RZKgj2teJyxqHptgTiePL/gMrUd9gNy
	+BIsenw==
X-Gm-Gg: ASbGncu8E5y7OhaBmIKB9UTm1EjnWyBHUYTs9ChjpSFu4L4jGxrXnA0d+FieypsqEFF
	EdxYEEGV0boDRnJSU8B5yoFGyeH4nP5pu3hOfAC/grN0nnubyCg0yzTS32Matbr/kZQ6fOoJ0fl
	qYBSEHyXIlqsYezdA4UfpMn4CXRXhFJWAOP1YLhFExoiKM37CfmS4RKnhjSdtu7N3MSoC3KMjb6
	yFWnAoH0DAqqpoumvDdX/KiLi69swHj3MP3qpHLBpuv1qgx8tLPI9bZCvp1RRszEO5XrbaLpRBL
	h/6xJCSQMreJzcBVSH+ValD7
X-Google-Smtp-Source: AGHT+IHHPpuaDheMry+pYphnLaTAHPDbG0jIwP0tRXtoqvvMzwNaSd8OMsy0WILkaBVjneljMbJSzA==
X-Received: by 2002:a05:6402:518c:b0:5cf:abbb:5b4a with SMTP id 4fb4d7f45d1cf-5d020688560mr11154636a12.25.1732496039231;
        Sun, 24 Nov 2024 16:53:59 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a23d7sm3566773a12.9.2024.11.24.16.53.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 16:53:57 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso5088550a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 16:53:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQgAjVQGLYQ70xhEF/NXb0Iz5DhPau0tKdBoq8wF4Hyd8bIPAOZRE3F0GU5FVHzht3DiZdodqv3XuKFpKP@vger.kernel.org
X-Received: by 2002:a17:906:1daa:b0:aa5:3853:5531 with SMTP id
 a640c23a62f3a-aa53853579amr504011466b.33.1732496035955; Sun, 24 Nov 2024
 16:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn> <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV> <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV> <Z0OqCmbGz0P7hrrA@casper.infradead.org>
 <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com> <Z0O8ZYHI_1KAXSBF@casper.infradead.org>
In-Reply-To: <Z0O8ZYHI_1KAXSBF@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 16:53:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
Message-ID: <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 15:53, Matthew Wilcox <willy@infradead.org> wrote:
>
> a file time which is newer than the actual time of the file.  I tried
> to construct an example, and I couldn't.  eg:
>
> A:      WRITE_ONCE(inode->sec, 5)
> A:      WRITE_ONCE(inode->nsec, 950)
> A:      WRITE_ONCE(inode->sec, 6)
> B:      READ_ONCE(inode->nsec)
> B:      READ_ONCE(inode->sec)
> A:      WRITE_ONCE(inode->sec, 170)
> A:      WRITE_ONCE(inode->sec, 7)
> A:      WRITE_ONCE(inode->sec, 950)
> B:      READ_ONCE(inode->nsec)

I assume those WRITE_ONCE(170/190) should be nsec.

Also note that as long as you insist on using READ_ONCE, your example
is completely bogus due to memory ordering issues. It happens to work
on x86 where all reads are ordered, but on other architectures you'd
literally re-order the reads in question completely.

So assuming we make the read_once be "smp_read_acquire()" to make them
ordered wrt each other, and make the writes ordered with smp_wmb() or
smp_store_release(), I think it still can fail.

Look, let's write 5.000950, 6.000150 and 7.000950, while there is a
single reader (and let's assume these are all properly ordered reads
and writes):

  W1.s 5
  W1.ns 950
  W2.s 6
  R.ns (950)
  R.s (6)
  W2.ns 150
  W3.s 7
  W3.ns 950
  R.ns (950)

and look how the reader is happy, because it got the same nanoseconds
twice. But the reader thinks it had a time of 6.000950, and AT NO
POINT was that actually a valid time.

                    Linus

