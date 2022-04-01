Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A277E4EF776
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbiDAP50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 11:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358345AbiDAPqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:46:33 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D21B1D2041;
        Fri,  1 Apr 2022 08:21:10 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4FABA2935; Fri,  1 Apr 2022 11:21:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4FABA2935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1648826469;
        bh=4l3wlpIs4kNvRReXOBmDIJ2f7a/O4+gaNwKWu3ut688=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=galmP6duQKF5oiJQ1aRbMUar5ztI/u16FU8KQfPppgE8sct8iqbIPnsQqVzPwqlzu
         nF5j8gH04DjSYf4X4FiOI54u7yUevYwTiBTCLMYI1NaaVWY21TbvOCH0E5rpfX+3re
         Fhlcp4NLX4vn6jHOT5YNo8X8djsdPofS35PasJJc=
Date:   Fri, 1 Apr 2022 11:21:09 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Message-ID: <20220401152109.GB18534@fieldses.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:02:04AM -0700, Dai Ngo wrote:
> Update find_clp_in_name_tree to check and expire courtesy client.
> 
> Update find_confirmed_client_by_name to discard the courtesy
> client by setting CLIENT_EXPIRED.
> 
> Update nfsd4_setclientid to expire client with CLIENT_EXPIRED
> state to prevent multiple confirmed clients with the same name
> on the conf_name_tree.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 27 ++++++++++++++++++++++++---
>  fs/nfsd/state.h     | 22 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fe8969ba94b3..eadce5d19473 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2893,8 +2893,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
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
> @@ -2973,8 +2976,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
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
....
> +static inline void
> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
> +{
> +	spin_lock(&clp->cl_cs_lock);
> +	clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
> +	spin_unlock(&clp->cl_cs_lock);
> +}

This is a red flag to me.... What guarantees that the condition we just
checked (cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) is still true
here?  Why couldn't another thread have raced in and called
reactivate_courtesy_client?

Should we be holding cl_cs_lock across both the cl_cs_client_state and
the assignment?  Or should reactivate_courtesy_client be taking the
client_lock?

I'm still not clear on the need for the CLIENT_RECONNECTED state.

I think analysis would be a bit simpler if the only states were ACTIVE,
COURTESY, and EXPIRED, the only transitions possible were

	ACTIVE->COURTESY->{EXPIRED or ACTIVE}

and the same lock ensured that those were the only possible transitions.

(And to be honest I'd still prefer the original approach where we expire
clients from the posix locking code and then retry.  It handles an
additional case (the one where reboot happens after a long network
partition), and I don't think it requires adding these new client
states....)

--b.
