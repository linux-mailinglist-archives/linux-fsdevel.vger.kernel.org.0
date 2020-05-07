Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3704B1C845D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgEGIJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGIJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 04:09:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB309C061A41;
        Thu,  7 May 2020 01:09:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z8so5205203wrw.3;
        Thu, 07 May 2020 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=xV3Ps0RsdCVhfxWoq/YPpZZAsZRZc/1bRKCvZXY1C2s=;
        b=f1l63tFzPYekUF5/P/qZk8XOI5QYNw6EkCD1pgFct2Oun2QZOeS/oz4CVT0hZ8lhUr
         h839qr7rMRncHscWHM3CRjhaHSE6XTFCN6P2llKiNJOL2Q0nUk5EqCezUPz0LkC8rzPp
         H2C9TgIK5bJEHoiUwwDXbrLOK9gRo+DuPEpz7FbLkuBXqWXrtRJAB4wygJGpUJnJvU/Q
         3c3nxNgg+kkeS27OBGL0ttQe8VpO87fyDXw1Z5OyOGMASm3q1FZb1GBqwhqVbdTpri+5
         AHwyCtBQWwG+u1PudeigXxYuC17mZNPTwCyzsZmRD/QKqL46Cp9u6tO2Ktz8tvgYSQkY
         //Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=xV3Ps0RsdCVhfxWoq/YPpZZAsZRZc/1bRKCvZXY1C2s=;
        b=Gf9bibh0scp6ElL5uLRwvGbGRnOsuwuohw37pmDuZzmbAob6bfTjJ6m1Q/TuwfLfj+
         nee7dCEbySLwydRR/W9tDD/wmm6lcL3hJR3dmE0683V0ciRtKAd1qswxKr3xFmp+VdDB
         DxG9jDnOItsjDhO5ompNJXrAilMvN3ZuqJFrM9J8DFNaxlabgebMz3NLBQFClNqaGBYK
         1HUvKrpmQ3x5G/JkfPaD5AaF4hyD0ELyiwOfR9TKqN4muRhMXVM9XlVru8Vpd3RSymrR
         G4tHw3LJxsZrc1+XgABUU4Lm4btu6K9xVDLL4YgirpMKUrH88+0xF8R4WNxNa8pNAuPj
         Qj4w==
X-Gm-Message-State: AGi0Pub9muJZ45veQLQzFMaxxTnM0sEAttlIeKlUrDIt6Jio22l1RWLl
        4EKxU0i/0oqleLfE8JKhsU8=
X-Google-Smtp-Source: APiQypISzecItIXL6bUSv7pE5bwW/O6vts2MY1mF5Ku1rioJ7tRNh4kjLBp9y9/ZHIkyuDTwfZAdoA==
X-Received: by 2002:adf:face:: with SMTP id a14mr13599009wrs.397.1588838971476;
        Thu, 07 May 2020 01:09:31 -0700 (PDT)
Received: from dumbo ([2a01:230:2::ec6])
        by smtp.gmail.com with ESMTPSA id p7sm7046956wrf.31.2020.05.07.01.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 01:09:30 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jWbaw-0004TM-GV; Thu, 07 May 2020 10:09:26 +0200
Message-Id: <20200507080650.439636033@linux.com>
User-Agent: quilt/0.65
Date:   Thu, 07 May 2020 10:04:57 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
        viro@zeniv.linux.org.uk, tytso@mit.edu, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 1/1] hibernate: restrict writes to the snapshot device
References: <20200507080456.069724962@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=hibernate-restrict-writes-to-snapshot-dev
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

Hibernation via snapshot device requires write permission to the swap
block device, the one that more often (but not necessarily) is used to
store the hibernation image.

With this patch, such permissions are granted iff:

1) snapshot device config option is enabled
2) swap partition is used as snapshot device

In other circumstance the swap device is not writable from userspace.

