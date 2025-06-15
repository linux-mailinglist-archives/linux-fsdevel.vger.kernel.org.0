Return-Path: <linux-fsdevel+bounces-51695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2407FADA47A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E397188EC85
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 23:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83317262800;
	Sun, 15 Jun 2025 23:00:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411221348;
	Sun, 15 Jun 2025 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750028452; cv=none; b=UdNf5E8Euz07jvgWx+9E4I0dztLBda9YaEasyxU6jGJQlR+EbcvxGmSwedAz2YbQ8Az2kitmfGM4ncuFjhXMawkvmbtHPp+o/ZBCez4txT4vBDZmVb4Rk8pCAQCzAsTZ1gYGIAL+lU3k/4e8ql2DTSChK0MyFnvxGmYhA2efYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750028452; c=relaxed/simple;
	bh=0+Eq7imDVhtyA4ah3U8MoUmMelbIy7qZo1J48iHgxsk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=L0VHgpDiAfG7/CfItREJ9GrwQY3Pnhfwqc744Zx1VpNZddtPlh/Q3iPkZGjG+r1BpbG0kbSriPCHT2jNvYDcUy6W4vqRfVOyY3+9TFgG5nXRTATYyZ1saaWgZpgbJ2MTugfbZCYWl6+FsXFWrDQr+vQtI8UZQ+1i8T/QMI2Ma4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uQwLA-00FKsE-U4;
	Sun, 15 Jun 2025 23:00:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>,
 Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v3?] proc_sysctl: remove rcu_dereference() for accessing ->sysctl
Date: Mon, 16 Jun 2025 09:00:39 +1000
Message-id: <175002843966.608730.14640390628578526912@noble.neil.brown.name>


The rcu_dereference() call in proc_sys_compare() is problematic as
->d_compare is not guaranteed to be called with rcu_read_lock() held and
rcu_dereference() can cause a warning when used without that lock.

Specifically d_alloc_parallel() will call ->d_compare() without
rcu_read_lock(), but with ->d_lock to ensure stability.  In this case
->d_inode is usually NULL so the rcu_dereference() will normally not be
reached, but it is possible that ->d_inode was set while waiting for
->d_lock which could lead to the warning.

The rcu_dereference() isn't really needed - ->sysctl isn't used in a
pattern which normally requires RCU protection.  In particular it is
never updated.  It is assigned a value in proc_sys_make_inode() before
the inode is generally visible, and the value is freed (using
rcu_free()) only after any possible access to the inode must have
completed.

Even though the value stored at ->sysctl is not freed, the ->sysctl
pointer itself is set to NULL in proc_evict_inode().  This necessitates
proc_sys_compare() taking care, reading the pointer with READ_ONCE()
(currently via rcu_dereference()) and checking for NULL.  If we drop the
assignment to NULL, this care becomes unnecessary.

This patch removes the assignment of NULL in proc_evict_inode() so that
for the entire (public) life of a proc_sysctl inode, the ->sysctl
pointer is stable and points to a valid value.  It then changes
proc_sys_compare() to simply use ->sysctl without any concern for it
changing or being NULL.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/proc/inode.c       | 4 +---
 fs/proc/proc_sysctl.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index a3eb3b740f76..e0f984c44523 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -41,10 +41,8 @@ static void proc_evict_inode(struct inode *inode)
 		proc_pid_evict_inode(ei);
 
 	head = ei->sysctl;
-	if (head) {
-		RCU_INIT_POINTER(ei->sysctl, NULL);
+	if (head)
 		proc_sys_evict_inode(inode, head);
-	}
 }
 
 static struct kmem_cache *proc_inode_cachep __ro_after_init;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index cc9d74a06ff0..5358327ee640 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -915,7 +915,6 @@ static int sysctl_is_seen(struct ctl_table_header *p)
 static int proc_sys_compare(const struct dentry *dentry,
 		unsigned int len, const char *str, const struct qstr *name)
 {
-	struct ctl_table_header *head;
 	struct inode *inode;
 
 	/* Although proc doesn't have negative dentries, rcu-walk means
@@ -928,8 +927,7 @@ static int proc_sys_compare(const struct dentry *dentry,
 		return 1;
 	if (memcmp(name->name, str, len))
 		return 1;
-	head = rcu_dereference(PROC_I(inode)->sysctl);
-	return !head || !sysctl_is_seen(head);
+	return !sysctl_is_seen(PROC_I(inode)->sysctl);
 }
 
 static const struct dentry_operations proc_sys_dentry_operations = {
-- 
2.49.0


