Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6959775B292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjGTP3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjGTP3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:29:04 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D324F270F
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:59 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51bef8bb689so2534487a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689866938; x=1690471738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/u9EQyW+X21UxdbxspElMqoKZgJyUHYdK5EQ3Z7BOw=;
        b=3Hwd44nZ28dd7XQpwbotYQrWBx55skJp3Gg5KtDbRpDdMOffpWdvgIzNW860/54HaT
         Azxf/5by8rXcrok2m41Mqp1TMzDWRinsNR8PQskZDazzTs+Gp7tZqhBOc1yUUgTuJmRr
         kksHZP3kh1tFtsq2GBDhXDOpYxYoVGwh08aplvBGp9TKQ48GqSDmZqAyZ2GTmAZhYpJ1
         o2H8FoOGoPqkY2ao9JEaJJHSfeUSbfw+8DSGPm6uorPl8pnz36deNwerOjK72eTjgqXq
         PVbSr14PujluBch8hecMx3je20sH5Q9iXokyshWyBaVVH59tY43OZqL9Vt46qTAXsIUY
         M1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866938; x=1690471738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/u9EQyW+X21UxdbxspElMqoKZgJyUHYdK5EQ3Z7BOw=;
        b=FmpfyrBYkqqpiih7uwX1o8IxnS7vn5jwQkYYF2An1TOaDaVka/Zpd1cOHZyUQIfGRx
         HXeFYK89/1oPzATyI+zqYDz2LbgJSGBCS8JfUf5vCAet6r5TtpKLgrm/ofdD97EC7OjO
         T6PbpyQylFLydKf1Nx8QaM5Nt/IARg0lUdSVImYb5F7cEgJIQA0lK5iHOFyxSfZrA9PA
         TlBADXdUofxRjXPlQrG01wTifIUR5jNYXl7ovDLNwoOBgtsb/fokG1oKEuN1DVBvZ2jL
         kZl61K14Vuw2d/rucwg7oOB7CzutgG0Zb/TT19lLMUfleWvK1Ai9l3bmgqGfGTY5bxJA
         FNHg==
X-Gm-Message-State: ABy/qLZBvbawBeEHm4uDNwPA2sPf84PbhkZMgL2BrbG/1P5uVDOodPDD
        wLr6WoojxxgXoJPwTHS17b2qTb4E8Za26c0=
X-Google-Smtp-Source: APBJJlHVWjVGueX9/R76s//0Z49bMtlWlMtdOLYEUW5lsDUqEawxcfhDALGNUuPtRnFpdXqSHdO1FkhKZsz5mhM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6402:e9c:b0:51e:3810:e3b1 with SMTP
 id h28-20020a0564020e9c00b0051e3810e3b1mr39802eda.1.1689866938115; Thu, 20
 Jul 2023 08:28:58 -0700 (PDT)
Date:   Thu, 20 Jul 2023 15:28:20 +0000
In-Reply-To: <20230720152820.3566078-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230720152820.3566078-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720152820.3566078-6-aliceryhl@google.com>
Subject: [RFC PATCH v1 5/5] rust: file: add `DeferredFdCloser`
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a new type called `DeferredFdCloser` that can be used to close
files by their fd in a way that is safe even if the file is currently
held using `fdget`.

This is done by grabbing an extra refcount to the file and dropping it
in a task work once we return to userspace.

See comments on `binder_do_fd_close` and commit `80cd795630d65` for
motivation.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This is an implementation of `binder_deferred_fd_close` in Rust.

I think the fact that binder needs to close fds in this way raises the
question of how we want the Rust APIs for closing files to look.
Apparently, fdget is not just used in easily reviewable regions, but
also around things like the ioctl syscall, meaning that all ioctls must
abide by the fdget safety requirements.

 rust/bindings/bindings_helper.h |  2 +
 rust/helpers.c                  |  7 +++
 rust/kernel/file.rs             | 80 ++++++++++++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 7281264cbaa1..9b1f4efdf7ac 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -11,7 +11,8 @@
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{marker::PhantomData, ptr};
+use alloc::boxed::Box;
+use core::{alloc::AllocError, marker::PhantomData, mem, ptr};
 
 mod poll_table;
 pub use self::poll_table::{PollCondVar, PollTable};
@@ -241,6 +242,83 @@ fn drop(&mut self) {
     }
 }
 
