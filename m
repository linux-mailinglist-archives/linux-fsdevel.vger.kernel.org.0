Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46B788E6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjHYSQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHYSQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C77E272E;
        Fri, 25 Aug 2023 11:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4029663CF0;
        Fri, 25 Aug 2023 18:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40DDC433C8;
        Fri, 25 Aug 2023 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692987365;
        bh=BN1/EWAmb45aMN+a6vKUvJgEIwz3gX0aZC8XPOEDzd4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t1mP2uDlNtadgA+pqxe3YYAzoWjx7l06JhVz5JG3gR6AsFh1rPq7+zHuXMwHV0JiS
         7sihUH83epzHd3pRXmB10VMHJVPJ8DEm8u3uL28OQyGMtKyDDsOhiakSQvzRYDowy8
         /BOnH7sHHUpUIt8phZUzvk+QDtbAvTeyeOR945rGxvmbJUdVRnQZkOv24HOgqwjZk0
         Cko9YQqx8/yK6nA132Z/VZdvc5laSg94PPjgLJYUcT+u8qpSwYqqVPf4d3BzS4a1Ap
         AYi+Zi9L9MRslKqoCbT3g3+ktNSJqD1PAYBc2yHfH/RcfNkpYEuo60J+tNsv8room5
         Laz0gCfnnZbtg==
Message-ID: <dc4cb39baf9e8d503e0c79ddc4d1ada1eba97ecb.camel@kernel.org>
Subject: Re: [PATCH 3/7] lockd: fix race in async lock request handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Fri, 25 Aug 2023 14:16:03 -0400
In-Reply-To: <20230823213352.1971009-4-aahringo@redhat.com>
References: <20230823213352.1971009-1-aahringo@redhat.com>
         <20230823213352.1971009-4-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-08-23 at 17:33 -0400, Alexander Aring wrote:
> This patch fixes a race in async lock request handling between adding
> the relevant struct nlm_block to nlm_blocked list after the request was
> sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of the
> nlm_block in the nlm_blocked list. It could be that the async request is
> completed before the nlm_block was added to the list. This would end
> in a -ENOENT and a kernel log message of "lockd: grant for unknown
> block".
>=20
> To solve this issue we add the nlm_block before the vfs_lock_file() call
> to be sure it has been added when a possible nlmsvc_grant_deferred() is
> called. If the vfs_lock_file() results in an case when it wouldn't be
> added to nlm_blocked list, the nlm_block struct will be removed from
> this list again.
>=20
> The introducing of the new B_PENDING_CALLBACK nlm_block flag will handle
> async lock requests on a pending lock requests as a retry on the caller
> level to hit the -EAGAIN case.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index aa4174fbaf5b..3b158446203b 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -546,6 +546,9 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>  		ret =3D nlm_lck_blocked;
>  		goto out;
>  	}
> +
> +	/* Append to list of blocked */
> +	nlmsvc_insert_block_locked(block, NLM_NEVER);
>  	spin_unlock(&nlm_blocked_lock);
> =20
>  	if (!wait)
> @@ -557,9 +560,12 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file =
*file,
>  	dprintk("lockd: vfs_lock_file returned %d\n", error);
>  	switch (error) {
>  		case 0:
> +			nlmsvc_remove_block(block);
>  			ret =3D nlm_granted;
>  			goto out;
>  		case -EAGAIN:
> +			if (!wait)
> +				nlmsvc_remove_block(block);
>  			ret =3D async_block ? nlm_lck_blocked : nlm_lck_denied;
>  			goto out;
>  		case FILE_LOCK_DEFERRED:
> @@ -570,17 +576,16 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
>  			ret =3D nlmsvc_defer_lock_rqst(rqstp, block);
>  			goto out;
>  		case -EDEADLK:
> +			nlmsvc_remove_block(block);
>  			ret =3D nlm_deadlock;
>  			goto out;
>  		default:			/* includes ENOLCK */
> +			nlmsvc_remove_block(block);
>  			ret =3D nlm_lck_denied_nolocks;
>  			goto out;
>  	}
> =20
>  	ret =3D nlm_lck_blocked;
> -
> -	/* Append to list of blocked */
> -	nlmsvc_insert_block(block, NLM_NEVER);
>  out:
>  	mutex_unlock(&file->f_mutex);
>  	nlmsvc_release_block(block);

Reviewed-by: Jeff Layton <jlayton@kernel.org>
