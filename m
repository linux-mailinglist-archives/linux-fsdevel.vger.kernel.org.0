Return-Path: <linux-fsdevel+bounces-45587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3991FA799DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 04:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C273189318F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500EC14EC46;
	Thu,  3 Apr 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ3L3+FL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47538610B;
	Thu,  3 Apr 2025 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743645650; cv=none; b=qKrDXnSlPYXicWwW5IpxAp4IeKtrtq4/nZ827evc7XzGIDHc5xU6pX9xeQVUNUzCtaGBEh99+qQQJEgXAWDtpVE3AWoHQXXLGWwDTLxyD98gc4/vRB43BfIC7F15UBtNhT2CMgCdcC/q9opF21z68pdNeH8i8FtU0Vub4luqdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743645650; c=relaxed/simple;
	bh=0ba+sRGF2jAkbc+QseTQRVmQ9JgKzPa2R2booIqtf0U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H2Bvan61P6FLEtU8LYe+lsTdn+8aYWn6LpH7MDEteTNjHz2vaQ/fSnMBxID8LkNhZakrk+WIUihhAa0pVS6ltNf4tD5KJ5xFmzEeQM4ixGAqW2iGqVhnwZszcJH2HhkLxJ3DISV2NR0oy1su/S8AOEhZO0DmWLd1pF5/9Y1ry3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ3L3+FL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301e05b90caso381490a91.2;
        Wed, 02 Apr 2025 19:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743645648; x=1744250448; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcde5Nyi6TaMVAZ5o62Gx5sjG4xeY8R/Cdn03wkDkWw=;
        b=YQ3L3+FLKFcQl6XiBmS+nezQPQVoXoGztN/6YCD4IulVs/KU0IrtaMtdGvTt1+451y
         GdVNtOQXzBaBazKoo49xmMB/2ruCKNm3XeYiSN6H55MiYrGOmc6n8HNiRkNBhxQIocRn
         ipXlT0fdamXMU7rwIj4/F/ddjVKBNbvm+nLegIZGwlNpbYnF6jr4nI01uCEPwiQk+ALS
         i9JvaoUheh3zfeekE8Cw2x0Ot1Ter5yJMJ5Dc3tq5/X8dsD9SfxqqfD3sGU2/6XI2CnA
         +lF9q5z5CG3s6+8SsXzdAsyFq46F5wUsOAZrrFHXHHYCLjQzojIrGOp1Vlcazzxct2t5
         0FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743645648; x=1744250448;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcde5Nyi6TaMVAZ5o62Gx5sjG4xeY8R/Cdn03wkDkWw=;
        b=Uli1unKBSg4x9KanwDxVBzyaTJsnQj1UpczVla5rkBpqWk4xGyM21T96fFNNrdJs8O
         A9ite7rgHf7ySOpSavktHm5SM691FSIrxSh6I8p5vHUcr1jB0IXIrjsQCNVMDqxCkA9+
         VLF6GWNSvdAYCE3VZ2vBOaOVzYP4vHyAW/NGxu/6Fv8WfzxCzvP/CLT5t8vaLIk9C5wE
         +PPwP2BTvLthlYogbCFM9/cUEtZvR3SrJdKtsuirYRpt03zCHccGfpM1lngotAisElGO
         tp59Z+C4cpaj0nCMpy1Rp0tBQqXBVHt0Zm/DHu1tPojoe+c8CdPMVanvPDBYFWBmBCfQ
         z78A==
X-Forwarded-Encrypted: i=1; AJvYcCUjFBJDDAnFcMR2mcu/Oom2kUKIdFlV8t349zMaUrPgVcdLHfrjUe4N572NrVGJLF/P7byqPYmJakpGCygY@vger.kernel.org, AJvYcCUqAi8vZ0U/tWbqwqw/PVbxxQ102OPYVu/zUct2Wc5MZgdplM2L99pAYPT0nWe94l9l3GLoVswm1h4NF7dX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjw0E5PTjAGFHzlbBbxnx2uEN0qwyFv9dGD49PrhO5Top2gVxo
	3oX3XRVrTjz8kv4aRFE0R2az4yIIZ9gGXgQ3b6/WZsxY/yyMHro1
