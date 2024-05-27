Return-Path: <linux-fsdevel+bounces-20209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E458CFAB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA751F22D09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4873B3B1AB;
	Mon, 27 May 2024 07:58:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE856455;
	Mon, 27 May 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796699; cv=none; b=Xn6MOlSLax/3/FeOB3ADQGO/SDOi+utRB4qHA0xUxjsT090KT8t92Oz4XjLEqgSgqS3h8So/Pkd0WxELlY64GQv536TrGXGxxW840JCyTOOgiu80J2iA4bje+rgkkLLO41y1WcQJxRZpqtq/u5xAVm8SR+ESgPIIsOefciKt5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796699; c=relaxed/simple;
	bh=zHBANfI6t7WoSuSiD9w3Jd9ujBSu+Yh+yqVT6vlxMU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EbnKQUuuXB9Ui5QCe246IicoRHoTFUWQ8LfQNROpqalT3k8IUUeDDx7lCUiiO4VHO1AXNtMG+bxhC+p3VVPmZA4d0LT1ja/h+yDPuoXaUGGqJlY7lqOG0SKeQhcPFthr6zWwlYifjOfnc6m4QEzkt+A5FjQ4ybA0WOoyvq/khD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Vnnwq69qfz1S5jg;
	Mon, 27 May 2024 15:54:35 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 818AE1A0188;
	Mon, 27 May 2024 15:58:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 15:58:09 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lczerner@redhat.com>, <cmaiolino@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yi.zhang@huawei.com>, <lihongbo22@huawei.com>
Subject: [PATCH v2 0/4] enhance the path resolution capability in fs_parser
Date: Mon, 27 May 2024 15:58:50 +0800
Message-ID: <20240527075854.1260981-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Mount options with path should be parsed into block device or inode. As
the new mount API provides a serial of parsers, path should also be 
looked up into block device within these parsers, not in each specific
filesystem.

The following is a brief overview of the patches, see the patches for
more details.

Patch 1-2: Enhance the path resolution capability in fs_parser.
Patch 3: Fix the `journal_path` options error in ext4. 
Patch 4: Remove the `fs_lookup_param` and its description.

Comments and questions are, as always, welcome.

Thanks,
Hongbo

Changes since v1:
	* Fix test robot warning and rebase on latest code.

Hongbo Li (4):
  fs: add blockdev parser for filesystem mount option.
  fs: add path parser for filesystem mount option.
  fs: ext4: support relative path for `journal_path` in mount option.
  fs: remove fs_lookup_param and its description.

 Documentation/filesystems/mount_api.rst |  17 +---
 fs/ext4/super.c                         |  26 +----
 fs/fs_parser.c                          | 125 +++++++++++++-----------
 include/linux/fs_parser.h               |   7 +-
 4 files changed, 71 insertions(+), 104 deletions(-)

-- 
2.34.1


