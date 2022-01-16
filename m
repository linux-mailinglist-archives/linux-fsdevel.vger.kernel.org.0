Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F248FC34
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 11:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiAPKof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 05:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiAPKof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 05:44:35 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF231C06161C
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 02:44:34 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:76d0:2bff:fec8:549])
        by xavier.telenet-ops.be with bizsmtp
        id jNkX260060kcUhD01NkXgF; Sun, 16 Jan 2022 11:44:32 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n931S-009zj9-Rx; Sun, 16 Jan 2022 11:44:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n92p4-009x1i-BF; Sun, 16 Jan 2022 11:31:42 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: Fix one_thousand defined but not used warning
Date:   Sun, 16 Jan 2022 11:31:42 +0100
Message-Id: <20220116103142.2371807-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If CONFIG_PERF_EVENTS is not set:

    kernel/sysctl.c:125:12: warning: ‘one_thousand’ defined but not used [-Wunused-variable]
      125 | static int one_thousand = 1000;
	  |            ^~~~~~~~~~~~

Fix this by protecting the definition of one_thousand by a check for
CONFIG_PERF_EVENTS, as is used for its single remaining user.

Fixes: 39c65a94cd966153 ("mm/pagealloc: sysctl: change watermark_scale_factor max limit to 30%")
Reported-by: noreply@ellerman.id.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ef77be575d8754d2..d77208f9a56f2907 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -122,12 +122,12 @@ static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int two_hundred = 200;
-static int one_thousand = 1000;
 static int three_thousand = 3000;
 #ifdef CONFIG_PRINTK
 static int ten_thousand = 10000;
 #endif
 #ifdef CONFIG_PERF_EVENTS
+static int one_thousand = 1000;
 static int six_hundred_forty_kb = 640 * 1024;
 #endif
 
-- 
2.25.1

