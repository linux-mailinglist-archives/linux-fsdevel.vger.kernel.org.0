Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22F7A2636
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjIOSmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjIOSlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:41:52 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B978B4212;
        Fri, 15 Sep 2023 11:40:25 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RnNK60pC9z9sW2;
        Fri, 15 Sep 2023 20:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZYs+58deJjiPO8x76TVvnJ/svOQYbXd85JbMK60DK4=;
        b=nbK0ltBUmQsL56D0EhZ4txGadxEvVy4TubQU3sjKYn6rLPyAwbUdURHJ8b7n3zRdtyN/4Z
        ypn7d+WKBepAkrMqlYrcpEnjSMQaoXkHFqFzoi6xAKmqYIcE4d5nhd2NJIIkCltxDGFZqX
        aPiRGdlaOPgV/tMGFjiJ/rnPBUDvjHKssw/KzOPJoi2RRiMVQtr/SMPLsZ5ZmivBbieE89
        tSpFP1+7JVhzls4KDO9r0MQkSh811k3tpn2w1NcQ02D8BjCZtKlrXgjf8qjYLwmyE0yjlD
        nMlVsGHg5BAV06syTuM4YAtZ4/po/zbqrO9EN8APt8gc76aXRTMNwttPDzWfeQ==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 22/23] xfs: enable block size larger than page size support
Date:   Fri, 15 Sep 2023 20:38:47 +0200
Message-Id: <20230915183848.1018717-23-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNK60pC9z9sW2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

Currently we don't support blocksize that is twice the page size due to
the limitation of having at least three pages in a large folio[1].

[1] https://lore.kernel.org/all/ZH0GvxAdw1RO2Shr@casper.infradead.org/

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/xfs_mount.c | 9 +++++++--
 fs/xfs/xfs_super.c | 7 ++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index aed5be5508fe..4272898c508a 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -131,11 +131,16 @@ xfs_sb_validate_fsb_count(
 	xfs_sb_t	*sbp,
 	uint64_t	nblocks)
 {
-	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
+	unsigned long mapping_count;
+
+	if (sbp->sb_blocklog <= PAGE_SHIFT)
+		mapping_count = nblocks >> (PAGE_SHIFT - sbp->sb_blocklog);
+	else
+		mapping_count = nblocks << (sbp->sb_blocklog - PAGE_SHIFT);
 
 	/* Limited by ULONG_MAX of page cache index */
-	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
+	if (mapping_count > ULONG_MAX)
 		return -EFBIG;
 	return 0;
 }
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1f77014c6e1a..75bf4d23051c 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1651,13 +1651,10 @@ xfs_fs_fill_super(
 		goto out_free_sb;
 	}
 
-	/*
-	 * Until this is fixed only page-sized or smaller data blocks work.
-	 */
-	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
+	if (mp->m_sb.sb_blocksize == (2 * PAGE_SIZE)) {
 		xfs_warn(mp,
 		"File system with blocksize %d bytes. "
-		"Only pagesize (%ld) or less will currently work.",
+		"Blocksize that is twice the pagesize %ld does not currently work.",
 				mp->m_sb.sb_blocksize, PAGE_SIZE);
 		error = -ENOSYS;
 		goto out_free_sb;
-- 
2.40.1

