Return-Path: <linux-fsdevel+bounces-29839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE697E9FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 12:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49ED1C2115F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2827A1974FA;
	Mon, 23 Sep 2024 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxBaIGhl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF27194C83
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727087957; cv=none; b=P4hjXESfKhDFY0Sf8HNiZzCxCysKZUn9Y5AMATlmlUwlz/mZ5r0fLBBUpwxujgfAywNYoWxPEs5qeRG0ruftQLQ3V7abef5wgkyxgl+j6y0SQ9aUxiELFyyG9HCrdWNL14acIKHewInxLnmAbGueKF238LZhPAgt7xhlksNgPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727087957; c=relaxed/simple;
	bh=CH65LImeA31V2gjQos723kYI2pAomGpkq/i+T/O62kQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W1PdKPYCqvQRp1kA5oO1SOskIHapDjvQGDGpsvcHWBWuPlYGpIyTyYDrnLapHwfuvrbDQAWOljpm8cXPipBcfvjAvuhALhWbL2ZP7aUYjE2hWEAFo0RAlhiPnSoyYPsVYR//2D0UGZaZfNgIIYyCWjOCn7GsOe65HopNaBRBDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxBaIGhl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb050acc3so21454265e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727087954; x=1727692754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+7IA8B4S/OjOJloT0o9UpFRo091wD5m6NGMGUoTT03Y=;
        b=NxBaIGhlYGAwrGWZnWhT7rrsakAQeqNvx+7V3t05icEMuqPDubpzPeW3fr2hP+Rxy1
         piN5s5pAS4crRCZmBsiB/txvbIhrfTrZhkQI1/+jtbSSnqOMxyEVRQZqe/EqCrddJfpz
         oM1xDdj95yk3Gn87ra2vFb1Id1epmt8q39rUYhB7uCplJlHl0TxygzadVy4Q7rBu+8En
         Lq1fXL//+vQn31xVyAgu0zZv/ehFX2U49coxuty1+cHYkqr3+WsX46PUSeK5ItXjkI/Y
         7dySRew9N/cfz0CqdOY7lpVeB8jzUfhSFcbOZ1+ChclIhSlb9Z9O58MqqJWPTMrX02D/
         JSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727087954; x=1727692754;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7IA8B4S/OjOJloT0o9UpFRo091wD5m6NGMGUoTT03Y=;
        b=QKHH+Ez/xTJdydXU16FiXWHP8mJqYDG/c0QtbiVyn94ZxVPfaauknW3wmCJTTNZhq9
         UKE8Rduv+Gv6fGmIu4aVSZPURPae6dvd+3HfNfHVz6M7z+opABf/MXLlBzBeEPkEc4bN
         Yef26zxx9DAjfiZeMFL0+9hnZJ2B+3fNj+iHcv7bzSjMt/aRXMvsZwkPaDL+iak2trVL
         9i4w3cmV4bke2N9J3NcWMYltwDVYZ72eTxxldAd2dipCEf07//doFQhhDkd1GMLSVWQ+
         UIvke66MN/XaQ8UHDaba/v6nmJ7IX3g06BQLqx9HbP3iHQrVpKgnohJ2omCQzQ9MBu02
         flbQ==
X-Gm-Message-State: AOJu0YwZ2DGf0WsddrG8GqkDKVYYAiDiwWqvgBYNzYNrGQJQV5Yj2HbV
	gUpunGfNKTH7GPntZ5kJQak5heXG1aBy0aMnhIl4Hs6NxXrFq8GhncTiuiI9nBIVWMrlE7Y/Wj9
	HWYGsnc75duWp2g==
X-Google-Smtp-Source: AGHT+IGnmDgpLMMur7aPg5uBT28jOb2AJr+cKC1CN46Ca0eTDLuzHjLPHmc/6gPU+glijQp5LkiefARc8INsayI=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a7b:cb43:0:b0:42c:a8d4:2554 with SMTP id
 5b1f17b1804b1-42e7a9e4172mr1703825e9.4.1727087953720; Mon, 23 Sep 2024
 03:39:13 -0700 (PDT)
