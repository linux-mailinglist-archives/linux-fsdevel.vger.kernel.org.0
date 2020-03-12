Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 116441831D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCLNn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 09:43:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62672 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgCLNn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:43:26 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02CDhGNl010832;
        Thu, 12 Mar 2020 22:43:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Thu, 12 Mar 2020 22:43:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02CDh364010609
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 12 Mar 2020 22:43:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] umh: fix refcount underflow in fork_usermode_blob().
Message-ID: <2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp>
Date:   Thu, 12 Mar 2020 22:43:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before thinking how to fix a bug that tomoyo_realpath_nofollow() from
tomoyo_find_next_domain() likely fails with -ENOENT whenever
fork_usermode_blob() is used because 449325b52b7a6208 did not take into
account that TOMOYO security module needs to calculate symlink's pathname,
is this a correct fix for a bug that file_inode(file)->i_writecount != 0
and file->f_count < 0 ?



From 8a9891af757a89b2a52addbc88a9911c17f6a2a9 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 12 Mar 2020 22:39:26 +0900
Subject: [PATCH] umh: fix refcount underflow in fork_usermode_blob().

Since free_bprm(bprm) always calls allow_write_access(bprm->file) and
fput(bprm->file) if bprm->file is set to non-NULL, __do_execve_file()
must call deny_write_access(file) and get_file(file) if called from
do_execve_file() path.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 449325b52b7a6208 ("umh: introduce fork_usermode_blob() helper")
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

