Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4E33894C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 10:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhCLJ4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhCLJzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:55:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338EC061574;
        Fri, 12 Mar 2021 01:55:41 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lKeW2-00F7m8-Jg; Fri, 12 Mar 2021 10:55:30 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/6] um: fix CONFIG_GCOV for built-in code
Date:   Fri, 12 Mar 2021 10:55:25 +0100
Message-Id: <20210312104627.9355049045fe.Ie4896d26d2a4e1116c760cdb91087a1817807ca6@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

With contemporary toolchains, CONFIG_GCOV doesn't work because
gcov now relies on both init and exit handlers, but those are
discarded from the binary. Fix the linker scripts to keep them
instead, so that CONFIG_GCOV can work again.

Note that this does not make it work in modules yet, since we
don't call their exit handlers.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/common.lds.S | 2 ++
 arch/um/kernel/vmlinux.lds.S     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index eca6c452a41b..1223dcaaf7e3 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -84,11 +84,13 @@
   .init_array : {
 	__init_array_start = .;
 	*(.init_array)
+	*(.init_array.*)
 	__init_array_end = .;
   }
   .fini_array : {
 	__fini_array_start = .;
 	*(.fini_array)
+	*(.fini_array.*)
 	__fini_array_end = .;
   }
 
diff --git a/arch/um/kernel/vmlinux.lds.S b/arch/um/kernel/vmlinux.lds.S
index 16e49bfa2b42..2245ae4907d2 100644
--- a/arch/um/kernel/vmlinux.lds.S
+++ b/arch/um/kernel/vmlinux.lds.S
@@ -1,6 +1,8 @@
 
 KERNEL_STACK_SIZE = 4096 * (1 << CONFIG_KERNEL_STACK_ORDER);
 
+#define RUNTIME_DISCARD_EXIT
+
 #ifdef CONFIG_LD_SCRIPT_STATIC
 #include "uml.lds.S"
 #else
-- 
2.29.2

