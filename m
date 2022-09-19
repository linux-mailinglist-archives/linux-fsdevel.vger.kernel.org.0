Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41715BCA3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiISLGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 07:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiISLGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:06:05 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA0B84C;
        Mon, 19 Sep 2022 04:06:02 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28JB5EAU024945;
        Mon, 19 Sep 2022 20:05:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Mon, 19 Sep 2022 20:05:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28JB5ET3024941
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Sep 2022 20:05:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3411f396-a41e-76cb-7836-941fbade81dc@I-love.SAKURA.ne.jp>
Date:   Mon, 19 Sep 2022 20:05:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH (urgent)] vfs: fix uninitialized uid/gid in chown_common()
Content-Language: en-US
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <00000000000008058305e9033f85@google.com>
Cc:     linux-security-module@vger.kernel.org,
        syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000008058305e9033f85@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting uninit-value in tomoyo_path_chown() [1], for
chown_common() is by error passing uninitialized newattrs.ia_vfsuid to
security_path_chown() via from_vfsuid() when user == -1 is passed.
We must initialize newattrs.ia_vfs{u,g}id fields in order to make
from_vfs{u,g}id() work.

Link: https://syzkaller.appspot.com/bug?extid=541e21dcc32c4046cba9 [1]
Reported-by: syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/open.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 8a813fa5ca56..0550efb7b53a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -709,6 +709,8 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	kuid_t uid;
 	kgid_t gid;
 
+	newattrs.ia_vfsuid = VFSUIDT_INIT(KUIDT_INIT(-1));
+	newattrs.ia_vfsgid = VFSGIDT_INIT(KGIDT_INIT(-1));
 	uid = make_kuid(current_user_ns(), user);
 	gid = make_kgid(current_user_ns(), group);
 
-- 
2.34.1

