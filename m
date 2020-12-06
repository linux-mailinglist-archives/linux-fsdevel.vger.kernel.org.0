Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E014E2D0081
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 05:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgLFE2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 23:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLFE2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 23:28:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C0C0613D0;
        Sat,  5 Dec 2020 20:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=D5ZHvjUvMBDemr7cpbY6iKne/87nTrj0lp8KQjcma0E=; b=yzSU+OEsW/NQxelTeDu7RZVtaV
        JNBhbuxIXeotQMfZO+CNLaavmrOcopGwSQMecylokD/39YI6ylQHPMS3ISYEvVQreemhIcsi2JkOp
        HEp/9j8Y6KDl8Bqure8S6yQl3YXOqFJMOzQSlxv8GbxjfW7uX4Yap91YD8ToxcAIiixKZ0o7Iw0JT
        9bN1FoLkDcjbtEnchpz3OCCJulbUI0E78fy9eXo7sIIUKZB2BTu4GkWn5+DG9wv96Nm5sPp5VI3Vy
        qzzvbe39s7DAv2aHKSHathau2XBTHqRdMZVwgbCt+eW//r9g+un5GtUgjNM+iooXfSdC0YV/+1cRu
        DFxInAEQ==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klk3c-0002rw-QN; Sun, 06 Dec 2020 02:45:53 +0000
Subject: Re: memory leak in generic_parse_monolithic [+PATCH]
To:     syzbot <syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        David Howells <dhowells@redhat.com>
References: <0000000000002a530d05b400349b@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6db2af99-e6e3-7f28-231e-2bdba05ca5fa@infradead.org>
Date:   Sat, 5 Dec 2020 18:45:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <0000000000002a530d05b400349b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/13/20 9:17 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    af5043c8 Merge tag 'acpi-5.10-rc4' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13e8c906500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f13716fa0212fd
> dashboard link: https://syzkaller.appspot.com/bug?extid=86dc6632faaca40133ab
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102a57dc500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129ca3d6500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com
> 
> Warning: Permanently added '10.128.0.84' (ECDSA) to the list of known hosts.
> executing program
> executing program
> BUG: memory leak
> unreferenced object 0xffff888111f15a80 (size 32):
>   comm "syz-executor841", pid 8507, jiffies 4294942125 (age 14.070s)
>   hex dump (first 32 bytes):
>     25 5e 5d 24 5b 2b 25 5d 28 24 7b 3a 0f 6b 5b 29  %^]$[+%](${:.k[)
>     2d 3a 00 00 00 00 00 00 00 00 00 00 00 00 00 00  -:..............
>   backtrace:
>     [<000000005c6f565d>] kmemdup_nul+0x2d/0x70 mm/util.c:151
>     [<0000000054985c27>] vfs_parse_fs_string+0x6e/0xd0 fs/fs_context.c:155
>     [<0000000077ef66e4>] generic_parse_monolithic+0xe0/0x130 fs/fs_context.c:201
>     [<00000000d4d4a652>] do_new_mount fs/namespace.c:2871 [inline]
>     [<00000000d4d4a652>] path_mount+0xbbb/0x1170 fs/namespace.c:3205
>     [<00000000f43f0071>] do_mount fs/namespace.c:3218 [inline]
>     [<00000000f43f0071>] __do_sys_mount fs/namespace.c:3426 [inline]
>     [<00000000f43f0071>] __se_sys_mount fs/namespace.c:3403 [inline]
>     [<00000000f43f0071>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3403
>     [<00000000dc5fffd5>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>     [<000000004e665669>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 

Hi David,
Is this a false positive, maybe having to do with this comment from
fs/fsopen.c: ?

/*
 * Check the state and apply the configuration.  Note that this function is
 * allowed to 'steal' the value by setting param->xxx to NULL before returning.
 */
static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
			       struct fs_parameter *param)
{


Otherwise please look at the patch below.
Thanks.

> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches


---
From: Randy Dunlap <rdunlap@infradead.org>

Callers to vfs_parse_fs_param() should be responsible for freeing
param.string.

Fixes: ecdab150fddb ("vfs: syscall: Add fsconfig() for configuring and managing a context")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
This looks promising to me but I haven't fully tested it yet
because my build/test machine just started acting flaky,
like it is having memory or disk errors.
OTOH, it could have ramifications in other places.

 fs/fs_context.c |    1 -
 fs/fsopen.c     |    4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20201204.orig/fs/fs_context.c
+++ linux-next-20201204/fs/fs_context.c
@@ -128,7 +128,6 @@ int vfs_parse_fs_param(struct fs_context
 		if (fc->source)
 			return invalf(fc, "VFS: Multiple sources");
 		fc->source = param->string;
-		param->string = NULL;
 		return 0;
 	}
 
--- linux-next-20201204.orig/fs/fsopen.c
+++ linux-next-20201204/fs/fsopen.c
@@ -262,7 +262,9 @@ static int vfs_fsconfig_locked(struct fs
 		    fc->phase != FS_CONTEXT_RECONF_PARAMS)
 			return -EBUSY;
 
-		return vfs_parse_fs_param(fc, param);
+		ret = vfs_parse_fs_param(fc, param);
+		kfree(param->string);
+		return ret;
 	}
 	fc->phase = FS_CONTEXT_FAILED;
 	return ret;

