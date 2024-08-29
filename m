Return-Path: <linux-fsdevel+bounces-27891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC800964B0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16A91C24DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08B1B4C57;
	Thu, 29 Aug 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaG82umK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7B1B1502;
	Thu, 29 Aug 2024 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947628; cv=none; b=dCltvM2IjuscZMBBI8qh4qJ+yT84eD+lyZf0uwxflc+ArhDgiLtrGd6rIGW3m/SX9X3BIOwDFLSzEHBXLZI68vORXu7r3wl6uB/PsBCh8rCU4UZDYRhInAuS5Dt93he3VLqCGwhbVABQ4BWKXS0A4Qh3PSIByzvhw839rUU99Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947628; c=relaxed/simple;
	bh=5Gf64Miv46SYDMbF8FclSwuG7XXf0NKcGa7lj5N9fR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZrMkTdXwP8irNtFS9RoRy80spCk6Gh3c5SJ+C85/72FwLFTYNa6SsYBJMRGNKENQkpFQgT0UZWPxNR68PK1syHaBBfyQkzPMC+WiySAtP4gP88/WQzQTRPX9/YzVx7mouokSJCkWYkP6AnPrNf+OOALt8Mc8MDOjYqep1e1+BEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaG82umK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8631C4CEC5;
	Thu, 29 Aug 2024 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947628;
	bh=5Gf64Miv46SYDMbF8FclSwuG7XXf0NKcGa7lj5N9fR8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KaG82umKsCaEV/UcL9s2VaUkb3OBj25rMBXAiM9PmuZ/56dC9Qh0xiYOGUxjBzS/K
	 MlyvdBEyNKv3kNZb5Fz4yhI2Vjw6taxbZNWlFdmo2da9C0NskGmZtXE+zEucglNM9+
	 6FJ6S0a0nvm0aF2hMr40BCxwNb6b+I6+YNANXrZTaX354bwju6pGT77ekncVzxJ+jB
	 y8s0LCj8XdoiOxB++jpzUrMCGcGdfBM+gJgak+XVyAHAv8qkEo8tbbeQ5LGV/WEewk
	 CO9EFbGD4K/RKmS8/HSQYOCgt+khQjTN6tA521OsQcu/oYCYQKeGzuHqDiUNnzngSZ
	 VomB5XqqBs4pw==
Message-ID: <6ecd19ff0c70d6d93e473d958a210dd131b665c0.camel@kernel.org>
Subject: Re: [PATCH v14 14/25] nfs_common: add NFS LOCALIO auxiliary
 protocol enablement
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 12:07:06 -0400
In-Reply-To: <20240829010424.83693-15-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-15-snitzer@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS
> client to generate a nonce (single-use UUID) and associated
> short-lived nfs_uuid_t struct, register it with nfs_common for
> subsequent lookup and verification by the NFS server and if matched
> the NFS server populates members in the nfs_uuid_t struct.
>=20
> nfs_common's nfs_uuids list is the basis for localio enablement, as
> such it has members that point to nfsd memory for direct use by the
> client (e.g. 'net' is the server's network namespace, through it the
> client can access nn->nfsd_serv with proper rcu read access).
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs_common/Makefile     |  3 ++
>  fs/nfs_common/nfslocalio.c | 74 ++++++++++++++++++++++++++++++++++++++
>  include/linux/nfslocalio.h | 31 ++++++++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 fs/nfs_common/nfslocalio.c
>  create mode 100644 include/linux/nfslocalio.h
>=20
> diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> index e58b01bb8dda..a5e54809701e 100644
> --- a/fs/nfs_common/Makefile
> +++ b/fs/nfs_common/Makefile
> @@ -6,6 +6,9 @@
>  obj-$(CONFIG_NFS_ACL_SUPPORT) +=3D nfs_acl.o
>  nfs_acl-objs :=3D nfsacl.o
> =20
> +obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) +=3D nfs_localio.o
> +nfs_localio-objs :=3D nfslocalio.o
> +
>  obj-$(CONFIG_GRACE_PERIOD) +=3D grace.o
>  obj-$(CONFIG_NFS_V4_2_SSC_HELPER) +=3D nfs_ssc.o
> =20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> new file mode 100644
> index 000000000000..1a35a4a6dbe0
> --- /dev/null
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/rculist.h>
> +#include <linux/nfslocalio.h>
> +#include <net/netns/generic.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("NFS localio protocol bypass support");
> +
> +DEFINE_MUTEX(nfs_uuid_mutex);

