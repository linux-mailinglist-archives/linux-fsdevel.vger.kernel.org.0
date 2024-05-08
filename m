Return-Path: <linux-fsdevel+bounces-19118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6938C0350
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEB81C22094
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEAB12B151;
	Wed,  8 May 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmiwfqhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96E12AADC;
	Wed,  8 May 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189918; cv=none; b=LwHIN3aBCxPdLjybw5tbz5rO7MAlAAWUfWi+sHEvm1tlMdYHFKgqleJZoeFpPcXNA5hHsU3KdCJdVYDx1XNDFc/jKvmrPDhgX+2jpIaBEFEyoDIzhX2ceVTz53vMSOCEP4Bc04zgYrqc5jZzhNJh1NubcSGVjTSjJQ9hJY0M0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189918; c=relaxed/simple;
	bh=cGxuPlRJuTn+IFe3vhW3XS9aL57oA1nRa7hPyt3GCg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka8jekGewvtV7zZ5BVQofYeOsg5TVJkfLihwQ4Jh+uVtNL0hcTdAz4FayqtMEV13DOv8+n2t6s8h0HjjfxamTm1j+t6pcnYZMzWW1WewmJvdo7Dbk+1DCN2aRaHJW6DN3Q+MH986FCdYiMFj1YhmGkeQ9ut6JXfybIzhktjWfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmiwfqhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965C5C113CC;
	Wed,  8 May 2024 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715189917;
	bh=cGxuPlRJuTn+IFe3vhW3XS9aL57oA1nRa7hPyt3GCg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmiwfqhkN1kg1VsWEgD9s239IxlsKBBdfxyUCVGUjNQSf++MmyfFoNsKZuP+xEeB7
	 +6khUssP3HC5nmXQAJs1e6VKjn26j5w6GRGufcXJRCJF4zZzhb64cHEWkWSQQfYvTf
	 DtGWUvXPn7ZPIRU0wI6KL2MvGwkIJJUfTjMHan6+pq7qWO2pYI+FSmtYwq5p8MSr42
	 RsUiGGYD4gs0Xjx84Du0v7QUriJLK9RmqwG0LiTs+dPDS75oJ7M3V+AGZAeOVDb6ve
	 JyvDU9n7yG/pRokffk4zhS3o60+DLg7TBbYU0/xTnRnZ//wZv5XDVayjHsEOqTtQ61
	 i21IuKI0N4Zkg==
Date: Wed, 8 May 2024 10:38:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tytso@mit.edu, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fscrypt: try to avoid refing parent dentry in
 fscrypt_file_open
Message-ID: <20240508173835.GB19059@sol.localdomain>
References: <20240508081400.422212-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508081400.422212-1-mjguzik@gmail.com>

On Wed, May 08, 2024 at 10:14:00AM +0200, Mateusz Guzik wrote:
> Merely checking if the directory is encrypted happens for every open
> when using ext4, at the moment refing and unrefing the parent, costing 2
> atomics and serializing opens of different files.
> 
> The most common case of encryption not being used can be checked for
> with RCU instead.
> 
> Sample result from open1_processes -t 20 ("Separate file open/close")
> from will-it-scale on Sapphire Rapids (ops/s):
> before:	12539898
> after:	25575494 (+103%)
> 
> v2:
> - add a comment justifying rcu usage, submitted by Eric Biggers
> - whack spurious IS_ENCRYPTED check from the refed case
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/crypto/hooks.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)

Applied to https://git.kernel.org/pub/scm/fs/fscrypt/linux.git/log/?h=for-next

Thanks!

- Eric

