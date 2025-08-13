Return-Path: <linux-fsdevel+bounces-57762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17BDB24F02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90AC1C25F7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38E4298CB1;
	Wed, 13 Aug 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqD71wrY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3B290DB2;
	Wed, 13 Aug 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100790; cv=none; b=GnxoVDG//j6MhveOutA/Z6HZpGRbYQ+2b2hoR0wr6kWJLSuXTg80SbHqW5b6zjajXWAWJvkFXMAz1gyFwuj3k3pPCnOgIwCcu3rxmXhejgdieSZzn09QScuCfn+VaHcs6RfjHD6ynuCrufnzNjl68LyDXkNTZKyqYgdJQGnja+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100790; c=relaxed/simple;
	bh=FPYWOVsji3ixX2iS2gVF/tvnt0qaiqF7Xfo+QifuOUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/lIBaZAjiXT65ftXr9gepbItYTDJLy9nfpRXieLd3G66pfq0PW/5BgVTDM7FcEbBRiepRCgI/ph5BaQKo/MDG//TLGqNgj7bqlulPoCS+fmg0BYD+iO+i5HtXZsA+mMv9z9pdhpk5MmrGJFXCck51/Gl2xosaKkMTlvAWhUBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqD71wrY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109c781c4so175971cf.3;
        Wed, 13 Aug 2025 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100786; x=1755705586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ds0sd9CSyQTd+8w9NdPNI+kGfpLQ87PIjaVbK8R6JG4=;
        b=SqD71wrYKoOQoO4SJxPIQUW7qzL5ysGlQ2BzDpcRDHJjfeizAYMuXmFKe2TvMkFBvi
         dtZe3nVsMaItqC6kULj1ASAScWVPkBiiFo7114E/AEfeNdKYwxsd0yfC38m6D0IXeOVz
         pFpf7itgzny+kIoFP05DX0SadZ4HlGZw5LdNSTHd1YXWoc9noVW/B6LqRSwBrTqW/6dz
         LKOwi4jEXMb9k1iODeB7ru7hnKvSJY6iTWxN1MCHIAYI3zhKvu5n/DOCXxYed7uuOuC9
         95o65mjRIddweqOWAr310Bpt2Cge8sOk7sRHDPxHfsvfyKCOp4RpWxAUhiZwgRUlDIKT
         VG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100786; x=1755705586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ds0sd9CSyQTd+8w9NdPNI+kGfpLQ87PIjaVbK8R6JG4=;
        b=SZX44Tt95Aq6POfaFwunql/QarP6uD527MJZouE6knJKUhtIeHubOtJlM4Ls+ATLW3
         wsuB5njQjYMi0StYBdBgvX9AB2dxarfqZM2x1YRsgOhNz3CfTESXm/ODBXC3x1uvklPu
         IvnzaYBcqxmXSqACtDhqw0blsRdXSkCJ0awdZR8+tYDTPdQr2ufj3NzslTMpyA860EOB
         G/jGt+S1/m11exRnzo8nR2+HZWCpOOzUe8yVzFjqzQB05Hw7skGMRYB16J/ctYyuKaNX
         ng7ZgtqDx68jLClz8Y7gLpf8peNWJ0U+sXgnJc74L2zti8p8Ab9hbLNFAzcS+rZrKtJA
         Dqxw==
X-Forwarded-Encrypted: i=1; AJvYcCUvFdd3ACDjikdzw0TgFjODxMJtRkbaZzXXObLvGPnOMP1mG7rUvOwC5+Ydh6+iy7FlxzSYkSPBB7oY@vger.kernel.org, AJvYcCVAXhAZRqL2YE9Z7y/geNCYVHgRXe9WIgUdyjCHtFweucpPispkGtSSAzF4vOKR0nQGnxF7NeY0@vger.kernel.org, AJvYcCVDvXCFvIdk2otNaDX2wf0f8KIgstSq3QpEQK7fhadp2uIxbFZdghlCeH5Eu5VvCXuU88tS//aSkKXawxLp@vger.kernel.org, AJvYcCVHJTUn6KOI3/VGCTLo++zGfimhgkL7M1Gqbid5+Y5q9ZPU0NOZ78eBSh07WL7qV6CiGTLZvl6D6vxu7F9f45nh@vger.kernel.org, AJvYcCWohKNCEn3+fCVEHH6EQJyJ572BFPaOtG/40/+sI+laGXN3DxVGLpLRUzDfdxlP02rP/9r8kWU4Db6E@vger.kernel.org, AJvYcCWrTRm4MVKW++qMENX5ulZ24tFd/vp6DRR39T0X4paiN5fFhKhBIY9bg8q6rcs1qIC/F0PpG5tFXlkqun+DYQ0=@vger.kernel.org, AJvYcCXRzm2VdiLB3SBviKEAPS49tfcOzAO2JBSZh82rpYRlXg8ZjpzN3XxcBaeu5Jnx4hNAXbYuIlvtnq1DoQ==@vger.kernel.org, AJvYcCXoK1dYYLjTRxTOA+i69OkFAiMgooSif+gFDWCfZc4B8en7wtRZmrrmZjIMBToMY65Aclh6BX3ClXbdGmkyNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFvg83Oq0okhJcx3gqHikOQYTl5rYUafBu9b3gB6n5OKa9lCD/
	JnPbUb8uazZ3A5qS9j3e/KZTz+YPJWMTnwKDexlGTOPMe4h6aY00qfhU
