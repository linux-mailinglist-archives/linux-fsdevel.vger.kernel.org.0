Return-Path: <linux-fsdevel+bounces-79245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC7/GQb3pmmgawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:58:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B491F1E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3A3230BD82E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3CB47DD6C;
	Tue,  3 Mar 2026 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="DXt75/c1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4E47DD72;
	Tue,  3 Mar 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549632; cv=none; b=LUN2+tE3vPTOGJcVgaP1rcvI9x7oEhHrnATWvDXcRjA89csxtHgBC1+3gXkVeZFfjDsDpVfRiBqkRLmkBrH2BAuwBWdeMj2Cv4Jyrylz7kLpYlrMywu6LJz3kRBVyNI+wnlDP4+cahqdqRB0f+HuuiDU4NLBKZUvCkgqo2H7/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549632; c=relaxed/simple;
	bh=gI5bOwAeUkUY8pSAuolzMNEKM2WKrkwcWy+OzXJrtJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYMlBssZ1Xq0uOOGS2VLdcwt9rtGjTi5DhpgcPw81OC58oWPDe9LiWsmxpSYgauJc0CuaT/pwWSwdKSAwnCSBUXzhOMwy9x4/DPLQ36OtKNPGwgICDzM3I7403g5l4mDu3V8oqP/wleNoZDHJVCwqMbHuzCdIhIj+vrMYXUfGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=DXt75/c1; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=akjDuevaC6SFej5GlTUhQnMF+egg0zckZ+j0Qk1HXe8=; b=DXt75/c1v72RO6v1U3XR9ogkPL
	38Fgjjo0KIiVpK4CnRmK/5BoghFqqL2jnHcFrm3vQpIYC24imTfWps1ZKyArc2Tnu5B9y87bjp0Nt
	laBw7mS/PI+T7odCYY3UlzJ/o587a9MQEKUh4ka/9j4Kyt+gPMWkeSrVfoKsTRXZWX05snHPkRaYB
	EOWn2kUMS3BNeiMIrnfWUR6vOzsk7Ef7m+MRBV3AxBXWvev01aNtahiu3JyqwQe/Mf4AFmBQWTf8l
	5SuQrir4T4EyZMTuRUXGPpFtei9zF/MC1cVOX0sdOUPmkJzv05/NAB+hU0HBfzBx1aFROYmz5vJEK
	KQtRIe3/3FaJkYIDkx/feICJM7qzsEGo4sj+iH3jlxS8bte0orsCvi+r/+kA0h12nKRxYyUHHfTLy
	ka4Zgt31Fbs7C6QXDdPX2ifbq74c9de78vxfBXmRTdz43HJU79pv0n8/DpE5+BXXcPOEZWY+nSWg7
	Hphuv/NfaUJJJYikzNYNUA5NxkifeGQJ93PhrgkJQxElBCHAubl7uhiTJPZLqpARsuS6IQpIjB1en
	G6SFtzZrv2DUNHTvaWL2lQ1rHEDGUyM/6SCkbPMaJ05IjVFq7LY+0n+8R1p6Yn6B72toTkcXEmzVU
	nVsEHbjONLABdd1SE2MCQzqjPFIT9RYiRPgjBg29A=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject:
 Re: [PATCH v3 2/4] 9p: Add mount option for negative dentry cache retention
Date: Tue, 03 Mar 2026 15:53:47 +0100
Message-ID: <4490625.ejJDZkT8p0@weasel>
In-Reply-To:
 <7c2a5ba3e229b4e820f0fcd565ca38ab3ca5493f.1772178819.git.repk@triplefau.lt>
References:
 <cover.1772178819.git.repk@triplefau.lt>
 <7c2a5ba3e229b4e820f0fcd565ca38ab3ca5493f.1772178819.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: D3B491F1E46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79245-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[triplefau.lt:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,crudebyte.com:dkim]
X-Rspamd-Action: no action

