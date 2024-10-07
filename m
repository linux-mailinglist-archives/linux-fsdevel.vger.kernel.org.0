Return-Path: <linux-fsdevel+bounces-31173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40836992BE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F72B1C21A2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 12:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646831D2796;
	Mon,  7 Oct 2024 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qgSi7B4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451018BB89
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304548; cv=none; b=iN2qjmC3nnKrmxGIk7gM4XRwU8zjiw8uZoh2bTj8BBVI+EIupH8kJtdzwWr5YeoJwiX/1NoBJaJKOdqWIn1/aslTeH6Y2y+C29mulCUvTWKRjoCUDjltICGFGCpzl1zCxgnc1juHraBxXPkZcNrUkgE2MOfz5RKZs8VrUgb2k+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304548; c=relaxed/simple;
	bh=w1umpy6jXToZDVxKpGcGFXq9OzBf72ZHi2mnV8uEt0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtqxsQ+Oyy26GOW+v1GgHx1npbM+jncf+3YrZihZLS7EdNTkX26XmpAuYrHcD4vqRUunWErAU2qNkFBfTr9Qb5e1ci3GJC5VT+Br9WvaK5xSxCvBbdRPQODbYXkiERqWRAG433dXzINDvjdKc0dC0IiwaFCJnhfHeMf2q1yX4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qgSi7B4R; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539885dd4bcso5299795e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728304545; x=1728909345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w1umpy6jXToZDVxKpGcGFXq9OzBf72ZHi2mnV8uEt0c=;
        b=qgSi7B4R5AlJ1ef/aGPAh3oIbzd/cZND23E+6H/xC5KehXodV0dGmwg96ZLBpD3Eqn
         SF6Wz97z7r1NtW3+xSrSqIGC19rqcIDrng8+gOMY/xGZbuMMGu4DOl8UlLgyoB+yBR8Y
         vufW72vJGXNaNV1HG782GFVa0UL0qqxDJiD60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304545; x=1728909345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1umpy6jXToZDVxKpGcGFXq9OzBf72ZHi2mnV8uEt0c=;
        b=w6h0uS8tqNGy7keAS55ZXrOoqUqa8zQnjWgKdrHpKtX0Ttxq/uZxkVVU1j2oWnXIV9
         WkY4He9PZBxuudKqPL0+d2yOmqoB4VAIXJ3BNa9djmaxQVnDbyvFcLWnCeKa8l6koCBS
         3Wy6/BMAPm27hg+7b7oKUFbrtsTnIUpowP/7vsSDgE+hhnH4hnQBIGYTww6CEhaI1wIj
         O5rdnZlUIfJQwHyArsnZIos/uKdXqR97+HoMe586jxZRO3XAQRMEGdCwFhmu+iMtJfQe
         XLJ+4LJffHIRxbwgecRouYzCSoH9/q4tC+Eec8cTvj1daiaUdDAmsgkjrxWi3+nEKDoI
         M+bw==
X-Forwarded-Encrypted: i=1; AJvYcCV9qEJDqPzHf2oXgVhadwJGdWPgT5h5ozXrj/gSNdMhQ6bWC3lob7YPOQZUqzqLizxzsgnELqXGXGW2Gvi/@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/DRCNP2ZLgpxtNpn64JAOTPJv7o8zIakpYIDqDeS897Fqkfi
	gOHVYKrgTPEpsYl72SHe2l7oxPZlgRKkvAPpEqT7Jg4rozrd2RxvDNrGfqEorHJCrTASW9Ke14W
	qlzYenwHfY3LYYvIyNYD3+JpPRuDdG5dpy2KmKg==
X-Google-Smtp-Source: AGHT+IFN/63kduzVL0hs+1/wL01jUFIDJcPBzbtC5mFPviEkspucyY5LG6IIVBxMd3LfgP+Bkr2TWZ3QZJTtg0gkRuw=
X-Received: by 2002:a05:6512:104b:b0:533:901:e441 with SMTP id
 2adb3069b0e04-539ab85c04dmr5508241e87.10.1728304545111; Mon, 07 Oct 2024
 05:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <efc65503-15fd-4f8d-a6c4-b3bacb7481cb@linux.alibaba.com> <20240827115252.3481395-1-yangyun50@huawei.com>
In-Reply-To: <20240827115252.3481395-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 14:35:33 +0200
Message-ID: <CAJfpegvTm-qniu8OOY2Riy-0xFg2=wy3ROOcrLkQ2hcZCzKgMw@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove useless IOCB_DIRECT in fuse_direct_read/write_iter
To: yangyun <yangyun50@huawei.com>
Cc: jefflexu@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 13:53, yangyun <yangyun50@huawei.com> wrote:
>
> On Tue, Aug 27, 2024 at 04:30:04PM +0800, Jingbo Xu wrote:

> > When the size of the user requested IO is greater than max_read and
> > max_pages constraint, it's split into multiple requests and these split
> > requests can not be sent to the fuse server until the previous split
> > request *completes* (since fuse_simple_request()), even when the user
> > request is submitted from async IO e.g. io-uring.
>
> The same use case. Your explanation is more explicit.

Applied, thanks.

Miklos

