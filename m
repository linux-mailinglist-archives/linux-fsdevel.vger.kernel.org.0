Return-Path: <linux-fsdevel+bounces-68479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF96C5D04F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AABA84E11E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5D30E0D0;
	Fri, 14 Nov 2025 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai9Olzdg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A734191F91
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121878; cv=none; b=pMMSyZJsF7WbCCrTcUwFV4mfWzBvx4bsYQzK4JpandcGk9G7gSWVOm4jFKPPz322MprzWIGpVau9KDr6KtPvIvwAcSfsBGj62rz83asuXHIAzIJV8hFQiOOhGmsnLrbgLSffBEv4WMHrac1AyRUy2iGqUBZboFP5mN50h8StHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121878; c=relaxed/simple;
	bh=x6xbQqDyq3/siOHNML7UHG7tz0oXBlvmioxxBnHgW8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPOBrr0cef4PdqndeFJRR4AHJxlHBojUsfjhmAxAsZL/fjvwMZBXiYY+aSvQcJHCZl7UvVtEK8lZCr4KsHs4OgMcq0ITVrP/HNU919P2cPhHpt9AVo/boFYn/+WPeWga1cw9v1dJ0lglzgdnL8wICJLApN7bt/thspujCLh70Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai9Olzdg; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so3105557a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 04:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763121875; x=1763726675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+Ia0/YLClIePr23rrtQAMdjOjoBRt/r/u70odOG7PY=;
        b=ai9OlzdgiW9FiPgYSr1cAvA4wQ3aj0MPAgaBur6py3vt+hNo8Lo0d2JTh8YGkIDQpN
         lwoTQrXKDqa7e4+BqMWFOVETNgMeVhX/jSYAnvvmSZHe/e3uuDbFcCOWxMn7n1zNf2V7
         i7wOxISY2sSwXoUTS/onXfKLtzYT/FX4aPODwBqq4G73pl83pw7oli0oswpubCZV5DMG
         a1by19wIyQPwMY13myNbTgnWHkLMRO69o2jV3s10aE5mRJUFMzhWWcv+Y29+K6+Uzf5G
         5GqAwo6KtFUaQEVjTuJGL9W3OQHofQ60+MMd51oqUfON4JSq7JI33NtePJTec55K/WiF
         3zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763121875; x=1763726675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+Ia0/YLClIePr23rrtQAMdjOjoBRt/r/u70odOG7PY=;
        b=cqnHQ9eZJRCwscqO27rRa0aFMeCz/DlwQlqBmqL1L+CxW1Xd0dLaVN6evhDokJf7JR
         cMMqE3i2MG+lu31lKnmc84NUKW3C73GNI9n6X63HSWZCXAenFCZjGmsRpfXXCnIBc/AW
         JFTkVT7JvwTXQmWMYvQDeKhgDfybGDuWEikUmke7bA/Xao1VUiz2T6oV7A/3UNqcsRoC
         lquDHsUJ/71SEuBpIo3oHAEK9G4E5pu9R42BqaTPnZBQeDN59dzq2XMVhkyTQRMHIuDh
         XNVoXe2iUG91nzcrXhpLArMaWrMsMTxdFif0TzIsnV8C3lBRsf9HZ1Wtk0wIb/GFG6xs
         URww==
X-Forwarded-Encrypted: i=1; AJvYcCXQLIIkDU+j4HjICJxTq2rPt4uA7mUdm+ZGOG4x8mlP+Kn70Xl3xPZPMU0ezZtwX4+hqLmH31t9HAXQKI2q@vger.kernel.org
X-Gm-Message-State: AOJu0YwGnvY8qPjqfDTa/i4bK8nHR39Z8fU6F+/qTYbSeTpXzj+H45YH
	Wp97bng1x2FWaZqE/9s/VE4P3slc7xryPgROcEFPykt9stRuZbO2emAbIfF047Fh6yavEAlGL8t
	Fb3cAvfSWiekfmUSU9/I0WH0fy7vOnR4=
