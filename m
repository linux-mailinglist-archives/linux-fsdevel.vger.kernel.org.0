Return-Path: <linux-fsdevel+bounces-19804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464848C9E19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C94B2414E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7593413667D;
	Mon, 20 May 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhnwnH2o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8AA13398E;
	Mon, 20 May 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211470; cv=none; b=LII+PqUicGDxmWj6YQOBWNA38fiFbVyvZEYDs+sRmJyQX6s4foZOEX09/N6Wlk7p3+Sg6V54akTCpKuVPPR4RJGRP02MLtJ3q0Ijhin/fKnbm0jx3kYBYSYckQPmPUdjKhl1XB6Qax0l6yqKDr1zyLKMfcSHpZW0D62xUNYQhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211470; c=relaxed/simple;
	bh=tmycHzHS16yUDsFnDDAGL9c2k/ykCsqRadkM55Fr7Rk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFzwdlwfdtwJIUw9onoJ1fXjxdXyx85UPcI7SaZMiQg5n5nR2+lBFtT/iGoe4ucrAzpc1R9HjExHNklohruEukJHTGuX3aWaUs1BmuF/GbRy0tNW+X/SRAi0FJxG2cXfxtHVZwFoRW5CsvSRXpIxzdsDZXDTxsc5Dufyk1MNBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhnwnH2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F33C2BD10;
	Mon, 20 May 2024 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716211470;
	bh=tmycHzHS16yUDsFnDDAGL9c2k/ykCsqRadkM55Fr7Rk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XhnwnH2o/kK01P+lYGJGEibHOO3m9DuugiCuE9yJ90uFaL2eM+Z/d2XN3lfTGzpFb
	 U4Wdfi2wQEEbGEARAa9r0h/ryL8Yte54qJzPeudrmaXyUi1BkFmVqPUbtUc1lrvbFV
	 XsHOTEM3WPnFIpxJ0fUeqvW/7p3x4ebrAR5QC1u+ujqVeEJsG5gMEPPpGKMb0g1zUK
	 rDW1NGM8VzK7VKTndup+Bftvki/RVcH2m9dQ5A1WdxCcqvAsFnANYp+gm6u8NyHqo7
	 3uj8bfGfzDkE9jUBcavi0KrEt6fVGzzxkJOkYHTb/1t1fSpWuKtwRysfthdhp0fM7v
	 U+/eUYApP/Nvg==
Message-ID: <e522702477bed6e73c1e365bd8bd77a4250955c2.camel@kernel.org>
Subject: Re: [PATCH v2 4/5] cachefiles: cyclic allocation of msg_id to avoid
 reuse
From: Jeff Layton <jlayton@kernel.org>
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev, 
	dhowells@redhat.com
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com, 
 zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com,  Baokun Li <libaokun1@huawei.com>
Date: Mon, 20 May 2024 09:24:27 -0400
In-Reply-To: <a4d57830-2bde-901f-72c4-e1a3f714faa5@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
	 <20240515125136.3714580-5-libaokun@huaweicloud.com>
	 <f449f710b7e1ba725ec9f73cace6c1289b9225b6.camel@kernel.org>
	 <d3f5d0c4-eda7-87e3-5938-487ab9ff6b81@huaweicloud.com>
	 <4b1584787dd54bb95d700feae1ca498c40429551.camel@kernel.org>
	 <a4d57830-2bde-901f-72c4-e1a3f714faa5@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-20 at 20:42 +0800, Baokun Li wrote:
