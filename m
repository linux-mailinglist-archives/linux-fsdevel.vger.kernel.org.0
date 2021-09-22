Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C474415280
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 23:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhIVVQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbhIVVQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:16:16 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD1C061574;
        Wed, 22 Sep 2021 14:14:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B70A0367; Wed, 22 Sep 2021 17:14:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B70A0367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632345284;
        bh=COD99wavAMRU46pdqs2noxG8QaEqrAA8YTXdBv0f36s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8GgiTIghpAPPnljQJ93brr1qXGhHecPy1aFcrm1c+HXRTwEAktBceWkcGFcGTrUB
         whqhL8/nSL1kFweGy16V3Vzvwf3ZhD39W+nIxIutWnEfy+LtjFpO/sebOj1x95q0A+
         RDm/RzVV8WeAKpRmIKvY55cOZwV8/8Q78N+9LY7g=
Date:   Wed, 22 Sep 2021 17:14:44 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210922211444.GC22937@fieldses.org>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-3-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916182212.81608-3-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 02:22:11PM -0400, Dai Ngo wrote:
> @@ -2389,6 +2395,10 @@ static int client_info_show(struct seq_file *m, void *v)
>  		seq_puts(m, "status: confirmed\n");
>  	else
>  		seq_puts(m, "status: unconfirmed\n");
> +	seq_printf(m, "courtesy client: %s\n",
> +		test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ? "yes" : "no");
> +	seq_printf(m, "last renew: %lld secs\n",

I'd rather keep any units to the left of the colon.  Also, "last renew"
suggests to me that it's the absolute time of the last renew.  Maybe
"seconds since last renew:" ?

> +		ktime_get_boottime_seconds() - clp->cl_time);
>  	seq_printf(m, "name: ");
>  	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>  	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> @@ -4652,6 +4662,42 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>  	nfsd4_run_cb(&dp->dl_recall);
>  }
>  
> +/*
> + * If the conflict happens due to a NFSv4 request then check for
> + * courtesy client and set rq_conflict_client so that upper layer
> + * can destroy the conflict client and retry the call.
> + */
> +static bool
> +nfsd_check_courtesy_client(struct nfs4_delegation *dp)
> +{
> +	struct svc_rqst *rqst;
> +	struct nfs4_client *clp = dp->dl_recall.cb_clp;
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> +	bool ret = false;
> +
> +	if (!i_am_nfsd()) {
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
> +			mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +			return true;
> +		}
> +		return false;
> +	}
> +	rqst = kthread_data(current);
> +	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
> +		return false;
> +	rqst->rq_conflict_client = NULL;
> +
> +	spin_lock(&nn->client_lock);
> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) &&
> +				!mark_client_expired_locked(clp)) {
> +		rqst->rq_conflict_client = clp;
> +		ret = true;
> +	}
> +	spin_unlock(&nn->client_lock);

Check whether this is safe; I think the flc_lock may be taken inside of
this lock elsewhere, resulting in a potential deadlock?

rqst doesn't need any locking as it's only being used by this thread, so
it's the client expiration stuff that's the problem, I guess.

--b.
