Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54B517294
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385790AbiEBPen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385802AbiEBPel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 11:34:41 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1FB86C;
        Mon,  2 May 2022 08:31:11 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 60525713F; Mon,  2 May 2022 11:31:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 60525713F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651505471;
        bh=KXJ1uBoZns7RI8SUji44iCMQjg3j2uxiNAWZofFuDhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0ZlrmWnJTAdkpPMVsyAwFCvB8EbfmTBVl/Oz13z5h5WVfxfwoWcgSXf+pMcRcGE/
         pMQo4UU6GbFhNbqBYPPdqsdfSN443T8xfEN7XNxBv0CMRBtBTF80EA4ANXIOyTOqJL
         8XTg0ICLGuUdeS32RbayMUIIky4V0CfMX6qYWvkE=
Date:   Mon, 2 May 2022 11:31:11 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v24 2/7] NFSD: add support for share reservation
 conflict to courteous server
Message-ID: <20220502153111.GB30550@fieldses.org>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
 <1651426696-15509-3-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651426696-15509-3-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 01, 2022 at 10:38:11AM -0700, Dai Ngo wrote:
> This patch allows expired client with open state to be in COURTESY
> state. Share/access conflict with COURTESY client is resolved by
> setting COURTESY client to EXPIRABLE state, schedule laundromat
> to run and returning nfserr_jukebox to the request client.
> 

Looks good to me.

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>

--b.

> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 101 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 917eaab45999..0e98e9c16e3e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -694,6 +694,57 @@ static unsigned int file_hashval(struct svc_fh *fh)
>  
>  static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>  
> +/*
> + * Check if courtesy clients have conflicting access and resolve it if possible
> + *
> + * access:  is op_share_access if share_access is true.
> + *	    Check if access mode, op_share_access, would conflict with
> + *	    the current deny mode of the file 'fp'.
> + * access:  is op_share_deny if share_access is false.
> + *	    Check if the deny mode, op_share_deny, would conflict with
> + *	    current access of the file 'fp'.
> + * stp:     skip checking this entry.
> + * new_stp: normal open, not open upgrade.
> + *
> + * Function returns:
> + *	false - access/deny mode conflict with normal client.
> + *	true  - no conflict or conflict with courtesy client(s) is resolved.
> + */
> +static bool
> +nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> +{
> +	struct nfs4_ol_stateid *st;
> +	bool resolvable = true;
> +	unsigned char bmap;
> +	struct nfsd_net *nn;
> +	struct nfs4_client *clp;
> +
> +	lockdep_assert_held(&fp->fi_lock);
> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
> +		/* ignore lock stateid */
> +		if (st->st_openstp)
> +			continue;
> +		if (st == stp && new_stp)
> +			continue;
> +		/* check file access against deny mode or vice versa */
> +		bmap = share_access ? st->st_deny_bmap : st->st_access_bmap;
> +		if (!(access & bmap_to_share_mode(bmap)))
> +			continue;
> +		clp = st->st_stid.sc_client;
> +		if (try_to_expire_client(clp))
> +			continue;
> +		resolvable = false;
> +		break;
> +	}
> +	if (resolvable) {
> +		clp = stp->st_stid.sc_client;
> +		nn = net_generic(clp->net, nfsd_net_id);
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +	}
> +	return resolvable;
> +}
> +
>  static void
>  __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
>  {
> @@ -4969,7 +5020,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>  
>  static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>  		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> -		struct nfsd4_open *open)
> +		struct nfsd4_open *open, bool new_stp)
>  {
>  	struct nfsd_file *nf = NULL;
>  	__be32 status;
> @@ -4985,6 +5036,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>  	 */
>  	status = nfs4_file_check_deny(fp, open->op_share_deny);
>  	if (status != nfs_ok) {
> +		if (status != nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
> +				stp, open->op_share_deny, false))
> +			status = nfserr_jukebox;
>  		spin_unlock(&fp->fi_lock);
>  		goto out;
>  	}
> @@ -4992,6 +5050,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>  	/* set access to the file */
>  	status = nfs4_file_get_access(fp, open->op_share_access);
>  	if (status != nfs_ok) {
> +		if (status != nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
> +				stp, open->op_share_access, true))
> +			status = nfserr_jukebox;
>  		spin_unlock(&fp->fi_lock);
>  		goto out;
>  	}
> @@ -5038,21 +5103,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>  }
>  
>  static __be32
> -nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp, struct nfsd4_open *open)
> +nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
> +		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> +		struct nfsd4_open *open)
>  {
>  	__be32 status;
>  	unsigned char old_deny_bmap = stp->st_deny_bmap;
>  
>  	if (!test_access(open->op_share_access, stp))
> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>  
>  	/* test and set deny mode */
>  	spin_lock(&fp->fi_lock);
>  	status = nfs4_file_check_deny(fp, open->op_share_deny);
>  	if (status == nfs_ok) {
> -		set_deny(open->op_share_deny, stp);
> -		fp->fi_share_deny |=
> +		if (status != nfserr_share_denied) {
> +			set_deny(open->op_share_deny, stp);
> +			fp->fi_share_deny |=
>  				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> +		} else {
> +			if (nfs4_resolve_deny_conflicts_locked(fp, false,
> +					stp, open->op_share_deny, false))
> +				status = nfserr_jukebox;
> +		}
>  	}
>  	spin_unlock(&fp->fi_lock);
>  
> @@ -5393,7 +5466,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  			goto out;
>  		}
>  	} else {
> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>  		if (status) {
>  			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>  			release_open_stateid(stp);
> @@ -5627,6 +5700,26 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>  }
>  #endif
>  
> +static bool
> +nfs4_has_any_locks(struct nfs4_client *clp)
> +{
> +	int i;
> +	struct nfs4_stateowner *so;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
> +		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {
> +			if (so->so_is_open_owner)
> +				continue;
> +			spin_unlock(&clp->cl_lock);
> +			return true;
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
>  /*
>   * place holder for now, no check for lock blockers yet
>   */
> @@ -5634,8 +5727,8 @@ static bool
>  nfs4_anylock_blockers(struct nfs4_client *clp)
>  {
>  	if (atomic_read(&clp->cl_delegs_in_recall) ||
> -			client_has_openowners(clp)  ||
> -			!list_empty(&clp->async_copies))
> +			!list_empty(&clp->async_copies) ||
> +			nfs4_has_any_locks(clp))
>  		return true;
>  	return false;
>  }
> -- 
> 2.9.5
