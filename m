Return-Path: <linux-fsdevel+bounces-25435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0955294C26F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC231C24E85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4077C1917C6;
	Thu,  8 Aug 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEOMKDNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F13919069B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133796; cv=none; b=W8T4sY87nB4ZllzHsna2fEJk2aleEnmkQrfBkgm2BguH9nicT76YnnWXSe/hM/4PkpNBEUlTn5yAk9YTTBUNgjhEVw0P2kPJkt3YGHnib5e69RMK67gKaXacKWRf3J1S1ontJTnewNs3NqMOPhNrBh5xBX3egQVdp1c0f39RpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133796; c=relaxed/simple;
	bh=6Ih3i+4Hw1P+6eHIXABlsLLf+5mhyzhRH25qSqltXX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JblSP4hSOcu402OHAe8wFwUU+PFaqiOtgiz52d8wqmZzNgu79hSv/f4IJYNZm3V7xp1ezr13+jLnVb4Rv1d9hxX8J2spOqXlSdaqPLrDrNF1OCKe5xe6f6tlP5Q/jCncc/oZEtRXzAvoHqOWcEUGZKjL2hX667pnbc8QhBE0zhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEOMKDNT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e3eb3fe93so1971460276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723133794; x=1723738594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LnrOkpnPCFdbzQn/x9iHS+wX+2l97GUTugL+KcnmTkA=;
        b=WEOMKDNTc2CnSFdd1+kswUEuLqiC7PtjET+Rb9U9fZzxoPEv/FwIQIdhVyUYgU30D6
         UtO0+lqVAeTJJeoWSm892IvQy81mYEAXp/Ymt4cQTGfHvlgDJbqoYt6079RcIGW2537J
         bAAX27BxQnwYlJBhlBLL9Bm0drBp6PfzscaR5vlrkNihZFHnI9r+SZhSs4N1uTmH2gE8
         lQzGivb7yIFjb2IPlbAUvgQBNXVzyVuMdkwOuTSCLeHRHmoOu2/QK0A1nVlooDH1Xw3Q
         iox9NSAzQXrWXYtD1Qg6G0tfYTipRjzt0K1v6nGMrNeACEVrOB7bzEMW/IcfYp4tKD/n
         r3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133794; x=1723738594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnrOkpnPCFdbzQn/x9iHS+wX+2l97GUTugL+KcnmTkA=;
        b=e+I41YMIctGUw9AHogK0/PBXhVqNtSUGiZQT3cYSljym7aeH5cxthFsgsD7clTuDDw
         WuSbI0pOckx0uD+cied4uzEuiXTVNV5mR/WaejhBNhLAsCbn5jseMLSS6/XlvblXb+qI
         2+XDyuX/sXwO3GO0K7r7ElE/Ozcp5RfUDQWC+2kPPHfOx3aeNQ56sWH4/iO1Ozr5wY4e
         5L7SkeLcerM+XeX+b05KcXZUVC0ubh8n3uYc9AncfeNv3QtxbAmwPCMeXiNynmyUmD5O
         Jq8gWs49Czg07mXnrfO/z1MSnbp6bZMhNaypGn/0990w9GfCP7VsU9hr7H7Ud+HNJR7w
         4GUA==
X-Forwarded-Encrypted: i=1; AJvYcCXZRJB9BIJmRCXRbUmo81se3fhDoqFapSOGvm4CYEBHOICKvNknZ/k6o/CGkbT/eyvbeZbvbi6sVg9y89YMBnlPNYSN4fUnrq6HFJBb5g==
X-Gm-Message-State: AOJu0Yzw+/Lm3xrPcGJXnEiSa9WmQXhpvYA44aAllZkVEJWDJqlL/F+B
	iZ4m532++PpnstjLHXExe+MIYVLnnqEv974GlFnFO8hdf+AU2aXMkQcI0cOwI6GTD4R+sJ05ML0
	0B5xFO0EJs1uRiA==
X-Google-Smtp-Source: AGHT+IErYjafy0I8ODbgd/7fZg54LDTDd7vHtt2H8T5U9KTddFirQ5oOi7NGxvr6EQ57PdY69ofn8ahJXQz+vb4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:26d2:0:b0:e03:2217:3c8f with SMTP id
 3f1490d57ef6-e0e9da86880mr4196276.2.1723133794036; Thu, 08 Aug 2024 09:16:34
 -0700 (PDT)
Date: Thu, 08 Aug 2024 16:15:45 +0000
In-Reply-To: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=6Ih3i+4Hw1P+6eHIXABlsLLf+5mhyzhRH25qSqltXX4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtO9W8ShuSxK2tF6pVinnkGiah1DUVK31iGo3K
 2Sc7+2LDPaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrTvVgAKCRAEWL7uWMY5
 RlTSD/9fuN1pb719WKFq9tEB3IAVCXdxBm3YMiS28NgN2w9S+NkWrO/NDIC6+9Gr3rUYizVGk7B
 7PldiVjZG+ONB+GuxvcbumwPjtp4uqGlH4yMuK9yriHZYtJ8mVaqFidxLmskQBvpAtqW8kPX2I3
 pQUNHDaCfR5mAWWGD/mG1GNu5LRaZLYV0IBso1axFN3sdkRgvoVxIkax8YQR8/XruZoIvdrMtH7
 5ci/7UM5r1EHZ8U+OagwjSVhQu6ZbrYk743ZeAXJ+pdy1Adkeh+bY3FSGWteIzi/T+5Bi0HdGzH
 zYvyEZ6TNMbOoN4P3ILsvaslshULgAECovmpSJ06bCcLFZNGyoFMvQDKXgraUK/nqqitERXeu/V
 6Bh+4+CruxzdT8MJ/WpAZfdGZZo3luGBU5aQcHDLluxVKUrz4v8O0x7rEfu77990evr5XnOpns+
 K4IVSzTe0wsV3QhW4CEnC4i1TjOH21aK3kMTsjuDF6uc0fIbt14ZLTHjgTVW8sOrNSzYdnW0kRZ
 4M2NrFhtj5SvsJ1eNs7JAY8zP0xzeIcJ2SoTU0p2dSsEYONa8B3NwvdUuldqmUJcT4f7CrPY/uH
 l6HbLQ0VRV7GV9FFW7vptQlfZzAj1A+VlySWKWKBGmB+gR1lqf0w2Eb3CxqXnmX7ttRfQKBYBDO FYmIRq23yMQwmFw==
X-Mailer: b4 0.13.0
Message-ID: <20240808-alice-file-v9-2-2cb7b934e0e1@google.com>
Subject: [PATCH v9 2/8] rust: task: add `Task::current_raw`
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
Cc: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>
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
2.46.0.rc2.264.g509ed76dc8-goog


