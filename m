Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4633461396
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377316AbhK2LN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhK2LLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:11:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E8CC08E9BA;
        Mon, 29 Nov 2021 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CpdIv33J0woQiQie2FA5j4DvYI7ANLTE3cQ274uSOLs=; b=l2HeU8pd8OX8MEvrORrtSs9Bfm
        JS8/QDQuQcqpCPw8NtwBVZ4Y5lx/jMxdkQChoyDWo8sQDQhkRtZ4f64MpzMYtibvbEjwKZlbYb8WF
        HCBrxfA7P0HKGsNtPPLdyRR53HEHh2CGztJ3qyfrdtfWzFwVLPd+VMKa6Ve902TshdXO0D/+4buAK
        Gro9f3w+TbP/PL9bvCYNIPu6P0jl10bpiBhCfF4T/zbTnzJqXQzehxIYiWe/KBJSTjVzesk0Z+Ths
        fKiM476zd599wCnwBQUIDVa33a3A9R/qsjZ49IMBarU00JI7iY0N3hCthPFix/vWH5tIwoekBmDp7
        054Fnt7g==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdo2-0073ZN-I8; Mon, 29 Nov 2021 10:22:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 28/29] iomap: build the block based code conditionally
Date:   Mon, 29 Nov 2021 11:22:02 +0100
Message-Id: <20211129102203.2243509-29-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only build the block based iomap code if CONFIG_BLOCK is set.  Currently
that is always the case, but it will change soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/Kconfig        | 4 ++--
 fs/iomap/Makefile | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index a6313a969bc5f..6d608330a096e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -15,11 +15,11 @@ config VALIDATE_FS_PARSER
 	  Enable this to perform validation of the parameter description for a
 	  filesystem when it is registered.
 
-if BLOCK
-
 config FS_IOMAP
 	bool
 
+if BLOCK
+
 source "fs/ext2/Kconfig"
 source "fs/ext4/Kconfig"
 source "fs/jbd2/Kconfig"
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 4143a3ff89dbc..fc070184b7faa 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -9,9 +9,9 @@ ccflags-y += -I $(srctree)/$(src)		# needed for trace events
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
 iomap-y				+= trace.o \
-				   buffered-io.o \
+				   iter.o
+iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
 				   direct-io.o \
 				   fiemap.o \
-				   iter.o \
 				   seek.o
 iomap-$(CONFIG_SWAP)		+= swapfile.o
-- 
2.30.2

