Return-Path: <linux-fsdevel+bounces-57735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 145B3B24DCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9AA189DBD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F127FB1E;
	Wed, 13 Aug 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIp89+xr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3487276058;
	Wed, 13 Aug 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099596; cv=none; b=Wcut+6sqfwh7gcaTBc4al6SfLoOZgvO9Y4nik8HCcIiLQGKkfufEE7gFeI0/kdVD0hwU9rCxiTErzt6qY+f7OxG3LXpqq4PnSE7Kj4cAxsA29JaEn9fRwAV0dkrm9csEwnE88CF0tlE8UevWjuhp3weNVIz3bnBN9J2XcWki8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099596; c=relaxed/simple;
	bh=pbhmDtO71qVMDCBwFBh7wsmwO5+SFwM7vnisSM+P7vk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rFFwbgZ6ZYPOBiX5j9MYJ5uePJ4/TH6yDDFWt4lSRuH+0LlkthrIStpGao42N7iMxgeojFPePWh6s3eSkvU1o6DNSuD3FXGsu942rPGumZnjIALC7N25YwSzaIPwLXo7LVFYBmNiZikr0oe210iXwgU6as6A5VEsfYwkbjAROV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIp89+xr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70a9282139fso496186d6.1;
        Wed, 13 Aug 2025 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099593; x=1755704393; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1PBgm6FTY47v6gTvWfZBpQMyISqIs23+q0cdOn41Ao=;
        b=JIp89+xrXG1Pl58B2BEsuvR3lnN3tAAd2BTaJU++TArDtGcV/tkuNWEz3bfUZZIdLS
         whmBEj3ruHAQeaNjCW3szEdg8AKKi15SANbQ++wU/kcdXibyVXPBZGcXytXyI3Uolzcd
         KLyj/5tGmtun8s3SwLfdJPgmmwG6nMz7PDKmnLoqTOXnZ+ATzuEHAoiVBZuaMGQqJ4ht
         tQ854hW5M1EgmkkxN1Uu+bt0axP7FgQITqY1W4v4603ix41CT5qWZVOY1owgPcHjNiuR
         NSRzrHiUvb541MTlmHphCXWA5vjbiwssMktEMeKqnNBE8wXjizqb3z24jN9ojKs86bhW
         88rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099593; x=1755704393;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1PBgm6FTY47v6gTvWfZBpQMyISqIs23+q0cdOn41Ao=;
        b=rGEsvpL/hV/Pq5jLau6HoOOWjMxhduwbD/uL8pUIUcDEMiFfwdTax8tyWyr2x+XmLx
         blf6TPVasdwGlA3bVxD/NlhdJRL/q1Wl0Gx5g6DnUCvPfbVKieoTDgo7P5yBqjmFud80
         ooWN8iwWcN1H/rlDaf0X5jenEBIKA9PLw4G7VU32n1hEJ4QG9lmcW6cUS6z0Pw8DPnWi
         4xO7Kne1mJ/985amNeNP2VaR31clrL/tYkkqsmWr1PfPXX/VFeubCE9q+R9Mo0SvRuk1
         dFCWetc4N0BXKGLVZ1DyMELVBQWeKFjD80BrVI3uPTejrqowatL2NpgeDUgogk/TOpqb
         BrBg==
X-Forwarded-Encrypted: i=1; AJvYcCVlibg3FO8yJemclV0541vMyNfjD9ABJoYkm26JzYcA9lemI2gb6JgFdOVhkqiH2eSLznUTzahI8UPRBPq0@vger.kernel.org, AJvYcCVmAURquRVU+61QlkoASfwZ33YdloYeTE76GqUFeaMWt//ZMEVCIkwuZRCfPxSJLaWixODfrBLYbObQbg==@vger.kernel.org, AJvYcCWYNGufASoiiD4fj5F/4HZ957cQziGxTFAMOA026v6pTWsmbDSfsS2B43mQfBNoCnd+gBreYKogRtaQ9vAHn2i5@vger.kernel.org, AJvYcCWiHk7R8FDrvjq/Nq5hpTGsUWwqBij4EiQpeYMNY4c6wBOWhpMeiZyQkVU7OYbm/bEJeTd1bqUmHfugh7X7lg==@vger.kernel.org, AJvYcCXBM0sbb2Ivy3/2lDT/nYDo0Md4a6szZy36qqMsOhoefY4xJgAjPlQEmQXTll/NLWOm9kvyBmJ6Jq0PHrVfXBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtTMlEC/fcxTrkBwSag4EDD/pC03e0aqkwelPcRjzMUBfTsn3
	pwlE10G+M9OHv150oSJGl7A8tCt5++HHa+gAs4cVCuPXetIcjtvUnB0y
