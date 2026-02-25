Return-Path: <linux-fsdevel+bounces-78405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HUfJmV5n2nScAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:36:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50419E57E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E480330FBB09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 22:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AC333BBB5;
	Wed, 25 Feb 2026 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="es/U5aFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DA33C515
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058859; cv=none; b=T/n3cDYc8lBPN259aJAiRWAlhJprjrI4El8sx9p/5IBJWZgEQgwcYTRHvGGzvTE4Zskk6/LJv9lkglP7nj6OmFRKioWzA+GKeyaYIJyjG5JY0l//g4eWu7P0LAX7q+rgJsH8ffLL6gzqOc0QT7VufUWASB2NdubCcmfjgX06LiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058859; c=relaxed/simple;
	bh=rSm9eO5Ae7qCYX7mFMqmd32iA6mbsCBNJytO0KWipNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=harUUUpijinxO5Rgg0XOVjR8+3vmZvkgkQjW3HX473cLFZnGSGcJ5xqDl5hjRXDGxkypGp9LTf1AcN9S5p8BkHAcL2A1oMUYyUXF4qTVOyBTxXEt/gS1S/EU9fuk1og33dXZgKCcKKss1AHbwbSfr5OE/ObW3M7Rwp0taY/cL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=es/U5aFj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adef9d486bso1423985ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 14:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772058857; x=1772663657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NU8CwwwJNtwj6NKE5VGHBuhoRDOVzhXUv5Gj/T+7KkI=;
        b=es/U5aFjRFMNvljq3G9LLMpLEnDW7LerIGyE7IuQbTW6aXu8uN/NyA8wdpSn4hmdtx
         OWSIKSiFqiAL7J2+oa6IjCO/pKxHtrqPkX0ccUWmyRjW7b/6BmkYDMkVoldKsWeLM/3p
         pcgDB3+AaVPNL9K6XkrGh/NsSMZU9MSr4TKrGrKL9kapLQkbmMcCjuKxNb6Ei+psazEg
         awLrG1Eou+z5Sct+u/CvNOAMuLZOh0xWViaw45ZC3xUKRUVJ7l9loEaC50adMulpGcK1
         CFxublVnJO/O2XPkQMNfLqcGyQRpjSLzKsm8av9xecvnewd1LAleGOusbcQW1oqPEzkZ
         OLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058857; x=1772663657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NU8CwwwJNtwj6NKE5VGHBuhoRDOVzhXUv5Gj/T+7KkI=;
        b=EQLpguMdzT8MuIKHkEW0L9bY0YT4HS85r/ax8uGBocg73XrEm0cgDq+FeSTpEFQ4H4
         aJR3LOh0ZWEkx6sl8cyOBfHVUC9pwZT+BEHd1hOBojO5TRssz8sBzULHveiLyFefQKMq
         UZINW664os+sNdTzrIX8/JT+r+MGfhSPwAuZRMtMfA/svTwqm13j5G/P7HBZ23s0AOQr
         ebDskEhb7c1khR2FTF+NweTd/n/3eaeCjnpwgM8HoVpc0dmvThOUGaR/4dcn7jSan7iv
         3EgPzosOiZ9M3ypbge/Mjvn1c3/IftV0UlfiB+ecjKvSR9DUkv2U0XyJmGP7vxCjC9O2
         LshA==
X-Forwarded-Encrypted: i=1; AJvYcCWZscYUaNDvxTzDUvy77sbBxdhNWvj6mvYBYy2gGsIlnl8rZGp5/yO20ycCa4YwLmP99Nd0NVAHDDI6Z6ud@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZt3KbYYZzmu4XPkUvt/F3+yifVpbAQZTLDiw+i7flQSBg3ux
	T02GIp/V0ncoj5kId6BqoQ4H74a9CSSpDlM5tpE4tuLy7qzGYUvP6GqX2WvEFBgEliBGj3XZrMm
	ZKoJmgGGoOcbp+L37Uw==
