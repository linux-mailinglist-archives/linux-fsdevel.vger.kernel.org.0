Return-Path: <linux-fsdevel+bounces-62236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D59B8A467
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2953A02F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B1318151;
	Fri, 19 Sep 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="xbo3W1UF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB731771E
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295505; cv=none; b=fFYNtORQfpS6S/3jNu7gM7LgEkB1dGRQjMhoM7NvUKjFEvW+3mWPJVGGu0xbeoZAiXVt1o2mFiNu86ZqT/JtP3R1Df0q7m16EhQHG+JaoK1b0XmxDASyTR21xCs8auhy3VbHwgN7N5pDczU5J1UDg2NTjW6//1ntY266nhU6BfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295505; c=relaxed/simple;
	bh=tIBWHHOOKfm2qL1G0oNEg1lQ/EY8RTTkm2B9w+25Bvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQTZHvCUoLrihlQM/OuyjS6vG6XwCmRBP/PAntNe2cCFb0I7rFtXhS21gy8GlDvp89MRhU8UcIkik2ABRuiIwOCdL+elwZ688fFWNGQVvnKvnKHuES5yeLSFrzFxgkzyQeA8Q+CRY108/sBOI4jAqaBIgR12XMO8WLIHr3HTSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=xbo3W1UF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57afc648b7dso342243e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758295500; x=1758900300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EztjVQ+y07YMfegmHOd0VyK62XkODMWu0LdNE29WAS0=;
        b=xbo3W1UFpKFkZ1p3cmir9bHExoubmn+zN65uKZIOYM/VNr4k3So7pYfDI6mX/D9Xs7
         tKrFxrKGsa1OUV4/BaJm81tBW61J4ZGYYxqxZFHL+2WJXFRTEp/mhXDIaLf+cQRcgUXe
         AYqPNZvLbxLN1AyYo7ig5n8eVxO+iPi1huE+4hW6lV7MZkf7YHIdjHXfXdto2VLmATJZ
         knqRg3MYiebrHRGL5TV4krfrv3EaVDwqo3YKPYYlEuRSeFOsywbR4G16hcwfzRVUvkmK
         +8rrea1TuR59LvTS19HlGLqGt+kLHJ+F5+322OVOV6/84SIcgYqHnsi5cc3ulWFd4ja5
         pnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295500; x=1758900300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EztjVQ+y07YMfegmHOd0VyK62XkODMWu0LdNE29WAS0=;
        b=dNUiagh+Q1yVrfiVCFXpKVxSaVrhtzt4Z38L2smBkixjEh8Spzdc1KUoo1zW7ZQY5g
         BOul/e1wN5fXHggrDcAAKAqCktFSnbnHTv5iwqLDIFCzdjPPe+c7hk7cMHe7QgkSqEeM
         GCSDHlTqjOWb+BWuf6xKxzI7RA8pq8lyDolirWXOBk78CWCUsPPFpkt4w9xIJ9LPfmE1
         gxltA80wgBUs5vQlCv1atPmIvSaPScsEvnql94GVlUU0C9K/6HP0pyhIBm0o1PEliJZl
         RrcLImW92dnqh1tPglbLAVkvagvITsWa4QmAMLsAKuqxUrInMd6/drWRTXKQp/wcgNR9
         NQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/we3THSiaE/rAXlTBgepf53bmy+y9jDGRmGhXXnO1qfDL8B+qwqhQ9RXGGPK3PhfIuu1SKHoxv0cxAx8L@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcYQB/xviB1JeBzjk8E8O2+wOE8Klr/QKb1ptp4WryJKD5Hdi
	Fqm6jGZRaJGOFsu25BQJifN2oz8AA4cIqDgqmQ/BrmOiU1DzF4BbTXE01dxPfDvdvLKvn/F8yeL
	hVnS8Ok5zJeGtdJXWIIz2dvwgWnFBPqd7hZiCb7NfdQ==
X-Gm-Gg: ASbGnctYU1zBHciny3p/OGDMlMK2OUclD+UhzQJv8Vc2qwuYVWuRu/We0zXI85zdue7
	UoQ6nMYFBsRc5y3Te/RaQIDCSDJIkSfRjhLFwsOjTRjanA2uPfIEYk/ZIfS0ybQ/hDRzX1jK11Z
	rwEn8Ee7i9KX9hfE+56fJJ+9O7u5oh9T1SbbyunFiQvEEQTAxAsLopjLINucv3e3LWRyHNQdzVO
	va4p58pt42KnX0=
X-Google-Smtp-Source: AGHT+IHin4gQus9SrkFEog2pTedfunr2Ers950l0f82oxrEtfjemfexmsAorW/Dsqdjvay/GpFMt6pfW/hwC+qBHF14=
X-Received: by 2002:a05:6512:2c0b:b0:571:b70b:7dbf with SMTP id
 2adb3069b0e04-579e2507c81mr1455897e87.17.1758295499599; Fri, 19 Sep 2025
 08:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
In-Reply-To: <20250918195806.6337-1-safinaskar@gmail.com>
From: Nicolas Schichan <nschichan@freebox.fr>
Date: Fri, 19 Sep 2025 17:24:48 +0200
X-Gm-Features: AS18NWBwMqIXE_dMXDlT0ngUIReSbekPPTszWv5gIfg03bAEg3Id33JL3Yqjedw
Message-ID: <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

> > When booting with root=/dev/ram0 in the kernel commandline,
> > handle_initrd() where the deprecation message resides is never called,
> > which is rather unfortunate (init/do_mounts_initrd.c):

> Yes, this is unfortunate.
>
> I personally still think that initrd should be removed.

Considering that the deprecation message didn't get displayed in some
configurations, maybe it's a bit early at the very least.

> I suggest using workaround I described in cover letter.

I'm not too keen on having an initramfs just to loop-mount
/sys/firmware/initrd, after all current kernels are able to handle the
use case just fine.

It looks like there is a lot of code calling into specific filesystems
so that the initrd code can guess the size of the file system before
copying into /dev/ram0, and I believe this is what causes the main
gripe against initrd today. What is wrong with just copying
/initrd.image using its actual size into /dev/ram0 instead of guessing
it with the help of filesystem specific code ?

> Also, for unknown reasons I didn't get your letter in my inbox.
> (Not even in spam folder.) I ocasionally found it on lore.kernel.org .

Sorry about that, When I used git-send-email yesterday to reply, the
SMTP server I used wasn't authenticated to google, so all gmail
recipients were dropped. Hopefully this work better today.

Regards,

-- 
Nicolas Schichan

