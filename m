Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67A863C76B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 19:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiK2SwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 13:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiK2SwT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD7641999
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 10:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669747876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O5j2IPI8sowFiv9HG2RJDVcClXhFgfnIRCdX4t+4Se4=;
        b=Ls60m4BqLzGyQMNQ03zeSKmLgPTkO4kbAKzgxfEBRtTgjSG06lYCercN7G1/UDB4u6T1ff
        ghWbQaZt9MAM3VjNlSDUmQvEvkcuJsLeeOwzOROzlGt8tYCMr2TxvjFiSVV0FDHev5+eL1
        a1vNVwt19ZyXd5qu+kzt1yVRIpjM3XE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-UIP0kyXIO8WsaZuaeG3oFw-1; Tue, 29 Nov 2022 13:51:14 -0500
X-MC-Unique: UIP0kyXIO8WsaZuaeG3oFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1118986EB30
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 18:51:14 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC8C02027064
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 18:51:13 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fs/remap_range: avoid spurious writeback on zero length request
Date:   Tue, 29 Nov 2022 13:51:19 -0500
Message-Id: <20221129185119.51071-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

generic_remap_checks() can reduce the effective request length (i.e.,
after the reflink extend to EOF case is handled) down to zero. If this
occurs, __generic_remap_file_range_prep() proceeds through dio
serialization, file mapping flush calls, and may invoke file_modified()
before returning back to the filesystem caller, all of which immediately
check for len == 0 and return.

While this is mostly harmless, it is spurious and not completely
without side effect. A filemap write call can submit I/O (but not
wait on it) when the specified end byte precedes the start but
happens to land on the same aligned page boundary, which can occur
from __generic_remap_file_range_prep() when len is 0.

The dedupe path already has a len == 0 check to break out before
doing range comparisons. Lift this check a bit earlier in the
function to cover the general case of len == 0 and avoid the
unnecessary work. While here, account for the case where
generic_remap_check_len() may also reduce length to zero.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---

v2:
- Also handle generic_remap_check_len().
v1: https://lore.kernel.org/linux-fsdevel/20221128160813.3950889-1-bfoster@redhat.com/

 fs/remap_range.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 654912d06862..8741ecd616a7 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -304,7 +304,7 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	/* Check that we don't violate system file offset limits. */
 	ret = generic_remap_checks(file_in, pos_in, file_out, pos_out, len,
 			remap_flags);
-	if (ret)
+	if (ret || *len == 0)
 		return ret;
 
 	/* Wait for the completion of any pending IOs on both files */
@@ -328,9 +328,6 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	if (remap_flags & REMAP_FILE_DEDUP) {
 		bool		is_same = false;
 
-		if (*len == 0)
-			return 0;
-
 		if (!IS_DAX(inode_in))
 			ret = vfs_dedupe_file_range_compare(file_in, pos_in,
 					file_out, pos_out, *len, &is_same);
@@ -348,7 +345,7 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 
 	ret = generic_remap_check_len(inode_in, inode_out, pos_out, len,
 			remap_flags);
-	if (ret)
+	if (ret || *len == 0)
 		return ret;
 
 	/* If can't alter the file contents, we're done. */
-- 
2.37.3

