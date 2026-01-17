Return-Path: <linux-fsdevel+bounces-74290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E0D38F5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 16:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E61483032709
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E8A233D88;
	Sat, 17 Jan 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0zaPWxa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D623645D
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768663534; cv=none; b=EcX5bbj0iDKEk2iPRW0sOPcidC38jBwhoADfq7XKUXf8M/J17XplXK73C0YmGV6zbRCqJzP9qJa4/sidufw7K+ua9bOAQum1FeTF5kOU4a0UzVkbHQMDhniyva3PUF2doAukmwQSygcJMX6uiE6uzjBIMhcX4QONtwdLnrwrND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768663534; c=relaxed/simple;
	bh=9ipAyLskKwi1ksx9hkkM2iyTNIPdZ0fYz79QhCj4ffA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ahaULdCtHx0gi3PYOdFV9K6IK1HLQWD0Y1X6KJetrCkUL88baUn1ZpMG0MVyVbEABtRdP7bjY0GPk+BsfKWJsCcYakZzIdaBezKJyMWeM7VmGbvbDXueri+AdaznlJPxsAoVp0FeG1iVywqQUYxWQP8fBRCkUUSokG3s/Hp3WSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0zaPWxa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso32092095e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 07:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768663530; x=1769268330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KqqLu+rK83FYvuu43UqacZgGarS1nyPWiHaErFCcx+s=;
        b=w0zaPWxac3n44oJeA2yYz1htROIZE7YRtAhUA3iMpqpD3spou6UQkDfZ9D1Z60Xunb
         t701e3bTfAsypHwmmhCIiZ50wTlGC2ATfm5ZP2f1snD0NsexfT0Zt2/9EDYnEuHm+D8Q
         0VPSoEcBalbdCSCgFojMfBWvYIhWewyjiXvzT/nDQDQx2mz1PkNgSqPdN8A0Vzd/oir6
         ROBx/Npis/R4NvmqSwD88+qMe67DOcXz9He8mlsYQy3g45scwZ1DP2MeUNeefpc0LLID
         34J3UsjwJ3fO0oPwhxAiwpMae3t++3rE5PnFYGxLYTmo/7n6BRq8DFcu5pp6wDu34JZn
         90sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768663530; x=1769268330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqqLu+rK83FYvuu43UqacZgGarS1nyPWiHaErFCcx+s=;
        b=STxhxq0uuU2x99zFBBz/Oue9FndTle5p7063HiyU3U9O4WF+Xx+Ai3eXIoBJXJqlY8
         QXISv7e8hXUK9TvWNMMbr6FOUfV69NnYjJnGN9HEvjg4LgBfLPyVOR56hXkIy1+Uz3xR
         FI4C3g2pzk3FKr/iMzsGf+ybfrgQVTA+4fv1pgYlHN24Gx0pTuFtp8k4BMlTavpdC4+d
         Wg5XRh4KfeylBcSZDAozQmBUQKz/wCOaB4Rg6mCecNg92SwYHjFLe3gVWYZZy50MwFwx
         senl3EBGRotH6vX6aIInzimJ5v6EayzRXbVuz5MUYa9BLpWwy0qxmVQAlwp0fHFWS5II
         zGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9kthIxVTsFG1GVgqLhszyqYDjt3EFwLMpNULqZMh6qtAruVCW97IbaJkx+dDfUl305aQFh6/lmlgcS/So@vger.kernel.org
X-Gm-Message-State: AOJu0YxlldlP1BnQiMzvT2YVl0yoZBaANIvsO5fFgzrkiQjppHh2MAny
	spzeTXP3eifZU5PIolfqP7K2yBgNSu4a8HmFOShAIqD5qNMpSiRk/TUkAfUOExP1xoGqd5qdJAY
	KOGz4OkH1K40GCYQLXg==
X-Received: from wmhm8.prod.google.com ([2002:a05:600c:40c8:b0:477:7893:c737])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e0f:b0:47e:e779:36e with SMTP id 5b1f17b1804b1-4801eb0375amr70230175e9.19.1768663529817;
 Sat, 17 Jan 2026 07:25:29 -0800 (PST)
