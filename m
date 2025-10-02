Return-Path: <linux-fsdevel+bounces-63283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E2FBB3F29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 14:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45231C7E88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE30311948;
	Thu,  2 Oct 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGQMcLus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1224311589
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409743; cv=none; b=Fp8uFx5TSer4AjbzVMOLbeSqtMG0SYr1lP/KhYrvfheluFrchDxyXnAMrsJzmZmwQ1Qx97PVWtINwqdH248Eyu+Z6VIzLmbwyISa/nNjPRS77RpvIH7aSjtPndBBNgfDPJoyTxWPjm++KN23g+bk6swjd507iqvc/4Ke5QQH1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409743; c=relaxed/simple;
	bh=wYXddcwvRcQeKAEy9A1oIWjRBhIg8md5Wu6+CeCI49E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgNzK5lrKKRV22t/oHr9GwRoBUUJ18z/BmHx06p+wYClFh7CKAvbhhb7So9TxVRMV7+eCg9DKrUD0hKnwqEOupMRphduyH19hYeAStBoGbVYhIIvqGOKyXZ5SHWi3yesAtnvAqKD9MzhS9Qbku4t8Ud3uMe2ePucc/qu5GhVI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGQMcLus; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f67ba775aso1496643b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759409741; x=1760014541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJxtmpcoXc4yrgHs5WtTE6sBIdXe4Bd5IXbrrNjT5jw=;
        b=NGQMcLusDd/Trjo4v/ZCJyD5L6xV8SQsCX3YmeSXaTk8TgIbI0cDmxoda2ObY4av2o
         O0XocLzHvtPpRa2Ff5Go4t61EUDF+QbwQ1OL3/SrWJDq/eAd7wmO5IrJUALFkE2lWIq2
         FLL8XSeLYKlKOqyKgMTCAeE4VSU1SdJXt+7ZbL1BeM6d76bF5fQ97dLd17gi3nYi826A
         bRseLqLBxScAOV6+JG5cD04DDnX+8e4k2iQYUO3qN8gXPFKYhLWk3Omi4gn9CFYnQjSZ
         nbr4zf7WZ3D/fK5P3KNn+J5MFtsnLIS4Jzdib6ZuQVgrehDyKPxNYhgZNHfwwJ7q/m60
         2qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409741; x=1760014541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJxtmpcoXc4yrgHs5WtTE6sBIdXe4Bd5IXbrrNjT5jw=;
        b=mnArbPzjk1L6an/ihr/LdWq05LJMqStz3+WoNplfmvwcXLdqNdX5tLHiCL5GwSALzB
         24h2+CslQOJHt5Ej84DLpLQAMf7hYO2Z5ZqciyzRmWg1Qhf/dFnYetcwTsYrC2aQ//Zn
         XmjqIa+tD4NqBx0w6J0EdYCttEKV2DTfRQoErARE9NmB1Ka8cKU3XFxiHieROVJMQSQM
         f0So2JURyKdMHJVRLYkuM+6vIHIthgMbjKScqG48k4T2GD0Fjrn/vtXQvHIt6b9iHnG3
         IYyMbVyRibp45E2qSNwGsv/0tIYG4GcGZ1/x/3iSczP2hAyRl3+J6IKt6Q/fB+8taCCJ
         i8gw==
X-Gm-Message-State: AOJu0YzR6Db7n+wV8b3bLe0VTLkpK/ays1nAr9mchULZsd95fXMXyw2L
	HYyO1L91bHKUiKHIZdIBu2eEksvSkYY4+xYgfDw1Dg1QW32QoOFHxICP
X-Gm-Gg: ASbGnctTx26iKtPAaeYeS2GwzrVjW2CVcax9O+aTErO4rtPkjCu4NrnL7rsKAWaMdUC
	cnk0dW1lEQAX8UCirtYBjuSQTxuJqaoXGrFMfuXS28jdKwaQCt3f9GH7HrD7SjQrMNM3+4t4tWP
	/L49BRLbhujxSERvMplWjrMxIKxxIN0Z8DaTfrLN1/q81D34NlsmESEVQkIHR+Ukc7aB3iNWqXy
	6mh0k3PjS/92hQd885GYNf2aasQLnc1DsRbI/0/03LRr+Wpi4weir3zwxDk+UP2NAD/gYLJHrkK
	VMNzP7FhBOo4zCMbakAGJC5UF14EArPCepooKGM3JFgx4S0d9fISAljgIFrPid1zLhwBPCzRc93
	Ej68a+wia4HrLI65KzJMW+TGbc2gkuycgtHVA/YdzUnY74jA=
X-Google-Smtp-Source: AGHT+IHFaqJGan1kbBL1yPFJipQm5sq8pkjRSeMRc0bigutWIseqQVBU2KqOXs5f++yqM/U9uhcYVQ==
X-Received: by 2002:a05:6a00:1884:b0:776:20c2:d58b with SMTP id d2e1a72fcca58-78af4209966mr9210619b3a.24.1759409740920;
        Thu, 02 Oct 2025 05:55:40 -0700 (PDT)
