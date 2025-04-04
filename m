Return-Path: <linux-fsdevel+bounces-45710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B9DA7B6A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 05:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0935F1773F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 03:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ABF13BC35;
	Fri,  4 Apr 2025 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOh6kZl1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251624689;
	Fri,  4 Apr 2025 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743737444; cv=none; b=UcG7Nrlgh5GdEJ7pAOGSPFSXD5nyU7FQfaWx2EhoYy5nEZEeT7h9rYnjP5EAvuoi1YruHaolNhE3DW8cdzmiTs6G8M1uDLblV63Cc6/KneytZQdq2v6TVj1rHcGjKxManccyY1QX6JqmmjKHaKfIbFHpsmukdA+rMhIvRSLgJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743737444; c=relaxed/simple;
	bh=U6jZ1m6RvzZ1InzjbMV1o6OWZGRc7mf7MBIOIM0DQFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WG6PHKxNn1OcnjFOmg54WOxemyp/epmgN8cq++t9copFSQIx/kYUjncW36Rj7lj1OUBoxegbum3DcGzD/De+E24ClzOS5it+m9Icngc6f7cQ/APdxQIaMwlD7sJtb3dx7AZuFDXHBCg05sc5Lu4XkNagikGoljvq2rLnAD7FYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOh6kZl1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22438c356c8so16935635ad.1;
        Thu, 03 Apr 2025 20:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743737442; x=1744342242; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c9+F07hHySKl7rcmqOAuuqBan5yT29cru9Aq9XN81Dc=;
        b=KOh6kZl1soRoumg0K8VvumBG5vONZkDtVSXzjeJ2OjEeAiOTps22Eajrch5Y9PbIl4
         C7Yuwn9Lv7Pn5SpfNXKto3sLVcjZAE484hXlcnJ+8kFThfBVjVoLiHNTCQJflV1lRowM
         uBQc4ZvwFpWF9kmiBLuD745D+/PRjAa6/RR3UfmuDMcb5y4sGm4Q9h4nPD0p7GYT/Oa4
         fmyp6hwzohm+xM12/tml6saTLVN+r8AKLb2+u7yTF1JV3UZhMbY1zO8fVKgOiv1UdOGa
         9cJ98A9k8vj0aEcuyDSDrcgbzET3iWkVqd4Gi1bualTovhMM0vvFvyMVD/IyI8AIcfQt
         A7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743737442; x=1744342242;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9+F07hHySKl7rcmqOAuuqBan5yT29cru9Aq9XN81Dc=;
        b=YzcwUFxxu0x+Uqt4x7vylEmSn6Qi2kgGJaaIfiRvEr3YtiCYDYgJ9yXdVp12/fopx1
         2+WVUQ9K/X/yP8UrH/LkhB7PJZcFW4HNZ0IBZ4/L1bY8ggqYzYIT2QpLYYbZjR3xY8hx
         AupymEyfWoNFULsXZ18B93BYOD/9/GJ6YQk9JaS4eUbO7Gp2gxRUjKYmb6ABOcDZxw1U
         f+vlCay7LJEKKoqzpiu6BR/jPWy0DtafKgvO2Tn74u+d7cqDT78cevmiCKAln2Xls+qn
         BCRCx62ANh1spaM02nW3RpIn+MN7oZ9vq/aHt9Kr1lv1qGhnGLwe8Oy482MUI5j0mbyT
         oJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJXDoGTq6wOY1ez3GEVX0IumSkGKarvwZvsMLKKXi5BE+xOzU1hdQCa1lLyF0EVoe6oARzi1D4Fh1a8pIV@vger.kernel.org, AJvYcCX4kq0r+hd/Fjrdhe9eAvG5vmSb8kGqQ0tpzCsN8imNInc3tiVAuB/h2CYTfzZwmVI2rQ6K+TK0Zu1xpMy/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfx0/WM38zs36eNLf7+64MXrZFwVzZjJuBHaWrxElLeA0SfJEy
	BH8Oct+oRd3QP7KsmqG18q8wuC/ghFKyvFX9RADsUgPQtkrhtzp6
X-Gm-Gg: ASbGncvKBy17LruWoHPDcaURXNIHe5YJMNZ9fwEkrPr8H2nWQoGqpXrHQTNcaiiU6eH
	odHDfLRRuMNnwuTKUVflsgHkZxqXFxpvcbR7xx/QQ14Uz2evggw8qmnmjwaYS84charp6Imxk8e
	6c8By7V0oVAmxMiCWUIenmI80oOLL7e57bEC5+Dwd9TWwgC3bESeDPc5ntcMjCV/wBjF3+APvQo
	KcmEZY8PzP53rTh65DdHzuVBsSux15p0nMFdCtUrYqAsaKWBdkhTG/58dS3NrFIufGih5m7/sIt
	VOfgMYByhyki4v+Fjgh1oXg9918AtxffHKlpVy6ivEW39TzRo0LPaAbPVTjKEKmobzuAdUjF0w=
	=
