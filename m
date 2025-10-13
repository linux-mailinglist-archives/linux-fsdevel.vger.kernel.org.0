Return-Path: <linux-fsdevel+bounces-63941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD03BD26A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 12:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4759189BC36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352222FE596;
	Mon, 13 Oct 2025 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYGb4s7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40982FE564
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349601; cv=none; b=kqklzxFIM/kajvUJrKJhY07rD2aMcuL//YHkA70Lzdh1IdicVGSTRzTTT+KEdnv8hPr2G3qOZYjBPsizFYvBbAEV2VZpIKPOfdgePwbM7hxV79rkW9yddaw9bLrtTSl+or+72Kr1CXzohHQVxNUso7VQI7UDWSvLY+JTlGlSvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349601; c=relaxed/simple;
	bh=+zOuCBbttI2pym4Pdpz046IX8ZPwrX2sj4yc80Raf0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnNWvvWOjsBO7WcdZZkbhIiPrRyC/2CIDMCMnA7sUIvCqiioxTeM+uY3ZHD+PEWkr8Y4XAUt89VS7OWFvotz/tr2WBEFB1qxVJolxvx3Wtqgz0aGnU3rTN1yvgIiMMGvQf5krllxVHgSE/roJ+RgrJGdqiPJVZalBBOmqio4pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYGb4s7P; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6348447d5easo3766428d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 02:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760349599; x=1760954399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZsaCMPk0e7xOahYxc9B2HTwzlp/3SZdj7OzfRUl7Tc=;
        b=lYGb4s7PFPtlQAqGLwjY6C3BoptYCrvsiQTPmRJWe0jrmue4kzt875LXGc+nwMus5e
         gg/dRRivympKqj/Xbh/kqv4jfo3sNkaRAWWH4kZP7QO+EYk91Xl5ZvumS/kg92GHtPjk
         j1DbxG/Dgk3vmqFQjqZbS6cxMNqHU4DeIsE2rSdChE2dhflRSZVNKpBaEr6XVXJ3d+35
         Uw6w91MZJuEBrgw2xCsk0gcBTZMcncRHXUPfRkRDe21ahILoyvU3E/QbhqdS6KHwrvfA
         79Um23YLTNO6t/m7Vr/uQlJA0nZ6SxJWNCgTAeqdZEx/sH8Vu9rR490wZ3vArZnHDyqH
         MjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349599; x=1760954399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZsaCMPk0e7xOahYxc9B2HTwzlp/3SZdj7OzfRUl7Tc=;
        b=Es3Yv3QXkoj3granHvVN+3uzBwoIloJzqR+wfR/Dw0bYUDgTc9OjKIDAp+QXWkfbrl
         9ItrP/C2YBu0ckJtJugZNP9CsG1caKlYgGgQXHWHBSES/EEOuO17wGMLFSiOjaFKDcEP
         ehzs4fNM+XERLjduBhegkGnz2xh+2XdwxwC4EQberJFYiZwBhlQbSqTw0sdVUnjEyYhy
         OwQZEoZyhhp/tgs7bFUMNRBUxwn53d2ODBvPCcR40BbItkkNBWLB6zS7+rGI+/0X0/VT
         isGN6BVzzvN/Q/qTFqoJukS35eEYH5WiBgXM7TfoSPhoFHRTbFopz9dMkauM+WyZisix
         +6RA==
X-Gm-Message-State: AOJu0Yx2ZADzzqU+oIL1HU29UJOJl7oc304kgC11XA8sh4dwU/EZq3Vn
	92AOv7v7tW6VzrjWao03s7okr9N+++Uoead4yXS6oSlWLIZk76Ye+lB+VF8G24pr/OdZg7yeIhg
	W5FSReyTjn8tDFxCQ6pRd34SfcI5bboI=
X-Gm-Gg: ASbGncsEsKoIkHczs7oP5E/i7Jo3MVoJ8mScS2480feTLP5KEjL5ywVEInYSYxd0MSW
	KYvZcM3tDNv6fShMI6KrxdzQIlVLQskgsaU//SY0EJMwfsgFGF3GtSotR1N7E/uVgiyvgwkUjJ2
	tju/ymhcWW3LDs4hFaymb7bu8ReqahLxzRQmFUBXCpspBiGzPxHe33gnwwDiLmXHKteQe8GhXuP
	m1iKEvbo6lXadoilAPbCQxYYkupEyUYLVwA
X-Google-Smtp-Source: AGHT+IEjiQMnhpQ/Kb5hfGFGrybCEQQLnH8Bm2H6/rcdu7ghvXP+Te8kpl6LHQn/PIgvNHwUMvVrGJdsfOorS0mdutU=
X-Received: by 2002:a53:ee07:0:b0:63c:daf9:bf21 with SMTP id
 956f58d0204a3-63cdaf9fa65mr11783686d50.24.1760349598638; Mon, 13 Oct 2025
 02:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-3-safinaskar@gmail.com> <CAHp75VezkZ7A1VOP8cBH8h0DKVumP66jjUbepMCP87wGOrh+MQ@mail.gmail.com>
In-Reply-To: <CAHp75VezkZ7A1VOP8cBH8h0DKVumP66jjUbepMCP87wGOrh+MQ@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 12:59:21 +0300
X-Gm-Features: AS18NWA-897xF_-UIFWa7pg6NN4-821ID7y01MXNqW6009NHHhcR0gsdnks-4OY
Message-ID: <CAPnZJGBAc-kqZ-MAKRGrk1big=N_GZupxKgM_+TodqgteffLvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:05=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> > -       noinitrd        [RAM] Tells the kernel not to load any configur=
ed
> > +       noinitrd        [Deprecated,RAM] Tells the kernel not to load a=
ny configured
> >                         initial RAM disk.
>
> How one is supposed to run this when just having a kernel is enough?
> At least (ex)colleague of mine was a heavy user of this option for
> testing kernel builds on the real HW.

This option applies to initrd only, not to initramfs.
Except for EFI mode, when it applies to both.

I will remove this option when I remove initrd.

In EFI mode it is easy just not to pass initramfs, so all is okay.

Also I will clarify docs in v3.

Also, please, answer here:
https://lore.kernel.org/regressions/20250918183336.5633-1-safinaskar@gmail.=
com/

--=20
Askar Safin