X-Gm-Gg: ASbGncstq3hbWiSYjaCbcQ4SgQJqE9ym7WEdb5Di00IvvVvndexz4YM2p1A2SxmXEA0
	uJQWk8wZlMgFv6LXbjTEl2H8p7RV9vBBzCvSygflRBbX8qpBT17lr5bOCiXWM6BSw2wC8IraX/N
	HyBv6XfeP8N9dlAXXe0S7mJXiVY6/EjpeGgCu9txkAO+Gh14cKLQEemB9P2PcRjbWkGw0ShWC88
	Zzmxz/Ef2PN5P3LonuQPeJXt6yHxeTDX1o2axRlGeLuj5aVwndPfQAr4O+pLc+vG1hqgaOSyP/e
	dJWnyAStmyvJK5j6xp6jrnLIsTTG1kIOssbQ8194MiOHuGRyp8E3OsIPaZ2FOpadvukeohQE3SU
	7eMMjqbY0SoURJynqnuA0W0iQz/oSxUj+nb83AyJYs2PG7Fvno+7Lz/jMwAOPSHs6mASkN+wk/t
	M0IlrdOTiRce/0sSE7m5lcT6zFVRb/ns3d2XmwKcYvxX5y
X-Google-Smtp-Source: AGHT+IHyUKVG/mS9LrmhskFBc8fLiX7b3H0/ofCR3EPTyDC9r+OJDyKAXjDzHP16/W+xsxEJ7HTUpg==
X-Received: by 2002:a05:620a:a111:b0:7e8:bf8:abf7 with SMTP id af79cd13be357-7e865280ff2mr499775385a.20.1755099593482;
        Wed, 13 Aug 2025 08:39:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:39:52 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/9] rust: use `kernel::{fmt,prelude::fmt!}`
Date: Wed, 13 Aug 2025 11:39:45 -0400
Message-Id: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMGxnGgC/33NTQ7CIBQE4Ks0rMXAw/658h7GBcVHS2KLAiWap
 neX1oVdGJczyXwzEY/OoCfHbCIOo/HGDimIXUZUJ4cWqbmmTIBBzkpWU2UdUuWDo1oOdgyUUw2
 s4LwSACWQNLw71Oa5oufLJzt8jMkO37IzPlj3Wo8jX9q/H5FTRouDYBWWwIRWp7aX5rZXticLF
 2FD8N8EJILLJm8kr2pV4JaY5/kNFP2VtwwBAAA=
X-Change-ID: 20250709-core-cstr-fanout-1-f20611832272
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Jens Axboe <axboe@kernel.dk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099590; l=2531;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=pbhmDtO71qVMDCBwFBh7wsmwO5+SFwM7vnisSM+P7vk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD15Csr5AV6bt6Plsqpo3gx8mcieA66z2j4+xAajfnt6k92rEjYMF8suWRw/hGcxp1PDPKHJ4m3
 WytRFj5zs2A0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This is series 2a/5 of the migration to `core::ffi::CStr`[0].
20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.

This series depends on the prior series[0] and is intended to go through
the rust tree to reduce the number of release cycles required to
complete the work.

Subsystem maintainers: I would appreciate your `Acked-by`s so that this
can be taken through Miguel's tree (where the other series must go).

[0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com/

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Add a patch to address new code in device.rs.
- Drop incorrectly applied Acked-by tags from Danilo.
- Link to v2: https://lore.kernel.org/r/20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com

Changes in v2:
- Rebase on rust-next.
- Drop pin-init patch, which is no longer needed.
- Link to v1: https://lore.kernel.org/r/20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com

---
Tamir Duberstein (9):
      gpu: nova-core: use `kernel::{fmt,prelude::fmt!}`
      rust: alloc: use `kernel::{fmt,prelude::fmt!}`
      rust: block: use `kernel::{fmt,prelude::fmt!}`
      rust: device: use `kernel::{fmt,prelude::fmt!}`
      rust: file: use `kernel::{fmt,prelude::fmt!}`
      rust: kunit: use `kernel::{fmt,prelude::fmt!}`
      rust: seq_file: use `kernel::{fmt,prelude::fmt!}`
      rust: sync: use `kernel::{fmt,prelude::fmt!}`
      rust: device: use `kernel::{fmt,prelude::fmt!}`

 drivers/block/rnull.rs               |  2 +-
 drivers/gpu/nova-core/gpu.rs         |  3 +--
 drivers/gpu/nova-core/regs/macros.rs |  6 +++---
 rust/kernel/alloc/kbox.rs            |  2 +-
 rust/kernel/alloc/kvec.rs            |  2 +-
 rust/kernel/alloc/kvec/errors.rs     |  2 +-
 rust/kernel/block/mq.rs              |  2 +-
 rust/kernel/block/mq/gen_disk.rs     |  2 +-
 rust/kernel/block/mq/raw_writer.rs   |  3 +--
 rust/kernel/device.rs                |  6 +++---
 rust/kernel/device/property.rs       | 23 ++++++++++++-----------
 rust/kernel/fs/file.rs               |  5 +++--
 rust/kernel/kunit.rs                 |  8 ++++----
 rust/kernel/seq_file.rs              |  6 +++---
 rust/kernel/sync/arc.rs              |  2 +-
 scripts/rustdoc_test_gen.rs          |  2 +-
 16 files changed, 38 insertions(+), 38 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250709-core-cstr-fanout-1-f20611832272

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


