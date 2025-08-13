Return-Path: <linux-fsdevel+bounces-57737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC5B24DD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1575A1B61EA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB82820DB;
	Wed, 13 Aug 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijRwty/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0428000F;
	Wed, 13 Aug 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099600; cv=none; b=AppO8JBA7ZmrxvxTgcNyxpgCTGQFIk1h4Vo0rz3JrByamKvKcvHmqc1+LuR2YuXzm78UU3FsEW8mB347ghrrFt0EAnVV0zruMoXpG7qHiFIxqTDUmzI3kOEQsI96SGGSLh/QmspB6NVj+adApDCZWPZGhSelUymtDMjDdkTK/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099600; c=relaxed/simple;
	bh=PSL4iigvbqQ2ksUQBIiw94ADQQA5vnHuf37BheuwWG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lS5xnJwMEuU7PRsTQ4xGrV+xw7np3srwcbdDW3KSeZNXGzkeKdDXzWo5YhsU2cEbrQ6VR0Oy0DzBQ496tqt9+MAOSRp9It7w2aGISQs7YeocHmc/Do8XbhKs+IPTd7nibziweujMt2VrFQClDlVcP72dSOMv7odE6pY40MsD4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijRwty/s; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e80ba947cfso667986585a.0;
        Wed, 13 Aug 2025 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099597; x=1755704397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8zwWmF5N009AGIXlDD+XsD4K4+mEgy8HqbF8g/gLNE=;
        b=ijRwty/st5sHfOJtI0bg9CEzQmNMNJlCiIxLfs5wAvpPj/A7gtWn3LIyXjVsCt8HXe
         pzkRM7hSdj3vtrjmkM4r80+G/xMhCDEjOhWYdoWMtRlM2pDkTT1ImWo1zh+frPQw9+d+
         UTdGVbTqB6OuMmUh7VPNA+Soe9ppnyJIiKV/AFa6sKxaYr52nd2Dlv1L9CVuJKvYVpvq
         Z1zYynWDwDQ1Z1h4kMN8FIxJIb9CEFpSBvN5fw2SjLwyG5ldhQlWmxZtHDSZzDHbuBfr
         ZnKQoPtMzTuBpCd0EdLcQLOzpnZAJ3ljMB9dSxR2z6aZFLo5Hw9pymycylVvTWCrdM1X
         /iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099597; x=1755704397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8zwWmF5N009AGIXlDD+XsD4K4+mEgy8HqbF8g/gLNE=;
        b=q50JR8nR9gpvYlLwv3oUfvD0cul/pC3lj3mbdIKSNiEOIRo6zQGoSvFnkD5x2AzXzB
         RTMUbUrRqrIxCvTiDnnBE2nbH6BGPxSIU1+xE2UCaDiJphYA/3deJqof9tktONyunx4n
         32Ne+WyE4CHK6rzeh67Jvcpe3io0mbxlxu/pTNvUL3XdIpIREcYhaj7BFvb6uCX+Hu8/
         UcJ5EvUEI/TksnZcj6Z1rpvLDkQU/lGUDY0WjvDMn/t3D36vChbJFgvFhqf9CvQqHExx
         JXmQSISm78FLAOjOooOWyIqqOsMRVQudNCIj24jtgNhRDlCTlJq8D82jk9s9ryUROTCu
         GfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKBPGuBNZ9Kw08sJyql/bTcB0VxUVOEj+ha/pFem0gx9EaZnYebOoQyCkg10X78eYleU/6SpITfJAQQA==@vger.kernel.org, AJvYcCVSezZupcI+fdmTCC/FOc+Yk9ZN/ktWVgFHGqe6q6cAfZHFoFrc8rwn+g085K6bsBhZWT0+dJ5kml6TDt1FJg==@vger.kernel.org, AJvYcCVb4XZbG/0IDNJkVI2XhR2UBzFa37NnhkkVeKmm97R+QcYc1E0QaaEzp7IJvN1B17N3vD64zmjv8u7U/ypTwXI=@vger.kernel.org, AJvYcCWAYUQjykAbQBvVRShU24RoiJyQKKFFPsIacDsxzBsZoCyZs8B6llS3sVgtPVx4SAqj4kbE5gYcJby3nVAQNDMb@vger.kernel.org, AJvYcCXU9gA4Vuhmq393QoUfL1/7NFRRqiOLI+tlSRRaXRPPUySfQ1qXbFU32vvFCJfipTfT6/UCXXuCTHko1CSu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78BW46Nq8nsML4PTfzNJFBK5gNrwSjhWk1VX8BmgDkPgc3imm
	+2A8l5waT3aUQTNLwh8BuPqdg1SbL0odHaoUngVnoIkyjsbbY+CbbZoU
