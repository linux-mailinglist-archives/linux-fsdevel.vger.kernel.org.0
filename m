Return-Path: <linux-fsdevel+bounces-55913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B589B0FDC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 01:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA5F7A71EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BA272E48;
	Wed, 23 Jul 2025 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKLSPZEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A61EF0A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753314733; cv=none; b=SnIp7kA1nlLHzewweb2ZN7WzV3g0DX8JJKwX80x4UaG+QpZv6Bt7xfCedmTfGr9IRFvi7O2zidivmc1otPpJ7/bLth/sBMDwEM0akJPbUadWQux1XQDaVazt+l5AgPOVM0hhuyJt5b8kufMARDnIC3VXqrLfX04HXIvlL2r5Kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753314733; c=relaxed/simple;
	bh=S/um9K8fQEZCv73qr1RUHfDMeTJfg8S212yGgFnFaMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNz5UZF8vjCU7X4qbm3PjWik4FrrlcH+qB2nRADbsjKEaBtaMwXuawaZQlS5sZUihYSvAbmmekdxmOsNizOjzPYCOTgPWiTEtwe67pvM9ekPhskjmHZMufxmEUoollyvD/pVQKDDq/+OjF38PyFHa/VatstmbfnV1TNVc+g/dDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKLSPZEw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab6b3e8386so4785571cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753314731; x=1753919531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee54U/m2gdfqXxDyk4rZd/GHFKfrJgszqDwb2Rmzk3Y=;
        b=WKLSPZEwGkznvbkGaeIka3d0vbXToyogr7l1z8QMKpoGDC2JHNI0pnJ9jVEblvWzJA
         bi2eeIiebPRLlDhYvalVwFOKkRl2rnK6cNwzi9TRybMpH7Xn+DbFUC9ZM+x9tt/IcgJs
         3/n2VlKDR3ltT2KUfaDFbL3VxI5SoTE5DXlTX5nvYWrJlDcIXECQaKJs4m3yyvfZDqTk
         edGOWcfgOpSwf2JOiymq9MGcxsuoy3pjRB8MPneE5Ic2PdysGZx9egyZzNz2Aux455g8
         ZwaB7jMpXlN0pkweQl2dT1Qppswi+MSh8oVJelOyNpHeBGzDJi6w29ITUoqZkg/9d9bO
         mMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753314731; x=1753919531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ee54U/m2gdfqXxDyk4rZd/GHFKfrJgszqDwb2Rmzk3Y=;
        b=LUpQz88Df72xXTbT5F8dB8IdoIhPaRA34onxQhcRA7GQsXou17ia26mXkIhwkUlyZb
         q5b172ECiCZIiKG5TDtfYaRK0swKQ91FhPTXyNkQa4Jo3pvM+jXcX65oKKvuwltrFkWG
         GUr7eqnwYLF8aOd5huVAUZdrWIVeGA88OausXLjvdYo/1kFcuTWFOWvSVdg90h0aRNxa
         d9kXTreQ1ttFH+/2u8ypMD2JFnGpk6Pt8rNrjKHicuPNjOP/24gYf2zZYOnCKb7LYIUy
         5Y0OfJoEL2xyGEWxnlcyi4rDJ1XyJPTkda60O3Lu2Fump3cNIhL+ZgUkJzMdHrdO1VYK
         03LA==
X-Forwarded-Encrypted: i=1; AJvYcCVBrZ1NGSANxU4DThBqjhqquDJO+FovszmTNHXU7kopPE+e06MlZndZodjt3JBrxXnAPkbKOYZpSbp3TR7z@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3kBDv/r930yh8xk1Uki0gBkigOBMi/ru2GduDTYRD8D5eY3u
	TSwuKNwcvSru9c73IvuENqm0Y/wsZxS1GfuuOlLfBXkyWmNeYm9UZS5GIBj2uAZMZJZ14vAfCTb
	rxY8VZSiU3Ls6PKBzrwX5lpvOTZZQpESLQDPv0Q8=
