Return-Path: <linux-fsdevel+bounces-20197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418008CF74F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 03:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DD01F21C06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 01:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CF623D7;
	Mon, 27 May 2024 01:46:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B8621;
	Mon, 27 May 2024 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716774402; cv=none; b=Wx1Vt9tcK2urBQLH1FWsx9MVpgtm1T1xFVDqdExJiixuGpHRVpuAF+fWmqs3t34KpIZEMB8uopyTgNH51xLJFoDZhtDmAGCpYFKv55XG2L6yj0b0k05PqG5DbVANUD43tuuu7aptbzrOF13jtSNxLBRSrBomW5xV0yg2/Z2MriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716774402; c=relaxed/simple;
	bh=SW/gItspD/ZTVDcTK1q3GUEQsjaFbAVGKVLTUwEWRi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ukXqqOpYKtRI25Ze1+gDQtFtPMap+ySdxbBO5taCIqyxVmKRc/IwOAvnCjRB0YGM1kulAWhokNLp4+sOrapabHrPoSG+psr0jO/uYdRbtOOXjjpwJsW9saMlSO1XRIFFrjXVnNMcPwA7ccfkgFWR9bproDAjzvTC4OKn4Mbm9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vndgw6j2yzwPSp;
	Mon, 27 May 2024 09:42:52 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C54C180A9F;
	Mon, 27 May 2024 09:46:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 09:46:37 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lczerner@redhat.com>, <cmaiolino@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yi.zhang@huawei.com>, <lihongbo22@huawei.com>
Subject: [PATCH 0/4] enhance the path resolution capability in fs_parser
Date: Mon, 27 May 2024 09:47:13 +0800
Message-ID: <20240527014717.690140-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


