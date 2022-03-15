Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49E4D9E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbiCOPD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiCOPD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:03:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A2755BD7;
        Tue, 15 Mar 2022 08:02:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 15B3248F; Tue, 15 Mar 2022 11:02:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 15B3248F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1647356565;
        bh=vORQ/Pgvsh8pVaK+fYzhn/ikhqWHXA8LAbqiSoHemdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brtV6+UaWQZ0/yeSRzSJWds9/zAPEXzB1p1VjiHWhDX5vlbrqBn5qewOy2ARfat3R
         royQ7TgeZX+dMI0EZ5aLB6TKM+24/PvJhTzA3MaQo5cJpwPSzCostjE7EvD9FeKgQy
         at/3rA8d35CjxejKDzVne9ZtvaV0W5JTtdwsrRcs=
Date:   Tue, 15 Mar 2022 11:02:45 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v16 03/11] NFSD: Add lm_lock_expired call out
Message-ID: <20220315150245.GA19168@fieldses.org>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-4-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647051215-2873-4-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 06:13:27PM -0800, Dai Ngo wrote:
> Add callout function nfsd4_lm_lock_expired for lm_lock_expired.
> If lock request has conflict with courtesy client then expire the
> courtesy client and return no conflict to caller.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a65d59510681..583ac807e98d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6578,10 +6578,47 @@ nfsd4_lm_notify(struct file_lock *fl)
>  	}
>  }
>  
> +/**
> + * nfsd4_lm_lock_expired - check if lock conflict can be resolved.
> + *
> + * @fl: pointer to file_lock with a potential conflict
> + * Return values:
> + *   %false: real conflict, lock conflict can not be resolved.
> + *   %true: no conflict, lock conflict was resolved.
> + *
> + * Note that this function is called while the flc_lock is held.
> + */
> +static bool
> +nfsd4_lm_lock_expired(struct file_lock *fl)
> +{
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_client *clp;
> +	bool rc = false;
> +
> +	if (!fl)
> +		return false;
> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
> +	clp = lo->lo_owner.so_client;
> +
> +	/* need to sync with courtesy client trying to reconnect */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
> +		rc = true;
> +	else {
> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +			set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
> +			rc =  true;
> +		}
> +	}

I'd prefer:

	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
		rc = true;

Same result, but more compact and straightforward, I think.

--b.

> +	spin_unlock(&clp->cl_cs_lock);
> +	return rc;
> +}
> +
>  static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>  	.lm_notify = nfsd4_lm_notify,
>  	.lm_get_owner = nfsd4_lm_get_owner,
>  	.lm_put_owner = nfsd4_lm_put_owner,
> +	.lm_lock_expired = nfsd4_lm_lock_expired,
>  };
>  
>  static inline void
> -- 
> 2.9.5
