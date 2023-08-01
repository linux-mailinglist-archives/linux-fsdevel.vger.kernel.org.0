Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799D576AA88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 10:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjHAIHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 04:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAIHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:07:16 -0400
Received: from out-81.mta1.migadu.com (out-81.mta1.migadu.com [IPv6:2001:41d0:203:375::51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96E8C6
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 01:07:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690877234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WFpsI7hm0V6rHVislgu0Moatq1RO7Su0U6sgPs9zxg=;
        b=G3nMrRUIlxq7lvOXL6DkUqXNsISzXwPtprr/d/R3GkVU0ULiHjRGhKT0NHk8XBgJhYn/m0
        1QzpuzbQSbkperExIDdvNpmlNtIEmuV6DQL7h9he9GAaIln0jnJJth3wWrbbbKUWgaJhJX
        XYo+3Xukx3g7RrWfNd/BhV0E0EWvwUQ=
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
Subject: [PATCH 3/3] fuse: write back dirty pages before direct write in direct_io_relax mode
Date:   Tue,  1 Aug 2023 16:06:47 +0800
Message-Id: <20230801080647.357381-4-hao.xu@linux.dev>
In-Reply-To: <20230801080647.357381-1-hao.xu@linux.dev>
References: <20230801080647.357381-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

In direct_io_relax mode, there can be shared mmaped files and thus dirty
pages in its page cache. Therefore those dirty pages should be written
back to backend before direct io to avoid data loss.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/fuse/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 60f64eafb231..0bcdf0aafeb7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (!ia)
 		return -ENOMEM;
 
+	if (fopen_direct_io && fc->direct_io_relax) {
+		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
+		if (res) {
+			fuse_io_free(ia);
+			return res;
+		}
+	}
 	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
 		if (!write)
 			inode_lock(inode);
-- 
2.25.1

