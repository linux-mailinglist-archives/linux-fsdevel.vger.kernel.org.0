Return-Path: <linux-fsdevel+bounces-24243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FC293C41D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5952B23B49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323BB19DF60;
	Thu, 25 Jul 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIGrO0HS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63F19D893
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917671; cv=none; b=aKrpvCMWe4+4yjvDHhWsgS5Et8q+qlRCxcvEddRGkLM3rDP/qt+PCqM3dK91yAzvH0rI2lBvRsWsIUhosdATzbUAW1pBGAUZc8eRI+DRrxtIewwaHnScKHJi/zjJFraRZ02bopLXw+YodwjsJ2CtIhucuZGf3ZBJscM8XC+0Tow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917671; c=relaxed/simple;
	bh=Y7EveGwaFZVeZYYvVcVUkcGhuSESwjRgqqnewAo3pxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TC44a80YK93AOlPIl6yVOVv8cOqLb2NypC6yWoKMJFkQIMEaZpU6hnDc/UzTzXZpv8vTOI05pw6ilLEWmYrA8XbMludiJck5i9FOyi3Wyf/wW95bALYut6IX/6xCxjpahNf3A1lHL7cq9Zra9k/14sU/RVCxe/YiNa7ynGojCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIGrO0HS; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2ef1ba2a5e6so2361871fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917668; x=1722522468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqu9hbcZjiCiJxMWwW1DRQvdcpwKODwZoAJXE9dNBuQ=;
        b=IIGrO0HSUwM4JAC1W6HTDEVta8UwvgIgaq88d/TfulzvvsxkQfw3uS6r3JcQfoC0Ql
         +0LdZO3H5fjctx2dZ1S470carvP6nQiUFf7mlS50fwJOxkgzmfe6pO3F4FZTCH0FfRo2
         MeIiuA/NSRuc+AhdcV0HohR6k/iAWpXOp8qXwQzGqCTJ3I4clDWkLeg7kFim+v++p6MB
         8d2sNOURRwOOvhyqa2foU/J8cGtTeleb3B/qqp6pyrtYBtzkiKwNa6dd/e/Qm5N8c4gl
         66mzTpUn0uN+yav+VEfvKrtmPmrkRRboLdrOaXpJoU21MIifqyWIamjX3p18YPJZYKxY
         Jp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917668; x=1722522468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqu9hbcZjiCiJxMWwW1DRQvdcpwKODwZoAJXE9dNBuQ=;
        b=JgcpCn+DonsocnMAJnfAL/zZnh5ydyj6hJGscMyeMTGUfi9eVFVtccxQvg3JgiFXb6
         CfYOuW7dV2oiqj1HOvpOb0e6uLT5F3bveQaNBtT8B4nCqwL8Ul3xnflJzcOyaZd55Qgb
         rZXCENfSiG6xxEfdq+AtAtkomtGIgjEdWCNdNn+sxDjZEGtcZYq4ASE4Qi767KxipfNt
         N2TvQ4BC+ijAwyABV6TFHgu7sCcazX1cUJUWgtu45LUb9rh9fTULCwetM56DMgLL1Y28
         Tj7jiYGzb23sarL5PrrGOwpzp0WhQlRdoQJOMachsSyT4QRDI7WcTKschYkuVknL4MNJ
         WpZw==
X-Forwarded-Encrypted: i=1; AJvYcCXj4K36nqWe3FeN0lgZgFH9X9cBzzP24lhBY7m2AU61BfVRBhPP+H7jEHQUT+Yls+waRx7Z1XcnxhlOEHKvwZJVbPNLaSzb7fumr1mGHQ==
X-Gm-Message-State: AOJu0Yxg9K/TUJtgS1fzDMy9MZ25zFx+IMMYPJZtyNC9QJ/JezmHPpq7
	1x9LWza9gpxJDaBiGsNmOMTreknaHRj0vbW2Ohcq6KX7Rcasi9pnbhVGwJDRMPweihFL/dK+2Sg
	vOZTZ2p/m6fBlCw==
X-Google-Smtp-Source: AGHT+IFnXRADlnUEbxl0mtBvfwQuGp+zFQ+sJ+3vf/k0s7kKBVZQ+Ew6ChUoyD+TuMMrhdtMCgU3QmSJ6KPBxEQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:97c4:0:b0:2ef:1bc3:3fa with SMTP id
 38308e7fff4ca-2f039b3999emr48501fa.0.1721917668172; Thu, 25 Jul 2024 07:27:48
 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:35 +0000
In-Reply-To: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Y7EveGwaFZVeZYYvVcVUkcGhuSESwjRgqqnewAo3pxw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDXe7TQovfSy+bcM+80aWs50pz7TKA1NVt2F
 dKLuFFnsZ2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg1wAKCRAEWL7uWMY5
 RpJIEAC1c3zbht1aNR9FY2+6fNMS99tzB2GUHPJaEdtuUJ4ILd1Eg60NRfZuOdJcp58SdE75C4R
 DxcTruQkGWaQ6GUOHi9LcnOfO3YgxzHKdjnFeZ2XRdB4o6kP+V4oaT4h9GI0TmllzHOl0iAcP7y
 iCJe5J+1zEo2PUPeR5sq1dJhzJ1gisMMlqu/kdCZ0hZhpHI3OEF+RPnb2CfZrSGm6ywXyLtrRGT
 X9idZihV/78sRUhhwXb1OU5xaJgrd2ltriARLf66c4dI/jkqurNSSWMgYZhoAZq4o4BjXuQoVXK
 kqjrAK06BgJLj2sKp8GR4QqRoZha6rndpSyDkUIfOi1MqFgJLpMUW0Z/SBLyap9Ya56+zsemE2J
 LzWfzOAT76t8xTPDvN9pNG1jKHgsNGYBFSRyraWlUtVZD7YD7o8Zk6LSP3cF4bDdc7DIJOlKFWh
 U6IDSZ575oMK4ltRD7KwcKnioadJrujgwOJCobcqzSkRVs5cQ5KNOW4LG9OyBEkhdj6bj32CLHh
 Ry7preBUES11aSl79B8RNZnVgoD8PRXx0RkXS6lsY914s60hjcYDMDi6PdjCVYhOFGWg1BimRf/
 O48jMkZXjXyM2HA8rSAFAwwAhFfyzQSIOKc50Q/E0Go2O+gM2Nd4pzF2WvZxI+Mmq+i3d8zcOLg F/mNAgZB1cBXWOA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-2-55a2e80deaa8@google.com>
Subject: [PATCH v8 2/8] rust: task: add `Task::current_raw`
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
2.45.2.1089.g2a221341d9-goog


