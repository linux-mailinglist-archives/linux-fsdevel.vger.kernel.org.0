Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48F820DB94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbgF2UHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:07:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39578 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbgF2UHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:07:45 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq047-0006AH-D6; Mon, 29 Jun 2020 14:07:43 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq045-0004Ar-Uk; Mon, 29 Jun 2020 14:07:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 29 Jun 2020 15:03:10 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <87wo3p4p35.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq045-0004Ar-Uk;;;mid=<87wo3p4p35.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX181qpo/p82KflUzkNI/ibXfHEB+3fTggUA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 916 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.2%), b_tie_ro: 9 (1.0%), parse: 1.35 (0.1%),
         extract_message_metadata: 18 (2.0%), get_uri_detail_list: 4.9 (0.5%),
        tests_pri_-1000: 25 (2.7%), tests_pri_-950: 1.31 (0.1%),
        tests_pri_-900: 1.12 (0.1%), tests_pri_-90: 273 (29.8%), check_bayes:
        271 (29.6%), b_tokenize: 20 (2.2%), b_tok_get_all: 11 (1.2%),
        b_comp_prob: 3.7 (0.4%), b_tok_touch_all: 232 (25.3%), b_finish: 1.00
        (0.1%), tests_pri_0: 571 (62.3%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 2.2 (0.2%), poll_dns_idle: 0.52 (0.1%), tests_pri_10:
        2.7 (0.3%), tests_pri_500: 9 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 08/15] umd: Transform fork_usermode_blob into fork_usermode_driver
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Instead of loading a binary blob into a temporary file with
shmem_kernel_file_setup load a binary blob into a temporary tmpfs
filesystem.  This means that the blob can be stored in an init section
and discared, and it means the binary blob will have a filename so can
be executed normally.

The only tricky thing about this code is that in the helper function
blob_to_mnt __fput_sync is used.  That is because a file can not be
executed if it is still open for write, and the ordinary delayed close
for kernel threads does not happen soon enough, which causes the
following exec to fail.  The function umd_load_blob is not called with
any locks so this should be safe.

Executing the blob normally winds up correcting several problems with
the user mode driver code discovered by Tetsuo Handa[1].  By passing
an ordinary filename into the exec, it is no longer necessary to
figure out how to turn a O_RDWR file descriptor into a properly
referende counted O_EXEC file descriptor that forbids all writes.  For
path based LSMs there are no new special cases.

[1] https://lore.kernel.org/linux-fsdevel/2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp/
Link: https://lkml.kernel.org/r/87d05mf0j9.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umd.h          |   6 +-
 kernel/umd.c                 | 126 +++++++++++++++++++++++++++--------
 net/bpfilter/bpfilter_kern.c |  14 +++-
 3 files changed, 113 insertions(+), 33 deletions(-)

diff --git a/include/linux/umd.h b/include/linux/umd.h
index d827fb038d00..12ff8f753ea7 100644
--- a/include/linux/umd.h
+++ b/include/linux/umd.h
@@ -2,6 +2,7 @@
 #define __LINUX_UMD_H__
 
 #include <linux/umh.h>
+#include <linux/path.h>
 
 #ifdef CONFIG_BPFILTER
 void __exit_umh(struct task_struct *tsk);
@@ -23,8 +24,11 @@ struct umd_info {
 	struct file *pipe_from_umh;
 	struct list_head list;
 	void (*cleanup)(struct umd_info *info);
+	struct path wd;
 	pid_t pid;
 };
-int fork_usermode_blob(void *data, size_t len, struct umd_info *info);
+int umd_load_blob(struct umd_info *info, const void *data, size_t len);
+int umd_unload_blob(struct umd_info *info);
+int fork_usermode_driver(struct umd_info *info);
 
 #endif /* __LINUX_UMD_H__ */
diff --git a/kernel/umd.c b/kernel/umd.c
index 7fe08a8eb231..aaa6f3142e52 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -4,11 +4,98 @@
  */
 #include <linux/shmem_fs.h>
 #include <linux/pipe_fs_i.h>
+#include <linux/mount.h>
+#include <linux/fs_struct.h>
+#include <linux/task_work.h>
 #include <linux/umd.h>
 
 static LIST_HEAD(umh_list);
 static DEFINE_MUTEX(umh_list_lock);
 
