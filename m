Return-Path: <linux-fsdevel+bounces-30180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A92987627
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B362837E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508AB14D2B9;
	Thu, 26 Sep 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEXTgxq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0D156228
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362783; cv=none; b=QZgpsNnPp3t4Xk7zdw9/FtllHkvQNcDjWi04YFF8JEiLkgciFVqqx5UailwhmRbBjOflgFsMUgwmAuwFfh8Jry20Z19O+2EEC7HyiwThP4+sf50F5b0CMAjx27TXnV1kvaqpuc6tgs9oKXXOfk7X2iyZ50G+P8Q++QMjn54UEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362783; c=relaxed/simple;
	bh=Eg4ozalPfp9Dq+G3RNTBq09+vqD1HxtxrCxKQ7R9a6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NHOO6z/y1Y5lhwwaIC10R6NYSSlfW9fyCSujXfjD08Cz2phb3uEXRTmg3iPr7wv75KDWU24zvhzj2+WEIY7iSs/1slU1RXyBvgrRrpu7/cI+WTtPBqtY7811ksxviMHSFbBm8JrOCR55S1wSikQDdwWADDEetMiJfFG4/mHaDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEXTgxq4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3e062dbeeso13622187b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727362780; x=1727967580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeV1KHW77gl2ixtTigXOOKfMDho4UiCgTf2SV63cy/Q=;
        b=OEXTgxq4sKMvvAy67Dh8YjizLVbOJ5k1gUFzDMBwx5RpDYP1FqjJaWKv36U5shCBUv
         3JiETjDfPDsFX16kB6kUOUD4xdxOXHnyXyXMk/3friP6Ufr3QC1+idjlyqRaJit6UV2W
         jsaBfF0L+wfZcUuHRBe7M35hGgUAeqpnvTdW8A4tG7eSpfn+hvIn7AMTwPjS6gTVdzEO
         qi8pybyfCUeS7KWd1Iw2X+CEV6l/pJlvxIzsmc5+qKxBgibG3x14H6vmYTcb0+2+Bhxk
         MyNKd04/gVhxGvY7xggMbANzGtHwbVhqu1uTgDHUIz3Nzlw8QeqVA411lrkwAGJG15mu
         Q4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362780; x=1727967580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeV1KHW77gl2ixtTigXOOKfMDho4UiCgTf2SV63cy/Q=;
        b=dtEDWGW4tewvyyLgna072kAdjJRjavoLJcPAr5FK9uSuIps1ZOJQr7LIZo7inmD/0y
         sd5mNoBPGd0TMdHvPWOzWGDSgdQWl9NZwZOmKCPg/ZT/+y0pdmwcqxxKT+yu+2oV1V2H
         mRL03Q6nI+edHij76IkQJqvwwtDDlEL6ShREIAnZdzJYykU6AFxj+blr7/OhjEFH5Vqi
         zMWDbp0WFOZ8b1JkmFlN7I5296tS92vUTzt96/oABodkoaYfAtZ4f9HGZp/UYdcNNQs+
         quDZCuoDzyY3VnSR+k1sK8UE+QTyMPoDftQkGlPWvI4YuA/AJYfKulGbY8XEb2AKJfcy
         e7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVyEyGlcZ41+D0WvXCuIcreAiwxTAa2r1WnXkMjcPHmgsZPSGkFefFdzfxfWnAjs1thpeg6awlzi4mg0XAD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt37gJZAD+E60YHT3Mx4plgttA90OB7Qihq1yDqslHDRzxEDku
	KELNr9wtjn55vIMQSd1zpXVCT9UenpbL/YMeeuUHDyx3hfdddWQTCKQpRAuvA7mJnZT4bXY5xno
	thYbdZshi4XVD8Q==
X-Google-Smtp-Source: AGHT+IFXzXcQGkkg6miI4lRR5aDTs+z8nxuijS5MIlaFFi6hc9IleFgTZI1r0Pf/fM7aCAkUF4CI+a3V4yd3vaM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:3405:b0:6d9:d865:46c7 with SMTP
 id 00721157ae682-6e22eddb5d4mr290447b3.2.1727362780176; Thu, 26 Sep 2024
 07:59:40 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:58:56 +0000
In-Reply-To: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Eg4ozalPfp9Dq+G3RNTBq09+vqD1HxtxrCxKQ7R9a6k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm9XbTowpCdvo26oRjUrDd2SCJfZSsqtQXyf1e6
 aNmADjn0mqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvV20wAKCRAEWL7uWMY5
 RrmiEACSG2C7yeB3qHx86arzRAzmg9UQ6670GsCB4hPpsLd5PJPnl8TwUULgOTX7eXcKEhOPuUp
 uThZFejvJD+T3SSZMsh9OwbIZEkBbGm/HOO6MCaEjmK+v4+d1Mn8NRT2rfwifU2juxsubMRN5H8
 RBhCu+w9oPkFw9RRw5PKE9KQdO8h+zuOSf90pXOYDVHQ6jiwM3tdtrS7gjhD44eq0wwCVTzaVBL
 cS7c9owyotQ7SqY87HJQA5cp85DO+0ann56qTE+2PXZVc/SaQDuMdzwmKypdbBBHfbACD4ICP9L
 uuCq75U8+DlZr9Dx1xCatEybfz8Q2TWQBrflphbJtMs0NhHL1cWoYwDBXNgiWd8WBORQIeLZHdb
 wnVGRgbOAu2+OIt2FXjjmyMEse63ZGVyoYFOqm8oHQL1Dg0/sNw9cK1XCOn1iaJpyCcud9F67dV
 uMRCacwi/HN/Rs4CqTfSLamBTppC1MWSvkaXnDpY5jI5yNNiWpXrg1etF+AcPDg9Syh/czy+Aoq
 x0cP0IlNTyTn0dLbJybbXPUtVgMUOlNd0jj/B/sFlEPymXHCT0YdkBzPeDhFdTRXfrf8S0uZLO7
 9A2JGCx3J0lAysqYfW36wJhlrZwLpi6jSzGXuiyPWmpofby1KBRRuR4DngYqVXhfsYrJdewTB4E ArpTcxpmLl4b9JA==
X-Mailer: b4 0.13.0
Message-ID: <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com>
Subject: [PATCH 2/3] rust: file: add f_pos and set_f_pos
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add accessors for the file position. Most of the time, you should not
use these methods directly, and you should instead use a guard for the
file position to prove that you hold the fpos lock. However, under
limited circumstances, files are allowed to choose a different locking
strategy for their file position. These accessors can be used to handle
that case.

For now, these accessors are the only way to access the file position
within the llseek and read_iter callbacks.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/fs/file.rs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index e03dbe14d62a..c896a3b1d182 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -333,6 +333,26 @@ pub fn flags(&self) -> u32 {
         // FIXME(read_once): Replace with `read_once` when available on the Rust side.
         unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
     }
+
+    /// Read the file position.
+    ///
+    /// # Safety
+    ///
+    /// You must hold the fpos lock or otherwise ensure that no data race will happen.
+    #[inline]
+    pub unsafe fn f_pos(&self) -> i64 {
+        unsafe { (*self.as_ptr()).f_pos }
+    }
+
+    /// Set the file position.
+    ///
+    /// # Safety
+    ///
+    /// You must hold the fpos lock or otherwise ensure that no data race will happen.
+    #[inline]
+    pub unsafe fn set_f_pos(&self, value: i64) {
+        unsafe { (*self.as_ptr()).f_pos = value };
+    }
 }
 
 impl File {

-- 
2.46.0.792.g87dc391469-goog


