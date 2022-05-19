Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63A52C96E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 03:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiESBvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 21:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiESBvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 21:51:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A92286FF;
        Wed, 18 May 2022 18:51:37 -0700 (PDT)
Received: from kwepemi100023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3XqS5yZnzgYNF;
        Thu, 19 May 2022 09:50:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100023.china.huawei.com (7.221.188.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 09:51:35 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 09:51:34 +0800
Subject: Re: [PATCH -next] exec: Remove redundant check in
 do_open_execat/uselib
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20220518081227.1278192-1-chengzhihao1@huawei.com>
 <20220518104601.fc21907008231b60a0e54a8e@linux-foundation.org>
 <202205181215.D448675BEA@keescook>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <c937de42-6288-7ea4-c4ac-bba08e3424c4@huawei.com>
Date:   Thu, 19 May 2022 09:51:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202205181215.D448675BEA@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2022/5/19 3:17, Kees Cook Ð´µÀ:

>>> WARNON(path_noexec(&file->f_path)) // path_noexec() checks fail
> 
> Did you encounter this in the real world?
I found the problem by running fuzz test.(syzkaller)

Here is a brief reproducer.
1. Apply diff
2. Complie and run repo.c
diff
diff --git a/fs/exec.c b/fs/exec.c
index e3e55d5e0be1..388d38b87e9a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -897,6 +897,7 @@ EXPORT_SYMBOL(transfer_args_to_stack);

  #endif /* CONFIG_MMU */

+#include <linux/delay.h>
  static struct file *do_open_execat(int fd, struct filename *name, int 
flags)
  {
  	struct file *file;
@@ -925,9 +926,15 @@ static struct file *do_open_execat(int fd, struct 
filename *name, int flags)
  	 * and check again at the very end too.
  	 */
  	err = -EACCES;
+	if (!strcmp(file->f_path.dentry->d_iname, "my_bin")) {
+		pr_err("wait ...\n");
+		msleep(3000);
+	}
  	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
+			 path_noexec(&file->f_path))) {
+		pr_err("exec %pd %d %d %s\n", file->f_path.dentry, 
file->f_path.mnt->mnt_flags & MNT_NOEXEC, 
file->f_path.mnt->mnt_sb->s_iflags & SB_I_NOEXEC, 
file->f_path.mnt->mnt_sb->s_type->name);
  		goto exit;
+	}

  	err = deny_write_access(file);
  	if (err)

repo.c
int main(void)
{
	int ret;

	system("umount temp 2>&1 > /dev/null");
	system("mount -t tmpfs none temp");
	system("echo 12312 > temp/my_bin && chmod +x temp/my_bin");
	ret = fork();
	if (ret < 0) {
		perror("fork fail");
		return 0;
	}
	if (ret == 0) {
		system("mount -oremount,noexec temp");
		exit(0);
	} else {
		execve("/root/temp/my_bin", NULL, 0);
		//syscall(__NR_uselib, "/root/temp/my_bin");
	}
	return 0;
}
> 
>>
>> You're saying this is a race condition?  A concurrent remount causes
>> this warning?
> 
> It seems not an unreasonable thing to warn about. Perhaps since it's
> technically reachable from userspace, it could be downgraded to
> pr_warn(), but I certainly don't want to remove the checks.


> 
> I'd like to leave this as-is, since we _do_ want to find the cases where
> we're about to allow an exec and a very important security check was NOT
> handled.
>I think removing redundant checking is okay,

do_open_execat/uselib has initialized the acc_mode and open_flag for 
exec file, the check is equivalent to check in may_open().

Remount(noexec) operations can alos happen after the latest check, 
double check has no means for the concurrent situation.

The MNT_NOEXEC flag only affects the open operation, it won't cause any 
problems that an opened bin file is executing in a non-exec mounted 
filesystem.
