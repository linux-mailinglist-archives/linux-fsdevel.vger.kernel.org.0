Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B289C198918
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 02:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgCaAyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 20:54:37 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:54880
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729358AbgCaAyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:54:37 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DKBAA4lIJe/+im0XZgBh4BCxyBcAu?=
 =?us-ascii?q?CKYFAIRIqhBqPTgEBAQMGgRKKIIUUhRWFKRSBZwoBAQEBAQEBAQEbGQECBAE?=
 =?us-ascii?q?BhEQCgjIkNgcOAhABAQEFAQEBAQEFAwFthQpYhXEGIwRSEBgNAhgOAgJHEAY?=
 =?us-ascii?q?ThX4krXh/MxoCiimBDiqMMRp5gQeBRAOBNoFmhDQKgyKCXgSNc4MDhw9FgQC?=
 =?us-ascii?q?XG4JGlxUdj0IDjCctpnGFfwQugVhNLgqDJ1AYnH83MIEGAQGNJl8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2DKBAA4lIJe/+im0XZgBh4BCxyBcAuCKYFAIRIqhBqPT?=
 =?us-ascii?q?gEBAQMGgRKKIIUUhRWFKRSBZwoBAQEBAQEBAQEbGQECBAEBhEQCgjIkNgcOA?=
 =?us-ascii?q?hABAQEFAQEBAQEFAwFthQpYhXEGIwRSEBgNAhgOAgJHEAYThX4krXh/MxoCi?=
 =?us-ascii?q?imBDiqMMRp5gQeBRAOBNoFmhDQKgyKCXgSNc4MDhw9FgQCXG4JGlxUdj0IDj?=
 =?us-ascii?q?CctpnGFfwQugVhNLgqDJ1AYnH83MIEGAQGNJl8BAQ?=
X-IronPort-AV: E=Sophos;i="5.72,326,1580745600"; 
   d="scan'208";a="238809243"
Received: from unknown (HELO mickey.themaw.net) ([118.209.166.232])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 31 Mar 2020 08:54:31 +0800
Subject: [PATCH v2 4/4] autofs: add comment about autofs_mountpoint_changed()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Mar 2020 08:54:31 +0800
Message-ID: <158561607160.23197.3228166849408166685.stgit@mickey.themaw.net>
In-Reply-To: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
References: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
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

