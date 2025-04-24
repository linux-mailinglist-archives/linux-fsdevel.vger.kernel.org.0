Return-Path: <linux-fsdevel+bounces-47238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4EA9ADD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5E43B97B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9227B4FE;
	Thu, 24 Apr 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/MZsjis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B2224D7;
	Thu, 24 Apr 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498817; cv=none; b=l7WZyVW0HfSeoS1twTq9ZSpEVW87Nj/QKVjLc1vP6AwyuZW2fnddbBwTK8RgD/+e6aVvYWQJRUNrBIAbrLO8udg647aYnHrXz5rwUd5uGfnuUY3+SGJ6A+yvn1tEOaqhqBy9qzmZDp5TUWQkELiQQ01/cHNmLP/A5Wyxy5HZ3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498817; c=relaxed/simple;
	bh=UvcvRWYN3RuJk5MuwIcps2gtfN6XtnWVNcGrJqAeEpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJiMy6xmmf9Dp0BkajVDEyA/mBkkb27qCECcsGduTXO0y1vhtW2PcKDuxbE+crcS8sBxoWirLtMR38RMcBhOl1ekk+sFThU5E+CkZyrfQmM/WIm72LXzNhShDC6nYYkl6+Sx8Hc0LBMy0vn5PHl87djRAIm9BWCoSWr/+LtxLMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/MZsjis; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47690a4ec97so11190081cf.2;
        Thu, 24 Apr 2025 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745498814; x=1746103614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYM/9Ory8tzfg3Kpjz+Y35nva+i71yk+zvmGNY+Byso=;
        b=Y/MZsjisF573GbRsUn/93ik3KmGCPyrGk2wxSsC3NJNyiSVUAjuESL588/TtAvpPbk
         hP/RoK5xV/M/BBp9P6BWB39ZdTwNU3ZFDb4sog3VHCkLbIGQwtf/Nd6pekpc52F5Qxt1
         j+z9GUzKx1TbKvhZfudXs1r/tAfcdVnBJhH/IQQJOzzbkdkiPitgu4VtBzkTcxyku329
         FxmXJXAO9/HRD4bjHcRxgwgOid3yaahiwkc40o9ru0UlmLFqYN/eLhr8vH86twUBZVCZ
         3IeFlSuOUXn8TJCqtymkgE/mdsCFmv60zyM1MFeTEr2k3ZBVc/RuObZwdlVXRogkV2fY
         SJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745498814; x=1746103614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYM/9Ory8tzfg3Kpjz+Y35nva+i71yk+zvmGNY+Byso=;
        b=VBrcZ5FJl3fSPvEfsHeYXX1RS4BzjfIa7fLsl/JwZ1x1k7YiC5FOM6s4xRcpAgtqpd
         ThlSVuQKax3P42LpwYwEBJKKKzem4LeI8KQSY8/x54fdzFG1rPZ17UfMO+bgy0Bmh2f7
         s6gpufEAn81LGzu0nSs3CVCpXA+yo0sVi1UrgQHWJQ2TTXl7b+9sFOoA/tKvIk/+fXZf
         uO/xCzKnbnlcpy9tGWBajeVLMn17ehuXRp7mHRVoOpm0UbQnx2WyIH5Eh8j9dEFSeGAu
         uLawNpajuwWKEsll20eh2lEJzLo4qL+0zbLiukiXqbv02RphUfFnlbHHs0B8XQLPMznB
         uYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYuSnbuzoLyshiRICgeCq4Mqj+A5Guf1EI9yKhH4Ya2JH32lIHIwNlfaghvxONylWOVe/TYgrmNA==@vger.kernel.org, AJvYcCUkpBdUZoNaxfppZsG+SbJ5PBczdtKKYgF02jhUDZGzwiG2bOv1OBpU3aXlthShbOSlFW7/6Pnj/xeCIUz4dLYJMhcJV3JQ@vger.kernel.org, AJvYcCWzcsiyS4wgcDA1uP4TJWG9/uQLKkrOmTykVwqBsxXyYsanKkApMieJPeOKGlAL9qr9si18fQdickuK+mu+@vger.kernel.org, AJvYcCXKFTctUgFpcSEXd8g9MvBizlC2Os+dBJyBB4ZLObOUO6R+yRSjwM2cEApSgm76H7wyeYFaFyRj1Etn21Ef@vger.kernel.org
X-Gm-Message-State: AOJu0YwotrSb5N3qPTSOFaiN5nrYPUrYmKkdthkRvRV0AaGn8DY3MPa4
	32IjzwUWY7TjKrDMrJEisf7za8GDvI4Eg5uWzhjHPf544T2zVjl6
