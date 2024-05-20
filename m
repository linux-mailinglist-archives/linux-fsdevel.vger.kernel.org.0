Return-Path: <linux-fsdevel+bounces-19775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E138C9AEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48821C20A87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 10:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF154D11D;
	Mon, 20 May 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/h1rBjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AD210E7;
	Mon, 20 May 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199453; cv=none; b=uCIpFyBxZmx32z8t38uleQ1f5/rWj7WFFcqfMajBGsaxqZEuFXHumXFybXZxvo/SnK80mxnm7keuRcytkEyJLKJkM8gl1/GpO4iGuZg8P9PoBDx2umC+B2RLvC6IhGuENcvL7GP8E+1CFZHYoYjecX3k37u5lzmEoSMOsjlp5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199453; c=relaxed/simple;
	bh=pEMdYb6oVlwhGnEI+Y6x4TkIYwX5Qmfs20rTTu91xJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YzOMuYQAEvdFNNguVcHpUV0maH7GgTSipFKJ0u/OEKg5KvOI78JwnChtWmyUekxz7YZYvDTbhh295SvBSVvoaHKCSL6WnVkPrU2oB8PitpguFX7tlWEi/nvL67xmctejwzUomkry0E9ssxGdKLy13yfoKLPqSy0clZKt1xpDDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/h1rBjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C73C2BD10;
	Mon, 20 May 2024 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716199453;
	bh=pEMdYb6oVlwhGnEI+Y6x4TkIYwX5Qmfs20rTTu91xJs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=g/h1rBjSdThs0rr5JPaGozrvm+umPhRvS99VprkqO0xusHtuLMJMa1Swaedrdw0F2
	 fc9dfTsiR2BGBIZ7jPV8HEvOfLse/EuEtBk2wfDxtjg587VjBguOLqmrPWvt1CwyhE
	 rEEwvYs2e7spyivvKpVdNcCq50NVMZFza3yw0R/LYCTp1f6VKYNTf88HGiLaU/Hm5p
	 kgL/p3VgkGbIvyWBoYRZ9e6D6Vb1Q36usuomPNklAssW5dRtex75N9n7TQf5ioC6Fw
	 AsKjbeR9dyE1wM7nxVK7gXEEqXsYB/7VU/CU/andwwwLHTmrEeodAdei7jaKdkxJ9m
	 DgxP0J8QJ3GmQ==
Message-ID: <4b1584787dd54bb95d700feae1ca498c40429551.camel@kernel.org>
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
Date: Mon, 20 May 2024 06:04:10 -0400
In-Reply-To: <d3f5d0c4-eda7-87e3-5938-487ab9ff6b81@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
	 <20240515125136.3714580-5-libaokun@huaweicloud.com>
	 <f449f710b7e1ba725ec9f73cace6c1289b9225b6.camel@kernel.org>
	 <d3f5d0c4-eda7-87e3-5938-487ab9ff6b81@huaweicloud.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-20 at 12:06 +0800, Baokun Li wrote:
