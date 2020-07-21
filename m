Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8997E228595
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgGUQaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbgGUQ2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3461CC061794;
        Tue, 21 Jul 2020 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TZGFhBS1vSa3KHC8kTIcxm+uFEJ0ZiELC7/lIthiJQQ=; b=tZwucmBupqJ+czU2GmfRNHMqYb
        iOT/K6KhStl9ONJIZTRDe/8R4z7KMhtUFRuy6AbneK0WaKlRFCWrwy+EB8GHcn2u1YTd+Elf4KRj6
        svhIPY5FkLxVndqvIvM4MIruB/PNMoE8qM5lqteKHufzsHyNuv6z6rywWo62BawYwDWki9/2/viXr
        6Da8k0Y3zdos/hJWVmPTvTQBxr1B1INQA2Q1oi4tIpuZS/IN2hy9DGY/SdmVlmZMxsz5UMRsq2oSu
        x+wvHMUUUJ0fwLeccN7Pq6dtVMxfZknWH7T12/FCBDkt9qouOy1lTmdZ71zv+7H317GjspgJ+Mb2h
        tBAuMsWg==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv82-0007Sg-LS; Tue, 21 Jul 2020 16:28:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 08/24] init: move the prepare_namespace prototype to init/do_mounts.h
Date:   Tue, 21 Jul 2020 18:28:02 +0200
Message-Id: <20200721162818.197315-9-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No need to have this prototype in a global header included by
every driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/init.h | 1 -
 init/do_mounts.h     | 1 +
 init/main.c          | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 212fc9e2f691a1..7de54fcad39431 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -147,7 +147,6 @@ extern unsigned int reset_devices;
 
 /* used by init/main.c */
 void setup_arch(char **);
-void prepare_namespace(void);
 void __init init_rootfs(void);
 extern struct file_system_type rootfs_fs_type;
 
diff --git a/init/do_mounts.h b/init/do_mounts.h
index c855b3f0e06d19..853da3cc4a3586 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -11,6 +11,7 @@
 
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
+void prepare_namespace(void);
 extern int root_mountflags;
 
 static inline int create_dev(char *name, dev_t dev)
diff --git a/init/main.c b/init/main.c
index c2c9143db96795..b952e4cd685af4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,8 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 
+#include "do_mounts.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
-- 
2.27.0

