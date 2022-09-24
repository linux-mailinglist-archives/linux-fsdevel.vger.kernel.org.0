Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898995E8D41
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiIXOVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 10:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIXOVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 10:21:05 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Sep 2022 07:21:04 PDT
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com [221.176.66.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ADFEDFCE
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 07:21:04 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3])
        by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9632f1193b52-e119a;
        Sat, 24 Sep 2022 22:17:57 +0800 (CST)
X-RM-TRANSID: 2ee9632f1193b52-e119a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.64.113.136])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2632f117a251-45be7;
        Sat, 24 Sep 2022 22:17:56 +0800 (CST)
X-RM-TRANSID: 2ee2632f117a251-45be7
From:   liujing <liujing@cmss.chinamobile.com>
To:     vgoyal@redhat.com
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] virtio_fs.c: add check kmalloc return
Date:   Sat, 24 Sep 2022 10:17:28 -0400
Message-Id: <20220924141728.3343-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 fs/fuse/virtio_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4d8d4f16c727..07334c9c2883 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -989,6 +989,10 @@ __releases(fiq->lock)
 
 	/* Allocate a buffer for the request */
 	forget = kmalloc(sizeof(*forget), GFP_NOFS | __GFP_NOFAIL);
+
+	if (forget == NULL)
+		return -ENOMEM;
+
 	req = &forget->req;
 
 	req->ih = (struct fuse_in_header){
-- 
2.18.2



