Return-Path: <linux-fsdevel+bounces-54482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEADB00164
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 14:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645725815E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85591255E34;
	Thu, 10 Jul 2025 12:15:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE521FF42
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149749; cv=none; b=anQzJsIuCyw04ntX39yxPZVqZvthyygtpiGBZjRZDYMLV0HBm+DvuPvoSznpnsMMfw54Cp86Xfpb62VCQoIBoqcaPnFN9buSYIhhtWQiXcsqe18jyepBUkfLggpU5JQcuRXjEX1i28K/1GdNogCpmPaCZBnB2FPDuaijkmE67RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149749; c=relaxed/simple;
	bh=CWu7FlHBojLGm5tuTQDLic7+B61OTrI5Fe5paZlyHYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BWppeptWX+8oPIrhqSvImZVOYOvXK1/uWG9Cw3PgaTan9f1vmVQY+8tEsz2wh1Wy4VOR4r2/8vKvmU4UZXpSe1NKPTo2nqKGFmakY/WwX+SSOSPWsaPuWbXdd3zEc6C6ppf1pi7IvnvxFzO3CZVFgYnRB4yzVabS0TZGOiB7FPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bdDG73tTyzXf6s;
	Thu, 10 Jul 2025 20:11:11 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id CBC6F180B3F;
	Thu, 10 Jul 2025 20:15:37 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Jul
 2025 20:15:37 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>, <sandeen@redhat.com>
Subject: [PATCH v5 0/7] f2fs: new mount API conversion
Date: Thu, 10 Jul 2025 12:14:08 +0000
Message-ID: <20250710121415.628398-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

In this version, we have finished the issues pointed in v4.
First, I'd like to express my sincere thanks to Jaegeuk and Chao
for reviewing this patch series and providing corrections. I also
appreciate Eric for rebasing the patches onto the latest branch to
ensure forward compatibility.

The latest patch series has addressed all the issues mentioned in
the previous set. For modified patches, I've re-added Signed-off-by
tags (SOB) and uniformly removed all Reviewed-by tags.

v5:
  - Add check for bggc_mode(off) with sb blkzone case.
  - Fix the 0day-ci robot reports.

v4: https://lore.kernel.org/all/20250602090224.485077-1-lihongbo22@huawei.com/
  - Change is_remount as bool type in patch 2.
  - Remove the warning reported by Dan for patch 5.
  - Enhance sanity check and fix some coding style suggested by
    Jaegeuk in patch 5.
  - Change the log info when compression option conflicts in patch 5.
  - Fix the issues reported by code-reviewing in patch 5.
  - Context modified in patch 7.

V3: https://lore.kernel.org/all/20250423170926.76007-1-sandeen@redhat.com/
- Rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
  dev branch
- Fix up some 0day robot warnings

(Here is the origianl cover letter:)

Since many filesystems have done the new mount API conversion,
we introduce the new mount API conversion in f2fs.

The series can be applied on top of the current mainline tree
and the work is based on the patches from Lukas Czerner (has
done this in ext4[1]). His patch give me a lot of ideas.

Here is a high level description of the patchset:

1. Prepare the f2fs mount parameters required by the new mount
API and use it for parsing, while still using the old API to
get mount options string. Split the parameter parsing and
validation of the parse_options helper into two separate
helpers.

  f2fs: Add fs parameter specifications for mount options
  f2fs: move the option parser into handle_mount_opt

2. Remove the use of sb/sbi structure of f2fs from all the
parsing code, because with the new mount API the parsing is
going to be done before we even get the super block. In this
part, we introduce f2fs_fs_context to hold the temporary
options when parsing. For the simple options check, it has
to be done during parsing by using f2fs_fs_context structure.
For the check which needs sb/sbi, we do this during super
block filling.

  f2fs: Allow sbi to be NULL in f2fs_printk
  f2fs: Add f2fs_fs_context to record the mount options
  f2fs: separate the options parsing and options checking

3. Switch the f2fs to use the new mount API for mount and
remount.

  f2fs: introduce fs_context_operation structure
  f2fs: switch to the new mount api

[1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/

Hongbo Li (7):
  f2fs: Add fs parameter specifications for mount options
  f2fs: move the option parser into handle_mount_opt
  f2fs: Allow sbi to be NULL in f2fs_printk
  f2fs: Add f2fs_fs_context to record the mount options
  f2fs: separate the options parsing and options checking
  f2fs: introduce fs_context_operation structure
  f2fs: switch to the new mount api

 fs/f2fs/super.c | 2101 +++++++++++++++++++++++++++--------------------
 1 file changed, 1190 insertions(+), 911 deletions(-)

-- 
2.33.0


