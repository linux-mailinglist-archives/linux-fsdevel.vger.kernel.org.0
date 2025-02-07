Return-Path: <linux-fsdevel+bounces-41200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9BA2C44A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0D53A7BB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B8A214A9C;
	Fri,  7 Feb 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja+rTEGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA61F76BD;
	Fri,  7 Feb 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936732; cv=none; b=iKa+sMylBHeS9684Jh1LTvp1SnmkSxNAB/zS2ThDsdvAfIc406jATQzCqYcZTtekCxQTRjiMxZ3k90gUuiVnp9eKdle93gCha/63KJDG6z5uNcrT1WwEtUdZLEUoW/fNSZybqbVT3eVOVscOmc6EUAcwPtIUXlV5sKlFTNQt3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936732; c=relaxed/simple;
	bh=U+Qc9yDzlFcfSbcLQ8+EjkelL/BGK5QZfWUtRfyC07w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=raSeSXfZXHmFgiFCH61kNUb+LN57TsM4gNtYhQDMY9OpsukNzgDtDdJRfurU9BvT7MsCYGed5Ky4zqWAPFCus4BcrjOb940BPl2j6pOyXT/Drhr8UG1JXLo2adcy7fzVUZ+8aouqRYS+Jtjgnm8T1Rurz4stNg+i5pLqK7LPJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja+rTEGt; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7bcf32a6582so188826085a.1;
        Fri, 07 Feb 2025 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738936730; x=1739541530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVCZw/m2XLPWza3hqEAZhBT+UfWA+IsYv3mZHv/oOJc=;
        b=ja+rTEGtkrxVEVe0ekX5lOJqEx5U+1g8xsJsNJ5c6CtxTzUDg0c87jX6wM94PvvQp3
         /sOzUxWN+va6jyUtvkqOgwk99cguAx1M47Js0BD5EjLypzmCBIshBkdk57tWSVNfa0XQ
         G6aI1T61qNpTMCX4OcHsDNnFpWC/0AfBcRhE24gsZpusETuu54IFRoC1vU1sK1CS+RKA
         p+7MgA0BUjN4QkEtD+W1hxHpASug9LfIc6iJCboNwtC1vqtaAH55xr7PDl1dqdTIRdMq
         IDPo3C9oZsWDr1rUaLpO2No/00CNGZ7lhrviA82T1P0AdqzG1KEyR/4YJCJOBhrizuIB
         9mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936730; x=1739541530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVCZw/m2XLPWza3hqEAZhBT+UfWA+IsYv3mZHv/oOJc=;
        b=kPkSa2wAro4NlSvZVIK98Ieo8dZcuX9vKBLkE1Ds4KT4yFkhQBZYZxD+EW+u4MDvhT
         JKc7tao6OHtm05C0OkuoZ2Wu9lkJUTtJ6vNDVi0mFVBW4+07S8AyLbcm3AsTuJ3+5H+f
         BWV07lENcfJP6//satflAVzPljLx/xGbbC3p/M3n+l2b8CplTwEcnl8Uxl9nlorpxSNR
         K38yy/kaaA0XBsiV0kcXVVq7BHjGoWehuSaLO4hhuN2RcZsvG0Xon2/O/onFWElPWYaN
         XO102rq5EfXl7xyXX201setqrYpCtwkvuCFPOof56coYl0D4YAmSUXuk0tq5AJTUfSh+
         K1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWGOxrgtxuMfNDz4VT94TQn9OpiTqjkHdbFxcCIeBtbMFIGKo/92u9rVMOz4EXQLkCqz7/7nU9noUuqbnjpeFs=@vger.kernel.org, AJvYcCWqOqaiH5pk6RufhAMTF6mkbR+tuPtRzizQpOCw/DqD7Y7ST8DAyt5PoT/5+hFgDPKYLLAUK17zpvAi1lNF@vger.kernel.org, AJvYcCXxF97A9Mi7i7FRuufRv8M5Iq2Hfn/w4e3/JFUrPVuIKU3ZM9uFLghrjRbRL7nDoU1d52m0SQIxTClmQJuQ@vger.kernel.org, AJvYcCXys4sSCo5au/rWdhEGAktLc2jcd178JLN5be4dsduDi2AcaD0dEMcNZkCp37iuyi3+vL6FagJB3jjg@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRVmRpS0quvRGkPhMQHMkP8u6oCTK5vkW5pwrik5AtARP5P05
	jnVW57Tgwdgf9qiHRoj6dvwL37osgLbtyfk1nuICGDr/3aSPzvxM
X-Gm-Gg: ASbGnct/JJNvEUN+D0azm5INb6EY5F1Ckrs4OddVjosLdLTvLFPuCjybVkXQ87jpgb8
	KkugF06F7/whN3Mq0CuJnkql/E9CHvfHGp8wY/zwxciRjNVV7CXUKZTuO8T+mSRUYZdQgxxem5V
	2KAUEquRmk3IXq+wVQoGq6cQphArg0hc9H3ITBJ+oxlXKpCfuRU18rbtCEh7mvi8kNuqww49mBM
	3RiTxe8+w3qvnpobzXwnDd4e5nHorn21TPZDz07R0gfSk0vm8SdSKhrV8/bo9JrMIgdFsNKjIh+
	3klOx5YQvCcqyDFdQBMBhtqxFRewajc3FO8=
X-Google-Smtp-Source: AGHT+IGmLVkr5MZzrT5HfwPcZT9faF46dg2WAfvnxPktSkECPMwgcRbLtUhoPVu2iNld0LYucSIViw==
X-Received: by 2002:a05:620a:270c:b0:7b6:dc4f:8879 with SMTP id af79cd13be357-7c047c97716mr601107285a.47.1738936730013;
        Fri, 07 Feb 2025 05:58:50 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e11d19sm191919685a.52.2025.02.07.05.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:58:49 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 08:58:24 -0500
Subject: [PATCH v16 1/4] rust: remove redundant `as _` casts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-rust-xarray-bindings-v16-1-256b0cf936bd@gmail.com>
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

Remove redundant casts added in commit 1bd8b6b2c5d3 ("rust: pci: add
basic PCI device / driver abstractions") and commit 683a63befc73 ("rust:
platform: add basic platform device / driver abstractions")

While I'm churning this line, move the `.into_foreign()` call to its own
statement to avoid churn in the next commit which adds a `.cast()` call.

Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
Fixes: 683a63befc73 ("rust: platform: add basic platform device / driver abstractions")
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/pci.rs      | 3 ++-
 rust/kernel/platform.rs | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4c98b5b9aa1e..6c3bc14b42ad 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -72,10 +72,11 @@ extern "C" fn probe_callback(
 
         match T::probe(&mut pdev, info) {
             Ok(data) => {
+                let data = data.into_foreign();
                 // Let the `struct pci_dev` own a reference of the driver's private data.
                 // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
                 // `struct pci_dev`.
-                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
+                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data) };
             }
             Err(err) => return Error::to_errno(err),
         }
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 50e6b0421813..dea104563fa9 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -63,10 +63,11 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
         let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
         match T::probe(&mut pdev, info) {
             Ok(data) => {
+                let data = data.into_foreign();
                 // Let the `struct platform_device` own a reference of the driver's private data.
                 // SAFETY: By the type invariant `pdev.as_raw` returns a valid pointer to a
                 // `struct platform_device`.
-                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data.into_foreign() as _) };
+                unsafe { bindings::platform_set_drvdata(pdev.as_raw(), data) };
             }
             Err(err) => return Error::to_errno(err),
         }

-- 
2.48.1


