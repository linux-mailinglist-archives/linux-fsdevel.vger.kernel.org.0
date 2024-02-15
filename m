Return-Path: <linux-fsdevel+bounces-11700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD1185637A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7809281B67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D512D75B;
	Thu, 15 Feb 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SFCehM1i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZD2C3IWP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SFCehM1i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZD2C3IWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C012AACB;
	Thu, 15 Feb 2024 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000976; cv=none; b=thP7GcCTjpOuuun8uJILfPgUjPcy6QqdaZxQ0Gbl41sDNqCD/y7Ebf5TP487E1vzbfqlKi3kpHMSGHxV+F8u6euMYDQeeKZ/h2MIFwihGNvMO4PK7NejNVgC9vFTBQ4qCW9Xr44em2bhOqbn1k0nY4pJIbyiDO14RXV5QxhGpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000976; c=relaxed/simple;
	bh=L7i0tcy2cKPGn87m/3kZ9L7ExtZnPY9SJSD9OsMRP8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx8ehYw2T9U6Le4DLwCHHlF6Ae7Ye9/1og0/xDZIy33spdo68n8jh2FkcjMqlnEQLcOwiU/+fIeSuAfQ/XW5xScJSmbIAqMRHz9pvIvmRLcuYbHazZA53/LofCFux1SPHSa93fKlogprBMtmp2wjUcEtN5INw5mg+kMxAgUlL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SFCehM1i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZD2C3IWP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SFCehM1i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZD2C3IWP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 010891F88F;
	Thu, 15 Feb 2024 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708000972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xllyM6ganl1nkUdTCw7dKs4zu1EaUQeku+Rjbl7poO4=;
	b=SFCehM1i0eL+sOnqh6j56G4C/q2zS+cbmhg5mLeK71FLcnOiHc6cxMoD4IhU08kh3glFXP
	q+8Hy/BxIOVsPqoWXSih1xbyTGeHW6/8Za/nx5MhvCEEVyiALHMmeHpIaqdUCrZjoRUSqP
	ThPhgtf506qzJBb1S3ZDaBWvberFkG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708000972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xllyM6ganl1nkUdTCw7dKs4zu1EaUQeku+Rjbl7poO4=;
	b=ZD2C3IWPN70iRjUwEZcMgKUegCNZK9lM6VlWwkd3uS6MQL4FW4DrdYcnIbFvTxVtd1pd7m
	IsVBucz/sNZkaxCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708000972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xllyM6ganl1nkUdTCw7dKs4zu1EaUQeku+Rjbl7poO4=;
	b=SFCehM1i0eL+sOnqh6j56G4C/q2zS+cbmhg5mLeK71FLcnOiHc6cxMoD4IhU08kh3glFXP
	q+8Hy/BxIOVsPqoWXSih1xbyTGeHW6/8Za/nx5MhvCEEVyiALHMmeHpIaqdUCrZjoRUSqP
	ThPhgtf506qzJBb1S3ZDaBWvberFkG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708000972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xllyM6ganl1nkUdTCw7dKs4zu1EaUQeku+Rjbl7poO4=;
	b=ZD2C3IWPN70iRjUwEZcMgKUegCNZK9lM6VlWwkd3uS6MQL4FW4DrdYcnIbFvTxVtd1pd7m
	IsVBucz/sNZkaxCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E22AD139D0;
	Thu, 15 Feb 2024 12:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tzgtN8sGzmWsEAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 12:42:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8E7C5A0809; Thu, 15 Feb 2024 13:42:47 +0100 (CET)
Date: Thu, 15 Feb 2024 13:42:47 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	hughd@google.com, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 1/7] libfs: Rename "so_ctx"
Message-ID: <20240215124247.yfzxqbp6dirnvgrf@quack3>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786024524.11135.12492553100384328157.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170786024524.11135.12492553100384328157.stgit@91.116.238.104.host.secureserver.net>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.98%]
X-Spam-Flag: NO

On Tue 13-02-24 16:37:25, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Most of instances of "so_ctx" were renamed before the simple offset
> work was merged, but there were a few that were missed.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index eec6031b0155..bfbe1a8c5d2d 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -271,7 +271,7 @@ void simple_offset_init(struct offset_ctx *octx)
>   * @octx: directory offset ctx to be updated
>   * @dentry: new dentry being added
>   *
> - * Returns zero on success. @so_ctx and the dentry offset are updated.
> + * Returns zero on success. @octx and the dentry's offset are updated.
>   * Otherwise, a negative errno value is returned.
>   */
>  int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
> @@ -430,8 +430,8 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  
>  static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  {
> -	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
> -	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> +	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
> +	XA_STATE(xas, &octx->xa, ctx->pos);
>  	struct dentry *dentry;
>  
>  	while (true) {
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

