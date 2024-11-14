Return-Path: <linux-fsdevel+bounces-34748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEE9C8561
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0582B2A5B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5FB1F7797;
	Thu, 14 Nov 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPRL1XK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462331F76C2;
	Thu, 14 Nov 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574578; cv=none; b=FZ++r7ZHL+dvNt9ZcVOXYKWv94kWDg+cqmQ05HLYEU7Q50rFBT+QSnCdpg5PFC/6FhHIkbwPIu/2ga+y+nr0V8XIuHwycOKYkoJr/RU0H8P4Kg86EDU+bkpnVs+Djfy684tkWVNdPQnea/iCs+ELuwQpUtyl6a7cG96AvLiHiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574578; c=relaxed/simple;
	bh=+Kcks4+MoH1dGgJVxVViGL1/8SgAheSksGOdFZwz/lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2F0fgktQAZK6sgUsNRr9rABovboIoyQ3JGlKX75qzJPFDkiLuVZogzZ4lEh7bvQaqvVlIfNDLUJN/OmXD7qA+NmQttp6VBtfoJ7XwwtrijNiUgHX0FC9uvA8o2CoAdCwu4PsX/v8+qvJuQ+TeXc3m9opsUUW88Lc5RSdIW98LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPRL1XK1; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d3e9e854b8so4656916d6.1;
        Thu, 14 Nov 2024 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731574576; x=1732179376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fka0qAiq0GtAsXHDcKvajqGKTaUu1AUnphiVt3sPZ0I=;
        b=CPRL1XK1IoLh78FySDk4K+zHFmm39awbgnJhbHv7Wm1GdNkEcCoUMDq+l5H2dK8KQr
         UvTFLO3yqToJyitAbcrfvacQkSMqvCBtF0az8f/KbdB7FFI/tsfgAzMKoo1VNeG+bbA2
         scIxS5lMJ8BkepxpOUPXkWJX8OC07j1n6P1vJvD7n+l//H2FGc44MX7Uz96dWYwpjilt
         xRkfPvSlnH16P8zlpTdeQqGA5IgANI+1/40W/hO4Be92ZEDavg5n+lcxCnbK6Ds7rLn1
         zS2op7wYSn3hqCZ5L8Uo39BmTmH+Tfj9bWU9mPJFlAoQ8gGK+4CjwkLI0ePdvAIe3jua
         m+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574576; x=1732179376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fka0qAiq0GtAsXHDcKvajqGKTaUu1AUnphiVt3sPZ0I=;
        b=IUIDeNz/1k6b/zpJHDR/TeFixZqnQXJHtXm313sLV+FxuFPdg5lgIgZoTm8mohR9gS
         8xpeWNSTgaFf+NVCHp05L9HQtqiz6KjE+s9ABdvM+jHEWz631oCffayc7WGPczNkJ4v1
         /74CQMj0PR0r2XYKGpePEQ986LOoN50tJs9/ztlMmLtctMJyVUCKdwUz0LzwcjNGVi93
         U6jf0j8sJW1EUoKgsbM4ov3sxvvgQRIbXxnWnv856bNAOvbAoeYuf5gRnandkzkd//Jc
         SVCpBF/Qjs7/js3pOyywFRPnmsbWMffHmHGXO0p0/PH2aPnO7p9jAn6E4gB4nPRl70HT
         AV7g==
X-Forwarded-Encrypted: i=1; AJvYcCV4wYMX/tXaA8D2YAQdJ3iBm31KVm8QuYc2n4xboKkweAZs8j5IT9e7z5oRKgG5XmaipSgYJmzpavBRPcvm@vger.kernel.org, AJvYcCVUq4j569PaRPE1ZXK5quJCPKMYzheUEPkm2kVVd5IAzHExCKIGjthH80X92I91x95riQC6UMc+3OjMzWue@vger.kernel.org, AJvYcCWNzaZRaVooWXyLKIfmqr5mqHBUTA9Z5ZNqGV5KAmq2LgmHPa6YpIOLK9W67Ht2jnnp1LKq9UOrT9CL0/ipsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7L9cMDHeJaCOMGuO9RxuwtG6vFYmNY2t3ovFBkWInzKbeHT7
	B18Xb05iTQSM96rgoIi3/dZoJ4ed7I1OW9c9WmJ1xRFOH150TnmK9YV1tljkUu/u5EHmlQooX8o
	932CxLzAf5PXwt6e32DWAkjOhZiM=
X-Google-Smtp-Source: AGHT+IG8hDvpof60JZ2Ge/zGIiukxyq1BC4BuxYDCknzlwMwZ31CgP6PQwy9cyUjAN8fUmeH7M5Z2FDboGBy84qXMik=
X-Received: by 2002:a05:6214:450e:b0:6ce:26d0:c7cd with SMTP id
 6a1803df08f44-6d3e8fb7fa6mr39405556d6.2.1731574575934; Thu, 14 Nov 2024
 00:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
 <20241107005720.901335-5-vinicius.gomes@intel.com> <CAOQ4uxgHwmAa4K3ca7i1G2gFQ1WBge855R19hgEk7BNy+EBqfg@mail.gmail.com>
 <87ldxnrkxw.fsf@intel.com>
In-Reply-To: <87ldxnrkxw.fsf@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 09:56:04 +0100
Message-ID: <CAOQ4uxguV9SkFihaCcyk1tADNJs4gb8wrA7J3SVYaNnzGhLusw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] ovl: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:30=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Thu, Nov 7, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> > <vinicius.gomes@intel.com> wrote:
>
> [...]
>
> >
> > Vinicius,
> >
> > While testing fanotify with LTP tests (some are using overlayfs),
> > kmemleak consistently reports the problems below.
> >
> > Can you see the bug, because I don't see it.
> > Maybe it is a false positive...
>
> Hm, if the leak wasn't there before and we didn't touch anything related =
to
> prepare_creds(), I think that points to the leak being real.
>
> But I see your point, still not seeing it.
>
> This code should be equivalent to the code we have now (just boot
> tested):
>
> ----
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 136a2c7fb9e5..7ebc2fd3097a 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -576,8 +576,7 @@ static int ovl_setup_cred_for_create(struct dentry *d=
entry, struct inode *inode,
>          * We must be called with creator creds already, otherwise we ris=
k
>          * leaking creds.
>          */
> -       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dentry-=
>d_sb));
> -       put_cred(override_cred);
> +       WARN_ON_ONCE(override_creds_light(override_cred) !=3D ovl_creds(d=
entry->d_sb));
>
>         return 0;
>  }
> ----
>
> Does it change anything? (I wouldn't think so, just to try something)

No, but I think this does:

--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -576,7 +576,8 @@ static int ovl_setup_cred_for_create(struct dentry
*dentry, struct inode *inode,
         * We must be called with creator creds already, otherwise we risk
         * leaking creds.
         */
-       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dentry->d=
_sb));
+       old_cred =3D override_creds(override_cred);
+       WARN_ON_ONCE(old_cred !=3D ovl_creds(dentry->d_sb));
        put_cred(override_cred);

        return 0;

Compiler optimized out override_creds(override_cred)? :-/

However, this is not enough.

Dropping the ref of the new creds is going to drop the refcount to zero,
so that is incorrect, we need to return the reference to the new creds
explicitly to the callers. I will send a patch.

Thanks,
Amir.

