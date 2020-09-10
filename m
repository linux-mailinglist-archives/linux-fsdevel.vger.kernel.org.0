Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40A026508A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 22:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgIJUVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgIJUVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:21:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50816C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 13:21:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so5360477pfc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7QYn1yhWQ40fqsjl2bkOVXNzJEardYI1LG85/i6U4Y=;
        b=BclfH4h6+3Bniz3hlYX1B8/uwcukDuLERmdv/too1YSZlXK9dBtB6T76hiHYKxbvf9
         ygrdCHBb2d1zvH8fNVjO46IvyeFd1UQ1/ZyJKm4z7MgXVjH3rg/TxqlBaSg381uGWgSp
         a0ksHPHgB/X4oFDK2ba/ovfJCDRHiImWHRs4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7QYn1yhWQ40fqsjl2bkOVXNzJEardYI1LG85/i6U4Y=;
        b=nAkMbq03JsQLB7kE9TBd/G+V3cEDTznBKs3fvnGxFyPl5ftP/OILc6iQAATdftDGKQ
         Qe5iEocuQohZCxLAATrLzbJDhJBIxqQxvleMIyUpKYzyaoHczjPxbQsiuoC682O+qxbY
         5H94vxvCPYIuYt/0CwOSOhl8BzmLIXXkFe0dcxrT9KUU3zLrODyxLeBPjuuGlLmgEFFl
         VMzfGTq0oEnU0N3wzuc8xkI0IJEv9sSfyE4kvB4jLkF1Hp0WMblkpbhfxfnfZLP5Eeom
         i5oSFkK+pRT9YxSfuT3M/iZkZd38b2Pvvp1WkD+LrwVOvWZ8vREFB/PD8y+wwzwqEblI
         XXMw==
X-Gm-Message-State: AOAM5303UCb1yb64Q3mCvQJ5ctqZ6UJYg5Qfa3q9o2PMYqOpIqL8MMG+
        tHELlJJdGQrgrdN0/DcIkdkfCQ==
X-Google-Smtp-Source: ABdhPJx0DRsV2uk7XRhN5WyrdQ3GN+smsELZkM+SGtSpILq3ccN5AWUrZdo9DI6cB7SYJM/QqYly8g==
X-Received: by 2002:a63:4418:: with SMTP id r24mr5838961pga.8.1599769277620;
        Thu, 10 Sep 2020 13:21:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13sm5241229pgq.41.2020.09.10.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 13:21:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     Kees Cook <keescook@chromium.org>, John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [RFC PATCH 1/6] security/fbfam: Add a Kconfig to enable the fbfam feature
Date:   Thu, 10 Sep 2020 13:21:02 -0700
Message-Id: <20200910202107.3799376-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910202107.3799376-1-keescook@chromium.org>
References: <20200910202107.3799376-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Wood <john.wood@gmx.com>

Add a menu entry under "Security options" to enable the "Fork brute
force attack mitigation" feature.

Signed-off-by: John Wood <john.wood@gmx.com>
---
 security/Kconfig       |  1 +
 security/fbfam/Kconfig | 10 ++++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 security/fbfam/Kconfig

diff --git a/security/Kconfig b/security/Kconfig
index 7561f6f99f1d..00a90e25b8d5 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -290,6 +290,7 @@ config LSM
 	  If unsure, leave this as the default.
 
 source "security/Kconfig.hardening"
+source "security/fbfam/Kconfig"
 
 endmenu
 
diff --git a/security/fbfam/Kconfig b/security/fbfam/Kconfig
new file mode 100644
index 000000000000..bbe7f6aad369
--- /dev/null
+++ b/security/fbfam/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+config FBFAM
+	bool "Fork brute force attack mitigation"
+	default n
+	help
+	  This is a user defense that detects any fork brute force attack
+	  based on the application's crashing rate. When this measure is
+	  triggered the fork system call is blocked.
+
+	  If you are unsure how to answer this question, answer N.
-- 
2.25.1

