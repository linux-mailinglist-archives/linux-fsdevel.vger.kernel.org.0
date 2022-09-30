Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8160B5F0A39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiI3L1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiI3L0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:26:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7E2EE2E;
        Fri, 30 Sep 2022 04:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77060B8280D;
        Fri, 30 Sep 2022 11:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF6BC4347C;
        Fri, 30 Sep 2022 11:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664536744;
        bh=x94ngh3SR30xuVLdH4ioO8YH0PC8Q6w0q3cK1o2WgAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1+suCyBf4Mq23dZykr03FKvOkB2KN2pmo4hPt9FSzh5mDyAgRwzx4IBi3jD2xYta
         2aH0OFlPU2JQZt0iJZDPo+cYiYNcx36IEelulL17hYdS4gazqnHPs16SmxbYG7/sIh
         Mn4Q66DPEqaqeLSh88qk9dZa9Z+SLVE+UCijLAM0IQjzkK+04GeTC+Y6owqADky9WX
         6QI36erT6IJdk6dUqhK+InrXSOp5nQD/lPUXYB6IWKocKgbeYVjwswHwH3urvBP8HN
         fKO0R+gneckl6h3osuEOy9z4kQ2Iw97ImHbJTgAgvforuxHZb1TWNVjqkRNIonephB
         t2vFf8ic4Ckug==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 9/9] ext4: update times after I/O in write codepaths
Date:   Fri, 30 Sep 2022 07:18:40 -0400
Message-Id: <20220930111840.10695-10-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930111840.10695-1-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The times currently get updated before the data is copied (or the DIO is
issued) which is problematic for NFSv4. A READ+GETATTR could race with a
write in such a way to make the client associate the state of the file
with the wrong change attribute, and that association could persist
indefinitely if the file sees no further changes.

For this reason, it's better to bump the times and change attribute
after the data has been copied or the DIO write issued.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/file.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 109d07629f81..1fa8e0239856 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -246,7 +246,7 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (count <= 0)
 		return count;
 
-	ret = file_modified(iocb->ki_filp);
+	ret = file_remove_privs(iocb->ki_filp);
 	if (ret)
 		return ret;
 	return count;
@@ -269,7 +269,11 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	current->backing_dev_info = inode_to_bdi(inode);
 	ret = generic_perform_write(iocb, from);
 	current->backing_dev_info = NULL;
-
+	if (ret > 0) {
+		ssize_t ret2 = file_update_time(iocb->ki_filp);
+		if (ret2)
+			ret = ret2;
+	}
 out:
 	inode_unlock(inode);
 	if (likely(ret > 0)) {
@@ -455,7 +459,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 		goto restart;
 	}
 
-	ret = file_modified(file);
+	ret = file_remove_privs(file);
 	if (ret < 0)
 		goto out;
 
@@ -572,6 +576,11 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (extend)
 		ret = ext4_handle_inode_extension(inode, offset, ret, count);
 
+	if (ret > 0) {
+		ssize_t ret2 = file_update_time(iocb->ki_filp);
+		if (ret2)
+			ret = ret2;
+	}
 out:
 	if (ilock_shared)
 		inode_unlock_shared(inode);
@@ -653,6 +662,11 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (extend)
 		ret = ext4_handle_inode_extension(inode, offset, ret, count);
+	if (ret > 0) {
+		ssize_t ret2 = file_update_time(iocb->ki_filp);
+		if (ret2)
+			ret = ret2;
+	}
 out:
 	inode_unlock(inode);
 	if (ret > 0)
-- 
2.37.3

