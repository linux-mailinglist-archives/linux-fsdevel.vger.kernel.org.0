Return-Path: <linux-fsdevel+bounces-9892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F6845CF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D99D1F226D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FB160880;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644215D5BA;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804160; cv=none; b=heVmmP/6C9SBqCb80Pg/Z1w+PiGGEXU1lL4b98+XT17nYK3FsrFAWnfUuz56Wm+A+8qQUpXbWlkGmXzn2ii87MzFjlaQ9+bWqu3U/1qcneBziwSORDpUWJuqUnf7Vjw8q2eHTvdzro8QQobYGeznIA2BHqiBPPS22KlOWG23UOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804160; c=relaxed/simple;
	bh=NPnmMMbyV1baHC4KsmvnpUoEetauizgbbY4RJQJGnHo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BQtIFSYrl41JnnQOktQ5i+WhHxsxYXj9f3WNqg0tje7Ki6kBi+KeyS3bsN1inE4W0hBkBU8n2JNkmqQnSZuOu5SU0tBXPGMIdVOxum4v14vEZtMjGoU0nSDMPfnyaJZ44tBaSAxDeNlUn6wgSC6m/0aJkXZUSAOwQPkwm1mVFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3886C433A6;
	Thu,  1 Feb 2024 16:15:59 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVZjc-00000005Tik-47ok;
	Thu, 01 Feb 2024 11:16:16 -0500
Message-ID: <20240201161616.843551963@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 10:34:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [PATCH 1/6] eventfs: Warn if an eventfs_inode is freed without is_freed being set
References: <20240201153446.138990674@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There should never be a case where an evenfs_inode is being freed without
is_freed being set. Add a WARN_ON_ONCE() if it ever happens. That would
mean there was one too many put_ei()s.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 515fdace1eea..ca7daee7c811 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -73,6 +73,9 @@ enum {
 static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
+
+	WARN_ON_ONCE(!ei->is_freed);
+
 	kfree(ei->entry_attrs);
 	kfree_const(ei->name);
 	kfree_rcu(ei, rcu);
@@ -84,6 +87,14 @@ static inline void put_ei(struct eventfs_inode *ei)
 		kref_put(&ei->kref, release_ei);
 }
 
+static inline void free_ei(struct eventfs_inode *ei)
+{
+	if (ei) {
+		ei->is_freed = 1;
+		put_ei(ei);
+	}
+}
+
 static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
 {
 	if (ei)
@@ -679,7 +690,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-		put_ei(ei);
+		free_ei(ei);
 		ei = NULL;
 	}
 	return ei;
@@ -770,7 +781,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ei;
 
  fail:
-	put_ei(ei);
+	free_ei(ei);
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
@@ -801,9 +812,8 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 	list_for_each_entry(ei_child, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
 
-	ei->is_freed = 1;
 	list_del(&ei->list);
-	put_ei(ei);
+	free_ei(ei);
 }
 
 /**
-- 
2.43.0



