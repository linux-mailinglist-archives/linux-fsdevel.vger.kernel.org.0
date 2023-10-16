Return-Path: <linux-fsdevel+bounces-412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BEC7CABCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB2328176C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076228E08;
	Mon, 16 Oct 2023 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbL0JENl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7B28E02;
	Mon, 16 Oct 2023 14:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C62C433C7;
	Mon, 16 Oct 2023 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697467467;
	bh=EosIPRQRkZS/m8fRSYLf1GF9E5dQpYw/H0GO2FrhMzU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pbL0JENlz5RnGYP4I9kBXyy7y5PAbYeNgIvdEtdEfV+6JtSnYAgZxXfj6QS0OTvnq
	 7EQLcIfg5sdun4AKj6ILT0f9Sn+Lj6uvsAiodPVGiYDgFZBItlIo32ZAZ94e+7xhcC
	 EzgeCAxFRNF1lIZMxpTdwOblh/UZLmbq4cioT65oxIZDzZFXQX7uvm9EQBD1jalFt1
	 7JjsKBkOkgur951+Esn3xom0VBOBX9uF/8bVz6kjKcDLzBtDl8aS9RlYKjQ/3DdqNd
	 U2gH58YxGzyynaLl9ZTOovVYCLIQjHNnnlfnqltpw7WhZQlr1WcoivXsWgUIsn7mNI
	 RHCnJAlJeYfQA==
Message-ID: <bd10b3e5a826d8658a2ee6bba510d25b27c35b50.camel@kernel.org>
Subject: Re: [RFC PATCH 01/53] netfs: Add a procfile to list in-progress
 requests
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Marc Dionne
 <marc.dionne@auristor.com>,  Paulo Alcantara <pc@manguebit.com>, Ronnie
 Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom
 Talpey <tom@talpey.com>, Dominique Martinet <asmadeus@codewreck.org>, Ilya
 Dryomov <idryomov@gmail.com>, Christian Brauner <christian@brauner.io>,
 linux-afs@lists.infradead.org,  linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org,  ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cachefs@redhat.com
Date: Mon, 16 Oct 2023 10:44:24 -0400
In-Reply-To: <20231013155727.2217781-2-dhowells@redhat.com>
References: <20231013155727.2217781-1-dhowells@redhat.com>
	 <20231013155727.2217781-2-dhowells@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-13 at 16:56 +0100, David Howells wrote:
> Add a procfile, /proc/fs/netfs/requests, to list in-progress netfslib I/O
> requests.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/internal.h   | 22 +++++++++++
>  fs/netfs/main.c       | 91 +++++++++++++++++++++++++++++++++++++++++++
>  fs/netfs/objects.c    |  4 +-
>  include/linux/netfs.h |  6 ++-
>  4 files changed, 121 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index 43fac1b14e40..1f067aa96c50 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -29,6 +29,28 @@ int netfs_begin_read(struct netfs_io_request *rreq, bo=
ol sync);
>   * main.c
>   */
>  extern unsigned int netfs_debug;
> +extern struct list_head netfs_io_requests;
> +extern spinlock_t netfs_proc_lock;
> +
> +#ifdef CONFIG_PROC_FS
> +static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq)
> +{
> +	spin_lock(&netfs_proc_lock);
> +	list_add_tail_rcu(&rreq->proc_link, &netfs_io_requests);
> +	spin_unlock(&netfs_proc_lock);
> +}
> +static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq)
> +{
> +	if (!list_empty(&rreq->proc_link)) {
> +		spin_lock(&netfs_proc_lock);
> +		list_del_rcu(&rreq->proc_link);
> +		spin_unlock(&netfs_proc_lock);
> +	}
> +}
> +#else
> +static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq) {}
> +static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
> +#endif
> =20
>  /*
>   * objects.c
> diff --git a/fs/netfs/main.c b/fs/netfs/main.c
> index 068568702957..21f814eee6af 100644
> --- a/fs/netfs/main.c
> +++ b/fs/netfs/main.c
> @@ -7,6 +7,8 @@
> =20
>  #include <linux/module.h>
>  #include <linux/export.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
>  #include "internal.h"
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/netfs.h>
> @@ -18,3 +20,92 @@ MODULE_LICENSE("GPL");
>  unsigned netfs_debug;
>  module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
>  MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
> +
> +#ifdef CONFIG_PROC_FS
> +LIST_HEAD(netfs_io_requests);
> +DEFINE_SPINLOCK(netfs_proc_lock);
> +
> +static const char *netfs_origins[] =3D {
> +	[NETFS_READAHEAD]	=3D "RA",
> +	[NETFS_READPAGE]	=3D "RP",
> +	[NETFS_READ_FOR_WRITE]	=3D "RW",
> +};
> +
> +/*
> + * Generate a list of I/O requests in /proc/fs/netfs/requests
> + */
> +static int netfs_requests_seq_show(struct seq_file *m, void *v)
> +{
> +	struct netfs_io_request *rreq;
> +
> +	if (v =3D=3D &netfs_io_requests) {
> +		seq_puts(m,
> +			 "REQUEST  OR REF FL ERR  OPS COVERAGE\n"
> +			 "=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D =3D=3D=3D =3D=3D =3D=3D=3D=3D =3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D\n"
> +			 );
> +		return 0;
> +	}
> +
> +	rreq =3D list_entry(v, struct netfs_io_request, proc_link);
> +	seq_printf(m,
> +		   "%08x %s %3d %2lx %4d %3d @%04llx %zx/%zx",
> +		   rreq->debug_id,
> +		   netfs_origins[rreq->origin],
> +		   refcount_read(&rreq->ref),
> +		   rreq->flags,
> +		   rreq->error,
> +		   atomic_read(&rreq->nr_outstanding),
> +		   rreq->start, rreq->submitted, rreq->len);
> +	seq_putc(m, '\n');
> +	return 0;
> +}
> +
> +static void *netfs_requests_seq_start(struct seq_file *m, loff_t *_pos)
> +	__acquires(rcu)
> +{
> +	rcu_read_lock();
> +	return seq_list_start_head(&netfs_io_requests, *_pos);
> +}
> +
> +static void *netfs_requests_seq_next(struct seq_file *m, void *v, loff_t=
 *_pos)
