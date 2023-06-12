Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA172B761
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 07:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjFLFfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 01:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjFLFfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:35:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1004131
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 22:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=eQHKXIxxZPpwRi7zakrjgzSjidDQExIg6srBZ+XxC9c=; b=EGhnqyFNtfYhUu9A8XesNUTrOr
        LQdoTGjBCFJTbqUZGj2Fn271aIVYkD+iQvIJoTBH2FyPvFbUarUv5/yojf635FsmgFZ05BW0Jisn7
        bvYKTTGer48ae5Ky/6QZ1WZT1/sqi1Tczi3Kp2vGMCp6eTVR5I01nSWEBtDEOiDfYoLIAXtWNwe9P
        5UIlz0BL++AJpOElqO+7Qe1+ZSxHq6iH4Mpwt8cw+4NFSDKGzJkPE6OHhxmP09p1bTbel+jZBOcHO
        dgur8NyLF6sDOEhKAhEy2iyonasIPKTdNxguM5K1hg61grBWeCpVP0Gv+ur+UXOiVeQe268GPW9Lx
        wiAgc3IA==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8aCz-002f4g-0e;
        Mon, 12 Jun 2023 05:35:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     dlemoal@kernel.org, naohiro.aota@wdc.com
Cc:     jth@kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] zonefs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
Date:   Mon, 12 Jun 2023 07:35:15 +0200
Message-Id: <20230612053515.585428-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
wiring up a dummy direct_IO method to indicate support for direct I/O.
Do that for zonefs so that noop_direct_IO can eventually be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/zonefs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 132f01d3461f14..12372ec58389e1 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -181,7 +181,6 @@ const struct address_space_operations zonefs_file_aops = {
 	.migrate_folio		= filemap_migrate_folio,
 	.is_partially_uptodate	= iomap_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
-	.direct_IO		= noop_direct_IO,
 	.swap_activate		= zonefs_swap_activate,
 };
 
@@ -813,6 +812,7 @@ static int zonefs_file_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	file->f_mode |= FMODE_CAN_ODIRECT;
 	ret = generic_file_open(inode, file);
 	if (ret)
 		return ret;
-- 
2.39.2