X-Gm-Gg: ASbGncuIaUQQeemfAX6v1k+l0AgqKgcoVWDiS7Tyvkr4D7DaXLfWhIWPm9nDuDUOWEa
	b2pGljp9D+QuQxPyalGhIIedKu4tA9T5h4T/Z2SB592gELbTS5oLfWNLPtfOy5mp4lHjOc+AfA9
	UAPOsLN0jpM9U04XpDMSTiKZgFbN6Ov+G0XuAO2r8vRp0OEJ5wVv0Lfssy5E41BX/RLAarjqgU8
	ZblWlk=
X-Google-Smtp-Source: AGHT+IEMRnbgAKZOxyuUQQiruj3steQESdzwy7vNKBKjHqVthCYNDmtR44+IIXkos0BuHE11p2CQVcXizXOpjf4iy6k=
X-Received: by 2002:ac8:59cc:0:b0:472:1d98:c6df with SMTP id
 d75a77b69052e-4ae6dfb8872mr78046391cf.52.1753314730629; Wed, 23 Jul 2025
 16:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-bg-flush-v1-0-cd7b089f3b23@ddn.com> <20250723-bg-flush-v1-2-cd7b089f3b23@ddn.com>
In-Reply-To: <20250723-bg-flush-v1-2-cd7b089f3b23@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 23 Jul 2025 16:51:59 -0700
X-Gm-Features: Ac12FXz8Cq5kWY-bdfaoNt1PSPk3VsqHeEkMKwG7ZoX09s3y38FIT9niJ06JcGU
Message-ID: <CAJnrk1bbT7QnEfY-Kp_NOmrS-EZW92qwddKTgruMKe-WGMneiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Flush the io-uring bg queue from fuse_uring_flush_bg
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 3:42=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> This is useful to have a unique API to flush background requests.
> For example when the bg queue gets flushed before
> the remaining of fuse_conn_destroy().
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c         | 2 ++
>  fs/fuse/dev_uring.c   | 3 +++
>  fs/fuse/dev_uring_i.h | 4 ++++
>  3 files changed, 9 insertions(+)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5387e4239d6aa6f7a9780deaf581483cc28a5e68..d5f2fb82c04bf1ee7a35cb1d6=
d43e639270945af 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2408,6 +2408,8 @@ void fuse_flush_requests(struct fuse_conn *fc, unsi=
gned long timeout)
>         spin_unlock(&fc->bg_lock);
>         spin_unlock(&fc->lock);
>
> +       fuse_uring_flush_bg(fc);

I think we'll need to get rid of the
"WARN_ON_ONCE(ring->fc->max_background !=3D UINT_MAX);" in
fuse_uring_flush_bg() since fuse_flush_requests() sets
fc->max_background to UINT_MAX a few lines above before making this
call.


Thanks,
Joanne

> +
>         /*
>          * Wait 30s for all the events to complete or abort.  Touch the
>          * watchdog once per second so that we don't trip the hangcheck t=
imer
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index eca457d1005e7ecb9d220d5092d00cf60961afea..acf11eadbf3b6d999b310b5d8=
a4a6018e83cb2a9 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -123,6 +123,9 @@ void fuse_uring_flush_bg(struct fuse_conn *fc)
>         struct fuse_ring_queue *queue;
>         struct fuse_ring *ring =3D fc->ring;
>
> +       if (!ring)
> +               return;
> +
>         for (qid =3D 0; qid < ring->nr_queues; qid++) {
>                 queue =3D READ_ONCE(ring->queues[qid]);
>                 if (!queue)
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 55f52508de3ced624ac17fba6da1b637b1697dff..ae806dd578f26fbeac12f880c=
d7b6031a56aec00 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -206,6 +206,10 @@ static inline bool fuse_uring_request_expired(struct=
 fuse_conn *fc)
>         return false;
>  }
>
> +static inline void fuse_uring_flush_bg(struct fuse_conn *fc)
> +{
> +}
> +
>  #endif /* CONFIG_FUSE_IO_URING */
>
>  #endif /* _FS_FUSE_DEV_URING_I_H */
>
> --
> 2.43.0
>
>

