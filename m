Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1D467DB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbhLCTFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 14:05:06 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43312 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243519AbhLCTFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:05:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 26EE5CE281E;
        Fri,  3 Dec 2021 19:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4BEC53FCD;
        Fri,  3 Dec 2021 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638558098;
        bh=qhIqzvUuq7x/CDXgiR+YK9vTB/venL5eiKQkZSnYM4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJl9sArEjy2oeAV/PGgVpQ3PDQ+MwLOFnwS7uw4wDcqY3Hh6JtR5ePUyFPFKyK/hK
         NrWpZPI0ZVW4tDRhAEHxkrHCS2lGSYWCjUuTlM+Qmqwim1DJZonDHcRxet9UneTfMD
         +hEBNlRQeBDkF6k6Aw27kZcE9XtMkU7yesmVjWAotAetOxVEQfGv8X6UASWdobEuf5
         pSDHa2r2J1H5HtUAvz6yi2+/ARXYlv3I/FpHQGmlppquQ2vom7H5hreE3XSSIiRCYY
         0a9f5XT9sqGZM8MJz9eu+xyqa/NpX/j2eqxuEPz3mv5o5FpjMNrK0MV6K/DLlksSKO
         F+6e+1TXVx0wg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hao Li <lihao2018.fnst@cn.fujitsu.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs/dcache: avoid unused-function warning
Date:   Fri,  3 Dec 2021 20:01:02 +0100
Message-Id: <20211203190123.874239-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211203190123.874239-1-arnd@kernel.org>
References: <20211203190123.874239-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Now that 'dentry_stat' is marked 'static', we can run into this warning:

fs/dcache.c:128:29: error: 'dentry_stat' defined but not used [-Werror=unused-variable]
  128 | static struct dentry_stat_t dentry_stat = {

Hide it in the same #ifdef as its only references.

Fixes: f0eea17ca8da ("fs: move dcache sysctls to its own file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/dcache.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0eef1102f460..c84269c6e8bf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -124,16 +124,15 @@ struct dentry_stat_t {
 	long dummy;		/* Reserved for future use */
 };
 
-/* Statistics gathering. */
-static struct dentry_stat_t dentry_stat = {
-	.age_limit = 45,
-};
-
 static DEFINE_PER_CPU(long, nr_dentry);
 static DEFINE_PER_CPU(long, nr_dentry_unused);
 static DEFINE_PER_CPU(long, nr_dentry_negative);
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
+/* Statistics gathering. */
+static struct dentry_stat_t dentry_stat = {
+	.age_limit = 45,
+};
 
 /*
  * Here we resort to our own counters instead of using generic per-cpu counters
-- 
2.29.2

