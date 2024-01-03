Return-Path: <linux-fsdevel+bounces-7266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7D482375C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FACB237F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 21:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A21DA37;
	Wed,  3 Jan 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XzPohwl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045361DA23
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a27e323fdd3so307009566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 13:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704319068; x=1704923868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B48exi/vSSjCNhOi4YzTWDyLBVxd7y5kwoUyxHuxs+c=;
        b=XzPohwl3GTxre9wjwR0P5roC+Vg5YtkZqlLPBq4KkRVjSqkA/5RjfhUvOtkmHFi0j9
         +dFoInS8cxhztvTdd8OJ3lobBlYsSTGpjEc3cgVPRf9kRK1ivdQHmam3q8o7RMvdSLls
         qG5FndyBEu4lIbYtpl06+M4n5+7FqPAi8zSJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704319068; x=1704923868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B48exi/vSSjCNhOi4YzTWDyLBVxd7y5kwoUyxHuxs+c=;
        b=ERZObVrwzUwNc1SNAYBPL7hMyS0afx7i5s4EDB9wyznauZFuMIruptkWgrpPQzC5EB
         ZRUDqExOpCEryo1iim3ep2EDCtk5gN2CQVzabIC+KVfZOuunJmBBBnJv+k1FTsunH4OC
         ht2ySYSc0qPpnNfbiSAKU48/L+Z3cz2GxTLmq2WW2g9SCABh3Vhfgwab4KHFKVd7HtYC
         bkn3T5u4kUZaeds2/w9RldJZha6wj4GJsoh3WRoo2i5+oLr3s2bnUEEd8HJ1TINWUe24
         aKJzY9fGLzcFcrJDtHpCcGUOMxuigpo4w28cFpPiKphkjH6PcYEFsuE1AGnm5HFva61x
         iBPw==
X-Gm-Message-State: AOJu0YynwK2LvXFeFl+9pifq4LkyG/B7GuGhu6UH/2Lxm/RjUAhTrDWB
	9WPRaiqox/55HcmE8g5mVfOo6ILtKPoVEjs6Nmxnbi1wVkLsPBJy
X-Google-Smtp-Source: AGHT+IGn5yRieM4tIf55Y4Lg/gN7pmSqic1zLk5vWX1eBP1SI6ywSa8UicnOITIxZEOBL/4mufi2NA==
X-Received: by 2002:a17:906:fe09:b0:a26:e292:394b with SMTP id wy9-20020a170906fe0900b00a26e292394bmr9815068ejb.67.1704319068162;
        Wed, 03 Jan 2024 13:57:48 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id ka24-20020a170907921800b00a26abf393d0sm12549264ejb.138.2024.01.03.13.57.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 13:57:47 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5336986cso108078005e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 13:57:47 -0800 (PST)
X-Received: by 2002:a7b:c405:0:b0:40d:6299:3b6d with SMTP id
 k5-20020a7bc405000000b0040d62993b6dmr5498997wmi.212.1704319067258; Wed, 03
 Jan 2024 13:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <4dec932dcd027aa5836d70a6d6bedd55914c84c2.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <6c3fc5e9-f8cf-4b42-9317-8ce9669160c2@kernel.org> <CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
 <2XFP6S.GINKQ8IKAA1W1@gmail.com>
In-Reply-To: <2XFP6S.GINKQ8IKAA1W1@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 13:57:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGfiJS692Gh1sRkqGpZ87Ra-Rvg46EciSU3fUDD3HDug@mail.gmail.com>
Message-ID: <CAHk-=wjGfiJS692Gh1sRkqGpZ87Ra-Rvg46EciSU3fUDD3HDug@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] tty: splice_read: disable
To: Oliver Giles <ohw.giles@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 13:34, Oliver Giles <ohw.giles@gmail.com> wrote:
>
> I'm happy to report that that particular SSL VPN tool is no longer
> around.

Ahh, well that simplifies things and we can then just remove the tty
splice support again.

Of course, maybe then somebody else will report on some other odd
user, but ... fingers crossed.

                Linus

