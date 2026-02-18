Return-Path: <linux-fsdevel+bounces-77492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKtlINUwlWmeMwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:24:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8EB152D70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6971D306222A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 03:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117842EC0AA;
	Wed, 18 Feb 2026 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXmWz36H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F62EBBB3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771384977; cv=none; b=KZk2gdHiPO3EhOg3T09FsI+4tok1F7a+GB2zfVjUgQFnrcHhpRXX/zsG7P5yLyzT4pY0+vIpqyijO5l2oXSyZ0J+dfcfj0+lzB0LhdR8djr6M6pxaBQnh1JlDxPzC75VSl+gRETBohdzqvra0y9Eqc/NKPyBTGP8gAVioo5d9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771384977; c=relaxed/simple;
	bh=E5jwkj734pizptjz+7tZbtEgw4+EqYGDhoDFZuTbg3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pluQTvYpajzuJTiikCuUfTKoKm0ZeLDZaxNuX1fTfnevvEGvRKAKbXPMowb/Gds0HZFcxBdM3OanNW3yx9EmK6KrB4daxixkgO7+sih88qN5biKMx925nrBw6WdSuYz3n6QAw4qnVASLFfmbznQLA44G6kQniH8b6GcqFU1JkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LXmWz36H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3568090851aso22575808a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 19:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771384975; x=1771989775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBIv4Kjul+M1r0tdQ268vYu5sNrxPVO9X/dnp6afltc=;
        b=LXmWz36HuaGSNsBkp6fGmHQhmaZ1esi1rfaMJwuEtht45TmjvQ3zpTV+4BejFCiE+P
         kjKltJKl5rV+0SJfjaPsGu6RLZOih+1vGhvX8h+glPZQ4fw0lozYiJx+j9TYzjcvMwec
         tSvsDEJQN/6eWoBiHOayTDFLelmk2x+G1Zu665Uk8AlUsLayB4SMPol7gwwwreVZbmdI
         8XLrtXt41QKIctzxmuIKnA5JpY08bIuubx7/KR6dRTsMa0jeGIx9x1Pc4BHUCOc1dDFm
         +l0hBEeY0Vp0KjDyf6OBbyAjK+l5CAgILGAfGRxUWhCJIbyOFWRYAg21zngdaYhWgAWa
         kJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771384975; x=1771989775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBIv4Kjul+M1r0tdQ268vYu5sNrxPVO9X/dnp6afltc=;
        b=snSZts95y14nLQli6GeI87xrsu4/SzImmYArnluW/CEdWZTwuAd/GeFW3Fvh0JcCx4
         PxsF5HwGW1oh0tD4FW6R3IsNdmBvEffH63ZIdOt9vZFvPfZny2rsTcaMUrbJf8J4JYjy
         oJb1FJQBffJ7AnQ0MMvhIB9MTMzWPg9THweJQSl0wkk3p6Ckd00PDVP4zHJBc/nkDOya
         86EJnw+XoQmp47xeuieBJbyMURAMXdKD0YfhTOwYbz2PnE+NX3WP3tS5QT4aIZkh+Lyt
         XfxhfhL8NkB2ynCwny9qvWKFH5BQhOXJIsAhSYLXSZhQminUAZj/XQmoWdKFd6cjPWNo
         u+WA==
X-Forwarded-Encrypted: i=1; AJvYcCVA0XLPTmX+9EGb7WmX3v7kel5luQCxh7cQ/DODF+qThbqSyBut+RDQAdZC0gsHdiMeegqeAeWVViYYbMxC@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGqJHM0uwA80pkqsrOkbKM8R/ytRvCNLZGUlznPeKHyTHguVU
	PNU9jJfcQg+GGfw+lRcNHtZ4sS7XWWWvYKqW3qd6ZKouyAN8Ztm7J7EzE6kYnNYq6m9b1Fp6hzM
	HuWDIAcaiw1VdXK/xGQ==
X-Received: from pjbls16.prod.google.com ([2002:a17:90b:3510:b0:354:c082:9b93])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:144f:b0:366:14ac:e1df with SMTP id adf61e73a8af0-39483aa8f59mr12907868637.69.1771384975197;
 Tue, 17 Feb 2026 19:22:55 -0800 (PST)
Date: Tue, 17 Feb 2026 19:22:31 -0800
In-Reply-To: <20260218032232.4049467-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260218032232.4049467-3-tjmercier@google.com>
Subject: [PATCH v3 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77492-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,memory.events:url]
X-Rspamd-Queue-Id: DD8EB152D70
X-Rspamd-Action: no action

Currently some kernfs files (e.g. cgroup.events, memory.events) support
inotify watches for IN_MODIFY, but unlike with regular filesystems, they
do not receive IN_DELETE_SELF or IN_IGNORED events when they are
removed.

This creates a problem for processes monitoring cgroups. For example, a
service monitoring memory.events for memory.high breaches needs to know
when a cgroup is removed to clean up its state. Where it's known that a
cgroup is removed when all processes die, without IN_DELETE_SELF the
service must resort to inefficient workarounds such as:
1.  Periodically scanning procfs to detect process death (wastes CPU and
    is susceptible to PID reuse).
2.  Placing an additional IN_DELETE watch on the parent directory
    (wastes resources managing double the watches).
