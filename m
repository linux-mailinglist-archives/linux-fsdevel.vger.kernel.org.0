Return-Path: <linux-fsdevel+bounces-78796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNCjKzsLomk3ygQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:23:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D71BE26E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A07930AD484
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112247A0B6;
	Fri, 27 Feb 2026 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG+0YFYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA102BE63F;
	Fri, 27 Feb 2026 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227372; cv=none; b=CpA8hhdSUIrXRFAqVYA0hqUhUXCoDC/OTBsr44mpMxImAfuFQu63JgAA16AmI7DCdRpRG3S0CfEhZ1mEmRT1tSB3UktDD8P9LkW3R8kDh9eqortyr/pLxUQ6gERCcZyVnENPd5HRZ/FkvswdwDh7WBSQvaEitePiky4GnwlTrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227372; c=relaxed/simple;
	bh=gdzxoUn2gxhPxqAZE2wnuoB0K0GDDb9MlkGqZ/c6Edk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2VzpwdN3+/Uqky2sUBy9FiuJyun/SKtaSEBrBw1ps5sCq4uLnNfgWZbtuUzSipfwtuffywSuMBNaSxagokdAwbL6oH2mH44NG6FXL0l2RycdW3x1Rvr7OgABIvs/xl7OfTpcZWJ9dYrYGuPmEwD+1pjvTPsBpEGW2xULPogJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG+0YFYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263E2C116C6;
	Fri, 27 Feb 2026 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772227372;
	bh=gdzxoUn2gxhPxqAZE2wnuoB0K0GDDb9MlkGqZ/c6Edk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IG+0YFYYtUAUb+23rDHJYKFU8SK8o4070YARNt9N3Nj/qUn8Tq4dktYf6wZ2hqh06
	 XZ8a5Cn7X4z2JY9gO7rFXYkCWHQDGqwWj4g28PUrzC46IgrG3tiir7tJuMpitY3gNg
	 RFBwdzNFVmzfn969s0VhfYuE3DZx7QEMoBPM79w4+3acu0XOmfwxQ+sWyPRIt1BOvG
	 t8h+rI7Cwfb3oqGHY5imm4je2+mBpxC0aBImRggF9jqarNyydQIe7IRUhtNxhZP1lX
	 ErT/H4J8H8hSiZ0ehxMQK1LYebJMjhBIXoqqs8YjQurzDS3+I/RLRWj3sU540OtjDX
	 rfm0CrtjlGykQ==
Date: Fri, 27 Feb 2026 13:22:47 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/14] ext4, fscrypt: merge fscrypt_mergeable_bio_bh into
 io_submit_need_new_bio
Message-ID: <20260227212247.GC2659@quark>
References: <20260226144954.142278-1-hch@lst.de>
 <20260226144954.142278-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226144954.142278-5-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-78796-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 0D4D71BE26E
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:49:24AM -0800, Christoph Hellwig wrote:
> ext4 already has the inode and folio and can't have a NULL
> folio->mapping in this path. Open code fscrypt_mergeable_bio_bh in
> io_submit_need_new_bio based on these simplifying assumptions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/crypto/inline_crypt.c | 23 -----------------------
>  fs/ext4/page-io.c        |  8 ++++++--
>  include/linux/fscrypt.h  |  9 ---------
>  3 files changed, 6 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index c0852b920dbc..0da53956a9b1 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -406,29 +406,6 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
>  }
>  EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
>  
> -/**
> - * fscrypt_mergeable_bio_bh() - test whether data can be added to a bio
> - * @bio: the bio being built up
> - * @next_bh: the next buffer_head for which I/O will be submitted
> - *
> - * Same as fscrypt_mergeable_bio(), except this takes a buffer_head instead of
> - * an inode and block number directly.
> - *
> - * Return: true iff the I/O is mergeable
> - */
> -bool fscrypt_mergeable_bio_bh(struct bio *bio,
> -			      const struct buffer_head *next_bh)
> -{
> -	const struct inode *inode;
> -	u64 next_lblk;
> -
> -	if (!bh_get_inode_and_lblk_num(next_bh, &inode, &next_lblk))
> -		return !bio->bi_crypt_context;
> -
> -	return fscrypt_mergeable_bio(bio, inode, next_lblk);
> -}
> -EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
> -
>  /**
>   * fscrypt_dio_supported() - check whether DIO (direct I/O) is supported on an
>   *			     inode, as far as encryption is concerned
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 88226979c503..3db3c19a29e5 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -441,11 +441,15 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
>  }
>  
>  static bool io_submit_need_new_bio(struct ext4_io_submit *io,
> +				   struct inode *inode,
> +				   struct folio *io_folio,
>  				   struct buffer_head *bh)
>  {
>  	if (bh->b_blocknr != io->io_next_block)
>  		return true;
> -	if (!fscrypt_mergeable_bio_bh(io->io_bio, bh))
> +	if (!fscrypt_mergeable_bio(io->io_bio, inode,
> +			(folio_pos(io_folio) + bh_offset(bh)) >>
> +			 inode->i_blkbits))
>  		return true;
>  	return false;
>  }
> @@ -456,7 +460,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
>  			     struct folio *io_folio,
>  			     struct buffer_head *bh)
>  {
> -	if (io->io_bio && io_submit_need_new_bio(io, bh)) {
> +	if (io->io_bio && io_submit_need_new_bio(io, inode, io_folio, bh)) {
>  submit_and_retry:
>  		ext4_io_submit(io);
>  	}

As in patch 2, this needs to use 'folio', not 'io_folio'.

- Eric

