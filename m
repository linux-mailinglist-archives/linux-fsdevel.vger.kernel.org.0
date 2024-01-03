Return-Path: <linux-fsdevel+bounces-7250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C55823566
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32ECF1F25755
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E71CAA8;
	Wed,  3 Jan 2024 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EqAcBFq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69ED1CA89
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1257005a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 11:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704309317; x=1704914117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VqpWt6ocefEfDXK+KnHNKXoEM0IL+DB/QDp9HBirG1E=;
        b=EqAcBFq97pFwtmYe13BC1tWt0GnonY1LTo4njL+s/snL8yXFgvwnYkRUvAtt0zQ9y6
         1mAGHvuhP4DgrfVmN58DjUqF4MjT9AUfQ9v+xAn91VKSdCaUBG/PJsNgglyc+tUo5uIJ
         agJzYaT5uMGGPb5c8DZYQb6Ljve9/cQuK6XK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704309317; x=1704914117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqpWt6ocefEfDXK+KnHNKXoEM0IL+DB/QDp9HBirG1E=;
        b=QVHcTuG35BW/Gd1XgxldsSUFA0VYXO57svQlDjxVzgCoNGQnRp1vt/kEW40ml7TRf0
         udvMfEzFX3D2Z+H+/IgAqMF/H+Vdg5Mwm0Obv1pqdOaN1CAi+IX55BUs23+lXN6N+PcJ
         rR9ufLrimo2BZWevUyDwUZHHCclQCjRvf5O6p/5BpfW7c1FK3leUoJlyiHevl5zuG2oD
         mKXGHLKj3mBjVj/z50u61ERAi1XNwT2GKPgMs3EEXHv+SOEjDG637Got9Xr1yJI+0MJB
         mSgsjRYDNVhM6vqb2ElrapYjAo9oI8Z5oiWvChKk5pqAzKB/2qcGfFHzzuwQ/Piuba8U
         CV5g==
X-Gm-Message-State: AOJu0YwRkKXlV8hgtw9ZJK9w3OIdwXMhAY23Ei8lbUJccR+NPZmKGbZD
	vhjPrQSLzq++RmzhjhNblH6Rn4ZtPnYLqrfwlJK5mFIZkg7cSZcD
X-Google-Smtp-Source: AGHT+IHBNk+nZYma5zbbSEtndmaYV8frhbGoyUzQsbo5lCkh1I1dYUsP9ZUfU43EGMhYIa7p/Ewm5Q==
X-Received: by 2002:a17:906:189:b0:a28:8cb2:e5a5 with SMTP id 9-20020a170906018900b00a288cb2e5a5mr681868ejb.25.1704309316885;
        Wed, 03 Jan 2024 11:15:16 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id gh33-20020a1709073c2100b00a26b3f29f3dsm11925216ejc.43.2024.01.03.11.15.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:15:15 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-556cd81163fso1036045a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 11:15:15 -0800 (PST)
X-Received: by 2002:a17:906:ef0c:b0:a27:6fbc:ce3 with SMTP id
 f12-20020a170906ef0c00b00a276fbc0ce3mr3854440ejs.42.1704309315585; Wed, 03
 Jan 2024 11:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <4dec932dcd027aa5836d70a6d6bedd55914c84c2.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <6c3fc5e9-f8cf-4b42-9317-8ce9669160c2@kernel.org>
In-Reply-To: <6c3fc5e9-f8cf-4b42-9317-8ce9669160c2@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 11:14:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
Message-ID: <CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] tty: splice_read: disable
To: Jiri Slaby <jirislaby@kernel.org>, Oliver Giles <ohw.giles@gmail.com>
Cc: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 03:36, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> What are those "things" doing that "splice to tty", I don't recall and
> the commit message above ^^^ does not spell that out. Linus?

It's some annoying SSL VPN thing that splices to pppd:

   https://lore.kernel.org/all/C8KER7U60WXE.25UFD8RE6QZQK@oguc/

and I'd be happy to try to limit splice to tty's to maybe just the one
case that pppd uses.

So I don't think we should remove splice_write for tty's entirely, but
maybe we can limit it to only the case that the VPN thing used.

I never saw the original issue personally, and I think only Oliver
reported it, so cc'ing Oliver.

Maybe that VPN thing already has the pty in non-blocking mode, for
example, and we could make the tty splicing fail for any blocking op?

                Linus

