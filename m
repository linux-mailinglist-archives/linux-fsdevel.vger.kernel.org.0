Return-Path: <linux-fsdevel+bounces-57741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62265B24DD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857237BFA0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5712868B5;
	Wed, 13 Aug 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrgTPQUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4B285C83;
	Wed, 13 Aug 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099608; cv=none; b=mCGRpsj1Ri9fLFseB0c0/fpaIvxCTr82TIPTfffQBARxsv82/FlZJWHbRV4Kaj7AXZQ+qAXBpS+/OM0CRbRhRgyC9WYgclKGfndrAMeHD5YabW7kO4Ej5Xld5Kfxbq1dYWNuIdgLEELLTAyKMjFUTcm0Z/k8b5BHO+MnVwrD068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099608; c=relaxed/simple;
	bh=NMYBijI5MjCpRRYFrsF0rVf9eokObKfR9KrctSSofPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6bU1sjhjA5/2eeTGXL0yM7wx3/FrgxyflZaY1+QNkWrVbTg0ZkILbQYPssDEOxd2WVsCmVrMP9EamWjoYtVC17mPem56EPPZ0a31Xyhr/D5MN8V5aUb4PFgDVjR82M4hQsLN707QN7k06TSXuAE6XNw0FY0t3MZ3he5HM7w3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrgTPQUh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e6696eb47bso664605885a.3;
        Wed, 13 Aug 2025 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099605; x=1755704405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKQyJUeEwCiLmV9wAMTey92Pv78BxejTGsU885hQL84=;
        b=KrgTPQUhfgaZDyBAHked+WqXC4bLJV3Pq7YSdDrssCpJzJ12ZvWSPTIneTsS2QvuJf
         /ESHmWOmMQeE7B5LDST+9gIk5OkAzR2w6ltzEZWK9mo52jTLCWeC/SeFv13R2lJkEOe7
         Z5TWYfrqa1NJCrCNTdI7AjyFU8oJocKMxfqVb20hd2SuUMlnsAAu+Kh76dYmh63qckuq
         v/WfD+H94K7spfLSJVcxnRb03I4ikrJYe5gpn7sCQSBLdNt1B8zGCNTgDN5gYMMCZPKO
         PkmWTtqnAxSc3ens4XnMOiH5oy6csFh9AzK6znea2kcu2+7GaGN1r+6+fGLNvd+EjH37
         2BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099606; x=1755704406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKQyJUeEwCiLmV9wAMTey92Pv78BxejTGsU885hQL84=;
        b=QlIcSmz0rjhOBehf9gv70Or2N64qP/eCqGDEtQ6e+Xjx3DVgTq1M5zxryWdgA3to0h
         eRs9DcLA8VgZj3o4pvOctDrEdOdN5o1gcbQdWRV58yKWqeKtrPv75h9EKVbFSyV11ON7
         ILE0R2KSqr+Bf3PTYYI7AntThO4BLtMHCulamxt5Ns8BzrblGLkqRSt6izHUHQKs3Hqo
         JQhi3JuCzA4wHu5ZS0eGNzI3AeUbh5V+d5etpTrPy7i7/lg67V0A079txV5dB7RcQWnj
         ARn5+AXzIzmn2bEZqiMm7s1EHTR9a52fGPFvLNPe4f65ykYy/Gql0e6se7//xr3oNK2p
         dT9A==
X-Forwarded-Encrypted: i=1; AJvYcCUh9Nu5Pyy701MgPRUJcznynbcRNKBG9qzLNYHXNMu6xb5Fz6bYQ5bVP9Dw2xUjBijCPFLtk/r1BK07aCFn@vger.kernel.org, AJvYcCUn+wDOhz64qb9tuSDU8Re/29B25ukMokJomheIdmk5B+X7ZF927TEr6KL+Fnl2R0CFQHK02UwemdcVb4/FCml1@vger.kernel.org, AJvYcCV8i9b2el2mmyGBct01y9Msc3kJXfNbwYQGzoWFV30ySc0t/J7ZejZebYtnubSsEo7u+BUJrfjQcLJNBxMCepE=@vger.kernel.org, AJvYcCWL+xqAxW+FS8kOpBVxRSRv5K3bQmQNh6lXoMgU4JJIs3om0eJvUwacnFtDmoUQ5+8Z9xmv76nDo/+8eA==@vger.kernel.org, AJvYcCXQJhZlS3Uk+vdxlMjM9LKs6wA39QSVGYgF8kdYr2H2lyiD4Ch+9X5qbiAM19zTD7XvHbIpx6+ASnTih1258w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9jXlM68twsY6lH8DR3xbvyqBWSQeOKtL6ej7wnxjVRo4yGUt
	EFrARbPpOw2J3OthoQ489GJ8t/OJLtgPcxs+1os+g28ULO8q7ZChH26n
