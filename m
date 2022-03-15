Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4486E4D9EE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 16:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349683AbiCOPkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349680AbiCOPkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:40:41 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F651302;
        Tue, 15 Mar 2022 08:39:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5062272A6; Tue, 15 Mar 2022 11:39:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5062272A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1647358768;
        bh=jsZMp3Bg3w3pMx3Swoz6Ezy/RdgvP3Q66fIkcqQ4p4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRziIqkLQvuja8PPI6WujoFYdc2rHunwJ0uAK/0FK/1zLeZVA84WXega8OKM3VlYc
         Nn/JFWU6H7ME2ecxP83+8RA5GD5bcWkqV+egInu8z4xLXQ+QMgBJm3Msuq5QOO+isE
         YR90Jmxh1+f67IimNT3ubD4zp60Q8feqIDkGSGJo=
Date:   Tue, 15 Mar 2022 11:39:28 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v16 05/11] NFSD: Update nfs4_get_vfs_file() to handle
 courtesy clients
Message-ID: <20220315153928.GC19168@fieldses.org>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
 <1647051215-2873-6-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647051215-2873-6-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 06:13:29PM -0800, Dai Ngo wrote:
> Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
> reservation conflict with courtesy client.
> 
> If share/access check fails with share denied then check if the
> the conflict was caused by courtesy clients. If that's the case
> then set CLIENT_EXPIRED flag to expire the courtesy clients and
> allow nfs4_get_vfs_file to continue. Client with CLIENT_EXPIRED
> is expired by the laundromat.

I'm not following this code.  I'll see if I can give it another shot
tomorrow, but are you sure it can't be simplified somehow?

Keep in mind, we really don't care about share conflicts much.  I'm not
sure whether anyone actually uses open deny modes, so there's no need to
optimize that case.  I'd be totally fine with expiring things
unnecessarily in the deny mode case, for example.

--b.

> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 91 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2beb0972de88..b16f689f34c3 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4973,9 +4973,75 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
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
> +	}
> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
> +		(access & NFS4_SHARE_DENY_READ &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
> +		(access & NFS4_SHARE_DENY_WRITE &&
> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
> +		return true;
> +	}
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
> +			(!nfs4_check_access_deny_bmap(st,
> +					access, share_access)))
> +			continue;
> +		clp = st->st_stid.sc_client;
> +		if (nfs4_check_and_expire_courtesy_client(clp))
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
> @@ -4991,15 +5057,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
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
> @@ -5050,7 +5130,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>  	unsigned char old_deny_bmap = stp->st_deny_bmap;
>  
>  	if (!test_access(open->op_share_access, stp))
> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>  
>  	/* test and set deny mode */
>  	spin_lock(&fp->fi_lock);
> @@ -5059,7 +5139,10 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>  		set_deny(open->op_share_deny, stp);
>  		fp->fi_share_deny |=
>  				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> -	}
> +	} else if (status == nfserr_share_denied &&
> +		!nfs4_resolve_deny_conflicts_locked(fp, false, stp,
> +			open->op_share_deny, false))
> +		status = nfs_ok;
>  	spin_unlock(&fp->fi_lock);
>  
>  	if (status != nfs_ok)
> @@ -5399,7 +5482,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
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
