Return-Path: <linux-fsdevel+bounces-57777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D33CCB2520F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76FCA4E5222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2AD288C38;
	Wed, 13 Aug 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krZ4uNQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510C303C86;
	Wed, 13 Aug 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105852; cv=none; b=BJZ8hyNO3pnGS87P/OPtaItXf4ZufrQZZYpICHz2BEGYcmcYxf1oUgwpQ3gsku+ZEYB15vmUkmNbdOEPZzkRX9gm+xmGNU18P9I7hHS6GnYQWb8747CuqQ7/Z/w1W806whGMZ3ZyCWm/3nPcBvO4OC8ZDMgafebkF10zcnaEyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105852; c=relaxed/simple;
	bh=kInu3WpIUa5ivvSUVJDySAyzqDy8m7u4hXMISKjVg1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVElJYdwHoKYeMMSm9iGJbDzsS/TkT7TxxZ8cN/qzspiqRqSzU6zC2/cTBJPQgI/+yFka4vr8HcUUzTVPdNZ7IEtkjpGsPGZfuj/1doU+h+YV0reoIUHCqsG+CnWoi/lYVpW8Wp3CbZ6yfkRhmVhiRN0EKFwQ7imm3Qj4QvCDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krZ4uNQH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so8012377a12.3;
        Wed, 13 Aug 2025 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755105850; x=1755710650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6QEvKbWqHKl56z7lqO1CQDa/mVnlY0njSFi7H7FEMM=;
        b=krZ4uNQHILzrTkEyymDA/5z1xRtpRr+mrFnNkdxxhCFkJV+rVFNFZg6htlfQAbeQxr
         zJdN7D9lXqye9TJZYpbKWpJZIv3m/XgnWsYIhH9dwVyWXDbiGaee+FkSS7xm2kDjnerh
         ulQ+DBvdOpn/2WEd8rBeMPxqxmvTqcS5tkhT7ZQq9TLqiY30abCIHy57TpoOJsHFWm6J
         wcBwaw4gA3VdiNIBoQ5J9VjRd9IDNevA7T7PpZ5pt1x/g637r+PBVO1Hx+Uo1WIHc3qk
         efSh2BZlLuTuqQUyj+LN19SwhFa5qib24B8esII1MjBeF+HP+zDkVliIFot3WC7z6drC
         xZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755105850; x=1755710650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6QEvKbWqHKl56z7lqO1CQDa/mVnlY0njSFi7H7FEMM=;
        b=uuA2MHpm+V1Fvyr9vs4rFwhSUI8z6uN2/fudypyH0xpzAWd5R5P8539vGy8pfR070q
         JEi/A/JZMEht7dVz7HvagX/PJNUKlhj48SzVHuBqFGweHewRmXYr7frXa/VthNCHUJQD
         j1ji1VXCEwOZRQIQGEHTKMxxM/VWwedAnQAiX348dP68NqTLzk5o9YHGRBKPifyOGAXz
         pab0lkAiu0pDUPm1IgTI3SrULdwhrseKhhOxotrzq+7eHDgMuzPv6pdyufQLI8Qgy6Iv
         XIhXA+JeuRNnzq3U4aM4PrBSC4CJ3oNNE+JvS5TGVMLuVBO5O1ZEaGlJ90EGDC5leFty
         mPMA==
