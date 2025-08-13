Return-Path: <linux-fsdevel+bounces-57767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D04B24F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5AE1C27262
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3703093AC;
	Wed, 13 Aug 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un/Iykkf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7C307AC4;
	Wed, 13 Aug 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100807; cv=none; b=VLg5T1HGWkcLc0UzT9h2yg2Cf2t92LlklC3kOhfO9HhZqGwCLSME+Me6PJJcqfEvaFay2I5v2e4PXDLTdLgag1Iq1zAHB9wLvBdafGIeJnWk5/HA1KQ2Y4oTQ9u+8j42nv5KYAFvzKbVGi+iicbwpVXMIsz6GVDgvxRfZfhVQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100807; c=relaxed/simple;
	bh=pJzkdbx9fI80O3tC2LSw31fJ1joDqXqi5o9BSlHr9bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtJ4feigCLgB2NjWkccJITURdfWtRLIY4nVVp6DKneAsaNH2XpJO5DhK8TQbUP45iJ9fhTJSOZZWwecruO2fSbkF9u0EelcmSSLghK/ENWPW7U49nt2TBo0lrVAN9ayCaTkg1xEODvicNNKSc5dm5gWtdMLszhLECwjPZqNyILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un/Iykkf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109914034so649131cf.0;
        Wed, 13 Aug 2025 09:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100804; x=1755705604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=No81RyEmCPqSM5FObkHye8Zu6zoLkgwRwhVrnmuST/w=;
        b=Un/IykkfWdOA/GKxncsQMhmB1M3BqGn5xrk9q6Vok5xaQ5IeNIeTSPSUMyFjhBk0LB
         IIGqHt+4d9uBJfvXeD9wv/UY1V2kQMbNDshXxEpAkOp4SDoUNsj+D7OhzRhRtfQsVUG9
         jUUpWT+Y/mgZYBo/drQ4TXZRLgMuc7mXdOSYnpo4DlJmlaW/EA3PehKD0mwIXSbQnjdG
         t1Vcyx3KltuOBaU1xsH7isWoxsr6nZ06gaohA+sXa/IkYXDt268YoSgF/X+XHRTJThwD
         H7MeBxqvZj17XjGZp0Itb/D+3zPrG4xOLXtUPTA0cHkskgphELyxNr/m0RCkKGDCtHrr
         QF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100804; x=1755705604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No81RyEmCPqSM5FObkHye8Zu6zoLkgwRwhVrnmuST/w=;
        b=UqDI3zxyDGilm8vmGZ5lHYoy0Pvtwlk26LUIXCXs+r+nqxmODCpuU+V3UAROGki9ju
         4RoW4B4me9zmdODru9WQKbX5hDp2uj0DTsEg5d4GLCi5L0fv0m2UrA6zh7CMx8rz2AkH
         gvqdgeaNgYsn/JYIz1o1GlPNDWcsOVEsPs/JPu+V7D3E/dkRYAifwt47KoS/N+e8M9br
         EdONZ/8aqP4Gt22oPGSyOFIKh/qEJ5jyezCcCxl4KikOwpFdEMP1yC7S1LoXPakrEaKm
         NL/x0MKltL/57pdN0hNkY3CP+NfjTYQT6D+vTNEQZvpQdTqCJY4NtGIQA4ejbq4fYYbl
         K3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXeRHS6VbsAJOrs5jOWYq/wnkaZeyzweRz1yTckuF0YYAXVfwlYXg1b0S7r9816g2vwnRGJo3NJUM4OfIxC+tf@vger.kernel.org, AJvYcCUvQ6VINP/V2O5pT7KNPk3iZSeCHrN4ltUPJO4dml+svbTmamOK5D7VWf91FsWDrvKGLW+aRKW6spCvTg==@vger.kernel.org, AJvYcCVCcF43eJCiu6WGtLJM4hLBs95vc1GZmO2aF3QK5JY6XZhwE4ONiO71NbAA4Nz96QrmWdmULchJFISAVcke@vger.kernel.org, AJvYcCVGHufOHnQ23RXUKAOeGgt9H/jUJgkljdRV8IENtbiyI83P+4SZibn5HizSvHWVd6jhc4IWCl8XBdDaY7NheSY=@vger.kernel.org, AJvYcCW//SjYhW7ZH3K6IruW39nuH9VLg8RSgx/koF15Zlt1tPKOja3ukE5Y/MBGwjhiVr7U5cHuFRLl9pza@vger.kernel.org, AJvYcCWAa4M0/6E4RiWrvx3PiBCw5SJcEsUhxb/JpopzGIkB8+sD9K5AVE8LKnPNwEJk7vdAtCYdi0yv@vger.kernel.org, AJvYcCXLJudH4/L/con/E1yMfyoWa16ZUrIwn32ibbWUrG5KXbOh+Ir9BHZDgNWTwNQbsbXyZV8kwSCcV4pd@vger.kernel.org, AJvYcCXizwKfH2mOaT+dP0jK7or3et46XutKGQFsypz4cC95JqRig7fn+wCuelHbfLaylAJnLoRv0ssZX8ubk+CN3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7Tk7vFkMSXorOHLRHLNZCxZXATttEnxiouH67y0Ee/Ph/FZF
	QAy+5IRtSGT3HzvXMRbj3uTLyocPufxnL0JmT4PG3BrtH5UyD2xAYQCh
