Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45CB20C1E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgF0N6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 09:58:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56481 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgF0N6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:58:11 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05RDvCLq005289;
        Sat, 27 Jun 2020 22:57:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Sat, 27 Jun 2020 22:57:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05RDvBus005282
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 27 Jun 2020 22:57:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
 <87366g8y1e.fsf@x220.int.ebiederm.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <aa737d87-cf38-55d6-32f1-2d989a5412ea@i-love.sakura.ne.jp>
Date:   Sat, 27 Jun 2020 22:57:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87366g8y1e.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/27 21:59, Eric W. Biederman wrote:
> Can you try replacing the __fput_sync with:
> 	fput(file);
>         flush_delayed_fput();
>         task_work_run();

With below change, TOMOYO can obtain pathname like "tmpfs:/my\040test\040driver".

Please avoid WARN_ON() if printk() is sufficient (for friendliness to panic_on_warn=1 environments).
For argv[], I guess that fork_usermode_driver() should receive argv[] as argument rather than
trying to split info->driver_name, for somebody might want to pass meaningful argv[] (and
TOMOYO wants to use meaningful argv[] as a hint for identifying the intent).

diff --git a/kernel/umd.c b/kernel/umd.c
index de2f542191e5..ae6e85283f13 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -7,6 +7,7 @@
 #include <linux/mount.h>
 #include <linux/fs_struct.h>
 #include <linux/umd.h>
+#include <linux/task_work.h>
 
 static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *name)
 {
@@ -25,7 +26,7 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 	if (IS_ERR(mnt))
 		return mnt;
 
-	file = file_open_root(mnt->mnt_root, mnt, name, O_CREAT | O_WRONLY, 0700);
+	file = file_open_root(mnt->mnt_root, mnt, name, O_CREAT | O_WRONLY | O_EXCL, 0700);
 	if (IS_ERR(file)) {
 		mntput(mnt);
 		return ERR_CAST(file);
@@ -41,23 +42,33 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 		return ERR_PTR(err);
 	}
 
-	__fput_sync(file);
+	if (current->flags & PF_KTHREAD) {
+		__fput_sync(file);
+	} else {
+		fput(file);
+		flush_delayed_fput();
+		task_work_run();
+	}
 	return mnt;
 }
 
 /**
  * umd_load_blob - Remember a blob of bytes for fork_usermode_driver
- * @info: information about usermode driver
- * @data: a blob of bytes that can be executed as a file
- * @len:  The lentgh of the blob
+ * @info: information about usermode driver (shouldn't be NULL)
+ * @data: a blob of bytes that can be executed as a file (shouldn't be NULL)
+ * @len:  The lentgh of the blob (shouldn't be 0)
  *
  */
 int umd_load_blob(struct umd_info *info, const void *data, size_t len)
 {
 	struct vfsmount *mnt;
 
-	if (WARN_ON_ONCE(info->wd.dentry || info->wd.mnt))
+	if (!info || !info->driver_name || !data || !len)
+		return -EINVAL;
+	if (info->wd.dentry || info->wd.mnt) {
+		pr_info("%s already loaded.\n", info->driver_name);
 		return -EBUSY;
+	}
 
 	mnt = blob_to_mnt(data, len, info->driver_name);
 	if (IS_ERR(mnt))
@@ -71,14 +82,14 @@ EXPORT_SYMBOL_GPL(umd_load_blob);
 
 /**
  * umd_unload_blob - Disassociate @info from a previously loaded blob
- * @info: information about usermode driver
+ * @info: information about usermode driver (shouldn't be NULL)
  *
  */
 int umd_unload_blob(struct umd_info *info)
 {
-	if (WARN_ON_ONCE(!info->wd.mnt ||
-			 !info->wd.dentry ||
-			 info->wd.mnt->mnt_root != info->wd.dentry))
+	if (!info || !info->driver_name || !info->wd.dentry || !info->wd.mnt)
+		return -EINVAL;
+	if (WARN_ON_ONCE(info->wd.mnt->mnt_root != info->wd.dentry))
 		return -EINVAL;
 
 	kern_unmount(info->wd.mnt);
@@ -158,8 +169,14 @@ int fork_usermode_driver(struct umd_info *info)
 	char **argv = NULL;
 	int err;
 
-	if (WARN_ON_ONCE(info->tgid))
+	if (!info || !info->driver_name || !info->wd.dentry || !info->wd.mnt)
+		return -EINVAL;
+	if (WARN_ON_ONCE(info->wd.mnt->mnt_root != info->wd.dentry))
+		return -EINVAL;
+	if (info->tgid) {
+		pr_info("%s already running.\n", info->driver_name);
 		return -EBUSY;
+	}
 
 	err = -ENOMEM;
 	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);



