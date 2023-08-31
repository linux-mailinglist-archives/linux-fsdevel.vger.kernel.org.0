Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72D878E5B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 07:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbjHaFcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 01:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245458AbjHaFcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:32:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40971CD6;
        Wed, 30 Aug 2023 22:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=uGghW2I13jI1s6iCzfvyY6VFo2KuSrw5mx3MS02ZxdA=; b=UOuGFtVdc4LyLWQQgplDozXLY+
        D5qVUJ5Ocj6dI7tE1CQZZfZJxWSt0NBz3ZjqBraP9GxkW2aPqNI+GrYA6yQ8f25W0NW4AWF3kmsgX
        Xwjtti0FD3v0Pmubqu5DqlI2sZl4aQV9b1awL7Njenugw49DaH76pgqG/rZcRW9kcmw+hVps2qrq/
        nUgmUqSVUMsy34OhQNOjxkTq4eQ9RACqgQyK19s+OWT03Ohtvghoj5EyvUmv6hc2AoRHfyIQ8fEdo
        5rZttcWQCJmQLnkprYZkEq93wKHA49HYV6HztAHAO/oedD60dPSvHkAK1tOo9Zq8jfNqwk3L8jSwl
        iP83Di4g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbaHr-00EgmO-07;
        Thu, 31 Aug 2023 05:32:11 +0000
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
Subject: [PATCH 3/4] selinuxfs: free sb->s_fs_info after shutting down the super block
Date:   Thu, 31 Aug 2023 07:31:56 +0200
Message-Id: <20230831053157.256319-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831053157.256319-1-hch@lst.de>
References: <20230831053157.256319-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Also remove the duplicate freeing in the sel_fill_super error path given
that ->kіll_sb is also called on ->fill_super failure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 security/selinux/selinuxfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9dafb6ff110d26..8a8a532be8e767 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2100,9 +2100,6 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 err:
 	pr_err("SELinux: %s:  failed while creating inodes\n",
 		__func__);
-
-	selinux_fs_info_free(sb);
-
 	return ret;
 }
 
@@ -2123,8 +2120,8 @@ static int sel_init_fs_context(struct fs_context *fc)
 
 static void sel_kill_sb(struct super_block *sb)
 {
-	selinux_fs_info_free(sb);
 	kill_litter_super(sb);
+	selinux_fs_info_free(sb);
 }
 
 static struct file_system_type sel_fs_type = {
-- 
2.39.2

