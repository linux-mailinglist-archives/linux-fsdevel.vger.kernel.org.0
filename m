Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45151987CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 01:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgC3XH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 19:07:29 -0400
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:28035
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729024AbgC3XH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:07:27 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2COHgD7eoJe/+im0XZgBh4BCxyBcAs?=
 =?us-ascii?q?CgieBYRIqg1JIj08BAQEBAQEGgRI4iWiFFIUVhSkUgWcKAQEBAQEBAQEBGxk?=
 =?us-ascii?q?BAgQBAYREAoIyJDYHDgIQAQEBBQEBAQEBBQMBbYUKWEIBDAGFIQYjBFIQGA0?=
 =?us-ascii?q?CGA4CAkcQBhOFfiSuGH8zGgKKL4EOKgGMMBp5gQeBRAOBNoFmhDQKgyKCXgS?=
 =?us-ascii?q?Nc4MDhw9FgQCXG4JGlxUdj0IDjCctpnGFfwQugVhNLgqDJ1AYnH83MIEGAQG?=
 =?us-ascii?q?ENYkrXwEB?=
X-IPAS-Result: =?us-ascii?q?A2COHgD7eoJe/+im0XZgBh4BCxyBcAsCgieBYRIqg1JIj?=
 =?us-ascii?q?08BAQEBAQEGgRI4iWiFFIUVhSkUgWcKAQEBAQEBAQEBGxkBAgQBAYREAoIyJ?=
 =?us-ascii?q?DYHDgIQAQEBBQEBAQEBBQMBbYUKWEIBDAGFIQYjBFIQGA0CGA4CAkcQBhOFf?=
 =?us-ascii?q?iSuGH8zGgKKL4EOKgGMMBp5gQeBRAOBNoFmhDQKgyKCXgSNc4MDhw9FgQCXG?=
 =?us-ascii?q?4JGlxUdj0IDjCctpnGFfwQugVhNLgqDJ1AYnH83MIEGAQGENYkrXwEB?=
X-IronPort-AV: E=Sophos;i="5.72,326,1580745600"; 
   d="scan'208";a="233609863"
Received: from unknown (HELO mickey.themaw.net) ([118.209.166.232])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 31 Mar 2020 07:07:10 +0800
Subject: [PATCH 4/4] autofs: add comment about autofs_mountpoint_changed()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Mar 2020 07:07:07 +0800
Message-ID: <158560962791.14841.11556262088621555043.stgit@mickey.themaw.net>
In-Reply-To: <158560961146.14841.14430383874338917674.stgit@mickey.themaw.net>
References: <158560961146.14841.14430383874338917674.stgit@mickey.themaw.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function autofs_mountpoint_changed() is unusual, add a comment
about two cases for which it is used.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/root.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index b3f748e4df08..5efb7fa1ce2b 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -280,9 +280,24 @@ static struct dentry *autofs_mountpoint_changed(struct path *path)
 	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
 
-	/*
-	 * If this is an indirect mount the dentry could have gone away
-	 * as a result of an expire and a new one created.
+	/* If this is an indirect mount the dentry could have gone away
+	 * and a new one created.
+	 *
+	 * This is unusual and I can't remember the case for which it
+	 * was originally added now. But an example of how this can
+	 * happen is an autofs indirect mount that has the "browse"
+	 * option set and also has the "symlink" option in the autofs
+	 * map entry. In this case the daemon will remove the browse
+	 * directory and create a symlink as the mount (pointing to a
+	 * local path) leaving the struct path stale.
+	 *
+	 * Another not so obvious case is when a mount in an autofs
+	 * indirect mount that uses the "nobrowse" option is being
+	 * expired and the mount has been umounted but the mount point
+	 * directory remains when a stat family system call is made.
+	 * In this case the mount point is removed (by the daemon) and
+	 * a new mount triggered leading to a stale dentry in the struct
+	 * path of the waiting process.
 	 */
 	if (autofs_type_indirect(sbi->type) && d_unhashed(dentry)) {
 		struct dentry *parent = dentry->d_parent;

