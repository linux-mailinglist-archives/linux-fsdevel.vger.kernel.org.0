Return-Path: <linux-fsdevel+bounces-64221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C43BDDBAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008F119C1D7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13093191B7;
	Wed, 15 Oct 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rRafDthF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040131815D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519999; cv=none; b=A0r8xLobIjXQ0lcIlKCGncJpdn6MbzXiBfRDyo7/TJWKSjDVSJiNV9L6FUpIxeISU0j61rX/zlGntrqokDKLZLBcNky/f9ACeDY0ZuNphkCce9b63od+1ZwguXIV+LJnMxeiSf7nMcnX4oo1L7nolNpIhlhBF1tNT0mKG9rO+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519999; c=relaxed/simple;
	bh=JVRj22Ng3b1eVxQJcCY9mMBaJL9GhhjXfZw1V8afc4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugsRbPyRg3hlfbvduqdr5PLLpwtb41lXXZSn0+UcggoxILDdsSf/TA/9WI2ZQJJNrl+OPhfTlxem5EXdlGRpqG5LOOnHWgTdKmiR2TRBPKZfhEspZHo8XEJjUB18ehkMTD6vPS05XdMDbPw5jYS1dYJmkL2R0hV0c7Fg0JiaI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rRafDthF; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S8nb+I8tRGGYs4piz+KpoE6jt9X0wrxDJ0ZgzR8knnc=; b=rRafDthF/8zlM/yyA23IRXvc5m
	TlS+3TUtCMfRKtmXilIzjBtAsUFXr5riMYg94cT/EP/bknduZ1pOxbTWBDOWCsFAJ6TDgA5i1bJWS
	P7d6rNBxDsOUBE2DeGdhn0uFCBSBYnXvL5sS0N+9qWGX1JnRRbcA9AHM2uLKqsrOrh3VDpnl1bo3C
	XPiVVuWIAxQNBwFRAR80r0m2WlUZmkOIU8BtpnVh4XckYEmViXHLgO+rWgwkBnR1+h47Impuk5X9h
	uCvrkLt8brigaldlgkPkG+ZEDIS0x2tf5zIYsbnSznnBtjojY6oMUL6mLwEkkna+9bc9swbpFYWVW
	+ZCBusXQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8xfj-009rsc-94; Wed, 15 Oct 2025 11:19:51 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Joanne Koong
 <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org,  Gang He
 <dchg2000@gmail.com>
Subject: Re: [PATCH v3 1/6] fuse: {io-uring} Add queue length counters
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-1-6d87c8aa31ae@ddn.com>
	(Bernd Schubert's message of "Mon, 13 Oct 2025 19:09:57 +0200")
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
	<20251013-reduced-nr-ring-queues_3-v3-1-6d87c8aa31ae@ddn.com>
Date: Wed, 15 Oct 2025 10:19:50 +0100
Message-ID: <87sefk8qtl.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13 2025, Bernd Schubert wrote:

> This is another preparation and will be used for decision
> which queue to add a request to.

Just a very small nit: "This is another preparation..." -- this is the
first patch in the series, so it makes more sense to have this sentence in
the second patch instead.  I guess the patches got reordered at some point
and the wording didn't got updated accordingly.

Cheers,
--=20
Lu=C3=ADs

>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c   | 17 +++++++++++++++--
>  fs/fuse/dev_uring_i.h |  3 +++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index f6b12aebb8bbe7d255980593b75b5fb5af9c669e..872ae17ffaf49a30c46ef89c1=
668684a61a0cce4 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -86,13 +86,13 @@ static void fuse_uring_req_end(struct fuse_ring_ent *=
ent, struct fuse_req *req,
>  	lockdep_assert_not_held(&queue->lock);
>  	spin_lock(&queue->lock);
>  	ent->fuse_req =3D NULL;
> +	queue->nr_reqs--;
>  	if (test_bit(FR_BACKGROUND, &req->flags)) {
>  		queue->active_background--;
>  		spin_lock(&fc->bg_lock);
>  		fuse_uring_flush_bg(queue);
>  		spin_unlock(&fc->bg_lock);
>  	}
> -
>  	spin_unlock(&queue->lock);
>=20=20
>  	if (error)
> @@ -112,6 +112,7 @@ static void fuse_uring_abort_end_queue_requests(struc=
t fuse_ring_queue *queue)
>  	list_for_each_entry(req, &queue->fuse_req_queue, list)
>  		clear_bit(FR_PENDING, &req->flags);
>  	list_splice_init(&queue->fuse_req_queue, &req_list);
> +	queue->nr_reqs =3D 0;
>  	spin_unlock(&queue->lock);
>=20=20
>  	/* must not hold queue lock to avoid order issues with fi->lock */
> @@ -1280,10 +1281,13 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue=
 *fiq, struct fuse_req *req)
>  	req->ring_queue =3D queue;
>  	ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
>  				       struct fuse_ring_ent, list);
> +	queue->nr_reqs++;
> +
>  	if (ent)
>  		fuse_uring_add_req_to_ring_ent(ent, req);
>  	else
>  		list_add_tail(&req->list, &queue->fuse_req_queue);
> +
>  	spin_unlock(&queue->lock);
>=20=20
>  	if (ent)
> @@ -1319,6 +1323,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  	set_bit(FR_URING, &req->flags);
>  	req->ring_queue =3D queue;
>  	list_add_tail(&req->list, &queue->fuse_req_bg_queue);
> +	queue->nr_reqs++;
>=20=20
>  	ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
>  				       struct fuse_ring_ent, list);
> @@ -1351,8 +1356,16 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  bool fuse_uring_remove_pending_req(struct fuse_req *req)
>  {
>  	struct fuse_ring_queue *queue =3D req->ring_queue;
> +	bool removed =3D fuse_remove_pending_req(req, &queue->lock);
>=20=20
> -	return fuse_remove_pending_req(req, &queue->lock);
> +	if (removed) {
> +		/* Update counters after successful removal */
> +		spin_lock(&queue->lock);
> +		queue->nr_reqs--;
> +		spin_unlock(&queue->lock);
> +	}
> +
> +	return removed;
>  }
>=20=20
>  static const struct fuse_iqueue_ops fuse_io_uring_ops =3D {
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce14158904a86c248c77767be4fe5ae..c63bed9f863d53d4ac2bed7bf=
bda61941cd99083 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -94,6 +94,9 @@ struct fuse_ring_queue {
>  	/* background fuse requests */
>  	struct list_head fuse_req_bg_queue;
>=20=20
> +	/* number of requests queued or in userspace */
> +	unsigned int nr_reqs;
> +
>  	struct fuse_pqueue fpq;
>=20=20
>  	unsigned int active_background;
>
> --=20
> 2.43.0
>


