Return-Path: <linux-fsdevel+bounces-57766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB2B24F5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0065C2F70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C03074BB;
	Wed, 13 Aug 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrQo4qCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5DC2C1592;
	Wed, 13 Aug 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100804; cv=none; b=CBMxoBe2cjHUFv0LsfGxS4hc4uqkh/UonFeq0tKvBXp/f5iXvr9c0vtjk99V3hRnvc0fVvKfbB2VoOJa7ioGVbPZ1aXQz1gUP/92QZRnixnM8bDdD1pUzhW6+a0w3KxGbl2JwdLU25QOw+B9G/uU8+w641L4LjZEG+fyLXxBsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100804; c=relaxed/simple;
	bh=FCC+E1xmBS2zbIJe2GHcKx3NU/Npdnpc3auNCZaC3ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZ5J4hNsIOrxJBCovNPPSWt+eCvLNXbARKHn0wuFAza61+uiMT5uZ/6IRrMUYMIgKadcpS3lestSZ5Aca8IHplOzwQcZ8blJjARZ/GxTWBrRepQUXoYsCjI5mVF6EAoA7tbi7LLjjgbDrfbhy1V5AuXrE+UcmqoIJzLqkv/ar14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrQo4qCD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109bc07a4so171321cf.2;
        Wed, 13 Aug 2025 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100801; x=1755705601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/OjcvLjUPzFCyg8jVNcHhnvtjPK+Ol7GWEqlUb/j7Q=;
        b=nrQo4qCDItaZZOSit3zGYUqYMDYf4x9YzMs7T+IzLahY92o1DwqMw+Ct+dyMT02PP4
         vXw8ksRuCgF0HSS7rFgbkWQreRvIX6LtOUx68ZOFdbn9RQScd9FgqvCW4+HsP6z2YZec
         lt7CaoA7WB8UisOLYg1cXRTV566OuqZ88nnrfU7pJyc+vV3mmqhMJutI9mQQdiz7kMWC
         n7M1Prjjk978c8hYj7lJjZxnqyd4+W67ZCKAJExcNnc86N08pJlUewRJwKEqbSPposrn
         17UVyJjEvzvav/zPYKccT7dPVFl5+JvEQGXhP+pRxW7tCHo4BreYbiWRaWy+sdbjIF2k
         Rvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100801; x=1755705601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/OjcvLjUPzFCyg8jVNcHhnvtjPK+Ol7GWEqlUb/j7Q=;
        b=YOhAwt44ggpfHkKIj50sHvWPZiVuAuYmtL4vSw65PT854Tq2DHYafLfZMjqsSGj1mx
         N3oltEoQKKgLSp4SqQwHH/H2bSPhdUDcCIFHkh5qJkf8NN5956vwS3ghDW13CMF3aEtE
         Z9tbgW4r1avqflVjrwshi1D/DhQoVAUIy9tuqL8KYluHRxc73z6O0IlabMMwVfUlJZ76
         d39/tl3F91paom0zgxdOsFDbvlwzgrCB8uuM6q8NHWIpvV/xECEx/nSc2zdK01VlQlER
         ILW/jxN5HGYOyK9qQjhIkgtUsES5NY7HOVyQaovkno8PcOYiSiGpjqtt1W7nldXniBWk
         lViw==
