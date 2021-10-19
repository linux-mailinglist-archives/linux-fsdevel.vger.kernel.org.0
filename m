Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C9432AE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhJSAGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhJSAGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:06:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FDAC06161C;
        Mon, 18 Oct 2021 17:03:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4A0671F41857;
        Tue, 19 Oct 2021 01:03:58 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 26/32] fanotify: WARN_ON against too large file handles
Date:   Mon, 18 Oct 2021 21:00:09 -0300
Message-Id: <20211019000015.1666608-27-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

struct fanotify_error_event, at least, is preallocated and isn't able to
to handle arbitrarily large file handles.  Future-proof the code by
complaining loudly if a handle larger than MAX_HANDLE_SZ is ever found.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index cedcb1546804..45df610debbe 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -360,13 +360,23 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 static int fanotify_encode_fh_len(struct inode *inode)
 {
 	int dwords = 0;
+	int fh_len;
 
 	if (!inode)
 		return 0;
 
 	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
+	fh_len = dwords << 2;
 
-	return dwords << 2;
+	/*
+	 * struct fanotify_error_event might be preallocated and is
+	 * limited to MAX_HANDLE_SZ.  This should never happen, but
+	 * safeguard by forcing an invalid file handle.
+	 */
+	if (WARN_ON_ONCE(fh_len > MAX_HANDLE_SZ))
+		return 0;
+
+	return fh_len;
 }
 
 /*
-- 
2.33.0

