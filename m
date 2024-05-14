Return-Path: <linux-fsdevel+bounces-19425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE258C56D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CBCB22647
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC30145A0F;
	Tue, 14 May 2024 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ4H+8lq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B501459ED;
	Tue, 14 May 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692661; cv=none; b=czNNg2Eki24jnT4Nkqu1hmOj+Mh0M//BlK2z9cQeE7ULuf9kg4Qx1cDdPrE8GbGslr6uVB2zD6eGa9tW425/7lijd0TjA9Xe3HH9XxUgdl9xUG6iC/Tz1pCbNXfLX1ykgRmxRll4PtlfCT86IbddjLpHHkK5sqh6OMnG99CR8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692661; c=relaxed/simple;
	bh=DBzT/f9hz5kzEs1Lm2UwR9EBpOc9RzF/B/rScSdn5yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVTC1eZ90m/DwMjla8Su0aWJRTixuHbAtul/CaReg+rVUhD3awBpARdqoE7I+2t0hyyD3kpyA3lK6HMh19YDiFPS4MgZhb/fBlqHb4+f8TsTjBIpBB8QUORnyPooBSN/yRIfhCww/CVYhVVH/CLjlmDUCf3Rxeh1Z+sOlCme6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ4H+8lq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso43594535ad.0;
        Tue, 14 May 2024 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692659; x=1716297459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB+WIMSatnqqUVhcX1WxfgkTneiX5pxrA/ncOnhz7vc=;
        b=eQ4H+8lq+XpOKKs5qjYNn1SNVLKvcFRfTVSse9ZvoNlpqeIRAzDHyln4F8sNrcHued
         L971ZrIZr/G9rijh/2s7pS6wglVWL0YjaSe4aniWd5ovLpbvpPDOEZuveCM5jxZAXK4A
         7Wvf3PfGhwABqvzIiTtZK3whukTHw0eKu57+Zwlv4l+m661fc8Ek26vJJiS29caQ5Yt+
         PWI9+1t0WG4nDOgYPQ+vRLB60fCAZNIMkX1qe+Z/DvsBPOtEfQnbJ06NL9ZwOHRhlYQ0
         5koTUdWtI8f5rWEWsI9jgGUyeNX74QXyyesAIXZhA22xyeaYP/OkwkZfholQcK977NZe
         Sh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692659; x=1716297459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB+WIMSatnqqUVhcX1WxfgkTneiX5pxrA/ncOnhz7vc=;
        b=Gjeh2exRrCt+q5ohkpKiun+qfuwg3zgopngrkWUyvWqT3DZ/fSY2NmTe49Jot+Oq/V
         DN7nkke32iQoL+lq+EeTR5jKeE89ToU8azKAlKWkei1MapXYPCVTOj4RtforIqbjekIt
         vKTxELaGPJtp+xJCohkcwIHalVDYui80N3fL/kT1iJCQDFC8Ak1Ef1grz83xrsN7oYxu
         vIJ0tsU3q5pZEgOxqcgv/s1uDv0dyGLFXr2bFXAxfo6C3q9l0/6xKA4bOJeq77pzft9R
         yOUiBfmnWKbPfKozmz64DCt4GzoamlnSdOf9TmyPSB97nD1M36wjMejQGmvHHVyvs7zC
         udxA==
X-Forwarded-Encrypted: i=1; AJvYcCV/km0a13R3Hkv5f4MQPd81NzKKP5HgbcOQuD8dLj+se9V28tq+N+yU0LDxlB3nTIfRh6kDs/ldV1EyQLJBB69wFZUL5G5dpjZ1OkJc5rzrStgMCsc1l0XUzgO0uO663fTufR3v5SLSnqNLseLBq3F8UPfLk7kGE2zspRk/FlIICo9w+duGxEyhEQ7k
X-Gm-Message-State: AOJu0YwDYkTS2iXIByJxsyrpWHp+c14wEY70w96+tWi3HWbHsUixT2Vd
	D6/DTZbHXdbupnPK++/wC1SVEVBkjjH+brXmK7fIEqMDTN15WVLP
X-Google-Smtp-Source: AGHT+IE0XbCRPPJ26mkbp8Q1xkHdIdFzDb4rGbrIWWlGfet7iN0OnUqPUqA0afyCPKhWnRhWgAL1oQ==
X-Received: by 2002:a17:902:bf04:b0:1e2:1df:449b with SMTP id d9443c01a7336-1ef44182635mr121080315ad.69.1715692659332;
        Tue, 14 May 2024 06:17:39 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:39 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH v2 03/30] samples: rust: add initial ro file system sample
Date: Tue, 14 May 2024 10:16:44 -0300
Message-Id: <20240514131711.379322-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514131711.379322-1-wedsonaf@gmail.com>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Introduce a basic sample that for now only registers the file system and
doesn't really provide any functionality beyond having it listed in
`/proc/filesystems`. New functionality will be added to the sample in
subsequent patches as their abstractions are introduced.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 samples/rust/Kconfig      | 10 ++++++++++
 samples/rust/Makefile     |  1 +
 samples/rust/rust_rofs.rs | 19 +++++++++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 samples/rust/rust_rofs.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 59f44a8b6958..2f26c5c52813 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -41,6 +41,16 @@ config SAMPLE_RUST_PRINT
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_ROFS
+	tristate "Read-only file system"
+	help
+	  This option builds the Rust read-only file system sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_rofs.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 791fc18180e9..df1e4341ae95 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -3,5 +3,6 @@
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_INPLACE)		+= rust_inplace.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_ROFS)			+= rust_rofs.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
new file mode 100644
index 000000000000..d465b107a07d
--- /dev/null
+++ b/samples/rust/rust_rofs.rs
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust read-only file system sample.
+
+use kernel::prelude::*;
+use kernel::{c_str, fs};
+
+kernel::module_fs! {
+    type: RoFs,
+    name: "rust_rofs",
+    author: "Rust for Linux Contributors",
+    description: "Rust read-only file system sample",
+    license: "GPL",
+}
+
+struct RoFs;
+impl fs::FileSystem for RoFs {
+    const NAME: &'static CStr = c_str!("rust_rofs");
+}
-- 
2.34.1


