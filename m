Return-Path: <linux-fsdevel+bounces-63860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68BBD03A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 16:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A51B3B3783
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 14:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003DE286429;
	Sun, 12 Oct 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvUM0Saw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7857286404
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279152; cv=none; b=fXOub/Te1Y7LWyPYw+mZ13oujmlgYDVxqpPERXHXDluDEhWqeL1z41+7I0hZXmU/rfKFtEGlbEWbbWdV+kP3tsKJ3anY6Dyj1G7kgyu1l5kOvKVZCfCNRG39j6Ya6uv97QmOXeo+CjoBSIDvDKryIFZMGt8b/qIPP30qd7CCUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279152; c=relaxed/simple;
	bh=PpEZLAkPjAJdXnEnlZlPVoCkMKKS3ABCk+fUadrptZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCwlhw1oLzZJ6HJXMhsa44cVk5cplf6PBTYCovlmA6INKfEkp2K3tPaygbWeCrnmmFtn/uYiZg0YMpdSlZKWWY8lz90EaPYKAFnDuWBgJGCkUmS/DEZq3+LD6uT2Lht2IAxMZG0qLisekKHRs4+sX7FVM/Oywt323EU5u9M2b3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvUM0Saw; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63bcdf5f241so4855551d50.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760279149; x=1760883949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fMV5+oJY4Oj9tnMbJ06MZM6D9GED7063UwCEjj637k=;
        b=LvUM0SawsWEBC0Xj1/TnPr4Ff4qx/gYOjIhfZKeDdhy+mwpwZYAdMrtoKWbzbsg3N/
         wpJed9DPpV55cGAKqUgmjNIvCYFx39fmFRA3tVgBuE2JBZ2IRCHlIkFMCbC2QSKHE4s2
         3vwP/SrLo2Q6SxdcuE7A1aHl9cJGvgZbVu0g2b56CBSqVy74+I+3UAZBfrPduaxbskdl
         5Vsxi8M8F2iplozG+TM1C0fbGcXvCQfcs5+4BjOUKRknjPkTpiqwmqnNYHC5JTqkowXx
         lgJKdQgPwURDOkmkZ9zZhHLLFsWtk9HGwerHYr2F0VCJzx+WlMWlfh74OYK1/zg5WaSB
         ltNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760279149; x=1760883949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fMV5+oJY4Oj9tnMbJ06MZM6D9GED7063UwCEjj637k=;
        b=MptDVZCRm+zpbnBXeKSaspiES82H7/kQ+f8xTeMMYvefAeKQPJqLlF+nwhxviMnoJB
         V9RRgx8vXrn313+VSLot/CGcdqLYbkNXaj39v3mXbeIfrdfpeWcJmz4vQc9w31hqjw+e
         yKwfMZqkBCyPACmE4tfDwwobphSX1zid16fvfYH7QFqaSZUZzIKLEXnR2/VBS8Habn0c
         mijjOrrtM+qXWiKuBaLtLImM78PtZbpwdC76kxqYacSiWuoxn0iN9b9ZrMddxi1ybtO9
         FUHgiHLcaAat9EPxwDRCdsQCZy5faTVZw5YCTkIMq4fUDDlycfvJekr9DjQfxwg6J8D/
         m5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP6GAVr1RLHPEZugFRWZxDINtjOcH+VD5gR0s/bc5dXOjZPxRWf22PTP3z5aUPBQ99ySyWFyBsaIB6Xz3A@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbn4awsh+iX5JDV3JzGn8gxIXNx2aQTzP6pFN8K0qJc7I740R
	xYyxxfZDLGf9PVmWvyUr8pSJYEi0zusmyXThN+LgL6H5wF2akg82lSKmL9xVto7R68R67NghKnR
	LGV+a5BHERO5lfIIAUQ6n+tNaGPbP3Ug=
X-Gm-Gg: ASbGncu97fiO22bQAiQDfzTZDGqbUBu403PfzumT7CgkRKiZyrS3KPOm4bOFcVZvGFk
	j+437SUEgX5fuMcbB59xQbE6f/3gUToxeMkUehRsFfiQWjGF2kGafa9x7atL1DbOWFv5m6Es20k
	jIwjzEhhtXCzjIK2GeWitYKc5X4raLvcVVwB9MFMTXlJ+p6A6LehI3QiK7Wgqqw6L+5cNliGJSl
	R1fO+TXBbvh1t1H4s5sONsIcqXsnM/JGpROtHUDzvrHDPlaCMAKxy4R9XoxKvp03pD+63w=
X-Google-Smtp-Source: AGHT+IHmxiF7nVA3plgtnQqzvawJieYggf79AOyr68QSOl695ikP7vNaryvJojZvuI4FaLPjbXvyeSFSgXSKkGbnvCk=
X-Received: by 2002:a53:acc3:0:10b0:63c:da71:e38f with SMTP id
 956f58d0204a3-63cda71ff12mr10421050d50.3.1760279148739; Sun, 12 Oct 2025
 07:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
 <20251012125819.136942-1-safinaskar@gmail.com>
In-Reply-To: <20251012125819.136942-1-safinaskar@gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sun, 12 Oct 2025 15:25:37 +0100
X-Gm-Features: AS18NWBVfoyBRd5-fZ6Zr5cXh7eUoOgNBeTIO1AtyhLxiUaPpLgGuteQi54v9Ow
Message-ID: <CAMw=ZnTuK=ZijDbhrMOXmiGjs=8i2qyQUwwtM9tcvTSP0k6H4g@mail.gmail.com>
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple instances
To: Askar Safin <safinaskar@gmail.com>
Cc: alx@kernel.org, brauner@kernel.org, cyphar@cyphar.com, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Oct 2025 at 13:58, Askar Safin <safinaskar@gmail.com> wrote:
>
> Okay, I spent some more time researching this.
>
> By default move_mount should work in your case.
>
> But if we try to move mount, residing under shared mount, then move_mount
> will not work. This is documented here:
>
> https://elixir.bootlin.com/linux/v6.17/source/Documentation/filesystems/s=
haredsubtree.rst#L497
>
> "/" is shared by default if we booted using systemd. This is why
> you observing EINVAL.
>
> I just found that this is already documented in move_mount(2):
>
>     EINVAL The  source  mount  object's  parent  mount  has  shared  moun=
t propagation, and thus cannot be moved (as described in mount_name=E2=80=
=90
>     spaces(7)).
>
> So everything is working as intended, and no changes to manual pages are
> needed.

I don't think so. This was in a mount namespace, so it was not shared,
it was a new image, so not shared either, and '/' was not involved at
all. It's probably because you tried with a tmpfs instead of an actual
image.

But it really doesn't matter, I just wanted to save some time for
other people by documenting this, but it's really not worth having a
discussion over it, feel free to just disregard it. Thanks.

