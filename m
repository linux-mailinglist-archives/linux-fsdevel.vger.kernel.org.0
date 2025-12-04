Return-Path: <linux-fsdevel+bounces-70666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DDFCA3E34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 14:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3F31300CA87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7533B6C4;
	Thu,  4 Dec 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVepicvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A823EAA0;
	Thu,  4 Dec 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764856151; cv=none; b=sUhhb+Vw/nGqJK4RsmKGB9mYTDKaaZNdkw2wb46oq7hhvNFogA2vk8ICGJ0tSCVeTPyerDPDB/NlhwLIpwy/8tCC/cw6SGeNienohmOPvVNPXF+b5C68+4nRlNN6SUyTXC40bSh/wp+WA9zRX4WW7wvz1FhLnVK2etMnjzsIlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764856151; c=relaxed/simple;
	bh=B7cDzUwtwLmcB8xAMZThSouUsjZu/ErXbPbY+L/GdXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pw/gdjfUpXHVhiBojFbxeOZ3JA11iiHsy7vjoYLkhDuWDSTkR3MX8TPWkcX6jEVEkNeFylIpIYjmXeMMlKCroEDsyWCigi7+JXZADHF+4cLrT2a3iJ5vFZU00a3acC/z13ibqMfLqscZQRsdwFJ7D+qY/q0W7ySqlft9tBVg5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVepicvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F029C19421;
	Thu,  4 Dec 2025 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764856150;
	bh=B7cDzUwtwLmcB8xAMZThSouUsjZu/ErXbPbY+L/GdXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nVepicvSuHrsUZU5TvrhrjBjmxr90zPsertf4SDPp2bIhamIANFFAzDBECWn6vSLw
	 YqK1+FHei26vGaAuwG9tK1TJ4ETggU81274BhdcVXb3EwBfbbjsXavk+6vzTseug5R
	 9MJtsrUX1CiVtj+XYXnzrtLQc/U1B7KQUfZONd781ess2OjgQ0I4R/IZthrpyipKVD
	 F6VKFSgefvMFRwZKa1+CUgPP+ZgAXIrl30Of1Mg2t6AlKRnX8XBn9o87AJVqgIq9oU
	 lukmrmDKolsFR800YqL/OB6Rv8MysbIVnaHaK0mp74lNkD+bOKCD8j4nZz6Ml4nypM
	 Y2d6O79os87aw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 04 Dec 2025 08:48:32 -0500
Subject: [PATCH v2 1/2] filelock: add lease_dispose_list() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-dir-deleg-ro-v2-1-22d37f92ce2c@kernel.org>
References: <20251204-dir-deleg-ro-v2-0-22d37f92ce2c@kernel.org>
In-Reply-To: <20251204-dir-deleg-ro-v2-0-22d37f92ce2c@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3241; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=B7cDzUwtwLmcB8xAMZThSouUsjZu/ErXbPbY+L/GdXs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpMZFSjldUBZODaqIkmtwHqaztEsUC3pzmC4rnE
 q/b4U8KznuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTGRUgAKCRAADmhBGVaC
 Fch5D/0YlgBlxJYpt5DgQLZ6uW3pREY2rjO6y/orDk1W147DVow+pUO00Nw9S3/yxhXr4onv5rA
 wqpZIQ/u2wZl+/1zwOzEeIJDqsSMGOCyGdCUDslJEkBMPgA8Dasv5QiQ8ywZy21lLUDGb0ucZps
 m4bJeyzGEYD2o+5+bRyvgjS8/o2fmbrrr2ApxXGg7qqjS41i7qjhpNkgjoDHa3fHnlL/7j3jF7G
 kcqTY/XPAjsVXrjmwFYEJRGSKwhtm6OCWYFjf/UuDurfM2fUTE6suM6JBNvrDz01pp77FHS9Bui
 34XGDBeqjbeBwcI+xQNOyKE9HcnO8p2WnzWmOZki+L9EQbaqKx/KieZFb+ze/o8KPU4dfPtrR1n
 ZW2Mdi5/3nUVo6uTCbCeUe+G6qRcUtYFGuJxcZQ+RWfPuSuuF59L1xw7lYuPBovEjcARujr6FMR
 wiQQTRSiw2HcejWJD3OjvkY1o7fAs8vYfaL/vW3pSqXd9UatY1WZEzWsxK5USB7dptbyxYqELQ2
 GLTGConFs56F/Oj4DFJCHxNzla/3dM2ZS+sLNPQMOrX+vbWk21Van/6EulZmwQX1GxmeqojwDUC
 NxNJn5dYCKXcQOx8bRaoxBgD2NgabIp6HMRLl9CNkC3vdAqwoZdU6+oUYONNb4nEw2I3YgxsykN
 N+byhTgY/sJe4fA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The lease-handling code paths always know they're disposing of leases,
yet locks_dispose_list() checks flags at runtime to determine whether
to call locks_free_lease() or locks_free_lock().

Split out a dedicated lease_dispose_list() helper for lease code paths.
This makes the type handling explicit and prepares for the upcoming
lease_manager enhancements where lease-specific operations are being
consolidated.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 9f565802a88cd34f79541fb156ef6326c0e199f1..be0b79286da89d6b939ac071a9174c557d7f4d81 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -369,10 +369,19 @@ locks_dispose_list(struct list_head *dispose)
 	while (!list_empty(dispose)) {
 		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
 		list_del_init(&flc->flc_list);
-		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
-			locks_free_lease(file_lease(flc));
-		else
-			locks_free_lock(file_lock(flc));
+		locks_free_lock(file_lock(flc));
+	}
+}
+
+static void
+lease_dispose_list(struct list_head *dispose)
+{
+	struct file_lock_core *flc;
+
+	while (!list_empty(dispose)) {
+		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
+		list_del_init(&flc->flc_list);
+		locks_free_lease(file_lease(flc));
 	}
 }
 
@@ -1620,7 +1629,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 	error = wait_event_interruptible_timeout(new_fl->c.flc_wait,
 						 list_empty(&new_fl->c.flc_blocked_member),
 						 break_time);
@@ -1643,7 +1652,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
 out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 free_lock:
 	locks_free_lease(new_fl);
 	return error;
@@ -1727,7 +1736,7 @@ static int __fcntl_getlease(struct file *filp, unsigned int flavor)
 		spin_unlock(&ctx->flc_lock);
 		percpu_up_read(&file_rwsem);
 
-		locks_dispose_list(&dispose);
+		lease_dispose_list(&dispose);
 	}
 	return type;
 }
@@ -1896,7 +1905,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 	if (is_deleg)
 		inode_unlock(inode);
 	if (!error && !my_fl)
@@ -1932,7 +1941,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
 		error = fl->fl_lmops->lm_change(victim, F_UNLCK, &dispose);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 	return error;
 }
 
@@ -2727,7 +2736,7 @@ locks_remove_lease(struct file *filp, struct file_lock_context *ctx)
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 }
 
 /*

-- 
2.52.0


