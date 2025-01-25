Return-Path: <linux-fsdevel+bounces-40099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4053A1BFD5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 01:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68923AF863
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC65142659;
	Sat, 25 Jan 2025 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1KitjkE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030C13635C
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765087; cv=none; b=MXIth8dqZSR7s0XFMbAistD8dwOS8QK6NHmEk/ik0LxSF2hkzROy7kOxC68M/e/9o5Frdy3t6UWv/81yx60eSa5TnNQFhmgZpPtJlt8B3ya9foHIfOwZPO0GitKATUP19jViorxu42z1sL9XacftA9YzsxKknbYKK6Msg0Q+QkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765087; c=relaxed/simple;
	bh=SR6XKn8q34cHwqxA32rhgrCgP+50FgBg5tC7UPX6uWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZcnpKRPBBdfFFGiGGgqb1aEURh2nzBbvEmlfwPlxZyOZORSIKcGIqcWIpOdCzN7Od4nVsOC74co69X76DAfdQ0A9EDZtL5VMZ3VelwzQ5c+ck+PfoUegZNEoBQPg/oYZkCggCBZ/T6BmfDMuPzZf5fo+Z3T0YZOIsOZl9ccEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1KitjkE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46b1d40ac6bso24730621cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 16:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737765085; x=1738369885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAIykMngroBde0Ow2HrUHH6TGSFcAQUM7lMr4FFBt7I=;
        b=W1KitjkExz2EQrTIZe0W5ZR7N8InZq2TURKt46esN7zD9idrMMaK/quIBgz353cpns
         Ee2P1Ih8LkjV/4u2TFJ+zTSLRtdMljn8fC30289a3r8b5J10yeX3/dnJXClEe4D5GxdE
         wJyfLTRapbZS0Madifrw3PTfKBlDzTGI/X6qS1uiHVNRgH7uHOxWYShfP2tu2NKF5ouW
         3Q323+dl2+4dmuzU/NbKtBohmMChDVps9sgB3k66byGXSJF4ENgYqbMWzHnAUSdzXKAp
         Phd/jFhmUnn9ST8Zz7v4IpjqiTGGdBnc8lBUuJqc+6UsTrZ08bATKYaNi2WYWVKV8UOx
         qBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737765085; x=1738369885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAIykMngroBde0Ow2HrUHH6TGSFcAQUM7lMr4FFBt7I=;
        b=mcntF03/JolB64tmqNnn6WHrx5Jrz3/Nxj2ymu3mUyA7oldgR93bUAfEN5Pg5kVdBk
         9CNxM2PEgrQzVIdr5k1rNeRF5k0p91beHNG0jmtp7tyNLiKvqAs1uMLnW+I96hPrGKQ+
         LrpyfJsvgl24T0NDurYcl2jqHqF6nY57QvtqkWV492L5zIvFq8r7EZgRzC8hkIgvUFx+
         i5lT/hnZFa8XNrbO4Jfj/mXfu4Xkl4FBWxNHLGBBlNpNbD9oid9HJYxVD1nJ8yHb80Up
         g6rU6g7Cq0lRv4eiw1DnGIR/xes+3L9I9B+aLvwNPi6X9Pd1hP+6aZ/gYmpNIy9liwFi
         S+ag==
X-Forwarded-Encrypted: i=1; AJvYcCULbqmnGf44nECefeJmAubBsECAuIypUPyIu9AAa6gwFRqkm9lV4mGXcdh3DvcJpiBZguRllBOKRA4MD+2u@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8XLPpFU9iDXyk2txZt4tDGT0iTGelbWEhjZv31MhCFG+qQUa
	rldi9Q/zT0GWzfHjefDpTAMe0nHaptJUY/8O7nQo0qOOfWlXFgCzYJD6ulkGi71ry0W9hAXWBDj
	0oM5/nZ8W822fgoCBK2PQtqX11/o=
X-Gm-Gg: ASbGncv4TkYj9fTwYyfpGxq98sMLUdM92gEd+ctbVDTCrwLpY1esNBdKtF2SEQs4p2w
	Mv0PwU1CbqRC2jxaEXe3a0cvZIm4mxaTWL587+NvH+9TGBcIH4+BaHSQsZid12b8=
X-Google-Smtp-Source: AGHT+IH3b+tjBc/+dNMvgxefji+P1a+dB0j4nDumAOsyueC9svHBwLjrTk78q2paaPabjEwugVP1D1gwQq6fW0BDrwY=
X-Received: by 2002:ac8:57c2:0:b0:467:59d5:b20b with SMTP id
 d75a77b69052e-46e66feae90mr77319641cf.4.1737765084713; Fri, 24 Jan 2025
 16:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
 <20250124-optimize-fuse-uring-req-timeouts-v1-1-b834b5f32e85@ddn.com>
In-Reply-To: <20250124-optimize-fuse-uring-req-timeouts-v1-1-b834b5f32e85@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Jan 2025 16:31:14 -0800
X-Gm-Features: AWEUYZm0ZrocRz0CnwTGfpLbvpeh44JeRZ-_ZgzFTMQSzMlV5tfGdCx3NBNu2Vk
Message-ID: <CAJnrk1aDH0kPdXOrEh4=ApW4biNzOtkCKKT=57-T64=ZO1BEUg@mail.gmail.com>
Subject: Re: [PATCH 1/4] fuse: {io-uring} Use READ_ONCE in fuse_uring_send_in_task
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 8:47=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> The value is read from another task without, while the task that
> had set the value was holding queue->lock. Better use READ_ONCE
> to ensure the compiler cannot optimize the read.
>
> Fixes: 284985711dc5 ("fuse: Allow to queue fg requests through io-uring")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 5c9b5a5fb7f7539149840378e224eb640cf8ef08..1834c1933d2bbab0342257fde=
4b030f06506c55d 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -1202,10 +1202,12 @@ static void fuse_uring_send_in_task(struct io_uri=
ng_cmd *cmd,
>  {
>         struct fuse_ring_ent *ent =3D uring_cmd_to_ring_ent(cmd);
>         struct fuse_ring_queue *queue =3D ent->queue;
> +       struct fuse_req *req;
>         int err;
>
>         if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
> -               err =3D fuse_uring_prepare_send(ent);
> +               req =3D READ_ONCE(ent->fuse_req);
> +               err =3D fuse_uring_prepare_send(ent, req);

Hi Bernd,  did you mean something like this?:

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5c9b5a5fb7f7..692e97f9870d 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -676,7 +676,7 @@ static int fuse_uring_copy_to_ring(struct
fuse_ring_ent *ent,

 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent)
 {
-       struct fuse_req *req =3D ent->fuse_req;
+       struct fuse_req *req =3D READ_ONCE(ent->fuse_req);
        int err;

        err =3D fuse_uring_copy_to_ring(ent, req);

I'm on top of the for-next tree but I'm not seeing where
fuse_uring_prepare_send() takes in req as an arg.


Thanks,
Joanne

>                 if (err) {
>                         fuse_uring_next_fuse_req(ent, queue, issue_flags)=
;
>                         return;
>
> --
> 2.43.0
>

