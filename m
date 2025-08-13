Return-Path: <linux-fsdevel+bounces-57757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A9EB24EEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD88388660E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471DD287263;
	Wed, 13 Aug 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k46lIir6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A8286417;
	Wed, 13 Aug 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100774; cv=none; b=eKjfid1De7IN1NZq65OfjN9/yBDAmKlo/RJ3jVR2r2Gmy6YyPclmIgqueu97zTc7ycxpLa/5Ig5MJmqYaJpzHSiDOFYd5InbHy0FmerINjvsMjq4tzS9BuCWjEiCg9GprH2AXIq63D1irr4wX1dG7BVi5E/F14qRlf8w75kjors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100774; c=relaxed/simple;
	bh=/6Rqc6yq70/uVo2CCK0rVzt/j/mmv1WXhqKkANquG+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L35lF4rVufHb0UX231gNIWLeOYLSYZ+NF+0U4HAzvzJJDwh8iNh+IrnB3zW3eqGp7mVrYE6+4zGkQVXHKwclLWbVDgVew+nquGbYFnx53w03qVzMfXysk6Uub7Z/09LT7N1+KzM1ZjVlIi4v0at9+nxrXgxq5I2MapAGn4lYQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k46lIir6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109bd63d0so272871cf.2;
        Wed, 13 Aug 2025 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100771; x=1755705571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EC+1oIHbj40bMk7XrURGYK12FsziAijPlq/Nwpia8Q=;
        b=k46lIir6kWR9TgZRjMU+hrx/F+iYt9EJnftVNF/5tjyEv4wz947W3HhDwebn0fk6C0
         HphZFwTKDGrhviJmnw0+lb08HV2inhxaSXdwty183SSWA04Vhv/nSgpzmbtxnmp1OyYC
         z8vuyLm4/NpGGUMwVyZqxt23+Kh8QMosduaa47IstfitYJ5VDfbcDH6W0cLYMEJW0BNY
         I/0RHK4RM9yANzXYxGrsk1I+/kCAnkuk6VM/5JAzpNE4hqsNiKOTosg7E+t2E+0Uj1KL
         22/5SRr+zspvLcdO/0nZFdqvNVrWa1D8rzJa07qHKN91GlGoE9GXjAFORxkUYVkZNEQ9
         ofwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100771; x=1755705571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EC+1oIHbj40bMk7XrURGYK12FsziAijPlq/Nwpia8Q=;
        b=b5Itcfz+Nte7eY6eB2UiYenKpP3RfnZW4SCQpKXDFWW0o2J/GJceW3yoBGvzKJcNHm
         C0zCqQw8E0BgV/0MkbckJX18OILWN5LN6fMEodCHewzzmPiDmDTpfAUCgKPubCw9/MSN
         fz1NdLez8EDrNGA9/F98FustpvRQzcUIv4PQegblWeI8irPS+kuxI8bJEjQi+7B/FQK9
         RLrG7lrG/CWnQRDH3fKDXYlxjpTLqYAlM+b8Sf66HeEbetx4u272tWaZUH3JBIkAUO/V
         YALqwoLCNp3WCHesUV67mA1hiHVYThVxuhiFMoHMvXyzhf1Woy2i8eQ1GNivuUHohoy+
         ijcw==
X-Forwarded-Encrypted: i=1; AJvYcCU1SpfckHuuo9+onOO/5/0uhZjnSlXP3aW0eTIiHQ7imoaZl0NcIM8IrJQQiGppkhwZConM1Ww3rhcfN/810Wo=@vger.kernel.org, AJvYcCUvvqeR+gzkav/hFnAsV1MPz1xlyKhzNlkvJuQE8PPugKw9MlkEDIo5PQvnIT1rnWtJay8G+jKkEUJDlm8ZwEdC@vger.kernel.org, AJvYcCUyZOUT4pL5OZtpsp7taHl7rrjBltXFHnpyP6TBc78YM3J5V35FKWOcSoIZ/nDSQsmrpeB1r+6ht4OS1uuxRA==@vger.kernel.org, AJvYcCV+7gm+kMkNXIKdmrz6Ui6D1li6mAZ/QFq4MZSbPW6VDmrXiz/BDkZG5sRoMvKcUthMTLayFTg3t01t@vger.kernel.org, AJvYcCV95ltuVl0lUbxIRwRk+S/2QHj2cJU8SdVt6k05SZzsvZ63JpL5TEjjmt7s3uodVJupiNGpImJjktKutg==@vger.kernel.org, AJvYcCWh4rldAvDXCzASDHkHFtP3AVq1oiC6oq+PaCb4FbXhTvyiaX4Jmux4NNP/1hnTp1s13Yk/kS47q1IQbU3R@vger.kernel.org, AJvYcCXKe+bVPjkR1nU96SCsP9jC9zf2GNe4+sZvsOMP0yvWMmsL2OmJyKqKPRUVggBR6wNoe5NpHMAR@vger.kernel.org, AJvYcCXuykafyLGWW/19RhkWg6uMhKiPF3O6OHio+Uu1LjrUMp9K18yjs921RS+mTISC9ESELxM/6yi1BYIE@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9iaiRFHL/OpITOgkhD+ROkbI7fxK9YlSP19kudp6QpUK+4FX
	EQ+R3WXSvKFCA6FoSGQwwlF4kU9MxCXhDuLXxOxichk3Tz7rv0DVlCfK
