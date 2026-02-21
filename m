Return-Path: <linux-fsdevel+bounces-77863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGFnG9sNmmm5YAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:56:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2444F16DBFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB07C302810E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941F6340D8C;
	Sat, 21 Feb 2026 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9ki9g1i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88F311587;
	Sat, 21 Feb 2026 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703768; cv=none; b=PeRAi5eOvxzknXeLk2MpkR42sBjDnU7USiVZfUKhtBEbDKfObs0sD98eb71ATPTd3vtjGE5ix+eE+1r0rNZ4ECbiQLVxamdMhPrss/amzy0jH33x4eenKP7chCZ8uhUqymWWCGXir1YUuRpAzi7owQPzHYnO5vZt7YHfhpOUQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703768; c=relaxed/simple;
	bh=R7/z9C7qpx7IpjmeTzkpHTTwUmtvP03YWgReVTnc/oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgj9A+BD2PAAvY2eB+DzAyffx7OAt76YBOf4Clk7o+A8pfe78kPooRRuKSBwk+9STtcmoQsUhMnfcJOfQP8m9JKi3i9kpbWCXwXotXfbB+L8W1PWY3x/fDI39LUSeAnRMZEzSo9qzVGl99T+hRlF2WGLjbeyGoNSows0+gXEGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9ki9g1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A524EC4CEF7;
	Sat, 21 Feb 2026 19:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771703768;
	bh=R7/z9C7qpx7IpjmeTzkpHTTwUmtvP03YWgReVTnc/oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9ki9g1iZd2fKMZu/SNx0xP47FVGH4dM64Nvb9u3kkIZ4ZaECBGItZFJE0OD3vqFc
	 kLT75lsM20kWZ1QfOXSHoMSp/UfxVBiloLPFWewMS7emZ5DcuBzNRJUNsju8gQ1zGL
	 4MbTu8L2XlqDo6ELdq34K3bGkWdG1HwIQ+24/s8CBMwntTsSH54RMRmv3zK+96TN74
	 Ida4hmcXT7iAlaI+EiwBIO/bvJn+Y5fKmtauovnGzK8QRF5ZSKDXVQTujPP1GDC1Aj
	 Y2OkNX/EKRJsXSKfYs94nUhNOUErSp8BpzOSQ/Efde7cOrusfRkAf54gmH9kOo/Ekt
	 58VcljSalnk4Q==
Date: Sat, 21 Feb 2026 11:56:05 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] fscrypt: pass a byte length to fscrypt_zeroout_range
Message-ID: <20260221195605.GF2536@quark>
References: <20260218061531.3318130-1-hch@lst.de>
 <20260218061531.3318130-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218061531.3318130-9-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77863-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 2444F16DBFE
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 07:14:46AM +0100, Christoph Hellwig wrote:
> Range lengths are usually expressed as bytes in the VFS, switch
> fscrypt_zeroout_range to this convention.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/crypto/bio.c | 6 +++---
>  fs/ext4/inode.c | 3 ++-
>  fs/f2fs/file.c  | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index e41e605cf7e6..cea931620c04 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -115,7 +115,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
>   * @inode: the file's inode
>   * @pos: the first file logical offset (in bytes) to zero out
>   * @pblk: the first filesystem physical block to zero out
> - * @len: number of blocks to zero out
> + * @len: bytes to zero out
>   *
>   * Zero out filesystem blocks in an encrypted regular file on-disk, i.e. write
>   * ciphertext blocks which decrypt to the all-zeroes block.  The blocks must be
> @@ -136,7 +136,7 @@ int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,

This should be accompanied by a change in the type of 'len' to u64 or
loff_t, and similarly in fscrypt_zeroout_range_inline_crypt().  It's
unclear that the callers always pass lengths <= U32_MAX bytes,
especially the one in f2fs.

Also, the comment for fscrypt_zeroout_range() should be updated to
mention that pos and len need to be multiples of the filesystem block
size, given that it will no longer be implied by the units.

- Eric

