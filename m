Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446F774389D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 11:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjF3Jqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjF3Jq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:46:27 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AADF35A5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 02:46:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688118378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRJ5kSABaCwn8RkR4VsTGccOmq4ViDUJMulfHwP1+ls=;
        b=e4guLSqfxyNIo8fxqbhcM0gUvfT0qnmLkSUkWxN8iz8CgAbcrAgUa+1J/B7Pyoj8CaLYdE
        jmypzFF8m+NDkL/3COGHhheYUZ0iA4GMksX9NVsqXnVECjaSK5pHMC+u5Ld1NPdX+k5Y2D
        xiT8kEWa3aeiok5/iVuc0HkeCbdYceA=
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net
Subject: [PATCH 3/3] fuse: write back dirty pages before direct write in direct_io_relax mode
Date:   Fri, 30 Jun 2023 17:46:02 +0800
Message-Id: <20230630094602.230573-4-hao.xu@linux.dev>
In-Reply-To: <20230630094602.230573-1-hao.xu@linux.dev>
References: <20230630094602.230573-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

In direct_io_relax mode, there can be shared mmaped files and thus dirty
pages in its page cache. Therefore those dirty pages should be written
back to backend before direct write to avoid data loss.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/fuse/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 176f719f8fc8..7c9167c62bf6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (!ia)
 		return -ENOMEM;
 
+	if (fopen_direct_write && fc->direct_io_relax) {
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

