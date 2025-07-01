Return-Path: <linux-fsdevel+bounces-53536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C8AAEFFC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E45E3AE8A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD627E1D0;
	Tue,  1 Jul 2025 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl3IHeWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F427C145;
	Tue,  1 Jul 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387245; cv=none; b=dDVcm1VHLzUtjuR+5bjI9vj/j6pe2QKGGtvUVNFLwK33c0PsCY+yFO4SemqsZLpVZcmUkaGhsFF1/gmWj+QFfySi08QfykkNXd8qSc1fwycO7ngbOyZftHotprBYUwZ6XrEqlFLvBx1Bfa78WRswlYfYtwnjMjQmrqNvn8fSlGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387245; c=relaxed/simple;
	bh=aGvJvyB8w+moAcSxmTaopQJRgroqK4bgIeBJiWTqd7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOsqxl/KOqGl71GVx4wxI7JnVEiiCXPKdEKJM6ZImZVfydcRB4r89xrn5amGpML2K4G4Bt/UavlhBIVGFOuCIju/S73rLP8/+ZK1srPpGlcXcvRasC58IRe9dL94q+qiO3BiqUl8c35DL6+XVKr+0JMnm+NeYwaA4RA3pdEWVkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl3IHeWm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a823b532a4so19118871cf.2;
        Tue, 01 Jul 2025 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751387243; x=1751992043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7m5LLXh6Vvt1HNHQi7mgcWgQec9riTqSsqAgm3pbC2Y=;
        b=Kl3IHeWm+BU9o0a6/XS9mVLy05rDcjp3KPlALocL9jkJRlRdPxkmvNQgw0m3TjML7C
         8tjZ+DID0+czISK+lMb5iru87qdQyAsLFqILXxYFJyF2K0gDdfhtvUVDthlrg8uxoOv5
         /oeZRQCm0lKgsmjdsQ6JsIOLuaXptULodA5ZzZtBFJjd+kF+KvQo3E6crlEd4aACTMP9
         fOVcW3JJsYdv9+dlv6vwKNB8boqQ5vMQEechJoHQaJUi5L01eSE0ioLh8TVa8L98g2jG
         Q1fVdu4DAPbCFp+1e0KE4YpAJ2VerLu6mGYAuF6eT0mDSdQsUceaKhlyEHSxeaE/sj9V
         SECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387243; x=1751992043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7m5LLXh6Vvt1HNHQi7mgcWgQec9riTqSsqAgm3pbC2Y=;
        b=k85uk3m44irQYr0PmoSnuLjpGFVMf3tTQLrSa4dtjJqdygFnVPws/kO15W0RbR8XJS
         0peu/+jm/TUXCz1QjfJ79B0T6+jLSj0ql5beavNNhyV5pTpAUE8O/oqK9neFgQvNTIKd
         BvDFCZEd7i+W946K+eHK3d0jpkmCFzy/sm8+A0jjBTC+NeeWvbQ9to8AA6F288w40jJC
         /+7fr3MulOHnlvvmeQ1l6RtyGw72PDlB6ZJ4TvH0JK2rDa/YpGJ8DFNBBkOVo9oRtul2
         EdMmZXY/LxzvKkZ6bjWPPkxXtbRQKLjUfOCBjF+FxUTjdCt29oSdoYhmsXTP9QeA5oKh
         9UjA==
X-Forwarded-Encrypted: i=1; AJvYcCWQAswWf9ITlfxgea+w/P3PK/nVudjrBxUYD3pYdOqzGVwKKoYuFoUd3C2pOHimVANV0uIzPfjrUS+KhscS@vger.kernel.org, AJvYcCXT3RL05rhT5cn0ib/ytJXU87YvxifCW8UvAevPv15JWAI0t5kt7W+kELvUD1zowroPH7vSqECl/3lq9xQn@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgGIM5g9vD4T9UjyMfD2kYu6AtNCEojg4KalnTiv0IKzoTzvU
	NjsK9P4Cc05MZwzohLEfEtuyvOPCZu5GdycGL2cCg0APX5uZCse2ZMWt
