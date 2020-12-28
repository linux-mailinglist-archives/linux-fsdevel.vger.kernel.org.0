Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D882E6C4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Dec 2020 00:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgL1Wzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgL1Up2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:45:28 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8026C0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 12:44:47 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g3so6171469plp.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 12:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46zWNq1MQMAllPErESq+P0d3wb/+jK7l73bBEn1MKsw=;
        b=ULQrG5MLVRY0Vzr34XFrkm3y61mmJ5AIS4J3bNrtIG1AIchd+p7ay3R7CbXRclN8uZ
         M6UeZQrH5oUiOCriZCg/UIiQDgd2JN5KLqd9nEs81cSqo5rI+PVH6kv0v+k6Yl5MCUjV
         09OOnYx+vrVOj+ICiXMmKDiBDca8BE0gsq5OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46zWNq1MQMAllPErESq+P0d3wb/+jK7l73bBEn1MKsw=;
        b=kOdRSmuW/OePX9auM2+MCPBLW8lJv4sPTvdmCuabFhWLT2qFDIpLGV08FkUXJqv1fH
         kRsiHY9liIgQxDPa+Q592l+B/kQN7aqC8LVhPKcBdqhgHvtwd/IuMth7GF3h4aIs8xYS
         vNTR+cX1sRtmJpRpHFYeOZ0HnY4l+iX8gpNdu8A+c7Z56BGWhJvnsuJz8bc2j/YKP6s7
         LT93kUVGCb7y+gzkOALogk1622r0GpRKLHHdCFwojJv0J6zEIhB4lApQcATSv2Z+Rnpn
         pkgiXRkgx3ObKd5KLYxaoTldH2RnAxWiTOE+QsD31MEtlqRvR/F0Gbew4wBbnbXTRw6V
         yI0A==
X-Gm-Message-State: AOAM530foPp25R2E+E2AoxSA2Dh509+Xor3ltwUE7TGaZUpkJtCE7Wpd
        jotLC64xeu0gM+tIURuPsh93jPsMb1UEEAAAt88=
X-Google-Smtp-Source: ABdhPJxzW5BNpGbiIkly/rGtsowvBDABW0hzn/xoLQGi8JxAkFaLtLng/NVzkkuRgLFRoydQzclBJQ==
X-Received: by 2002:a17:90b:24c:: with SMTP id fz12mr668157pjb.138.1609188287184;
        Mon, 28 Dec 2020 12:44:47 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b129sm37843077pgc.52.2020.12.28.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 12:44:46 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kyle Anderson <kylea@netflix.com>,
        Manas Alekar <malekar@netflix.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Rob Gulewich <rgulewich@netflix.com>,
        Zoran Simic <zsimic@netflix.com>, stable@vger.kernel.org
Subject: [RESEND PATCH] fs: Validate flags and capabilities before looking up path in ksys_umount
Date:   Mon, 28 Dec 2020 12:44:38 -0800
Message-Id: <20201228204438.1726-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ksys_umount was refactored to into split into another function
(path_umount) to enable sharing code. This changed the order that flags and
permissions are validated in, and made it so that user_path_at was called
before validating flags and capabilities.

Unfortunately, libfuse2[1] and libmount[2] rely on the old flag validation
behaviour to determine whether or not the kernel supports UMOUNT_NOFOLLOW.
The other path that this validation is being checked on is
init_umount->path_umount->can_umount. That's all internal to the kernel.

[1]: https://github.com/libfuse/libfuse/blob/9bfbeb576c5901b62a171d35510f0d1a922020b7/util/fusermount.c#L403
[2]: https://github.com/karelzak/util-linux/blob/7ed579523b556b1270f28dbdb7ee07dee310f157/libmount/src/context_umount.c#L813

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Fixes: 41525f56e256 ("fs: refactor ksys_umount")
---
 fs/namespace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cebaa3e81794..dc76f1cb89f4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1710,10 +1710,6 @@ static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
 
-	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
-		return -EINVAL;
-	if (!may_mount())
-		return -EPERM;
 	if (path->dentry != path->mnt->mnt_root)
 		return -EINVAL;
 	if (!check_mnt(mnt))
@@ -1746,6 +1742,12 @@ static int ksys_umount(char __user *name, int flags)
 	struct path path;
 	int ret;
 
+	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
+		return -EINVAL;
+
+	if (!may_mount())
+		return -EPERM;
+
 	if (!(flags & UMOUNT_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 	ret = user_path_at(AT_FDCWD, name, lookup_flags, &path);
-- 
2.25.1

