Return-Path: <linux-fsdevel+bounces-19234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D358C1C03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34F91C2212D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337113B7A9;
	Fri, 10 May 2024 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwZv8VsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5C13AA3E;
	Fri, 10 May 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304204; cv=none; b=JHebzdFxwon/7tkCbUP5WBqA2EJpcccE5CYuT60M+9lLvpIcYHYeHtpns9ApypNoYWonpJHf5Q9aegNVp2T59E78rxs325SW2a9qxMF6aKG0kYKBzXQXGt69dE5o8/lnnNVX68byCQsuOBKWt8LH4lETpbvdKPJllpjtY4XAiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304204; c=relaxed/simple;
	bh=q/FawnNNYdlyJTnV7E3Oe1PGL6Eb45vWLaHXkmAaNZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSw8ote6SrSqoZUZbhoh7hW0f2LkF0WzZRVPPbsgmgvT6Pxxzy1/kfjGhtdt/ZaGipHvnAzw/p68W3qf1bWVTgZoex4XTvFdEHuJAn5qU8jAxdszavtdnC0eDfKs2qbTe55v1fhwx2SKabsbRnC9GcbR4NlWtaxteCGLAQuFpw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwZv8VsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60614C116B1;
	Fri, 10 May 2024 01:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304203;
	bh=q/FawnNNYdlyJTnV7E3Oe1PGL6Eb45vWLaHXkmAaNZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwZv8VsSwrZOOohfrqdjX3bsQIUWtJESwffvWTHyjxpKo9ZV1uf/EjVz225CT9p6+
	 h6j8eu2Zemx1r2C7dzpgS/JeDI8nQ4Boid45QlHuaD3gacoqkP5OeB0LXvXXisRXcy
	 t/NSSc5XVmqF00wXABtz/et51ITlrvAqcWdiMc3YlNskt5QPObrfnoVzdHs/L5HEGs
	 w73jIWSua8+2q/QFXImM1omgQ0rtb/9hMHmJFuE5jpyGJ36+U7ZSAe1vkfTrTzInKZ
	 yW8GCwEfsjcyGYDqYZwC+ayNiNccGJdYxU7SmRht/Z10lzmE0HHhuOurIP+0uIo1QV
	 13HcrkjxpFIXg==
Date: Fri, 10 May 2024 01:23:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 2/9] f2fs: Simplify the handling of cached
 insensitive names
Message-ID: <20240510012322.GB1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-3-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-3-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:25PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Keeping it as qstr avoids the unnecessary conversion in f2fs_match
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: port to 6.8-rc3 and minor changes]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/dir.c      | 53 ++++++++++++++++++++++++++--------------------
>  fs/f2fs/f2fs.h     | 16 +++++++++++++-
>  fs/f2fs/recovery.c |  9 +-------
>  3 files changed, 46 insertions(+), 32 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

(But please change "cached insensitive" to "case-insensitive")

- Eric

