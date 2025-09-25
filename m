Return-Path: <linux-fsdevel+bounces-62744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA35B9FB87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7AC4C7D9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4BB299957;
	Thu, 25 Sep 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCL8SM9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8895291C11
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808478; cv=none; b=UtRwsPY/NICvPY+qRkp4BCEV5O5K0JEwEAA6qzIecfmjOD5vU35LIZo2JmvsQwpAXwH5gUhUeAaIAbl9UMFtkqkI5yjwjWde5FLQsjOXNjbBzB3rJpuv2DuTK/9xpL5OtlfauIE7v5VPLCfZDY0lctUalcnBji+QGiOTxVC3RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808478; c=relaxed/simple;
	bh=hAcmGZ1oTJ4jVBQJEYJ6EMTc7nRfLDtEyG/sjigYIyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGeqMoFLdcDBsHLinJe0qrMneQiV5QKsU9nLSbSDj8JItO9zylfbeeMDB0HqZIPmveWka3j/2SSDI4DOWvoPSg3doQ2w/j968LbQm4fdehdEh1QNFj+8KHyJmWqFvk4TA50XW6J09AQ/5jVE8EqU03nBbu1j6Qk349Jd/G9eFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCL8SM9/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-792f273fbe4so4549946d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808473; x=1759413273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xzf6OZF5c76vENMOs87EjkdVa89C5AWM8vex+/TLyw=;
        b=YCL8SM9/Y5iGmyNUrtthO8ujsjjPI9hQklmqkZFxLz22syOPbBir+RKbtzZXae4TUc
         /lwayXqGjNn+Wp3oAY62+DGxS1mRYUr61GIfoAf4fiBjX/5nuX37c2XMfn6uoRBA3Y2T
         uR33GlTCKiqRb3E+eH2Q5bdEWpz1pWqYMvCb1y7YJgCuJLXHUbFQprOQLQknt32HWf48
         INK//k++u/YzrTRCqklcsaHTEGCTAXTtwjRo9cE1eTmTl2jIWJO93IVSP7WA2iAp8sWu
         ZQB2zJgkfyiK77QA6JDWZm7wW/eojCFxn9eLxpNJ37p+Wg9mEg10MqrV9BIqUXenb9Ji
         bbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808473; x=1759413273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xzf6OZF5c76vENMOs87EjkdVa89C5AWM8vex+/TLyw=;
        b=Zb+vegm4DbcEyXsm7TaqEBr++nX1vkUGEc21u0mQrWUJnzyXo7EdFYgBGZ/1fGNZSp
         fojnaGsv3F3Qh+jP8AQ+Ou1KPphwbIfPHYqXMw0zWfgrEpr6iyXxSRPjSAVUxmVcEVh1
         M2USFEAhdrbvqyeXNa0PemVRqtKuQBoR2SGTJAy7ye0O0f0txWyi5mG+u9v4mGZcXFSm
         jFJ3sWwlEsukW1m43gOO7hWQ/fvGOuspnff5lv/EMMCOwfCI99VBeGCPvBPk/d1bH1Hw
         NdNkl95cI4wWoP0+X2xmPkKE8QYPevGFz/uYH2FXR5jT3L3/Kl6bSYDivOkwfG1YNucT
         CuoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTZRRtEkBR6Qe23+qZleKfzx7KNiUKEoNdZiLQ2OALqH4wZH/MlH2DzhUWjSWqOjSxw1tLnOdADK+DGOij@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RJmCRjFTEvnJmzmgcGHQtTV7UqJ5gdlGI8LMsk8HNnLZTqNs
	Z//gIMdeYRfOhrzf3aSQ9h1flgK0DeHwhjfAp53qOPng0ijpICv3kPxY
X-Gm-Gg: ASbGnctAp0f5Z9K0U6GkHxyh+zoUoe8sQNpaPrO3sbUZLLobyw9j+XiCZ9SuZSJOqVw
	IhRnrgdiioWmpt8bIKrRf/h7F2dyUic5F84FakQAd8rYF1X23E7ePV1awCEO3jqh8UbS9rYTRsy
	YyMPTUkgwERXIdm02BNbaO1NQdLl8OP9u2RxNX474UwSqk3v7gGDAjFFmim+ciMqPlJ5hyBNx+n
	QwciwpkyVUkmr4RsK5W/nJp/AOwe0kTZNHpfAwfQImmzACRL7oaLDEp9UlHQ3DFM3+vIVFeHTHW
	Mtc/iGaxsNmn/fWiVgHzJDjFeVd8V+/iJ9EDeiW2mgw4MPDr9yBQQqaj7QC70CXmAGGXbLzSxra
	aJICcV1S1/99Fw7E55CrAvO8CvjEXIJVvWCbBVS0AQMV+5tYB+gFv4l8Af9AJL09CXbr4RU/QWl
	Fh0GvcTnKVs0Yavjvpjm1EFfP0bYV1896ufNs+Rl8uMKvUeuIt3w1onw0nerfNHbnvXzzj
X-Google-Smtp-Source: AGHT+IF/YXOPVFfPbsLgNMSmKy5gMrqFYiERb3qNmBjJICdsnhp8ZUohxvtzmsCi+i1Rv5C0gLGPJg==
X-Received: by 2002:ad4:5bc9:0:b0:76a:fcee:97aa with SMTP id 6a1803df08f44-7fc309ec826mr47810606d6.29.1758808473264;
        Thu, 25 Sep 2025 06:54:33 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:32 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:51 -0400
Subject: [PATCH v2 03/19] rust: auxiliary: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-3-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=1276;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=hAcmGZ1oTJ4jVBQJEYJ6EMTc7nRfLDtEyG/sjigYIyU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEE+jmobZ+OS5gJ2DI0z3t4gywTvP6wS/uYHw9wdi8Q0VEYO/oiFsjlDMO0nWijf77etP3ctTic
 ZfcFfCn7DRwM=
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
 samples/rust/rust_driver_auxiliary.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f2a820683fc3..7c916eb11b64 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,13 +5,13 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, bindings, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
 use pin_init::PinInit;
 
 const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
-const AUXILIARY_NAME: &CStr = c_str!("auxiliary");
+const AUXILIARY_NAME: &CStr = c"auxiliary";
 
 struct AuxiliaryDriver;
 

-- 
2.51.0


