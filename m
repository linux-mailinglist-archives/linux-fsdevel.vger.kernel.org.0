Return-Path: <linux-fsdevel+bounces-79349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yInhIa4qqGnJpAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:50:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9931FFDA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E8AD301E200
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B71E8826;
	Wed,  4 Mar 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="M9UdGE2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B81E633C;
	Wed,  4 Mar 2026 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628644; cv=none; b=GV3ol+su/y1hPQQkfMrjujs+AzfTef/7DOwzbXqJnW4eKxXBX/fvS+DrdNQB1vangJGNe8M3AfzttQCp97k421iSBnA503MWFyHuxa2mX6fQ8tPfyIMApowlL4+bqsiLW3FPNtz9KOtEqmiko43+y0fOILy92bysben7rmm1ou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628644; c=relaxed/simple;
	bh=wA8ZtkMMTkiBFZxruqKgAYkmata6f6nHpZ8smnw0U6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyoX53hiDTr2oY6eMx36/blRkZSpevoZPyho1ktDrRuCfZSdqqCPvkLbctbcmEp/Q7pICM6FS7lb30yTvXW9kIap284dC9rj8/IFk9+niBFGBmED2deN5jJTupAWXVXjZjMdVjQ39IvUL9Czwdb+N994nIjHDtvVnSfck2lUBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=M9UdGE2S; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=i7fRI1gCj+KY/6ScYnYJKT+I5vd0HqgB4j9Ra2PBaUg=; b=M9UdGE2SYJqQO/7F/3MA2nAO3v
	rTms52rqok9GRSCo3CkVFcTJHf/t85oO4JvO7jDFE91iSfwvca7MqhdonwQLhBzbfNGREZdF37rGu
	j/Sx24cMGkWOOaBErOnMARGizGnNs59FSOQZPDFTkjnD2wpdMxFcZfWZoAbxpyzl1srShju3+hC32
	11X9BCm3y9oe+no70bP/7BQ1vxcyHWIoLB4F1wjylxwqoBQkXXlB6La7FWM/bnPEaJQbcizkSAaFL
	/M+s/Tto7WG46p6/MfhzWGBUWa95peswTa0B3Qfxq8IbC+gjtnVd0AHa7jcB7X9ThXdlPQXltd9Dy
	8uOCdwCPEqjSqouB5k2whbffsaSVRSfcKHrdYATvfuaMfd+j6qLuppXrTfNomg65ygk5ouwDBoM6i
	uR32xrnJp9ZJL99PskQY3czHZZ6jSiC4jIzE+Jl1Wf13Xq4Y0TkhlwFao7L5mspbhLiXDqwM1EgZE
	kVsaEppaOZzCMm9oV6kozrc7DTBGM7FZn6QHH+2ab0dZJyuJX2Zk9LkXfpmaO0Msar8ApXaOfC/WW
	Dh5hWsI3Z60M/R/PI6nKMY+mRwRKcNkjXTIjAc6sWcX+vBe469pxv8Ucr1GLDRIYrCsPMAK7fsZS7
	ZBAtFItdjpjYiQurF0PlcDiB6okQcaXNQCPuQdYoQ=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v3 1/4] 9p: Cache negative dentries for lookup performance
Date: Wed, 04 Mar 2026 13:50:40 +0100
Message-ID: <5156132.0VBMTVartN@weasel>
In-Reply-To:
 <c2b00b0230b49561915d416a2183691ed82f4923.1772178819.git.repk@triplefau.lt>
References:
 <cover.1772178819.git.repk@triplefau.lt>
 <c2b00b0230b49561915d416a2183691ed82f4923.1772178819.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: DD9931FFDA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79349-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,crudebyte.com:dkim,crudebyte.com:email,triplefau.lt:email]
X-Rspamd-Action: no action

On Friday, 27 February 2026 08:56:52 CET Remi Pommarel wrote:
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
>  fs/9p/v9fs.h            |   5 ++
>  fs/9p/v9fs_vfs.h        |  15 ++++++
>  fs/9p/vfs_dentry.c      | 105 ++++++++++++++++++++++++++++++++++------
>  fs/9p/vfs_inode.c       |  12 +++--
>  fs/9p/vfs_super.c       |   1 +
>  include/net/9p/client.h |   2 +
>  8 files changed, 128 insertions(+), 24 deletions(-)
[...]
> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> index 6a12445d3858..8410f7883109 100644
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
> @@ -101,6 +102,7 @@ enum p9_cache_bits {
>   * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the
> hierarchy * @clnt: reference to 9P network client instantiated for this
> session * @slist: reference to list of registered 9p sessions
> + * @ndentry_timeout_ms: Negative dentry caching retention time
>   *
>   * This structure holds state for each session instance established during
>   * a sys_mount() .
> @@ -116,6 +118,7 @@ struct v9fs_session_info {
>  	unsigned short debug;
>  	unsigned int afid;
>  	unsigned int cache;
> +	unsigned int ndentry_timeout_ms;
>  #ifdef CONFIG_9P_FSCACHE
>  	char *cachetag;
>  	struct fscache_volume *fscache;
> @@ -133,6 +136,8 @@ struct v9fs_session_info {
>  	long session_lock_timeout; /* retry interval for blocking locks */
>  };
[...]
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 838a94218b59..55c6cb54bd25 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -192,6 +192,7 @@ struct p9_rdma_opts {
>   * @dfltgid: default numeric groupid to mount hierarchy as
>   * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the
> hierarchy * @session_lock_timeout: retry interval for blocking locks
> + * @ndentry_timeout_ms: Negative dentry lookup cache retention time in ms
>   *
>   * This strucure holds options which are parsed and will be transferred
>   * to the v9fs_session_info structure when mounted, and therefore largely
> @@ -203,6 +204,7 @@ struct p9_session_opts {
>  	unsigned short debug;
>  	unsigned int afid;
>  	unsigned int cache;
> +	unsigned int ndentry_timeout_ms;
>  #ifdef CONFIG_9P_FSCACHE
>  	char *cachetag;
>  #endif

Depending on what turns out to be chosen for the mount option eventually,
these types could be increased in size. But in general, LGTM:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>



