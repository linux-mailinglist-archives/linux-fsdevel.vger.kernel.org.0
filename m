Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD01675B290
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGTP3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 11:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjGTP3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:29:03 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C4C10D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:52 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-98e40d91fdfso70976866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689866931; x=1690471731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EyZV70aSLRGUBSW3Idz74sX+TofVqWIQD1mh1640q38=;
        b=RqS707yH9iuG7p6GJXSLRTbTgG0a3UfXdNmkgzKXyq+LZAk/vDmF962f9cun/ZxZCg
         7d44NcEuve934uCnCmHBq7kvmoXcMgE8vYD2El840R8evkmUt6iB4SguESYzPUmKs136
         pcRKzjfCHFo51fe3uLQ8VtOzzYCmY7RUStmHPVdkrUlC+8ku7Pp6CEefLRS5aIo53e8p
         OY9bAVtCRHmJh/24zpIY+BvIeuDWITw0KryIPXViTV+QktgVYIYQbQaYHISUNt6cyX5Z
         KJiJ81aEPRXETKLR/BgpiqXSvxeDfS6e4nf+/0XDdPzyofbowKZ44ErJDP1tOrhygDtm
         fGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866931; x=1690471731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyZV70aSLRGUBSW3Idz74sX+TofVqWIQD1mh1640q38=;
        b=JQPkD7Gtku3CyFyHVfrH2C6ARLZ0CCUf0Rdvoan2kfbyi5gyNhy/ISIqruSHR5mCkh
         mBbejocjQkzRqbKxnyhUWDL3iPTGcmWL8sSEB5YoWg4PsZzqt4fOO0jxPP1UBuw1hkx4
         1Nt55S5SNwkrw2mgslUAU6LeGjokggVcdBIVRQLF98kOwzzObQgA/+BRguIl+DoZLNes
         tLpBQ/xv5W/8GtQZjQ7M/0OVbdlqi8G3atjv8c5/v4pm4labTKz6PyRQU03EF+egBlkS
         MTqV+0gP6aTPt7wIiZv4gVOtYiEA+e7t4UQFqzcqrwqMe5Ij5/AKMJH1cgYrrKqO5ZEE
         d8nw==
X-Gm-Message-State: ABy/qLaIj8q1oemEpV8XEybh9X0hdmFMqbKaj7/2pTxY4BBo16w/8xXd
        pNB/nR926g4T2O1oWUNN5E94NEXuxAD2dx4=
X-Google-Smtp-Source: APBJJlFcX1Wvv8T28heLGJIvE2Ykm8T7nFeE/WdA341Y+SWLJMzAB39fF5oIw+mdh2BWhXmtFjKIfxadaKRwNy4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:2bd7:b0:98e:1a1b:9c21 with SMTP
 id gv23-20020a1709072bd700b0098e1a1b9c21mr15466ejc.5.1689866930843; Thu, 20
 Jul 2023 08:28:50 -0700 (PDT)
Date:   Thu, 20 Jul 2023 15:28:18 +0000
In-Reply-To: <20230720152820.3566078-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230720152820.3566078-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720152820.3566078-4-aliceryhl@google.com>
Subject: [RFC PATCH v1 3/5] rust: file: add `FileDescriptorReservation`
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
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

From: Wedson Almeida Filho <walmeida@microsoft.com>

This allows the creation of a file descriptor in two steps: first, we
reserve a slot for it, then we commit or drop the reservation. The first
step may fail (e.g., the current process ran out of available slots),
but commit and drop never fail (and are mutually exclusive).

Co-Developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/file.rs | 61 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index d379ae2906d9..8ddf8f04ae0f 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -11,7 +11,7 @@
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::ptr;
+use core::{marker::PhantomData, ptr};
 
 /// Flags associated with a [`File`].
 pub mod flags {
@@ -179,6 +179,65 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+/// A file descriptor reservation.
+///
+/// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
+/// then we commit or drop the reservation. The first step may fail (e.g., the current process ran
+/// out of available slots), but commit and drop never fail (and are mutually exclusive).
+///
+/// # Invariants
+///
+/// The fd stored in this struct must correspond to a reserved file descriptor of the current task.
+pub struct FileDescriptorReservation {
+    fd: u32,
+    /// Prevent values of this type from being moved to a different task.
+    ///
+    /// This is necessary because the C FFI calls assume that `current` is set to the task that
+    /// owns the fd in question.
+    _not_send_sync: PhantomData<*mut ()>,
+}
+
+impl FileDescriptorReservation {
+    /// Creates a new file descriptor reservation.
+    pub fn new(flags: u32) -> Result<Self> {
+        // SAFETY: FFI call, there are no safety requirements on `flags`.
+        let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
+        if fd < 0 {
+            return Err(Error::from_errno(fd));
+        }
+        Ok(Self {
+            fd: fd as _,
+            _not_send_sync: PhantomData,
+        })
+    }
+
+    /// Returns the file descriptor number that was reserved.
+    pub fn reserved_fd(&self) -> u32 {
+        self.fd
+    }
+
+    /// Commits the reservation.
+    ///
+    /// The previously reserved file descriptor is bound to `file`.
+    pub fn commit(self, file: ARef<File>) {
+        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
+        // guaranteed to have an owned ref count by its type invariants.
+        unsafe { bindings::fd_install(self.fd, file.0.get()) };
+
+        // `fd_install` consumes both the file descriptor and the file reference, so we cannot run
+        // the destructors.
+        core::mem::forget(self);
+        core::mem::forget(file);
+    }
+}
+
+impl Drop for FileDescriptorReservation {
+    fn drop(&mut self) {
+        // SAFETY: `self.fd` was returned by a previous call to `get_unused_fd_flags`.
+        unsafe { bindings::put_unused_fd(self.fd) };
+    }
+}
+
 /// Represents the EBADF error code.
 ///
 /// Used for methods that can only fail with EBADF.
-- 
2.41.0.255.g8b1d071c50-goog

