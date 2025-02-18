Return-Path: <linux-fsdevel+bounces-42001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D520EA3A04C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 15:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171D9176784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F126F464;
	Tue, 18 Feb 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBVREB9p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601826E65F;
	Tue, 18 Feb 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889477; cv=none; b=bW6cXx3KsmIL0Rw9bBPCylE7YMnZQgoap6aItzKMM9hds4lztv27lgbwsGgRxrodrVkRJMSwa+EhMUI6ZOyngb/DZQLUtXc5hwCZLo9cIuzXZ+eSwkKW5WzzZwPslPN90gnyl/yvybhFNXczc4RHudkFZge2Ljvrz+FF5UP+EB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889477; c=relaxed/simple;
	bh=nGhttoR1swOP1QTQwepuqeDirYgZPEDMvtJFLrL5dpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkZPmMK8afVxLTbWeruaETjl+UPgrcZPqOWur3wA66iYoFqSz2ly6sQKnQ+7v3P+hcUGNenYbS/xiBLkP9LPGflNgeCD2Ml65J/N7gPJigMjcBGfjX3l07P3q47HYae1HU+i9XrrdrhFqFauw5im7/aghfcxs3yaQEE2oGTgYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBVREB9p; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-472049c72afso4996381cf.2;
        Tue, 18 Feb 2025 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739889475; x=1740494275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipEWRTbUNI0fhw7p2quxgycmIwXwELriTrZg15QiXvk=;
        b=OBVREB9pgEgdLUh6F0I+4MfTfVDqRDqBiKPVkqVfiZn2EgTb3Q/LcW6OUoYVDpuorz
         U/zeGhQIOiyg7ZsANU4U1yA8BeDsMQOWsz8wGUf2+LZ+k3MlJn4x8P1vMinXJ+r+nccd
         nc+6V1CPGfknC2edtfqWAJJjgqoghBAVrze4LEmrHvDI5KrkltVWO3ZQNsv13OCSgRvx
         ubud8JVA1eDJvdGB7jpkDVi3OlD+E5ssz9kuHX3WkZiwT4NZSK+yMl+D/PJ9/RIFtGpY
         sNhyoLgqrEicSJVOp7Mj4gzrSZ8C5dKJUFBhvm7CyiFh7hY8e609GAoKoftio07/UIpW
         TlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889475; x=1740494275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipEWRTbUNI0fhw7p2quxgycmIwXwELriTrZg15QiXvk=;
        b=Eo2Ebv9UhOleK6MW36P/z2PKv8CZiU+k3YJIdnbptKE3XpWo9N5ubMBj5Wze0ky9gu
         jqu6xQSLAs0N9yp9TakS+mjADV02A9ROhcztW6J4HoauCV2EdZj4LvnrRGPnQneq8Pw1
         rbti3toOpiE5egRTWGxdDCw8Mt/3T6YvBN6d/gaAQqxRbiGjEyTLMlQqhQh2Ihx18zAR
         seYcBpw6BChuWigQaO5j8Z3VhkT0x3RJ7991wyjDFCJWylfQuhhstVZia4Ugvph9EiPC
         H5Dn80n5Q3FpQ6mAfIOD1MB2ZUtzXPGwWhPd8vZcrGkRMjJKbm0xrlJQNwEmwRoDben2
         cjBA==
X-Forwarded-Encrypted: i=1; AJvYcCURid0dLYlIZyydYmY02y/WJg9ItrYBigijRVpctpibIp5bX7NEGbLc7wImCf4Yzv9p5cBGZGdLRejw@vger.kernel.org, AJvYcCV6PjIqeMPZ31WX25VJsDUlUpIT56PpCeegNgPC02sy8PwKg/OYbWl8WImSoSO6HMa9PK4S4nvULeWNhyjX@vger.kernel.org, AJvYcCVO1B/d9q24Zd9LxXCDBlhlg0PDEaCK2v14hOJerA8AxnCm/oqT+c4QxHAXFrQ8amrl8DaadfTAxVrjFR0u@vger.kernel.org, AJvYcCW99I+pjF1XGgNQam3n+TBIL6xLgUAkZR6uYZskITMRWjNO6lP21kni2cVjBvMn9oKnS8W8+2ocUGnCDFVr6qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCqs0tdOjlMovYeHr103Fw9K3W1LoOsLwqyzzCGWSepTDmlGE
	NN1ISkHw1dSuvVlghHuaC7mICd2gBEml7JWFtXDWIuTTNvvkgTYb
X-Gm-Gg: ASbGncsg6iTmnNesH2/Fn5VruiWRVhUdMQaBlKaBhb+8lBffnH5QSd1Z5mNtAxnLlTA
	/q2N90SVlZWkV5HPEJYvPcmZT2JsJ+sNq++iVKVCfRxQHhI+RmIeNx0D1QSSveQjV3FcVwM32Gh
	uyiSS32JtiYgrSbT+4Wlg2nhNMVoIxryQg+Hnxm2ZFlZVRlE89h8edub4kfKEjNhZwcUzEdhulT
	IUsCLRuIe2hbicLuxbEyse30tiPhnDlaaAF8vIwjmHiimZcdfG1ICjIAENdGZy9eG2JfUabk2Zb
	T3Ed74tVik4ZPMi6qww1r5ns6G3PLdqsJVLJ5rA=
X-Google-Smtp-Source: AGHT+IGWGozAyJpwGUgR/1ZiePcXGyBqaVKmWP4LBKOh5G7+06ogLFFHWvR9tghEbSQhwtHQ6RAYsQ==
X-Received: by 2002:ac8:5e0b:0:b0:471:837f:d5bf with SMTP id d75a77b69052e-471dbd1a17amr194869601cf.12.1739889474669;
        Tue, 18 Feb 2025 06:37:54 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:283f:a857:19c2:7622])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ef0a5943sm24409281cf.51.2025.02.18.06.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:37:54 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Feb 2025 09:37:45 -0500
Subject: [PATCH v17 3/3] MAINTAINERS: add entry for Rust XArray API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-rust-xarray-bindings-v17-3-f3a99196e538@gmail.com>
References: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>
In-Reply-To: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>
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


