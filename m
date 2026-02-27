Return-Path: <linux-fsdevel+bounces-78794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ9sML4JomngyQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:16:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 386851BE1F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E391301DC2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669B47A0A6;
	Fri, 27 Feb 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9Y/HrUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C23451CC;
	Fri, 27 Feb 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227003; cv=none; b=RgiCHrHzQDNETxQSFVutaAneWqOJt60S3dSOX3GLTUQHEgO3Gc8GXWN9s5gmgGASkPtsKS/tFcjhIYQEmaVzBSvEpvVAf/az9do/eSWJ08AV9073Obxw5mVjLSTrCXUk9ucboYLKTFo8NYnrJ9mzcLSPYuoCFFEhHQcKup/eWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227003; c=relaxed/simple;
	bh=IYVWg1WHxAiTLvaxqvVywcr6KglLqSKrG5o1wA/srJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6csCnDIqn6tyzrgyTCNU9mHUK4jRNB1Y1RPeNb4CPlA78kNJRJ63vvzJPlIKDQ1Hnc6DnenrdIuRTMWd0S8q4uYP47M8CIXZ/SmDI/bnkccdXIDmeJ9zRr2XuPBakyapkxjOQbgXOCOtIagWMgSE4t7s41QrPRTITs9soTvMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9Y/HrUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4098C116C6;
	Fri, 27 Feb 2026 21:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772227002;
	bh=IYVWg1WHxAiTLvaxqvVywcr6KglLqSKrG5o1wA/srJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9Y/HrUWuZUg8+lNeTyzL6gTo253Vmxl1ioHnAfR/Aw49uUiAtNG2CfzgiUzkQPnv
	 i5wHzU2ZHD3Itr0lRNfzL2rLy5lO4IAwdYXDiLa1avnHMcu5omFm/imvcMJTEbprOA
	 65ZHdkbBbAdcqTPhW5d0hEmXXfLDwogzOWPs1j1DOIbIfzXmKLD1iMbzOj6DPgQWRj
	 rokEjrjD8NyzHqZEf5OuPk7Q304WhRVSDKrP/ARW4BrDkqJA1RMQvdyQARjpohDELu
	 zp7/mVlTgNARTjjmcQHQqvohZsVLz6Jq8iLNo4HPMcWhjMjRDViVvw8N3gWX2YYMam
	 Us/UIEQtE2HHA==
Date: Fri, 27 Feb 2026 13:16:39 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/14] ext4: initialize the write hint in
 io_submit_init_bio
Message-ID: <20260227211639.GA2659@quark>
References: <20260226144954.142278-1-hch@lst.de>
 <20260226144954.142278-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226144954.142278-2-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78794-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 386851BE1F7
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:49:21AM -0800, Christoph Hellwig wrote:
> Make io_submit_init_bio complete by also initializing the write hint.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ext4/page-io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index a8c95eee91b7..a3644d6cb65f 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -416,6 +416,7 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
>  }
>  
>  static void io_submit_init_bio(struct ext4_io_submit *io,
> +			       struct inode *inode,
>  			       struct buffer_head *bh)
>  {
>  	struct bio *bio;
> @@ -430,6 +431,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
>  	bio->bi_end_io = ext4_end_bio;
>  	bio->bi_private = ext4_get_io_end(io->io_end);
>  	io->io_bio = bio;
> +	io->io_bio->bi_write_hint = inode->i_write_hint;
>  	io->io_next_block = bh->b_blocknr;
>  	wbc_init_bio(io->io_wbc, bio);
>  }

Maybe make this consistent with the other initializations by moving it
up a line and doing:

        bio->bi_write_hint = inode->i_write_hint;

- Eric

