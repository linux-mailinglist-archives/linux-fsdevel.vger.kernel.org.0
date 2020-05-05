Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBDD1C5253
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgEEJ7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728711AbgEEJ7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8rdsU7VZlRrvrCy7TVxgch3DiKXm2iP3D5AkhKRxD0=;
        b=OQED2cmoNVrYcuKsZNbYtMwcYa6Alolxb37gvPMh+3DmSxnVLHVb1hspQGNm4EBW39Nb3R
        mx84EklOEqWRGs6ae4IhcU5X/v9esnoL5y12VuS3XnDeUOnZTL8Fv7znlvT3vDkZ+qNxV+
        quJGWbszcnaelDUcOQ2VF1UxvbpSLcw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-u09qFy-VPR2MLiE96o_Rlg-1; Tue, 05 May 2020 05:59:29 -0400
X-MC-Unique: u09qFy-VPR2MLiE96o_Rlg-1
Received: by mail-wm1-f69.google.com with SMTP id d134so1061591wmd.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8rdsU7VZlRrvrCy7TVxgch3DiKXm2iP3D5AkhKRxD0=;
        b=H6bh6GYROCMYDr6KQeBMxScTYCzda1AGonQCuPelthAbAWQAcdobk+P+2DotCn3BtT
         z0jTSBW7UlqUeXv5g16whu10MHN3dCuuTqou2ZaPSvBpxKN5TmMx8GxyRmXDHD+UsVBv
         D8xF0t3cS6Qm4DP67P0Hx4a5GBKNLwsY38+2omOgXIL53mkHfGGIUAC+dmiCD8P9ulAF
         YjHH9hqpKU9Xxzr0nfYNMul+D2hc53dy+tHKtBkS49Qf5K0yX2BNLrm7wJi7MPtOKogV
         IuyYNBmxKI+04+xEderS2Xc4fv1ohkdbIz/Wuk5RQtyUuihnYiAniKeWd6VD+z3Mf1zi
         A88A==
X-Gm-Message-State: AGi0PuZdmRkAxQWG20Mrb6E8eiJSZSpQ/3CDXXgCxuao/tNAT3ci82oL
        dqA2iyHx3a4N5VfHHO2Oco6SbWJNefFiyg6FF/Pc0Dsxc4KJc2po3aopX7a94ae1/ebJKXlKtqW
        UB91cA2tCDrYhVeX5ckPzw6teqQ==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr2738371wml.51.1588672768134;
        Tue, 05 May 2020 02:59:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfyjkJgtaL4+LYdjW3wXxe6/c3F3UG4eo50ES+PNrmSRTsI9MSxsol/Rbw3fB96SggYG9J8w==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr2738350wml.51.1588672767972;
        Tue, 05 May 2020 02:59:27 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:27 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Lennart Poettering <mzxreary@0pointer.de>,
        "J . Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH 09/12] statx: add mount_root
Date:   Tue,  5 May 2020 11:59:12 +0200
Message-Id: <20200505095915.11275-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Determining whether a path or file descriptor refers to a mountpoint (or
more precisely a mount root) is not trivial using current tools.

Add a flag to statx that indicates whether the path or fd refers to the
root of a mount or not.

Reported-by: Lennart Poettering <mzxreary@0pointer.de>
Reported-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/stat.c                 | 3 +++
 include/uapi/linux/stat.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 3d88c99f7743..b9faa6cafafe 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -202,6 +202,9 @@ int vfs_statx(int dfd, const char __user *filename, int flags,
 	error = vfs_getattr(&path, stat, request_mask, flags);
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
+	if (path.mnt->mnt_root == path.dentry)
+		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
+	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index d81456247f10..6df9348bb277 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -181,6 +181,7 @@ struct statx {
 #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
 #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
+#define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 
 
-- 
2.21.1

