Return-Path: <linux-fsdevel+bounces-69449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE82C7B5D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F2D24E6457
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C72F39BD;
	Fri, 21 Nov 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cc4Aqxk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1D2F1FCA
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750573; cv=none; b=N/544tH5Y9CryQlIlMxQzmr9SLQ5q9UG2UYzgHLRt7/7zgfw7wdf1cUON/+fDr7Bv7RDKKruJ0Atd+J23lAyPArAAI5Vfzx3PS4ajMc3fOvyTeF7E4NX5Kjlw7CQjltthx/U+N6aqlAjVvrleKccZxmxz+cjVKNlJY93/AJgG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750573; c=relaxed/simple;
	bh=pP7IE0ptFG+z92q5nmZ1V3S1z9NWYDQ+50kpokca4Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc+1cRLBgpIU5dpN7ZyzaV40geQJuEUxevCuu0/JYSxSwsPoWfan0u88p3pnF109LkjK1OyhbI8Q6qVKux+WGDadBWkeodalvX6D2ARswTqudfEa0Zw4VnmrbYJHLDgvU7RZw7EA9lmVIjgI1A7wOFZLk/XukJwYfJ4L/gwRx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cc4Aqxk8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so4120087a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 10:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763750569; x=1764355369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YaGqj6qhvxsCaKPO1FZ2VNrm9hXCF3tI+Y3lpcaSAOA=;
        b=Cc4Aqxk83oGN81zJhqyx6+K2QhqkjmRFKbfT38569zy8BqzOMxqguLAIUFDL877osn
         CyAlBPUAQJ4etEQchyy7S/blvjBtUGhYHTWrJSH975C07Bt8lUsfHFaYucQy+F/oXuHD
         olg8y6lzKA7Et/bV1ypWijE35qkmwEA/RPtXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763750569; x=1764355369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaGqj6qhvxsCaKPO1FZ2VNrm9hXCF3tI+Y3lpcaSAOA=;
        b=SLprjUOHXXZ1Ibxk0YAxLI78lV4HipQbamABnVN8jNjeCHkGxFUlcKdOUGQlLo/NVg
         UQ2qh0hZjnbubSV2P2oo7/REZUKKGxGW2tYqQ6ZiZqS6bhLPZzbG+V/wkc2qFRo2YRR9
         6Dv2ICOW3kpiF3e1vmywQcj5HD6femXwAlSf9BlROafmYASYFYsTA+QYfz7/cB/l7UKG
         y+Z1Kv5odBxmpClEFIrsxpQ1Ps6lGIGdUXDePZV+HmdYo8cerpUiop9BnC6eApgNq4rB
         Bq74N6xOxRi9UD6dRAZCNZfvGQGbOsV/q8ykLCTNg0Yu3kmS8+1nJAm19rclU4QYHpPA
         bXNw==
X-Forwarded-Encrypted: i=1; AJvYcCV9T7SfIDC+CNXeOnFXAQDupmbodS5MDq74ix1lzq/MmTAdT41epnxlau69qmn3ou8IIW7DN+U59zEF/qrF@vger.kernel.org
X-Gm-Message-State: AOJu0YxFa7I0yfefbnrYyWs0boW2D/Utkzt+9R7gbKSaelXigpo5t/pg
	F3Mu5/QEi0FfRcHyRdVmjRR3TUPL5Me5mj56QRLAEg2ZVVrQVHdP00sy5cY/ryL3fait7vi8Lb7
	3ezakTQw=
X-Gm-Gg: ASbGnctuwRzz7zrxeSt8fGSy22K6JigPo0/Dwn5z69E9uyAJQKh9AzyrNGML/s0wpRF
	GrQRcK4j8SmwyvrwEWkfJAqOZI8WZ9lF87UbytAtZfkO4hd6NubpG1yUamYxDePDCvsL5EdTLwW
	Eim/JdnB2++BqFbY2iJJ46FDmBZUHU5Vn4o5ez92At/cucX8KMmLObk6fFdw46RXPgo3Tbvhop8
	QcSpUEaiZvQpCZs6WvWFW8FYvVYimiCumTX8OHV/nf2jgCmpkQHnC/147znG8pTCByJ97c6xN3B
	i3cSYjPMf50qgpMM8WNHg4r+T1G2kyoQO7LXYAqKZgWLXOaj+1rk7Xy72qlT56YGeWOLvPTTNXR
	aeT0bcqk8onPTaAa8nu2iPDRPRvi2Xiw3UABdUR0XfMoRDzpc0AMx3MBfm9MWWGtacZqPqB6mKY
	Ch5XcZQMVMd7GZz1bZ5VN/sED9u5cJaNi4JQmMAXEvdqtxayxhXx4oB5vwCWAG
