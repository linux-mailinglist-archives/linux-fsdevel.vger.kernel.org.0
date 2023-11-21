Return-Path: <linux-fsdevel+bounces-3342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49B7F3A15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 00:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42681F23039
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 23:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B458121;
	Tue, 21 Nov 2023 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BB38DEA;
	Tue, 21 Nov 2023 23:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58720C433C9;
	Tue, 21 Nov 2023 23:10:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
	(envelope-from <rostedt@goodmis.org>)
	id 1r5Ztg-00000002dDc-27wd;
	Tue, 21 Nov 2023 18:11:12 -0500
Message-ID: <20231121231112.373501894@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 21 Nov 2023 18:10:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/4] eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held
References: <20231121231003.516999942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If memory reclaim happens, it can reclaim file system pages. The file
system pages from eventfs may take the eventfs_mutex on reclaim. This
means that allocation while holding the eventfs_mutex must not call into
filesystem reclaim. A lockdep splat uncovered this.

Fixes: 28e12c09f5aa0 ("eventfs: Save ownership and mode")
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 3eb6c622a74d..56d192f0ead8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -95,7 +95,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
 		if (!ei->entry_attrs) {
 			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
-						  GFP_KERNEL);
+						  GFP_NOFS);
 			if (!ei->entry_attrs) {
 				ret = -ENOMEM;
 				goto out;
@@ -627,7 +627,7 @@ static int add_dentries(struct dentry ***dentries, struct dentry *d, int cnt)
 {
 	struct dentry **tmp;
 
-	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_KERNEL);
+	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_NOFS);
 	if (!tmp)
 		return -1;
 	tmp[cnt] = d;
-- 
2.42.0



