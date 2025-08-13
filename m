Return-Path: <linux-fsdevel+bounces-57768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E53BB24F4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADACD1C23FC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE40F309DC3;
	Wed, 13 Aug 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9dzMm+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039727FB2D;
	Wed, 13 Aug 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100811; cv=none; b=lrUmqiYQ75pjv3hJpChK0bL0tBm8ky12+dDnLcCB6vxaVoJ0SI5Ul6wlznTxu3ZNdpXma0r5V0GBmKyC6gqM2RR1CoUc1ut9sa2Glx8QQkkVJ6nS4S1Ny5nVGqgEtSO5cmVTG6JBS1YyMmPSP441erm/tdryTs9x2Zjyb8CVA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100811; c=relaxed/simple;
	bh=WdNf+rNMPJXvic2D/eUcktVEJW6IWJS1FHmVPimoUkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KqAeqAwjoycUfJVwNI5r/5OIJQTsBaLgqe3NFD4zn7cJK3Ps3PgjBfj/JsNkHzfIZgeT6DLaWEK/jppWyAi3rhhNHuwdq302Um5wf7f3oCQm2FVAwi8vaIUUyS/ELVMwuNzce+L5Ze+uPzVaLf4egiOTndbU7VL8bfKO7Xe/l/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9dzMm+N; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e849d7a28dso358070685a.2;
        Wed, 13 Aug 2025 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100808; x=1755705608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Cr4skJMToxR5ZDNlOWKhFrCtS61lHTyy++Kenuer/M=;
        b=C9dzMm+NRpOHymKHFTR111Pd5S4yUDJDCooRWbrtpcWy5PtYfQhOreoalt76Hu+iJy
         w/NCzf3m7vPLKsmfdfLfb23vkURklbaQr8XNBMIgjOXvKA0hHF/+x8N2NqkwCZvFv0d4
         0N4femz4SxVB+OYiAxPjBR5U96nq784m1kSH1A20ef93HIaX2v2BGKKTdgEDY3oS51d4
         l1c0Unqhinwa1IZD98FDzebVDKH4JwS50bS21D796+rC/thX5pSRw5RXdVuXgq5LczP1
         +6RxA5GkB32oyA5Aw0IHfkyd1a3D/7NeZjaSlIretuxA/v0fsB2Cs69vhizAg005q/Hx
         EKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100808; x=1755705608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Cr4skJMToxR5ZDNlOWKhFrCtS61lHTyy++Kenuer/M=;
        b=u8Hol2EynG8JP7wG9BkDuFEmEwaWQdoJEN2oghgqBWjUILs5E2A6OSFvzTwrh0oNpN
         hZTHekaTMXZjrdVWhe4+T7ARH3D/h4XboKrqQk9Y1o5mKDrNb/XVU1elcn6hjeb/Kz95
         NJma32JPa3bhI2lTKUcshLxTNKQlJ2DHlDWrB/WsSk6j9zsvrUpAEpqGP4rXViQ4cnc6
         p9MgykOWtTvxTriFzVKO6X1f+LRxQ4nGo5+La6xNRW9EUkA8abGbPAS8bSgQFMlTLh8b
         DCLrTInYWRsw4h9OPvf7TH0s4jBKm5l787miDNriSve24Pvz7A2LbFholRxpUaSdTKjb
         tTKA==