> On 2024/5/20 18:04, Jeff Layton wrote:
> > On Mon, 2024-05-20 at 12:06 +0800, Baokun Li wrote:
> > > Hi Jeff,
> > >=20
> > > Thank you very much for your review!
> > >=20
> > > On 2024/5/19 19:11, Jeff Layton wrote:
> > > > On Wed, 2024-05-15 at 20:51 +0800,
> > > > libaokun@huaweicloud.com=C2=A0wrote:
> > > > > From: Baokun Li <libaokun1@huawei.com>
> > > > >=20
> > > > > Reusing the msg_id after a maliciously completed reopen
> > > > > request may cause
> > > > > a read request to remain unprocessed and result in a hung, as
> > > > > shown below:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t1=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t2=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t3
> > > > > -------------------------------------------------
> > > > > cachefiles_ondemand_select_req
> > > > > =C2=A0=C2=A0 cachefiles_ondemand_object_is_close(A)
> > > > > =C2=A0=C2=A0 cachefiles_ondemand_set_object_reopening(A)
> > > > > =C2=A0=C2=A0 queue_work(fscache_object_wq, &info->work)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ondemand_object_worker
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cachefiles_ondemand_init_obje=
ct(A)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cachefiles_ondemand_sen=
d_req(OPEN)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // get msg_=
id 6
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_co=
mpletion(&req_A->done)
> > > > > cachefiles_ondemand_daemon_read
> > > > > =C2=A0=C2=A0 // read msg_id 6 req_A
> > > > > =C2=A0=C2=A0 cachefiles_ondemand_get_fd
> > > > > =C2=A0=C2=A0 copy_to_user
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Malicious c=
ompletion
> > > > > msg_id 6
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copen 6,-1
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cachefiles_ond=
emand_copen
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 complete=
(&req_A->done)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // will =
not set the object
> > > > > to close
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // becau=
se ondemand_id &&
> > > > > fd is valid.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // ondemand_object_worker() is done
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // but the object is still reopenin=
g.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // new open re=
q_B
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > cachefiles_ondemand_init_object(B)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > cachefiles_ondemand_send_req(OPEN)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // reuse=
 msg_id 6
