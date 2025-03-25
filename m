Return-Path: <linux-fsdevel+bounces-45050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B5A70C48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 22:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0E83BA5D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 21:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF68266B51;
	Tue, 25 Mar 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Y+lyv+MS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8891EFFBE
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938728; cv=none; b=SSz+9qxODPW8GMwmYIEf15xfP5wShYHMFhNTDrk7XIlITbc4lWrZKdmZCAyDoF/370smqR+eP5M1emJphdMrHRhr39x5wJ1smfGNJOlqPOotJipJJyXTZ5PUUJYxBBMdSVOYZP9+hGPHskUVsEN+WWaZYIM5oABuz7go7iNvDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938728; c=relaxed/simple;
	bh=98vqhO8sXkvKvJ4f1HJ7FnAm8vikwLD5oA9mdBWvfx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uGzw+/P8Xee1QrdiMDkMnZSoLshnZ44FABoTqpy6/Y9Ti7R1UXGHt6Ul1Q2EbiuEmnMHaAQWmuNlQLRVpGcual42z9XoRRE6SKj0dJer3YNXK8FTC5EjCUfP8U4mWHiUaectsyHI1XKRJLlcxLN/oBl2f0MBme1Swp1XO6BBSbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Y+lyv+MS; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QxaObqNfPJ5Wz+Rlt3maSnAFrBVObLh+Tr9POChNNq4=; b=Y+lyv+MSIrHZ4eDhYXYH8REbiK
	5Lae5KgraOLt0s+rxf32W+aDBy6MpWpTMac7Xrx65tT3s1be2mu9Vh0AHhYaenwxgL9ARkg7i/0kp
	w4qjeZs1O5qDnnXlRPiVdSqpQL/T8PuVJbkb5v3qDZUYHvikHHK8JW2DunvuZSB1lkRTFSssBfVKT
	u2BcVomeBTmh+78ZszipJA1jCUfOyHs5SfxJFsqhy4sOWCwzJRaoPQuvJlUx5FheeXqVZUk0VUuCV
	XdKXKBUe6M4SDkkjY1hXk96kdf2KbExs65cZOOXNw7rvmAlDzmbYw1tQm1e9sbSVJrseHGD2wX5nc
	EzVGCsvg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1txByj-006KKJ-Pu; Tue, 25 Mar 2025 22:38:33 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Joanne Koong
 <joannelkoong@gmail.com>,  Jeff Layton <jlayton@kernel.org>,
  linux-fsdevel@vger.kernel.org,  Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH v2] fuse: {io-uring} Fix a possible req cancellation race
