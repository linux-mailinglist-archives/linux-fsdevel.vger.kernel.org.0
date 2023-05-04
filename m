Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B7A6F782B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 23:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjEDVab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 17:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEDVa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 17:30:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199B14903;
        Thu,  4 May 2023 14:30:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so1850369a12.2;
        Thu, 04 May 2023 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683235822; x=1685827822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpDrHaDFb9uvY+Y5nUdaIxQKRWlMia3wPTlgfDNdf4c=;
        b=qwrCJncTbPjo7OVmLb6DC5CkyjhsTdxQEiYUjTISYeax0QnqJ+7w+fLvAGvuaJxaPp
         Biy+dpVNBJiWXPjTLS+Qjh7jTGnXGR054skBqurueUu4mQWWDFwk051N9sNmIVKpJlSm
         TtFoeRQKXeWTkPAParUiybl3T2AqyyLA+h36wqpHyuC/fQmynrFvoPnWeHhOkaJH1Jgj
         u9rNKsiyyy6gEYMZweRZ7GkEXNtSkiCyE7OhDcLiksv0RNr5Wlce5aK2IPjhGIYzVfJv
         S2Mmws/AseRyPGDs1Z8egoP2B3KfaGRUmRGMnwRjiF7GyKCb+bPVpN6/r4DPaYbQPKxw
         I93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683235822; x=1685827822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpDrHaDFb9uvY+Y5nUdaIxQKRWlMia3wPTlgfDNdf4c=;
        b=OiZmNVo3nQiDmvpP+ftmHtworouaDDMy0aubqC95sCwi6KWrsPOK6Pbl+AeJbP0Z8C
         AkwemZuORfhE7qnonf1BfQs5MvkmRG3pvYF/k/9KNdK//AZ65aCN6AW9aBKKozmQR55T
         XOYPNi3+UqVtxK1RnzTiMlMGH7MIKtiVGb0A1vg2+2r840ZAWBLKxHY0974SYKODXnoW
         La2/QWpBvEg1nM6SchIKthNvqkU9E/7nS1il9alqnBZ9othkJ+xm7fBPgpD4rcp+UPhv
         p7F7voIqzvYPi2dKiSPj0PY5Y6yce00MTSShmMIRBOMYsN1yu0kxTIqGkHJp/GAXFaSy
         tKvg==
X-Gm-Message-State: AC+VfDxF7Elk/DxeXGQl3t3LNJE1Mh2yqindqU1EPMICfPdWPO7a9q6I
        eoiK/Ca5n6ZfcQhVQ71QLhC1Btm6OEmEFsvZpm4=
X-Google-Smtp-Source: ACHHUZ5Wn3isdXputF03nNuI/MZ3Uu+owH1nKZqePrOGnu81HEC8Zu53kDXxLbOPkyMXsTcPaUAMwg==
X-Received: by 2002:a17:906:4785:b0:94a:7716:e649 with SMTP id cw5-20020a170906478500b0094a7716e649mr222144ejc.13.1683235822205;
        Thu, 04 May 2023 14:30:22 -0700 (PDT)
Received: from MIKMCCRA-M-GY0W.cisco.com ([2001:420:c0c0:1001::d1])
        by smtp.gmail.com with ESMTPSA id bz1-20020a1709070aa100b008f89953b761sm63289ejc.3.2023.05.04.14.30.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 May 2023 14:30:21 -0700 (PDT)
From:   Michael McCracken <michael.mccracken@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, serge@hallyn.com,
        tycho@tycho.pizza, Michael McCracken <michael.mccracken@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] sysctl: add config to make randomize_va_space RO
Date:   Thu,  4 May 2023 14:30:02 -0700
Message-Id: <20230504213002.56803-1-michael.mccracken@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_space
sysctl to 0444 to disallow all runtime changes. This will prevent
accidental changing of this value by a root service.

The config is disabled by default to avoid surprises.

Signed-off-by: Michael McCracken <michael.mccracken@gmail.com>
---
 kernel/sysctl.c | 4 ++++
 mm/Kconfig      | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index bfe53e835524..c5aafb734abe 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1913,7 +1913,11 @@ static struct ctl_table kern_table[] = {
 		.procname	= "randomize_va_space",
 		.data		= &randomize_va_space,
 		.maxlen		= sizeof(int),
+#if defined(CONFIG_RO_RANDMAP_SYSCTL)
+		.mode		= 0444,
+#else
 		.mode		= 0644,
+#endif
 		.proc_handler	= proc_dointvec,
 	},
 #endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 7672a22647b4..91a4a86d70e0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1206,6 +1206,13 @@ config PER_VMA_LOCK
 	  This feature allows locking each virtual memory area separately when
 	  handling page faults instead of taking mmap_lock.
 
+config RO_RANDMAP_SYSCTL
+    bool "Make randomize_va_space sysctl 0444"
+    depends on MMU
+    default n
+    help
+      Set file mode of /proc/sys/kernel/randomize_va_space to 0444 to disallow runtime changes in ASLR.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.37.1 (Apple Git-137.1)

