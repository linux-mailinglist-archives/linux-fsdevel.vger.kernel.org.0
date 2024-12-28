Return-Path: <linux-fsdevel+bounces-38203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79A9FDBC8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 18:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D3F3A141B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095731925A2;
	Sat, 28 Dec 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi2D5/TJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFE382
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735408528; cv=none; b=jTon0EXwIuWOe348UHdioC0BVChLHkj0yBvVMd0hvnV2rRmnqWGVGBK76Hya3L+EC+KL+xaqfPd6i6/AdxlwORgSWEyPaHRtR66doRVe2ktSpu589T7YZ9PhMBRU6Qlf0+mbU0PBap3S7+aGW6wIfjLqdeiTU8T77y3+XmNCbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735408528; c=relaxed/simple;
	bh=bwFx/HRhxQFiEIQ7+w/ckGTsvDdqntEzbhKZXbPzuoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZtqdzNtvOoxGtmT5sv5Hv0ApKPbGU2Qse0h1wVT3ju8L/Puha3ignsO+flvG4lraR2WLw11JVQB+Y9JlhInBgN8gMIbXbiDQ2F2xHfmZHPrrou7czYlS4aHxhkmGeUTO6gI+8FCWeEib6Dj2HcQvJxk2bI6n1Y5lGdSCPkZZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi2D5/TJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CDBC4CECD;
	Sat, 28 Dec 2024 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735408527;
	bh=bwFx/HRhxQFiEIQ7+w/ckGTsvDdqntEzbhKZXbPzuoU=;
	h=From:To:Cc:Subject:Date:From;
	b=qi2D5/TJMFVKU9f1fAgfTSY7ZbTJFDgLygv8Y5FIN+nesbCt2a3mjLVJkdwEQKR4d
	 Vz6ArZnICpZUzK1maDP81j0FZOx7CJozM77NgMsSE0voF337NBmpN/dUv1imMxRaRE
	 HCPjndho6JdTKMMssw9ilQLDbP8Qwh8vPJsCG3AGVXmr2zeTy3iYmNqFzslg3PPHE8
	 8HTfX0GD/oW98Ivqkbsnv6To5b+cYMkQxpb0GXFMAyYDt0ag5cP1NViaw2z4EI4beC
	 2Sf0rQuJqHQH61XeA3+QZgOF6k3DB4vI5rYV8A/EupRfLTup5UIFxJRx/zwMKWYMiC
	 GUDFO8GRwSdrw==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Liam.Howlett@oracle.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 0/5] Improve simple directory offset wrap behavior
Date: Sat, 28 Dec 2024 12:55:16 -0500
Message-ID: <20241228175522.1854234-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The purpose of this series is to construct a set of upstream fixes
that can be backported to v6.6 to address CVE-2024-46701.

In response to a reported failure of libhugetlbfs-test.32bit.gethugepagesizes:

https://lore.kernel.org/linux-fsdevel/f996eec0-30e1-4fbf-a936-49f3bedc09e9@oracle.com/T/#t

I've narrowed the range of directory offset values returned by
simple_offset_add() to 3 .. (S32_MAX - 1) on all platforms. This
means the allocation behavior is identical on 32-bit systems, 64-bit
systems, and 32-bit user space on 64-bit kernels. The new range
still permits over 2 billion concurrent entries per directory.

Changes since v6:
- Restrict the directory offset value range to S32_MAX on all platforms

This series (against v6.13-rc4) has been pushed to:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=tmpfs-fixes

Chuck Lever (5):
  libfs: Return ENOSPC when the directory offset range is exhausted
  Revert "libfs: Add simple_offset_empty()"
  Revert "libfs: fix infinite directory reads for offset dir"
  libfs: Replace simple_offset end-of-directory detection
  libfs: Use d_children list to iterate simple_offset directories

 fs/libfs.c         | 162 +++++++++++++++++++++------------------------
 include/linux/fs.h |   1 -
 mm/shmem.c         |   4 +-
 3 files changed, 79 insertions(+), 88 deletions(-)

-- 
2.47.0


