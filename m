Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD3363489
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfGIKwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 06:52:03 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54402 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfGIKwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:52:03 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x69ApIp7022725;
        Tue, 9 Jul 2019 19:51:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Tue, 09 Jul 2019 19:51:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x69ApDuL022606
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 9 Jul 2019 19:51:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
 <20190708131831.GT17978@ZenIV.linux.org.uk> <874l3wo3gq.fsf@xmission.com>
 <20190708180132.GU17978@ZenIV.linux.org.uk>
 <20190708202124.GX17978@ZenIV.linux.org.uk> <87pnmkhxoy.fsf@xmission.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5802b8b1-f734-1670-f83b-465eda133936@i-love.sakura.ne.jp>
Date:   Tue, 9 Jul 2019 19:51:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87pnmkhxoy.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/09 9:13, Eric W. Biederman wrote:
> Tetsuo, do you think you can implement the checks you need for Tomoyo
> for mount_move on top of the new security_mount_move?

I hope "Yes", for I'm not aware what will become possible with the new mount
syscalls. For example, if it becomes possible to use multiple source device
files or directories, TOMOYO is not ready to check multiple source device
files or directories, for currently TOMOYO uses

  file mount $DEVICE $MOUNTPOINT $FILESYSTEM $OPTIONS

( https://tomoyo.osdn.jp/2.6/policy-specification/domain-policy-syntax.html#file_mount )
syntax. If only optional part (any arguments which were previously passed via
"const void *data" of mount() syscall) differs, current syntax can be reused.

> 
> Al is proposing that similar hooks be added for the other subcases of
> mount so that less racy hooks can be implemented.  Tetsuo do you have
> any problem with that?

I welcome improvements that get rid of calling kern_path() from LSM hooks.

In the past, I incorrectly implemented which MS_* flag should be checked
(commit df91e49477a9be15 ("TOMOYO: Fix mount flags checking order.")).
If LSM hooks for mount manipulation are divided into multiple LSM hooks
(along with changing the argument from "const char *" to "const struct path *"),
such mistakes can be avoided.

> Tetsuo whatever the virtues of this patchset getting merged into Linus's
> tree it is merged now, so the only thing we can do now is roll up our
> sleeves go through everything and fix the regressions/bugs/issues that
> have emerged with the new mount api.

For now, can we apply this patch for 5.2-stable ?


From dd62fab0592e02580fd5a34222a2d11bfc179f61 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 9 Jul 2019 19:05:49 +0900
Subject: [PATCH] LSM: Disable move_mount() syscall when TOMOYO or AppArmor is enabled.

Commit 2db154b3ea8e14b0 ("vfs: syscall: Add move_mount(2) to move mounts
around") introduced security_move_mount() LSM hook, but we missed that
TOMOYO and AppArmor did not implement hooks for checking move_mount(2).
For pathname based access controls like TOMOYO and AppArmor, unchecked
mount manipulation is not acceptable. Therefore, until TOMOYO and AppArmor
implement hooks, in order to avoid unchecked mount manipulation, pretend
as if move_mount(2) is unavailable when either TOMOYO or AppArmor is
enabled.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 2db154b3ea8e14b0 ("vfs: syscall: Add move_mount(2) to move mounts around")
Cc: stable@vger.kernel.org # 5.2
---
 include/linux/lsm_hooks.h | 6 ++++++
 security/apparmor/lsm.c   | 1 +
 security/tomoyo/tomoyo.c  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 47f58cf..cd411b7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2142,4 +2142,10 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+static inline int no_move_mount(const struct path *from_path,
+				const struct path *to_path)
+{
+	return -ENOSYS;
+}
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ec3a928..5cdf63b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1158,6 +1158,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, apparmor_capable),
 
 	LSM_HOOK_INIT(sb_mount, apparmor_sb_mount),
+	LSM_HOOK_INIT(move_mount, no_move_mount),
 	LSM_HOOK_INIT(sb_umount, apparmor_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, apparmor_sb_pivotroot),
 
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92e..be1b1a1 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -558,6 +558,7 @@ static void tomoyo_task_free(struct task_struct *task)
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
 	LSM_HOOK_INIT(sb_mount, tomoyo_sb_mount),
+	LSM_HOOK_INIT(move_mount, no_move_mount),
 	LSM_HOOK_INIT(sb_umount, tomoyo_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, tomoyo_sb_pivotroot),
 	LSM_HOOK_INIT(socket_bind, tomoyo_socket_bind),
-- 
1.8.3.1



