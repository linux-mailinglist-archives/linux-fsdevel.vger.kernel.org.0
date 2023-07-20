Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6E75A6CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 08:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGTGpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 02:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGTGpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:45:16 -0400
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861326B1;
        Wed, 19 Jul 2023 23:45:08 -0700 (PDT)
X-QQ-mid: bizesmtp68t1689834875t8uqaw1v
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 20 Jul 2023 14:34:34 +0800 (CST)
X-QQ-SSF: 01400000000000F0H000000A0000000
X-QQ-FEAT: KTe/kbfylhYNEbP0cLXnuujVkVcG0fg7qq1gpxJ4cgX7rL0CEUgofhqLNhHfg
        JY8BbIc6FphT+tFsl5D3j/Nj9cPSBAP3eY8/S9LHyygL6bgC4DJe3VjqY610Co59xIc70jS
        REnua6FCRSzC1iUlE64Z3A6zbUG2aR3anS6H9Ys59E68N468w/FZeGQU152C7PiEm10UXAC
        h/xsbRO/NcJuSgZACdTr9aTQJSAXZjRSIFSleS/mlNxQW0hLzGVE4fMELaOzr+Aju7+6Tuf
        Emx0oJDbe+VP+FsaGmfAFFq4uS83jjvsym6yN5WHvHYmz+0TYlG2dHcejwi5Eo/Fa38vsq2
        9J0Dh9bRnPPJFKHI5Z5VrDDQtfZdLSZDUhP69fUJhw90KemQvpeUSmcFQv+LXJbN8WZ2VD6
        im0In4Yh7y+2qr1bkF0zow==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11999717834230943705
From:   Winston Wen <wentao@uniontech.com>
To:     Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Winston Wen <wentao@uniontech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] fs/nls: make load_nls() take a const parameter
Date:   Thu, 20 Jul 2023 14:34:14 +0800
Message-Id: <20230720063414.2546451-1-wentao@uniontech.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

load_nls() take a char * parameter, use it to find nls module in list or
construct the module name to load it.

This change make load_nls() take a const parameter, so we don't need do
some cast like this:

        ses->local_nls = load_nls((char *)ctx->local_nls->charset);

Also remove the cast in cifs code.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 fs/nls/nls_base.c       | 4 ++--
 fs/smb/client/connect.c | 2 +-
 include/linux/nls.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 52ccd34b1e79..a026dbd3593f 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -272,7 +272,7 @@ int unregister_nls(struct nls_table * nls)
 	return -EINVAL;
 }
 
-static struct nls_table *find_nls(char *charset)
+static struct nls_table *find_nls(const char *charset)
 {
 	struct nls_table *nls;
 	spin_lock(&nls_lock);
@@ -288,7 +288,7 @@ static struct nls_table *find_nls(char *charset)
 	return nls;
 }
 
-struct nls_table *load_nls(char *charset)
+struct nls_table *load_nls(const char *charset)
 {
 	return try_then_request_module(find_nls(charset), "nls_%s", charset);
 }
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 8ad10c96e8ce..238538dde4e3 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2290,7 +2290,7 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 
 	ses->sectype = ctx->sectype;
 	ses->sign = ctx->sign;
-	ses->local_nls = load_nls((char *)ctx->local_nls->charset);
+	ses->local_nls = load_nls(ctx->local_nls->charset);
 
 	/* add server as first channel */
 	spin_lock(&ses->chan_lock);
diff --git a/include/linux/nls.h b/include/linux/nls.h
index 499e486b3722..e0bf8367b274 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -47,7 +47,7 @@ enum utf16_endian {
 /* nls_base.c */
 extern int __register_nls(struct nls_table *, struct module *);
 extern int unregister_nls(struct nls_table *);
-extern struct nls_table *load_nls(char *);
+extern struct nls_table *load_nls(const char *charset);
 extern void unload_nls(struct nls_table *);
 extern struct nls_table *load_nls_default(void);
 #define register_nls(nls) __register_nls((nls), THIS_MODULE)
-- 
2.40.1

