Return-Path: <linux-fsdevel+bounces-41511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04835A30AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 13:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27C83A7FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643F1B85FD;
	Tue, 11 Feb 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhImh9Xd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5F1F0E2C;
	Tue, 11 Feb 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275270; cv=none; b=PDsoOcdSlX0OWfirR1qD88HBsnxtOZ9QRNONS7J0MjHi5aWo2s426WiTr1Y12jBnGouVrs5Dro9g61bA5vBivixZDtW0HF6FrVEt/QDxPh0LuhZx+axWjttJpSoE+HBzFpDKVUGMv9jg8FV8JXHUFHFA7Kte35k9zEbk/0h5VZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275270; c=relaxed/simple;
	bh=pClG0CHGIZUW6Je0jKFllZN+YKY241PYYC4as3pMdLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=el91yunp7MSm5JTQDRCqlbqoMVvZjOkfjjwvWc/NbR1Px+PkPyAbF+YhT6VAHkE9RAqJE02RfXzTj1Pcm1wqlt5gbdrVCCpJcUWLR+uRoPm6iqdot2gorN/OmymjgoJEYcfoh4ySI4hdbiLbox8HcW3Y3vsU9G/tjQBLGkR/k9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhImh9Xd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de84c2f62aso3416087a12.2;
        Tue, 11 Feb 2025 04:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275267; x=1739880067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXji3FwaOFrJZvLaGzUuJa5TBseHpAfeBhh2DojZ0Gc=;
        b=nhImh9XdMkjpYMmbkDHUUx487KPSYUNsi3qkQaSrSN48O1wEKZBShU2GpkL9GkWdw5
         R6uIt/8ZoVbnoWyMbcrNH6MC/fMkdFSv2q71HWmpim5XLQoF4YuEKVL1Cp/fqKir5H/d
         +3RGPjBVl9d+rHrdAak1utYSdkD7jaxSFV6a1uKnpN0zR/IO5INmeADsPpTdJcgmmUCS
         D0lzYGZoOhuDjwp5A+TKzLaumrv5ItKqxd6ZHWGFqJaBSj0ZAHmCXi9gD9+cTnarKqG7
         7x8EZqdh3uPYMiVW+6ARV02ap7jjiKkVz1E8qqkdJXiBsBun1VViKlcdnsRScc8NTHQ1
         xqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275267; x=1739880067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXji3FwaOFrJZvLaGzUuJa5TBseHpAfeBhh2DojZ0Gc=;
        b=UpX9yI8se1/VdjaMvka5Ze/wfCex3K81hiug/CFjtM2ey95foIqIuAAjd/rBMinA3c
         Y9+CKsjZGK8FN2+1RJI3mCEMQ9voD2x6hMY9HEoj4me97p3XDYdGrhzyvdV/9f6VvIQt
         zVSO9Nd2yYpmIqbFA5Fc/K2EvXkTK7dG1U4cuKIRCB9KZib9yf536PDCJrvFrPlSHBEu
         PAhuaSY9M7um9tsTxCa/shOBj2YVl6X7OUnjfa1NHmQjM9cNlNvu2fiZd7VPHMY01NeA
         3tpcsnjfF9t7F3ZPAyF8AHWUvuumuWT7GchxHdHai+suhV3MO+zyW9IeU7/hCQHGt65S
         pVBg==
X-Forwarded-Encrypted: i=1; AJvYcCVoP9glbFFgNHGfDg3pEdTv3LNg3S5pL9EWRk1/QPwA6iIGoyhxfcFbVaeWoVHDkNDp4M+KPs/R6J9W9HdjLg==@vger.kernel.org, AJvYcCXcePs7ad8JzKrnJ2MN/secKAgD5+C16DmWGQk71Bo9Ns8bUwxhrJ5Hm/Wdd1HV+NyIqC8hIIYPXx6RyY9a@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/JaT0V1tHUvu0ZyNXurBYA8RdKzGrcV6q+KxTe/iGy5vIMJW
	tuOumt/5OTXhEDTmGjF3aS3LhoGNpUHgPSIZkm2H81XaDicbQ5TyPawF+xHmDfPNx/J7mcR55U3
	ji++rBNR5/65T8wDWAx7h3cK8E23C7PIr73I=
X-Gm-Gg: ASbGncsZnuupE+8gxlD8Gi1G45s46MZUX/BaLu/yS7GtQ2ovUyxGLdYx6xrkbJIDJCH
	GVMmdL4gl2+cXo3Ik0ZJP2PDSaUkdOYoxTnk9n8awsqwG0EqOKFNQ9AAEHru6KlNEeH/FswkU
X-Google-Smtp-Source: AGHT+IEDBMe2geX8eoPTeC6yn8Qf1qQwPdbv2TeiqBz+6hLY+s6mCZbup2fr40COiFDxXKeuDd5WHZePk5K3yivOvx8=
X-Received: by 2002:a05:6402:4012:b0:5d3:cfd0:8d46 with SMTP id
 4fb4d7f45d1cf-5de450d6aadmr19587423a12.30.1739275266526; Tue, 11 Feb 2025
 04:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com> <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
In-Reply-To: <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Feb 2025 13:00:52 +0100
X-Gm-Features: AWEUYZlxZJWQ5K3FVjQ-kalfndjW0klbhvotPI9YZQZYqn7qRBNcnJFysePPCv4
Message-ID: <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:46=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Tue, 11 Feb 2025 at 12:13, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > What do you say about moving this comment outside the loop and leaving =
here
> > only:
> >
> >     /* Should redirects/metacopy to lower layers be followed? */
> >     if ((nextmetacopy && !ofs->config.metacopy) ||
> >         (nextredirect && !ovl_redirect_follow(ofs)))
> >           break;
>
> Nice idea, except it would break the next patch.

Really? I looked at the next patch before suggesting this
I did not see the breakage. Can you point it out?

BTW, this patch is adding consistency to following upperredirect
but the case of upperredirect and uppermetacopy read from
index still does not check metacopy/redirect config.

Looking closer at ovl_maybe_validate_verity(), it's actually
worse - if you create an upper without metacopy above
a lower with metacopy, ovl_validate_verity() will only check
the metacopy xattr on metapath, which is the uppermost
and find no md5digest, so create an upper above a metacopy
lower is a way to avert verity check.

So I think lookup code needs to disallow finding metacopy
in middle layer and need to enforce that also when upper is found
via index.

Thanks,
Amir.

