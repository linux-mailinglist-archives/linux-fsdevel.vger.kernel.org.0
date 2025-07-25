Return-Path: <linux-fsdevel+bounces-56008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D6B11746
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 06:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180C61C868C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B21E25EB;
	Fri, 25 Jul 2025 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr9rHPTY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D04A08;
	Fri, 25 Jul 2025 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753416118; cv=none; b=JOYVkn2+G4LQsU/oweAKRVF97En4aHxkbZ4UDJ4F7XLtGDFgat1faJ7S+B7wP8JyJfZw5D0lsp8Lw1oaKv3Vs7zFs3i2kgkZIrOy89chlSIDpEir5VDdV8juwobz5ibfCI1ns3OdypdEAUXUz784Sx3qOY2lLPjxbE6aBfTJerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753416118; c=relaxed/simple;
	bh=uYISutCeuX5jCbhhipb01l1Xr3JBDeeqD6bjQwW3+e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di+OwaN1d2yCN/Kwdu7nYOHe4HKqNtW95Yzv6uH0r/NfJwelxd8tUDItrbLTwc+P7GqVa3IYtY20MIGQgYQSBvvgm3Erfa7A7jAzo7rxnQx8ToTSYepqCYCS7EGtQwJ+NnxpZvXsLS8j0VKAtnrzgar26fULXYPT8g5i3YeISOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr9rHPTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0145C4CEE7;
	Fri, 25 Jul 2025 04:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753416118;
	bh=uYISutCeuX5jCbhhipb01l1Xr3JBDeeqD6bjQwW3+e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fr9rHPTYpbrw8K5Sk2DGeI/qrt2ACFeZVa0JnvIp0avuxOdlw4y5anOPK71ShxNJN
	 8taUSdk+MDKXLTWv2yv9YPUhIeY2LAUKndn5gb+lzEu9LMLcAWORORRUXB4t2q1yur
	 0gSRjFZF4LCjwIQmbHKS1ksLrMayengtVmLAmkAVlljMEPmLlP+bg/dWHBo8bnOPF7
	 aokmoSo26jODPmXUNJQxAa3yClLyeAJA4MwRJeF95Lw2nJzXhs47uaJccoFoGSunMp
	 MEERzr3tyK/q1aYsB5zsQHzj3qBzSbiceuFGGUYyLQX7520a0zZtCWcYz6zIuTdkU4
	 WNinz0nRqQkWw==
Date: Thu, 24 Jul 2025 21:01:08 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v4 02/15] fs/crypto: use accessors
Message-ID: <20250725040108.GA37178@sol>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
 <20250723-work-inode-fscrypt-v4-2-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-work-inode-fscrypt-v4-2-c8e11488a0e6@kernel.org>

On Wed, Jul 23, 2025 at 12:57:40PM +0200, Christian Brauner wrote:
> They can be removed once all filesystems have been converted to make
> room for fscrypt info in their own inodes.

Also note that the accessors still exist at the end of the series.  I'm
not sure what the above sentence is trying to say.

> @@ -396,10 +396,10 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
>  	 * uses the same pointer.  I.e., there's currently no need to support
>  	 * merging requests where the keys are the same but the pointers differ.
>  	 */
> -	if (bc->bc_key != inode->i_crypt_info->ci_enc_key.blk_key)
> +	if (bc->bc_key != fscrypt_get_inode_info_raw(inode)->ci_enc_key.blk_key)
>  		return false;
>  
> -	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
> +	fscrypt_generate_dun(fscrypt_get_inode_info_raw(inode), next_lblk, next_dun);
>  	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
>  }

This function could use a 'ci' local variable now.  It's not clear that
the second fscrypt_get_inode_info_raw() will get optimized out.

- Eric

