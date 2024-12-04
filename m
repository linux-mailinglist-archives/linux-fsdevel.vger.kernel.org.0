Return-Path: <linux-fsdevel+bounces-36457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538DD9E3B8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B29285ED6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E801EE01B;
	Wed,  4 Dec 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx18rmGD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41B1EC013
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319906; cv=none; b=WPTbwNNjUoo+xjLP/LKpssPzPf1BvJ0nO8WbfnwGmhtR8RiG+e9z7T1dbVKk6KzfvgXKzCRxjEvIBdoQrvh9TAm/05bOJMihmmGm3Cgr5oknRmIgPtYVWyk1YC0KRw03xcz3pw3CyMDzmzCkjGCQbrtYM6X3JMrNe8POoX2e4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319906; c=relaxed/simple;
	bh=SBiXhvqt4a5PozTppwIyp0ZjN0dM1lY1P7h2sIwgyVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxvvYnUgeORfe2RWczqZp5o5PoRbdJYME1i1nkieQAzAoFHns+Wz/0moHJN/EcdCXZOoYRmXCPfvZudpLG7VumGxS5r28dobxM010WPBOLNwBKlfrPVlOT0DSfm2c+GqNlzgM3QMU+4PoytgynKtxivZDnMgTeuYCSRC19ne6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx18rmGD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa55171d73cso171957566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 05:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733319903; x=1733924703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU3yRrlDvgxhF4npWZ993IA83rbyNir9rG5ZRRfNx5Y=;
        b=Tx18rmGDvvEUPY97LK7ZyYYaSrE7YS+a0hmr8B9C+5nyvjIJecFnKq13dbKKITAkDw
         jw0IqIG6oa8W3cLUV98VwRXjiEKhJiqm7f+r2kISIZiiLk+bwPMSVbb2dhCmdKiYTy4Y
         ooQlrN7P26CD1uPpeKrD055/ygi1+G7HCs2PPO3l8Oqy0C95nA97J28+KjRA8quB6fNF
         E8axNGVNhHNx5FAXxka5PeL16ISnxFSmOIkDSCyCeXNhZK+wKRP4PsnU2PjBg1mRJLrv
         w/ky9ZLkyVBNO+fiHfFB8wtI0X5KcMLe+yDW4NyGZRjX1Mir4tlMpGgme7it+guMau+H
         XObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319903; x=1733924703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jU3yRrlDvgxhF4npWZ993IA83rbyNir9rG5ZRRfNx5Y=;
        b=L1ii5z9fVDhmCTfh1lWSFrOKDCHuZmRFLwQkoZEfxXQFDzayLNYIzDqKg76UIWGHQ/
         3c12zkjiIw5CKa0uLteyjy501hAdjAJTIQTefHQtLEvFqZ68lReNVSbqGZb5Gzv4Visy
         /LZwSJSE42kq/CXMzKx8IVM8OujccyeCB4rl6pb87rmTb3/mFtzfI3NJyG/ijqPUHXaX
         TNEt6rgFblrB+z64cII4uwuILo40rIDeiLJMHoiIxBAiBhY420m0rwIphpgi6rmcblFY
         Iklcd+Hdn+HHxyy/ayXCZ6XXCFrCdDIpaT7fzczlIPjRTdXCbwIXZzSYJZW4TyLZDz+b
         iclg==
X-Forwarded-Encrypted: i=1; AJvYcCU0W8ToHY4EypvtIOH2rUCEMG+Ds2oxSA7TkXPXGiZhkytEkUuAYOYQDSa/PAwEw05LYjhNcoYQ+BtsrfAo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oluuNcxRMIqj4le7xZHQmzZelo+B5B8deUaX0ywWgPedhmFu
	r+3JHKR1djcuTLtSQSdfAvutxQwLEovQ5/tK4AnBh2WeKh781QrrOhzwz202BnyaI4BluW29zxP
	WfUzDUo40KiosqWSDnMkJ8hEcj44=
X-Gm-Gg: ASbGncuYRi7y4NpmKvjVVJrEHNxkhp57qCMrSwiwzAkptkGTXlPm2RdiNs9OSuUlePC
	kCytmG/FzLYf2mujKs9ER/SjEF7eVNYk=
X-Google-Smtp-Source: AGHT+IE6GVgesydzLWWMKwhM0vfd1x9Oa3m4FObftBkGhVH3tW/v0gAD9pDGccm4krB3H/Kth9BUqEx/0kYReqqzPhg=
X-Received: by 2002:a17:906:308a:b0:aa5:1d68:1f43 with SMTP id
 a640c23a62f3a-aa5f7161dc8mr782055466b.11.1733319902771; Wed, 04 Dec 2024
 05:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-imstande-einsicht-d78753e1c632@brauner> <20241204-goldbarren-endzeit-81cb9736bf61@brauner>
In-Reply-To: <20241204-goldbarren-endzeit-81cb9736bf61@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Dec 2024 14:44:51 +0100
Message-ID: <CAOQ4uxhdcWfjboS8yBs9SLU7G0yY8DXz8QnL8S5prR0dnvVumw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/pidfd: add pidfs file handle selftests
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:35=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Add selftests for pidfs file handles.
>
> Link: https://lore.kernel.org/r/20241202-imstande-einsicht-d78753e1c632@b=
rauner
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> I've added a bunch more selftests.
> Frankly, I'm going to probably be adding more as corner cases come to me.
> And I'm just going to be amending the patch and stuffing them into the
> tree unless I hear objections.
> ---

Generally, tests look good and you may add

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

But I wonder...

[...]

> +/*
> + * Test valid flags to open a pidfd file handle. Note, that
> + * PIDFD_NONBLOCK is defined as O_NONBLOCK and O_NONBLOCK is an alias to
> + * O_NDELAY. Also note that PIDFD_THREAD is an alias for O_EXCL.
> + */
> +TEST_F(file_handle, open_by_handle_at_valid_flags)
> +{
> +       int mnt_id;
> +       struct file_handle *fh;
> +       int pidfd =3D -EBADF;
> +       struct stat st1, st2;
> +
> +       fh =3D malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
> +       ASSERT_NE(fh, NULL);
> +       memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
> +       fh->handle_bytes =3D MAX_HANDLE_SZ;
> +
> +       ASSERT_EQ(name_to_handle_at(self->child_pidfd2, "", fh, &mnt_id, =
AT_EMPTY_PATH), 0);
> +
> +       ASSERT_EQ(fstat(self->child_pidfd2, &st1), 0);
> +
> +       pidfd =3D open_by_handle_at(self->pidfd, fh,
> +                                 O_RDONLY |
> +                                 O_WRONLY |
> +                                 O_RDWR |
> +                                 O_NONBLOCK |
> +                                 O_NDELAY |
> +                                 O_CLOEXEC |
> +                                 O_EXCL);
> +       ASSERT_GE(pidfd, 0);
> +

IIRC, your patch always opens an fd with O_RDWR. Right?

Isn't it confusing to request O_RDONLY and get O_RDWR?
Should we only allow requests to request open_by_handle_at()
with O_RDWR mode?

Thanks,
Amir.

