Return-Path: <linux-fsdevel+bounces-62748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325BB9FBD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08901C23BC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C262C11C5;
	Thu, 25 Sep 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+cODE8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7072C08CB
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808502; cv=none; b=gk3vMVTWWi7KFN8Wz22DlnN/U0zrmOSgjowFHf2sngQSkMdpx6QOTHNVPkudafkBWmoXhAhn9ww3Sb+gC4g8sKWheFdyxsfJXCLCFZdLYCBKpzvnCD6gq6lk0NvyVeLUliv8w2bmGr6j1lvReD8D75zGTVtrPBVY58y2+A9NqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808502; c=relaxed/simple;
	bh=tEhBaBJnhQFO++GmUh6w8m63Mr6JSvoXu3wOHmq14e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPZw0EEs1j86PQQ6DaEkQAtp/uAYmAm+dnH0s/0OXzFUeZuO3l/XxvjIQr3GD+5fUs1lZrF9kPB6vacTubQdtthm9Bg0mB0fenLCiHHdmQW2qAVwkvwlnHxcYfh1bbT5qm0C1FdsqWBuayVoY+ZMG2Mc7U8zR26kYpVWvJSDeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+cODE8g; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-7900f7f4ba9so7671946d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808499; x=1759413299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVSYVBz+/C/3yUXq0+Xlzki5tMQiQIQTN1ASo1OgvYI=;
        b=X+cODE8gpcyrA5FeL130iIoEK2/eyLm4jvpb2LplgGzizzyT5BcZY7Q/Mpmz1VoVAO
         SJDNVPXmqsZMqD+NQb6+JkQUviwFh1qkH7cIOFoc/xah7Yo19jSz0GZP9qoOZsyu1Uiw
         8I3n2Fdtzr+mEzFrqoXozNdzbpq0vZbBU8/dt3PWHB32wXAIVjoyNwZHTbWwu/btTQ6d
         GCWZSbQZUYgU0yFAydilmIm+tQaeSkBeoHNKiDCoNsFFKu/o0odqaC3VHhrMoapxRWAX
         H/90suxrOSxo151ZsRHOCms0ShPgsFRpVkfnIdH8MaE18pah7e+z3YhErUKAHvL0tQwe
         lT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808499; x=1759413299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVSYVBz+/C/3yUXq0+Xlzki5tMQiQIQTN1ASo1OgvYI=;
        b=GPvZ2wQ2DjLIgcoqRHzTt1d2nCUC1nE/4VdIZwMuyL7AEoInv28q+gfb3VlM1JVIeE
         Ug7wQy69E1BTN7iC+3EwZANp9KvHP1axkcPdVaLYZkywDUQFFsBwhdUvlvBeWjVd47Vj
         8tKS9XjiPciSyDKkl8EiVsOKN2l0cemRFdVaavYWs969gTZ+dIR8/SDZkhGp63oCu6eU
         220jq45INZ5L6PLfrglX5WzIlHv2trz0Bqwmaeojh521JezDE+Kgc2ZAqJgG29+nLSyi
         OZ6696oXAQoxd04IyQOLsdNG4z8unyXDKGqRKkY14BVN4bdf4XnyaKpRxSpJ1ZGjsogm
         3ymg==
X-Forwarded-Encrypted: i=1; AJvYcCUsN4HskMWXhnnp5Dm9Bl6kXo1Ho5WcTN641fZ3kAICnB+IV1HAmlHG8yNP2JOkm4cu+Q3nj6eaGC76ulXl@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfbwnrMFpO9f1YIKW1tffQV3XNXs6X24xip4COrwNLOMKGkol
	zoHGoE4Ijo0bXGmR+E3W/ay1npgh4SX2zpSMJuXmi27h1G/QwJsLt3s1
X-Gm-Gg: ASbGncsB6DLZtdtOzkfDaOnSv3kIjG0NCSzwBKVZGXj+LQbm6nmiE0Jfb/sVFHxLKPc
	2D1a7ljFT1nQualm0zvkMC7Uy8njeBas+tzeYOZt2LuKrHEmoSrr2rSZE/SsnhBoNIudIeOjvyg
	Y0QcfLxjkCnaGKIA7UIxf+tQKcEE5ppD4wqnU48h2DX2z+9N61tISaIyF/THt5RjdHgD4RcUNh2
	096AOurp/FljP7egs/Vo8Tk00nx7+bYGExjlMJGhQ2dlXDTNplhFquTrwxRbluwFV9NzRhf/hSI
	UO6z7317/rEBw7OwAZ/iUo2VQBvn8Idz7D9rPrN80PdkMUOA4Aatc56IwfOxefbV3u4jjBG3zLY
	jLU14Ft+5qZTnwBMNSPRBv31Bxfj7WM0s2CRCVUdQUwSGqUTLaMONL0okoLmgBt4i9MPsxwN73t
	7sb/NQ6CiKG/PC1+vMcAmFGMJiSZYQj2jvQ4VBGkHaFr62baF3ST2qA4WLCGZn7gQa9Ami
X-Google-Smtp-Source: AGHT+IEssEmLNZcem/aKdLWetF1Fs16YPcmtFsn6hozzBuZs4Wn/CLmfl+Df8wHKJRPpg5SfyGzrZA==
X-Received: by 2002:ad4:5deb:0:b0:78e:c5c7:1209 with SMTP id 6a1803df08f44-7fc3e015bc2mr57974806d6.56.1758808499295;
        Thu, 25 Sep 2025 06:54:59 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:55 -0400
Subject: [PATCH v2 07/19] rust: device: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-7-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=2297;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=tEhBaBJnhQFO++GmUh6w8m63Mr6JSvoXu3wOHmq14e0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFEkzUjb+lD/w38vqtw9O/htNaxJTX/sabnw4QloRojDdlHFE7uz1iz3IfwN44ls/ZjS7SJYOQu
 /SzXo2WM/nAo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/device.rs          | 4 +---
 rust/kernel/device/property.rs | 6 +++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index f3718da11871..242286162c8b 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -10,8 +10,6 @@
 };
 use core::{marker::PhantomData, ptr};
 
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
 use crate::str::CStrExt as _;
 
 pub mod property;
@@ -378,7 +376,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             bindings::_dev_printk(
                 klevel.as_ptr().cast::<crate::ffi::c_char>(),
                 self.as_raw(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>(),
             )
         };
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 3a332a8c53a9..3eb3f36d66d0 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -178,11 +178,11 @@ pub fn property_count_elem<T: PropertyInt>(&self, name: &CStr) -> Result<usize>
     /// # Examples
     ///
     /// ```
-    /// # use kernel::{c_str, device::{Device, property::FwNode}, str::CString};
+    /// # use kernel::{device::{Device, property::FwNode}, str::CString};
     /// fn examples(dev: &Device) -> Result {
     ///     let fwnode = dev.fwnode().ok_or(ENOENT)?;
-    ///     let b: u32 = fwnode.property_read(c_str!("some-number")).required_by(dev)?;
-    ///     if let Some(s) = fwnode.property_read::<CString>(c_str!("some-str")).optional() {
+    ///     let b: u32 = fwnode.property_read(c"some-number").required_by(dev)?;
+    ///     if let Some(s) = fwnode.property_read::<CString>(c"some-str").optional() {
     ///         // ...
     ///     }
     ///     Ok(())

-- 
2.51.0


