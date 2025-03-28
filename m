Return-Path: <linux-fsdevel+bounces-45246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FAA75253
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 23:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF43188C9FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 22:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2143126C02;
	Fri, 28 Mar 2025 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1DIhCcA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54A1EF362
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743199769; cv=none; b=iVHWxjAiq42hsayvldQ3mVXfoDWy6Qyy3kz3lOQ9Qowyj634Zh6gF6mRKtJmyDjaNTHb9qF2YncpOKo2bGS35HZgrpUxqF2WMZCI2EoNw8vtYFB7+vEK0Bi/dAk4veIB8PaTZ1IihMzjTgZ6rfOojicnGiMH2z+MJ07JP0ooUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743199769; c=relaxed/simple;
	bh=CRTwoveQY2p7NTKJMqRFxKn0SG5KyAmbfN/RT/juqVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gosoQV7bIZCnqcdTYNVn8BGBsuW+7OtK3wwdXo+axZSzwE9AIcA7AgJe5uRJt8I3qN7n5vHsuq+FrZfbmJSYEyOJZHUDQI1bQs9W0TPKpskohHFq12fd5AqnVznTEjZYdxpWwyLu9hT4TDSSTAhoRtSOM6feVI8OAVS4MUfck1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1DIhCcA; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47691d82bfbso51188501cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 15:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743199766; x=1743804566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHf8WmQv6k5lTAr4fVHcvJPEYLchDg0PUrKzG3tFU5c=;
        b=C1DIhCcA5kZN8rw9q6TjW+Q78+B5NQ0UcwrFuofzfg8MjzGF/598Me0hWtoRs+wgG3
         AequJ9RO0K9sZlwPoxtLeEvhDNLm15AHGtuq1CjjJC3O613UC012dxZmZ91aqiZQqJvc
         CgQNcMwr32Zb3vcFE9I/8lbt37vcmTZJ07y6aHsM1e1JM+JxzS3wMAJf+HRMzxO/F08F
         rcH9PE3BITWospWY1Clws1oNRIYIjq7htfyAIFJy8JDAIeuUWr7GHzW/cw8Bz+PEwMOd
         YzkZwOzzK4/kN7Luu8sS8IWfMN5lhz3FLMj5T2RPqeLyCDjhbsU7QAEy533xoAAt5Wtk
         GyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743199766; x=1743804566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHf8WmQv6k5lTAr4fVHcvJPEYLchDg0PUrKzG3tFU5c=;
        b=a8vBVWMQiFy1FzEKKxmguRuMcZLhKWLf7uKXYs52ak3mG7rdf516QCMmyzJENE3WPg
         qAMnbzfXMe2fTDm4Ifr2RJrgg5DDyQn/s8YUR8ty3hyi2H4lQo84jE7xZ5A4S3quvA04
         n7NVVUPpIUe+O05XpeeWBw4t9DNPiB/z4FEJI9aQzbd8OdffviRbGmisJMRe8bGBz8rZ
         fjqDfLtv8C9KRnzHgN9Ep6TuuMeBmHIHeK7IheCtoXsVuNfl89IbSJroBK/VZeyEwxlz
         WVG36GJIQ+HDyjRSXYINt0t/WIKuoNMVCOUkqOK/b8V/XraqEo9kzZtvEHakBoJN3Tjy
         u8eg==
X-Forwarded-Encrypted: i=1; AJvYcCX6V7PXoc+n2xelRUvtKw+he87aA/KjDgvpd/MAJjcIofe0e6BE4K+ORBfU49LBczG5bJfDQULa4UTzeqRR@vger.kernel.org
X-Gm-Message-State: AOJu0YxKiKW04QLAXD8Hf6b5FkIs56sPVReZlVt2Hkn5+75Qa8I+cA8l
	gKhvtLHCkt8kmzNrMXwvQN8KyOVyY4sTjnAsfPgwJkuHPebb2mg7hm2BBK4vv0PkdjrhWufNkh9
	5RP5ayF/9tTJkcZUam9N3Jcr1CSA=
X-Gm-Gg: ASbGncsdWrq6aqIAzienXEseqOuUaRvg/C65LL1RJC32mCLFLf54gztEAITOzSnxIsP
	3NeF/Mn9P0b4qtuf9gcXoOH2Cf1sOJKjRthWNhYM3lvVBf7BpRKEqoNMkCsgqv39lRV4iQyEuBU
	JC0H8Y6UrlkSjQ8t/aXTgFu3kQzCI=
