Return-Path: <linux-fsdevel+bounces-57742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6EDB24DF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9D3581488
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B369287260;
	Wed, 13 Aug 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIFFDNHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA187285C85;
	Wed, 13 Aug 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099610; cv=none; b=QJg3FEHFot2Lu1KlokHAslF6tMabZWgZzeDbN8Wp2uSsoWKv8z5U1kq7YFlgiMsx+9vLP+EIe30UcJsaaZp+7YLRQStCGo5SD9wc4FpdcW2r7j5AekSbbAyFxt+PB5w42qs083d7/aSkexwghhliGtP0BzUdvmGYuM8BV/dFoAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099610; c=relaxed/simple;
	bh=4r4hGm+5eFeJ1YD1XNe79Rof0MXa9XpmAsMvwuuTVcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cEwOf132+0UWXj6BWEJUIagfTUf8LD6ueU5dsCAmXNix8vAJj+OrJ99F7U46cWZsgQ/yi14P7bfUGyIMskLxptp6qIfNu5bl2GL+SN1iOHSNPRIT36Lyv7aGXhbyKu2uT5LyJ6vWCeUG+3WWUX58oFdrj+kFHMKhQnDcND/FgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIFFDNHK; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e806613af8so781151685a.2;
        Wed, 13 Aug 2025 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099608; x=1755704408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvH2/B2zmQ0D9vQHtz4nqDYlqgBbI+OptHpY/wLbPQQ=;
        b=nIFFDNHKx5feKut7NI8X5Jg0mYlcJVkVJOcs9I3mE5IOU9aZspDpj6A1/t3/xU20o9
         gEF5O13kQHo82/9Tixtgw++4HzmSuyJkO0A+3Il87kXjgMRlRUWrN4Z267xjSXM+GxTU
         LbGNcrfV2hnq3rjEKd6APGy929Zofy5w8Vjdzu+LzR3tzfkQpWlhsGctjo4X87b1obco
         bPCSbd8zuKxsHLrFH5dHYo/UAFyzB5V+UTAqMzkRdq/SerIXzMM4yXgqOxWw1b13hbdi
         dcdiviryCb8GYg2WS9z/4HSXIkg6UQ0dG9pRBbFSUE0VEtQwSjjh00cdtH/ZlwB3+LmI
         LKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099608; x=1755704408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvH2/B2zmQ0D9vQHtz4nqDYlqgBbI+OptHpY/wLbPQQ=;
        b=DL6iww2vvYtE/xHvNXaEYAnkf91ugCSP4WgD8xh31HCF/onAgGkZNLD2iDQhzfOETG
         I+NcPiDNRgXPQjoS6VNyCfQl6015Juc8URe/0rcU9Uo0Su0UA1Pvz0SCwKilccsZraTo
         2U3u+qL2mfW52/NMVyuaVXf8BIP11YsUhB8rfMfNJQ//dqUEEJiC7UPR74UYnBXuAp7S
         X70BkNs/dMK/6Ar65VohuSzRQ1JdaeZwdSrZIMeydBZH41FBmH7ASxiB0+gcE0zenrTS
         b1SuQiBC5l9uDUbUh3tTZ8fVD9OVRcJM/rpgDMn/V/tYB+6cMeBhW29jij7WmYS+SgLR
         UV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU14gtPe2pC16Y+4jgSMyKp4X8aNvZRVubF5/Q3chr+G3Ab/YSdPk0eRCcMANmzzfFUXGOnwmPiyGIQpg==@vger.kernel.org, AJvYcCUnkn6c8ftDDWyHtER940cJ7XDLHzTSvfTVSHU8RAwHC64VW+4/DE7IR2x1WuTWoa7ERRY447+5V0k3mIKAUbqm@vger.kernel.org, AJvYcCUx7RFodvPZc5aNlH0c/7wrXcAjrUI0NqdgXQk/mdiCBesahTQG10Ig+Xj4Dpvs5FtKV2+MIRC8ualbPDQc@vger.kernel.org, AJvYcCVJ1MUBdEZSZwP/ZiK5iHzDP9fbOjPg8nsca2esnPVZDYozGmo1GUVX/05uS9HkWSycPiDAzB0Uc+Aw3ZzcrQ==@vger.kernel.org, AJvYcCWCm0DQ+D/3+agMJUMlB6gJhpKEesVvSTXmlo73186ClQ5OjfslzOQ7z8l/z9cZ1JnpS2uHYzwLXgzk0yH0gDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4IF1SmVKcbpeXMZiFKQjMGWHLcV2irD03CO67qjFywOaEnfx7
	rMFQSTwJypIUNTI1UaPfGXwEF/L++zG8HFNWPfddZJio/6oPpYcCKG7p
X-Gm-Gg: ASbGnctc04VK/N8cGfoaJhyGfUoHqfWRpLPQraTgAk/5kpS/KREpBQK4C6aGH/YDe7E
	cbjUid/XuLyNTWSIsGeA84nl4y+hfJ1GBuZq8Eo2KzQgwvx+6Owl2Su5O8asqAJFMtLLrW7Uscd
	2a1oGEUgYi8dQmgtPi4zl2RLUWzkINeja/wCF0Ewr2I0CKhSfgW4w7eNxDwa+KSQpLIi4RCRt7a
	6EdhAnVWw/94fkafvCnCMgwtAZUJOlneUuT3wY6731jhPkMZBwH9urSMOl4QV29XMz9FDSv8Bt3
	VVU2dIDqvUOPVYPwH9HM3Jomkc+E4G6prIXAXyPchonT5rd94Dq3RkU8xVHRgkoNm8K1ijER2Vw
	DNiMlYxE4JTaSq4dzhgu6J/nj4XSDZ1Nnvx3vM/LUB1agE8Zko79huy5sbp1mK0uC39HIDJYIRy
	yUf/495+2PAXSDRPHk8xHVUKVaR+0TDQk6RvkKdlFPXrlA
X-Google-Smtp-Source: AGHT+IFQHqZ42a21nPnAfBqnqhi3SvB26bjyNrRjDQP3uTPdTZxNupm9Q0eYNC7DU+LaCe06RKPY/w==
X-Received: by 2002:a05:620a:608b:b0:7e0:bd35:fd23 with SMTP id af79cd13be357-7e8652f8d3bmr366589685a.46.1755099607447;
        Wed, 13 Aug 2025 08:40:07 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:40:06 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:39:52 -0400
Subject: [PATCH v3 7/9] rust: seq_file: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-7-a15eca059c51@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099591; l=1669;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=4r4hGm+5eFeJ1YD1XNe79Rof0MXa9XpmAsMvwuuTVcY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFJ0qGmLAvVhf4afCxnQAsgT2wKvjrpnkv9dk50qzD6Cg9FtpHbX+bHPMydLtqpXf3gEtgUpRyA
 oBpEXmc5iSAQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/seq_file.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 8f199b1a3bb1..59fbfc2473f8 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, c_str, fmt, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -31,7 +31,7 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a SeqFile {
 
     /// Used by the [`seq_print`] macro.
     #[inline]
-    pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
+    pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
         unsafe {
             bindings::seq_printf(
@@ -47,7 +47,7 @@ pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
 #[macro_export]
 macro_rules! seq_print {
     ($m:expr, $($arg:tt)+) => (
-        $m.call_printf(format_args!($($arg)+))
+        $m.call_printf($crate::prelude::fmt!($($arg)+))
     );
 }
 pub use seq_print;

-- 
2.50.1