X-Gm-Gg: ASbGncuMepXOd+gkU5FwR14cKh+52tg022K9SBOCFYU/UnzjluUrO1NklSmmvfuo7T8
	Zmv1+oAFf6p1+EpfBOwX1ryBTc3a0s0ihc0VoPLxyqwhpWfZadrXD7nG52SoampjiDPQwsbqpgH
	JbACe+135DqVChkJtwSl9eV1iWP/5++vc1FaTM0XeYoykzDD3Qaxk1RnaKm24sJfN6ZAMt5+xMk
	Iu9h4WukOOIdzp6cpgq5bfCUdu/zrSDcDDRnAJp6sBSjDzDCHhgfvrNgZ3TIAvUoMHgzfZz7930
	XzRu56zy+0L2ULUnNy56tgfVuvY3pPPra2K5msVXD2RAzoqVV0/edfBf5F9FbmFEzWAYOUm3v52
	HDZBof3nU4DCe2ZfY01FulgS5yygrBUs/oQRSo6nX3RAbAJ1v6bnTV4txvEmc4fkYEWvcEMkHwQ
	==
X-Google-Smtp-Source: AGHT+IGwGnhb8l9Hw1Mzr0aiSE5JQQWjgKVQGGbklZpx2Mzk98f9kxCEeLmoUVK9vQ4i8xFf2yAhHQ==
X-Received: by 2002:ac8:7c4c:0:b0:4a5:98ad:5640 with SMTP id d75a77b69052e-4a7fca4e44cmr315848531cf.23.1751387242446;
        Tue, 01 Jul 2025 09:27:22 -0700 (PDT)
Received: from a.1.b.d.0.e.7.9.6.4.2.0.b.3.4.b.0.0.1.1.e.f.b.5.1.4.0.4.0.0.6.2.ip6.arpa ([2600:4041:5bfe:1100:70ac:5fd8:4c25:89ec])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d530sm78032551cf.61.2025.07.01.09.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:27:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 01 Jul 2025 12:27:18 -0400
Subject: [PATCH 2/3] rust: xarray: implement Default for AllocKind
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-xarray-insert-reserve-v1-2-25df2b0d706a@gmail.com>
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
In-Reply-To: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751387238; l=1262;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=aGvJvyB8w+moAcSxmTaopQJRgroqK4bgIeBJiWTqd7I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD7o3/Mx9a2d9i3hzu8whxbHWeViTVLI5JV/NK1oVEI4eienN6VIXBhryqdEc0J7F3lMl5Fvi7t
 ZoQmAlUUdtAM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Most users are likely to want 0-indexed arrays. Clean up the
documentation test accordingly.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/xarray.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 436faad99c89..bbce54ec695c 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -24,10 +24,11 @@
 /// # Examples
 ///
 /// ```rust
-/// use kernel::alloc::KBox;
-/// use kernel::xarray::{AllocKind, XArray};
+/// # use kernel::alloc::KBox;
+/// # use kernel::xarray::XArray;
+/// # use pin_init::stack_pin_init;
 ///
-/// let xa = KBox::pin_init(XArray::new(AllocKind::Alloc1), GFP_KERNEL)?;
+/// stack_pin_init!(let xa = XArray::new(Default::default()));
 ///
 /// let dead = KBox::new(0xdead, GFP_KERNEL)?;
 /// let beef = KBox::new(0xbeef, GFP_KERNEL)?;
@@ -75,8 +76,10 @@ fn drop(self: Pin<&mut Self>) {
 }
 
 /// Flags passed to [`XArray::new`] to configure the array's allocation tracking behavior.
+#[derive(Default)]
 pub enum AllocKind {
     /// Consider the first element to be at index 0.
+    #[default]
     Alloc,
     /// Consider the first element to be at index 1.
     Alloc1,

-- 
2.50.0


