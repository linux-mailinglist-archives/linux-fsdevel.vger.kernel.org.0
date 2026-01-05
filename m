Return-Path: <linux-fsdevel+bounces-72394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D68CF418E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 15:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3691B3012CF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8A33C18A;
	Mon,  5 Jan 2026 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="madKqejx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56462FF178
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623114; cv=none; b=Y/6lLCTFzYYiI4UzKC9OXVli9bwL6TfswSwtb0x9ZJuiRBEtFPD2qwOwPPJ2T+BSw/3zGGxgO0WyKvM2lhuOveWxJqjlvGSPjg0MIxoliB087TqtFgdeJmp68ygpviyAlQJQTR8puPcCsY0bjrQ9EbiDTJbkU6Ckb/eHXgIycxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623114; c=relaxed/simple;
	bh=iAyNgqAGHR3mKYOUMqZv13SqTg4Z3lt2LR74wA+0qy8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jb6iwIngcRf6QaPjkJcK/WDrG1Bzo7Xp+tgE226IyHVlc2qTJtSif+jDq1m9vydrBMcWc8+5bZOu9oYbhhUNC/s9rwS1/Nuz6PomXTajqhBROrV9lLqYkPfyCqyMi/oepLKbwRlqCKludqhfSx+Mf6DiXXdnQX55wdGknendDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=madKqejx; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so142964005e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 06:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767623110; x=1768227910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SrnIFX9Zo+MxYL8oaw6CZU2TB2DZAwdhXacUrsYzCDk=;
        b=madKqejxhuegXmO2Q8T6IEzNkVSUS6MMeqlMoBPdoW+OOTct+BtByTeqsUWiGiHTGR
         Wq2BxNiVOP8qUhWjXWHQyEaUhA3ROjroeUxR3+qHuDK3Mngg6p8Oc+Ec8bj2vbG6Khej
         yurC+3nUExTa3oReLQcrg/6G+OlMtE3JiGPrAuxs2o0p7H1WXNh8V32AyY3fqmosmGKL
         hwoUqx84r+3zJtvAaOqjA1UXl4V6kS9uG1IxXSc+xno63G/YgyGvxZlQj/xGSqCWNJCQ
         zV+xPq1BDtD6PasZ1aQN8jxPE/eSXeB4eppureJVIMIZcgrtZjy8m5eEQ2/74Ar5zfhG
         88Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767623110; x=1768227910;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrnIFX9Zo+MxYL8oaw6CZU2TB2DZAwdhXacUrsYzCDk=;
        b=nEC64LfiPpsLag+wjueyzq4A2hlSVThFEhVZnx/XKwa4BXqtgbJ+afW6NNt1BHRS7x
         5Rl7QQR2gqOCNmpz4o6bdr/ZGKyrsm9Joa0lXGiBemsTSVhLaoSvT2IEW3rHwLq1EXu2
         ipMG3MC8LoGUJaULBMUbRTqw+Tetw6WKCG6JDQZcEVcwzeeWF/A/l+B9rHzYRli03+Q/
         thISkqithXDbU3DlawlK46Su6hHNNutPVIJhGpfbNPoY8521zsGWOHrIbKVTc7CiVd9q
         PzpQ4FEQ1YHvGHaSuCE5veaLOlnhaHLzhKJxIDWreKIHjplsm6SvnvlH7hkdSXJOmOLs
         M5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXW6g1e/jCXzXZ6tp4H47IJikQ6cjUenQWDT6U7OWrIkZPTOIIZZDrhFbwUCWrzAaNtmT8O+msQJK/91jfK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gHLnYZOOaJDxcaYOCSQYi2p78etKekzdLUMD6PwjFsizPQaU
	5Z7zlfdlUKm1UOKXjCmWn8h8CwEwIl8ax4Hp3tAdjtpb2MdounlRXyeqE2h5+Jqxb4wQsqkWyrX
	AayitxTltQv3KAn0rBg==
