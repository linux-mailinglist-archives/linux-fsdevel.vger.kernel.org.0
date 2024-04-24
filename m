Return-Path: <linux-fsdevel+bounces-17654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FFD8B1148
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EF71F2837C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A9D16D4E0;
	Wed, 24 Apr 2024 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8aBSMFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6F143894;
	Wed, 24 Apr 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980344; cv=none; b=C81i2pCLnH9wvjAAunbEDUZ8YtZR9j1bueu/L78sM70BK9IUEvmoPk4hLKpCdi9FoxgeUCmGYHSIZxIno+8W4VdKbJaBh27I4AWF3NWOHJAB7ZJJuLfAnjlKuO2Dzp5sAxMl7awH/weqyvkxO0VB9O1QKOKX3984SNalVukm+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980344; c=relaxed/simple;
	bh=OtOSn+BDxFLY6To7R3bqmK5m6GILLWg1o9flDCBIyAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmTPQm+ThaQXOAyYizXxWxXhlRfeHVxmfsii3MElVn+GXS25mG4+gVL8GBjZnYvJ+gy6WYy05eDHcu88CHQUzoJqy0JwZZnNS+0NoddbkZFgbTW9hRvz/Hxu7nc2qwbKOFAT1koviaJPI83V90sClBAPlO5UUrXMEsbVuvU+UGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8aBSMFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE38C113CD;
	Wed, 24 Apr 2024 17:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713980344;
	bh=OtOSn+BDxFLY6To7R3bqmK5m6GILLWg1o9flDCBIyAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8aBSMFXPkC07GyGURwSL3rkeVLd/Ncom8w5TIgu0XWA5xeoW36/75X6VOyukI0NS
	 CzdXUP/Yy66DGdRNe6usSoQX50kVnksk2v9Q/LwcQsICRs5WT9L2Ou6k+dvvMwfSfz
	 NnYNXUKE4LP/zN1Du1kP2eeQsu1u6VSo0ymkKaOuixJOjyvhEcupE5wL5iH+Uz23vh
	 AiX+59UeJ3ga54pwrFaUHWjgylT/f04uhEzySia6sdZTOBbELFQZ5UR/w4ricugDPf
	 yW11LGCxhOVF6o0HI95fwsmQUhluWQqatCu3gVLVZKAAfFfoF3lcqulhEcDAbo34Wi
	 Nmn4gQlbkDH9A==
Date: Wed, 24 Apr 2024 10:39:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 14/29] xfs: create a per-mount shrinker for verity inodes
 merkle tree blocks
Message-ID: <20240424173903.GI360919@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868793.1988170.8461136895877903082.stgit@frogsfrogsfrogs>
 <20240405031646.GK1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405031646.GK1958@quark.localdomain>

On Thu, Apr 04, 2024 at 11:16:46PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:39:43PM -0700, Darrick J. Wong wrote:
> > +/* Count the merkle tree blocks that we might be able to reclaim. */
> > +static unsigned long
> > +xfs_fsverity_shrinker_count(
> > +	struct shrinker		*shrink,
> > +	struct shrink_control	*sc)
> > +{
> > +	struct xfs_mount	*mp = shrink->private_data;
> > +	s64			count;
> > +
> > +	if (!xfs_has_verity(mp))
> > +		return SHRINK_EMPTY;
> > +
> > +	count = percpu_counter_sum_positive(&mp->m_verity_blocks);
> > +
> > +	trace_xfs_fsverity_shrinker_count(mp, count, _RET_IP_);
> > +	return min_t(s64, ULONG_MAX, count);
> 
> On 64-bit systems this always returns ULONG_MAX.

Oops, I think I meant u64 there.  It's confusing to me that
percpu_counter_sum_positive returns a signed type. :(

--D

> - Eric
> 

