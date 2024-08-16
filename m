Return-Path: <linux-fsdevel+bounces-26140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5D954EC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7FDB21AD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD35817;
	Fri, 16 Aug 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJZYPmbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBFC1AD9E2
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825635; cv=none; b=B1DzTort7v3Po0eHXEjLNMew5fXrUQUYZYVp1Le+GQeynAHegdyHQh/HCYnP5vbx+Fd7NGbJE/U0KJr3nKsxYFW1RKDNwAA5d75y7QEZBdmryScRfCsX2BRp54/K8/9y4oU5Y/QGUNLHcwxxyc6e10OTBTCgsd5fquQvmcWKJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825635; c=relaxed/simple;
	bh=/a5MarQ6r57ztjCRXP1409/anmb2uXZhHmGhszR7d+M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Y03fcVUAVZwvTi6hM/a8AJoJOg9mgQCoGNu+XMZ+TjFWX7urwyZAZIMLkNLPkOQyKOActtsTxYh6ngPbmLN4zdMVewzWsR4NuK9wY2jMLyhs14K3Yw7MOtJ7YP//srffIFP6ivkyoLMV4OXfUQ1aT7my1aVkN1ATA8H+dlp+2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJZYPmbi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723825633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezA2OXHYLd1IDVStpnIMK607RWjOjthXD5oJVhBUVCk=;
	b=HJZYPmbigI30KqsM+B/ueJqaHH96UyE/wICW3g81AxEz87zG88pvJHesMCaey6cbC81H7X
	vLqeDBvfNw3h6+KyYVEjeCxEZp5WAcTQ9IuP78I3NP9XYZOITxCjRs/mkg59oZDBQ4jfgK
	OaaT8ZRFwr6ZDtwJXB8W2+Ci6p60ph0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-NDq4FZKMO0uoITOEPUQ1Bw-1; Fri,
 16 Aug 2024 12:27:09 -0400
X-MC-Unique: NDq4FZKMO0uoITOEPUQ1Bw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D51EB19560AD;
	Fri, 16 Aug 2024 16:27:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 192A93001FE5;
	Fri, 16 Aug 2024 16:27:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
References: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
    Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] inode: remove __I_DIO_WAKEUP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2834954.1723825625.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2024 17:27:05 +0100
Message-ID: <2834955.1723825625@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

cc'ing Christoph as he did the original (bd5fe6c5eb9c5).

Christian Brauner <brauner@kernel.org> wrote:

> Afaict, we can just rely on inode->i_dio_count for waiting instead of
> this awkward indirection through __I_DIO_WAKEUP. This survives LTP dio
> and xfstests dio tests.
> =

> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> ---
>  fs/inode.c         | 23 +++++++++++------------
>  fs/netfs/locking.c | 18 +++---------------
>  include/linux/fs.h |  9 ++++-----
>  3 files changed, 18 insertions(+), 32 deletions(-)
> =

> diff --git a/fs/inode.c b/fs/inode.c
> index 7a4e27606fca..46bf05d826db 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2465,18 +2465,12 @@ EXPORT_SYMBOL(inode_owner_or_capable);
>  /*
>   * Direct i/o helper functions
>   */
> -static void __inode_dio_wait(struct inode *inode)
> +bool inode_dio_finished(const struct inode *inode)
>  {
> -	wait_queue_head_t *wq =3D bit_waitqueue(&inode->i_state, __I_DIO_WAKEU=
P);
> -	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
> -
> -	do {
> -		prepare_to_wait(wq, &q.wq_entry, TASK_UNINTERRUPTIBLE);
> -		if (atomic_read(&inode->i_dio_count))
> -			schedule();
> -	} while (atomic_read(&inode->i_dio_count));
> -	finish_wait(wq, &q.wq_entry);
> +	smp_mb__before_atomic();
> +	return atomic_read(&inode->i_dio_count) =3D=3D 0;

Can atomic_read_aquire() be used here?

>  }
> +EXPORT_SYMBOL(inode_dio_finished);
>  =

>  /**
>   * inode_dio_wait - wait for outstanding DIO requests to finish
> @@ -2490,11 +2484,16 @@ static void __inode_dio_wait(struct inode *inode=
)
>   */
>  void inode_dio_wait(struct inode *inode)
>  {
> -	if (atomic_read(&inode->i_dio_count))
> -		__inode_dio_wait(inode);
> +	wait_var_event(&inode->i_dio_count, inode_dio_finished);
>  }
>  EXPORT_SYMBOL(inode_dio_wait);
>  =

