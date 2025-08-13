Return-Path: <linux-fsdevel+bounces-57755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021CFB24E8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94C57B66B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC12280CC1;
	Wed, 13 Aug 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV4+XO8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D0274B2C;
	Wed, 13 Aug 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100768; cv=none; b=RSA/BSSchTPlcrylmX6+1jyqLRmkTE7noxQHSQvOHZw6w9YR4ED0cfeaVxIoOlMaLJS8lGAuQv2jD85ZOr5XWaTK6a06V7Vwj1ZZZfV4RoAlIMbQdRpj7XbHmeWMVxdapH90gZgYIvyx6HdERFp9J2GSQJ4ZOh3cAekQUjQOfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100768; c=relaxed/simple;
	bh=aHDCE8lQvGzrfp/JMmQg+1FkzUJWoG4yR/VNY61gI24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CFJVvbo4shlAO2fPZvk2OfnHHTja/TqwtnUUd4uhzsSRwQeFD/xQ6gEb+PzuGU0zgwLsQCaeFKP03Bjd1p/D37+SMw5VyxwTiv+VdbWjOTm1C2rmSagu/PHS7IspeYpBCXAFlnYHfGp/KhN7QabvDH2dWlbbMwokPwuZ4HvZxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV4+XO8Q; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b10957f506so885251cf.0;
        Wed, 13 Aug 2025 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100765; x=1755705565; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0whtI+aJ/lwfdA6IBx7EqaGS5GlUE+K1GZ8kbYrGWY=;
        b=GV4+XO8Qb+ayrORqGOfMH7n95822/zxLkHW3NhKfqUHD4eASugyNm+6X5Vubkq+bRF
         e9Bh7X4bEFFKrl9PMWXaS2hdAxJdVXeDBuI/P3KrHG9CzFUf3AgW1v/0Ol/IpvjsUgbK
         eA+rvfHLj4n45bbidgc3L9mMeYGpzNm2Drpl8xqSA/lL0ODcwF8yyOO+hUHx3+CVOHrz
         cnTBf3qYhyGalesn5m5jnCcBddyEluvLcAsP5Yip1ENyaLJHZiotiMwbofq0CDf1VQ24
         hl/5QyW48bc5p841S+0YkfhgqmEW4+jNvePC263gDncunhogN3Eeaf+FB4FAoUwN6G4i
         DgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100765; x=1755705565;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0whtI+aJ/lwfdA6IBx7EqaGS5GlUE+K1GZ8kbYrGWY=;
        b=XOhHg4N4JdxJXHiJ4ZjFVorFK4NmFFxEtjb5u257wNow8iml8lzRaZ8T9MwYsDlOdQ
         6hDZ5gJ8pugrJQfuhyw48UJxLRqBUD9dOHy/hU6kfE/A/CTpCswoQn6q8c0NfmR0uXw8
         qXEJJTSdQAldqgxIeEBPKa1raQ+7RhERymd0PwcqTJumlut2qyhYT22W4kIuraWQXb2Z
         JPBe/8KfIbSXhwgBHG/0eI9RjcZb/jwCYUatUNLbXi9C6K+XHSTf70Trowq/c8uV1ZwH
         uPukz5bF40RhEydC3u1bUtqRQLO/M9soudT/niox1Q8S0/+upZ59HKJVKKMNM3cM8gdT
         6SHg==
