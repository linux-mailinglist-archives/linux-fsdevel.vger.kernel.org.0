Return-Path: <linux-fsdevel+bounces-12674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BFC8626C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 19:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82AD1C20FC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83802495E0;
	Sat, 24 Feb 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MKI26+5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816716429
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708799078; cv=none; b=ukXsQbR00gPL8buKe+F4EVVn7J8VbjlYynJz8zIMqWZngZr7zFWSlPVsUlwSdOlkf9dLBzu7z4lhXmusBxC0R++7rqzjkayYL3xWnNiuhLV+ls9QiEYgRThlzaHdHv9SRK0EHCV4ElkziBYueRC5wbDJGSxrBx8NpN/ssOMgGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708799078; c=relaxed/simple;
	bh=4lm+SXPYpKy7RtJw7DWowMP0E17RWk/j+nPg7bklRI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4VA6gj5NQ60y1vYCZCiuhd5iddvjqz1wGNft9O9g0t1HyDXJCNWZYOxUd0YZm4QyZzlEZodd1skLoobGLveTtv15OJDjClKRIJDHOIH6S+KojMnDfzvCq5jRQrsn4aP0IcdY5V1At6tXhynxpF6uiEb3JEfujprSoqE63kYCiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MKI26+5r; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso178398366b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 10:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708799075; x=1709403875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EY+g2x/uu130bGhBO2NnzZ5mIwdVPUKzDp7TTIbbJ6o=;
        b=MKI26+5rg7CAfpBri6iIazTosFjDhD4+d25ef740XFMxUEySZsMHKg0HYX+kqQLmSP
         x6dLx1s6VyDVpyi4hI/BArHkWjNT7R0SPNkCMfHyWDbay5NlcCeii3ozR47Kqm5XpsOB
         Cxkf71Qobx1peuh7gqb9UhY0eVVxM5pNzxkKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708799075; x=1709403875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EY+g2x/uu130bGhBO2NnzZ5mIwdVPUKzDp7TTIbbJ6o=;
        b=vQfywjJ0xvOrX+eDqL9QlChtTaLE5r5npp+0n7kgQMBi/TuWR1Zz0xVAqLEzWnlhso
         ZR2BqrNN+H1hFhNDdm5Uds2kK36otGlQhY6PSj3m76o0ezWJGca18nA9AhvmIWEIj2yq
         2pOuU4fG6hn/s7+LasxUl8DRsckk61uPQUMTKx9auJhDt9ibQQcRygfZByiObf6n93gg
         oEcYDDZR1ZCPRERJx/5YXDA0UmigwION6HjBnS5iYn2Y/zAoNb/xCoG3dpMxRxsvPJ/b
         +VGj3qNCBg7TINcovxLqLVSRZL9HUp3YJbO6LeSI4tBIaV5rXKWk2qqh+2uGyAh4WQGj
         NzvA==
X-Forwarded-Encrypted: i=1; AJvYcCWcrLljAglLGhzdq5CMT6WJJ6lEVb8yzhaaOfn+PGuDmi8o1feAHrzxso8i3INyAK74i/nEL617uDAP7S6PD3o/3WxYAZ2I4DOdUkdnRQ==
X-Gm-Message-State: AOJu0Yyntz4GoWNYTsd3/vGYujjGSbSOnnUM/fB6WPrwBAYsgZBGP0h8
	DA2qjlbg84HmAB82AjTR6IfEK/+ioT230SYqrPZ5tuedT1Qf3Qde2kdsnFCLfq0SAdswMEMmThk
	BZOY=
X-Google-Smtp-Source: AGHT+IEtbUSDewrIimxFPwzFNjpBe4RD7v2Z3Za0od553ofU3DOAmDR/b9Q4CP9fEe2VZYAfQZZ6nA==
X-Received: by 2002:a17:906:f2c8:b0:a43:14db:343 with SMTP id gz8-20020a170906f2c800b00a4314db0343mr144773ejb.38.1708799075104;
        Sat, 24 Feb 2024 10:24:35 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709062dc400b00a3f355aeb0bsm792127eji.131.2024.02.24.10.24.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 10:24:34 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a293f2280c7so231760366b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 10:24:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRDF0Ae3x6h8O8rsY6yZ9t53cAGIl0wU+YkrVPLfYxBOU8MWXzccmdwv3nIzoAVVyVhc+Nwndba4adZNAVlysYJJL+v4LYlNZT09UyBQ==
X-Received: by 2002:a17:906:6701:b0:a3f:6717:37ae with SMTP id
 a1-20020a170906670100b00a3f671737aemr2030241ejp.69.1708799073809; Sat, 24 Feb
 2024 10:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com> <ZdoxuNx0Tt0E-Lzy@casper.infradead.org>
In-Reply-To: <ZdoxuNx0Tt0E-Lzy@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2024 10:24:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPakm89vC-phnNOQsDWRn24ODFNFUhkiuZ0Wks9aWsSw@mail.gmail.com>
Message-ID: <CAHk-=wgPakm89vC-phnNOQsDWRn24ODFNFUhkiuZ0Wks9aWsSw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Feb 2024 at 10:13, Matthew Wilcox <willy@infradead.org> wrote:
>
> > Ask yourself when you have last *really* sat there waiting for writes,
> > unless it's some dog-slow USB device that writes at 100kB/s?
>
> You picked a bad day to send this email ;-)
>
> $ sudo dd if=Downloads/debian-testing-amd64-netinst.iso of=/dev/sda

What? No. I literally picked the example you then did.

And you in fact were being clueless, and the kernel damn well should
tell you that you are being an ass, and should slow your writes down
so that you don't hurt others.

Which is what it did.

You should have damn well used oflag=direct, and if you didn't do
that, then the onus is all on YOU.

The kernel really isn't there to fix your stupid errors for you. You
do something stupid, the kernel will give you rope and happily say "do
you want more?"

                 Linus

