Return-Path: <linux-fsdevel+bounces-58851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E2B32188
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C54588A16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0A28B4E1;
	Fri, 22 Aug 2025 17:33:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70335948;
	Fri, 22 Aug 2025 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884002; cv=none; b=bfIwToBBsvbwxD0cLPhikJCo6cxu0TXTKPYbJU8vK+RybJRMZ60NGS7Icu5bi9je7aXa4MUb1ffsbOkifV8QFMu8jiA9p8Nbg7+5fTPmwluEZALn4Gx6DmdrbHrvwrYhCH3huQAZu2Z8ubovuJBp/K9Uvn1ZpZrSuvXQCY0wNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884002; c=relaxed/simple;
	bh=Ep+12uNxJtRBwkg/6WXOn5HwUmXIfedla1HYoJDu6sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toW7WNgSy0XR3PPRyd3yIRFtC8zY43Il/4cNkt6qrhiOs7FeoYJGwYPppd90TLFIrw61g15OocDCfge9uOLAHiHy4y/MG0EJq4fiTg+iTCv+mDbmwnwDHxOZDvLqOIL/cal3XVsQ+94WdLr5s5NygcKz/DUIK6mu9mRnOcCGp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id 9262A5A027A; Fri, 22 Aug 2025 19:23:35 +0200 (CEST)
From: Stefano Brivio <sbrivio@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	wangzijie <wangzijie1@honor.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	passt-dev@passt.top,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ye Bin <yebin10@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Rick P . Edgecombe" <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] proc: Bring back lseek() operations for /proc/net entries
Date: Fri, 22 Aug 2025 19:23:35 +0200
Message-ID: <20250822172335.3187858-1-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek
as ones for proc_read_iter et.al") breaks lseek() for all /proc/net
entries, as shown for instance by pasta(1), a user-mode network
implementation using those entries to scan for bound ports:

  $ strace -e openat,lseek -e s=none pasta -- true
  [...]
  openat(AT_FDCWD, "/proc/net/tcp", O_RDONLY|O_CLOEXEC) = 12
  openat(AT_FDCWD, "/proc/net/tcp6", O_RDONLY|O_CLOEXEC) = 13
  lseek(12, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
  lseek() failed on /proc/net file: Illegal seek
  lseek(13, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
  lseek() failed on /proc/net file: Illegal seek
  openat(AT_FDCWD, "/proc/net/udp", O_RDONLY|O_CLOEXEC) = 14
  openat(AT_FDCWD, "/proc/net/udp6", O_RDONLY|O_CLOEXEC) = 15
  lseek(14, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
  lseek() failed on /proc/net file: Illegal seek
  lseek(15, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
  lseek() failed on /proc/net file: Illegal seek
  [...]

That's because PROC_ENTRY_proc_lseek isn't set for /proc/net entries,
and it's now mandatory for lseek(). In fact, flags aren't set at all
for those entries because pde_set_flags() isn't called for them.

As commit d919b33dafb3 ("proc: faster open/read/close with "permanent"
files") introduced flags for procfs directory entries, along with the
pde_set_flags() helper, they weren't relevant for /proc/net entries,
so the lack of pde_set_flags() calls in proc_create_net_*() functions
was harmless.

Now that the calls are strictly needed for lseek() functionality,
add them.

Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 fs/proc/generic.c  | 2 +-
 fs/proc/internal.h | 1 +
 fs/proc/proc_net.c | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 76e800e38c8f..57ec5e385d1b 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -561,7 +561,7 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
-static void pde_set_flags(struct proc_dir_entry *pde)
+void pde_set_flags(struct proc_dir_entry *pde)
 {
 	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
 		pde->flags |= PROC_ENTRY_PERMANENT;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index e737401d7383..a358974f14d2 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -284,6 +284,7 @@ extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int)
 struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
 extern int proc_readdir(struct file *, struct dir_context *);
 int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
+void pde_set_flags(struct proc_dir_entry *pde);
 
 static inline void pde_get(struct proc_dir_entry *pde)
 {
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 52f0b75cbce2..20bc7481b02c 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -124,6 +124,7 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
 	p->proc_ops = &proc_net_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL_GPL(proc_create_net_data);
@@ -170,6 +171,7 @@ struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode
 	p->seq_ops = ops;
 	p->state_size = state_size;
 	p->write = write;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL_GPL(proc_create_net_data_write);
@@ -217,6 +219,7 @@ struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
 	pde_force_lookup(p);
 	p->proc_ops = &proc_net_single_ops;
 	p->single_show = show;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL_GPL(proc_create_net_single);
@@ -261,6 +264,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 	p->proc_ops = &proc_net_single_ops;
 	p->single_show = show;
 	p->write = write;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL_GPL(proc_create_net_single_write);
-- 
2.43.0


