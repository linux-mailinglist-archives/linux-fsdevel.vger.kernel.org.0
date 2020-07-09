Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122F521ABD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 01:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGIX64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 19:58:56 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:21784 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgGIX64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:58:56 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2020 19:58:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2283; q=dns/txt; s=iport;
  t=1594339135; x=1595548735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tF4pr/5XLKqBBsQkjwuwO6riASGyIFysFx/ut+c98HA=;
  b=cCuwIOGJNxx3XPF18pAdLlhRAzpx2+5LmhIdJTb5rYP2zUYB7rs5DZF9
   uaJ8DSYWi4H9LE8P+wXN4qC/2BEM8rlKRCrjW4SWNpYNypLNKhNvVvAkK
   RiBgB0hUw0OzZZ4qaDBgQekrU8GHdEqrI1/uAqWd7mdeRv5w8fLEOHEkX
   0=;
X-IronPort-AV: E=Sophos;i="5.75,332,1589241600"; 
   d="scan'208";a="532948238"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 09 Jul 2020 23:51:50 +0000
Received: from sjc-ads-2033.cisco.com (sjc-ads-2033.cisco.com [171.70.61.221])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 069NpoJ5024104;
        Thu, 9 Jul 2020 23:51:50 GMT
Received: by sjc-ads-2033.cisco.com (Postfix, from userid 396877)
        id E14BAC5C; Thu,  9 Jul 2020 16:51:49 -0700 (PDT)
From:   Julius Hemanth Pitti <jpitti@cisco.com>
To:     keescook@chromium.org, yzaikin@google.com, mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, mingo@elte.hu, viro@zeniv.linux.org.uk,
        xe-linux-external@cisco.com,
        Julius Hemanth Pitti <jpitti@cisco.com>
Subject: [PATCH] proc/sysctl: make protected_* world readable
Date:   Thu,  9 Jul 2020 16:51:15 -0700
Message-Id: <20200709235115.56954-1-jpitti@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.61.221, sjc-ads-2033.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

protected_* files have 600 permissions which prevents
non-superuser from reading them.

Container like "AWS greengrass" refuse to launch unless
protected_hardlinks and protected_symlinks are set. When
containers like these run with "userns-remap" or "--user"
mapping container's root to non-superuser on host, they
fail to run due to denied read access to these files.

As these protections are hardly a secret, and do not
possess any security risk, making them world readable.

Though above greengrass usecase needs read access to
only protected_hardlinks and protected_symlinks files,
setting all other protected_* files to 644 to keep
consistency.

Fixes: 800179c9b8a1 ("fs: add link restrictions")
Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
---
 kernel/sysctl.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7a..aeca2fd 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3223,7 +3223,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.procname	= "protected_symlinks",
 		.data		= &sysctl_protected_symlinks,
 		.maxlen		= sizeof(int),
-		.mode		= 0600,
+		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
@@ -3232,7 +3232,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.procname	= "protected_hardlinks",
 		.data		= &sysctl_protected_hardlinks,
 		.maxlen		= sizeof(int),
-		.mode		= 0600,
+		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
@@ -3241,7 +3241,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.procname	= "protected_fifos",
 		.data		= &sysctl_protected_fifos,
 		.maxlen		= sizeof(int),
-		.mode		= 0600,
+		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
@@ -3250,7 +3250,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.procname	= "protected_regular",
 		.data		= &sysctl_protected_regular,
 		.maxlen		= sizeof(int),
-		.mode		= 0600,
+		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
-- 
1.7.1

