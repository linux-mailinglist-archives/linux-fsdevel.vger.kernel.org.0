Return-Path: <linux-fsdevel+bounces-63107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9BBAC451
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A11EF4E255F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B32F5A0A;
	Tue, 30 Sep 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG5tBqPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B762BD034
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224429; cv=none; b=Zp1lc5L2j5AiVyKqaQGhbTB050nmKLqoqa8Ggcbz+YPFzmbWypMIbqJ9xhhZQ6D+448pdufJh2ZXxemIG3PFl+P8ay9yFniMiG2bNJE7TpJo6CgaQ10+BsSqzyLcQinpx+Fr4W6pUaumloReheLCjzcsk2dcGFOtNJA+YjOOXwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224429; c=relaxed/simple;
	bh=nnOJoFklgxkNVnV6y19zqwF7kPIYf/E1Pt8Foa/jQz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eW162cXgU54Xf/6z36TY6lN46OvTWIuktqp4iQB/PS++4liGFozfkRZ0bdn6YJNQSV5A12ASizUoUNlLUpUFJMPYxcJaw8B6mwGdueTnvcrwfETxywNnzovHT/BNaswxS5Cift9WfVSf2MOh5hJqXPqy+zb84v3wyQadFsRGD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG5tBqPZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b551350adfaso5388605a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759224427; x=1759829227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oV9nwWlvwMw+boSlHYxl2BiHlv2LHDCeucM2QPwsS60=;
        b=lG5tBqPZN6Tai22sjjt8EMPd3kHOkiWAiFG9OT5uc2FLX66DkhRwrJSwjn3CWXsOFv
         GmF9vFdxmRvlTHqMsOb8Jj22Cv1y36sfoDNP6nqoN8mDz3ZkHiYjphG/G5es/0EVuo2C
         ZOIIiuSrPSBsErjkQkw9B0p6ZDSkZ48inD96w1SfpC2aMqNDm3B8Pk63gPBGKUl/1lAM
         9Rk/x+HzdSppxD7jRda3hi2yTCcMagC3W39VPrTPR4Sw2W53RBmWmXxQ5MUq5c9qD4R/
         e3wcN1IcjLtlfllIM5RAVqUdgC/z7uwldiloo4Q57Tb1OkZgkBKF1G65EZGXS+9m8Ukx
         Zp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759224427; x=1759829227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oV9nwWlvwMw+boSlHYxl2BiHlv2LHDCeucM2QPwsS60=;
        b=ZpoUS3CjuxP8P+hzWs7oCy5O4cOlahz6xLlnioW35pAS0wwwfjyKuO/ozSB7NSknMc
         FfnbEq8UCpHCmTJ5iI4o2s9AMrWi7U2SMj/NIMzGIjno7O+UWKjfZjL3is6P+fh5I5N5
         1vvObx5uzBJpzAND5FxSUKoNUpHghbZOnjoNPmdPdurPDJy+o40yP+XFZYw396cUYQ/Q
         W4aman1fh0eCiE/uIdmwR7j++PtZV6y6Tk+UHEoIMz+VsyTKiS/ioYXtyvHuIjaQ7yAY
         t5eXjKPAgS9E3E66lcmSd5+iLYR7UB4mBLB82z191GP1edDIOJUiUzOPF5pc+VIpC4Zb
         3UEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpJPCd6cuKWQGvV8/oiPYlDtxKcTwyqsH/sMICIrWYxnYH5U8E5ttx5XHKEUArgidbsmF5Cw7cD71UJLUR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qwyNwERY59DMsfu/aJaHFKqQSmPQksc0dmq85kgQO2zzuM+c
	QSuj14N29Fe/pgKCaXg0+Vrj09lt4fwEmP9BVIqKx5M6P3tDMwtwwA6u
X-Gm-Gg: ASbGncsk7Xe91hKb5xj6oau8CbVZcRk23o7DoOR51w8R0aB/IyVIaNoEZnmtsDWG/o5
	RivJTrZCw9xh+nXBbOT5SVoDb08LEC7NPvhoiKqjSOTe5YCMgpR1o+Hb9PyB/0nuH/mLszWT69M
	C72E8G/4ubmGDjHBVtxA28fuZt3lellbV2HCAdY8sgfl02wnI+4rOVtg/UukdAn/dEUVsy6fAPl
	vVG2mm3oQbJt9/HuhXGKzq3tLR8M0sDWlhaEP0NpRnmyg9IBKNvF6ceMgR5bVmeR17zUbrvQzjN
	OfOSLDUDvD/0ehQmozUElHLjCk9F8b15l2O1R58dQAlMh5kZwlOMsI/a16RI2xDtof7VNF05U+v
	l5HQxE+XD1uIbcYsFGEtn3ZR1Lq5xS/m/L/hUpXKs8H0kvHMo5lVI7ZUM
X-Google-Smtp-Source: AGHT+IF5Mmu2cJGe20mrkbic7TsBlJPKePi0vu8IJGytdkUd9qXqS/ol7do4D3mDYqG73gSZQACchg==
X-Received: by 2002:a17:902:e5c4:b0:27e:da3a:32bc with SMTP id d9443c01a7336-27eda3a38b2mr187134845ad.33.1759224427493;
        Tue, 30 Sep 2025 02:27:07 -0700 (PDT)
Received: from LAPTOP-1SG6V2T1 ([194.114.136.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bcd9afbsm19821660a91.0.2025.09.30.02.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:27:07 -0700 (PDT)
From: djfkvcing117@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Onur Ozkan <work@onurozkan.dev>,
	Tong Li <djfkvcing117@gmail.com>
Subject: [PATCH] rust: file: add intra-doc link for 'EBADF'
Date: Tue, 30 Sep 2025 17:24:33 +0800
Message-ID: <20250930092603.284384-1-djfkvcing117@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tong Li <djfkvcing117@gmail.com>

Suggested-by: Onur Özkan <work@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1186
Signed-off-by: Tong Li <djfkvcing117@gmail.com>
---
 rust/kernel/fs/file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 67a3654f0fd3..f3153f4c8560 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -448,9 +448,9 @@ fn drop(&mut self) {
     }
 }
 
-/// Represents the `EBADF` error code.
+/// Represents the [`EBADF`] error code.
 ///
-/// Used for methods that can only fail with `EBADF`.
+/// Used for methods that can only fail with [`EBADF`].
 #[derive(Copy, Clone, Eq, PartialEq)]
 pub struct BadFdError;
 
-- 
2.51.0


