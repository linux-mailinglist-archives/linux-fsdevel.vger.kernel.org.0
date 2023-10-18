Return-Path: <linux-fsdevel+bounces-631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7517CDB82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBFD281C6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3828347B2;
	Wed, 18 Oct 2023 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdGvdu00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD91CF89;
	Wed, 18 Oct 2023 12:25:54 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F432114;
	Wed, 18 Oct 2023 05:25:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9a1762b43so54658475ad.1;
        Wed, 18 Oct 2023 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631952; x=1698236752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+P20rWuZA6yxfRBKzWJs22aPk/q3dgVSUAZONRYMjw=;
        b=PdGvdu00sRSA1Yaa8GQHorCi1ikzK7miFi0PT447y6PSw1GHzuCuxUEVsjcBreQw1v
         35e0DY8+ObBLC1IZINlSp9xz8IQapzw5IxdXpXh7rwyEucFrfSJXrxk/a2ZVCAub/DBX
         bmF3f92cAo9AQdE7ZIvz6b2V+yWEh/nlorvRpG6c+tIU8rLaJ7pf1YeOxOpVOK/0B5pU
         gou4o5QTJN4DFGhtCzKPUqeVaHRHu4fnTTg3c6rXZqPz8GCJSVVm76Pl0CCmTs12+xWl
         MbYFuxqUDlMf0DHyTDnzShKkvF5Tn7OxXkTNeAeXs9YqX9GptecG+GnFVN6fg8E09RAv
         uvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631952; x=1698236752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+P20rWuZA6yxfRBKzWJs22aPk/q3dgVSUAZONRYMjw=;
        b=NRNvFBlpMUvTsQvIc8/jgMlfQNsgZ49h8NZRHzlJdecP+uuVjyV0OeFk8bfxc2NUgU
         4K2v984lMEYIi8AcrGtVeeeTtFPW02hWrwSeSlA36m9jXpIwnyhbKb3cC/0KzQGBuWhU
         1zdArUJuCzqLn6BEOs7w6FpjXTmOgvxhzOXB1UzLGsXammUmVcCrvafVnbriDA6kXwTM
         WKfXsGOvlWjdbyLxtSzf3O4j1mUqbF3m1g47LgS6sU3JoJV6AdrWuq3Dk2Z87jFCQJew
         83hA3fKNWI7F2MnP2VJP/m3031JaJOywBMQqpNLDxPaTccrWnfAreLQipZepF9q7asRF
         DLHw==
X-Gm-Message-State: AOJu0YyKZD71nn7aZbfb24leRwa9u1CD59ObaS3uv/IESVLoS8Jg/0m0
	2uYH5muxaYwc0mxOeMrvOiCAykreKWc=
X-Google-Smtp-Source: AGHT+IExtLOqLAdx/C44xqAH7PSDp+Ode8C4dtrhLN5L0D5UrJBHynOp5U70WUKrkqTijfMiNwnDKA==
X-Received: by 2002:a17:902:e84e:b0:1c9:bf02:6638 with SMTP id t14-20020a170902e84e00b001c9bf026638mr6329839plg.51.1697631951913;
        Wed, 18 Oct 2023 05:25:51 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:25:51 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 03/19] samples: rust: add initial ro file system sample
Date: Wed, 18 Oct 2023 09:25:02 -0300
Message-Id: <20231018122518.128049-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018122518.128049-1-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 000000000000..1c00b1da8b94
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
+    const NAME: &'static CStr = c_str!("rust-fs");
+}
-- 
2.34.1