X-Forwarded-Encrypted: i=1; AJvYcCV9gI2JogykQPFTRbILlgDh/APqGiJRLQWV2yY7xpGKnyuHSrC5tRTWNXEB0phAhx9oszDQNo0yDtp8gE/5O0Wn@vger.kernel.org, AJvYcCVY/dX+dLDmoEsreu6iJ+924ZQ6BQJ1omuN4GQDlwhsRCsoUyKI7Rq4EQQchCuFWkkJTHBHrlvk@vger.kernel.org, AJvYcCVpdGn9cDpThofsCT7TYrDJVPsCd/I2VMF6Pj3efnwDJqBsbttHlPMU4aiA8SnkScMo8U6BXZMOi7qTKMbAcQ==@vger.kernel.org, AJvYcCW0JSdixd0I+46p09O36e1MWeTTAEr7P7LvawM3IL74IX0K1bZacFARcFHHAm8t3kicQUOEZWOBfwco@vger.kernel.org, AJvYcCW7SaZdYi9QkFx9uozsrWnpPEFvbXafvQKY+HyRCm5485aNFuRyDWHASnMilFFeFAIr1BpBCgwiK8HTFV3I@vger.kernel.org, AJvYcCWPuFYOi1TlSN+TZ4t6lPA6AV3/J1C7lMwrbVxCSQmlDM674XbIrfRDyUv0KrW7RuENhvhgLms1nklyGQ==@vger.kernel.org, AJvYcCXYx+57seYUuZKBYR4pcRggfrhAorPg+WMoyQ+YfmDX1aq8TMx6soQMpfmTa/hSDpnVhHGOcF471ZPCsS3QM50=@vger.kernel.org, AJvYcCXfZQw7RfUC3bKslfv+WY1ws4G3PRyKGCicv+DkLLSWbtsPrLAdoZ70ELP1TJepTQUJlRTNmQhdBYzq@vger.kernel.org
X-Gm-Message-State: AOJu0YyxhhkmeaVv8ei56igpB0uFxEv7jcybnV29Iiq6kC5pajoIHibj
	lp3Xp1Pw/dwzj7ciQEb9zXak9on+C4FscmRBZCGJOV/VBHi11lHybu3M
X-Gm-Gg: ASbGncsN6DozJINQ84yZxVYpTcQdebA1DCf7+guhQWzywzhgxQmSuu3X7Tp4fIpzk+s
	xnFce6ToJfZxmgxrwIXzUjvui8nnKQqcQPOZlQo8T2h+252GPCmdJmJE2LENGB+o9H0LxTUJ3gc
	H923wd8mabrxBv1LjMsqtuGp1fbygKNYrqveoZu68NlPQQk08li7gNWOfe7uRkMrp4Cic+r4sMS
	F3OqT1nnn0Q7MdRJ8b8Pq5nKcYda9EFpGpXBybtqYaXFJ9nNMGz1nML8ox5kwNLXAUXyrgM218T
	YruyfKQ2ndbarDVOZOWmsnHweJ8q44jjZC/8pvxUZ1ItI4JWfgCCO9HBlzU0MIfRH/TjOUvDxfx
	Joe1wDeU5j5N9B6hav5x1O6ZNIv+xpoYWb4hcuOjLMF1h5KIt7g7WaDjZAHoS4auo60c/GXo75T
	n1ItlO0W14uU6CsidskQ1stucyBPdQ
X-Google-Smtp-Source: AGHT+IF1FFwwiRWC7nkgIovb5g4WYGiTjLbCyBJ9eafSJnT0C/86p14jE6MKiVaAhyWdeKkN/zlclQ==
X-Received: by 2002:a05:620a:915f:b0:7e3:3894:113a with SMTP id af79cd13be357-7e86524c97cmr375547385a.16.1755100807777;
        Wed, 13 Aug 2025 09:00:07 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.09.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:00:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:24 -0400
