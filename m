Return-Path: <linux-fsdevel+bounces-41203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6DDA2C455
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2913ACD6F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993E7222569;
	Fri,  7 Feb 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HckszuxN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BA2206BF;
	Fri,  7 Feb 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936740; cv=none; b=iZFYWV1Y+obM8tcgFQTUqrRMXxaY3sHxLpEfhDHRV50J1OJOz+LJApJJCy3QhEtL2/dtgbopibcjyn05Hx+Oke35BCAF2nmFqBYlF4ergqPkcKtNlTNS1HRNqLVYL8kAWD3lyZ4cexII5A8pyPQkTGoioszyrKvuUuW4W2rrHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936740; c=relaxed/simple;
	bh=e0wLf1qpU3M4sIm0BwevK2p1vbX/X3wSyPu95F+7SS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UijgFp8jTRNIIRYgDaNC4AT1L4ADvx6hu/Oydqzkqjn0b6VXLpppWfsidSklpPnU4tO/+EKjlhSbzVZXWtl3fm7ypIu3Cb9IUDLBtgNJfK0sGVe5WluHx/EB9TrcRJtPNDzF8ZldLdtnCviBOrsiopQXgIbl69Gp9QqWNOHECn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HckszuxN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6f0afda3fso245221085a.2;
        Fri, 07 Feb 2025 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738936738; x=1739541538; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wpn3/XdlKwUhqavi+cPgIf8RKcnm9C0yzO7icUqL2zg=;
        b=HckszuxNx5+e9F0U99sDOm+AtbbtaCeCD3XujC2dGEosqYZ83/qVBoNZ66+9yE6UqZ
         bRoXF1wyMPFb4i8mu0Kn56NrQNRjuKYb7OoWCHPihecBFovNZcoHYb2hn5inuaFuYW2H
         2kE8KfJ4/BqJYgaLR0u8Y738rTlVQEXN+SmnFIb7c/LDCBQ0sJ21Q3ZzV88jvrAnZu5H
         1riBTinCwZRERO4k4Wk4rOpQ6le1MWXWL+0KS91V23Ijycr1hUBWIzvez0NSQBYnuOPl
         gJRmk8ql5AGa5xFw6ClTKD/3BIPixZl7iE9QM+A6dKCSx3bkgv3U17LSuqFtQqylJhRE
         sg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936738; x=1739541538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wpn3/XdlKwUhqavi+cPgIf8RKcnm9C0yzO7icUqL2zg=;
        b=n2UISO1xbCBPY/8jNuzVyUfBgd4gTdaeYcQcXyurePVNAMw19z2qKGrM6n8Drmr4Nv
         p8iBrolhmaXEZb2sKoXSrfW9CMNKRD+RLqrxfmFFbaqHYkdqWlZfEdDppWEKG0c2pz9p
         Bcyhm0n77+ymhcm95QrEPSN/0LOU3gb36bhAKGrNNxfks6Pi+oyecxJux2yAydK/gSEv
         yE+uXN2G/SsnbS/nMYqBud4gT1l0LYMFqP4szkSySFQEIaD1+ubYm2pYSk5IzlnS/QNI
         YMbP0oW8xdMbc2U1HnzZXGa8Wg48lv1Wv19JiZsOFueUeKDSXF7zypGOuHJg7zkgDKCm
         I5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeqxOtjk+Yig9Q+lh/mZz9PAaYlQyCTNVefD1u52vIz/3WimfITjrxSXWWQroPOwd7Yq6wn0GvoOvIjbzsKNg=@vger.kernel.org, AJvYcCVtHZHiEzFeHl1NDUBS9EIuSZ8INgAOrxlQ/SjIsagpff8dD88gwjynqMKpeyIV9Vh5qex6XOGRKsgJ@vger.kernel.org, AJvYcCWF9NYsf1JD0lwniRGHLVvj8aYM3YQ9oWE9p0o2S90x+SuXHNPCmlZCObT8a4xwu6EKna53VG4Qc6/GPvTp@vger.kernel.org, AJvYcCXGfQGZO3pjyMYcFLH7wUrsvAlfzPpH0QB0QX38n4sQ5ZSkH82/oD1loRqBiI7oKI5YmemySTiAd1Qb0XP2@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQS0sLF7XIKI3vu1bH3fboUp1iwvY5PwmlHJXaUX/YYmuX2S/
	Jq+c6YTPZtd2Mah66kLquJHRjpxNLkrK4a/tW8XKekTCshZk/TJr
X-Gm-Gg: ASbGncutHrp1NhICXGj7MXwNYWAPBEhw4t2uHYhsTkRDSl97LNIMHE42+SN7LgyNPP2
	qySICyVYSppv8S8jdTr5ANtRVFadVUDU5UbX/TO79V8eZ7THaCffRdXZuij7rHFQM4Y7kSWypPD
	QP+Dr19qPGUkQjbFma7emthr62njWVaiKDlXsO2islwoABiku6CXykYPvZEpIEfQI/sBds7+NLT
	DUEXBPYdtD4PI28i27QewZ88ojUTh2xisp8bEpnFCAxYbNiWsP5F/45o/dknsGMTRZRFqPumIhs
	T08A5ULeUEDWcev+aokI43ZpEEMg97azTkc=
X-Google-Smtp-Source: AGHT+IHJwjaC/82Oy+hjq0+mAZvGgxUq5cE3OAHB2Kmlq6SS61f+ujr3KqeeL6FpscTZDohbCf9ruA==
X-Received: by 2002:a05:620a:2994:b0:7b6:d5cb:43b0 with SMTP id af79cd13be357-7c047c9a788mr462795385a.39.1738936738181;
        Fri, 07 Feb 2025 05:58:58 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e11d19sm191919685a.52.2025.02.07.05.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:58:56 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 08:58:27 -0500
Subject: [PATCH v16 4/4] MAINTAINERS: add entry for Rust XArray API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-rust-xarray-bindings-v16-4-256b0cf936bd@gmail.com>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
In-Reply-To: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
X-Mailer: b4 0.15-dev

Add an entry for the Rust xarray abstractions.

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..88282b6e689b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25749,6 +25749,17 @@ F:	lib/test_xarray.c
 F:	lib/xarray.c
 F:	tools/testing/radix-tree
 
+XARRAY API [RUST]
+M:	Tamir Duberstein <tamird@gmail.com>
+M:	Andreas Hindborg <a.hindborg@kernel.org>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+C:	https://rust-for-linux.zulipchat.com
+T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+F:	rust/kernel/xarray.rs
+
 XBOX DVD IR REMOTE
 M:	Benjamin Valentin <benpicco@googlemail.com>
 S:	Maintained

-- 
2.48.1


