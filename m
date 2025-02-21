Return-Path: <linux-fsdevel+bounces-42226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CEBA3F5A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15755189C810
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3BD20F07C;
	Fri, 21 Feb 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q36boZgX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1F20F068
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143616; cv=none; b=EwTHRaUJgCwYjfontvaNXi4wiJ12LZmHMy1JYCC8APYnzWcbG6FOaSlsOZSK2wKz6Aq6cOMA5dZy16mDqj/FDfyCXbnr35bJfKgx0eWk9FQ9rtRnQXYIJVEArXhTUGkw3sjhLw/iKpvmhbf2Eiqwfh68S1wFsv/8OJh/To9m4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143616; c=relaxed/simple;
	bh=dJR5WjmY7M49v87cFPq7tV8h5trgLQiGlHMFv6ValbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4+7DtyhzNN/7WY684ehz/Puqtzwn+Zy02+gAsCs4909v2Ng4tC/2+6oGC/wLp597bzr212Cw/14YItD/GyLmx/Uu9BVihnvEJDvjpvRHunFFNk5dEyaXW3zQFUH33gW7JZdaV0QRzhGfNawT1VbqloYBR999tpRXSZa+/dn8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q36boZgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D935EC4CEE6;
	Fri, 21 Feb 2025 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143615;
	bh=dJR5WjmY7M49v87cFPq7tV8h5trgLQiGlHMFv6ValbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q36boZgXIK++lVaMYDVPBEeIp86v83QutEVCiftYaqfmN5jctXGAYDKZU9Cd3hQ/V
	 VHXmMeyIl50juwypSv7ET57rN+k5daxgeiDdy+WgCpAF44YRSAd4s7vwqVdUxnHX0C
	 kI9b+kHfAZ5c9/jkG4mGlyVvI/+akB7osxOhAawa+9riw/YLFXntuwxX/d0gHPfVp5
	 uoccThD61ipQNAIH3CZRlb/g5PWFA9oT/PG1vrt4OUp2l3zZTf9UL9KRMaUt59XFel
	 WQHE92cVuCu3B3qlSVZFNuJNJndTwopvZ8+Oc9pe+cWyOyIs2wY48T4AWUCnTYse0r
	 UDmdJmi64AVqA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:00 +0100
Subject: [PATCH RFC 01/16] fs: record sequence number of origin mount
 namespace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-1-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dJR5WjmY7M49v87cFPq7tV8h5trgLQiGlHMFv6ValbY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP5lOfPugbkdEzrNfLWjk89vaHPc+9cip3an1skD4
 efnTtmg2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRR7cZGWa8fMRgJ3Zl2vS/
 +8I+Wjrs/L1905Od1w8/ZF15Wy3926FjDH94Em9b83qqTpm+cv8yY578N+I3NieUHHl+VcO18Xq
 axDJOAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Store the sequence number of the mount namespace the anonymous mount
namespace has been created from. This information will be used in
follow-up patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     |  1 +
 fs/namespace.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index ffb613cdfeee..820a79f1f735 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -20,6 +20,7 @@ struct mnt_namespace {
 		wait_queue_head_t	poll;
 		struct rcu_head		mnt_ns_rcu;
 	};
+	u64			seq_origin; /* Sequence number of origin mount namespace */
 	u64 event;
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
diff --git a/fs/namespace.c b/fs/namespace.c
index a3ed3f2980cb..9bcfb405b02b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2853,15 +2853,28 @@ static int do_loopback(struct path *path, const char *old_name,
 
 static struct file *open_detached_copy(struct path *path, bool recursive)
 {
-	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
-	struct mnt_namespace *ns = alloc_mnt_ns(user_ns, true);
+	struct mnt_namespace *ns, *mnt_ns = current->nsproxy->mnt_ns, *src_mnt_ns;
+	struct user_namespace *user_ns = mnt_ns->user_ns;
 	struct mount *mnt, *p;
 	struct file *file;
 
+	ns = alloc_mnt_ns(user_ns, true);
 	if (IS_ERR(ns))
 		return ERR_CAST(ns);
 
 	namespace_lock();
+
+	/*
+	 * Record the sequence number of the source mount namespace.
+	 * This needs to hold namespace_sem to ensure that the mount
+	 * doesn't get attached.
+	 */
+	src_mnt_ns = real_mount(path->mnt)->mnt_ns;
+	if (is_anon_ns(src_mnt_ns))
+		ns->seq_origin = src_mnt_ns->seq_origin;
+	else
+		ns->seq_origin = src_mnt_ns->seq;
+
 	mnt = __do_loopback(path, recursive);
 	if (IS_ERR(mnt)) {
 		namespace_unlock();

-- 
2.47.2


