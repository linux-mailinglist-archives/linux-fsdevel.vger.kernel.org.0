Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7BD27AD26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgI1LrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 07:47:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgI1LrD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:47:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 982E99327A6E6E9AE8F7;
        Mon, 28 Sep 2020 19:47:01 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 28 Sep 2020
 19:46:52 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH -next] fs_parse: mark fs_param_bad_value() as static
Date:   Mon, 28 Sep 2020 19:44:23 +0800
Message-ID: <1601293463-25763-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We found the following warning when build kernel with W=1:

fs/fs_parser.c:192:5: warning: no previous prototype for ‘fs_param_bad_value’ [-Wmissing-prototypes]
int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
     ^
CC      drivers/usb/gadget/udc/snps_udc_core.o

And no header file define a prototype for this function, so we should mark
it as static.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 fs/fs_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index ab53e42..68b0148 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -189,7 +189,7 @@ int fs_lookup_param(struct fs_context *fc,
 }
 EXPORT_SYMBOL(fs_lookup_param);
 
-int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
+static int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
 {
 	return inval_plog(log, "Bad value for '%s'", param->key);
 }
-- 
2.7.4

