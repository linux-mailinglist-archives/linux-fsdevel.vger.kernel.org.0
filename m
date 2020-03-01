Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD917503F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCAVyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:54:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41662 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgCAVwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVx-003fOi-ES; Sun, 01 Mar 2020 21:52:45 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 31/55] atomic_open(): return the right dentry in FMODE_OPENED case
Date:   Sun,  1 Mar 2020 21:52:16 +0000
Message-Id: <20200301215240.873899-31-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
References: <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

->atomic_open() might have used a different alias than the one we'd
passed to it; in "not opened" case we take care of that, in "opened"
one we don't.  Currently we don't care downstream of "opened" case
which alias to return; however, that will change shortly when we
get to unifying may_open() calls.

It's not hard to get right in all cases, anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 56d39a8cfc3e..bfd62fa3856c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2952,11 +2952,15 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
+			int acc_mode = op->acc_mode;
+			if (unlikely(dentry != file->f_path.dentry)) {
+				dput(dentry);
+				dentry = dget(file->f_path.dentry);
+			}
 			/*
 			 * We didn't have the inode before the open, so check open
 			 * permission here.
 			 */
-			int acc_mode = op->acc_mode;
 			if (file->f_mode & FMODE_CREATED) {
 				WARN_ON(!(open_flag & O_CREAT));
 				fsnotify_create(dir, dentry);
-- 
2.11.0

