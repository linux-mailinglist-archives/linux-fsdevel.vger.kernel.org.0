Return-Path: <linux-fsdevel+bounces-24924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FBD946A8F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 18:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBF4B20F85
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 16:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4598115491;
	Sat,  3 Aug 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvnF/PWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF11F9F5
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722704155; cv=none; b=NfVY/lfwVzH1DNcpc0dgoXBWa11k9o92MvAYPRtn7oSDEGbvPQw9ohat+gEc7MieYvSDOb3mDqswlhzFZtzi1zfEoRV2ymoC/59VQu7Ta9XB0QTlRETufXfurY+mg99fYdQZF62k4QKM4HaDyykM6Lc17aQ6FZ7Ipb8w0qS/VaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722704155; c=relaxed/simple;
	bh=JMaGzfCOzpq9uwDvrCi95LreDeNtlcHHMYBouAv298A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmR7kHT9w91I/ahkyhlUkXpWdQSrDFpqyUiuQD0WO9p3v95X0Icmq1ejmFGWUtNHe0yOmelv+eAFxTDdjru7GyOT2uW9GxOCsVwMf6afuU0aciFBXdiqAn8BCrOinnFkcnhw+SBm8Hb4R2thTDv6CHAXjbx3dauLEZ525Mm0MPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvnF/PWn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d024f775so572172585a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722704153; x=1723308953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI/kTzcilCi8c7zIlJQG8cwU652FaeDa8pv5G37CWEM=;
        b=MvnF/PWnEsNEYN6WB/rW1RxL7WCfQCYSiUJ1H38Ndc896ZqhPLQ3ms6s3SBQj2kxGx
         kI1diwtA6iCUz1FZipTpZUfyQp/IN0BgOYNo4UPhscaWzDH7mhPbIY7w8taMqZWmMbRV
         YNFxeUCY+3IZsGWhEyiDQtngqDYcrgxFACIaKBMXcnbEEdaN6EE8OsbMTsszbNRlGVLo
         g4PifRgyx+7UF1UUdUMxMW3VQOGKokT1zMisq2kyI6n8f0rygVD+LEeYzjqZ1HIWYSvU
         aFlt0IudorLA1IpK+XxBoVrF0B+oopGQD8VsrsYkVAIKu1RVK8lwHdlDAhTc9wZeXrv5
         D8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722704153; x=1723308953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI/kTzcilCi8c7zIlJQG8cwU652FaeDa8pv5G37CWEM=;
        b=bX7TGiYwdAyRnQDYZWeQIBu8v1xmTxbN9kaP12qWi4RIMCltMtC5dCvZeo+B84e+/j
         GV5miM6sdRy8NdpvwAddDrL+AMvOHtQ4Zts+crCt7iaPj7EMYdIbNj9HCl4adl9qSrx2
         R9rSf18zPNQBwiSDiHTdeyNsJIDN60DvmpEuvqruKYORsOuJZVhBeDceffZTxQDnQMD/
         xe4tPEHYMADbGoDAZGy3Jb+Y4k4a3zHqdv+7//iDCQGGHGOyeyS883b0iachMBhIHvRu
         SSD/VPs3LJ8FSl6BBrm8B+DnSJiHJx6aHVUOdOHbp2kqU6B5rWEJGqTizg+jFw0Hd07t
         4jIA==
X-Forwarded-Encrypted: i=1; AJvYcCXra7LASuwayTo/fE7OF7HKVXvKwxpus6c2LrsxRY6LPxbwYdDUfrjZ/exxpY54X0JiMorpfHy7Nq16WIEP6XA9lU79zEsroua0pdl+kg==
X-Gm-Message-State: AOJu0Yw3wq2ZY0LlYlnj0d+jNdGIx3vvu0T8nNr7AOpkTjYZjLsH6esm
	Vxw34VaExyjX3AVrY+pM3rliRzOBV/Ml9hGXAs6SnABji8oqKnFYd0qu4GeLkwPPn8TY7xrXTG2
	nT0yFNkf6ckgE0O4B00mXRmIghonPEbdk
X-Google-Smtp-Source: AGHT+IFY1oFYdCmSC5sS6yWGlSrQc5UXq9+NfggFoW21C1MvAMDUXqLrOY++WTSLlIrS/KH26TDYa+VwD1bUgfLTzGU=
X-Received: by 2002:a05:620a:1786:b0:7a3:4fb7:5c77 with SMTP id
 af79cd13be357-7a34fb75d60mr736690085a.11.1722704152999; Sat, 03 Aug 2024
 09:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <e58775009d8df15b5513fab5ac112f0dac53e427.1721931241.git.josef@toxicpanda.com>
 <20240801170933.yqabftb5qphscyol@quack3>
In-Reply-To: <20240801170933.yqabftb5qphscyol@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 3 Aug 2024 18:55:42 +0200
Message-ID: <CAOQ4uxjFo3abddFVAtre9PE3X=HnvJU2kYhDzfnkt+ErMt4_3Q@mail.gmail.com>
Subject: Re: [PATCH 05/10] fanotify: introduce FAN_PRE_MODIFY permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 7:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 25-07-24 14:19:42, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > Generate FAN_PRE_MODIFY permission event from fsnotify_file_perm()
> > pre-write hook to notify fanotify listeners on an intent to make
> > modification to a file.
> >
> > Like FAN_PRE_ACCESS, it is only allowed with FAN_CLASS_PRE_CONTENT
> > and unlike FAN_MODIFY, it is only allowed on regular files.
> >
> > Like FAN_PRE_ACCESS, it is generated without sb_start_write() held,
> > so it is safe for to perform filesystem modifications in the the
>                 ^^^ seems superfluous                      ^^^ twice "the=
"
>
> > context of event handler.
> ...
> > diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> > index 5c811baf44d2..ae6cb2688d52 100644
> > --- a/include/linux/fanotify.h
> > +++ b/include/linux/fanotify.h
> > @@ -92,7 +92,8 @@
> >  #define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PE=
RM | \
> >                                     FAN_ACCESS_PERM)
> >  /* Pre-content events can be used to fill file content */
> > -#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
> > +#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS | FAN_PRE_MODIFY)
> > +#define FANOTIFY_PRE_MODIFY_EVENTS   (FAN_PRE_MODIFY)
>
> I didn't find FANOTIFY_PRE_MODIFY_EVENTS used anywhere?

Right. It is used later in the sb_write_barrier patches.
We can introduce it later if you prefer.

Thanks,
Amir.

