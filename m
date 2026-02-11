Return-Path: <linux-fsdevel+bounces-76956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC5VLCysjGl/sAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:19:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F71260E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC993018BC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA733E376;
	Wed, 11 Feb 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="hNkl25bH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2833BBD9;
	Wed, 11 Feb 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770826681; cv=none; b=VM87WObT5pGEYwgzFSatJIT1HD4OHv6iE6DVVtx+Pjhz33qGt2Nfod9UkBSDKINghvy5Jf/UG60bfhNgQQTv5tlFUR/RHIjAaxolBhMijpwOOgU1pFMxrStQkd94v800MxiPr6+3cTfIpDgewoIiRP28NdAgg5KY6mOiA9UIoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770826681; c=relaxed/simple;
	bh=8JobU68D8bC+YDQRkZ3rcmSbXAfjGXnoqq1Ohr18ESM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5NZyP3lPPKmRUMB6Kbkw/h8NGltpdXdRfKVBFLE7fukkZS9b/cFkCWlFwczteQW7CqcPJfJg96tKNWAZKyzGI2GRNv876K0SK0z/u2ZGIduno0tTNRU8VIO/PuZgJQjIs/wyGOFTMnS80+UEbTSJ230Pa0xwz8hrPXU7Us3E6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=hNkl25bH; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=OXkFkqt1aOozaRNFCPcreuHds3KfkDW81hEGdpAFSJo=; b=hNkl25bH5JF4JqxtFRjX1xQ+Zn
	2kUI1J+J3U/mZt18zmx+wSRaoCMPvFMdUAIr1375MqpnLMcdC9YZpweuDKM6YPsAA4flb/wv6Ygcl
	EpTiCvrHmhFNUi0aIl4X70w2xE4x8cpB35hdv7gP9t7acmOMS72fr19G7bituQ1s+gxMzD+2b+aAQ
	HfkfQrFk+hY60giyQLRFz7R/2nPwXtrFy9AS76bq+Id6T3E6yD/VyTPZ2biUDardgujyfTTcUPXEQ
	DSGN+07yREV7F+zeJSyk1M6TDnY4CNCNIX4a/tZ2wCKpvOj80GzzIYLwUY5XmjvfWtiQB+nu4dMCS
	M01QT/624QGz2MaJjceNlzq0NjlnNtxRHsxkUVyPPLZhL3MicVGL7ZGqsTnnQWg9gYVraYeA7X8Xm
	gZCfVtzu0vAPqjDSkrYMmORI79R4DkGDgief28VbGrURndHPjMMDfLxnw21BC68d44zkKx0EJ3tap
	FeaEKDUce4H6ECT9muwkBpVgaSjKxKmM0U8/OoD3DwpUr08/A7xJOt2EFVhMT9DRD4e0l6mMewVQK
	P9uPwwODRYOfpF+MjMw9yjK9s7kuoVWwlFm7xGrKPJ0YjYO3d0JFQIOMr88/Tz7ZXgIzX22g3c7dd
	HR5O79ZA75k2vJfA2JdCuiwEhQ8Yf2Sgxiehq0WFE=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 1/3] 9p: Cache negative dentries for lookup performance
Date: Wed, 11 Feb 2026 16:49:19 +0100
Message-ID: <10801068.nUPlyArG6x@weasel>
In-Reply-To:
 <51afd44abb72d251e2022fbb4d53dd05a03aeed0.1769013622.git.repk@triplefau.lt>
References:
 <cover.1769013622.git.repk@triplefau.lt>
 <51afd44abb72d251e2022fbb4d53dd05a03aeed0.1769013622.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76956-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crudebyte.com:dkim,triplefau.lt:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 540F71260E9
X-Rspamd-Action: no action