+static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *name)
+{
+	struct file_system_type *type;
+	struct vfsmount *mnt;
+	struct file *file;
+	ssize_t written;
+	loff_t pos = 0;
+
+	type = get_fs_type("tmpfs");
+	if (!type)
+		return ERR_PTR(-ENODEV);
+
+	mnt = kern_mount(type);
+	put_filesystem(type);
+	if (IS_ERR(mnt))
+		return mnt;
+
+	file = file_open_root(mnt->mnt_root, mnt, name, O_CREAT | O_WRONLY, 0700);
+	if (IS_ERR(file)) {
+		mntput(mnt);
+		return ERR_CAST(file);
+	}
+
+	written = kernel_write(file, data, len, &pos);
+	if (written != len) {
+		int err = written;
+		if (err >= 0)
+			err = -ENOMEM;
+		filp_close(file, NULL);
+		mntput(mnt);
+		return ERR_PTR(err);
+	}
+
+	fput(file);
+
+	/* Flush delayed fput so exec can open the file read-only */
+	flush_delayed_fput();
+	task_work_run();
+	return mnt;
+}
+
+/**
+ * umd_load_blob - Remember a blob of bytes for fork_usermode_driver
+ * @info: information about usermode driver
+ * @data: a blob of bytes that can be executed as a file
+ * @len:  The lentgh of the blob
+ *
+ */
+int umd_load_blob(struct umd_info *info, const void *data, size_t len)
+{
+	struct vfsmount *mnt;
+
+	if (WARN_ON_ONCE(info->wd.dentry || info->wd.mnt))
+		return -EBUSY;
+
+	mnt = blob_to_mnt(data, len, info->driver_name);
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	info->wd.mnt = mnt;
+	info->wd.dentry = mnt->mnt_root;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(umd_load_blob);
+
+/**
+ * umd_unload_blob - Disassociate @info from a previously loaded blob
+ * @info: information about usermode driver
+ *
+ */
+int umd_unload_blob(struct umd_info *info)
+{
+	if (WARN_ON_ONCE(!info->wd.mnt ||
+			 !info->wd.dentry ||
+			 info->wd.mnt->mnt_root != info->wd.dentry))
+		return -EINVAL;
+
+	kern_unmount(info->wd.mnt);
+	info->wd.mnt = NULL;
+	info->wd.dentry = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(umd_unload_blob);
+
 static int umd_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct umd_info *umd_info = info->data;
@@ -43,6 +130,7 @@ static int umd_setup(struct subprocess_info *info, struct cred *new)
 		return err;
 	}
 
+	set_fs_pwd(current->fs, &umd_info->wd);
 	umd_info->pipe_to_umh = to_umh[1];
 	umd_info->pipe_from_umh = from_umh[0];
 	umd_info->pid = task_pid_nr(current);
@@ -62,39 +150,21 @@ static void umd_cleanup(struct subprocess_info *info)
 }
 
 /**
- * fork_usermode_blob - fork a blob of bytes as a usermode process
- * @data: a blob of bytes that can be do_execv-ed as a file
- * @len: length of the blob
- * @info: information about usermode process (shouldn't be NULL)
+ * fork_usermode_driver - fork a usermode driver
+ * @info: information about usermode driver (shouldn't be NULL)
  *
- * Returns either negative error or zero which indicates success
- * in executing a blob of bytes as a usermode process. In such
- * case 'struct umd_info *info' is populated with two pipes
- * and a pid of the process. The caller is responsible for health
- * check of the user process, killing it via pid, and closing the
- * pipes when user process is no longer needed.
+ * Returns either negative error or zero which indicates success in
+ * executing a usermode driver. In such case 'struct umd_info *info'
+ * is populated with two pipes and a pid of the process. The caller is
+ * responsible for health check of the user process, killing it via
+ * pid, and closing the pipes when user process is no longer needed.
  */
-int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
+int fork_usermode_driver(struct umd_info *info)
 {
 	struct subprocess_info *sub_info;
 	char **argv = NULL;
-	struct file *file;
-	ssize_t written;
-	loff_t pos = 0;
 	int err;
 
-	file = shmem_kernel_file_setup(info->driver_name, len, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	written = kernel_write(file, data, len, &pos);
-	if (written != len) {
-		err = written;
-		if (err >= 0)
-			err = -ENOMEM;
-		goto out;
-	}
-
 	err = -ENOMEM;
 	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);
 	if (!argv)
@@ -106,7 +176,6 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	if (!sub_info)
 		goto out;
 
-	sub_info->file = file;
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
 	if (!err) {
 		mutex_lock(&umh_list_lock);
@@ -116,10 +185,9 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 out:
 	if (argv)
 		argv_free(argv);
-	fput(file);
 	return err;
 }
-EXPORT_SYMBOL_GPL(fork_usermode_blob);
+EXPORT_SYMBOL_GPL(fork_usermode_driver);
 
 void __exit_umh(struct task_struct *tsk)
 {
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index c0f0990f30b6..28883b00609d 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -77,9 +77,7 @@ static int start_umh(void)
 	int err;
 
 	/* fork usermode process */
-	err = fork_usermode_blob(&bpfilter_umh_start,
-				 &bpfilter_umh_end - &bpfilter_umh_start,
-				 &bpfilter_ops.info);
+	err = fork_usermode_driver(&bpfilter_ops.info);
 	if (err)
 		return err;
 	bpfilter_ops.stop = false;
@@ -98,6 +96,12 @@ static int __init load_umh(void)
 {
 	int err;
 
+	err = umd_load_blob(&bpfilter_ops.info,
+			    &bpfilter_umh_start,
+			    &bpfilter_umh_end - &bpfilter_umh_start);
+	if (err)
+		return err;
+
 	mutex_lock(&bpfilter_ops.lock);
 	if (!bpfilter_ops.stop) {
 		err = -EFAULT;
@@ -110,6 +114,8 @@ static int __init load_umh(void)
 	}
 out:
 	mutex_unlock(&bpfilter_ops.lock);
+	if (err)
+		umd_unload_blob(&bpfilter_ops.info);
 	return err;
 }
 
@@ -122,6 +128,8 @@ static void __exit fini_umh(void)
 		bpfilter_ops.sockopt = NULL;
 	}
 	mutex_unlock(&bpfilter_ops.lock);
+
+	umd_unload_blob(&bpfilter_ops.info);
 }
 module_init(load_umh);
 module_exit(fini_umh);
-- 
2.25.0

