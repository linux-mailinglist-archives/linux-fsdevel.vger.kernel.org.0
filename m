Return-Path: <linux-fsdevel+bounces-35313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E60A9D395E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB46281B49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C307D1A0BC5;
	Wed, 20 Nov 2024 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH0kTMWl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9611A00FA;
	Wed, 20 Nov 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101652; cv=none; b=QLb9LVJl99Iwcg01/9LLjVMwLRNeXA4FzSk/eA3PTAFQgfUH2gQwrXpMgL7MvFjIorUP2X2lY0IjshHmdhP5A1K5MorLZf1Uucqk/KqTyqfYy1mZmYLycSO2MzlVuSHNr97Oc9djiJvtSfDrb5n9GX9XZBEnoUfQoyriXRGt8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101652; c=relaxed/simple;
	bh=oY4G8rXKvXk/RMESA/pAWGVas5Id2NmoLa0YqTfcAV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hW62lrZCphVFYnIoUEzmY2bXtVw/eG33L4IRPZzpC7W0y3+SjOhu07nSFUSyId/6+rpNqURc2bpVFWJUI3fJTdiGQxfh+rvesIsc9ksJXIa2Ove/NAzwmlazrxCNuxNcYmPGER7/gi4U8fHjw5Di9Cxu9Wo+ROWRgNGtkkOTCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH0kTMWl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so5233215a12.3;
        Wed, 20 Nov 2024 03:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732101649; x=1732706449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUaKEruejfDCGRJdpj1eBL3gJs8S2bH9vNecg7yvIhA=;
        b=UH0kTMWl04zmjomg2SbUfqjYmKgjs5K8M7U9Quby0r12nDO6+G2Y6UUCxepRrJ/X+3
         hhHcXeBx9OqhnTBeCkFvLwwjy6B4yurAV0wTpk2aGaCuG0IvrBh66h7SlgH+2Mk9ZuTm
         nvaisgxh4G/ZkhMuvUaVeYQeMPaiwf8M69zGB2gp9g9r0cJrbD4vZxB0i9GoqMVWeSl9
         cGRIAOouNcOEaTpmKWsyHSgwBBjzIKi7T5vy2vVX0ijO+uk1X6Hscwyl97mpXXQP/n9d
         v8U84bYpyd+sOonYW5qwumMNivYU0XicCb7q/BLQgSQlfp2BH5DDCb76s9g3cI1NCwmT
         FQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101649; x=1732706449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUaKEruejfDCGRJdpj1eBL3gJs8S2bH9vNecg7yvIhA=;
        b=WZzVgu6eDCcXq/lede2RJ1UX9sM4PKdDcevqmvs89fKcI0+G87/W+k/bR6jZq1v9sp
         WEtVBP4/Q+XyGuG6yKugmwqLKofL6MrJDR77GjmOnok6Konc9GfHLDPi1ZD0wwoD72w0
         GUvDCGzPO9A48amvP+clbEXNzDFofn6v9sYRDeKGlzIPGf4QyYFAeFD4QLD9E9S0A3K7
         IazviE6AqbmPywxqef9PE7gwNvPoBAaXN1coI11/uQ7lQK/SANCwvxJz55MdhNlLYNZA
         aStiU5u2dvAxZvlrEl7HFbPdFjCFHsxjp7+qxMAMg6BT5Oq9OoT9Uc3hqcadOTh3zyNE
         eESg==
X-Forwarded-Encrypted: i=1; AJvYcCUTWZBXYQVWVMTQFzGlWMtoNtQh+x0WTuTYWEntXGFwHlW6syUHz5g0G2TcOo9ppYuHEb+ah1eSrD0sy8F9aA==@vger.kernel.org, AJvYcCUxqCWZqu953v+eTwZv38ep+ZM1GRtWjTAWhCLPifNdOQ5C5wNAWM7OjD1P+0w9zKPSp17UfDiwovp7@vger.kernel.org, AJvYcCW1F0WFQCh3lxi5XxyFnmeZKX2XqvG8OTzhHScNtkMGu+9aHx3LjejcohUl+aKG2I2t7Tu3q0/NxZfT1M7n@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JyKcUe2HaP9XY/rLNi7i39Pzk1ImkRP25Z0aNGPeNFCouG5h
	PAohA5pvH8LIEqqsGkJW+m2k81mtqHUUV6jTTCgtJftI6wCJKogQ
X-Google-Smtp-Source: AGHT+IF/eB9UNR6VnoZKt3nFhYHrh56urFiBKWBZ6vnCYzDyugb1WbUzdkpcnja3XeP3jZyhS9PA3Q==
X-Received: by 2002:a17:907:c1f:b0:a9d:e1d6:42a1 with SMTP id a640c23a62f3a-aa4dd57c0ecmr210229766b.30.1732101648787;
        Wed, 20 Nov 2024 03:20:48 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df5690csm758559566b.75.2024.11.20.03.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:20:48 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hughd@google.com,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/3] vfs: support caching symlink lengths in inodes