X-Google-Smtp-Source: AGHT+IGtsu4pcdBwZ95NoiFm3wpWok+ime2L9S+2IvOPldTkUI7aww3oXBlh2QzPIaAtAm0AW1eThQ==
X-Received: by 2002:a05:6402:5244:b0:640:f2cd:831 with SMTP id 4fb4d7f45d1cf-6455443f4bemr3147628a12.10.1763750568903;
        Fri, 21 Nov 2025 10:42:48 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363ac98asm5026530a12.5.2025.11.21.10.42.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 10:42:45 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7370698a8eso304955566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 10:42:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRETF5i5uIKk6YdA/22AIoUjALqoS+Htox0jqTVVEvopiW6lFRDMVUrR+YNSa3UjU5MARH9gyH3aUCfeOr@vger.kernel.org
X-Received: by 2002:a17:907:d8f:b0:b75:721:4297 with SMTP id
 a640c23a62f3a-b767183c209mr348578666b.47.1763750564580; Fri, 21 Nov 2025
 10:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org> <20251121-work-fd-prepare-v3-4-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-4-2c6444d13e0e@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Nov 2025 10:42:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgs2+RyEaWM+5pb2ZxdawHThdXxRWjY8RZwY+dDZZUurQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnLSJkTAnJpDzXAQxsB7pWHwV4gAWaGPp7Se2t0GLuEEbV62Fc7qor2anU
Message-ID: <CAHk-=wgs2+RyEaWM+5pb2ZxdawHThdXxRWjY8RZwY+dDZZUurQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/47] fhandle: convert do_handle_open() to FD_PREPARE()
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 10:01, Christian Brauner <brauner@kernel.org> wrote:
>
> +       FD_PREPARE(fdf, open_flag, file_open_handle(&path, open_flag));
> +       retval = ACQUIRE_ERR(fd_prepare, &fdf);
> +       if (retval)
> +               return retval;
>
> -       fd_install(fd, file);
> -       return take_fd(fd);
> +       return fd_publish(fdf);

Ok, this looks nicer to me, but can we take it one more step further?

Can we just make that FD_PREPARE() macro ust _contain_ the
ACQUIRE_ERR(fd_prepare) thing too?

I realize that you can't make FD_PREPARE() just return the error code,
because it needs to be a statement (in order to declare the new class
variable). So while I'd have *preferred* to see something like

        retval = FD_PREPARE(fdf, open_flag, open_fn(...));
        if (retval)
                return retval;
        return fd_publish(fdf);

that doesn't work syntactically. Foiled by the pitiful C preprocessor again.

But since absolutely everybody *has* to have that

        retval = ACQUIRE_ERR(fd_prepare, &fdf);
        if (retval)
                ...

sequence immediately after the FD_PREPARE(), and since that really
looks like magic line noise, I feel that it should at least be better
integrated.

It could be done multiple ways, I'm sure, but _one_ way to do it would
be to just add the error variable name as an argument, and write it
all as

        FD_PREPARE(fdf, retval, open_flag, open_fn(...));
        if (retval)
                return retval;

which at least avoids *some* of the line noise.

Another way would be to literally just add the "if ()" thing entirely
into it, and declare a local error variable. That can be done by using
a "for()" as an if-statement, ie the final part of the FD_PREPARE()
macro would be

        for (int FD_ERR = ACQUIRE_ERR(fd_prepare, &_var); FD_ERR; FD_ERR=0)

and then you could write all of this out as

        FD_PREPARE(fdf, retval, open_flag, open_fn(...))
                return FD_ERR;
        return fd_publish(fdf);

which admittedly looks a bit odd, but at least avoids having to know
to write out that ACQUIRE_ERR(fd_prepare..) thing, and generally looks
pretty readable to me.

That last thing is certainly compact and avoids any extra noise, but I
think the FD_PREPARE name might need changing to reflect the fact that
it now acts as a if-statement?

Maybe IF_FD_PREP_ERR() or something like that would make it more
natural to have that error condition as part of it?

Anyway, I think this RFC v3 version you posted is certainly
_acceptable_ in this form already, but I get the feeling that it could
be bikeshedded a *bit* more to be even simpler to use and not have
quite as much boilerplate...

              Linus