X-Gm-Gg: ASbGnctQIKkMxfDLsWqw28g8nxaCbWNnO2P6avKzXvnduwBPMwIAwZ5avjjyH+oJ/0Z
	j83IsTSLtoMVLWtln/4cZ4nuqc2vb6Y+LGwIbLd/F6TCOvVWc30wtdt/2o9W1QKSaDParq6ogt2
	6FZDlj+glGCECv7yV4lAFoHoGQdOCogOsUJz7GHkD7Uc4j8w2OIXWsOk4pXIS9n8XD+mIecSxDz
	TCD7GX7NkRtdIArjMrIDF7jz/26ykUgdiOtwgyWoms41FACNOMeFGq71aVnTA3hGQbCMwXdsJxL
	xMTP/IWHSgxiEUx5sF9+JOag7wCGVpGXKrsLJSAgbSEi8x3FhfsBPHSAsn+bwfE1XlLh1CfyBA=
	=
X-Google-Smtp-Source: AGHT+IHuQHtWHcO53kS5e5zZEuKi16tpySHAaverruz/vmyToXsfN39bOqzs8qlfsj43naZCs0Vs6w==
X-Received: by 2002:a17:90b:51c7:b0:2ff:72f8:3708 with SMTP id 98e67ed59e1d1-3057cb39169mr1470671a91.17.1743645648421;
        Wed, 02 Apr 2025 19:00:48 -0700 (PDT)
Received: from localhost.localdomain ([221.214.202.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb8dda5sm385727a91.40.2025.04.02.19.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 19:00:47 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com,
	Penglei Jiang <superman.xpt@gmail.com>
Subject: [PATCH 2/2] vfs: Fix anon_inode triggering VFS_BUG_ON_INODE in may_open()
Date: Wed,  2 Apr 2025 18:59:46 -0700
Message-Id: <20250403015946.5283-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

may_open()
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
        }
        ...
}

Since some anonymous inodes do not have S_IFLNK, S_IFDIR, S_IFBLK,
S_IFCHR, S_IFIFO, S_IFSOCK, or S_IFREG flags set when created, they
end up in the default case branch.

When creating some anon_inode instances, the i_mode in the switch
statement is not properly set, which causes the open operation to
follow the default branch when opening anon_inode.

We could check whether the inode is an anon_inode before VFS_BUG_ON_INODE
and trigger the assertion only if it's not. However, a more reasonable
approach might be to set a flag during creation in alloc_anon_inode(),
such as inode->i_flags |= S_ANON, to explicitly mark anonymous inodes.

The code that triggers the BUG:

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

Thank you!

Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@google.com"
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 fs/anon_inodes.c            | 4 ++++
 fs/namei.c                  | 5 ++++-
 include/linux/anon_inodes.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 583ac81669c2..c29eca6106d2 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -303,6 +303,10 @@ int anon_inode_create_getfd(const char *name, const struct file_operations *fops
 	return __anon_inode_getfd(name, fops, priv, flags, context_inode, true);
 }
 
+inline bool is_default_anon_inode(const struct inode *inode)
+{
+    return anon_inode_inode == inode;
+}
 
 static int __init anon_inode_init(void)
 {
diff --git a/fs/namei.c b/fs/namei.c
index 360a86ca1f02..81cea4901a2f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -40,6 +40,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/anon_inodes.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -3429,7 +3430,9 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 			return -EACCES;
 		break;
 	default:
-		VFS_BUG_ON_INODE(1, inode);
+		if (!is_default_anon_inode(inode)
+			&& !(inode->i_flags & S_PRIVATE))
+			VFS_BUG_ON_INODE(1, inode);
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


