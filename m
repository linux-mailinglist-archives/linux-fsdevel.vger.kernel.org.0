Return-Path: <linux-fsdevel+bounces-9988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE3C846E67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513871C24710
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D9413E216;
	Fri,  2 Feb 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xFIj4sol"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060713DBA2
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871356; cv=none; b=Tadt75gukK+ommF8lUD6traadrZpYYaspmLWWWJOrw4Qy0/1WEzxJR64HHZGbOLYwgPLvZIk2Tnuapz1sUKYFahQ+4YiQPGusgfiX0D1ACCx6N/qXKw08PP4ydymVjkCkkKxSN5zu3yDlMkCmFsUmBU6gVTbzcTJlkDTJJ9GWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871356; c=relaxed/simple;
	bh=Bjk/OB+Iji4BInn1vTv4uXEE+/4bkjfr3M+GCsCoH3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EewjjPhSrORsi4p2G/TYDJ680KtxmQMMfJWBrdkNuEUppcRa7OJAnxYHcMiIt5ZGBVZV0qSHrLCgLGfeQV5qRMkLOJHGudrKQonafKeS076BElmn7D1eOynhag8YgVZovdKGfw0asbDAkud/f9hNUXWfEHQ3F7UsX5/pJbI+G6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xFIj4sol; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-5100d033f56so1564690e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871352; x=1707476152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ApmdViD79PTF2wWIJgz6LFiyNcf37NPzHjT72tU4L0=;
        b=xFIj4solmwkyqz0Hx99esWgEI6m0K4Gdnth+taPK7Jv+Z9ioN22ctrf00Wdm0JrTOX
         Nbg97B2yhsyRVC7d1QeJtE2ACK+h7xbZg8JownLqJM1UE2ZvLVSIy9bHgFqoWHuu32ms
         xx13uoxQK887TSE3WX1ytdIVChlE4/c7kNWx1U8I59/3tUJpVhFMwgx9AeHqR545l1qJ
         A+5FAO4h8ckU/KXSODxryyUjjVc/p8rwV4WxzRGfXjKLCURiDFUhxtOG6wm1yCdbyB8N
         uRvGN1VLnpY0APvuQGfRFoLznYc6w3mekCVrkTUKTuK3T/fjWP/wJK2UNaFuMGpNT64a
         Z84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871352; x=1707476152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ApmdViD79PTF2wWIJgz6LFiyNcf37NPzHjT72tU4L0=;
        b=MoXyzQZy1C1MRu9AKgVdUYgDx1VKv1d/mx9YfuzpEtc8TuZ6HBr10iJWLBdUIHT/Uu
         0Yozss4flnM52QuRY6Ayjam/Cf5x6zNPfTV1vkbaqPiYKUX73UqOG/pIQasGiofUB8m/
         iygg2vBdCo2vd+mA0ei2wHQxbev9nM6GxBSwjjO8ZaqAQ1i/Ogv9UWg4D8LfeUGcpWYl
         5IbzOcVOlhlNDQ2rMH1g7IWkecK6nPd9BTULBozAbtOmPgD37lb6i4eBNmIhN2Oi28WI
         4fQcwa7lMXqYvfrwZfCzzAFEJ8+UnGq5ylH7G3GTAcCIhrJHu0FfUUwgpzXLTZaH+VKe
         VmUw==
X-Gm-Message-State: AOJu0YwaVffzg9h213xDfOhPMJStO0bO1U5640vlIc3FYKyaQ7Uc6i7I
	ETY7g3mOMlz1td9H2QW58RkDr/AmKCbKNwCzYiW3RYGizg4nGxnSne/UN409QfjUV1o7Iqx542b
	/7BotutgGKtmqaA==
X-Google-Smtp-Source: AGHT+IF+EZ41cAAMBhg2qxIO72OoWctg36/4F4yG8jV39ZPt8qXcBD28wpob7dqAxHvP5FodQpbj7dkcOpcyH0c=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a449:0:b0:2d0:6086:57f7 with SMTP id
 v9-20020a2ea449000000b002d0608657f7mr8753ljn.2.1706871351660; Fri, 02 Feb
 2024 02:55:51 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:36 +0000
