Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91051BD8B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD2Jte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 05:49:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31038 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726676AbgD2Jte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588153772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbs27IXMBaJcsgy3STOZVEUhkP5D7KawKdkHQuyWL3c=;
        b=S72lMrJDjgGGrdhQN9VtoUpcb62qHMfpnwlxBgg9ftY07ZeGLPRmmewCcw6cweF/Og0mmB
        1odbHVmjS38DkY020JQkyVdiRJjjr/BN5m3++0woW0oka5M2xmtlpqXSabhB5qwdgtikPD
        yhWV8NCVj9NB1DXaduqGuuZlOD6wtsM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-SBYd3gVGNb2n-Kly0HbRzA-1; Wed, 29 Apr 2020 05:49:31 -0400
X-MC-Unique: SBYd3gVGNb2n-Kly0HbRzA-1
Received: by mail-wm1-f70.google.com with SMTP id b203so784962wmd.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 02:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbs27IXMBaJcsgy3STOZVEUhkP5D7KawKdkHQuyWL3c=;
        b=SlD6uKsubeRnCH7aTOb7K48lK3Ikn26MnNYKVRJf+huxN0trEwEj6fSL36BAzPNqbd
         85qstoyYzO3g/86Jn7wzbwR1nzOn9vYgmYpsdrbz7j3M/MqMEws4SNVKItpib65YTDrp
         DhNDbHF3HCePTK1/GrsTjhU2bNYs9NUSxqW2EBSK5KyTX68GzlK84GgEmT6u0Uh/GIJc
         ye9DbbuSruq6v9tooZAhhpx5WMh7D4pH+mPsfahIeJyFcGoPf4wRGnbk//Lp7nbh6C+q
         1h9Z0/aXdo6pP6gkGLYMZZqWvy3Zlr6A9ASZhLmWLGDnJdUNUJQkvGdVmIIwRCCDgvzK
         u/FA==
X-Gm-Message-State: AGi0Pub9qOQfsHSwoDEV3ggYR4kejTBG2ZKeYoys9U4HYzQddDvHuM7Y
        0wwLZNqp5J7WbkbwNdWDI18whI31RuhewgBItgbKV5emUamGRCFMBcXiJ7BSj0GCZ54vb9XELpp
        tGGmmN4vzKn+pjxsa4Njywkm7Cw==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr40790321wrr.360.1588153770039;
        Wed, 29 Apr 2020 02:49:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypL3lOosPELSXYfi/Ql2ON5M3P/FRdYdFKW7FpT8yKLlLalIpi9flCq1OR+1XzHDC86bYLP/TQ==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr40790296wrr.360.1588153769812;
        Wed, 29 Apr 2020 02:49:29 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.226])
        by smtp.gmail.com with ESMTPSA id y18sm7506030wmc.45.2020.04.29.02.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:49:29 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [RFC PATCH 2/5] statsfs API: create, add and remove statsfs
Date:   Wed, 29 Apr 2020 11:49:22 +0200
Message-Id: <20200429094922.55032-1-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200427154727.GH29705@bombadil.infradead.org>
References: <20200427154727.GH29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mattew,
I am trying to apply your Xarrays suggestion, but I don't
understand how to make them properly work. In particular, the __xa_alloc
function always returns -EINVAL.

I tried to follow the Xarrays kernel doc and the example you provided to
replace the subordinates linked list, but alloc always returns that error.

Below you can find the changes I intended to do.
Can you help me?

Thank you,
Emanuele

------ 8< -----------
From ad5d20b6ce7995b2d1164104cf958f7bc3e692fa Mon Sep 17 00:00:00 2001
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Date: Tue, 28 Apr 2020 12:21:00 +0200
Subject: [PATCH] statsfs: switch subordinate sources to xarray