Date: Mon, 23 Sep 2024 10:38:48 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=18252; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CH65LImeA31V2gjQos723kYI2pAomGpkq/i+T/O62kQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm8UTB8rWceIYWmnvhfTXkX7Pd8EPJFuXbYmj3L
 E2wLzwHIYWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvFEwQAKCRAEWL7uWMY5
 RuwtD/9tnxW/3xlZLDnRrvcc4Nm0nRM9oZTussFIJ5PxfauSgqZm+2N3C7B/gVRSc6T1sBQ1w4x
 wxJs1K5mzOjhddFirMucA5lmCB5Kg89B2SkJzeILQQisReRw+hsIWqmSHaCwt7NQv+JtQq7grBg
 Y9nElhLRXniIQEV8HBURYltKn7im7Z+TNdt38hUeOurXeYJTZ1zD6KxG9VtiVfJfUB1Bv7ptGGj
 vSGZQPZGBjO+j179VyeXNw0jxEUDZGR444nlbzVONxpTPnljnCGhxnPkbAnJRlZ3WLQAOyNUksP
 MEUOC+f4BHkJvNKnurW8P0d0S6HkVPo2elJwOEzlAMrEGZpHLk403LdvOGoxO0zFhahDYMR+DuA
 UqhKYJTTVvrIOsB5MKj1Q/lBf0O/P+b/rRwtGdL9D3r1uPgxjhRT/njeqdUj/CJNmXU/AH6L2J+
 JDSpE2XUA1PhFOP0Wt2lgJm2jdW+Gh8tOiPRJRaEmIPDuMJxx7wNndxqftA+Vj8X27YfwbhXxLh
 E101ca/SKOAbQk4N+c/SHaGGZCdTt7faDly1vxPEl1nWu0UzYFW2gT9Lewlt/x04kROABrVuVLl
 Aqi0WZYdjRrHf0uvHJLi1KrZC4swvMxE5k/UpuDCHM4me5OdgUmJpHwKebkD1PDqoDbrGxkA8G1 7Qs7bAuUjJvXViA==
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923-xa_enter_leave-v1-1-6ff365e8520a@google.com>
Subject: [PATCH] xarray: rename xa_lock/xa_unlock to xa_enter/xa_leave
From: Alice Ryhl <aliceryhl@google.com>
To: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

Functions such as __xa_store() may temporarily unlock the internal
spinlock if allocation is necessary. This means that code such as

	xa_lock(xa);
	__xa_store(xa, idx1, ptr1, GFP_KERNEL);
	__xa_store(xa, idx2, ptr2, GFP_KERNEL);
	xa_unlock(xa);

does not prevent the situation where another thread sees the first store
without seeing the second store. Even if GFP_ATOMIC is used, this can
still happen if the reader uses xa_load without taking the xa_lock. This
is not the behavior that you would expect from a lock. We should not
subvert the expectations of the reader.

Thus, rename xa_lock/xa_unlock to xa_enter/xa_leave. Users of the XArray
will have fewer implicit expectations about how functions with these
names will behave, which encourages users to check the documentation.
The documentation is amended with additional notes about these caveats.

The previous example becomes:

	xa_enter(xa);
	__xa_store(xa, idx1, ptr1, GFP_KERNEL);
	__xa_store(xa, idx2, ptr2, GFP_KERNEL);
	xa_leave(xa);

Existing users of the function will be updated to use the new name in
follow-up patches. The old names will be deleted later to avoid
conflicts with new code using xa_lock().

The idea to rename these functions came up during a discussion at
the Linux Plumbers conference 2024. I was working on a Rust API for
using the XArray from Rust code, but I was dissatisfied with the Rust
API being too confusing for the same reasons as outlined above.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 Documentation/core-api/xarray.rst |  75 ++++++++++++-------
 include/linux/xarray.h            | 148 +++++++++++++++++++++++---------------
 2 files changed, 141 insertions(+), 82 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 77e0ece2b1d6..2f3546cc2db2 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -200,7 +200,7 @@ Takes RCU read lock:
  * xa_extract()
  * xa_get_mark()
 
