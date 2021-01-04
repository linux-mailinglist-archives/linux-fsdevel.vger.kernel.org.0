Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC662EA0D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 00:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhADXaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 18:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbhADXaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:30:52 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE57C061795
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jan 2021 15:30:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id hk16so569489pjb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jan 2021 15:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfLp24TIh/SK3eveJWpwVSs8JsQPedAkqnYyRzM6i/E=;
        b=LF2YwwtIXDuK8UwqLyfIcaYPTy3TzccRLiJWztAkNea/6+B/SIjv8ihAufVpiBi4Jq
         78opLO1Sm+lpCEAA1Zag//b+WHYOa+QgQKzWulhebUXV4UmAzNpwTnU2m/lr8D/qx8/n
         aW8EBcfhGZ3D7gl5djK2sUMHe30w5kQGGKPEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfLp24TIh/SK3eveJWpwVSs8JsQPedAkqnYyRzM6i/E=;
        b=ZIagJYa8mstYC+HT6cBLhlNmDpBik3CMdB6aY0cihc0wsx2LynYojiNvWqba2ghumG
         zd/NrySFsYMaxIwfXqXzCa2rJLvp2OmmREg/9iBSM5pA9T21F1MqVYKx4Vk6kULxbMzw
         ggWQUbVEgKitZVgxYxyG/G5B0bjrWVBGzXatCA0nJ8XgBuaXg88CYTX0hZ6Hz7mmjlFI
         oGPzFCdOlDLi+rjkE5yioYIDFFqalQE3nyE3ubc0kj8gkBnOaPPsq9fr+z/JNU0gnyFM
         Pnzc3K34vXQwHOMybS7za7vjamibEnI8z14IMn/8OPSQUm7OdrBNhhKd06O07+a/cgNT
         r78g==
X-Gm-Message-State: AOAM533I8Xe/5Uu9NuOWu0KAH605KvIqWUOwyBj28q5mp3tx8nUvONkz
        GkJUsfC89mxwoEI/IA6rXBclqt5VxR9ipGTi
X-Google-Smtp-Source: ABdhPJxdTMt66p4c6f3Rf9V54y7mtfnp7MA4ljeEQiInYcxuJT+Ov18Ei0wjmalBGBtqV4Dbl1SNMw==
X-Received: by 2002:aa7:8d8b:0:b029:19e:1081:77af with SMTP id i11-20020aa78d8b0000b029019e108177afmr66242908pfr.78.1609797255745;
        Mon, 04 Jan 2021 13:54:15 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id n7sm56765924pfn.141.2021.01.04.13.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 13:54:15 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kyle Anderson <kylea@netflix.com>,
        Manas Alekar <malekar@netflix.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Rob Gulewich <rgulewich@netflix.com>,
        Zoran Simic <zsimic@netflix.com>, stable@vger.kernel.org
Subject: [PATCH v2] fs: Validate umount flags before looking up path in ksys_umount
Date:   Mon,  4 Jan 2021 13:54:07 -0800
Message-Id: <20210104215407.10161-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ksys_umount was refactored to into split into another function
(path_umount) to enable sharing code. This changed the order that flags and
permissions are validated in, and made it so that user_path_at was called
before validating flags.

Unfortunately, libfuse2[1] and libmount[2] rely on the old flag validation
behaviour to determine whether or not the kernel supports UMOUNT_NOFOLLOW.
The other path that this validation is being checked on is
init_umount->path_umount->can_umount. That's all internal to the kernel. We
can safely move flag checking to ksys_umount, and let other users of
path_umount know they need to perform their own validation.

[1]: https://github.com/libfuse/libfuse/blob/9bfbeb576c5901b62a171d35510f0d1a922020b7/util/fusermount.c#L403
[2]: https://github.com/karelzak/util-linux/blob/7ed579523b556b1270f28dbdb7ee07dee310f157/libmount/src/context_umount.c#L813

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Fixes: 41525f56e256 ("fs: refactor ksys_umount")
---
 fs/namespace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cebaa3e81794..752f82121dd4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1710,8 +1710,6 @@ static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
 
-	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
-		return -EINVAL;
 	if (!may_mount())
 		return -EPERM;
 	if (path->dentry != path->mnt->mnt_root)
@@ -1725,6 +1723,13 @@ static int can_umount(const struct path *path, int flags)
 	return 0;
 }
 
+
+/*
+ * path_umount - unmount by path
+ *
+ * path_umount does not check the validity of flags. It is up to the caller
+ * to ensure that it only contains valid umount options.
+ */
 int path_umount(struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
@@ -1746,6 +1751,10 @@ static int ksys_umount(char __user *name, int flags)
 	struct path path;
 	int ret;
 
+	/* Check flag validity first to allow probing of supported flags */
+	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
+		return -EINVAL;
+
 	if (!(flags & UMOUNT_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 	ret = user_path_at(AT_FDCWD, name, lookup_flags, &path);
-- 
2.25.1