+/// Helper used for closing file descriptors in a way that is safe even if the file is currently
+/// held using `fdget`.
+///
+/// See comments on `binder_do_fd_close` and commit `80cd795630d65`.
+pub struct DeferredFdCloser {
+    inner: Box<DeferredFdCloserInner>,
+}
+
+/// SAFETY: This just holds an allocation with no real content, so there's no safety issue with
+/// moving it across threads.
+unsafe impl Send for DeferredFdCloser {}
+unsafe impl Sync for DeferredFdCloser {}
+
+#[repr(C)]
+struct DeferredFdCloserInner {
+    twork: mem::MaybeUninit<bindings::callback_head>,
+    file: *mut bindings::file,
+}
+
+impl DeferredFdCloser {
+    /// Create a new `DeferredFdCloser`.
+    pub fn new() -> Result<Self, AllocError> {
+        Ok(Self {
+            inner: Box::try_new(DeferredFdCloserInner {
+                twork: mem::MaybeUninit::uninit(),
+                file: core::ptr::null_mut(),
+            })?,
+        })
+    }
+
+    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
+    pub fn close_fd(mut self, fd: u32) {
+        let file = unsafe { bindings::close_fd_get_file(fd) };
+        if !file.is_null() {
+            self.inner.file = file;
+
+            // SAFETY: Since DeferredFdCloserInner is `#[repr(C)]`, casting the pointers gives a
+            // pointer to the `twork` field.
+            let inner = Box::into_raw(self.inner) as *mut bindings::callback_head;
+
+            // SAFETY: Getting a pointer to current is always safe.
+            let current = unsafe { bindings::get_current() };
+            // SAFETY: The `file` pointer points at a valid file.
+            unsafe { bindings::get_file(file) };
+            // SAFETY: Due to the above `get_file`, even if the current task holds an `fdget` to
+            // this file right now, the refcount will not drop to zero until after it is released
+            // with `fdput`. This is because when using `fdget`, you must always use `fdput` before
+            // returning to userspace, and our task work runs after any `fdget` users have returned
+            // to user space.
+            //
+            // Note: fl_owner_t is currently a void pointer.
+            unsafe { bindings::filp_close(file, current as bindings::fl_owner_t) };
+            // SAFETY: The `inner` pointer is compatible with the `do_close_fd` method.
+            //
+            // The call to `task_work_add` can't fail, because we are scheduling the task work to
+            // the current task.
+            unsafe {
+                bindings::init_task_work(inner, Some(Self::do_close_fd));
+                bindings::task_work_add(current, inner, bindings::task_work_notify_mode_TWA_RESUME);
+            }
+        } else {
+            // Free the allocation.
+            drop(self.inner);
+        }
+    }
+
+    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head) {
+        // SAFETY: In `close_fd` we use this method together with a pointer that originates from a
+        // `Box<DeferredFdCloserInner>`, and we have just been given ownership of that allocation.
+        let inner = unsafe { Box::from_raw(inner as *mut DeferredFdCloserInner) };
+        // SAFETY: This drops a refcount we acquired in `close_fd`.
+        unsafe { bindings::fput(inner.file) };
+        // Free the allocation.
+        drop(inner);
+    }
+}
+
 /// Represents the EBADF error code.
 ///
 /// Used for methods that can only fail with EBADF.
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7d83e1a7a362..6d0d044fa8cd 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,6 +8,7 @@
 
 #include <linux/cred.h>
 #include <linux/errname.h>
+#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/poll.h>
@@ -16,6 +17,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/task_work.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/helpers.c b/rust/helpers.c
index e13a7da430b1..d147ec5bc0a3 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -31,6 +31,7 @@
 #include <linux/sched/signal.h>
 #include <linux/security.h>
 #include <linux/spinlock.h>
+#include <linux/task_work.h>
 #include <linux/wait.h>
 
 __noreturn void rust_helper_BUG(void)
@@ -166,6 +167,12 @@ void rust_helper_security_cred_getsecid(const struct cred *c, u32 *secid)
 EXPORT_SYMBOL_GPL(rust_helper_security_cred_getsecid);
 #endif
 
+void rust_helper_init_task_work(struct callback_head *twork, task_work_func_t func)
+{
+	init_task_work(twork, func);
+}
+EXPORT_SYMBOL_GPL(rust_helper_init_task_work);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
-- 
2.41.0.255.g8b1d071c50-goog

