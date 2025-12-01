Return-Path: <linux-fsdevel+bounces-70346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2324C97F74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 16:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20158344166
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FD331ED8B;
	Mon,  1 Dec 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZT6cfSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4B31D732;
	Mon,  1 Dec 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601728; cv=none; b=Eg0Djoo2zmwEHkqzDoWs3d4tDzwLg6us96dmO4BLHu9ou0hJhes6zM4U7XdTHzA8I7m5jTwpsCrlA7/uowFmEcqWKvyr76Y4kiTAOpldaDoVGCduDjlYu4RH6/wpgnCN9YA0jbwgWXBRGaofWMP+tt8PY337g0cY7favxeaHnAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601728; c=relaxed/simple;
	bh=cG/FTQoDIgTQVQQgyWjzaBGw1VilL3/BkQi/hh42O3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7ukDPT8LT+/tlSJQJzTwSLqloIOTuP+g/LFpBxCT/yNnkFq5nvV4HvipyJT98W013Yb6JdsSP/E1A9qGXALAWPmy7jjoG96GTJLul5kQRPcaZtJG91SJOQigMvq69CO9P+bb4yuGKMk496QAl2Kr85jqgZaMNJPcgQd71Rxv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZT6cfSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D5FC116C6;
	Mon,  1 Dec 2025 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764601727;
	bh=cG/FTQoDIgTQVQQgyWjzaBGw1VilL3/BkQi/hh42O3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nZT6cfSw9ZfAzgV+fNtYZoQp8A0s5vYa8+Epdm2hJJcV0Kd9QuX/xlWGLPlEcn0Dd
	 cNd8ZZ8e1jL9iX1jW5rkcOyWwGyKJOzyfVSO2OoRen2J86dSerqlNJSc7db/C6viGF
	 j0u1V39GqGrscogBgzpD+zXt6M4jTBaAhRc0cOB/+dR1cMG+GFGWYO1tqVb4zbeK4C
	 njfQYa6efPauAgpuCRK7pQFqy9aUqfcNdmrq/a3/hWB6jMzhTCdsWz743s/Iv2l036
	 IOWDDZ26VP+wZhRX/sp9x8bzUR52wfSvhcTSRRz9Ol1XultzAKDYoIqmDlxSDVjob+
	 id2ixn6pIWBHw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Dec 2025 10:08:19 -0500
Subject: [PATCH 1/2] filelock: add lease_dispose_list() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-dir-deleg-ro-v1-1-2e32cf2df9b7@kernel.org>
References: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
In-Reply-To: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2909; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cG/FTQoDIgTQVQQgyWjzaBGw1VilL3/BkQi/hh42O3Q=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpLa98eafKYscaBPkHVj5sPjiW4D1TOkFVxHTeZ
 WvYvcz72E2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaS2vfAAKCRAADmhBGVaC
 FStyEAC9s8bTxqsVvsN7TRJHS7ThpU5inHXqJKGfAum2ki6Wa4m4P+OJQAn5Yxr50O+GidmQQD0
 fDf7KJeL8Br4C02KZZmlN1qjbV+gNtknsf9gZg9TsH+CrQMFZJNq8EnSF5tyBg+bSr5bdVyAKs/
 K1Kfrme+IEVVzeFShMJLjCzcxYNMAJH9MFGhuIqxtezWqNpeEZPD2ktWjSxmClrs+4fm8+nD59r
 nfMKiUEbdBDFcAZUQnlUOViDfN0vQBu4v1Wz+9a4jXwu1NHpv7b4D06GbggH1YGbRYHKpyeg/Q7
 Ag5s3FwDn3fu+vcpsEt2i5G4/9GnIscwmFkMgmpjGOpu/SthEXv0o8kKfD09lC6/vniBlECJYdA
 PHutw2Dho84oExfsyGSvmBD2WTwUWdWH9aaYFh07F66FZyicL6NC5Nv7prO2a+Y9h48JJGw7nrO
 62BighOvbtFBhdteYQwpY0OvlYrUeMP5JysdcI7NgpMHhp0F780i3DhXbjZ8pLqskH0IZv60eih
 4p5yeiaC4YXtYWg/3lwAGQQz8pI6Y60vjYkok4ts1LhYOkPFvts8Zt/evZirEQey6GJt8mUjRk4
 cLXSfVmzZxlUp9fexdy66A7iaqGUvf5m0Og/gx88EqtIchDf6zi5ulxZyCbGyCc1AxrRf7rJHE5
 gw8jEUbMvp6eOoQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and call that from the lease handling code instead of
locks_dispose_list(). Remove the lease handling parts from
locks_dispose_list().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 7f4ccc7974bc8d3e82500ee692c6520b53f2280f..e974f8e180fe48682a271af4f143e6bc8e9c4d3b 100644
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
@@ -1726,7 +1735,7 @@ static int __fcntl_getlease(struct file *filp, unsigned int flavor)
 		spin_unlock(&ctx->flc_lock);
 		percpu_up_read(&file_rwsem);
 
-		locks_dispose_list(&dispose);
+		lease_dispose_list(&dispose);
 	}
 	return type;
 }
@@ -1895,7 +1904,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 	if (is_deleg)
 		inode_unlock(inode);
 	if (!error && !my_fl)
@@ -1931,7 +1940,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
 		error = fl->fl_lmops->lm_change(victim, F_UNLCK, &dispose);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 	return error;
 }
 
@@ -2726,7 +2735,7 @@ locks_remove_lease(struct file *filp, struct file_lock_context *ctx)
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 
-	locks_dispose_list(&dispose);
+	lease_dispose_list(&dispose);
 }
 
 /*

-- 
2.52.0


