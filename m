Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC23EDF04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 23:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhHPVGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 17:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233348AbhHPVGC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:06:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CF3660F11;
        Mon, 16 Aug 2021 21:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629147930;
        bh=eNbbjitMtrjBC19cA2F9j/Ie/WZb6/qBUgModxnt7BM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LKz71eHghyBj7oA8VZ70nyvCO1cYE2cyG0tqVjsV18PNTS84Y30dQ2PH2zNSMZPO+
         E22FrhFq8Vj0w0T1skiXgL9LeuMKrVQcPLFYxANzSzJ7bFH3LFEBWNIKtVGbO6F5Tl
         R7SpSoxQPgZoU5nTfG+dN8f4RAlEhz54iWuDFyUe5sXRxTSiEg2HOstue2MgSju6E+
         Xqm9TNEK00Eg7zk2aOAalWtMuRPUrTQepu7S+rVN1DSv12nHRDkollTlI36snUDdjH
         LILtjNsBGG8iPV5egWlTyCVf2qeMws/SoQ+/tyyrvKmdIv7iEJS4+Ow9/c07VZ2k4p
         PGeziT9bQmIAw==
Subject: [PATCH 2/2] ext4: use DAX block device zeroout for FSDAX file
 ZERO_RANGE operations
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, jane.chu@oracle.com,
        willy@infradead.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sandeen@sandeen.net
Date:   Mon, 16 Aug 2021 14:05:30 -0700
Message-ID: <162914793009.197065.11088746748309098255.stgit@magnolia>
In-Reply-To: <162914791879.197065.12619905059952917229.stgit@magnolia>
References: <162914791879.197065.12619905059952917229.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Our current "advice" to people using persistent memory and FSDAX who
wish to recover upon receipt of a media error (aka 'hwpoison') event
from ACPI is to punch-hole that part of the file and then pwrite it,
which will magically cause the pmem to be reinitialized and the poison
to be cleared.

Punching doesn't make any sense at all -- the (re)allocation on pwrite
does not permit the caller to specify where to find blocks, which means
that we might not get the same pmem back.  This pushes the user farther
away from the goal of reinitializing poisoned memory and leads to
complaints about unnecessary file fragmentation.

Now that we've created a dax_zeroinit_range to perform what amounts to a
low level format of pmem, hook it up to ext4.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/ext4/extents.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)


diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92ad64b89d9b..630ce5338368 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -29,6 +29,7 @@
 #include <linux/fiemap.h>
 #include <linux/backing-dev.h>
 #include <linux/iomap.h>
+#include <linux/dax.h>
 #include "ext4_jbd2.h"
 #include "ext4_extents.h"
 #include "xattr.h"
@@ -4678,6 +4679,24 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	}
 
 	if (mode & FALLOC_FL_ZERO_RANGE) {
+		/*
+		 * If the file is in DAX mode, try to use a DAX-specific
+		 * function to zero the region.
+		 */
+		if (IS_DAX(inode)) {
+			bool	did_zeroout = false;
+
+			inode_lock(inode);
+
+			ret = dax_zeroinit_range(inode, offset, len,
+					&did_zeroout, &ext4_iomap_report_ops);
+			if (ret == -EINVAL)
+				ret = 0;
+			if (ret || did_zeroout)
+				goto out;
+
+			inode_unlock(inode);
+		}
 		ret = ext4_zero_range(file, offset, len, mode);
 		goto exit;
 	}

