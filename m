Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF752A22F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346917AbiEQM44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346768AbiEQM41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 08:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F2DF3EF24
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652792185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sr0Su8VmpTGq2+kXIOmhRI/79j0nmk1mBS04kJYAJN4=;
        b=etkPLNmQxqFyF/WTjAhyVeILDFQYKg/cDIspuAQvA91nl6zEQ/d3gUV3sySqEUlcZVtOnJ
        j65+WdLeDsalhi/xtlKcxGt0e/SMAKNheJzNZsHx9K6V4WH/kKL9UnZmQmMUvjY+isccoX
        T8OdPKPRU/Xbjf9o0eFVQzfeoPpWqsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-NBh8JBGjNfWaNAzY3H9YEA-1; Tue, 17 May 2022 08:56:22 -0400
X-MC-Unique: NBh8JBGjNfWaNAzY3H9YEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AD27100BAA9;
        Tue, 17 May 2022 12:56:21 +0000 (UTC)
Received: from localhost (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEDEB2166B2F;
        Tue, 17 May 2022 12:56:20 +0000 (UTC)
From:   Xiubo Li <xiubli@redhat.com>
To:     jlayton@kernel.org, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, dchinner@redhat.com, hch@lst.de,
        arnd@arndb.de, mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v3 1/2] fs/dcache: add d_compare() helper support
Date:   Tue, 17 May 2022 20:55:48 +0800
Message-Id: <20220517125549.148429-2-xiubli@redhat.com>
In-Reply-To: <20220517125549.148429-1-xiubli@redhat.com>
References: <20220517125549.148429-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

