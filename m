Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191711BA62B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgD0OTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 10:19:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43311 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727985AbgD0OTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587997139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZxH84mqOgKUCIrltch+dX9fSv+/5ZQHenb5aSxFeqI=;
        b=MhrB9SOZuYuUWarB4VshQ1wQhVcgnOCvwgmc0PNKfkYU79QgLontTWvJAJN7dSxG9S0OVa
        /6vI3qz5NhRzXMvtS5zrQuakZsWldA6R9ed1dH1rVkJT9tIfw5SxGAi8hcTp5J+/OtvJn5
        axHIE9pXQT8px454qjuyPZYNRYp/e2I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ebqsVYVJOSaxhNb2flqufw-1; Mon, 27 Apr 2020 10:18:27 -0400
X-MC-Unique: ebqsVYVJOSaxhNb2flqufw-1
Received: by mail-wm1-f71.google.com with SMTP id 14so8707493wmo.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 07:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZxH84mqOgKUCIrltch+dX9fSv+/5ZQHenb5aSxFeqI=;
        b=qWrLT8oVGLs6jHY1TDUZe2WewF3CRTzIqduymvH5pyDmOXg9Q9WI6dpKX5GvDcDsgs
         c//IMcm33mQaX0ZQhQtdXo3ZhcG3f99ETGcNIw+qVYST8Hni6sZNNzHoWIZOU1nTzmTG
         kj5HcPx63GVfUyvm/tiAAdV0rfeC7mSo4W91+ETFg0y40x77vWHjYnBShptemXhdf1ke
         lAQpDZFkAwK2GcO6g5ttUhFqLKVkFKp/+XNo44LpWoh8DiLy3ykDs1V6LucqtUJ6vCbD
         g2NpGhGROJUybk4PtujAJMoAFmA7DHpNvvgEBCuJqT3Ak8H1F+OGuAd2GGdGGPpM9e6p
         ZEUg==
X-Gm-Message-State: AGi0PublmCccRdI5IXZc9DOLkYEtreA4aAcswbCX5wlHcuLAv2SeGIgv
        65O01KoRc6oFcO3UswaQrNWS5AAggnleiZ1MijEd9FywXwxgTePuPGZw31HIog/HKVejOQ4IIwn
        jH8MxQEJ2kAlTdczXdNENQb2qig==
X-Received: by 2002:a5d:5229:: with SMTP id i9mr20226224wra.369.1587997105764;
        Mon, 27 Apr 2020 07:18:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ2mzAfAvgNc5tkRv8j6wCds01EzaWcBsdB1ns7Ni6rVvdogJtNeYjoRzA+wfMM26qrttwXeQ==
X-Received: by 2002:a5d:5229:: with SMTP id i9mr20226201wra.369.1587997105578;
        Mon, 27 Apr 2020 07:18:25 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.207])
        by smtp.gmail.com with ESMTPSA id 1sm15914570wmz.13.2020.04.27.07.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:18:24 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [RFC PATCH 1/5] refcount, kref: add dec-and-test wrappers for rw_semaphores
Date:   Mon, 27 Apr 2020 16:18:12 +0200
Message-Id: <20200427141816.16703-2-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200427141816.16703-1-eesposit@redhat.com>
References: <20200427141816.16703-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to the existing functions that take a mutex or spinlock if and
only if a reference count is decremented to zero, these new function
take an rwsem for writing just before the refcount reaches 0 (and
call a user-provided function in the case of kref_put_rwsem).

These will be used for statsfs_source data structures, which are
protected by an rw_semaphore to allow concurrent sysfs reads.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 include/linux/kref.h     | 11 +++++++++++
 include/linux/refcount.h |  2 ++
 lib/refcount.c           | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c..2dc935445f45 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -79,6 +79,17 @@ static inline int kref_put_mutex(struct kref *kref,
 	return 0;
 }
 
+static inline int kref_put_rwsem(struct kref *kref,
+				 void (*release)(struct kref *kref),
+				 struct rw_semaphore *rwsem)
+{
+	if (refcount_dec_and_down_write(&kref->refcount, rwsem)) {
+		release(kref);
+		return 1;
+	}
+	return 0;
+}
+
 static inline int kref_put_lock(struct kref *kref,
 				void (*release)(struct kref *kref),
 				spinlock_t *lock)
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0e3ee25eb156..a9d5038aec9a 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -99,6 +99,7 @@
 #include <linux/spinlock_types.h>
 
 struct mutex;
+struct rw_semaphore;
 
 /**
  * struct refcount_t - variant of atomic_t specialized for reference counts
@@ -313,6 +314,7 @@ static inline void refcount_dec(refcount_t *r)
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
+extern __must_check bool refcount_dec_and_down_write(refcount_t *r, struct rw_semaphore *rwsem);
 extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock);
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
 						       spinlock_t *lock,
diff --git a/lib/refcount.c b/lib/refcount.c
index ebac8b7d15a7..03e113e1b43a 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/refcount.h>
 #include <linux/spinlock.h>
 #include <linux/bug.h>
@@ -94,6 +95,37 @@ bool refcount_dec_not_one(refcount_t *r)
 }
 EXPORT_SYMBOL(refcount_dec_not_one);
 
+/**
+ * refcount_dec_and_down_write - return holding rwsem for writing if able to decrement
+ *                               refcount to 0
+ * @r: the refcount
+ * @lock: the mutex to be locked
+ *
+ * Similar to atomic_dec_and_mutex_lock(), it will WARN on underflow and fail
+ * to decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides a control dependency such that free() must come after.
+ * See the comment on top.
+ *
+ * Return: true and hold rwsem for writing if able to decrement refcount to 0, false
+ *         otherwise
+ */
+bool refcount_dec_and_down_write(refcount_t *r, struct rw_semaphore *lock)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	down_write(lock);
+	if (!refcount_dec_and_test(r)) {
+		up_write(lock);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(refcount_dec_and_down_write);
+
 /**
  * refcount_dec_and_mutex_lock - return holding mutex if able to decrement
  *                               refcount to 0
-- 
2.25.2