Subject: [PATCH v2 14/19] rust: platform: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-14-00be80fc541b@gmail.com>
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
In-Reply-To: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100760; l=6208;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=WdNf+rNMPJXvic2D/eUcktVEJW6IWJS1FHmVPimoUkg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMbMNG4YU/3mJ20aJZ2/qg6/JFicKqrYK50E3yuOLMOfQVP1/s/6nskEMQz/DX+ne69Xn25k7GG
 4YI8+/fuWpgo=
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
 rust/kernel/platform.rs              |  6 +++---
 samples/rust/rust_driver_faux.rs     |  4 ++--
 samples/rust/rust_driver_platform.rs | 30 ++++++++++++++----------------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8f028c76f9fa..d1cc5cee1cf5 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -135,7 +135,7 @@ macro_rules! module_platform_driver {
 /// # Examples
 ///
 ///```
-/// # use kernel::{acpi, bindings, c_str, device::Core, of, platform};
+/// # use kernel::{acpi, bindings, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -144,7 +144,7 @@ macro_rules! module_platform_driver {
 ///     MODULE_OF_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
-///         (of::DeviceId::new(c_str!("test,device")), ())
+///         (of::DeviceId::new(c"test,device"), ())
 ///     ]
 /// );
 ///
@@ -153,7 +153,7 @@ macro_rules! module_platform_driver {
 ///     MODULE_ACPI_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
-///         (acpi::DeviceId::new(c_str!("LNUXBEEF")), ())
+///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
 ///     ]
 /// );
 ///
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index ecc9fd378cbd..23add3160693 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -2,7 +2,7 @@
 
 //! Rust faux device sample.
 
-use kernel::{c_str, faux, prelude::*, Module};
+use kernel::{faux, prelude::*, Module};
 
 module! {
     type: SampleModule,
@@ -20,7 +20,7 @@ impl Module for SampleModule {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
 
-        let reg = faux::Registration::new(c_str!("rust-faux-sample-device"), None)?;
+        let reg = faux::Registration::new(c"rust-faux-sample-device", None)?;
 
         dev_info!(reg.as_ref(), "Hello from faux device!\n");
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index ad08df0d73f0..b3fe45a43043 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -63,7 +63,7 @@
 //!
 
 use kernel::{
-    acpi, c_str,
+    acpi,
     device::{
         self,
         property::{FwNodeReferenceArgs, NArgs},
@@ -85,14 +85,14 @@ struct SampleDriver {
     OF_TABLE,
     MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
+    [(of::DeviceId::new(c"test,rust-device"), Info(42))]
 );
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
     MODULE_ACPI_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
-    [(acpi::DeviceId::new(c_str!("LNUXBEEF")), Info(0))]
+    [(acpi::DeviceId::new(c"LNUXBEEF"), Info(0))]
 );
 
 impl platform::Driver for SampleDriver {
@@ -126,49 +126,47 @@ impl SampleDriver {
     fn properties_parse(dev: &device::Device) -> Result {
         let fwnode = dev.fwnode().ok_or(ENOENT)?;
 
-        if let Ok(idx) =
-            fwnode.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
-        {
+        if let Ok(idx) = fwnode.property_match_string(c"compatible", c"test,rust-device") {
             dev_info!(dev, "matched compatible string idx = {}\n", idx);
         }
 
-        let name = c_str!("compatible");
+        let name = c"compatible";
         let prop = fwnode.property_read::<CString>(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
 
-        let name = c_str!("test,bool-prop");
-        let prop = fwnode.property_read_bool(c_str!("test,bool-prop"));
+        let name = c"test,bool-prop";
+        let prop = fwnode.property_read_bool(c"test,bool-prop");
         dev_info!(dev, "'{name}'='{prop}'\n");
 
-        if fwnode.property_present(c_str!("test,u32-prop")) {
+        if fwnode.property_present(c"test,u32-prop") {
             dev_info!(dev, "'test,u32-prop' is present\n");
         }
 
-        let name = c_str!("test,u32-optional-prop");
+        let name = c"test,u32-optional-prop";
         let prop = fwnode.property_read::<u32>(name).or(0x12);
         dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n");
 
         // A missing required property will print an error. Discard the error to
         // prevent properties_parse from failing in that case.
-        let name = c_str!("test,u32-required-prop");
+        let name = c"test,u32-required-prop";
         let _ = fwnode.property_read::<u32>(name).required_by(dev);
 
-        let name = c_str!("test,u32-prop");
+        let name = c"test,u32-prop";
         let prop: u32 = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:#x}'\n");
 
-        let name = c_str!("test,i16-array");
+        let name = c"test,i16-array";
         let prop: [i16; 4] = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
         let len = fwnode.property_count_elem::<u16>(name)?;
         dev_info!(dev, "'{name}' length is {len}\n");
 
-        let name = c_str!("test,i16-array");
+        let name = c"test,i16-array";
         let prop: KVec<i16> = fwnode.property_read_array_vec(name, 4)?.required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}' (KVec)\n");
 
         for child in fwnode.children() {
-            let name = c_str!("test,ref-arg");
+            let name = c"test,ref-arg";
             let nargs = NArgs::N(2);
             let prop: FwNodeReferenceArgs = child.property_get_reference_args(name, nargs, 0)?;
             dev_info!(dev, "'{name}'='{prop:?}'\n");

-- 
2.50.1


