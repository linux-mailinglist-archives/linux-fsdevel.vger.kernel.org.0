Return-Path: <linux-fsdevel+bounces-75537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFPYF1HVd2mFlwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:57:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2648D630
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B093058BBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066262D8DCA;
	Mon, 26 Jan 2026 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZWXMCWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C912BF3CC;
	Mon, 26 Jan 2026 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460784; cv=none; b=KCzNtQUpgLGas6cL2vIJHTLiHBsQdToOGw2PbNqRuw1g8bC8ruObPTEF9iZwyfPrxmViF6UQAUD3U2vwKdcNpyBa9aKXDwYqJ6FuG/e2+/0UDyFQHmnsjw43V5pL6bf/OdDiFdE+8kQba5WzTIY0deMZVqm7XQ/hJk0v3TXWmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460784; c=relaxed/simple;
	bh=TkdZAEHLoZVW6dNs7U/9PTST8Ny56M8c0+/eFzOYBvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCfaznwU4boDFWU0S8Yr/KmyR8Eq6JypEuFn4B2Tl1VvxNC2N3k0lovVFaUkeA83XDyHrZMr1hLF7d4mf+caplC5AuGTbHsOBPtZoywr84Rwa+EMPmtt4LENgF6IdJ7UdIJGikfNdqsGUUdaNaELu2nZtBcUo50Xng2hnN6UJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZWXMCWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D16EC116C6;
	Mon, 26 Jan 2026 20:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769460784;
	bh=TkdZAEHLoZVW6dNs7U/9PTST8Ny56M8c0+/eFzOYBvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZWXMCWxHJ0tK1fvd3LwZN12C8TxdX8K7aUxfNiW2T8u22fQjivNmH4uEyABRVEoV
	 GPlLUp4YhcrFMRNRU9DgYuMDpM9kkSGLvTQrIQfKDaVFMKcc1mceuyy83UERMGhTQx
	 1mcedkcUNatj9dpAlswBq7c8gseKUbax/FBX5umcKjpk5NMkV6WHlGFOQWTyBAfQaf
	 UsjcT4ChuK8ryu+wbC0HIuSb71aTT6dcdO9GFJC1Lyf5DCxaWcWOjE61A0QDL3T3Fb
	 6zxB+40sjKUa92xpoHKbBTTTdg4Zcbqjpk60VVAq3lbBtCk4TKDtwLho9XKIJnvZOj
	 oZJBc6ED8t7Fw==
Date: Mon, 26 Jan 2026 12:53:01 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 07/16] fsverity: don't issue readahead for non-ENOENT
 errors from __filemap_get_folio
Message-ID: <20260126205301.GD30838@quark>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-8-hch@lst.de>
 <20260126191102.GO5910@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126191102.GO5910@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75537-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB2648D630
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 11:11:02AM -0800, Darrick J. Wong wrote:
> On Mon, Jan 26, 2026 at 05:50:53AM +0100, Christoph Hellwig wrote:
> > Issuing more reads on errors is not a good idea, especially when the
> > most common error here is -ENOMEM.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/verity/pagecache.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> > index 1efcdde20b73..63393f0f5834 100644
> > --- a/fs/verity/pagecache.c
> > +++ b/fs/verity/pagecache.c
> > @@ -22,7 +22,8 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
> >  	struct folio *folio;
> >  
> >  	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> > -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> > +	if (PTR_ERR(folio) == -ENOENT ||
> > +	    !(IS_ERR(folio) && !folio_test_uptodate(folio))) {
> 
> I don't understand this logic at all.  If @folio is actually an
> ERR_PTR, then we dereference the non-folio to see if it's not uptodate?
> 
> I think (given the previous revisions) that what you want is to initiate
> readahead if either there's no folio at all (ENOENT) or if there is a
> folio but it's not uptodate?  But not if there's some other error
> (ENOMEM, EL3HLT, EFSCORRUPTED, etc)?
> 
> So maybe you want:
> 
> 	folio = __filemap_get_folio(...);
> 	if (!IS_ERR(folio)) {
> 		if (folio_test_uptodate(folio))
> 			return folio_file_page(folio);
> 		folio_put(folio);
> 	} else if (PTR_ERR(folio) == -ENOENT) {
> 		return ERR_CAST(folio);
> 	}
> 
> 	if (num_ra_pages > 1)
> 		page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> 	folio = read_mapping_folio(inode->i_mapping, index, NULL);
> 	if (IS_ERR(folio))
> 		return ERR_CAST(folio);
> 
> 	return folio_file_page(folio);
> 
> <confused>

That version is wrong too: the condition 'PTR_ERR(folio) == -ENOENT' is
backwards.

This code gets replaced later in the series anyway.  For this patch, we
could simply insert two lines:

	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
+	if (IS_ERR(folio) && folio != ERR_PTR(-ENOENT))
+		return folio;

Then for the final version in generic_readahead_merkle_tree(), one
option would be:

	struct folio *folio;

	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
	if (folio == ERR_PTR(-ENOENT) ||
	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);

		page_cache_ra_unbounded(&ractl, nr_pages, 0);
	}
	if (!IS_ERR(folio))
		folio_put(folio);

Or as a diff from this series:

-	if (PTR_ERR(folio) == -ENOENT ||
-	    !(IS_ERR(folio) && !folio_test_uptodate(folio))) {
+	if (folio == ERR_PTR(-ENOENT) ||
+	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {

(Note that PTR_ERR() shouldn't be used before it's known that the
pointer is an error pointer.)

- Eric

