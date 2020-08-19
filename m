Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEF62497D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgHSH57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 03:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHSH5x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:57:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1817920772;
        Wed, 19 Aug 2020 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597823872;
        bh=46Afa7lxXaQ42q0RivTpZdxjVSSKrIctrmkKL9xdz2M=;
        h=From:To:Cc:Subject:Date:From;
        b=i+MQYRnW5CZzsLaOjHss3rw7hf9udYydqoUupa6xGDzflVgwvsHZgkdKdALKBfXML
         mAKdRb1ZblwzAt9METwq1jdGpffGgXlI4IvjtrBkwDX4cfzYkZsmXJCajX+JaPsRgO
         xqlgtAyUA38wZQRVsOMhK5jpf3lQkiTMwjHwEoD8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] fs: Delete always true compilation define
Date:   Wed, 19 Aug 2020 10:50:27 +0300
Message-Id: <20200819075027.916526-1-leon@kernel.org>
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
index 21c0893f2f1d..13a89df7c74e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -535,13 +535,11 @@ int __alloc_fd(struct files_struct *files,
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

