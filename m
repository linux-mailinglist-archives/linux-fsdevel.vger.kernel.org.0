Return-Path: <linux-fsdevel+bounces-75820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNcLAHugemmn8gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:49:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86675AA099
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBC673043D3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 23:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06342345CA0;
	Wed, 28 Jan 2026 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkjG2NtO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA632D7DF3;
	Wed, 28 Jan 2026 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769644097; cv=none; b=GvIgPOiLvkv6YV4TNCZMwr5KQzfhNesk2D0q8QBUdB51e2z8pcUawzwd3/jTjxRCsNDb9Qc7cXbXOFkQa329WmZ72VhhmCW2aKbjERjveJ7EFXZgG86pmlTo6gVhAzNVf5uUapppJixJW9oDgsYqM63FBeBfAqV3EEHsRcgCkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769644097; c=relaxed/simple;
	bh=hvMXm14By+MD7GzcKQWzW8IPoc0TXledHjjG+W0sMDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwvc264dikj1PaCw7dE3nWUUWGHubVGTUjfyw5KrGFfSnYNjPAaF5GMvYyypAnqAYALygra+aM9iLYLXLgc8EN428EVrlEK1WvOaZFZwZi+7Du5ZkMDHnwI3ynGQoNFnZC7q++MyW4p5F9hcfhHm5xJyRH/v+lu/rnK9dNUxYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkjG2NtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEDEC4CEF7;
	Wed, 28 Jan 2026 23:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769644097;
	bh=hvMXm14By+MD7GzcKQWzW8IPoc0TXledHjjG+W0sMDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkjG2NtOSWrGaDkEuNFbAXIvv42R7VcPyXsnFUJKK5dJ3zlpMIrAO+ckNPe4RUwQA
	 yDsKcuXXTAcMdQJ2/I0EB2301uLi1Kn4ntgejOaES8DO2zT6cyFm9zslQAjZfqNikP
	 QHQIB41Igq37rR/UtdPXtyPWRnzeEqh6t4Tw/LMPobIaSDKZOIVfoFFNJR4qFmyp/H
	 Tk3fVUONExASoE6FKfzFRH7ko6qJRMzbUoU0C8dA+TMhNUnKo0KxWVVdH3DaKioRRv
	 EYWgqfjh/DSxRCBH7bDVbDwCUr1GNVgCWAcgVQZ4wRaeRqejQk90xMKIT0jxRXyM4N
	 ofn/OEf9n3LMQ==
Date: Wed, 28 Jan 2026 15:48:14 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 07/15] fsverity: don't issue readahead for non-ENOENT
 errors from __filemap_get_folio
Message-ID: <20260128234814.GC2024@quark>
References: <20260128152630.627409-1-hch@lst.de>
 <20260128152630.627409-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128152630.627409-8-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75820-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 86675AA099
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:26:19PM +0100, Christoph Hellwig wrote:
> Issuing more reads on errors is not a good idea, especially when the
> most common error here is -ENOMEM.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/verity/pagecache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> index f67248e9e768..eae419d8d091 100644
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

This patch is still incorrect: when IS_ERR(folio) && folio !=
ERR_PTR(-ENOENT) it falls through to folio_file_page(), which crashes.
See https://lore.kernel.org/r/20260126205301.GD30838@quark/ for a
correct suggestion.

- Eric

