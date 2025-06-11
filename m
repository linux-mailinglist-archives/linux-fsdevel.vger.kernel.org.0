Return-Path: <linux-fsdevel+bounces-51374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A7AD6393
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 01:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7F01888222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1AF2F4322;
	Wed, 11 Jun 2025 22:59:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308B258CC0;
	Wed, 11 Jun 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682743; cv=none; b=PdLUSP3BPKr4ZxzP0UJYC7l9MwprkRVJqHEwz8IjFHH7JRzs38+ZGlUzoYMroypfZdOPiZWaKeC6wiLuW54T64kzPTGf/1tRwZLOHEXompt+YjVl3sshvQjoqBrmByNvG3KDEuNPhJP5i7kNuZvEBqTmuzE1uAWLyLbhNy7m++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682743; c=relaxed/simple;
	bh=+p49bxglS6vHYuXD21Z8kmOqvXOmaEy3O23Z2TX/mtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELa+tHuAZPj6iw4PYm01oyBxYCerV6DdUYTDwl3IPXThMpngG2jAC9c1GvBlqGgH9iCM8WRZsRmQr1ZQQQTJrtI3xSpnVBUxw0VATmjnAiZYmyioxBSPTC+3KXzaucKLN+tUCvwrEae7UncrT+vsogFOC2AoQabL5DTEtylUy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPUPL-008OC6-AX;
	Wed, 11 Jun 2025 22:58:59 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 2/2] fs/proc: take rcu_read_lock() in proc_sys_compare()
Date: Thu, 12 Jun 2025 08:57:03 +1000
Message-ID: <20250611225848.1374929-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611225848.1374929-1-neil@brown.name>
References: <20250611225848.1374929-1-neil@brown.name>
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
index cc9d74a06ff0..a4cdc0a189ef 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -917,19 +917,23 @@ static int proc_sys_compare(const struct dentry *dentry,
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


