Return-Path: <linux-fsdevel+bounces-68819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE69C670D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 03:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2817C4E0116
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 02:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B021328619;
	Tue, 18 Nov 2025 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Qj6YkGKp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dwQjWu8A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0084039;
	Tue, 18 Nov 2025 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434016; cv=none; b=mzYDyyRkrvicuCpx500nUWveYAOFfbZvs3sFQ/C74Zq/2URWzmM9mmfVbETOx5CpBwk2iHgFaK3JXH0P1Q4vKgxpUhsLMJppSm1Rs20M2EM1ITXwL5MTCbUbJoC499nvOnENPiaPN+dxDbwK9/YpG4pvSeGN4viZD5b9MORaspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434016; c=relaxed/simple;
	bh=pD48c+4zIw8yOWk8Y2Rs/31HPiRLYcKRb1GAEfXT2Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0xPPSs58KeOWGlLb+yxxZUSVwk3mc2QdxIVW47CAs7u0YK/Nemj1QCWaiXArShntZUZYo8le129Aq9hWRUYWVsTGM+HrZu2emsQUMSAXNRAEhndBhxB5gKaqpCqWHVsy1WwFgzICIj4wcqcx+rlTHS3BbbtL6D8sFC2vFUbKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=Qj6YkGKp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dwQjWu8A; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 151237A009D;
	Mon, 17 Nov 2025 21:46:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 17 Nov 2025 21:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1763434012; x=
	1763520412; bh=IKkLsOG4o8ISduKFt9a4pxwaqIA1wb6leGgdsGwqCbc=; b=Q
	j6YkGKpgjX9x7ZAHOnXAVVbNhNL9FO53nkB8px5yN843jYiIw1pEB9ldFjKJfKcb
	f4ihYfbRN1+DJwgWw03n6lDyeJhMDLnJ+eeNhNjvSvh9gTD0ERR1PO8LNLvhOh3S
	AS9rv8hmO4VuHs3wpBd4NkFFq8QJ9/b9L9nm9oI4uEJ/WaGXG080kkfVQD1R3vUv
	uaAWzoL9RlgYlVUhCcQlSu8A+Rd6tjifX19MKBYoeBGgbPS+3lSUcds1Quzjnz4C
	bkaE9im3zTqISnzhaiSblGKtTGjZqWiQKsb0lYRu5/5V0JVnZEjf2jEPavhPVBRY
	1NCE2HthlxMNeHJA8jX+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763434012; x=1763520412; bh=I
	KkLsOG4o8ISduKFt9a4pxwaqIA1wb6leGgdsGwqCbc=; b=dwQjWu8AJnl0VGEgx
	srqdySy+igyVcmKOvySHVaY7XkQcZ5D2ztHtD7etRM7HKdKCXWukldT09T4s/KMf
	1xzkj2+mrfHpG4ZX3gDyEvPSwM+SlJrszffVhffDLyJxmo6yZn5jfqEvfc2cYTto
	qAOWel97VTUAViMa+rLVCFILxGJg5XiUf+W9SCmQQbd9hj10ACIEVrHFVQ0hMPHw
	Ii1vbl6wPKJno4VFzDCmOyY+4ofKxkQnLB9itSKHgMdR0p+/EkVKuknGQfS4ALKY
	0/yEqIppkaFsaVEDGRMAw/qSQ0NbyV7sejMlGWQKzLz1wUT1OrRcWilfqYaGycin
	vGulA==
X-ME-Sender: <xms:HN4badqpkxoNAffiTm6M44pm4zjffemWpIK6C11F9KQTZXzIGG00nw>
    <xme:HN4baQWcICsCg_qmka_h5clvhct_A-ji9zl6v69YU6MTYTBF56uJgA6Xybf65NeDD
    JnfpP5l4rBqW-GTPJ0JKbC3et2QCTLmKdT0jUEs7Y7U9tcm>
X-ME-Received: <xmr:HN4baYbAXxs_8Lj5ZOIPlzyrFGWf4zViiO4Wqk9Vo-OdNAz5FZ3oYaZSdUvWATLj6UVHlc48Y5PsVrK3ODYB1fzNKo7iZ-KDPSY8U_i6L_nrLcKNRRLEeXykSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirh
    hoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegruhhtohhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghv
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrvhgvnhesthhhvg
    hmrgifrdhnvght
