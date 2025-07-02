Return-Path: <linux-fsdevel+bounces-53721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED87AF635C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 22:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CFF1BC86DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C442D63E8;
	Wed,  2 Jul 2025 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBi8wumQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47AC221F03;
	Wed,  2 Jul 2025 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488401; cv=none; b=iTsNNl1EIjbnTTJC202hzRz2WpUsaw8kCqIJMgCBUZ3akA9rv2MpjNMs8WR4ksvNun05z+RJBN2ZVlGsPAadc64k9WnJtzDAXpTaBi5v7zlqWEYx/4aogMvyCcd7gTwQFynoLFQZ5Ow1GjH9Vx/fbLdkTKU+aQd6Tohp2TQ5mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488401; c=relaxed/simple;
	bh=TnU/sk0OD7aWwA5HkeV/e3lpPQayYxGYFTTqDsslg/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SqCKDVQhxw+lsmhF14uhJkJP87Ltb2jZ4MkJhiSwQRAPtr5wqrk0972X0beFZs8s+XDgqNcReMNnkFKLodcJ16YpIR/ebu8CbajC1DA3X0U8SF2KgfcBA/fApAh/HCWrYU46gSLKZL10S9foLtLmR6uzO+XOj4TD2/szIjjQxbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBi8wumQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso4560114b3a.0;
        Wed, 02 Jul 2025 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751488399; x=1752093199; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TnU/sk0OD7aWwA5HkeV/e3lpPQayYxGYFTTqDsslg/Y=;
        b=VBi8wumQfckbHOsiOQdHR+OdhPuocGeiBG1tVLOMn77ZnVGnWX/q8PVfQ1FGsjxMZg
         c0bw+pXvc60g66nX0zdW3XSqRpvJvQX3Fz3WTRXJlTII0QNF+DT6K+F88mgBPUzY6keb
         rVuhMCO3AV34POAd99fY+ODwtmWqKqx5H2BXE4NrOSRc9gfumkjztmUr6tdExNXB5Fi9
         8s5o29cI1chPWlGBinPv1SP2Mn/dTLcMDbfijbXooJFe9YgEVi6BH3POqS5jI88aa3pM
         9i7NitVEnUV1HSuN/AwnqPld+Qk+hvo7mc1MUavPTRdbqXX3g3iaCOiDLQJMsDglpl+W
         j/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751488399; x=1752093199;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnU/sk0OD7aWwA5HkeV/e3lpPQayYxGYFTTqDsslg/Y=;
        b=XPQAe2IVEvy9dxOm/zQkCy5Wj0pO6t3yWzpVFuoGtEI1ks2NwlVKDxYm4o+j6p2QfG
         fjNeZrxXQ5XYMN5ZgeNsFRZnRNC3GXGMeCnARw7J+e59KTzYb2KbUdWsB1SJFxmLIlfJ
         yK6YsnTpgfkZm0gN7sedHPPd8VQygdCVz1cDOrOZ4U+oXtI5EIFa2St8/PUqbIvBLssN
         +CqSkKjpg7xjOPeX71/f+hil8Yl1sF2Q7ww5ZagfOpH1eLzmKDsxpTJMSkyWHplgfI9o
         KdBHGrUNH3st67VISf+83wrW1KqNhWLm42eMH6AA1GoEl2s2rQ1A1yBllULnqBd8V9Ko
         DezQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoN0h1mSlHH/m4Nz/ctdUrQtYFTJ4BKxNIr5lisLf27TSwJ7pWqBHQiV+iWVf81w/yZZdJKIAKykYbE8o/@vger.kernel.org, AJvYcCWh4dXUYMHaZf2Ra655HL/gBAo5GuMnMEttQrOLKEFQ7aLz2ww2vmOSJ3xkDW7sMFQ9MWMUQDCvuN+qCRzkv7zf@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLXzbk9Uwe16tUQ7UpkeJG21I4t2md/bktm/fZ72b1INlK9Zg
	EuIbs4MpyDnmbRw/B++1Fvycm1BeN513W3+SgmqCv6w/wrLZmBTqtz8845r7UiL9R9Y=
X-Gm-Gg: ASbGncseKn3NBV+cRJobszKcCE8dURRJwnsqXUsN17U+zRMFTF7/BClLDSRwQL+AbLP
	xVKrI1FzkAbmKnBbu29VR5hFGALL5oiyxk/CvEO/ElIIVcpC5oED2in+MgjE3843xCUmr9ecqlZ
	/EyNMjvpCeYmrGFb43Fq9Ii9G7Ah65Gy3fg05OPWFWx6VCe0GNlyvBGPqEGmuUElMCoBY1iKj2w
	BEU7PpfuuDhpNqGoh4r/pCTPnFqlGnnRHDoQHK5zhFGPdXkVDvq2oNlwHtySZfMlueoIv6iqGa8
	G8uwaFeedhOQHKZLYKYRU6KnpeX6/XtaKoxTu39MaO6SH44KzlMb7Zm1+JjzMW/muTWz
X-Google-Smtp-Source: AGHT+IEZEazQ7PWX1sPklfJKlXDCWYPEl9W6FjIBrwCYKJIUDhI8e9KBqhIU+S4XVSSgpYDJtCQ3Xw==
X-Received: by 2002:a05:6a00:17a6:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-74b5138bbdemr6543826b3a.18.1751488398753;
        Wed, 02 Jul 2025 13:33:18 -0700 (PDT)
Received: from [192.168.1.12] ([223.185.43.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540ae41sm15342862b3a.19.2025.07.02.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:33:18 -0700 (PDT)
Message-ID: <56091d9b2c9b4d565da7569a81d8b85f0f7d4c7b.camel@gmail.com>
Subject: Re: [UNDERSTOOD] KASAN: slab-out-of-bounds in vsnprintf triggered
 by large stack frame
From: Shardul Bankar <shardulsb08@gmail.com>
To: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
 john.ogness@linutronix.de, senozhatsky@chromium.org,
 viro@zeniv.linux.org.uk,  brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org,  linux-hardening@vger.kernel.org
Date: Thu, 03 Jul 2025 02:03:09 +0530
In-Reply-To: <202507020716.1B1E38593@keescook>
References: <9052e70eb1cf8571c1b37bb0cee19aaada7dfe3d.camel@gmail.com>
	 <aGUfd7mxQOOpkHz8@pathway.suse.cz> <202507020716.1B1E38593@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



Hello all,

Thank you to Pedro, Petr, and Kees for taking the time to provide such
a detailed analysis and clarification. My apologies for the initial
misinterpretation.

I now understand that the issue reported is not a latent kernel bug,
but the expected and correct behavior when a module overflows its
fixed-size kernel stack. Your explanation that the KASAN report was a
direct symptom of this overflow, rather than the trigger of a separate
bug, was the key piece I was missing.

> Try this and see how the crash changes:
>=20
> static int __init final_poc_init(void)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0volatile char stack_eater=
[STACK_FOOTPRINT];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (int i =3D STACK_FOOT=
PRINT - 1; i >=3D 0; i++)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0stack_eater[i] =3D 'A';
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
>=20
> :)
>=20
> >=20
As you suggested, Kees, I did try the PoC with the stack-clashing loop.
It was an insightful experiment, as it demonstrated how the specific
symptoms of the crash could change depending on exactly which memory
was corrupted by the overflow. It helped solidify my understanding of
the root cause.

I appreciate you all sharing your expertise and helping me learn from
this.

Thank you,
Shardul Bankar

