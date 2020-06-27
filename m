Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4520C10F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgF0Ljk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 07:39:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57236 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0Ljj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 07:39:39 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05RBcbc8066660;
        Sat, 27 Jun 2020 20:38:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Sat, 27 Jun 2020 20:38:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05RBcZq7066652
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 27 Jun 2020 20:38:36 +0900 (JST)
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
Date:   Sat, 27 Jun 2020 20:38:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/26 21:51, Eric W. Biederman wrote:
> Please let me know if you see any bugs.  Once the code review is
> finished I plan to take this through my tree.

This series needs some sanity checks.

diff --git a/kernel/umd.c b/kernel/umd.c
index de2f542191e5..f3e0227a3012 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -47,15 +47,18 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 
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
 
+	if (!info || !info->driver_name || !data || !len)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(info->wd.dentry || info->wd.mnt))
 		return -EBUSY;
 
@@ -158,6 +161,9 @@ int fork_usermode_driver(struct umd_info *info)
 	char **argv = NULL;
 	int err;
 
+	if (!info || !info->driver_name)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(info->tgid))
 		return -EBUSY;
 
But loading

----- test.c -----
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/umd.h>

static int __init test_init(void)
{
	const char blob[464] = {
		"\x7f\x45\x4c\x46\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x02\x00\x3e\x00\x01\x00\x00\x00\x80\x00\x40\x00\x00\x00\x00\x00"
		"\x40\x00\x00\x00\x00\x00\x00\x00\xd0\x00\x00\x00\x00\x00\x00\x00"
		"\x00\x00\x00\x00\x40\x00\x38\x00\x01\x00\x40\x00\x04\x00\x03\x00"
		"\x01\x00\x00\x00\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00"
		"\xb4\x00\x00\x00\x00\x00\x00\x00\xb4\x00\x00\x00\x00\x00\x00\x00"
		"\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\xb8\x01\x00\x00\x00\xbf\x01\x00\x00\x00\x48\xbe\xa8\x00\x40\x00"
		"\x00\x00\x00\x00\xba\x0c\x00\x00\x00\x0f\x05\xb8\xe7\x00\x00\x00"
		"\xbf\x00\x00\x00\x00\x0f\x05\x00\x48\x65\x6c\x6c\x6f\x20\x77\x6f"
		"\x72\x6c\x64\x0a\x00\x2e\x73\x68\x73\x74\x72\x74\x61\x62\x00\x2e"
		"\x74\x65\x78\x74\x00\x2e\x72\x6f\x64\x61\x74\x61\x00\x00\x00\x00"
		"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x0b\x00\x00\x00\x01\x00\x00\x00\x06\x00\x00\x00\x00\x00\x00\x00"
		"\x80\x00\x40\x00\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00"
		"\x27\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x11\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00"
		"\xa8\x00\x40\x00\x00\x00\x00\x00\xa8\x00\x00\x00\x00\x00\x00\x00"
		"\x0c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x01\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x00\x00\x00\x00\x00\x00\x00\x00\xb4\x00\x00\x00\x00\x00\x00\x00"
		"\x19\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		"\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
	};
	struct umd_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
	
	if (!info)
		return -ENOMEM;
	info->driver_name = kstrdup("my test driver", GFP_KERNEL);
	printk("umd_load_blob()=%d\n", umd_load_blob(info, blob, 464));
	//printk("fork_usermode_driver()=%d\n", fork_usermode_driver(info));
	return -EINVAL;
}

module_init(test_init);
MODULE_LICENSE("GPL");
----- test.c -----

causes

   BUG_ON(!(task->flags & PF_KTHREAD));

in __fput_sync(). Do we want to forbid umd_load_blob() from process context (e.g.
upon module initialization time) ?

Also, since umd_load_blob() uses info->driver_name as filename, info->driver_name has to
satisfy strchr(info->driver_name, '/') == NULL && strlen(info->driver_name) <= NAME_MAX
in order to avoid -ENOENT failure. On the other hand, since fork_usermode_driver() uses
info->driver_name as argv[], info->driver_name has to use ' ' within this constraint.
This might be inconvenient...
