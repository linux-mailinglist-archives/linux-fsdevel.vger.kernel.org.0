Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1F57E45C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 18:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiGVQ35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 12:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiGVQ3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:29:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DE691CD5;
        Fri, 22 Jul 2022 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dfsvCtbqj1aTabifZLD8rO8Jn7E44Br7CNa+F9C5WOo=; b=Eh0R/EMH/rCoU82UJQhON4r0qZ
        qqmUefp4at7/z2HepFQw3gDMVCE719zc+a/allPpuCx/8Mi5FyLndHi8qs+tkuUJMog80gIvoc/a6
        TKzO7Qf23pJPkOncSRAcwZfP6QOs1W28Vr68g8EmOc1RgQO0xuPY1XFE9MNhgCKU57JSzDRyEs9Q1
        +65qpuaaWRCVcjTxI4rU/nUdY8ESPq6vi8fgrkw6liUVeh7UTJA9qbYr2bQ6DrpiHoAGh5toS5k3M
        5HWKNJOoIo+81NOoC0QqXdZ3RR45Bn+MA1JORBKDGG2e7r9qUVvMx8RzV30FP3wk7Yr9MIN4f3w2j
        eNfN8liQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEvX1-007vOh-CK; Fri, 22 Jul 2022 16:29:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, corbet@lwn.net, keescook@chromium.org,
        yzaikin@google.com
Cc:     songmuchun@bytedance.com, zhangyuchen.lcr@bytedance.com,
        dhowells@redhat.com, deepa.kernel@gmail.com, hch@lst.de,
        mcgrof@kernel.org, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Documentation/filesystems/proc.rst: document procfs inode timestamps
Date:   Fri, 22 Jul 2022 09:29:34 -0700
Message-Id: <20220722162934.1888835-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220722162934.1888835-1-mcgrof@kernel.org>
References: <20220722162934.1888835-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The timestamps for procfs files are not well understood and can
confuse users and developers [0] in particular for the timestamp
for the start time or a process. Clarify what they mean and that
they are a reflection of the ephemeral nature of the filesystem
inodes.

The procfs inodes are created when you first read them and then
stuffed in the page cache. If the page cache and indodes are
reclaimed they can be removed, and re-created with a new timestamp
after read again. Document this little bit of tribal knowledge.

[0] https://lkml.kernel.org/r/20220721081617.36103-1-zhangyuchen.lcr@bytedance.com
Reported-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Documentation/filesystems/proc.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 9fd5249f1a5f..9defe9af683a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -59,6 +59,15 @@ The proc  file  system acts as an interface to internal data structures in the
 kernel. It  can  be  used to obtain information about the system and to change
 certain kernel parameters at runtime (sysctl).
 
+The proc files are dynamic in nature and allow for developers to make the
+content to be changed each time a file is read. The proc files and directories
+inodes are created when someone first reads a respective proc file or directory,
+as such the timestamps of the proc files reflect this time. As with other
+filesystems, these proc inodes can be removed through reclaim under memory
+pressure and so the timestamps of the proc files can change if the proc files
+are destroyed and re-created (echo 3 > /proc/sys/vm/drop_caches forces and
+illustrate the reclaim of inodes and page cache).
+
 First, we'll  take  a  look  at the read-only parts of /proc. In Chapter 2, we
 show you how you can use /proc/sys to change settings.
 
@@ -328,6 +337,13 @@ It's slow but very precise.
 		system call
   ============= ===============================================================
 
+Note that the start_time inside the stat file is different than the timestamp
+of the stat file itself. The timestamp of the stat file simply reflects the
+first time the stat file was read. The proc inode for this file can be reclaimed
+under memory pressure and be recreated after this and so the timestamp can
+change. Userspace should rely on the start_time entry in the the stat file to
+get a process start time.
+
 The /proc/PID/maps file contains the currently mapped memory regions and
 their access permissions.
 
-- 
2.35.1

