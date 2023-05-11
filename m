Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8CA6FF4F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbjEKOuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbjEKOtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 10:49:50 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1452110A08
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 07:48:52 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34BEmotw075176;
        Thu, 11 May 2023 23:48:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Thu, 11 May 2023 23:48:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34BEmo9g075172
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 May 2023 23:48:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a800496b-cae9-81bf-c79e-d8342418c5be@I-love.SAKURA.ne.jp>
Date:   Thu, 11 May 2023 23:48:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH] reiserfs: Initialize sec->length in reiserfs_security_init().
Content-Language: en-US
To:     syzbot <syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <000000000000d368dd05fb5dd7d3@google.com>
Cc:     reiserfs-devel@vger.kernel.org, glider@google.com,
        linux-fsdevel@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000d368dd05fb5dd7d3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting that sec->length is not initialized.

Since security_inode_init_security() returns 0 when initxattrs is provided
but call_int_hook(inode_init_security) returned -EOPNOTSUPP, control will
reach to "if (sec->length && ...) {" without initializing sec->length.

Reported-by: syzbot <syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=00a3779539a23cbee38c
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 52ca4b6435a4 ("reiserfs: Switch to security_inode_init_security()")
---
 fs/reiserfs/xattr_security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 6e0a099dd788..078dd8cc312f 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -67,6 +67,7 @@ int reiserfs_security_init(struct inode *dir, struct inode *inode,
 
 	sec->name = NULL;
 	sec->value = NULL;
+	sec->length = 0;
 
 	/* Don't add selinux attributes on xattrs - they'll never get used */
 	if (IS_PRIVATE(dir))
-- 
2.18.4

