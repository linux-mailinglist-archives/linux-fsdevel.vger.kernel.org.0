Return-Path: <linux-fsdevel+bounces-29403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05A979727
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BCA1C20C2F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ACD1C8FD8;
	Sun, 15 Sep 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jb45IT8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC501C7B9E
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410703; cv=none; b=C2R5vUbaQFpCrlgwslca7Koozjb4oVDwHi2Gy+79EnVbHdzrvGFMjnNwH9HvuPsjsL2Mu+F9GUH2bbD9qnmOzo8XI5UoblvLUCAxioTMQh0z4woUA6bMTkiS0hFmDSqET8zsyorwREBNAG7us3jlGsM0Ws8jMw3u1REwpY+15mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410703; c=relaxed/simple;
	bh=+rv6j785B2Asd3auywHXoPFhTSP9gSiszdqm+Xwr+aI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XHnZwUMAWFnFtQC2tlYaHYfFv4S5pUUcUzYvEv5tUdfRCesftrra7vHgD2SJSQd4l22LBJ4CbY63PySrHK1lpEivXteqGOE/wSU9dcdcXyrRiE6m4VgmICFx56XCBQlks7SgXi3+F8n1nnklu8yoylpzZM+Trp+a/mwNV/vWmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jb45IT8C; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d683cfa528so86380797b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726410701; x=1727015501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkGmu1Ei8yfm/3eeEHU7BES63iCYbdgu3tOlhcgG6qc=;
        b=Jb45IT8CZx81WPkfxtHNPac4UK/a1cqOQfGL8i1cfYDnku8c0wa0tDgt85RsQbTBwy
         7TIBbr8YAjOVQVI3/Jj6Q7ZPEOBTLLWZuRXhAPiQTbI0Zxub8c5xFyuYb7GFDtMXwDnr
         MDrm92MTEfIbLd6oOqcB0+s1bB49SjhxSgS7c/qQGJlEQGG39dPkOVFA+fUVNUeC6SPy
         jIzy+wSsZW8n9Yn0i6fk6x0TXvpjouOvE+P4Uoi+Dx332NxOdhX1RqNd+M+KOi5QyI9C
         sSs11zJcOaLdFmNlLQqbXPMLHlDGd5rR2sl/Dh+TZP6vLfjC7z9N4yccgz4Q+bsGR8QI
         S4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410701; x=1727015501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkGmu1Ei8yfm/3eeEHU7BES63iCYbdgu3tOlhcgG6qc=;
        b=ZywMab4sqz+BZzXhBsCArl7tUUN5AitmHc9oglpuUxN8F/m6S1owiDJ5nRQ8JP1Ai5
         V0JovkcAsjTuJnV+Udr5Z1nUfM/6EGh6nyUhLohkJxqsk/7LZP3eBO/6ZJbIaRKL26nn
         6689fUzWiVrf65ObUBg4YljmxhJT8POiHitkIfxh8rnEq98PRP2usQozBzyoS4aN3bOZ
         ovLpTx8ELl7+mD3/9HFeFd8zggxA4I+oHSacVanRyk5Ls9shL/7FF/zxfezfrbrary/K
         0Jp/Gh34GA0As+jNGY9OBhML4eUxo0yuVaPyweFDALZtWbXhex4BHwK9bnJfedtMTCC4
         9PsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4oqLS/qeyUJPadzkJQPb4kt2HQ22F0InUG42QGKHNWfv5cJOPAiol9agfAtipYgneDj0XMN/OKF6IRgok@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKYLTzR8jDWp4SZsYvzC5xH3FeGUkrOfGLULQhpK3UjvCtNKc
	tfQh8o0WFblhc+iYQ4NKADFzOmoiLLPtKmaFg16OIWUtqlY9hGxGwjZr+0lno4TM7tDhBcfGfCg
	U8r/6c2WVQ2iNVg==
X-Google-Smtp-Source: AGHT+IG4OTgHmcvBK8F9QzTwC03FC+JTINJZBl77CjBGWn4GOyO6KrG4A+heQeQ8GzPto43BxFkbBmHwFjwkG2U=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:2a84:b0:6dc:97eb:ac51 with SMTP
 id 00721157ae682-6dc97ebb066mr126177b3.3.1726410700520; Sun, 15 Sep 2024
 07:31:40 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:31:28 +0000
In-Reply-To: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+rv6j785B2Asd3auywHXoPFhTSP9gSiszdqm+Xwr+aI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5u/BRMuTCyk4C6ZuOxyOE1rsDuBB+ojWrrpQ7
 PNWWdayP9iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubvwQAKCRAEWL7uWMY5
 RvcUEACs+EHYmHyTXA5CqOjIpJvfFFGznoKIRV7P3FdTem4anQN4Ip2U7U3SZN3Seu9w4aN4VEf
 9g73ONo8cEtyAa7AtlANEITVYf1+VtOkCqeqccGBlxyppfxFNCFTpIlfWdPMjgcvH/iDpDOeeeu
 Oz6HV80N4RS59/OODeu9KWfeFJIEoQTwwbagT+tUm2sYLr8gC094BqW6oY4Q9VHpiR9JzqQH2u8
 YrHb4haDPSoeqTgjWGopNeXPzhssSkhxCA3u0aVlTPddRk9/gVXUv4pd12zaOyhPBfVRf+HzOeH
 m/7rczLTAgWjuD4EqgYErA18aJoP884SIEKcZgVFyqVth8qlvsx2dYGPAnhFPNH2GwgpXGNQmqb
 UjnmyLxWtSdO0v8yqs/g7hiCuE6uNVrxx2jFloTnzE/zLRICU/G2UlQXCG6aUBo6vuC3imFrbd2
 XlajUVNWFG+L255yZF4Z5EYZgOP6VJm3ek63qWXGOjt+APpL6cqeGAKUJ2FSwjkhZb3PmYJ41kT
 qbcH+yWIIfjd3d7aaS4XNryMFCZ62ehb5zh3hid98wXk6DqSN0lowmhQYnqGYaQ7DQaGpUlsDZ8
 BKzaSuu1qhgp2+OUlQJTiWw92LZm+rNv6xrJIvPnmI8R+lxbio5FS3pQypLJkIBjhAr3JiIcYK1 b71SAxy8IikXF+g==
X-Mailer: b4 0.13.0
Message-ID: <20240915-alice-file-v10-2-88484f7a3dcf@google.com>
Subject: [PATCH v10 2/8] rust: task: add `Task::current_raw`
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
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
Reviewed-by: Gary Guo <gary@garyguo.net>
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
2.46.0.662.g92d0881bb0-goog