X-Gm-Gg: ASbGncsg4fX64scMG2p466rMYlsC5eqtE/jlkZuIOx7xKDKGOKJuBhhIy1qnwOTLpp2
	t9uyz9aESdlfSmvojkIDW5xWsQEjyLxrIErUGo9Xloy4/nr95AKJmaTI1zSDfgf+5OW0+5TzdiW
	Hb+OuQWnsm1fWE2Yg/TeYdUl4AxuNiv2u1DMaMrPPMWMVrnngAYmTrm8GFonftODgEOGJNmspfr
	8Ir7ggcwKYV1XdrSINF5yJ+lhOtvKoquTwRd/xAYF3aujnrCZSi/Z8EIem3yM/lyLDjLEvVlYOC
	ElwUaA4tGXzdt4OG/CRXTDvOc7dEwwSXzSWvmSN+6D8HQRR8/Te3yy7D0Ma8/Op5H5wWBFs0MEx
	tul4R0wbyNkotP3Miye+hWFHowx7xEhFkU8asI61N5k7p+SkoRzgcSmqATQM9jJchur+hfmyDZA
	hetWAxr3i9wSwiAh97utwhqiAXHmOAiSEZK4w5dhE=
X-Google-Smtp-Source: AGHT+IGzmio4gQcQhVHqdVVj3T/dp8/AnBV2SNRMYaPtvVI0BMHcZ69oZYPC29RV5DhuQIaBmMWhHg==
X-Received: by 2002:ac8:5a49:0:b0:4b1:e3:7f66 with SMTP id d75a77b69052e-4b100e3871emr30995001cf.4.1755100785956;
        Wed, 13 Aug 2025 08:59:45 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:45 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:17 -0400
Subject: [PATCH v2 07/19] rust: device: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-7-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100760; l=2297;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=FPYWOVsji3ixX2iS2gVF/tvnt0qaiqF7Xfo+QifuOUk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNa4PcugqYrk3DuJ2Yn4vXySgpkZdlXpGXwDr9pq0jCPDnN1yG3NSwir9jXLBspeW3iRBmJ3qzJ
 EgNU8dPTeqg4=
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
 rust/kernel/device.rs          | 4 +---
 rust/kernel/device/property.rs | 6 +++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 449776474044..ba83cf3624fd 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -10,8 +10,6 @@
 };
 use core::{marker::PhantomData, ptr};
 
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
 use crate::str::CStrExt as _;
 
 pub mod property;
@@ -265,7 +263,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             bindings::_dev_printk(
                 klevel.as_ptr().cast::<crate::ffi::c_char>(),
                 self.as_raw(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>(),
             )
         };
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 3a332a8c53a9..3eb3f36d66d0 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -178,11 +178,11 @@ pub fn property_count_elem<T: PropertyInt>(&self, name: &CStr) -> Result<usize>
     /// # Examples
     ///
     /// ```
-    /// # use kernel::{c_str, device::{Device, property::FwNode}, str::CString};
+    /// # use kernel::{device::{Device, property::FwNode}, str::CString};
     /// fn examples(dev: &Device) -> Result {
     ///     let fwnode = dev.fwnode().ok_or(ENOENT)?;
-    ///     let b: u32 = fwnode.property_read(c_str!("some-number")).required_by(dev)?;
-    ///     if let Some(s) = fwnode.property_read::<CString>(c_str!("some-str")).optional() {
+    ///     let b: u32 = fwnode.property_read(c"some-number").required_by(dev)?;
+    ///     if let Some(s) = fwnode.property_read::<CString>(c"some-str").optional() {
     ///         // ...
     ///     }
     ///     Ok(())

-- 
2.50.1


