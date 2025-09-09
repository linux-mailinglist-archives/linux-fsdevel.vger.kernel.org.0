Return-Path: <linux-fsdevel+bounces-60715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B060B50435
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 19:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858275E55B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3033570CC;
	Tue,  9 Sep 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2GN5TmE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B73356910;
	Tue,  9 Sep 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438115; cv=none; b=Z2W0vyvE9SXAWP3AjRbHJmZAa3HHOnIhVGdFBNh0dDVA3Up6kxticUj3Hjalews6p1UW61spagDZYF0PkxBv/fLHsbDlxfUYThg6M3d5IqhFQUP3nyLCKevfd85iw8Uc//Y56+mkU10oITJgJovu1Y+0y4+wrbSEUKYHKTljgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438115; c=relaxed/simple;
	bh=FRFbYtUEenoZ3Xy/O1XOyDxlGBtA4lcTfQrK/mjHy50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1Bw+bolgH/zvWqYS0jNZ2wh9qffELMuiuBaE3Q6NCMY3Cgp5/GJh5VChF2fkrjITmJ+20yatA8UwuSRRr3MMk8wdBTJQD/zsSGKVNerKH7jY5N51pLFgyF6p/BrGcUVq/I+NjzinMw2eiLX/JSLGZWu3e4tMvOqFW9UtZYoAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2GN5TmE; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cceb3be82so4385364fac.2;
        Tue, 09 Sep 2025 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757438113; x=1758042913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FRFbYtUEenoZ3Xy/O1XOyDxlGBtA4lcTfQrK/mjHy50=;
        b=i2GN5TmEpDxUWgGIjnKRpiKhL8Wkqv6CWWRkjr7kfCKFlbDxQU1PxOW90AsqAQ1EA5
         tn4Fej5eOgx16o0o4dkVGXTuPX5yboUEZpeSVirR4xKKiTQRhb9gsZJm/1AYcrARAv/2
         j/It7Kc1zVag5yk2NJXuy5PWtclYy2QqaIS7E4B1AQYVp2RjdujBMe6dQaf+CbLSsuCo
         +kesaK4NO1P9jsSxwnAlXgV3WhI66dfbAqQGDT6wHXcbkSzpYO9DETmTcYbQzg+DCsUD
         Zyohdz7ac5RjepgZgW3eTU8daIHLuUbuKBnq66t/+YW/ZX0SV7BaG4/2jLyg51ucQbNI
         A/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757438113; x=1758042913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRFbYtUEenoZ3Xy/O1XOyDxlGBtA4lcTfQrK/mjHy50=;
        b=FWs9CcxToirkSQYhxXGGN0LoLZ4e188DfNcqb6ocQXg9rTeQGhYj43kH0qIZ9jGRYn
         nvXC4Z+KmvuMqCr7Pq/Vqr9D9kw26n2j7U03sawWH8OWZghpbm5yu+I3gJQPM8KAKS4f
         WvovsjdXFxXhkEN2pQ+2s1S7N1yxnhGs9QoJJ2b47haalQrX1QP/lO5NO1ZUMLGZ9aQz
         yyouik1+nu8kVyO4yi3ztz1RxRPoSjHCBFi/oI/M3OxON9QretFebg9ecy2Klav5Yehi
         JGTVIN5dXgW1pCbw9s72t8CCrIdGck4j0Jch/VfB7yOesehLnGQRVlwY3m2i5AQD3K80
         3Nyg==
X-Forwarded-Encrypted: i=1; AJvYcCU6cjoXhNbauuaYDTaBjaPhqU3B9ZCAX98BImL0EL99/kGjwwxDmyM3cTFI82+ehscBhjkhV4ZbmfIPai38@vger.kernel.org, AJvYcCV/i5S9728ZXOkWeaPr70AjmWMcPB1cGIvb2Cce4Y4ZY+BVDyyoXfuwPzDrAtsqNXsmCWejZHsqYf8krwG/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0s572oLKIPJJA3jJV6aaU9TNJ63kiSFjmtpXDvmxCVyYwa2fc
	FqaDakE+Cfmjm0FnOyC770tW2/hMx7cZRHh1q+AQvaKsKMnFd/tGyREGrrjZzpPSkypmxSSYbs8
	4jsuLXd+Fqs3lOB8BPim79U1QvIZWYB8=
X-Gm-Gg: ASbGncvESIi8jevIHKpzULF3rDOE+TobdlwY2yxQw8+u5LLYPsFFllhpjl6Ag0YeK9J
	iXUYZwCbGuj10141NQq/aimr1j8XjRJNnGMe/8LVbGmsRPjwjdVykq12bXXmIdK4OzY/JzWnTq2
	OmU2RUhgOYYks3HS1pBtE/2gfkiTxyYM2AobxtIboHBgXO82gWWNA6E/hiS8cdv3YWI03Xl5C/t
	+pEsYPHQw==
X-Google-Smtp-Source: AGHT+IFC2f1AzwJIHpG3nqtjhPSeFQ2E2slH2DYc3imJ2xW6WRwK3xUhoQbRDlM6b00PjBBc3rq0QjcT9wipwAiEhZE=
X-Received: by 2002:a05:6871:81cd:10b0:328:d4ef:941d with SMTP id
 586e51a60fabf-328d4f0402bmr3002526fac.45.1757438113192; Tue, 09 Sep 2025
 10:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909165744.8111-1-suchitkarunakaran@gmail.com> <20250909170800.GO31600@ZenIV>
In-Reply-To: <20250909170800.GO31600@ZenIV>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 9 Sep 2025 22:45:01 +0530
X-Gm-Features: AS18NWDlpCmAQz0WsbY8xTWZd7p4MuJm4fPL30hkMrLCjf30f4NZjNNS7N0RqrU
Message-ID: <CAO9wTFjrzCzgSH1+qf5D4UuF5YP1aG9gcDfj_Kpu5imvPSSr8w@mail.gmail.com>
Subject: Re: [PATCH RESEND] fs/namespace: describe @pinned parameter in do_lock_mount()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 22:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Sep 09, 2025 at 10:27:44PM +0530, Suchit Karunakaran wrote:
> > Add a description for the @pinned parameter in do_lock_mount() to suppress
> > a compiler warning. No functional changes
>
> This is the least of problems with that comment, really - or calling
> conventions it tries to describe.
>
> Check linux-next, it's rewritten there.

Thanks for pointing it out. I was unaware of the changes in the latest
version of linux-next.

