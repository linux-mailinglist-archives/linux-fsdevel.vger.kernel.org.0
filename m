Return-Path: <linux-fsdevel+bounces-13684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D71C872FCD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31EFFB2535E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 07:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CEE5CDC2;
	Wed,  6 Mar 2024 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLXMRpNn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29717745;
	Wed,  6 Mar 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710588; cv=none; b=FW8Zhoyz2alyBSx3Kwpcw/SpoRwPZrVtUZ4uYvUb9rhcI46g8nFrr7EBEM1/Ce6U3OmHxXb0hNtALyKuGbDJMhyMAKnOv3ETLn9jwVDbQpypJ0MDB0J8kgUIEFP2CYJuz9zJgStljyITdnrF6p62vLhud/FLq9PS/iHaTY81Ccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710588; c=relaxed/simple;
	bh=LrAJCCpBSl+gG4ngOTkrw02P1idCRsPrXIl0LP5p91A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAlgJxzxGC4R7nUslNVI/n9DnjAg3zlroNrsudW14BieD41Xv2r2I8Nonjc6Xg/L5blFsG4/F10eT4gZcF0DbABO8dQ1FaLGoheaL3GG/dAL7LnCO3bLtvnBROSpxkB4ep4OhPNN/dhhtl7yAAdhVlEvkF/HDIhWgiKGYzXREhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLXMRpNn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42e323a2e39so4969101cf.1;
        Tue, 05 Mar 2024 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709710585; x=1710315385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDrwQgCUDNhac4YClML9QXk4EGLdxQZ3FXrvzoxi6b4=;
        b=nLXMRpNns0z4HJE+c/jg1ZSHh2aj9CPI9caLHG2fbtQZdzdCBctS12sul35RSjZYvi
         4yBQ9WyvBh8jUmJ2dLxD9O/LC3fpLp+5lNA4KUPkPmuVEbCISxGfpLv8ZXsaeJo8VcEs
         3KQ/Q/1VZbuX/Ze4kNR5UXiTvmUKyxMU8tUqoyxDEfabrIPCNOHQ/X36dNM7I0J7jyL8
         R2vEGoYUS8a+k5xCkpJqtubHGEidE8ij1eH75yZm6I399lSHW/QlCyfonO4Ta3zhW2bK
         gTeC7iiMPFD3hH0fjdqta6EnL1o1ebzuZSO4XKoa75S0gEv6HqK/7K9UZrsUmqw/Z4Qi
         I8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710585; x=1710315385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDrwQgCUDNhac4YClML9QXk4EGLdxQZ3FXrvzoxi6b4=;
        b=BRwN3gqlCNnux1iukJYs8ZOgKBqWDykbW+7MErWve/ZjlWxDFYSC4EuuTLIyjPp/3w
         3IHE1L9z70y6zmlGlL/X90JCSL5V3/UVZ3Ryw9B5cI7EYXqKvqJWwuap0VmxdQd1uzrZ
         2JYZNvCjVxHtCQ4rxBEz5JaGCGtJstfNgHtSQXL9SbLbRn0Jq/s67uQTWTGaDCDTTzBB
         6FQzT7ff6vPrhh+g0z/QrB9u8Q//tHcRDuPYlEvuKvttJl5J1dtrA3xN3mvNDXLL1EWF
         QLcGg5WIdp2mMlRlh4Z4i3L5p/3CtvT60hCLVApEy0GVpQ6QHMuc3ujBCz8KQNjtW2Zn
         1T1w==
X-Forwarded-Encrypted: i=1; AJvYcCUP2YA6rZCj0Bnah07zl/eVbU+OXCeJ15wlwSCQgwp5eldAl+WAlfmtomARSAXk+nMJZzyGBrxKDdhd7Cn2NqhYF4T0I8u7jDCzAdAeEgve7xLZxJs5lW1NCUt45BJNObxqxbq1+TAME1UtztMaNh0hiF9mhpqGguTNKJIyvU5Dm8Nxrd9K3f4AW896jA==
X-Gm-Message-State: AOJu0YyS6XQYcZzBd48nLOwo31kitmGXZhavcxfY/Slf/NAZmXxZhpdX
	hVYxwMfIC4GCmrOMCGg8riVuYSdeNFqx/vnUwP/pPgUTvUy2nQpI+84eIOK7VC9arJEKSS3wcTB
	WounVoX0a/fVDjt5guLYHUSSRsYN4AHEX
X-Google-Smtp-Source: AGHT+IGjOyAXtAHcG6tM6H/9gW3KIAOM2zeiwg+k8x76N6uNWWD6hM5htKG/sAErFhUzTn5MVAgGhGKfdQa/78b0mK4=
X-Received: by 2002:a05:622a:2cb:b0:42e:7dae:5e41 with SMTP id
 a11-20020a05622a02cb00b0042e7dae5e41mr5748490qtx.33.1709710585393; Tue, 05
 Mar 2024 23:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeeaRuTpuxInH6ZB@neat> <202403051548.045B16BF@keescook>
In-Reply-To: <202403051548.045B16BF@keescook>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Mar 2024 09:36:14 +0200
Message-ID: <CAOQ4uxg185+i+n_mnXsEaxXYJ1SseDH6RtGreTJDhjkOt6mmSA@mail.gmail.com>
Subject: Re: [PATCH][next] fsnotify: Avoid -Wflex-array-member-not-at-end warning
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 1:52=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Tue, Mar 05, 2024 at 04:18:46PM -0600, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> > ready to enable it globally.
> >
> > There is currently a local structure `f` that is using a flexible
> > `struct file_handle` as header for an on-stack place-holder for the
> > flexible-array member `unsigned char f_handle[];`.
> >
> > struct {
> >       struct file_handle handle;
> >       u8 pad[MAX_HANDLE_SZ];
> > } f;
>
> This code pattern is "put a flex array struct on the stack", but we have
> a macro for this now:
>
> DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ);
>
> And you can even include the initializer:
>
> _DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ,
>              =3D { .handle_bytes =3D MAX_HANDLE_SZ });
>

Indeed that looks much nicer.

Thanks,
Amir.

