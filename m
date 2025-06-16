Return-Path: <linux-fsdevel+bounces-51790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0889AADB73A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 18:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0319217074A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019C21C174;
	Mon, 16 Jun 2025 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTOyktU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CBC2367D5;
	Mon, 16 Jun 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092172; cv=none; b=t7JKKiY5T/l65hVQVJ+FlnosVTpFT6Uy+RY97j4UbMQBbdW2pqG+hsbMHCn6XmiJAghzXnkxXbD0OVdD/koqM3216+b4XuaUzfjeG2WtaBVlRKiRHj6qssBb1rfITHfLMcz3fW2HsmP5mIrXj7+APS/WsM/zh+xJA543w47bR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092172; c=relaxed/simple;
	bh=Aam2vH1DT+AxekBGgy42SoF28L3IMN/0FazHzpDFCNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eumFppqoXPLzFKFcIXwiyvJnXQM6NcIYjVaVdtG3ogAYHNktC79soYY3TUUSkuQ4s2gwpSxXpPiYt26p6+IGIgidCv+9YuM+itx2+KX5udWKJnROSW0r60mlKdvSePI34LDycb3W2u9Kufnohhm1A9iriaN7bM0LXs0ksQPGWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTOyktU+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32934448e8bso39694931fa.3;
        Mon, 16 Jun 2025 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750092165; x=1750696965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGHjhkWZFw5eS8LrAUaDK4/YE+VvPVva5Ba83r2adLM=;
        b=HTOyktU+YE+neL9w20wlvrlW57/Bf0qGrCUgUbosYVBDIPj0USaFVtwq+kEM1nVvMN
         g2D2SFp/kn+r6D4qtder/8vjCgO/EgqkuBgEeIGbagiU9nRPSfZ2T8sT1qLLhwyZyKCG
         8qE3Bq+AoYDc87B4SP43XF/T+5lJh7u3KQc6UsNnsSWbU2b4lmm78sgl6KkcHpjs/fJb
         Ji+h2e41oay32CwQDLWwhVAFNdRhjDbQRXlmprdPV7Ealzw1VQWpcwEfvJfOT/xSoqkh
         y0eC6WpUtqhpJFNQ1oXxkHkAZBoF7PfH1jh76Ca+V7CZJSRSUK3vU7S/s6ztplwDMpm/
         OAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750092165; x=1750696965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGHjhkWZFw5eS8LrAUaDK4/YE+VvPVva5Ba83r2adLM=;
        b=oj1TOkfqttLYHNY5k508hjCc1ybnJ5bY0iDy8Qg1l27xxJ0U/xou6EKEo+yQluEzpR
         71SnOpuyeEdCMN5SoLly04OXXGLOgajUnZRVpEW6vymFt5mjEUVckHjaTCeInj8CrmTz
         Z32T8T5LV3LjdP0Cj+XSjg8x/Z86lIdz1bZ6WZGPIAi3xRfsaY5j4Ogf25TviduA3j6r
         oMa0gnJV7c5/UFN2NwkW4Kihs9TN+VbOu5atgdZQL1JPOLdpfPssTWUQZo9D4fvxHQn0
         Ka3lsEJtHCM0qhGh0ysv5s72dU+7Y/mbGo8vzj0XwOE1Y96shvf1B6kigivzkGKmzco2
         vfFw==
X-Forwarded-Encrypted: i=1; AJvYcCUqaYBTyvDbpawczOkG0ZWIdcWRFTMaA9L3CGzdotqNDIZLgFG7Pemgtay0fyexo3ZBYS0rlCpWAg00EPhMUA==@vger.kernel.org, AJvYcCUsKuG5JDfnJxEeUrohb9MO0aZ7cgRDDfo2lPT+9KuQZb+PWzNLKgReCkWlUZBhO65tqqG4VZMaaHOIJ6Fg@vger.kernel.org, AJvYcCX4gIlocp5YcAltIkFuMDjfBPcKuOyL/xd08yoTd0jUJOk5Td/iR/mNVn3gNXz3mqs5YnyanCGASt/e@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlpoeVG4eLNqcBy4vZqk9gNhghDue3IqbGnDfSPF1QfdFbIsa
	qJ+gfVDMOPiJne8smUGTlTPSCd2JdHC2BI/CJ3Zs4vzf2xORDH9dITdhtEGgZR4BTSyN7L2IiIW
	D5Upv6mJw0U90FQVMvmjx7Tegc7oJt/8=