X-Google-Smtp-Source: AGHT+IEgeQ407XLGOrhxRYOGPTsZsuRQaFfo0nI65E1FCRzLsQHBHp4w0lq1ECU18jA0nfC+N2J8KQ==
X-Received: by 2002:a17:902:e805:b0:223:4bd6:3863 with SMTP id d9443c01a7336-22a8a85a489mr18067515ad.10.1743737442247;
        Thu, 03 Apr 2025 20:30:42 -0700 (PDT)
Received: from localhost.localdomain ([221.214.202.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787778efsm22305745ad.259.2025.04.03.20.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 20:30:41 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: mjguzik@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	superman.xpt@gmail.com,
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v2] vfs: Fix anon_inode triggering VFS_BUG_ON_INODE in may_open()
Date: Thu,  3 Apr 2025 20:29:38 -0700
Message-Id: <20250404032938.76632-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <iufbqsvdp52sgpsjkyulfqgfpvksev3guds5hd556q7zxestgq@ixog46pumnry>
References: <iufbqsvdp52sgpsjkyulfqgfpvksev3guds5hd556q7zxestgq@ixog46pumnry>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Some anon_inodes do not set the S_IFLNK, S_IFDIR, S_IFBLK, S_IFCHR,
S_IFIFO, S_IFSOCK, or S_IFREG flags after initialization. As a result,
opening these files triggers VFS_BUG_ON_INODE in the may_open() function.

Here is the relevant code snippet:

    static int may_open(struct mnt_idmap *idmap, const struct path *path,
                int acc_mode, int flag)
    {
            ...
            switch (inode->i_mode & S_IFMT) {
            case S_IFLNK:
            case S_IFDIR:
            case S_IFBLK:
            case S_IFCHR:
            case S_IFIFO:
            case S_IFSOCK:
            case S_IFREG:
            default:
                    VFS_BUG_ON_INODE(1, inode);
                    ~~~~~~~~~~~~~~~~~~~~~~~~~~
            }
            ...
    }

To address this, we modify the code so that only non-anon_inodes trigger
VFS_BUG_ON_INODE, and we also check MAY_EXEC.

To determine if an inode is an anon_inode, we consider two cases:

  1. If the inode is the same as anon_inode_inode, it is the default
     anon_inode.
  2. Anonymous inodes created with alloc_anon_inode() set the S_PRIVATE
     flag. If S_PRIVATE is set, we consider it an anonymous inode.

The bug can be reproduced with the following code:

    #include <stdio.h>
    #include <unistd.h>
    #include <fcntl.h>
    #include <sys/timerfd.h>
    int main(int argc, char **argv) {
            int fd = timerfd_create(CLOCK_MONOTONIC, 0);
            if (fd != -1) {
                    char path[256];
                    sprintf(path, "/proc/self/fd/%d", fd);
                    open(path, O_RDONLY);
            }
            return 0;
    }

Finally, after testing, anon_inodes no longer trigger VFS_BUG_ON_INODE.

Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@google.com"
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
V1 -> V2: added MAY_EXEC check, added some comments

 fs/anon_inodes.c            | 12 ++++++++++++
 fs/namei.c                  |  8 +++++++-
 include/linux/anon_inodes.h |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 583ac81669c2..bf124d53973e 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -303,6 +303,18 @@ int anon_inode_create_getfd(const char *name, const struct file_operations *fops
 	return __anon_inode_getfd(name, fops, priv, flags, context_inode, true);
 }
 
+/**
+ * is_default_anon_inode - Checks if the given inode is the default
+ * anonymous inode (anon_inode_inode)
+ *
+ * @inode: [in] the inode to be checked
+ *
+ * Returns true if the given inode is anon_inode_inode, otherwise returns false.
+ */
+inline bool is_default_anon_inode(const struct inode *inode)
+{
+	return anon_inode_inode == inode;
+}
 
 static int __init anon_inode_init(void)
 {
diff --git a/fs/namei.c b/fs/namei.c
index 360a86ca1f02..e8cc00a7c31a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -40,6 +40,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/anon_inodes.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -3429,7 +3430,12 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 			return -EACCES;
 		break;
 	default:
-		VFS_BUG_ON_INODE(1, inode);
+		if (!is_default_anon_inode(inode)
+			&& !(inode->i_flags & S_PRIVATE))
+			VFS_BUG_ON_INODE(1, inode);
+		if (acc_mode & MAY_EXEC)
+			return -EACCES;
+		break;
 	}
 
 	error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index edef565c2a1a..eca4a3913ba7 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -30,6 +30,7 @@ int anon_inode_create_getfd(const char *name,
 			    const struct file_operations *fops,
 			    void *priv, int flags,
 			    const struct inode *context_inode);
+bool is_default_anon_inode(const struct inode *inode);
 
 #endif /* _LINUX_ANON_INODES_H */
 
-- 
2.17.1


