Return-Path: <linux-fsdevel+bounces-59618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D9FB3B484
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BBB463197
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D19279DAA;
	Fri, 29 Aug 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axHoGPko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A227815D;
	Fri, 29 Aug 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453123; cv=none; b=mNKQuGHLp5x8bavaFWcwIaK6tJB0cCYfNAvacR+5eVcgY+qBY4pfpcTKaT63DEOMviusVL/H1ygDCcTBNC0nXyVMxCwDkClaNZyEJSIHHTj1TGj6IuRTiv5HVfbGMiLOFcleeRkprtyZqXYNTt1jjOP1mhmh70SPSL6SD+PXkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453123; c=relaxed/simple;
	bh=Uei2tSjIXQ9PDVNco+qbvaNxdNtpvYhd0d6ZNpGnp78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo5wbmeF8RVJpyv65B/+NgfBu3uMk8NuOPuKrCOKu/avzFu9B9bBiL/YooG6yZmSoVPeLvkr0bhUWtnJVv3/hBBNWLTkLLNN7HmVJRTXIC58S7tU6h7KMDfNfDEIc5YzWKwujMjgE2wF/lyQfYeR9UtWxnoaibbyfyQXJmeR0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axHoGPko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9995C4CEF0;
	Fri, 29 Aug 2025 07:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756453123;
	bh=Uei2tSjIXQ9PDVNco+qbvaNxdNtpvYhd0d6ZNpGnp78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axHoGPkohSuq1woVfcfhWJQMJWbhQ61oRlr1f7RE0fzQ0DMjZa7IIPE3AYzPz6N5v
	 MfswV40PI8Od1I83M3QV5PiSwepRvV0UJJEkiq3xyyLS1UYDGbjjqXESWqfGeYV3go
	 HPsoWBtPqABotQqflg1XOjE7iAkf7hp4pNgXrlcQngQi4SMW3GkoHfME6tLZrVNc2+
	 zDDB7WDFTXvgnFZo2tK8usuKSCGQQB3b7u30saz91m64ks0hlaDh1mXt4JSVSrhzrx
	 zRmDaXuYeJaQo8o9ZqqT2M8vF+d5T/A8lS/wEsifGyXvTyn7OTZLaFfo5JJ3FT2BtT
	 Un8EsxBTxzBKA==
Date: Fri, 29 Aug 2025 09:38:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, kernel-team@fb.com, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 30/54] fs: change evict_dentries_for_decrypted_inodes
 to use refcount
Message-ID: <20250829-chancenreich-urwald-00b8a5df1966@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <283eebefe938d9a1dd4a3a162820058f3550505c.1756222465.git.josef@toxicpanda.com>
 <20250828-risse-negieren-f9a3d1526782@brauner>
 <20250828222610.GB2077538@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828222610.GB2077538@google.com>

On Thu, Aug 28, 2025 at 10:26:10PM +0000, Eric Biggers wrote:
> On Thu, Aug 28, 2025 at 02:25:21PM +0200, Christian Brauner wrote:
> > On Tue, Aug 26, 2025 at 11:39:30AM -0400, Josef Bacik wrote:
> > > Instead of checking for I_WILL_FREE|I_FREEING simply use the refcount to
> > > make sure we have a live inode.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > I have no idea how the lifetime of such decrypted inodes are managed.
> > I suppose they don't carry a separate reference but are still somehow
> > safe to be accessed based on the mk_decrypted_inodes list. In any case
> > something must hold an i_obj_count if we want to use igrab() since I
> > don't see any relevant rcu protection here.
> > 
> 
> inodes are placed on mk_decrypted_inodes by the filesystem while it's
> holding an i_count reference, and they're removed from the list by
> ->evict_inode shortly after i_count reaches zero.  So the corresponding
> i_obj_count reference is just the one associated with i_count.
> 
> This patch looks correct: we do igrab() while holding
> mk_decrypted_inodes_lock.  So either i_count is nonzero and we get a
> temporary i_count reference, or it's zero and we skip the inode since it
> cannot have dentries (and ->evict_inode is coming very soon as well).

Thanks for the explanation, Eric! That was exactly what I was looking for.

