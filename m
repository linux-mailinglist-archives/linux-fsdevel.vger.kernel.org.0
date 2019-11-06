Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A890F159C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 13:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfKFMAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 07:00:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728610AbfKFMAw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:00:52 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 373DB18A898A0E92176B;
        Wed,  6 Nov 2019 20:00:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 6 Nov 2019 20:00:40 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: Fix error return code in vboxsf_fill_super()
Date:   Wed, 6 Nov 2019 11:59:54 +0000
Message-ID: <20191106115954.114678-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: df4028658f9d ("staging: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/staging/vboxsf/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vboxsf/super.c b/drivers/staging/vboxsf/super.c
index 3913ffafa83b..0bf4d724aefd 100644
--- a/drivers/staging/vboxsf/super.c
+++ b/drivers/staging/vboxsf/super.c
@@ -176,8 +176,10 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* Turn source into a shfl_string and map the folder */
 	size = strlen(fc->source) + 1;
 	folder_name = kmalloc(SHFLSTRING_HEADER_SIZE + size, GFP_KERNEL);
-	if (!folder_name)
+	if (!folder_name) {
+		err = -ENOMEM;
 		goto fail_free;
+	}
 	folder_name->size = size;
 	folder_name->length = size - 1;
 	strlcpy(folder_name->string.utf8, fc->source, size);



