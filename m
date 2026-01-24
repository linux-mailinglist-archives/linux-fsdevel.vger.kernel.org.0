Return-Path: <linux-fsdevel+bounces-75369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCa7AJY3dWkqCQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 22:20:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5267F060
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 22:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4228C30131C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C6C27E054;
	Sat, 24 Jan 2026 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx3PHjVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB610F1;
	Sat, 24 Jan 2026 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769289604; cv=none; b=Vmml/LxuUCHmUS7mQQLiCJMiwKevvSc8EEtn4SGFa+cg/v0VVkWMsTSCn7LURpz/3LYm8l3FB9eUkhw1B0F6UGLIE7vPZ9OYmWd+c8UwB3+e1RgBPi17H2DhUgbs8OIEL5bDTHTC2ke43wYGDxsUHSgPDib9ok2DHiLy8WGXOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769289604; c=relaxed/simple;
	bh=oI+uA3O35prux956Vzu7Z1UUlwDa0yJcLaD0R2S8IsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBYDBN1cAHrUsw9qR1LS9tfdG32XF2WfaQUQV5TUe1EUlO3mKd4xhmlfKoGi5mxSVPuBAzW+L9X+zqEyjVerZvOGwhgQOfzy3Rbq+SGK4xkP4P8CBBJcDyMhsxxYSvI2MfVg9XrKCaNHn0FAvYHnBaxlDLlyo4rBMSJr5adXnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx3PHjVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE05BC116D0;
	Sat, 24 Jan 2026 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769289604;
	bh=oI+uA3O35prux956Vzu7Z1UUlwDa0yJcLaD0R2S8IsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tx3PHjVFa71TMA8P2jVrrQzZkrnzrpZqil3kd3DaCVTplbq9iK6DlJ8qsql1thPAv
	 UNjuW1nfiRVWAbZf+LRjOeoUGh4XP+zmVrTNSc8g7amTOCb4vyFpcPWGiqIIenq2dB
	 vft8MwRjbFKObQYd0ghcaHYdAZbM58IwoBylA9FvOa/jgLOmx9LjHJvNd36n4Pcm2R
	 L8QHWrN4AT/1gM+82FP1MC53CTF2OW1OSsDNz1AatHjk7o4UTRUS+VrtUNfKt2GK58
	 xob/cAfD4zqAwb+w2F7IClIn40cu37XDMKbfm3FWH+cSbAYgtbkiZuLzAG63322rOw
	 Mk5sbTrl4k/7w==
Date: Sat, 24 Jan 2026 13:19:56 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 06/11] fsverity: push out fsverity_info lookup
Message-ID: <20260124211956.GF2762@quark>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-7-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75369-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email]
X-Rspamd-Queue-Id: 9D5267F060
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:02AM +0100, Christoph Hellwig wrote:
> Pass a struct fsverity_info to the verification and readahead helpers,
> and push the lookup into the callers.  Right now this is a very
> dumb almost mechanic move that open codes a lot of fsverity_info_addr()
> calls int the file systems.  The subsequent patches will clean this up.
> 
> This prepares for reducing the number of fsverity_info lookups, which
> will allow to amortize them better when using a more expensive lookup
> method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/extent_io.c     |  4 +++-
>  fs/buffer.c              |  4 +++-
>  fs/ext4/readpage.c       | 11 ++++++++---
>  fs/f2fs/compress.c       |  4 +++-
>  fs/f2fs/data.c           | 15 +++++++++++----
>  fs/verity/verify.c       | 26 ++++++++++++++------------
>  include/linux/fsverity.h | 24 +++++++++++++++---------
>  7 files changed, 57 insertions(+), 31 deletions(-)

This patch introduces another bisection hazard by adding calls to
fsverity_info_addr() when CONFIG_FS_VERITY=n.  fsverity_info_addr() has
a definition only when CONFIG_FS_VERITY=y.

Maybe temporarily add a CONFIG_FS_VERITY=n stub for fsverity_info_addr()
that returns NULL, and also ensure that it's dereferenced only when it's
known that fsverity verification is needed.  Most of the call sites look
okay, but the second one in ext4_mpage_readpages() needs to be fixed.

> @@ -430,6 +431,7 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
>  #ifdef CONFIG_BLOCK
>  /**
>   * fsverity_verify_bio() - verify a 'read' bio that has just completed
> + * @vi: fsverity_info for the inode to be read
>   * @bio: the bio to verify
>   *
>   * Verify the bio's data against the file's Merkle tree.  All bio data segments
> @@ -442,13 +444,13 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
>   * filesystems) must instead call fsverity_verify_page() directly on each page.
>   * All filesystems must also call fsverity_verify_page() on holes.
>   */
> -void fsverity_verify_bio(struct bio *bio)
> +void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio)
>  {
>  	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
>  	struct fsverity_verification_context ctx;
>  	struct folio_iter fi;
>  
> -	fsverity_init_verification_context(&ctx, inode);
> +	fsverity_init_verification_context(&ctx, inode, vi);

Note that fsverity_info has a back-pointer to the inode.  So,
fsverity_init_verification_context() could just take the vi and set
ctx->inode to vi->inode.

Then it wouldn't be necessary to get the inode from
bio_first_folio_all(bio)->mapping->host (in fsverity_verify_bio()) or
folio->mapping->host (in fsverity_verify_blocks()).
Similarly in fsverity_readahead() too.

(It might make sense to handle this part as a separate patch.)

- Eric

