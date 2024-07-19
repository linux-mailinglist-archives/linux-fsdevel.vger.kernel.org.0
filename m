Return-Path: <linux-fsdevel+bounces-23993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98AE937738
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 13:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5533D281F21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFA8128812;
	Fri, 19 Jul 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqCf4XjA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AC1E871
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389351; cv=none; b=cV4vgv/zYtEbhVeXL9+55lVtwa3YQRSniG9qatZ0pisgNpjz/acco/h5RlAOmBT4RsTfXifAPYqQo7nCWQpft1h1YqBIfFFvzkv7bqN5+8oOI/5t6dikofnRmHcD13Rvy05xkBtgf8E/bnezhesuIYRMzo8caG7mRanwXHwmpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389351; c=relaxed/simple;
	bh=eYH1Sx5+EFqZZPyMC2duPjER2h+z3VYs2/4svFke7lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QY+HxNGlRuY1ST4EvCDQHbrr5Ybgurfx0xYhx/vJ9Q5M2/bQxRC/s4liBtHhW1cvgQomSDSfh+DTCPCSGmfpn0+6z6u8xBuVGMK+wU05XwZozYalnjis7jIv2LajaeuKPlHN2uy+DojVJ+O5O2hPYDk+eIwOW8m0fJ+e64uiR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqCf4XjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32910C4AF09;
	Fri, 19 Jul 2024 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721389350;
	bh=eYH1Sx5+EFqZZPyMC2duPjER2h+z3VYs2/4svFke7lk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NqCf4XjAFJ2Yky7U933md7kXdn/sBFVpvCmIhixVt9mU08Bpz/oD+fa7gQ7sLGbWN
	 cb+3OVai4RNvE8LkWok8RRR5xc/0o71bKgOR4boFPXyQbUdFMkbfTF/oqCTrRnujlr
	 dWmjmVdEQ5h3Ms1WPPAGVL+UGvrL1t081B89qWboNl9OJTEuHXxz+qFTWyZbt7enJd
	 8WMtKfzMDYhrWrjjlb7R33Mp75tOe39kqAr9bnsHYUr6dZ4cdzkkoDjY2Xiq/lUKNd
	 NQQQb2VCxk8PU+m3ACFOWam94iFHCDfHHYWd0vE10QHXN0kXxNvZzGXU9P54ouj35a
	 BGQpDcXlOHrqg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 19 Jul 2024 13:41:49 +0200
Subject: [PATCH RFC 2/5] fs: allow mount namespace fd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-work-mount-namespace-v1-2-834113cab0d2@kernel.org>
References: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
In-Reply-To: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Karel Zak <kzak@redhat.com>, Stephane Graber <stgraber@stgraber.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2096; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eYH1Sx5+EFqZZPyMC2duPjER2h+z3VYs2/4svFke7lk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNClRYW3XJLSHcYm1T/4nJV5c8jLz0zmr7hR6roIszh
 ea/vsiq2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRu78ZGZ7Gz5ijXe+/JvF6
 YZmgr78ax6WAXQfftb2fU9W+T+iGRAgjQ3Pr+7kn3aQ3C/fsfFaepu/pupXTz49Z2XN984WLluf
 ZOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We already allow a mount namespace id, enable mount namespace file
descriptors as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 328087a4df8a..3ee8adb7f215 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5243,12 +5243,37 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
  * that, or if not simply grab a passive reference on our mount namespace and
  * return that.
  */
-static struct mnt_namespace *grab_requested_mnt_ns(u64 mnt_ns_id)
+static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq)
 {
-	if (mnt_ns_id)
-		return lookup_mnt_ns(mnt_ns_id);
-	refcount_inc(&current->nsproxy->mnt_ns->passive);
-	return current->nsproxy->mnt_ns;
+	struct mnt_namespace *mnt_ns;
+
+	if (kreq->mnt_ns_id && kreq->spare)
+		return ERR_PTR(-EINVAL);
+
+	if (kreq->mnt_ns_id)
+		return lookup_mnt_ns(kreq->mnt_ns_id);
+
+	if (kreq->spare) {
+		struct ns_common *ns;
+
+		CLASS(fd, f)(kreq->spare);
+		if (!f.file)
+			return ERR_PTR(-EBADF);
+
+		if (!proc_ns_file(f.file))
+			return ERR_PTR(-EINVAL);
+
+		ns = get_proc_ns(file_inode(f.file));
+		if (ns->ops->type != CLONE_NEWNS)
+			return ERR_PTR(-EINVAL);
+
+		mnt_ns = to_mnt_ns(ns);
+	} else {
+		mnt_ns = current->nsproxy->mnt_ns;
+	}
+
+	refcount_inc(&mnt_ns->passive);
+	return mnt_ns;
 }
 
 SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
@@ -5269,7 +5294,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	if (ret)
 		return ret;
 
-	ns = grab_requested_mnt_ns(kreq.mnt_ns_id);
+	ns = grab_requested_mnt_ns(&kreq);
 	if (!ns)
 		return -ENOENT;
 
@@ -5396,7 +5421,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	if (!kmnt_ids)
 		return -ENOMEM;
 
-	ns = grab_requested_mnt_ns(kreq.mnt_ns_id);
+	ns = grab_requested_mnt_ns(&kreq);
 	if (!ns)
 		return -ENOENT;
 

-- 
2.43.0


