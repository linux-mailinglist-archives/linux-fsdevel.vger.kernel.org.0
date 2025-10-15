Return-Path: <linux-fsdevel+bounces-64195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF7ABDC656
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 06:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840DA18A7930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 04:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5992F616D;
	Wed, 15 Oct 2025 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR5lS+44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1012F3622
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501007; cv=none; b=pmkVHHlg7pNcksd/jIUSX1cSaKCOnhR5PfSu/uNgN4MM4XmZ+QEQFBGZi47Zx9JnUZqwI39gBYurl13yOGUhw2vgmGHYSPj8mdHbwXd0yVswHGwqz/T/PDlJV4BInzRtOCQZJxHsFALXb6/nGtiSh7W8QllhNM2WVpMczDmoJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501007; c=relaxed/simple;
	bh=+ZY9ISu0W16A5V+R31X/nl/Eyjev56GCHTyxRrxZotc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKCccZ8u/CEf3Rvn1A+K5y5dnOThvqpfAMjzJu0FX/0YvNmRpm4zHThmMGBE6jiJ1W40PBEVL8zl2+PPVp6qtMqwqlVZQCffeItokVZjcAGNfr5WvrQsd3q+xwon0CJOAgzIQMruYu0xHcMh5TlZL8noV5pjMu1EY72hqsPP2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BR5lS+44; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760501004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uZpbkKbGsAFX9mFxTHGyfhWtkHglsy/t96i+4mTbI4=;
	b=BR5lS+44Ev0K/nAHqVFKeiocFragzwM0IdN22P/kBoU0MMG8gXr8t7RJMCuz+FNuU2zWz3
	4LRad+p7e3MgRI99L+HOiYFHlpYZ2GKr8fUcMYf/vVqVC8r9ICX76d/pWDtKP+gXpcz/Ol
	MnANhi4JKLTLta3UUm4FWBYuhnKepJ4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-IJ03PnN8Nuixun6HANgAFQ-1; Wed, 15 Oct 2025 00:03:22 -0400
X-MC-Unique: IJ03PnN8Nuixun6HANgAFQ-1
X-Mimecast-MFC-AGG-ID: IJ03PnN8Nuixun6HANgAFQ_1760501002
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so16370513a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 21:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501001; x=1761105801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uZpbkKbGsAFX9mFxTHGyfhWtkHglsy/t96i+4mTbI4=;
        b=u20X8iO3+223YWrBtYBT9YQucPsmW1rTPJF5ZuIgBxUTHx5wcPTXsttGUHfs2wct3u
         pJEbd+akygXBaHNtyQEJ2O8j2AlfdkMaB43bbkxfzg6LPm9Wu1dpjmneqlMAkWknJ6Ri
         guX0mt5UrjgoTfFZ4H1DPg7XPSrNC3gdhEhKKqu84UqzjUXVrIZVX0TyX/J6RJHDBFLN
         qAxfimm1Agu/JqKvzmR6cSh02B5yQ04IZ5ilxI+KGst7Ee7/JNM0KML+7zy5WATfRj3M
         qWpib3BV9IoYvOwuv4gVDQE4VuS7X4CfRnCe6vAa/lH0DAA8dVvX7eJ2vPHRM650LOAs
         P2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWJD/y+EsEGP2/TmTcRq0JL48flb1vhz1msmnbFyuMyVfs00fItJOLQf4V9Uyqu8LSyNG1r0P5yLXo5rhg0@vger.kernel.org
X-Gm-Message-State: AOJu0YynF5oTHCFrdCk5BDBUfBvTq+sjimIZOLnKYIbkiVhWzD7jjK7U
	KFIPkVPNd+jy7S+Skjc315h/3/FLd/UgobQR/PZI18O9Rn80+8miV0E9tyiXEpgHlWMRDt9ycCu
	auaemnM3OMQp1bTDq7q9koZoDmJt2rmadCpMYVP+ObRCOch4jDrQh6STHZc3GYYLq0VI=
X-Gm-Gg: ASbGnct1JDjcLyAqpCgX3xzkuDoiVLK0rc4MFovvYLFU6oEAeBTNX5n9VvCbD1/KQAc
	MkM/FpVGmFEJ5u88t2bgIeRP+waFswXX5GYj4sSwmqLS91/kJrz6fZcrmGjk0p++NAElsvTYd8j
	pLv+fTyCSqO8wWGTwoMd1KGxxCahanXDb0FIT1eolIrfp7HsAjkkdGLlWfaDgDjkC0AG0OXBQiZ
	/zP8wGP4zBbqL5kT5Z6ueqqRIG6eZMoSdKiEgFhvEBqpz4t5dkMLm7ovylCtR6fGXRWHiyNUvaG
	XXY+O5Ws4TrxTPsT+XSWnrCv9Fjm2GlW/vA=