X-Received: from plrd12.prod.google.com ([2002:a17:902:aa8c:b0:2ad:9a1a:f7de])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2311:b0:2ad:b959:3de3 with SMTP id d9443c01a7336-2ade9991115mr13800735ad.19.1772058857077;
 Wed, 25 Feb 2026 14:34:17 -0800 (PST)
Date: Wed, 25 Feb 2026 14:34:03 -0800
In-Reply-To: <20260225223404.783173-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225223404.783173-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225223404.783173-3-tjmercier@google.com>
Subject: [PATCH v5 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>, syzbot@syzkaller.appspotmail.com
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-78405-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 3C50419E57E
X-Rspamd-Action: no action

Currently some kernfs files (e.g. cgroup.events, memory.events) support
inotify watches for IN_MODIFY, but unlike with regular filesystems, they
do not receive IN_DELETE_SELF or IN_IGNORED events when they are
removed. This means inotify watches persist after file deletion until
the process exits and the inotify file descriptor is cleaned up, or
until inotify_rm_watch is called manually.

This creates a problem for processes monitoring cgroups. For example, a
service monitoring memory.events for memory.high breaches needs to know
when a cgroup is removed to clean up its state. Where it's known that a
cgroup is removed when all processes die, without IN_DELETE_SELF the
service must resort to inefficient workarounds such as:
  1) Periodically scanning procfs to detect process death (wastes CPU
     and is susceptible to PID reuse).
  2) Holding a pidfd for every monitored cgroup (can exhaust file
     descriptors).

This patch enables IN_DELETE_SELF and IN_IGNORED events for kernfs files
and directories by clearing inode i_nlink values during removal. This
allows VFS to make the necessary fsnotify calls so that userspace
receives the inotify events.

As a result, applications can rely on a single existing watch on a file
of interest (e.g. memory.events) to receive notifications for both
modifications and the eventual removal of the file, as well as automatic
watch descriptor cleanup, simplifying userspace logic and improving
efficiency.

There is gap in this implementation for certain file removals due their
unique nature in kernfs. Directory removals that trigger file removals
occur through vfs_rmdir, which shrinks the dcache and emits fsnotify
events after the rmdir operation; there is no issue here. However kernfs
writes to particular files (e.g. cgroup.subtree_control) can also cause
file removal, but vfs_write does not attempt to emit fsnotify events
after the write operation, even if i_nlink counts are 0. As a usecase
for monitoring this category of file removals is not known, they are
left without having IN_DELETE or IN_DELETE_SELF events generated.
Fanotify recursive monitoring also does not work for kernfs nodes that
do not have inodes attached, as they are created on-demand in kernfs.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Tested-by: syzbot@syzkaller.appspotmail.com
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/dir.c | 54 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5b6ce2351a53..9c4eabc9c7a1 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -486,7 +486,7 @@ void kernfs_put_active(struct kernfs_node *kn)
  * removers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
  */
-static void kernfs_drain(struct kernfs_node *kn)
+static void kernfs_drain(struct kernfs_node *kn, bool drop_supers)
 	__releases(&kernfs_root(kn)->kernfs_rwsem)
 	__acquires(&kernfs_root(kn)->kernfs_rwsem)
 {
@@ -506,6 +506,8 @@ static void kernfs_drain(struct kernfs_node *kn)
 		return;
 
 	up_write(&root->kernfs_rwsem);
+	if (drop_supers)
+		up_read(&root->kernfs_supers_rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -524,6 +526,8 @@ static void kernfs_drain(struct kernfs_node *kn)
 	if (kernfs_should_drain_open_files(kn))
 		kernfs_drain_open_files(kn);
 
+	if (drop_supers)
+		down_read(&root->kernfs_supers_rwsem);
 	down_write(&root->kernfs_rwsem);
 }
 
@@ -1465,12 +1469,43 @@ void kernfs_show(struct kernfs_node *kn, bool show)
 		kn->flags |= KERNFS_HIDDEN;
 		if (kernfs_active(kn))
 			atomic_add(KN_DEACTIVATED_BIAS, &kn->active);
-		kernfs_drain(kn);
+		kernfs_drain(kn, false);
 	}
 
 	up_write(&root->kernfs_rwsem);
 }
 
