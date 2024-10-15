Return-Path: <linux-fsdevel+bounces-31998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7AF99EE93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6026284BA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B9A1B2181;
	Tue, 15 Oct 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjOlTXn4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F551BF2B
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000941; cv=none; b=TQV1c9XjGfXcjXIUrZVatWuMdU2ycKsMFpIpv4xVz35QNKQfgaKO49yr1U5jTtd9L9UWjqXoTaAvmnGrXk/vDvk4kbvr7/dt897aoGLO5EoLUihWps/5v97wPXCi++49JSw8XmEIZeikMqOzB8+yOPDuyeGvnoDWitXV7pPzVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000941; c=relaxed/simple;
	bh=uiJM4rSUOQpRuJzKCUCsVPKJFZberrG38PKUqst0GRU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=REjX9K4n1zhZw8dP9byuFyZIQ2CMRYL++ob7UpGF7h4rdMtVQzcYt7NEFiAjdA9K0FhR+jHtMJ0Dk7Yge9GydxjW80PZ/tHfxv8El5D4kEqWyq+355vCkrfIsvoubSfoXPkPiayCWxHRfjnamXnSAqFFy8zNuS334b+L3x2DFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjOlTXn4; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4311a383111so26098575e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729000938; x=1729605738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D3UvK17eSPt8UOicM/0eqJEABn/661zuSOEvnahhcrQ=;
        b=UjOlTXn4z1SgFi4cJjdzEQaiyE/af8Z/vi/TmCqPe7uhR75iKGqJ1RKKGk+QnaqASB
         ZyX+9F4OMqXQ2la9OZZjvuey+mRUHLLMVhh8vnXPa98bQydF46/qXqglrAJ7MO9JOWn4
         7eNLSQpz5smqpohq7JOG+DutCLnNpL/Hnm/Z3XS6LbOocEXW/dxKkiwOh673YwX1uqBt
         6A8PGOdWhtxA4RYMuSFlgNTkbUU6myOdHEXnsU31tEo1q6noD9U9rr8qUd7pu3dtAeGv
         ECed8JB2ZyBz65E1JSlb/TkSPHEBC6LjtT0vykARNitVZ2e3F4u09qIz4o358FGpfRjU
         Bh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000938; x=1729605738;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3UvK17eSPt8UOicM/0eqJEABn/661zuSOEvnahhcrQ=;
        b=rj1QFIsfRNDX04z8LhQmTAzfaZOwdxdHjQsRzKnRPDKUWEWQs0sgutPo8eOBfoMhiC
         l7HHG0pkxU2Qr0OKF+xNt9OSei1ex3ygHr7UpLUHasFmfFM82XNY65kJI+saczZsk2DM
         xqcQ7+BXp76ZyunCpMl4+mwP5l8mvFat100uWHIRSRg/yNYF9b0ONJzPJGPumtazF87i
         OE4Q2k2gAgvmzjZxf9sV0YEdusUx1/7XcoDldKU753HpRPnBSh4vildm3mjW/2tLpY+k
         hC1aJ0X0E2vnE6J0MkPkVx6xmrVlnkxZyfaYfep0sbnfcr3OrYOCef/TzBWktd/xJ0Ri
         qDQg==
X-Forwarded-Encrypted: i=1; AJvYcCXGdT6Iivl+CPNpLDvSsehQU1CgEAjX/f607+w3C9gWl5GJSUWbu7FZVGhlN84DqA2sm+GgmH7N/ECjfIQo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00QZvZIrdx27afrkjwQJIFzOZ3Rkqytn44HMiBJ/FAo2HUj8E
	RKxk+PgNL5si8bHId0hiX5DcbY1wwX9N7Tdloez/jNA2DP8l7wJ/pHvlE/cfiaPCxKKPfsZr2uf
	b6oyerd4etfWaGA==
X-Google-Smtp-Source: AGHT+IGU78NPTvkFziD53eUU1HzliQBcjp57k9rG0VlMlSkUOEZYF0iVT9DAZ6/MiIGfP+K1uxt2QF8cbr3ayec=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:793:b0:431:4b20:c7f9 with SMTP
 id 5b1f17b1804b1-4314b20c90fmr21015e9.5.1729000937986; Tue, 15 Oct 2024
 07:02:17 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:02:12 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAON1DmcC/x3MQQqAIBBA0avErBtQMYKuEi3MxhoiC0eiiO6et
 HyL/x8QSkwCXfVAopOF91ig6wr84uJMyFMxGGWsVrrB7GRFcYHyjX6LWdC1PpAdjbetgtIdiQJ f/7Mf3vcDzqqUCmMAAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5281; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=uiJM4rSUOQpRuJzKCUCsVPKJFZberrG38PKUqst0GRU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDnXlT0P9OH45c6iZwippHyMTLUkxyS14qWHIW
 C90/syoimyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZw515QAKCRAEWL7uWMY5
 RjJeEAC4nJb3elnKdDzL5/RoMJ3lgi3cdw40bmjgthB/t2mjkEnDxrVXpD6avxj5DXUhIfeX90o
 4Mg05WTn5yXHvjwdTDn4oW7sMwU0Yy5xYrWJMDJWrAumWU7bYSl2NI+jx2/Gb8FMuxMBIyg6Ud/
 bjRSsMuqnkVvlx3xKNGSWo9ERmQ8Y+yZO3TYPx6GdoUGhVmegC0DoDjyuPwYaeu0xCGV3L2cM1S
 TC9WRefQQVs5QXCZWJgyIgOzDaj3y6SeAUVcN9K80awo6Gm5mXu7Klr3A1RO9Bo1TrG2/eHBlSK
 yt16d+qSL/UxAxvQvz3eDE+bpkUS2N3crC2hADzdgMg0n9Gz2I0f4rhAWtU+ykGvjjCEzCI+6pS
 3ajsT8fszK7F3eWZXBnVDhv1Hr91ADY84NXhCg3EtC270Eul7OebK86tTfyMI9vJi2cJAxXgV9Q
 F2nB6OtEKAojVaWuzwL6X5OhNxMfPCCBSJbbl3MihTgZx0gBhd4GNzeqBWlOXed5F5vcxfxv4Bb
 ck7nDrTqhInxq4rDw5Ptbt3Vlr4mTjWTiygcBQB8W5JYc5Y5qIrR5qA6VSqlvW7pQQgiwIKGRTw
 +g6dmypdfgWNC1tegdYUTyYjaN8SOXnBo9kU6gptOaEcVxJRsoMySbxm9Br22x4BIGcq2pN6/kI 2FrW5cbBWCYgBlg==
