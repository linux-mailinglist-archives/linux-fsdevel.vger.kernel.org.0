Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C383477D156
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbjHORuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 13:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbjHORtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:49:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7F1BCC;
        Tue, 15 Aug 2023 10:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5534665462;
        Tue, 15 Aug 2023 17:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99BDC433C7;
        Tue, 15 Aug 2023 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692121787;
        bh=P35PBORFCYB/nJP0hk8qD7rxMuTtPMu491hRYOxcmkA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ej1JCtS0EXZurbdhVNfNtZQH5wRTc1jtj4JKFJ53X/sVq2/IEs1Tn/AdRzGXeeixQ
         9AZdJReW1KyKrJ5uOTLjr6NFRED9t08nyIJ4yfMJmLSahCV45akW5Qv2b8iureNqV5
         8qroAxoaGsMDdcVJk0JxZbq9Dtvcx+6dgP4bd9fAJlCVcaptEoQsHHoYqNkhFoBpfN
         kgM674HobAMl1C2i68WNSpFK5XKe6/DrNEaZ0/QLbJw73ojB5uhZ9YIk9Qp+gU9pg5
         zeeNZOY52IduBeULg1UllrchtiTmdXUEtPoXvKuH9WG9fGL1LqwUEeIph+O0rxARle
         qH7ZcITw2vbdQ==
