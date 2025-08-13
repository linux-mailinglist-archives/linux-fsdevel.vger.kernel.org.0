Return-Path: <linux-fsdevel+bounces-57758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2FEB24EF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1885C397D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5246527587D;
	Wed, 13 Aug 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+Bxw+mB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24C286D57;
	Wed, 13 Aug 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100776; cv=none; b=UJJS9psJI9j/rbaFVTNC69FglH7yY7H455+deXspTHUoaVnDXPXLuSrvQrVFm68IMjtmDklMXKSiRHHspqsXec1rMTggkdjekD/KzDH1Pra1vCxiSYdeaRXZqeUtCA3hTnCRPHssoWX0gkw01uUWes/0+63cwasi0eZ3U5zRetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100776; c=relaxed/simple;
	bh=F2nw+1+uvnPsEnvQVrrTk2VbbpWrYF1uYr4G8N1u7x4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7AZFxjCrmi9jhaZ/J3gDzi+Gwp+hcVdqjESiA7NjBVenqZ9rz2ilgE4YsfZeYH5fGMnqLZTsD++1B/RmXMDZOaFGWfxcvicgPwWx/oo/Eq3HteI4HGfzPxaqCIS9xfXxi+UIpnCZqlRTHYcRw/qDYJ3QVBLkNYs+IcZwOiLP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+Bxw+mB; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b1099126afso541401cf.0;
        Wed, 13 Aug 2025 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100774; x=1755705574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQkqhCR+X2AcT/u+sPVE1u8ILZHP3FwYk8GsseoCqig=;
        b=G+Bxw+mBXNBLXRv7LzBUg987gkV3R9Ra7D6McpvtiORJDLDbLtv11H2iOjmVjkivKB
         SN6O07EY4/sPCMPhLLk37QsYIXtz27h1tCSPXdnGe++sVx3CSkDcYJhKYhx0EjoQBuCQ
         utf84h8VUQMhGwnSC9I37nFVI1ocowMBZ47QleKYDwylth7/9lD3fBs4aLVoTZV5tfGZ
         ctBp92RavnpBQ03CE4vF1c8NIXIU1E28Gx/qmIPESB6TWPac4W13C4+bBw4mhsQg4oJs
         939Bq0+uALmGWsSSD0tu1GiOKzkG/Hy02ap1EqHHwg1UbwJ3V5pgiTR+ucjv6+RQ6ljL
         2IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100774; x=1755705574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQkqhCR+X2AcT/u+sPVE1u8ILZHP3FwYk8GsseoCqig=;
        b=pOq+lOALLHFosKQoZm06mwfYOAfBmKI3E1chQx74foeqFOFNsoVFaL+U8A2hs+PU1p
         YusURxrw4lCkgcdD8P8Z92stWeawaUCSeP4CBttWXiLpKNG2hRr2bPSVef4bxzYGxnX7
         l+G+edx9Hl64ryFfs+/9x9608RExwaqIh2apEFEKYvLlHutZaDxF59XhOJJHEeZPLBe8
         51107GSpsXKH3p6s7Ghvssq+OVqUa+N7op7Ypmc7S1JBunMV603oZe9KNr6bHC0A+hUV
         mk0NFHXVJfxjakBjEO1qm4Ny/LK1MT6vBoqOY+KF8TGiffVOabUkFW6OzYlkLMq6VOBA
         RziA==
X-Forwarded-Encrypted: i=1; AJvYcCU+yk5WeB9i5yme7x18lrXLu975HscO6tPoFngaF5vLLQHQ0a/+BvggOep4Hp69XZ5nvYaT9O/ckxtDBQwFIA0o@vger.kernel.org, AJvYcCU0fmu41jab8k6Bg8p5SAH01vzoS3BdFk5YFmFggD2k88PXSSMUQz9wbQvcshjkPNSeUsuFedgZyvVxkA==@vger.kernel.org, AJvYcCVGRvtnLVO3Tx3Z81vtstGYkrrFPPuux1O4Ff9v2tPwpMOswfc+vpY581yn+1gfTo94RgA5+S7WKaZd@vger.kernel.org, AJvYcCVGif+4ud5xWX5ux3oRpDtuxRQPZtx5Rg9kIyGw01vNrtIY/71UIwOI3DloKvRgH19HsEpAVcQmtgAa+sAkYz0=@vger.kernel.org, AJvYcCVzIpS53AT6QjLyxISYAfkUbKEOnGP/JGRmyEXGGxt+fZ8GJEa7DA1SPFvuZoUe101xOnVLAhNwjM2I@vger.kernel.org, AJvYcCWfYhOlTFXEcs/RWaK0L0NIEcnUWgbV6TNQmxuLxSY+ZfbSkI6LBwPD+aBga6zivDp1iTb5PeyHWmKFa4jl@vger.kernel.org, AJvYcCX8GJ3OtpZPaycu1j+5OANEm1IVIcfIOmxh9+zI5hJ9dNA/rNVY2hCIEf+yZFMve/8PIFZlH80gqHc4lfvMMw==@vger.kernel.org, AJvYcCXVo88uTfa8/n6i/fO80fK9m9gUq1CZWDHUua3HCk1hEyxFQaUuBKmd/KnPSf6Pf+N81NIzTInr@vger.kernel.org
X-Gm-Message-State: AOJu0YwglrGQs0ryitGAlfUFcduQ7ewdub46CmDEAVBUGBTvYA+lgKvt
	ypT9jxWHGZL/M/U9e0IkRu33r5XqeONGS8f2THaSXyLGgsEiuYLkkABT
X-Gm-Gg: ASbGncsUyKSrUI7vsOg228fzAjv77pi4yio4Th/sX0eZptxL3AmA3wYFmiK3BFmVzli
	OrpJUcxZ1+XSyvTDd6DmdfffI7OgeLTTsTla+yzIWNBDB3c+OJXh1plLFE9JyTlxWUyhwWbHjiQ
	61ZQycafZeJoCmv3q9SmA6u2CHEhoXtewFqDKHIUwDxaglnVayri105Mf5lSeTtPV5bo8zSQVaF
	jvKC48w4TOzMj2XkZ4XLELsGoAzaElnPjWMN87KGvBropbPzaI4jq0bs2AXVZ3PreymDH8BAxqH
	Ye5tHYsdeCqM5fUDu2F76z7LN5RVfWnBmUOxWrXjkmLmkkfkuIuaPTFNuxN5NPx5O98Vd2QUcJS
	j2WiJIFwPWpdO9oTv3D82pUS0k89/cF00pqKFbMyKjaUTnPanj4r1VVENvoM76SK14YWPZ2e1fU
	WAS1yLHOSEaZBXiiCiWwXbBg3YrL9F
X-Google-Smtp-Source: AGHT+IHZq3i1a9XTbFXQTxJJeihLgQb42x6jyJXFxK6dZtNdBD0dLMgXlffMglfu4O/TMFdzQ1T2Rw==
X-Received: by 2002:a05:622a:549:b0:4b0:83b4:5965 with SMTP id d75a77b69052e-4b0fc6ba555mr47290341cf.14.1755100773657;
        Wed, 13 Aug 2025 08:59:33 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:33 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:13 -0400
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
Message-Id: <20250813-core-cstr-cstrings-v2-3-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100759; l=1276;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=F2nw+1+uvnPsEnvQVrrTk2VbbpWrYF1uYr4G8N1u7x4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGMx/5kaMnlNTrXaGDrsiX78ZIRKLC+Iqyye94EgnMxhSsrGEv9tVHC8fuvWEciKzlDqn7iENLx
 rBu+o34IoWwg=
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
2.50.1


