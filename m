Return-Path: <linux-fsdevel+bounces-62745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39DB9FB9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608935E09AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7482874F3;
	Thu, 25 Sep 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGvqmg2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77089299A96
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808483; cv=none; b=Sk7Cn5t9bKFPXYNqeSg+gzIPhRhgi6ISxLZ3qT39prnkMQ3arWTqKCRQirLRGsQKw9+YpyyAw9Mt06+5GbN5PMf0/9Qxa5k5rjmK2SidkbEF3HlE7GzllazI4mK8U8ObZxk6BrSt/sA9us7fVsXL5xSDrjhoKG4eVYEJwctxgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808483; c=relaxed/simple;
	bh=bBVznekpj7qdZ0+04IhJTyz4wbdj27t8Hhu1jfona5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zp3qmp+KgdLliCJwfBc1rvXwK8A1S4P4E2XA0Pz8pnOzJ8Ft5k1eURag181WopLqlWx4QIIMZ81eTb2IoC70qY1T7iuwcAPEPyiLchzN6XM12dUtmiPEsB2obWOuzqsVEEaekN2xC4HgbF2s2yVRtlM2P1D4o8VdJ1K/2MiS4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGvqmg2F; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so8132486d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808480; x=1759413280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6lalX/iBRsGnpItoRbVPuxYp6EIBWS28tOUXJUE06A=;
        b=JGvqmg2FjpGnums7f9TtB91ZEHDxTDHKw5ZM2KiCeGnwDIKrxIWYi7oHNZ3VFYWtvw
         XaS34WAygmxNW3LOyTf7QTI6sc4u/zxOtwCJJ5iWmNL1bc+P6qBsNlSUstqD0Ic3jjjc
         S2wvXBH8DP5tN9ehtUeGsF3xwKkjGHkvQeVtet9YibnqfNA7DrGcEvOZntMMmaj3yGed
         GYqnxdeL2pnRx4UnDjbgutLucrIsneP96Nzjanj+qaaSNO11aLaAmhY4trCpE+PH4aKE
         Q0MqeM/uH1uCNuXTnQ3LBFtMA76FL+9wavqqpDnbyUt89PFtZQvCyXt8w8h4KwK9A1hC
         m7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808480; x=1759413280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6lalX/iBRsGnpItoRbVPuxYp6EIBWS28tOUXJUE06A=;
        b=rrBGaiC/OD8jqWbmC/eJhjDPQMxctiHVfSHnfjj3HYNtZMUbqV3kUtMv9rAtNeIIkf
         QsFSTHPi7gSAkXFyz0bnA3YkxMGLjCZIuixT4ht3TVTfnMSVP9/jh64mhvKkKdrjW6Wf
         qDXdLuNCgvm9PmBdQ99Pm3z77M8IIk9E6laBp5e1jb86XPEYdrxgw2SE/XbCucYH7hUi
         UShiPAVPk3l9FjFp4vLABYKzC/3zd/6gD9Fl/qtufWu3YXpvUY1FYfPrroiE7veSrc/x
         +U1DKRKQ8GZ49ygzJ+csW8gTNcaG7ouFAlhOt6M9Fl2aQ2erKqti4n6i4PpQijTGTe1w
         /BgA==
X-Forwarded-Encrypted: i=1; AJvYcCXFhSM4XwWgHQm+xiplOi2NnP+qKqjMsYhjvrNFOw4GR/l7P7fido6bygbOQK4F1658yFNusNWdhtVyHtyo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0tnXqgSxmRT26kVHSW760p1B1BLBq/7q4zWaDTJEk12Dzk87i
	3O+eCOf4Wrwy3MA/4qmtTz4/RDklWI0otD6fsO35QuVeAYjnIqyvxvvV
X-Gm-Gg: ASbGnct8nuf8qIlriDrVsTPZY5xK1aH705K6DV/trUui1RZCwXl2oRbuifDm84KQeEx
	ao1Td15XSJSar7X1Mxl0A/SLRogrSVQr5Z4aNGi7pFas75gGzFyLmuY6bNLFwy837qURmyro2Mr
	ygzbHmaGL3xRQ06gAKdplfbuOp9HM2HASYX86UPeMvkK6Ce7U8+40vMAO2KXZAcnAtkbZOIx0OS
	Gr8CXX5oiGm3VzfQsl7F2m+gtUh2j0yS/w/pqe8ztzXb0M36V+DHVdLlRu8fNN8IqpS0YB/n698
	+j+KQmNnwuiK1gNgBt6sGsh0sP2tSEE06cToBrlmXEEqCzQTXLcnRAfQ29t4CytcdTfG7HHYQJ6
	5xZOTz7XG72TM+8tPE6IHv7LP7ZMM1F6SBo19hqjPkT+J1BaiqQrsp12761gguJajlpajPdN/dO
	tXmZaCeqzgOVXv2rekKrIBEbMFw+ND37UT7HWGApPgRczDpVgVxJuOoMpz5hsrQu2wATvD
X-Google-Smtp-Source: AGHT+IHepv29FfYPtTdxgOoNZgUW8YipGs8v8IsYeK+WMtrN5j7d3Ey2ZO1H0B0PLPCt/i6MFpqqEg==
X-Received: by 2002:a05:6214:e44:b0:782:1086:f659 with SMTP id 6a1803df08f44-7fc39463963mr48276926d6.26.1758808479997;
        Thu, 25 Sep 2025 06:54:39 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:52 -0400
Subject: [PATCH v2 04/19] rust: clk: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-4-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=1787;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=bBVznekpj7qdZ0+04IhJTyz4wbdj27t8Hhu1jfona5I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIaSBovkrkMRrRLSQD5J+u5uy+nbEnxtyP0CB8hGaKgQan89NKIGBwidRQmE8SW0OYKsdw9ArOG
 kkgFhmd1d2QA=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/clk.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 1e6c8c42fb3a..09469277e95b 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -104,13 +104,12 @@ mod common_clk {
     /// The following example demonstrates how to obtain and configure a clock for a device.
     ///
     /// ```
-    /// use kernel::c_str;
     /// use kernel::clk::{Clk, Hertz};
     /// use kernel::device::Device;
     /// use kernel::error::Result;
     ///
     /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = Clk::get(dev, Some(c_str!("apb_clk")))?;
+    ///     let clk = Clk::get(dev, Some(c"apb_clk"))?;
     ///
     ///     clk.prepare_enable()?;
     ///
@@ -272,13 +271,12 @@ fn drop(&mut self) {
     /// device. The code functions correctly whether or not the clock is available.
     ///
     /// ```
-    /// use kernel::c_str;
     /// use kernel::clk::{OptionalClk, Hertz};
     /// use kernel::device::Device;
     /// use kernel::error::Result;
     ///
     /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = OptionalClk::get(dev, Some(c_str!("apb_clk")))?;
+    ///     let clk = OptionalClk::get(dev, Some(c"apb_clk"))?;
     ///
     ///     clk.prepare_enable()?;
     ///

-- 
2.51.0


