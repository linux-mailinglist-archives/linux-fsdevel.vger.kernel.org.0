Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4104E48A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 22:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiCVVwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 17:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbiCVVvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:51:52 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01672674F5;
        Tue, 22 Mar 2022 14:50:23 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2665F72C6; Tue, 22 Mar 2022 17:50:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2665F72C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1647985823;
        bh=4zP0pIJc2qHmjGMC2LudiwpznnevC8oMBvzNghI9J/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yDmrwKUu4+QOMjJc9xt/C9ApF8Uzgl5wD3s50a5mCA0ny5GZ0xP63Wb7ebcnNqgDI
         lVas4m2PyegIQFpUWb5MVJGZgGtsNEIeK/bHncSWRn1fljRfRCOUJdNhMx8v06zx53
         qzmlqsCi+gr3f4EjdJ/TzpnQwAwB4L3EiBqAsn4s=
Date:   Tue, 22 Mar 2022 17:50:23 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v17 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Message-ID: <20220322215023.GA13980@fieldses.org>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
 <1647503028-11966-7-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647503028-11966-7-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:43:43AM -0700, Dai Ngo wrote:
> Update find_clp_in_name_tree to check and expire courtesy client.
> 
> Update find_confirmed_client_by_name to discard the courtesy
> client by setting CLIENT_EXPIRED.
> 
> Update nfsd4_setclientid to expire client with CLIENT_EXPIRED
> state to prevent multiple confirmed clients with the same name
> on the conf_id_hashtbl list.

I could use a little more "why" here.

I'll give it another read, but right now I'm just not understanding how
this is meant to work.

--b.

> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 27 ++++++++++++++++++++++++---
>  fs/nfsd/state.h     | 22 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c6b5e05c9c34..dc0e60bf694c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2834,8 +2834,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>  			node = node->rb_left;
>  		else if (cmp < 0)
>  			node = node->rb_right;
> -		else
> +		else {
> +			if (nfsd4_courtesy_clnt_expired(clp))
> +				return NULL;
>  			return clp;
> +		}
>  	}
>  	return NULL;
>  }
> @@ -2914,8 +2917,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
>  static struct nfs4_client *
>  find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
>  {
> +	struct nfs4_client *clp;
> +
>  	lockdep_assert_held(&nn->client_lock);
> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
> +	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
> +	if (clp && clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
> +		nfsd4_discard_courtesy_clnt(clp);
> +		clp = NULL;
> +	}
> +	return clp;
>  }
>  
>  static struct nfs4_client *
> @@ -4032,12 +4042,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct nfs4_client	*unconf = NULL;
>  	__be32 			status;
>  	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfs4_client	*cclient = NULL;
>  
>  	new = create_client(clname, rqstp, &clverifier);
>  	if (new == NULL)
>  		return nfserr_jukebox;
>  	spin_lock(&nn->client_lock);
> -	conf = find_confirmed_client_by_name(&clname, nn);
> +	/* find confirmed client by name */
> +	conf = find_clp_in_name_tree(&clname, &nn->conf_name_tree);
> +	if (conf && conf->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
> +		cclient = conf;
> +		conf = NULL;
> +	}
> +
>  	if (conf && client_has_state(conf)) {
>  		status = nfserr_clid_inuse;
>  		if (clp_used_exchangeid(conf))
> @@ -4068,7 +4085,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	new = NULL;
>  	status = nfs_ok;
>  out:
> +	if (cclient)
> +		unhash_client_locked(cclient);
>  	spin_unlock(&nn->client_lock);
> +	if (cclient)
> +		expire_client(cclient);
>  	if (new)
>  		free_client(new);
>  	if (unconf) {
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d156ae3ab46c..14b2c158ccca 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -735,6 +735,7 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>  extern int nfsd4_client_record_check(struct nfs4_client *clp);
>  extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>  
> +/* courteous server */
>  static inline bool
>  nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
>  {
> @@ -749,4 +750,25 @@ nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
>  	return rc;
>  }
>  
> +static inline void
> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
> +{
> +	spin_lock(&clp->cl_cs_lock);
> +	clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
> +	spin_unlock(&clp->cl_cs_lock);
> +}
> +
> +static inline bool
> +nfsd4_courtesy_clnt_expired(struct nfs4_client *clp)
> +{
> +	bool rc = false;
> +
> +	spin_lock(&clp->cl_cs_lock);
> +	if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
> +		rc = true;
> +	if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY)
> +		clp->cl_cs_client_state = NFSD4_CLIENT_RECONNECTED;
> +	spin_unlock(&clp->cl_cs_lock);
> +	return rc;
> +}
>  #endif   /* NFSD4_STATE_H */
> -- 
> 2.9.5