> +{
> +	return seq_list_next(v, &netfs_io_requests, _pos);
> +}
> +
> +static void netfs_requests_seq_stop(struct seq_file *m, void *v)
> +	__releases(rcu)
> +{
> +	rcu_read_unlock();
> +}
> +
> +static const struct seq_operations netfs_requests_seq_ops =3D {
> +	.start  =3D netfs_requests_seq_start,
> +	.next   =3D netfs_requests_seq_next,
> +	.stop   =3D netfs_requests_seq_stop,
> +	.show   =3D netfs_requests_seq_show,
> +};
> +#endif /* CONFIG_PROC_FS */
> +
> +static int __init netfs_init(void)
> +{
> +	if (!proc_mkdir("fs/netfs", NULL))
> +		goto error;
> +

It seems like this should go under debugfs instead.

> +	if (!proc_create_seq("fs/netfs/requests", S_IFREG | 0444, NULL,
> +			     &netfs_requests_seq_ops))
> +		goto error_proc;
> +
> +	return 0;
> +
> +error_proc:
> +	remove_proc_entry("fs/netfs", NULL);
> +error:
> +	return -ENOMEM;
> +}
> +fs_initcall(netfs_init);
> +
> +static void __exit netfs_exit(void)
> +{
> +	remove_proc_entry("fs/netfs", NULL);
> +}
> +module_exit(netfs_exit);
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index e17cdf53f6a7..85f428fc52e6 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -45,6 +45,7 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
>  		}
>  	}
> =20
> +	netfs_proc_add_rreq(rreq);
>  	netfs_stat(&netfs_n_rh_rreq);
>  	return rreq;
>  }
> @@ -76,12 +77,13 @@ static void netfs_free_request(struct work_struct *wo=
rk)
>  		container_of(work, struct netfs_io_request, work);
> =20
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
> +	netfs_proc_del_rreq(rreq);
>  	netfs_clear_subrequests(rreq, false);
>  	if (rreq->netfs_ops->free_request)
>  		rreq->netfs_ops->free_request(rreq);
>  	if (rreq->cache_resources.ops)
>  		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> -	kfree(rreq);
> +	kfree_rcu(rreq, rcu);
>  	netfs_stat_d(&netfs_n_rh_rreq);
>  }
> =20
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index b11a84f6c32b..b447cb67f599 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -175,10 +175,14 @@ enum netfs_io_origin {
>   * operations to a variety of data stores and then stitch the result tog=
ether.
>   */
>  struct netfs_io_request {
> -	struct work_struct	work;
> +	union {
> +		struct work_struct work;
> +		struct rcu_head rcu;
> +	};
>  	struct inode		*inode;		/* The file being accessed */
>  	struct address_space	*mapping;	/* The mapping being accessed */
>  	struct netfs_cache_resources cache_resources;
> +	struct list_head	proc_link;	/* Link in netfs_iorequests */
>  	struct list_head	subrequests;	/* Contributory I/O operations */
>  	void			*netfs_priv;	/* Private data for the netfs */
>  	unsigned int		debug_id;
>=20

ACK on the general concept however. This is useful debugging info.
--=20
Jeff Layton <jlayton@kernel.org>

