Return-Path: <linux-fsdevel+bounces-10923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C776484F472
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373E41F22ACB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F93612A;
	Fri,  9 Feb 2024 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQ8nZCQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15931A8F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477537; cv=none; b=K2Ic/i4A3weihjZAJx/eM50z/uHJRIKl1NTpd0Hph+1CfwfJXsIJkHYsnw4zHGBbhxWcbRtnbLsLBRmcieXuGhv9hF65OLo2+gzbSx4lZu5EErfFc+G4VxuVNffisSeNCleqyn7lVjCIAd4aza7wxuHebi8CjZ6H6lwZ28jVfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477537; c=relaxed/simple;
	bh=HqW1OxCqhXgTLw9onxFSixvmxMjeck/nA/121BxSsCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SwmoHN0Otr/sWAPlkvPHUz9wkNwZ0IZ2moA5LYG6rYUVnJDFmIw2HDWgwdUjRlss2jjmJRMX0Jh0ESdla0jXjMcDiyaoycwklBEPv1YIzgKpqcuxFfRc0FIYGRjbJM8AISC66/pvhv+xsVqeu5B/KbUPLYj6TFSSYOXVmpBE2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQ8nZCQM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc7489c346bso1830548276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707477534; x=1708082334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJTS0bha4jjy5RqEPvTLKlFyYUs1XDYOnmkfX5fj9c0=;
        b=vQ8nZCQMVeD48u13bQNQjhQCvhXFrfJ/317vfjejrwymUGw9YE1sb0VQAGRCz/m42e
         xfgQXP6HzlLlsikJ/mIMdzmpTEqDKs2JkApF1R28ACgi9UKz12m3UF/1ID3lAw+Wlsxv
         CTRshJ16/VJwD3SwlFI9u5i7bNAd6FJNtSd5qiG5WIIIVtKd+iEQckaTJS67Lf+vPsm7
         +SUowlK2KIjedt5NSV/i3HO9L9SuBQ9KZPxehynwPTHBRZ4GvSgBUSCECjZrYGSy8QXk
         qPD1jrs1ZUEkYti7OYXqVDEuE583q6HRFhLlzdZSw3r/crzr8JRPLSMAkQCSmH1I/dUv
         R3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477534; x=1708082334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJTS0bha4jjy5RqEPvTLKlFyYUs1XDYOnmkfX5fj9c0=;
        b=LiokgLOr1bB0VqZq2y3Pe93yfHAtB00NpuoayU6c+yuuVabuunWGZDTWi/0rPRlTS4
         eaN2h3dW5zEgzxL3dRxwvUb0F4CR8V+eVatf+Q23VbD31vnJIp1zH+j2xx6XzSRje150
         xHHI1KHeE4vruqZmwKEnpB1YQSeKnRfA/5q+AvRP5SVemOwRkgzoL5X5KQ+PfEIMr/z6
         +M+pZ1wAViDqRO8qBUNy/18YPGIMyW5J5OaBybgGem/KuooNllR9t2hyxdGjqYWKSLf4
         4kdis2Hk7ZiSJEQehRbaLcNDqBuvLshgS+cC+913/MfuK9PQDp7OJuUrEJdVwIDQCMN4
         t5Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVzzrIHzXXiekLdkQT6PXCpVyB4YMiygUjwfC+l9aXbrk0fMTKO3mK0fPaT+dYGTerEE91NL0KzD0LFzHt9kwTZyVn99SBNTwI+J4si6A==
X-Gm-Message-State: AOJu0Yz7CtuFH3IJ/V0uC6AlPspYiRo5SG/SikkLI5qG2g2CM2ZasXlw
	u1GB2v04cZAb3WYOwcdyaMFD+GgqhDccFzQB3UqjnFtOKTxvzpb9pUwwZNGC6qZ1EWEZ08TjsF5
	0eAdA+KtvJaF2jA==
X-Google-Smtp-Source: AGHT+IFNvysYe3ygGL3HHOp3MNzAAfnYzsE1RDWD4JGsOBgpvu1cdHyhPvFwmdyJP24W+hBjDiE3YtehFZwa6jQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:110c:b0:dc6:5396:c0d4 with SMTP
 id o12-20020a056902110c00b00dc65396c0d4mr269082ybu.1.1707477534562; Fri, 09
 Feb 2024 03:18:54 -0800 (PST)
Date: Fri, 09 Feb 2024 11:18:15 +0000
In-Reply-To: <20240209-alice-file-v5-0-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=HqW1OxCqhXgTLw9onxFSixvmxMjeck/nA/121BxSsCU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxgoQI4IU+W0XW9N3yocqX13mqr0g65bQ44Rqb
 1nUM6g4R+mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcYKEAAKCRAEWL7uWMY5
 Rq3kD/9DzCDNzTpPSVxk82we/p3M26mN5s9Nor1fWDRM2D5T90DnGNc5ZcUuaMkmCLQ9AR/HrfK
 6XbO48Iv3WM18Hp6Z7L1nmvQpREO9yEfpvEZU0/hp3fm65XQh8sgb8aw/WvPlV9EA/cOUPC1qkU
 7UwWimbbAc84kcGfl6OPmwgO7LMDZVaA3ZXpM/gmvTKjNwPbhGlFIgxF1MehroH5V4Xt6ofUjLi
 uYFI+G2MuhLIP2wCwB0+xCaKTGm0TnCzhFsA6NapX6gYMwSv31ccsF49/VIXpEmTV2aLv3lVNL5
 YpEhBLckZM5Ylx88FUkPeitP5jdZy+n6OZSvF+XbiM8WNHq80asSJb68hgUlDdp3g1Rt2U+utLk
 LCTwZ0sZ+RKVRXfKESJx5l5ixLcrNrVWX128W9LDehxwJNcl32krdgSPmPkSe/0VDDskdDYepLv
 5ZXOwuiTaNJAMwrE+llrvF25tSESBAIfhe7j5K04armtVhpZSSmrURMVJhGEduH5AlYSjykfPQe
 t/nGT71DFZHFGFLRakOEacdTTgdZtLMjvTw9GEs6XX6zOW0ulTPhNuuCLG3SPDFS/VpcyfgeTt2
 MaojZYlh1E5R+IjAj3b4v2cYHZcUG2Oq7DlErFTBMYzMJfppFHsFxXN94o6TFiSUiM49HBielUS JQ/rtgBVjbsIgAA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240209-alice-file-v5-2-a37886783025@google.com>
Subject: [PATCH v5 2/9] rust: task: add `Task::current_raw`
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
2.43.0.687.g38aa6559b0-goog


