Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9474E40C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiCVOQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiCVOQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB40E5EBE2;
        Tue, 22 Mar 2022 07:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1671461618;
        Tue, 22 Mar 2022 14:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58AEC340EC;
        Tue, 22 Mar 2022 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958445;
        bh=fLjxBm8/O9PPSCQbyWKZryc2El3aKu8MYrh8+64v/X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDzECXc5HO8N3LwXLqQ/RFYOc7LMSRRgX2R0H6gIvan1niOuVZ4V1zqjbcPkJUeW7
         Dr9gBz9GRcuFtX4NY/ShAmp2uN6w88GiB0Oth/6TiP93kJpP7p5Qnrj0j4TM+mGtYa
         ZD57+t0TJUV4ZdtgaI4syWvzmTcR4M3wsYxG7ACldDqPjJYhKkLkX3l6vRwn0mf4fz
         HsHiTFcFrUA6Rlw86mptLqfee8QwC7TLzIsOvyxmZgr/gHqD8RzaQPJLwkcjbsQrSv
         CI3rOd3fuj3Hu4gTatI3R1LjAK+oouxl2LIxkiDMkinjL+s19grM86C3EDsmYN6oKT
         qBW7fOYaUc0ag==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 49/51] ceph: set i_blkbits to crypto block size for encrypted inodes
Date:   Tue, 22 Mar 2022 10:13:14 -0400
Message-Id: <20220322141316.41325-50-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some of the underlying infrastructure for fscrypt relies on i_blkbits
being aligned to the crypto blocksize.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9f34e4993b61..b048d9da8310 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -975,13 +975,6 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
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
@@ -1006,6 +999,15 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
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
2.35.1

