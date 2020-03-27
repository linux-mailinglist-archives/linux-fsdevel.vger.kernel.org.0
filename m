Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC70F194E32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 01:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgC0Avs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 20:51:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50525 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgC0Avr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 20:51:47 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02R0pcVr011087;
        Fri, 27 Mar 2020 09:51:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Fri, 27 Mar 2020 09:51:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02R0panf011076
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 27 Mar 2020 09:51:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH (repost)] umh: fix refcount underflow in fork_usermode_blob().
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp>
 <20200312143801.GJ23230@ZenIV.linux.org.uk>
 <a802dfd6-aeda-c454-6dd3-68e32a4cf914@i-love.sakura.ne.jp>
 <85163bf6-ae4a-edbb-6919-424b92eb72b2@i-love.sakura.ne.jp>
Message-ID: <9b846b1f-a231-4f09-8c37-6bfb0d1e7b05@i-love.sakura.ne.jp>
Date:   Fri, 27 Mar 2020 09:51:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <85163bf6-ae4a-edbb-6919-424b92eb72b2@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since free_bprm(bprm) always calls allow_write_access(bprm->file) and
fput(bprm->file) if bprm->file is set to non-NULL, __do_execve_file()
must call deny_write_access(file) and get_file(file) if called from
do_execve_file() path. Otherwise, use-after-free access can happen at
fput(file) in fork_usermode_blob().

  general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] SMP DEBUG_PAGEALLOC
  CPU: 3 PID: 4131 Comm: insmod Tainted: G           O      5.6.0-rc5+ #978
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
  RIP: 0010:fork_usermode_blob+0xaa/0x190

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 449325b52b7a6208 ("umh: introduce fork_usermode_blob() helper")
Cc: <stable@vger.kernel.org> [4.18+]
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/exec.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index db17be51b112..ded3fa368dc7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1761,11 +1761,17 @@ static int __do_execve_file(int fd, struct filename *filename,
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
-	if (!file)
+	if (!file) {
 		file = do_open_execat(fd, filename, flags);
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		goto out_unmark;
+		retval = PTR_ERR(file);
+		if (IS_ERR(file))
+			goto out_unmark;
+	} else {
+		retval = deny_write_access(file);
+		if (retval)
+			goto out_unmark;
+		get_file(file);
+	}
 
 	sched_exec();
 
-- 
2.18.2

