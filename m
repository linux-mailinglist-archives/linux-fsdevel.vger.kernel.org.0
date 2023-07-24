Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE075E994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 04:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGXCP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jul 2023 22:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjGXCPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:15:42 -0400
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C517B2111;
        Sun, 23 Jul 2023 19:14:05 -0700 (PDT)
X-QQ-mid: bizesmtp78t1690164740tg9ld4pi
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 24 Jul 2023 10:11:58 +0800 (CST)
X-QQ-SSF: 01400000000000F0I000000A0000000
X-QQ-FEAT: RumxddD8MdA+0nVTY5mTz+KglAS8oWEoRwf/bUWEYT3aQ269LJW73I/Uu+q2v
        FkUX5/tO3YkHDQS0XJZmnh2Jxb+IVtCA0PYpS2Uu7u2l2OS3uOrVuS4rqcFaxgyLX2hnJNw
        JbHg70O3xkWPWaPi665gZkFuuwOW4M8ZzHBZ8CMgrsin//3F98LHgvqaZlXK3All5ePWIMS
        uSdAyLMLBiK4ec5GrhTuVZKNvNkPHx0Nc5Fdu5DI5sLIPtVKXPimpOXmdDQg14vtjpXgqta
        rfca7ZGT6cS2ei/naFX4SXWbyP9jn8AQwKhxHzJxApdBWbrRvbC7n/RzLwdK1jLwzhmeMGm
        GyN4CzKspLHj1ZVzfCG5o2upMkgmXyicU/+YmoVqXxvdJf+M0N2yFXEgpcpRr+SLZTsig5J
        FOZF1Z9JAn4=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18095699350768677073
From:   Winston Wen <wentao@uniontech.com>
To:     Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Winston Wen <wentao@uniontech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 1/2] fs/nls: make load_nls() take a const parameter
Date:   Mon, 24 Jul 2023 10:10:56 +0800
Message-Id: <20230724021057.2958991-2-wentao@uniontech.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230724021057.2958991-1-wentao@uniontech.com>
References: <20230724021057.2958991-1-wentao@uniontech.com>
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

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Winston Wen <wentao@uniontech.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.com>
---
 fs/nls/nls_base.c   | 4 ++--
 include/linux/nls.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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

