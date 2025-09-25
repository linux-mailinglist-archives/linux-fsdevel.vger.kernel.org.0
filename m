Return-Path: <linux-fsdevel+bounces-62747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7588B9FBD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3066D384916
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF5D2BEFF2;
	Thu, 25 Sep 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1LvN2ul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50CD2BDC10
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808496; cv=none; b=lTdEBfStHpJ1+fYXjHFDXDyzEjeTAUHty4gqeapJhjWNb4Fy5aIm9WoCjVbA6ahFtjjTKx7kUfjPvV+UIPZijQlsn7jSuYOgtoidGSbRW7+sqa2I9mAA4Ab1JsN/2X9OL3cBMbj8w9jzK1W7IW3pw9p0uRLonG/u8ThEaGglqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808496; c=relaxed/simple;
	bh=Min9lnjKt/hlKTHKx8DHe+UjEz1oTNKYHDrlD//vrww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpGwxPy2/LEXerHKM3fp9gFOuZ843iGNUA0WAHBFFdXA6vgE0V+iuQ2uOrOBo0r/k/20VbrfyPeqiVaQZmkxUrp4xzXy8FzvTixkCCEniq4dVoTSfWE2wYDIYdRohXRJgxqaDbn/IQxRrNEBf51/qULaoSPKVv/P/4CQtkisrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1LvN2ul; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78393b4490cso7647436d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808493; x=1759413293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcH0HLOTSj/FtySm//oEeXI3qjx7RwnfgKjEtc013kc=;
        b=S1LvN2ulyuYlC3JWx5P5dkUrvUIOGi9gQL/n8rTKAAcrRyMSLnFoSen2I6NFWmm6A9
         EXjjsdoM17SO5e44MMD6uU2ZYn6rWgpyGarbUeLpB9nl9ihi1fKt6C9HqDyCeUnPVdi1
         Y+1LLN8O5/jnpyRfOUwNwTPFjHajLABxQU8p/K+rnLLwOs5fmFdUHWCM1YjSo24Hx9OR
         EVIOBfOGs2rr461N46M/3Xa95WPkUE4ujXu7cNkGFT9v1f9XzVn2+UFIQ9Hood1imnrP
         r2YxhgCSqNkb9y5sW2wM6xRjIdBzGTw4cNUkw3eMXG9BPax2jsl0LsEqWpeWn235zc6G
         WpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808493; x=1759413293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcH0HLOTSj/FtySm//oEeXI3qjx7RwnfgKjEtc013kc=;
        b=ZgXz2qqJOt/nGH+P5+tMKhgU1KgAodrcwHa/98+mZIA0P+0exk5RxEQyKakstKXkMo
         +wTpKUGCjX2qDAGKrtrXrrKsz3r9CiUt2h6xnMt1ZVHjtEfOplzdBuzqGl6y3JEJNfs2
         v+0lgtbxmlEmXoa/0VXeFWaWPPb/jxvWdAMv2gTNrJKLG2v2zYNT4iTl+TZKYa4AUwZf
         Bl8U5dxBkaRHc1LsFtTLC1S2vNULrAVQw+Bgh2fPEG8WHoHWcYTvSX5LNI/INv7IuCL1
         pRCpLoq6YRFqcS01mwbquELpCUDOG5JvTOEfuEqYsX4zCURVDhEnngb4rgEdaslfcCca
         oTdA==
X-Forwarded-Encrypted: i=1; AJvYcCXIOhjn/Xh3tcEAPIYjg7aQwdidtRPnqtwDvaCdvxHwBqmzfihI1mNq8XeIYnqNBai7TbsxAnsprqG9KdIn@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIGRxDhw5i5qAJ7aZlZFzMK6biEg3c+ubvLucFQZyrXFrXR7O
	8Jmeqkf55BoYcFtTS+rVHX2wF4upUi8EmRENFIykg011DgDn1vMRdN13
