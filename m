Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0E461399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377318AbhK2LNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhK2LLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:11:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB544C08E9BB;
        Mon, 29 Nov 2021 02:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Uz5Lg9VfLJD3I0hYm9puMXvJxrIX6Nb7rdZ5ItT8lkU=; b=dRs0CbQLL5JDushgx3p30SscdV
        SzcgxX8giadEKFgDO9L0d/L7N0Gx4MHKRHjkcBCXa/OK/zGSK9MQ5zw3+hahgxEuDbIsfVUGDfjpg
        5PLKF3ZweGAabGbimeK03wT25Qfflu/PFI/bH1UCQJpA2qKtvwICMvEQX70DjR88QDj5+Ylx5DUeA
        AuJWsAxaXqLjN01rVYBkA/BLChMw3LKN7osfUWW7Un1/PuObbGFNv87DuXxkEMg7yrEjntAgPa3Dl
        Na9Nd4ru0hm2NQwUxjG0pEH+Tf3zGR41CePK0rcoL1arJX8BFFWtiaNqBj52iTFx2qpqI6hxqIN4y
        zld5QI0Q==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdo4-0073aO-0q; Mon, 29 Nov 2021 10:22:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 29/29] fsdax: don't require CONFIG_BLOCK
Date:   Mon, 29 Nov 2021 11:22:03 +0100
Message-Id: <20211129102203.2243509-30-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file system DAX code now does not require the block code.  So allow
building a kernel with fuse DAX but not block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 6d608330a096e..7a2b11c0b8036 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -42,6 +42,8 @@ source "fs/nilfs2/Kconfig"
 source "fs/f2fs/Kconfig"
 source "fs/zonefs/Kconfig"
 
+endif # BLOCK
+
 config FS_DAX
 	bool "File system based Direct Access (DAX) support"
 	depends on MMU
@@ -89,8 +91,6 @@ config FS_DAX_PMD
 config FS_DAX_LIMITED
 	bool
 
-endif # BLOCK
-
 # Posix ACL utility routines
 #
 # Note: Posix ACLs can be implemented without these helpers.  Never use
-- 
2.30.2

