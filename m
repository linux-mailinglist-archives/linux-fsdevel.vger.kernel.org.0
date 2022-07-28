Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E629D58402B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiG1NjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 09:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiG1NjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CBBA501AE
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jul 2022 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659015559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEG7fIKaCcVg64l3rHOgljVHfKFni+uklyxHNrGsN2k=;
        b=OOS1kC0sZtERUwGCn+mxa9IOUxWjWzq+Pvj9IYdjnrY2gxdTVgz86cx/0LzbRf3JCIZ7zw
        Xnep4yCOQO2QM0JjG0sMrEGq3Ncq+hrYUiPtf00lGm6FfpKiHrclxF8r3R+aHxUPmtIoKx
        D6C0xralAqysxMqaog0r+EP8i88LJzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-rfB9pIH9OC6rTapXqGE2Bw-1; Thu, 28 Jul 2022 09:39:17 -0400
X-MC-Unique: rfB9pIH9OC6rTapXqGE2Bw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 218B1803520;
        Thu, 28 Jul 2022 13:39:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 068142026D64;
        Thu, 28 Jul 2022 13:39:15 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     jlayton@kernel.org, tytso@mit.edu, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE
Date:   Thu, 28 Jul 2022 15:39:14 +0200
Message-Id: <20220728133914.49890-2-lczerner@redhat.com>
In-Reply-To: <20220728133914.49890-1-lczerner@redhat.com>
References: <20220728133914.49890-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the I_DIRTY_TIME will never get set if the inode already has
I_DIRTY_INODE with assumption that it supersedes I_DIRTY_TIME.  That's
true, however ext4 will only update the on-disk inode in
->dirty_inode(), not on actual writeback. As a result if the inode
already has I_DIRTY_INODE state by the time we get to
__mark_inode_dirty() only with I_DIRTY_TIME, the time was already filled
into on-disk inode and will not get updated until the next I_DIRTY_INODE
update, which might never come if we crash or get a power failure.

The problem can be reproduced on ext4 by running xfstest generic/622
with -o iversion mount option. Fix it by setting I_DIRTY_TIME even if
the inode already has I_DIRTY_INODE.

Also clear the I_DIRTY_TIME after ->dirty_inode() otherwise it may never
get cleared.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/fs-writeback.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 05221366a16d..174f01e6b912 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2383,6 +2383,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 
 		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
 		flags &= ~I_DIRTY_TIME;
+		if (inode->i_state & I_DIRTY_TIME) {
+			spin_lock(&inode->i_lock);
+			inode->i_state &= ~I_DIRTY_TIME;
+			spin_unlock(&inode->i_lock);
+		}
 	} else {
 		/*
 		 * Else it's either I_DIRTY_PAGES, I_DIRTY_TIME, or nothing.
@@ -2399,13 +2404,20 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 	 */
 	smp_mb();
 
-	if (((inode->i_state & flags) == flags) ||
-	    (dirtytime && (inode->i_state & I_DIRTY_INODE)))
+	if ((inode->i_state & flags) == flags)
 		return;
 
 	spin_lock(&inode->i_lock);
-	if (dirtytime && (inode->i_state & I_DIRTY_INODE))
+	if (dirtytime && (inode->i_state & I_DIRTY_INODE)) {
+		/*
+		 * We've got a new lazytime update. Make sure it's recorded in
+		 * i_state, because the time might have already got updated in
+		 * ->dirty_inode() and will not get updated until next
+		 *  I_DIRTY_INODE update.
+		 */
+		inode->i_state |= I_DIRTY_TIME;
 		goto out_unlock_inode;
+	}
 	if ((inode->i_state & flags) != flags) {
 		const int was_dirty = inode->i_state & I_DIRTY;
 
-- 
2.35.3

