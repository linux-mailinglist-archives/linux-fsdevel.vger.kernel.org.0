Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C0D344CE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 18:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhCVRLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhCVRLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:11:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A558DC061574;
        Mon, 22 Mar 2021 10:11:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so17953081wrt.8;
        Mon, 22 Mar 2021 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPEpEZgdFBNuAySe33wXUxS0c6QSZ5Fcq/SWTX6m1/c=;
        b=crMqOcSSN0otgZYG8RYbdA5tgD/jzTplIRXBtlG4vOv+5IDPOF6nc8dyz8dK3UWYj4
         WVkBuZgvjIzxVwdjISbsYKHXdgoFH6vFWnWiHoDnGDoDT3E76HxaD5lwlBk2f62JGW+L
         Ndvi120N1oa7+CC29/6Mvj8+4voIe09KY+T02GykLug9gEo+rlj7txI+LS2JKWuaAP0Z
         MdroSVeCncJdyoHKAJR3+b5HEiaTKG1hGRgzETNZXc/wbULCFoiwNN5gGj4uyAuC63sq
         4qf+WVYW8hPt2AM+rW4M4tcuudtef+2rzcG0MpRpZyXOnFHW2v3Gqrx/85uWdLd0PXqw
         gGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPEpEZgdFBNuAySe33wXUxS0c6QSZ5Fcq/SWTX6m1/c=;
        b=eKff2+Cl4TWKXmRF8gifUtXvUY4FHeaIfHru53lvdOveKvdEPfU+2VSNEJnyM8Tr16
         SDNUt2o++VkMsbg4aIVQTBUE0YEMcz60NLZGQf3bfJ3ZtG1NI78a3QBc/aLd+9DZs8Q5
         hZZSCA4fAaRkIfgO0O8UVrB1I70wYDSDK7u+p1Uew/LEIcG+c580dcXLRQ5ov6iOKEiI
         Mh0I2I7Aii6DIwXUx9E9Qxk5Y7I7OY2i/HwUFwCGZVEl3Ixgj/kMLgn1+C236SGB3A4U
         QM78HxjJgQ/HfnP5nVbDp4kHNz5F1oKdJOEq8jI96PTzEvfEXqOsgS8VCTyxnj/nBoCB
         REdQ==
X-Gm-Message-State: AOAM533rvDOff4IGV6LMTR4epSh+7Z7/migw6qq+z/6r4otvomHnwk0H
        crD6dnIVzUKowBGgGJEz3+Q=
X-Google-Smtp-Source: ABdhPJx7b06btMqKpp1MNA9IjMnV7fQ1dYB3ciPRnHJNX6umMi9KLCwXh/fyKmch7fFCwo5RbO4tlg==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr605282wrn.200.1616433082388;
        Mon, 22 Mar 2021 10:11:22 -0700 (PDT)
Received: from localhost.localdomain ([141.226.241.101])
        by smtp.gmail.com with ESMTPSA id j9sm55119wmi.24.2021.03.22.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:11:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH] xfs: use a unique and persistent value for f_fsid
Date:   Mon, 22 Mar 2021 19:11:18 +0200
Message-Id: <20210322171118.446536-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some filesystems on persistent storage backend use a digest of the
filesystem's persistent uuid as the value for f_fsid returned by
statfs(2).

xfs, as many other filesystem provide the non-persistent block device
number as the value of f_fsid.

Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
for identifying objects using file_handle and f_fsid in events.

The xfs specific ioctl XFS_IOC_PATH_TO_FSHANDLE similarly attaches an
fsid to exported file handles, but it is not the same fsid exported
via statfs(2) - it is a persistent fsid based on the filesystem's uuid.

Use the same persistent value for f_fsid, so object identifiers in
fanotify events will describe the objects more uniquely.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Guys,

This change would be useful for fanotify users.
Do you see any problems with that minor change of uapi?

The way I see it, now f_fsid of an xfs filesystem can change on reboots.
With this change, it will change once more and never more.

I did not find any kernel internal user other than fanotify and as for
userland expectations, there should not be much expectations from the
value of f_fsid as it is persistent for some filesystems and bdev number
for others - there is no standard.

Thanks,
Amir.

 fs/xfs/xfs_super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e5e0713bebcd..37f8417b78c4 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -790,7 +790,7 @@ xfs_fs_statfs(
 	struct xfs_mount	*mp = XFS_M(dentry->d_sb);
 	xfs_sb_t		*sbp = &mp->m_sb;
 	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
-	uint64_t		fakeinos, id;
+	uint64_t		fakeinos;
 	uint64_t		icount;
 	uint64_t		ifree;
 	uint64_t		fdblocks;
@@ -800,8 +800,8 @@ xfs_fs_statfs(
 	statp->f_type = XFS_SUPER_MAGIC;
 	statp->f_namelen = MAXNAMELEN - 1;
 
-	id = huge_encode_dev(mp->m_ddev_targp->bt_dev);
-	statp->f_fsid = u64_to_fsid(id);
+	statp->f_fsid.val[0] = mp->m_fixedfsid[0];
+	statp->f_fsid.val[1] = mp->m_fixedfsid[1];
 
 	icount = percpu_counter_sum(&mp->m_icount);
 	ifree = percpu_counter_sum(&mp->m_ifree);
-- 
2.25.1