-Takes xa_lock internally:
+Internally calls xa_enter to lock spinlock:
  * xa_store()
  * xa_store_bh()
  * xa_store_irq()
@@ -224,7 +224,7 @@ Takes xa_lock internally:
  * xa_set_mark()
  * xa_clear_mark()
 
-Assumes xa_lock held on entry:
+Caller must use xa_enter:
  * __xa_store()
  * __xa_insert()
  * __xa_erase()
@@ -233,14 +233,41 @@ Assumes xa_lock held on entry:
  * __xa_set_mark()
  * __xa_clear_mark()
 
+Variants of xa_enter and xa_leave:
+ * xa_enter()
+ * xa_tryenter()
+ * xa_enter_bh()
+ * xa_enter_irq()
+ * xa_enter_irqsave()
+ * xa_enter_nested()
+ * xa_enter_bh_nested()
+ * xa_enter_irq_nested()
+ * xa_enter_irqsave_nested()
+ * xa_leave()
+ * xa_leave_bh()
+ * xa_leave_irq()
+ * xa_leave_irqrestore()
+
+The xa_enter() and xa_leave() functions correspond to spin_lock() and
+spin_unlock() on the internal spinlock.  Be aware that functions such as
+__xa_store() may temporarily unlock the internal spinlock to allocate memory.
+Because of that, if you have several calls to __xa_store() between a single
+xa_enter()/xa_leave() pair, other users of the XArray may see the first store
+without seeing the second store.  The xa_enter() function is not called xa_lock()
+to emphasize this distinction.
+
-If you want to take advantage of the lock to protect the data structures
-that you are storing in the XArray, you can call xa_lock()
-before calling xa_load(), then take a reference count on the
-object you have found before calling xa_unlock().  This will
-prevent stores from removing the object from the array between looking
-up the object and incrementing the refcount.  You can also use RCU to
-avoid dereferencing freed memory, but an explanation of that is beyond
-the scope of this document.
+If you want to take advantage of the lock to protect the data stored in the
+XArray, then you can use xa_enter() and xa_leave() to enter and leave the
+critical region of the internal spinlock. For example, you can enter the critcal
+region with xa_enter(), look up a value with xa_load(), increment the refcount,
+and then call xa_leave().  This will prevent stores from removing the object
+from the array between looking up the object and incrementing the refcount.
+
+Instead of xa_enter(), you can also use RCU to increment the refcount, but an
+explanation of that is beyond the scope of this document.
+
+Interrupts
+----------
 
 The XArray does not disable interrupts or softirqs while modifying
 the array.  It is safe to read the XArray from interrupt or softirq
@@ -258,21 +285,21 @@ context and then erase them in softirq context, you can do that this way::
     {
         int err;
 
-        xa_lock_bh(&foo->array);
+        xa_enter_bh(&foo->array);
         err = xa_err(__xa_store(&foo->array, index, entry, GFP_KERNEL));
         if (!err)
             foo->count++;
-        xa_unlock_bh(&foo->array);
+        xa_leave_bh(&foo->array);
         return err;
     }
 
     /* foo_erase() is only called from softirq context */
     void foo_erase(struct foo *foo, unsigned long index)
     {
-        xa_lock(&foo->array);
+        xa_enter(&foo->array);
         __xa_erase(&foo->array, index);
         foo->count--;
-        xa_unlock(&foo->array);
+        xa_leave(&foo->array);
     }
 
 If you are going to modify the XArray from interrupt or softirq context,
@@ -280,12 +307,12 @@ you need to initialise the array using xa_init_flags(), passing
 ``XA_FLAGS_LOCK_IRQ`` or ``XA_FLAGS_LOCK_BH``.
 
 The above example also shows a common pattern of wanting to extend the
-coverage of the xa_lock on the store side to protect some statistics
-associated with the array.
+coverage of the internal spinlock on the store side to protect some
+statistics associated with the array.
 
 Sharing the XArray with interrupt context is also possible, either