> +void inode_dio_wait_interruptible(struct inode *inode)
> +{
> +	wait_var_event_interruptible(&inode->i_dio_count, inode_dio_finished);
> +}
> +EXPORT_SYMBOL(inode_dio_wait_interruptible);
> +
>  /*
>   * inode_set_flags - atomically set some inode flags
>   *
> diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
> index 75dc52a49b3a..c2cfdda85230 100644
> --- a/fs/netfs/locking.c
> +++ b/fs/netfs/locking.c
> @@ -21,23 +21,11 @@
>   */
>  static int inode_dio_wait_interruptible(struct inode *inode)
>  {
> -	if (!atomic_read(&inode->i_dio_count))
> +	if (inode_dio_finished(inode))
>  		return 0;
>  =

> -	wait_queue_head_t *wq =3D bit_waitqueue(&inode->i_state, __I_DIO_WAKEU=
P);
> -	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
> -
> -	for (;;) {
> -		prepare_to_wait(wq, &q.wq_entry, TASK_INTERRUPTIBLE);
> -		if (!atomic_read(&inode->i_dio_count))
> -			break;
> -		if (signal_pending(current))
> -			break;
> -		schedule();
> -	}
> -	finish_wait(wq, &q.wq_entry);
> -
> -	return atomic_read(&inode->i_dio_count) ? -ERESTARTSYS : 0;
> +	inode_dio_wait_interruptible(inode);
> +	return !inode_dio_finished(inode) ? -ERESTARTSYS : 0;
>  }
>  =

>  /* Call with exclusively locked inode->i_rwsem */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b6f2e2a1e513..f744cd918259 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2380,8 +2380,6 @@ static inline void kiocb_clone(struct kiocb *kiocb=
, struct kiocb *kiocb_src,
>   *
>   * I_REFERENCED		Marks the inode as recently references on the LRU list=
.
>   *
> - * I_DIO_WAKEUP		Never set.  Only used as a key for wait_on_bit().
> - *
>   * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
>   *			synchronize competing switching instances and to tell
>   *			wb stat updates to grab the i_pages lock.  See
> @@ -2413,8 +2411,6 @@ static inline void kiocb_clone(struct kiocb *kiocb=
, struct kiocb *kiocb_src,
>  #define __I_SYNC		7
>  #define I_SYNC			(1 << __I_SYNC)
>  #define I_REFERENCED		(1 << 8)
> -#define __I_DIO_WAKEUP		9
> -#define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
>  #define I_LINKABLE		(1 << 10)
>  #define I_DIRTY_TIME		(1 << 11)
>  #define I_WB_SWITCH		(1 << 13)
> @@ -3230,6 +3226,7 @@ static inline ssize_t blockdev_direct_IO(struct ki=
ocb *iocb,
>  #endif
>  =

>  void inode_dio_wait(struct inode *inode);
> +void inode_dio_wait_interruptible(struct inode *inode);
>  =

>  /**
>   * inode_dio_begin - signal start of a direct I/O requests
> @@ -3241,6 +3238,7 @@ void inode_dio_wait(struct inode *inode);
>  static inline void inode_dio_begin(struct inode *inode)
>  {
>  	atomic_inc(&inode->i_dio_count);
> +	smp_mb__after_atomic();
>  }
>  =

>  /**
> @@ -3252,8 +3250,9 @@ static inline void inode_dio_begin(struct inode *i=
node)
>   */
>  static inline void inode_dio_end(struct inode *inode)
>  {
> +	smp_mb__before_atomic();
>  	if (atomic_dec_and_test(&inode->i_dio_count))

Doesn't atomic_dec_and_test() imply full barriering?  See atomic_t.txt,
"ORDERING":

 - RMW operations that have a return value are fully ordered;

> -		wake_up_bit(&inode->i_state, __I_DIO_WAKEUP);
> +		wake_up_var(&inode->i_dio_count);
>  }
>  =

>  extern void inode_set_flags(struct inode *inode, unsigned int flags,
> =

> ---
> base-commit: 5570f04d0bb1a34ebcb27caac76c797a7c9e36c9
> change-id: 20240816-vfs-misc-dio-5cb07eaae155
> =


