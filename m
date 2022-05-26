Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE55347FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbiEZBRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245633AbiEZBRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD76E57992
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653527866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BY0uwuvfpByIIEbA88X1ubdt91de5QP6Qq8gloHmh0c=;
        b=YyAddy/44yomVNkYnVsMewozc9FCegOrdFJpkufVmap6teNJkQ0UH1K+oxUXz0dUB5fHkY
        KnWyKyGzBXuyA6N13E5Nn6bDBEOev2UloGRmuiAzJ2sQC6+lNufr1OUpqvWZBr/PxdcS1F
        HuD0wA32xGBb27A3leezZsl2Il97H3M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-IXXakG4mN7mno6SV09tZgQ-1; Wed, 25 May 2022 21:17:43 -0400
X-MC-Unique: IXXakG4mN7mno6SV09tZgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B6C638041C6;
        Thu, 26 May 2022 01:17:43 +0000 (UTC)
Received: from localhost (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 903A32166B26;
        Thu, 26 May 2022 01:17:42 +0000 (UTC)
From:   Xiubo Li <xiubli@redhat.com>
To:     jlayton@kernel.org, idryomov@gmail.com, viro@zeniv.linux.org.uk
Cc:     willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v6 1/2] fs/dcache: export d_same_name() helper
Date:   Thu, 26 May 2022 09:17:36 +0800
Message-Id: <20220526011737.371483-2-xiubli@redhat.com>
In-Reply-To: <20220526011737.371483-1-xiubli@redhat.com>
References: <20220526011737.371483-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Compare dentry name with case-exact name, return true if names
are same, or false.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/dcache.c            | 15 +++++++++++----
 include/linux/dcache.h |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 93f4f5ee07bf..a409312ee0df 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2247,10 +2247,16 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 }
 EXPORT_SYMBOL(d_add_ci);
 
-
-static inline bool d_same_name(const struct dentry *dentry,
-				const struct dentry *parent,
-				const struct qstr *name)
+/**
+ * d_same_name - compare dentry name with case-exact name
+ * @parent: parent dentry
+ * @dentry: the negative dentry that was passed to the parent's lookup func
+ * @name:   the case-exact name to be associated with the returned dentry
+ *
+ * Return: true if names are same, or false
+ */
+bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
+		 const struct qstr *name)
 {
 	if (likely(!(parent->d_flags & DCACHE_OP_COMPARE))) {
 		if (dentry->d_name.len != name->len)
@@ -2261,6 +2267,7 @@ static inline bool d_same_name(const struct dentry *dentry,
 				       dentry->d_name.len, dentry->d_name.name,
 				       name) == 0;
 }
+EXPORT_SYMBOL_GPL(d_same_name);
 
 /**
  * __d_lookup_rcu - search for a dentry (racy, store-free)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba51480b2..bb72361834de 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -233,6 +233,8 @@ extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
 					wait_queue_head_t *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
+extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
+			const struct qstr *name);
 extern struct dentry * d_exact_alias(struct dentry *, struct inode *);
 extern struct dentry *d_find_any_alias(struct inode *inode);
 extern struct dentry * d_obtain_alias(struct inode *);
-- 
2.36.0.rc1

