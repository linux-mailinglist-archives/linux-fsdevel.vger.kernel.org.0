Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0A322B2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhBWNHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 08:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232604AbhBWNHO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:07:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5767164E2E;
        Tue, 23 Feb 2021 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614085594;
        bh=qgIZbiFmFiCklL4YAeuOm1DOj1XlagRerb2FPqRmlqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fA/RoKNugLi5VEuLMZ18K0khOVA7LZzUouPZDNKEKcgKhtNMEc1AMhO3TY9o0x/Q/
         lYa/xhPzwMS2md4y7FwwbTMzcZiavz/0Bef4aWwapToQXrEmc4+JSLK8Nrb/d8I8Tl
         DSk8NliLpSx0E10GeAzddrKugBo3DVHTMj0z2YBXZ76JsM5hrK9iFc0smzo6ERW/pB
         J5/hLMysRISg5v5czXL140fJSj1wkj3mkSqUEYHoZjj8AUDdigUFKNipWCVm0T4+fn
         4Ng7knD+n+sRQcFCDspQKuwpd5BB8WxhlgQW++h+Sm46pigJN1agVlcocjdLEhfLml
         ghiXxOp1/QgwQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, xiubli@redhat.com, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v3 2/6] ceph: rework PageFsCache handling
Date:   Tue, 23 Feb 2021 08:06:25 -0500
Message-Id: <20210223130629.249546-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223130629.249546-1-jlayton@kernel.org>
References: <20210223130629.249546-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the new fscache API, the PageFsCache bit now indicates that the
page is being written to the cache and shouldn't be modified or released
until it's finished.

Change releasepage and invalidatepage to wait on that bit before
returning.

Also define FSCACHE_USE_NEW_IO_API so that we opt into the new fscache
API.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
Cc: linux-cachefs@redhat.com
Cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/addr.c  | 9 ++++++++-
 fs/ceph/super.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e267aa60c8b6..3936ae3e8dcd 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -146,6 +146,8 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc = page_snap_context(page);
 
+	wait_on_page_fscache(page);
+
 	inode = page->mapping->host;
 	ci = ceph_inode(inode);
 
@@ -168,11 +170,16 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	ClearPagePrivate(page);
 }
 
-static int ceph_releasepage(struct page *page, gfp_t g)
+static int ceph_releasepage(struct page *page, gfp_t gfp)
 {
 	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
 	     page, page->index, PageDirty(page) ? "" : "not ");
 
+	if (PageFsCache(page)) {
+		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
+			return 0;
+		wait_on_page_fscache(page);
+	}
 	return !PagePrivate(page);
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 060c93df9b93..2f7e769290c4 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -21,6 +21,7 @@
 #include <linux/ceph/libceph.h>
 
 #ifdef CONFIG_CEPH_FSCACHE
+#define FSCACHE_USE_NEW_IO_API
 #include <linux/fscache.h>
 #endif
 
-- 
2.29.2