-using xa_lock_irqsave() in both the interrupt handler and process
-context, or xa_lock_irq() in process context and xa_lock()
+using xa_enter_irqsave() in both the interrupt handler and process
+context, or xa_enter_irq() in process context and xa_enter()
 in the interrupt handler.  Some of the more common patterns have helper
 functions such as xa_store_bh(), xa_store_irq(),
 xa_erase_bh(), xa_erase_irq(), xa_cmpxchg_bh()
@@ -293,8 +320,8 @@ and xa_cmpxchg_irq().
 
 Sometimes you need to protect access to the XArray with a mutex because
 that lock sits above another mutex in the locking hierarchy.  That does
-not entitle you to use functions like __xa_erase() without taking
-the xa_lock; the xa_lock is used for lockdep validation and will be used
+not entitle you to use functions like __xa_erase() without calling
+xa_enter; the XArray lock is used for lockdep validation and will be used
 for other purposes in the future.
 
 The __xa_set_mark() and __xa_clear_mark() functions are also
@@ -308,8 +335,8 @@ Advanced API
 The advanced API offers more flexibility and better performance at the
 cost of an interface which can be harder to use and has fewer safeguards.
 No locking is done for you by the advanced API, and you are required
-to use the xa_lock while modifying the array.  You can choose whether
-to use the xa_lock or the RCU lock while doing read-only operations on
+to use xa_enter while modifying the array.  You can choose whether
+to use xa_enter or the RCU lock while doing read-only operations on
 the array.  You can mix advanced and normal operations on the same array;
 indeed the normal API is implemented in terms of the advanced API.  The
 advanced API is only available to modules with a GPL-compatible license.
@@ -320,8 +347,8 @@ This macro initialises the xa_state ready to start walking around the
 XArray.  It is used as a cursor to maintain the position in the XArray
 and let you compose various operations together without having to restart
 from the top every time.  The contents of the xa_state are protected by
-the rcu_read_lock() or the xas_lock().  If you need to drop whichever of
-those locks is protecting your state and tree, you must call xas_pause()
+the rcu_read_lock() or the xas_enter() lock.  If you need to drop whichever
+of those locks is protecting your state and tree, you must call xas_pause()
 so that future calls do not rely on the parts of the state which were
 left unprotected.
 
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0b618ec04115..dde10de4e6bf 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -532,29 +532,48 @@ static inline bool xa_marked(const struct xarray *xa, xa_mark_t mark)
 	for (index = 0, entry = xa_find(xa, &index, ULONG_MAX, filter); \
 	     entry; entry = xa_find_after(xa, &index, ULONG_MAX, filter))
 
-#define xa_trylock(xa)		spin_trylock(&(xa)->xa_lock)
-#define xa_lock(xa)		spin_lock(&(xa)->xa_lock)
-#define xa_unlock(xa)		spin_unlock(&(xa)->xa_lock)
-#define xa_lock_bh(xa)		spin_lock_bh(&(xa)->xa_lock)
-#define xa_unlock_bh(xa)	spin_unlock_bh(&(xa)->xa_lock)
-#define xa_lock_irq(xa)		spin_lock_irq(&(xa)->xa_lock)
-#define xa_unlock_irq(xa)	spin_unlock_irq(&(xa)->xa_lock)
-#define xa_lock_irqsave(xa, flags) \
+#define xa_tryenter(xa)		spin_trylock(&(xa)->xa_lock)
+#define xa_enter(xa)		spin_lock(&(xa)->xa_lock)
+#define xa_leave(xa)		spin_unlock(&(xa)->xa_lock)
+#define xa_enter_bh(xa)		spin_lock_bh(&(xa)->xa_lock)
+#define xa_leave_bh(xa)		spin_unlock_bh(&(xa)->xa_lock)
+#define xa_enter_irq(xa)	spin_lock_irq(&(xa)->xa_lock)
+#define xa_leave_irq(xa)	spin_unlock_irq(&(xa)->xa_lock)
+#define xa_enter_irqsave(xa, flags) \
 				spin_lock_irqsave(&(xa)->xa_lock, flags)
