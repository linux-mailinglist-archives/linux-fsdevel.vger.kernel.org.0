Return-Path: <linux-fsdevel+bounces-27894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA52964B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126D5B24DA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028BB1922FE;
	Thu, 29 Aug 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNvmlwvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27C195FD5;
	Thu, 29 Aug 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948528; cv=none; b=QbnVPG5mvicIdROXq2mR33svZYkv0eYSpnehm1qC6gXLJ9/xY539zGkU23UMwjDbEgsNsaPcSIdhPUKP18VwJmhEDjavmIQwnbUdydsD0Y1THHU3WoD898bEgy4CrRVSGISwj7BkDeFM80nNOqdE0I1aK19IA4Zwo1J0bNP0KCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948528; c=relaxed/simple;
	bh=Q0Owz95Y13iUYjfu3dmujKQngYspzij/0DjXNE3KPU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb97nvYAl/UTCR2TtwUKkEmH2i/QF6xwGpDhhQq80DAezpTRQEp/owy3jfo+b5MHpokN28P+hTZd2nC7vSoO44c9XR/gLZz9hDbYUPNJQiOBG2gVh1/4UCY1l6ozzCw74/fujxLK8LqdHJqBlEIBIAFTIIRyH1wzyUZWHr95IPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNvmlwvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926E2C4CEC1;
	Thu, 29 Aug 2024 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724948527;
	bh=Q0Owz95Y13iUYjfu3dmujKQngYspzij/0DjXNE3KPU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNvmlwvPris7BDZ7I0YiuLufSn8cJeF3Ah0VjzqO7QHZfLhrBeefZtVK9wMp9j7p4
	 GMv6fncJ0yl86HLdKfEzgkGxYm6GeHnOpjEc6L7ZIrxRrZq5yVwha80eL71FHXD+nO
	 o1KO7uEWmHJFifQEDoZepGlCvIl8zlaJ9Lfup0B2F67LJrP91T1IAPNMOyayobsGQd
	 jJpTQNoK+dG1RRncSLY+62L0UzEmKMzNJlSWKsfOiwktGbuwvhP0F75WdlnoUs88W0
	 PX0M+NY4I6eg3eDjLM5hZwupcoK03YCXpCd+f0qhOC9aheUDOPPJoVVP8dz0wI+ge9
	 OScwSQ8QT74ig==
Date: Thu, 29 Aug 2024 12:22:06 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 14/25] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
Message-ID: <ZtCgLvrUfz9VzyL3@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-15-snitzer@kernel.org>
 <6ecd19ff0c70d6d93e473d958a210dd131b665c0.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ecd19ff0c70d6d93e473d958a210dd131b665c0.camel@kernel.org>

On Thu, Aug 29, 2024 at 12:07:06PM -0400, Jeff Layton wrote:
> On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS
> > client to generate a nonce (single-use UUID) and associated
> > short-lived nfs_uuid_t struct, register it with nfs_common for
> > subsequent lookup and verification by the NFS server and if matched
> > the NFS server populates members in the nfs_uuid_t struct.
> > 
> > nfs_common's nfs_uuids list is the basis for localio enablement, as
> > such it has members that point to nfsd memory for direct use by the
> > client (e.g. 'net' is the server's network namespace, through it the
> > client can access nn->nfsd_serv with proper rcu read access).
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs_common/Makefile     |  3 ++
> >  fs/nfs_common/nfslocalio.c | 74 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/nfslocalio.h | 31 ++++++++++++++++
> >  3 files changed, 108 insertions(+)
> >  create mode 100644 fs/nfs_common/nfslocalio.c
> >  create mode 100644 include/linux/nfslocalio.h
> > 
> > diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> > index e58b01bb8dda..a5e54809701e 100644
> > --- a/fs/nfs_common/Makefile
> > +++ b/fs/nfs_common/Makefile
> > @@ -6,6 +6,9 @@
> >  obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
> >  nfs_acl-objs := nfsacl.o
> >  
> > +obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) += nfs_localio.o
> > +nfs_localio-objs := nfslocalio.o
> > +
> >  obj-$(CONFIG_GRACE_PERIOD) += grace.o
> >  obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
> >  
> > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > new file mode 100644
> > index 000000000000..1a35a4a6dbe0
> > --- /dev/null
> > +++ b/fs/nfs_common/nfslocalio.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/rculist.h>
> > +#include <linux/nfslocalio.h>
> > +#include <net/netns/generic.h>
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("NFS localio protocol bypass support");
> > +
> > +DEFINE_MUTEX(nfs_uuid_mutex);
> 
> Why a mutex here? AFAICT, you're just using this to protect the list. A
> spinlock would probably be more efficient.

