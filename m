Return-Path: <linux-fsdevel+bounces-42303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D208A400E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9EC1882CE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112D1253B4E;
	Fri, 21 Feb 2025 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0ZBdYYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9025335A;
	Fri, 21 Feb 2025 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169672; cv=none; b=PNyeWUiT6p4zjTldpZGj7WM35RmJSthfekwQIQDvo9OUdZmFXJUUXtf1WbYK1Cz+jpt7rbXuE1fi6bciZyC9C3EaC0hr475047bow1Q+o7+8w39OXa/dWiNjtFYIIb02TzIJlMiboHmv9MWPMuM1gqCrexM2ufEAuwwiiYAoYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169672; c=relaxed/simple;
	bh=nGhttoR1swOP1QTQwepuqeDirYgZPEDMvtJFLrL5dpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4R1ac/tAw4e+Ccr/Hq8DWy7t9mMmztRZnlEu+S/RQD3VDvQ24QUpWVf20u4SdUtg4z9EjdzshDRtD81UECOFhCsX2qj4yesNgZ8bfUSSDQvb+iDQdj2FwBbr2db+9WYdJgDLMq2aLziwoiyE4a2b/T31jWinHbBkrp0GhboV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0ZBdYYL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7be8f281714so286979385a.1;
        Fri, 21 Feb 2025 12:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169669; x=1740774469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipEWRTbUNI0fhw7p2quxgycmIwXwELriTrZg15QiXvk=;
        b=f0ZBdYYLTwTUzg8FTtxf3KU6TgUtjekCsKIZA6luesUxMxxt5lLHxi0hhWxr3rvWEh
         lkZeLh887xL1D5KhFReVhzQcDlnQ7uRxVezFnbel+SksGa95XXDesXf16TbD4LsuGVZA
         FdbYtXuGJuDCFvTsunNS66G+L+6fwjSQdoXfnYw/knXey3aXXvbZ1a615or719J+W6KV
         GkSs5H9LHNiywGZZar91lYHw5Qwb46ps5HSr+Wdc6XVBJ7h1ARzE/vkaz5np3GTYPX4s
         ArX9+U12YFmRhZhpy8823m0LRaZfbNmGN0p2ZLtZGf3LdVjP/vnOXSScJGyjLZX5b2Kn
         DJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169669; x=1740774469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipEWRTbUNI0fhw7p2quxgycmIwXwELriTrZg15QiXvk=;
        b=aW4dMi6tAwP8xjJc9xCQYWUwn740aWZf/DTuvP1NFqxLwzHDcz8zY+dXCGWYhuTxle
         R/RNydIM6C6AetdkmBcASC+SezVUjyvizAit89WzMJPyQjIwmt8CnUUKTTqKHJyTFKqI
         h583qEmn/Gd3aOp5r86wtiz5g1olrptSPqwxNxFws1TOmLoQXVGPeYRQViLtvVlmWJ1o
         uSHInCwcDnlc+OV8vDv/tpU5ybP0VNIi4B1fKMSxKVK5lDes8hcp4bzLihrBMpBBFdWv
         Qj/uOR0dDppT9uWo5J+jvppqpCS5qFKyNPgXNnqnjk4WzooM9hQoQqa28WDqzV7Dn7zh
         DNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGx7BXOSv46MpgWdW90FDWXLwc4He/NDioBcGmJjsSVKGW7nz6lDo9l8T3+JeerJN55ebZf9urKMtWWYJ2@vger.kernel.org, AJvYcCUd04E5DFszz+ObBHAs1grwf/hfJ5s57669z/43NDhxMGln5LnumBVy2JKYy9D7itaTMbAthMsc2UGREc4F@vger.kernel.org, AJvYcCV4u2v4P8pq6oo93JhkOgkjj0kOepkss5jWTEZD0rdTuhZgQ1Vrd+M5jQmjmY6fxBr5ibsVD4HN3R0n@vger.kernel.org, AJvYcCVsER99ejtFFngJYSK2qdUNoq/4UOVU/csxxLXzGndh+4IC9KCNNHqwJG8WClDUhR/yhgJ2tNwOlMKP8Chtj8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzk53oPGF3pzyct4teOPhPgaMeiGxVeoS0rRQsjqM/ocsNRW1Z
	mLfamS/FiOI+VcSN7tkOsrbNpFcHIv229QyybGylqhWyj3qCCK8Z
X-Gm-Gg: ASbGncucSlqKMb4QPYBsR3nzgekM4vHW7p6Q+2WVmzyokFVC1s/5KRpodxN2vYiUUwI
	L3kt+Giu+ljQYHHOE7ImW5/7IOBCcrMalL2Yfqv+IOxBKUUrSTmnoIrUfDYLCsEnUcpaHDznfYy
	/zLvUbBQu1ZmKctvEJaSW1KNX/0cdceNG6xqn1b2QONeMpuxGkAXcBj7/pXo3QWUKZ6JeyuMmDb
	nz+D0Onoy2ZnrSalgjyJ1zkV/QbY2qe8jdn4Le8aXLsv9j+jdooB1qt1sA7KCL5nqWp5b/RIwHU
	suiVHnOSr9J/8JHRlIire6JUkIdAEVlwsF/HIDeqv5D01oR1Rw==
X-Google-Smtp-Source: AGHT+IGzdMSv/oYQrAzUn6Bchc187UjEzN2FLNKCWP2FOrjv2+RNm6uEFODoqMSglyfAVjItmAIXJQ==
X-Received: by 2002:a05:620a:2b86:b0:7c0:a2d9:cb65 with SMTP id af79cd13be357-7c0cef66eb1mr679494585a.57.1740169669461;
        Fri, 21 Feb 2025 12:27:49 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:880f:47d4:56c6:b852])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a99d363csm539224985a.70.2025.02.21.12.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:27:48 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 15:27:42 -0500
Subject: [PATCH v18 3/3] MAINTAINERS: add entry for Rust XArray API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-rust-xarray-bindings-v18-3-cbabe5ddfc32@gmail.com>
References: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
In-Reply-To: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
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
index efee40ea589f..f8d6a5f4a4cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25794,6 +25794,17 @@ F:	lib/test_xarray.c
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


