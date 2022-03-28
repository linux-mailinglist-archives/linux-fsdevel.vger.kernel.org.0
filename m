Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A614E9A3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbiC1O7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiC1O7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:59:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF34B506C3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 07:58:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A01F01F37C;
        Mon, 28 Mar 2022 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648479482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mBRwTJu+eomhiDBvaJunDEbA+vXIlIH5YKWbye3zRTA=;
        b=jucx+T3OKUrOM6o6QcYNks06jB876vtGPps6AYvaAwwE0e4wnc65JXpttJ+wSsm2rnzSAV
        xRoVCt24oGF2OWPamH6QdNgLDMem/MxL5LxCXwlskni1UaQD2uj54+/ehbnrjwcbXd2LdS
        n3dZsrWejEP/zKlVYV33Cou06CJ9S+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648479482;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mBRwTJu+eomhiDBvaJunDEbA+vXIlIH5YKWbye3zRTA=;
        b=BkIW1Y7HedZOD/DBUBd1Azc86EPrvi1T5dFQONrcTVSKstMwjj2lbs/mRlTi+yfm8dYx07
        0uo3xJY4vLxkKaDg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 82D14A3B9E;
        Mon, 28 Mar 2022 14:58:02 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH] watch_queue: fix IOC_WATCH_QUEUE_SET_SIZE alloc error paths
Date:   Mon, 28 Mar 2022 16:57:46 +0200
Message-Id: <20220328145746.8146-1-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From code inspection, the watch_queue_set_size() allocation error paths
return the ret value set via the prior pipe_resize_ring() call, which
will always be zero.

Fixes: c73be61cede58 ("pipe: Add general notification queue support")
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 kernel/watch_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 3990e4df3d7b0..a128dedec9db2 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -248,6 +248,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	if (ret < 0)
 		goto error;
 
+	ret = -ENOMEM;
 	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
 	if (!pages)
 		goto error;
-- 
2.34.1

