Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD155300A79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 19:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbhAVR5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729466AbhAVRwD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:52:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7486723A9C;
        Fri, 22 Jan 2021 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611337883;
        bh=x1lJQGM04EP7vdDpOg3XZRh7p/S7qixcDsgKzeM7VHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgeYi17BYaz72pJfJRzXo5B8FqtZCB7ZgIWCKtkxGYlhLd4ecVOMeSpzWpQov/w7Q
         2g5dp/aQ1Q3YXFu0mRH6SaSqo5/hVN5LY21FCbTJbT7lWWPco8GRYp2dYAtqiNMgS5
         r3vP4aivhAT59DjBigNLlSPz9DYrhe+szb8xHs83tKQ6/cboaeNPChs3LuVf4WrE0K
         oTe9+2nW97R614lf9C71NBjcori4PijInVwyXZd4sYKUXyTWtLs2b16dQgAW22u7Om
         2XZfA0OTD2XTqyd1515vuUxGX4KiXwMyHrLpbiF9QoSyDTw6rSwTQX5PLu44Y8PtXe
         xvIWzKp3r95OQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        willy@infradead.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/6] ceph: rework PageFsCache handling
Date:   Fri, 22 Jan 2021 12:51:14 -0500
Message-Id: <20210122175119.364381-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122175119.364381-1-jlayton@kernel.org>
References: <20210122175119.364381-1-jlayton@kernel.org>
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
 fs/ceph/addr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e267aa60c8b6..f554667e1e91 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -166,13 +166,19 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	ceph_put_snap_context(snapc);
 	page->private = 0;
 	ClearPagePrivate(page);
+	wait_on_page_fscache(page);
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

