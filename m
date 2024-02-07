Return-Path: <linux-fsdevel+bounces-10561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED2884C487
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21871F25DE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E01CD2E;
	Wed,  7 Feb 2024 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtUEw2gi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C851CD1F;
	Wed,  7 Feb 2024 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285518; cv=none; b=M4EOVdy4mIR5+Dz/pjCn3jj59jlcN9nfME/JUU8NCwFQfZ+beKR8DfdXrtXeP8y64X0rPdW6sYbCikpiP6c/OVv+Da5DT+GfTQ8QiOjtAizf89478QAx7VX/Xhec3UqDs8DFh4SC7zBgfxNcwbGWdQOVRJ+SVSun8Kd4DP1ISBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285518; c=relaxed/simple;
	bh=uE6OJVQ9YSoP27CkODIAeXkMzlntU+IcQj/F+5dnDzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUMQhdiQpRjt8CM4bwdj/Mql7zL9cBjHcU2ktApyCiXZDYvaDvXmjqdnBRcrlwn+e0ZFWUndQBwRC0QTIdsezDzgyxYJ1NLWos9GrleIeaPeKR73z2ynFiaibSBb5xJnnXwqbNbMXK20y4uO7+PMUpGEmc4re33b1Tq9FBqPgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtUEw2gi; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso14727739f.0;
        Tue, 06 Feb 2024 21:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707285515; x=1707890315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkwDZBuBbGTcPxqte4yWeQZdnC8yjl5ClvwPnqlCYos=;
        b=jtUEw2giG5WeTUMjIZsdgbXTpHyZE5HDT0TIrjIbPQcGBJsNHivqs1NBWhjMd7mo8f
         qzOAlcpOpYVOtTg+L2saxB3R43645LE9QpL+SLvgIKPFudpew4Cv7HzszTQ0lmk+3arn
         RqncdpkPpYCo5zX2zlFgk+Dhafi79yinzcuUWy2iEuV38gDvoSsZZqWvbQguHXeS6L55
         Eac63R0Q9iCyuKgD5q//EYjMoNWvy8tNXs3a9oLEYqaWWm2o8xMUO8oPXRmm718TdJ8p
         FQncOPUw2O+VrXfpv6yUrnZoooisVlwH2/6txc5bu5Qqv5DAXCgnwCCjZ5dXtR+RX5J9
         aRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707285515; x=1707890315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkwDZBuBbGTcPxqte4yWeQZdnC8yjl5ClvwPnqlCYos=;
        b=L4eYIdtm0QelE1JY0OJsxopKhC0lSF+FVfrmEIVvQ8/u7pO+MvZTIy1zJMIDjxEJP6
         QKtG1kZDHw3FYjoIAefcl9yZ7Jk/h6OFEsHPG43T9vSnHCOIp16NNzIibkJqKNTv3NI9
         zrtsepndazlC+rfvbUMRCaJ0cPvS64/HpNxdBPCbMuYq+KwLlQsiGu0gopWAbIIyEfZF
         VK6IykkZJwn+P46h6SflBG1B3QHl2pWwxrhWT/DkrtC8z5hhndYVJwmOcljHzztsSPek
         fqCTbsQxV8mVR5hNnm6hDSblGStYlGvdt7hgCFnDU+SP9hU4cnnWC0yeaUPd2v+NZzhS
         FyDw==
X-Gm-Message-State: AOJu0Yx6pJgbv5UUeBcAY8PCt2Mon6gkbgF5BxtJDfDjxMoAeB/9RyOW
	K3HjNlppgcjcAKe5QlIDZMOu4ORi0/dyF4sHSMc37HVOO55ZHrtrre6/8SGtJ5w=
X-Google-Smtp-Source: AGHT+IFkCx9oarzlC/nqZWJkzSYlfmZLvGmIpOWg1ZetcBJ5HpCpQCXqyZ9WBOgkR1/kLssi72E1Nw==
X-Received: by 2002:a6b:a01:0:b0:7c3:ffcd:9dde with SMTP id z1-20020a6b0a01000000b007c3ffcd9ddemr358915ioi.8.1707285515078;
        Tue, 06 Feb 2024 21:58:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVx3EcbvFQ6Vy1Gf+U/E7IqUB5Iyq9TATAyOhLakq7oM1EixvRR/wpw03gppawHk7jPg9jScdaQcSqGu6W+P6P4I1M55ME8qrHml0vuB1cgDFWhlPNlWxopVM+Pc77tXamEHva7egZGJCUxaFrGyPvOSS6c5inRDKePddLig6zMKabRQ3TlflCgPEdFcYVwqQQdL2kBvTN6gtPpXrnITkgW+q2+tpfsT3YZlZxmoeqAHD9hObZcmDeNEkuy4DuO5TJ3kPJeKJZ+vUF7HiLElgseQirLOXpOY0ar
