Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8374176CC1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjHBLyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjHBLys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:54:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AE210C1
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/8Wi8b28r9xtX80bnDMh1uKblec+nendgN29bLhHzCE=; b=rA4nq8gVqQz5jicfq1OTidvLae
        HoEeskc++Ae61AYL5DX1PWUM5BbwnXww4LZQNTeuE/PDdURZxERv6YM9MaZPpsYD6wCe74fqWe7+a
        Tb5+BpuF6GL4sAqsR63mAUZ7yKrvKCQ05oil7seSrwgGUB+z8X7pp43Bp51Eh013cLg2Kf+kvAR3z
        5Vf3usP6IRGUT4Awuo8vUwjNCuPYG5IiX4oCaKeqZwxUHtJxqVMR+gxnIxI4kWrXkr3ALGKLGRXWF
        IvMGwVA3ztPk+d3FnZ56eKyy6D4ZVjD3BhVmXVrMUifOQOSHuhPER0BXqU9HYa3g4jPANSQOj8Szv
        F5kjVtQQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRARC-004qdi-0k;
        Wed, 02 Aug 2023 11:54:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     jack@suse.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] quota: use lockdep_assert_held_write in dquot_load_quota_sb
Date:   Wed,  2 Aug 2023 13:54:39 +0200
Message-Id: <20230802115439.2145212-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802115439.2145212-1-hch@lst.de>
References: <20230802115439.2145212-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use lockdep_assert_held_write to assert and self-document the locking
state in dquot_load_quota_sb instead of hand-crafting it with a trylock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/quota/dquot.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a0c577ab2b7b26..2eb59646d3a1a3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2359,11 +2359,10 @@ static int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int error;
 
+	lockdep_assert_held_write(&sb->s_umount);
+
 	/* Just unsuspend quotas? */
 	BUG_ON(flags & DQUOT_SUSPENDED);
-	/* s_umount should be held in exclusive mode */
-	if (WARN_ON_ONCE(down_read_trylock(&sb->s_umount)))
-		up_read(&sb->s_umount);
 
 	if (!fmt)
 		return -ESRCH;
-- 
2.39.2

