Return-Path: <linux-fsdevel+bounces-69478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23928C7D556
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 19:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E538E4E1B9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF82267AF2;
	Sat, 22 Nov 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWp7qBzg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCDF513;
	Sat, 22 Nov 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763835440; cv=none; b=nXQKbHCV+iWFyvplalAscQpKkD3Euwp+9wNjmWddqMSRokuSl6zWWDuq7Y5YxSjrEub/TEB/H9teXr/D9f92e/+5exCL8guN1oE4bPQXNHVOByIFLyW+CwmQ5lq8lcQpzZZZSx8jSUCqIeRZSXZXxDvMLsbD3LQbjGrKUaziKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763835440; c=relaxed/simple;
	bh=we92XnUPL2GqTAE+Ck+cg8BMRawK5MC/LOnXeHskfuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ9nJNpL4I/7xpF2dKphhD2aDd1JU3WnIeMfBqBJZNjGITdsLWCihMgPo5YhkNYvzzwOPpWG0pqa378k3dsVxzq/y40+g1dgp3hPcdMqdAfp9GhmG08aq4l8hiIgkELb+nzdwVjRMKunbsOt3eIxFH2Xki8NKpyxY1aGWZXfOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWp7qBzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B7EC4CEF5;
	Sat, 22 Nov 2025 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763835439;
	bh=we92XnUPL2GqTAE+Ck+cg8BMRawK5MC/LOnXeHskfuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWp7qBzgegMBBvpNUpmYHt1dSh1dwb7l1gVTIWRYlM8OTWUUWdH975ieJ/TI6cuVG
	 OX7gdRw1zpMWaRAmRv0Pz5kTcOJ5IekC3ZeBx9szPIC3Dql/L0kmwVZ5VGp+oau6xF
	 K+hU9omr4xma5Czu40WtwkdKJGRRqNJhRTmnradNl8hyDB2KWgpOd/2rjf7bk2qc+q
	 WWaus1hdoFJCoreampp5V9lRtGeRWqONH5+HwEkBZ+Hp9kkUdcQG/mGDp0/fg6NZL7
	 cbRX2Xcy/CEsx0PZZhycSzUq9SYMtwWCgvZRmqdsvJ9TD/UyPFWLyRIO1QANBTu2TY
	 e1RjCaTvPOX5A==
Date: Sat, 22 Nov 2025 10:17:17 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/11] fscrypt: pass a byte offset to
 fscrypt_mergeable_bio
Message-ID: <20251122181717.GA1626@quark>
References: <20251118062159.2358085-1-hch@lst.de>
 <20251118062159.2358085-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118062159.2358085-5-hch@lst.de>

On Tue, Nov 18, 2025 at 07:21:47AM +0100, Christoph Hellwig wrote:
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index 1773dd7ea7cf..aba830e0827d 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -361,7 +361,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
>   * fscrypt_mergeable_bio() - test whether data can be added to a bio
>   * @bio: the bio being built up
>   * @inode: the inode for the next part of the I/O
> - * @next_lblk: the next file logical block number in the I/O
> + * @pos: the next file logical offset (in bytes) in the I/O

In comments, maybe call it a "file position" instead of "file logical
offset" to match the variable name?

- Eric

