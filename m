Return-Path: <linux-fsdevel+bounces-22616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E091A475
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 13:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A90C1F2322C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18230145B13;
	Thu, 27 Jun 2024 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MexA7hH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C613F014;
	Thu, 27 Jun 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486100; cv=none; b=uNKLnFSiYIDpM/PZRqX58qo/xlePWmwzcOFEbVeyLnlmCmQCr+sZ740foYISvbL9p/zgGWGoIE07ypRBsnbKnBcghzWBcMqZ4fpDOr7SnafsvWsdv7OcgNr4ONEemuwjuFIAVxTt9S0tfUhksh/U78PPCvD56A+qnI6q5fXoRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486100; c=relaxed/simple;
	bh=d9XGZ2kB3Lt/GXYoN+EjaPRKIEPhF2tefw/+D8t0oTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0+V9tUzoJNJDONNdkEjhbDtRaa5NGkyw49xAtTPcPR6D9aL4rN8wcGBDcELmmRODzykjuxsh5VcfDxNSepvNOkCY4ewy2YgHb7C1zlZcDkfkNRz0GrZGCkbyw3ptG9U0CCFQdmYe7TNKCfrPit13jgOf+hTApnw92x+ZRPhYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MexA7hH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B160AC2BBFC;
	Thu, 27 Jun 2024 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719486099;
	bh=d9XGZ2kB3Lt/GXYoN+EjaPRKIEPhF2tefw/+D8t0oTk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MexA7hH0tR2F5X8b5EtDn8VpN0iKLpq2+zUi+ASp/gJhQ9pDdNkbgSnjSMxfjnbVI
	 +7JdDiFaosrI0SnEFNDJ6ceQaZDimYzg+BE6ZT4jj0vZgSUiuNRl099Zj5RIbgJ9cp
	 y75CKiI+N14qArASzJEwkeE+OWOpRdkM/+HFwRqZnNR7tPwtuPq8R0iQJnktkEloUb
	 iiCma2tk1xTbOPrzZibllYTBJmWxFY7rQzy009mFggg6ePVLMWbAe5Z0Ry6LwUV1Je
	 Tt7x+MgWKu5ax0tO9xBuBidj7OxuM6lI4gKmC1To0SgC2nJBbic/SxGHeUyizZTH/W
	 oqrqnMYU1yQgw==
Message-ID: <5bb711c4bbc59ea9fff486a86acce13880823e7b.camel@kernel.org>
Subject: Re: [PATCH v2 2/5] cachefiles: flush all requests for the object
 that is being dropped
From: Jeff Layton <jlayton@kernel.org>
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com, 
 zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com,  Baokun Li <libaokun1@huawei.com>
Date: Thu, 27 Jun 2024 07:01:37 -0400
In-Reply-To: <20240515125136.3714580-3-libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
	 <20240515125136.3714580-3-libaokun@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
>=20
> Because after an object is dropped, requests for that object are
> useless,
> flush them to avoid causing other problems.
>=20
> This prepares for the later addition of cancel_work_sync(). After the
> reopen requests is generated, flush it to avoid cancel_work_sync()
> blocking by waiting for daemon to complete the reopen requests.
>=20
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> =C2=A0fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 73da4d4eaa9b..d24bff43499b 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -564,12 +564,31 @@ int cachefiles_ondemand_init_object(struct
> cachefiles_object *object)
> =C2=A0
> =C2=A0void cachefiles_ondemand_clean_object(struct cachefiles_object
> *object)
> =C2=A0{
> +	unsigned long index;
> +	struct cachefiles_req *req;
> +	struct cachefiles_cache *cache;
> +
> =C2=A0	if (!object->ondemand)
> =C2=A0		return;
> =C2=A0
> =C2=A0	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
> =C2=A0			cachefiles_ondemand_init_close_req, NULL);
> +
> +	if (!object->ondemand->ondemand_id)
> +		return;
> +
> +	/* Flush all requests for the object that is being dropped.
> */

I wouldn't call this a "Flush". In the context of writeback, that
usually means that we're writing out pages now in order to do something
else. In this case, it looks like you're more canceling these requests
since you're marking them with an error and declaring them complete.

> +	cache =3D object->volume->cache;
> +	xa_lock(&cache->reqs);
> =C2=A0	cachefiles_ondemand_set_object_dropping(object);
> +	xa_for_each(&cache->reqs, index, req) {
> +		if (req->object =3D=3D object) {
> +			req->error =3D -EIO;
> +			complete(&req->done);
> +			__xa_erase(&cache->reqs, index);
> +		}
> +	}
> +	xa_unlock(&cache->reqs);
> =C2=A0}
> =C2=A0
> =C2=A0int cachefiles_ondemand_init_obj_info(struct cachefiles_object
> *object,

--=20
Jeff Layton <jlayton@kernel.org>

