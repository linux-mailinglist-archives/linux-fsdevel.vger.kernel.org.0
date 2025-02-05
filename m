Return-Path: <linux-fsdevel+bounces-40929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A64EA29553
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA777A1DA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10191917D6;
	Wed,  5 Feb 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd8BZXk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF6154C1D
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770826; cv=none; b=ePRFiJ6MuNSbMNs8zX3M5nEW68/LWf8OEnTGfa85b03COw2aNtNaDew0QMKfaF76tc8K6fQJct1GGb7RnYGqPguerZVZPF5fVFpdiR/+NMLFrJ2izdYjPJEkSazOvCyCYm+xZwJ/d11e2nrvVKXp0W+2hrdvpYd+CBvRefKufTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770826; c=relaxed/simple;
	bh=SwXpm1zZ5lHPwRmGArQ9jHaPNOfssiLr2y2LbaDQg/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XetdX6lyWaRCjj6fwudpvxhs6U3IPU3mUJHCQKinQkMbm+JIQJ8kytbXVxNOjEqtwdsdS8+6x8uXE+OqUXQmMSS+IKj9UMO+GA3+zztKj0ybNDL7YpMJ19+OWBelRPvMNt6zMovjG6Qq9rAE95o6grN2Psm3xjZM55NkIXpGlWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd8BZXk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41626C4CED1;
	Wed,  5 Feb 2025 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738770825;
	bh=SwXpm1zZ5lHPwRmGArQ9jHaPNOfssiLr2y2LbaDQg/w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bd8BZXk2L/YeIGJjbVU0R+TY6Lro7CICJk4R0t1ARROQCLrWNKCcN35LoWwnIVmC6
	 3lyk+gMnPTcsH9Bxm/yWpf3QkOyPEFaTqxIq//ktaTD5UkWERfXQ52Eqw72aKOnn9z
	 b1VG+NrSIhsr28Z7/T9+itVysIUZttgQ/XipMu7bEX25gMeSH44EOfRPpC+D0CNmuG
	 EjfYS7uDiYIzCmMuPjBBYNmq6+1ssJNUz0HfrwjCjGet527jotW55Q8zL4wPPkML4N
	 qoAOvRtUrX80V+pj6DSGM+ZRTiQFTV5/2mTzsIMB1pDxn44ybqwafem2mSumUHSybs
	 +TQXAKg4llxOA==
Message-ID: <7822667d74f4cb748ff207857da9138887a19611.camel@kernel.org>
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for
 uring requests
From: Jeff Layton <jlayton@kernel.org>
To: Bernd Schubert <bernd.schubert@fastmail.fm>, Joanne Koong
	 <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Date: Wed, 05 Feb 2025 10:53:44 -0500
In-Reply-To: <e3da9d0c-39df-4994-91d2-a90b9ec7c627@fastmail.fm>
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
	 <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm>
	 <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
	 <74a5f0ea-e7dc-440b-82c6-5755dea98fa4@fastmail.fm>
	 <CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com>
	 <bc801a5c-8150-4b6c-b7b6-b587d556d99b@fastmail.fm>
	 <e3da9d0c-39df-4994-91d2-a90b9ec7c627@fastmail.fm>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 22:31 +0100, Bernd Schubert wrote:
