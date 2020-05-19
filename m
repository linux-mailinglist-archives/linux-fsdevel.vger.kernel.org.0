Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD441D9EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 20:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgESSOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 14:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgESSOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 14:14:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC65FC08C5C0;
        Tue, 19 May 2020 11:14:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so198970wmb.4;
        Tue, 19 May 2020 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=Smbnh/HjJZfXW9umDTUlih066PFtxdapl55+liTkPwU=;
        b=aDw1q/Gcg/iKskACjlVFyCLUCG7c7zqmH32bqk8M1zWcKSzmtRuNo9w3BCn0wKWsjL
         AnyO3xoCyLsf8Z3YX7yykH4AXXIE5jJBgBnxOWWVWC+3jbal211Cy9p0XfM43vXfujG4
         3VcVe+Q/UgcclgL0x5PHCog6v9iWU+ELVwCd+IKXGLFHpqahv2ReoXSbEhasm5iOzALt
         hKFCaQKfogF6F8WskDDf0vWICcYHdARKj0Bz2lXc5otMmr4NHcpJ+8mOeRK2s0G0HIVn
         KKAYICIqXJqkIrqzh9bvNkYZuSGO1VXcmZwGtJKZTxQ41KexhZ45pIrHGOp94wYAHf1t
         Qo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=Smbnh/HjJZfXW9umDTUlih066PFtxdapl55+liTkPwU=;
        b=R5PZQAQtVMD1uzsLcrOEhisdJBO2Y3zVsqiyc4B+1nl1ZHXqgtxUa3IZp9Rw49l7OQ
         WIxk9ybT8Hm4frqCPo4/CEhSLFdHw9pgnlwD6nDlIN3NLYbNesSoc28SWbhTs3JLHvjH
         IHAWgEDlH1/bsxPlfGAavA6NdiqcxytxpaiB3kLa8cl7QdgGIP47E56IvMmK4bwVSxNl
         yMj5ukBk3aJdZQvBhf+fGGdySJfagVDF5gNdcn13thdZeJGlwjdvaXmkVO5Vv/BnZb1X
         qSJn5HB1c/j9pj8xjRkylo0+kFWtGib1wTiD4WLIZfRBN9TzrcENHnweTTCYyyS1hlvV
         kfLA==
X-Gm-Message-State: AOAM532x4oeRf8O2zFtqWuDIWKnxtuEJyfn+TY0XfL4Ho6zwffKx8zHH
        E0D//G6eCqa0hm3+nFpush8=
X-Google-Smtp-Source: ABdhPJwtwcBxa1z6T7T+kmhD2d0HQ+Omb3d13a8dvsF60CkMyXrE0dYCYUK7i1sDzO1JsSZN1YcYYQ==
X-Received: by 2002:a1c:7e03:: with SMTP id z3mr670958wmc.88.1589912053600;
        Tue, 19 May 2020 11:14:13 -0700 (PDT)
Received: from dumbo ([185.220.101.209])
        by smtp.gmail.com with ESMTPSA id s8sm265465wrg.34.2020.05.19.11.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:14:12 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jb6kk-0004L5-Q7; Tue, 19 May 2020 20:14:10 +0200
Date:   Tue, 19 May 2020 20:14:10 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
        viro@zeniv.linux.org.uk, tytso@mit.edu, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH v2] PM: hibernate: restrict writes to the resume device
Message-ID: <20200519181410.GA1963@dumbo>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
        viro@zeniv.linux.org.uk, tytso@mit.edu, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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
2) swap partition is used as resume device

In other circumstances the swap device is not writable from userspace.

In order to achieve this, every write attempt to a swap device is
checked against the device configured as part of the uswsusp API [0]
using a pointer to the inode struct in memory. If the swap device being
written was not configured for resuming, the write request is denied.

NOTE: this implementation works only for swap block devices, where the
inode configured by swapon (which sets S_SWAPFILE) is the same used
by SNAPSHOT_SET_SWAP_AREA.

In case of swap file, SNAPSHOT_SET_SWAP_AREA indeed receives the inode
of the block device containing the filesystem where the swap file is
located (+ offset in it) which is never passed to swapon and then has
not set S_SWAPFILE.

As result, the swap file itself (as a file) has never an option to be
written from userspace. Instead it remains writable if accessed directly
from the containing block device, which is always writeable from root.

[0] Documentation/power/userland-swsusp.rst

v2:
 - rename is_hibernate_snapshot_dev() to is_hibernate_resume_dev()
 - fix description so to correctly refer to the resume device

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
+int is_hibernate_resume_dev(const struct inode *);
+#else
+static inline int is_hibernate_resume_dev(const struct inode *i) { return 0; }
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
 
+int is_hibernate_resume_dev(const struct inode *bd_inode)
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
+	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode))
 		return -ETXTBSY;
 
 	if (!iov_iter_count(from))

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
