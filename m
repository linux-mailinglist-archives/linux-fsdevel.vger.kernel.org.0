Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7F20B1F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFZNBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 09:01:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46934 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZNBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:01:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonyj-0005Bi-RT; Fri, 26 Jun 2020 07:01:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonyg-0001bv-40; Fri, 26 Jun 2020 07:01:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 26 Jun 2020 07:56:42 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87d05mf0j9.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jonyg-0001bv-40;;;mid=<87d05mf0j9.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/QwtP+DmH8AFNcMytOMR2clSik9Phsua0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2697 ms - load_scoreonly_sql: 0.18 (0.0%),
        signal_user_changed: 12 (0.4%), b_tie_ro: 9 (0.3%), parse: 3.0 (0.1%),
        extract_message_metadata: 112 (4.2%), get_uri_detail_list: 37 (1.4%),
        tests_pri_-1000: 68 (2.5%), compile_eval: 141 (5.2%), tests_pri_-950:
        3.1 (0.1%), tests_pri_-900: 14 (0.5%), tests_pri_-90: 268 (9.9%),
        check_bayes: 263 (9.8%), b_tokenize: 133 (4.9%), b_tok_get_all: 29
        (1.1%), b_comp_prob: 4.9 (0.2%), b_tok_touch_all: 84 (3.1%), b_finish:
        1.33 (0.0%), tests_pri_0: 2162 (80.2%), check_dkim_signature: 13
        (0.5%), check_dkim_adsp: 13 (0.5%), poll_dns_idle: 10 (0.4%),
        tests_pri_10: 3.8 (0.1%), tests_pri_500: 40 (1.5%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 08/14] umd: Transform fork_usermode_blob into fork_usermode_driver
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
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umd.h          |   6 +-
 kernel/umd.c                 | 121 ++++++++++++++++++++++++++---------
 net/bpfilter/bpfilter_kern.c |  14 +++-
 3 files changed, 108 insertions(+), 33 deletions(-)

diff --git a/include/linux/umd.h b/include/linux/umd.h
index 6c3e00e0520b..d4a2e9e6f154 100644
--- a/include/linux/umd.h
+++ b/include/linux/umd.h
@@ -2,6 +2,7 @@
 #define __LINUX_UMD_H__
 
 #include <linux/umh.h>
+#include <linux/path.h>
 
 struct umd_info {
 	const char *driver_name;
@@ -9,8 +10,11 @@ struct umd_info {
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
index bad2e8da7f96..afb689d6bf35 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -4,11 +4,93 @@
  */
 #include <linux/shmem_fs.h>
 #include <linux/pipe_fs_i.h>
+#include <linux/mount.h>
+#include <linux/fs_struct.h>
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
+	__fput_sync(file);
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
@@ -43,6 +125,7 @@ static int umd_setup(struct subprocess_info *info, struct cred *new)
 		return err;
 	}
 
+	set_fs_pwd(current->fs, &umd_info->wd);
 	umd_info->pipe_to_umh = to_umh[1];
 	umd_info->pipe_from_umh = from_umh[0];
 	umd_info->pid = task_pid_nr(current);
@@ -62,39 +145,21 @@ static void umd_cleanup(struct subprocess_info *info)
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
@@ -106,7 +171,6 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	if (!sub_info)
 		goto out;
 
-	sub_info->file = file;
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
 	if (!err) {
 		mutex_lock(&umh_list_lock);
@@ -116,10 +180,9 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
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

