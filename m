Return-Path: <linux-fsdevel+bounces-57739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C221B24DDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D31E1BC09C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A1C2853EA;
	Wed, 13 Aug 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH6+hJEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB0283FC8;
	Wed, 13 Aug 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099604; cv=none; b=cYo9groVbpiRUlAdW+noBVppr6laK+j2OgSRCEMMNgsTLUH94+cm4ejwq0xf3kd/jggfRBYvQxDJ9gtSutQDNnD7LFTRuMZsvuLxdYVlr20sdE/jaqoqqUIzC/NQoihKhZBA2g5iEojmcP2R/cWxo4iUJQYciim0zyIpLEuFuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099604; c=relaxed/simple;
	bh=l5FpEcw0uQYnPs0RLtDbZfxzw/E05BYYCtB2nhqouWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxYKPHI3YIV+kOmK7GTmRJXuax3R1/pK5nGLnENF23jJlVSXK49+1qX0e4DU+IS18FJx9hdEDazt27OCbRzVIOlE+xoyP1T0XJS61Nb3US0cdnf86ryyAFNJml+qYP4j8nH6jdwmOi1/Ieu0FC4O+6Z8oRlIUx6bGkOqtkKoUBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH6+hJEY; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e2c1dc6567so443840485a.1;
        Wed, 13 Aug 2025 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099602; x=1755704402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRfZ2w/4F4Ea9f92rkBZAFGpsLi9iHZG21wugvWYEpw=;
        b=DH6+hJEY9DPisitJAsRfDHXF9wgfsSkcJ2XySPyTwmTe6JquCRodPdgetdhsYdocTy
         LRtbzS0m/reZE8/h+peIJQPEDqwPRRLNcHbCV8exTrNGFFuWgdceiXy7v/zJ7z27aTBk
         3zsdddShcAtS5hYUvRTij12CgZkUVmFCqTC/dUx9TReUbBgO6NjQZWFATMa909PRiHv/
         8hvGtCtA8WCTTk1d+o7AIX1n0gsS27NY+VkK4YE2Pk79o5ZVfI2hyI3dKZnHe7Wzj5d+
         G7iTEwr2poKWF3oiiFb/pj3k1PNkR7zYX0h3n2Az40Uf6aOyr2EthFAj7tIzvx9rXO6h
         FwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099602; x=1755704402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRfZ2w/4F4Ea9f92rkBZAFGpsLi9iHZG21wugvWYEpw=;
        b=dlmBgPMYk2GIBBIEszN2dAgA5xO2F2ltWZwPL3+dactT820xZU1BwfZc6+9WLvJJs1
         zOmlcTN1JLcO9WcZ0GPJHAwb2kHgg8iZcG6n8Q08cv9vjh/NxlHSEix8pvExCxwbZZwI
         iHl/o+/LFthk1cRCxNfOAR2lBItG2RVgwe3M+MjPnbCvJlhkwt8uiQ0fBQlyLiyMNepL
         9YMONMu0W4UAmgA5564vUjPVoGwmhhPnRRvbBNPSHGEFwMcm02O+l5YNuoz5pLWLK99o
         jz5EWxpJO946+AhthlDewskzM/Evom4Vp+I37XTGJkAw6x0qOEEq9UMp5gXh3FzWdwYs
         RccA==
X-Forwarded-Encrypted: i=1; AJvYcCVsd5ktslQrG/0CTB+uA+B7Gnijf31FxUlCBnirF683PE7KN84txWN6TCv5NNMvQx3qXn/3gXejekSPHLPh8hvq@vger.kernel.org, AJvYcCWXxNCMTHDTsD6JDtMqla9S6pgPrUZ6nbzbO4JWcaa2ZABDPaC9y1g5wvMTIT6TkobIoAXjFOVDpzQqLA==@vger.kernel.org, AJvYcCWaiVgdntYNsK5Wnyyi6iUrLhE7ONlWJO7DJTgCB6neMtvWsAGg+UIPFGPmrSAHnY55TaLQMRgD1hLmt+STxQ==@vger.kernel.org, AJvYcCWu6NyiiJUjkQR8J8fQQXIyiw/akPHGJGEAkVLaJuqk155z+M8L5gQ1z6ZPsTfOgxiueIMA7rj1VxCSzb9eYAs=@vger.kernel.org, AJvYcCXiD8GYWUWE5zPXYtq8KgnA7JaREeXpzvBxhLHUgJRTYjTe8XWHhHnku30cMrCYJP2W2b5VcqV4HQXDnyaV@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxtAZUJgB5GBO7Z9EkUUPEnoSnqVEyCyG1TaZdqBrIZBxwTVm
	dPF/K8bIBSDs6LRcaG8p3aJAvsYb0z6nTUQCSo7yoJHKChpGjGij5Pxv
X-Gm-Gg: ASbGnct3zQ4jgX0O1ii92hkQctlz/yBqJd/LYFhKsWUGyknd2eMGVJsUgDsaWNNl43I
	bAvdayXNMo2CcvrpTaKlWJSCRngXk5sJOVQZ5t0e62BUL+FUomfjoOSyhhdj07W9TKNfBKs4OOG
	5TNScON7By6r9yb4nE2Ja5SHmQ/6ko5ONBhuCYIcsoEhdlJPec715SoigOjZwR0tI99DEbOn1JS
	OG3ICnLBo0sYRex5vMdILaG3G8l2YW6v9NQxe+b4hQZWKxsuGKDN4bybTYimoyB8JBcyuHrzvsH
	n4L+fmXqqhpqDnqD+Ytc6YMDiV6uQZy/mRn2pyYXU61m30ahrJYwnN+5l8v3TMSgwFfGA1MsSR7
	Qgh038MBEEt1JM3KscbE3DQfO1bzK7sMeJHYv4uc/VfW9lwNvH8/0qhLY2T3BXVk/VR+gpvOGwF
	YVfazI7C4WZxuw2pSE+IL1CpPpkBmuso5qKek5mAdKk4x4
X-Google-Smtp-Source: AGHT+IHc3zRAl0lkk0iybOGSsFCbiPVspNuo1MJksI72/kUVwI0EXzlGYnouroXpZFiNdgcqWm0lKw==
X-Received: by 2002:a05:620a:4001:b0:7e8:3a70:795c with SMTP id af79cd13be357-7e8653782c2mr475868385a.65.1755099601681;
        Wed, 13 Aug 2025 08:40:01 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:40:01 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:39:49 -0400
Subject: [PATCH v3 4/9] rust: device: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-4-a15eca059c51@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099590; l=1289;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=l5FpEcw0uQYnPs0RLtDbZfxzw/E05BYYCtB2nhqouWU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QC5C2cxbS+6RI0o5ytJmwUqcqJ2t/hbVRgJ5waZwP6iVwmKa7NnILxyeTSEYvFBt+Rv1Lv2ql5F
 nY/Gb6itHSwo=
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
 rust/kernel/device.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index b8613289de8e..65306e77d97d 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -5,10 +5,10 @@
 //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
 
 use crate::{
-    bindings,
+    bindings, fmt,
     types::{ARef, ForeignOwnable, Opaque},
 };
-use core::{fmt, marker::PhantomData, ptr};
+use core::{marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -435,7 +435,7 @@ macro_rules! impl_device_context_into_aref {
 macro_rules! dev_printk {
     ($method:ident, $dev:expr, $($f:tt)*) => {
         {
-            ($dev).$method(::core::format_args!($($f)*));
+            ($dev).$method($crate::prelude::fmt!($($f)*));
         }
     }
 }

-- 
2.50.1


