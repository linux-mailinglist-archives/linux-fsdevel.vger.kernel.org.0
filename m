Return-Path: <linux-fsdevel+bounces-57738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F96B24DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8021E18839BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8B283FFC;
	Wed, 13 Aug 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxqiin/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D228312F;
	Wed, 13 Aug 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099602; cv=none; b=Cqlo4oO+Gdlbdt88xrCRMNoozui/kOXWb/vssRP4ORLUH6lmInK7Mj87Itr3WRAeJQak+tf+190A9m2vOcMBnuVsehBW/7/ssjERpVTGy9uAjG3OxM1t9yWvCmoYOmcrK27fJVrrIj3iyaFbaEou+v8WLsWs/P1AWVN36Gg4q2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099602; c=relaxed/simple;
	bh=af6FE21/bV11TzZblZrnYjzjw1z2PLK6stOqUBZ4ohw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHGFIsuLkwST9NCdtNNy1AcGjXbmyqyZDamq6FOQmqnqxafZxpVjBsQ5wEdFz3t0M4AoPKBAi8z9CWyWLfcYkTR4+x1clL8l5WwrPxmPVSvmB6YZxQEsRJ+0om3eJRUyV3ZJtKKQNtW+16wzRDTl2ZEYysINuWup09DoXYsRO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxqiin/s; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e809baeef7so736315585a.0;
        Wed, 13 Aug 2025 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099600; x=1755704400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoILmxC+s8qjLUlPIig2YwOCGBuLO0IARaqVpLKdXqs=;
        b=Wxqiin/sRn4csfQAjPud0nUqlgEGPNKeVTjWvQpL5Y/P3jnVWB150NZjm1L9gKnwGx
         hormPyTWoRGZCPHTwDOOKzXhxGWVAmjUv6a1E0htPHSbkK8ydTd4k2dD928755t0beEV
         FbRd+l+L3PWbBInQy194AEV0Vsscg6KEcDbfKJDjRyNG4PXk3AvmcI6EM30X5Tdbwwsr
         o3/12jtTjPkPNGltP45QwZEF1O5qpp7OdQeUemN3xviMNJ1qZNd18YsCgh9ZCHRBQVRB
         Xh/W0UFGXw5E0JBaW7lwq+jckZtP7f1ND+Uj1v6UyRUufZdahX5Gsx29j6JfnRGBNN1L
         4O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099600; x=1755704400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoILmxC+s8qjLUlPIig2YwOCGBuLO0IARaqVpLKdXqs=;
        b=HtwPegxhyb6uAMquofLPf4dplKCfGiVqGXCKxoyNB7HrfFucqJEPI3fQoAYaFfdO+1
         L317K+QG3MrMvrvLAlRURK128C1A/5R5BJukiOKiq1zKe+zbO2Q7AGJd0bt42v84VclS
         c7RDuX4LZB/GXbpKNbSXbKlEiKbzU4Dnr6RPwJ8rSu+0werbRciexBbHAJVGZ9nLg9im
         c+zv/kdEyaH5mZsjTG+agkL1kRBX28o8eDvrDDl1MEj0bnY0d/p9P67NHMbMs+yJ10xs
         69kQT+MtTGBEgSjEvrE0Fd9w2t8dZUY3trSeO996AhRUSwctEHtaUjR1GNWWHXA1IvH8
         BNrw==
X-Forwarded-Encrypted: i=1; AJvYcCUH9nNGsFIVxg7KYIxDqedLBIWKa13NDemzNOQ7tieQJspX2ntGLjy3E/hTxLqxBA4q4f3vaMPL+yHuyipT@vger.kernel.org, AJvYcCUZ+riX8nLXJdIKvacegUE6ZFrRVChZBFtmdrTwFoslbNxyqRppGWA3qOTnSc8VxA015QgAIMLrBNM5XuswHZ8x@vger.kernel.org, AJvYcCVVPMe8LRmTz3PAhD1DdTrZTkD3ANF6ILXnqXuVCbz2Td6NuVQWYynoFG0Cfglxs6XJJX8zcOGbsm3PwA==@vger.kernel.org, AJvYcCWe5kQcqp0Mgsw/xtU9SY00snat1qSRxf6vYJZDjw43wdKju1P4MzFlgMCt3z6Imab6gK8XKYAxyZVBgaDchyM=@vger.kernel.org, AJvYcCXGEZHlo4hkrafSK8nFVGIp2D1cHdbH+hOoZmvngxbvji67VMYYFtLoZn3j54zOmGokYVm4Kj+eP8zxHlkNfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YziX+CKcU+W/HSU9HWrb4diVP5mBRudPXPkyCuQjQv2o5MDUi//
	2K9nFIrRh6f4LiSyt7fEjF05MFjux7xZECLx5OJvg32LSCGtKzIO2nD4
