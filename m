Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F171A78E5B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 07:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbjHaFcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 01:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244800AbjHaFcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:32:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2815EA;
        Wed, 30 Aug 2023 22:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=onojrvo/4J+rr41hNOyQoa+Ghh8TsydVpI3xPRsi118=; b=toc1Q8HEVJiy3fD1KHJPR2pG2g
        AZqJDRtIXxiVn5ZCGXmTyWhgq0PZ9mEkFCgE788OttmLNc0j4/cqtzRGw/oJQEE9+hQYkF54d7ifY
        oRdCYKsdayrOYO4ThcedMZyGw5+bxM4PrDpEhg1NQpZUjnE46W2CPLPvDRCVCDwPv84QcFR+ucp0f
        PcTCU2g49IykihM3lBmJDhbGJLJde/9tEv4jswz/IMljzhT3dhfOkznuuDIfNdS55+zgB0uilfrqs
        GMZVjkQJP66y6Lhex4GZ654TPleoblO+Y1KUkF0Q3JW+ckPUXwRQmTVRRxtNs+oZAT3MBK6mrcf9R
        UNlc9UvA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbaHn-00EglZ-28;
        Thu, 31 Aug 2023 05:32:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH 2/4] devpts: free sb->s_fs_info after shutting down the super block
Date:   Thu, 31 Aug 2023 07:31:55 +0200
Message-Id: <20230831053157.256319-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831053157.256319-1-hch@lst.de>
References: <20230831053157.256319-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sb->s_fs_info can only be safely freed after generic_shutdown_super was
called and all access to the super_block has stopped.

Thus only free the private data after calling kill_litter_super, which
calls generic_shutdown_super internally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/devpts/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 299c295a27a03e..d46cea36c026ad 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -491,10 +491,10 @@ static void devpts_kill_sb(struct super_block *sb)
 {
 	struct pts_fs_info *fsi = DEVPTS_SB(sb);
 
+	kill_litter_super(sb);
 	if (fsi)
 		ida_destroy(&fsi->allocated_ptys);
 	kfree(fsi);
-	kill_litter_super(sb);
 }
 
 static struct file_system_type devpts_fs_type = {
-- 
2.39.2