In-Reply-To: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2292; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Bjk/OB+Iji4BInn1vTv4uXEE+/4bkjfr3M+GCsCoH3I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjJckMPHmLhUIiPgXUpw7gM92pGwvmvNEzb9
 4LAYK2UX5iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIyQAKCRAEWL7uWMY5
 RrAsD/4jSpaOcEIG9sCDcWDdJX+UN94jVByiIBv6iGusfSlTy/zrfh2/niLbdxLt5ihG79Kvim1
 Vy/8VkquGO1Rm1Ff4oAQx9W2waylkLTFnV8IHA18le/kK9Y0P1sUSny3CO4anLD564bXrtBaxZr
 Fk8CTX9DbPsZCXw5aacUEFUKRk3LI5ZXFRLnKXiACAYr17InVZKyoe+UoiRvalbbzEJKqXbWlzw
 352wpnmE2fcf5lWm8JxIj350VJ5YO5jmq9blleXBucfcm5Jhj5yPnfmkj4bx4FR4TEbh/Onh/HK
 cs0WE02UazElXGcb1W0zjVRW84gxA64KGuZe2cijY0HwL9fEH4w7Wwe/xCxDUjvq2sFkoOalGgp
 Zzrb/uMoO0is2D3bHXwFGx4gZ5TB+6ungdBIEUWLqb5ZZbqR2MadBJQ6+S4uKHhXVsDLCpXrLVs
 vium6PbmOAAGWv3R0YD9art/w9pP1JdtTXI3pGPNXt9wcbiq8bdIQ+znCFJG9BKNjuxgvDZcYu9
 KTXOk4/+36IgaJm2BI8QJfdwriLQ7Y9Ol/0EzcDbBiVvokUrzJoUSpD/R1Qy7ldBOzuInua0TjX
 ECpBuyuQYXhjFIBTTLFWmkzM5HHK+yvWlvjaY7F+TKgyUDFyZx/uEE2D05lqho6PPLBtt2SdEHx kvILMP8qnvciJBA==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-2-fc9c2080663b@google.com>
Subject: [PATCH v4 2/9] rust: task: add `Task::current_raw`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduces a safe function for getting a raw pointer to the current
task.

When writing bindings that need to access the current task, it is often
more convenient to call a method that directly returns a raw pointer
than to use the existing `Task::current` method. However, the only way
to do that is `bindings::get_current()` which is unsafe since it calls
into C. By introducing `Task::current_raw()`, it becomes possible to
obtain a pointer to the current task without using unsafe.

Link: https://lore.kernel.org/all/CAH5fLgjT48X-zYtidv31mox3C4_Ogoo_2cBOCmX0Ang3tAgGHA@mail.gmail.com/
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/task.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 148a4f4eb7a8..b579367fb923 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -97,6 +97,15 @@ unsafe impl Sync for Task {}
 type Pid = bindings::pid_t;
 
 impl Task {
+    /// Returns a raw pointer to the current task.
+    ///
+    /// It is up to the user to use the pointer correctly.
+    #[inline]
+    pub fn current_raw() -> *mut bindings::task_struct {
+        // SAFETY: Getting the current pointer is always safe.
+        unsafe { bindings::get_current() }
+    }
+
     /// Returns a task reference for the currently executing task/thread.
     ///
     /// The recommended way to get the current task/thread is to use the
@@ -119,14 +128,12 @@ pub unsafe fn current() -> impl Deref<Target = Task> {
             }
         }
 
-        // SAFETY: Just an FFI call with no additional safety requirements.
-        let ptr = unsafe { bindings::get_current() };
-
+        let current = Task::current_raw();
         TaskRef {
             // SAFETY: If the current thread is still running, the current task is valid. Given
             // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
             // (where it could potentially outlive the caller).
-            task: unsafe { &*ptr.cast() },
+            task: unsafe { &*current.cast() },
             _not_send: NotThreadSafe,
         }
     }
-- 
2.43.0.594.gd9cf4e227d-goog


