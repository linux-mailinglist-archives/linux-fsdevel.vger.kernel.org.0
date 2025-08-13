Return-Path: <linux-fsdevel+bounces-57756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15510B24EC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363B11BC5CB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF2428469A;
	Wed, 13 Aug 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMO4ioGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A225B1DC;
	Wed, 13 Aug 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100770; cv=none; b=A5NhJUkWi7Ao+LavXK0YK8rP1XbA9aqKeCm66zr6aqKOLLbTVIgEwN+4Tj7XA3jSKM3W1XLh5XthDKck77ciWN26Mq7NXzYlu8c609lNF7sLSfwSgnpzed8dtw3zX61/quM5WTZBMNRoBeAp5uYuHVFsViXTv9wveKngGc67tJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100770; c=relaxed/simple;
	bh=ynC0QESeHbsdNeAVd2Vn1HA549NqluNx3Nnx6Y10jSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXLCJWNvwXahlO42rqugNfwKlQB71wy1sGYbllLBAU4ebFrUQwwacs3Wt89yrMiRgNHftRT7jDLKruY3kvvXD8EjvNhScX2NIvCQ673psvX1MVwk0Wam02OkMMudzFnzFtOAzBCI6Ifq6ESRzX5a4ACoBO8UIfWEf9KetccaLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMO4ioGI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109bcba7eso228861cf.2;
        Wed, 13 Aug 2025 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100768; x=1755705568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcLQFrhiOp/Rq3w2uCcr+Vuz3BcbpuBMoaDB6Viof4c=;
        b=bMO4ioGISGcmvAupov9PHxfRwhjM0inB3qyC+uxIxPgYZOP//M/isLYIb6J33JcquU
         Yc10NaKCf0YEYyLblScOXbU6d8q72/6IWuX/YZuM4Tjn579522gDVf6YnjVTubJjM+uG
         VMCyj4DH53SH4eId2igSIgqVXk8TIX0+lzZpOSQlUWHtAYoYLR8XXiwIKL8vcZkBSO6w
         wXZb+1Tg7unt/Nhtf6g5bpoDKJlkkzoUvqPV817N1zY/2LUjUX8ntuuxGU2iWzwWWZ2w
         ZCE3sHBXbq4sDbMe8e8mLyU7emLhfcQLUsW3Wh6L3JIKrlO44X0nSCAYE6vgqpTaI6li
         M0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100768; x=1755705568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcLQFrhiOp/Rq3w2uCcr+Vuz3BcbpuBMoaDB6Viof4c=;
        b=RaNrjMiAWv7x3RBnqBxdw93XSR6Mvi6tnxOljrgYh8HxkBcriAEuHRYaPar1KmUG6L
         PDX+rEcQ5IygIRYHeTlCaJbMDotT+BoVHPBTVkGmGf59XmkaCkPw05vk29iemPeUdP3u
         YkUexZDaaB2B7XbGQjsDjGHoAHx5l7nOi+K0Dz4kLcCvPbFMUECRrX0lsJOHonDNnH5L
         h4JN2Qd6GP53o8LrjZ0KyPH9v4d9rE4X28/nLoQE6h0TnY4U6AVritlQ71+VCSQ1f8cf
         gc2Jg1RWipZsLnZg9eNV9iHloLXHw4v8jJnDJH7FkDZPLxaSnE2U8GXpfWxkSCi84jmK
         ivkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2sExE+kHxoYknqNgCbrZvy3VX5JKFEOLfJlBZRI0NUB5mRLFUpfqvWSyJoYr6dtOPEdAs7cPgQbeV@vger.kernel.org, AJvYcCUQmArt4vPh4quVB+Or3MuQnPObbw6a2Fi6/AkZ8GEVV1FGtAf2zFrxUqf8kPisD9mWgUNfCVLEFdg5u/Gy@vger.kernel.org, AJvYcCUdGj3Z3CvGQjYQd0Bv6ZZw1J4rvunPI1mlrrjkoDsM8pYvhPMlq0ImAc7L2+ETofxsXBZXmvN+eTy78AiAww==@vger.kernel.org, AJvYcCVGmnQpMrA5FGeEKUvtihXKrhDN+5eWdO0rssb026WNTEflJ7p9O5sIWXcUz8bxDGNFOF6GQEs7LKoVnQ==@vger.kernel.org, AJvYcCWF18Kypyp5krnOgPb6Mj/pCqvYqrtJBfc8vNUpSxgATvHcMZm0DX1IFacsy07QeU5VyBnOL6k6VaOit7jaPSA=@vger.kernel.org, AJvYcCWNkactkYcsqyU29Mya+KAwI0GC1hPx9EGrEXZ+h77wTPLbc/Z6xxRT4iwAyK6imAfYPXyNsXRf@vger.kernel.org, AJvYcCX1PsGZVrm3xct7zcdevWCTqO/KCRiaKFOFqaGMioP1/Ha8lNTRoLxoRbKz5LtDYZDXFJGYOjq2cN293DWs3Cfj@vger.kernel.org, AJvYcCXFYrjLIJ0nUkN5VmVmM883cbRysnB9zB4TBycUi/f46vrhJsZMt3uF9rQm/B+hfD1bO8eI0dPCXBpW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpyf6NDOSZ0Pd0l7lF6FYYM71adrTbN36QYJWV/AX5OvOpQR2b
	9/AujGg73vQKohyzsvFkxmQW9N8br1tYp+P/d/GdANjn1fgHBKJnOhCP
