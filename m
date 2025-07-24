Return-Path: <linux-fsdevel+bounces-55916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ED0B0FE1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 02:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0A61CE0BBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16476FC3;
	Thu, 24 Jul 2025 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NevmptLD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C9EEDE
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316251; cv=none; b=vCQz4VJYULLA3ON1eWqYfbOn7sJq9jbwkbbNCzYiQjolvD7WCZlWwc376Yq6Y1uHD4Df4Dp1D/BjqgCGpr9Ww59SEKQKeaVzSEtD4HiHUZAWUHsOuOGvBGO+/RedXEn8yIfSdYrRSBQCwm/tx8cyjMRShMnd2DdPvobcJEtAn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316251; c=relaxed/simple;
	bh=6ua0cNKa4PXECr+bAB8t1XgLDcMsedMBBkG8PHrQros=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbEl7/GFMi6F9dtQjrFsJA1Ke8e4g6HGokUUuuU+HJwEilcnSFnJdYQPEdbxi3zDoSGd5cC3dh2ev2WFqNQlR65auieV7E7MvGP6a2jcSQNn2We9nKDW/gdh3J41djdupyotrjmMflkMdDSFE6BVC+PJn6QBsoOmcVlY0w+8maA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NevmptLD; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e169ac6009so56228085a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753316249; x=1753921049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z8Svpg1cfbuktjGluThKcnPQObK+9oMCGdTlo+8hnc=;
        b=NevmptLDDDF2/u8FfRJasIGi4fgis8zFE3Smwj9ZyIQDgrFtA8C6DZRcnX82u3keJ5
         svU8VEUnT1eRwOSd/Z3PrUux/6HYFm12a2uoUtFbX/1bQ8mKgwvQk59m+qg+yuDDzcAm
         ynu7bGHmuV2vUHaExks7leQltljNaha9OMRIkFU+63kTrlycUJeIcxD2O25RaYYNuIjf
         LeIMQr8VVDnuCAaxMmIJQDL4x+oZw1zc9hI9Y5ASW7L+gwo2ZQVawBvQ+Mb74N8GJNJM
         atGwPB9SvJunQkB5+NXESnD2R6gV3ENpAxyN4WIcRcmF6rBJwlsm/MElVOsMJ86WTC1o
         CG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753316249; x=1753921049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6z8Svpg1cfbuktjGluThKcnPQObK+9oMCGdTlo+8hnc=;
        b=TB/r0u7yiskdbub9RJQZYxybCbLxZ8A5kTN5sR5DlfU2CAAyL6r8C/yL2CtfTn2WzV
         LIdmEqlympvqXuvOdR/LCJ47d1bV+trdhBznoEtR5X4qnvAxKHWEqybhgqH6L8depFUn
         0FeGHW9pINB+Bn0JVZD3aR+FWIm+QvIbT6Q55TOkj94Xy9s3b/7F3f9QsP9bDTLE6ikd
         7cAvL7aVHIsqZz7t2O7aqI6xJ+HpFmqubSQTNo0D/kFrGk97hngYV4hqljZEFu+a6T3u
         +DIOH6p2ivrAl/VyocwUiuOPTXiuxjtwajLXAz+zrbfQPS2OQPSeNRljkJTGW6Ogq3xz
         0wIg==
X-Forwarded-Encrypted: i=1; AJvYcCWllhPImHrFsqTbbJvBCvrn2xZb8hi8FnhT7vPdUBLXyns3BBpPQDNw597LjHL05nJMULuN20S3taej3MDK@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiLPMbX4xuym2Yq3dOHJgK49yPlC8H8rb6vUs0rtmbeqWFo3U
	JlRJ8FCeK6NkxdrRaV+bWNiYRdfNhr2BVufZl9AEjA8/jqHHyGIO8wjgSZJbcNbhwKToZCxw3d9
	C8LMSKr0YeVTQeSGlwOYx/EYKecwnUIECOZ8ASnI=
X-Gm-Gg: ASbGnctcXBlzUMUE0KbBJNEJGNG41iNeRTZyayzwAAKRSirZfYAGo5xUfFF2ii4eRvl
	TxFlNSPpayJ3YfYLzKOOaV6113nnzED1uSI8IKaxfpMbzhXQrqv0J3/onDbStEIePMo9QKwg0X9
	kHZDN3OibFMPAXiP+hDZu3lMQFDsAEnDmz+KxVjGVfxt9at7ZOSED1lOAZb2knxYdG74UNmgbNX
	QHu/wieWcKEjYq/3w==
X-Google-Smtp-Source: AGHT+IFg0tsGMaVZ5PDhg7bcoa6yEiBmpoVh1g+5sIKMZkID/VOCTEWgmdcXW18ISI++bn/tkYhwZkbttXypfcE2qFc=
X-Received: by 2002:a05:620a:a106:b0:7e3:2c14:2319 with SMTP id
 af79cd13be357-7e62a192cd6mr634637685a.44.1753316248415; Wed, 23 Jul 2025
 17:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-bg-flush-v1-0-cd7b089f3b23@ddn.com> <20250723-bg-flush-v1-1-cd7b089f3b23@ddn.com>