X-Gm-Gg: ASbGnctVzANWhpMUtIEjNODtF8yojUEUdmU12hMR0vZclKr3rBccgLzUprlpCSGEiRr
	OGY2jpcU7YWxIweFiDmnQccvdmc8zvDlYnWWjNp2Jztk64YcB1K7EjasvUWF1XnnkLmCC8Oumxc
	5iaaDxZtAmGkJ4OWfF0d6lD2EmxfkPZhPOmI4fTGWICdxETBo4PnuRywA267at69F8jKEeJ1rYV
	et32Md8l1pOC8v07OosRkQvscW0RKCsG7zsNwGFbheKzOI4FlR5QZfLf04o6w3uY7aK3GOEEj/t
	IOt44B4r0au19wYcpvziAwVQsJ653w==
X-Google-Smtp-Source: AGHT+IFLPZRTeEBnp02A24BB11TzIc54P4/uz4OFeP6C6qvyCufMc0uePFFrCWp4el+uCuwHGruYX33UGp8Hti71IBc=
X-Received: by 2002:a05:6402:34c5:b0:637:e271:8087 with SMTP id
 4fb4d7f45d1cf-64350e89819mr1987517a12.18.1763121875253; Fri, 14 Nov 2025
 04:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
 <20251114-work-ovl-cred-guard-prepare-v1-1-4fc1208afa3d@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-prepare-v1-1-4fc1208afa3d@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 13:04:22 +0100
X-Gm-Features: AWmQ_bmkCUnindwxUUrbK60hAuZ4mDBjDr7Rfbq7cP3I990uQcvef6d_qZPVQiY
Message-ID: <CAOQ4uxhpwpNKeTzR4D_LzOkwxMdpTrik0GmR1Z0UtMf16O29PQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] ovl: add prepare_creds_ovl cleanup guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:15=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The current code to override credentials for creation operations is
> pretty difficult to understand. We effectively override the credentials
> twice:
>
> (1) override with the mounter's credentials
> (2) copy the mounts credentials and override the fs{g,u}id with the inode=
 {u,g}id
>
> And then we elide the revert because it would be an idempotent revert.
> That elision doesn't buy us anything anymore though because I've made it
> all work without any reference counting anyway. All it does is mix the
> two credential overrides together.
>
> We can use a cleanup guard to clarify the creation codepaths and make
> them easier to understand.
>
> This just introduces the cleanup guard keeping the patch reviewable.
> We'll convert the caller in follow-up patches and then drop the
> duplicated code.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/dir.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 0030f5a69d22..87f6c5ea6ce0 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -575,6 +575,42 @@ static int ovl_create_over_whiteout(struct dentry *d=
entry, struct inode *inode,
>         goto out_dput;
>  }
>
> +static const struct cred *ovl_prepare_creds(struct dentry *dentry, struc=
t inode *inode, umode_t mode)
> +{
> +       int err;
> +
> +       if (WARN_ON_ONCE(current->cred !=3D ovl_creds(dentry->d_sb)))
> +               return ERR_PTR(-EINVAL);
> +
> +       CLASS(prepare_creds, override_cred)();
> +       if (!override_cred)
> +               return ERR_PTR(-ENOMEM);
> +
> +       override_cred->fsuid =3D inode->i_uid;
> +       override_cred->fsgid =3D inode->i_gid;
> +
> +       err =3D security_dentry_create_files_as(dentry, mode, &dentry->d_=
name,
> +                                             current->cred, override_cre=
d);
> +       if (err)
> +               return ERR_PTR(err);
> +
> +       return override_creds(no_free_ptr(override_cred));
> +}
> +
> +static void ovl_revert_creds(const struct cred *old_cred)
> +{
> +       const struct cred *override_cred;
> +
> +       override_cred =3D revert_creds(old_cred);
> +       put_cred(override_cred);
> +}
> +

Earlier patch removed a helper by the same name that does not put_cred()
That's a backporting trap.

Maybe something like ovl_revert_create_creds()?

And ovl_prepare_create_creds()?

> +DEFINE_CLASS(prepare_creds_ovl,
> +            const struct cred *,
> +            if (!IS_ERR(_T)) ovl_revert_creds(_T),
> +            ovl_prepare_creds(dentry, inode, mode),
> +            struct dentry *dentry, struct inode *inode, umode_t mode)
> +

Maybe also matching CLASS name.

Thanks,
Amir.

