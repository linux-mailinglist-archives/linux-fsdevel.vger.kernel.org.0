Return-Path: <linux-fsdevel+bounces-41513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07911A30B8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 13:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1F13ABA25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BBF1EDA22;
	Tue, 11 Feb 2025 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Xz6clA1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD81FBEA6
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276084; cv=none; b=JC+1RmzqeeR76AZFHRJD4ZgpWymEYNXgQ4RcOSHnMJ/VCm4O849U1p9OnhZLzI7w+lliFuLp6MEA4PozpT/A4PE+QI/f/bUDVChz8eEacuQbdPGIQixJ6/gQ2G8Z963WbjjMA9PbSup60R5aickpyERyzNJ6qn5ImKL0QVElsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276084; c=relaxed/simple;
	bh=P+115TeWGvefTCOAOdhDLh56cNX/bAd9/f2jYPAwgkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKz9t6lLxJ0yy2LVmofL5oVMG5d/BNwNDtuexaE8feY5+7dbmtQDmuKZL5Pl3yBS9+B/FzH4sd6fAnsLybg0mcV4lT2C4vBXgOGPJV10W1qP9HJHJEyyDM9U740qHWRFIaWuyRSTmm7400jQXZ8jshJ8Mn098nm0l4poyneEbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Xz6clA1X; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4718e6fffbeso22161711cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 04:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739276081; x=1739880881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUJokO2qwxWVfabSA/BYVONxZz6dHWxK6xx5SuVb1G4=;
        b=Xz6clA1XwKBsJZ6va1q0vXtWGO5WmdLImaCfeOjZu1/pt9ppYC5kZzP6S1frTVRC4Z
         2ese96vc3dSM0X3wwjYGo8evCwZf9g0fMkoxw6MttMSTcozOVujpwMg3vtX/3PK/KYCQ
         eOk01/VY49ccKqYlvBhF5mP6oOOKJWF5xmvzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739276081; x=1739880881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUJokO2qwxWVfabSA/BYVONxZz6dHWxK6xx5SuVb1G4=;
        b=u+gcTJuc541nWhe0w6rdFbi/jrZtqxnAiZsE17ydrPw/XXL6z1Tx76nHc58Tmn3rJ9
         L/3cBMuQn4VVrcR+/yAQDlqKRCr6zY6b4fED7fzwa4cmw4uLZQoym8w7I8Ft0w4fTlfb
         BlrcfMDfM3rBcflRHhBFeREc/vNKDVLFbpFyKt7iYngdlxzeSEWS26nkcQgCyN97ieTq
         Bi55kqSn0NqH6WREMPDkH0r75NZBpGpLH0r+sbCDJM3dpfQFEWRsnz4M/iXaAL4bSsJ6
         0Wi84/4dyFvVBO3wluEPQ23K5ISSgwk8MKGogIFLlrNQfVKlgCy3wd8o6GX+rrBmy6BH
         uvIw==
X-Forwarded-Encrypted: i=1; AJvYcCXjKggQKlBw72KH4EDV5xxtRCSs6Y7uRBIN7BbR+sdp+yMKGyGV52a0USiPaSVixoTlHd4OBI5prdBUbIis@vger.kernel.org
X-Gm-Message-State: AOJu0YyDuUlTeImEGSMYtTBr/YxANV9wLJ5czDkvrXbEmrrJt5Ak3zTH
	8Ru6KeGlNaJo10bvoGu4ds244LhqS8kNAai7fRbnKmonvt70knpKYGwxj4tL8Wa3HBMKXwJEnp4
	vrcuZQ/N5zTftbKiRKE8XvpvktXV3dXoBW6gIsw==
X-Gm-Gg: ASbGncvVH23DUNxKh2+r+2/oo9OlxI9aVlQshqLx3XMWLbTb3o4t54XRUpcxxxdNtoD
	EVMrvx561I4QSUOg7uUADxOUOptgm44e8AOOcaJ6AE5OxlZpflPvYtMi3mXEmyAJVrBEaVQ==
X-Google-Smtp-Source: AGHT+IEOzfq3v/9xFDeXDWSg3OQME7Gzg8NYIJD8geqDjZtHJH7+1HqsC06JZZ8s9GXuWle0PojQ6JDnxCO+S7ptWt8=
X-Received: by 2002:a05:622a:1209:b0:471:a31b:2ed4 with SMTP id
 d75a77b69052e-471a31b2f2bmr36265661cf.52.1739276081464; Tue, 11 Feb 2025
 04:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-5-mszeredi@redhat.com>
 <CAOQ4uxgOwu1pnS9BoMYDua6D4aJ+UUOwbsSyUakP2dMd5wQaBg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgOwu1pnS9BoMYDua6D4aJ+UUOwbsSyUakP2dMd5wQaBg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Feb 2025 13:14:30 +0100
X-Gm-Features: AWEUYZnQIjEJy7kAKG3hdMqZ7Bm1391gn3VLr5QlnJ8MPRWHJftivMyXJt4WAVg
Message-ID: <CAJfpegtPj6FW59xpVBSxL8UwhC8qPv6gCQov=2QQUty0YW-6rg@mail.gmail.com>
Subject: Re: [PATCH 5/5] ovl: don't require "metacopy=on" for "verity"
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 at 11:50, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Feb 10, 2025 at 8:45=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.c=
om> wrote:
> >
> > Allow the "verity" mount option to be used with "userxattr" data-only
> > layer(s).
>
> This standalone sentence sounds like a security risk,
> because unpriv users could change the verity digest.
> I suggest explaining it better.

Same condition as in previous patch applies: if xattr is on a
read-only layer or modification is prevented in any other way, then
it's safe. Otherwise no.

> > @@ -986,10 +981,6 @@ int ovl_fs_params_verify(const struct ovl_fs_conte=
xt *ctx,
> >                         pr_err("metacopy requires permission to access =
trusted xattrs\n");
> >                         return -EPERM;
> >                 }
> > -               if (config->verity_mode) {
> > -                       pr_err("verity requires permission to access tr=
usted xattrs\n");
> > -                       return -EPERM;
> > -               }
>
> This looks wrong.
> I don't think you meant to change the case of
> (!config->userxattr && !capable(CAP_SYS_ADMIN))

Yep, good catch.

Thanks,
Miklos

