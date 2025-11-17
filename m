Return-Path: <linux-fsdevel+bounces-68696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96CC63647
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0308348970
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE3C25F79A;
	Mon, 17 Nov 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlP2bJjc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0D1FDA8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373260; cv=none; b=ri4hMbNVSFVQYhNTLqPtHiEybdA3wK6kIOI6EWJnsLUYvGfnOcXRpQ118B0bd0CAcpRZRx209n4W/Re7X00p/i2OUelZ9NgsjTIf0+tCP/VZu+XwG9dqpIk6dahTCsbU+8i5iy3xnkIfiielTzULZgZCHWbnaoDtJKJHkZCvwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373260; c=relaxed/simple;
	bh=XpD10tiL67OuczhG07tB5rMjTZ3p+wG4wDitY6/j4Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjuaY6BUPPrgEv78IrKPYsKbXz0FoTXEGNGwMGkY/q7KVAAwzoMphiJDeKrt91FZnGcdoro9+lmUTTZ5jz73oOOk+ex7M3d1PBSRQL+39Pqng3KiykFnVHinmJTt5xCJdub9a19oqkpNZW4fwmkDO0aAx38I8WQrNo6XbFY2fYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlP2bJjc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so5449085a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 01:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763373257; x=1763978057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD+aMtA5d+3kAnU5X6VmlRARaW2JSBOp81UKZkZrVUQ=;
        b=UlP2bJjczXWv8dBJ70TDCTyqRj1TGklJh0H2uc1/icTX4tG1IGcHWqF6QXQNMC3ppO
         E7tu6IYijFyWH69W21cEdkLDYWVFWTB6YWCg8KS+1N+VjdT8Bwy/VeQkuEPuQaOT5juV
         /66bwmCTJjzg4y9tFCrqejwQxPXwxew02IBQBYpLjyYwlN8tEt79KTffB6zDSGiPMRKa
         c07EoKB8TJCnTBfWjC4O+CsNcMKrVXaMad3eyS8SLCkNyIlbTeqDDxR6kcfWIxLIHZjY
         15deTXqer+/T7tj9lWBhswP6YxxSWlAON8eD1PmNBJGBUIsV9ywsir//M0YQN40Q0qtq
         7xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373257; x=1763978057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HD+aMtA5d+3kAnU5X6VmlRARaW2JSBOp81UKZkZrVUQ=;
        b=P3oB2sNKVH2/mkq88QqHoWcOOhio5kHZSSBZGplF7DjgvHRCI9zGxDc2lUfQJhgUrZ
         S6s8BdU02fYqCNYfOJB03yVE99P7/xW8jTauNiJsiQLe8Vtlwl3BwUARSD0hCUY9nWZr
         VxYVI8IN6XvKhDHKABpF2IsERI4Qxt4/jHT8mnYnPZvfnMf6XGvKEgKnTxojt+5GqDTD
         5bLMqGf1Yv6OdkFi4spSpVMBSkCRfhUGkB3oHaH6sWFXNKz6ylTuE18GV3uxo9jYDzGP
         JlAVBWrfTWv5T3rvodiG+/tIdUzHdSSmenZcknoE6C+XfT+Yv9XkeJCQXJQgS5RLd+j2
         3x7w==
X-Forwarded-Encrypted: i=1; AJvYcCU79aoZwOE3zpSMnLSw4CLk9ld4mGCMk0Vghyk+ScJa7nQtyWSNXHb8dypE7RoegiqDTE+3oVcKCY7iCESn@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQ9es2KorTaVJogHA9ApmYazz/mRPyCkjqI4ufYmrxB5jCkX5
	TLSqvq2BWYosuW/0meA68WtDi9svUh016wkNgf9T2juHQ8QOYU663gFdMdy3xYu+Mjd2+7DwRPD
	5TvyQb8y1Ow/E4K/CzBqSw+Shm4/gVzEI8PSA4fhlqw==
X-Gm-Gg: ASbGncvqv00b3AiGKAQs3Y4W0a12a37LBCUFjlH+2JAe15xENC1CMS0ZJsSml7LlJW/
	02sR9UK4Y9kynuUhsgkZfUwyDy7/ts64p1fyMnjcKlFTk3NBD15pJQ2EgXcgvYiGH9DJ1ySCBLM
	9sVkrLEfrEaUUz5nLRGZpmZKkejEtf5Z9GwhT6bKfceKFXcXNhQWqAXPSddhb69x5xg0rzCaihI
	D5cGjCWpZdGppKthCuPlGGj7px0QOsjM4bLoddEDoGOFocZjSfu7xBZkPqEsAb5qKXMkwp1sEoq
	BnpKupiOG1PY7vqRLYBOnej8z6PFqMdzdJ+efYA=
X-Google-Smtp-Source: AGHT+IG6n4ozUH+cO6JSRqMPvuXVQ6UnZHL5xUh4dDtn1wIlyDY76CWkmb82XPN0XilBnywRUXWIrP0C6C3fZsKmm7A=
X-Received: by 2002:a05:6402:278f:b0:640:f481:984 with SMTP id
 4fb4d7f45d1cf-64350e11448mr10579248a12.2.1763373257367; Mon, 17 Nov 2025
 01:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
 <20251117-work-ovl-cred-guard-prepare-v2-2-bd1c97a36d7b@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-prepare-v2-2-bd1c97a36d7b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Nov 2025 10:54:04 +0100
X-Gm-Features: AWmQ_bn39cEAku2hzpiTGBhj2c8YelvGhTIUXiuenD0_FyixjGJkX38VHO88pZ8
Message-ID: <CAOQ4uxivPErJ1MmOXB3roFup8T5jd429HHgJcLmYSgqskhApkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ovl: port ovl_create_tmpfile() to new
 ovl_override_creator_creds cleanup guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:35=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> This clearly indicates the double-credential override and makes the code
> a lot easier to grasp with one glance.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/dir.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 3eb0bb0b8f3b..dad818de4386 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1387,7 +1387,6 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>  static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
>                               struct inode *inode, umode_t mode)
>  {
> -       const struct cred *new_cred __free(put_cred) =3D NULL;
>         struct path realparentpath;
>         struct file *realfile;
>         struct ovl_file *of;
> @@ -1396,10 +1395,10 @@ static int ovl_create_tmpfile(struct file *file, =
struct dentry *dentry,
>         int flags =3D file->f_flags | OVL_OPEN_FLAGS;
>         int err;
>
> -       scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
> -               new_cred =3D ovl_setup_cred_for_create(dentry, inode, mod=
e, old_cred);
> -               if (IS_ERR(new_cred))
> -                       return PTR_ERR(new_cred);
> +       with_ovl_creds(dentry->d_sb) {
> +               scoped_class(ovl_override_creator_creds, cred, dentry, in=
ode, mode) {
> +                       if (IS_ERR(cred))
> +                               return PTR_ERR(cred);
>
>                         ovl_path_upper(dentry->d_parent, &realparentpath)=
;
>                         realfile =3D backing_tmpfile_open(&file->f_path, =
flags, &realparentpath,
> @@ -1425,6 +1424,7 @@ static int ovl_create_tmpfile(struct file *file, st=
ruct dentry *dentry,
>                                 ovl_file_free(of);
>                         }
>                 }
> +       }
>         return err;
>  }
>
>
> --
> 2.47.3
>

