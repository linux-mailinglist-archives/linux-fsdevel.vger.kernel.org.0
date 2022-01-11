Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFBA48B72B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350655AbiAKTSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350819AbiAKTRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D62C028BEA;
        Tue, 11 Jan 2022 11:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E7CF61781;
        Tue, 11 Jan 2022 19:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751E8C36AE3;
        Tue, 11 Jan 2022 19:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928602;
        bh=xELeb58cviAxV9IMAfrG0Afpp622M58migNzu2PHEcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9XZDWwiiOCF5y642Bfv2KBKxDL10XfRJxRH5frVo60My5cpq9Bi6+O2AdHeHmGVd
         Cv6LD0IigzFqaZv+K3EjpNo3z3m5cR8j5tCB5vF+wKNkLm+pWLUjepdszh0g3GVubt
         9BQKtttqihEVIOm7FGtbIymXVWv+qkUFzxa6NoBIGGy1yo0E69qEiCGgnahjP1AG3K
         pXjuIEqPsiklyr883CZIP9PptQ8hc69Cfg9uTXVNtuhWgMitEVcUEzBWjAXethKNOG
         mUw5wnUarzQ8x9GujXa71rpB353owiWvKp6Oo0oP6lg3IDs2mQLDhMm9412bKXG/yz
         fBeSxEkSZmWEg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 45/48] ceph: set i_blkbits to crypto block size for encrypted inodes
Date:   Tue, 11 Jan 2022 14:16:05 -0500
Message-Id: <20220111191608.88762-46-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index eecda0a73908..d7eff9c3e988 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -968,13 +968,6 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	issued |= __ceph_caps_dirty(ci);
 	new_issued = ~issued & info_caps;
 
-	/* directories have fl_stripe_unit set to zero */
-	if (le32_to_cpu(info->layout.fl_stripe_unit))
-		inode->i_blkbits =
-			fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
-	else
-		inode->i_blkbits = CEPH_BLOCK_SHIFT;
-
 	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
 
 	if ((new_version || (new_issued & CEPH_CAP_AUTH_SHARED)) &&
@@ -999,6 +992,15 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 #endif
 	}
 
+	/* directories have fl_stripe_unit set to zero */
+	if (IS_ENCRYPTED(inode))
+		inode->i_blkbits = CEPH_FSCRYPT_BLOCK_SHIFT;
+	else if (le32_to_cpu(info->layout.fl_stripe_unit))
+		inode->i_blkbits =
+			fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
+	else
+		inode->i_blkbits = CEPH_BLOCK_SHIFT;
+
 	if ((new_version || (new_issued & CEPH_CAP_LINK_SHARED)) &&
 	    (issued & CEPH_CAP_LINK_EXCL) == 0)
 		set_nlink(inode, le32_to_cpu(info->nlink));
-- 
2.34.1