X-Forwarded-Encrypted: i=1; AJvYcCU60H3r76dvUnpiYAq6ZpH6b3ijQgcXODjokvefso66FgktrWp5DBxMOQHOVL+q9VzYMm6jwm0hr5Jy@vger.kernel.org, AJvYcCUDcbcroZI9YVKl7Ea6jXlWYK80EnzMDsjrvh98/185FySugDlU6/eqXgEI2USdx4tigj2pU/7ICIVL@vger.kernel.org, AJvYcCUPNIVgMykw9JTWusqSmx18Kd4ttieGsxYax97hrtg99D3IpUXXJ5akc89EwTZD6IGGXQ6gHwWW@vger.kernel.org, AJvYcCVNwLd9XYPVYnMqGXG7yoPaFXcfuBkdTUWP409yI79SjIC2CAOx3yc50+VnflZc/+iGjQANMiFkW9i5PbiNHQ==@vger.kernel.org, AJvYcCVcYIw6W1IyfbvljRUVhnj8E2MSfvBZZMTHT79X1OYgRF4+XN5Z4lFpkWYnqwCh48JjlHPUcgPD+m+oNg==@vger.kernel.org, AJvYcCXBJitbI+eRsYH85y5b16gh3MW0zJLm9Hn8mGjdEkP9WgUnwH7cnHnJQlFeLjlLcvqLb+0XSFdIMFw6f4Cd8rs=@vger.kernel.org, AJvYcCXFwT0J6AVGqaZ4Tfi2YXCvE2iAOguFxIc/sXWa21qZ2Ke/c5ePzbqBI4Mm4/ogQx4pPyxpF1Egy5gjuvx+LDK1@vger.kernel.org, AJvYcCXRf0eUsgVXYmThCYhCnn7tcK3ALNNjKhdhdjSBrboDrPxEEGseYVrQ+NWDLWuoqZglKU8UGAL9k4s0BsCp@vger.kernel.org
X-Gm-Message-State: AOJu0YxOivRo6LKLhlpwfET0npHPOCC6nN8iDPOv7EHJqpZGmk9dVZRg
	SKTJWhY8hBVH/zvJvWqbJRkBcl1kC2VL2AFKr9P+6K2cJuvri7o3vPij
X-Gm-Gg: ASbGncsnIEnKPRtG3rqbBM/TBxKo4FiopTyD7eUzbQbIGreJRWps9bG8IfmV4sHKfU4
	1cqGNPpLCZPuw3s1rcSNsFC4EBEJC1pcikl0b8jG6JaElVvYjR/EefbtGJUgH16eooYfsVFR9F3
	2QItymJvhWTdiuHO3a2OqN26WH2uEBdSWIZBajSPXsWb/1TgrXp94fFdqeO0OHodA88yGuPZHFz
	V+pAIVtHrjNnyhm7mGchALdglPNuC3SbJpuzJBvkzoi9qyjAq/GFdPGGbwZEKS05M+QWc0Cp+lN
	7ym8ChwMP3sIn029j94+6z4oLwFno5aHLbiUShZucnZtEdAAf/RPdMWTYHkAMgAkkeX9rsfaZv6
	GcJ/D/d6t/pi7Z7l3fRGoQF+Jo68LamS4bmrPezuVpUZpvGQVl/4WUwklFxKXDIjOmgmGVf0miB
	Unb8UwDF9z0UxMUvck3c0AReHiFKYhgrUyOpXFsEU=
X-Google-Smtp-Source: AGHT+IH5bKPMcxOfEgPLnp/iCra4Z0v+g72GVh8C9pgOCOpkMw6QX69XzjlmvW75JgEFDH3PQhtWRQ==
X-Received: by 2002:ac8:7d55:0:b0:4ab:67de:c791 with SMTP id d75a77b69052e-4b109b10015mr1017511cf.24.1755100764687;
        Wed, 13 Aug 2025 08:59:24 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:23 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
Date: Wed, 13 Aug 2025 11:59:10 -0400
Message-Id: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+2nGgC/5WQzWrEIBRGXyW4ruVeo/lb9T3KLG70mhGapNVMa
 Bny7jWZoUw3hW6ET/B4OFeROAZOoiuuIvIaUpinPNRTIeyZpoFlcHkLBcpAjSDtHFnatMTjCNO
 QJHoiqkrlwTuRH75H9uHzgL6ebjvyxyWzl9ul6CllyDyOYemKxhviElzVutrokpnB1QBN6chrx
 41nNM40ZkePnBIdUtlxV2qwfFDyNM2XRaJcSwnSaGNR91Zr71+GkcLbc/7z3xhCw5bAtNbgb8x
 PoTtFAd7T7Cin+7avWlRgfbeiEXuLc0jLHL+O3iseMf5Ku2IWAFVrBUx12/KDwGnbtm/CeV1jw
 AEAAA==
X-Change-ID: 20250710-core-cstr-cstrings-1faaa632f0fd
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100759; l=7346;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=aHDCE8lQvGzrfp/JMmQg+1FkzUJWoG4yR/VNY61gI24=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGTTtsiwktq2/jtDQWZ3OsBeIX7b+1AYy/DJLjfLo7rG242TN6+wE3vHC3Ph8gTa/g64MF8rY1d
 RTwisWWbFUQc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This series depends on step 3[0] which depends on steps 2a[1] and 2b[2]