> Hi Jeff,
>=20
> Thank you very much for your review!
>=20
> On 2024/5/19 19:11, Jeff Layton wrote:
> > On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > >=20
> > > Reusing the msg_id after a maliciously completed reopen request may c=
ause
> > > a read request to remain unprocessed and result in a hung, as shown b=
elow:
> > >=20
> > >         t1       |      t2       |      t3
> > > -------------------------------------------------
> > > cachefiles_ondemand_select_req
> > >   cachefiles_ondemand_object_is_close(A)
> > >   cachefiles_ondemand_set_object_reopening(A)
> > >   queue_work(fscache_object_wq, &info->work)
> > >                  ondemand_object_worker
> > >                   cachefiles_ondemand_init_object(A)
> > >                    cachefiles_ondemand_send_req(OPEN)
> > >                      // get msg_id 6
> > >                      wait_for_completion(&req_A->done)
> > > cachefiles_ondemand_daemon_read
> > >   // read msg_id 6 req_A
> > >   cachefiles_ondemand_get_fd
> > >   copy_to_user
> > >                                  // Malicious completion msg_id 6
> > >                                  copen 6,-1
> > >                                  cachefiles_ondemand_copen
> > >                                   complete(&req_A->done)
> > >                                   // will not set the object to close
> > >                                   // because ondemand_id && fd is val=
id.
> > >=20
> > >                  // ondemand_object_worker() is done
> > >                  // but the object is still reopening.
> > >=20
> > >                                  // new open req_B
> > >                                  cachefiles_ondemand_init_object(B)
> > >                                   cachefiles_ondemand_send_req(OPEN)
> > >                                   // reuse msg_id 6
> > > process_open_req
> > >   copen 6,A.size
> > >   // The expected failed copen was executed successfully
> > >=20
> > > Expect copen to fail, and when it does, it closes fd, which sets the
> > > object to close, and then close triggers reopen again. However, due t=
o
> > > msg_id reuse resulting in a successful copen, the anonymous fd is not
> > > closed until the daemon exits. Therefore read requests waiting for re=
open
> > > to complete may trigger hung task.
> > >=20
> > > To avoid this issue, allocate the msg_id cyclically to avoid reusing =
the
> > > msg_id for a very short duration of time.
> > >=20
> > > Fixes: c8383054506c ("cachefiles: notify the user daemon when looking=
 up cookie")
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > ---
> > >   fs/cachefiles/internal.h |  1 +
> > >   fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
> > >   2 files changed, 17 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> > > index 8ecd296cc1c4..9200c00f3e98 100644
> > > --- a/fs/cachefiles/internal.h
> > > +++ b/fs/cachefiles/internal.h
> > > @@ -128,6 +128,7 @@ struct cachefiles_cache {
> > >   	unsigned long			req_id_next;
> > >   	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation=
 */
> > >   	u32				ondemand_id_next;
> > > +	u32				msg_id_next;
> > >   };
> > >  =20
> > >   static inline bool cachefiles_in_ondemand_mode(struct cachefiles_ca=
che *cache)
> > > diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> > > index f6440b3e7368..b10952f77472 100644
> > > --- a/fs/cachefiles/ondemand.c
> > > +++ b/fs/cachefiles/ondemand.c
> > > @@ -433,20 +433,32 @@ static int cachefiles_ondemand_send_req(struct =
cachefiles_object *object,
> > >   		smp_mb();
> > >  =20
> > >   		if (opcode =3D=3D CACHEFILES_OP_CLOSE &&
> > > -			!cachefiles_ondemand_object_is_open(object)) {
> > > +		    !cachefiles_ondemand_object_is_open(object)) {
> > >   			WARN_ON_ONCE(object->ondemand->ondemand_id =3D=3D 0);
> > >   			xas_unlock(&xas);
> > >   			ret =3D -EIO;
> > >   			goto out;
> > >   		}
> > >  =20
> > > -		xas.xa_index =3D 0;
> > > +		/*
> > > +		 * Cyclically find a free xas to avoid msg_id reuse that would
> > > +		 * cause the daemon to successfully copen a stale msg_id.
> > > +		 */
> > > +		xas.xa_index =3D cache->msg_id_next;
> > >   		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
> > > +		if (xas.xa_node =3D=3D XAS_RESTART) {
> > > +			xas.xa_index =3D 0;
> > > +			xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
> > > +		}
> > >   		if (xas.xa_node =3D=3D XAS_RESTART)
> > >   			xas_set_err(&xas, -EBUSY);
> > > +
> > >   		xas_store(&xas, req);
> > > -		xas_clear_mark(&xas, XA_FREE_MARK);
> > > -		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> > > +		if (xas_valid(&xas)) {
> > > +			cache->msg_id_next =3D xas.xa_index + 1;
> > If you have a long-standing stuck request, could this counter wrap
> > around and you still end up with reuse?
> Yes, msg_id_next is declared to be of type u32 in the hope that when
> xa_index =3D=3D UINT_MAX, a wrap around occurs so that msg_id_next
> goes to zero. Limiting xa_index to no more than UINT_MAX is to avoid
> the xarry being too deep.
>=20
> If msg_id_next is equal to the id of a long-standing stuck request
> after the wrap-around, it is true that the reuse in the above problem
> may also occur.
>=20
> But I feel that a long stuck request is problematic in itself, it means
> that after we have sent 4294967295 requests, the first one has not
> been processed yet, and even if we send a million requests per
> second, this one hasn't been completed for more than an hour.
>=20
> We have a keep-alive process that pulls the daemon back up as
> soon as it exits, and there is a timeout mechanism for requests in
> the daemon to prevent the kernel from waiting for long periods
> of time. In other words, we should avoid the situation where
> a request is stuck for a long period of time.
>=20
> If you think UINT_MAX is not enough, perhaps we could raise
> the maximum value of msg_id_next to ULONG_MAX?
> > Maybe this should be using
> > ida_alloc/free instead, which would prevent that too?
> >=20
> The id reuse here is that the kernel has finished the open request
> req_A and freed its id_A and used it again when sending the open
> request req_B, but the daemon is still working on req_A, so the
> copen id_A succeeds but operates on req_B.
>=20
> The id that is being used by the kernel will not be allocated here
> so it seems that ida _alloc/free does not prevent reuse either,
> could you elaborate a bit more how this works?
>=20

ida_alloc and free absolutely prevent reuse while the id is in use.
That's sort of the point of those functions. Basically it uses a set of
bitmaps in an xarray to track which IDs are in use, so ida_alloc only
hands out values which are not in use. See the comments over
ida_alloc_range() in lib/idr.c.


> >=20
> > > +			xas_clear_mark(&xas, XA_FREE_MARK);
> > > +			xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> > > +		}
> > >   		xas_unlock(&xas);
> > >   	} while (xas_nomem(&xas, GFP_KERNEL));
> > >  =20
>=20
> Thanks again!
>=20

--=20
Jeff Layton <jlayton@kernel.org>