X-Gm-Gg: ASbGncvI1g3dZ9hNdevdPvY2iXIjg4fMR3Yfcvp2JjkDzClUFZShXlV8lbO+xJLeYk7
	3tG/WPXlCg5nTMmOWGpJ1u7YNqSnaV2MT9Wbw0+moa/7N1Rg7p5+X4il5TD1flIDCKbeCBE6Htw
	mWJ5mMje6gK+bJTukp4qgoCTjl4Y9s8cZnGVAwb9cUhGN2pLym6Ct2BDuK3Qy/yvG2pZj23HqOQ
	RenTThKwnb4BSeqP1/16GePfQVBqNvbpqWWBi5WzsfPYdbC4BzJ61gRPVU3oRmWYBDcpDN/p8RH
	ydmBHZsHouq9IH/zHI5MTxBqb72AsYko14TI2JcW9dvWqUrLT+ylhO16w30r/NFnKF/wiUV+KWO
	rW3fKxUUcMh6cun1yRVhjBhbyMYly3MceYqJtjf6YxlphTgVilx9We2Irzr+Uohytpb0cXSReWc
	Be018GAQhJmJl4q4aqRbgWoGnEAEfkHh8VWqy2T9b/wUcQG/6acA==
X-Google-Smtp-Source: AGHT+IGpgxrufvVbj/EAOSRbPajvrkbv1ubmtObGTneciR1xN69K//nK7cLM3mPNug8AvmxmRiJbtQ==
X-Received: by 2002:a05:622a:1887:b0:4ab:3a31:680d with SMTP id d75a77b69052e-4b0fc71e9f9mr41676621cf.16.1755100770752;
        Wed, 13 Aug 2025 08:59:30 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:30 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:12 -0400
Subject: [PATCH v2 02/19] gpu: nova-core: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-2-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100759; l=2863;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/6Rqc6yq70/uVo2CCK0rVzt/j/mmv1WXhqKkANquG+c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMxUD8q7sdXNIZJbqOsCnf0eKBOPnd2r+87E83qZIwccXLqO4VipK6rxEDA6qqdZDuVzG7p8Zpy
 1WZEYV9IVxAE=
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
 drivers/gpu/drm/nova/driver.rs  | 10 +++++-----
 drivers/gpu/nova-core/driver.rs |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b28b2e05cc15..87480ee8dbae 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, c_str, device::Core, drm, drm::gem, drm::ioctl, prelude::*, types::ARef};
+use kernel::{auxiliary, device::Core, drm, drm::gem, drm::ioctl, prelude::*, types::ARef};
 
 use crate::file::File;
 use crate::gem::NovaObject;
@@ -22,12 +22,12 @@ pub(crate) struct NovaData {
     major: 0,
     minor: 0,
     patchlevel: 0,
-    name: c_str!("nova"),
-    desc: c_str!("Nvidia Graphics"),
+    name: c"nova",
+    desc: c"Nvidia Graphics",
 };
 
-const NOVA_CORE_MODULE_NAME: &CStr = c_str!("NovaCore");
-const AUXILIARY_NAME: &CStr = c_str!("nova-drm");
+const NOVA_CORE_MODULE_NAME: &CStr = c"NovaCore";
+const AUXILIARY_NAME: &CStr = c"nova-drm";
 
 kernel::auxiliary_device_table!(
     AUX_TABLE,
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 274989ea1fb4..2f1a37be3107 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
+use kernel::{auxiliary, bindings, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
 
 use crate::gpu::Gpu;
 
@@ -35,7 +35,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         pdev.set_master();
 
         let bar = Arc::pin_init(
-            pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0")),
+            pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0"),
             GFP_KERNEL,
         )?;
 
@@ -44,7 +44,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
                 gpu <- Gpu::new(pdev, bar)?,
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
-                    c_str!("nova-drm"),
+                    c"nova-drm",
                     0, // TODO[XARR]: Once it lands, use XArray; for now we don't use the ID.
                     crate::MODULE_NAME
                 )?,

-- 
2.50.1


