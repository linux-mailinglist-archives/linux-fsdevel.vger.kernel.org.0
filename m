Return-Path: <linux-fsdevel+bounces-16951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2053A8A5646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20681F2290F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1976B78C99;
	Mon, 15 Apr 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FDNE+7br"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F876F17
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194647; cv=none; b=c/cASIZqp4nkOPda9CiLos0726V6szV04jFYY1sX4SXqd8Mr3WvEYARM391KulKQhFkXX9cF5GVxCbsJQgTazZ/MvJdRp/mGBpVVEmGbjBC83IIy0PTHjmdFHaj4e8EGx532wXbm2HNGao0hrkt8EgGPhbWwzmau47Z2tWlb4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194647; c=relaxed/simple;
	bh=0K4dQJV+mfWZQNpGK/vITATfXVgyY0RZsCg7Qbj7+NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYDqSQBf0WD/SLoHiR7S4bnrtANRjzPuK1XS4ZYJsQ49UtoBT5cMLk9s+/ZhcAFqnRXD9zBWJsNw1m6UJrlci64OB/okqhLgdKbyIHSjkZdAveCgRq3djLUodr77Adypf3JQ41w880/n319QmHyw593/V4mp/EKAfiAyGXg4awE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FDNE+7br; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51addddbd4so391881966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713194644; x=1713799444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WYfOEsGC0slx6ThijhpmfrIi/hp4YLF9aD3FqVog84w=;
        b=FDNE+7brcKZ7SrEegxDpdQnyMKdAq7mtba1xwFzcRSRH5OR1+rZv4AfZMH9ScQaHLg
         QvGWV4RLpaTvqEcXsK5BJodr59VCFNF8q65J7WzxArTFE/mEnzLFhDkSD03nmxWkoX3j
         Vmr9m0LtDROIO3tIx8xg5etjGZTxvl1HeJSDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194644; x=1713799444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYfOEsGC0slx6ThijhpmfrIi/hp4YLF9aD3FqVog84w=;
        b=pKeXwXm/rtDGzP4xTd65T5RIEIzy5XGOiEvp1M/7vTzhMufRgrPpBnKUj8BVzl2eOM
         +6QGmgf09Ez1JZ/gwkS0Z7rcOrL6Mksr1ANCtm977jUniFOk2zONOJB4HY5RTC5LEFOI
         tDUTqvo5UUGg5sZm/gBuYRaSAYN8ndrLtp/6uwTl0pxFqQmWpLtnYIJkHLjdmAg9v3Ke
         J7dstV+CQPzxpiAQwkfHI7c6wOWyLZyPW7XEMANhPslb2tajIZ3JEKQjvOH+EyLuTCby
         vkbVHowpca+CajFPJGTBYJY3qVN+vLzqoVxJizvpIc8urdUwpgt4c017knKpjIpmWWV5
         WgAg==
X-Forwarded-Encrypted: i=1; AJvYcCXtWBpwgZ85Hl+KOf4+ulgYkZFhhUQ/Wj0oiEN/JaIrSRg36nrNxMSKqgbOjJ4K+k94ssxZxBrXDmH/dFWrXdCIonFiDkWCyu8Pnv8WnQ==
X-Gm-Message-State: AOJu0YzodX/BxpayBZSeftYH++JCjP9lu21cmi2ykblNmOl4ZHzZh/63
	5T2o5iM/LCGfOv9cVog/zau8RnNDKGum/JjhAAvT/lamWO2aApQ6L6UxtQB16VQpKFH+Z/mF3ih
	R/FbiRQ==
X-Google-Smtp-Source: AGHT+IHXgR21W4MUF1sAj7zwQGhK5c4hLaLRwV69xrYaw1v0bF47UOgmT/JCghDGSKQdpXMMLHAnLg==
X-Received: by 2002:a17:906:fcb6:b0:a52:35d6:157c with SMTP id qw22-20020a170906fcb600b00a5235d6157cmr5671580ejb.68.1713194643992;
        Mon, 15 Apr 2024 08:24:03 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id h18-20020a17090619d200b00a51a80028e8sm5585188ejd.65.2024.04.15.08.24.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:24:03 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51beae2f13so386072366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 08:24:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrn9oHgWUiJduRocTO97PX1lcoJv2mfj5F3wN4WsAOlEwL9EaJ7nqHgsqqC2wgeGB8Y0jApom4mC7PH2iysVAienzyvlO1xwK3etS+YA==
X-Received: by 2002:a17:906:e0da:b0:a52:5c9a:1c8b with SMTP id
 gl26-20020a170906e0da00b00a525c9a1c8bmr2466375ejb.5.1713194642825; Mon, 15
 Apr 2024 08:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com> <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <ZgFN8LMYPZzp6vLy@hovoldconsulting.com> <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info> <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
 <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com> <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
 <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com> <Zh0SicjFHCkMaOc0@hovoldconsulting.com>
 <20240415-warzen-rundgang-ce78bedb5f19@brauner>
In-Reply-To: <20240415-warzen-rundgang-ce78bedb5f19@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Apr 2024 08:23:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPTEYv3F9tgvJf-OakOxyGw2jzRVD0BMkXmC5ANPj0YA@mail.gmail.com>
Message-ID: <CAHk-=whPTEYv3F9tgvJf-OakOxyGw2jzRVD0BMkXmC5ANPj0YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ntfs3: remove warning
To: Christian Brauner <brauner@kernel.org>
Cc: Anton Altaparmakov <anton@tuxera.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, 
	"linux-ntfs-dev@lists.sourceforge.net" <linux-ntfs-dev@lists.sourceforge.net>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 07:16, Christian Brauner <brauner@kernel.org> wrote:
>
> (1) Since the ntfs3 driver is supposed to serve as a drop-in replacement
>     for the legacy ntfs driver we should to it the same way we did it
>     for ext3 and ext4 where ext4 registers itself also for the ext3
>     driver. In other words, we would register ntfs3 as ntfs3 filesystem
>     type and as legacy ntfs filesystem type.

I think that if just registering it under the same name solves the
immediate issue, that's the one we should just go for.

>     To make it fully compatible
>     we also need to make sure it's persistently mounted read-only.

My reaction to that is "only if it turns out we really need to".

It sounds unlikely that somebody has an old ntfs setup and then tries
to mount things rw which didn't use to work and things go sideways if
that then suddenly works.

But "unlikely" isn't "impossible", of course - it's just that I'd
suggest we actually wait for that report to happen and ask what the
heck they were doing and why they were doing that...

              Linus

