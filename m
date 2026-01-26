Return-Path: <linux-fsdevel+bounces-75458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIZJAt1dd2n8eQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:28:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 991CC8834B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE4F30500D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21492336ED4;
	Mon, 26 Jan 2026 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DV6bF7eq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xQu1Vaj2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DV6bF7eq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xQu1Vaj2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFCD3358B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430356; cv=none; b=eWuFnDQm9oD0dvfTaG3rx0K8qvvZCs1Dc0hwcgDKXAT/GzJUha68+dyINRg9qr1DzbLlDGv4Ew+RxZd8Q3IaX03wFAxVG/UTLr1xM2jCr3QPBLDD2BVQtuDGe7xmGPDbT3GUHrIpaM7ENCZE97Ly5himu5JbyH/luPAuNWJrzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430356; c=relaxed/simple;
	bh=Kr4pbVAoBFAOKe2U2uBURLxkQoX4sPLhP+FSjqBHdKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAgCwxEYF4R0LSca68eN32nwTbwZ+wi+LZ+hdcCHDez2AtJ2dAmnel8LIktS1lfxzujQX7U4JPZZWaRipUe0uqbjapu5ryn/tXQt/vk4TKPsIG1q/fr939JP99gAj50pheQZbG3OsiVorJ1g97x8J0HT5efmJmBVSX9eEjIY5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DV6bF7eq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xQu1Vaj2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DV6bF7eq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xQu1Vaj2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EFE55BD1B;
	Mon, 26 Jan 2026 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769430352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=;
	b=DV6bF7eqdQr2AN0P1dcCs6x0cm8pWr4LSFosTEpOhfiuvkhCtsBrB40ysodlBnkmFoGcv6
	0RTw3uV3Qp4wlszR5+qp9cHCZGuxPpcKZLET1Zx6QmhvisQ82a5IqV7qDlQAIMGKwUETmf
	4d/SJRh543uV7kOnTmGZpBb+K/NheRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769430352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=;
	b=xQu1Vaj2hOyr+jI7u+4QgtHTf4F9pC9MtwBJ4E6l1wEJ8fFIB0IxNG37PdCg4yes2oU76C
	9wiHu+43jgJJXuCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769430352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=;
	b=DV6bF7eqdQr2AN0P1dcCs6x0cm8pWr4LSFosTEpOhfiuvkhCtsBrB40ysodlBnkmFoGcv6
	0RTw3uV3Qp4wlszR5+qp9cHCZGuxPpcKZLET1Zx6QmhvisQ82a5IqV7qDlQAIMGKwUETmf
	4d/SJRh543uV7kOnTmGZpBb+K/NheRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769430352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MV3F0STu6B93gps4cXK23myNu3IPJ1yHxMz64iA9XOo=;
	b=xQu1Vaj2hOyr+jI7u+4QgtHTf4F9pC9MtwBJ4E6l1wEJ8fFIB0IxNG37PdCg4yes2oU76C
	9wiHu+43jgJJXuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2688C139F0;
	Mon, 26 Jan 2026 12:25:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yQdgCVBdd2kiEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Jan 2026 12:25:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D95E1A0A4F; Mon, 26 Jan 2026 13:25:47 +0100 (CET)
Date: Mon, 26 Jan 2026 13:25:47 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 12/16] fs: consolidate fsverity_info lookup in buffer.c
Message-ID: <dmqdpe5kyb43kniwsbogdhw6oiktponzcy3nx3zkvuhoxrlkdk@fyzrntl6aihe>
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
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:email,suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75458-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 991CC8834B
X-Rspamd-Action: no action

On Mon 26-01-26 05:50:58, Christoph Hellwig wrote:
> Look up the fsverity_info once in end_buffer_async_read_io, and then
> pass it along to the I/O completion workqueue in
> struct postprocess_bh_ctx.
> 
> This amortizes the lookup better once it becomes less efficient.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