In order to achieve this, every write attempt to a swap device is
checked against the device configured as part of the uswsusp API [0]
using a pointer to the inode struct in memory. If the swap device being
written was not configured for snapshotting, the write request is denied.

NOTE: this implementation works only for swap block devices, where the
inode configured by swapon (which sets S_SWAPFILE) is the same used
by SNAPSHOT_SET_SWAP_AREA.

In case of swapfile, SNAPSHOT_SET_SWAP_AREA indeed receives the inode
of the block device containing the filesystem where the swap files is
located (+ offset in it) which is never passed to swapon and then has
not the S_SWAPFILE set.

As result, the swapfile itself (as a file) has never an option to be
written from userspace. Instead it remains writable if accessed directly
from the containing block device, which is always writeable from root.

[0] Documentation/power/userland-swsusp.rst

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk
Cc: tytso@mit.edu
Cc: len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
 fs/block_dev.c          |    3 +--
 include/linux/suspend.h |    6 ++++++
 kernel/power/user.c     |   14 +++++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

Index: b/include/linux/suspend.h
===================================================================
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -466,6 +466,12 @@ static inline bool system_entering_hiber
 static inline bool hibernation_available(void) { return false; }
 #endif /* CONFIG_HIBERNATION */
 
+#ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
+int is_hibernate_snapshot_dev(const struct inode *);
+#else
+static inline int is_hibernate_snapshot_dev(const struct inode *i) { return 0; }
+#endif
+
 /* Hibernation and suspend events */
 #define PM_HIBERNATION_PREPARE	0x0001 /* Going to hibernate */
 #define PM_POST_HIBERNATION	0x0002 /* Hibernation finished */
Index: b/kernel/power/user.c
===================================================================
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -35,8 +35,14 @@ static struct snapshot_data {
 	bool ready;
 	bool platform_support;
 	bool free_bitmaps;
+	struct inode *bd_inode;
 } snapshot_state;
 
+int is_hibernate_snapshot_dev(const struct inode *bd_inode)
+{
+	return hibernation_available() && snapshot_state.bd_inode == bd_inode;
+}
+
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
@@ -95,6 +101,7 @@ static int snapshot_open(struct inode *i
 	data->frozen = false;
 	data->ready = false;
 	data->platform_support = false;
+	data->bd_inode = NULL;
 
  Unlock:
 	unlock_system_sleep();
@@ -110,6 +117,7 @@ static int snapshot_release(struct inode
 
 	swsusp_free();
 	data = filp->private_data;
+	data->bd_inode = NULL;
 	free_all_swap_pages(data->swap);
 	if (data->frozen) {
 		pm_restore_gfp_mask();
@@ -202,6 +210,7 @@ struct compat_resume_swap_area {
 static int snapshot_set_swap_area(struct snapshot_data *data,
 		void __user *argp)
 {
+	struct block_device *bdev;
 	sector_t offset;
 	dev_t swdev;
 
@@ -232,9 +241,12 @@ static int snapshot_set_swap_area(struct
 		data->swap = -1;
 		return -EINVAL;
 	}
-	data->swap = swap_type_of(swdev, offset, NULL);
+	data->swap = swap_type_of(swdev, offset, &bdev);
 	if (data->swap < 0)
 		return -ENODEV;
+
+	data->bd_inode = bdev->bd_inode;
+	bdput(bdev);
 	return 0;
 }
 
Index: b/fs/block_dev.c
===================================================================
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2023,8 +2023,7 @@ ssize_t blkdev_write_iter(struct kiocb *
 	if (bdev_read_only(I_BDEV(bd_inode)))
 		return -EPERM;
 
-	/* uswsusp needs write permission to the swap */
-	if (IS_SWAPFILE(bd_inode) && !hibernation_available())
+	if (IS_SWAPFILE(bd_inode) && !is_hibernate_snapshot_dev(bd_inode))
 		return -ETXTBSY;
 
 	if (!iov_iter_count(from))