X-Gm-Gg: ASbGncsaEJCwr9fkpsfaXytPnx0vvWGnaUDS/qYmHcvANbhFITNcpxnXCtBpOirlyER
	n9Ndm7e41I7Mlz0t6AwoB4H+dWJMFOV4JWbq9qmlbZiyHdwNJu4m3TV25z8d7tKikJkShRoiwHh
	oSBeb3f99mYTIuMW8H4VhoxWE3wsv74VKGaTg5jJphpWnWWP5WDLUlS6GC41pssSIyTIcnedA9z
	QRFfvNjPeo5moeAX0+g+DMZ/XAJzZAG5rlxblpMoEOBuQllEvSfVTK0ttHTKynlxoJof2hkzQOR
	238j1VMLAXuUbhBLIldpC87vQnpKUQ8NnmDX1mPBGHW1Jf6H55KvEW1Go10k1rqRcAjsYGkHJ1R
	WjVDy7yknkeLmTElm+f/L8IHqacQVWAlQMrA68xVZmT2a1kKsBe7lS66ZmppU3Jpc8OXPwrO6/e
	2rjz6yw7RnzKqwZP91JkEFQL+jqzfXL1hS/ZX3lRQ=
X-Google-Smtp-Source: AGHT+IFgGPvPh4bfxQucqgJHqCsG0vM6pF/+xbTUs/ykAXBszfC0kqp0dx747oGo8p7Cqazh57fRZA==
X-Received: by 2002:a05:622a:2517:b0:4b0:7575:7de9 with SMTP id d75a77b69052e-4b0fc7cfb9emr46052741cf.29.1755100804167;
        Wed, 13 Aug 2025 09:00:04 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:00:03 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:23 -0400
Subject: [PATCH v2 13/19] rust: pci: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-13-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100760; l=1469;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=pJzkdbx9fI80O3tC2LSw31fJ1joDqXqi5o9BSlHr9bU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJF8uf3JOHjRl/3R+S1L4dcXzTZi1ecUZ6oNmqIkZFTkprDomxNGqbftfYtsMPlX0Gi4pLxpz5R
 f+K48sFdc9w8=
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
 samples/rust/rust_driver_pci.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..e0e9d9fda484 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{bindings, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -79,7 +79,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
         let drvdata = KBox::pin_init(
             try_pin_init!(Self {
                 pdev: pdev.into(),
-                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci")),
+                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c"rust_driver_pci"),
                 index: *info,
             }),
             GFP_KERNEL,

-- 
2.50.1


