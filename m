Return-Path: <linux-fsdevel+bounces-40122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A09CA1C64B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 05:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735947A3070
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 04:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E7B2E634;
	Sun, 26 Jan 2025 04:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E4bGnadN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC93232
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 04:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737864969; cv=none; b=NwlzO2iJsHP/ba6oJ6viZdrLWxPAuscs8CUUZIBW/jKXWIz24YUUaz/AkNqyrxnCkMOR4S+4qNuIKkRDFSMM72P4K0wautcRKeUwpmb9LKJSnAY2S66+ZNW56VnxxDvgzx2oQKsIlmiw2AvFoniStiIHTb+zkrNUDTX4krLrKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737864969; c=relaxed/simple;
	bh=8qNIZhTUsehV/OfCzWKvIiUr6lWTXe3U5I0w131gjcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxRdGM1TivrOtaD2fLBGNK1wHDn+RVEhuwrC9NRYLoMtxQIegUWu8bOmyZNgZU5HQp8XlCSeIGKpRWzsH5uol003RXX9Guui2xdt8XwjzEbBXtfeFQFi6hywmdebKvVFYx5faUc+/dhsS0TAo+/INvkGuXsjDIDWDaf8qbcI/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E4bGnadN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so6863939a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 20:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737864964; x=1738469764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J2HH65SBDanTffFiIpqDflawtBct/Qo0jMGo4SaaGy4=;
        b=E4bGnadNGLISUzwHYWjpC73Tl8BJtsVSzbbps5zompI3EsUJTXWwa6rtskASjK1K0p
         TyE7BzYJcFz3Q1u3E024vNH95SETiZXwfnXVCrxHvP/MaVnnwxJauJEy8OOCXUhKkU9e
         ZdOAdloMnM5F3RTT1ZNuk158pMdZmFYLJhk5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737864964; x=1738469764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2HH65SBDanTffFiIpqDflawtBct/Qo0jMGo4SaaGy4=;
        b=NV3jL5pWnpC8hLh4T4qSln9+fOuET/FuzFpZmaKjVaq3p1wIUB4vQsNhJmAtnkav8W
         NXeSaNKhjvqZTU6IF4/1E+0BB+7BtQFuNS+lPaaJyzDyqYkezkCuKfKLlPFIQhEaSbVL
         woSaUE7pxW0EhBCXVXhdb71Cttz0r3ugoYQNm8O4TtwyxcVQKSDEjECddD27KyxeoHUz
         s2doPcMYb2aAkbubG8qZvncIhMK9MfanuUQrAYd2OODHjr4RKVLuT4ZHibH/g8jjNqGc
         GSebIl7ZBGq/tetWgmYKxRoq8Nc2Iwqoszc/3ffKEije3toFnApK+27ol96KML1VrBxt
         db2Q==
X-Gm-Message-State: AOJu0Ywv7m9PyUAh1TcHcnU919qyreRbo5b1JEBs+7Efo47wlVuLmt6L
	iP56r7Unq/n1OqB9rObkAqw9AAzDoWWNHnbokPosafWxdAuvcEV21z2OUnViDCjVUY/b0oza7sF
	TSwE=
X-Gm-Gg: ASbGncurLDWn+75AwC9ULVIRJoJtWn1YG93Qi98wY9M2X651Gx8lrmGDr9UF3OEt5zo
	tTf/Z+Uznu7Tj+KMxEDrCXKX/LgFJWo71EYFVSS1+GPJ4QdF2mPOQ8Qz46qAnV+ZOezzg0QZCWS
	BHHzbd9bMswBqxzzEIq96Ism74kEVddXLQ+oD+s22T/x5LZJHMgMhBnNQSYOO4rAjMmSmTJpEFB
	/HlWL6BCDIxKq+JFz4w/3gdKG+JjrNWoby4BOdgbh1TTQWz4ftzdUi5+9h0xOwx+Kh2TSdiWL8a
	h1zMyCGYwdXRi1mtZLYwUIJbuy+5KkLm0RgEa6lR1CtkWgeGlmTKzKI5FOTcWZRXOg==
X-Google-Smtp-Source: AGHT+IENB6GDxoWX9gXB5x2a+KG8oBxQdGx+LQUbr87/0Lt6Oldg/6noAINNiCy315o6EkjXStVTDw==
X-Received: by 2002:a05:6402:348c:b0:5dc:1239:1e5b with SMTP id 4fb4d7f45d1cf-5dc123920a9mr9291016a12.23.1737864963845;
        Sat, 25 Jan 2025 20:16:03 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18628d00sm3472256a12.27.2025.01.25.20.16.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 20:16:02 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d9b6b034easo6708802a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 20:16:01 -0800 (PST)
X-Received: by 2002:a05:6402:3508:b0:5dc:1395:1d3a with SMTP id
 4fb4d7f45d1cf-5dc13952111mr8638547a12.1.1737864961530; Sat, 25 Jan 2025
 20:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOg9mSRXYtybVX7GSK0dMcdOXTshJjy4YL8CF6Ly0aSPQV7nEg@mail.gmail.com>
In-Reply-To: <CAOg9mSRXYtybVX7GSK0dMcdOXTshJjy4YL8CF6Ly0aSPQV7nEg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Jan 2025 20:15:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjihBfyz7Fj8PkowEgoChj4JmNZo4b_oKmSLZL9Tkujkg@mail.gmail.com>
X-Gm-Features: AWEUYZk9T8i7prXeWQzqWB1trsPFmq5c4nhuaDQEaQObG4MB24hqZAqPQ9_7ZAg
Message-ID: <CAHk-=wjihBfyz7Fj8PkowEgoChj4JmNZo4b_oKmSLZL9Tkujkg@mail.gmail.com>
Subject: Re: [GIT PULL] orangefs syzbot fix...
To: Mike Marshall <hubcap@omnibond.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jan 2025 at 08:32, Mike Marshall <hubcap@omnibond.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
> tags/for-linus-6.14-ofs1

You're using a new key that I don't have, and can't find. Pls use the
right one, or make the new one available.

          Linus

