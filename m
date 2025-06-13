Return-Path: <linux-fsdevel+bounces-51534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CFFAD7FA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 02:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674B57AE4D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 00:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B71C6FF9;
	Fri, 13 Jun 2025 00:38:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5090EEBA;
	Fri, 13 Jun 2025 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749775085; cv=none; b=FGJAmrEhjjejPifLJH92KpwU+NtDyYMDhj8eVMb9E/jYSHr+RYoCr0GCZTbBNMt28mO64y/e1BmuNS44BBXwW26+BT+LaMtVKDKS6Rt4dGPnN68VAEOVF6wSde9kcKdQbXd/lm9NOPD4hqVXHCabBL848vQudiEZPXpj12YxhlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749775085; c=relaxed/simple;
	bh=iqS/z3Gqo+8xCdoolb1OxJ6f5y0nNxZmycHc2wANlf4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=mNHV3LDIhUf68JOj5Wc5ixok4iZAmFLbYlDn+T7Kmz6fB4TSC5U0qZctZuoCJgjxtHUmwuH0TzQPGl0tKDhsFD3HxxI/AwCuF6v/5Zr9X3QbN7i45pYMH1auyht40e7dz9hpvq0Mi2gJFg0irbD90dCfQmx+aXCTwNKpJ+/bnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPsQh-009bhR-Km;
	Fri, 13 Jun 2025 00:37:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>,Joel
 Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] proc_sysctl: Fix up ->is_seen() handling
Date: Fri, 13 Jun 2025 10:37:58 +1000
Message-id: <174977507817.608730.3467596162021780258@noble.neil.brown.name>


Some sysctl tables can provide an is_seen() function which reports if
the sysctl should be visible to the current process.  This is currently
used to cause d_compare to fail for invisible sysctls.

This technique might have worked in 2.6.26 when it was implemented, but
it cannot work now.  In particular if ->d_compare always fails for a
particular name, then d_alloc_parallel() will always create a new dentry
and pass it to lookup() resulting in a new inode for every lookup.  I
tested this by changing sysctl_is_seen() to always return 0.  When
all sysctls were still visible and repeated lookups (ls -li) reported
different inode numbers.

This patch discards proc_sys_compare (the d_compare function) and
instead adds the is_seen functionality into proc_sys_revalidate (the
d_revalidate function).  If the sysctl table is unregistering, 0 is
returned.  Otherwise if is_seen() exists but fails, -ENOENT is returned.

The rcu_dereference() and RCU_INIT_POINTER() for ->sysctl are removed as
the field is not rcu-managed.  It is only changed when the inode is
created and when it is evicted, and in these cases there can be no
possible concurrent access.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/proc/inode.c       |  2 +-
 fs/proc/proc_sysctl.c | 35 ++++-------------------------------
 2 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index a3eb3b740f76..c3991dd314d9 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -42,7 +42,7 @@ static void proc_evict_inode(struct inode *inode)
=20
 	head =3D ei->sysctl;
 	if (head) {
-		RCU_INIT_POINTER(ei->sysctl, NULL);
+		ei->sysctl =3D NULL;
 		proc_sys_evict_inode(inode, head);
 	}
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index cc9d74a06ff0..dbf652b50909 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -884,21 +884,15 @@ static const struct inode_operations proc_sys_dir_opera=
tions =3D {
 	.getattr	=3D proc_sys_getattr,
 };
=20
-static int proc_sys_revalidate(struct inode *dir, const struct qstr *name,
-			       struct dentry *dentry, unsigned int flags)
-{
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-	return !PROC_I(d_inode(dentry))->sysctl->unregistering;
-}
-
 static int proc_sys_delete(const struct dentry *dentry)
 {
 	return !!PROC_I(d_inode(dentry))->sysctl->unregistering;
 }
=20
-static int sysctl_is_seen(struct ctl_table_header *p)
+static int proc_sys_revalidate(struct inode *dir, const struct qstr *name,
+			       struct dentry *dentry, unsigned int flags)
 {
+	struct ctl_table_header *p =3D PROC_I(d_inode(dentry))->sysctl;
 	struct ctl_table_set *set =3D p->set;
 	int res;
 	spin_lock(&sysctl_lock);
@@ -907,35 +901,14 @@ static int sysctl_is_seen(struct ctl_table_header *p)
 	else if (!set->is_seen)
 		res =3D 1;
 	else
-		res =3D set->is_seen(set);
+		res =3D set->is_seen(set) ? 1 : -ENOENT;
 	spin_unlock(&sysctl_lock);
 	return res;
 }
=20
-static int proc_sys_compare(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
-{
-	struct ctl_table_header *head;
-	struct inode *inode;
-
-	/* Although proc doesn't have negative dentries, rcu-walk means
-	 * that inode here can be NULL */
-	/* AV: can it, indeed? */
-	inode =3D d_inode_rcu(dentry);
-	if (!inode)
-		return 1;
-	if (name->len !=3D len)
-		return 1;
-	if (memcmp(name->name, str, len))
-		return 1;
-	head =3D rcu_dereference(PROC_I(inode)->sysctl);
-	return !head || !sysctl_is_seen(head);
-}
-
 static const struct dentry_operations proc_sys_dentry_operations =3D {
 	.d_revalidate	=3D proc_sys_revalidate,
 	.d_delete	=3D proc_sys_delete,
-	.d_compare	=3D proc_sys_compare,
 };
=20
 static struct ctl_dir *find_subdir(struct ctl_dir *dir,
--=20
2.49.0


