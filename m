Return-Path: <linux-fsdevel+bounces-27395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22492961376
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7510EB237B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF91CCB28;
	Tue, 27 Aug 2024 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDQq7ZjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671571CDA24
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774404; cv=none; b=uu0cex2Y898k6DOjHevITz+cinVUeDU3k0UQ+4KplnxcCZtECEC3beEqN8+qNbxG3Q+ZyM2VNVXL/syngFZNfvPCRUodc0A5lyuVK1kTyYiwCOpmQdomhPOtnc8UON39y7DSCcf5zYdbb+hshXWm7eHKrVBhbmzrkVcbwtQRkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774404; c=relaxed/simple;
	bh=DE+gGtjVtEol42ZCGLAdc2sv/qn+B/OiKlktxCin3uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UxQeQ6DkWI6NcqAAYcaYn1vHmDgccpMImL1euQ24of7XTFDgHUmsx+bwdkCXSVjeEJK484MCCvqjNwM7VyHHSF05eL/k+JcHNP95uQi+cGUbY/GVTQ6C+ymdM83CNnsS8WZTJdHoCgM7Pnazl0cRxRH6OpjPsm0saQwCfph2uaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDQq7ZjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783A1C4FE07;
	Tue, 27 Aug 2024 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774404;
	bh=DE+gGtjVtEol42ZCGLAdc2sv/qn+B/OiKlktxCin3uE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XDQq7ZjDwI8AC6Fj1oxAsuHrCGy9En+5jUbhNv0Hn009zPn4EP5k3gaSgiWsMIcmU
	 v1aYprobuu5S8xNKWJJRLEpZ9Sn9FF9ZUjueUF9l2gAqAkHuB4G/via8om737bC4R7
	 s5ZFwup6mp0rtIPfyiegT5qfOvoG1HTnQupT70d7fQ2dqldnbQnk/T1tsD8Bfh+qGr
	 JDkeBjOVndsuv1YbThNR/Y41t72q5vvxcypc6aj4ziqaQPe/U2JBo1+GjPpfSj1qPm
	 yHjMC+JW2U2I1LdAjG6yiIVsNj5C6xrXW28N561WPBYxapRMufCgNcRPSZDMcUx28L
	 3xzdoo92Hg9NA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 27 Aug 2024 17:59:44 +0200
Subject: [PATCH v2 3/3] fs: use kmem_cache_create_rcu()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-work-kmem_cache-rcu-v2-3-7bc9c90d5eef@kernel.org>
References: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
In-Reply-To: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DE+gGtjVtEol42ZCGLAdc2sv/qn+B/OiKlktxCin3uE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSd/f7767KcLA/hXX+3aE6tvXhpOj9fz6VNL8v+yF7fO
 GGj0dxcjo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJcKUw/C95ceaBUq2q+/RX
 X04fzUt9zn6zW5GxcvKWiepRa62Ss4UZ/lcZel3xF2AyljeveZNyn7PvRPK98DnzdspOlFy3QcT
 qCSMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Switch to the new kmem_cache_create_rcu() helper which allows us to use
a custom free pointer offset avoiding the need to have an external free
pointer which would grow struct file behind our backs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c    | 6 +++---
 include/linux/fs.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 694199a1a966..83d5ac1fadc0 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -514,9 +514,9 @@ EXPORT_SYMBOL(__fput_sync);
 
 void __init files_init(void)
 {
-	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-				SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN |
-				SLAB_PANIC | SLAB_ACCOUNT, NULL);
+	filp_cachep = kmem_cache_create_rcu("filp", sizeof(struct file),
+				offsetof(struct file, f_freeptr),
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 61097a9cf317..12a72f162da7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1057,6 +1057,7 @@ struct file {
 		struct callback_head	f_task_work;
 		struct llist_node	f_llist;
 		struct file_ra_state	f_ra;
+		freeptr_t		f_freeptr;
 	};
 	/* --- cacheline 3 boundary (192 bytes) --- */
 } __randomize_layout

-- 
2.45.2


