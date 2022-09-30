Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199A65F0A50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiI3L1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiI3L0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:26:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D7D10D3;
        Fri, 30 Sep 2022 04:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C818B827BA;
        Fri, 30 Sep 2022 11:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D155C43470;
        Fri, 30 Sep 2022 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664536742;
        bh=uSYS665bHJOW0VgPrjPhB+eIdRUg3nkzUm52VZICAu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imbcD7d6rpnQgdKAoXWpTwniyU5ehyOAtwQa0fjjF1Zv+C/Up8oaasOc8/vQ/kmjj
         T26yTA/V8BY0QY16x7AeFuF4wpt8BDpqsyiMe3rMIE1wWyD3nyrljy0gTh/3lzj6b5
         TD5biiRLBTzFAubEfD67uUdE7z/Zv9VQvaxicYgMzHJ4Ok81YaNYDaZQwEYQVcU2uw
         V3kKWaYG6BHZeX28d8LrQZJkRbcIQYxb4vmyGgU4ldNYll813gqZuqyuPUHZ9DIVw3
         gLaGZV55F9N2OzXNFYsWJceKPjJ06Irqjkoq1i2VXH4Gi4ewHaCU8b4oypBh16FVSz
         0EikFQXuIpMtw==
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
Subject: [PATCH v6 8/9] vfs: update times after copying data in __generic_file_write_iter
Date:   Fri, 30 Sep 2022 07:18:39 -0400
Message-Id: <20220930111840.10695-9-jlayton@kernel.org>
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

The c/mtime and i_version currently get updated before the data is
copied (or a DIO write is issued), which is problematic for NFS.

READ+GETATTR can race with a write (even a local one) in such a way as
to make the client associate the state of the file with the wrong change
attribute. That association can persist indefinitely if the file sees no
further changes.

Move the setting of times to the bottom of the function in
__generic_file_write_iter and only update it if something was
successfully written.

If the time update fails, log a warning once, but don't fail the write.
All of the existing callers use update_time functions that don't fail,
so we should never trip this.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/filemap.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..72c0ceb75176 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3812,10 +3812,6 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		goto out;
 
-	err = file_update_time(file);
-	if (err)
-		goto out;
-
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		loff_t pos, endbyte;
 
@@ -3868,6 +3864,19 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			iocb->ki_pos += written;
 	}
 out:
+	if (written > 0) {
+		err = file_update_time(file);
+		/*
+		 * There isn't much we can do at this point if updating the
+		 * times fails after a successful write. The times and i_version
+		 * should still be updated in the inode, and it should still be
+		 * marked dirty, so hopefully the next inode update will catch it.
+		 * Log a warning once so we have a record that something untoward
+		 * has occurred.
+		 */
+		WARN_ONCE(err, "Failed to update m/ctime after write: %ld\n", err);
+	}
+
 	current->backing_dev_info = NULL;
 	return written ? written : err;
 }
-- 
2.37.3

