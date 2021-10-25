Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57743A0D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhJYTfj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:35:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58724 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhJYTdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:33:05 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C4F431F4316F;
        Mon, 25 Oct 2021 20:30:41 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 25/31] fanotify: WARN_ON against too large file handles
Date:   Mon, 25 Oct 2021 16:27:40 -0300
Message-Id: <20211025192746.66445-26-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

struct fanotify_error_event, at least, is preallocated and isn't able to
to handle arbitrarily large file handles.  Future-proof the code by
complaining loudly if a handle larger than MAX_HANDLE_SZ is ever found.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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

