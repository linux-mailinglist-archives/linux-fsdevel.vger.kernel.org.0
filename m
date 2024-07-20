Return-Path: <linux-fsdevel+bounces-24036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E2937FC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 09:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584561C2155D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 07:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A491A291;
	Sat, 20 Jul 2024 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+f6AmQQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555165821A
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jul 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461456; cv=none; b=FRL6o5yEYLVYz/UIPCIdHcDZnHFrqiOg5vPaot1e0I3wWtI7qScwWZtKx77fWz11gYprUEANPTC6MJ4VFuLOL8BNhfhPmXvdOXGSfnmVu3aSSX3CtRDKg9FCjho07zsjzgzECllpzC4MWUqvupqBOYwx9yLWG12ySJXRWwfKpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461456; c=relaxed/simple;
	bh=JOEIobkIZAzDt4BNOx32SJplqQOWURyezuGAmtfpRTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEKUPpbuj7b6myVAbr0l7UOHMP089ePznR/XPC4ZX5CWuicURw32D/1ieJ1+pPmE+UR66qiatOP/QTHaQML3ukwmhC5lLty7IpXvyylSyCie/0zZqpnbgj5rj0Q75lnmdjn4B3rMHFMwvtS0l2sO1frA3a7M67U0f4hdGg9GOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+f6AmQQ; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48fe76c0180so852555137.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jul 2024 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721461454; x=1722066254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZd2vTZteakA+pgUqZUhXPjL+6tljKBJDA37c0FPp50=;
        b=N+f6AmQQO68mzBy2JFmkoLpTw2PJuYfvg0w60byp+qbBWNb5HyfVfitEzambMly1Co
         fOe43NosRZDVxxYeXvKWJvWStQz5tceXqtw5TWcTMeBvXjM+f0+sRDpeUBfysj8HaqP0
         M3OHzLk66VWcz67KttT0I6Bq2Zh1pkheQ/dhomLMmS1I3AtfhahYmjJ8Pyczlncb8aVU
         RDnkqtzQY1ToEgoPX3rcOOrMbanqxfiCq0Fj0Z25A9NHFSc1kvJaId9ua/xp8XM+eDR9
         /4bV+E678DrXyUGOwuRWMLNx8enRIj2rmfq9fWGH2Rb9NyiFtif2yDlb56O/1GmxyTOT
         l53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721461454; x=1722066254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZd2vTZteakA+pgUqZUhXPjL+6tljKBJDA37c0FPp50=;
        b=KM7N2qo4Ex/SOxBUNwJT4qn083/o4wRuAlA3jBmKVIB+GzEgwzOmmlE517QH5yaF5R
         l5KI5j/qarAVRDARA6Klin1Zu6G1yKR1mPPdHItFZw2JZUaIcuVSEPh7Kn9i9G4veleq
         sRT9nU0qAEFfZBR/RVI8/JN/MgI1R7KUl0vZMMezqXsozU+L/I8fdOJzevu77Aap9wC3
         eEnUaQs7P6PMHwk5hL7g+FI/GhgUKA2PS2Tn5xRhzM4A3exvW9jnW09enspUYtQSBGub
         /HbqQihJCOd5ZdNi8ZvneFNV6QGw6KuzSTdJX3vEmBxVqdNDvo95nSuRSt1rkOGRCyCj
         hE6A==
X-Forwarded-Encrypted: i=1; AJvYcCVU6HnBDrXLcDciScCcC7roLri8E3thBYBrsnvhuNXxstLBlNjh5lIe4tBoBkXXBIK4Hbht4C8ydb7VTQUln7BMS/rafn2NQ+ToYjIayA==
X-Gm-Message-State: AOJu0YzkhXdwrc6lYGOByJAM/8mkqSu/YkKthZeA9nOLmIootyrLHOzc
	JoNnvkVZ8X5zZH1f3wD9W6foGXBLvrz35kNtkwLrQfapDZGxllVPs+3O7drAzOR6sZk8Pb6MQTr
	50P4w4M7IjjyR/eDYbfqJs35sLmUpFLoSxgI=
X-Google-Smtp-Source: AGHT+IFcL+G9NFEImNYHQQzhV39PrJhV0c8O5fzT17tfadK4+8BQQer/Ek56f4+mVFa8tTe0pTOk2x4+mNPM4ikooZk=
X-Received: by 2002:a05:6102:6a88:b0:48f:eabd:d72a with SMTP id
 ada2fe7eead31-4928b9ad17amr576690137.17.1721461453402; Sat, 20 Jul 2024
 00:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adfd31f369528c9958922d901fbe8eba48dfe496.1721403041.git.josef@toxicpanda.com>
In-Reply-To: <adfd31f369528c9958922d901fbe8eba48dfe496.1721403041.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 20 Jul 2024 10:44:02 +0300
Message-ID: <CAOQ4uxhq9rWBXAxsvF3vm=fc2rPo=hpkiX9TZO8y5BgYDJNbJA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: don't skip extra event info if no info_mode is set
To: Josef Bacik <josef@toxicpanda.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 6:31=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Previously we would only include optional information if you requested
> it via an FAN_ flag at fanotify_init time (FAN_REPORT_FID for example).
> However this isn't necessary as the event length is encoded in the
> metadata, and if the user doesn't want to consume the information they
> don't have to.  With the PRE_ACCESS events we will always generate range
> information, so drop this check in order to allow this extra
> information to be exported without needing to have another flag.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks sane, you may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I think it would be best to re-post this one along with the pre-content
events series for better context.

Thanks,
Amir.

> ---
>  fs/notify/fanotify/fanotify_user.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 9ec313e9f6e1..2e2fba8a9d20 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -160,9 +160,6 @@ static size_t fanotify_event_len(unsigned int info_mo=
de,
>         int fh_len;
>         int dot_len =3D 0;
>
> -       if (!info_mode)
> -               return event_len;
> -
>         if (fanotify_is_error_event(event->mask))
>                 event_len +=3D FANOTIFY_ERROR_INFO_LEN;
>
> @@ -740,12 +737,10 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>         if (fanotify_is_perm_event(event->mask))
>                 FANOTIFY_PERM(event)->fd =3D fd;
>
> -       if (info_mode) {
> -               ret =3D copy_info_records_to_user(event, info, info_mode,=
 pidfd,
> -                                               buf, count);
> -               if (ret < 0)
> -                       goto out_close_fd;
> -       }
> +       ret =3D copy_info_records_to_user(event, info, info_mode, pidfd,
> +                                       buf, count);
> +       if (ret < 0)
> +               goto out_close_fd;
>
>         if (f)
>                 fd_install(fd, f);
> --
> 2.43.0
>

