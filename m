Return-Path: <linux-fsdevel+bounces-77137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AEHFn4Lj2n4HQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:31:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B61EC135BCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99B9A30624B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312235CB84;
	Fri, 13 Feb 2026 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukP/IVYD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244B35A94C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770982196; cv=none; b=QJkm9xY5CusZl714twmZcw74jgncBOviEe/v4evY5dhpeSoXKyuR98TZ2TLb/tJ1dMVi2HIogebbLzFv3Q01ksLm54vPmO1ZByFSncOLE4axPcALPoWMeyuWxDaDNOVrECeVqHaVBtLXzVNxw1jmB4+azxyriUgjLIs5Zuwen8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770982196; c=relaxed/simple;
	bh=yCEi51iwihIQ6/KNEUjlLXlerIrErSDL4RHDSmEJwqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pCVULpTiiCFI46eZRk8inWT0tj6ckSdSjMtZjdCO+7RbHA8mJoAxykPoSeoA4bv+Y8q3jz4Vj0ph/lH59LdSTgyQ0RL4J2NBgD2cHgZPbrbzw4T6xPL01TgkvPXgouuvlmb2ZQAsmYfMz/jFZx97qEpJxvbk96Yq3Pcd/QFjm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukP/IVYD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso7863715e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 03:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770982193; x=1771586993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GpA4zks8oXTqCWt4/gqpScCP5DONS2AqVxE0dwGJ/8s=;
        b=ukP/IVYDjEITiquF5XW2u5uOtQ/JHfjK4EGisJDRFPgAer9GX0mnmEBlDMJr99NQaM
         co1jyHMtspo+ZrPSX3wVpwMM0AZMngVmTLyVpS14T2yCQetLwWYwRt1HoNDRODshZ5Tg
         ww48pUXjESPCroaZw2BQuYEvCEI1VfUnQn8j3HE4oOkfzgZ44/TX/16FR9qG6Nud8SXo
         eAEH36UEmhP4KlEzEK7n1BTsjQG+l/kVMcI3mLqu4IyXucVCmziu0YZPgHQM+mqyLElj
         1lUnDrlFavfSRtyDfk3vxWI0tWvx2rIPbkfJvIQ82A5JtYGw3sFGmCzFNy1xioexj+L8
         2MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770982193; x=1771586993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpA4zks8oXTqCWt4/gqpScCP5DONS2AqVxE0dwGJ/8s=;
        b=DetO2CdE5QErdwEFeMHpPEEAY9xEOVj4fl4XdgTkbF+M9AXwe8/K9oc4hHKQjbEEha
         XKhAY/qPXnAlSiJ1b1hQ8lj1E3Y1ndbl6+VBxrejHTy/TJoQFpkDC0t+TVIrdgNCt0eG
         2F0wrXo7SSu4y4htONOcLLjjS1vqT9Tfdqz2rAqP3QoOR2GST10l5xIndVsE5FoIaOmN
         fXC9OkhfC58fJTh8iFDCYCBvcVyHEv/47+FfAj3KrxqjAOZHXYZllTdRTJvGaJOWpCHU
         17c5y8dcVlTS7iYbbh5mLqlP6sDiYxwrYF2bqBesoPrWtW1LJKcXmWQqWGe97wms7PK/
         YAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGcCKqsg1gZxioRW8P1svf8CM4qIFk4HrF78eG4ySKSpqG4Km6N07uM2pQWeL9Xj0Ca8p2e2HpsCekCX2R@vger.kernel.org
X-Gm-Message-State: AOJu0YwZTml1+BWcPdjSw3+fpkF2BzkNauSNcY4ru4rOuytPClltiUIO
	bGcMZUKlyHk59I7ae9BfYNV/+XZe8JGaqgYOo2hWp51EcjDSBjqIJlArYTep7WaOQFjN81MyO6J
	F2yCNkNGN6Hb98Fi1VA==
X-Received: from wmoo19.prod.google.com ([2002:a05:600d:113:b0:483:6a60:3501])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1381:b0:483:54cc:cd89 with SMTP id 5b1f17b1804b1-48373a1bbc4mr23639015e9.9.1770982193471;
 Fri, 13 Feb 2026 03:29:53 -0800 (PST)
Date: Fri, 13 Feb 2026 11:29:42 +0000
In-Reply-To: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4828; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=yCEi51iwihIQ6/KNEUjlLXlerIrErSDL4RHDSmEJwqY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpjwstSJRuzC5n7YzFvHhJ9w7Yghk3PUZ46YUSO
 jBiftZbxtqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaY8LLQAKCRAEWL7uWMY5
 Ri0MD/kBPdV56NkzCHG6F680bzzWalPBUKLu5sCgMqs54jul9o2awp86Fd+feimnaM1BB4XmJhD
 AAi0eexNVneqfUKDXDt/jp9nUB33eVaVefI7amxfI9MmsNjGLOd0qCKBkXnBpYYviOzazrlWwX7
 YpavT1iwhsiFXdkHDbE425VCAk9vJVN42nZdAXgmZ75+c2KRaLXD5lPdszMvPPMOYj90e0YFYRB
 3TdXEEJUvl2b1V872XGL/H+ETf+ISXWDgsUFNwa1+zcFCG2uQNw6PsiN2E/r/sQFY7XArtT1bZh
 8201kq5ltjaju/qwxebGdXA9SKsWfiLhPZCVrhydKAvxZ3ydPke3EqQGdOUGVn7AvddloGfzQQz
 gc6my5wiyNV2Nrq6rSAl/czULWbzpXgXg14jcwF0xDlFC1xtd5gv5K8iLY+bLbFabofMa+Q7jqa
 GskdLLyVphPt3lUXSRU2GUDE4P55Ztm9jbgx0u1MxKmYNpihI1ExSYDeJKBpwSRBk70gxWfbO33
 f23Idk3w+o9Tfi8TCTuBxD0RERl9ZRiWpabNMZDys6pdxHYYC9GqQJFERRaJWoT6PokEht4KkdV
 tH+oiMW1/Zs6JtQiobUVBHvtIv61hBJk45ewd0iVodLY7UompJRt3p1kko7/YpkvznVHVrhG3E5 86r/2UFDjo06v7g==
