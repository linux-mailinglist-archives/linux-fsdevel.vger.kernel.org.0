Return-Path: <linux-fsdevel+bounces-11625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E485583E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 01:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3034CB22814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7305818;
	Thu, 15 Feb 2024 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEvdwyv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500AB389;
	Thu, 15 Feb 2024 00:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707956194; cv=none; b=Cx52DQalSS/w91UeZ/DOi8HpS8qlnTwaRvfRwopvdB0fFwoltNIdouWGorNXv3uB1qEEEIEZRVHd9Snjsi/KWV0cx8WWxJZCQkjjiTOahaGhEmvfFFlLlLe4enl8GjcQi5WFpc64ZOR6E1yKSIFTeUbZJ6YnoFSLykAdEPwQkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707956194; c=relaxed/simple;
	bh=ylFK6Bpi7O0s6j/9+mo/NrShh6U5P03/xrJn/rG4PpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGee5vCyTlFk/kkm3jR1JE+k8hED3L2gRUAPef+OB0z40J/46gYWlok8arAlGSksd7aSajUL/I7rNOwoDZ8rXpzd9KZYLE4/Dvdc1mTTOa0QI7IUqYEouKnfow2c82aapcjCqLjf0SbK2M0P0+8Q2DXlj6GFrumxMt1rjSq1xKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEvdwyv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCF9C433F1;
	Thu, 15 Feb 2024 00:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707956193;
	bh=ylFK6Bpi7O0s6j/9+mo/NrShh6U5P03/xrJn/rG4PpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEvdwyv92kXe4udUPiYfbfA9b6N6wY5f05UN/tXpwXHit2VxdlHZZIQ4lvbl7JCb6
	 fGYXD6oQSJ9SpdC361S/r4aUdmN4cyBhjtlCshylY1BOlBXnmc+mg7N+1s0hBW3kTz
	 pIt0vbs66fOB1cWPiOnO1k/uVsWavea+HZjzPACrazcYPZSV+EvqjVs309elxkHM2A
	 Z2qgQmP6d1NRO6s+/qrBmK+BA6yW/WOrypcYy7gygv260aFM2OVif9hW82XZub3Uhc
	 DXBqhfAWjEU4KDEIHfzixirflHkeiWRiORgDXBCdku4/cEfJ/9n9YdZPUNTe4MlRSh
	 G2KeHLq9+gT8w==
Date: Wed, 14 Feb 2024 16:16:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v6 04/10] fscrypt: Drop d_revalidate once the key is added
Message-ID: <20240215001631.GI1638@sol.localdomain>
References: <20240213021321.1804-1-krisman@suse.de>
 <20240213021321.1804-5-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213021321.1804-5-krisman@suse.de>

On Mon, Feb 12, 2024 at 09:13:15PM -0500, Gabriel Krisman Bertazi wrote:
> From fscrypt perspective, once the key is available, the dentry will
> remain valid until evicted for other reasons, since keyed dentries don't
> require revalidation and, if the key is removed, the dentry is
> forcefully evicted.  Therefore, we don't need to keep revalidating them
> repeatedly.
> 
> Obviously, we can only do this if fscrypt is the only thing requiring
> revalidation for a dentry.  For this reason, we only disable
> d_revalidate if the .d_revalidate hook is fscrypt_d_revalidate itself.
> 
> It is safe to do it here because when moving the dentry to the
> plain-text version, we are holding the d_lock.  We might race with a
> concurrent RCU lookup but this is harmless because, at worst, we will
> get an extra d_revalidate on the keyed dentry, which is will find the
> dentry is valid.
> 
> Finally, now that we do more than just clear the DCACHE_NOKEY_NAME in
> fscrypt_handle_d_move, skip it entirely for plaintext dentries, to avoid
> extra costs.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

I think this explanation misses an important point, which is that it's only
*directories* where a no-key dentry can become the regular dentry.  The VFS does
the move because it only allows one dentry to exist per directory.

For nondirectories, the dentries don't get reused and this patch is irrelevant.

(Of course, there's no point in making fscrypt_handle_d_move() check whether the
dentry is a directory, since checking DCACHE_NOKEY_NAME is sufficient.)

The diff itself looks good -- thanks.

- Eric

