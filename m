Return-Path: <linux-fsdevel+bounces-77027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEUEJdfzjWlw8wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 16:37:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FB912F07B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 16:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2065316D2D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358E2EBB8C;
	Thu, 12 Feb 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="V+S3ga8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACF2E7635;
	Thu, 12 Feb 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910530; cv=none; b=qBMbECwJ7rHY9qtPbfn9Hv3gyxRKeXSQsnYbU/F/fDPVCHNKH0hRfkgLKj8zGRgn70V0ycpjkO7fLgAWfiTTla5VbsZjFiZdwr/bQsGNMgM5DFYfXe4hiHivevKhoei1pI1H/Dr4rdNK6kMJyUQHFPm6TXz9qMGki2OWK3LBKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910530; c=relaxed/simple;
	bh=RvgG1Hojz0gxTMiFY2oYgpXYa17ImuThyavhDz+eI+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp0XGX89kLO83fArFiomvfC/FknTmOK1c1Odb4gtOqFQdeU+bQ9U4gGFD+bxUcZ1iO2jDUmvkx8hILjqAHk52n/dsHCBV/1eh1xTFf5NVJ0diNGZTOi1qch53PnIa7WOAnlMmEQEM+El20cllctDF9L4blML3qA3mziqlf2YnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=V+S3ga8D; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=EcLpryrTcW8sMjqjlNCr1rs/sbV0wZ/th1uenQrCi/M=; b=V+S3ga8DSrsMlLoh+KW5pgyOqJ
	FCR4XGnf1p0pGBx7Ymz+r0uZxTNvzCmQm3iW5s/dYe2Vivkhbq7oV5muF5NzJW8OKTj9dkk/o97xu
	1wnQ2derSKRJd53DCf4HG8CSauUgefXEGr0snADGoS7lISuqsqq7cxIMxmEoOOJqPKqgR27sHevW0
	M45ujXEaegriqDHxImGLSBV9sO2G/RHMALGEYbZGNUKyrAnDohzWfXxP09VBlizkEHORuLpBiHEXk
	oIftplw0O/VH45g556rip4BL6GpE3eCEq7OF/VZeTNumSSlRRMnb+rD+CzY2sEGnKGaUi6Ug7M6D6
	lGEh+X+B3WPukA6XLHauN4ylilORBXi3MaoqD+3nxnna8DmVdMBiKykiHadTMR0xRm7UIQIIETf9T
	Kbn7/TRcDE5fhFeCVNRLM3DiBmJT/tYjFPZZnb71DvI5N58NSJBsFcvjwYvylfnYon/RoZrY00jEZ
	T1GDUgNbZ5z4/Cobi2X0f9oPWBRsEkbwD44UnDpm5YoYyaWMxWW8Sx0Uw7L4mVQNB4wNtbkWuXveJ
	V99T1t11jz0LQ/n2isSmPlxGXCtpdM5ntxV80sAEwU9Q3/b6ZDFuKSkzxloNn/jjqLGF2kS2zgas6
	ke+6TmQ5pRKJI2BKZy4n51cMhsW4+/I8j8sEACJQM=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 3/3] 9p: Enable symlink caching in page cache
Date: Thu, 12 Feb 2026 16:35:24 +0100
Message-ID: <2050624.usQuhbGJ8B@weasel>
In-Reply-To:
 <dfc736a3b22d1a799ec0eb30c038d75120745610.1769013622.git.repk@triplefau.lt>
References:
 <cover.1769013622.git.repk@triplefau.lt>
 <dfc736a3b22d1a799ec0eb30c038d75120745610.1769013622.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	URIBL_RED(0.50)[triplefau.lt:email];
	CTE_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77027-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[crudebyte.com,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_ALLOW(0.00)[crudebyte.com:s=kylie];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E7FB912F07B
X-Rspamd-Action: no action

On Wednesday, 21 January 2026 20:56:10 CET Remi Pommarel wrote:
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
>  fs/9p/vfs_addr.c       | 24 ++++++++++++--
>  fs/9p/vfs_inode.c      |  6 ++--
>  fs/9p/vfs_inode_dotl.c | 73 +++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 90 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 862164181bac..ee672abbb02c 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -70,10 +70,19 @@ static void v9fs_issue_read(struct netfs_io_subrequest
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
> +		err = p9_client_readlink(fid, &target);

Treadlink request requires 9p2000.L. So this would break with legacy protocol
versions 9p2000 and 9p2000.u I guess:

https://wiki.qemu.org/Documentation/9p#9p_Protocol

> +		len = strnlen(target, PAGE_SIZE - 1);

Usually we are bound to PATH_MAX.

Target link path is coming from 9p server, which may run another OS and
therefore target might be longer than PATH_MAX, in which case it would always
yield in -ENAMETOOLONG when client requests that link target from cache.

But OTOH there is no real alternative for storing a link target in cache that
can never be delivered to user. So I guess it is OK as-is.

Simply using PATH_MAX would make it worse, as it would potentially silently
shorten the link from host.

> +		n = copy_to_iter(target, len, &subreq->io_iter);
> +		if (n != len)
> +			err = -EFAULT;
> +		total = i_size_read(rreq->inode);
> +	} else
> +		total = p9_client_read(fid, pos, &subreq->io_iter, &err);
> 
>  	/* if we just extended the file size, any portion not in
>  	 * cache won't be on server and is zeroes */
> @@ -99,6 +108,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest
> *subreq) static int v9fs_init_request(struct netfs_io_request *rreq, struct
> file *file) {
>  	struct p9_fid *fid;
> +	struct dentry *dentry;
>  	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
>  			rreq->origin == NETFS_WRITETHROUGH ||
>  			rreq->origin == NETFS_UNBUFFERED_WRITE ||
> @@ -115,6 +125,14 @@ static int v9fs_init_request(struct netfs_io_request
> *rreq, struct file *file) if (!fid)
>  			goto no_fid;
>  		p9_fid_get(fid);
> +	} else if (S_ISLNK(rreq->inode->i_mode)) {
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
> index a82a71be309b..e1b762f3e081 100644
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

What is that for?

> +		} else {
>  			inode->i_op = &v9fs_symlink_inode_operations;
> +		}
> 
>  		break;
>  	case S_IFDIR:
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 6312b3590f74..486b11dbada3 100644
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
> @@ -702,6 +706,15 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct
> inode *dir,
> 
>  	gid = v9fs_get_fsgid_for_create(dir);
> 
> +	/* Update mode based on ACL value */
> +	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
> +	if (err) {
> +		p9_debug(P9_DEBUG_VFS,
> +			 "Failed to get acl values in symlink %d\n",
> +			 err);
> +		goto error;
> +	}
> +
>  	/* Server doesn't alter fid on TSYMLINK. Hence no need to clone it. */
>  	err = p9_client_symlink(dfid, name, symname, gid, &qid);
> 
> @@ -712,8 +725,30 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct
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
> @@ -853,24 +888,23 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct
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
> @@ -884,6 +918,29 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
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



