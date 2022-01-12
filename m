Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF3B48CC8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 20:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357583AbiALTxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 14:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbiALTwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:52:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC78C061757;
        Wed, 12 Jan 2022 11:52:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id C7B746217; Wed, 12 Jan 2022 14:52:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C7B746217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642017128;
        bh=IRx9/BURO6LUwOmVgG1xNmENJ/qxCB2XAmPn62DsCCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jL5AYpsbmQXWImC12y4cIEtSupX2WVLDLljXG+Hm/eVd7FXxLaVSKqwP5CKbAJDHy
         FLYsfGEeHJSPxFjv8WCRVMJ1GJilfgd09W1CIvJNghSc1gmuvnhbkt4FS4Oso8Afcz
         1owZpPOZ69B3pRvc5qzpSBDgUqKeYz4EeOz+4pxg=
Date:   Wed, 12 Jan 2022 14:52:08 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220112195208.GF10518@fieldses.org>
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
> @@ -4912,7 +4987,128 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>  	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>  }
>  
> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
> +static bool
> +__nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
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
> + * Check all files belong to the specified client to determine if there is
> + * any conflict with the specified access_mode/deny_mode of the file 'fp.
> + *
> + * If share_access is true then 'access' is the access mode. Check if
> + * this access mode conflicts with current deny mode of the file.
> + *
> + * If share_access is false then 'access' the deny mode. Check if
> + * this deny mode conflicts with current access mode of the file.
> + */
> +static bool
> +nfs4_check_access_deny_bmap(struct nfs4_client *clp, struct nfs4_file *fp,
> +		struct nfs4_ol_stateid *st, u32 access, bool share_access)
> +{
> +	int i;
> +	struct nfs4_openowner *oo;
> +	struct nfs4_stateowner *so, *tmp;
> +	struct nfs4_ol_stateid *stp, *stmp;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +					so_strhash) {
> +			if (!so->so_is_open_owner)
> +				continue;
> +			oo = openowner(so);
> +			list_for_each_entry_safe(stp, stmp,
> +				&oo->oo_owner.so_stateids, st_perstateowner) {
> +				if (stp == st || stp->st_stid.sc_file != fp)
> +					continue;
> +				if (__nfs4_check_access_deny_bmap(stp, access,
> +							share_access)) {
> +					spin_unlock(&clp->cl_lock);
> +					return true;
> +				}
> +			}
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
> +/*
> + * This function is called to check whether nfserr_share_denied should
> + * be returning to client.
> + *
> + * access: is op_share_access if share_access is true.
> + *	   Check if access mode, op_share_access, would conflict with
> + *	   the current deny mode of the file 'fp'.
> + * access: is op_share_deny if share_access is true.
> + *	   Check if the deny mode, op_share_deny, would conflict with
> + *	   current access of the file 'fp'.
> + * stp:    skip checking this entry.
> + *
> + * Function returns:
> + *	true  - access/deny mode conflict with courtesy client(s).
> + *		Caller to return nfserr_jukebox while client(s) being expired.
> + *	false - access/deny mode conflict with non-courtesy client.
> + *		Caller to return nfserr_share_denied to client.
> + */
> +static bool
> +nfs4_conflict_courtesy_clients(struct svc_rqst *rqstp, struct nfs4_file *fp,
> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> +{
> +	struct nfs4_client *cl;
> +	bool conflict = false;
> +	int async_cnt = 0;
> +	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +
> +	spin_lock(&nn->client_lock);
> +	list_for_each_entry(cl, &nn->client_lru, cl_lru) {

This means we're manually searching through all the state of every
client each time we find a share conflict.

Well, maybe I'm OK with that.  Share conflicts are not the normal case.
(I'm not sure anyone actually uses them.)  So I guess I don't care if
that case is slow.

It's kind of a lot of code, though, I wish there were a way to simplify.

--b.

> +		if (!nfs4_check_access_deny_bmap(cl, fp, stp, access, share_access))
> +			continue;
> +		spin_lock(&cl->cl_cs_lock);
> +		if (test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
> +			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
> +			async_cnt++;
> +			spin_unlock(&cl->cl_cs_lock);
> +			continue;
> +		}
> +		/* conflict with non-courtesy client */
> +		spin_unlock(&cl->cl_cs_lock);
> +		conflict = false;
> +		break;
> +	}
> +	spin_unlock(&nn->client_lock);
> +	if (async_cnt) {
> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +		conflict = true;
> +	}
> +	return conflict;
> +}
> +
> +static __be32
> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>  		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>  		struct nfsd4_open *open)
>  {
> @@ -4931,6 +5127,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>  	status = nfs4_file_check_deny(fp, open->op_share_deny);
>  	if (status != nfs_ok) {
>  		spin_unlock(&fp->fi_lock);
> +		if (status != nfserr_share_denied)
> +			goto out;
> +		if (nfs4_conflict_courtesy_clients(rqstp, fp,
> +				stp, open->op_share_deny, false))
> +			status = nfserr_jukebox;
>  		goto out;
>  	}
>  
> @@ -4938,6 +5139,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>  	status = nfs4_file_get_access(fp, open->op_share_access);
>  	if (status != nfs_ok) {
>  		spin_unlock(&fp->fi_lock);
> +		if (status != nfserr_share_denied)
> +			goto out;
> +		if (nfs4_conflict_courtesy_clients(rqstp, fp,
> +				stp, open->op_share_access, true))
> +			status = nfserr_jukebox;
>  		goto out;
>  	}
>  
