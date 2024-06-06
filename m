Return-Path: <linux-fsdevel+bounces-21108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23398FEFA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D52828C26D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355F319AD8E;
	Thu,  6 Jun 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUqMdu9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873B196DB8;
	Thu,  6 Jun 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684411; cv=none; b=bNIUS7fQLKVIGD/VA1wezc0wbLV3E+DX1oYi/xPj3jmlHIiNKm6JLbfTnSyR3VWpZApadFEzKRnA8uO2uqET0wW8SqeCLJKuiWyB63mMQ9DP/uAh+IcvIef3bnIu0BpLcjho5BAT+7Nyjw04U3kxWSUONnUYJXUmCZ/hieyaC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684411; c=relaxed/simple;
	bh=z2aMNW6speFYWYGfqOFRjJMnJn+QHJ2ChisVkcPa20s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCbOiQfMUTIslLZDzPN5UNzeHQ7IcT6PEpBY73NdMxPJmNWJcyzaova6k9K8s6WrTlohaT136Z7Tc8hbwTsqjH4ayOA+jKrxjHDaHTn7yKwl1xn0rLk9/nihGYzY7cKAnS429CiZnLOx42idzclcHCJpcgAOUn7fq/Zca5VN9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUqMdu9o; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79517ff527dso60942885a.3;
        Thu, 06 Jun 2024 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684409; x=1718289209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXy9ZshJzoipG0WEEKUipDjKLkHhQIDQe2ob1zDmxHs=;
        b=PUqMdu9ohVKRriit8dWU1/I0vCfsGEExWvNq0WtTac1UaAIp0tMMI6fz9T3X5rAHa0
         StM9hEqUAjLi54ATR53XKPCnVydqOYS9xPrx5+eWcFR/xf7a3VclMSWcLeGtIOqbtDHb
         4VP+B+QnwMz9U4T/WLK8cGFivdySrwpkAzHW1O132jGFuiLJOKIHHfW5wL5A7AUkSFVP
         9bIA23/dpQL6OQGH24jVbIys+NXUkPsTGNf/sVPyaKBbnrdSwQjAFRxrelvBu2oy9EFr
         lwWZSCaBXO2ESB/fGg/jJpD2Bgl6rWtk1u29nq853eCXHQaLhx6taP4yt7IISGh2gVrw
         PC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684409; x=1718289209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXy9ZshJzoipG0WEEKUipDjKLkHhQIDQe2ob1zDmxHs=;
        b=HPi3QvVkVNvnsnctOXWDHP6qbuMqZFWZYd9WiiB0wErqU/hFOTvymZNMdOX4P9/JkJ
         xO1EI7H6Wq6BNhtIE3DdwLG3TaqyVQ+8qXjDgu4pmFhj2UhxFdxM8UACEcBafiQHB7XF
         8sXMEt0fQABHhsuRcildBaMYIQrfEyW4x0pnYSNW8A+fzI7TEkGNB5ChRXGhW6RgC2Au
         xD9TaZarppIwy8rO59WgE99QEtL6cAnPUuzwVjKW0/P4TX1WkDeJ1deIoIOT0aqVz1bJ
         gJnXz091CezkWYESOtX2zralJd5Djlja9RVBL1zf7UZoBOyi0M069xo5yWBWApqqY908
         lBLw==
X-Forwarded-Encrypted: i=1; AJvYcCUS1h+9hq06hxvsAwH4kIkUZpc+8/9hFQ7WKqosNGPp6thxGnmaRfBqBvQpocASnu7poQ/kbvAYCqWmBhuBXnsT21zKrtRi/ugwEpJ9tA==
X-Gm-Message-State: AOJu0Yz7MWyK1w6zskrsancX6vGxpAB1Oh0L1I8ynra2gLLhblAlcJee
	I9FWTBN2xO6Bo2bopP/BP2gTV8jrzk3KpymFV1Ld+v8ag7f+yA1GIMFi2ZWbgJ6e9Qg3i6YBUVB
	8FS7buhJ+UFI9PW2eD0j0ftzuk/8=
X-Google-Smtp-Source: AGHT+IFpV6/Vq+Jfe7DcjTtDFqCk4rpIxn8W10iRhdrmMEwY5BNQvOW6XzuVu7GZ3yutgR0wa9qPxyecGxcsX9KAaBY=
X-Received: by 2002:ae9:f80f:0:b0:792:a92a:2c6 with SMTP id
 af79cd13be357-79523d4abf3mr543437685a.17.1717684408995; Thu, 06 Jun 2024
 07:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org> <20240606131746.563882173@linuxfoundation.org>
In-Reply-To: <20240606131746.563882173@linuxfoundation.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Jun 2024 17:33:17 +0300
Message-ID: <CAOQ4uxhL59Sz4akfk-DGQXYTRwLu4B1gPUgKOy0J_RehdzkVTg@mail.gmail.com>
Subject: Re: [PATCH 6.6 439/744] splice: remove permission hook from iter_file_splice_write()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:18=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.

I have objections and I wrote them when Sasha posted the patch for review:

https://lore.kernel.org/stable/CAOQ4uxgx7Qe=3D+Nn7LhPWAzFK3n=3DqsFC8U++U5XB=
aLUiTA+EqLw@mail.gmail.com/

Where did this objection get lost?

Thanks,
Amir.

>
> ------------------
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> [ Upstream commit d53471ba6f7ae97a4e223539029528108b705af1 ]
>
> All the callers of ->splice_write(), (e.g. do_splice_direct() and
> do_splice()) already check rw_verify_area() for the entire range
> and perform all the other checks that are in vfs_write_iter().
>
> Instead of creating another tiny helper for special caller, just
> open-code it.
>
> This is needed for fanotify "pre content" events.
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/r/20231122122715.2561213-6-amir73il@gmail.c=
om
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Stable-dep-of: 7c98f7cb8fda ("remove call_{read,write}_iter() functions")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/splice.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index d983d375ff113..a8f97c5e8cf0e 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -673,10 +673,13 @@ iter_file_splice_write(struct pipe_inode_info *pipe=
, struct file *out,
>                 .u.file =3D out,
>         };
>         int nbufs =3D pipe->max_usage;
> -       struct bio_vec *array =3D kcalloc(nbufs, sizeof(struct bio_vec),
> -                                       GFP_KERNEL);
> +       struct bio_vec *array;
>         ssize_t ret;
>
> +       if (!out->f_op->write_iter)
> +               return -EINVAL;
> +
> +       array =3D kcalloc(nbufs, sizeof(struct bio_vec), GFP_KERNEL);
>         if (unlikely(!array))
>                 return -ENOMEM;
>
> @@ -684,6 +687,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, =
struct file *out,
>
>         splice_from_pipe_begin(&sd);
>         while (sd.total_len) {
> +               struct kiocb kiocb;
>                 struct iov_iter from;
>                 unsigned int head, tail, mask;
>                 size_t left;
> @@ -733,7 +737,10 @@ iter_file_splice_write(struct pipe_inode_info *pipe,=
 struct file *out,
>                 }
>
>                 iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len =
- left);
> -               ret =3D vfs_iter_write(out, &from, &sd.pos, 0);
> +               init_sync_kiocb(&kiocb, out);
> +               kiocb.ki_pos =3D sd.pos;
> +               ret =3D call_write_iter(out, &kiocb, &from);
> +               sd.pos =3D kiocb.ki_pos;
>                 if (ret <=3D 0)
>                         break;
>
> --
> 2.43.0
>
>
>