3.  Holding a pidfd for every monitored cgroup (can exhaust file
    descriptors).

This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED events.
This allows applications to rely on a single existing watch on the file
of interest (e.g. memory.events) to receive notifications for both
modifications and the eventual removal of the file, as well as automatic
watch descriptor cleanup, simplifying userspace logic and improving
resource efficiency.

Implementation details:
The kernfs notification worker is updated to handle file deletion.
The optimized single call for MODIFY events to both the parent and the
file is retained, however because CREATE (parent) events remain
unsupported for kernfs files, support for DELETE (parent) events is not
added here to retain symmetry. Only support for DELETE_SELF events is
added.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/dir.c             | 21 +++++++++++++++++
 fs/kernfs/file.c            | 45 ++++++++++++++++++++-----------------
 fs/kernfs/kernfs-internal.h |  3 +++
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 29baeeb97871..e5bda829fcb8 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -9,6 +9,7 @@
 
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/fsnotify_backend.h>
 #include <linux/namei.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
@@ -1471,6 +1472,23 @@ void kernfs_show(struct kernfs_node *kn, bool show)
 	up_write(&root->kernfs_rwsem);
 }
 
+static void kernfs_notify_file_deleted(struct kernfs_node *kn)
+{
+	static DECLARE_WORK(kernfs_notify_deleted_work,
+			    kernfs_notify_workfn);
+
+	guard(spinlock_irqsave)(&kernfs_notify_lock);
+	/* may overwite already pending FS_MODIFY events */
+	kn->attr.notify_event = FS_DELETE;
+
+	if (!kn->attr.notify_next) {
+		kernfs_get(kn);
+		kn->attr.notify_next = kernfs_notify_list;
+		kernfs_notify_list = kn;
+		schedule_work(&kernfs_notify_deleted_work);
+	}
+}
+
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos, *parent;
@@ -1520,6 +1538,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			struct kernfs_iattrs *ps_iattr =
 				parent ? parent->iattr : NULL;
 
+			if (kernfs_type(pos) == KERNFS_FILE)
+				kernfs_notify_file_deleted(pos);
+
 			/* update timestamps on the parent */
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e978284ff983..4be9bbe29378 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -37,8 +37,8 @@ struct kernfs_open_node {
  */
 #define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
 
-static DEFINE_SPINLOCK(kernfs_notify_lock);
-static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
+DEFINE_SPINLOCK(kernfs_notify_lock);
+struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
 
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
@@ -909,7 +909,7 @@ static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
 	return ret;
 }
 
-static void kernfs_notify_workfn(struct work_struct *work)
+void kernfs_notify_workfn(struct work_struct *work)
 {
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
@@ -935,11 +935,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	down_read(&root->kernfs_supers_rwsem);
 	down_read(&root->kernfs_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
-		struct kernfs_node *parent;
-		struct inode *p_inode = NULL;
-		const char *kn_name;
 		struct inode *inode;
-		struct qstr name;
 
 		/*
 		 * We want fsnotify_modify() on @kn but as the
@@ -951,24 +947,31 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (!inode)
 			continue;
 
-		kn_name = kernfs_rcu_name(kn);
-		name = QSTR(kn_name);
-		parent = kernfs_get_parent(kn);
-		if (parent) {
-			p_inode = ilookup(info->sb, kernfs_ino(parent));
-			if (p_inode) {
-				fsnotify(notify_event | FS_EVENT_ON_CHILD,
-					 inode, FSNOTIFY_EVENT_INODE,
-					 p_inode, &name, inode, 0);
-				iput(p_inode);
+		if (notify_event == FS_DELETE) {
+			fsnotify_inoderemove(inode);
+		} else {
+			struct kernfs_node *parent = kernfs_get_parent(kn);
+			struct inode *p_inode = NULL;
+
+			if (parent) {
+				p_inode = ilookup(info->sb, kernfs_ino(parent));
+				if (p_inode) {
+					const char *kn_name = kernfs_rcu_name(kn);
+					struct qstr name = QSTR(kn_name);
+
+					fsnotify(notify_event | FS_EVENT_ON_CHILD,
+						 inode, FSNOTIFY_EVENT_INODE,
+						 p_inode, &name, inode, 0);
+					iput(p_inode);
+				}
+
+				kernfs_put(parent);
 			}
 
-			kernfs_put(parent);
+			if (!p_inode)
+				fsnotify_inode(inode, notify_event);
 		}
 
-		if (!p_inode)
-			fsnotify_inode(inode, notify_event);
-
 		iput(inode);
 	}
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 6061b6f70d2a..cf4b21f4f3b6 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -199,6 +199,8 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
  * file.c
  */
 extern const struct file_operations kernfs_file_fops;
+extern struct kernfs_node *kernfs_notify_list;
+extern void kernfs_notify_workfn(struct work_struct *work);
 
 bool kernfs_should_drain_open_files(struct kernfs_node *kn);
 void kernfs_drain_open_files(struct kernfs_node *kn);
@@ -212,4 +214,5 @@ extern const struct inode_operations kernfs_symlink_iops;
  * kernfs locks
  */
 extern struct kernfs_global_locks *kernfs_locks;
+extern spinlock_t kernfs_notify_lock;
 #endif	/* __KERNFS_INTERNAL_H */
-- 
2.53.0.310.g728cabbaf7-goog


