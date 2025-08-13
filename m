Return-Path: <linux-fsdevel+bounces-57736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7012AB24DD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DDD1A27C69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7277280A5A;
	Wed, 13 Aug 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBhjNRjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095927FB18;
	Wed, 13 Aug 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099598; cv=none; b=Wo0SAD8Q+/tXvk7wRXIb1oc3CcSsLeBGO7vtQn8r5C4fWmjN3qFn9yskEviFuuvgxpgvghlzDVXYRsOXb2LLjgQXh3ZJG/5vOeBNLfg/iVMt8GT6wPb3hv8kgAwYWYh1nKcly3UKWNlWen0RPMqJ2Wre7rXACCbAt4qKG8bsdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099598; c=relaxed/simple;
	bh=389zTUeuB5JbibSGFWLgE7LO3s/a6burYE85gcD6ZMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJs+Ge6vRkNFE3N16kxqPfVxKUw5i0bwtZQr271JfXKeVIhwo+GaZzeVhk6bFgNNi6AA+hfQ3s8BYl9t9/WCaU0mm5lmk60fcWluqQwLH0hiPFFCkoqqmPKuGoVfdpGN8ziaKzjC/1YUiOdjWwFQPnmfFWSx5JXkumKNqElMQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBhjNRjM; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e6696eb47bso664586885a.3;
        Wed, 13 Aug 2025 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099595; x=1755704395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGoVOhy4jERd3neINn4TPM8U5EEaP5ugIKSB6mln43c=;
        b=FBhjNRjM36CqI6VFinjl02jPr3aHoqloJi4V+G/eIfGPpDUkjur1rVn+dXJ8mwfUkS
         Nk8K1mXzNBpgzxZt1L4yuokK1e3UcPL6Rv8TySfqDGTrh5fjqb5V+g4BWQ78VOeshgTl
         MKdlcaniJeFF96i0BRW1V+fDyDN1QBxUwy3t/gP5jx2rySzCUZ5DdWHrBH9DvgmWjV2P
         2SXimZ15JxrxYwy7rtFc41p/tAC8NQagdwwC91WBvd9wGvns767ag8Boh/Dv5IIM8OfF
         2FQ3V582guwut0a3J0HFvA+uTDskzMnSPbAPdi5L50kAfzs9oePGSjrt5Zo+aoGPencA
         5pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099595; x=1755704395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGoVOhy4jERd3neINn4TPM8U5EEaP5ugIKSB6mln43c=;
        b=lu+DGz9w3zGIvwzv8Lss/fFFXAh0/MZm8gYeP8MQSTH0Zp/FddiM8qGjJRrWYWvC+J
         Q/HokJPz4Mho1X5Fqtylfx6KV4I+Dp3greW/yzk2DV3UPPU1+KF1QbEaNyAeoLeqWsod
         AKjVzacrW+/YLWsxpAC8mpEglj0KZVPfYlqzK18MC3+cZBblANxNegJBfihuMe2MFfHi
         je8OlGq9EGqU9f+xfFqSBlrJfpUbbeJOJF6AiIKsIAKYX9Sj4PUAuS4iwiHWJz/eOiZK
         v/AtZYMiVObqGWEay6LXZe9HV9ki5Aa+5R+hrGkr5zrzx/5AqPsXvA0njChV/ZSGmuEd
         hJbw==
X-Forwarded-Encrypted: i=1; AJvYcCURE7tQUnWSJ9b01F1G4h8j3Lu+lP5w6kkAyiPSalrAFXvztREfhhdEtj/lRKWUK1/Q26J/UPb8kj7lgVBaIUA=@vger.kernel.org, AJvYcCUUXy0UDg4q/6u8FuNCON+FzIy+sTG2dnsXwBHV/WDuQliVObwP5c2TeJ/Pdqz6mHvTyUvOv0hfUgdnIQ==@vger.kernel.org, AJvYcCUvrUVfmp+BmLnGbh49wWbJq30AGO27QoCAA6TZZns32NNxtyfpZ8XDEXqZEewxgoTD/+cEPTwtV/D4iQI1Fg==@vger.kernel.org, AJvYcCVnEpzvwyJDQaumDh/5lkn/MagSDpVERQWZlDiz41yPGJ7j7YT8quBIWgePr+lwC5ODetEtXPXF0L+BrbVj@vger.kernel.org, AJvYcCXWRmwX7VEKilHooV2DNY59UidOfjQczMhp6PtWJ7ppZFIYOpBo/+1yIpIIpZpb+SpSpvlQ1+3Q9L7XqgElUN6T@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKxsLkLw0Qcu1u7Ic754IJQxEVphE9UwaEqhGuqQfsQU2gkAU
	EemaMSTFsRJCnE8CSrXLzSa8sKUAv7CYqnUZBWYgumcYsqc9dJ62DNTA