> fuse: {io-uring} Fix a possible req cancellation race
>=20
> From: Bernd Schubert <bschubert@ddn.com>
>=20
> task-A (application) might be in request_wait_answer and
> try to remove the request when it has FR_PENDING set.
>=20
> task-B (a fuse-server io-uring task) might handle this
> request with FUSE_IO_URING_CMD_COMMIT_AND_FETCH, when
> fetching the next request and accessed the req from
> the pending list in fuse_uring_ent_assign_req().
> That code path was not protected by fiq->lock and so
> might race with task-A.
>=20
> For scaling reasons we better don't use fiq->lock, but
> add a handler to remove canceled requests from the queue.
>=20
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Reported-by: Joanne Koong <joannelkoong@gmail.com>
> Closes: https://lore.kernel.org/all/CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=3Dm-=
zF0ZoLXKLUHRjNTw@mail.gmail.com/
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>=20
> --
> Compilation tested only
> ---
> =C2=A0fs/fuse/dev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 25 ++++++++++++++++---------
> =C2=A0fs/fuse/dev_uring.c=C2=A0=C2=A0 |=C2=A0=C2=A0 25 ++++++++++++++++++=
+++----
> =C2=A0fs/fuse/dev_uring_i.h |=C2=A0=C2=A0=C2=A0 6 ++++++
> =C2=A0fs/fuse/fuse_dev_i.h=C2=A0 |=C2=A0=C2=A0=C2=A0 2 ++
> =C2=A0fs/fuse/fuse_i.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 =
2 ++
> =C2=A05 files changed, 47 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 80a11ef4b69a..0494ea47893a 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -157,7 +157,7 @@ static void __fuse_get_request(struct fuse_req *req)
> =C2=A0}
> =C2=A0
> =C2=A0/* Must be called with > 1 refcount */
> -static void __fuse_put_request(struct fuse_req *req)
> +void __fuse_put_request(struct fuse_req *req)
> =C2=A0{
> =C2=A0	refcount_dec(&req->count);
> =C2=A0}
> @@ -529,16 +529,23 @@ static void request_wait_answer(struct fuse_req *re=
q)
> =C2=A0		if (!err)
> =C2=A0			return;
> =C2=A0
> -		spin_lock(&fiq->lock);
> -		/* Request is not yet in userspace, bail out */
> -		if (test_bit(FR_PENDING, &req->flags)) {
> -			list_del(&req->list);
> +		if (test_bit(FR_URING, &req->flags)) {
> +			bool removed =3D fuse_uring_remove_pending_req(req);
> +
> +			if (removed)
> +				return;
> +		} else {
> +			spin_lock(&fiq->lock);
> +			/* Request is not yet in userspace, bail out */
> +			if (test_bit(FR_PENDING, &req->flags)) {
> +				list_del(&req->list);
> +				spin_unlock(&fiq->lock);
> +				__fuse_put_request(req);
> +				req->out.h.error =3D -EINTR;
> +				return;
> +			}

One thing that bothers me with the existing code and this patch is that
the semantics around FR_PENDING are unclear.

I know it's supposed to mean that the req is waiting for userland to
read it, but in the above case for instance, we're removing it from the
list and dropping its refcount while leaving the bit set. Shouldn't we
clear it there and in fuse_uring_remove_pending_req()?

=20
> =C2=A0			spin_unlock(&fiq->lock);
> -			__fuse_put_request(req);
> -			req->out.h.error =3D -EINTR;
> -			return;
> =C2=A0		}
> -		spin_unlock(&fiq->lock);
> =C2=A0	}
> =C2=A0
> =C2=A0	/*
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 1e2bceb4ff1e..f9abdcf5f7e6 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -771,8 +771,6 @@ static void fuse_uring_add_req_to_ring_ent(struct fus=
e_ring_ent *ent,
> =C2=A0					=C2=A0=C2=A0 struct fuse_req *req)
> =C2=A0{
> =C2=A0	struct fuse_ring_queue *queue =3D ent->queue;
> -	struct fuse_conn *fc =3D req->fm->fc;
> -	struct fuse_iqueue *fiq =3D &fc->iq;
> =C2=A0
> =C2=A0	lockdep_assert_held(&queue->lock);
> =C2=A0
> @@ -782,9 +780,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fus=
e_ring_ent *ent,
> =C2=A0			ent->state);
> =C2=A0	}
> =C2=A0
> -	spin_lock(&fiq->lock);
> =C2=A0	clear_bit(FR_PENDING, &req->flags);
> -	spin_unlock(&fiq->lock);
> =C2=A0	ent->fuse_req =3D req;
> =C2=A0	ent->state =3D FRRS_FUSE_REQ;
> =C2=A0	list_move_tail(&ent->list, &queue->ent_w_req_queue);
> @@ -1285,6 +1281,8 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
> =C2=A0	if (unlikely(queue->stopped))
> =C2=A0		goto err_unlock;
> =C2=A0
> +	set_bit(FR_URING, &req->flags);
> +	req->ring_queue =3D queue;
> =C2=A0	ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fuse_ring_ent, list=
);
> =C2=A0	if (ent)
> @@ -1323,6 +1321,8 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
> =C2=A0		return false;
> =C2=A0	}
> =C2=A0
> +	set_bit(FR_URING, &req->flags);
> +	req->ring_queue =3D queue;
> =C2=A0	list_add_tail(&req->list, &queue->fuse_req_bg_queue);
> =C2=A0
> =C2=A0	ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
> @@ -1353,6 +1353,23 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
> =C2=A0	return true;
> =C2=A0}
> =C2=A0
> +bool fuse_uring_remove_pending_req(struct fuse_req *req)
> +{
> +	struct fuse_ring_queue *queue =3D req->ring_queue;
> +
> +	spin_lock(&queue->lock);
> +	if (test_bit(FR_PENDING, &req->flags)) {
> +		list_del(&req->list);
> +		spin_unlock(&queue->lock);
> +		__fuse_put_request(req);
> +		req->out.h.error =3D -EINTR;
> +		return true;
> +	}
> +	spin_unlock(&queue->lock);
> +
> +	return false;
> +}
> +
> =C2=A0static const struct fuse_iqueue_ops fuse_io_uring_ops =3D {
> =C2=A0	/* should be send over io-uring as enhancement */
> =C2=A0	.send_forget =3D fuse_dev_queue_forget,
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index a37991d17d34..86071758628f 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -143,6 +143,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned=
 int issue_flags);
