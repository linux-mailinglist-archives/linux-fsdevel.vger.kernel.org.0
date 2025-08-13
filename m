Return-Path: <linux-fsdevel+bounces-57761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5FCB24F0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367962A2C75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550427A446;
	Wed, 13 Aug 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN7CSJh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC228C840;
	Wed, 13 Aug 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100786; cv=none; b=ZR/4mqHCN+pCip8gUOBk31Jd/eDDuLnnD8EaMNqOrhTWOgK0SHW8fHVf0ReeY9JNyCE7AK+NcOH6rygTOtDmMxRPv+5y6GlXh6u42J0YEWZ2iSvWk6qevmyIJLH+PqgJU8tBUlaa8/fC2J1urb1x3AbtruCiAffb8aCuIC/kCEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100786; c=relaxed/simple;
	bh=PmSJIKP9ITH0el/dadPamYsnQlMWQ/txa9zC2kGqUps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qp/k9825SmvKHpIP811W44oUhQd3zcpNz+pl8MTuusu4GHMAx03b7AheGfaKEeZyvl1R2T5DfUx/DxB7AJJTzYEKVtShRLre+SlOgof89HRaZCy9WBGIKvVHfQLkm+eK0s9NWxFOpgwXCiYfja6Bz+gIClu6piqdG8mswrypbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN7CSJh/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109919a09so511901cf.0;
        Wed, 13 Aug 2025 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100783; x=1755705583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3htc3xdxBwju1wGSUcBXvP8f+eCEVOm7Du1GidEXHQ=;
        b=AN7CSJh/z2bnea42Um5sNStyPTt8+sBda8y8KAFxlMPaNslOTv1ogJJ4FqfwtO3EuT
         RBS/KdSzc0ipZXewMVMur2llOgiv+7HuAmsSyYPavyxE/1VG8wbrT7WQ04EzcpTwXsBw
         kflDn+rWaFSoaIq4OY+ld/qdMA0Wpf7H2LUGn9nA8fM81a7jza/SB2SWfRUVKYsaxy0U
         Zd1/FXoInr7I//V6+YtLQ/pkIZkatWGbbKRBk4dr1tbSwnMsJJ7VCTYnerF03dCQU0aH
         3anFlNIyB5QUjFBu053z0uVVUDtVE8XWguOOdE0ETHulYDQ3TL9hspKbu1OxvwXAq33m
         VgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100783; x=1755705583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3htc3xdxBwju1wGSUcBXvP8f+eCEVOm7Du1GidEXHQ=;
        b=FCh5sTUG6F9nRWwudlHEpo8Dy232A8rjUiaq1yA50IEUr87ySdkGK3yP6VfJfRI/J5
         hj4woUqiVwQ7/LsIEMn2Qyp3usKCx8DlWmStfY8KN8AfDK+UZHtDWDn0LGgupvYwhhZF
         FOsudNB2YETpenyKvpfyRRMwfiKJDU0vW5LD1+gMg3RYGglPaZPcc7Y0E5hDejVky4Nr
         jyk2pVJZDaWoToPwunWgNcmB5YOb8Z2GMTcKfgqdi50hLzWtNTOv8uF/8HAYzs7kz2Q4
         R0vfBMqGDInoMArLTPqYiyBAJ5nLxwsqFaF7VnXpSWslUuAOi9Qi29ADxthtVWiiAWTz
         5FCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs1tb8TbVkKsnlRp2PB2Tbwn7Vx9zQz5IYtwv59mcnCPRuMH088QoPhLW4+VmF1m61h5DP1efZZgr6cRNSJHg=@vger.kernel.org, AJvYcCUzPleNkZLkuChc6zJQmHQLcgBMJU0e0G7kqYeR2DstJ++C2nn0x0kzXIVmXfHwyrHNZZtpzlGQXAjaYLul7p/w@vger.kernel.org, AJvYcCUzsVdqoadkW7UZHmKAy4K5Q+RNJgjJrabkkybJmCxAyCUAYjvpoSv3ZqJyj4DZtY8Cae2tZWjyKc4f@vger.kernel.org, AJvYcCVBA1MNUnBw6oHgazL1D4T2RGr0qy8B3OumRAoymEPNQt3EtQ37Fw3LiSetC8HA9xc4fg8yMahKY2bP@vger.kernel.org, AJvYcCVe4OUZ0RVTjFJuDnOB80XjUMzSDkYTIxbgEYmPzqR28oWeI74rfA+0Kubj5Z5/jxFuD9cMaBwxg+QGZg==@vger.kernel.org, AJvYcCWV1o1/LO1qUt+kol6GW1+MLCn1hsdlZwscpiG/9wKZJLCukr1I58ExRMsofn4CikjxMd+yekLnfq0G/Xq1Zw==@vger.kernel.org, AJvYcCXY5lJmtva9EUF+SYzo5sdTcIzPfQS2RAlBySEBFr2swq+fJqjzQ7CZOunpFIOWn6DViKzO/aBw@vger.kernel.org, AJvYcCXpRLFiNeMY8agzBgViB67XMvGS7aWZTYeczAlrF1w5xy53lby4rbNOYkmKnRH/E5CEVrne2EGQ3c6iC7eP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Df4PwXCZKUQh7SAq+LkbQ+uxQXd1X/ZcNU0QF/KSSO4Mmv6Q
	2hQe6n4zsPenjsG6j8qVEcXi0a+wvQYVJV0pKytaBFR7Vw6VQ86PJ7a0
