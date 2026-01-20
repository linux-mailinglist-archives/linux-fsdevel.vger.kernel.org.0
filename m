Return-Path: <linux-fsdevel+bounces-74649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH6mFlx+cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:21:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758F52BD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CAA23ECE48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE60438FE1;
	Tue, 20 Jan 2026 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr2DLEgk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7443637E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917763; cv=none; b=MZbQG91ElUezc21Dd8/FL3HLawb9VWrQnGKIPP0aa+sH2pahFKqYpP7zr91kp2D4SgJPhKqMyzf+V2QvtUE9ilXdGW2gjEAGxvjeeFhFkslCjr7ztAys5SEIUa67nSjQLQFbGOwoL8EYU3/G0bv173hMdRFrBfv4acYjrq9P8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917763; c=relaxed/simple;
	bh=xPu9fBuMUhOPCePDz8GtSrWF1C+vSgEjvzKG6Lg96aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeRrPQJKvfqSUoYU+J615/zka2/q7kA7q2UlhOTJ+ySrjcgfp8ZREMpNhyIkik1N8dvQQvyALbAu+6prM0iDcZ+mSe/F/vpkVo4R6dqYcr82juNeGfY24x+mFVcireDU433smLjfUcEixNKd8Pur3fVUs8zBxz7neuWoYJge7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr2DLEgk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso34252535ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768917761; x=1769522561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFD71p8fWspU3BL1+X8LZN5zYONG2aaCKcJtMsQB+Vo=;
        b=cr2DLEgk7MTf3awz95Cg7680K1kjdZyZtChH5IuSAjfiSBoSTZxE7ESLhQyfyYSTb9
         PTHCDB0dycyISwyJnnqrsEFo09/6qjEnHbEdcH9+0JiGaNzqqrzJ8Pc/A8GvkB+uLW84
         sswgGbKxyZC09fQMDRiHPOXY+XnqXxOrFXLFay8DiCR/AIgGcbPMsPVbZQaUD/mFwzaW
         JrqFeO2WJpPT9D0bIqBDCF9zBpbdTh3kzYARvR6XFvdFRY5uXem/05nWBxa/tHbwtRwA
         iXA66dSGeNUGBeg0W9LNSa6xSd61deVupZ1cFcGYLT5i1JQb1PPHOobKh43+8OQ/5CMZ
         ezhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917761; x=1769522561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFD71p8fWspU3BL1+X8LZN5zYONG2aaCKcJtMsQB+Vo=;
        b=GNl83i2o9khbTJ+97z0yRNhh1lrwk0LARIHswN6c6Ddf2Js2Z3HWtV34wcPPYHNFX4
         6WFIoS1FmC1PBHVds6DVeLDaUPBFRs8LXblX/tzQiPM9pedNBCsRWTh4dc47HL82WU9d
         3iiUge5ptSq9PZuXqDlTGuivHNjgxHsSbqeEEZLpWqYDLGn0yxsrHndKUXtQ1HRvaN3d
         Jo52ylD2XB4gCE6s9CX0uchhbzucNMPkeStjEwgUxDgjblZt476FaqdL3b53qL4qT6rh
         h9aUVTP4rECmL2uDEiQBeqEqaWNr0uE4D9ugzO7oa+dZrCpt6DZLcjF55sLSnkFI4amq
         igLw==
X-Forwarded-Encrypted: i=1; AJvYcCWYRX0OYIET56kNYlfut9/E3sseXin+L6xFBwpbeU2CEASwN5M1Qk94DIMA4qGeHlmWzkujSlLOlnZavTkV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkd4LfdXPnsw3KSpn28v1DyY3cIjW6e8z4a+jzK8KtdNr3TKKG
	ReIlOc5PwnVqnNUboAKxfpxaxD+B90R3zwDUSWJjn5klYcwXf/MdKbYq
X-Gm-Gg: AZuq6aKx3a+XxmVYgKRrOy4O89Y8t0ENg1jdAUDirmyrDkQ9NkUzRk38hxus3nTPhcq
	ZOnMOLKtRmrMvJB7W2J3ncwiFMlu14cjHH8qchHLi22eR5JZEQXZK224HvTr2KioFI53qIXaKZ5
	Rn8DIjxMhS0oyDyZw1gDAF4poUGsgJb0PXDKQ0bGlfnFEGzF3rLLFqodBmEUh0jVsW5S7omVn+S
	2dqnxsYrfg7Sd6qn/BK66JHk9l9pf/OWfyZFpbahvWVQSSx4mofJlv3Iy9i7KNe+jRM8dZ6So/I
	AjZcb48y2jYayJ9VLT6LgYbcVkqbDaoX5qp2Z73Bqm19x9kXEDwt1B3Yp0/4fK4wy6mHLLyoHpJ
	xC0grezuHuA/TBKiKOYUlkiaRwtoGp4rC0bONoj/QOhrKaUc6Vpy/joP70Ch3mgMDEJUYUqDLof
	Sk64lHYUR7tfe/V7i32Kddj2uFKzEIPRRf7jfGeNbvdF356nuscGgqSM3Ry8bX3NU=
X-Received: by 2002:a17:903:38cf:b0:2a3:628d:dbea with SMTP id d9443c01a7336-2a76a0a673fmr16827585ad.24.1768917760594;
        Tue, 20 Jan 2026 06:02:40 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:1803:3ab0::2e2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a773d4e5basm17649535ad.94.2026.01.20.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:02:39 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: [PATCH] rust: replace `kernel::c_str!` with C-Strings in seq_file and device
Date: Tue, 20 Jan 2026 06:02:35 -0800
Message-ID: <20260120140235.126919-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-74649-lists,linux-fsdevel=lfdr.de];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[fosterryanr@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4758F52BD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

This patch updates seq_file and device modules to use the native
C-string literal syntax (c"...") instead of the kernel::c_str! macro.

Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
---
 rust/kernel/device.rs   | 5 +----
 rust/kernel/seq_file.rs | 4 ++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 71b200df0f40..1c3d1d962d15 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -12,9 +12,6 @@
 };
 use core::{any::TypeId, marker::PhantomData, ptr};
 
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
-
 pub mod property;
 
 // Assert that we can `read()` / `write()` a `TypeId` instance from / into `struct driver_type`.
@@ -462,7 +459,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             bindings::_dev_printk(
                 klevel.as_ptr().cast::<crate::ffi::c_char>(),
                 self.as_raw(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>(),
             )
         };
diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 855e533813a6..518265558d66 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         unsafe {
             bindings::seq_printf(
                 self.inner.get(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
             );
         }
-- 
2.52.0