Yeah, will do, I meant to revisit (when Neil suggested the same for
the lock that is added in 15/25).

Thanks.

> > +
> > +/*
> > + * Global list of nfs_uuid_t instances, add/remove
> > + * is protected by nfs_uuid_mutex.
> > + * Reads are protected by RCU read lock (see below).
> > + */
> > +LIST_HEAD(nfs_uuids);
> > +
> > +void nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
> > +{
> > +	nfs_uuid->net = NULL;
> > +	nfs_uuid->dom = NULL;
> > +	uuid_gen(&nfs_uuid->uuid);
> > +
> > +	mutex_lock(&nfs_uuid_mutex);
> > +	list_add_tail_rcu(&nfs_uuid->list, &nfs_uuids);
> > +	mutex_unlock(&nfs_uuid_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(nfs_uuid_begin);
> > +
> > +void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
> > +{
> > +	mutex_lock(&nfs_uuid_mutex);
> > +	list_del_rcu(&nfs_uuid->list);
> > +	mutex_unlock(&nfs_uuid_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(nfs_uuid_end);
> > +
> > +/* Must be called with RCU read lock held. */
> > +static nfs_uuid_t * nfs_uuid_lookup(const uuid_t *uuid)
> > +{
> > +	nfs_uuid_t *nfs_uuid;
> > +
> > +	list_for_each_entry_rcu(nfs_uuid, &nfs_uuids, list)
> > +		if (uuid_equal(&nfs_uuid->uuid, uuid))
> > +			return nfs_uuid;
> > +
> > +	return NULL;
> > +}
> > +
> > +bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *dom)
> > +{
> > +	bool is_local = false;
> > +	nfs_uuid_t *nfs_uuid;
> > +
> > +	rcu_read_lock();
> > +	nfs_uuid = nfs_uuid_lookup(uuid);
> > +	if (nfs_uuid) {
> > +		nfs_uuid->net = maybe_get_net(net);
> > +		if (nfs_uuid->net) {
> > +			is_local = true;
> > +			kref_get(&dom->ref);
> > +			nfs_uuid->dom = dom;
> > +		}
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return is_local;
> > +}
> > +EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> > diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> > new file mode 100644
> > index 000000000000..9735ae8d3e5e
> > --- /dev/null
> > +++ b/include/linux/nfslocalio.h
> > @@ -0,0 +1,31 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > + */
> > +#ifndef __LINUX_NFSLOCALIO_H
> > +#define __LINUX_NFSLOCALIO_H
> > +
> > +#include <linux/list.h>
> > +#include <linux/uuid.h>
> > +#include <linux/sunrpc/svcauth.h>
> > +#include <linux/nfs.h>
> > +#include <net/net_namespace.h>
> > +
> > +/*
> > + * Useful to allow a client to negotiate if localio
> > + * possible with its server.
> > + *
> > + * See Documentation/filesystems/nfs/localio.rst for more detail.
> > + */
> > +typedef struct {
> > +	uuid_t uuid;
> > +	struct list_head list;
> > +	struct net *net; /* nfsd's network namespace */
> > +	struct auth_domain *dom; /* auth_domain for localio */
> > +} nfs_uuid_t;
> > +
> > +void nfs_uuid_begin(nfs_uuid_t *);
> > +void nfs_uuid_end(nfs_uuid_t *);
> > +bool nfs_uuid_is_local(const uuid_t *, struct net *, struct auth_domain *);
> > +
> > +#endif  /* __LINUX_NFSLOCALIO_H */
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

