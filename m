Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3E6AE485
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCGPWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 10:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCGPWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:22:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE17A242
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 07:19:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 275621FDA8;
        Tue,  7 Mar 2023 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678202390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=M+tvMKVkurm8+zJ9DRYcnXNNXYHuivK1Un8blqUUrSk=;
        b=jx6EZlEco/A+F5ZGycu+76lbKMCy/CKy+RGMd6Jf4RNwSoOXMAncvL8K5jOS8eAH/dJbVs
        lNou2sb9inmnVzwWFz+gjycwet/HmNCoj3mL2fMftlJVq3VZbILqKR4tLq9p07FA3NDvGC
        FJLw7u8MY59pZ6EFlGW0rsvUKkB5W+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678202390;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=M+tvMKVkurm8+zJ9DRYcnXNNXYHuivK1Un8blqUUrSk=;
        b=97gQBZPqzY2rVcp1XfJ73vRzKSD8jewhvhFQCVAySSBvrQ+cdh+MfLjbygLE54vhaNxVvC
        zzdkduFMETY5KoAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 017C31341F;
        Tue,  7 Mar 2023 15:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nSN9OhVWB2SGHgAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 07 Mar 2023 15:19:49 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] watch_queue: fix IOC_WATCH_QUEUE_SET_SIZE alloc error paths
Date:   Tue,  7 Mar 2023 16:21:06 +0100
Message-Id: <20230307152106.6899-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The watch_queue_set_size() allocation error paths return the ret value
set via the prior pipe_resize_ring() call, which will always be zero.

As a result, IOC_WATCH_QUEUE_SET_SIZE callers such as "keyctl watch"
fail to detect kernel wqueue->notes allocation failures and proceed to
KEYCTL_WATCH_KEY, with any notifications subsequently lost.

Fixes: c73be61cede58 ("pipe: Add general notification queue support")
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
Version 2:
- document "keyctl watch" behaviour with this bug

 kernel/watch_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index a6f9bdd956c3..f10f403104e7 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -273,6 +273,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	if (ret < 0)
 		goto error;
 
+	ret = -ENOMEM;
 	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
 	if (!pages)
 		goto error;
-- 
2.35.3

