Return-Path: <linux-fsdevel+bounces-9705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699CE844798
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB81C21B35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E460F405C1;
	Wed, 31 Jan 2024 18:54:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12E3EA96;
	Wed, 31 Jan 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727298; cv=none; b=YagUh+JHNe8k94F7NDoPk36aEj43tchKDVYICh4CtOpAeb0d88VQQwuyRAjPQOX0/lJjc2it1EmDJZXRnPpJUP5NsaY4bF4SSpR8oKMPizUKvdMexsGM1gGX5Z9h4EQ9QynK/t7ZEKlXJ0CcTsljZJuoKoKYILLt63MQ3RLHBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727298; c=relaxed/simple;
	bh=q343WLfpufl7W/ZraSQs5ordYtlVQ0quLjuxzkJRZAM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OMBb+6BOD7b0uHZahDt8hAJeFiXa1gLsj15ae3fo8QL/2iuPf/RMHfHAw12pFekQ+Effpf3RdYrFeFGz7uz1c5/LjweF/44wLoVs1s7PRF1AUid//N2BBWnLMrwrBwxYUk6B0e/gFKYBQfOakQRK+jj2LrfNxVA+9ecwkQq+6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D08C41606;
	Wed, 31 Jan 2024 18:54:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVFjt-000000055SJ-15QJ;
	Wed, 31 Jan 2024 13:55:13 -0500
Message-ID: <20240131185513.124644253@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 31 Jan 2024 13:49:24 -0500
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
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 6/7] eventfs: Clean up dentry ops and add revalidate function
References: <20240131184918.945345370@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

In order for the dentries to stay up-to-date with the eventfs changes,
just add a 'd_revalidate' function that checks the 'is_freed' bit.

Also, clean up the dentry release to actually use d_release() rather
than the slightly odd d_iput() function.  We don't care about the inode,
all we want to do is to get rid of the refcount to the eventfs data
added by dentry->d_fsdata.

It would probably be cleaner to make eventfs its own filesystem, or at
least set its own dentry ops when looking up eventfs files.  But as it
is, only eventfs dentries use d_fsdata, so we don't really need to split
these things up by use.

Another thing that might be worth doing is to make all eventfs lookups
mark their dentries as not worth caching.  We could do that with
d_delete(), but the DCACHE_DONTCACHE flag would likely be even better.

As it is, the dentries are all freeable, but they only tend to get freed
at memory pressure rather than more proactively.  But that's a separate
issue.

Link: https://lore.kernel.org/linux-trace-kernel/202401291043.e62e89dc-oliver.sang@intel.com/

Cc: stable@vger.kernel.org
Fixes: c1504e510238 ("eventfs: Implement eventfs dir creation functions")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Original-patch: https://lore.kernel.org/linux-trace-kernel/20240130190355.11486-6-torvalds@linux-foundation.org

 fs/tracefs/event_inode.c |  5 ++---
 fs/tracefs/inode.c       | 27 ++++++++++++++++++---------
 fs/tracefs/internal.h    |  3 ++-
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0289ec787367..0213a3375d53 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -378,13 +378,12 @@ static void free_ei(struct eventfs_inode *ei)
 }
 
 /**
- * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
- * @ti: the tracefs_inode of the dentry
+ * eventfs_d_release - dentry is going away
  * @dentry: dentry which has the reference to remove.
  *
  * Remove the association between a dentry from an eventfs_inode.
  */
-void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
+void eventfs_d_release(struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
 	int i;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5c84460feeeb..d65ffad4c327 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -377,21 +377,30 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
-static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
+/*
+ * It would be cleaner if eventfs had its own dentry ops.
+ *
+ * Note that d_revalidate is called potentially under RCU,
+ * so it can't take the eventfs mutex etc. It's fine - if
+ * we open a file just as it's marked dead, things will
+ * still work just fine, and just see the old stale case.
+ */
+static void tracefs_d_release(struct dentry *dentry)
 {
-	struct tracefs_inode *ti;
+	if (dentry->d_fsdata)
+		eventfs_d_release(dentry);
+}
 
-	if (!dentry || !inode)
-		return;
+static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct eventfs_inode *ei = dentry->d_fsdata;
 
-	ti = get_tracefs(inode);
-	if (ti && ti->flags & TRACEFS_EVENT_INODE)
-		eventfs_set_ei_status_free(ti, dentry);
-	iput(inode);
+	return !(ei && ei->is_freed);
 }
 
 static const struct dentry_operations tracefs_dentry_operations = {
-	.d_iput = tracefs_dentry_iput,
+	.d_revalidate = tracefs_d_revalidate,
+	.d_release = tracefs_d_release,
 };
 
 static int trace_fill_super(struct super_block *sb, void *data, int silent)
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 932733a2696a..4b50a0668055 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -78,6 +78,7 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
-void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
+
+void eventfs_d_release(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.43.0



