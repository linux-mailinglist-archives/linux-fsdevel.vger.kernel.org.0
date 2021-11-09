Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001BF44A91D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbhKIIhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244293AbhKIIgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FDCC061764;
        Tue,  9 Nov 2021 00:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5N2wtSBKEyzbs+s60mcT1q0r4L87tEtFQFzTKPXH4O4=; b=hLY1nZ/kodqvEJXK4tgo++ZHpl
        xATjxHA2n9lCQb+BE/S9F5drb7+1FcEpSUEGk7upLJ2S0sM9gsw0lNRoF+dYHObiZFOyQAhZtDc6k
        TLBcg6UF+NUa76IhBMApzd6unCBb3P1S3kd7TXu1LRWqQDrpHasqR7az9aE3QPgOS/c2BQTdcO3jd
        DkzIuMG5A0Bw0zQzDOZywtJ7aOPiBEA+MeevBvJuXHUjBsdzdKfBrkGPgEHvlrHGT5lV1wv/IVjIN
        Vwu4HAuYXN/tanPC0AZC2u8Tw0b1o3ezXFXkYvoPZ0i47ZFyprqYRyCoNAy6eVjmywqR78Ibghr1Y
        5QozPaQw==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZt-000sEe-DB; Tue, 09 Nov 2021 08:34:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 28/29] iomap: build the block based code conditionally
Date:   Tue,  9 Nov 2021 09:33:08 +0100
Message-Id: <20211109083309.584081-29-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only build the block based iomap code if CONFIG_BLOCK is set.  Currently
that is always the case, but it will change soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

