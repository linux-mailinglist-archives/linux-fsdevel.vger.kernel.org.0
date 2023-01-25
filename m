Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3765267B634
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjAYPuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAYPuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:50:17 -0500
X-Greylist: delayed 1231 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 07:50:17 PST
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BF4FC21
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 07:50:16 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-LG1apAgMNhCnHMZXWZtq6A-1; Wed, 25 Jan 2023 10:29:34 -0500
X-MC-Unique: LG1apAgMNhCnHMZXWZtq6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73EAC85C6E2;
        Wed, 25 Jan 2023 15:29:33 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (ovpn-208-16.brq.redhat.com [10.40.208.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B32BE2026D4B;
        Wed, 25 Jan 2023 15:29:31 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Val Cowan <vcowan@redhat.com>
Subject: [RFC PATCH v1 4/6] proc: Allow to use the allowlist filter in userns
Date:   Wed, 25 Jan 2023 16:28:51 +0100
Message-Id: <76e8b2d0c0651af6906351b7d43fa2a4d117dc04.1674660533.git.legion@kernel.org>
In-Reply-To: <cover.1674660533.git.legion@kernel.org>
References: <cover.1674660533.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RDNS_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/proc_allowlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_allowlist.c b/fs/proc/proc_allowlist.c
index 2153acb8e467..c605f73622bd 100644
--- a/fs/proc/proc_allowlist.c
+++ b/fs/proc/proc_allowlist.c
@@ -100,7 +100,7 @@ static int open_allowlist(struct inode *inode, struct file *file)
 	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
 	// we need this because shrink_dcache_sb() can't drop our own dentry.
@@ -199,7 +199,7 @@ static const struct proc_ops proc_allowlist_ops = {
 static int __init proc_allowlist_init(void)
 {
 	struct proc_dir_entry *pde;
-	pde = proc_create("allowlist", S_IRUSR | S_IWUSR, NULL, &proc_allowlist_ops);
+	pde = proc_create("allowlist", S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH, NULL, &proc_allowlist_ops);
 	pde_make_permanent(pde);
 	pde_make_allowlist(pde);
 	return 0;
-- 
2.33.6