In-Reply-To: <20250723-bg-flush-v1-1-cd7b089f3b23@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 23 Jul 2025 17:17:17 -0700
X-Gm-Features: Ac12FXypUKtjAT_K7AS60AjQ20wln1piXZH7ojVri5sLTBsNag354dgde4chKeM
Message-ID: <CAJnrk1bAoDdm8n+r3sBXUqvZQ3av7T7YVBR4zCtLSBNkwLGY4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Refactor io-uring bg queue flush and queue abort
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 3:15=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> This is a preparation to allow fuse-io-uring bg queue
> flush from flush_bg_queue()
>
> This does two function renames:
> fuse_uring_flush_bg -> fuse_uring_flush_queue_bg
> fuse_uring_abort_end_requests -> fuse_uring_flush_bg
>
> And fuse_uring_abort_end_queue_requests() is moved to
> fuse_uring_stop_queues().
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c   | 14 +++++++-------
>  fs/fuse/dev_uring_i.h |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 249b210becb1cc2b40ae7b2fdf3a57dc57eaac42..eca457d1005e7ecb9d220d509=
2d00cf60961afea 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -47,7 +47,7 @@ static struct fuse_ring_ent *uring_cmd_to_ring_ent(stru=
ct io_uring_cmd *cmd)
>         return pdu->ent;
>  }
>
> -static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
> +static void fuse_uring_flush_queue_bg(struct fuse_ring_queue *queue)

nit: i find the naming "fuse_uring_flush_bg_queue" easier to follow
than "fuse_uring_flush_queue_bg"

>  {
>         struct fuse_ring *ring =3D queue->ring;
>         struct fuse_conn *fc =3D ring->fc;
> @@ -88,7 +88,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *en=
t, struct fuse_req *req,
>         if (test_bit(FR_BACKGROUND, &req->flags)) {
>                 queue->active_background--;
>                 spin_lock(&fc->bg_lock);
> -               fuse_uring_flush_bg(queue);
> +               fuse_uring_flush_queue_bg(queue);
>                 spin_unlock(&fc->bg_lock);
>         }
>
> @@ -117,11 +117,11 @@ static void fuse_uring_abort_end_queue_requests(str=
uct fuse_ring_queue *queue)
>         fuse_dev_end_requests(&req_list);
>  }
>
> -void fuse_uring_abort_end_requests(struct fuse_ring *ring)
> +void fuse_uring_flush_bg(struct fuse_conn *fc)
>  {
>         int qid;
>         struct fuse_ring_queue *queue;
> -       struct fuse_conn *fc =3D ring->fc;
> +       struct fuse_ring *ring =3D fc->ring;
>
>         for (qid =3D 0; qid < ring->nr_queues; qid++) {
>                 queue =3D READ_ONCE(ring->queues[qid]);

Does the "queue->stopped =3D true;" line inside this function need to
get moved? AFAICT, if we set queue->stopped to true here, then we're
not able to send out the request (eg fuse_uring_commit_fetch() returns
err if queue->stopped is true)


Thanks,
Joanne

> @@ -133,10 +133,9 @@ void fuse_uring_abort_end_requests(struct fuse_ring =
*ring)
>                 WARN_ON_ONCE(ring->fc->max_background !=3D UINT_MAX);
>                 spin_lock(&queue->lock);
>                 spin_lock(&fc->bg_lock);
> -               fuse_uring_flush_bg(queue);
> +               fuse_uring_flush_queue_bg(queue);
>                 spin_unlock(&fc->bg_lock);
>                 spin_unlock(&queue->lock);
> -               fuse_uring_abort_end_queue_requests(queue);
>         }
>  }
>
> @@ -475,6 +474,7 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
>                 if (!queue)
>                         continue;
>
> +               fuse_uring_abort_end_queue_requests(queue);
>                 fuse_uring_teardown_entries(queue);
>         }
>
> @@ -1326,7 +1326,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>         fc->num_background++;
>         if (fc->num_background =3D=3D fc->max_background)
>                 fc->blocked =3D 1;
> -       fuse_uring_flush_bg(queue);
> +       fuse_uring_flush_queue_bg(queue);
>         spin_unlock(&fc->bg_lock);
>
>         /*
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce14158904a86c248c77767be4fe5ae..55f52508de3ced624ac17fba6=
da1b637b1697dff 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -138,7 +138,7 @@ struct fuse_ring {
>  bool fuse_uring_enabled(void);
>  void fuse_uring_destruct(struct fuse_conn *fc);
>  void fuse_uring_stop_queues(struct fuse_ring *ring);
> -void fuse_uring_abort_end_requests(struct fuse_ring *ring);
> +void fuse_uring_flush_bg(struct fuse_conn *fc);
>  int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req =
*req);
>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
> @@ -153,7 +153,7 @@ static inline void fuse_uring_abort(struct fuse_conn =
*fc)
>                 return;
>
>         if (atomic_read(&ring->queue_refs) > 0) {
> -               fuse_uring_abort_end_requests(ring);
> +               fuse_uring_flush_bg(fc);
>                 fuse_uring_stop_queues(ring);
>         }
>  }
>
> --
> 2.43.0
>
>