X-Forwarded-Encrypted: i=1; AJvYcCV5IQPJUoEJ3azCUv4a/B41JJw4c8fwmYsk3B6izhPjHMJ8nieyUh7iiYSpUt5pi+zeJaLpx1vGwx0B@vger.kernel.org, AJvYcCVIV/jtoq1gNhRtcaJgQvZ2+PTIytdixrfaoA9GbVbCqPjdCyfND8fybAf2rK+nEkmBEqwK3j4holSisfL3Nw==@vger.kernel.org, AJvYcCVMqrun2W/QFhmR0mo0VYxZ9VZA9KF5ITvLsIBsW0mw7rBPrTbDkZIyM7mv1K/9W95P4fgOUmlC385mSNYDKTRQ@vger.kernel.org, AJvYcCWF6QMiwuCd7zHN6CUoAuZnSwKKw7uOf+7VN+xEkN89jdUWYs985kSuNrzIaBmn3Tm5yE4VK54Bdf1Wpg==@vger.kernel.org, AJvYcCWZxVRXiyOc4xFeLe8SBZ+0dvxQeBJo/JdF0SW9a6+IP/h2fgSmQ1v1thIVrVlTSQNiv9DeHUBUU5lVPbrJ@vger.kernel.org, AJvYcCWnjnDJDm2FE6D0bmQPxp3R4mRU5Xbp/H8xBrZLhx+mtezY8Em0MT1Iq7K2vYNeVAO5Wrmbsdr9@vger.kernel.org, AJvYcCWw+vUzvUY8FWA5fN346vZpyDrBdYoSGj3Bk2SQYzVwwysg40Bh6rPw2+56lAMWcDZ4ipga8Sspr8qz@vger.kernel.org, AJvYcCXN4sGt3/evTzmOTTkSu3Y1YdddqJ5a4UVInsC8M2En3icb2ymjsissa/KestALsrAESsI8itBDuiv/uIz/3dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUE80cl//9Ei+RUwUiqU58HENo5AXNE6Dh3XizF2DSOaq+akS
	nx+oVgqwUQO5A1/LgH7N3c3f+DwClU7jXUkV+pKkG7OMGiKBF15IFKRB
X-Gm-Gg: ASbGncvfSiFkKn0pBg+9ssRdIYzvgeE0BUWsTMSlNycdiU/nxlIroDOjARyaFlWN4wq
	aNDSKe5l41XMRaWQujWQBgY18bZBu+lBwp65iZ0b/nyH5V2tllLiH61hYXFSv1WXk2LskuO0cej
	PsIDHS98I53qOqFJSgrpMZaawCrXLTYB9RZ7kw3hX8oCDqwiTFxjYbPvoejdLCcDqWFPqVN4Pqc
	AvcAOJbLavky12XZGMsxFtKFEc27JUyj71qb0jFYfIuAUZxMPLtUED7ctHtR5Jviq2QZti+GNqG
	r1P0R97EMUBx98p1v0MzFVcgQHFa+jNTAasA2SKn9RTEwop3YJvlo+cZR1fyvpM0YNYPQOU+evP
	BedxXPilWQhOzc3D2t/+EXQGLRVeyKPcu+H5iOOCK1wLNCLzRMvX6J5nMsKw6eu2X7mt1LU3+ib
	barHpWQh9ulXIWN1iXL2JTQ6yXl+Nc++8p7TKP5E4hQPpiUWOz5A==
X-Google-Smtp-Source: AGHT+IES7vk4zB0ZC/D3qMs7OTSn5Dxg3UcQGWucgQyc/Iq4csLIB9eF9yDnaBryVWkEjj/KjEl1iw==
X-Received: by 2002:a05:622a:4d9b:b0:4b0:670b:f21a with SMTP id d75a77b69052e-4b0fc6ee628mr48601731cf.5.1755100801145;
        Wed, 13 Aug 2025 09:00:01 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:00:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:22 -0400
Subject: [PATCH v2 12/19] rust: net: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-12-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100760; l=1712;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=FCC+E1xmBS2zbIJe2GHcKx3NU/Npdnpc3auNCZaC3ZM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHkm7OAhkqupu/r01/ORPl+xGRNBHMTZfNmyT7G+V9MYSoET0dRfxK8dFo7H47XEnCgLYL8iqa1
 2FXZUDQ0x/AI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/net/phy.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index be1027b7961b..9aeb2bd16b58 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -780,7 +780,6 @@ const fn as_int(&self) -> u32 {
 ///
 /// ```
 /// # mod module_phy_driver_sample {
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -799,7 +798,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 /// # }
@@ -808,7 +807,6 @@ const fn as_int(&self) -> u32 {
 /// This expands to the following code:
 ///
 /// ```ignore
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -828,7 +826,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 ///

-- 
2.50.1


