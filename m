Return-Path: <linux-fsdevel+bounces-57743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F99B24DFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160436220D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1BF28751D;
	Wed, 13 Aug 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBDS44ZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91656287245;
	Wed, 13 Aug 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099612; cv=none; b=jEMA/Qh1mKrB/LFyVKmynb6/4jPdbwJspP+V7GzsfdZVhb0OaBNj+/iLcIpSRizvPIGSO1qricFIxI1hHvHg6dkAEwWDBYW/Y3TuOx+9zp7HlGJSJcPXRtYwDfljadj8bpAaFVZkl/cUkKVE3H3JWuYTnaCEXccyW558MFiUxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099612; c=relaxed/simple;
	bh=GRf55CBaIXfcLimWiztzt2WPB2t4kstaCplsKmlIKbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CI0jWZJzCN0wYTIZfaTwqb9pMKuAKl4KtgS3Z6EdJ6lkdR2aZ2yIjrK5WSGBW979cj1c7hQo6FcrxBaFa5xn0k9759apdbokr1e6WIxtR7u0OhMqUkhLu23HuVjKEbMDaj1GrcVu36sWut7N845UVi4aY5051z5DyV3CLiZkLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBDS44ZV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e8248b3f1cso820957285a.0;
        Wed, 13 Aug 2025 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099609; x=1755704409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Txy/cJf0GBJ+o0igtkYkmxWlbfspCRXzkvSHCuYjmpk=;
        b=nBDS44ZVyWsqhl6ehnXII0K9hY8sk3YCRB5CDFMkTPtkEBksBjNhI0yn2dGRg0V/ig
         4omm9Wun7hOyzda9IWRK2L2gKBJWRTRtCEgiMJx04ncBSHRk5DIsnVvZbNY6YhQGnnds
         vouz0DUOIJa3LBZkTyvEzMrNuHuCXqgbKJT3HN81MOLYqX8ofih4wUg7t19nRskSDUYk
         oHctLDwzYe/bXd6CHvkYE+l33vPtwPHMTufqbSkLtFd2mKlB6BYW9Fut/EA3SxJp0qBD
         kiO+ksa0yUmVb/wvuyt1IksetPp3GVHN5QBNJaMZ09V/eUjwnpOOWsHRX43BY5QC6MdT
         YIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099609; x=1755704409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Txy/cJf0GBJ+o0igtkYkmxWlbfspCRXzkvSHCuYjmpk=;
        b=abalbJW24rkQqU/AsTwNVR8XVSomnfOX7/vcmv3VCdQ6S3sDAFZVH2PFHTVBieGO+l
         ZV3hQEK9i9FhPQyD3lNyi+q5v6bc2UL/AB9se16vc6OJpWQLM2AgJQuiT2jFMp9VcOil
         jnCO5JfrwdHu21HHKLwZ8RDqZyxS1MoziBtXH2tfJVq6aevkE8E9Scag5BSFgujiWAMz
         x0s2y3ooH8X8AxvSFNd54gjWea/aKZQnz18YaCk5csP7LEofhIA4dv0yuu60snKuJ7Dw
         47QJKXYWUtdYh/pQx39n9T56jkFNrgEmhbvghf/KY3NaSqjhZk+sl6JjG4F4mdFRw0le
         AzbA==
X-Forwarded-Encrypted: i=1; AJvYcCUhz0xuRzazTjPy1kDAB9zPX+moyvQrt0E/vgFo4EVOc9OrHJn0+cZe7b4E0adAbgWNVw6kMp4sWX1/LEXX@vger.kernel.org, AJvYcCVAL4x4Kx3WrhF5QQItB26/lc9QMzoYDh38lnvcewOSzct4iGUHXCfg7MwbqZI6Re4ATsZS0jMIQWvx1g==@vger.kernel.org, AJvYcCWEDu+8snZAN1SbzyOyM9SPwcr7dzQrzTU2UiCxWAt/NnDrT3SFeU8xEFYzd3mkq/wpvBaPVXe0OdrkPEdOeQ==@vger.kernel.org, AJvYcCWNIt/KKIdhXZwGdkGUrmdYlqsq/iNM7Q8tESRq1J6xkSDyPLD7P9FaQZR6DqiZ1oE+80/HI0skfV8ucOvWGbci@vger.kernel.org, AJvYcCXhLtmky4oWUXPkyYywceH4/6vnd+0eX9NpyzE4biYKohjwb5jNSChyUmkT7ILlU82Gctix+xi+P0wzBjbwPjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4b5J2OF689Jz49lhw9vGOoALiWkenvBvlSnu8B8zwkqVsGaSp
	f+sebnKiGLd+6N2KVtMRWQj5fhy6Aj23UGYM07jbhApBu0olK1ftyXRh
X-Gm-Gg: ASbGncvF+1Mv5etNjpkdCGMhVLSQ7LgdkYNj2zrgAco/OUtAF3VWUbOVWHsLH6xKSQR
	CBWfaYF3pvyJyYRvFfG7qrW/Lw2gVDzfBcEkokaQC8xoTk+ZOoBCwBS8kfjZXKykRjLzIkpr6yw
	MTp/aO0Ao2R38mv7eGkaRnzIrq/tTqNGSQB3ggn677hdNGRdBXRO9Fh+3nFWARSL8TTfjcJdqfP
	8GoCOqf2jouMKbVTYUc6mUsJMq+F5AdeDQ57G5d52AxY72GxPHPUTMB9FEo0ZIhrnk45d0jrgQi
	5mfBawCkrGA9K+lUVe+9UoOJZ2jMm934s+58mKoR1JTsGN8GZu6RtQFh206RZYKHaGaJpVdhGRz
	Xm2J3s6I8RIEj3dAevZDyVgur+IeuzGXTSAGe7LdcJYme5HyphK7UeOUKt1ArbA7N6anvvqsd13
	Tw/nW1WuH0iX3l3itZXY1QnGZkKCYuXnyXhA==
X-Google-Smtp-Source: AGHT+IFxJagWPZZZ2hzouDkHBzhG5TPmQTOcmugjvUWSzlYtPNO6sC6jEyzc3aC/S1mkWUBCIwCCGQ==
X-Received: by 2002:a05:620a:4897:b0:7e8:21af:3d6f with SMTP id af79cd13be357-7e865276f4emr408733985a.17.1755099609321;
        Wed, 13 Aug 2025 08:40:09 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:40:08 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:39:53 -0400
Subject: [PATCH v3 8/9] rust: sync: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-8-a15eca059c51@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099591; l=998;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=GRf55CBaIXfcLimWiztzt2WPB2t4kstaCplsKmlIKbc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOAIUsQflz2HGM4AvRq77QQJYK6O5RKw6D4n7a/7jWYfKPgD+405KYQHwXHJu4uUN1IVy1k31PV
 2UmoGqrCUOQI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 63a66761d0c7..4f3c1c2ff05e 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -20,6 +20,7 @@
     alloc::{AllocError, Flags, KBox},
     bindings,
     ffi::c_void,
+    fmt,
     init::InPlaceInit,
     try_init,
     types::{ForeignOwnable, Opaque},
@@ -27,7 +28,6 @@
 use core::{
     alloc::Layout,
     borrow::{Borrow, BorrowMut},
-    fmt,
     marker::PhantomData,
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},

-- 
2.50.1


