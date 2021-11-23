Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34A245AD3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhKWU1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhKWU11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:27:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF0AC061748;
        Tue, 23 Nov 2021 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yJ3RzY1voXG2DzFJBaSjRI3l4NyG6muD9eavq9IoPyE=; b=3dXvzw++60pe790rfdVLpqYe0D
        pGMicrlUvhKSlfahVDwwKOxL7iBAJPSWtd2M3AGpAQpafctCaFJnJbiiTs9fEmgl1nn+7lNsA60Ux
        QzL+VN31wdSePsgeg2VK2g6M330vK4VXg3WVGtY9B1W4kiz8KN6kE22DZb92m0/q3K6LVztmX3ESd
        kgktZbi/PpadZ1xP3ES5xhJrWKD47nfYsk8nXOfPiqRD0DnxPjv8ADkilG8T3IyQXj/clbxR39wXM
        vhz7XsV3vRFLX8VKUMAUeGHu84VXQd+vz61EOf7IPVvTWXrvdiD3fEKSWbhIiBnhI/LqBIkevxTu9
        /8XdN67Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpcKS-003Qr0-96; Tue, 23 Nov 2021 20:23:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 5/9] sysctl: make ngroups_max const
Date:   Tue, 23 Nov 2021 12:23:43 -0800
Message-Id: <20211123202347.818157-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211123202347.818157-1-mcgrof@kernel.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stephen Kitt <steve@sk2.org>

ngroups_max is a read-only sysctl entry, reflecting NGROUPS_MAX. Make
it const, in the same way as cap_last_cap.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 kernel/sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8d5bcf1f08f3..b22149c46fa8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -124,7 +124,7 @@ static unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 static int maxolduid = 65535;
 static int minolduid;
 
-static int ngroups_max = NGROUPS_MAX;
+static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
 
@@ -2290,7 +2290,7 @@ static struct ctl_table kern_table[] = {
 #endif
 	{
 		.procname	= "ngroups_max",
-		.data		= &ngroups_max,
+		.data		= (void *)&ngroups_max,
 		.maxlen		= sizeof (int),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
-- 
2.33.0

