Return-Path: <linux-fsdevel+bounces-77529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNKwFt9dlWkHPwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:36:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E9915376D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D519300E2BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBA6309DC5;
	Wed, 18 Feb 2026 06:36:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12E2EB5CD;
	Wed, 18 Feb 2026 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771396569; cv=none; b=fLDVvSBf07iu7soWi/+7ueOl590cJa/mL5R/yBHfgIbPYr4e/7mYkKLY96ou8B9bu/rUCqz5MLDsHgXpVW13PdSY4k2TC7XpD7gKc1x/f4cO2O3CDUKe1w0I/8f1e8I9L3ZTwA6ER36VkvPMeHxUioz2gdh5ytrNjdNmpq+e7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771396569; c=relaxed/simple;
	bh=mCMXBJ6iaPWA0+D3lrlPhTG3i5LKegeJ4ZtHscJK6aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul7pY9mD9U3tSH9tyG4JOlhtEKAT5BeyH5FzmpfWb5pmGygkcE5DskQilo060zxWMI8mdpyZ1shb/1mbR+c+P2RU+Ryj6S11nY3RNqrhj1S1fBbpeXT2JmqeK6P9DXgOLb5v/wVWrfejSXWnWVv3KzaZGVS0R+86nIrnrb6r1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 459A868B05; Wed, 18 Feb 2026 07:36:06 +0100 (CET)
Date: Wed, 18 Feb 2026 07:36:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	djwong@kernel.org
Subject: Re: [PATCH v3 11/35] iomap: allow filesystem to read fsverity
 metadata beyound EOF
Message-ID: <20260218063606.GD8600@lst.de>
References: <20260217231937.1183679-1-aalbersh@kernel.org> <20260217231937.1183679-12-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-12-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77529-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: F0E9915376D
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:11AM +0100, Andrey Albershteyn wrote:
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bd3ab4e6b2bf..6ebf68fdc386 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -533,18 +533,45 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,

I've looked at the modifications to iomap_read_folio_iter over the entire
series.  First comment is that it probably makes sense to have one patch
modifying this logic instead of multiple.  I also think the final result
can be improved quite a bit by a better code structure, see the patch
below against your full series.  I've left three XXX comments with
questions that are probably easier to ask there in the code then
separately, I hope this works for you.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9468c5d60b23..48c572d549aa 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -534,47 +534,53 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			return 0;
 
 		/*
-		 * We hits this for two case:
-		 * 1. No need to go further, the hole after fsverity descriptor
-		 * is the end of the fsverity metadata. No ctx->vi means we are
-		 * reading folio with descriptor.
-		 * 2. This folio contains merkle tree blocks which need to be
-		 * synthesized and fsverity descriptor. Skip these blocks as we
-		 * don't know how to synthesize them yet.
+		 * Handling of fsverity "holes". We hits this for two case:
+		 *   1. No need to go further, the hole after fsverity
+		 *	descriptor is the end of the fsverity metadata.
+		 *
+		 *	No ctx->vi means we are reading a folio with descriptor.
+		 *	XXX: what does descriptor mean here?  Also how do we
+		 *	even end up with this case?  I can't see how this can
+		 *	happe based on the caller?
+		 *
+		 *   2. This folio contains merkle tree blocks which need to be
+		 *	synthesized and fsverity descriptor.
 		 */
 		if ((iomap->flags & IOMAP_F_FSVERITY) &&
-		    (iomap->type == IOMAP_HOLE) &&
-		    !(ctx->vi)) {
-			iomap_set_range_uptodate(folio, poff, plen);
-			return iomap_iter_advance(iter, plen);
-		}
+		    iomap->type == IOMAP_HOLE) {
+		    	if (!ctx->vi) {
+				iomap_set_range_uptodate(folio, poff, plen);
+				/*
+				 * XXX: why return to the caller early here?
+				 */
+				return iomap_iter_advance(iter, plen);
+			}
 
-		/* zero post-eof blocks as the page may be mapped */
-		if (iomap_block_needs_zeroing(iter, pos) &&
-		    !(iomap->flags & IOMAP_F_FSVERITY)) {
+			/*
+			 * Synthesize the hash value for a zeroed folio if we
+			 * are reading merkle tree blocks.
+			 */
+			fsverity_folio_zero_hash(folio, poff, plen, ctx->vi);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else if (iomap_block_needs_zeroing(iter, pos) &&
+			   /*
+			    * XXX: do we still need the IOMAP_F_FSVERITY check
+			    * here, or is this all covered by the above one?
+			    */
+			   !(iomap->flags & IOMAP_F_FSVERITY)) {
+			/* zero post-eof blocks as the page may be mapped */
 			folio_zero_range(folio, poff, plen);
 			if (fsverity_active(iter->inode) &&
 			    !fsverity_verify_blocks(ctx->vi, folio, plen, poff))
 				return -EIO;
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
-			/*
-			 * Synthesize zero hash folio if we are reading merkle
-			 * tree blocks
-			 */
-			if ((iomap->flags & IOMAP_F_FSVERITY) &&
-			    (iomap->type == IOMAP_HOLE)) {
-				fsverity_folio_zero_hash(folio, poff, plen,
-							 ctx->vi);
-				iomap_set_range_uptodate(folio, poff, plen);
-			} else {
-				if (!*bytes_submitted)
-					iomap_read_init(folio);
-				ret = ctx->ops->read_folio_range(iter, ctx, plen);
-				if (ret)
-					return ret;
-				*bytes_submitted += plen;
-			}
+			if (!*bytes_submitted)
+				iomap_read_init(folio);
+			ret = ctx->ops->read_folio_range(iter, ctx, plen);
+			if (ret)
+				return ret;
+			*bytes_submitted += plen;
 		}
 
 		ret = iomap_iter_advance(iter, plen);

