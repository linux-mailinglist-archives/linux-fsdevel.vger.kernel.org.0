Return-Path: <linux-fsdevel+bounces-45805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B06A7C7A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 06:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38ED3B8C40
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 04:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F901B040D;
	Sat,  5 Apr 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSMf0Ydx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575E383;
	Sat,  5 Apr 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743828948; cv=none; b=KrHbFv6NHzAcXeb9lU5Jk7qGMdH8W3773b6KPBRY2Bcx7U0pd6ClOgJ5WUN0B+iO2xCX//tXr/UCovEFkANAtv5HlhYPCOmWKeKqPtGUgAXFZx/L6cmGOyDrjMoMFWLBf1x8tAJechJaVzy3peq/z2v1OOr7BUAlTcZ3Y/QKTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743828948; c=relaxed/simple;
	bh=kG4T87z8sYPGaxgwKwahuOOk4nDjhUhydb9Avm3K0Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwfVmyc7aYvYZhfwXWqWJbo9eOTKA7mBzQdpi46+H/Ks4obVw8YlItizVwXQLfycxO3zDVxFBHb72ozORvFnwx7jyCfy+Oi7L7/5F3FtE4jLmAL2urDGPgaBODttBf84bnOPuTf0mxgLvdx5wV8RINy1o6ha8341ZGX0y7PKhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSMf0Ydx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so517672866b.3;
        Fri, 04 Apr 2025 21:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743828945; x=1744433745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG4T87z8sYPGaxgwKwahuOOk4nDjhUhydb9Avm3K0Y8=;
        b=QSMf0YdxGOVpBp1vrZX/n7oDCPzdd3e8+0Lar+OaLTTI2sqlKSPxAWrnEFd7RtGA9D
         CcL+HqGZ/SpxhBGDTVOwe3qhzFqVbY2FAK4KUHZcVz7Epqh0FEes8/gT1a7j8wNTbnd8
         Rx+1EbHnVUBCOwfRi1tEedalyI1SKNyqQ8MFChp+AhUtNSRp22g3VxCDVujnhAt4auGF
         fH2QJHwZ4LC8LrLPvUu3oX4q65v5oWKtNGpo5fZZG6s5mHRQGSrsb3rvswSrkWftaE/D
         /CICiMvUGUQIwfUqODvwu+cpIpsWphSCWv4OrDvKddp8fr3DpZnJDifrd/vf/YBRywhX
         LHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743828945; x=1744433745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG4T87z8sYPGaxgwKwahuOOk4nDjhUhydb9Avm3K0Y8=;
        b=ZTZ/dZI4lUT3EwBQMCikRJaEZDkGW+cBwV3XoXgNCmQfq7BsqBK5ooj1wQxb1XDG9r
         Sy1drCfbgB44MfcVX9/niVSce9dFUjUTcn1zRItqBhjHLIa1pQWZfiLna1Tocsn9BeV3
         Q1jxQdDBOXaOYv5f3hl/mHzbh9C6RNpGU2z8w0ggJ5LyXSZKt9nyMcDdeCPCS+1Pu2Qx
         JvWhn7UTk35wSG4gY/Wi6JTQBhuHpZDUmJWl/MaL+P7CkFECqNglrpu592BfA8hoFXiP
         uHGLiNz22j8hEvHB/FzYg/KH4TLuyiZ0Cn0boOHoWRfUaOUWnjJVz/AVFmzQ1YW4j9zs
         AeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJef8iFFVzJVklLqePc7uCcohUAP1onmEafI7VhBlSXfQJIoAO7Jd215B5AkoyidwFgSUSbg/92PuTwheV@vger.kernel.org, AJvYcCVndTDjyeiy2tzLiFUzMmAq2Utb6Mh8ql3D1KTeoTGBEt2FK3nbHeFEbsqfM4/kuIUThK/j3D5kFqL1H9jE@vger.kernel.org
X-Gm-Message-State: AOJu0YxpvdLcEB/V6KoHtU87pBMvRpC48ctCF6kqUDs0wu+2aE8tHrAS
	aSYOec1VJaDFalc7+UjFn+AzUSk0r3bF/KgdcP2keKq16IQMqLb0bT4Ago4C7gdPrin9ceu3uXs
	AGtGHhCZc2uZbawkBtoIy+XD55x8=
X-Gm-Gg: ASbGncuO+EnRflILPme6K7XGjt6ygfHoFUF3boYXJLXg0T5mDz10FFrWCiOtooTkCvO
	284QBoL5JuJ42s71w/v2t7INIUoNkC5Qot9TW3nfwsYrj/Xa8I+UnVFwHkQvKK4kruy5l9MSPSF
	kW1K/pH2EmeeBMZ8mzbaLPqnzZYg==
X-Google-Smtp-Source: AGHT+IFcUVeXXZxdo7j1ulhpZ0rOcuuR8gAaHePRUA3DnIZWmW3HhrCh7oQTXbro0DlpRy0xFni1HW1GW1tSbk16ZPE=
X-Received: by 2002:a17:907:3f93:b0:ac7:9828:ea41 with SMTP id
 a640c23a62f3a-ac7d1bca584mr424341266b.41.1743828944788; Fri, 04 Apr 2025
 21:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329192821.822253-1-mjguzik@gmail.com> <20250329192821.822253-3-mjguzik@gmail.com>
 <87h63bpnib.fsf@igel.home> <Z--bN3WetGcsQmnx@infradead.org>
In-Reply-To: <Z--bN3WetGcsQmnx@infradead.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 5 Apr 2025 06:55:33 +0200
X-Gm-Features: ATxdqUGZVV2m3-29AEJfDylOnEd-fQAW1DdjQBXQ1-IcltKzJ7udo6Hoht0qQ9c
Message-ID: <CAGudoHF2RbaEAUYcWBZCo=4KvRroEcotAjtZEnoTG1qTYA5+eg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: cache the string generated by reading /proc/filesystems
To: Christoph Hellwig <hch@infradead.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 10:41=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, Mar 29, 2025 at 09:53:16PM +0100, Andreas Schwab wrote:
> > On M=C3=A4r 29 2025, Mateusz Guzik wrote:
> >
> > > It is being read surprisingly often (e.g., by mkdir, ls and even sed!=
).
> >
> > It is part of libselinux (selinuxfs_exits), called by its library
> > initializer.
>
> Can we please fix libselinux instead of working around this really
> broken behavior in the kernel?
>

That's a fair point, I'm going to ask them about it. If they fix it
then I'll probably self-NAK the patch.

--=20
Mateusz Guzik <mjguzik gmail.com>

