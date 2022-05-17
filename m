Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AAA529674
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 03:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiEQBDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 21:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242712AbiEQBDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 21:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D5764704F
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 18:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652749408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sr0Su8VmpTGq2+kXIOmhRI/79j0nmk1mBS04kJYAJN4=;
        b=P80qJer+uZ0yp6CwmrVtY4iIsVyMZ4IZax86NeFWPsPiHb1T6iNraSMOZZCe8ASAfxJwej
        TqIS4byfjG527FPqrtasrm4PNSnQkMpolmhsHlu0AD4z0G78PsKB7QRclRs6HZFGBWKPvG
        B8ZZmw3SyNSDHJpStRozuFNmPljkyQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-KnC_sT4AMFiEFxMcx4vgGw-1; Mon, 16 May 2022 21:03:24 -0400
X-MC-Unique: KnC_sT4AMFiEFxMcx4vgGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2719B80A0B9;
        Tue, 17 May 2022 01:03:24 +0000 (UTC)
Received: from localhost (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C7FD7774;
        Tue, 17 May 2022 01:03:23 +0000 (UTC)
From:   Xiubo Li <xiubli@redhat.com>
To:     jlayton@kernel.org, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2 1/2] fs/dcache: add d_compare() helper support
Date:   Tue, 17 May 2022 09:03:15 +0800
Message-Id: <20220517010316.81483-2-xiubli@redhat.com>
In-Reply-To: <20220517010316.81483-1-xiubli@redhat.com>
References: <20220517010316.81483-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/dcache.c            | 15 +++++++++++++++
 include/linux/dcache.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 93f4f5ee07bf..95a72f92a94b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2262,6 +2262,21 @@ static inline bool d_same_name(const struct dentry *dentry,
 				       name) == 0;
 }
 
+/**
+ * d_compare - compare dentry name with case-exact name
+ * @parent: parent dentry
+ * @dentry: the negative dentry that was passed to the parent's lookup func
+ * @name:   the case-exact name to be associated with the returned dentry
+ *
+ * Return: 0 if names are same, or 1
+ */
+bool d_compare(const struct dentry *parent, const struct dentry *dentry,
+	       const struct qstr *name)
+{
+	return !d_same_name(dentry, parent, name);
+}
+EXPORT_SYMBOL(d_compare);
+
 /**
  * __d_lookup_rcu - search for a dentry (racy, store-free)
  * @parent: parent dentry
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba51480b2..444b2230e5c3 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -233,6 +233,8 @@ extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
 					wait_queue_head_t *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
+extern bool d_compare(const struct dentry *parent, const struct dentry *dentry,
+		      const struct qstr *name);
 extern struct dentry * d_exact_alias(struct dentry *, struct inode *);
 extern struct dentry *d_find_any_alias(struct inode *inode);
 extern struct dentry * d_obtain_alias(struct inode *);
-- 
2.36.0.rc1

