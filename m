Return-Path: <linux-fsdevel+bounces-58204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F02B2B0AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4DB1968612
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0927280B;
	Mon, 18 Aug 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZVHwdi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D5270EBF;
	Mon, 18 Aug 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542479; cv=none; b=EuEMnXRwkzDnYKxKeGX7OjNJCJpqYnfyLZNPFsnvn3JUXXdryuE2KQVCiwVoqULUcFnwiRO9cT8ZfQl3STEgbFvWV5CT4UnqpBvqsOvtx5lOeMpKLJkMXweQp2YP5jIPXd5Bhbtm5ut6k1igGw0f79cdDymfBOA2o+hzAmq2Wwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542479; c=relaxed/simple;
	bh=ZHexbF7np/Jhges04hIm4GXEMoM3CQhe3mct/LZZeEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vrw0PyIRzkGf1TSWfdQwFVJdAH5cWTtoaX4iP9jq2lNAc2b1fuEpyAWiLIk4DVvB4Bm7L/4EF0aUB2+nAGYExxmRnYf6+HMWPn0HHLKJX6cwv4raejTw7DJU3bFz9/a5Cb18k7YhA0giuxFDBVYP1FIwk/QtTM1e1/Niwm4U4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZVHwdi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CFEC4CEED;
	Mon, 18 Aug 2025 18:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755542478;
	bh=ZHexbF7np/Jhges04hIm4GXEMoM3CQhe3mct/LZZeEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZVHwdi/DQolQ888xB3FbMAy68bfxZmvGQguso6L/JOX+4+z0Iv8x2dcOgsotfh0z
	 IjMjAZW7QNM2ANtEt4RoRFenzfGJvpo8h8gzS5SfkPrKDEuS9FUA5/rGbHWJLYW2hH
	 vNKaRc7gK+LGwaqH9KFrrkFUdYxc1tNcLeU/+dC/Rm8UjZKEGVBSz1AXzUuASxaVSo
	 E37Vug/5h1wKrWG9waj1f0l0ywx6VEuCV22vORb3zEtYE9MqJCyZt0HduIS9aBur3z
	 M2Tlc4/rPA90+oiJp1D3vn4LjdB2Oy3C/7Qa9KuH0XJ575+OY6OArJ4Mq3MQZTt8Tg
	 bmzSjhS0xSxcg==
Date: Mon, 18 Aug 2025 20:40:39 +0200
From: Nicolas Schier <nsc@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v2 3/7] gen_init_cpio: attempt copy_file_range for file
 data
Message-ID: <aKNzpz3ibFDQwdSQ@levanger>
References: <20250814054818.7266-1-ddiss@suse.de>
 <20250814054818.7266-4-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814054818.7266-4-ddiss@suse.de>

On Thu, Aug 14, 2025 at 03:18:01PM +1000, David Disseldorp wrote:
> The copy_file_range syscall can improve copy performance by cloning
> extents between cpio archive source and destination files.
> Existing read / write based copy logic is retained for fallback in case
> the copy_file_range syscall is unsupported or unavailable due to
> cross-filesystem EXDEV, etc.
> 
> Clone or reflink, as opposed to copy, of source file extents into the
> output cpio archive may (e.g. on Btrfs and XFS) require alignment of the
> output to the filesystem block size. This could be achieved by inserting
> padding entries into the cpio archive manifest.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  usr/gen_init_cpio.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Thanks.  I like introducing copy_file_range() here, it reduces the cpio
generation time on my system by a about 30% on a btrfs filesystem.
May cpio_mkfile_csum() now the slowest part?

Kind regards,
Nicolas

