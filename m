Return-Path: <linux-fsdevel+bounces-3568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E13B47F698C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 00:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B851B20F00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4094405FD;
	Thu, 23 Nov 2023 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlkgCF7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCB14F8F;
	Thu, 23 Nov 2023 23:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D65C433C8;
	Thu, 23 Nov 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700782827;
	bh=Xm4N+IK6cCfxBp62n/HaElU5RuamPewSwlV6BouTrZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlkgCF7AZc1nwFkrrVNZuXJNAG5eIED8A7ChoGgowDuHL4jfLEjpU0uBC3MyH64TP
	 6Mr642Nu906RKxsWhnunaXu4vOWG50BLV3gvPZCSTkfwk+NFz9KmDo3ugt1TDBbTWf
	 UkLNLEE52qhK+S9FnpC2fMZ6G97ZL+Qqnil6pgUq1gEgrHIFyTL0S0Iz/KqZM2cvn/
	 9r9Gj1ojWMMveCE88Ak/0OyUT666+xOpgy6+zjUoA79GHQuzKf30E+mZdrZ6JyBHII
	 ZjmzKbXvCysFW6N9HgCGOFmoMBJ9NpgMjob9u8Ncb7zT5Bw6BEKV6zBdKUBWa1JW+J
	 hSmiymEd/cUiA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ebiggers@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com,
	amir73il@gmail.com,
	kpsingh@kernel.org,
	roberto.sassu@huawei.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v13 bpf-next 3/6] Documentation/bpf: Add documentation for filesystem kfuncs
Date: Thu, 23 Nov 2023 15:39:33 -0800
Message-Id: <20231123233936.3079687-4-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123233936.3079687-1-song@kernel.org>
References: <20231123233936.3079687-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a brief introduction for file system kfuncs:

  bpf_get_file_xattr()
  bpf_get_fsverity_digest()

The documentation highlights the strategy to avoid recursions of these
kfuncs.

Signed-off-by: Song Liu <song@kernel.org>
---
 Documentation/bpf/fs_kfuncs.rst | 21 +++++++++++++++++++++
 Documentation/bpf/index.rst     |  1 +
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/bpf/fs_kfuncs.rst

diff --git a/Documentation/bpf/fs_kfuncs.rst b/Documentation/bpf/fs_kfuncs.rst
new file mode 100644
index 000000000000..8762c3233a3d
--- /dev/null
+++ b/Documentation/bpf/fs_kfuncs.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _fs_kfuncs-header-label:
+
+=====================
+BPF filesystem kfuncs
+=====================
+
+BPF LSM programs need to access filesystem data from LSM hooks. The following
+BPF kfuncs can be used to get these data.
+
+ * ``bpf_get_file_xattr()``
+
+ * ``bpf_get_fsverity_digest()``
+
+To avoid recursions, these kfuncs follow the following rules:
+
+1. These kfuncs are only permitted from BPF LSM function.
+2. These kfuncs should not call into other LSM hooks, i.e. security_*(). For
+   example, ``bpf_get_file_xattr()`` does not use ``vfs_getxattr()``, because
+   the latter calls LSM hook ``security_inode_getxattr``.
diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index aeaeb35e6d4a..0bb5cb8157f1 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -21,6 +21,7 @@ that goes into great technical depth about the BPF Architecture.
    helpers
    kfuncs
    cpumasks
+   fs_kfuncs
    programs
    maps
    bpf_prog_run
-- 
2.34.1


