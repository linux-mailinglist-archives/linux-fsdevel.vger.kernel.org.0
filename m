Return-Path: <linux-fsdevel+bounces-76953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMsxFjanjGnVrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:58:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AAC125E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A83923034B17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89924326D55;
	Wed, 11 Feb 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="YVqWCmw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9E32548D;
	Wed, 11 Feb 2026 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825487; cv=none; b=ecVeft2sxAbacsrDbDr2wv4GWNwvXTXZEBrK7zfvLtuPXLZ+1YBHAUdFW/js+o4BK5OXTJCgMcyKE6fvNenSu02sHyJi5ngE5guaBNb4/RFUMG+pG0BgjoPCgke2/hUB8u1xT98XosBxVHRItKcb27rJqkeHMbEspY+EVQhR+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825487; c=relaxed/simple;
	bh=HboLgwrrJSBpIVbQmtbxi3id/yn56qSaq/Ws66MZEz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWqUJvMvUNLY6CO4Ya6JNrXvSoOi9BTp2bEQmB+JUD+JwB1eCo+ty/+LhDWFTLUGvUvBdaEPLPTSJC5Y5E4hKiMjDbgdE/tGcjcwKbL6CujN6Akvh7HRdBQVPCgUCTPYOB7DxTRG660rwuN5ar87vcQUKHwgJYa3yGgRfHsaZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=YVqWCmw3; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=XHs+MvJHP7lm1GyHxgPTtCKn4yhsw71bbxz6K7cmxMA=; b=YVqWCmw3pDbyedqAUhHAjTiqUt
	NckSUNlaq7mtjn0V6BMRQs7ObxzZyXoKbWEgK4sTMnnu+DEC2135Hew/IjWvG33uCmVMWM+/kAik1
	8dM8MzG7p1jqVqUCcCcEB5BNaiMXmPfqUqz+kGRi6V4Awwh4F12zUNEKIk3QXNC7xAzJdBslllZ00
	3/tsKST6lVjxr4dv1fuRjVclfGkg07h+s4/iyjZbIbkX7RGgcqdSjFip41heudAL9EU0ZorAk5noE
	naG1ARHWz+PLncyfEgpUx3+iRZBqVcN2nwjzJtFRVjHSwQ4NyfGJBA+grAd30bk2T3FdTV4OzTMI3
	MW3ZunWSduYwWYqj8bNOvRIBnFjYylWxOyupuug5lUhSf91A3TiG3NrxSqv3Fn2+HDrm2ixU08ePw
	7HT4Yeu/dKDQTY7Ba7KRHCmCkK5R57czVXAWDAHPnLqn/4i7apQWf7Pn71cvw8oFAjQRm2QNF8j9m
	GvFedvARdeoPj3ZB0q4WHtepwhg0y/NFAAqgINhWg+hT0XpMOOQ+1hx72G78CwIjbsaQ5YtKs8VTS
	3Fozz7M2K4mks3vuNUS7OKVbrLoHeEM9CGjafGXZCGb5ct2mGVhEdW1TayuQxaTZGtmf6J4WS3a+f
	M0sQhKn0xRDl8Ap4VN+sQDXHIq6JF3Yw27qVl6+TQ=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject:
 Re: [PATCH v2 2/3] 9p: Introduce option for negative dentry cache retention
 time
Date: Wed, 11 Feb 2026 16:58:02 +0100
Message-ID: <3929797.kQq0lBPeGt@weasel>
In-Reply-To:
 <7e38e7bd31674208ab2b0de909c0744feda2c03f.1769013622.git.repk@triplefau.lt>
References:
 <cover.1769013622.git.repk@triplefau.lt>
 <7e38e7bd31674208ab2b0de909c0744feda2c03f.1769013622.git.repk@triplefau.lt>
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
	TAGGED_FROM(0.00)[bounces-76953-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[crudebyte.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0AAC125E6B
X-Rspamd-Action: no action

On Wednesday, 21 January 2026 20:56:09 CET Remi Pommarel wrote:
> Add support for a new mount option in v9fs that allows users to specify
> the duration for which negative dentries are retained in the cache. The
> retention time can be set in milliseconds using the ndentrytmo option.
> 
> For the same consistency reasons, this option should only be used in
> exclusive or read-only mount scenarios, aligning with the cache=loose
> usage.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  fs/9p/v9fs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 1da7ab186478..f58a2718e412 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -39,7 +39,7 @@ enum {
>  	 * source if we rejected it as EINVAL */
>  	Opt_source,
>  	/* Options that take integer arguments */
> -	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
> +	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrytmo,
>  	/* String options */
>  	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
>  	/* Options that take no arguments */
> @@ -93,6 +93,7 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
>  	fsparam_string	("access",	Opt_access),
>  	fsparam_flag	("posixacl",	Opt_posixacl),
>  	fsparam_u32	("locktimeout",	Opt_locktimeout),
> +	fsparam_s32	("ndentrytmo",	Opt_ndentrytmo),

Not better "ndentrytimeout" ?

My first thought was whether it was really worth introducing a dedicated
timeout option exactly for negative dentries (instead of a general cache
timeout option). But on a 2nd thought it actually needs separate handling, as
negative dentries have the potential to pollute with a ridiculous amount of
bogus entries.

Wouldn't it make sense to enable this option with some meaningful value for
say cache=loose by default? 24 hours maybe?

> 
>  	/* client options */
>  	fsparam_u32	("msize",	Opt_msize),
> @@ -159,6 +160,8 @@ int v9fs_show_options(struct seq_file *m, struct dentry
> *root) from_kgid_munged(&init_user_ns, v9ses->dfltgid));
>  	if (v9ses->afid != ~0)
>  		seq_printf(m, ",afid=%u", v9ses->afid);
> +	if (v9ses->ndentry_timeout != 0)
> +		seq_printf(m, ",ndentrytmo=%d", v9ses->ndentry_timeout);
>  	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
>  		seq_printf(m, ",uname=%s", v9ses->uname);
>  	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
> @@ -337,6 +340,10 @@ int v9fs_parse_param(struct fs_context *fc, struct
> fs_parameter *param) session_opts->session_lock_timeout =
> (long)result.uint_32 * HZ; break;
> 
> +	case Opt_ndentrytmo:
> +		session_opts->ndentry_timeout = result.int_32;
> +		break;
> +
>  	/* Options for client */
>  	case Opt_msize:
>  		if (result.uint_32 < 4096) {





