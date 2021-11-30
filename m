Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6351A463C27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 17:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244296AbhK3QtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 11:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbhK3QtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:49:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9941DC061574;
        Tue, 30 Nov 2021 08:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=N+ZxBEWMH5fccd3w/J0gUfy7tclVtZexQtqR5EBwu2I=; b=r4rdsP/D5PB7eTDfZ3xa640H7F
        60NVhcXotmxxxQR2N5Lpnfk6aayoZoCscCJiQzAw9Ecmp9V+w08h8XF9DnfmEot+kjkwqbFJhGUAV
        pvpyvpY7DRzGjzN/fZ7FI/62TQFqrnf/YC62AZEbqKjbW4vxqqsXYzwLLIB5jwqlY1usTaOxJDFKQ
        YUzrIIEjVxVAbACvSU54XuUjzCxsnUdLcNFbubv6fcf+fnHvO7iPanJH7a0YJP98oUUg9ogf+Gmi/
        lSsYvynKi96wSu9S8P5wJauJQ7TxdmUyYdLVKHr9xAVNzxrQ1Xw1Ugx4t3CZgLGwLnD/ZhtNE4GJm
        dVlCuHdg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms6G1-006CWP-OD; Tue, 30 Nov 2021 16:45:29 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] firmware_loader: export sysctl registration
Date:   Tue, 30 Nov 2021 08:45:25 -0800
Message-Id: <20211130164525.1478009-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The firmware loader fallback sysctl table is always built-in,
but when FW_LOADER=m the build will fail. We need to export
the sysctl registration and de-registration. Use the private
symbol namespace so that only the firmware loader uses these
calls.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: firmware_loader: move firmware sysctl to its own files
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback_table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 51751c46cdcf..255823887c70 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -56,10 +56,12 @@ int register_firmware_config_sysctl(void)
 		return -ENOMEM;
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(register_firmware_config_sysctl, FIRMWARE_LOADER_PRIVATE);
 
 void unregister_firmware_config_sysctl(void)
 {
 	unregister_sysctl_table(firmware_config_sysct_table_header);
 	firmware_config_sysct_table_header = NULL;
 }
+EXPORT_SYMBOL_NS_GPL(unregister_firmware_config_sysctl, FIRMWARE_LOADER_PRIVATE);
 #endif /* CONFIG_SYSCTL */
-- 
2.33.0

