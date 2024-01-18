Return-Path: <linux-fsdevel+bounces-8255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08A8831B91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211BB1C2454D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE82C872;
	Thu, 18 Jan 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AthP+9F8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EAC2C849
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588632; cv=none; b=r9h1gXcVEDAlK1RcWJWf9UZsJUjZ4VZbn9AhW1R8T7MlSjsV38krar2N0YJb5Wj22WErC/WvZGVu/UPSNHPLrs2sOeOw5I3eAYOoMGogorRFYxnR5zw+5VT4hSIlr3P2lnfMszizD1iFatGIrJds6b+k/EAV3yybZiNfkLpXqmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588632; c=relaxed/simple;
	bh=VXii4VQu3CEARTA//TXCHQIIjHMrXvbh1ihXw7gxrpE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Developer-Key:
	 X-Developer-Signature:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=V/jg1tubSs8SVyDBlDYC6wOWSLM6Cl8pvkzPyP52u03LXXgD4jUN/vX/GveaIoZ4nGiyB7CcqsfeGO/IXdtlZ+5CHXSlHMlkCn97KGfUHiHLNHKYXkjFZNf7qSOCR5SCZOz6web3kPBvnUXQK3mUl3+C5fYAVfX51ZgdBEz9j3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AthP+9F8; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-50eb710ee18so10721103e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 06:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705588629; x=1706193429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzVko5ey5XomiaTP/3j+Aylzt4fKZA9AvfFuwkATRlQ=;
        b=AthP+9F8Cv7XJAh0jqkXGp+bUtR+oa68RlHq8DpxraDmMIkr7fhbfyZ+lfzJv5FIMk
         nm05ItDqVYiHoUounpGaiCioHLWBNGuZOLaK0Y/29ocNMQkxe1qhwoKAN0q5HrQjbxZY
         4EZi2j3x1si96F6nDOqEWEG5geaHHub0DeuxbRyVc1DJGYTU5IODRDJdIf5wQ7pHYLv1
         kNpSseVG3FQE+l0Akds0r5+L2LagQLFlTjdtnPnplElruax06cqLl7rE/P9491gDksO9
         rRJYW6Ki9YdUevBizHR89fxckEvpDyUOwZm/jjTKW8yPyjy5X2R7s12UHofEPmoQC53A
         paPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588629; x=1706193429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzVko5ey5XomiaTP/3j+Aylzt4fKZA9AvfFuwkATRlQ=;
        b=Kx0ZY3TJoE5cQXOyFeFHE67UqZJakbsLWJph0b1uE/GUKg5UxqFJCNIqx+HW02WSOW
         GVS+8NYE46S+0wGT5z+k1QODUqvIPuAKmislX3zOwP3Dm0ScJipVbKAXvxLHZOYD9pT7
         Z4bkYzdgcB2uObzdtSBYVrL2GdyiKA20yLU34xiQm4h1jFZpa+fwzz7/IfpjoZlWlfGw
         FdqBg4y8/GSDEMSgf6p1iQguzW1VNwX5Fc4mjgSPn/cIyQwfS9ab73JTvuy0YtdiGgrZ
         ZIHe61LpWCHflmI5RvswHdBaXw3EdwbhHb/mMybYd5Yo5/lhsfjV0YB31ckFkGPxGy4H
         SWlg==
X-Gm-Message-State: AOJu0Yx9EoZFRbRQsodiFZDKGHSI+RVRYxExjAq9oPX5LNOrSQGNRgKf
	s1Nh58KGFwS2Qlwa9hnBbczIkVUWHlrVlcLB5/7/M/DOoTSHR+xGwN5MnMORFFH+yNCkYEkb04f
	SIe0m/j+1dWB4ug==
X-Google-Smtp-Source: AGHT+IGAqcdIb4FXVBRsBjhRKiL8btlEnJNMXXgbSRNVXzHIUfkC3AwJxajBSXJuYEwhxbkio8q/0Pht3OkPH/Q=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:1326:b0:50f:14fd:5a2 with SMTP
 id x38-20020a056512132600b0050f14fd05a2mr1242lfu.9.1705588629212; Thu, 18 Jan
 2024 06:37:09 -0800 (PST)
Date: Thu, 18 Jan 2024 14:36:47 +0000
In-Reply-To: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220; i=aliceryhl@google.com;
 h=from:subject; bh=VXii4VQu3CEARTA//TXCHQIIjHMrXvbh1ihXw7gxrpE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlqTHPE2OQ5MxNmkDx/d0OyvyE9y0jK5TyOb1gz
 zrC083CUEyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZakxzwAKCRAEWL7uWMY5
 RjpdEACVtZzvrDY55UxSJ0r3VfIxbuH2lJ60e5lYPYESp/NSHZUevhadVVJ5vNaqGItTbasjvh1
 tGN5hPIH0oOAfcQsOueBMQHjqksSSKFZDTtPMJWj020IPO38EU7p+4nmFMCIb+jaImA97N+1DDW
 A/MR6DzqWFkHMa1/+Xe/Zc4VgvPz5+SWEiCR0jU2im3moJN1uX8ZqHU51N9EhAo0VBkT8nkYOyI
 bCDJrRgssbd663cT0mZhWamzB8IiQYOTgGMmrOZ0XwBxVQsVFKK8apkEI8ApgNyat+Co9T6p1cF
 wkzcoRcGLHp7298srMnW5NNnvwpnCCGaP7CzswE7C9UD6ghCiPEa/55CT0UoOWaZ4+JXZHnvq4j
 Igre90ckd2KIf+IK1g6j8r1QelcY3EOI0xFQzO4inFl1luCvZ7/C5hez22JzuBzjgxU/rf3LfXA
 eoWczckrhL9h5W9YYcCgJcdeclNGH9gs6bitekVktpOadWm9GTk1aq3O1yMOHuVDqq/AnUlyKiJ
 QZvuEWyK51mlWtYlf7TCjiHYanRUrnRmF6e+iNWQkE/3/sIf/X0P+izYMzfgLlltS5tTC1Dn3ct
 XctOVPFmJAjZf4gWlkQ6goBCTyyda6IjbMK0zeVA/+X162OA8vdYa3lL30+c0L/bfjUO6ZJOt9p SHBCBHHndkwyigg==
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118-alice-file-v3-6-9694b6f9580c@google.com>
Subject: [PATCH v3 6/9] rust: task: add `Task::current_raw`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/task.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 4665ff86ec00..396fe8154832 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -82,6 +82,15 @@ unsafe impl Sync for Task {}
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
@@ -104,14 +113,12 @@ fn deref(&self) -> &Self::Target {
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
2.43.0.381.gb435a96ce8-goog