X-Forwarded-Encrypted: i=1; AJvYcCUGx4CuQ8E6Cd/R31I9VGL4BQAYSoky1iqTW1anzmris+61P43n7JsHf0FqlUFFsH6K9EuIEMsG@vger.kernel.org, AJvYcCUX7uxE68SFsntCFuK6NBigBco4T1DvjASViZw+1Cb2xsmkGOlQ4KiKkIr3UCtqbiy6BJetSDFgxiAz@vger.kernel.org, AJvYcCUe6LAzHD8MeMUR2cLQa1D/KyyD//JgABTB6dUIqOpqjR67LCGJOJAD9bOdC5u8pyDaPRIoGq6Cg18IZ5RpCzYg@vger.kernel.org, AJvYcCUvOyjUC51dx8v4NeijKGqcjsSWtSq03dHKP6rxynXa1DWtN4OeItfehow8oS1re15L+UKSAjsnzPk9V8u5@vger.kernel.org, AJvYcCV1ycBlkBT6dlsnUgeXEqS3UmafCIv/OHj1Q/mQLxVXCuggT1rTEH16a33awlfILW9AQjIWHKUZqT5f@vger.kernel.org, AJvYcCVjvCcnMbCd/hpxCCCBX45IwAy7/hiHLWrbVl02ssKfeJEjaUEV2JtCsIbLKyfmKIIVyyjiuH3rPEY71Q==@vger.kernel.org, AJvYcCVtWiOWaAMqXXOJW3grvSwYWOwccvHpCwUI25XcQb9YSS9e21lX3GxZa0Qgn+zIOyumReuxVOdmHtYx25QUHnU=@vger.kernel.org, AJvYcCVtyt+SmFd1d6S7ERR3SN/Bh5PdIqNjY4iwSG41cBy0r/YX1Iy2qK82+IhxScEuoq9btRopKmyeYkCyWL6N3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ9UXxh9bLjp8+8q7B37QZUX1id+b1PLGz/LrBujn/DVV/lWRp
	UZkSoh8ZVuxzEZH0F3ulhEqZvpZMBJcmy/VVsAwQQK8ZcLB6Dg3fqx+DnPbf4vhp
X-Gm-Gg: ASbGncu0Ml6aL2dGHRLmURoLrfQT5e3asWAcCCVdYjjNE8HdOtG5v4rxHSTLUtKE/nV
	L2u42Ju/mGMOs9bKJzGpQ1hSZjwBubyBnEXd0aho7YN6eHIdbCCF6V3ZtE2Ur5YrkOZtDtCwDux
	RC4HRtJjfQNyxQXr0G91yviZLIZHF7k0QdQX8fBNyETpeyexiSMc4GHttbVNPr+Jl5IJpDwfaW5
	M/0/vy6s2WJrG6n5RoGUMoFWMDOtfjx/p7oO2trGbGUy73ocFaFTrG/I7nbxR8t48Ye94moJWnK
	03tePGvd7u40BHTnwTz6H1fKrA1f84X939ZveLsH31MGsRThUgmiMLLAoJOo2EDnfwnZnGEPc/U
	TtArgI3kYlsY/aM8jXPlK806xVbdWWcFLMZ8GRZDPFKivLkgB6zDcF1J52a12+Zp1SqJTPVoDrB
	wL+NgtR2NEue1UJWdS1CrxH7d3KTQr32ki1CyV/X0=
X-Google-Smtp-Source: AGHT+IHzxOT0e51q9GMbCoQJQmA1iOf0AGvoQCtni9f1rWQqIeUQheFiN4hAfvpXA6DN5Xlkg8xgDQ==
X-Received: by 2002:a05:622a:1f96:b0:4b0:e6d1:ef60 with SMTP id d75a77b69052e-4b0fc88d5e7mr42154561cf.59.1755100798179;
        Wed, 13 Aug 2025 08:59:58 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:57 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:21 -0400
Subject: [PATCH v2 11/19] rust: miscdevice: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-11-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100760; l=1136;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=kInu3WpIUa5ivvSUVJDySAyzqDy8m7u4hXMISKjVg1o=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLPeBqFF3G2/b3iHg82noX65chkInTWyugikz/odK+rtAeYGjZ0XZ8DXrV1KFAOJaqwd30EdnIK
 Svg+beZiy3Ak=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_misc_device.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index e7ab77448f75..60ab10b02574 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -98,7 +98,6 @@
 use core::pin::Pin;
 
 use kernel::{
-    c_str,
     device::Device,
     fs::File,
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
@@ -133,7 +132,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Initialising Rust Misc Device Sample\n");
 
         let options = MiscDeviceOptions {
-            name: c_str!("rust-misc-device"),
+            name: c"rust-misc-device",
         };
 
         try_pin_init!(Self {

-- 
2.50.1