X-Gm-Gg: ASbGnctoCw2/s7NrDfQ91JjY4Gy3lZ/ORFJlZxPBCRKu8rJwBAS7+IdXceebDPI5SD/
	Jd4LTxg+FbHLleoOmNijSB4vVEkB3fGcS6FsybDJSa09Z24NCVPbGXWJ2FLOmSev0t4b38d6oDm
	ntUeSX1y+mjG09QnUFaoUH8FGw+sWk5OQa73gbli87SK0/qL5wQVtWpw2+jT+dmgNOv+8+rGJsl
	Pj0QMostQqacR06pcw9I1LBxnJgm/SS6IXM7aa+Q62rENq4k8gxVLsVaWZ+JSMJMYJcrnglKPzb
	lQ3Z1rewRZQrMUKLwWeUvuYRY+5gm8epvRc4SYbPRJDOfDkp0uJJpAhvhXtTYW2v40dbNDjffz0
	YMtxX8xnHdd9+fbBNNnIn0pmhp87sAJnRoecczbzIiPB58BIbSib8UZ1OHbA09NIZHpYoIrXBQy
	8ne3sjZEo5PEmWOH7EsH+2gRDim6p6
X-Google-Smtp-Source: AGHT+IEw2MywSOelGxEwOHkkEsX6w+ABjjurOH62xOqVIAik4CTrWwNZQzOT2Gf4eYLfrctpn5BQhw==
X-Received: by 2002:a05:622a:1897:b0:4af:1f06:6b41 with SMTP id d75a77b69052e-4b0fc8ff29fmr44905511cf.59.1755100767638;
        Wed, 13 Aug 2025 08:59:27 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:26 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:11 -0400
Subject: [PATCH v2 01/19] drivers: net: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-1-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100759; l=3366;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=ynC0QESeHbsdNeAVd2Vn1HA549NqluNx3Nnx6Y10jSc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHiyLqrJcehhIptvqcnDNXZWSbG5Ir619fMXHEgmHiYwxygRjCE1NI0Z8X3GDO4GkwgSMycAa+N
 s2+YoMGwSqgc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/net/phy/ax88796b_rust.rs | 7 +++----
 drivers/net/phy/qt2025.rs        | 5 ++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index bc73ebccc2aa..2d24628a4e58 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -5,7 +5,6 @@
 //!
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
 use kernel::{
-    c_str,
     net::phy::{self, reg::C22, DeviceId, Driver},
     prelude::*,
     uapi,
@@ -41,7 +40,7 @@ fn asix_soft_reset(dev: &mut phy::Device) -> Result {
 #[vtable]
 impl Driver for PhyAX88772A {
     const FLAGS: u32 = phy::flags::IS_INTERNAL;
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+    const NAME: &'static CStr = c"Asix Electronics AX88772A";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1861);
 
     // AX88772A is not working properly with some old switches (NETGEAR EN 108TP):
@@ -105,7 +104,7 @@ fn link_change_notify(dev: &mut phy::Device) {
 #[vtable]
 impl Driver for PhyAX88772C {
     const FLAGS: u32 = phy::flags::IS_INTERNAL;
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88772C");
+    const NAME: &'static CStr = c"Asix Electronics AX88772C";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1881);
 
     fn suspend(dev: &mut phy::Device) -> Result {
@@ -125,7 +124,7 @@ fn soft_reset(dev: &mut phy::Device) -> Result {
 
 #[vtable]
 impl Driver for PhyAX88796B {
-    const NAME: &'static CStr = c_str!("Asix Electronics AX88796B");
+    const NAME: &'static CStr = c"Asix Electronics AX88796B";
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_model_mask(0x003b1841);
 
     fn soft_reset(dev: &mut phy::Device) -> Result {
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 0b9400dcb4c1..9ccc75f70219 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -9,7 +9,6 @@
 //!
 //! The QT2025 PHY integrates an Intel 8051 micro-controller.
 
-use kernel::c_str;
 use kernel::error::code;
 use kernel::firmware::Firmware;
 use kernel::net::phy::{
@@ -36,7 +35,7 @@
 
 #[vtable]
 impl Driver for PhyQT2025 {
-    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
+    const NAME: &'static CStr = c"QT2025 10Gpbs SFP+";
     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043a400);
 
     fn probe(dev: &mut phy::Device) -> Result<()> {
@@ -69,7 +68,7 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from the boot ROM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x00c0)?;
 
-        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
+        let fw = Firmware::request(c"qt2025-2.0.3.3.fw", dev.as_ref())?;
         if fw.data().len() > SZ_16K + SZ_8K {
             return Err(code::EFBIG);
         }

-- 
2.50.1


