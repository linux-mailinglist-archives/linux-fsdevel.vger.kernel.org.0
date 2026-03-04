Return-Path: <linux-fsdevel+bounces-79352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMPeACAtqGlPpQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:01:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2DE1FFF9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE483302C765
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3482571B8;
	Wed,  4 Mar 2026 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Ba2iLRwR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4D1DE8AE;
	Wed,  4 Mar 2026 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629275; cv=none; b=JKn9cjvJTC8065C26NwRtaQAndxvyJOSqzszX53a+3/O206dorvQMrXu+y8XIMrCM+PXYXV0iS6TWmAgjWvZt5UEx6bwK8N+0dK9CKmN+LNq5IQ7X8jMUaHWrqY+c+fbo5AS0zlCY6KdZJI8zZpIKlPkuVfJFingq8+5j94p5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629275; c=relaxed/simple;
	bh=uiKXWtTeZDyaRhQ7zCznF3T0Ytm6IQ0EqLTyPNoEBrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKKoyIjR1bevi5pWbT8wEAK0Iqk1vrlAowxt71RcUh2G/+2LF43BIBgUbA3TpwInmO8ywhG0EWw9UxEiz2wR2ztg7YQ+Z1DfEUkzA0Uc+AAL+JGU4gy5TZF1BmS6PtVxJK9Vlmd194J+xcPNKgfZ0wjLj1qhK5vugefwDyAu8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=Ba2iLRwR; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=4VQEgMxWBXY5mL414IvwloEeIDpX22HoWVaQFQ8XoQg=; b=Ba2iLRwRGNGg9Rho3WAePmvR1I
	Bec0smJoRz+SfNuDLD9DIOEJjci/UVk3b7ylahO+DWj/LoKKCR3mswxRakKLhpYWJGI/Y1thJ6ewl
	dYXAm53p8PGbjM5kAInfJHHlSbDTDlc/XikkdpZNZbs6YkbYI1afS5mF7LsKUmbxye/wJEZSL3/ki
	hUsYQiOt3jlu7U+CQetp3B8NmcIxyY+4jtJaO4UbHXATY2xcudAxvGo5q8sEjWpT6DpS7FLSJimLR
	aghItWS1TwCqzuR6oh6RxpXDAGJQi5iOz1tnr3DTvJwsA0Us6WA7jbwcgqswg/AkLOoogIch8m+4t
	JopWMTiDuo3yJ2g+eBqtQODS3qOZ9z0xE/WSswAqJfz+nszGFGY26EE2l10k5dWRdq/DqvpMmB3Ts
	wT/gKB3k/bbognkq4cC9vBRkbN7WbTwTLQSr6giWUBHi4a71XQstni+8sr8UB3TbFE9mHokwGERYD
	LC4KIItCBPMnQs0YY2jAFCBPHehezsrUpnm0/86YvUwAFQJ0w1F3wt0r7HNJ1uXLN0BffWFzfm6o6
	2cjoedkZ2QzHgv1eo/RU4VUM1TT90ErNvE/hmObXnLXG7BRU4LBrlo/AdMR7TQItYIL5p4VXO0gWu
	1MZsDWy9t1rABhp1wB1jwTaJF8+K6UW90EDtUwL8A=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v3 4/4] 9p: Enable symlink caching in page cache
Date: Wed, 04 Mar 2026 14:01:11 +0100
Message-ID: <1876957.3VsfAaAtOV@weasel>
In-Reply-To:
 <c17ddf1cf0b8962407cf023eb18b30c307c44f50.1772178819.git.repk@triplefau.lt>
References:
 <cover.1772178819.git.repk@triplefau.lt>
 <c17ddf1cf0b8962407cf023eb18b30c307c44f50.1772178819.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: BA2DE1FFF9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79352-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,triplefau.lt:email,crudebyte.com:dkim,crudebyte.com:email]
X-Rspamd-Action: no action

