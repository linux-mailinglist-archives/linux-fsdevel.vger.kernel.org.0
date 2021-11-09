Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD6744A91F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhKIIhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244215AbhKIIgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4602EC061767;
        Tue,  9 Nov 2021 00:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Sy1y0UiMgxAYvlwmHMq+D5FA8YC6nzMpWW5stnnL7mE=; b=gpT3QABXYlkVO9cfQiVD4lTzsW
        wpEmY4Z/eRxbkXYSg+JxoHSV++jJ3mKJHMfrn55KL2mcGq383JeE2GT0n04CgdH5G/vt20HeQQaO9
        ha8NRcqJ+6vlyLr/9gPdQntTqO6D0qCC+EcTk3/BEguhqZKKy15SmdCTvO76lOOWte1YinTMjYCfi
        /KdwmZypZoj4wrR5V//D1uQ5lhEQb0sJEsg0xrWwJmOJ7q4ZVu8d8geqMTHzf2XXvKP3vPNMuL8Pr
        VipJXXXtONrtI41oW3trXzSqrHSuGOwLqYKEYfzEe5AM49EB/C47xpIkPi9qt5n1Z11n3latDwOG8
        X+sUDJ5Q==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZu-000sFi-W7; Tue, 09 Nov 2021 08:34:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 29/29] fsdax: don't require CONFIG_BLOCK
Date:   Tue,  9 Nov 2021 09:33:09 +0100
Message-Id: <20211109083309.584081-30-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file system DAX code now does not require the block code.  So allow
building a kernel with fuse DAX but not block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

