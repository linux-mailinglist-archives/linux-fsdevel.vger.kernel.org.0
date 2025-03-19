Return-Path: <linux-fsdevel+bounces-44482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A20A2A69A93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 22:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCF316C048
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41DA2144A3;
	Wed, 19 Mar 2025 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPzIsS89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DD1A072A
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418439; cv=none; b=a5d+TCgqkxqd0G7ewFiaJ6nRPdjFNhO3EK47aoKQjCAzuebL/Td4TzlAHSsE/K4PCb4Ae744gcDdWQcqWA1hOKT6BxSnqHVNKLt8RLsz8yTekZnpkdYEBYJIY8s4va3aRsYxLowr+elgJ9Lg2bmfwjjsDTWRrcb21FXEedJ7X5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418439; c=relaxed/simple;
	bh=Yjd3pkVnw+QErPk+dbzhCMcAr8f7gsut7kjkUJB+R4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4HfL6KwiswyHOqCujzmlcTW/RUsAsqoPnI501laaM1kZbnsPK+GATgPagzrR3TdgPZuKEDkSKqlQ6Q4y/WLbxjIFwW58F+2WPupPsFXU6nq0tbqUkl94Jb3UitBtLwODvQtvD9QEpLAu0zr/y9Azyycb2IrdfIQ4T172KPspTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPzIsS89; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47698757053so1857091cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742418436; x=1743023236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvjyBMD1aR5cjsbvAQvKZsbzd8hLbDvZ7ccDXh7yVyw=;
        b=KPzIsS89Doe1A4TNXUQPCQ4oAUt3ler/F+G9KX4NU33aahmJXOlso364pEC86X78UJ
         L8yWSp8rWK4BGk+M9V++r4EVy20vwLzQTciRE9EBeUNuI8HCPoPm9JnTWrKPyWyzeQ6s
         xRsrvMGXszF5UK2/Io2PiJQqa0VGNxmVeK8sCmy/hfCi9KpC4I5ByzoVN6B3RbcWlp+4
         ouaWNnmjnFoWgszcZgAzANzyt8cShkcFl7NNBm7kphrLIiYfPBeO9Jzip2dO4QkrFv8o
         JhKvFvaeCqIPQu4MhFYmvuVjfb9zl4DPhfXZ2ARcTnO1emA0LwCIe5oUJ09TgmXjBbm7
         7e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418436; x=1743023236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvjyBMD1aR5cjsbvAQvKZsbzd8hLbDvZ7ccDXh7yVyw=;
        b=JfrYX2BjLesJQ5lUfCI4MnfoF8LAJGTx95UTyk6MPKSKg8jfXWQsYQujqyBZQRmQFS
         D4WPhPMDvGyvHTMAHkNZ0H/OEB2BJTttJmRiC517PNVig5ARSBKIOeC+iWQLxpGQM0jt
         6fCp75rs+5bb1rUaEI9KkNtvn14huR70IHll0dU6+xcgL+BXoaFCYLZC+h4Pd2zldhKA
         42HBqHhxlnsb2QviKVwIz+kpG16ag4nqiJpXTXWNkJPo/mmAjHZT3PHE9MWnnJT+F8zP
         0PWzN3QHo+rwVO/UWUjQDlaSxh/g1Q1+gv1zX58TA99P67g6kqNOn+7o6yp2VV8dR/9i
         Yumg==
X-Forwarded-Encrypted: i=1; AJvYcCVWSEx9xEx7c/z/EerZW5XVnejYsZfaAmG1dxoTK3oWDC7Pi7ESvKmnU9OseE/PhD38jUZAHXEF1a++IIux@vger.kernel.org
X-Gm-Message-State: AOJu0YzUY3eyW06MDRE1yZzqY4U2GdAknyy4Ab6F2hBW/5Rw6ZE6TzV9
	UYoWk5D4Q0d6HXlDTsHbx/hbi6L25TnBGyI6MjgegjQO8hwM5LhkvplSkH/50bLBNWKqtY0wfAZ
	OvbfF2aUh1Kjynllujl1ExL8uhEQ=
X-Gm-Gg: ASbGncvaEa2C1ZiCmc0r+IfJ2BKWR2/MDqb7A//pWtSksm/mABqSjHGkaDXSOezUIFw
	A2XemWh5ed46KelOery3DuOpjLO9RvyOQvesJiW4rWBdsnvESgB7A0REub4Ad2MDxarZBcLQ7bx
	5KO1YJsiWpybTStjJBeaVkB+z69ZI=
X-Google-Smtp-Source: AGHT+IFqXAxuod130J4jVTaHRhmtmPihvn7xXWbMRfb8vIObNNkMJSIjYNifZju2+bRNPajxxorezONqtg0D2yCgba8=
X-Received: by 2002:a05:622a:2285:b0:476:7f5c:e2fe with SMTP id
 d75a77b69052e-47710cab232mr17430991cf.6.1742418436023; Wed, 19 Mar 2025
 14:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-fr_pending-race-v1-0-1f832af2f51e@ddn.com> <20250319-fr_pending-race-v1-2-1f832af2f51e@ddn.com>
