Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A706470D17D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 04:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjEWCnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 22:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjEWCnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 22:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F20DE9;
        Mon, 22 May 2023 19:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A540262E11;
        Tue, 23 May 2023 02:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995F8C433EF;
        Tue, 23 May 2023 02:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684809825;
        bh=X8VbVCFKITBC5cqkNteTtbljFMveelWWgEatZbTs04s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuW99+7zpZXnD1XsI5K4iSk8v0vkV2eL5lnirncVrE/GGUupJmCcqlfcs1tghZ+wj
         kqqf5c56A5tUSlBLI+9B9oNtsbpm4VySLoRXxGGcOC2G/5kVU7wqB9FLnLkBFyWM7m
         7/AU8uKRxqd+oI89eD4xT/Ilxysg/pQz+WssuGrooF79vMcj06DqTqR05sb9MWk4vT
         ki09UtS8v6dyujPw5elczqNGfn/rQHmvq7fR5IS80pfa9CdCutOPxcH2KmwveCC2k2
         7HaPl1jikM9nRurG2FbTsxHBBehxMQC1IP0NYppxWBMH7gyefTJLaL7EMpxDFq0yA3
         DoHecIImRNNHw==
Date:   Mon, 22 May 2023 22:43:42 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] NFSD: handle GETATTR conflict with write
 delegation
Message-ID: <ZGwoXtYZP0Z0JgAf@manet.1015granger.net>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-3-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684799560-31663-3-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 04:52:39PM -0700, Dai Ngo wrote:
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the write delegation is recalled and NFS4ERR_DELAY is returned
> for the GETATTR.

Isn't this yet another case where the server should send the
CB_RECALL and wait for it briefly, before resorting to
NFS4ERR_DELAY?


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfs4xdr.c   |  5 +++++
>  fs/nfsd/state.h     |  3 +++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b90b74a5e66e..ea9cd781db5f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8353,3 +8353,40 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>  {
>  	get_stateid(cstate, &u->write.wr_stateid);
>  }
> +
> +__be32
> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode)

As a globally-visible function, this needs a documenting comment, and
please use "nfsd4_" rather than "nfs4_".


> +{
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +	struct nfs4_delegation *dp;
> +
> +	ctx = locks_inode_context(inode);
> +	if (!ctx)
> +		return 0;
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> +		if (fl->fl_flags == FL_LAYOUT ||
> +				fl->fl_lmops != &nfsd_lease_mng_ops)
> +			continue;
> +		if (fl->fl_type == F_WRLCK) {
> +			dp = fl->fl_owner;
> +			/*
> +			 * increment the sc_count to prevent the delegation to
> +			 * be freed while sending the CB_RECALL. The refcount is
> +			 * decremented by nfs4_put_stid in nfsd4_cb_recall_release
> +			 * after the request was sent.
> +			 */
> +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker) ||
> +					!refcount_inc_not_zero(&dp->dl_stid.sc_count)) {
> +				spin_unlock(&ctx->flc_lock);
> +				return 0;
> +			}
> +			spin_unlock(&ctx->flc_lock);
> +			return nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> +		}
> +		break;
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +	return 0;
> +}
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 76db2fe29624..ed09b575afac 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2966,6 +2966,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  		if (status)
>  			goto out;
>  	}
> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> +		status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry));
> +		if (status)
> +			goto out;
> +	}
>  
>  	err = vfs_getattr(&path, &stat,
>  			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d49d3060ed4f..64727a39f0db 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>  	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>  	return clp->cl_state == NFSD4_EXPIRABLE;
>  }
> +
> +extern __be32 nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp,
> +				struct inode *inode);
>  #endif   /* NFSD4_STATE_H */
> -- 
> 2.9.5
> 
