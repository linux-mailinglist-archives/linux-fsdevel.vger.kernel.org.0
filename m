Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA377B3A2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 20:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjI2SnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjI2SnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:43:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327E6199;
        Fri, 29 Sep 2023 11:43:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2C3C433C8;
        Fri, 29 Sep 2023 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696013001;
        bh=dsAIvonzMBGLzOUuzBkDUFs/z3RCTJBFMlCcN4lg03s=;
        h=From:Date:Subject:To:Cc:From;
        b=iy2Fa5Efgr5pPH4MAeONdFF4TfQpVLHXnSpzz5R76+UxzerMvFibEqDjCSqjnCifL
         hkSxKGmzRTUaw7JLsKdW1NSrvgHA5Q6MDCJ4OJKCWt6pGsb2AG7nWJ9GUWv663GZUI
         SzCyEZLvXyBUCZnoT3oJHM9NDZ+8MQlkDofdQhYjkY8QAwS7a/VM6/XiODh5RMTUtE
         lXxfgQKyVL71XC2BgfkZx8mk5B1jMQHJMyLoSo259kU7Za29u7+PnRed/lv7ZJlxHa
         wwTvkHdJ9zfz4UfFVQgm93nRYKPqWSJY5TtcCOZ2Jn+Bt0v2sTu4M7Q2eNaevKmbeS
         M1Z4m8o7/pGQg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 29 Sep 2023 14:43:18 -0400
Subject: [PATCH] xfs: reinstate the old i_version counter as
 STATX_CHANGE_COOKIE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-xfs-iversion-v1-1-38587d7b5a52@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMUaF2UC/x2MQQqAIBAAvyJ7bkGNQPtKdBBbay8WCiKIf886D
 sxMg0yJKcMqGiQqnPmOA9QkwF8unoR8DAYt9SyttlhDRi6UPhGNssFpr8xiFYzkSRS4/rtt7/0
 FJgnIFV4AAAA=
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dsAIvonzMBGLzOUuzBkDUFs/z3RCTJBFMlCcN4lg03s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlFxrIJqTwOBqvHLTbxU9WHv82mlhAnijBN26hv
 xEApTHGyYOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZRcayAAKCRAADmhBGVaC
 FacDEACGYMZPWxXBQVmP5FluUddVXFbuLOvAXRerZfeMiOW3lubp4T9LRZEgMcHQTvkkGl7fIJu
 F8x9p41Gq+C9GdcSVCwC/EoA5vnxY6o6S4fhNFwSJfGdiMwDkgziyQHuo7s5U/jz9xplAWbUMMs
 CUBJxidfzuJRcPnPjy5QVQGly20SC2/qokGrBnUvZoMQSaj34ElcQlj+fS1hAYMgw0+3RYEZVsn
 Ih4aYguNISs/enGzJvz8ANjW4+Vn0uN9YR+z9kApnLo1MdbJXC7LCpc6RYQ10GjZKOErmNJx43g
 V2g1kQvYn0xTNBPXXkbQBo3Qz5HgMCp0Y4pXMIEtuIiy/qMA/yyJgV6RtTcRUGf+4pX9Jxj9tDi
 W9jZ/lofYb4ho6xnk6QXLsscpic3UFvLS4e9Tl9Oqp37GRsh/iv+daDfxP2Ft12FZKz6OsdkEPQ
 dKLYRQsNaQvKJLgw/dNMoOqXXHKK5udKm/Yfx3s7HVW3krQmhqZ4gXatgnzS1sIW+3rfjUR8e6a
 AqK4giVYHXTW90tJM1Wdr9xqaX2khY8lb1zoUb5s4W/1hSycKgtpY4X5gDQEnCHFV507/RQ6pti
 w8RKl9QVy6c7aEFmLHkDu9FFVd+X6A/dXcCEbm+wstOPEtUZsFGfsK9TkABK48+4ynzjUFOm8QS
 AH/+l+iQW3TOJ1w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The handling of STATX_CHANGE_COOKIE was moved into generic_fillattr in
commit 0d72b92883c6 (fs: pass the request_mask to generic_fillattr), but
we didn't account for the fact that xfs doesn't call generic_fillattr at
all.

Make XFS report its i_version as the STATX_CHANGE_COOKIE.

Fixes: 0d72b92883c6 (fs: pass the request_mask to generic_fillattr)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I had hoped to fix this in a better way with the multigrain patches, but
it's taking longer than expected (if it even pans out at this point).

Until then, make sure we use XFS's i_version as the STATX_CHANGE_COOKIE,
even if it's bumped due to atime updates. Too many invalidations is
preferable to not enough.
---
 fs/xfs/xfs_iops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1c1e6171209d..2b3b05c28e9e 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -584,6 +584,11 @@ xfs_vn_getattr(
 		}
 	}
 
+	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
+		stat->change_cookie = inode_query_iversion(inode);
+		stat->result_mask |= STATX_CHANGE_COOKIE;
+	}
+
 	/*
 	 * Note: If you add another clause to set an attribute flag, please
 	 * update attributes_mask below.

---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230929-xfs-iversion-819fa2c18591

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