which both depend on step 1[3].

This series also has a minor merge conflict with a small change[4] that
was taken through driver-core-testing. This series is marked as
depending on that change; as such it contains the post-conflict patch.

Subsystem maintainers: I would appreciate your `Acked-by`s so that this
can be taken through Miguel's tree (where the previous series must go).

Link  https://lore.kernel.org/all/20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com/ [0]
Link: https://lore.kernel.org/all/20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com/ [1]
Link: https://lore.kernel.org/all/20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com/ [2]
Link: https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com/ [3]
Link: https://lore.kernel.org/all/20250704-cstr-include-aux-v1-1-e1a404ae92ac@gmail.com/ [4]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Rebase.
- Add two patches to address new code.
- Drop incorrectly applied Acked-by tags from Danilo.
- Link to v1: https://lore.kernel.org/r/20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com

---
Tamir Duberstein (19):
      drivers: net: replace `kernel::c_str!` with C-Strings
      gpu: nova-core: replace `kernel::c_str!` with C-Strings
      rust: auxiliary: replace `kernel::c_str!` with C-Strings
      rust: clk: replace `kernel::c_str!` with C-Strings
      rust: configfs: replace `kernel::c_str!` with C-Strings
      rust: cpufreq: replace `kernel::c_str!` with C-Strings
      rust: device: replace `kernel::c_str!` with C-Strings
      rust: firmware: replace `kernel::c_str!` with C-Strings
      rust: kunit: replace `kernel::c_str!` with C-Strings
      rust: macros: replace `kernel::c_str!` with C-Strings
      rust: miscdevice: replace `kernel::c_str!` with C-Strings
      rust: net: replace `kernel::c_str!` with C-Strings
      rust: pci: replace `kernel::c_str!` with C-Strings
      rust: platform: replace `kernel::c_str!` with C-Strings
      rust: seq_file: replace `kernel::c_str!` with C-Strings
      rust: str: replace `kernel::c_str!` with C-Strings
      rust: sync: replace `kernel::c_str!` with C-Strings
      rust: io: replace `kernel::c_str!` with C-Strings
      rust: regulator: replace `kernel::c_str!` with C-Strings

 drivers/block/rnull.rs                |  2 +-
 drivers/cpufreq/rcpufreq_dt.rs        |  5 ++---
 drivers/gpu/drm/nova/driver.rs        | 10 +++++-----
 drivers/gpu/nova-core/driver.rs       |  6 +++---
 drivers/net/phy/ax88796b_rust.rs      |  7 +++----
 drivers/net/phy/qt2025.rs             |  5 ++---
 rust/kernel/clk.rs                    |  6 ++----
 rust/kernel/configfs.rs               |  9 +++++----
 rust/kernel/cpufreq.rs                |  3 +--
 rust/kernel/device.rs                 |  4 +---
 rust/kernel/device/property.rs        |  6 +++---
 rust/kernel/firmware.rs               |  6 +++---
 rust/kernel/io/mem.rs                 |  7 +++----
 rust/kernel/kunit.rs                  | 11 ++++-------
 rust/kernel/net/phy.rs                |  6 ++----
 rust/kernel/platform.rs               |  6 +++---
 rust/kernel/regulator.rs              |  9 +++------
 rust/kernel/seq_file.rs               |  4 ++--
 rust/kernel/str.rs                    |  5 ++---
 rust/kernel/sync.rs                   |  5 ++---
 rust/kernel/sync/completion.rs        |  2 +-
 rust/kernel/workqueue.rs              |  8 ++++----
 rust/macros/kunit.rs                  | 10 +++++-----
 rust/macros/module.rs                 |  2 +-
 samples/rust/rust_configfs.rs         |  5 ++---
 samples/rust/rust_driver_auxiliary.rs |  4 ++--
 samples/rust/rust_driver_faux.rs      |  4 ++--
 samples/rust/rust_driver_pci.rs       |  4 ++--
 samples/rust/rust_driver_platform.rs  | 30 ++++++++++++++----------------
 samples/rust/rust_misc_device.rs      |  3 +--
 scripts/rustdoc_test_gen.rs           |  4 ++--
 31 files changed, 88 insertions(+), 110 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250710-core-cstr-cstrings-1faaa632f0fd