Date: Wed, 20 Nov 2024 12:20:34 +0100
Message-ID: <20241120112037.822078-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120112037.822078-1-mjguzik@gmail.com>
References: <20241120112037.822078-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When utilized it dodges strlen() in vfs_readlink(), giving about 1.5%
speed up when issuing readlink on /initrd.img on ext4.

Filesystems opt in by calling inode_set_cached_link() when creating an
inode.

The size is stored in a new union utilizing the same space as i_devices,
thus avoiding growing the struct or taking up any more space.

Churn-wise the current readlink_copy() helper is patched to accept the
size instead of calculating it.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c                     | 34 +++++++++++++++++++---------------
 fs/proc/namespaces.c           |  2 +-
 include/linux/fs.h             | 15 +++++++++++++--
 security/apparmor/apparmorfs.c |  2 +-
 4 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9d30c7aa9aa6..e56c29a22d26 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5272,19 +5272,16 @@ SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newna
 				getname(newname), 0);
 }
 
-int readlink_copy(char __user *buffer, int buflen, const char *link)
+int readlink_copy(char __user *buffer, int buflen, const char *link, int linklen)
 {
-	int len = PTR_ERR(link);
-	if (IS_ERR(link))
-		goto out;
+	int copylen;
 
-	len = strlen(link);
-	if (len > (unsigned) buflen)
-		len = buflen;
-	if (copy_to_user(buffer, link, len))
-		len = -EFAULT;
-out:
-	return len;
+	copylen = linklen;
+	if (unlikely(copylen > (unsigned) buflen))
+		copylen = buflen;
+	if (copy_to_user(buffer, link, copylen))
+		copylen = -EFAULT;
+	return copylen;
 }
 
 /**
@@ -5304,6 +5301,9 @@ int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 	const char *link;
 	int res;
 
+	if (inode->i_opflags & IOP_CACHED_LINK)
+		return readlink_copy(buffer, buflen, inode->i_link, inode->i_linklen);
+
 	if (unlikely(!(inode->i_opflags & IOP_DEFAULT_READLINK))) {
 		if (unlikely(inode->i_op->readlink))
 			return inode->i_op->readlink(dentry, buffer, buflen);
@@ -5322,7 +5322,7 @@ int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 		if (IS_ERR(link))
 			return PTR_ERR(link);
 	}
-	res = readlink_copy(buffer, buflen, link);
+	res = readlink_copy(buffer, buflen, link, strlen(link));
 	do_delayed_call(&done);
 	return res;
 }
@@ -5391,10 +5391,14 @@ EXPORT_SYMBOL(page_put_link);
 
 int page_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
+	const char *link;
+	int res;
+
 	DEFINE_DELAYED_CALL(done);
-	int res = readlink_copy(buffer, buflen,
-				page_get_link(dentry, d_inode(dentry),
-					      &done));
+	link = page_get_link(dentry, d_inode(dentry), &done);
+	res = PTR_ERR(link);
+	if (!IS_ERR(link))
+		res = readlink_copy(buffer, buflen, link, strlen(link));
 	do_delayed_call(&done);
 	return res;
 }
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc78c0a..c610224faf10 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -83,7 +83,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
 		if (res >= 0)
-			res = readlink_copy(buffer, buflen, name);
+			res = readlink_copy(buffer, buflen, name, strlen(name));
 	}
 	put_task_struct(task);
 	return res;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..2cc98de5af43 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -626,6 +626,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_XATTR	0x0008
 #define IOP_DEFAULT_READLINK	0x0010
 #define IOP_MGTIME	0x0020
+#define IOP_CACHED_LINK	0x0040
 
 /*
  * Keep mostly read-only and often accessed (especially for
@@ -723,7 +724,10 @@ struct inode {
 	};
 	struct file_lock_context	*i_flctx;
 	struct address_space	i_data;
-	struct list_head	i_devices;
+	union {
+		struct list_head	i_devices;
+		int			i_linklen;
+	};
 	union {
 		struct pipe_inode_info	*i_pipe;
 		struct cdev		*i_cdev;
@@ -749,6 +753,13 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
+{
+	inode->i_link = link;
+	inode->i_linklen = linklen;
+	inode->i_opflags |= IOP_CACHED_LINK;
+}
+
 /*
  * Get bit address from inode->i_state to use with wait_var_event()
  * infrastructre.
@@ -3351,7 +3362,7 @@ extern const struct file_operations generic_ro_fops;
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
 
-extern int readlink_copy(char __user *, int, const char *);
+extern int readlink_copy(char __user *, int, const char *, int);
 extern int page_readlink(struct dentry *, char __user *, int);
 extern const char *page_get_link(struct dentry *, struct inode *,
 				 struct delayed_call *);
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 01b923d97a44..60959cfba672 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2611,7 +2611,7 @@ static int policy_readlink(struct dentry *dentry, char __user *buffer,
 	res = snprintf(name, sizeof(name), "%s:[%lu]", AAFS_NAME,
 		       d_inode(dentry)->i_ino);
 	if (res > 0 && res < sizeof(name))
-		res = readlink_copy(buffer, buflen, name);
+		res = readlink_copy(buffer, buflen, name, strlen(name));
 	else
 		res = -ENOENT;
 
-- 
2.43.0


