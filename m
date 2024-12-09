Return-Path: <linux-fsdevel+bounces-36770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B697F9E92B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7F31622C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D112221D85;
	Mon,  9 Dec 2024 11:46:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9815EFA0;
	Mon,  9 Dec 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744774; cv=none; b=TgXjXNG6xcsuyTVcA7y78TF7POQm6yxBCflCBVJsekDxpmzqi5UffCooBINQFRqB3NeK2qWlXSdocyatjXQ4u98xvXKg9OCWPykVVErIwIyrGolXfRehzX7STyDVY8nFbsbPGPGcNQE9hexNv2Dcf3dDdz94r5UJvOgveMor2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744774; c=relaxed/simple;
	bh=0Bzgv1TRS8v7g//RHenENj3hzbBPhURktJxinIOrqN0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hdWLKhLUo5hegS08nFuSjm1hE26kRk2cI3JYDUrsP8fsS57FQXVExYiWj1G05SHl407UL69kyf8nqgkZDwHaBhTcsLvieIgdkpgTlC7rqJ5CMrRz7K2fP+H6KGMM0fzbDfwVwTobGBgWhAhV8pNalPSEaPsNaVGWFYj6eu1YhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y6KlY590czRj5c;
	Mon,  9 Dec 2024 19:44:25 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id B07E7180064;
	Mon,  9 Dec 2024 19:46:08 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Dec
 2024 19:46:08 +0800
From: Long Li <leo.lilong@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v6 0/3] iomap: fix zero padding data issue in concurrent append writes
Date: Mon, 9 Dec 2024 19:42:38 +0800
Message-ID: <20241209114241.3725722-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500017.china.huawei.com (7.185.36.126)

Hi ALL,

This patch series fixes zero padding data issues in concurrent append write
scenarios. A detailed problem description and solution can be found in patch 2.
Patch 1 is introduced as preparation for the fix in patch 2, eliminating the
need to resample inode size for io_size trimming and avoiding issues caused
by inode size changes during concurrent writeback and truncate operations.
Patch 3 is a minor cleanup.


v5: https://lore.kernel.org/linux-xfs/20241127063503.2200005-1-leo.lilong@huawei.com/
v4: https://lore.kernel.org/linux-xfs/20241125023341.2816630-1-leo.lilong@huawei.com/
v3: https://lore.kernel.org/linux-xfs/20241121063430.3304895-1-leo.lilong@huawei.com/
v2: https://lore.kernel.org/linux-xfs/20241113091907.56937-1-leo.lilong@huawei.com/
v1: https://lore.kernel.org/linux-xfs/20241108122738.2617669-1-leo.lilong@huawei.com/

v5->v6:
  1. Introduce patch 1. 
  2. The io_size is trimmed based on the end_pos in patch 2.
  3. Update the fix tag to a more accurate in patch 2.
  4. Collect reviewed tag.

Long Li (3):
  iomap: pass byte granular end position to iomap_add_to_ioend
  iomap: fix zero padding data issue in concurrent append writes
  xfs: clean up xfs_end_ioend() to reuse local variables

 fs/iomap/buffered-io.c | 66 ++++++++++++++++++++++++++++++++++++------
 fs/xfs/xfs_aops.c      |  2 +-
 include/linux/iomap.h  |  2 +-
 3 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.39.2