X-Google-Smtp-Source: AGHT+IHn/Ighj9F7DANupnTC6h8H+PJlHt0VPZ/kku6zD4fKc8Ot5bE3KeX+UqONlXbIKUGjBMmlZ0V55ryGIy8ZzME=
X-Received: by 2002:ac8:7e83:0:b0:477:64b0:6a21 with SMTP id
 d75a77b69052e-477e4b95d79mr14692681cf.23.1743199766203; Fri, 28 Mar 2025
 15:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-fr_pending-race-v2-1-487945a6c197@ddn.com>
In-Reply-To: <20250325-fr_pending-race-v2-1-487945a6c197@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 28 Mar 2025 15:09:15 -0700
X-Gm-Features: AQ5f1JqZ2HmrhkRICQfZK53Q5SboN79xAa7dwFTar3Xaqmjq934x2gVGmFEsrDM
Message-ID: <CAJnrk1ZrT_45_ZH5f6afAJe7eZWJAVKbz=px5PUeO21A_2cYPA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: {io-uring} Fix a possible req cancellation race
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 10:30=E2=80=AFAM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> task-A (application) might be in request_wait_answer and
> try to remove the request when it has FR_PENDING set.
>
> task-B (a fuse-server io-uring task) might handle this
> request with FUSE_IO_URING_CMD_COMMIT_AND_FETCH, when
> fetching the next request and accessed the req from
> the pending list in fuse_uring_ent_assign_req().
> That code path was not protected by fiq->lock and so
> might race with task-A.
>
> For scaling reasons we better don't use fiq->lock, but
> add a handler to remove canceled requests from the queue.
>
> This also removes usage of fiq->lock from
> fuse_uring_add_req_to_ring_ent() altogether, as it was
> there just to protect against this race and incomplete.
>
> Also added is a comment why FR_PENDING is not cleared.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Reported-by: Joanne Koong <joannelkoong@gmail.com>
> Closes: https://lore.kernel.org/all/CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=3Dm-=
zF0ZoLXKLUHRjNTw@mail.gmail.com/
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
> Changes in v2:
> - Removed patch 1 that unset FR_PENDING
> - Added a comment as part of this patch why FR_PENDING
>   is not cleared
> - Replaced function pointer by direct call of
>   fuse_remove_pending_req
> ---
>  fs/fuse/dev.c         | 34 +++++++++++++++++++++++++---------
>  fs/fuse/dev_uring.c   | 15 +++++++++++----
>  fs/fuse/dev_uring_i.h |  6 ++++++
>  fs/fuse/fuse_dev_i.h  |  1 +
>  fs/fuse/fuse_i.h      |  3 +++
>  5 files changed, 46 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 2c3a4d09e500f98232d5d9412a012235af6bec2e..2645cd8accfd081c518d3e221=
27e899ad5a09127 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -407,6 +407,24 @@ static int queue_interrupt(struct fuse_req *req)
>         return 0;
>  }
>
> +bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
> +{
> +       spin_lock(lock);
> +       if (test_bit(FR_PENDING, &req->flags)) {
> +               /*
> +                * FR_PENDING does not get cleared as the request will en=
d
> +                * up in destruction anyway.
> +                */
> +               list_del(&req->list);
> +               spin_unlock(lock);
> +               __fuse_put_request(req);
> +               req->out.h.error =3D -EINTR;
> +               return true;
> +       }
> +       spin_unlock(lock);
> +       return false;
> +}
> +
>  static void request_wait_answer(struct fuse_req *req)
>  {
>         struct fuse_conn *fc =3D req->fm->fc;
> @@ -428,22 +446,20 @@ static void request_wait_answer(struct fuse_req *re=
q)
>         }
>
>         if (!test_bit(FR_FORCE, &req->flags)) {
> +               bool removed;
> +
>                 /* Only fatal signals may interrupt this */
>                 err =3D wait_event_killable(req->waitq,
>                                         test_bit(FR_FINISHED, &req->flags=
));
>                 if (!err)
>                         return;
>
> -               spin_lock(&fiq->lock);
> -               /* Request is not yet in userspace, bail out */
> -               if (test_bit(FR_PENDING, &req->flags)) {
> -                       list_del(&req->list);
> -                       spin_unlock(&fiq->lock);
> -                       __fuse_put_request(req);
> -                       req->out.h.error =3D -EINTR;
> +               if (test_bit(FR_URING, &req->flags))
> +                       removed =3D fuse_uring_remove_pending_req(req);
> +               else
> +                       removed =3D fuse_remove_pending_req(req, &fiq->lo=
ck);
> +               if (removed)
>                         return;
> -               }
> -               spin_unlock(&fiq->lock);
>         }
>
>         /*
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ebd2931b4f2acac461091b6b1f1176cde759e2d1..add7273c8dc4a23a23e50b879=
db470fc06bd3d20 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -726,8 +726,6 @@ static void fuse_uring_add_req_to_ring_ent(struct fus=
e_ring_ent *ent,
>                                            struct fuse_req *req)
>  {
>         struct fuse_ring_queue *queue =3D ent->queue;
> -       struct fuse_conn *fc =3D req->fm->fc;
> -       struct fuse_iqueue *fiq =3D &fc->iq;
>
>         lockdep_assert_held(&queue->lock);
>
> @@ -737,9 +735,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fus=
e_ring_ent *ent,
>                         ent->state);
>         }
>
> -       spin_lock(&fiq->lock);
>         clear_bit(FR_PENDING, &req->flags);
> -       spin_unlock(&fiq->lock);
>         ent->fuse_req =3D req;
>         ent->state =3D FRRS_FUSE_REQ;
>         list_move(&ent->list, &queue->ent_w_req_queue);
> @@ -1238,6 +1234,8 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>         if (unlikely(queue->stopped))
>                 goto err_unlock;
>
> +       set_bit(FR_URING, &req->flags);
> +       req->ring_queue =3D queue;
>         ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
>                                        struct fuse_ring_ent, list);
>         if (ent)
> @@ -1276,6 +1274,8 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>                 return false;
>         }
>
> +       set_bit(FR_URING, &req->flags);
> +       req->ring_queue =3D queue;
>         list_add_tail(&req->list, &queue->fuse_req_bg_queue);
>
>         ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
> @@ -1306,6 +1306,13 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>         return true;
>  }
>
> +bool fuse_uring_remove_pending_req(struct fuse_req *req)
> +{
> +       struct fuse_ring_queue *queue =3D req->ring_queue;
> +
> +       return fuse_remove_pending_req(req, &queue->lock);
> +}
> +
>  static const struct fuse_iqueue_ops fuse_io_uring_ops =3D {
>         /* should be send over io-uring as enhancement */
>         .send_forget =3D fuse_dev_queue_forget,
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 2102b3d0c1aed1105e9c1200c91e1cb497b9a597..e5b39a92b7ca0e371512e8071=
f15c89bb30caf59 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -142,6 +142,7 @@ void fuse_uring_abort_end_requests(struct fuse_ring *=
ring);
>  int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req =
*req);
>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
> +bool fuse_uring_remove_pending_req(struct fuse_req *req);
>
>  static inline void fuse_uring_abort(struct fuse_conn *fc)
>  {
> @@ -200,6 +201,11 @@ static inline bool fuse_uring_ready(struct fuse_conn=
 *fc)
>         return false;
>  }
>
> +static inline bool fuse_uring_remove_pending_req(struct fuse_req *req)
> +{
> +       return false;
> +}
> +
>  #endif /* CONFIG_FUSE_IO_URING */
>
>  #endif /* _FS_FUSE_DEV_URING_I_H */
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 3b2bfe1248d3573abe3b144a6d4bf6a502f56a40..2481da3388c5feec944143bfa=
bb8d430a447d322 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -61,6 +61,7 @@ int fuse_copy_out_args(struct fuse_copy_state *cs, stru=
ct fuse_args *args,
>  void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
>                            struct fuse_forget_link *forget);
>  void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *=
req);
> +bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock);
>
>  #endif
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index fee96fe7887b30cd57b8a6bbda11447a228cf446..2086dac7243ba82e1ce6762e2=
d1406014566aaaa 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -378,6 +378,7 @@ struct fuse_io_priv {
>   * FR_FINISHED:                request is finished
>   * FR_PRIVATE:         request is on private list
>   * FR_ASYNC:           request is asynchronous
> + * FR_URING:           request is handled through fuse-io-uring
>   */
>  enum fuse_req_flag {
>         FR_ISREPLY,
> @@ -392,6 +393,7 @@ enum fuse_req_flag {
>         FR_FINISHED,
>         FR_PRIVATE,
>         FR_ASYNC,
> +       FR_URING,
>  };
>
>  /**
> @@ -441,6 +443,7 @@ struct fuse_req {
>
>  #ifdef CONFIG_FUSE_IO_URING
>         void *ring_entry;
> +       void *ring_queue;
>  #endif
>  };
>
>
> ---
> base-commit: 81e4f8d68c66da301bb881862735bd74c6241a19
> change-id: 20250218-fr_pending-race-3e362f22f319
>
> Best regards,
> --
> Bernd Schubert <bschubert@ddn.com>
>

