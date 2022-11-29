Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642CB63CB92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 00:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiK2XIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 18:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbiK2XIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5603B1A07C
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 15:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669763262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLZ5Zb0FMcgu9a248FF0yO4LaK1oKSPwkjdRN3S+Dwo=;
        b=AXFvEL9EQ64PrkbavYQDjhxiYJvrlJt4zzb/7Tvajr5C90Zv2+bbUILABh5RToMaEgs9Wj
        61sJVgJPC8jWPH2+Bwj8jt0n3AvZvP7r5pYii1oJV/plqfweLY4w0T6mu89Rp7CBQH1mEv
        dlonVQRIbbRUYUl5L5Hw/QLg4WD1y7s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-6rFX7KCrMZCvjshGWIconQ-1; Tue, 29 Nov 2022 18:07:41 -0500
X-MC-Unique: 6rFX7KCrMZCvjshGWIconQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DC1C3C0257E;
        Tue, 29 Nov 2022 23:07:40 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-2.brq.redhat.com [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2049940C6EC4;
        Tue, 29 Nov 2022 23:07:38 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] fs: Add activate_super function
Date:   Wed, 30 Nov 2022 00:07:33 +0100
Message-Id: <20221129230736.3462830-2-agruenba@redhat.com>
In-Reply-To: <20221129230736.3462830-1-agruenba@redhat.com>
References: <20221129230736.3462830-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add function activate_super() for grabbing an active reference on a
super block.  Fails if the filesystem is already shutting down.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/super.c         | 19 +++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 8d39e4f11cfa..051241cf408b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -393,6 +393,25 @@ static int grab_super(struct super_block *s) __releases(sb_lock)
 	return 0;
 }
 
+/**
+ * activate_super - try to grab an active reference on the superblock
+ * @sb: reference we are trying to grab
+ *
+ * Try to grab an active reference on the superblock to prevent filesystem
+ * shutdown.  Fails if the filesystem is already shutting down (see
+ * deactivate_locked_super()).
+ */
+bool activate_super(struct super_block *sb)
+{
+	if (atomic_inc_not_zero(&sb->s_active)) {
+		smp_mb__after_atomic();
+		BUG_ON(!(sb->s_flags & SB_BORN));
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL(activate_super);
+
 /*
  *	trylock_super - try to grab ->s_umount shared
  *	@sb: reference we are trying to grab
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f1651..84c609123a25 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2573,6 +2573,7 @@ void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
 void kill_anon_super(struct super_block *sb);
 void kill_litter_super(struct super_block *sb);
+bool activate_super(struct super_block *sb);
 void deactivate_super(struct super_block *sb);
 void deactivate_locked_super(struct super_block *sb);
 int set_anon_super(struct super_block *s, void *data);
-- 
2.38.1

