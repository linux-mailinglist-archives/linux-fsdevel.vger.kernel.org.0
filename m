Return-Path: <linux-fsdevel+bounces-57760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68286B24F12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35195C4427
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD528C035;
	Wed, 13 Aug 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3RH32az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AB288C39;
	Wed, 13 Aug 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100782; cv=none; b=iqKaTUEykho6nKNq8vzF8/cbuUgEKDVhLAjts0DICSs5H3icGLPIu3rVARF45n6beHist4SPX6ggu3Ipz446aPygmoNHePpcgI2ODKXV3jZ1cAWptOFp4qUpX+aBoCCga5L9E/OIcGLvFR7Mre9yZf0wCAH+pCa3DxudgvxU84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100782; c=relaxed/simple;
	bh=EQZo1upB9M1x1JFdTpaV8Cq+trhQfkvbEQ0ucCR/Veg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5J90xH8oj9FVfJp0M9m8a64CS0C9ydPYU4SqEyREFHpZZMgydevr56vpvLDAwQrYkTQfFcN25wBxHACDOvdPJQ+j46qhTfLWSGQDz2Xn8/e+nywFT7uriKUUxQfrcx64MuuTBnFFcsCcWh8uEvGt/FaKOcpDp0QqkE1lCDSCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3RH32az; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b10993301fso550311cf.0;
        Wed, 13 Aug 2025 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100780; x=1755705580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uSi0/KFXiiCYmcIUU0pjTetKZWsYlG+no8vKmb84iA=;
        b=i3RH32azRUHt5nShGlnK7aIXZrhCapXQH2iTzvOoGD4ikqRhvvOfRupGmzOQ6lVZ6+
         a7EeapCbCPyWm4O2hNrofOrFF1hEq1f1IODthzkyk1K/VNakHDjim7aNJAV8B3rwX/0q
         HD1eYmja+3M1XRIfXZ7kcnnakooFcm1Pe+GZvL77ZHdMtVQ4oJDLXuwMB33Yzhjf6imI
         u3EaI7EkfZpD1xSuSoEauuK3FrVQVLdrL4MJQ1Y6+dxGrHuRbr/bR/X0YW3nAGWaqpRu
         tI+1kY+ae/+dR+KtEFNvcF3WUiyfxfa+0q7ZE4aRKIZ+9xSAszzf2AuPd9CliPH3EvJb
         S1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100780; x=1755705580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uSi0/KFXiiCYmcIUU0pjTetKZWsYlG+no8vKmb84iA=;
        b=SZ+p5Srz9oyDtrClTsCx8GUMSK8iUmP+QxRYBl5TOpYivddSYcuAGV83xfWPzulscB
         gqIYh+mCW3wN1u63l3EI5j0XOXKphvIbvznYhgBquXe4S7dRHLeCfhbsuOtDaza7n3FH
         pnM6eoBRD+LDJ3fF2SbWIKq21zGx90THAJ5wb96QLZx1Qj+Cppp7MuSzhuelOihyyqCZ
         gg4M3K5mWqinOaNW1227+4qkMZEXn/0hw+hE3LaNnvI7eNAD72cllSAm5LWaWaVugQuc
         FN0L/35YA4DUZMDBVMN9XrPBZp/Vg0BAnbfdEohns3vPIcN76VH30mA2gtWM3AiFW6YM
         wu+w==
X-Forwarded-Encrypted: i=1; AJvYcCU3vy0ArmgOaV2/ey6CjVBE02u/TiXVNmRpjRqmjdcHHh4YtjKi+syfmWdW353U7HZm5YKOCnQMhHwrUIT5344=@vger.kernel.org, AJvYcCUAsl+JP8Ok7utCC8SB83WnY9IZJ4BnGYmAZ0ELtaK8d+bIN5byQizlfN0qZBiAdbaobHbV8IPk8bKom2+wOQ==@vger.kernel.org, AJvYcCUSuiKe/Ry+WD2NnYrOz+uSg2z/CVGRnklirWXjnuRhRUhOPH3AVCDXPwFAwX364bRECGdb32NXJra3@vger.kernel.org, AJvYcCVLYrGhZGfEx8vexsz904T1YFB5aQUQiAOUGg+w23Zk1izIdpSUOMlFpYJVj8ZFOI+kjSQZMJlLaKF4PQ==@vger.kernel.org, AJvYcCVUot04SxtR7HGFSH66Ap7LcRPmh0onwDrXEMj5sD8gm2F2xlHSelg9CrCZgNXldqyTGsk8+AHj2Lmgn2J1tLZA@vger.kernel.org, AJvYcCWZlCRTR0OKJf+r/TGP82Jmoez4ycHqfiDk/umwxW7OavLQkz86Km02KT4PkmF5TdHQWG/hjalX@vger.kernel.org, AJvYcCXbTQCeNSMp5BoB4xLFsBoEA0fFnzi3vuacS812G7KKZUNyQ1Fpjl1o77QwKL8kcMXMO2N8t52VWZolS+jL@vger.kernel.org, AJvYcCXfvLdhpnX6oGy6TSY9MYPSL94I6WntJQmpkOsGDSQ5b/aoAa4a4k183cP1SPGq3DHDoeBXBt2dlL0K@vger.kernel.org
X-Gm-Message-State: AOJu0YylBink4irreEIW8jdwTDBL9tUtAFa0C1JAROvzrnnPfMF+5UYk
	a1lckgoQCaUJX4jOGhaGyfQcxDc+dzqipqGEoNYGiycEK8ZLEwc0roDr