Received: from fedora ([2405:201:3017:a80:9e5c:2c74:b73f:890a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a2b9sm2165556b3a.19.2025.10.02.05.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:55:40 -0700 (PDT)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH 2/4] fs/namespace: add umounted mounts to umount_mnt_ns
Date: Thu,  2 Oct 2025 18:18:38 +0530
Message-ID: <20251002125422.203598-3-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002125422.203598-1-b.sachdev1904@gmail.com>
References: <20251002125422.203598-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

This patch add "unmounted" mounts to umount_mnt_ns instead of mount
namespace being NULL for such mounts. This will allow us to later use
statmount to get mount info about these mounts.

We also introduce proper checks so that "unmounted" mounts are still
detected correctly.

We delete mounts from umount_mnt_ns when no references to them exist.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 fs/d_path.c    |  2 +-
 fs/mount.h     | 10 +++++++++-
 fs/namespace.c | 23 ++++++++++++++++++++---
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index bb365511066b..c6a4118899e1 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -119,7 +119,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
 			/* Global root */
 			mnt_ns = READ_ONCE(mnt->mnt_ns);
 			/* open-coded is_mounted() to use local mnt_ns */
-			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
+			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns) && !is_umount_ns(mnt_ns))
 				return 1;	// absolute root
 			else
 				return 2;	// detached or not attached yet
diff --git a/fs/mount.h b/fs/mount.h
index 97737051a8b9..03f8165939b4 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -122,10 +122,18 @@ static inline int mnt_has_parent(const struct mount *mnt)
 	return mnt != mnt->mnt_parent;
 }
 
+extern struct mnt_namespace *umount_mnt_ns;
+
+static inline bool is_umount_ns(struct mnt_namespace *ns)
+{
+	return ns == umount_mnt_ns;
+}
+
 static inline int is_mounted(struct vfsmount *mnt)
 {
+	struct mnt_namespace *ns = READ_ONCE(real_mount(mnt)->mnt_ns);
 	/* neither detached nor internal? */
-	return !IS_ERR_OR_NULL(real_mount(mnt)->mnt_ns);
+	return !IS_ERR_OR_NULL(ns) && !is_umount_ns(ns);
 }
 
 extern struct mount *__lookup_mnt(struct vfsmount *, struct dentry *);
diff --git a/fs/namespace.c b/fs/namespace.c
index 70fe01d810df..0b4be12c02de 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1016,7 +1016,7 @@ static inline bool check_anonymous_mnt(struct mount *mnt)
 {
 	u64 seq;
 
-	if (!is_anon_ns(mnt->mnt_ns))
+	if (!is_anon_ns(mnt->mnt_ns) || is_umount_ns(mnt->mnt_ns))
 		return false;
 
 	seq = mnt->mnt_ns->seq_origin;
@@ -1400,9 +1400,11 @@ static void mntput_no_expire(struct mount *mnt)
 {
 	LIST_HEAD(list);
 	int count;
+	struct mnt_namespace *ns;
 
 	rcu_read_lock();
-	if (likely(READ_ONCE(mnt->mnt_ns))) {
+	ns = READ_ONCE(mnt->mnt_ns);
+	if (likely(ns && !is_umount_ns(ns))) {
 		/*
 		 * Since we don't do lock_mount_hash() here,
 		 * ->mnt_ns can change under us.  However, if it's
@@ -1438,6 +1440,18 @@ static void mntput_no_expire(struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_DOOMED;
 	rcu_read_unlock();
 
+	if (mnt_ns_attached(mnt)) {
+		struct mnt_namespace *ns;
+
+		move_from_ns(mnt);
+		ns = mnt->mnt_ns;
+		if (ns) {
+			ns->nr_mounts--;
+			__touch_mnt_namespace(ns);
+		}
+		mnt->mnt_ns = NULL;
+	}
+
 	list_del(&mnt->mnt_instance);
 	if (unlikely(!list_empty(&mnt->mnt_expire)))
 		list_del(&mnt->mnt_expire);
@@ -1885,6 +1899,9 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		 * namespace, etc.
 		 */
 		mnt_notify_add(p);
+
+		mnt_add_to_ns(umount_mnt_ns, p);
+		umount_mnt_ns->nr_mounts++;
 	}
 }
 
@@ -4804,7 +4821,7 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 		return -EPERM;
 
 	/* Mount has already been visible in the filesystem hierarchy. */
-	if (!is_anon_ns(mnt->mnt_ns))
+	if (!is_anon_ns(mnt->mnt_ns) || is_umount_ns(mnt->mnt_ns))
 		return -EINVAL;
 
 	return 0;
-- 
2.51.0