X-Gm-Gg: ASbGncuxWrfyUGWkl/yo5ZwCqltaKsLLp3mrBt5xl3FijYRSOdVN94RzIWs3/z5aOMY
	ZS/+oVDDT5S/QKanWktk52iEBe565lWW/xld+x/6bwM9NAZ/1jXtPPkvtHI7apiJj4eS8ZXDGvM
	rjkwKgnEZk6tbeWJGFwodciFJyPr0zm/IcaABikc5ruTTYB4lixwHvFSW83ktbbQcEhTLVA1d8c
	0X1u6eB6i144G+I6fYwoqb4uUVQnPx6N1uBP5eOneEw8n2xvva9Vm8OIRFadZQV6FUm2Y8R1Loz
	VygOghoyxlzFnXZ22DvBu96IPBCjoftV4RIJY2mRxU0jouEErA3V/VGHka/WU1SculAIRRqo3p1
	seOEwMxLJ+7Yth+D/fNOVQstTf/kfLgCp6Wcp8F7+xOM6r1ytDuMnP59iWTbJcknAvMC9HR/XZJ
	/K5fT8+hYbXluZzXtyuMzR8p40Gjf/c6w5Q/RAm4c=
X-Google-Smtp-Source: AGHT+IGmsxX0kELWnIl4AOAgAiKMupAmKqdo33fAGQtEH9G6dj1HBj58ZUP7RvHy9vaNQjbbVuIMtw==
X-Received: by 2002:ac8:7d55:0:b0:4b0:f1f3:dd71 with SMTP id d75a77b69052e-4b0fc8b9d5emr46748261cf.52.1755100782714;
        Wed, 13 Aug 2025 08:59:42 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:16 -0400
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
Message-Id: <20250813-core-cstr-cstrings-v2-6-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100759; l=2329;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=PmSJIKP9ITH0el/dadPamYsnQlMWQ/txa9zC2kGqUps=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMb7Tw5E0tWRPzZFQNf3SQWWA+44VvrTatP7kJQXzTcRJm+H4iMDqWaOwYFfKj0pe0olEYL99jK
 yP22+o0xYZgQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
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
index 2bdf9ae00ffe..c59b84820684 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -841,7 +841,6 @@ fn register_em(_policy: &mut Policy) {
 /// ```
 /// use kernel::{
 ///     cpufreq,
-///     c_str,
 ///     device::{Core, Device},
 ///     macros::vtable,
 ///     of, platform,
@@ -854,7 +853,7 @@ fn register_em(_policy: &mut Policy) {
 ///
 /// #[vtable]
 /// impl cpufreq::Driver for SampleDriver {
-///     const NAME: &'static CStr = c_str!("cpufreq-sample");
+///     const NAME: &'static CStr = c"cpufreq-sample";
 ///     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
 ///     const BOOST_ENABLED: bool = true;
 ///

-- 
2.50.1


