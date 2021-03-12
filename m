Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69355338951
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 10:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhCLJ4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 04:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhCLJzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:55:47 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09165C061762;
        Fri, 12 Mar 2021 01:55:47 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lKeW2-00F7m8-UP; Fri, 12 Mar 2021 10:55:31 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/6] um: fix CONFIG_GCOV for modules
Date:   Fri, 12 Mar 2021 10:55:26 +0100
Message-Id: <20210312104627.54210a33e4c0.I9807ad0ea6ee21a81f86d367f3b61e5f24f8b30b@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

At least with current toolchain versions, gcov (as enabled
by CONFIG_GCOV) requires init and exit handlers to run. For
modules, this wasn't done properly, so use the new support
for CONFIG_MODULE_DESTRUCTORS as well as CONFIG_CONSTRUCTORS
to have gcov init and exit called appropriately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig.debug    | 2 ++
 arch/um/kernel/process.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/um/Kconfig.debug b/arch/um/Kconfig.debug
index ca040b4e86e5..74b27b11cb44 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -17,6 +17,8 @@ config GCOV_BASE
 	bool "Enable gcov support (selectively)"
 	depends on DEBUG_INFO
 	depends on !KCOV && !GCOV_KERNEL
+	select CONSTRUCTORS
+	select WANT_MODULE_DESTRUCTORS
 	help
 	  This option allows developers to retrieve coverage data from a UML
 	  session, stored to disk just like with a regular userspace binary,
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index c5011064b5dd..33f895a95ff8 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -240,6 +240,8 @@ void do_uml_exitcalls(void)
 	call = &__uml_exitcall_end;
 	while (--call >= &__uml_exitcall_begin)
 		(*call)();
+
+	run_all_module_destructors();
 }
 
 char *uml_strdup(const char *string)
-- 
2.29.2

