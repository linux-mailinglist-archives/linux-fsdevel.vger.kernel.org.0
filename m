Return-Path: <linux-fsdevel+bounces-45831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2E6A7D155
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 02:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDE43AB10E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 00:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7D1A50;
	Mon,  7 Apr 2025 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnHoVhSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47123C2EF;
	Mon,  7 Apr 2025 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743986489; cv=none; b=iAZwYwXUkkWqMe6sD3+9JgzHnUc3b2XhcPCgojy32mczj0dM1vpaYIjKD88p0YZWiXhakKklOEPzAnURsArKvAOXVX22AsCU4pmhseLhVWbAWis1x4fqMXnJN+/Q9ZvRTtl1SOcrPk6wWjISBGzUvUJ5O3YCsyPWNm1V/fgUrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743986489; c=relaxed/simple;
	bh=CC4Ef5cjDbsSYbVqDqbwFx1wQVUkjDiV8sSkqGPJeWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1IcRyVdxcLz3KUYfJl9whptvSkIB98sN8nItDadgn8IReHkpJDPwaIgrVelu4XknTkdUeSpTMGzNlzE0B6KIyldJ+TBfVLnqU3tEsikfxHfCvG78hAzTv7f4KgiGMhzaV1rg8TeZluDNnq4pY2mZybVoCEyCt/2vY4wp1QWJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnHoVhSV; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2cc57330163so2170525fac.2;
        Sun, 06 Apr 2025 17:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743986487; x=1744591287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC4Ef5cjDbsSYbVqDqbwFx1wQVUkjDiV8sSkqGPJeWY=;
        b=cnHoVhSVpUB5qFHeGIZooI4MD+jIFDYyslVNtinpzngIBIDBY2Sz0M7lxM6Nas62/f
         X3yAOxLe0zwCQLLNFCEBO7Ld/ajslqVnOjvZo9lvceXG9ZV/g42GlF3yJUhKdMJ4T3Ko
         l6ZuR2TRYJNqvBcUZfgpn9oR2ma2iFkfrw/Lo2gjCo7LH8rwZFogoSPV//C8WCKHVBPb
         kVBitQy0JhnWIHpwOL3S/N9JSv3L/AlzUymKkhfG2VOXJqM+C2vhVBocBVa2CpQuCt9N
         uzEH4wIc2rDCK1msaI6fGyVYazjKl+RDgGvY4TB/NQb+hoeg3NCBzjGapcNWhEC4Nbp/
         2rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743986487; x=1744591287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CC4Ef5cjDbsSYbVqDqbwFx1wQVUkjDiV8sSkqGPJeWY=;
        b=BvKkEImnqinPH28OdsTGyv58E0UlyqSZk7+GtazqSa4rSRJQLkoQ1WDFZZHLV3gY0z
         pLGu8VmypzbFv3YLsZhJEQToqvR1GhD7ZAkQ4XywyECQmvrEh3bL95iwRAXTQkJ69XsY
         qt57+BLyO06t2Bv+2FG9UvfNZeUaJPJJGg7HuhxjxLbxledkPKdLkCABtXgXzWvnhBho
         YeuzE6/ifjBerUVZGPDbtH0Mm6nthDhLg+9tSRDJalAZ6aRMdyUqjzhCoScut6e8+b59
         07XLuj2oXPTyYHLOBTi+W7EzP9MvmNjen2knfWLv4nMbmIb0tANGiadxwCy1TrBqrNyY
         EBCg==
X-Forwarded-Encrypted: i=1; AJvYcCU6nmHpHbsvmKM2Dqc1L6MeWeXfK/dQ75iYoj4ztMHkuc2rzy+fFtrhDfdYYiFkAUjaronR4EjXvLVzUYuL@vger.kernel.org, AJvYcCWsJOVmjvln1H2dNuV3O6tVYpBPSX7FN85wGaAT2VV5f8nooIxQ1+76kttvhMeh03aknwuU9en2At55ITUo@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPHoJx8MEkSN/TlN6cpPOZt9AzBIof8Fafd86fXSPWfy4o5S7
	8QpifPyYEBCITWOcLg4cBQZkwaaWx5YyXIb4ruopl93GIr8fs2nl+irqPGse0LzWdCzdnAEljnP
	1JZDQ2fI25y8hpyqseZGyt9YAyQY=
X-Gm-Gg: ASbGnctUGTTNGArRg1vJMgcNXG7b8ARfM800ua2UnHXD5f+E5bPHaAsCOMAQ9Qt6yAC
	dOO2KC9G69dKiyoSkC7vEAG18GF8Fw5QkqIspItMDmlkkVI63g6Kg+yMYXfYushTIsVEEiVRWp4
	BDb53PiMDXNcrJWKM/VckD5ZDavw==
X-Google-Smtp-Source: AGHT+IHSVndkLtJqE5Jjssk3DBIW4fmoqBFpyiA0afpVlSNevi1mSiuOqziwLt3ODMR1p1dvelaGWTIEclYqWARes0c=
X-Received: by 2002:a05:6870:569e:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-2cc9e7fcd76mr6355789fac.25.1743986487188; Sun, 06 Apr 2025
 17:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404-aphorismen-reibung-12028a1db7e3@brauner>
 <CAGudoHErv6sX+Tq=NNLL3b61Q70TeZxi93Nx_MEcMrQSg47JGA@mail.gmail.com>
 <20250406-reime-kneifen-11714c0a421d@brauner> <20250406-angucken-ankommen-6974c000f0fb@brauner>
In-Reply-To: <20250406-angucken-ankommen-6974c000f0fb@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 7 Apr 2025 02:41:13 +0200
X-Gm-Features: ATxdqUH1guGfzORNPTtqmHATa3-5D6zjUekE_ynbWy6nR08MFRThLuRMdyDc5ss
Message-ID: <CAGudoHF5E=PSkJ6Gf7jOeU9Ry72QyNkanqQzMdmy_Kraj=SL+w@mail.gmail.com>
Subject: Re: [PATCH] anon_inode: use a proper mode internally
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Penglei Jiang <superman.xpt@gmail.com>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 9:51=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Anyway, I'm finishing the patch and testing tomorrow and will send out
> > with all the things I mentioned (unless I find out I'm wrong).
>
> Found my notes about this. I knew I had notes about this somewhere...
> It isn't possible to execute anoymous inodes because you cannot open
> them. That includes stuff like:
>
> execveat(fd_anon_inode, "", NULL, NULL, AT_EMPTY_PATH)
>
> Look, anonymous inodes have inode->f_op set to no_open_fops which sets
> no_open() which returns ENXIO. That means any call to do_dentry_open()
> which is the endpoint of the do_open_execat() will fail. There's no
> chance to execute an anonymous inode. Unless a given subsystem overrides
> it ofc.
>
> I still agree that we need to be more coherent about this and we need to
> improve various semantical quirks I pointed out. But the exec problem
> isn't really an issue so the patch itself still seems correct to me.

Ok, that makes sense. Thanks for the explanation.

--=20
Mateusz Guzik <mjguzik gmail.com>

