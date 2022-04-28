Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42B512953
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 04:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiD1CI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 22:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiD1CIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:08:25 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323013F5F;
        Wed, 27 Apr 2022 19:05:11 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 854591506; Wed, 27 Apr 2022 22:05:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 854591506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651111511;
        bh=QCkmNtSPy65RomWZIe/Vs0ux8LiQsEUhiCrAcC59kC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTNLtXTgfc9kocTyow1/UJ8elexj4MqVaQ7Fs5pZrWgW+YGZGI+cnqZcxk9kB+NIF
         omoO0prchATZ/SMuD3YiMmwr2sMgdF5JHktf/dbiQR2QtVdh0JxB1UWEWNe2lIawiY
         nhr6JjUwdnXDcg2hzRO+3yMImy3cFWmCaCTdyUP8=
Date:   Wed, 27 Apr 2022 22:05:11 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v22 6/7] NFSD: add support for lock conflict to
 courteous server
Message-ID: <20220428020511.GK13471@fieldses.org>
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-7-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651049573-29552-7-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 01:52:52AM -0700, Dai Ngo wrote:
> This patch allows expired client with lock state to be in COURTESY
> state. Lock conflict with COURTESY client is resolved by the fs/lock
> code using the lm_lock_expirable and lm_expire_lock callback in the
> struct lock_manager_operations.
> 
> If conflict client is in COURTESY state, set it to EXPIRABLE and
> schedule the laundromat to run immediately to expire the client. The
> callback lm_expire_lock waits for the laundromat to flush its work
> queue before returning to caller.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 82 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 55ecf5da25fe..9b1134d823bb 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5705,11 +5705,31 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>  }
>  #endif
>  
> +/* Check if any lock belonging to this lockowner has any blockers */
>  static bool
> -nfs4_has_any_locks(struct nfs4_client *clp)
> +nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
> +{
> +	struct file_lock_context *ctx;
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_file *nf;
> +
> +	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
> +		nf = stp->st_stid.sc_file;
> +		ctx = nf->fi_inode->i_flctx;
> +		if (!ctx)
> +			continue;
> +		if (locks_owner_has_blockers(ctx, lo))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool
> +nfs4_anylock_blockers(struct nfs4_client *clp)
>  {
>  	int i;
>  	struct nfs4_stateowner *so;
> +	struct nfs4_lockowner *lo;
>  
>  	spin_lock(&clp->cl_lock);
>  	for (i = 0; i < OWNER_HASH_SIZE; i++) {
> @@ -5717,40 +5737,17 @@ nfs4_has_any_locks(struct nfs4_client *clp)
>  				so_strhash) {
>  			if (so->so_is_open_owner)
>  				continue;
> -			spin_unlock(&clp->cl_lock);
> -			return true;
> +			lo = lockowner(so);
> +			if (nfs4_lockowner_has_blockers(lo)) {
> +				spin_unlock(&clp->cl_lock);
> +				return true;
> +			}
>  		}
>  	}
>  	spin_unlock(&clp->cl_lock);
>  	return false;
>  }
>  
> -/*
> - * place holder for now, no check for lock blockers yet
> - */
> -static bool
> -nfs4_anylock_blockers(struct nfs4_client *clp)
> -{
> -	/* not allow locks yet */
> -	if (nfs4_has_any_locks(clp))
> -		return true;
> -	/*
> -	 * don't want to check for delegation conflict here since
> -	 * we need the state_lock for it. The laundromat willexpire
> -	 * COURTESY later when checking for delegation recall timeout.
> -	 */
> -	return false;
> -}
> -
> -static bool client_has_state_tmp(struct nfs4_client *clp)
> -{
> -	if (((!list_empty(&clp->cl_delegations)) ||
> -			client_has_openowners(clp)) &&
> -			list_empty(&clp->async_copies))
> -		return true;
> -	return false;
> -}
> -
>  static void
>  nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>  				struct laundry_time *lt)
> @@ -5767,7 +5764,7 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>  			goto exp_client;
>  		if (!state_expired(lt, clp->cl_time))
>  			break;
> -		if (!client_has_state_tmp(clp))
> +		if (!client_has_state(clp))
>  			goto exp_client;
>  		cour = (clp->cl_state == NFSD4_COURTESY);
>  		if (cour && ktime_get_boottime_seconds() >=
> @@ -6722,6 +6719,28 @@ nfsd4_lm_put_owner(fl_owner_t owner)
>  		nfs4_put_stateowner(&lo->lo_owner);
>  }
>  
> +/* return pointer to struct nfs4_client if client is expirable */
> +static void *
> +nfsd4_lm_lock_expirable(struct file_lock *cfl)
> +{
> +	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)cfl->fl_owner;
> +	struct nfs4_client *clp = lo->lo_owner.so_client;
> +
> +	if (!try_to_expire_client(clp))
> +		return clp;
> +	return NULL;
> +}
> +
> +/* schedule laundromat to run immediately and wait for it to complete */
> +static void
> +nfsd4_lm_expire_lock(void *data)
> +{
> +	struct nfs4_client *clp = (struct nfs4_client *)data;
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> +
> +	flush_workqueue(laundry_wq);

Note we don't actually end up using the nfsd_net, or the argument to
lm_lock_expirable.  This was a mistake in my original sketch.  See

	https://lore.kernel.org/linux-nfs/20220417190727.GA18120@fieldses.org/

	"Correction: I forgot that the laundromat is global, not
	per-net.  So, we can skip the put_net/get_net.  Also,
	lm_lock_expirable can just return bool instead of void *, and
	lm_expire_lock needs no arguments."

--b.

> +}
> +
>  static void
>  nfsd4_lm_notify(struct file_lock *fl)
>  {
> @@ -6748,9 +6767,12 @@ nfsd4_lm_notify(struct file_lock *fl)
>  }
>  
>  static const struct lock_manager_operations nfsd_posix_mng_ops  = {
> +	.lm_mod_owner = THIS_MODULE,
>  	.lm_notify = nfsd4_lm_notify,
>  	.lm_get_owner = nfsd4_lm_get_owner,
>  	.lm_put_owner = nfsd4_lm_put_owner,
> +	.lm_lock_expirable = nfsd4_lm_lock_expirable,
> +	.lm_expire_lock = nfsd4_lm_expire_lock,
>  };
>  
>  static inline void
> -- 
> 2.9.5
