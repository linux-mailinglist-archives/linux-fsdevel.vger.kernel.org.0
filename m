Return-Path: <linux-fsdevel+bounces-57759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4EB24EF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EE33AC34C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1028936F;
	Wed, 13 Aug 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA4TavYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314D2882DF;
	Wed, 13 Aug 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100781; cv=none; b=SY4lYF3INwqqb5/S3Xn+7mh042eaywsJIA93te+3jq32V/5Z3R4u32XKmAPMCgtMNuiZTSvrBXeQ3HMsfufY5g6IRlN0ikdRFmNJOdz7+g0U1LU6K/Axi3Hs+SYkJGwTeeFgSdKDCFpEBWlqnK6Ciw+AvCN6whwGS20GukODOGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100781; c=relaxed/simple;
	bh=kr82Gyb3wJcxQA+MDJPetUwZA3ndNFP5TJoRT0zX8oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udsitFgNKiKvyhRTS7p0xnGrp6QZ7kfSqN7I7TH9snMPbw0DxQniWgXqUt4EPmLCDHRHqlBaj5dFLUd0CNW4Zi4kCNg7WrA4D5LivM8bsob6YvHqloXz+ecGvEJM7UNJIQEVjemE7Pr8l9t8jM4jO7a0Tk+clsRkwCyQXAr8TMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA4TavYK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e2c1dc6567so445410585a.1;
        Wed, 13 Aug 2025 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100777; x=1755705577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B/Rl80M2RF+JrMNdMpIaLoO99EqPe4tcyPYcOz885g=;
        b=lA4TavYKghl2oyGGzquYOUWlNxzVXzxXnOU4qmhyUklcI7+KzJiohhCv+ozinyOh5j
         Rq1EL3I1eFHMQnLomifJzp+OyFL3MQFx615JMcuQ7NLCx++MP0zU89v4q//0SBpohbce
         XgDG+nwBMsvVVZsMjMf5DM1Xy5jeqNwIQYdUuroBwTb+PPLiPvrpK8G4tN+MadVsxbFJ
         1ONPykbT5gj39aNpbxIcKLkGgBIbvkfLOfEAuLd9ATN6HLWFVM9915mRahMOVqz+qSVd
         Qog5qg1OT9l8QZFLImZvRgCVRUoUmkkHCI0aGrXPud1XHmTf9L3ZZ9Hp1PlgArVuJGkq
         UCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100777; x=1755705577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0B/Rl80M2RF+JrMNdMpIaLoO99EqPe4tcyPYcOz885g=;
        b=bBYwQBs/ws1oioGFCeiTctt8fhsqQGMYK36FWJWogGA/orQkX8lnUBEprd7rUIAZR1
         ZNEOI3fp8eLwmabPCGpdttVPVH+o+YTjEjvj7R7gsSgJRY3GAwZ/Oq8/E9E7CdTFSdXU
         8uDLQ0zBIMsqiAtDzO15woU1ADe7eRgEA3/p1bvVTmKgNjmxrSmV5u4EOjXKTJ/6pkVF
         PGFSuFzZUYD7UW1HHyFrJ4UT0ZKKi8Y1sB6Mqs87H6QPRoMzb4t0vBo0XUA3vz8Uy5C4
         MAT8cMwpJ+z7KutrucH1y/7aWp2IcbxJ3R/Ze1LTtbAQlIIL+u0wBav1pRDJETaXngfc
         opQg==
X-Forwarded-Encrypted: i=1; AJvYcCUMsK9n0cy9pfiTad9zUjh96VwP/liRa9XLZvcVftE+nozfAxYUZrlvRqF8xpt+w+reh0r9QHjnHlcmI6S80zeb@vger.kernel.org, AJvYcCUQts2edQHQiy6YtadnUSKlirbS2RPI981FEAh9h7/alM5eaTYIBsFLnPrq1yVBO47syo6+95sotW9zLw==@vger.kernel.org, AJvYcCVZHd/1sAQI14P+mBUy640zxnKosjh/8uXlW5Z4LvAkEO69P7cHGgURCCSp2N2JrdovWCrsg/MsWRHPo7PZdw==@vger.kernel.org, AJvYcCVkX1ukEOOk/GP/cFb2XhKMKKzfEATCrlWVrsGOwN1XOJmxF8LWiX7w2fpizrk5IFjSUAq/2ce1XZvv@vger.kernel.org, AJvYcCVwpvIuNjRomkJSrxMi4hPEKZzU8Eb3BicAixnBzR36Wmw6BRgMDRudarCg5mW8IcW52+Ezd62z@vger.kernel.org, AJvYcCWM+BUU3int5lZ8TbvrVdsXPVAO6pOUZbyhO6kH3MqRFRy2VHnVPJqQA68EqK8MmERtc9IM1zjYjRsD@vger.kernel.org, AJvYcCXH8R3Jme66cejAyCxm2M8GD3BnlaymYqgXUnm/L/Y4K/Qqtybsaf4Msc0uwOFiB6fQk6WaP7azOBlYjmCbqic=@vger.kernel.org, AJvYcCXVL709g5LrpaakTSM3L4y/99smzMsMU+rzTCtsTWor0cCM1etX7L0z6PijbHRbyvfYAVLed1bCOrd/oQ8V@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcYF/p4Vr2TCE7uUJifJmbMw7z13EeU3ZFxD8TjfkicZewLD/
	y7UkJuEMcZTCGFU2K4l97pwMdX/rWlKNfsrtGtvnnlbvaqXvkALfL5qNoxTdEPb87Vg=
X-Gm-Gg: ASbGncui64omdRK5TxgjwnspxakHVzbkiVVvojkovpRzFr0A3xekJIDenYlYTDIovns
	qlinzjGMoX44/3AuUapiktbrtr9vj8ycy80zG844HYgFsqY5sTg/Nr2K1iMssG2huPL+oIrOLgA
	zdTSFInMMh5J6qzL0KS8x5Oi7E61ENUXAm7vw1UHzkfTe90I25RWbXFdVTXHEkc6wFFrvdS60+4
	KiKRZKcb2OTW06lIeZno9K0/M95fRk5nqRMwuO113gEfT+N5VwjHuNdfTCvCNoavZ6cyC2JVeca
	582co2XS6/ebhScj3+IjeleZi+kKpAW6OnlDhsxDI0u0/g1MEW8WWa09XpGubpEpK14mw7KnCh1
	Wn6PcLvW1fNegXDUfObv/00w5SufhonAwryROH8nWnO7MDeoteZoThKwmT/m/bIYeef21TrN2/M
	RPh7uQU7JJUUD0KeXGgcxS2Adq0S3g/jit8yPpgHY=
X-Google-Smtp-Source: AGHT+IGXAuHbm5U1Y4n3fl9DFmAOsvOkx0F/inmIBEc5qoVGXJ6UExGE17RCyI2F88NmRNkKJHgt9g==
X-Received: by 2002:a05:620a:46a9:b0:7e8:6551:64e3 with SMTP id af79cd13be357-7e86551689cmr488086185a.56.1755100776729;
        Wed, 13 Aug 2025 08:59:36 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:36 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:14 -0400
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
Message-Id: <20250813-core-cstr-cstrings-v2-4-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100759; l=1737;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=kr82Gyb3wJcxQA+MDJPetUwZA3ndNFP5TJoRT0zX8oM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIlIhhB4BGisD/SuihGvNGHWqLUmAuy/tzhcAeWkBxzWuNh9scLQItFeaGY7gyP1Qw+o3qXno4q
 0C9ZKgq+ekgw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
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
2.50.1