X-Mailer: b4 0.14.2
Message-ID: <20260213-upgrade-poll-v2-2-984a0fb184fb@google.com>
Subject: [PATCH v2 2/2] rust_binder: use UpgradePollCondVar
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77137-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B61EC135BCC
X-Rspamd-Action: no action

Most processes do not use Rust Binder with epoll, so avoid paying the
synchronize_rcu() cost in drop for those that don't need it. For those
that do, we also manage to replace synchronize_rcu() with kfree_rcu(),
though we introduce an extra allocation.

In case the last ref to an Arc<Thread> is dropped outside of
deferred_release(), this also ensures that synchronize_rcu() is not
called in destructor of Arc<Thread> in other places. Theoretically that
could lead to jank by making other syscalls slow, though I have not seen
it happen in practice.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs |  2 +-
 drivers/android/binder/thread.rs  | 25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index 132055b4790f0ec69a87635b498909df2bf475e2..9374f1a86766c09321b57e565b6317cc290ea32b 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1684,7 +1684,7 @@ pub(crate) fn poll(
         table: PollTable<'_>,
     ) -> Result<u32> {
         let thread = this.get_current_thread()?;
-        let (from_proc, mut mask) = thread.poll(file, table);
+        let (from_proc, mut mask) = thread.poll(file, table)?;
         if mask == 0 && from_proc && !this.inner.lock().work.is_empty() {
             mask |= bindings::POLLIN;
         }
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 82264db06507d4641b60cbed96af482a9d36e7b2..a07210405c64e19984f49777a9d2c7b218944755 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -16,8 +16,8 @@
     seq_file::SeqFile,
     seq_print,
     sync::atomic::{ordering::Relaxed, Atomic},
-    sync::poll::{PollCondVar, PollTable},
-    sync::{Arc, SpinLock},
+    sync::poll::{PollTable, UpgradePollCondVar},
+    sync::{Arc, LockClassKey, SpinLock},
     task::Task,
     types::ARef,
     uaccess::UserSlice,
@@ -35,7 +35,7 @@
     BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverCode, DeliverToRead,
 };
 
-use core::mem::size_of;
+use core::{mem::size_of, pin::Pin};
 
 /// Stores the layout of the scatter-gather entries. This is used during the `translate_objects`
 /// call and is discarded when it returns.
@@ -412,7 +412,7 @@ pub(crate) struct Thread {
     #[pin]
     inner: SpinLock<InnerThread>,
     #[pin]
-    work_condvar: PollCondVar,
+    work_condvar: UpgradePollCondVar,
     /// Used to insert this thread into the process' `ready_threads` list.
     ///
     /// INVARIANT: May never be used for any other list than the `self.process.ready_threads`.
@@ -433,6 +433,11 @@ impl ListItem<0> for Thread {
     }
 }
 
+const THREAD_CONDVAR_NAME: &CStr = c"Thread::work_condvar";
+fn thread_condvar_class() -> Pin<&'static LockClassKey> {
+    kernel::static_lock_class!()
+}
+
 impl Thread {
     pub(crate) fn new(id: i32, process: Arc<Process>) -> Result<Arc<Self>> {
         let inner = InnerThread::new()?;
@@ -443,7 +448,7 @@ pub(crate) fn new(id: i32, process: Arc<Process>) -> Result<Arc<Self>> {
                 process,
                 task: ARef::from(&**kernel::current!()),
                 inner <- kernel::new_spinlock!(inner, "Thread::inner"),
-                work_condvar <- kernel::new_poll_condvar!("Thread::work_condvar"),
+                work_condvar <- UpgradePollCondVar::new(THREAD_CONDVAR_NAME, thread_condvar_class()),
                 links <- ListLinks::new(),
                 links_track <- AtomicTracker::new(),
             }),
@@ -1484,10 +1489,13 @@ pub(crate) fn write_read(self: &Arc<Self>, data: UserSlice, wait: bool) -> Resul
         ret
     }
 
-    pub(crate) fn poll(&self, file: &File, table: PollTable<'_>) -> (bool, u32) {
-        table.register_wait(file, &self.work_condvar);
+    pub(crate) fn poll(&self, file: &File, table: PollTable<'_>) -> Result<(bool, u32)> {
+        let condvar =
+            self.work_condvar
+                .poll(&self.inner, THREAD_CONDVAR_NAME, thread_condvar_class())?;
+        table.register_wait(file, condvar);
         let mut inner = self.inner.lock();
-        (inner.should_use_process_work_queue(), inner.poll())
+        Ok((inner.should_use_process_work_queue(), inner.poll()))
     }
 
     /// Make the call to `get_work` or `get_work_local` return immediately, if any.
@@ -1523,7 +1531,6 @@ pub(crate) fn notify_if_poll_ready(&self, sync: bool) {
     pub(crate) fn release(self: &Arc<Self>) {
         self.inner.lock().is_dead = true;
 
-        //self.work_condvar.clear();
         self.unwind_transaction_stack();
 
         // Cancel all pending work items.

-- 
2.53.0.273.g2a3d683680-goog


