Return-Path: <linux-fsdevel+bounces-59528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEEB3AD7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 00:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463C7987F3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315926F2A2;
	Thu, 28 Aug 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE6yBDY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD551C84A0;
	Thu, 28 Aug 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419973; cv=none; b=FoSfabHl780y73dtUSfES5Vw32W14yzTPbDgwrOADur7e9Ry0I7COO2GCOMyvInE/vqwM9u7FdzRdA4ZhKF97ghfA7FayqDrYBoXb4FUNfE6fpTpdyi0cI94AMO64vRWUxKtzeT6929B6vC7sNSykKPKK5E0OLrvHKwdUUhW/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419973; c=relaxed/simple;
	bh=BgBomaxNx1rB9WxjMJkmquCqgsqBO71bzcMttOgeGeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyMvKJQjUGq94cqH8841pzJqYYV21HdJg9oNoynP9RQQHmvAz9CVFj3gioZEL+IV6GG1LU/sW3DLdrzV2yS4sn0R4Why2b6ahTASMXSNiMFC5R7PoqyIGvi7uJok+eIOxS1/N9UCNP5Ch21bU9GMwQjrkozXHkCiDoWWw/XMe0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE6yBDY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D39C4CEEB;
	Thu, 28 Aug 2025 22:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756419973;
	bh=BgBomaxNx1rB9WxjMJkmquCqgsqBO71bzcMttOgeGeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IE6yBDY+WWUBHT6+Vh1+pgY8NShVrehwmrPgVDWHqxQQXZKARAz89+HPdIlyD5F3k
	 zDjkTPyIH/7eVIBOfORrDv1dzAksOHIqv0tRxcppDDM2JLaTXTsuk7oWvMZgAx70TN
	 Rq2LUgTrXj67vDBTX8Oo5shR+9+BlB+a6bJ9NLZuojh6vbBZwLPBfR/uhoTwixsNJ4
	 nuroyumc3a2w0JY8s7rLLGFXaaCDVBRJhJ5Pq/sCqnlYrVKUfvJkZ4RULmhf2aBjjo
	 1ENWyGVCoJyO4wb+an5DEG6DwCU21uDRpvkOr5R+TpXtnYyHicRbHT21rCABAASj/V
	 nyz1g3cC1c//Q==
Date: Thu, 28 Aug 2025 22:26:10 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 30/54] fs: change evict_dentries_for_decrypted_inodes
 to use refcount
Message-ID: <20250828222610.GB2077538@google.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <283eebefe938d9a1dd4a3a162820058f3550505c.1756222465.git.josef@toxicpanda.com>
 <20250828-risse-negieren-f9a3d1526782@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-risse-negieren-f9a3d1526782@brauner>

On Thu, Aug 28, 2025 at 02:25:21PM +0200, Christian Brauner wrote:
> On Tue, Aug 26, 2025 at 11:39:30AM -0400, Josef Bacik wrote:
> > Instead of checking for I_WILL_FREE|I_FREEING simply use the refcount to
> > make sure we have a live inode.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> I have no idea how the lifetime of such decrypted inodes are managed.
> I suppose they don't carry a separate reference but are still somehow
> safe to be accessed based on the mk_decrypted_inodes list. In any case
> something must hold an i_obj_count if we want to use igrab() since I
> don't see any relevant rcu protection here.
> 

inodes are placed on mk_decrypted_inodes by the filesystem while it's
holding an i_count reference, and they're removed from the list by
->evict_inode shortly after i_count reaches zero.  So the corresponding
i_obj_count reference is just the one associated with i_count.

This patch looks correct: we do igrab() while holding
mk_decrypted_inodes_lock.  So either i_count is nonzero and we get a
temporary i_count reference, or it's zero and we skip the inode since it
cannot have dentries (and ->evict_inode is coming very soon as well).

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

