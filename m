Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761F67A90E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 04:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIUC1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjIUC1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91B799
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 19:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695263216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tc0bjCqixzwYqyqmCYYQsNKe2jTu81OkpkWyIhDzUrA=;
        b=VwFiJqMn/EBMqxpaxNE4mZCYsOP67IAJzp4JxLDvf1cSCLlqf26NJ+5nvEpG/bQghEIQ5v
        PV+4WVezTA1WoTUxyh2IR8iMLztF1BBmgpaXbZlnmR1VlYDJfVT3a+nBrS6oL9ggvMfsSK
        qwsonpKqXOF8jaFYV2+Sed+JjCA7o4k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-Zz11l0T_MlS-2Rmm89xoxg-1; Wed, 20 Sep 2023 22:26:54 -0400
X-MC-Unique: Zz11l0T_MlS-2Rmm89xoxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 005A8101A53B;
        Thu, 21 Sep 2023 02:26:54 +0000 (UTC)
Received: from li-a71a4dcc-35d1-11b2-a85c-951838863c8d.ibm.com.com (unknown [10.72.113.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C51E40C2064;
        Thu, 21 Sep 2023 02:26:49 +0000 (UTC)
From:   xiubli@redhat.com
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] fuse: pass ATTR_KILL_SUID/ATTR_KILL_SGID mode bits to user space
Date:   Thu, 21 Sep 2023 10:24:36 +0800
Message-ID: <20230921022436.1191166-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Such as for the xfstest-dev's generic/684 test case it will clear
suid and sgid if the fallocate request is commit by an unprivileged
user.

We need to pass the ATTR_KILL_SUID/ATTR_KILL_SGID flags to userspace.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/fuse/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f67bef9d83c4..73dcf54efbff 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1938,11 +1938,11 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 
 			attr->ia_mode = inode->i_mode;
 			if (inode->i_mode & S_ISUID) {
-				attr->ia_valid |= ATTR_MODE;
+				attr->ia_valid |= ATTR_KILL_SUID | ATTR_MODE;
 				attr->ia_mode &= ~S_ISUID;
 			}
 			if ((inode->i_mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
-				attr->ia_valid |= ATTR_MODE;
+				attr->ia_valid |= ATTR_KILL_SGID | ATTR_MODE;
 				attr->ia_mode &= ~S_ISGID;
 			}
 		}
-- 
2.41.0

