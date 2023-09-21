Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB77A9B47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjIUS5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjIUS46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:56:58 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 11:51:05 PDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006E8D9FB;
        Thu, 21 Sep 2023 11:51:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 1D1AF100572;
        Thu, 21 Sep 2023 17:03:35 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rnrQDSauchoq; Thu, 21 Sep 2023 17:03:35 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 133D5100544; Thu, 21 Sep 2023 17:03:35 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 7F4CA100223;
        Thu, 21 Sep 2023 17:03:33 +1000 (AEST)
Subject: [PATCH 1/8] autofs: refactor autofs_prepare_pipe()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Date:   Thu, 21 Sep 2023 15:03:33 +0800
Message-ID: <169527981274.27328.17552761781465494402.stgit@donald.themaw.net>
In-Reply-To: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor autofs_prepare_pipe() by seperating out a check function
to be used later.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index d5a44fa88acf..c24d32be7937 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -209,12 +209,20 @@ int autofs_fill_super(struct super_block *, void *, int);
 struct autofs_info *autofs_new_ino(struct autofs_sb_info *);
 void autofs_clean_ino(struct autofs_info *);
 
-static inline int autofs_prepare_pipe(struct file *pipe)
+static inline int autofs_check_pipe(struct file *pipe)
 {
 	if (!(pipe->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 	if (!S_ISFIFO(file_inode(pipe)->i_mode))
 		return -EINVAL;
+	return 0;
+}
+
+static inline int autofs_prepare_pipe(struct file *pipe)
+{
+	int ret = autofs_check_pipe(pipe);
+	if (ret < 0)
+		return ret;
 	/* We want a packet pipe */
 	pipe->f_flags |= O_DIRECT;
 	/* We don't expect -EAGAIN */


