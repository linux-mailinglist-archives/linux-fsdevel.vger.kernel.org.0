Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF22712C9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 20:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbjEZSjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 14:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjEZSju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 14:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6EDE65;
        Fri, 26 May 2023 11:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29CDE65265;
        Fri, 26 May 2023 18:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AB1C433D2;
        Fri, 26 May 2023 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685126295;
        bh=v7n0sXhrZiP5MnmX43KkAQxABzOU/qt4D/84aeS9sP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJabg4GWEwhYIlPb/el6csQMtx+/ezRSpEXUxy7KUIebNJoK3TMYVUPGeKMJSqIDd
         0NVyISeQdN1qQy+ISjeJYzja0lKSGFDcaEQbTrvyK2yKF/WClp3RsWk5ozScf87yZ1
         jKvo4spQCXDwkjxUcQvJxcqX4dsYLTXyPgDHIogDTFTarGPWh0JCwD9DJpuxFtH5oR
         59TVi9jpoJjNHFTl6wQTDlmFclU8lGoZM/IvE1hiQ0CM71wx2v5IuuQ/mIq8tt4VbF
         FuEPt2LpS+Y9skhhXsSyJxWvxBQb5hYsDmc3kKUjqsl8DkP2hpA9Qnjv0yYykW4nyc
         Bsp2XJQR5Tt1w==
Date:   Fri, 26 May 2023 14:38:12 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] NFSD: handle GETATTR conflict with write delegation
Message-ID: <ZHD8lDQADV6wUO4V@manet.1015granger.net>
References: <1685122722-18287-1-git-send-email-dai.ngo@oracle.com>
 <1685122722-18287-2-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685122722-18287-2-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 10:38:41AM -0700, Dai Ngo wrote:
> If the GETATTR request on a file that has write delegation in effect
> and the request attributes include the change info and size attribute
> then the write delegation is recalled. The server waits a maximum of
> 90ms for the delegation to be returned before replying NFS4ERR_DELAY
> for the GETATTR.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfs4xdr.c   |  5 +++++
>  fs/nfsd/state.h     |  3 +++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b90b74a5e66e..9f551dbf50d6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8353,3 +8353,51 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>  {
>  	get_stateid(cstate, &u->write.wr_stateid);
>  }
> +
> +/**
> + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
> + * @rqstp: RPC transaction context
> + * @inode: file to be checked for a conflict
> + *

Let's have this comment explain why this is necessary. At the least,
it needs to cite RFC 8881 Section 18.7.4, which REQUIREs a conflicting
write delegation to be gone before the server can respond to a
change/size GETATTR request.


> + * Returns 0 if there is no conflict; otherwise an nfs_stat
> + * code is returned.
> + */
> +__be32
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
> +{
> +	__be32 status;
> +	int cnt;
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
> +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
> +				spin_unlock(&ctx->flc_lock);
> +				return 0;
> +			}
> +			spin_unlock(&ctx->flc_lock);
> +			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> +			if (status != nfserr_jukebox)
> +				return status;
> +			for (cnt = 3; cnt > 0; --cnt) {
> +				if (!nfsd_wait_for_delegreturn(rqstp, inode))
> +					continue;
> +				return 0;
> +			}

I'd rather not retry here. Can you can say why a 30ms wait is not
sufficient for this case?


> +			return status;
> +		}
> +		break;
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +	return 0;
> +}
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index b83954fc57e3..4590b893dbc8 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2970,6 +2970,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  		if (status)
>  			goto out;
>  	}
> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
> +		if (status)
> +			goto out;
> +	}
>  
>  	err = vfs_getattr(&path, &stat,
>  			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d49d3060ed4f..cbddcf484dba 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>  	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>  	return clp->cl_state == NFSD4_EXPIRABLE;
>  }
> +
> +extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> +				struct inode *inode);
>  #endif   /* NFSD4_STATE_H */
> -- 
> 2.9.5
> 