Message-ID: <c049f33344990f74c2b88cc3279a913f6ff6f498.camel@kernel.org>
Subject: Re: [RFCv2 1/7] lockd: fix race in async lock request handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Tue, 15 Aug 2023 13:49:45 -0400
In-Reply-To: <20230814211116.3224759-2-aahringo@redhat.com>
References: <20230814211116.3224759-1-aahringo@redhat.com>
         <20230814211116.3224759-2-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
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
>  fs/lockd/svclock.c          | 100 ++++++++++++++++++++++++++----------
>  include/linux/lockd/lockd.h |   2 +
>  2 files changed, 74 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index c43ccdf28ed9..7d63524bdb81 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -133,6 +133,7 @@ nlmsvc_remove_block(struct nlm_block *block)
>  {
>  	if (!list_empty(&block->b_list)) {
>  		spin_lock(&nlm_blocked_lock);
> +		block->b_flags &=3D ~B_PENDING_CALLBACK;
> 		list_del_init(&block->b_list);
>  		spin_unlock(&nlm_blocked_lock);
>  		nlmsvc_release_block(block);
> @@ -232,6 +233,7 @@ nlmsvc_create_block(struct svc_rqst *rqstp, struct nl=
m_host *host,
>  	kref_init(&block->b_count);
>  	INIT_LIST_HEAD(&block->b_list);
>  	INIT_LIST_HEAD(&block->b_flist);
> +	mutex_init(&block->b_cb_mutex);
> =20
>  	if (!nlmsvc_setgrantargs(call, lock))
>  		goto failed_free;
> @@ -289,6 +291,8 @@ static void nlmsvc_free_block(struct kref *kref)
> =20
>  	dprintk("lockd: freeing block %p...\n", block);
> =20
> +	WARN_ON_ONCE(block->b_flags & B_PENDING_CALLBACK);
> +
>  	/* Remove block from file's list of blocks */
>  	list_del_init(&block->b_flist);
>  	mutex_unlock(&file->f_mutex);
> @@ -532,6 +536,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file =
*file,
>  		goto out;
>  	}
> =20
> +	mutex_lock(&block->b_cb_mutex);
> +	if (block->b_flags & B_PENDING_CALLBACK)
> +		goto pending_request;
> +
> +	/* Append to list of blocked */
> +	nlmsvc_insert_block(block, NLM_NEVER);
> +
>  	if (!wait)
>  		lock->fl.fl_flags &=3D ~FL_SLEEP;
>  	mode =3D lock_to_openmode(&lock->fl);
> @@ -541,9 +552,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file =
*file,
>  	dprintk("lockd: vfs_lock_file returned %d\n", error);
>  	switch (error) {
>  		case 0:
> +			nlmsvc_remove_block(block);
>  			ret =3D nlm_granted;
> -			goto out;
> +			goto out_cb_mutex;
>  		case -EAGAIN:
> +			if (!wait)
> +				nlmsvc_remove_block(block);
> +pending_request:
>  			/*
>  			 * If this is a blocking request for an
>  			 * already pending lock request then we need
> @@ -552,26 +567,29 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
>  			if (wait)
>  				break;
>  			ret =3D async_block ? nlm_lck_blocked : nlm_lck_denied;
> -			goto out;
> +			goto out_cb_mutex;
>  		case FILE_LOCK_DEFERRED:
> +			block->b_flags |=3D B_PENDING_CALLBACK;
> +
>  			if (wait)
>  				break;
>  			/* Filesystem lock operation is in progress
>  			   Add it to the queue waiting for callback */
>  			ret =3D nlmsvc_defer_lock_rqst(rqstp, block);
> -			goto out;
> +			goto out_cb_mutex;
>  		case -EDEADLK:
> +			nlmsvc_remove_block(block);
>  			ret =3D nlm_deadlock;
> -			goto out;
> +			goto out_cb_mutex;
>  		default:			/* includes ENOLCK */
> +			nlmsvc_remove_block(block);
>  			ret =3D nlm_lck_denied_nolocks;
> -			goto out;
> +			goto out_cb_mutex;
>  	}
> =20
>  	ret =3D nlm_lck_blocked;
> -
> -	/* Append to list of blocked */
> -	nlmsvc_insert_block(block, NLM_NEVER);
> +out_cb_mutex:
> +	mutex_unlock(&block->b_cb_mutex);
>  out:
>  	mutex_unlock(&file->f_mutex);
>  	nlmsvc_release_block(block);
> @@ -728,34 +746,60 @@ nlmsvc_update_deferred_block(struct nlm_block *bloc=
k, int result)
>  		block->b_flags |=3D B_TIMED_OUT;
>  }
> =20
> +static int __nlmsvc_grant_deferred(struct nlm_block *block,
> +				   struct file_lock *fl,
> +				   int result)
> +{
> +	int rc =3D 0;
> +
> +	dprintk("lockd: nlmsvc_notify_blocked block %p flags %d\n",
> +					block, block->b_flags);
> +	if (block->b_flags & B_QUEUED) {
> +		if (block->b_flags & B_TIMED_OUT) {
> +			rc =3D -ENOLCK;
> +			goto out;
> +		}
> +		nlmsvc_update_deferred_block(block, result);
> +	} else if (result =3D=3D 0)
> +		block->b_granted =3D 1;
> +
> +	nlmsvc_insert_block_locked(block, 0);
> +	svc_wake_up(block->b_daemon);
> +out:
> +	return rc;
> +}
> +
>  static int nlmsvc_grant_deferred(struct file_lock *fl, int result)
>  {
> -	struct nlm_block *block;
> -	int rc =3D -ENOENT;
> +	struct nlm_block *iter, *block =3D NULL;
> +	int rc;
> =20
>  	spin_lock(&nlm_blocked_lock);
> -	list_for_each_entry(block, &nlm_blocked, b_list) {
> -		if (nlm_compare_locks(&block->b_call->a_args.lock.fl, fl)) {
> -			dprintk("lockd: nlmsvc_notify_blocked block %p flags %d\n",
> -							block, block->b_flags);
> -			if (block->b_flags & B_QUEUED) {
> -				if (block->b_flags & B_TIMED_OUT) {
> -					rc =3D -ENOLCK;
> -					break;
> -				}
> -				nlmsvc_update_deferred_block(block, result);
> -			} else if (result =3D=3D 0)
> -				block->b_granted =3D 1;
> -
> -			nlmsvc_insert_block_locked(block, 0);
> -			svc_wake_up(block->b_daemon);
> -			rc =3D 0;
> +	list_for_each_entry(iter, &nlm_blocked, b_list) {
> +		if (nlm_compare_locks(&iter->b_call->a_args.lock.fl, fl)) {
> +			kref_get(&iter->b_count);
> +			block =3D iter;
>  			break;
>  		}
>  	}
>  	spin_unlock(&nlm_blocked_lock);
> -	if (rc =3D=3D -ENOENT)
> -		printk(KERN_WARNING "lockd: grant for unknown block\n");
> +
> +	if (!block) {
> +		pr_warn("lockd: grant for unknown pending block\n");
> +		return -ENOENT;
> +	}
> +
> +	/* don't interfere with nlmsvc_lock() */
> +	mutex_lock(&block->b_cb_mutex);
> +	block->b_flags &=3D ~B_PENDING_CALLBACK;
> +
> +	spin_lock(&nlm_blocked_lock);
> +	WARN_ON_ONCE(list_empty(&block->b_list));
> +	rc =3D __nlmsvc_grant_deferred(block, fl, result);
> +	spin_unlock(&nlm_blocked_lock);
> +	mutex_unlock(&block->b_cb_mutex);
> +
> +	nlmsvc_release_block(block);
>  	return rc;
>  }
> =20
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index f42594a9efe0..91f55458f5fc 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -185,10 +185,12 @@ struct nlm_block {
>  	struct nlm_file *	b_file;		/* file in question */
>  	struct cache_req *	b_cache_req;	/* deferred request handling */
>  	struct cache_deferred_req * b_deferred_req
> +	struct mutex		b_cb_mutex;	/* callback mutex */

There is no mention at all of this new mutex in the changelog or
comments. It's not at all clear to me what this is intended to protect.
In general, with lockd being a single-threaded service, we want to avoid
sleeping locks. This will need some clear justification.

At a glance, it looks like you're trying to use this to hold
B_PENDING_CALLBACK steady while a lock request is being handled. That
suggests that you're using this mutex to serialize access to a section
of code and not one or more specific data structures. We usually like to
avoid that sort of thing, since locks that protect arbitrary sections of
code become difficult to work with over time.

I'm going to go out on a limb here though and suggest that there is
probably a way to solve this problem that doesn't involve adding new
locks.

>  	unsigned int		b_flags;	/* block flags */
>  #define B_QUEUED		1	/* lock queued */
>  #define B_GOT_CALLBACK		2	/* got lock or conflicting lock */
>  #define B_TIMED_OUT		4	/* filesystem too slow to respond */
> +#define B_PENDING_CALLBACK	8	/* pending callback for lock request */
>  };
> =20
>  /*

Do we need this new flag at all? It seems redundant. If we have a block
on the list, then it is sort of by definition "pending callback". If
it's not on the list anymore, then it's not. No?

--=20
Jeff Layton <jlayton@kernel.org>
