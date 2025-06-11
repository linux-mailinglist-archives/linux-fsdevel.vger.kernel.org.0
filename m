Return-Path: <linux-fsdevel+bounces-51295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04CCAD5342
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A476D3B36E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0394127602C;
	Wed, 11 Jun 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA5qGziG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C3273D9E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639784; cv=none; b=DsYzumrIyj6Cjoa0UH6MpQxiJeSOlOTQlmrrc2RtnuXvKN41TKhpiau/G3beUXidDvSqlvDNR1yhWIweCcO34ld2nUD5CaHkTvThmAM4H47OOjyLrqCBDJMtbD2wDbIIN/q95N1pVmYhUCAHYpoTE+b0Bev5WTgm2Awb/KEOncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639784; c=relaxed/simple;
	bh=WyLNBqgFQk38wTW1sEJu29x7u3LCQ2V814HcI2klEgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO2oItoupKdG65WNVMN2oFADzAETiOigP4vzCLR+3GpJbTvjM2XABciqfxq1OzawarpodP0rUuJYCW0ozIDBINpLM+adfDIAInM2pNV5VsRNZs7pLFALfSmil312k4eShEQzqrytUTuYA7oKJULMWyp83YUNvU0IPMi7Ue9mlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA5qGziG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB499C4CEEE;
	Wed, 11 Jun 2025 11:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639784;
	bh=WyLNBqgFQk38wTW1sEJu29x7u3LCQ2V814HcI2klEgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BA5qGziGtP7Dlz6wJlrhErfCsnJiST6vxQCkJLMvyYWkEJmOizDnYgCSvbGMh5A9h
	 jm7IyzmIpKuox76o4bXVTLPIyIS5Ybvz16MrOXqZE+k5Q1u4jwoXdxr1VypUwypROd
	 Qqg4DACYav5f0vs/7yFtEykhcF7nGF9bZhO1aMPPA5/v8zUUA8Fb7KlEISN4UY5Fkk
	 ybWSKLgKN4+htV7VDm42gwL8zSWJZBcBwsddjOWr8ET8m3AVXf+MKqZRLpnwQJJVoW
	 ZahnZ9rfx7mjZah2WnOSNr2imovsLGMjF9QiEMp0ZRvuFp2+vT1Ko4lZifM94k1RWD
	 wOUx74NxtK/GQ==
Date: Wed, 11 Jun 2025 13:03:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 16/26] make commit_tree() usable in same-namespace move
 case
Message-ID: <20250611-bohrinsel-burgen-dd721040fea2@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-16-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-16-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:38AM +0100, Al Viro wrote:
> Once attach_recursive_mnt() has created all copies of original subtree,
> it needs to put them in place(s).
> 
> Steps needed for those are slightly different:
> 	1) in 'move' case, original copy doesn't need any rbtree
> manipulations (everything's already in the same namespace where it will
> be), but it needs to be detached from the current location
> 	2) in 'attach' case, original may be in anon namespace; if it is,
> all those mounts need to removed from their current namespace before
> insertion into the target one
> 	3) additional copies have a couple of extra twists - in case
> of cross-userns propagation we need to lock everything other the root of
> subtree and in case when we end up inserting under an existing mount,
> that mount needs to be found (for original copy we have it explicitly
> passed by the caller).
> 
> Quite a bit of that can be unified; as the first step, make commit_tree()
> helper (inserting mounts into namespace, hashing the root of subtree
> and marking the namespace as updated) usable in all cases; (2) and (3)
> are already using it and for (1) we only need to make the insertion of
> mounts into namespace conditional.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