X-Gm-Gg: ASbGncu8y8JOWQDU9LGBE/C1IJSoVGvCzZLvaZpGtS/ho3rW8ygX1UCnANBqJwD58NZ
	uI3XZJX1nCrifohNXmgeYrHxeFiOWyCGbPVCak6ERTJhdZbzydIE17vIr/liajoTeneG4istsda
	dJid+tb4LroEUk9SM6yIwpzvumdSnd+DbWmHY6OO+DMwZlLXSZmnujQKfzvG9uSpZpukLZ+vXaT
	ZrqYosC3kH86KdHQ6wT3gzjp5PWqZmVwb6mmaPK0/mBj5ZxkeXNo7T3uwpbMlRVmU2R8Dn8Sllj
	CLQ7ewchzt3hhVwF5vgIVRas1whSoIvUlstuC2zhz1Cl1mPhaEik6bAPrme3Tq8vRl32V7K71b7
	ImPZu44KiMzOPZvPPSVkbqMFhxhVK00tSmU6bXY3m2rom404kpBWO81ldKteICXEO4p7J+q7bT5
	rD+nccyEbd2ywChFdyoWY/CmQXU9OdC10sEA==
X-Google-Smtp-Source: AGHT+IG14Ou5jKogZhVRtk4/jsabABzOGdHRDYRyYwlXybd5iqYGKxAQsMBHFwVEi3/l9Z9yMLj/Cg==
X-Received: by 2002:a05:620a:3707:b0:7e7:fafc:c6f with SMTP id af79cd13be357-7e86526c55bmr457281385a.22.1755099605519;
        Wed, 13 Aug 2025 08:40:05 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:40:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:39:51 -0400
Subject: [PATCH v3 6/9] rust: kunit: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-6-a15eca059c51@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099590; l=2471;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=NMYBijI5MjCpRRYFrsF0rVf9eokObKfR9KrctSSofPM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLKIxkqmYjvgREAtIt6jqTnawH9+7pVTy/Un6pR53J21I51aGM8aOXhOurMFKVJYH2NWvrbQfzx
 uG07vM7LPJgM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/kunit.rs        | 8 ++++----
 scripts/rustdoc_test_gen.rs | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 41efd87595d6..cf58a204b222 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -6,8 +6,8 @@
 //!
 //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
 
+use crate::fmt;
 use crate::prelude::*;
-use core::fmt;
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -74,14 +74,14 @@ macro_rules! kunit_assert {
                 // mistake (it is hidden to prevent that).
                 //
                 // This mimics KUnit's failed assertion format.
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
                     $name
                 ));
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    Expected {CONDITION} to be true, but is false\n"
                 ));
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    Failure not reported to KUnit since this is a non-KUnit task\n"
                 ));
                 break 'out;
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index abb34ada2508..c8f9dc2ab976 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -202,7 +202,7 @@ macro_rules! assert_eq {{
     // This follows the syntax for declaring test metadata in the proposed KTAP v2 spec, which may
     // be used for the proposed KUnit test attributes API. Thus hopefully this will make migration
     // easier later on.
-    ::kernel::kunit::info(format_args!("    # {kunit_name}.location: {real_path}:{line}\n"));
+    ::kernel::kunit::info(fmt!("    # {kunit_name}.location: {real_path}:{line}\n"));
 
     /// The anchor where the test code body starts.
     #[allow(unused)]

-- 
2.50.1


