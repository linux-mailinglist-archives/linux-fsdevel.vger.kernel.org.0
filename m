Return-Path: <linux-fsdevel+bounces-76043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMcLM/ClgGlNAAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:26:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B5CCB34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA223058199
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC496367F34;
	Mon,  2 Feb 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O8UcVMSw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cgHhQxOp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O8UcVMSw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cgHhQxOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD18366DB0
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038590; cv=none; b=IrxJRSMKftlmbpdb+/2OX1VcA/L6/eXm+/9zyLVP8hGKVx/VcZRydFCiVQKcnocmQ03s3MGLI4lC3firTjBh23f2JhqY4r6rUe/9tzFgaEdsQdU7DWkqFFgye+iZqxrRPK3K7sANc9KprQhqWehDYQnD5V+Z4Dyd5unxoQWyB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038590; c=relaxed/simple;
	bh=26zWbhZ3quDnRBRQlfNMUJkdmyZDQtdDoqRKUZfp39I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Abkg6v0IQN3DRY1pmCIxxZhH+PHAw9GxJce0CeXqSo3MFCWpemFxTQXwALsjqH+PGlnZCpI8fw7jMrCsOo6NBwUc1/FPq/EXT14/8lH/69vlVx4J3dhtOShwC3qXOMbgOwztr+8KNNmjBYqEzN9z6/Wn60BWZjR/lfGssBbMq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O8UcVMSw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cgHhQxOp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O8UcVMSw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cgHhQxOp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27BBB3E73A;
	Mon,  2 Feb 2026 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770038587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3Tl325ZHEOerEDjAj+q8fElNt5iSa6FovhV/OM3kno=;
	b=O8UcVMSwdPeSRo5QHDzpnoQD0utSyBGdT0SYM0yo2hsU46KRNF+GfCogeKKFwkIzmOf7ro
	505sveLamiJdLnPGaYJetc8kEKOv6un6N0ulUHFuVvS3BbSa4kCAGzgPw7PcXBXIzSITFs
	flH8tkLTPiYh0G+MXGOh2OsLaFgUgJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770038587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3Tl325ZHEOerEDjAj+q8fElNt5iSa6FovhV/OM3kno=;
	b=cgHhQxOp+6dEumsLPNF0vhuziX7oYprxduJvthIKF38+P8f5oQgW3llE+f0B+9UO+RYfwL
	hxqIdbhsL8UMqwAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770038587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3Tl325ZHEOerEDjAj+q8fElNt5iSa6FovhV/OM3kno=;
	b=O8UcVMSwdPeSRo5QHDzpnoQD0utSyBGdT0SYM0yo2hsU46KRNF+GfCogeKKFwkIzmOf7ro
	505sveLamiJdLnPGaYJetc8kEKOv6un6N0ulUHFuVvS3BbSa4kCAGzgPw7PcXBXIzSITFs
	flH8tkLTPiYh0G+MXGOh2OsLaFgUgJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770038587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3Tl325ZHEOerEDjAj+q8fElNt5iSa6FovhV/OM3kno=;
	b=cgHhQxOp+6dEumsLPNF0vhuziX7oYprxduJvthIKF38+P8f5oQgW3llE+f0B+9UO+RYfwL
	hxqIdbhsL8UMqwAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 103EB3EA62;
	Mon,  2 Feb 2026 13:23:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BhrnAzulgGlVUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Feb 2026 13:23:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC3ABA08F8; Mon,  2 Feb 2026 14:23:02 +0100 (CET)
Date: Mon, 2 Feb 2026 14:23:02 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 01/11] fsverity: don't issue readahead for non-ENOENT
 errors from __filemap_get_folio
Message-ID: <5tbvx3urecnju72wyvursogffocasy43jcizxncdhl34w72row@blj7csijokcg>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202060754.270269-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202060754.270269-2-hch@lst.de>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim,lst.de:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76043-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 2F2B5CCB34
X-Rspamd-Action: no action

On Mon 02-02-26 07:06:30, Christoph Hellwig wrote:
> Issuing more reads on errors is not a good idea, especially when the
> most common error here is -ENOMEM.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/verity/pagecache.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> index 01c652bc802f..1a88decace53 100644
> --- a/fs/verity/pagecache.c
> +++ b/fs/verity/pagecache.c
> @@ -22,7 +22,8 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
>  	struct folio *folio;
>  
>  	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +	if (folio == ERR_PTR(-ENOENT) ||
> +	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>  
>  		if (!IS_ERR(folio))
> @@ -30,9 +31,9 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
>  		else if (num_ra_pages > 1)
>  			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
>  		folio = read_mapping_folio(inode->i_mapping, index, NULL);
> -		if (IS_ERR(folio))
> -			return ERR_CAST(folio);
>  	}
> +	if (IS_ERR(folio))
> +		return ERR_CAST(folio);
>  	return folio_file_page(folio, index);
>  }
>  EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