-#define xa_unlock_irqrestore(xa, flags) \
+#define xa_leave_irqrestore(xa, flags) \
 				spin_unlock_irqrestore(&(xa)->xa_lock, flags)
-#define xa_lock_nested(xa, subclass) \
+#define xa_enter_nested(xa, subclass) \
 				spin_lock_nested(&(xa)->xa_lock, subclass)
-#define xa_lock_bh_nested(xa, subclass) \
+#define xa_enter_bh_nested(xa, subclass) \
 				spin_lock_bh_nested(&(xa)->xa_lock, subclass)
-#define xa_lock_irq_nested(xa, subclass) \
+#define xa_enter_irq_nested(xa, subclass) \
 				spin_lock_irq_nested(&(xa)->xa_lock, subclass)
-#define xa_lock_irqsave_nested(xa, flags, subclass) \
+#define xa_enter_irqsave_nested(xa, flags, subclass) \
 		spin_lock_irqsave_nested(&(xa)->xa_lock, flags, subclass)
 
+/*
+ * These names are deprecated. Please use xa_enter instead of xa_lock, and
+ * xa_leave instead of xa_unlock.
+ */
+#define xa_trylock(xa)			xa_tryenter(xa)
+#define xa_lock(xa)			xa_enter(xa)
+#define xa_unlock(xa)			xa_leave(xa)
+#define xa_lock_bh(xa)			xa_enter_bh(xa)
+#define xa_unlock_bh(xa)		xa_leave_bh(xa)
+#define xa_lock_irq(xa)			xa_enter_irq(xa)
+#define xa_unlock_irq(xa)		xa_leave_irq(xa)
+#define xa_lock_irqsave(xa, flags)	xa_enter_irqsave(xa, flags)
+#define xa_unlock_irqrestore(xa, flags) xa_leave_irqsave(xa, flags)
+#define xa_lock_nested(xa, subclass)	xa_enter_nested(xa, subclass)
+#define xa_lock_bh_nested(xa, subclass) xa_enter_bh_nested(xa, subclass)
+#define xa_lock_irq_nested(xa, subclass) xa_enter_irq_nested(xa, subclass)
+#define xa_lock_irqsave_nested(xa, flags, subclass) \
+		xa_enter_irqsave_nested(xa, flags, subclass)
+
 /*
- * Versions of the normal API which require the caller to hold the
- * xa_lock.  If the GFP flags allow it, they will drop the lock to
+ * Versions of the normal API which require the caller to use
+ * xa_enter.  If the GFP flags allow it, they will drop the lock to
  * allocate memory, then reacquire it afterwards.  These functions
  * may also re-enable interrupts if the XArray flags indicate the
  * locking should be interrupt safe.
@@ -592,9 +611,9 @@ static inline void *xa_store_bh(struct xarray *xa, unsigned long index,
 	void *curr;
 
 	might_alloc(gfp);
-	xa_lock_bh(xa);
+	xa_enter_bh(xa);
 	curr = __xa_store(xa, index, entry, gfp);
-	xa_unlock_bh(xa);
+	xa_leave_bh(xa);
 
 	return curr;
 }
@@ -619,9 +638,9 @@ static inline void *xa_store_irq(struct xarray *xa, unsigned long index,
 	void *curr;
 
 	might_alloc(gfp);
-	xa_lock_irq(xa);
+	xa_enter_irq(xa);
 	curr = __xa_store(xa, index, entry, gfp);
-	xa_unlock_irq(xa);
+	xa_leave_irq(xa);
 
 	return curr;
 }
@@ -643,9 +662,9 @@ static inline void *xa_erase_bh(struct xarray *xa, unsigned long index)
 {
 	void *entry;
 
-	xa_lock_bh(xa);
+	xa_enter_bh(xa);
 	entry = __xa_erase(xa, index);
-	xa_unlock_bh(xa);
+	xa_leave_bh(xa);
 
 	return entry;
 }
@@ -667,9 +686,9 @@ static inline void *xa_erase_irq(struct xarray *xa, unsigned long index)
 {
 	void *entry;
 
-	xa_lock_irq(xa);
+	xa_enter_irq(xa);
 	entry = __xa_erase(xa, index);
-	xa_unlock_irq(xa);
+	xa_leave_irq(xa);
 
 	return entry;
 }
@@ -695,9 +714,9 @@ static inline void *xa_cmpxchg(struct xarray *xa, unsigned long index,
 	void *curr;
 
 	might_alloc(gfp);
-	xa_lock(xa);
+	xa_enter(xa);
 	curr = __xa_cmpxchg(xa, index, old, entry, gfp);
-	xa_unlock(xa);
+	xa_leave(xa);
 
 	return curr;
 }
@@ -723,9 +742,9 @@ static inline void *xa_cmpxchg_bh(struct xarray *xa, unsigned long index,
 	void *curr;
 
 	might_alloc(gfp);
-	xa_lock_bh(xa);
+	xa_enter_bh(xa);
 	curr = __xa_cmpxchg(xa, index, old, entry, gfp);
-	xa_unlock_bh(xa);
+	xa_leave_bh(xa);
 
 	return curr;
 }
@@ -751,9 +770,9 @@ static inline void *xa_cmpxchg_irq(struct xarray *xa, unsigned long index,
 	void *curr;
 
 	might_alloc(gfp);
-	xa_lock_irq(xa);
+	xa_enter_irq(xa);
 	curr = __xa_cmpxchg(xa, index, old, entry, gfp);
-	xa_unlock_irq(xa);
+	xa_leave_irq(xa);
 
 	return curr;
 }
@@ -781,9 +800,9 @@ static inline int __must_check xa_insert(struct xarray *xa,
 	int err;
 
 	might_alloc(gfp);
-	xa_lock(xa);
+	xa_enter(xa);
 	err = __xa_insert(xa, index, entry, gfp);
-	xa_unlock(xa);
+	xa_leave(xa);
 
 	return err;
 }
@@ -811,9 +830,9 @@ static inline int __must_check xa_insert_bh(struct xarray *xa,
 	int err;
 
 	might_alloc(gfp);
-	xa_lock_bh(xa);
+	xa_enter_bh(xa);
 	err = __xa_insert(xa, index, entry, gfp);
-	xa_unlock_bh(xa);
+	xa_leave_bh(xa);
 
 	return err;
 }
@@ -841,9 +860,9 @@ static inline int __must_check xa_insert_irq(struct xarray *xa,
 	int err;
 
 	might_alloc(gfp);
-	xa_lock_irq(xa);
+	xa_enter_irq(xa);
 	err = __xa_insert(xa, index, entry, gfp);
-	xa_unlock_irq(xa);
+	xa_leave_irq(xa);
 
 	return err;
 }
@@ -874,9 +893,9 @@ static inline __must_check int xa_alloc(struct xarray *xa, u32 *id,
 	int err;
 
 	might_alloc(gfp);
-	xa_lock(xa);
+	xa_enter(xa);
 	err = __xa_alloc(xa, id, entry, limit, gfp);
-	xa_unlock(xa);
+	xa_leave(xa);
 
 	return err;
 }
@@ -907,9 +926,9 @@ static inline int __must_check xa_alloc_bh(struct xarray *xa, u32 *id,
 	int err;
 
 	might_alloc(gfp);
-	xa_lock_bh(xa);
+	xa_enter_bh(xa);
 	err = __xa_alloc(xa, id, entry, limit, gfp);
-	xa_unlock_bh(xa);
+	xa_leave_bh(xa);
 
 	return err;
 }
@@ -940,9 +959,9 @@ static inline int __must_check xa_alloc_irq(struct xarray *xa, u32 *id,
 	int err;
 
 	might_alloc(gfp);
-	xa_lock_irq(xa);
+	xa_enter_irq(xa);
 	err = __xa_alloc(xa, id, entry, limit, gfp);
-	xa_unlock_irq(xa);
+	xa_leave_irq(xa);
 
 	return err;
 }
@@ -977,9 +996,9 @@ static inline int xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
 	int err;
 
 	might_alloc(gfp);
-	xa_lock(xa);
+	xa_enter(xa);
 	err = __xa_alloc_cyclic(xa, id, entry, limit, next, gfp);
-	xa_unlock(xa);
+	xa_leave(xa);
 
 	return err;
 }
@@ -1014,9 +1033,9 @@ static inline int xa_alloc_cyclic_bh(struct xarray *xa, u32 *id, void *entry,
 	int err;
 
 	might_alloc(gfp);
-	xa_lock_bh(xa);
+	xa_enter_bh(xa);
 	err = __xa_alloc_cyclic(xa, id, entry, limit, next, gfp);
-	xa_unlock_bh(xa);
+	xa_leave_bh(xa);
 
 	return err;
 }
@@ -1051,9 +1070,9 @@ static inline int xa_alloc_cyclic_irq(struct xarray *xa, u32 *id, void *entry,
 	int err;
 
 	might_alloc(gfp);
-	xa_lock_irq(xa);
+	xa_enter_irq(xa);
 	err = __xa_alloc_cyclic(xa, id, entry, limit, next, gfp);
-	xa_unlock_irq(xa);
+	xa_leave_irq(xa);
 
 	return err;
 }
@@ -1408,17 +1427,30 @@ struct xa_state {
 			(1U << (order % XA_CHUNK_SHIFT)) - 1)
 
 #define xas_marked(xas, mark)	xa_marked((xas)->xa, (mark))
-#define xas_trylock(xas)	xa_trylock((xas)->xa)
-#define xas_lock(xas)		xa_lock((xas)->xa)
-#define xas_unlock(xas)		xa_unlock((xas)->xa)
-#define xas_lock_bh(xas)	xa_lock_bh((xas)->xa)
-#define xas_unlock_bh(xas)	xa_unlock_bh((xas)->xa)
-#define xas_lock_irq(xas)	xa_lock_irq((xas)->xa)
-#define xas_unlock_irq(xas)	xa_unlock_irq((xas)->xa)
-#define xas_lock_irqsave(xas, flags) \
-				xa_lock_irqsave((xas)->xa, flags)
-#define xas_unlock_irqrestore(xas, flags) \
-				xa_unlock_irqrestore((xas)->xa, flags)
+#define xas_tryenter(xas)	xa_tryenter((xas)->xa)
+#define xas_enter(xas)		xa_enter((xas)->xa)
+#define xas_leave(xas)		xa_leave((xas)->xa)
+#define xas_enter_bh(xas)	xa_enter_bh((xas)->xa)
+#define xas_leave_bh(xas)	xa_leave_bh((xas)->xa)
+#define xas_enter_irq(xas)	xa_enter_irq((xas)->xa)
+#define xas_leave_irq(xas)	xa_leave_irq((xas)->xa)
+#define xas_enter_irqsave(xas, flags) xa_enter_irqsave((xas)->xa, flags)
+#define xas_leave_irqrestore(xas, flags) xa_leave_irqrestore((xas)->xa, flags)
+
+
+/*
+ * These names are deprecated. Please use xas_enter instead of xas_lock, and
+ * xas_leave instead of xas_unlock.
+ */
+#define xas_trylock(xas)			xas_tryenter(xas)
+#define xas_lock(xas)				xas_enter(xas)
+#define xas_unlock(xas)				xas_leave(xas)
+#define xas_lock_bh(xas)			xas_enter_bh(xas)
+#define xas_unlock_bh(xas)			xas_leave_bh(xas)
+#define xas_lock_irq(xas)			xas_enter_irq(xas)
+#define xas_unlock_irq(xas)			xas_leave_irq(xas)
+#define xas_lock_irqsave(xas, flags)		xas_enter_irqsave(xas, flags)
+#define xas_unlock_irqrestore(xas, flags)	xas_leave_irqsave(xas, flags)
 
 /**
  * xas_error() - Return an errno stored in the xa_state.

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240921-xa_enter_leave-b11552c3caa2

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