In-Reply-To: <20250319-fr_pending-race-v1-2-1f832af2f51e@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 19 Mar 2025 14:07:05 -0700
X-Gm-Features: AQ5f1JpISUMSM6kxD6iyuv1tJkTr1oY0LnxwIU6Wil9pWT5o-5EfVhNnNsKdUT0
Message-ID: <CAJnrk1ZAU1jMpZ2=ovAO_vVJaJ=Tc1mk8YN7zECZEcwjD2TX=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: {io-uring} Fix a possible req cancellation race
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:37=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
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
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Reported-by: Joanne Koong <joannelkoong@gmail.com>
> Closes: https://lore.kernel.org/all/CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=3Dm-=
zF0ZoLXKLUHRjNTw@mail.gmail.com/
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

LGTM but imo the code looks cleaner with
fuse_uring_remove_pending_req() just directly calling
fuse_remove_pending_req() instead of passing in "bool
(*remove_fn)(struct fuse_req *req, spinlock_t *lock))" as a function
arg.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev.c         | 33 +++++++++++++++++++++++----------
>  fs/fuse/dev_uring.c   | 17 +++++++++++++----
>  fs/fuse/dev_uring_i.h | 10 ++++++++++
>  fs/fuse/fuse_i.h      |  2 ++
>  4 files changed, 48 insertions(+), 14 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 124a6744e8088474efa014a483dc6d297cf321b7..20c82bb2313b95cdc910808ee=
4968804077ed05b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -407,6 +407,21 @@ static int queue_interrupt(struct fuse_req *req)
>         return 0;
>  }
>
> +static bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lo=
ck)
> +{
> +       spin_lock(lock);
> +       if (test_bit(FR_PENDING, &req->flags)) {
> +               list_del(&req->list);
> +               clear_bit(FR_PENDING, &req->flags);
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
> @@ -428,23 +443,21 @@ static void request_wait_answer(struct fuse_req *re=
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
> -                       clear_bit(FR_PENDING, &req->flags);
> -                       spin_unlock(&fiq->lock);
> -                       __fuse_put_request(req);
> -                       req->out.h.error =3D -EINTR;
> +               if (test_bit(FR_URING, &req->flags))
> +                       removed =3D fuse_uring_remove_pending_req(
> +                               req, fuse_remove_pending_req);
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
> index ebd2931b4f2acac461091b6b1f1176cde759e2d1..0d7fe8d6d2bf214b38bc90f6a=
7a9b4840219a81c 100644
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
> @@ -1306,6 +1306,15 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>         return true;
>  }
>
> +bool fuse_uring_remove_pending_req(struct fuse_req *req,
> +                                  bool (*remove_fn)(struct fuse_req *req=
,
> +                                                    spinlock_t *lock))

nit: indentation should be aligned here?

> +{
> +       struct fuse_ring_queue *queue =3D req->ring_queue;
> +
> +       return remove_fn(req, &queue->lock);
> +}
> +
>  static const struct fuse_iqueue_ops fuse_io_uring_ops =3D {
>         /* should be send over io-uring as enhancement */
>         .send_forget =3D fuse_dev_queue_forget,
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 2102b3d0c1aed1105e9c1200c91e1cb497b9a597..89a1da485b0e06fc6096f9b34=
3dc0855c5df9c0b 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -142,6 +142,9 @@ void fuse_uring_abort_end_requests(struct fuse_ring *=
ring);
>  int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req =
*req);
>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
> +bool fuse_uring_remove_pending_req(struct fuse_req *req,
> +                                  bool (*remove_fn)(struct fuse_req *req=
,
> +                                                    spinlock_t *lock));

nit: indentation needs to be aligned here?

>
>  static inline void fuse_uring_abort(struct fuse_conn *fc)
>  {
> @@ -200,6 +203,13 @@ static inline bool fuse_uring_ready(struct fuse_conn=
 *fc)
>         return false;
>  }
>
> +static inline bool fuse_uring_remove_pending_req(
> +       struct fuse_req *req,
> +       bool (*remove_fn)(struct fuse_req *req, spinlock_t *lock))
> +{
> +       return false;
> +}
> +
>  #endif /* CONFIG_FUSE_IO_URING */
>
>  #endif /* _FS_FUSE_DEV_URING_I_H */
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index fee96fe7887b30cd57b8a6bbda11447a228cf446..5428a5b5e16a880894142f0ec=
1176a349c9469dc 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -392,6 +392,7 @@ enum fuse_req_flag {
>         FR_FINISHED,
>         FR_PRIVATE,
>         FR_ASYNC,
> +       FR_URING,
>  };
>
>  /**
> @@ -441,6 +442,7 @@ struct fuse_req {
>
>  #ifdef CONFIG_FUSE_IO_URING
>         void *ring_entry;
> +       void *ring_queue;
>  #endif
>  };
>
>
> --
> 2.43.0
>