Received: from fedora-laptop.hsd1.nm.comcast.net (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id c24-20020a02a618000000b004710f04c411sm109425jam.76.2024.02.06.21.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:58:34 -0800 (PST)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kent.overstreet@linux.dev,
	bfoster@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH RFC 2/3] bcachefs: create framework for Rust bindings
Date: Tue,  6 Feb 2024 22:58:18 -0700
Message-ID: <20240207055818.611679-1-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds infrastructure for Rust bindings, generated by bindgen, for
bcachefs internal use. The Rust code is only enabled when a new config
option, BCACHEFS_RUST, is defined. This option depends on RUST.

This change does not generate any bindings; future patches will use the
framework introduced here to add Rust code to bcachefs.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 fs/bcachefs/.gitignore                 | 3 +++
 fs/bcachefs/Kconfig                    | 6 ++++++
 fs/bcachefs/Makefile                   | 9 +++++++++
 fs/bcachefs/bindgen_parameters         | 5 +++++
 fs/bcachefs/bindings/bindings_helper.h | 3 +++
 fs/bcachefs/bindings/mod.rs            | 3 +++
 6 files changed, 29 insertions(+)
 create mode 100644 fs/bcachefs/.gitignore
 create mode 100644 fs/bcachefs/bindgen_parameters
 create mode 100644 fs/bcachefs/bindings/bindings_helper.h
 create mode 100644 fs/bcachefs/bindings/mod.rs

diff --git a/fs/bcachefs/.gitignore b/fs/bcachefs/.gitignore
new file mode 100644
index 000000000000..35be43f02195
--- /dev/null
+++ b/fs/bcachefs/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+bcachefs_generated.rs
diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
index 5cdfef3b551a..6d40669dca00 100644
--- a/fs/bcachefs/Kconfig
+++ b/fs/bcachefs/Kconfig
@@ -33,6 +33,12 @@ config BCACHEFS_QUOTA
 	depends on BCACHEFS_FS
 	select QUOTACTL
 
+config BCACHEFS_RUST
+	bool "bcachefs Rust support"
+	depends on BCACHEFS_FS && RUST
+	help
+	This enables the internal Rust bindings for bcachefs.
+
 config BCACHEFS_ERASURE_CODING
 	bool "bcachefs erasure coding (RAID5/6) support (EXPERIMENTAL)"
 	depends on BCACHEFS_FS
diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index 1a05cecda7cc..3f209511149c 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -89,4 +89,13 @@ bcachefs-y		:=	\
 	varint.o		\
 	xattr.o
 
+always-$(CONFIG_BCACHEFS_RUST)		+= bindings/bcachefs_generated.rs
+
+$(obj)/bindings/bcachefs_generated.rs: private bindgen_target_flags = \
+    $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
+
+$(obj)/bindings/bcachefs_generated.rs: $(src)/bindings/bindings_helper.h  \
+	$(src)/bindgen_parameters FORCE
+	$(call if_changed_dep,bindgen)
+
 obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
diff --git a/fs/bcachefs/bindgen_parameters b/fs/bcachefs/bindgen_parameters
new file mode 100644
index 000000000000..547212bebd6e
--- /dev/null
+++ b/fs/bcachefs/bindgen_parameters
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+--allowlist-function ''
+--allowlist-type ''
+--allowlist-var ''
diff --git a/fs/bcachefs/bindings/bindings_helper.h b/fs/bcachefs/bindings/bindings_helper.h
new file mode 100644
index 000000000000..f8bef3676f71
--- /dev/null
+++ b/fs/bcachefs/bindings/bindings_helper.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../bcachefs.h"
diff --git a/fs/bcachefs/bindings/mod.rs b/fs/bcachefs/bindings/mod.rs
new file mode 100644
index 000000000000..19a3ae3c63c6
--- /dev/null
+++ b/fs/bcachefs/bindings/mod.rs
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+
+include!("bcachefs_generated.rs");
-- 
2.43.0