X-Gm-Gg: ASbGncsjhZ8LXghanWqWq8WyCLdTXdpVun6/Wyz7+0M89kHr2KoOGKd7g64IknodB/U
	ZtIb0QI08Zbm8tI6ZRmgVzqRL1e2bGdat/HhuziLNSdwKqmFO9l2fA+VyWkCqg8zpvrr8N14qHB
	KQTTeCP2PqAaQlTu4yMnrQUGSA6+WodIimRvC1iCJ4qe6qpbMldnxFmvAE8Wss9bcdP9JdJRaJr
	PXt+TVvuydMEhfywCSIFECaN94Ge5IRH8Age6fpP3zyVFAhSH1PFs2WOUKM8PflM6bteWKZp/eX
	cifI/7yNr1DP9wUAoMnqmwyokZVtHimAYUrRx6mRaEVFdsT1AI8P1q+K9ZRKLXrdP+eCY3BvYdL
	s8yiRNKNxV+GM+fZMiN5D4CshJ9rCtwjERZMMSlSrnHNuhe0usNcqXnY0w3M7avib8LvHEycn6z
	JigwoJTyRZ+7F2DGgtmNATKKFNyZfPUf47YynKh2/PE9PGLvkeeTB19mnWYJmhoz+5YjS4
X-Google-Smtp-Source: AGHT+IFFa6JfDTmizjqmxfQvOyAEd2lLRtwY0ex2OgZ0+m8iJA/xUn2p1/EJZbMyBxylc7ieBx66XA==
X-Received: by 2002:a05:6214:20e5:b0:786:50ca:73dd with SMTP id 6a1803df08f44-7fc40d25d17mr51916906d6.46.1758808492358;
        Thu, 25 Sep 2025 06:54:52 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:51 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:54 -0400
Subject: [PATCH v2 06/19] rust: cpufreq: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-6-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=2379;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Min9lnjKt/hlKTHKx8DHe+UjEz1oTNKYHDrlD//vrww=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO2LsZad4F+RVkixHdOcMhyCY96m5gE5v9iNO38GMhdV/J/W7PblbDJmxH/UCygnEMUNp04FBPV
 HU86loJ89jQs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/cpufreq/rcpufreq_dt.rs | 5 ++---
 rust/kernel/cpufreq.rs         | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 7e1fbf9a091f..1120a8f5edd7 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -3,7 +3,6 @@
 //! Rust based implementation of the cpufreq-dt driver.
 
 use kernel::{
-    c_str,
     clk::Clk,
     cpu, cpufreq,
     cpumask::CpumaskVar,
@@ -56,7 +55,7 @@ impl opp::ConfigOps for CPUFreqDTDriver {}
 
 #[vtable]
 impl cpufreq::Driver for CPUFreqDTDriver {
-    const NAME: &'static CStr = c_str!("cpufreq-dt");
+    const NAME: &'static CStr = c"cpufreq-dt";
     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
     const BOOST_ENABLED: bool = true;
 
@@ -201,7 +200,7 @@ fn register_em(policy: &mut cpufreq::Policy) {
     OF_TABLE,
     MODULE_OF_TABLE,
     <CPUFreqDTDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("operating-points-v2")), ())]
+    [(of::DeviceId::new(c"operating-points-v2"), ())]
 );
 
 impl platform::Driver for CPUFreqDTDriver {
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 86c02e81729e..43ecdc56cb59 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -840,7 +840,6 @@ fn register_em(_policy: &mut Policy) {
 /// ```
 /// use kernel::{
 ///     cpufreq,
-///     c_str,
 ///     device::{Core, Device},
 ///     macros::vtable,
 ///     of, platform,
@@ -853,7 +852,7 @@ fn register_em(_policy: &mut Policy) {
 ///
 /// #[vtable]
 /// impl cpufreq::Driver for SampleDriver {
-///     const NAME: &'static CStr = c_str!("cpufreq-sample");
+///     const NAME: &'static CStr = c"cpufreq-sample";
 ///     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
 ///     const BOOST_ENABLED: bool = true;
 ///

-- 
2.51.0