X-Google-Smtp-Source: AGHT+IGImOr2hD8TqDen33xf9P2W2HhIzAj6VITYdudbzagsR5ihVGYXo/8iCbzleBw0SvzZGxmArAt5NFrM2Jw=
X-Received: from wmgp3.prod.google.com ([2002:a05:600c:2043:b0:477:98de:d8aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e90:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47d1959440dmr653250495e9.34.1767623110293;
 Mon, 05 Jan 2026 06:25:10 -0800 (PST)
Date: Mon, 05 Jan 2026 14:25:03 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAL7JW2kC/x2MQQqAIBAAvxJ7TrClhPpKRIRttVAqq0Qg/T3pO
 DAzGSIJU4ShyiB0c2TvCjR1BfZY3E6K18KAGo1udKeEVtrYkbL+CkuaQ5KZvU2nItNufWsQsbN Q+iBFfP73OL3vBz0jO5RrAAAA
X-Change-Id: 20260105-redefine-compat_ptr_ioctl-e64f9462225c
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=iAyNgqAGHR3mKYOUMqZv13SqTg4Z3lt2LR74wA+0qy8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpW8nAbhHIEzEIHBpKSIsFslJ6mFkpu4x4QKg8Y
 i30jirHqIKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVvJwAAKCRAEWL7uWMY5
 Rv2JEACx4zFq5dYTXn9oDxs357zNbU6IUJ3CbydvC/4U0NPeOMhJWt6TvheMx59aFe/UvDICOFh
 faXrrc2iZK2N8EDT/nGg5Dg62wCMkg/+R196tPhuiurwmp6U7+LvOG9fuX1K/IZhReMI36wMwrF
 14T1Y15JTvIbQ855jH+w/cNaKJtoZ08vogHTNUKf7dAatNFneyD2ami4Do4T8M3HblZqM1ccFOx
 /TrsOJMuWTLY+JjTJduUmvmdCvVZlaWfLJzfdNREsFjiowAp2FFMlmCw1yehACMR8/s/aKy5/JX
 TXgp7MeJzAOasSXbMW8cVHt5VN1QOWunbdgRWmWT/V5o+pp4bcQAFQjuInpoNm6oDDIf3oNk2JL
 R7P55Duq4XnWLOuBasC6mQXTtrnS7YQ17+SjTP/uHNk2WclFXfTEIXHXSGNvUPw/iw6VmZUAHv5
 9XK07asNELVteETDgebFwQFWmENyvqzUWYPkrUO5pTvUkbJRgbFmMoD3BCl/mhDH3pSjkqoarMl
 luo805FfjgTPHfolk0/6Ut3ZpxqFgO93mj4m/XYP4X22/QKw+I2VvgPa+s61FdTS2C/cAO9BjmR
 FMNmTEUmOc4ha1W4oTW7zjGVSXHQji4wjqjrvSZ1Iko5xbd7dGoIFAP64q7DZUVifcOr+IyNEXk 19jM4sdVY/Jl3lQ==
X-Mailer: b4 0.14.2
Message-ID: <20260105-redefine-compat_ptr_ioctl-v1-1-25edb3d91acc@google.com>
Subject: [PATCH] rust: redefine `bindings::compat_ptr_ioctl` in Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

There is currently an inconsistency between C and Rust, which is that
when Rust requires cfg(CONFIG_COMPAT) on compat_ioctl when using the
compat_ptr_ioctl symbol because '#define compat_ptr_ioctl NULL' does not
get translated to anything by bindgen.

But it's not *just* a matter of translating the '#define' into Rust when
CONFIG_COMPAT=n. This is because when CONFIG_COMPAT=y, the type of
compat_ptr_ioctl is a non-nullable function pointer, and to seamlessly
use it regardless of the config, we need a nullable function pointer.

I think it's important to do something about this; I've seen the mistake
of accidentally forgetting '#[cfg(CONFIG_COMPAT)]' when compat_ptr_ioctl
is used multiple times now.

This explicitly declares 'bindings::compat_ptr_ioctl' as an Option that
is always defined but might be None. This matches C, but isn't ideal:
it modifies the bindings crate. But I'm not sure if there's a better way
to do it. If we just redefine in kernel/, then people may still use the
one in bindings::, since that is where you would normally find it. I am
open to suggestions.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/rust_binder_main.rs |  3 +--
 rust/bindings/lib.rs                       | 13 +++++++++++++
 rust/kernel/miscdevice.rs                  |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index d84c3c360be0ee79e4dab22d613bc927a70895a7..30e4517f90a3c5c2cf83c91530a6dfcca7316bd6 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -322,8 +322,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
         owner: THIS_MODULE.as_ptr(),
         poll: Some(rust_binder_poll),
         unlocked_ioctl: Some(rust_binder_ioctl),
-        #[cfg(CONFIG_COMPAT)]
-        compat_ioctl: Some(bindings::compat_ptr_ioctl),
+        compat_ioctl: bindings::compat_ptr_ioctl,
         mmap: Some(rust_binder_mmap),
         open: Some(rust_binder_open),
         release: Some(rust_binder_release),
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 0c57cf9b4004f176997c59ecc58a9a9ac76163d9..19f57c5b2fa2a343c4250063e9d5ce1067e6b6ff 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -67,3 +67,16 @@ mod bindings_helper {
 }
 
 pub use bindings_raw::*;
+
+pub const compat_ptr_ioctl: Option<
+    unsafe extern "C" fn(*mut file, ffi::c_uint, ffi::c_ulong) -> ffi::c_long,
+> = {
+    #[cfg(CONFIG_COMPAT)]
+    {
+        Some(bindings_raw::compat_ptr_ioctl)
+    }
+    #[cfg(not(CONFIG_COMPAT))]
+    {
+        None
+    }
+};
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index ba64c8a858f0d74ae54789d1f16a39479fd54b96..c3c2052c92069f6e64b7bb68d6d888c6aca01373 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -410,7 +410,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         compat_ioctl: if T::HAS_COMPAT_IOCTL {
             Some(Self::compat_ioctl)
         } else if T::HAS_IOCTL {
-            Some(bindings::compat_ptr_ioctl)
+            bindings::compat_ptr_ioctl
         } else {
             None
         },

---
base-commit: 8314d2c28d3369bc879af8e848f810292b16d0af
change-id: 20260105-redefine-compat_ptr_ioctl-e64f9462225c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


