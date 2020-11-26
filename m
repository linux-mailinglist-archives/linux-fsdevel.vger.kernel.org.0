Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A62C4F3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 08:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbgKZHRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 02:17:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7689 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbgKZHRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:17:48 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ChTbY42tTz15P5R;
        Thu, 26 Nov 2020 15:17:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 15:17:27 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH] fs: export vfs_stat() and vfs_fstatat()
Date:   Thu, 26 Nov 2020 15:15:48 +0800
Message-ID: <1606374948-38713-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The public function vfs_stat() and vfs_fstatat() are
unexported after moving out of line in
commit 09f1bde4017e ("fs: move vfs_fstatat out of line"),
which will prevent the using in kernel modules.
So make them exported.

Fixes: 09f1bde4017e ("fs: move vfs_fstatat out of line")
Reported-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 fs/stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index dacecdd..7d690c6 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -147,6 +147,7 @@ int vfs_fstat(int fd, struct kstat *stat)
 	fdput(f);
 	return error;
 }
+EXPORT_SYMBOL(vfs_fstat);

 /**
  * vfs_statx - Get basic and extra attributes by filename
@@ -207,6 +208,7 @@ int vfs_fstatat(int dfd, const char __user *filename,
 	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
 			 stat, STATX_BASIC_STATS);
 }
+EXPORT_SYMBOL(vfs_fstatat);

 #ifdef __ARCH_WANT_OLD_STAT

--
2.8.1