X-Gm-Gg: ASbGnctd8MZJdB7RuK720eqMZoxHlY7Ijq9S/3uJWUEzJb338b/RohMDiKQJVdEYD93
	pOZW4EKsqc0TVGMn49VOSmOlLisCBifo3mdLazxsODRGW/L3Ghl/ecjMjJdNlyYYN9QssVvDM/b
	CIXKIb3q122W+R8UDWF1wT2/cjPQmgTgiuE8aBZGtXx1FLdQ13rHc14ehOhrgbVO8+yOSDx7j9D
	Hgh4+fBp90QLTb4Z1m4QKVTtC/DJTN7Xex6YifpH9Ya2VJe4gWudqtYh23x3vg1IB6oqpPNSWFB
	R2NjGfSnjvW5sAokhroUqUOR09WQaoXK9jB+AO1KFYEpvXoA6o7khMqTlNRP1PXydcomcAndjbO
	C6eHwNoMyfrDjKZCq4Vih7ioor3V01O68ZbXlhjIZIJUhMGCBG83Lt4ABC0+E46P5LeCbUP5gW4
	Z2wnVdIQIIA+2wIJqx9nS+amQUt8owwp6OBQ==
X-Google-Smtp-Source: AGHT+IHs0ZT7on5I9bZ1u8GrngyqrpuYHkDBkbdZIYm0MXwjYrSAWt/b+r463sWhhOCkHmkmHHChcg==
X-Received: by 2002:a05:620a:2814:b0:7e8:3324:7aff with SMTP id af79cd13be357-7e86520cfbbmr401368585a.9.1755099595332;
        Wed, 13 Aug 2025 08:39:55 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:39:54 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:39:46 -0400
Subject: [PATCH v3 1/9] gpu: nova-core: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-1-a15eca059c51@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099590; l=2221;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=389zTUeuB5JbibSGFWLgE7LO3s/a6burYE85gcD6ZMA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH/OsVlm0jUqXUwZWz2BvLX/LLKHbQHM91qDOJUmbF5e65uFWklBkvH4AGdcLYQ44WEXJF4RoEQ
 Dbvzeo+QbbAo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/nova-core/gpu.rs         | 3 +--
 drivers/gpu/nova-core/regs/macros.rs | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b5c9786619a9..600cc90b5fab 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{device, devres::Devres, error::code::*, pci, prelude::*, sync::Arc};
+use kernel::{device, devres::Devres, error::code::*, fmt, pci, prelude::*, sync::Arc};
 
 use crate::driver::Bar0;
 use crate::falcon::{gsp::Gsp, sec2::Sec2, Falcon};
@@ -12,7 +12,6 @@
 use crate::regs;
 use crate::util;
 use crate::vbios::Vbios;
-use core::fmt;
 
 macro_rules! define_chipset {
     ({ $($variant:ident = $value:expr),* $(,)* }) =>
diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index a3e6de1779d4..6b9df4205f46 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -149,10 +149,10 @@ impl $name {
 
         // TODO[REGA]: display the raw hex value, then the value of all the fields. This requires
         // matching the fields, which will complexify the syntax considerably...
-        impl ::core::fmt::Debug for $name {
-            fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
+        impl ::kernel::fmt::Debug for $name {
+            fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
                 f.debug_tuple(stringify!($name))
-                    .field(&format_args!("0x{0:x}", &self.0))
+                    .field(&::kernel::prelude::fmt!("0x{0:x}", &self.0))
                     .finish()
             }
         }

-- 
2.50.1