X-Mailer: b4 0.13.0
Message-ID: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>
Subject: [PATCH] rust: task: adjust safety comments in Task methods
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The `Task` struct has several safety comments that aren't so great. For
example, the reason that it's okay to read the `pid` is that the field
is immutable, so there is no data race, which is not what the safety
comment says.

Thus, improve the safety comments. Also add an `as_ptr` helper. This
makes it easier to read the various accessors on Task, as `self.0` may
be confusing syntax for new Rust users.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This is based on top of vfs.rust.file as the file series adds some new
task methods. Christian, can you take this through that tree?
---
 rust/kernel/task.rs | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 1a36a9f19368..080599075875 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -145,11 +145,17 @@ fn deref(&self) -> &Self::Target {
         }
     }
 
+    /// Returns a raw pointer to the task.
+    #[inline]
+    pub fn as_ptr(&self) -> *mut bindings::task_struct {
+        self.0.get()
+    }
+
     /// Returns the group leader of the given task.
     pub fn group_leader(&self) -> &Task {
-        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
-        // have a valid `group_leader`.
-        let ptr = unsafe { *ptr::addr_of!((*self.0.get()).group_leader) };
+        // SAFETY: The group leader of a task never changes after initialization, so reading this
+        // field is not a data race.
+        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
 
         // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
         // and given that a task has a reference to its group leader, we know it must be valid for
@@ -159,42 +165,41 @@ pub fn group_leader(&self) -> &Task {
 
     /// Returns the PID of the given task.
     pub fn pid(&self) -> Pid {
-        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
-        // have a valid pid.
-        unsafe { *ptr::addr_of!((*self.0.get()).pid) }
+        // SAFETY: The pid of a task never changes after initialization, so reading this field is
+        // not a data race.
+        unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
     }
 
     /// Returns the UID of the given task.
     pub fn uid(&self) -> Kuid {
-        // SAFETY: By the type invariant, we know that `self.0` is valid.
-        Kuid::from_raw(unsafe { bindings::task_uid(self.0.get()) })
+        // SAFETY: It's always safe to call `task_uid` on a valid task.
+        Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
     }
 
     /// Returns the effective UID of the given task.
     pub fn euid(&self) -> Kuid {
-        // SAFETY: By the type invariant, we know that `self.0` is valid.
-        Kuid::from_raw(unsafe { bindings::task_euid(self.0.get()) })
+        // SAFETY: It's always safe to call `task_euid` on a valid task.
+        Kuid::from_raw(unsafe { bindings::task_euid(self.as_ptr()) })
     }
 
     /// Determines whether the given task has pending signals.
     pub fn signal_pending(&self) -> bool {
-        // SAFETY: By the type invariant, we know that `self.0` is valid.
-        unsafe { bindings::signal_pending(self.0.get()) != 0 }
+        // SAFETY: It's always safe to call `signal_pending` on a valid task.
+        unsafe { bindings::signal_pending(self.as_ptr()) != 0 }
     }
 
     /// Returns the given task's pid in the current pid namespace.
     pub fn pid_in_current_ns(&self) -> Pid {
-        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
-        // pointer as the namespace is correct for using the current namespace.
-        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
+        // SAFETY: It's valid to pass a null pointer as the namespace (defaults to current
+        // namespace). The task pointer is also valid.
+        unsafe { bindings::task_tgid_nr_ns(self.as_ptr(), ptr::null_mut()) }
     }
 
     /// Wakes up the task.
     pub fn wake_up(&self) {
-        // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
-        // And `wake_up_process` is safe to be called for any valid task, even if the task is
+        // SAFETY: It's always safe to call `signal_pending` on a valid task, even if the task
         // running.
-        unsafe { bindings::wake_up_process(self.0.get()) };
+        unsafe { bindings::wake_up_process(self.as_ptr()) };
     }
 }
 
@@ -202,7 +207,7 @@ pub fn wake_up(&self) {
 unsafe impl crate::types::AlwaysRefCounted for Task {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
-        unsafe { bindings::get_task_struct(self.0.get()) };
+        unsafe { bindings::get_task_struct(self.as_ptr()) };
     }
 
     unsafe fn dec_ref(obj: ptr::NonNull<Self>) {

---
base-commit: 22018a5a54a3d353bf0fee7364b2b8018ed4c5a6
change-id: 20241015-task-safety-cmnts-a7cfe4b2c470

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


