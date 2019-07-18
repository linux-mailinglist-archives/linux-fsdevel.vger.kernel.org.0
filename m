Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628E26CBCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfGRJWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 05:22:05 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2487 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfGRJWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:22:05 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 05:22:02 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15d3037fea81-9cdbf; Thu, 18 Jul 2019 17:12:30 +0800 (CST)
X-RM-TRANSID: 2ee15d3037fea81-9cdbf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55d3037fdf8b-f6500;
        Thu, 18 Jul 2019 17:12:30 +0800 (CST)
X-RM-TRANSID: 2ee55d3037fdf8b-f6500
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libfs: fix obsolete function
Date:   Thu, 18 Jul 2019 17:12:28 +0800
Message-Id: <1563441148-31741-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

simple_strtoll is obsolete, and use kstrtoll instead

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 fs/libfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 7e52e77..69cc01d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -883,7 +883,8 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 		goto out;
 
 	attr->set_buf[size] = '\0';
-	val = simple_strtoll(attr->set_buf, NULL, 0);
+	if (kstrtoll(attr->set_buf, 0, &val))
+		return -EINVAL;
 	ret = attr->set(attr->data, val);
 	if (ret == 0)
 		ret = len; /* on success, claim we got the whole input */
-- 
1.9.1



