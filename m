Return-Path: <linux-fsdevel+bounces-41096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF74BA2ADAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514A91673A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091CC24819F;
	Thu,  6 Feb 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcCtTU0P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09BA246328;
	Thu,  6 Feb 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738859098; cv=none; b=OmAdMCmBz2qkXTqtgBRn4TkdoxugF8VD6o94PczCdOGSFrCI3Hpbk+n+xOhzQrW5YQZP0DycP59ajSBKOVGNQXWH2zpM638Op1tHaU3EJg3r3s1Bq6PYCMTNgeKvClTx1ak8bvTFxajcIEX++pcxKgOFAkJxpR/mrYSN8m4w7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738859098; c=relaxed/simple;
	bh=UaDVREG7/Sc3wMsZDfW00ioz6KhQBs0G60BDqwnSyiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehGCYECM54DaikOJTCDev4/E33xYRqtCCxOJKEYZk04DW9x0KVMHhYE8+QPbPOiol8339M/Wu7NfFw/45c88p+CDF0y650cz+6CmZ+nudHvVKcNKr5g8s7Kzl63P57xefQCcZebG5ubVemi80/iz0SafQAqpXxC527oxJ5kDB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcCtTU0P; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be8f28172dso52986885a.3;
        Thu, 06 Feb 2025 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738859095; x=1739463895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OVe41mTulKLQ9Ass6Rm3bcrGgxfqO9FwEz+pynI7pA=;
        b=jcCtTU0P1vygwofxSw0IWes5zjq0Cej0OFlRGFHh/3MitCE5DrlOHbsD5SjOqaMAcP
         NYquKrFHccGVHJKv95MjDWaxH5Tu0Z60KUScFWr/7sI3bX6JsZIn48riqHzDx8RYvSlx
         cTkI+cDlYBuXYHoCGDml8qDoKKod/iVfbT26saY4Zsl/0RD7S2njtbpAeD75xpKqA75s
         NjbxDKqkybkgw5xRFvj6KqGS4Gmi+qcUQPjP7MDD+lNYKdCrAWik5Wc4eZTL17DUACAT
         FJ8OPIXxXxT8p5R8dNJq0kWqpYur88c/ljYBylZxDceGQc0PcsuynReG7Ukta/a9Ox4I
         YF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738859095; x=1739463895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OVe41mTulKLQ9Ass6Rm3bcrGgxfqO9FwEz+pynI7pA=;
        b=HXYepDDolmGtXVKroaCOjrFKj9ASI0JVdMFvG3H4fLuARCQX2b9K3BmrNzyss7FjAh
         7mvz+gKhcblUPl6ECoWYjcSceZopuaT17v8PEJhDNVYleAXkdzLPoCs3A+qGIOydEYJk
         Tz9oBOnZGtMsgMDFDq3PO8blvBOZjeWrQ2iHll/FBc2zv1yb7hH4yIyvVd6TJZGtO6Kw
         C276O/CHcdg8j0l0JSzLU1d0Pir8EUjtCjkSCin5BJHjVhlBgkgPGrK8GMamQx5WwKTV
         JB8zSSCX3ZdXshZYjzbZnBU4YXbNZcZOyqsyj31q2kR1xiwe6JBXn6EdpETAWu1ipA3R
         z5vA==
X-Forwarded-Encrypted: i=1; AJvYcCUrL5h3weoMKh3tuTnXLd4TNV3X/IRfyGFex+6Cp038hT84i3eR543DD3deewNmL8dC7Ba+oSSX7rua7Y00iuE=@vger.kernel.org, AJvYcCV0XKYwNrYJF94c6GCcSeRlmFVpL5+Kc4FwL5rsaM3yV9As8P0cTidcRYIzxRN+QYVdnWo2iMYn+r7pWjKT@vger.kernel.org, AJvYcCW2VT8pXIPa6fQVNi6rwMwIp3ExtzWa1we2tnMEwvTyS6EwpPha9fLCRcqlgIdahpneec5weVv4IfmMUhqR@vger.kernel.org, AJvYcCWBkTzcdevk1EQO5IVVze/A1s+5kWrnQKNC1sJE4u92T1BublyIhPAMMbs30cUOsowPVFOVPLtg3DVk@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgH1JGX5HMTCGRIeu6awUJcqzhgOLs5R49tg+i1xrKPfz2r2s
	zu80g0tO1wRhr637/YVj2G3MNb+At1hSPfadeAB2W0UzFeRQAV5u
X-Gm-Gg: ASbGncvY5C2ObIlfkkRrPgqNKUIiZNrAOWw3rMt8wjfdpckwkRy3htaZ8e+vn3zCcSn
	HaFPKqG437DK6csSL+q8640qRaFxdKbVuddTo4IpAMVmrQCzOR87TiLV9D0fv1RxD6K8/eMkT3r
	xjTtSZPJ06htUhzqEEzh1CIItVyE8VFtmaUR00DhViDNRCGDI0UOoXR6bfh2D8VMe4hCyZH+C8q
	CeyK03WGpuE4M9IjkBCaw/eTdCiYee37NsdH97QnJgDI7mFt0zPm+ybhR/zDRqg11DBjYs9OWkq
	dRXvf7Bo/CPyhPD1OAwxpxaPMx05sfv4JgcJ
X-Google-Smtp-Source: AGHT+IHWNmhtgJE3obCuD0D4KWQ3iey5+ZU7xrUgSbDtfGMX6Z8QSSJm4ck5+6NJKaCshFhDRRh8Iw==
X-Received: by 2002:a05:620a:2710:b0:7b6:cedf:1b4e with SMTP id af79cd13be357-7c03a02ee89mr1001197585a.41.1738859095548;
        Thu, 06 Feb 2025 08:24:55 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041eb8e09sm76440685a.102.2025.02.06.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:24:55 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 06 Feb 2025 11:24:45 -0500
Subject: [PATCH v15 3/3] MAINTAINERS: add entry for Rust XArray API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-rust-xarray-bindings-v15-3-a22b5dcacab3@gmail.com>
References: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
In-Reply-To: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
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
 Tamir Duberstein <tamird@gmail.com>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
X-Mailer: b4 0.15-dev

Add an entry for the Rust xarray abstractions.

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


