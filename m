Return-Path: <linux-fsdevel+bounces-64196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F30E7BDC65C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 06:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7992118A8222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 04:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF42FDC40;
	Wed, 15 Oct 2025 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmgtgL69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDAC2F60CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501011; cv=none; b=rbPsq9MVyaQL2JTHjrMX1ckQZx+V6te9ImtrpzyAwNJSoO4Ym27c0Qhzh4AJp78lgNcDIEqtmw02jXyl5wZHQ4E7kYbqdpFfFp3QBwG57Z768aUcJennm8x+KRCKtfpN0fbSPuzVo2VJJaXxrCetEswqH9zTmul6eM15fNlCDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501011; c=relaxed/simple;
	bh=N/Hg0cUpSuxjkf/64ySl79HzvAfeUdFUvUkHgBa06ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeO1VajGsGlyZr9AG0zMy4pnaXoGLTRpW4bJXdoZcbU2nAaA+SpWjI3NMLWRN2vz79mB3kQn5VEJiu//h1qsO5RY57JITyJnaleBKlzwEL8nzlBEJYB5RelMwNh0SBHyySxxumwzjOujRQHjEMFw7w2yxcLbSUJh+x2tIzJ8gNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmgtgL69; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760501008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cTJtwMXIeLnmZnv2DTXzRty+qoslZ2OR6cifyBicWw=;
	b=PmgtgL69gmyp6LxvqgrZ2u3Un3oYOUNrvD+JndCL7RCGXhlGzr2l5obyYZM1yRVLDiXwlv
	4VkY0Czg9T0TAE0vVtj/NK+I73QkFWG0tITD3pp+wRJK5bQKywtoZyHfSqCPfATlevRips
	C5fmGeu+x/i+ki2ms8JSxBXAuhNdPR8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-zEWmemEmNAWKIRjGPkb0kQ-1; Wed, 15 Oct 2025 00:03:26 -0400
X-MC-Unique: zEWmemEmNAWKIRjGPkb0kQ-1
X-Mimecast-MFC-AGG-ID: zEWmemEmNAWKIRjGPkb0kQ_1760501006
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-339ee7532b9so27072997a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 21:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501006; x=1761105806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cTJtwMXIeLnmZnv2DTXzRty+qoslZ2OR6cifyBicWw=;
        b=hsQqQQwY0+EC5WlJyrTHobL+S/U8XsQE4bJTt+Ly2PNeLHaTh9mdjqBvnBw8TikeVI
         PvAgihMiudeqz0CZr74vjoxrlYUT+LfTtQHOQcq4IGq6nypcib4SdRTmWYzxkTd/gnqb
         9K0MYXY/dbZ1CdFISCeAvoXwllp5Vd+VJsaUHpYbfrWCVbI/kSyhukoKzmBhZN+7WKqE
         NN2TlqHJvTnPUraHv3XEGzoW8yVJP/2zBqRYva6ezJOgEBhYiaY2h2+AB6EkQEIiP3rl
         KrQhYQjvuY6EXwOqlr6KXlKirfgVEPikBJ7VsHtocaqzejgWWr+oqbZhIVPaghmmHm47
         ep0g==
X-Forwarded-Encrypted: i=1; AJvYcCWF8VWo1YCAdYJFSxeTrRo5D7Nm1aPYqMJr47JhfyUflinP1X3ud/NeLVhWEIbQQVM6U0Sg74xc0vOwF4kA@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnNo4IfLGqCo8Xcncsrwo9nFrXBUYypqZnEI9KZvpW60r6IwJ
	eL8vqxKRUvfopgvmwhXp5yoXgRAbWFfW6xT7v6uTBV6xc5AoMoevFVsikrwEiXI7FvUnsPcpglo
	CVQj4oN1Yi5JmwLlPKWMAD3xtfoeP7y/e0dXhZc9ZumCqlFL7oO2UhEb6tHwb+y16Ibs=
X-Gm-Gg: ASbGncvjI8V9crEou8oWY0B/iX5AcXQwUS4mL1iHvRgel/aqrytiX85bD48MnnBeG7Q
	ruZdrGbAx5uOnDkc1izeaWaOF+5XE8KwlPROjojXoxukOTiKJxyUWGx47zI/fEimkL/FDPJurnh
	t6RIldQXawVwrP3FaAkjCIZwX1oM+7wI67YZRjO9DVVtgLc5wpCjfkuyTzBOolzK+Io2hPr+OkK
	sDkyMu+WlDPzzm9zXDJ9esa7w8svGKXQOH+bwHukHXIoaXht6TsRxSGEy2b8WaLzqM+IZ5aQcbJ
	zDOO73atkA3CX4H1yA1mH2Pd1sMzFB83n/0=
X-Received: by 2002:a17:90b:33cc:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-33b51118ee0mr34810901a91.13.1760501005676;
        Tue, 14 Oct 2025 21:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRzf7FvM8OpEXrg7e1JvlWOpwl6hxFANdBMkZkYCR63zSreZUiUYv4PdbI0oENdYzK01tTDw==
X-Received: by 2002:a17:90b:33cc:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-33b51118ee0mr34810857a91.13.1760501005275;
        Tue, 14 Oct 2025 21:03:25 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b978607cfsm608006a91.9.2025.10.14.21.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:03:24 -0700 (PDT)
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
Subject: [PATCH rust-next v2 2/3] rust: miscdevice: add llseek support
Date: Wed, 15 Oct 2025 13:02:42 +0900
Message-ID: <20251015040246.151141-3-ryasuoka@redhat.com>
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

Add the ability to write a file_operations->llseek hook in Rust when
using the miscdevice abstraction.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 rust/kernel/miscdevice.rs | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index d698cddcb4a5..2efd0847cde1 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -126,6 +126,16 @@ fn release(device: Self::Ptr, _file: &File) {
         drop(device);
     }
 
+    /// Handler for llseek.
+    fn llseek(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &mut File,
+        _offset: i64,
+        _whence: i32,
+    ) -> Result<isize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Handle for mmap.
     ///
     /// This function is invoked when a user space process invokes the `mmap` system call on
@@ -296,6 +306,27 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         }
     }
 
+    /// # Safety
+    ///
+    /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
+    unsafe extern "C" fn llseek(file: *mut bindings::file, offset: i64, whence: c_int) -> i64 {
+        // SAFETY: The llseek call of a file can access the private data.
+        let private = unsafe { (*file).private_data };
+        // SAFETY: This is a Rust Miscdevice, so we call `into_foreign` in `open` and
+        // `from_foreign` in `release`, and `fops_llseek` is guaranteed to be called between those
+        // two operations.
+        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+        // SAFETY:
+        // * The file is valid for the duration of this call.
+        // * There is no active fdget_pos region on the file on this thread.
+        let file = unsafe { File::from_raw_file_mut(file) };
+
+        match T::llseek(device, file, offset, whence) {
+            Ok(res) => res as i64,
+            Err(err) => i64::from(err.to_errno()),
+        }
+    }
+
     /// # Safety
     ///
     /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
@@ -391,6 +422,11 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     const VTABLE: bindings::file_operations = bindings::file_operations {
         open: Some(Self::open),
         release: Some(Self::release),
+        llseek: if T::HAS_LLSEEK {
+            Some(Self::llseek)
+        } else {
+            None
+        },
         mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
         read_iter: if T::HAS_READ_ITER {
             Some(Self::read_iter)
-- 
2.51.0


