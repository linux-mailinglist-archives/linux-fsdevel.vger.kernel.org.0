Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5534E326F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 22:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiCUVtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 17:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiCUVtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:49:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD8D294A13;
        Mon, 21 Mar 2022 14:45:52 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A9E2C5EE6; Mon, 21 Mar 2022 17:44:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A9E2C5EE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1647899040;
        bh=FAzW/zVpXr0zQECDNwtnKCDV3GaXWpTL6X+c4iIExDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHtffhq1rYTj5zY24c0jx9Vu2W/IgR5x2fJngV4EAlSvz2Ii6Pwhill6cCZb9doPj
         9jcvPc1oJS1rStly7aFBRJkKVD8IKpwzC1O8s4Z9ys2ZU+ATFmMKLWC85L6JMsfxPw
         RuMqr1igTVA3FRmxzV22z5Asl9y7zEAmwUnws7pY=
Date:   Mon, 21 Mar 2022 17:44:00 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v17 05/11] NFSD: Update nfs4_get_vfs_file() to handle
 courtesy client
Message-ID: <20220321214400.GA19715@fieldses.org>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
 <1647503028-11966-6-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647503028-11966-6-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:43:42AM -0700, Dai Ngo wrote:
> Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
> reservation conflict with courtesy client.
> 
> Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
> reservation conflict with courtesy client.
> 
> When we have deny/access conflict we walk the fi_stateids of the
> file in question, looking for open stateid and check the deny/access
> of that stateid against the one from the open request. If there is
> a conflict then we check if the client that owns that stateid is
> a courtesy client. If it is then we set the client state to
> CLIENT_EXPIRED and allow the open request to continue. We have
> to scan all the stateid's of the file since the conflict can be
> caused by multiple open stateid's.
> 
> Client with CLIENT_EXPIRED is expired by the laundromat.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 91 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index f20c75890594..c6b5e05c9c34 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4950,9 +4950,75 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>  	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>  }
>  
> +static bool
> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
> +			bool share_access)
> +{
> +	if (share_access) {
> +		if (!stp->st_deny_bmap)
> +			return false;
> +
> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
> +			(access & NFS4_SHARE_ACCESS_READ &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
> +			(access & NFS4_SHARE_ACCESS_WRITE &&
> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
> +			return true;
> +		}
> +		return false;

Looks like you could do this with just:

		return share_access & bmap_to_share_mode(stp->st_deny_bmap);


> +	}
> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
> +		(access & NFS4_SHARE_DENY_READ &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
> +		(access & NFS4_SHARE_DENY_WRITE &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
> +		return true;
> +	}

Likewise.

Also, I think it'd be simpler to check for both access and deny
conflicts here, instead of just one or the other.

> +	return false;
> +}
> +
> +/*
> + * Check whether courtesy clients have conflicting access
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
> + *	true   - access/deny mode conflict with normal client.
> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
> + */
> +static bool
> +nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> +{
> +	struct nfs4_ol_stateid *st;
> +	struct nfs4_client *clp;
> +	bool conflict = false;
> +
> +	lockdep_assert_held(&fp->fi_lock);
> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
> +		if (st->st_openstp || (st == stp && new_stp) ||

I'd split this into separate if statements and add a comment at least
for the st_openstp case, which isn't too obvious:

		if (st->st_openstp) /* ignore lock stateids */
			continue;

> +			(!nfs4_check_access_deny_bmap(st,
> +					access, share_access)))
> +			continue;
> +		clp = st->st_stid.sc_client;
> +		if (nfsd4_expire_courtesy_clnt(clp))
> +			continue;
> +		conflict = true;
> +		break;
> +	}
> +	return conflict;
> +}
> +
>  static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>  		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
> -		struct nfsd4_open *open)
> +		struct nfsd4_open *open, bool new_stp)
>  {
>  	struct nfsd_file *nf = NULL;
>  	__be32 status;
> @@ -4968,15 +5034,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>  	 */
>  	status = nfs4_file_check_deny(fp, open->op_share_deny);
>  	if (status != nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status != nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
> +				stp, open->op_share_deny, false)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
>  	}
>  
>  	/* set access to the file */
>  	status = nfs4_file_get_access(fp, open->op_share_access);
>  	if (status != nfs_ok) {
> -		spin_unlock(&fp->fi_lock);
> -		goto out;
> +		if (status != nfserr_share_denied) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
> +		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
> +				stp, open->op_share_access, true)) {
> +			spin_unlock(&fp->fi_lock);
> +			goto out;
> +		}
>  	}
>  
>  	/* Set access bits in stateid */
> @@ -5027,7 +5107,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>  	unsigned char old_deny_bmap = stp->st_deny_bmap;
>  
>  	if (!test_access(open->op_share_access, stp))
> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>  
>  	/* test and set deny mode */
>  	spin_lock(&fp->fi_lock);
> @@ -5036,7 +5116,10 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>  		set_deny(open->op_share_deny, stp);
>  		fp->fi_share_deny |=
>  				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> -	}
> +	} else if (status == nfserr_share_denied &&
> +		!nfs4_resolve_deny_conflicts_locked(fp, false, stp,
> +			open->op_share_deny, false))

Looks to me like these nfs4_resolve_deny_conflicts_locked() calls could
go into nfs4_file_check_deny and nfs4_file_get_access instead.

--b.

> +		status = nfs_ok;
>  	spin_unlock(&fp->fi_lock);
>  
>  	if (status != nfs_ok)
> @@ -5376,7 +5459,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  			goto out;
>  		}
>  	} else {
> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>  		if (status) {
>  			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>  			release_open_stateid(stp);
> -- 
> 2.9.5