X-Gm-Gg: ASbGncvr5dGUdHxoq0SjlqXxLrFMwFX/mzHqf01uGAjmmwvO2xJUURCioSr/zoZZQGe
	ab/+Tx0O45GE5s5eLn7Jf9Bn+cNfHvSc48ctmpC2YKPU6uPNpnEgBgeKBtP1iFt8A8pZUnF/6gp
	1ZQvAvAUG8y68DQBs59DgDE+FRMBJxArJDzeXtsnEoycpD/jdGspyqWCIxVf7xuOKAVnAFBitlP
	Viz4ZyDKScTCBZorm7+a+hR50AXjjEVClLkqW4RnEGXCQ6F4auMa16pO15wXPJRd5jsNOT9sLfP
	GTT7AEDmANQZjRKrce8WSBl7mT4ACDePW5QC5hY+TCYZy13HgV0tAZQn1uAhhu7mx/spVDevhk+
	3/CjzFoBwKDOCXPy5vUMyds0eOT+LYSEs5Poyw8dIVpwE81AWo9LaoRpQh/CSlHnXP810hf77HA
	xAMD8mAWpbrpDWsFrQTMARNXeCN6T3NqhmGLJw1WrOo0FE
X-Google-Smtp-Source: AGHT+IE1pby1TNrlRmqWtTqCTDZQP1D4c39paDUDyEiVNPrf/2gtoMRUjpJ7cXNWJtGfePDy+14ROw==
X-Received: by 2002:a05:620a:8a83:b0:7e8:21ab:2846 with SMTP id af79cd13be357-7e8653207f2mr294256985a.36.1755099597290;
        Wed, 13 Aug 2025 08:39:57 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:39:56 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:39:47 -0400
Subject: [PATCH v3 2/9] rust: alloc: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-2-a15eca059c51@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099590; l=2090;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=PSL4iigvbqQ2ksUQBIiw94ADQQA5vnHuf37BheuwWG4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN+HYlLAYPrUuy/AnIupocmwcDxEYQ6EU0tYcePMf7VZdJcmyQEaJoOPoXUfzoxZjDXIW6ttbd0
 6E4kkz9lOvwo=
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
 rust/kernel/alloc/kbox.rs        | 2 +-
 rust/kernel/alloc/kvec.rs        | 2 +-
 rust/kernel/alloc/kvec/errors.rs | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 856d05aa60f1..563187d09a8e 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -7,7 +7,6 @@
 use super::{AllocError, Allocator, Flags};
 use core::alloc::Layout;
 use core::borrow::{Borrow, BorrowMut};
-use core::fmt;
 use core::marker::PhantomData;
 use core::mem::ManuallyDrop;
 use core::mem::MaybeUninit;
@@ -17,6 +16,7 @@
 use core::result::Result;
 
 use crate::ffi::c_void;
+use crate::fmt;
 use crate::init::InPlaceInit;
 use crate::types::ForeignOwnable;
 use pin_init::{InPlaceWrite, Init, PinInit, ZeroableOption};
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 3c72e0bdddb8..4a1b2c26209a 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -7,9 +7,9 @@
     layout::ArrayLayout,
     AllocError, Allocator, Box, Flags,
 };
+use crate::fmt;
 use core::{
     borrow::{Borrow, BorrowMut},
-    fmt,
     marker::PhantomData,
     mem::{ManuallyDrop, MaybeUninit},
     ops::Deref,
diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index 348b8d27e102..21a920a4b09b 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -2,7 +2,7 @@
 
 //! Errors for the [`Vec`] type.
 
-use core::fmt::{self, Debug, Formatter};
+use kernel::fmt::{self, Debug, Formatter};
 use kernel::prelude::*;
 
 /// Error type for [`Vec::push_within_capacity`].

-- 
2.50.1


