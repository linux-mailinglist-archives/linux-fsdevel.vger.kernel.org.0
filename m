Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149797437EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjF3JJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 05:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjF3JJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:09:02 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9BE5E;
        Fri, 30 Jun 2023 02:09:01 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1688116139;
        bh=OOAKwOFfZgl3msnuVjn16jsWxbjqhfuBBnZpLziJnjI=;
        h=From:Date:Subject:To:Cc:From;
        b=nAHp3GNWH3bIQbbJ7B2nTlLTXY9Xq9hWNzqd0TfTgHy3IlpLDeWD+dqQm7O/eXYKH
         0K/WErRYqTmvh7xyi3fti32K8jO6hhbiSopGvMb1wcI5VLDlClgpI9DBF50J9KHfdA
         jEofzwLiPn0IJVU1BBMtLuj1xR1dkREs+FIaJFUk=
Date:   Fri, 30 Jun 2023 11:08:53 +0200
Subject: [PATCH] mm: make MEMFD_CREATE into a selectable config option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230630-config-memfd-v1-1-9acc3ae38b5a@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKSbnmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDMyNL3eT8vLTMdN3c1Ny0FN2kVLPENAPjJPOU5EQloJaCotS0zAqwcdG
 xtbUA9l1O0V4AAAA=
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Willy Tarreau <w@lwt.eu>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688116137; l=2138;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OOAKwOFfZgl3msnuVjn16jsWxbjqhfuBBnZpLziJnjI=;
 b=kQBkkRFrqk5TKAAbU2s4iVjeJ2yAWu+HDlzAGyCqAqXUgKoaMED26dyk7Wz3UwkSiKAieqaCN
 wukedK6JuBXC9N+wJRWyCzBe5NaSB5lv8wz20O/k+hugFZlrp9EiaeA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The memfd_create() syscall, enabled by CONFIG_MEMFD_CREATE, is useful on
its own even when not required by CONFIG_TMPFS or CONFIG_HUGETLBFS.

Split it into its own proper bool option that can be enabled by users.

Move that option into mm/ where the code itself also lies.
Also add "select" statements to CONFIG_TMPFS and CONFIG_HUGETLBFS so
they automatically enable CONFIG_MEMFD_CREATE as before.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/Kconfig | 5 ++---
 mm/Kconfig | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 18d034ec7953..19975b104bc3 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -169,6 +169,7 @@ source "fs/sysfs/Kconfig"
 config TMPFS
 	bool "Tmpfs virtual memory file system support (former shm fs)"
 	depends on SHMEM
+	select MEMFD_CREATE
 	help
 	  Tmpfs is a file system which keeps all files in virtual memory.
 
@@ -240,6 +241,7 @@ config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends on X86 || IA64 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
 	depends on (SYSFS || SYSCTL)
+	select MEMFD_CREATE
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
@@ -264,9 +266,6 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
 	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
 	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
 
-config MEMFD_CREATE
-	def_bool TMPFS || HUGETLBFS
-
 config ARCH_HAS_GIGANTIC_PAGE
 	bool
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 09130434e30d..22acffd9009d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1144,6 +1144,9 @@ config KMAP_LOCAL_NON_LINEAR_PTE_ARRAY
 config IO_MAPPING
 	bool
 
+config MEMFD_CREATE
+	bool "Enable memfd_create() system call" if EXPERT
+
 config SECRETMEM
 	default y
 	bool "Enable memfd_secret() system call" if EXPERT

---
base-commit: e55e5df193d247a38a5e1ac65a5316a0adcc22fa
change-id: 20230629-config-memfd-be6af03b7dca

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