prerequisite-message-id: 20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com
prerequisite-patch-id: 0ccc3545ff9bf22a67b79a944705cef2fb9c2bbf
prerequisite-patch-id: b1866166714606d5c11a4d7506abe4c2f86dac8d
prerequisite-patch-id: b575ae9ef33020b691c8c5a17bd1985676519e14
prerequisite-patch-id: 8fee5e2daf0749362331dad4fc63d907a01b14e9
prerequisite-patch-id: 366ef1f93fb40b1d039768f2041ff79995e7e228
prerequisite-patch-id: 1d350291f9292f910081856d8f7d5e4d9545cfd1
prerequisite-patch-id: 9a6a60bd2b209126de64c16a77a3a1d229dd898c
prerequisite-patch-id: 08ae5855768ec3b4c68272b86d2a0e0667c9aa47
prerequisite-patch-id: 801be981c2346617fa9412498930b68dc784693b
prerequisite-patch-id: f0dbf0a55a27fe8e199e242d1f79ea800d1ddb66
prerequisite-patch-id: c0b4abb4d44f7e63d002d0bfe5239296930c183e
prerequisite-message-id: 20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com
prerequisite-patch-id: 6711f2a2f25c12784057aa725a9482feef6bb6f0
prerequisite-patch-id: 3b5144133c0e239e0a258c9aa4da0df2dd464e66
prerequisite-patch-id: 589a352ba7f7c9aefefd84dfd3b6b20e290b0d14
prerequisite-patch-id: 2a4b0b9170e25637b9eba0e516863bdcdb4149a8
prerequisite-patch-id: 3d89601bba1fb01d190b0ba415b28ad9cbf1e209
prerequisite-patch-id: 10923aebf24011b727f60496c0f9e0ad57e0a967
prerequisite-patch-id: 9a7e8ba460358985147efd347658be31fbc78ba2
prerequisite-patch-id: f79b8755f3d75effc581d09eafe5725043516aad
prerequisite-patch-id: d598958c2d64dcb56a5cd64b088594be51b1d752
prerequisite-change-id: 20250201-cstr-core-d4b9b69120cf:v15
prerequisite-patch-id: 6711f2a2f25c12784057aa725a9482feef6bb6f0
prerequisite-patch-id: 3b5144133c0e239e0a258c9aa4da0df2dd464e66
prerequisite-patch-id: 0ccc3545ff9bf22a67b79a944705cef2fb9c2bbf
prerequisite-patch-id: b1866166714606d5c11a4d7506abe4c2f86dac8d
prerequisite-patch-id: 589a352ba7f7c9aefefd84dfd3b6b20e290b0d14
prerequisite-patch-id: 2a4b0b9170e25637b9eba0e516863bdcdb4149a8
prerequisite-patch-id: 3d89601bba1fb01d190b0ba415b28ad9cbf1e209
prerequisite-patch-id: 10923aebf24011b727f60496c0f9e0ad57e0a967
prerequisite-patch-id: 9a7e8ba460358985147efd347658be31fbc78ba2
prerequisite-patch-id: f79b8755f3d75effc581d09eafe5725043516aad
prerequisite-patch-id: d598958c2d64dcb56a5cd64b088594be51b1d752
prerequisite-patch-id: b575ae9ef33020b691c8c5a17bd1985676519e14
prerequisite-patch-id: 8fee5e2daf0749362331dad4fc63d907a01b14e9
prerequisite-patch-id: 366ef1f93fb40b1d039768f2041ff79995e7e228
prerequisite-patch-id: 1d350291f9292f910081856d8f7d5e4d9545cfd1
prerequisite-patch-id: 9a6a60bd2b209126de64c16a77a3a1d229dd898c
prerequisite-patch-id: 08ae5855768ec3b4c68272b86d2a0e0667c9aa47
prerequisite-patch-id: 801be981c2346617fa9412498930b68dc784693b
prerequisite-patch-id: f0dbf0a55a27fe8e199e242d1f79ea800d1ddb66
prerequisite-patch-id: c0b4abb4d44f7e63d002d0bfe5239296930c183e
prerequisite-patch-id: 9c0a6624ed7b7e1d0373985c5c084a844e7c49ce
prerequisite-patch-id: e0ca756f740ab0ce7478bbf6510948ba89529a2f
prerequisite-patch-id: 6d8dbdf864f79fc0c2820e702a7cb87753649ca0
prerequisite-patch-id: 7d4d1d036043a85dcbaf0d09ea85768120efe094

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