X-Gm-Gg: ASbGnctK8zFOQRo1OX431mOpebWH8RRODFUtocJOTfsqyp19dUOfjFe3vJE3z/FxdD3
	TQ7pQYuo7+l6pH5e/jjbapl80iYyMzLTu5PMMBbLZAGaFAKOLY+oEPgD/s6pA1yeguEf7857e7Y
	hzJUPlvW39FabVBse/IWm8+MqC4zErvRU/Qv9hujWUZOTgkZwrCsEj2S5CmGYjnUbQPsIqffpxj
	outH1RbJJ1gSMls1IJ/+n0vXaRFKWmVlF58p4VpKwSdYtpu8i9kssMY1Xf0Gjvt/nLRbD8Z06ig
	vrxbhhVri5BGDTx9ZV7dZfb4wj+aaf0PcpOLw/lp37bfMUPb6kX3dG3bVcADcMhmmbqPtoZB0fM
	Z8XlXpwv3evf/YJQNYusW8J9DyJvteAWo05WsGGplv+vr4KZW/vBnyDpmOpfPsu4+kS0gGT/EHW
	yKdw5hpquw68lSg4mOBgtg5GcJhDuz5wCnfJA7dGY=
X-Google-Smtp-Source: AGHT+IEAmj18QhxLoJhKv5gl7oxN5rOUOYsu7xtf/ad0LtVX2HZm2WUPSGMiEf/0bbq/rLPvLyA/eg==
X-Received: by 2002:a05:622a:4811:b0:4af:230a:dadb with SMTP id d75a77b69052e-4b0fc6be691mr50407091cf.5.1755100779635;
        Wed, 13 Aug 2025 08:59:39 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:15 -0400
Subject: [PATCH v2 05/19] rust: configfs: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-5-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100759; l=3197;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=EQZo1upB9M1x1JFdTpaV8Cq+trhQfkvbEQ0ucCR/Veg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMestgupOVA5qzlqQPukztYt1+taScdgyyamOqF0bRx/0xpl4F7OS1NMKmSJTbYBoooWukzcpGj
 E2jFgDmWmiQs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/configfs.rs       | 9 +++++----
 samples/rust/rust_configfs.rs | 5 ++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 9fb5ef825e41..69bb1fb53543 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -21,7 +21,6 @@
 //!
 //! ```ignore
 //! use kernel::alloc::flags;
-//! use kernel::c_str;
 //! use kernel::configfs_attrs;
 //! use kernel::configfs;
 //! use kernel::new_mutex;
@@ -50,7 +49,7 @@
 //!
 //!         try_pin_init!(Self {
 //!             config <- configfs::Subsystem::new(
-//!                 c_str!("rust_configfs"), item_type, Configuration::new()
+//!                 c"rust_configfs", item_type, Configuration::new()
 //!             ),
 //!         })
 //!     }
@@ -66,7 +65,7 @@
 //! impl Configuration {
 //!     fn new() -> impl PinInit<Self, Error> {
 //!         try_pin_init!(Self {
-//!             message: c_str!("Hello World\n"),
+//!             message: c"Hello World\n",
 //!             bar <- new_mutex!((KBox::new([0; PAGE_SIZE], flags::GFP_KERNEL)?, 0)),
 //!         })
 //!     }
@@ -1000,7 +999,9 @@ macro_rules! configfs_attrs {
                     static [< $data:upper _ $name:upper _ATTR >]:
                         $crate::configfs::Attribute<$attr, $data, $data> =
                             unsafe {
-                                $crate::configfs::Attribute::new(c_str!(::core::stringify!($name)))
+                                $crate::configfs::Attribute::new(
+                                    $crate::c_str!(::core::stringify!($name)),
+                                )
                             };
                 )*
 
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index 5005453f874d..ea84c23b784b 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -3,7 +3,6 @@
 //! Rust configfs sample.
 
 use kernel::alloc::flags;
-use kernel::c_str;
 use kernel::configfs;
 use kernel::configfs_attrs;
 use kernel::new_mutex;
@@ -35,7 +34,7 @@ struct Configuration {
 impl Configuration {
     fn new() -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
-            message: c_str!("Hello World\n"),
+            message: c"Hello World\n",
             bar <- new_mutex!((KBox::new([0; PAGE_SIZE], flags::GFP_KERNEL)?, 0)),
         })
     }
@@ -61,7 +60,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
         try_pin_init!(Self {
             config <- configfs::Subsystem::new(
-                c_str!("rust_configfs"), item_type, Configuration::new()
+                c"rust_configfs", item_type, Configuration::new()
             ),
         })
     }

-- 
2.50.1


