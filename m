Return-Path: <linux-fsdevel+bounces-155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA677C665D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 09:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D693D282862
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C9DF6E;
	Thu, 12 Oct 2023 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvWFNVfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAFACA71;
	Thu, 12 Oct 2023 07:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95052C433C8;
	Thu, 12 Oct 2023 07:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697095667;
	bh=uFOVsO0iA7aERTg561QtZIyfEN81ZReHUhYxtMi3rEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvWFNVfFW7OtxSkeY822KLUGNK0/bFrW0/i73sSIrS7DPfp+ATEQGOEy+D0Hm9ngf
	 CFHDGH2okbPQT4cu1sstJ+7w8Nqvzh1lwraH7kdqkghfyGMxYSaeosg8c70+sU3E3Z
	 u/yfR5lpSao+952TLbTPLEEUu8YlyUOP8UV24hnj6RT/qm5SjMm2kmbU6g66UtXH5M
	 E44Ma8qReRsi7UZBhO62Ts/yEq/Ln0HlOj9+sFo1kG+uZBmuqdr2lKc6+5Ccuyfv7t
	 D/Sxr5EBT4kGs6NCT0OK9+zRW+JcObRaxJYbHPJ8flpg379R2VKtTWZHU3a7KNJhl2
	 tuhRlcyIe+tVA==
Date: Thu, 12 Oct 2023 00:27:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 07/28] fsverity: always use bitmap to track verified
 status
Message-ID: <20231012072746.GA2100@sol.localdomain>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-8-aalbersh@redhat.com>
 <20231011031543.GB1185@sol.localdomain>
 <q75t2etmyq2zjskkquikatp4yg7k2yoyt4oab4grhlg7yu4wyi@6eax4ysvavyk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q75t2etmyq2zjskkquikatp4yg7k2yoyt4oab4grhlg7yu4wyi@6eax4ysvavyk>

On Wed, Oct 11, 2023 at 03:03:55PM +0200, Andrey Albershteyn wrote:
> > How complicated would it be to keep supporting using the page bit when
> > merkle_tree_block_size == page_size and the filesystem supports it?  It's an
> > efficient solution, so it would be a shame to lose it.  Also it doesn't have the
> > max file size limit that the bitmap has.
> 
> Well, I think it's possible but my motivation was to step away from
> page manipulation as much as possible with intent to not affect other
> filesystems too much. I can probably add handling of this case to
> fsverity_read_merkle_tree_block() but fs/verity still will create
> bitmap and have a limit. The other way is basically revert changes
> done in patch 09, then, it probably will be quite a mix of page/block
> handling in fs/verity/verify.c

The page-based caching still has to be supported anyway, since that's what the
other filesystems that support fsverity use, and it seems you don't plan to
change that.  The question is where the "block verified" flags should be stored.
Currently there are two options: PG_checked and the separate bitmap.  I'm not
yet convinced that removing the support for the PG_checked method is a good
change.  PG_checked is a nice solution for the cases where it can be used; it
requires no extra memory, no locking, and has no max file size.  Also, this
change seems mostly orthogonal to what you're actually trying to accomplish.

> > > Also, this patch removes spinlock. The lock was used to reset bits
> > > in bitmap belonging to one page. This patch works only with one
> > > Merkle tree block and won't reset other blocks status.
> > 
> > The spinlock is needed when there are multiple Merkle tree blocks per page and
> > the filesystem is using the page-based caching.  So I don't think you can remove
> > it.  Can you elaborate on why you feel it can be removed?
> 
> With this patch is_hash_block_verified() doesn't reset bits for
> blocks belonging to the same page. Even if page is re-instantiated
> only one block is checked in this case. So, when other blocks are
> checked they are reset.
> 
> 	if (block_cached)
> 		return test_bit(hblock_idx, vi->hash_block_verified);

When part of the Merkle tree cache is evicted and re-instantiated, whether that
part is a "page" or something else, the verified status of all the blocks
contained in that part need to be invalidated so that they get re-verified.  The
existing code does that.  I don't see how your proposed code does that.

- Eric

