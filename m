Return-Path: <linux-fsdevel+bounces-23067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224559268D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 21:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B6B1F23F01
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 19:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CFB18A924;
	Wed,  3 Jul 2024 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q2y0pQhg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C3178367
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033526; cv=none; b=UJV+SJCj4YkwO9TPGqcdEb0VsI8F5Ed3qYko2ALQFC0yHbXdK8kAZhzk7ble+hUk5HW/lCi7RpysDjyUJiwCpDDA7ICLY9MUQ+HFsiy9zfnuCpRtyOjRQHSqPV5/QteH5hw+IcTs9DBgDYFJ+G0eCp8fl1eOEb6hI6wqaOYFY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033526; c=relaxed/simple;
	bh=yBaVYEswZrvbgKnS47fptzlPQ1fF8FvBjoGLyqFPLwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXqYj4lCJd03qA4DKQnD1uv9hjP0UgEiz0BXcC1WOjEI9byc5/4A5i2+NEEeEWbPK+99tbf26GzxZi9niA6nHJhMRYPCqEL1FzJrAVfbrTfTREHiGt5J47NhtS8VekDNI2LPl8iQdiV6j93nfs0Bysz8NiWtzv0lk0UVzbXxT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q2y0pQhg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so3719971a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720033523; x=1720638323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Kf3K019bVOQK2OWkQy5jBzht4Y9Q+WIcCF0i+S26bo=;
        b=Q2y0pQhglU+5brt9qIBu4Ws3qolUOehnmV4uR0qMdGXg74nHPphEdpMLS0Xyc3cG1+
         lZJTp06Lo/GBP0+yDlTj5QhsZzsFsIkoFTGLiUvTXF2ccFHgMKlKxp48cDtkUMx2JR/V
         Eu0N42+42QpMOQINo3EtI9tqZ7rMtYJeCzzOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033523; x=1720638323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Kf3K019bVOQK2OWkQy5jBzht4Y9Q+WIcCF0i+S26bo=;
        b=PDqzvCFk3aB0aym0aHeHhPZBhIFHdxS1KtnhGgXSRRUGZ+ot/Qp/WiXnGTQfV++zeF
         bfz4VANYAMDcX8F8USZrCSEAQbca+r0At1P9lUNDZ2UWbqDiYVqmEdnCyJJePzdsuylA
         sN3/6bbOMnm9E5bdyS8dxfGDIOGUlS53kll3naOTFbcseq25ojYnu4CYDdp5h6kG967c
         7dw4wJP11aj3TCPny7gNm3e9lGowiwp+cX7XDB9RewavRZqzBMBmGeN9qvalXNqU5h41
         j74qGERM009J/d+Mu3NjIgkb9GKOEZLokx6tq+QzTco4JgLF8Jm78qVH+8FMraCtHd0R
         FVwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqBK0r9pI6UJ+LmJ42xAOQQhZytYeVJDgKd6QNvpSJmEsoVOwEMFzfTjRni0cnsceGmjk8Q1CH90Ev1yN4K/hUD3qEMQXVUylD+bfuRA==
X-Gm-Message-State: AOJu0YydRVyAQS6JaAwZgXwNVcKX6XEsoN5ia2cGvfiCUA3ZlwwqZnLv
	w9syKR7eWsxXz/T73AjBWrhV6b/8ch0rgUt5hRwfFXR4A98UuOXG7XUB5MRjVwO3TbsXa6wzHhE
	u7p9J2g==
X-Google-Smtp-Source: AGHT+IGgtdUHZDVicl8rOK6zgPCgLaY9TCjSz4D0+5pmbr1+/jVRv/mlwImdmgYjsvELQZ/52bZCyQ==
X-Received: by 2002:a05:6402:40cd:b0:584:8feb:c3a1 with SMTP id 4fb4d7f45d1cf-5879ede2784mr11335373a12.1.1720033523047;
        Wed, 03 Jul 2024 12:05:23 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c83529sm7464479a12.6.2024.07.03.12.05.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:05:22 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a724598cfe3so709276166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 12:05:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDsxh0kdtsh+QLGe4ycDWOTr9hq/iXiBZ+WdogDGJmn4U8TVi5nZ2tWz0KMaq0jH8eRyJwU6oiVsCt6ZyWNdFur1KN4LtizzNZQYccow==
X-Received: by 2002:a17:907:2daa:b0:a6f:6721:b065 with SMTP id
 a640c23a62f3a-a751448a5a1mr1186982066b.32.1720033521063; Wed, 03 Jul 2024
 12:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625110029.606032-1-mjguzik@gmail.com> <20240625110029.606032-3-mjguzik@gmail.com>
 <CAAhV-H47NiQ2c+7NynVxduJK-yGkgoEnXuXGQvGFG59XOBAqeg@mail.gmail.com>
 <e8db013bf06d2170dc48a8252c7049c6d1ee277a.camel@xry111.site>
 <CAAhV-H7iKyQBvV+J9T1ekxh9OF8h=F9zp_QMyuhFBrFXGHHmTg@mail.gmail.com>
 <30907b42d5eee6d71f40b9fc3d32ae31406fe899.camel@xry111.site>
 <1b5d0840-766b-4c3b-8579-3c2c892c4d74@app.fastmail.com> <CAAhV-H4Z_BCWRJoCOh4Cei3eFCn_wvFWxA7AzWfNxYtNqUwBPA@mail.gmail.com>
 <8f2d356d-9cd6-4b06-8e20-941e187cab43@app.fastmail.com> <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
 <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com>
 <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
 <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com>
 <b60a61b8c9171a6106d50346ecd7fba1cfc4dcb0.camel@xry111.site>
 <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
 <CAHk-=wii3qyMW+Ni=S6=cV=ddoWTX+qEkO6Ooxe0Ef2_rvo+kg@mail.gmail.com> <e40b8edeea1d3747fe79a4f9f932ea4a8d891db0.camel@xry111.site>
In-Reply-To: <e40b8edeea1d3747fe79a4f9f932ea4a8d891db0.camel@xry111.site>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 12:05:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJh1egNXJN7AsqpE76D4LCkUQTj+RboO7O=3AFeLGesw@mail.gmail.com>
Message-ID: <CAHk-=wiJh1egNXJN7AsqpE76D4LCkUQTj+RboO7O=3AFeLGesw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, libc-alpha@sourceware.org, 
	"Andreas K. Huettel" <dilfridge@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 11:48, Xi Ruoyao <xry111@xry111.site> wrote:
>
> Fortunately LoongArch ILP32 ABI is not finalized yet (there's no 32-bit
> kernel and 64-bit kernel does not support 32-bit userspace yet) so we
> can still make it happen to use struct statx as (userspace) struct
> stat...

Oh, no problem then. If there are no existing binaries, then yes,
please do that,

It avoids the compat issues too.

I think 'struct statx' is a horrid bloated thing (clearing those extra
"spare" words is a pain, and yes, the user copy for _regular_ 'stat()'
already shows up in profiles), but for some new 32-bit platform it's
definitely worth the pain just to avoid the compat code or new
structure definitions.

              Linus

