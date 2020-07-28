Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3774C230FC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbgG1QfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731478AbgG1QfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:35:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C5C061794;
        Tue, 28 Jul 2020 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i1H+gCppzv/oG+6sLkbZmKQE2JPL8SjqHA8WTb2gSvU=; b=LxM66CH3HTPccSmCXgX61L4i3x
        lcFVojpvIzaXLMSJtSHVOjYQc1VPg8nqUMGKn26icgHeCTDwa8cHthtW0NyH9IL7x2K6H/JISRVQ8
        JPjpG3xAigGpx594tGH/CGBwTS6i+qC6/bKK6FkfnsZJZTHT+M/4vF+It4SBOG2cwOdDfrVoib8bQ
        SKzq5r8Fy6WzZpVjLBXx+/sapnEvfU8lNNYQaRCR8MWe4VeeF/i1AciLsd00Ig8++1b8MByywdmZX
        UNpBAk8J1tPn5xuPMOXn0AlyHrb5reNQLbLvHkH954tGZ9cpRydpCm4IgPR8ell8DTsT3PERwJxOn
        5Vw0CBQg==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SZD-00075W-DO; Tue, 28 Jul 2020 16:35:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 23/23] init: add an init_dup helper
Date:   Tue, 28 Jul 2020 18:34:16 +0200
Message-Id: <20200728163416.556521-24-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728163416.556521-1-hch@lst.de>
References: <20200728163416.556521-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to grab a reference to a file and install it at
the next available fd, and switch the early init code over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/init.c                     | 12 ++++++++++++
 include/linux/init_syscalls.h |  1 +
 init/main.c                   |  7 +++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index db5c48a85644fa..730e05acda2392 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -8,6 +8,7 @@
 #include <linux/namei.h>
 #include <linux/fs.h>
 #include <linux/fs_struct.h>
+#include <linux/file.h>
 #include <linux/init_syscalls.h>
 #include <linux/security.h>
 #include "internal.h"
@@ -251,3 +252,14 @@ int __init init_utimes(char *filename, struct timespec64 *ts)
 	path_put(&path);
 	return error;
 }
+
+int __init init_dup(struct file *file)
+{
+	int fd;
+
+	fd = get_unused_fd_flags(0);
+	if (fd < 0)
+		return fd;
+	fd_install(get_unused_fd_flags(0), get_file(file));
+	return 0;
+}
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 3654b525ac0b17..92045d18cbfc99 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -16,3 +16,4 @@ int __init init_unlink(const char *pathname);
 int __init init_mkdir(const char *pathname, umode_t mode);
 int __init init_rmdir(const char *pathname);
 int __init init_utimes(char *filename, struct timespec64 *ts);
+int __init init_dup(struct file *file);
diff --git a/init/main.c b/init/main.c
index 1c710d3e1d461a..089e21504b1fc1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1467,10 +1467,9 @@ void __init console_on_rootfs(void)
 		pr_err("Warning: unable to open an initial console.\n");
 		return;
 	}
-	get_file_rcu_many(file, 2);
-	fd_install(get_unused_fd_flags(0), file);
-	fd_install(get_unused_fd_flags(0), file);
-	fd_install(get_unused_fd_flags(0), file);
+	init_dup(file);
+	init_dup(file);
+	init_dup(file);
 }
 
 static noinline void __init kernel_init_freeable(void)
-- 
2.27.0

