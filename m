Return-Path: <linux-fsdevel+bounces-58633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79DB302A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFE91CE045F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C147F346A0C;
	Thu, 21 Aug 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9C4qLEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F78F3451DB;
	Thu, 21 Aug 2025 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803399; cv=none; b=ZuePimokJOR37EKw1NVLeZ4PhyMbvsilreY9VjJpdfWEIjXLvVoR6740ZTIMIqxcJ39NiyI0KGSQDHdl1D5P1qqsOGpdiUR3YBuykEtl+BKiaRcEVxw7kldOQQ/f1KDarIOk3YSDmgq/f320ca1ZkxeocOfg7xBsXpEFaKjVWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803399; c=relaxed/simple;
	bh=YIdL6akO0KLrTYwBK6SwuRLLUSW2a562UXW3vk87x3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gJ9ggQb+hXmT/mHLURNCuKJT5qj0zeFH+racWjPhSg9yUbr6nenGroAG0OlFLPwmwuV98CEk794SoUahCvC8FAgwRCoCoIfB/xgjXeU0xnKU9SupZ9VK77+JmddgBCqqjLjE0XOpcSBrfR7tcuxkeO1RIRWKHOmRqjNCQOJg710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9C4qLEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E289C4CEEB;
	Thu, 21 Aug 2025 19:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755803398;
	bh=YIdL6akO0KLrTYwBK6SwuRLLUSW2a562UXW3vk87x3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a9C4qLEKD+YNd2/a5UY87jx5f7O+tkE1oVCnCvAmvf9giIfUEYo83N8WfNXBkw6aC
	 eyEINQh0Umv7fm1oR7+v3m9EyhA+eW57ldudDGSOxdrWsSw+RAzy57K1Dj6xYvNNM0
	 wyBPHGLRGkBerUNzm7iy0UBLk2vB26Wv3s4ccD3Urt2cRniuOeES3vJN1p92WTHvu9
	 FSeXbwx2K1RISArfzvDkdi1BnKhoP5EMmRjj145Y9Nii6u/oo0fkpMn53glMGE5JTE
	 rARhtizT77RrRfK4aVZtikH31dK8Y2hw/Niu7O49VDo9d76KCgBcmduc3ToGSlrY9W
	 /TNqKMyM4lDHw==
From: Nathan Chancellor <nathan@kernel.org>
To: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 David Disseldorp <ddiss@suse.de>
Cc: linux-next@vger.kernel.org, nsc@kernel.org
In-Reply-To: <20250819032607.28727-1-ddiss@suse.de>
References: <20250819032607.28727-1-ddiss@suse.de>
Subject: Re: [PATCH v3 0/8] gen_init_cpio: add copy_file_range / reflink
 support
Message-Id: <175580339739.1482542.13736702939659184221.b4-ty@kernel.org>
Date: Thu, 21 Aug 2025 12:09:57 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Tue, 19 Aug 2025 13:05:43 +1000, David Disseldorp wrote:
> This patchset adds copy_file_range() support to gen_init_cpio. When
> combined with data segment alignment, large-file archiving performance
> is improved on Btrfs and XFS due to reflinks (see patch 7 benchmarks).
> 
> cpio data segment alignment is provided by "bending" the newc spec
> to zero-pad the filename field. GNU cpio and Linux initramfs
> extractors handle this fine as long as PATH_MAX isn't exceeded. A
> kernel initramfs extraction unit test for this is provided.
> 
> [...]

Applied, thanks!

[1/8] gen_init_cpio: write to fd instead of stdout stream
      https://git.kernel.org/kbuild/c/1400227773201
[2/8] gen_init_cpio: support -o <output_file> parameter
      https://git.kernel.org/kbuild/c/ae18b94099b04
[3/8] gen_init_cpio: attempt copy_file_range for file data
      https://git.kernel.org/kbuild/c/97169cd6d95b3
[4/8] gen_init_cpio: avoid duplicate strlen calls
      https://git.kernel.org/kbuild/c/348ff9e3c1cf1
[5/8] gen_initramfs.sh: use gen_init_cpio -o parameter
      https://git.kernel.org/kbuild/c/9135564db4904
[6/8] docs: initramfs: file data alignment via name padding
      https://git.kernel.org/kbuild/c/7c1f14f6e8e7f
[7/8] gen_init_cpio: add -a <data_align> as reflink optimization
      https://git.kernel.org/kbuild/c/5467e85508fd1
[8/8] initramfs_test: add filename padding test case
      https://git.kernel.org/kbuild/c/6da752f55bc48

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