X-Gm-Gg: ASbGncuEPIWP6eW23nSFqrhaKDhaTLOUL0To1iLHIXRLh9kZCjmLIQ2NFlbyXEjAxow
	hte75KcSoCXsUevc4AAXkYcfWzjTvtN7ROoYMX7IPGjMA0NbJafzkXChWrLiFcToPgJ1RSFKtOW
	jf60kmF10VtcX/5pcrtSw6GB4Zgw1LfKk/K3Y1C+nodGHQJMBihQPp4so7xFr+6UAyC7tjUAbA0
	nLlX/U8M2+jtMsO7EWAMy9dckg289X6LCPb9n6uXdLyWD+e2l9mSR0a1XjDGT55iafs4ChKWlE5
	I17kbDSg6H6D0wdOPcw7vwrzok42MOlNIRNRW1VHdIBmxVcE9zYx7+lHVf1Vkk/rpc6A0mbZ+7E
	Q2O9Fy72FzcDsbT6S8fOYRteQtAmYXkH5Zw2eMQaat68OViF97YcQkDSE5R2EBtxo0Wa2
X-Google-Smtp-Source: AGHT+IGPS/dXTlSAUgqMyWGzy05kAtY0v8SaSKHbVmoNWKqJ530g0u4yrhTVutuLdWk4A0POPvlmzw==
X-Received: by 2002:a05:6214:21ef:b0:6e8:97f6:3229 with SMTP id 6a1803df08f44-6f4bfbd59b7mr44609636d6.16.1745498814256;
        Thu, 24 Apr 2025 05:46:54 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c08ef1a6sm8960636d6.7.2025.04.24.05.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:46:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: paul@paul-moore.com
Cc: omosnace@redhat.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] vfs,shmem,kernfs: fix listxattr to include security.* xattrs
Date: Thu, 24 Apr 2025 08:46:43 -0400
Message-ID: <20250424124644.4413-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vfs has long had a fallback to obtain the security.* xattrs from the
LSM when the filesystem does not implement its own listxattr, but
shmem/tmpfs and kernfs later gained their own xattr handlers to support
other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
filesystems like sysfs no longer return the synthetic security.* xattr
names via listxattr unless they are explicitly set by userspace or
initially set upon inode creation after policy load. coreutils has
recently switched from unconditionally invoking getxattr for security.*
for ls -Z via libselinux to only doing so if listxattr returns the xattr
name, breaking ls -Z of such inodes.

Before:
$ getfattr -m.* /run/initramfs
<no output>
$ getfattr -m.* /sys/kernel/fscaps
<no output>

After:
$ getfattr -m.* /run/initramfs
security.selinux
$ getfattr -m.* /sys/kernel/fscaps
security.selinux

Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.smalley.work@gmail.com/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 fs/kernfs/inode.c |  8 +++++++-
 fs/xattr.c        | 13 +++++++++++++
 mm/shmem.c        |  8 +++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index b83054da68b3..8fd69e48d32d 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -140,12 +140,18 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(dentry);
 	struct kernfs_iattrs *attrs;
+	ssize_t sz;
 
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
+	sz = simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
+	if (sz >= 0 && sz <= size)
+		sz += security_inode_listsecurity(d_inode(dentry),
+						buf ? buf + sz : NULL,
+						size - sz);
+	return sz;
 }
 
 static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
diff --git a/fs/xattr.c b/fs/xattr.c
index 02bee149ad96..68ac91d0dbc3 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1428,6 +1428,15 @@ static bool xattr_is_trusted(const char *name)
 	return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
 }
 
+static bool xattr_is_maclabel(const char *name)
+{
+	const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
+
+	return !strncmp(name, XATTR_SECURITY_PREFIX,
+			XATTR_SECURITY_PREFIX_LEN) &&
+		security_ismaclabel(suffix);
+}
+
 /**
  * simple_xattr_list - list all xattr objects
  * @inode: inode from which to get the xattrs
@@ -1468,6 +1477,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		if (!trusted && xattr_is_trusted(xattr->name))
 			continue;
 
+		/* skip MAC labels; these are provided by LSM separately */
+		if (xattr_is_maclabel(xattr->name))
+			continue;
+
 		err = xattr_list_one(&buffer, &remaining_size, xattr->name);
 		if (err)
 			break;
diff --git a/mm/shmem.c b/mm/shmem.c
index 99327c30507c..69f664668a3a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4372,7 +4372,13 @@ static const struct xattr_handler * const shmem_xattr_handlers[] = {
 static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
 	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
-	return simple_xattr_list(d_inode(dentry), &info->xattrs, buffer, size);
+	ssize_t sz = simple_xattr_list(d_inode(dentry), &info->xattrs, buffer,
+				size);
+	if (sz >= 0 && sz <= size)
+		sz += security_inode_listsecurity(d_inode(dentry),
+						buffer ? buffer + sz : NULL,
+						size - sz);
+	return sz;
 }
 #endif /* CONFIG_TMPFS_XATTR */
 
-- 
2.49.0


