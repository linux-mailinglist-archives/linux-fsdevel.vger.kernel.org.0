Return-Path: <linux-fsdevel+bounces-65991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3A6C17972
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F39364E6601
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3411C277C8C;
	Wed, 29 Oct 2025 00:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si/Bl4IZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7261DE2BF;
	Wed, 29 Oct 2025 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698526; cv=none; b=U3AjXR76dq2Yhwue2IDzmxhhiTL73T8ouadi4EmCTyDiI854yVaB8QN33rnErXCYy+er9CbxaZeEw9DpQ5kIkQSuSKijcDtk0wo+cLpDjxf+7RfjWtoABq2/qUzEEWXaIG42quxDth8k136VmTCUvSYfGfpQLSpPYOtFY+bcaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698526; c=relaxed/simple;
	bh=9Xd8GxSos5Qz1BGxdT+w1iPD9eVgqkrRRMVpPPQi2rU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYtkQMJynsLUHO6mC0CliuYXBf925o8+ZWXyQrHDCxor1W42SdCvmZBwezLTq+8Ja0CLz1p5o5lWlZG1boIHJ5EOsiudmcUx0emQ4n2xVhA9oJUTIowM+VYfVNBbqIeasBztyAIBIVIxMBlsB/YN1UAeCBy9/OcIPOqxWMd5vIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si/Bl4IZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE88C4CEE7;
	Wed, 29 Oct 2025 00:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698526;
	bh=9Xd8GxSos5Qz1BGxdT+w1iPD9eVgqkrRRMVpPPQi2rU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=si/Bl4IZBZnusblXCEasHNvCnDGU+/Q7iLFdvK2Gn8LdSNaqw79zi/RAsIdX2gx0s
	 SSgTjTMa0nSweLra5eag5Nwd6YlbLVDBNOZygt/Mn1J+nUFiUWyl3y66ZFrqC2cYlf
	 OE2bW3j4xFBgEB0S+JxGN/u8lmxKRUv9ybWW4UZOwgBU+cp7nzR7d8IGjTxmteph/z
	 Ay7kmNfBoIh6uWVqCbyZrVyN0wxV6JUC+scpb0pFjCC60DO3qLmGUrUPWMgTHTYEdn
	 Yzv8YlTOS0EDu4Gydgj7zM3ON2RFbOXi/Bx3uBxayV1gKFulzc1vLvyty9pj22PUcm
	 el3qx32PMBK1w==
Date: Tue, 28 Oct 2025 17:42:05 -0700
Subject: [PATCHSET v6 4/6] fuse2fs: cache iomap mappings for even better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818545.1430840.7420840378591574460.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap-cache
---
Commits in this patchset:
 * fuse2fs: enable caching of iomaps
 * fuse2fs: be smarter about caching iomaps
 * fuse2fs: enable iomap
---
 fuse4fs/fuse4fs.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++----
 misc/fuse2fs.c    |   50 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 96 insertions(+), 8 deletions(-)


