Return-Path: <linux-fsdevel+bounces-50983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12764AD1975
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7D51692C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FCF2820AA;
	Mon,  9 Jun 2025 08:00:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8C281365
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456007; cv=none; b=XqI55V0CIhqT14KpklEe+WzGLNiuL+Rhmo3+BtZonlKOuFi02nZCn3PBvDSaUrwm/LWDKr+CE7zfAus/JZ96Bbg/LC9zfyM78dFTAh/spT7pZgcYBFhYdNKRF47y0j994L8SvZjw7D1qAHfsdF4NTFuu3/vTrasb/B1yoXIxHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456007; c=relaxed/simple;
	bh=FSU7m9u7LhvR3xmVC77vQM/srFQGTXQK79gPEmnCtz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4/FBvSc5RP8xtttkiz8F8/3GBmnkA0S1gmwY3mbpvgz8vT4Uu37XpZTWUkU66/TJGtb5es+qkjlIg+4S1KhdGzUW5UjSeP10ohGRMx90h1ZKAhQJ+qg+1DrkWiQkL8OGe7wj6fH8xRFySxPDxzOTU0KmFQxkxeGBh26Wp1zm/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOXQK-006HTl-0S;
	Mon, 09 Jun 2025 08:00:04 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/8] fs/proc: take rcu_read_lock() in proc_sys_compare()
Date: Mon,  9 Jun 2025 17:34:08 +1000
Message-ID: <20250609075950.159417-4-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609075950.159417-1-neil@brown.name>
References: <20250609075950.159417-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_sys_compare() is the ->d_compare function for /proc/sys.
It uses rcu_dereference() which assumes the RCU read lock is held and
can complain if it isn't.

However there is no guarantee that this lock is held by d_same_name()
(the caller of ->d_compare).  In particularly d_alloc_parallel() calls
d_same_name() after rcu_read_unlock().

So this patch calls rcu_read_lock() before accessing the inode (which
seems to be the focus of RCU protection here), and drops it afterwards.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/proc/proc_sysctl.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9f1088f138f4..e3d9f36b6699 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -916,19 +916,23 @@ static int proc_sys_compare(const struct dentry *dentry,
 {
 	struct ctl_table_header *head;
 	struct inode *inode;
+	int ret;
 
 	/* Although proc doesn't have negative dentries, rcu-walk means
 	 * that inode here can be NULL */
 	/* AV: can it, indeed? */
+	rcu_read_lock();
 	inode = d_inode_rcu(dentry);
-	if (!inode)
-		return 1;
-	if (name->len != len)
-		return 1;
-	if (memcmp(name->name, str, len))
-		return 1;
-	head = rcu_dereference(PROC_I(inode)->sysctl);
-	return !head || !sysctl_is_seen(head);
+	if (!inode ||
+	    name->len != len ||
+	    memcmp(name->name, str, len)) {
+		ret = 1;
+	} else {
+		head = rcu_dereference(PROC_I(inode)->sysctl);
+		ret = !head || !sysctl_is_seen(head);
+	}
+	rcu_read_unlock();
+	return ret;
 }
 
 static const struct dentry_operations proc_sys_dentry_operations = {
-- 
2.49.0