> > > > > process_open_req
> > > > > =C2=A0=C2=A0 copen 6,A.size
> > > > > =C2=A0=C2=A0 // The expected failed copen was executed successful=
ly
> > > > >=20
> > > > > Expect copen to fail, and when it does, it closes fd, which
> > > > > sets the
> > > > > object to close, and then close triggers reopen again.
> > > > > However, due to
> > > > > msg_id reuse resulting in a successful copen, the anonymous
> > > > > fd is not
> > > > > closed until the daemon exits. Therefore read requests
> > > > > waiting for reopen
> > > > > to complete may trigger hung task.
> > > > >=20
> > > > > To avoid this issue, allocate the msg_id cyclically to avoid
> > > > > reusing the
> > > > > msg_id for a very short duration of time.
> > > > >=20
> > > > > Fixes: c8383054506c ("cachefiles: notify the user daemon when
> > > > > looking up cookie")
> > > > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > > > ---
> > > > > =C2=A0=C2=A0 fs/cachefiles/internal.h |=C2=A0 1 +
> > > > > =C2=A0=C2=A0 fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
> > > > > =C2=A0=C2=A0 2 files changed, 17 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/cachefiles/internal.h
> > > > > b/fs/cachefiles/internal.h
> > > > > index 8ecd296cc1c4..9200c00f3e98 100644
> > > > > --- a/fs/cachefiles/internal.h
> > > > > +++ b/fs/cachefiles/internal.h
> > > > > @@ -128,6 +128,7 @@ struct cachefiles_cache {
> > > > > =C2=A0=C2=A0=C2=A0	unsigned long			req_id_next;
> > > > > =C2=A0=C2=A0=C2=A0	struct xarray			ondemand_ids;	/*
> > > > > xarray for ondemand_id allocation */
> > > > > =C2=A0=C2=A0=C2=A0	u32				ondemand_id_next;
> > > > > +	u32				msg_id_next;
> > > > > =C2=A0=C2=A0 };
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0 static inline bool cachefiles_in_ondemand_mode(struc=
t
> > > > > cachefiles_cache *cache)
> > > > > diff --git a/fs/cachefiles/ondemand.c
> > > > > b/fs/cachefiles/ondemand.c
> > > > > index f6440b3e7368..b10952f77472 100644
> > > > > --- a/fs/cachefiles/ondemand.c
> > > > > +++ b/fs/cachefiles/ondemand.c
> > > > > @@ -433,20 +433,32 @@ static int
> > > > > cachefiles_ondemand_send_req(struct cachefiles_object
> > > > > *object,
> > > > > =C2=A0=C2=A0=C2=A0		smp_mb();
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0		if (opcode =3D=3D CACHEFILES_OP_CLOSE &&
> > > > > -
> > > > > 			!cachefiles_ondemand_object_is_open(object)) {
> > > > > +		=C2=A0=C2=A0=C2=A0
> > > > > !cachefiles_ondemand_object_is_open(object)) {
> > > > > =C2=A0=C2=A0=C2=A0			WARN_ON_ONCE(object->ondemand-
> > > > > >ondemand_id =3D=3D 0);
> > > > > =C2=A0=C2=A0=C2=A0			xas_unlock(&xas);
> > > > > =C2=A0=C2=A0=C2=A0			ret =3D -EIO;
> > > > > =C2=A0=C2=A0=C2=A0			goto out;
> > > > > =C2=A0=C2=A0=C2=A0		}
> > > > > =C2=A0=C2=A0=20
> > > > > -		xas.xa_index =3D 0;
> > > > > +		/*
> > > > > +		 * Cyclically find a free xas to avoid
> > > > > msg_id reuse that would
> > > > > +		 * cause the daemon to successfully copen a
> > > > > stale msg_id.
> > > > > +		 */
> > > > > +		xas.xa_index =3D cache->msg_id_next;
> > > > > =C2=A0=C2=A0=C2=A0		xas_find_marked(&xas, UINT_MAX,
> > > > > XA_FREE_MARK);
> > > > > +		if (xas.xa_node =3D=3D XAS_RESTART) {
> > > > > +			xas.xa_index =3D 0;
> > > > > +			xas_find_marked(&xas, cache-
> > > > > >msg_id_next - 1, XA_FREE_MARK);
> > > > > +		}
> > > > > =C2=A0=C2=A0=C2=A0		if (xas.xa_node =3D=3D XAS_RESTART)
> > > > > =C2=A0=C2=A0=C2=A0			xas_set_err(&xas, -EBUSY);
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0		xas_store(&xas, req);
> > > > > -		xas_clear_mark(&xas, XA_FREE_MARK);
> > > > > -		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> > > > > +		if (xas_valid(&xas)) {
> > > > > +			cache->msg_id_next =3D xas.xa_index +
> > > > > 1;
> > > > If you have a long-standing stuck request, could this counter
> > > > wrap
> > > > around and you still end up with reuse?
> > > Yes, msg_id_next is declared to be of type u32 in the hope that
> > > when
> > > xa_index =3D=3D UINT_MAX, a wrap around occurs so that msg_id_next
> > > goes to zero. Limiting xa_index to no more than UINT_MAX is to
> > > avoid
> > > the xarry being too deep.
> > >=20
> > > If msg_id_next is equal to the id of a long-standing stuck
> > > request
> > > after the wrap-around, it is true that the reuse in the above
> > > problem
> > > may also occur.
> > >=20
> > > But I feel that a long stuck request is problematic in itself, it
> > > means
> > > that after we have sent 4294967295 requests, the first one has
> > > not
> > > been processed yet, and even if we send a million requests per
> > > second, this one hasn't been completed for more than an hour.
> > >=20
> > > We have a keep-alive process that pulls the daemon back up as
> > > soon as it exits, and there is a timeout mechanism for requests
> > > in
> > > the daemon to prevent the kernel from waiting for long periods
> > > of time. In other words, we should avoid the situation where
> > > a request is stuck for a long period of time.
> > >=20
> > > If you think UINT_MAX is not enough, perhaps we could raise
> > > the maximum value of msg_id_next to ULONG_MAX?
> > > > Maybe this should be using
> > > > ida_alloc/free instead, which would prevent that too?
> > > >=20
> > > The id reuse here is that the kernel has finished the open
> > > request
> > > req_A and freed its id_A and used it again when sending the open
> > > request req_B, but the daemon is still working on req_A, so the
> > > copen id_A succeeds but operates on req_B.
> > >=20
> > > The id that is being used by the kernel will not be allocated
> > > here
> > > so it seems that ida _alloc/free does not prevent reuse either,
> > > could you elaborate a bit more how this works?
> > >=20
> > ida_alloc and free absolutely prevent reuse while the id is in use.
> > That's sort of the point of those functions. Basically it uses a
> > set of
> > bitmaps in an xarray to track which IDs are in use, so ida_alloc
> > only
> > hands out values which are not in use. See the comments over
> > ida_alloc_range() in lib/idr.c.
> >=20
> Thank you for the explanation!
>=20
> The logic now provides the same guarantees as ida_alloc/free.
> The "reused" id, indeed, is no longer in use in the kernel, but it is
> still
> in use in the userland, so a multi-threaded daemon could be handling
> two different requests for the same msg_id at the same time.
>=20
> Previously, the logic for allocating msg_ids was to start at 0 and
> look
> for a free xas.index, so it was possible for an id to be allocated to
> a
> new request just as the id was being freed.
>=20
> With the change to cyclic allocation, the kernel will not use the
> same
> id again until INT_MAX requests have been sent, and during the time
> it takes to send requests, the daemon has enough time to process
> requests whose ids are still in use by the daemon, but have already
> been freed in the kernel.
>=20
>=20

If you're checking for collisions somewhere else, then this should be
fine:

Acked-by: Jeff Layton <jlayton@kernel.org>

