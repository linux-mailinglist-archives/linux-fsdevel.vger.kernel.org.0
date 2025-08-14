Return-Path: <linux-fsdevel+bounces-57887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7CEB26635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24521893AF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE62FE06C;
	Thu, 14 Aug 2025 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjxeOasw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA702F99BF;
	Thu, 14 Aug 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176802; cv=none; b=SMEpzjiAP30liC34zOlJMGA/rETeXcsqZ+pRt8rRaRsH8fSkjR8SG85cg1KdHY6JWdcOAzLB8da36dEgd+CaLEqWieV+Ib41Vhptp53JGF0v6mjRz0ThUgofQvVertigk/N/IOp1ugbaz3rdN7+LGghPNxs9OO9flNa0T6hc0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176802; c=relaxed/simple;
	bh=yXU+xqss3wt6RF2C1pQzlmW8kyy9g6iVFki28NId5x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1N9IS8VJUX8tO9tcchtDfiNq39Wl6sYuHml3MKpb4wmTIJFTgVojji+KQVYGQ62ciWK/2VP8RQenIr2qG1Eodejqf6CXVBtuBIJOkhWXgP/ZkYQyRziSO3+98RPt2uuVmHKujEaw+CsrCLHTBXdi40aWpPpzsYT3v5P9vbjDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjxeOasw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so1973278a12.1;
        Thu, 14 Aug 2025 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755176797; x=1755781597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NolYQJvyhPcsnT+xMKzXGXu3lpIUA/IYkI9+Mycsw/Y=;
        b=hjxeOasw6an8s2/XEWLT4C31ZrOwMTrbtj82HlhFYoyquY1ObcMWim+vUt6QKjBoqN
         eP3EwITn6oEdJFVPPp/54QjPWJyfmQB2wbnQOFiAxIBbtZZSEpiEpzRBJQTWHG1UovED
         8JYugU2/LYq240mFPgCzSnM1AVPx/AC2v5CnX66/HDcGEJMooLORYuKotpCLfVLtsmzM
         J+CVb7COtYpDUGaiS+Vcdz0QbOSS8lSTDvIVFAShG55VwfFwoA1lTKRxLOgOFClPLlZe
         qGyxhl6apopvkbBjTk73NsevCUNnQYagUkHMLbO8e/0RJNbsHWYRRzneS6xMPqAn6RB0
         IDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755176797; x=1755781597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NolYQJvyhPcsnT+xMKzXGXu3lpIUA/IYkI9+Mycsw/Y=;
        b=r3AayZizuljDRB4C7neURIarjap2PbUE01LulnyYZLrXuodoeceZ0KCIGOvuRV5031
         4jA8QSW/B1oKtga40v6OjotHL230Wy96d5FHRNzlCxucuWCg9eltkCsK4IGqboJrlCEh
         ghuYrhEFwxkvNNyrDsP41UfI7qt64gODN30IuY/s6t6EM1PL2KC/A2473uLLpX4jIf2C
         r+9Q50Agcfy7rf/vPrQecmCFBy+kTVchRMOqvZZvgn0/YoQQMJSeBC0uxHFOS406c8d5
         8IgMGvPrfFXEgeJ0HrXHcnatgdxNtVgBpsFtbCqTBNq9IvSgVzO7oKV1lAcvek8afwkH
         673g==
X-Forwarded-Encrypted: i=1; AJvYcCWUATk8wjXQNvUlmj/LdyDrdV9JROrYz9WqXel7tZl/hDtrL5Z1lY2eHJk3xdcBI+vlonrJe12JjTOVv94N@vger.kernel.org, AJvYcCWl7/pnnVHeJmR2lJc/xDH8z0JbB7dTyRa8kcNZuAMuAWoQ24CIG/R2858hTeSqnQKqZbgC0ua9AcaE8Boz@vger.kernel.org, AJvYcCXZP1xYm5+jokcfgs4v3kxsPfPOyi+Y2GlPWIWcwmYVspH0MWoY+GmtAtCF2jcA9kfZwlUmTAeoIByjtEp5eA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aSp95IzS3giyGDgL0DRcaaj+Ls1OjbWZJed+dkbT4CFrefiG
	gGcoUifMjqT8+eWYXeJ0VsKSWg0oY5lEYiM/unNRgzD9Jqkcl4L5yQGvDfrT0eKWJIyqJlnG3sR
	6j6Hvco8N2xlIDVkE+5xyu24fLN3/2XU=
X-Gm-Gg: ASbGncuPYZGMt74uhE+d1cldUDa6Lp+utBzmackU1evPXOPwo8NSxEdmHnk8s0sBEUt
	IsqG0k/VmVRoKTzXcI0n8Hx8hkat4RNtTtKy3LKxMAadLg9HEXnA5QFWIZhykmbRk2lOaskUfg7
	gi5jJgrYRxvSBkav/4v67tHvttH+M9t2d7QNiqPpNcVCh1gJCp6YLoqijlHachSQCtYpXnYgmTc
	A9J6Hk=
X-Google-Smtp-Source: AGHT+IG68uLyeU9XKnDtlckrLqRHGga2ZRNfbbT8dB5hS0cyueD2JJwU2RYX12xFYFwAenpPmmwyfAC4DMNL9y4xsUM=
X-Received: by 2002:a05:6402:46d0:b0:615:ad7c:cc44 with SMTP id
 4fb4d7f45d1cf-61891b21c95mr2351275a12.17.1755176796734; Thu, 14 Aug 2025
 06:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com> <20250813-tonyk-overlayfs-v4-8-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-8-357ccf2e12ad@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 15:06:25 +0200
X-Gm-Features: Ac12FXyXL-F1FoALdjDGvfjZD9WRh1OuOFhGA6BF_z8biO23BoKqvE2Rx9RgFto
Message-ID: <CAOQ4uxjzmTCWesbGtD67u5yaUU4mRheObL=bCmLBoWFfPhzEYQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] ovl: Check for casefold consistency when creating
 new dentries
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:37=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> In a overlayfs with casefold enabled, all new dentries should have
> casefold enabled as well. Check this at ovl_create_real()
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v3:
> - New patch
> ---
>  fs/overlayfs/dir.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 70b8687dc45e8e33079c865ae302ac58464224a6..be8c5d02302de7a3ee63220a6=
9f99a808fde3128 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -187,6 +187,11 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, s=
truct dentry *parent,
>                         /* mkdir is special... */
>                         newdentry =3D  ovl_do_mkdir(ofs, dir, newdentry, =
attr->mode);
>                         err =3D PTR_ERR_OR_ZERO(newdentry);
> +                       /* expect to inherit casefolding from workdir/upp=
erdir */
> +                       if (!err && ofs->casefold !=3D ovl_dentry_casefol=
ded(newdentry)) {
> +                               dput(newdentry);
> +                               err =3D -EINVAL;
> +                       }

If we do encounter a filesystem that does not inherit casefolding
(which is perfectly legal) the reason for this error is going to be very
hard for users to track down.

I think this calls for pr_warn_ratelimited() like we did for the lookup
warnings with inconsistent casefloding.

Thanks,
Amir.

