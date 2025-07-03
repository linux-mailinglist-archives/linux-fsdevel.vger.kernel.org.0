Return-Path: <linux-fsdevel+bounces-53786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD0AF71E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6374A4543
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EC42E3382;
	Thu,  3 Jul 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1woTX0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B971FBCAE;
	Thu,  3 Jul 2025 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541292; cv=none; b=LxsGRfjg1uUWL1b8qOi1Tz/W0bqG9hQOenp4NJYAd5yCZYj/5ssObQk7YJRTesz4Br75gKESpv9qrDcrh6MSttYajRmD6b7TN4JGL3N/CMqc6cveUApkvvAYwDMbDmoJgKcI9HGyIrq3krsdQDa4vpuThFZhqctSqCm7gDy5KJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541292; c=relaxed/simple;
	bh=mNsqj9xikvGHAbhnFLxXI85xQtG5WdRBKzviDxj0WTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEzCxQuToSDvsYB8QBOgi6PDAJt3L+CTPwT66j2n6/C5HpqWeS2U6tD6LCO4qOYPp6dhaCqoozjmR5exUhFssLLonAuFMF7DI/aWsOJ+/rH8D0sStEzRQbA7SVUOsm5wRFX2Ael9nxCLCm5HCq22Vbq0kq15bcVXQJ7c3isTgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1woTX0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDE4C4CEED;
	Thu,  3 Jul 2025 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751541291;
	bh=mNsqj9xikvGHAbhnFLxXI85xQtG5WdRBKzviDxj0WTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q1woTX0lYCFKseDwN8E+6ES4HBIJoFuPdjZt+7QfG4Nt71LPVOqIuel7391+LcJGk
	 ZtMH6WdpNAIAHu9f4DwgoVUBSOezulo02zrFarf0njDQYJRbxVlD+wdFzQCUrhftYk
	 59l+MYnRXKdbnKkYWfrm89ll4JM20bqjnEv+PX5QKUxskU7c3+ewgNLHsThN8XoMaM
	 t80kYst0olIlOsstKbIOhCvk9uEHP2sqtZQceipxcxw9pbMI/alzJDy7bDIyiTHYY8
	 //NjRhy2tudfKHmF4A/5EIr/KA5hq3rp4lA/lvX7SyzgEqayCtzwdK4DUfPEnQKQ+o
	 WDZ/QzEqjHOKQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60f276c7313so3225952eaf.2;
        Thu, 03 Jul 2025 04:14:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDGPLA2rbe/eiiDQcIxNQObn9KIzWBfhkmY0BHe0RX4ebQtVZ2BR9Wxp/d8f7T2BzfORcT+YpWyWQ=@vger.kernel.org, AJvYcCXkwfPMS4AVy9rZRjtp7GHKWBn08nKupW+kUqSLn8G3B+6LiBvMaym+NvkEHZHzqZ5K8qcvUDozHmXHEp7t@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsz7bS1xCe5H7fzgmib0odeG6X1Zm4mAIfnX8fF20Z/tcCD6g
	wkTTg+qmq1iGbW8NZDMiimARLePPtJp9a6NVtxAuWLTet/hVBeAQ5OqE2H+4SiarEAbTOWgRwBQ
	d2LT/BR9xHolZ9sIPY89tmqRW+pAcJH4=
X-Google-Smtp-Source: AGHT+IFqc5Wym2KKFRMOKCGjwCYMLryBz8OJng0oeHksTC/dDorg9PYRwpjhuu9n3EIUq5sf15kLvFRP2nn5r0p39IU=
X-Received: by 2002:a05:6820:4cc9:b0:610:f4d7:740b with SMTP id
 006d021491bc7-6120106a13cmr4169467eaf.2.1751541291140; Thu, 03 Jul 2025
 04:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702211305.GE1880847@ZenIV> <20250702211408.GA3406663@ZenIV> <20250702212542.GH3406663@ZenIV>
In-Reply-To: <20250702212542.GH3406663@ZenIV>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 13:14:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0guc=2UXE3s15B9gZr2MAM6knQvC-99mUOGxNj9QGLcgQ@mail.gmail.com>
X-Gm-Features: Ac12FXyNtgljTBtK-b_DNH3DuNL5sMatSa6wtry9MjU9IEM_VLJivcl_LIGW-WQ
Message-ID: <CAJZ5v0guc=2UXE3s15B9gZr2MAM6knQvC-99mUOGxNj9QGLcgQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] fix tt_command_write()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 11:25=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> 1) unbalanced debugfs_file_get().  Not needed in the first place -
> file_operations are accessed only via debugfs_create_file(), so
> debugfs wrappers will take care of that itself.
>
> 2) kmalloc() for a buffer used only for duration of a function is not
> a problem, but for a buffer no longer than 16 bytes?
>
> 3) strstr() is for finding substrings; for finding a character there's
> strchr().
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Or do you want me to apply this?

> ---
>  drivers/thermal/testing/command.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/=
command.c
> index ba11d70e8021..1159ecea57e7 100644
> --- a/drivers/thermal/testing/command.c
> +++ b/drivers/thermal/testing/command.c
> @@ -139,31 +139,21 @@ static int tt_command_exec(int index, const char *a=
rg)
>         return ret;
>  }
>
> -static ssize_t tt_command_process(struct dentry *dentry, const char __us=
er *user_buf,
> -                                 size_t count)
> +static ssize_t tt_command_process(char *s)
>  {
> -       char *buf __free(kfree);
>         char *arg;
>         int i;
>
> -       buf =3D kmalloc(count + 1, GFP_KERNEL);
> -       if (!buf)
> -               return -ENOMEM;
> +       strim(s);
>
> -       if (copy_from_user(buf, user_buf, count))
> -               return -EFAULT;
> -
> -       buf[count] =3D '\0';
> -       strim(buf);
> -
> -       arg =3D strstr(buf, ":");
> +       arg =3D strchr(s, ':');
>         if (arg) {
>                 *arg =3D '\0';
>                 arg++;
>         }
>
>         for (i =3D 0; i < ARRAY_SIZE(tt_command_strings); i++) {
> -               if (!strcmp(buf, tt_command_strings[i]))
> +               if (!strcmp(s, tt_command_strings[i]))
>                         return tt_command_exec(i, arg);
>         }
>
> @@ -173,20 +163,20 @@ static ssize_t tt_command_process(struct dentry *de=
ntry, const char __user *user
>  static ssize_t tt_command_write(struct file *file, const char __user *us=
er_buf,
>                                 size_t count, loff_t *ppos)
>  {
> -       struct dentry *dentry =3D file->f_path.dentry;
> +       char buf[TT_COMMAND_SIZE];
>         ssize_t ret;
>
>         if (*ppos)
>                 return -EINVAL;
>
> -       if (count + 1 > TT_COMMAND_SIZE)
> +       if (count > TT_COMMAND_SIZE - 1)
>                 return -E2BIG;
>
> -       ret =3D debugfs_file_get(dentry);
> -       if (unlikely(ret))
> -               return ret;
> +       if (copy_from_user(buf, user_buf, count))
> +               return -EFAULT;
> +       buf[count] =3D '\0';
>
> -       ret =3D tt_command_process(dentry, user_buf, count);
> +       ret =3D tt_command_process(buf);
>         if (ret)
>                 return ret;
>
> --
> 2.39.5
>
>

