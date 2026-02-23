Return-Path: <linux-fsdevel+bounces-77979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJC1LrWAnGmLIgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:30:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846E179CEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5109B304F037
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE58313E21;
	Mon, 23 Feb 2026 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpZHqKCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1C30FC1D;
	Mon, 23 Feb 2026 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864060; cv=none; b=LZFIouZD2SWuOWWzdIgJMvDtIJfQi3DxwtYkZFUk6Wc+YvtBlXtZz6TgOAGy2M7//UkV4SM1FFPWKD38uOamqL0vgGS2/a41hEHm2iozPoibJjUOFaHfSBkJCntd9zP1RuBUv8JfVaUVsqkQSlixYWVbzou5Ufqbz84oLhCSzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864060; c=relaxed/simple;
	bh=fzmMAPqHr6UY1W4QOVefe5i2Klnyid7y4W4h12ZJ2Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwMW/WX1Lx42fVqraMDhJpwsbkntahoPoXrc8zxcbgzgNc9+pp0I4pKy18NE9bkILaMcUoK8UXbbqD2M1WENro+MVd16b2xYVfWJm0TU6CaWnrvNr1goJHYFd/7/UpBzvoUxI0v9BtHge5Tu0W+ID4DnYmQeKHfyFt1cfmHm43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpZHqKCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4C0C116C6;
	Mon, 23 Feb 2026 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771864060;
	bh=fzmMAPqHr6UY1W4QOVefe5i2Klnyid7y4W4h12ZJ2Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpZHqKCQVoqovvBwyXxOJHCiEMZrA6Q/JpYJGnJIIc2oQPs06MEKkI2nY/zfzmSWW
	 RUMoIBImCulZAFA1eRig7dOUjjvPSv7vrLnjoa5hpGddB6C8VZjV9DU4c5omi5GA3V
	 kbB0tp1pQ4yEZCNRLtkWc/NrBeyohlbB9FoijXBqBflMlKjQa+/gXYebPitszzgJUv
	 76a515aLdWGxWI/p9dF+d2BNiOHcnnrwsg1RCAZbpUyI9HB5oyHCU9SRwIoBytvTdg
	 eBnyigzBpUc4z5n0YMet2oqc1k0UhJU4y9u22UoLfJJqBTVOPfxsZ50XKnQE1Okwbx
	 2Kc+0pi50pInA==
Date: Mon, 23 Feb 2026 08:27:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/16] ntfs3: remove copy and pasted iomap code
Message-ID: <20260223162739.GC2390353@frogsfrogsfrogs>
References: <20260223132021.292832-1-hch@lst.de>
 <20260223132021.292832-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223132021.292832-13-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77979-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 6846E179CEA
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 05:20:12AM -0800, Christoph Hellwig wrote:
> ntfs3 copied the iomap code without attribution or talking to the
> maintainers, to hook into the bio completion for (unexplained) zeroing.

Well they /did/ attribute it...

> Fix this by just overriding the bio completion handler in the submit
> handler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ntfs3/inode.c | 51 +++---------------------------------------------
>  1 file changed, 3 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 7ab4e18f8013..60af9f8e0366 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -605,63 +605,18 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> -/*
> - * Copied from iomap/bio.c.

...extremely poorly, by not recording their reasons for copy-pasting the
code.

> - */
> -static int ntfs_iomap_bio_read_folio_range(const struct iomap_iter *iter,
> -					   struct iomap_read_folio_ctx *ctx,
> -					   size_t plen)
> -{
> -	struct folio *folio = ctx->cur_folio;
> -	const struct iomap *iomap = &iter->iomap;
> -	loff_t pos = iter->pos;
> -	size_t poff = offset_in_folio(folio, pos);
> -	loff_t length = iomap_length(iter);
> -	sector_t sector;
> -	struct bio *bio = ctx->read_ctx;
> -
> -	sector = iomap_sector(iomap, pos);
> -	if (!bio || bio_end_sector(bio) != sector ||
> -	    !bio_add_folio(bio, folio, plen, poff)) {
> -		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> -		gfp_t orig_gfp = gfp;
> -		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> -
> -		if (bio)
> -			submit_bio(bio);
> -
> -		if (ctx->rac) /* same as readahead_gfp_mask */
> -			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
> -				gfp);
> -		/*
> -		 * If the bio_alloc fails, try it again for a single page to
> -		 * avoid having to deal with partial page reads.  This emulates
> -		 * what do_mpage_read_folio does.
> -		 */
> -		if (!bio)
> -			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
> -		if (ctx->rac)
> -			bio->bi_opf |= REQ_RAHEAD;
> -		bio->bi_iter.bi_sector = sector;
> -		bio->bi_end_io = ntfs_iomap_read_end_io;
> -		bio_add_folio_nofail(bio, folio, plen, poff);
> -		ctx->read_ctx = bio;
> -	}
> -	return 0;
> -}

Yeah, identical to iomap_bio_read_folio_range except for setting
bi_end_io.

Don't copy-paste stuff.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> -
>  static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
>  		struct iomap_read_folio_ctx *ctx)
>  {
>  	struct bio *bio = ctx->read_ctx;
>  
> +	bio->bi_end_io = ntfs_iomap_read_end_io;
>  	submit_bio(bio);
>  }
>  
>  static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
> -	.read_folio_range = ntfs_iomap_bio_read_folio_range,
> -	.submit_read = ntfs_iomap_bio_submit_read,
> +	.read_folio_range	= iomap_bio_read_folio_range,
> +	.submit_read		= ntfs_iomap_bio_submit_read,
>  };
>  
>  static int ntfs_read_folio(struct file *file, struct folio *folio)
> -- 
> 2.47.3
> 
> 

