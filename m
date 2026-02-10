Return-Path: <linux-fsdevel+bounces-76852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BIIBIVai2ljUAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:19:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15611D0A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0443300A323
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340B3876DF;
	Tue, 10 Feb 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sgxfn2gV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1242DA75A;
	Tue, 10 Feb 2026 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740350; cv=none; b=i/9AOmgyvBMvtsFYfW1FW8tYxx/aI//kUhdW01sPkC0rEayXKB2g7ISzvcwF7Hps2Ga/oj4TQfbfktdiQiTNYrTDVkyIbTU0qzMn4azbT7n5tjyTrAjhSFU2/qZq59FIDxKsZGC1lE0BOaLRNvd5u6e/ZljxbqW2UW9fB1B14dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740350; c=relaxed/simple;
	bh=DJgpqDgCDLe3uWVySnf1XSHMXSBUe6qPOwn/xpZjWJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrXdM55jLzCRU8VavIktzOTsjzRNiCq18Q4Nwe1HcIzCqpoHu/LqvpI11zA58a6/SR4VKlhNWOd+vd3DJYnoFg9XesMgMZaO1cLr0miTVffqEBRDyYXkBZGsSqGVYXLRdupclipXsWXxqLVOr9nLQ5Wi7bY/zbT6mRa7Uvl/pxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sgxfn2gV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PGesva70mslEDm8VYYOxxhMMj39lZTeJUpaUgZeqCFs=; b=Sgxfn2gV3O8tsllkd4lZB+PbMS
	C/LKAKk9csEzyBZSndd0metDMHwo4WGhp//i2S9y1Ez0Fo2KnqEhAR2KbJwb62LWScAGz1SzmMQfy
	r1XFso1GnCyy03+4f68zj1zhFQzSUbP3IL4cQHnhOaROw9BHgfVKJeaZyxE7NHFXrhcLHFvWRRhI/
	EwAnenzyDSPpwNTXtce3wzDwrYDY0HhWRFv3XYkRu6LjozQCy+6FWbQUdlVicjRQatRdq0h5X2Z8o
	4bZuy+g6VT6+Ge64agQZOimRzwe8N6MvSs+Onn1wWes7opNCGkFye2G2/r5LuQ33yVXBUcY+z0mcx
	j2VKT3cA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpqSD-0000000HDJQ-1qtf;
	Tue, 10 Feb 2026 16:19:09 +0000
Date: Tue, 10 Feb 2026 08:19:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 4/5] xfs: only flush when COW fork blocks overlap data
 fork holes
Message-ID: <aYtafWEg11UBZwge@infradead.org>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129155028.141110-5-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76852-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: EE15611D0A1
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:50:27AM -0500, Brian Foster wrote:
> The zero range hole mapping flush case has been lifted from iomap
> into XFS. Now that we have more mapping context available from the
> ->iomap_begin() handler, we can isolate the flush further to when we
> know a hole is fronted by COW blocks.
> 
> Rather than purely rely on pagecache dirty state, explicitly check
> for the case where a range is a hole in both forks. Otherwise trim
> to the range where there does happen to be overlap and use that for
> the pagecache writeback check. This might prevent some spurious
> zeroing, but more importantly makes it easier to remove the flush
> entirely.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/xfs/xfs_iomap.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 0edab7af4a10..0e82b4ec8264 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1760,10 +1760,12 @@ xfs_buffered_write_iomap_begin(
>  {
>  	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
>  						     iomap);
> +	struct address_space	*mapping = inode->i_mapping;
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> +	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
>  	struct xfs_bmbt_irec	imap, cmap;
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
> @@ -1831,6 +1833,8 @@ xfs_buffered_write_iomap_begin(
>  		}
>  		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
>  				&ccur, &cmap);
> +		if (!cow_eof)
> +			cow_fsb = cmap.br_startoff;
>  	}
>  
>  	/* We never need to allocate blocks for unsharing a hole. */
> @@ -1845,17 +1849,37 @@ xfs_buffered_write_iomap_begin(
>  	 * writeback to remap pending blocks and restart the lookup.
>  	 */
>  	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> -		if (filemap_range_needs_writeback(inode->i_mapping, offset,
> -						  offset + count - 1)) {
> +		loff_t start, end;
> +
> +		imap.br_blockcount = imap.br_startoff - offset_fsb;
> +		imap.br_startoff = offset_fsb;
> +		imap.br_startblock = HOLESTARTBLOCK;
> +		imap.br_state = XFS_EXT_NORM;
> +
> +		if (cow_fsb == NULLFILEOFF) {
> +			goto found_imap;
> +		} else if (cow_fsb > offset_fsb) {

No need for an else after a goto.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I wonder if at some point the zeroing logic should be split into a
separate helper..

