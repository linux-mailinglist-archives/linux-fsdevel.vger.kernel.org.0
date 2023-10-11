Return-Path: <linux-fsdevel+bounces-27-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B532E7C4847
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 05:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A311C20EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2963A0;
	Wed, 11 Oct 2023 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLrRj6K/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF041354F7;
	Wed, 11 Oct 2023 03:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFB4C433C7;
	Wed, 11 Oct 2023 03:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696994145;
	bh=OVumWVhYu2Vxm/WDR3LSajdVVDZlhEjqAKCZQ8IVLSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLrRj6K/Hh0sj5lkG3XJTdl/a82CkGfsYUyuIE0eeWbHi8TjzjNqOhcmbuBH6PZg/
	 A1z6moEj83XL2cjoNCTgx4vLNGRabPn5mV58Q+bjPomXpnVwICoF7fjo8320tr6kxn
	 VJViwkXoLTtG/75wc9YQql+XOs2e4K01Ib+lOc5yEFPxA3dM7REltoJgRz7gB4BVxI
	 fFsjbCGAGsKFTVNdJzlWmNyc7o1qMgwwplRzB5Kawl3YyfdAW5es6zgHjKwbRQMf+f
	 rfaAbfhAsltzbFn6HjS+5hx6aWqUXAN9hVjoOMbGx3NhcQdt6j0PHixFALTnsRw1pA
	 iPtZv5Pfbbz6g==
Date: Tue, 10 Oct 2023 20:15:43 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 07/28] fsverity: always use bitmap to track verified
 status
Message-ID: <20231011031543.GB1185@sol.localdomain>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-8-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-8-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:01PM +0200, Andrey Albershteyn wrote:
> The bitmap is used to track verified status of the Merkle tree
> blocks which are smaller than a PAGE. Blocks which fits exactly in a
> page - use PageChecked() for tracking "verified" status.
> 
> This patch switches to always use bitmap to track verified status.
> This is needed to move fs-verity away from page management and work
> only with Merkle tree blocks.

How complicated would it be to keep supporting using the page bit when
merkle_tree_block_size == page_size and the filesystem supports it?  It's an
efficient solution, so it would be a shame to lose it.  Also it doesn't have the
max file size limit that the bitmap has.

> Also, this patch removes spinlock. The lock was used to reset bits
> in bitmap belonging to one page. This patch works only with one
> Merkle tree block and won't reset other blocks status.

The spinlock is needed when there are multiple Merkle tree blocks per page and
the filesystem is using the page-based caching.  So I don't think you can remove
it.  Can you elaborate on why you feel it can be removed?

>  /*
> - * Returns true if the hash block with index @hblock_idx in the tree, located in
> - * @hpage, has already been verified.
> + * Returns true if the hash block with index @hblock_idx in the tree has
> + * already been verified.
>   */
> -static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
> -				   unsigned long hblock_idx)
> +static bool is_hash_block_verified(struct fsverity_info *vi,
> +				   unsigned long hblock_idx,
> +				   bool block_cached)
>  {
> -	bool verified;
> -	unsigned int blocks_per_page;
> -	unsigned int i;
> -
> -	/*
> -	 * When the Merkle tree block size and page size are the same, then the
> -	 * ->hash_block_verified bitmap isn't allocated, and we use PG_checked
> -	 * to directly indicate whether the page's block has been verified.
> -	 *
> -	 * Using PG_checked also guarantees that we re-verify hash pages that
> -	 * get evicted and re-instantiated from the backing storage, as new
> -	 * pages always start out with PG_checked cleared.
> -	 */
> -	if (!vi->hash_block_verified)
> -		return PageChecked(hpage);
> -
> -	/*
> -	 * When the Merkle tree block size and page size differ, we use a bitmap
> -	 * to indicate whether each hash block has been verified.
> -	 *
> -	 * However, we still need to ensure that hash pages that get evicted and
> -	 * re-instantiated from the backing storage are re-verified.  To do
> -	 * this, we use PG_checked again, but now it doesn't really mean
> -	 * "checked".  Instead, now it just serves as an indicator for whether
> -	 * the hash page is newly instantiated or not.
> -	 *
> -	 * The first thread that sees PG_checked=0 must clear the corresponding
> -	 * bitmap bits, then set PG_checked=1.  This requires a spinlock.  To
> -	 * avoid having to take this spinlock in the common case of
> -	 * PG_checked=1, we start with an opportunistic lockless read.
> -	 */

Note that the above comment explains why the spinlock is needed.

> -	if (PageChecked(hpage)) {
> -		/*
> -		 * A read memory barrier is needed here to give ACQUIRE
> -		 * semantics to the above PageChecked() test.
> -		 */
> -		smp_rmb();
> +	if (block_cached)
>  		return test_bit(hblock_idx, vi->hash_block_verified);

It's not clear what block_cached is supposed to mean here.

- Eric

