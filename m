Return-Path: <linux-fsdevel+bounces-67798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBE2C4B9B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A63B926A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 06:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335B8299927;
	Tue, 11 Nov 2025 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="ISFGi8VP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oxay8t3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F229A33E;
	Tue, 11 Nov 2025 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841128; cv=none; b=sx6YZWrCh6rDIgg2dYFv7kcVhloGQ7nrDCK5AEv9qhtq8Th+1yCY/d9cC5tYi7PUNtPlsY/qj3zCDpWQ2d1ufy2lGRRTbfio9w+kgCXVHG8jGN6GNJYl+F/37vuaixkGoJpj4o72yb/OM0iIUmRSanXMNphlm66zNIBcmiDrCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841128; c=relaxed/simple;
	bh=RT7cHie7/z9LHjbRhmoQ7VroOQ9rcZfk+ZV6dtTT0w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os9CpQ7KHhtzw+hMN91iXSaLiTuKNU8Gr1kvstpGEDi83P+bogwhr9vMP5nr5C16PBDUior+UlyUlqh8diyX17nAJbD1+/OJ4RvkDXf5loBw46fae2LNap5T02KLdrlxkWpxG9qx2xxrahFkYAVCQ32I6R1Su+VLOdUMWfLA57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=ISFGi8VP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oxay8t3j; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E0AC81D00231;
	Tue, 11 Nov 2025 01:05:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 01:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762841125; x=
	1762927525; bh=weQyEFLrwhiAqZUXXte+JUsWt13LSOjWmWUMwpPby44=; b=I
	SFGi8VPd0Dkbek+Hikwe6v+w7rOqbYHabAF9WkYgcznOOTtQ1mM7c6T1w7tgxg7G
	kjlcGcrSq7kwfVzFCKvjP/HRZrHrliv2Uih7kmiOAZIg0U05BoV4Mh9bLZwy+P79
	Dli0azD2UiTDxNRkHRuRE+OkOeaKFtN9PlI3TIVD0zWHfKfw27QoTLEE/E5jGI/c
	8HX81i3+BDC5SDEQfGq6dwYkYRyMg43LZrE+R5b+R/TS3cFrDvh1T1g4lIerjzPB
	Su2mDkyLUkAqOJaHuA6N6lBNwM1paOk4m9vPxhEda3/RJdIekpSiB388JslmWMeo
	Yy1D3cGs2RSurpY14h0Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762841125; x=1762927525; bh=w
	eQyEFLrwhiAqZUXXte+JUsWt13LSOjWmWUMwpPby44=; b=Oxay8t3jCDSFQGMPc
	gdN9nJukt0uKOdWnyhV746aqq5mOpvL7uKLfQZaBbDtm70712UN6k8VqHjkXtR+Q
	ln+SPPdycnNK2/Cx5DM28soYQvGBcYyMMnsAnBEK8b0cJjvkFDWnKrXodf34LLng
	3HcPQucTFXgWhsOw4xy+PE5lgZBeVFLkkHHr91Av4X4QDseY+YrBrM/C3P/jgDAW
	PlK/gvRUrE1HH9AA6CwS7U7l+Ql/L/gCrF76Mn9Ijh8fcXtm+LPHYT4gMT6bK/Ql
	5sZ7lDdV+vjNZug9NJLLENsbFJRZXRuu7wFIS2KR/BGCx7Nj4TYVXC+Q52T60cXQ
	/+cfA==
X-ME-Sender: <xms:JdISaX8kcmFEtuMMxFPADyWQW0QT6WTfMufGWwLiRoRNqmfUKGt-cw>
    <xme:JdISaUYSJ2DfGN0wUxgtA5mZTf67r3kGX3GIggiDfkzuHJMD2kMs7s2BQWdGrCclD
    dKKHxUkdXgD9m3UADRueRDmnlCFFMrr7t6ZGO2QKFGe2lsE>
X-ME-Received: <xmr:JdISaTOASt_LweWi9adUb-Tszsds0PLnp12okdF8yWRut-klqHiTkp16oroTkExFPT7YKNN9LcGkDflbjZ1eiKVAoVJoJGlFdYj70Ja1AqB9wKoi8plPOt8YbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtgeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:JdISaYDHN73YvNvx_jURvJNBrSFdr_p5Q3TbGdytoAqo87ljdG1O6g>
    <xmx:JdISaSJN1wsjLP71wmjWgEVI3Yb82BMmkUBkS7mo6S_G0e5wgnsb8Q>
    <xmx:JdISaZNeuZ8i05LjN9oZVdhGfeqccWFF5KTjF5JUUlcNL-0VNvMwxg>
    <xmx:JdISaY4U9sltm50N6U5Ucaqg7q867Lu5zg_lOvSwiIo_Vjr8Bz6ucA>
    <xmx:JdISaatnaHtb1Nx8aQw0z8VH6CzTCFIO3sS7lYfBn6QWqYRPQCD5yMc8>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 01:05:23 -0500 (EST)
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Date: Tue, 11 Nov 2025 14:04:39 +0800
Message-ID: <20251111060439.19593-3-raven@themaw.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111060439.19593-1-raven@themaw.net>
References: <20251111060439.19593-1-raven@themaw.net>
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

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h | 4 ++++
 fs/autofs/inode.c    | 1 +
 fs/autofs/root.c     | 8 ++++++++
 fs/namespace.c       | 6 ++++++
 include/linux/fs.h   | 1 +
 5 files changed, 20 insertions(+)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 23cea74f9933..34533587c66b 100644
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
@@ -109,11 +110,14 @@ struct autofs_wait_queue {
 #define AUTOFS_SBI_STRICTEXPIRE 0x0002
 #define AUTOFS_SBI_IGNORE	0x0004
 
+struct mnt_namespace;
+
 struct autofs_sb_info {
 	u32 magic;
 	int pipefd;
 	struct file *pipe;
 	struct pid *oz_pgrp;
+	struct mnt_namespace *owner;
 	int version;
 	int sub_version;
 	int min_proto;
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index f5c16ffba013..0a29761f39c0 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -251,6 +251,7 @@ static struct autofs_sb_info *autofs_alloc_sbi(void)
 	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
 	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
 	sbi->pipefd = -1;
+	sbi->owner = current->nsproxy->mnt_ns;
 
 	set_autofs_type_indirect(&sbi->type);
 	mutex_init(&sbi->wq_mutex);
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 174c7205fee4..8cce86158f20 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -341,6 +341,14 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 	if (autofs_oz_mode(sbi))
 		return NULL;
 
+	/* Refuse to trigger mount if current namespace is not the owner
+	 * and the mount is propagation private.
+	 */
+	if (sbi->owner != current->nsproxy->mnt_ns) {
+		if (vfsmount_to_propagation_flags(path->mnt) & MS_PRIVATE)
+			return ERR_PTR(-EPERM);
+	}
+
 	/*
 	 * If an expire request is pending everyone must wait.
 	 * If the expire fails we're still mounted so continue
diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..27bb12693cba 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5150,6 +5150,12 @@ static u64 mnt_to_propagation_flags(struct mount *m)
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
index c895146c1444..a5c2077ce6ed 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3269,6 +3269,7 @@ extern struct file * open_exec(const char *);
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
+u64 vfsmount_to_propagation_flags(struct vfsmount *mnt);
 
 extern char *file_path(struct file *, char *, int);
 
-- 
2.51.1