---
 fs/statsfs/statsfs.c    | 45 +++++++++++++++++++++++++++--------------
 include/linux/statsfs.h |  5 ++---
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/fs/statsfs/statsfs.c b/fs/statsfs/statsfs.c
index c8cfa590a3b0..0cf135c36776 100644
--- a/fs/statsfs/statsfs.c
+++ b/fs/statsfs/statsfs.c
@@ -107,11 +107,12 @@ const struct file_operations statsfs_ops = {
 static void statsfs_source_remove_files_locked(struct statsfs_source *src)
 {
 	struct statsfs_source *child;
+	unsigned long index;
 
 	if (src->source_dentry == NULL)
 		return;
 
-	list_for_each_entry(child, &src->subordinates_head, list_element)
+	xa_for_each (&src->subordinates, index, child)
 		statsfs_source_remove_files(child);
 
 	statsfs_remove_recursive(src->source_dentry);
@@ -180,6 +181,7 @@ static void statsfs_create_files_recursive_locked(struct statsfs_source *source,
 						  struct dentry *parent_dentry)
 {
 	struct statsfs_source *child;
+	unsigned long index;
 
 	/* first check values in this folder, since it might be new */
 	if (!source->source_dentry) {
@@ -189,7 +191,7 @@ static void statsfs_create_files_recursive_locked(struct statsfs_source *source,
 
 	statsfs_create_files_locked(source);
 
-	list_for_each_entry(child, &source->subordinates_head, list_element) {
+	xa_for_each (&source->subordinates, index, child) {
 		if (child->source_dentry == NULL) {
 			/* assume that if child has a folder,
 			 * also the sub-child have that.
@@ -258,10 +260,23 @@ EXPORT_SYMBOL_GPL(statsfs_source_add_values);
 void statsfs_source_add_subordinate(struct statsfs_source *source,
 				    struct statsfs_source *sub)
 {
+	int err;
+	uint32_t index;
+
 	down_write(&source->rwsem);
 
 	statsfs_source_get(sub);
-	list_add(&sub->list_element, &source->subordinates_head);
+	err = __xa_alloc(&source->subordinates, &index, sub, xa_limit_32b,
+		       GFP_KERNEL);
+
+	if (err) {
+		printk(KERN_ERR "Failed to insert subordinate %s\n"
+			"Too many subordinates in source %s\n",
+			sub->name, source->name);
+		up_write(&source->rwsem);
+		return;
+	}
+
 	if (source->source_dentry)
 		statsfs_create_files_recursive_locked(sub,
 						      source->source_dentry);
@@ -276,10 +291,11 @@ statsfs_source_remove_subordinate_locked(struct statsfs_source *source,
 					 struct statsfs_source *sub)
 {
 	struct statsfs_source *src_entry;
+	unsigned long index;
 
-	list_for_each_entry(src_entry, &source->subordinates_head, list_element) {
+	xa_for_each (&source->subordinates, index, src_entry) {
 		if (src_entry == sub) {
-			list_del_init(&src_entry->list_element);
+			xa_erase(&source->subordinates, index);
 			statsfs_source_remove_files(src_entry);
 			statsfs_source_put(src_entry);
 			return;
@@ -431,13 +447,13 @@ static void do_recursive_aggregation(struct statsfs_source *root,
 				     struct statsfs_aggregate_value *agg)
 {
 	struct statsfs_source *subordinate;
+	unsigned long index;
 
 	/* search all simple values in this folder */
 	search_all_simple_values(root, ref_src_entry, val, agg);
 
 	/* recursively search in all subfolders */
-	list_for_each_entry(subordinate, &root->subordinates_head,
-			     list_element) {
+	xa_for_each (&root->subordinates, index, subordinate) {
 		down_read(&subordinate->rwsem);
 		do_recursive_aggregation(subordinate, ref_src_entry, val, agg);
 		up_read(&subordinate->rwsem);
@@ -571,13 +587,13 @@ static void do_recursive_clean(struct statsfs_source *root,
 			       struct statsfs_value *val)
 {
 	struct statsfs_source *subordinate;
+	unsigned long index;
 
 	/* search all simple values in this folder */
 	set_all_simple_values(root, ref_src_entry, val);
 
 	/* recursively search in all subfolders */
-	list_for_each_entry(subordinate, &root->subordinates_head,
-			     list_element) {
+	xa_for_each (&root->subordinates, index, subordinate) {
 		down_read(&subordinate->rwsem);
 		do_recursive_clean(subordinate, ref_src_entry, val);
 		up_read(&subordinate->rwsem);
@@ -703,9 +719,10 @@ EXPORT_SYMBOL_GPL(statsfs_source_revoke);
  */
 static void statsfs_source_destroy(struct kref *kref_source)
 {
-	struct statsfs_value_source *val_src_entry;
 	struct list_head *it, *safe;
+	struct statsfs_value_source *val_src_entry;
 	struct statsfs_source *child, *source;
+	unsigned long index;
 
 	source = container_of(kref_source, struct statsfs_source, refcount);
 
@@ -717,15 +734,14 @@ static void statsfs_source_destroy(struct kref *kref_source)
 	}
 
 	/* iterate through the subordinates and delete them */
-	list_for_each_safe(it, safe, &source->subordinates_head) {
-		child = list_entry(it, struct statsfs_source, list_element);
+	xa_for_each (&source->subordinates, index, child)
 		statsfs_source_remove_subordinate_locked(source, child);
-	}
 
 	statsfs_source_remove_files_locked(source);
 
 	up_write(&source->rwsem);
 	kfree(source->name);
+	xa_destroy(&source->subordinates);
 	kfree(source);
 }
 
@@ -761,8 +777,7 @@ struct statsfs_source *statsfs_source_create(const char *fmt, ...)
 	init_rwsem(&ret->rwsem);
 
 	INIT_LIST_HEAD(&ret->values_head);
-	INIT_LIST_HEAD(&ret->subordinates_head);
-	INIT_LIST_HEAD(&ret->list_element);
+	xa_init(&ret->subordinates);
 
 	return ret;
 }
diff --git a/include/linux/statsfs.h b/include/linux/statsfs.h
index f6e8eead1124..20153f50ffc0 100644
--- a/include/linux/statsfs.h
+++ b/include/linux/statsfs.h
@@ -11,6 +11,7 @@
 #define _STATSFS_H_
 
 #include <linux/list.h>
+#include <linux/xarray.h>
 
 /* Used to distinguish signed types */
 #define STATSFS_SIGN 0x8000
@@ -64,9 +65,7 @@ struct statsfs_source {
 	struct list_head values_head;
 
 	/* list of struct statsfs_source for subordinate sources */
-	struct list_head subordinates_head;
-
-	struct list_head list_element;
+	struct xarray subordinates;
 
 	struct rw_semaphore rwsem;
 
-- 
2.25.2

