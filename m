Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA29303EFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 14:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404603AbhAZNlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 08:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392686AbhAZNlr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:41:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85D7122B3B;
        Tue, 26 Jan 2021 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611668467;
        bh=I/J1E95+y7XfRKunDTb5TO1y21yMpB/0pHrt99FpeOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2nWoYyVrke+3PdywVnD3x7SIczXebDZaktsoTGGmvXM6qqxOQdNu+88dBA7Il2ED
         n074JLNaYC99L3EAfo6RtNh7KOTY+RCbiN1LEpwi23dDA2ClhLKli4JXdaZmrMnny1
         swQCRAstD2hDNkGz/1asjqG7ENeZx9xBDymqMHeo8z3TdgNUNEBj5xCcLhdNOePqrl
         hc1v8Awto+7FrUvuZWZjAGOys8mkLE8DkJg6IK/bA+Z2Sz1wsoEfQKa0IKkh1ixw2U
         xf0Lr3+7xveekNz5F1ItGsKSUvzomLZ4Xrwd5acAhCgBzGR4NgjCAV+zbA/b7oaD4p
         g1/EMbIkJ/n2A==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com, dhowells@redhat.com
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH 2/6] ceph: rework PageFsCache handling
Date:   Tue, 26 Jan 2021 08:40:59 -0500
Message-Id: <20210126134103.240031-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126134103.240031-1-jlayton@kernel.org>
References: <20210126134103.240031-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2b17bb36e548..fbfa49db06fd 100644
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
+static int ceph_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
 	     page, page->index, PageDirty(page) ? "" : "not ");
 
+	if (PageFsCache(page)) {
+		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
+			return 0;
+		wait_on_page_fscache(page);
+	}
 	return !PagePrivate(page);
 }
 
-- 
2.29.2