Date: Sat, 17 Jan 2026 15:25:20 +0000
In-Reply-To: <20260117-upgrade-poll-v1-0-179437b7bd49@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117-upgrade-poll-v1-0-179437b7bd49@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3796; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=9ipAyLskKwi1ksx9hkkM2iyTNIPdZ0fYz79QhCj4ffA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpa6nlFxHRFC9Er4fNiBw9GYpYeu3Uu4ieGDJeI
 wo6v3Mb5H6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaWup5QAKCRAEWL7uWMY5
 RtG8EACdXCwXlePrBnRXKgNEHXkdYMvJULH49b5iki2wcp8iujIwa+FEoFXm1Y69eN5UCCZtcQH
 zylpEINsHKVe4/to8zHNwCmm5tLMwDeEWjNTv2t2g9W5UXD4Zw/F9RrerMh4va+TshAnCJGLJXu
 04229CYQkUTlNmMwREG+u9/+6hcT1fMQgYSijDpVy1gdhpBb1PPyCgcx7AmiYkX+V/4JihValTI
 hU8iO7IyLpKIlH6kuT2gRS9bCG4At0CSusPaMiH45agzSNWx+3HWRp9PtxcbjsQXOxXQ7Z7DsWf
 CUGEAxYfVXI6OTKm3Nz9IzdyZtkrxqjT+KyHKNCbH1VAKXqrp9kaJAYbmgMSkkEkOZGAYBiVCTu
 +K8UtmVC9olOfl/EDZNYg9PLy13SnSorCw6hO5i610hJVHp6kllzrwdbjfV25/P+hjP3K8oNRAw
 rGMIGCeT1h1wmNC5ddkhoe6q+jH+CVhkaBQDuI6R6XSg6VgtTkx+Psi8L78z5mR7h8iM5j3EY4Z
 jrhvuVEHQJKj1FaVH5+oMhINwBUn092wKAxAk4S6RPiL1yH+saaVfT05jl72QSYKxV5AfMNVvwD
 exsQTHgSAT1OQyHjhwsRtP+bE/AJHnT4On9+oN0IeJdPXLy4I4TuuYgCegpoj/IEYnvGYMHEQyb 0ULwk+2ADGWOyqw==
X-Mailer: b4 0.14.2
Message-ID: <20260117-upgrade-poll-v1-2-179437b7bd49@google.com>
Subject: [PATCH RFC 2/2] rust_binder: use UpgradePollCondVar
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Most processes do not use Rust Binder with epoll, so avoid paying the
synchronize_rcu() cost in drop for those that don't need it. For those
that do, we also manage to replace synchronize_rcu() with kfree_rcu(),
though we introduce an extra allocation.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs |  2 +-
 drivers/android/binder/thread.rs  | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

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
index 82264db06507d4641b60cbed96af482a9d36e7b2..8f09cf1599ae7edcf2ee60b2cb1b08cc2d0afd3f 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -16,7 +16,7 @@
     seq_file::SeqFile,
     seq_print,
     sync::atomic::{ordering::Relaxed, Atomic},
-    sync::poll::{PollCondVar, PollTable},
+    sync::poll::{PollTable, UpgradePollCondVar},
     sync::{Arc, SpinLock},
     task::Task,
     types::ARef,
@@ -412,7 +412,7 @@ pub(crate) struct Thread {
     #[pin]
     inner: SpinLock<InnerThread>,
     #[pin]
-    work_condvar: PollCondVar,
+    work_condvar: UpgradePollCondVar,
     /// Used to insert this thread into the process' `ready_threads` list.
     ///
     /// INVARIANT: May never be used for any other list than the `self.process.ready_threads`.
@@ -443,7 +443,7 @@ pub(crate) fn new(id: i32, process: Arc<Process>) -> Result<Arc<Self>> {
                 process,
                 task: ARef::from(&**kernel::current!()),
                 inner <- kernel::new_spinlock!(inner, "Thread::inner"),
-                work_condvar <- kernel::new_poll_condvar!("Thread::work_condvar"),
+                work_condvar <- kernel::new_upgrade_poll_condvar!("Thread::work_condvar"),
                 links <- ListLinks::new(),
                 links_track <- AtomicTracker::new(),
             }),
@@ -1484,10 +1484,15 @@ pub(crate) fn write_read(self: &Arc<Self>, data: UserSlice, wait: bool) -> Resul
         ret
     }
 
-    pub(crate) fn poll(&self, file: &File, table: PollTable<'_>) -> (bool, u32) {
-        table.register_wait(file, &self.work_condvar);
+    pub(crate) fn poll(&self, file: &File, table: PollTable<'_>) -> Result<(bool, u32)> {
+        let condvar = self.work_condvar.poll(
+            &self.inner,
+            c"Thread::work_condvar (upgraded)",
+            kernel::static_lock_class!(),
+        )?;
+        table.register_wait(file, condvar);
         let mut inner = self.inner.lock();
-        (inner.should_use_process_work_queue(), inner.poll())
+        Ok((inner.should_use_process_work_queue(), inner.poll()))
     }
 
     /// Make the call to `get_work` or `get_work_local` return immediately, if any.
@@ -1523,7 +1528,6 @@ pub(crate) fn notify_if_poll_ready(&self, sync: bool) {
     pub(crate) fn release(self: &Arc<Self>) {
         self.inner.lock().is_dead = true;
 
-        //self.work_condvar.clear();
         self.unwind_transaction_stack();
 
         // Cancel all pending work items.

-- 
2.52.0.457.g6b5491de43-goog