X-Received: by 2002:a17:90b:3a91:b0:329:f535:6e48 with SMTP id 98e67ed59e1d1-33b513a1f54mr36206175a91.36.1760501001447;
        Tue, 14 Oct 2025 21:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeB00/IAiV2A5VWR2GpIwimPRs4bIDRky9OnqOTaOwRvemdHPVbmX+QZZKvd8185HR/P1l4A==
X-Received: by 2002:a17:90b:3a91:b0:329:f535:6e48 with SMTP id 98e67ed59e1d1-33b513a1f54mr36206138a91.36.1760501001077;
        Tue, 14 Oct 2025 21:03:21 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b978607cfsm608006a91.9.2025.10.14.21.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:03:20 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH rust-next v2 1/3] rust: fs: add pos/pos_mut methods for LocalFile struct
Date: Wed, 15 Oct 2025 13:02:41 +0900
Message-ID: <20251015040246.151141-2-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015040246.151141-1-ryasuoka@redhat.com>
References: <20251015040246.151141-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pos() and pos_mut() methods to get and set a file position.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 rust/kernel/fs/file.rs | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index cf06e73a6da0..bda6cc540dfe 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -283,6 +283,23 @@ pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a LocalFile {
         unsafe { &*ptr.cast() }
     }
 
+    /// Create a mutable reference to a [`LocalFile`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The caller must ensure that `ptr` points at a valid file and that the file's refcount is
+    ///   positive for the duration of `'a`.
+    /// * The caller must ensure that if there is an active call to `fdget_pos` that did not take
+    ///   the `f_pos_lock` mutex, then that call is on the current thread.
+    #[inline]
+    pub unsafe fn from_raw_file_mut<'a>(ptr: *mut bindings::file) -> &'a mut LocalFile {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of `'a`. The cast is okay because `LocalFile` is `repr(transparent)`.
+        //
+        // INVARIANT: The caller guarantees that there are no problematic `fdget_pos` calls.
+        unsafe { &mut *ptr.cast() }
+    }
+
     /// Assume that there are no active `fdget_pos` calls that prevent us from sharing this file.
     ///
     /// This makes it safe to transfer this file to other threads. No checks are performed, and
@@ -337,6 +354,20 @@ pub fn flags(&self) -> u32 {
         // FIXME(read_once): Replace with `read_once` when available on the Rust side.
         unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
     }
+
+    /// Get the current `f_pos` with the file.
+    #[inline]
+    pub fn pos(&self) -> i64 {
+        // SAFETY: The `f_pos` is valid while `LocalFile` is valid
+        unsafe { (*self.as_ptr()).f_pos }
+    }
+
+    /// Get a mutable reference to the `f_pos`.
+    #[inline]
+    pub fn pos_mut(&mut self) -> &mut i64 {
+        // SAFETY: The `f_pos` is valid while `LocalFile` is valid
+        unsafe { &mut (*self.as_ptr()).f_pos }
+    }
 }
 
 impl File {
@@ -356,6 +387,23 @@ pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a File {
         // INVARIANT: The caller guarantees that there are no problematic `fdget_pos` calls.
         unsafe { &*ptr.cast() }
     }
+
+    /// Creates a mutable reference to a [`File`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The caller must ensure that `ptr` points at a valid file and that the file's refcount is
+    ///   positive for the duration of `'a`.
+    /// * The caller must ensure that if there are active `fdget_pos` calls on this file, then they
+    ///   took the `f_pos_lock` mutex.
+    #[inline]
+    pub unsafe fn from_raw_file_mut<'a>(ptr: *mut bindings::file) -> &'a mut File {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of `'a`. The cast is okay because `File` is `repr(transparent)`.
+        //
+        // INVARIANT: The caller guarantees that there are no problematic `fdget_pos` calls.
+        unsafe { &mut *ptr.cast() }
+    }
 }
 
 // Make LocalFile methods available on File.
@@ -372,6 +420,19 @@ fn deref(&self) -> &LocalFile {
     }
 }
 
+// Make LocalFile methods available on File.
+impl core::ops::DerefMut for File {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The caller provides a `&File`, and since it is a reference, it must point at a
+        // valid file for the desired duration.
+        //
+        // By the type invariants, there are no `fdget_pos` calls that did not take the
+        // `f_pos_lock` mutex.
+        unsafe { LocalFile::from_raw_file_mut(core::ptr::from_mut(self).cast()) }
+    }
+}
+
 /// A file descriptor reservation.
 ///
 /// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
-- 
2.51.0


