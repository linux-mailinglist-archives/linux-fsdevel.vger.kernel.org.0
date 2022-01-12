Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08848CC2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 20:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357076AbiALTnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 14:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344396AbiALTli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:41:38 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CDC061757;
        Wed, 12 Jan 2022 11:40:55 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9625A6CEE; Wed, 12 Jan 2022 14:40:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9625A6CEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642016454;
        bh=YQ0iVW06YQi3ayR/AYhXa57dJhumqyxYBBlkh8r+bH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ei4PaNBIN7ZhNvFBLcDqXqJD897uIB6btxL0xIvJDBx1V4dKz/DtuMeZSOpiAF6+p
         VHTjngKHb1z8n0vUnWnA57EYh2E++K5kPTiBXOsLjvcoewkzN2QcAaXSl7T3idSoGy
         d3KS59vlurZsBp5VHQOcQF21qc0rYlPnbJ6x7gZ0=
Date:   Wed, 12 Jan 2022 14:40:54 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220112194054.GD10518@fieldses.org>
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641840653-23059-3-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:50:53AM -0800, Dai Ngo wrote:
>  static time64_t
>  nfs4_laundromat(struct nfsd_net *nn)
>  {
> @@ -5587,7 +5834,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	};
>  	struct nfs4_cpntf_state *cps;
>  	copy_stateid_t *cps_t;
> +	struct nfs4_stid *stid;
>  	int i;
> +	int id;
>  
>  	if (clients_still_reclaiming(nn)) {
>  		lt.new_timeo = 0;
> @@ -5608,8 +5857,41 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	spin_lock(&nn->client_lock);
>  	list_for_each_safe(pos, next, &nn->client_lru) {
>  		clp = list_entry(pos, struct nfs4_client, cl_lru);
> -		if (!state_expired(&lt, clp->cl_time))
> +		spin_lock(&clp->cl_cs_lock);
> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags))
> +			goto exp_client;
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
> +			if (ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
> +				goto exp_client;
> +			/*
> +			 * after umount, v4.0 client is still around
> +			 * waiting to be expired. Check again and if
> +			 * it has no state then expire it.
> +			 */
> +			if (clp->cl_minorversion) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				continue;
> +			}

I'm not following that comment or that logic.

> +		}
> +		if (!state_expired(&lt, clp->cl_time)) {
> +			spin_unlock(&clp->cl_cs_lock);
>  			break;
> +		}
> +		id = 0;
> +		spin_lock(&clp->cl_lock);
> +		stid = idr_get_next(&clp->cl_stateids, &id);
> +		if (stid && !nfs4_anylock_conflict(clp)) {
> +			/* client still has states */

I'm a little confused by that comment.  I think what you just checked is
that the client has some state, *and* nobody is waiting for one of its
locks.  For me, that comment just conufses things.

> +			spin_unlock(&clp->cl_lock);

Is nn->client_lock enough to guarantee that the condition you just
checked still holds?  (Honest question, I'm not sure.)

> +			clp->courtesy_client_expiry =
> +				ktime_get_boottime_seconds() + courtesy_client_expiry;
> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
> +			spin_unlock(&clp->cl_cs_lock);
> +			continue;
> +		}
> +		spin_unlock(&clp->cl_lock);
> +exp_client:
> +		spin_unlock(&clp->cl_cs_lock);
>  		if (mark_client_expired_locked(clp))
>  			continue;
>  		list_add(&clp->cl_lru, &reaplist);

In general this loop is more complicated than the rest of the logic in
nfs4_laundromat(). I'd be looking for ways to simplify it and/or move some
of it into a helper function.

--b.

> @@ -5689,9 +5971,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>  }