On Wednesday, 21 January 2026 20:56:08 CET Remi Pommarel wrote:
> Not caching negative dentries can result in poor performance for
> workloads that repeatedly look up non-existent paths. Each such
> lookup triggers a full 9P transaction with the server, adding
> unnecessary overhead.
> 
> A typical example is source compilation, where multiple cc1 processes
> are spawned and repeatedly search for the same missing header files
> over and over again.
> 
> This change enables caching of negative dentries, so that lookups for
> known non-existent paths do not require a full 9P transaction. The
> cached negative dentries are retained for a configurable duration
> (expressed in milliseconds), as specified by the ndentry_timeout
> field in struct v9fs_session_info. If set to -1, negative dentries
> are cached indefinitely.
> 
> This optimization reduces lookup overhead and improves performance for
> workloads involving frequent access to non-existent paths.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  fs/9p/fid.c             |  11 +++--
>  fs/9p/v9fs.c            |   1 +
>  fs/9p/v9fs.h            |   2 +
>  fs/9p/v9fs_vfs.h        |  15 ++++++
>  fs/9p/vfs_dentry.c      | 105 ++++++++++++++++++++++++++++++++++------
>  fs/9p/vfs_inode.c       |   7 +--
>  fs/9p/vfs_super.c       |   1 +
>  include/net/9p/client.h |   2 +
>  8 files changed, 122 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> index f84412290a30..76242d450aa7 100644
> --- a/fs/9p/fid.c
> +++ b/fs/9p/fid.c
> @@ -20,7 +20,9 @@
> 
>  static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
>  {
> -	hlist_add_head(&fid->dlist, (struct hlist_head *)&dentry->d_fsdata);
> +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
> +
> +	hlist_add_head(&fid->dlist, &v9fs_dentry->head);
>  }
> 
> 
> @@ -112,6 +114,7 @@ void v9fs_open_fid_add(struct inode *inode, struct
> p9_fid **pfid)
> 
>  static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int
> any) {
> +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
>  	struct p9_fid *fid, *ret;
> 
>  	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p) uid %d any %d\n",
> @@ -119,11 +122,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry
> *dentry, kuid_t uid, int any) any);
>  	ret = NULL;
>  	/* we'll recheck under lock if there's anything to look in */
> -	if (dentry->d_fsdata) {
> -		struct hlist_head *h = (struct hlist_head *)&dentry->d_fsdata;
> -
> +	if (!hlist_empty(&v9fs_dentry->head)) {
>  		spin_lock(&dentry->d_lock);
> -		hlist_for_each_entry(fid, h, dlist) {
> +		hlist_for_each_entry(fid, &v9fs_dentry->head, dlist) {
>  			if (any || uid_eq(fid->uid, uid)) {
>  				ret = fid;
>  				p9_fid_get(ret);
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 057487efaaeb..1da7ab186478 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -422,6 +422,7 @@ static void v9fs_apply_options(struct v9fs_session_info
> *v9ses, v9ses->cache = ctx->session_opts.cache;
>  	v9ses->uid = ctx->session_opts.uid;
>  	v9ses->session_lock_timeout = ctx->session_opts.session_lock_timeout;
> +	v9ses->ndentry_timeout = ctx->session_opts.ndentry_timeout;
>  }
> 
>  /**
> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> index 6a12445d3858..99d1a0ff3368 100644
> --- a/fs/9p/v9fs.h
> +++ b/fs/9p/v9fs.h
> @@ -91,6 +91,7 @@ enum p9_cache_bits {
>   * @debug: debug level
>   * @afid: authentication handle
>   * @cache: cache mode of type &p9_cache_bits
> + * @ndentry_timeout: Negative dentry lookup cache retention time in ms
>   * @cachetag: the tag of the cache associated with this session
>   * @fscache: session cookie associated with FS-Cache
>   * @uname: string user name to mount hierarchy as
> @@ -116,6 +117,7 @@ struct v9fs_session_info {
>  	unsigned short debug;
>  	unsigned int afid;
>  	unsigned int cache;
> +	unsigned int ndentry_timeout;

Why not (signed) long?

>  #ifdef CONFIG_9P_FSCACHE
>  	char *cachetag;
>  	struct fscache_volume *fscache;
> diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
> index d3aefbec4de6..7e6e8881081c 100644
> --- a/fs/9p/v9fs_vfs.h
> +++ b/fs/9p/v9fs_vfs.h
> @@ -28,6 +28,19 @@
>  /* flags for v9fs_stat2inode() & v9fs_stat2inode_dotl() */
>  #define V9FS_STAT2INODE_KEEP_ISIZE 1
> 
> +/**
> + * struct v9fs_dentry - v9fs specific dentry data
> + * @head: List of fid associated with this dentry
> + * @expire_time: Lookup cache expiration time for negative dentries
> + * @rcu: used by kfree_rcu to schedule clean up job
> + */
> +struct v9fs_dentry {
> +	struct hlist_head head;
> +	u64 expire_time;
> +	struct rcu_head rcu;
> +};
> +#define to_v9fs_dentry(d) ((struct v9fs_dentry *)((d)->d_fsdata))
> +
>  extern struct file_system_type v9fs_fs_type;
>  extern const struct address_space_operations v9fs_addr_operations;
>  extern const struct file_operations v9fs_file_operations;
> @@ -35,6 +48,8 @@ extern const struct file_operations
> v9fs_file_operations_dotl; extern const struct file_operations
> v9fs_dir_operations;
>  extern const struct file_operations v9fs_dir_operations_dotl;
>  extern const struct dentry_operations v9fs_dentry_operations;
> +extern void v9fs_dentry_refresh(struct dentry *dentry);
> +extern void v9fs_dentry_fid_remove(struct dentry *dentry);
>  extern const struct dentry_operations v9fs_cached_dentry_operations;
>  extern struct kmem_cache *v9fs_inode_cache;
> 
> diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
> index c5bf74d547e8..90291cf0a34b 100644
> --- a/fs/9p/vfs_dentry.c
> +++ b/fs/9p/vfs_dentry.c
> @@ -23,6 +23,46 @@
>  #include "v9fs_vfs.h"
>  #include "fid.h"
> 
> +/**
> + * v9fs_dentry_is_expired - Check if dentry lookup has expired
> + *
> + * This should be called to know if a negative dentry should be removed
> from + * cache.
> + *
> + * @dentry: dentry in question
> + *
> + */
> +static bool v9fs_dentry_is_expired(struct dentry const *dentry)
> +{
> +	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
> +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
> +
> +	if (v9ses->ndentry_timeout == -1)
> +		return false;
> +
> +	return time_before_eq64(v9fs_dentry->expire_time, get_jiffies_64());
> +}

v9fs_negative_dentry_is_expired() ?

Or is there a plan to use this for regular dentries, say with cache=loose in
future?

> +
> +/**
> + * v9fs_dentry_refresh - Refresh dentry lookup cache timeout
> + *
> + * This should be called when a look up yields a negative entry.
> + *
> + * @dentry: dentry in question
> + *
> + */
> +void v9fs_dentry_refresh(struct dentry *dentry)
> +{
> +	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
> +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
> +
> +	if (v9ses->ndentry_timeout == -1)
> +		return;
> +
> +	v9fs_dentry->expire_time = get_jiffies_64() +
> +				   msecs_to_jiffies(v9ses->ndentry_timeout);
> +}

v9fs_negative_dentry_refresh_timeout() ?

> +
>  /**
>   * v9fs_cached_dentry_delete - called when dentry refcount equals 0
>   * @dentry:  dentry in question
> @@ -33,20 +73,15 @@ static int v9fs_cached_dentry_delete(const struct dentry
> *dentry) p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
>  		 dentry, dentry);
> 
> -	/* Don't cache negative dentries */
> -	if (d_really_is_negative(dentry))
> -		return 1;
> -	return 0;
> -}
> +	if (!d_really_is_negative(dentry))
> +		return 0;

Is it worth a check for v9ses->ndentry_timeout != 0 here?

> 
> -/**
> - * v9fs_dentry_release - called when dentry is going to be freed
> - * @dentry:  dentry that is being release
> - *
> - */
> +	return v9fs_dentry_is_expired(dentry);
> +}

"... is being released"

> 
> -static void v9fs_dentry_release(struct dentry *dentry)
> +static void __v9fs_dentry_fid_remove(struct dentry *dentry)
>  {
> +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
>  	struct hlist_node *p, *n;
>  	struct hlist_head head;
> 
> @@ -54,13 +89,54 @@ static void v9fs_dentry_release(struct dentry *dentry)
>  		 dentry, dentry);
> 
>  	spin_lock(&dentry->d_lock);
> -	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
> +	hlist_move_list(&v9fs_dentry->head, &head);
>  	spin_unlock(&dentry->d_lock);
> 
>  	hlist_for_each_safe(p, n, &head)
>  		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
>  }
> 
> +/**
> + * v9fs_dentry_fid_remove - Release all dentry's fid
> + * @dentry: dentry in question
> + *
> + */
> +void v9fs_dentry_fid_remove(struct dentry *dentry)
> +{
> +	__v9fs_dentry_fid_remove(dentry);
> +}

" ... all dentry's fids" ?

> +
> +/**
> + * v9fs_dentry_init - Initialize v9fs dentry data
> + * @dentry: dentry in question
> + *
> + */
> +static int v9fs_dentry_init(struct dentry *dentry)
> +{
> +	struct v9fs_dentry *v9fs_dentry = kzalloc(sizeof(*v9fs_dentry),
> +						  GFP_KERNEL);
> +
> +	if (!v9fs_dentry)
> +		return -ENOMEM;
> +
> +	INIT_HLIST_HEAD(&v9fs_dentry->head);
> +	dentry->d_fsdata = (void *)v9fs_dentry;
> +	return 0;
> +}
> +
> +/**
> + * v9fs_dentry_release - called when dentry is going to be freed
> + * @dentry:  dentry that is being release
> + *
> + */
> +static void v9fs_dentry_release(struct dentry *dentry)
> +{
> +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
> +
> +	__v9fs_dentry_fid_remove(dentry);
> +	kfree_rcu(v9fs_dentry, rcu);
> +}
> +
>  static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int
> flags) {
>  	struct p9_fid *fid;
> @@ -72,7 +148,7 @@ static int __v9fs_lookup_revalidate(struct dentry
> *dentry, unsigned int flags)
> 
>  	inode = d_inode(dentry);
>  	if (!inode)
> -		goto out_valid;
> +		return !v9fs_dentry_is_expired(dentry);
> 
>  	v9inode = V9FS_I(inode);
>  	if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
> @@ -112,7 +188,6 @@ static int __v9fs_lookup_revalidate(struct dentry
> *dentry, unsigned int flags) return retval;
>  		}
>  	}
> -out_valid:
>  	p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) is valid\n", dentry, dentry);
>  	return 1;
>  }
> @@ -139,12 +214,14 @@ const struct dentry_operations
> v9fs_cached_dentry_operations = { .d_revalidate = v9fs_lookup_revalidate,
>  	.d_weak_revalidate = __v9fs_lookup_revalidate,
>  	.d_delete = v9fs_cached_dentry_delete,
> +	.d_init = v9fs_dentry_init,
>  	.d_release = v9fs_dentry_release,
>  	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
>  	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
>  };
> 
>  const struct dentry_operations v9fs_dentry_operations = {
> +	.d_init = v9fs_dentry_init,
>  	.d_release = v9fs_dentry_release,
>  	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
>  	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 0f3189a0a516..a82a71be309b 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -549,7 +549,7 @@ static int v9fs_remove(struct inode *dir, struct dentry
> *dentry, int flags)
> 
>  		/* invalidate all fids associated with dentry */
>  		/* NOTE: This will not include open fids */
> -		dentry->d_op->d_release(dentry);
> +		v9fs_dentry_fid_remove(dentry);
>  	}
>  	return retval;
>  }
> @@ -732,9 +732,10 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir,
> struct dentry *dentry, name = dentry->d_name.name;
>  	fid = p9_client_walk(dfid, 1, &name, 1);
>  	p9_fid_put(dfid);
> -	if (fid == ERR_PTR(-ENOENT))
> +	if (fid == ERR_PTR(-ENOENT)) {
>  		inode = NULL;
> -	else if (IS_ERR(fid))
> +		v9fs_dentry_refresh(dentry);
> +	} else if (IS_ERR(fid))
>  		inode = ERR_CAST(fid);
>  	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
>  		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> index 315336de6f02..9d9360f9e502 100644
> --- a/fs/9p/vfs_super.c
> +++ b/fs/9p/vfs_super.c
> @@ -327,6 +327,7 @@ static int v9fs_init_fs_context(struct fs_context *fc)
>  	ctx->session_opts.uid = INVALID_UID;
>  	ctx->session_opts.dfltuid = V9FS_DEFUID;
>  	ctx->session_opts.dfltgid = V9FS_DEFGID;
> +	ctx->session_opts.ndentry_timeout = 0;
> 
>  	/* initialize client options */
>  	ctx->client_opts.proto_version = p9_proto_2000L;
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 838a94218b59..3d2483db9259 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -192,6 +192,7 @@ struct p9_rdma_opts {
>   * @dfltgid: default numeric groupid to mount hierarchy as
>   * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the
> hierarchy * @session_lock_timeout: retry interval for blocking locks
> + * @ndentry_timeout: Negative dentry lookup cache retention time in ms
>   *
>   * This strucure holds options which are parsed and will be transferred
>   * to the v9fs_session_info structure when mounted, and therefore largely
> @@ -212,6 +213,7 @@ struct p9_session_opts {
>  	kgid_t dfltgid;
>  	kuid_t uid;
>  	long session_lock_timeout;
> +	unsigned int ndentry_timeout;
>  };
> 
>  /* Used by mount API to store parsed mount options */




