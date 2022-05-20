Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3952F5C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 May 2022 00:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351285AbiETWjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 18:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiETWjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 18:39:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8239E185C9F
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 15:39:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2DDF71FAB6;
        Fri, 20 May 2022 22:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653086346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wFtOgtQYncNYvGQ4WzYJkmS03M9ZmoxtarfIztXq+vw=;
        b=fBErSvnqnClBtWNUXUCn5uMa4CL4sfqHnBnGaulQEgIaiXc1hhgXPuQomnM5+dRRRqyQtz
        S/ghigmI3+4rwLzLggNLlfcFQt217J2SBPUVbabw/kjPPq61cqqj5ktvo9Ctpr84KGpDTf
        BiNSSwX5RKRYI7lca6w5rbASAo5PWsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653086346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wFtOgtQYncNYvGQ4WzYJkmS03M9ZmoxtarfIztXq+vw=;
        b=kBY0m3sgstVeA5I6bxNcM3sTtSmrdkJ6FuvY52W9moJJ1jD+DC8U0OuHTrLo+qlwoX3ipY
        jFArWLYORwWXeLDg==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D6B22C141;
        Fri, 20 May 2022 22:39:06 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH RESEND] watch_queue: fix IOC_WATCH_QUEUE_SET_SIZE alloc error paths
Date:   Sat, 21 May 2022 00:37:58 +0200
Message-Id: <20220520223758.32548-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
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
index 230038d4f908..a89a65954ce1 100644
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
2.35.3