In-Reply-To: <20250325-fr_pending-race-v2-1-487945a6c197@ddn.com> (Bernd
	Schubert's message of "Tue, 25 Mar 2025 18:29:31 +0100")
References: <20250325-fr_pending-race-v2-1-487945a6c197@ddn.com>
Date: Tue, 25 Mar 2025 21:38:33 +0000
Message-ID: <87pli4u6xy.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bernd!

On Tue, Mar 25 2025, Bernd Schubert wrote:

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

At first, this patch looked OK to me.  However, after looking closer, I'm
not sure if this doesn't break fuse_abort_conn().  Because that function
assumes it is safe to walk through all the requests using fiq->lock, it
could race against fuse_uring_remove_pending_req(), which uses queue->lock
instead.  Am I missing something (quite likely!), or does fuse_abort_conn()
also needs to be modified?

[ Another scenario that is not problematic, but that could become messy in
  the future is if we want to add support for the FUSE_NOTIFY_RESEND
  operation through uring.  Obviously, that's not an issue right now, but
  this patch probably will make it harder to add that support. ]

Cheers,
--=20
Lu=C3=ADs

> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Reported-by: Joanne Koong <joannelkoong@gmail.com>
> Closes: https://lore.kernel.org/all/CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=3Dm-=
zF0ZoLXKLUHRjNTw@mail.gmail.com/
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
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
>  	return 0;
>  }
>=20=20
> +bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
> +{
> +	spin_lock(lock);
> +	if (test_bit(FR_PENDING, &req->flags)) {
> +		/*
> +		 * FR_PENDING does not get cleared as the request will end
> +		 * up in destruction anyway.
> +		 */
> +		list_del(&req->list);
> +		spin_unlock(lock);
> +		__fuse_put_request(req);
> +		req->out.h.error =3D -EINTR;
> +		return true;
> +	}
> +	spin_unlock(lock);
> +	return false;
> +}
> +
>  static void request_wait_answer(struct fuse_req *req)
>  {
>  	struct fuse_conn *fc =3D req->fm->fc;
> @@ -428,22 +446,20 @@ static void request_wait_answer(struct fuse_req *re=
q)
>  	}
>=20=20
>  	if (!test_bit(FR_FORCE, &req->flags)) {
> +		bool removed;
> +
>  		/* Only fatal signals may interrupt this */
>  		err =3D wait_event_killable(req->waitq,
>  					test_bit(FR_FINISHED, &req->flags));
>  		if (!err)
>  			return;
>=20=20
> -		spin_lock(&fiq->lock);
> -		/* Request is not yet in userspace, bail out */
> -		if (test_bit(FR_PENDING, &req->flags)) {
> -			list_del(&req->list);
> -			spin_unlock(&fiq->lock);
> -			__fuse_put_request(req);
> -			req->out.h.error =3D -EINTR;
> +		if (test_bit(FR_URING, &req->flags))
> +			removed =3D fuse_uring_remove_pending_req(req);
> +		else
> +			removed =3D fuse_remove_pending_req(req, &fiq->lock);
> +		if (removed)
>  			return;
> -		}
> -		spin_unlock(&fiq->lock);
>  	}
>=20=20
>  	/*
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ebd2931b4f2acac461091b6b1f1176cde759e2d1..add7273c8dc4a23a23e50b879=
db470fc06bd3d20 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -726,8 +726,6 @@ static void fuse_uring_add_req_to_ring_ent(struct fus=
e_ring_ent *ent,
>  					   struct fuse_req *req)
>  {
>  	struct fuse_ring_queue *queue =3D ent->queue;
> -	struct fuse_conn *fc =3D req->fm->fc;
> -	struct fuse_iqueue *fiq =3D &fc->iq;
>=20=20
>  	lockdep_assert_held(&queue->lock);
>=20=20
> @@ -737,9 +735,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fus=
e_ring_ent *ent,
>  			ent->state);
>  	}
>=20=20
> -	spin_lock(&fiq->lock);
>  	clear_bit(FR_PENDING, &req->flags);
> -	spin_unlock(&fiq->lock);
>  	ent->fuse_req =3D req;
>  	ent->state =3D FRRS_FUSE_REQ;
>  	list_move(&ent->list, &queue->ent_w_req_queue);
> @@ -1238,6 +1234,8 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>  	if (unlikely(queue->stopped))
>  		goto err_unlock;
>=20=20
> +	set_bit(FR_URING, &req->flags);
> +	req->ring_queue =3D queue;
>  	ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
>  				       struct fuse_ring_ent, list);
>  	if (ent)
> @@ -1276,6 +1274,8 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  		return false;
>  	}
>=20=20
> +	set_bit(FR_URING, &req->flags);
> +	req->ring_queue =3D queue;
>  	list_add_tail(&req->list, &queue->fuse_req_bg_queue);
>=20=20
>  	ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
> @@ -1306,6 +1306,13 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  	return true;
>  }
>=20=20
> +bool fuse_uring_remove_pending_req(struct fuse_req *req)
> +{
> +	struct fuse_ring_queue *queue =3D req->ring_queue;
> +
> +	return fuse_remove_pending_req(req, &queue->lock);
> +}
> +
>  static const struct fuse_iqueue_ops fuse_io_uring_ops =3D {
>  	/* should be send over io-uring as enhancement */
>  	.send_forget =3D fuse_dev_queue_forget,
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
>=20=20
>  static inline void fuse_uring_abort(struct fuse_conn *fc)
>  {
> @@ -200,6 +201,11 @@ static inline bool fuse_uring_ready(struct fuse_conn=
 *fc)
>  	return false;
>  }
>=20=20
> +static inline bool fuse_uring_remove_pending_req(struct fuse_req *req)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_FUSE_IO_URING */
>=20=20
>  #endif /* _FS_FUSE_DEV_URING_I_H */
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 3b2bfe1248d3573abe3b144a6d4bf6a502f56a40..2481da3388c5feec944143bfa=
bb8d430a447d322 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -61,6 +61,7 @@ int fuse_copy_out_args(struct fuse_copy_state *cs, stru=
ct fuse_args *args,
>  void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
>  			   struct fuse_forget_link *forget);
>  void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *=
req);
> +bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock);
>=20=20
>  #endif
>=20=20
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index fee96fe7887b30cd57b8a6bbda11447a228cf446..2086dac7243ba82e1ce6762e2=
d1406014566aaaa 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -378,6 +378,7 @@ struct fuse_io_priv {
>   * FR_FINISHED:		request is finished
>   * FR_PRIVATE:		request is on private list
>   * FR_ASYNC:		request is asynchronous
> + * FR_URING:		request is handled through fuse-io-uring
>   */
>  enum fuse_req_flag {
>  	FR_ISREPLY,
> @@ -392,6 +393,7 @@ enum fuse_req_flag {
>  	FR_FINISHED,
>  	FR_PRIVATE,
>  	FR_ASYNC,
> +	FR_URING,
>  };
>=20=20
>  /**
> @@ -441,6 +443,7 @@ struct fuse_req {
>=20=20
>  #ifdef CONFIG_FUSE_IO_URING
>  	void *ring_entry;
> +	void *ring_queue;
>  #endif
>  };
>=20=20
>
> ---
> base-commit: 81e4f8d68c66da301bb881862735bd74c6241a19
> change-id: 20250218-fr_pending-race-3e362f22f319
>
> Best regards,
> --=20
> Bernd Schubert <bschubert@ddn.com>
>


