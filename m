Return-Path: <linux-fsdevel+bounces-75773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP9MCTI6emlB4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:32:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0573EA5CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B814230141D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87C25A2B4;
	Wed, 28 Jan 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpq9jZw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92A225390;
	Wed, 28 Jan 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617957; cv=none; b=SJvOGtXg0eZQnsWhY+MbIlP6YvUGe6mAm6mZfxwZjiOa+NhokcXjC7wu9mlx8HSlTamqmBKOSRF+WnpInttQIVF6jko3VD9wfTiGFOCKCNUDv+elIZ7ER+QEzZmeJmQJb9+B3nzUD6Q2+QFu3UXX+7omb0i0tgv9GSPj61dXmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617957; c=relaxed/simple;
	bh=Gjb2XTAZWQfSBe91HGBLrPlle2AZt8PjScnsQefnGR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/HLzEH5PMQFnrWLEYXxcyq5rjIxee6TMJG1wF7PWc7+z6+HD4W1+i1C9mgo4BtHSVe3+S1KgfJQC/aLQcXLNgyAfSmga4CXBkES462Xcv8eFeJl6Kyt1yv2+zuG4VWeutacnAXJf5+kYtKdVpAPJkABKoAajUngffrh2R9NJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpq9jZw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0571EC4CEF1;
	Wed, 28 Jan 2026 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769617957;
	bh=Gjb2XTAZWQfSBe91HGBLrPlle2AZt8PjScnsQefnGR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vpq9jZw7FiRK7Z0GIVDuXc/zZaROTPIvzGYU5/r5D+r2Cs7yOWAHIsHqiLLVnG+3o
	 qo06koxxi6EUbScDMHHhnu78QPzXVFyDQKnL2KXYhO+M4ChUi2wyx+t47kkF50efIE
	 hJDn+IvRmh2vz9XLJ0yNvVUY9jOXoReY5c1yUxmIzA8tFAt6/MWz/ZyPm/Tih4127y
	 Io4TBpP34WeyBJEnx7IYBZytusCqOE04d2NTeg1wr3T5VaYPmRlSYCAOIJ980wIFF9
	 P3c6BuytXZ5EMl+/U2qFpn9KFfXx7k6hChqD9G99r22F5e7SGTzzmsFwwe+PHa7Fly
	 n32UX0Y+r4n9Q==
Date: Wed, 28 Jan 2026 08:32:36 -0800
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
Subject: Re: [PATCH 07/15] fsverity: don't issue readahead for non-ENOENT
 errors from __filemap_get_folio
Message-ID: <20260128163236.GZ5910@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75773-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 0573EA5CAF
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:26:19PM +0100, Christoph Hellwig wrote:
> Issuing more reads on errors is not a good idea, especially when the
> most common error here is -ENOMEM.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine, and I still hate the C type system and all its
barely-mentioned subtleties that cause endless discussion

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
>  
>  		if (!IS_ERR(folio))
> -- 
> 2.47.3
> 
> 