X-Gm-Gg: ASbGnct8ImyhH0qBjrP3xzAtijtQFnizGIhr+V18qUqiX5a4zJ3Duoiiyh9KTE7UAZz
	Ka2jgylWGm+422Qiyq0Gexm57c6FggqNJ2+TuvX4gG4tV7HsXoDPKb3ksqOW3Wnpgz98Ut8+xo6
	cuWMfydWU8gtmBHHi9MOzK69e+ekC0ce3inQfn7V2UJrUStBA8o+UTuTX2VLIkdquSqYdMye8CF
	UKHBDqJcuWfmFL0dbexz9Pu3UxrcIM0vUPUtBpH3s4lEIyMd1VdDyppgKoYE0+G6PWo/bkypck2
	xqxfQNjsPOqk+nmLHIJeJw9q8wAxBD5gDmZdnYu78KuMNPE8n8UsIhQpLQ+3vMoS69TIKeX3RqY
	tQMbGEPkh31Z2HgKuM2QtNkipuPbnUvvtPu9Hqas1S1elaNx61P1Y4p47Sj738aSjWVbg4pfb9D
	9zIuE/o2ZsG2MSQ6k96XxHJi5V12wXPnhTYIa8OWBEs/OH
X-Google-Smtp-Source: AGHT+IHJTBTQsKJ9J0icDqWPfLqwUQt/F8t0mjlt1AUtpFI3OZp9iuL1Mfx3vEnp4RBicKJJchksRw==
X-Received: by 2002:a05:620a:9174:b0:7e7:fe10:60ac with SMTP id af79cd13be357-7e8652dfb35mr381227685a.33.1755099599634;
        Wed, 13 Aug 2025 08:39:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:39:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:39:48 -0400
Subject: [PATCH v3 3/9] rust: block: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-3-a15eca059c51@gmail.com>
References: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099590; l=2915;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=af6FE21/bV11TzZblZrnYjzjw1z2PLK6stOqUBZ4ohw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QND6ryUce6zUmM6RgxlBBczQVu5n2eIQGV08rFnIBp3j+aPyM2w4SbFr7X/VFxWqv4YqG7uQRhM
 UPVnePCfgnwU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Custom.20formatting/with/516476467
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull.rs             | 2 +-
 rust/kernel/block/mq.rs            | 2 +-
 rust/kernel/block/mq/gen_disk.rs   | 2 +-
 rust/kernel/block/mq/raw_writer.rs | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index d07e76ae2c13..6366da12c5a5 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -51,7 +51,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                 .logical_block_size(4096)?
                 .physical_block_size(4096)?
                 .rotational(false)
-                .build(format_args!("rnullb{}", 0), tagset)
+                .build(fmt!("rnullb{}", 0), tagset)
         })();
 
         try_pin_init!(Self {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 831445d37181..61ea35bba7d5 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -82,7 +82,7 @@
 //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
-//!     .build(format_args!("myblk"), tagset)?;
+//!     .build(fmt!("myblk"), tagset)?;
 //!
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index cd54cd64ea88..494c95623b97 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -6,9 +6,9 @@
 //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
 
 use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
+use crate::fmt::{self, Write};
 use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
 use crate::{error, static_lock_class};
-use core::fmt::{self, Write};
 
 /// A builder for [`GenDisk`].
 ///
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
index 7e2159e4f6a6..d311e24e2595 100644
--- a/rust/kernel/block/mq/raw_writer.rs
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use core::fmt::{self, Write};
-
 use crate::error::Result;
+use crate::fmt::{self, Write};
 use crate::prelude::EINVAL;
 
 /// A mutable reference to a byte buffer where a string can be written into.

-- 
2.50.1