X-ME-Proxy: <xmx:HN4bade8krCZm4J4qr5K-NfGJ7B6NKGtlJhyS4fymS6fxkvQO_N7tw>
    <xmx:HN4baS3tMQB-AKz2l9pRs0WZOqIFcCZDvfQv1t2qSmWLh7roCaUENA>
    <xmx:HN4baUJlPSot9nwwE-GNsxoYaHHfjtiMC-H1bmXAAl8V1vjo-vQ0nQ>
    <xmx:HN4baREngk1aKECjCNVuYjeJJCEyWOg4CVTgriyiIS3-v3fYYfIZlQ>
    <xmx:HN4bac7ze66pC0LCEpgcYIHWps250zNsWcbLcldFFkE6hZoBj9ObeGz_>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 21:46:50 -0500 (EST)
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/1] autofs: dont trigger mount if it cant succeed
Date: Tue, 18 Nov 2025 10:46:31 +0800
Message-ID: <20251118024631.10854-2-raven@themaw.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118024631.10854-1-raven@themaw.net>
References: <20251118024631.10854-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a mount namespace contains autofs mounts, and they are propagation
private, and there is no namespace specific automount daemon to handle
possible automounting then attempted path resolution will loop until
MAXSYMLINKS is reached before failing causing quite a bit of noise in
the log.

Add a check for this in autofs ->d_automount() so that the VFS can
immediately return an error in this case. Since the mount is propagation
private an EPERM return seems most appropriate.

Suggested by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h  | 5 +++++
 fs/autofs/dev-ioctl.c | 1 +
 fs/autofs/inode.c     | 1 +
 fs/autofs/root.c      | 8 ++++++++
 fs/namespace.c        | 6 ++++++
 include/linux/fs.h    | 1 +
 6 files changed, 22 insertions(+)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 23cea74f9933..4fd555528c5d 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <uapi/linux/mount.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/uaccess.h>
@@ -27,6 +28,9 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include "../mount.h"
+#include <linux/ns_common.h>
+
 
 /* This is the range of ioctl() numbers we claim as ours */
 #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
@@ -114,6 +118,7 @@ struct autofs_sb_info {
 	int pipefd;
 	struct file *pipe;
 	struct pid *oz_pgrp;
+	u64 mnt_ns_id;
 	int version;
 	int sub_version;
 	int min_proto;
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 8adef8caa863..6b9a6de1c6fb 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -381,6 +381,7 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 		swap(sbi->oz_pgrp, new_pid);
 		sbi->pipefd = pipefd;
 		sbi->pipe = pipe;
+		sbi->mnt_ns_id = to_ns_common(current->nsproxy->mnt_ns)->ns_id;
 		sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 	}
 out:
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index f5c16ffba013..732aee76a24c 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -251,6 +251,7 @@ static struct autofs_sb_info *autofs_alloc_sbi(void)
 	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
 	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
 	sbi->pipefd = -1;
+	sbi->mnt_ns_id = to_ns_common(current->nsproxy->mnt_ns)->ns_id;
 
 	set_autofs_type_indirect(&sbi->type);
 	mutex_init(&sbi->wq_mutex);
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 174c7205fee4..d10df9d89d1c 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -341,6 +341,14 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 	if (autofs_oz_mode(sbi))
 		return NULL;
 
+	/* Refuse to trigger mount if current namespace is not the owner
+	 * and the mount is propagation private.
+	 */
+	if (sbi->mnt_ns_id != to_ns_common(current->nsproxy->mnt_ns)->ns_id) {
+		if (vfsmount_to_propagation_flags(path->mnt) & MS_PRIVATE)
+			return ERR_PTR(-EPERM);
+	}
+
 	/*
 	 * If an expire request is pending everyone must wait.
 	 * If the expire fails we're still mounted so continue
diff --git a/fs/namespace.c b/fs/namespace.c
index 2bad25709b2c..786ac259c399 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5141,6 +5141,12 @@ static u64 mnt_to_propagation_flags(struct mount *m)
 	return propagation;
 }
 
+u64 vfsmount_to_propagation_flags(struct vfsmount *mnt)
+{
+	return mnt_to_propagation_flags(real_mount(mnt));
+}
+EXPORT_SYMBOL_GPL(vfsmount_to_propagation_flags);
+
 static void statmount_sb_basic(struct kstatmount *s)
 {
 	struct super_block *sb = s->mnt->mnt_sb;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd3b57cfadee..d876ace737e1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3271,6 +3271,7 @@ extern struct file * open_exec(const char *);
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
+u64 vfsmount_to_propagation_flags(struct vfsmount *mnt);
 
 extern char *file_path(struct file *, char *, int);
 
-- 
2.51.1


