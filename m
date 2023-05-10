Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE26FD3DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 04:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjEJCe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 22:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEJCe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 22:34:56 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 19:34:55 PDT
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 190D8273C
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 19:34:54 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.64.19])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 86CE2B0017A40;
        Wed, 10 May 2023 10:25:18 +0800 (CST)
Received: from localhost (10.79.71.101) by ZJY01-ACTMBX-06.didichuxing.com
 (10.79.64.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 10 May
 2023 10:25:18 +0800
X-MD-Sfrom: houweitao@didiglobal.com
X-MD-SrcIP: 10.79.64.19
From:   houweitao <houweitao@didiglobal.com>
To:     <akpm@linux-foudation.org>, <houweitao@didiglobal.com>,
        <xupengfei@nfschina.com>, <brauner@kernel.org>,
        <dchinner@redhat.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <royliyueyi@didiglobal.com>
Subject: [PATCH] fs: hfsplus: fix uninit-value bug in hfsplus_listxattr
Date:   Wed, 10 May 2023 10:25:15 +0800
Message-ID: <20230510022515.9368-1-houweitao@didiglobal.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.79.71.101]
X-ClientProxiedBy: ZJY03-PUBMBX-01.didichuxing.com (10.79.71.12) To
 ZJY01-ACTMBX-06.didichuxing.com (10.79.64.19)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BUG: KMSAN: uninit-value in strncmp+0x11e/0x180 lib/string.c:307
 strncmp+0x11e/0x180 lib/string.c:307
 is_known_namespace fs/hfsplus/xattr.c:45 [inline]
 name_len fs/hfsplus/xattr.c:397 [inline]
 hfsplus_listxattr+0xe61/0x1aa0 fs/hfsplus/xattr.c:746
 vfs_listxattr fs/xattr.c:473 [inline]
 listxattr+0x700/0x780 fs/xattr.c:820
 path_listxattr fs/xattr.c:844 [inline]
 __do_sys_llistxattr fs/xattr.c:862 [inline]
 __se_sys_llistxattr fs/xattr.c:859 [inline]
 __ia32_sys_llistxattr+0x171/0x300 fs/xattr.c:859
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Reported-by: syzbot <syzbot+92ef9ee419803871020e@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=92ef9ee419803871020e
Signed-off-by: houweitao <houweitao@didiglobal.com>
---
 fs/hfsplus/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 58021e73c00b..f7f9d0889df3 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -698,7 +698,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return err;
 	}
 
-	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
+	strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
 			XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
 	if (!strbuf) {
 		res = -ENOMEM;
-- 
2.17.1

