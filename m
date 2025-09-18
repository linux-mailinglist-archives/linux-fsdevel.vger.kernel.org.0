Return-Path: <linux-fsdevel+bounces-62097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD4B83FC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0D81C08648
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103EA2FF14C;
	Thu, 18 Sep 2025 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJWFp5Pn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB127E7FC;
	Thu, 18 Sep 2025 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190334; cv=none; b=Mi2FHK6efUkYtDsVYCaeuNdL07IUEaz5aFXZ5T57RYzQJTuFvJbyKgtCOwUj6Lb6gI7HIu0GD4oQfgGsUVKNWOy6sCrl1BeF7bhnMNYhraGM5861oSoMcZikV/aVbhJcL2LVpfOnFsXiD2J97uc+y/lu9zkUEfUYUTBnlFZknGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190334; c=relaxed/simple;
	bh=YNpbHl0e3vU8E4llPbmuVZsTppgL8lTynK3tRRFcir4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VncPnWsKhGkOOxKOSwZyG6T1wQn49p+xdprTDFAk0faC9zu8h4kWZz2LeM3b06v1GQqoktEvPpDQOQ7Un7SwYMFRLeFSYFy6+HMS6SJaZ4C/AVxT/TTMBKIVYcPWBrtrSh+0owOug6z/B/MnkN5oNXzqMP4Ht99TNfLwCA2UfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJWFp5Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CB0C4CEF1;
	Thu, 18 Sep 2025 10:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190334;
	bh=YNpbHl0e3vU8E4llPbmuVZsTppgL8lTynK3tRRFcir4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PJWFp5PnGpphs/p6jvX208TBYn7epuzPlkKJIyvGQfu0rG7PUdZ+0q0chtlWExo3a
	 9BuLf3T2z8SbIgr3Tpu88QvuCgDlNEk6/orz+gwMD9DfetjfVD1CumP8kRDBN5g8cD
	 SHZCFdG3vcBkfomJA2qtB7TQj8GqfFcZQpw6V2DKccS9vm4pP8K5bMzw6kxaMXtJvc
	 jXkKyTcCuq0Gp5MJcQ/N2tsqyxQ5Ng+engEQfzAULWbQTfQabFyBukSvBFqJHMQZXX
	 PGl8kw2ZLdT77nQ+X3cDOP4AkpQBKBpS9132v417FZ4UIgpIR8eSur+oPIi5Yk40hZ
	 4rPicOED55csg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:49 +0200
Subject: [PATCH 04/14] ipc: port to ns_ref_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-4-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YNpbHl0e3vU8E4llPbmuVZsTppgL8lTynK3tRRFcir4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvXUwbyKmWHr1Wl6ExauUjTv2hP4befpr9MKwn6He
 c5W7wlg6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIwmaG/2Um0V5th2rnnBN1
 Ljd6ocjq2XD1iaTJ4iChdZPVFt/4dJ6RoU/u+ymDizGa+3dxPGJJzfJcu4nH4+7Fkth5HAVvo7M
 CmAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop accessing ns.count directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ipc_namespace.h | 4 ++--
 ipc/namespace.c               | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 924e4754374f..21eff63f47da 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -140,14 +140,14 @@ extern struct ipc_namespace *copy_ipcs(unsigned long flags,
 static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
 {
 	if (ns)
-		refcount_inc(&ns->ns.count);
+		ns_ref_inc(ns);
 	return ns;
 }
 
 static inline struct ipc_namespace *get_ipc_ns_not_zero(struct ipc_namespace *ns)
 {
 	if (ns) {
-		if (refcount_inc_not_zero(&ns->ns.count))
+		if (ns_ref_get(ns))
 			return ns;
 	}
 
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 09d261a1a2aa..bd85d1c9d2c2 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -199,7 +199,7 @@ static void free_ipc(struct work_struct *unused)
  */
 void put_ipc_ns(struct ipc_namespace *ns)
 {
-	if (refcount_dec_and_lock(&ns->ns.count, &mq_lock)) {
+	if (ns_ref_put_and_lock(ns, &mq_lock)) {
 		mq_clear_sbinfo(ns);
 		spin_unlock(&mq_lock);
 

-- 
2.47.3