On Friday, 27 February 2026 08:56:55 CET Remi Pommarel wrote:
> Currently, when cache=loose is enabled, file reads are cached in the
> page cache, but symlink reads are not. This patch allows the results
> of p9_client_readlink() to be stored in the page cache, eliminating
> the need for repeated 9P transactions on subsequent symlink accesses.
> 
> This change improves performance for workloads that involve frequent
> symlink resolution.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  fs/9p/vfs_addr.c       | 29 +++++++++++++++--
>  fs/9p/vfs_inode.c      |  6 ++--
>  fs/9p/vfs_inode_dotl.c | 72 +++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 94 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 862164181bac..0683090a5f15 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -70,10 +70,24 @@ static void v9fs_issue_read(struct netfs_io_subrequest
> *subreq) {
>  	struct netfs_io_request *rreq = subreq->rreq;
>  	struct p9_fid *fid = rreq->netfs_priv;
> +	char *target;
>  	unsigned long long pos = subreq->start + subreq->transferred;
> -	int total, err;
> -
> -	total = p9_client_read(fid, pos, &subreq->io_iter, &err);
> +	int total, err, len, n;
> +
> +	if (S_ISLNK(rreq->inode->i_mode)) {
> +		/* p9_client_readlink() must not be called for legacy protocols
> +		 * 9p2000 or 9p2000.u.
> +		 */
> +		BUG_ON(!p9_is_proto_dotl(fid->clnt));

I would have added this to p9_client_readlink() instead, as it is in general a
bug if someone calls that function without 9p2000.L. But I take it that you
wanted to make it clear that way that this context is only executed by
9p2000.L in the first place, so OK.

> +		err = p9_client_readlink(fid, &target);
> +		len = strnlen(target, PAGE_SIZE - 1);
> +		n = copy_to_iter(target, len, &subreq->io_iter);
> +		if (n != len)
> +			err = -EFAULT;
> +		total = i_size_read(rreq->inode);
> +	} else {
> +		total = p9_client_read(fid, pos, &subreq->io_iter, &err);
> +	}
> 
>  	/* if we just extended the file size, any portion not in
>  	 * cache won't be on server and is zeroes */
> @@ -99,6 +113,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest
> *subreq) static int v9fs_init_request(struct netfs_io_request *rreq, struct
> file *file) {
>  	struct p9_fid *fid;
> +	struct dentry *dentry;
>  	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
>  			rreq->origin == NETFS_WRITETHROUGH ||
>  			rreq->origin == NETFS_UNBUFFERED_WRITE ||
> @@ -115,6 +130,14 @@ static int v9fs_init_request(struct netfs_io_request
> *rreq, struct file *file) if (!fid)
>  			goto no_fid;
>  		p9_fid_get(fid);
> +	} else if (S_ISLNK(rreq->inode->i_mode)){

Nit: missing space between ) and {

Except of that:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

/Christian

> +		dentry = d_find_alias(rreq->inode);
> +		if (!dentry)
> +			goto no_fid;
> +		fid = v9fs_fid_lookup(dentry);
> +		dput(dentry);
> +		if (IS_ERR(fid))
> +			goto no_fid;
>  	} else {
>  		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
>  		if (!fid)
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index c82db6fe0c39..98644f27d6f1 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -302,10 +302,12 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
>  			goto error;
>  		}
> 
> -		if (v9fs_proto_dotl(v9ses))
> +		if (v9fs_proto_dotl(v9ses)) {
>  			inode->i_op = &v9fs_symlink_inode_operations_dotl;
> -		else
> +			inode_nohighmem(inode);
> +		} else {
>  			inode->i_op = &v9fs_symlink_inode_operations;
> +		}
> 
>  		break;
>  	case S_IFDIR:
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 643e759eacb2..a286a078d6a6 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -686,9 +686,13 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct
> inode *dir, int err;
>  	kgid_t gid;
>  	const unsigned char *name;
> +	umode_t mode;
> +	struct v9fs_session_info *v9ses;
>  	struct p9_qid qid;
>  	struct p9_fid *dfid;
>  	struct p9_fid *fid = NULL;
> +	struct inode *inode;
> +	struct posix_acl *dacl = NULL, *pacl = NULL;
> 
>  	name = dentry->d_name.name;
>  	p9_debug(P9_DEBUG_VFS, "%lu,%s,%s\n", dir->i_ino, name, symname);
> @@ -702,6 +706,14 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct
> inode *dir,
> 
>  	gid = v9fs_get_fsgid_for_create(dir);
> 
> +	/* Update mode based on ACL value */
> +	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
> +	if (err) {
> +		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in mknod %d\n",
> +			 err);
> +		goto error;
> +	}
> +
>  	/* Server doesn't alter fid on TSYMLINK. Hence no need to clone it. */
>  	err = p9_client_symlink(dfid, name, symname, gid, &qid);
> 
> @@ -712,8 +724,30 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct
> inode *dir,
> 
>  	v9fs_invalidate_inode_attr(dir);
> 
> +	/* instantiate inode and assign the unopened fid to the dentry */
> +	fid = p9_client_walk(dfid, 1, &name, 1);
> +	if (IS_ERR(fid)) {
> +		err = PTR_ERR(fid);
> +		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
> +			 err);
> +		goto error;
> +	}
> +
> +	v9ses = v9fs_inode2v9ses(dir);
> +	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
> +	if (IS_ERR(inode)) {
> +		err = PTR_ERR(inode);
> +		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
> +			 err);
> +		goto error;
> +	}
> +	v9fs_set_create_acl(inode, fid, dacl, pacl);
> +	v9fs_fid_add(dentry, &fid);
> +	d_instantiate(dentry, inode);
> +	err = 0;
>  error:
>  	p9_fid_put(fid);
> +	v9fs_put_acl(dacl, pacl);
>  	p9_fid_put(dfid);
>  	return err;
>  }
> @@ -853,24 +887,23 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct
> inode *dir, }
> 
>  /**
> - * v9fs_vfs_get_link_dotl - follow a symlink path
> + * v9fs_vfs_get_link_nocache_dotl - Resolve a symlink directly.
> + *
> + * To be used when symlink caching is not enabled.
> + *
>   * @dentry: dentry for symlink
>   * @inode: inode for symlink
>   * @done: destructor for return value
>   */
> -
>  static const char *
> -v9fs_vfs_get_link_dotl(struct dentry *dentry,
> -		       struct inode *inode,
> -		       struct delayed_call *done)
> +v9fs_vfs_get_link_nocache_dotl(struct dentry *dentry,
> +			       struct inode *inode,
> +			       struct delayed_call *done)
>  {
>  	struct p9_fid *fid;
>  	char *target;
>  	int retval;
> 
> -	if (!dentry)
> -		return ERR_PTR(-ECHILD);
> -
>  	p9_debug(P9_DEBUG_VFS, "%pd\n", dentry);
> 
>  	fid = v9fs_fid_lookup(dentry);
> @@ -884,6 +917,29 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
>  	return target;
>  }
> 
> +/**
> + * v9fs_vfs_get_link_dotl - follow a symlink path
> + * @dentry: dentry for symlink
> + * @inode: inode for symlink
> + * @done: destructor for return value
> + */
> +static const char *
> +v9fs_vfs_get_link_dotl(struct dentry *dentry,
> +		       struct inode *inode,
> +		       struct delayed_call *done)
> +{
> +	struct v9fs_session_info *v9ses;
> +
> +	if (!dentry)
> +		return ERR_PTR(-ECHILD);
> +
> +	v9ses = v9fs_inode2v9ses(inode);
> +	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
> +		return page_get_link(dentry, inode, done);
> +
> +	return v9fs_vfs_get_link_nocache_dotl(dentry, inode, done);
> +}
> +
>  int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
>  {
>  	struct p9_stat_dotl *st;




