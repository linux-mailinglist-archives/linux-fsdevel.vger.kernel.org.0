Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4E77E094
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 13:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbjHPLiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 07:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244697AbjHPLhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449081BFB;
        Wed, 16 Aug 2023 04:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D36DC6664B;
        Wed, 16 Aug 2023 11:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C8BC433C7;
        Wed, 16 Aug 2023 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692185865;
        bh=RL4m4ONn3JQ2aJBR+dWTncFryUjjHtRlbcL+rnTLBJQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ElSdhCW2SgW0LGYw1qdRbeF4aaUkZTfSbwgJkNzEQi74ozYVNsp5Yf/XjHj+oN0Dl
         1R1og3BX4xR2gOeZuvgQwISBZhJ+Bs9WaMyhPamZNfQqhqy6dlD+/BKWWzFye0brrV
         sMdkjuOZ172KF9MPA14XyxQJu+nu5k+PJxZpYUCyYeSD24IxlN2MH0slrbD6gLFrO+
         dd/93H3icHfSQyKMZ1wGf35vP2cdFAcoTaAVLxDMDjw6942Z72gu42cW6/urI8qcXv
         Ud3WzdN9C/CeOJVxXMd1rbkZQaps22haTrHskTtOvzJttL6kwL3Z7UX6zoDVEZliFk
         5vBgZXQJIcZrw==
Message-ID: <88ec807d16a7eb2be252eea0c10e3374c01da1bf.camel@kernel.org>
Subject: Re: [RFCv2 2/7] lockd: FILE_LOCK_DEFERRED only on FL_SLEEP
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Wed, 16 Aug 2023 07:37:42 -0400
In-Reply-To: <20230814211116.3224759-3-aahringo@redhat.com>
References: <20230814211116.3224759-1-aahringo@redhat.com>
         <20230814211116.3224759-3-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> This patch removes to handle non-blocking lock requests as asynchronous
> lock request returning FILE_LOCK_DEFERRED. When fl_lmops and lm_grant()
> is set and a non-blocking lock request returns FILE_LOCK_DEFERRED will
> end in an WARNING to signal the user the misusage of the API.
>=20

Probably need to rephrase the word salad in the first sentence of the
commit log. I had to go over it a few times to understand what was going
on here.

In any case, I'm guessing that the idea here is that GFS2/DLM shouldn't
ever return FILE_LOCK_DEFERRED if this is a non-wait request (i.e.
someone called F_SETLK instead of F_SETLKW)?

That may be ok, but again, lockd goes to great lengths to avoid blocking
and I think it's generally a good idea. If an upcall to DLM can take a
long time, it might be a good idea to continue to allow a !wait request
to return FILE_LOCK_DEFERRED.

I guess this really depends on the current behavior today though. Does
DLM ever return FILE_LOCK_DEFERRED on a non-blocking lock request?


> The reason why we moving to make non-blocking lock request as
> synchronized call is that we already doing this behaviour for unlock or
> cancellation as well. Those are POSIX lock operations which are handled
> in an synchronized way and waiting for an answer. For non-blocking lock
> requests the answer will probably arrive in the same time as unlock or
> cancellation operations as those are trylock operations only.
>=20
> In case of a blocking lock request we need to have it asynchronously
> because the time when the lock request getting granted is unknown.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c | 39 +++++++--------------------------------
>  1 file changed, 7 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 7d63524bdb81..1e74a578d7de 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -440,31 +440,6 @@ static void nlmsvc_freegrantargs(struct nlm_rqst *ca=
ll)
>  	locks_release_private(&call->a_args.lock.fl);
>  }
> =20
> -/*
> - * Deferred lock request handling for non-blocking lock
> - */
> -static __be32
> -nlmsvc_defer_lock_rqst(struct svc_rqst *rqstp, struct nlm_block *block)
> -{
> -	__be32 status =3D nlm_lck_denied_nolocks;
> -
> -	block->b_flags |=3D B_QUEUED;
> -
> -	nlmsvc_insert_block(block, NLM_TIMEOUT);
> -
> -	block->b_cache_req =3D &rqstp->rq_chandle;
> -	if (rqstp->rq_chandle.defer) {
> -		block->b_deferred_req =3D
> -			rqstp->rq_chandle.defer(block->b_cache_req);
> -		if (block->b_deferred_req !=3D NULL)
> -			status =3D nlm_drop_reply;
> -	}
> -	dprintk("lockd: nlmsvc_defer_lock_rqst block %p flags %d status %d\n",
> -		block, block->b_flags, ntohl(status));
> -
> -	return status;
> -}
> -
>  /*
>   * Attempt to establish a lock, and if it can't be granted, block it
>   * if required.
> @@ -569,14 +544,14 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
>  			ret =3D async_block ? nlm_lck_blocked : nlm_lck_denied;
>  			goto out_cb_mutex;
>  		case FILE_LOCK_DEFERRED:
> -			block->b_flags |=3D B_PENDING_CALLBACK;
> +			/* lock requests without waiters are handled in
> +			 * a non async way. Let assert this to inform
> +			 * the user about a API violation.
> +			 */
> +			WARN_ON_ONCE(!wait);
> =20
> -			if (wait)
> -				break;
> -			/* Filesystem lock operation is in progress
> -			   Add it to the queue waiting for callback */
> -			ret =3D nlmsvc_defer_lock_rqst(rqstp, block);
> -			goto out_cb_mutex;
> +			block->b_flags |=3D B_PENDING_CALLBACK;
> +			break;
>  		case -EDEADLK:
>  			nlmsvc_remove_block(block);
>  			ret =3D nlm_deadlock;

--=20
Jeff Layton <jlayton@kernel.org>
