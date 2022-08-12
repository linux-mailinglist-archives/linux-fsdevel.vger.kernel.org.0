Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB655910D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiHLMhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiHLMhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9643CAE9E3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660307852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ylpaYidSLtIS5aOXK4M1ZVgF/GC3QayX8jCpJ2bSyu0=;
        b=jIXBJyWbW68HLbdoEy0fNptWYz4tZKwWz5EtARh/EV5WJ6qrXcIAUgFfWVFqyAWAw/N5Go
        aGiVV9JUJn/ekwzssq3jtVzmgW562mKnqq4Defqt7v2gMZYUXhzLkon7dicnHRKRnVkNF3
        oDihTv70ADsVtUg5llgZ099l47baSL0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-VLqtkQlFOQq8ta_PztHrGg-1; Fri, 12 Aug 2022 08:37:29 -0400
X-MC-Unique: VLqtkQlFOQq8ta_PztHrGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 218EF1C0782A;
        Fri, 12 Aug 2022 12:37:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7A4E2026D64;
        Fri, 12 Aug 2022 12:37:27 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jlayton@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, ebiggers@kernel.org,
        david@fromorbit.com
Subject: [PATCH v3 1/3] ext4: don't increase iversion counter for ea_inodes
Date:   Fri, 12 Aug 2022 14:37:25 +0200
Message-Id: <20220812123727.46397-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ea_inodes are using i_version for storing part of the reference count so
we really need to leave it alone.

The problem can be reproduced by xfstest ext4/026 when iversion is
enabled. Fix it by not calling inode_inc_iversion() for EXT4_EA_INODE_FL
inodes in ext4_mark_iloc_dirty().

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
v2, v3: no change

 fs/ext4/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..2a220be34caa 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5731,7 +5731,12 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 	}
 	ext4_fc_track_inode(handle, inode);
 
-	if (IS_I_VERSION(inode))
+	/*
+	 * ea_inodes are using i_version for storing reference count, don't
+	 * mess with it
+	 */
+	if (IS_I_VERSION(inode) &&
+	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
 		inode_inc_iversion(inode);
 
 	/* the do_update_inode consumes one bh->b_count */
-- 
2.37.1

