Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC01084C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 20:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKXTb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 14:31:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44301 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKXTb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 14:31:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so14861233wrn.11;
        Sun, 24 Nov 2019 11:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QG4oMalSJITPl5dzJwFkwS3vwL8ty266LKmX5/+8iyw=;
        b=kH4v/6aEMLaSjEpnVO6zzCLcos7qYMUk+aXF57w/oZ6reKoyCFxVYEIinY8ejNhAmV
         fybNjxT1BY0jWqLemx0FzzrJALVOmCSdmARTUz7rF8q/YGXAHDWPRoJa6znCHux+UiIb
         xjuDYt1Uq2GIo978hvVvjJI/C74QPdY+Dt0O3wlYoxscLlLGYReGXIPrLgWCTF4CuLyC
         VIuKZt+vDCUyZuV9K7Xmib4kxWE4ib7Wxrj9bHf0AoNbFeNvCu0Ub7gicZWjirMKUIof
         nn0myP/sVdCCXtlg4fQ7SbxPoeCIiAU2kGQmD5A25NsxQSxAUCZWyzdBaAHIQNBZKJZi
         sxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QG4oMalSJITPl5dzJwFkwS3vwL8ty266LKmX5/+8iyw=;
        b=IU3EBtlpRneBRV57/iJ6VwFRWfrW4m6b/PeKXDzEvEkJWxxBt+69FxelBEvJwJ1iwV
         XJE0kQIEknY4Hd0Bk4lBAwO2GVs2llGk1eiL0jKYS6M2UZ9qBR1ajFH1Caij3haIVt25
         USCP3DmXnLxqrS2adWVTLBejAEbAXFSUEN9BrtAXzF/tuOlkJABl/ILLk8SuaemCTZuk
         B94WdxxcsHmmLJw3LlTaUaU+NZIE/dNMZGCcnG7eAV/1w8fSAVHbEgWMvE401RS0Ps3I
         P30yl8Ycnlg7qEWQgd8z6VWA6xe07bb9jLBTKakrd+H3mEAfEWO8YdQBAjQCCt8hR2QS
         QzjA==
X-Gm-Message-State: APjAAAUzkVWT11c+jJxPUFIPcF4YepYdXydgSpd3/svR6q4rUqEWwd/v
        xT4vMBj8eLBcn9rtXliW7x4=
X-Google-Smtp-Source: APXvYqyliheZUhfJLstF6Mzl+u5ftSUoN8G+LIaVYsc6nxehrTAiuB5+DOIuz8eKSdR58snkjkVbIQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr5703540wrq.196.1574623914141;
        Sun, 24 Nov 2019 11:31:54 -0800 (PST)
Received: from localhost.localdomain ([94.230.83.228])
        by smtp.gmail.com with ESMTPSA id p9sm7314317wrs.55.2019.11.24.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 11:31:53 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH] utimes: Clamp the timestamps in notify_change()
Date:   Sun, 24 Nov 2019 21:31:45 +0200
Message-Id: <20191124193145.22945-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Push clamping timestamps down the call stack into notify_change(), so
in-kernel callers like nfsd and overlayfs will get similar timestamp
set behavior as utimes.

Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 42e729b9ddbb ("utimes: Clamp the timestamps before update")
Cc: stable@vger.kernel.org # v5.4
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Arnd,

This fixes xfstest generic/402 when run with -overlay setup.
Note that running the test requires latest xfstests with:
 acb2ba78 - overlay: support timestamp range check

I had previously posted a fix specific for overlayfs [1],
but Miklos suggested this more generic fix, which should also
serve nfsd and other in-kernel users.

I tested this change with test generic/402 on ext4/xfs/btrfs
and overlayfs, but not with nfsd.

Jeff, could you ack this change is good for nfsd as well?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20191111073000.2957-1-amir73il@gmail.com/

 fs/attr.c   | 5 +++++
 fs/utimes.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index df28035aa23e..e8de5e636e66 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -268,8 +268,13 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	attr->ia_ctime = now;
 	if (!(ia_valid & ATTR_ATIME_SET))
 		attr->ia_atime = now;
+	else
+		attr->ia_atime = timestamp_truncate(attr->ia_atime, inode);
 	if (!(ia_valid & ATTR_MTIME_SET))
 		attr->ia_mtime = now;
+	else
+		attr->ia_mtime = timestamp_truncate(attr->ia_mtime, inode);
+
 	if (ia_valid & ATTR_KILL_PRIV) {
 		error = security_inode_need_killpriv(dentry);
 		if (error < 0)
diff --git a/fs/utimes.c b/fs/utimes.c
index 1ba3f7883870..090739322463 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -36,14 +36,14 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 		if (times[0].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_ATIME;
 		else if (times[0].tv_nsec != UTIME_NOW) {
-			newattrs.ia_atime = timestamp_truncate(times[0], inode);
+			newattrs.ia_atime = times[0];
 			newattrs.ia_valid |= ATTR_ATIME_SET;
 		}
 
 		if (times[1].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_MTIME;
 		else if (times[1].tv_nsec != UTIME_NOW) {
-			newattrs.ia_mtime = timestamp_truncate(times[1], inode);
+			newattrs.ia_mtime = times[1];
 			newattrs.ia_valid |= ATTR_MTIME_SET;
 		}
 		/*
-- 
2.17.1

