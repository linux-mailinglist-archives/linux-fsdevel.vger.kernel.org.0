Return-Path: <linux-fsdevel+bounces-22785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543DE91C1E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B403281E83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D31C68AF;
	Fri, 28 Jun 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4YToG7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76B1C688F
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586675; cv=none; b=YERWFTJuUPcyoDFpwvdHxV+uOeIWn37Kt7+bxo57Yins5UuHP8/duR6C7vmCerYvKqfNAaNxoYnp7TOP3gLo61z1fSIN3p+g7gSaJSCbGvnNZbg+Sk1AodYBO6o1yrjqA+hUc/u6WpW+o7WskZYPtVid9GhTsng3b9ct7pYEwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586675; c=relaxed/simple;
	bh=4wlabOF4qnHHRK4JrQrSunzQwpBlfLkz5DsTWMrd2qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDLrGr7JCfvJ4ZXFtjWOP53bjp82+IT0i58LHAB8a1LnHtm+Le3pDhPl72qNn29dZnsa0PdlGlbyUS38Dx6W2UTtQFbvbMsJrc3FcSpZFhWaYZP5NvFpYyEHMsVsqotulv8iMw679HZa0MiRhLXP50pTmZORj98hSJLuhYgo4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4YToG7l; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2ec507c1b59so8941631fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586672; x=1720191472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uL/9BQ4R/uRrk1opn7GDHDLDYKLgQIp+STPcPNnv19c=;
        b=A4YToG7lwy2fc4NgsHjG0ST23a/SuB/hdDWtFF+LKXF71Hxc7us+j0cySNz7uDdKqE
         Ldq3Un6NwQWdLocWzeV0aL8xGwj6pEJRVIIVpbHfbQ/fJimuJrrJsk1lbk0N0tQl23XH
         wcgbXka8quI9RfYofLHJoDqTxtmnI/rqXFTmQe21f6h+uzCsbpdcpFO3+XIHumavOBhN
         qlKuY5Jjd+gp2MUyKwqHMi51aIiny6LAYjgPkB6PdcTzOIgkyktQ8DImWzBNP2gqNAFs
         kmeYu3+cgWLBo97f+0Le0VJXHfT5nPl2cVIXJj6WaLd5LXPpeZOoc2YSZX4wLdROv3DK
         S+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586672; x=1720191472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uL/9BQ4R/uRrk1opn7GDHDLDYKLgQIp+STPcPNnv19c=;
        b=QqY+ZoXL8pOVGzqKBkK95xfn7bcb+M6IfeFvyZsLuazG4cbYH1P+9U+e0HaaNwxmbz
         vlIaxunn6PSnyFRRigd8zGxmi47sdrfBC54IT0EozEoU40+0oGmziNDlzKvXmXhYyHmF
         iwEiweR8XG+yoQdtCLrVdO5xv6lzIT/9yKdmZVQITBYRtNYkzwGNoD82AKewctxV7MCw
         +WhXSebE30FadmYZaNCjW1N0vmYW5c9LTD/7QZD2icM3lYk5BF08qiB7w+VY/j/SzETm
         o51O2e6mZ29Y9Y0cNs+1mDkLjJSKY3D3Cx0Dv8nAFDcZXIJn1i0mS5I/IAZaJuduvKB0
         Limw==
X-Forwarded-Encrypted: i=1; AJvYcCU+W6PXIPhAf9kcHFBYzsl8wyA3+fIxyXawdxnLMItIdFlus/87XEI+OffHHzVVu/0y8GIh67qWy+uwd5eF/x+eRsUEnryPJNWkMrYKMA==
X-Gm-Message-State: AOJu0YxZxJYYRxK9vfigb+Yjpijf/iNrvhoF25YHkGWSZXM5qgXNtPG2
	irGCBtNJbmz2Nx1RVzLdO5xzOuHVhfB12jJ/+jbNRP/NJ7X6tkhST9rh5LkFrJ+aJvrNotfge8P
	w42/UCrlY1jf8Qg==
X-Google-Smtp-Source: AGHT+IF4x8A8zxRvt0MO24DrI0ZYp3Fh+ug0LLXFI1pHBsJMoatc+FQqu4gSdGFjmz3I91QmsTd5qtePAA3XHHg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9ecd:0:b0:2ec:50c9:a379 with SMTP id
 38308e7fff4ca-2ec5b3029c5mr201621fa.1.1719586672124; Fri, 28 Jun 2024
 07:57:52 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:57:15 +0000
In-Reply-To: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=4wlabOF4qnHHRK4JrQrSunzQwpBlfLkz5DsTWMrd2qw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfs9jeYGVfccOjNJJgD0mBPSJBqVxCXsT9A+Rf
 xXH8RwrXKSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn7PYwAKCRAEWL7uWMY5
 Rk7rD/0VEce2HuPYmy5wHQ2PKiRYdvjySXoXmml+ODukz/MvKujn4F0D8Auob2a9rzz7CajFKKF
 1KxmfxBBHxF0WYHZvZ3fdF6/pazjAX0sQ795ungMt+9bpI/4kYfJ7ITcSc+oTgmrdgbx4vT5UUQ
 q9+F2pVzeUwyvRBdI2Diykosg40NX74C1KsWjDDpEPlzKVBmUCLxixN21wh7rEw5g8eUCtb088d
 KktzouRVrVw9RIb7t3vUG8ZOsgeDRYC7/50Vs+scjj2HTQKzxdDADlwNdXiydbNoYABQMTAsc2X
 R1aHw2/bSxUVDhRI4/GA2OYddyORuZqMvkPZxiwbTSdRIvVA7KYlvvAFl4DJpEGrAoL5YLfEh9c
 cAEeb3xoNsy4JCAfsPP9pNUwJ4b3T3MtRUPF/85PzGB4HTssf9aatvWPH2S9TrJCeOxpCatl0eJ
 qhA6xtw6ussyDiN9kBmTQBz9zqdRNG8AijhUODDBowz/TAA+5Lvwq68nIxXKDTmKq8aaLnZy3n2
 vEthTYJm20xQ+udE0XA3ck4wN5Xurj2qWTLjlkYGclK3M673hELdkDEL6icatFS3a1bYqweK8e4
 BAJFQaW2GJImHJRXvyOWgqD4UEZQ7VT0qf1hbyus/TazFFmfoM52ITkqFnYsBy0hL9bJBdg7l4C 4Xn8Jv6eOzC6OZw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-alice-file-v7-2-4d701f6335f3@google.com>
Subject: [PATCH v7 2/8] rust: task: add `Task::current_raw`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="utf-8"

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
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/task.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 278c623de0c6..367b4bbddd9f 100644
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
@@ -119,14 +128,12 @@ fn deref(&self) -> &Self::Target {
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
2.45.2.803.g4e1b14247a-goog


