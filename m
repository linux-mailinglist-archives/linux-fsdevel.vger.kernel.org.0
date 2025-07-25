Return-Path: <linux-fsdevel+bounces-55991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D7FB11547
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B9D1708C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD27140E5F;
	Fri, 25 Jul 2025 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEw5Bpbv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1110A39FD9;
	Fri, 25 Jul 2025 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403600; cv=none; b=DHQubVc6eSNxWJpiGBCMoMYf2yjwRgroDWNFSHkOBsKNIn32cJPuvpts5WhPDfP+93Nzewd/P7zyOc0z9plSdvbPeVzsAbrAlJee//DtHkUrA6TPlwjjRrCuhzPTpCe8n2QhiVK5wT2WkEZE9HF8uJL5iWfp5lGAkb/piORFW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403600; c=relaxed/simple;
	bh=0n6wOytkyHIbd0cN9E/m8bHAp+OZobRBL+nqNrzqudQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDnBrg+hMgfsrIeexzPV7hZbOlcwMx3ABF40+TZeSZzr0aF1YaFs7K6hXYxN+iUjhyleOMBKnVXCU1lRnq5+jHVKJw8YRrDlhxyLg0JpEn6a2MNCFIPTfv3lEoB0+KVetgBedUlXFlOy3gDJVty0GifQGPe8E77gml6husqr6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEw5Bpbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458F1C4CEED;
	Fri, 25 Jul 2025 00:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753403599;
	bh=0n6wOytkyHIbd0cN9E/m8bHAp+OZobRBL+nqNrzqudQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEw5BpbvqGqzMhPeYdgHpmLQSHqVLIAWM/PNKUx8ZW+baXX7mxiFpF4GMTldpGpNL
	 NNEeiSiTzuGn/kz8ACNAAQhLClruMZPUC8utCyDzOV0DArtnFiEfKMEeFJxrkgGZrW
	 lsovjUwxtP7JIXXyvTiS5sNxPaWrCqbh3rnM+AzF/Kl6etfB/i2B0WWQmw/hE4FuTB
	 l5RUDrsXheS9vuYCEd8R3otFSK7eRqSErz3wM+yDeJDzDm/H/DbtvAuR60onih4uHP
	 SGcCik2ob+RX/RADy00pEKhE2yl35w2h7gFyKmpVGPxMqPreRj7+nl/08yzJ1BmEVq
	 DZTPxSEzAB3vg==
Date: Thu, 24 Jul 2025 17:32:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v4 03/15] ext4: move fscrypt to filesystem inode
Message-ID: <20250725003229.GB25163@sol>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
 <20250723-work-inode-fscrypt-v4-3-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-work-inode-fscrypt-v4-3-c8e11488a0e6@kernel.org>

On Wed, Jul 23, 2025 at 12:57:41PM +0200, Christian Brauner wrote:
> ext4: move fscrypt to filesystem inode

ext4: move fscrypt_inode_info pointer to ext4_inode_info

Similarly in other patches.  Calling the pointer the "fscrypt" (or the
"fsverity") is kind of an abuse of terminology.

>  const struct fscrypt_operations ext4_cryptops = {
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.inode_info_offs	= offsetof(struct ext4_inode_info, i_crypt_info) -
> +				  offsetof(struct ext4_inode_info, vfs_inode),
> +#endif
>  	.needs_bounce_pages	= 1,
>  	.has_32bit_inodes	= 1,
>  	.supports_subblock_data_units = 1,

No need for #ifdef CONFIG_FS_ENCRYPTION in this file, since it is
compiled only when CONFIG_FS_ENCRYPTION=y.  Similarly in other patches.

- Eric

