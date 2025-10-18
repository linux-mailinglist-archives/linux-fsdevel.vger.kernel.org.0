Return-Path: <linux-fsdevel+bounces-64583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C056BED731
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 20:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21FD19A65B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D22641E3;
	Sat, 18 Oct 2025 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxDIUqo6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698FC25742F
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810591; cv=none; b=YLWqyI9TyCCmpEteqdxU50QT9K7FXaAnePZLCWfeylja6fKDpDWlhGDez/cYQRO08/0TeyHq2CpAC+5U5hJfHvKmud/HOYEwDVkUM9lSRCZP1CXyd6wv0gml9betHZzWUv/eA1egaO8eP3DJDHocuXHT7wKQ4YkMxtnX6HDylGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810591; c=relaxed/simple;
	bh=0GzwcDEeRifVYWOU1Ju17zqBLy5F9ZnkEqm/6SUKvKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F7ya5JXv8iWwgS93xJW1fzlNWmi3fGfZWtZQWbgdR7LcMYvu8bV1VzmSHh0jffArdbGqouxu/bIJGz4vm1RcYGfnUAwZoSuT3GpNq9A3yXfqSHHNno+674lFOSC7//qKH3WUCfmrLJsmzWQLUNfpp6cjxijF1eBaICBZi+zMdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxDIUqo6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso30818445e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760810588; x=1761415388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jw3+rOqAmz9lI4+2vszjAxIVE8PlKgnkOGLhqwHbOo=;
        b=hxDIUqo6eoQQzTk/UK2gwlX//nfbdzaTwNxS/XcLvWTFXKz5p8Pib51uSza/iK0TR8
         E7X08qcyzgzhVWcnKqAcu8Ntg4MaM66VYBAUC/zpzCTch5BnhEDIjTZ4q2M+Ath2bwkf
         keKUxSQwJixk4tDpFD1p33qi9gIt4SniDidLU+08qSE3TxoKzOCIrt6m/dnTz8zCvc7N
         oZbivVvtCBzIdIvnPZzer6FR5aEICGsb08wSrGdARgtbrsoJKZgu0UA8TPzWXsaCXZgK
         NRqMU7lsymz2BK2cZ/baMWhs4noidaJxecq56qoMu+p1Tn9QwS2IRTTZ4V12VmLAsjgq
         aYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810588; x=1761415388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jw3+rOqAmz9lI4+2vszjAxIVE8PlKgnkOGLhqwHbOo=;
        b=uKUvkBEM8Qc+fjkXdnwtagrgIKfunTuDQIUEkqK1AfsZ/lWIB7Rx6EEm9nzTlO9qKT
         SYyoFyf6kDb65uHdJHnAasMbMYvtOsJjVP09rdI5iLLfJTjEZnaPsNkXKptIhMoFVEpp
         wOCjIjgUlSZzyGK2Y3PlIu+6POulP2zU8exvs7gbi2n8nIKQn3eGhRKuesqHigen4Dbm
         9sbOnDbGwP4nt8HMwCbphr74Iyf8ozdE/TCQswAXPj4J1I+mlOH9944wzoLsJlKktNJ5
         BSPPt4tCptD33JdO/jpNOR9hTG0VZkx7a4H9AE3wMwDpjYcBHrkovxwOE916YLP09vqt
         Kb3A==
X-Forwarded-Encrypted: i=1; AJvYcCVemzaQLGbK88a7BSNSBrEbXHA2yVHwx7WPL0S34odz2LPb03g8MunBu7Ok36IqFAoLRG8WifjjOXeByH3E@vger.kernel.org
X-Gm-Message-State: AOJu0YwAAtQnkAvcPmB1yuJcyDsmIQo/+BvoEovjxUjXe8q+cz99dPJm
	+sR4zpKdAbRZbcLUapYOoeWw2ZfSIllifhq4yLjYHmpytZkLPmvJFaPsel/Uvdl3D2yENoOZt1u
	qo4gaQkCQLYIbh0z0Lw==
X-Google-Smtp-Source: AGHT+IEDBiBL9j3PrKHEoPMUCzoRBlvkx4ZL7AxoxVM1NpYJWMzoUQv31Vq5zUARBonVeR76HGoFc6I/2XbrkI8=
X-Received: from wmbh26.prod.google.com ([2002:a05:600c:a11a:b0:46e:6a75:2910])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4715:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-4711791c8c3mr58877225e9.31.1760810587581;
 Sat, 18 Oct 2025 11:03:07 -0700 (PDT)
Date: Sat, 18 Oct 2025 18:03:03 +0000
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251018180303.3615403-1-aliceryhl@google.com>
Subject: [PATCH v18 12/16] rust: configfs: use `CStr::as_char_ptr`
From: Alice Ryhl <aliceryhl@google.com>
To: tamird@gmail.com
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org, airlied@gmail.com, 
	alex.gaynor@gmail.com, aliceryhl@google.com, arve@android.com, 
	axboe@kernel.dk, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, broonie@kernel.org, 
	cmllamas@google.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
	gary@garyguo.net, gregkh@linuxfoundation.org, jack@suse.cz, 
	joelagnelf@nvidia.com, justinstitt@google.com, kwilczynski@kernel.org, 
	leitao@debian.org, lgirdwood@gmail.com, linux-block@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, llvm@lists.linux.dev, longman@redhat.com, 
	lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com, 
	mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com, 
	mturquette@baylibre.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	nm@ti.com, ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, 
	russ.weight@linux.dev, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	simona@ffwll.ch, surenb@google.com, tkjos@android.com, tmgross@umich.edu, 
	urezki@gmail.com, vbabka@suse.cz, vireshk@kernel.org, viro@zeniv.linux.org.uk, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tamir Duberstein <tamird@gmail.com>

Replace the use of `as_ptr` which works through `<CStr as
Deref<Target=&[u8]>::deref()` in preparation for replacing
`kernel::str::CStr` with `core::ffi::CStr` as the latter does not
implement `Deref<Target=&[u8]>`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/configfs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 10f1547ca9f1..466fb7f40762 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -157,7 +157,7 @@ pub fn new(
                     unsafe {
                         bindings::config_group_init_type_name(
                             &mut (*place.get()).su_group,
-                            name.as_ptr(),
+                            name.as_char_ptr(),
                             item_type.as_ptr(),
                         )
                     };
-- 
2.51.0.915.g61a8936c21-goog


