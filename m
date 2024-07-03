Return-Path: <linux-fsdevel+bounces-23060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D42E92677E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 19:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B6D28339A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12BC185E53;
	Wed,  3 Jul 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dRFkz+PV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D171C68D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029314; cv=none; b=MohZQ+l2ahMn0LtA+q2RW2a2n9P9ZJHF4O2Ox9qJ4rRm9UDXVdkvpy6fAAH+G9YduOsH9MsYg2GshXPc97V+T5I71DkpKHzx08Ai1KEf1QUMIPc7onYhOCbK+iAWvqE97hbE2BkeetgvErNDND7mo34ckphI9+ToD1s3JV+zVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029314; c=relaxed/simple;
	bh=7f1Jw4HvKMPAz77zJdFLUyAdloZi7jiFu3rAdtPOMZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YI73nuvzLaY1H1pxiDiS+6lBSllyn1hv7G/Gl+Lm/OzsLBPmRdpQ5bOKkyCGm+YG0RXyGAM8m6e96yoYpLtGase3N4atc9NnePfdB1aWn3XslvjdLTLPo0gpp5qodgRzCHuuEbv8CcHjbp2nvGFgXhoaLQchj1rvaHx1qxyHqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dRFkz+PV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a72988749f0so846669666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720029311; x=1720634111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jBLAgZolniuYLkImL+HV9eymQn/u6hu6ZNMnsLo1ncg=;
        b=dRFkz+PVNNxOiWhMAVJ9mtzjL02jXuLf9B2nWBsrLdLnZS+tEw0kK665dewopzR5B/
         CbeUi8LtlcnnEDWRBX2MO9N3yHMgWmj8EsoL7rYgtbRbblaaxK0urKfy7rJi6v4BtSxV
         2WO/uKUjq2flvMTlh7q9iZXJ4QWCd5SG56DTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029311; x=1720634111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBLAgZolniuYLkImL+HV9eymQn/u6hu6ZNMnsLo1ncg=;
        b=ZyGG4AYPnnZYW9/CdwwcT9A8X7vDDEzEgjL/0HmZtFspWFGH7vcHi5O8PZu+tolEVa
         //Eu1yWs8irCxHxagHqieLIxCwjRbdyyk0wVmhOgbxPOscR9vLwzi2PMasM2/UFcVSCz
         IV7ryMnEBprm1oDCPkkZK6GyqpY+5ZYciiQSBmNyYJVzJm/88bVaDR+aDXtr5bJ6LbTy
         UaTTxxhDCxqTISToyQPYlK5hn9EiZXzcTVijnpMATjgYWFFMqvnAqyEubmxxW6RAAOMP
         0saVfUC/yvqjrQRFLidNY6PODq43B8Ht4XU0AQpiFfaa51VCxDDe1SUlJ+Xns/YxD59k
         vdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGltQScCldy0sbDpcBZU+Xa9e6of8XUcorHJasNkmj8oP1zifsZ+fyuPytq3vMLO0PZlTuz9+/h9cLN3YurWsz6s1NeEgf5RG73K78zQ==
X-Gm-Message-State: AOJu0YyyMzPV9o+XXP3t/OgFIbId3YUskP38aA5jCj5GRgNPNk2m3Hpi
	mjdhaJvGO7JUVDYarO8plEfr0KkZGJ9C/pKZjv/1RqT3EQU9n20dz3fQQ4GzXrGHQ0i0zxFTzh5
	q2voIHA==
X-Google-Smtp-Source: AGHT+IGRwJebAO11rdjT7aUDAD75l/I5SQ9kna8zES8GkDDYEbAY+3KySQ6LxurOWggNEPelmH2VEg==
X-Received: by 2002:a17:907:2d25:b0:a6c:6fac:f1ff with SMTP id a640c23a62f3a-a751446289fmr1001583866b.12.1720029310726;
        Wed, 03 Jul 2024 10:55:10 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0657b1sm525769166b.133.2024.07.03.10.55.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 10:55:10 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a72988749f0so846666266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 10:55:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeYaGItmfcw1k1ajyJ4yatXg2Yngu2duIBOLT6P5Fds9kPqaYFTzDoML3yy/SXoJozJeIgVZgcl82s0rbjLWhjD7ubEMijoosSyO3H7g==
X-Received: by 2002:a17:906:7d2:b0:a72:4b31:13b5 with SMTP id
 a640c23a62f3a-a75144f61a2mr779219566b.54.1720029309600; Wed, 03 Jul 2024
 10:55:09 -0700 (PDT)
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
 <b60a61b8c9171a6106d50346ecd7fba1cfc4dcb0.camel@xry111.site> <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
In-Reply-To: <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 10:54:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wii3qyMW+Ni=S6=cV=ddoWTX+qEkO6Ooxe0Ef2_rvo+kg@mail.gmail.com>
Message-ID: <CAHk-=wii3qyMW+Ni=S6=cV=ddoWTX+qEkO6Ooxe0Ef2_rvo+kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, libc-alpha@sourceware.org, 
	"Andreas K. Huettel" <dilfridge@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 10:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh wow. Shows just *how* long ago that was - and how long ago I looked
> at 32-bit code. Because clearly, I was wrong.

Ok, so clearly any *new* 32-bit architecture should use 'struct statx'
as 'struct stat', and at least avoid the conversion pain.

Of course, if using <asm-generic/stat.h> like loongarch does, that is
very much not what happens. You get those old models with just 'long'.

So any architecture that didn't do that 'stat == statx' and has
binaries with old stat models should just continue to have them.

It's not like we can get rid of the kernel side code for that all _anyway_.

             Linus

