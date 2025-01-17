Return-Path: <linux-fsdevel+bounces-39502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E369A15497
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D89C188C424
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E519DF66;
	Fri, 17 Jan 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kyo2yhKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360D33062;
	Fri, 17 Jan 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132237; cv=none; b=SP6CDYSmH4gXn86RoooQCj31PN0GT6E5pY2ld2YUrmiNXxQvrsX6krIOdUGXbmUOs3VAECThEyGbTLpcK30hwKA0FJPANvf5XDEwaCwbXNmSjIcNnwhrMkHAe/rTcUdOR73g4UatVvh3TYOtMpVNAgabBcy5UOO01umWDZbrF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132237; c=relaxed/simple;
	bh=S02F2sVetY7kvvykNiDGJwlwNft/i3THYzyTiCi3N6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVTXwwr4TzA6gvkcrtzZ59Z8OQ9qJ+0BC057Fky1mJyHavFfT7UNT5rJfqiMXJrQixe+AQRNPe54kFccV70+UM09wlPiFO0HIWE7E7VtWJ7uefuVi5+zIqtiX5C7NpAJm3r8iqUk1+OjuCO9x23VkEWBc26IEW9n/zZpCeH5PUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kyo2yhKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED05C4CEDD;
	Fri, 17 Jan 2025 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737132236;
	bh=S02F2sVetY7kvvykNiDGJwlwNft/i3THYzyTiCi3N6I=;
	h=From:To:Cc:Subject:Date:From;
	b=Kyo2yhKf/2sXZJoY5Nj661rDPYbywRn6sgwZGlLRMqe3rITI93OISYLUUSG7M6PsU
	 5x3XybunpHjikgKJshxh+Ty4iR6XZBh/IKbNaRKO3PNeV6nOu/iOHmpcu4jzJ2Iyja
	 /gJ65RiXJi4yx3AhyIAMsMBjfMvu4m57WYNK1mY20Hy+xYEqpryozF43Yx+mK6gWhl
	 uxdVDBuf36B2jyButU/WodKR2jJ0o/WfdZCxpoi5GU2h618uJPG5Hfsbvr6QbnZTdJ
	 mwjOBMLkuLFi/aTK2lWSLlv/KYta1psDhCJm6jcH/nPZKJ9Y0gtygFxX5C0u5FIGQU
	 S53qI9Deohw0Q==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Date: Fri, 17 Jan 2025 16:41:16 +0000
Message-ID: <20250117164350.2419840-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If users clearly know which file-backed pages to reclaim in system view, they
can use this ioctl() to register in advance and reclaim all at once later.

To MM and others,

I'd like to propose this API in F2FS only, since
1) the use-case is quite limited in Android at the moment. Once it's generall
accepted with more use-cases, happy to propose a generic API such as fadvise.
Please chime in, if there's any needs.

2) it's file-backed pages which requires to maintain the list of inode objects.
I'm not sure this fits in MM tho, also happy to listen to any feedback.

Jaegeuk Kim (2):
  f2fs: register inodes which is able to donate pages
  f2fs: add a sysfs entry to request donate file-backed pages

 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++
 fs/f2fs/debug.c                         |  3 ++
 fs/f2fs/f2fs.h                          | 14 +++++-
 fs/f2fs/file.c                          | 65 +++++++++++++++++++++++++
 fs/f2fs/inode.c                         | 14 ++++++
 fs/f2fs/shrinker.c                      | 27 ++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         |  8 +++
 include/uapi/linux/f2fs.h               |  7 +++
 9 files changed, 145 insertions(+), 1 deletion(-)

-- 
2.48.0.rc2.279.g1de40edade-goog