On Friday, 27 February 2026 08:56:53 CET Remi Pommarel wrote:
> Introduce a new mount option, ndentrycache, for v9fs that allows users
> to specify how long negative dentries are retained in the cache. The
> retention time can be set in milliseconds (e.g. ndentrycache=10000 for
> a 10secs retention time), or negative entries can be kept until the
> buffer cache management removes them by using the option without a
> value (i.e. ndentrycache).
> 
> For consistency reasons, this option should only be used in exclusive
> or read-only mount scenarios, aligning with the cache=loose usage.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  fs/9p/v9fs.c | 73 ++++++++++++++++++++++++++++++++--------------------
>  fs/9p/v9fs.h | 23 ++++++++++-------
>  2 files changed, 58 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index c5dca81a553e..a26bd9070786 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -39,11 +39,12 @@ enum {
>  	 * source if we rejected it as EINVAL */
>  	Opt_source,
>  	/* Options that take integer arguments */
> -	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
> +	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrycachetmo,
>  	/* String options */
>  	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
>  	/* Options that take no arguments */
>  	Opt_nodevmap, Opt_noxattr, Opt_directio, Opt_ignoreqv,
> +	Opt_ndentrycache,
>  	/* Access options */
>  	Opt_access, Opt_posixacl,
>  	/* Lock timeout option */
> @@ -77,41 +78,43 @@ static const struct constant_table p9_versions[] = {
>   * the client, and all the transports.
>   */
>  const struct fs_parameter_spec v9fs_param_spec[] = {
> -	fsparam_string	("source",	Opt_source),
> -	fsparam_u32hex	("debug",	Opt_debug),
> -	fsparam_uid	("dfltuid",	Opt_dfltuid),
> -	fsparam_gid	("dfltgid",	Opt_dfltgid),
> -	fsparam_u32	("afid",	Opt_afid),
> -	fsparam_string	("uname",	Opt_uname),
> -	fsparam_string	("aname",	Opt_remotename),
> -	fsparam_flag	("nodevmap",	Opt_nodevmap),
> -	fsparam_flag	("noxattr",	Opt_noxattr),
> -	fsparam_flag	("directio",	Opt_directio),
> -	fsparam_flag	("ignoreqv",	Opt_ignoreqv),
> -	fsparam_string	("cache",	Opt_cache),
> -	fsparam_string	("cachetag",	Opt_cachetag),
> -	fsparam_string	("access",	Opt_access),
> -	fsparam_flag	("posixacl",	Opt_posixacl),
> -	fsparam_u32	("locktimeout",	Opt_locktimeout),
> +	fsparam_string	("source",		Opt_source),
> +	fsparam_u32hex	("debug",		Opt_debug),
> +	fsparam_uid	("dfltuid",		Opt_dfltuid),
> +	fsparam_gid	("dfltgid",		Opt_dfltgid),
> +	fsparam_u32	("afid",		Opt_afid),
> +	fsparam_string	("uname",		Opt_uname),
> +	fsparam_string	("aname",		Opt_remotename),
> +	fsparam_flag	("nodevmap",		Opt_nodevmap),
> +	fsparam_flag	("noxattr",		Opt_noxattr),
> +	fsparam_flag	("directio",		Opt_directio),
> +	fsparam_flag	("ignoreqv",		Opt_ignoreqv),
> +	fsparam_string	("cache",		Opt_cache),
> +	fsparam_string	("cachetag",		Opt_cachetag),
> +	fsparam_string	("access",		Opt_access),
> +	fsparam_flag	("posixacl",		Opt_posixacl),
> +	fsparam_u32	("locktimeout",		Opt_locktimeout),
> +	fsparam_flag	("ndentrycache",	Opt_ndentrycache),
> +	fsparam_u32	("ndentrycache",	Opt_ndentrycachetmo),

That double entry is surprising. So this mount option is supposed to be used
like ndentrycache=n for a specific timeout value (in ms) and just ndentrycache
(without any assignment) for infinite timeout. That's a bit weird.

Documentation/filesystems/9p.rst should be updated as well BTW.

Nevertheless, like mentioned before, I really think the string "timeout"
should be used, at least in a user visible mount option. Keep in mind that
timeouts are a common issue to look at, so it is common to just grep for
"timeout" in a code base or documentation. An abbrevation like "tmo" or
leaving it out entirely is for me therefore IMHO inappropriate.

You found "ndentrycachetimeout" too horribly long, or was that again just
motivated by the code indention below? I personally find those indention
alignments completely irrelevant, not sure how Dominique sees that.
Personally I avoid them, as they cost unnecessary time on git blame.

/Christian
 
>  	/* client options */
> -	fsparam_u32	("msize",	Opt_msize),
> -	fsparam_flag	("noextend",	Opt_legacy),
> -	fsparam_string	("trans",	Opt_trans),
> -	fsparam_enum	("version",	Opt_version, p9_versions),
> +	fsparam_u32	("msize",		Opt_msize),
> +	fsparam_flag	("noextend",		Opt_legacy),
> +	fsparam_string	("trans",		Opt_trans),
> +	fsparam_enum	("version",		Opt_version, p9_versions),
> 
>  	/* fd transport options */
> -	fsparam_u32	("rfdno",	Opt_rfdno),
> -	fsparam_u32	("wfdno",	Opt_wfdno),
> +	fsparam_u32	("rfdno",		Opt_rfdno),
> +	fsparam_u32	("wfdno",		Opt_wfdno),
> 
>  	/* rdma transport options */
> -	fsparam_u32	("sq",		Opt_sq_depth),
> -	fsparam_u32	("rq",		Opt_rq_depth),
> -	fsparam_u32	("timeout",	Opt_timeout),
> +	fsparam_u32	("sq",			Opt_sq_depth),
> +	fsparam_u32	("rq",			Opt_rq_depth),
> +	fsparam_u32	("timeout",		Opt_timeout),
> 
>  	/* fd and rdma transprt options */
> -	fsparam_u32	("port",	Opt_port),
> -	fsparam_flag	("privport",	Opt_privport),
> +	fsparam_u32	("port",		Opt_port),
> +	fsparam_flag	("privport",		Opt_privport),
>  	{}
>  };
> 
> @@ -159,6 +162,10 @@ int v9fs_show_options(struct seq_file *m, struct dentry
> *root) from_kgid_munged(&init_user_ns, v9ses->dfltgid));
>  	if (v9ses->afid != ~0)
>  		seq_printf(m, ",afid=%u", v9ses->afid);
> +	if (v9ses->ndentry_timeout_ms == NDENTRY_TMOUT_NEVER)
> +		seq_printf(m, ",ndentrycache");
> +	else if (v9ses->flags & V9FS_NDENTRY_TMOUT_SET)
> +		seq_printf(m, ",ndentrycache=%u", v9ses->ndentry_timeout_ms);
>  	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
>  		seq_printf(m, ",uname=%s", v9ses->uname);
>  	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
> @@ -337,6 +344,16 @@ int v9fs_parse_param(struct fs_context *fc, struct
> fs_parameter *param) session_opts->session_lock_timeout =
> (long)result.uint_32 * HZ; break;
> 
> +	case Opt_ndentrycache:
> +		session_opts->flags |= V9FS_NDENTRY_TMOUT_SET;
> +		session_opts->ndentry_timeout_ms = NDENTRY_TMOUT_NEVER;
> +		break;
> +
> +	case Opt_ndentrycachetmo:
> +		session_opts->flags |= V9FS_NDENTRY_TMOUT_SET;
> +		session_opts->ndentry_timeout_ms = result.uint_64;
> +		break;
> +
>  	/* Options for client */
>  	case Opt_msize:
>  		if (result.uint_32 < 4096) {
> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> index 8410f7883109..2e42729c6c20 100644
> --- a/fs/9p/v9fs.h
> +++ b/fs/9p/v9fs.h
> @@ -24,6 +24,8 @@
>   * @V9FS_ACCESS_ANY: use a single attach for all users
>   * @V9FS_ACCESS_MASK: bit mask of different ACCESS options
>   * @V9FS_POSIX_ACL: POSIX ACLs are enforced
> + * @V9FS_NDENTRY_TMOUT_SET: Has negative dentry timeout retention time been
> + *			    overriden by ndentrycache mount option
>   *
>   * Session flags reflect options selected by users at mount time
>   */
> @@ -34,16 +36,17 @@
>  #define V9FS_ACL_MASK V9FS_POSIX_ACL
> 
>  enum p9_session_flags {
> -	V9FS_PROTO_2000U    = 0x01,
> -	V9FS_PROTO_2000L    = 0x02,
> -	V9FS_ACCESS_SINGLE  = 0x04,
> -	V9FS_ACCESS_USER    = 0x08,
> -	V9FS_ACCESS_CLIENT  = 0x10,
> -	V9FS_POSIX_ACL      = 0x20,
> -	V9FS_NO_XATTR       = 0x40,
> -	V9FS_IGNORE_QV      = 0x80, /* ignore qid.version for cache hints */
> -	V9FS_DIRECT_IO      = 0x100,
> -	V9FS_SYNC           = 0x200
> +	V9FS_PROTO_2000U       = 0x01,
> +	V9FS_PROTO_2000L       = 0x02,
> +	V9FS_ACCESS_SINGLE     = 0x04,
> +	V9FS_ACCESS_USER       = 0x08,
> +	V9FS_ACCESS_CLIENT     = 0x10,
> +	V9FS_POSIX_ACL         = 0x20,
> +	V9FS_NO_XATTR          = 0x40,
> +	V9FS_IGNORE_QV         = 0x80, /* ignore qid.version for cache hints */
> +	V9FS_DIRECT_IO         = 0x100,
> +	V9FS_SYNC              = 0x200,
> +	V9FS_NDENTRY_TMOUT_SET = 0x400,
>  };
> 
>  /**