X-Gm-Gg: ASbGncuHiEkF8wHXKheIB/vqpmjOaj7qvDBzDRpxtigUi91QPKtiZuZIx2wfnwUB+ch
	jsVpMPT13jhQ2PNcQKEGCAuCp4xmiRRaqkbTovj2cqNPoskVH7KR3i1Jr7/6UCxzyHftyebUbgV
	LVy8EtJekoE8PyOjLJiFO5ww6EiiPiDRRVY36X1Lb2385kWp3Anu1OpHdHJoali7180CG7bZ3Ey
	r3q
X-Google-Smtp-Source: AGHT+IH86or2b4nSd6J9yqUJQWOMlBO13YM20Bvxvom0rUZ1yN9rwRJvzisWo7kAvJ4hyXcypNhct8NM1uMudAUyl9U=
X-Received: by 2002:a2e:b8ce:0:b0:32a:7610:ccdb with SMTP id
 38308e7fff4ca-32b4a5da0f1mr25478011fa.40.1750092165208; Mon, 16 Jun 2025
 09:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <583792.1750073757@warthog.procyon.org.uk>
In-Reply-To: <583792.1750073757@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 16 Jun 2025 11:42:33 -0500
X-Gm-Features: AX0GCFuQQ2ViM7WpkUVc9dM7ciBWzW3hsNnLBL0zxXjGbJuN5zTpoPQCLObq__Q
Message-ID: <CAH2r5msJPp9PAvnjOVBOBjjZ7skWMNgH7j2s34uR3oyLxBOVug@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix hang due to missing case in final DIO read
 result collection
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

running tests with this now

On Mon, Jun 16, 2025 at 6:36=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> When doing a DIO read, if the subrequests we issue fail and cause the
> request PAUSE flag to be set to put a pause on subrequest generation, we
> may complete collection of the subrequests (possibly discarding them) pri=
or
> to the ALL_QUEUED flags being set.
>
> In such a case, netfs_read_collection() doesn't see ALL_QUEUED being set
> after netfs_collect_read_results() returns and will just return to the ap=
p
> (the collector can be seen unpausing the generator in the trace log).
>
> The subrequest generator can then set ALL_QUEUED and the app thread reach=
es
> netfs_wait_for_request().  This causes netfs_collect_in_app() to be calle=
d
> to see if we're done yet, but there's missing case here.
>
> netfs_collect_in_app() will see that a thread is active and set inactive =
to
> false, but won't see any subrequests in the read stream, and so won't set
> need_collect to true.  The function will then just return 0, indicating
> that the caller should just sleep until further activity (which won't be
> forthcoming) occurs.
>
> Fix this by making netfs_collect_in_app() check to see if an active threa=
d
> is complete - i.e. that ALL_QUEUED is set and the subrequests list is emp=
ty
> - and to skip the sleep return path.  The collector will then be called
> which will clear the request IN_PROGRESS flag, allowing the app to
> progress.
>
> Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the wai=
tqueue used")
> Reported-by: Steve French <sfrench@samba.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 43b67a28a8fa..1966dfba285e 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -381,7 +381,7 @@ void netfs_wait_for_in_progress_stream(struct netfs_i=
o_request *rreq,
>  static int netfs_collect_in_app(struct netfs_io_request *rreq,
>                                 bool (*collector)(struct netfs_io_request=
 *rreq))
>  {
> -       bool need_collect =3D false, inactive =3D true;
> +       bool need_collect =3D false, inactive =3D true, done =3D true;
>
>         for (int i =3D 0; i < NR_IO_STREAMS; i++) {
>                 struct netfs_io_subrequest *subreq;
> @@ -400,9 +400,11 @@ static int netfs_collect_in_app(struct netfs_io_requ=
est *rreq,
>                         need_collect =3D true;
>                         break;
>                 }
> +               if (subreq || test_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flag=
s))
> +                       done =3D false;
>         }
>
> -       if (!need_collect && !inactive)
> +       if (!need_collect && !inactive && !done)
>                 return 0; /* Sleep */
>
>         __set_current_state(TASK_RUNNING);
>
>


--=20
Thanks,

Steve

