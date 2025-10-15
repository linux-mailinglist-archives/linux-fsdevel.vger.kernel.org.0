Return-Path: <linux-fsdevel+bounces-64222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDAABDDC41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36EC9502C74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D642D73B2;
	Wed, 15 Oct 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V9ohWjja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8D31AF15
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520368; cv=none; b=eJ8+lTGH8eOKt5+cW6uTmSgJ1Hl0xAnBKlKlZ8ImArW6gnq7OCUNsLdmYKSoW3GBmxRtUtYGh8RqF6ESzx0HqWfX6SugTB5tZhd9MHKpVAoV8k2uEdS2UiWJ9L6XzyYSGEqUPUXxsEe1OT26hnSmU/aCKGk5ys5M1kQp0j2fI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520368; c=relaxed/simple;
	bh=wmRWh5whxzJ7yjpUdzzPZC4rLY8NUcqaVDhlg75v1ak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OlaorJWflAMAYpBW6Vvmj0L99xvwGc/XxRwP2Kg2sXKhbsPBUCL6IY24cixdumGCsXoH8pYdQmdIEfbMy7LExuDdauw5fHDSvfKHfdf+3vI19Y3lamf2sEHG6gapU++rOAojPO/T4IKdzzKRUekfgm/DAF+mUOnxnmv8HOk595g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=V9ohWjja; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lb9I5AX0cwbq/TwrWZghI2AJjaDVcFACYB3lLeQQ3NM=; b=V9ohWjjaswKTW7/ZyKiB3ysXVR
	MzLEgKE+8bZA0ezB93bOh3IHQYsiiz8m3jOcZNVvTVO+luBaJKokxyo+6TWmxsjAGV+S5adCZjIqS
	61sFPikyB66mqJTSKj6269ww3e/avtMT/6SkynjSaDovJe26TMhFfVxNDIm89EMrDbx1fuy/BKUiO
	TohQ1wLchyjQa5/HXP2fciadcyWensnVtmNkn6dbTS6GOwtM+Rx9tmNBX6KUq8QFoPdeUbZ48joJu
	75cDyHtCZ/X9zFUb5kpJTZefFhhfVQXdy7on7/JuaDrx+YWEL8A0frBL2V5tbgnfTyxanoycwf5qw
	WrZYhFMw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8xle-009s45-02; Wed, 15 Oct 2025 11:25:58 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Joanne Koong
 <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org,  Gang He
 <dchg2000@gmail.com>
Subject: Re: [PATCH v3 5/6] fuse: {io-uring} Allow reduced number of ring
 queues
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-5-6d87c8aa31ae@ddn.com>
	(Bernd Schubert's message of "Mon, 13 Oct 2025 19:10:01 +0200")
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
	<20251013-reduced-nr-ring-queues_3-v3-5-6d87c8aa31ae@ddn.com>
Date: Wed, 15 Oct 2025 10:25:57 +0100
Message-ID: <87o6q88qje.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13 2025, Bernd Schubert wrote:

> Queues selection (fuse_uring_get_queue) can handle reduced number
> queues - using io-uring is possible now even with a single
> queue and entry.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c       | 35 +++--------------------------------
>  fs/fuse/inode.c           |  2 +-
>  include/uapi/linux/fuse.h |  3 +++
>  3 files changed, 7 insertions(+), 33 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 92401adecf813b1c4570d925718be772c8f02975..aca71ce5632efd1d80e3ac0ad=
4e81ac1536dbc47 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -999,31 +999,6 @@ static int fuse_uring_commit_fetch(struct io_uring_c=
md *cmd, int issue_flags,
>  	return 0;
>  }
>=20=20
> -static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
> -{
> -	int qid;
> -	struct fuse_ring_queue *queue;
> -	bool ready =3D true;
> -
> -	for (qid =3D 0; qid < ring->max_nr_queues && ready; qid++) {
> -		if (current_qid =3D=3D qid)
> -			continue;
> -
> -		queue =3D ring->queues[qid];
> -		if (!queue) {
> -			ready =3D false;
> -			break;
> -		}
> -
> -		spin_lock(&queue->lock);
> -		if (list_empty(&queue->ent_avail_queue))
> -			ready =3D false;
> -		spin_unlock(&queue->lock);
> -	}
> -
> -	return ready;
> -}
> -
>  /*
>   * fuse_uring_req_fetch command handling
>   */
> @@ -1051,13 +1026,9 @@ static void fuse_uring_do_register(struct fuse_rin=
g_ent *ent,
>  	cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
>=20=20
>  	if (!ring->ready) {
> -		bool ready =3D is_ring_ready(ring, queue->qid);
> -
> -		if (ready) {
> -			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
> -			WRITE_ONCE(ring->ready, true);
> -			wake_up_all(&fc->blocked_waitq);
> -		}
> +		WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
> +		WRITE_ONCE(ring->ready, true);
> +		wake_up_all(&fc->blocked_waitq);
>  	}
>  }
>=20=20
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index d1babf56f25470fcc08fe400467b3450e8b7464a..3f97cc307b4d77e1233418073=
1589c579b2eb7a2 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1503,7 +1503,7 @@ static struct fuse_init_args *fuse_new_init(struct =
fuse_mount *fm)
>  		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
>  		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
>  		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
> -		FUSE_REQUEST_TIMEOUT;
> +		FUSE_REQUEST_TIMEOUT | FUSE_URING_REDUCED_Q;
>  #ifdef CONFIG_FUSE_DAX
>  	if (fm->fc->dax)
>  		flags |=3D FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12bd39f535188cb5466688eba42263..3da20d9bba1cb6336734511d2=
1da9f64cea0e720 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -448,6 +448,8 @@ struct fuse_file_lock {
>   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
>   * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
>   *			 init_out.request_timeout contains the timeout (in secs)
> + * FUSE_URING_REDUCED_Q: Client (kernel) supports less queues - Server i=
s free
> + *			 to register between 1 and nr-core io-uring queues
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -495,6 +497,7 @@ struct fuse_file_lock {
>  #define FUSE_ALLOW_IDMAP	(1ULL << 40)
>  #define FUSE_OVER_IO_URING	(1ULL << 41)
>  #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
> +#define FUSE_URING_REDUCED_Q (1ULL << 43)

This flag doesn't seem to be used anywhere.  Should it be removed, or will
there be any usage for it?

Cheers,
--=20
Lu=C3=ADs


>  /**
>   * CUSE INIT request/reply flags
>
> --=20
> 2.43.0
>