> =C2=A0void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse=
_req *req);
> =C2=A0bool fuse_uring_queue_bq_req(struct fuse_req *req);
> =C2=A0bool fuse_uring_request_expired(struct fuse_conn *fc);
> +bool fuse_uring_remove_pending_req(struct fuse_req *req);
> =C2=A0
> =C2=A0static inline void fuse_uring_abort(struct fuse_conn *fc)
> =C2=A0{
> @@ -206,6 +207,11 @@ static inline bool fuse_uring_request_expired(struct=
 fuse_conn *fc)
> =C2=A0	return false;
> =C2=A0}
> =C2=A0
> +static inline bool fuse_uring_remove_pending_req(struct fuse_req *req)
> +{
> +	return false;
> +}
> +
> =C2=A0#endif /* CONFIG_FUSE_IO_URING */
> =C2=A0
> =C2=A0#endif /* _FS_FUSE_DEV_URING_I_H */
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 19c29c6000a7..36b9092061ea 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -49,6 +49,8 @@ static inline struct fuse_dev *fuse_get_dev(struct file=
 *file)
> =C2=A0unsigned int fuse_req_hash(u64 unique);
> =C2=A0struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 uni=
que);
> =C2=A0
> +void __fuse_put_request(struct fuse_req *req);
> +
> =C2=A0void fuse_dev_end_requests(struct list_head *head);
> =C2=A0
> =C2=A0void fuse_copy_init(struct fuse_copy_state *cs, int write,
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index dcc1c327a057..29a7a6e57577 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -408,6 +408,7 @@ enum fuse_req_flag {
> =C2=A0	FR_FINISHED,
> =C2=A0	FR_PRIVATE,
> =C2=A0	FR_ASYNC,
> +	FR_URING,
> =C2=A0};
> =C2=A0
> =C2=A0/**
> @@ -457,6 +458,7 @@ struct fuse_req {
> =C2=A0
> =C2=A0#ifdef CONFIG_FUSE_IO_URING
> =C2=A0	void *ring_entry;
> +	void *ring_queue;
> =C2=A0#endif
> =C2=A0	/** When (in jiffies) the request was created */
> =C2=A0	unsigned long create_time;

--=20
Jeff Layton <jlayton@kernel.org>

