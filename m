Return-Path: <linux-fsdevel+bounces-15208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EBF88A7CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0380A1C624DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5F114BF96;
	Mon, 25 Mar 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWawwgNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CCA1487F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373121; cv=none; b=HI5kRwwmDls/e4w8NlvCF5VaZonT/V2uND4doQN66MYTaAzQUsUW05L867EC9PgM0Czmqr/oGVct6heOcVx+3AYmzV+aTPUGXQ9zfl3u5SkuH0dQ31MWBL7FIypm+DSRC1tX+iWXFyQ17wajjpmEocu/X/0XZE59XVq3m3R0BHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373121; c=relaxed/simple;
	bh=udtrNptnFxbxKqQrX9+mM5Q4/jyDJfWjZsxVyKdxm8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SEYDLoIUEIudDMmH7Na5stizV8nu2KWqUILVDejVtK5oo6zY5KN9kJtzFaWvxa6eiGyga5RgmfvC6cJ2Gmv+DP11Qu9vbYcOTRVBjY40HdsYrNPduLeCKJSRQ/Au/wOXe2D/MilWbsXRcRerjWrT+mfecmOrTtyrWx1U+NAZ3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWawwgNX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a08eb0956so68598047b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711373119; x=1711977919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUirGja49fq+EfmDjKlBPEUoLvWOsAMP244ZtmR22XM=;
        b=tWawwgNXx70YIQfp1C2vlb+Ms+NvfKDRUs9gWQxOGAuK9RfvPqf4fUbwGaWK8hxFp7
         kMRPBunG4azhnA/TTTLDY++k7xqz7Wbca2CJzTJq8K8cp0pvNkMhRGWjwP4RG5O/j7tj
         uVTGugB8MVY+grlXIijy5a/znOgOSdgzZ6sebAoG1KjAPQIk1sd++NZWKZPUqE+lbsog
         29tUSIW7bMdA/ZCbhdEFFzCrFCK/fnGqT/qFwy9fX2rLG3mlB7Be3oDFx6doyy3PEpvy
         XnYDOThCt9MXcsE+UepwsAWQbuf/DQYu5rcSGLLpyT0S/H9kdXUMNfwScfSbZfJF3TeB
         nbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373119; x=1711977919;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUirGja49fq+EfmDjKlBPEUoLvWOsAMP244ZtmR22XM=;
        b=JoF7f8iDMCg+huwLVv8X5xon2gPAvQ9muVuVfOWj+NORUwmht5qZJvcLWOQXWzCPjZ
         zvZBU+Cv0yfScOKwjws5q0cxDb+ZCSi2pB8jPqwAHIzq3qGqNorql+yHpJOmwnGolXRw
         G37cneTEBTxtS8SYSTzV3KejbO+jlpdsXRqFr1QUpJEvGg1TM4fMeF0u8olkecKPruIO
         l58S/7XgqchWHddI6Dsgyq9uf3oB0AoVeFwqGcFqSnlkWWXHpAmhCoMi0ktJP7dftuBZ
         +MXcLXKrIJsAHPNo4Ct7OHJ6KVnuWgonIbi985sZhws3B65WnIWEUYYnH6Wx0jrPK3/A
         25Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU0GRIw4qjwMDQw+183oNxhOw87AAc1tiCo64P77hq666iuWmsbJC5juehmMgVdKrTMLX3qHR4CcX+UFXnvmLcM6mdh5zoGq5AXJRz7ZQ==
X-Gm-Message-State: AOJu0Yyp8MWEpxhA7/Douz3ZmS3OW+NI9kEvp4STnA8h1ykvEIkyA3IH
	AwG8DPHGoGRK0bT4ACm8xu9rwM/HgjuDPa7tDC6YcN/DAwEvQ54qNDLZhV2it5cXYvXdK7NNjF4
	gtA==
X-Google-Smtp-Source: AGHT+IGZ4GbHZfQqNyfKU0ORm9bHPGuAWEguo10JeYmC3vb/xuHNhO0+53sAJ0STxwXrlIhD9OeWLlMDZ1s=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:610c:b0:60c:ca9c:7d10 with SMTP id
 hi12-20020a05690c610c00b0060cca9c7d10mr1690248ywb.2.1711373119532; Mon, 25
 Mar 2024 06:25:19 -0700 (PDT)
Date: Mon, 25 Mar 2024 14:25:16 +0100
In-Reply-To: <32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com> <20240322151002.3653639-2-gnoack@google.com>
 <32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.fastmail.com>
Message-ID: <ZgF7PFWDIxoFdgIb@google.com>
Subject: Re: [PATCH v11 1/9] fs: Add and use vfs_get_ioctl_handler()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-security-module@vger.kernel.org, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 04:31:58PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 22, 2024, at 16:09, G=C3=BCnther Noack wrote:
> > From: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> >
> > Add a new vfs_get_ioctl_handler() helper to identify if an IOCTL comman=
d
> > is handled by the first IOCTL layer.  Each IOCTL command is now handled
> > by a dedicated function, and all of them use the same signature.
>=20
> Sorry I didn't already reply the previous time you sent this.
> I don't really like the idea of going through another indirect
> pointer for each of the ioctls here, both because of the
> complexity at the source level, and the potential cost on
> architectures that need heavy barriers around indirect
> function calls.
> =20
> > -static int ioctl_fibmap(struct file *filp, int __user *p)
> > +static int ioctl_fibmap(struct file *filp, unsigned int fd, unsigned=
=20
> > long arg)
> >  {
> > +	int __user *p =3D (void __user *)arg;
>=20
> The new version doesn't seem like an improvement when you
> need the extra type casts here.=20
>=20
> As a completely different approach, would it perhaps be
> sufficient to define security_file_ioctl_compat() in a
> way that it may return a special error code signifying
> "don't call into fops->{unlocked,compat}_ioctl"?
>=20
> This way landlock could trivially allow ioctls on e.g.
> normal file systems, sockets and block devices but prevent
> them on character devices it does not trust.

Thank you for the review, Arnd!  I gave your suggestion a shot and it seems
cleaner - I'll send an updated patch shortly.

=E2=80=94G=C3=BCnther

