Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206DC1F6884
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 15:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFKNCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 09:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgFKNCo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:02:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C022078D;
        Thu, 11 Jun 2020 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591880564;
        bh=oIFDco9wSfb4lTuFP6eOfnJlL6E9kI2N6jVSLJ+pxQE=;
        h=From:To:Cc:Subject:Date:From;
        b=aVGlTAk0/jjcBuzmDwXpUPnRY27q+6WlBJJ7htCnedfok1X0zknD7h+4MFZHp0DP/
         Yx5S4aAVreN6WpY5wuk7Wgsc1YR+13n1fhlPQdurXK/Mi7MdLVXsD7AakOrqtCT+xe
         Qjg4QIIRQ3+2U/cNNr4KAjofN1zUVPguT5AwTCjA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Delete always true compilation define
Date:   Thu, 11 Jun 2020 16:02:37 +0300
Message-Id: <20200611130237.1994420-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

In commit 1027abe8827b ("[PATCH] merge locate_fd() and get_unused_fd()")
the existing "#if 1" was moved from one place to another. Originally
that compilation define was set for the sanity check and more than 12
years later it is safe to remove it.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 fs/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index c8a4e4c86e55..cab9d55765dd 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -522,13 +522,11 @@ int __alloc_fd(struct files_struct *files,
 	else
 		__clear_close_on_exec(fd, fdt);
 	error = fd;
-#if 1
 	/* Sanity check */
 	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
 		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
 		rcu_assign_pointer(fdt->fd[fd], NULL);
 	}
-#endif

 out:
 	spin_unlock(&files->file_lock);
--
2.26.2

