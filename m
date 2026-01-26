Return-Path: <linux-fsdevel+bounces-75517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD7ROL+9d2l8kgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:17:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 664CC8C782
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9B94301BA58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2B283FC4;
	Mon, 26 Jan 2026 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmrG1E8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4B27E1DC;
	Mon, 26 Jan 2026 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455032; cv=none; b=Zvk/IG61LMvlyVmT3wm9MO2TJcFM2dLLiLpnsc5eBepKq7/g7RvrWxVMRYTgKnIYbVlGKLdsDnijvjj4WMOZQiaD8P74bBZTJGOs3RrnbPvWsxAriiEkWAMAwCpWOe/THgbeW7VhZ651HVrz9LiEDKpEBPl5sY0W8uClOfW7uiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455032; c=relaxed/simple;
	bh=c6mwFMvXEjiLFJR+TWQqYQK8IA/G2ahMYoJYI7/EcS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mp6dksxkFOcZbYkGN9S7brcs7Qol9iz7OP/JBZ4Fu3wsebUdqqUKE+JutoF8nnFjHXCvmHKkl9J7TkTlVv/6Gd9tM8kCKuO3Sp4DOfzoXrhy6dhWsNRBWcQIhu2cZ9Qays7Bmhu+hIfcwacpiA7urJ3PC9dSRJJ/+cfBVn23418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmrG1E8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162EBC116C6;
	Mon, 26 Jan 2026 19:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455032;
	bh=c6mwFMvXEjiLFJR+TWQqYQK8IA/G2ahMYoJYI7/EcS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmrG1E8MKuZ5yhsArszWcM106CYHh/uuhUonO/jdtqKqzIOy21hYAvsiaEgAOrf/X
	 y0VVW9BDFbqwnN+F+86Iow7YSBRegzlCGcpzAIeROc+rJEJjOig3lgBSu0kQ8uekv5
	 Oscknqqn+TUFH/nEkTO/nY0sjKfko4z0SN/FLbp79i7njAuAhnF5XuRRcI5xkJnYwT
	 a4cvFZ9nvjJmj2sdZgiVxTdnb1aWDZAB23bqeGzUfxpwoogVd05goiDW9KEUmPNwQk
	 ZOL/tvCF3Qao9Xl9hT4jTF+cujHvL8mJSDNNHqJc48gX5pdgyAiz5kBIYBm3KtkUBk
	 0mjhNOmkxIL3g==
Date: Mon, 26 Jan 2026 11:17:11 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 12/16] fs: consolidate fsverity_info lookup in buffer.c
Message-ID: <20260126191711.GR5910@frogsfrogsfrogs>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-13-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75517-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 664CC8C782
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:50:58AM +0100, Christoph Hellwig wrote:
> Look up the fsverity_info once in end_buffer_async_read_io, and then
> pass it along to the I/O completion workqueue in
> struct postprocess_bh_ctx.
> 
> This amortizes the lookup better once it becomes less efficient.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/buffer.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 3982253b6805..f4b3297ef1b1 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -302,6 +302,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  struct postprocess_bh_ctx {
>  	struct work_struct work;
>  	struct buffer_head *bh;
> +	struct fsverity_info *vi;
>  };
>  
>  static void verify_bh(struct work_struct *work)
> @@ -309,25 +310,14 @@ static void verify_bh(struct work_struct *work)
>  	struct postprocess_bh_ctx *ctx =
>  		container_of(work, struct postprocess_bh_ctx, work);
>  	struct buffer_head *bh = ctx->bh;
> -	struct inode *inode = bh->b_folio->mapping->host;
>  	bool valid;
>  
> -	valid = fsverity_verify_blocks(*fsverity_info_addr(inode), bh->b_folio,
> -				       bh->b_size, bh_offset(bh));
> +	valid = fsverity_verify_blocks(ctx->vi, bh->b_folio, bh->b_size,
> +				       bh_offset(bh));
>  	end_buffer_async_read(bh, valid);
>  	kfree(ctx);
>  }
>  
> -static bool need_fsverity(struct buffer_head *bh)
> -{
> -	struct folio *folio = bh->b_folio;
> -	struct inode *inode = folio->mapping->host;
> -
> -	return fsverity_active(inode) &&
> -		/* needed by ext4 */
> -		folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> -}
> -
>  static void decrypt_bh(struct work_struct *work)
>  {
>  	struct postprocess_bh_ctx *ctx =
> @@ -337,7 +327,7 @@ static void decrypt_bh(struct work_struct *work)
>  
>  	err = fscrypt_decrypt_pagecache_blocks(bh->b_folio, bh->b_size,
>  					       bh_offset(bh));
> -	if (err == 0 && need_fsverity(bh)) {
> +	if (err == 0 && ctx->vi) {
>  		/*
>  		 * We use different work queues for decryption and for verity
>  		 * because verity may require reading metadata pages that need
> @@ -359,15 +349,20 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
>  {
>  	struct inode *inode = bh->b_folio->mapping->host;
>  	bool decrypt = fscrypt_inode_uses_fs_layer_crypto(inode);
> -	bool verify = need_fsverity(bh);
> +	struct fsverity_info *vi = NULL;
> +
> +	/* needed by ext4 */
> +	if (bh->b_folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> +		vi = fsverity_get_info(inode);
>  
>  	/* Decrypt (with fscrypt) and/or verify (with fsverity) if needed. */
> -	if (uptodate && (decrypt || verify)) {
> +	if (uptodate && (decrypt || vi)) {
>  		struct postprocess_bh_ctx *ctx =
>  			kmalloc(sizeof(*ctx), GFP_ATOMIC);
>  
>  		if (ctx) {
>  			ctx->bh = bh;
> +			ctx->vi = vi;
>  			if (decrypt) {
>  				INIT_WORK(&ctx->work, decrypt_bh);
>  				fscrypt_enqueue_decrypt_work(&ctx->work);
> -- 
> 2.47.3
> 
> 

