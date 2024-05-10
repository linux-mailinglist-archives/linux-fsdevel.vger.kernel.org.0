Return-Path: <linux-fsdevel+bounces-19236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E718C1C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94041B228D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BDD13BAC8;
	Fri, 10 May 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLz17kI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0713B79B;
	Fri, 10 May 2024 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304254; cv=none; b=t9+IWLQT+iyTEdRAaaoJceVyUOfDhu2aQfSBOIXIg9rDVWtfFkbFqoNTjhFv+KqHYjJajlqpygfykk3BI60ROiH9G0yV1wpPhUNQQ3e0VycqsAuRh/BkBhYz51A+56H0AMCYSKtlaCoqD6zUYI77BcHcUWRlTn68hJ/g80WWMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304254; c=relaxed/simple;
	bh=urrTXTTywRFtsj11Qs5I6AcHADvw2TrkRJTB0c5eGe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btrh8g3CEMX1I9PU8QbbEEqu76EC5N/SBKHNDqMLUyZIgU5lWXs6G/jAQlaCx3B18nqhrLIoh7UZAB5alohkTwxESVcT6r8g0u1VR1+at4KAJfGGZ3rKYwDuNBc/qoCN8TmzgvV5uBIEzToRkcnIZyK+ZPfK1XbRwc8oKA4Snfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLz17kI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DD4C116B1;
	Fri, 10 May 2024 01:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304253;
	bh=urrTXTTywRFtsj11Qs5I6AcHADvw2TrkRJTB0c5eGe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLz17kI4X02wMZUNr5OvfC48XIq3oJJ9HRAWlpYS3SHaIIfExDpXhTjedc+N5XzGR
	 DZWdE4qnhAGvCKTxz04eYQwAniShrmvJfePAl3e5vqgxjqsXFKPZicw1Jf9eXfREpf
	 ji4cFW+msOXy8wixr4JIHKAKwRigqAPVqIq9ZUgKL+RCh9QJlCuMXDhHLpLkDx3LBp
	 xZBkjdJV7Lodpg2uKuPK/G/dCH9oQ79PjBb5nxN9+OYZo/S2p60x7zslYUiJF/QBpb
	 Bl6MaLwjw4nM/CvuC1+17nFv2kLcndUOfPo9tzSUPO8MCjO9ZZQuiX40EztU59L/gN
	 l4XBXFcKVxsZA==
Date: Fri, 10 May 2024 01:24:11 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 5/9] f2fs: Reuse generic_ci_match for ci comparisons
Message-ID: <20240510012411.GD1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-6-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-6-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:28PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Now that ci_match is part of libfs, make f2fs reuse it instead of having
> a different implementation.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/dir.c | 58 ++++-----------------------------------------------
>  1 file changed, 4 insertions(+), 54 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

