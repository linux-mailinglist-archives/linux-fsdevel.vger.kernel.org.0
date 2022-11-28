Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A3A63AD50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 17:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiK1QJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 11:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiK1QJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:09:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9062DF
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 08:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669651690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3t5lxpJyz2ChibaJvTVnfzPLZbRPnpBfQnoaZHf+ZqE=;
        b=QWR9T5S0+zsvd1PeyulNzwcabwwW+x+hhENIUo7lyNrr3MhVsJ1ggplmzl+7UKiW3s6c6s
        0LTRHv8O+52u6H0DV2B0LU87HljFTc8zJYWuCqCCE+su1TAQo6JXR/0kHaivfBDe9Byk2S
        L4z3eMnrlZnaEMXIxVoU/z9oVJpC6bE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-eBzks-U3P3OF0Ewje4AtQg-1; Mon, 28 Nov 2022 11:08:08 -0500
X-MC-Unique: eBzks-U3P3OF0Ewje4AtQg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14A6C382F1A4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 16:08:08 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFC634A9254
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 16:08:07 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/remap_range: avoid spurious writeback on zero length request
Date:   Mon, 28 Nov 2022 11:08:13 -0500
Message-Id: <20221128160813.3950889-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

The dedupe path already has a len == 0 check to break out before doing
range comparisons. Lift this check a bit earlier in the function to
cover the general case of len == 0 and avoid the unnecessary work.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/remap_range.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 654912d06862..32ea992f9acc 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -306,6 +306,8 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 			remap_flags);
 	if (ret)
 		return ret;
+	if (*len == 0)
+		return 0;
 
 	/* Wait for the completion of any pending IOs on both files */
 	inode_dio_wait(inode_in);
@@ -328,9 +330,6 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	if (remap_flags & REMAP_FILE_DEDUP) {
 		bool		is_same = false;
 
-		if (*len == 0)
-			return 0;
-
 		if (!IS_DAX(inode_in))
 			ret = vfs_dedupe_file_range_compare(file_in, pos_in,
 					file_out, pos_out, *len, &is_same);
-- 
2.37.3

