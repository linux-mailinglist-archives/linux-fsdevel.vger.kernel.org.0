Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2491C37AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 13:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgEDLEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 07:04:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50784 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726756AbgEDLD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 07:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588590237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09losalqRUJ7midVbFAi44IAzVHZ/Wi/7WIU6kwrX9U=;
        b=aP8Xk5B2XSZslWTPJEtoZD2+FbHEpogFWzDcb/Ne6jdtOAhecXYddgLCVjRyhBNmtuFgB+
        3U5zGypGzxxXXsUfjGr2s6P6rKvAeslVYu1VzsES9IFPmAlbDb/h0KTkTsAAi5ODZHp7mP
        CH/WBuNH7mtum5HzquLOSizg3vqg0Oo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-34JKpV7JPK67hmQy0cbPyA-1; Mon, 04 May 2020 07:03:54 -0400
X-MC-Unique: 34JKpV7JPK67hmQy0cbPyA-1
Received: by mail-wm1-f72.google.com with SMTP id b203so3298897wmd.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 04:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09losalqRUJ7midVbFAi44IAzVHZ/Wi/7WIU6kwrX9U=;
        b=WwL8h32NnDnF0T/gy1mZ/sMBa7WYNX8Akiws9vQ32GDSWqk63zyLCc1tob/o9rlRnd
         dRc2/IfDLZE5ajJVkuM0owjSESd8eBRo4qJzhRIV9+NIYtaKS/vF5h/qXkUUVqUiHmpP
         vGfM4HiOne5N73etXZoh4B4iVIMsBWQUFuLItPbWFkSOX4RM5YTcdGy0EZGlSXZrRnLA
         +puaWUV+2lpXTaw746WAxwaFQRG6kmR1EPC4U27a2OKzfoZmRDdUEfltoi6YwKMURSOb
         O922U840taYnt6Tj2O9GrmETon8QWUUu7un4WZU7WRiZEkItmNL45maqtR+SRzsaUKdH
         FyqA==
X-Gm-Message-State: AGi0Pubvf5FC1cbtRonq6SfpTYnJafg7S+XrqGkNQD6t1iMTen8LtcW0
        PeZLuodjaSsS1qYK5zf2DBbMCsAvldp6ityanwiZGTCLFO4Xz6ItxQFwMo2jNPFbqc2wgxiZqEn
        tRlMT0XovLdFtzcYt7+eEY7d32A==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr6739131wrc.24.1588590232891;
        Mon, 04 May 2020 04:03:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJvuRFnJ0VBK5Hu4muwInjRtI3dy4S4pn3siD3o26S579ZPY0C/y2BIROU3uJD8eKGxaBWo7w==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr6739098wrc.24.1588590232648;
        Mon, 04 May 2020 04:03:52 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id a13sm10885750wrv.67.2020.05.04.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:03:52 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 1/5] refcount, kref: add dec-and-test wrappers for rw_semaphores
Date:   Mon,  4 May 2020 13:03:40 +0200
Message-Id: <20200504110344.17560-2-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504110344.17560-1-eesposit@redhat.com>
References: <20200504110344.17560-1-eesposit@redhat.com>
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

These will be used for stats_fs_source data structures, which are
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

