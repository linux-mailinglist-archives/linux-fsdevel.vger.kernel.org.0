Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDEF20EE2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 08:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgF3GSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 02:18:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61336 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgF3GSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:18:05 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05U6H3xt072997;
        Tue, 30 Jun 2020 15:17:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Tue, 30 Jun 2020 15:17:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05U6H2bZ072931
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 30 Jun 2020 15:17:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
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
 <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
 <87y2o51hkk.fsf@x220.int.ebiederm.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8137153b-6163-b52c-a1f8-f3949dc321bd@i-love.sakura.ne.jp>
Date:   Tue, 30 Jun 2020 15:16:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87y2o51hkk.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/30 10:13, Eric W. Biederman wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> 
>> On Mon, Jun 29, 2020 at 02:55:05PM -0500, Eric W. Biederman wrote:
>>>
>>> I have tested thes changes by booting with the code compiled in and
>>> by killing "bpfilter_umh" and running iptables -vnL to restart
>>> the userspace driver.
>>>
>>> I have compiled tested each change with and without CONFIG_BPFILTER
>>> enabled.
>>
>> With
>> CONFIG_BPFILTER=y
>> CONFIG_BPFILTER_UMH=m
>> it doesn't build:
>>
>> ERROR: modpost: "kill_pid_info" [net/bpfilter/bpfilter.ko] undefined!
>>
>> I've added:
>> +EXPORT_SYMBOL(kill_pid_info);
>> to continue testing...

kill_pid() is already exported.

>>
>> And then did:
>> while true; do iptables -L;rmmod bpfilter; done
>>  
>> Unfortunately sometimes 'rmmod bpfilter' hangs in wait_event().
>>
>> I suspect patch 13 is somehow responsible:
>> +	if (tgid) {
>> +		kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
>> +		wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
>> +		bpfilter_umh_cleanup(info);
>> +	}
>>
>> I cannot figure out why it hangs. Some sort of race ?
>> Since adding short delay between kill and wait makes it work.

Because there is a race window that detach_pid() from __unhash_process() from
__exit_signal() from release_task() from exit_notify() from do_exit() is called
some time after wake_up_all(&pid->wait_pidfd) from do_notify_pidfd() from
do_notify_parent() from exit_notify() from do_exit() was called (in other words,
we can't use pid->wait_pidfd when pid_task() is used at wait_event()) ?

Below are changes I suggest.

diff --git a/kernel/umd.c b/kernel/umd.c
index ff79fb16d738..f688813b8830 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -26,7 +26,7 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 	if (IS_ERR(mnt))
 		return mnt;
 
-	file = file_open_root(mnt->mnt_root, mnt, name, O_CREAT | O_WRONLY, 0700);
+	file = file_open_root(mnt->mnt_root, mnt, name, O_CREAT | O_WRONLY | O_EXCL, 0700);
 	if (IS_ERR(file)) {
 		mntput(mnt);
 		return ERR_CAST(file);
@@ -52,16 +52,18 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 
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
+	if (info->wd.dentry || info->wd.mnt)
 		return -EBUSY;
 
 	mnt = blob_to_mnt(data, len, info->driver_name);
@@ -76,15 +78,14 @@ EXPORT_SYMBOL_GPL(umd_load_blob);
 
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
 		return -EINVAL;
+	BUG_ON(info->wd.mnt->mnt_root != info->wd.dentry);
 
 	kern_unmount(info->wd.mnt);
 	info->wd.mnt = NULL;
@@ -138,7 +139,7 @@ static void umd_cleanup(struct subprocess_info *info)
 {
 	struct umd_info *umd_info = info->data;
 
-	/* cleanup if umh_setup() was successful but exec failed */
+	/* cleanup if umd_setup() was successful but exec failed */
 	if (info->retval) {
 		fput(umd_info->pipe_to_umh);
 		fput(umd_info->pipe_from_umh);
@@ -163,7 +164,10 @@ int fork_usermode_driver(struct umd_info *info)
 	const char *argv[] = { info->driver_name, NULL };
 	int err;
 
-	if (WARN_ON_ONCE(info->tgid))
+	if (!info || !info->driver_name || !info->wd.dentry || !info->wd.mnt)
+		return -EINVAL;
+	BUG_ON(info->wd.mnt->mnt_root != info->wd.dentry);
+	if (info->tgid)
 		return -EBUSY;
 
 	err = -ENOMEM;
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 91474884ddb7..9dd70aacb81a 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -19,8 +19,13 @@ static void shutdown_umh(void)
 	struct pid *tgid = info->tgid;
 
 	if (tgid) {
-		kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
-		wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
+		kill_pid(tgid, SIGKILL, 1);
+		while (({ bool done;
+			  rcu_read_lock();
+			  done = !pid_task(tgid, PIDTYPE_TGID);
+			  rcu_read_unlock();
+			  done; }))
+			schedule_timeout_uninterruptible(1);
 		bpfilter_umh_cleanup(info);
 	}
 }