+/*
+ * This function enables VFS to send fsnotify events for deletions.
+ * There is gap in this implementation for certain file removals due their
+ * unique nature in kernfs. Directory removals that trigger file removals occur
+ * through vfs_rmdir, which shrinks the dcache and emits fsnotify events after
+ * the rmdir operation; there is no issue here. However kernfs writes to
+ * particular files (e.g. cgroup.subtree_control) can also cause file removal,
+ * but vfs_write does not attempt to emit fsnotify events after the write
+ * operation, even if i_nlink counts are 0. As a usecase for monitoring this
+ * category of file removals is not known, they are left without having
+ * IN_DELETE or IN_DELETE_SELF events generated.
+ * Fanotify recursive monitoring also does not work for kernfs nodes that do not
+ * have inodes attached, as they are created on-demand in kernfs.
+ */
+static void kernfs_clear_inode_nlink(struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+	struct kernfs_super_info *info;
+
+	lockdep_assert_held_read(&root->kernfs_supers_rwsem);
+
+	list_for_each_entry(info, &root->supers, node) {
+		struct inode *inode = ilookup(info->sb, kernfs_ino(kn));
+
+		if (inode) {
+			clear_nlink(inode);
+			iput(inode);
+		}
+	}
+}
+
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos, *parent;
@@ -1479,6 +1514,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	if (!kn)
 		return;
 
+	lockdep_assert_held_read(&kernfs_root(kn)->kernfs_supers_rwsem);
 	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
 
 	/*
@@ -1512,7 +1548,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		 */
 		kernfs_get(pos);
 
-		kernfs_drain(pos);
+		kernfs_drain(pos, true);
 		parent = kernfs_parent(pos);
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
@@ -1522,9 +1558,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			struct kernfs_iattrs *ps_iattr =
 				parent ? parent->iattr : NULL;
 
-			/* update timestamps on the parent */
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
+			kernfs_clear_inode_nlink(pos);
+
+			/* update timestamps on the parent */
 			if (ps_iattr) {
 				ktime_get_real_ts64(&ps_iattr->ia_ctime);
 				ps_iattr->ia_mtime = ps_iattr->ia_ctime;
@@ -1553,9 +1591,11 @@ void kernfs_remove(struct kernfs_node *kn)
 
 	root = kernfs_root(kn);
 
+	down_read(&root->kernfs_supers_rwsem);
 	down_write(&root->kernfs_rwsem);
 	__kernfs_remove(kn);
 	up_write(&root->kernfs_rwsem);
+	up_read(&root->kernfs_supers_rwsem);
 }
 
 /**
@@ -1646,6 +1686,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	bool ret;
 	struct kernfs_root *root = kernfs_root(kn);
 
+	down_read(&root->kernfs_supers_rwsem);
 	down_write(&root->kernfs_rwsem);
 	kernfs_break_active_protection(kn);
 
@@ -1675,7 +1716,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 				break;
 
 			up_write(&root->kernfs_rwsem);
+			up_read(&root->kernfs_supers_rwsem);
 			schedule();
+			down_read(&root->kernfs_supers_rwsem);
 			down_write(&root->kernfs_rwsem);
 		}
 		finish_wait(waitq, &wait);
@@ -1690,6 +1733,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	kernfs_unbreak_active_protection(kn);
 
 	up_write(&root->kernfs_rwsem);
+	up_read(&root->kernfs_supers_rwsem);
 	return ret;
 }
 
@@ -1716,6 +1760,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 	}
 
 	root = kernfs_root(parent);
+	down_read(&root->kernfs_supers_rwsem);
 	down_write(&root->kernfs_rwsem);
 
 	kn = kernfs_find_ns(parent, name, ns);
@@ -1726,6 +1771,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 	}
 
 	up_write(&root->kernfs_rwsem);
+	up_read(&root->kernfs_supers_rwsem);
 
 	if (kn)
 		return 0;
-- 
2.53.0.414.gf7e9f6c205-goog