Why a mutex here? AFAICT, you're just using this to protect the list. A
spinlock would probably be more efficient.

> +
> +/*
> + * Global list of nfs_uuid_t instances, add/remove
> + * is protected by nfs_uuid_mutex.
> + * Reads are protected by RCU read lock (see below).
> + */
> +LIST_HEAD(nfs_uuids);
> +
> +void nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
> +{
> +	nfs_uuid->net =3D NULL;
> +	nfs_uuid->dom =3D NULL;
> +	uuid_gen(&nfs_uuid->uuid);
> +
> +	mutex_lock(&nfs_uuid_mutex);
> +	list_add_tail_rcu(&nfs_uuid->list, &nfs_uuids);
> +	mutex_unlock(&nfs_uuid_mutex);
> +}
> +EXPORT_SYMBOL_GPL(nfs_uuid_begin);
> +
> +void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
> +{
> +	mutex_lock(&nfs_uuid_mutex);
> +	list_del_rcu(&nfs_uuid->list);
> +	mutex_unlock(&nfs_uuid_mutex);
> +}
> +EXPORT_SYMBOL_GPL(nfs_uuid_end);
> +
> +/* Must be called with RCU read lock held. */
> +static nfs_uuid_t * nfs_uuid_lookup(const uuid_t *uuid)
> +{
> +	nfs_uuid_t *nfs_uuid;
> +
> +	list_for_each_entry_rcu(nfs_uuid, &nfs_uuids, list)
> +		if (uuid_equal(&nfs_uuid->uuid, uuid))
> +			return nfs_uuid;
> +
> +	return NULL;
> +}
> +
> +bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_=
domain *dom)
> +{
> +	bool is_local =3D false;
> +	nfs_uuid_t *nfs_uuid;
> +
> +	rcu_read_lock();
> +	nfs_uuid =3D nfs_uuid_lookup(uuid);
> +	if (nfs_uuid) {
> +		nfs_uuid->net =3D maybe_get_net(net);
> +		if (nfs_uuid->net) {
> +			is_local =3D true;
> +			kref_get(&dom->ref);
> +			nfs_uuid->dom =3D dom;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return is_local;
> +}
> +EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> new file mode 100644
> index 000000000000..9735ae8d3e5e
> --- /dev/null
> +++ b/include/linux/nfslocalio.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +#ifndef __LINUX_NFSLOCALIO_H
> +#define __LINUX_NFSLOCALIO_H
> +
> +#include <linux/list.h>
> +#include <linux/uuid.h>
> +#include <linux/sunrpc/svcauth.h>
> +#include <linux/nfs.h>
> +#include <net/net_namespace.h>
> +
> +/*
> + * Useful to allow a client to negotiate if localio
> + * possible with its server.
> + *
> + * See Documentation/filesystems/nfs/localio.rst for more detail.
> + */
> +typedef struct {
> +	uuid_t uuid;
> +	struct list_head list;
> +	struct net *net; /* nfsd's network namespace */
> +	struct auth_domain *dom; /* auth_domain for localio */
> +} nfs_uuid_t;
> +
> +void nfs_uuid_begin(nfs_uuid_t *);
> +void nfs_uuid_end(nfs_uuid_t *);
> +bool nfs_uuid_is_local(const uuid_t *, struct net *, struct auth_domain =
*);
> +
> +#endif  /* __LINUX_NFSLOCALIO_H */

--=20
Jeff Layton <jlayton@kernel.org>

