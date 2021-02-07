Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B136312766
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBGU1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 15:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGU1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 15:27:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F4CC06174A
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Feb 2021 12:26:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id m2so2174755pgq.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Feb 2021 12:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=mxKKO1TY0wYVaI8POrF6A8LJfDP6M0L/dZ2gay10pTs=;
        b=EIwGaQ8SSc9i3SaZwRAyzA1b3AqcCp6dOSK3HSGQljqGc/VRlH+m5elvTpQ9va9nm/
         uE0kdM/MTDu/rby/fdE/Lms0xN+l6NYd4iVjskSkMPD0kKpj4rfBo0xq/+HUxKxGi8H+
         BMdGDQVS25EHxLabvc2NMfVCuCVuG3FsLv02Eisi9DTXtAH8OcfpYykuSkej2pojbsbf
         ZwZtUrRCjfojR0qX89ymR7AgYtQcspydL8IKq83WhLinapN+BVpZVNsceVDe5/BW2GVP
         3Z9M3GKOx8JMBU2otk00fioZS/kXtgz0lXd3lRz3i170fcT0bMCTyx9jhkwC4x2wT1Iz
         4L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=mxKKO1TY0wYVaI8POrF6A8LJfDP6M0L/dZ2gay10pTs=;
        b=Vz8TCP+X5i0cOhQU5wpDIjodjOTO8LdsbGe6diKRkGaW6wuJwRxNopPo7WZOsMq9JS
         RWGSJU1Fwe/twmSOK2SUkIaI9D4L0q3sDHV2gA2rXp29G3ExrUDsY9+9BBr1NYwG9HcK
         fw9adzgxG2P3Dt9w++HNiT6T/i49SlnfgOO+5+H4b5CyXIf4NppPpCc3kXVeB3DCVxCB
         DKIJyvoYHy2zHs6qTla+EpEkwZI4kAa0M6YwswVJS0oqF//lVOnJzn3M5HU8Nde47AX0
         t3b7+XhfxkmNJdBxalC+bK5dRIvw3erT1iWClJkAIWobisrIYAjleXPDc+By2clD+N7s
         CqRw==
X-Gm-Message-State: AOAM532WuoIT6bmJhQ5omS7dmW2Sun2FZTMIsfDiYo4B1UnvBPAqnv6u
        3oUUn3rOZpQe5XLJCLo0MFFTOh9zk1LxwA==
X-Google-Smtp-Source: ABdhPJwHOgd2MpiW5bI4cRdE5U/pU3MSDDzKfjwGYwVGvfvAU1YFEAu39pBtq52mZlzH26Q5vVAGXA==
X-Received: by 2002:a65:57cd:: with SMTP id q13mr5876866pgr.367.1612729581590;
        Sun, 07 Feb 2021 12:26:21 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v1sm16563374pga.63.2021.02.07.12.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 12:26:20 -0800 (PST)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC] namei: don't drop link paths acquired under LOOKUP_RCU
Message-ID: <8b114189-e943-a7e6-3d31-16aa8a148da6@kernel.dk>
Date:   Sun, 7 Feb 2021 13:26:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1AB8B81F96D255D88DCA2EF9"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1AB8B81F96D255D88DCA2EF9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Ran into an issue where testing with LOOKUP_CACHED ended up complaining
about a mount count mismatch:

WARNING: CPU: 3 PID: 368 at fs/namespace.c:1168 mntput_no_expire+0x1b5/0x270
Modules linked in:
CPU: 3 PID: 368 Comm: al Not tainted 5.11.0-rc6+ #9166
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:mntput_no_expire+0x1b5/0x270
Code: 0f 84 b9 fe ff ff 48 8b 35 28 d7 fd 00 b9 01 00 00 00 bf 08 00 00 00 48 c7 c2 80 1b 17 82 e8 d2 10 e2 ff e9 97 fe ff ff 79 02 <0f> 0b e8 44 d4 e7 ff 83 05 0d 91 da 00 01 48 c7 c7 04 96 00 82 e8
RSP: 0018:ffffc900002bbe68 EFLAGS: 00010286
RAX: 0000000000000008 RBX: 00000000ffffffff RCX: 0000000000000008
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000008
RBP: ffff888102790000 R08: 0000000000000000 R09: 0000000000000008
R10: ffff8881b9ce9c80 R11: 0000000000002000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888102790088 R15: ffff888102790050
FS:  00007f35e29f9580(0000) GS:ffff8881b9cc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558689fde004 CR3: 0000000108403003 CR4: 00000000001706e0
Call Trace:
 path_umount+0x224/0x510
 __x64_sys_umount+0x6f/0x80
 do_syscall_64+0x31/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f35e292f2cb
Code: 1b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 71 1b 0c 00 f7 d8
RSP: 002b:00007ffc6536e638 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f35e292f2cb
RDX: 00007ffc6536e640 RSI: 0000000000000000 RDI: 0000558689fde004
RBP: 0000558689fdd220 R08: 00007f35e2a194c0 R09: 0000000000000000
R10: 0000558689fdc448 R11: 0000000000000246 R12: 0000558689fdd120
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

and I believe this is due to the stack links being put, even though they
were acquired under LOOKUP_RCU, and hence don't hold an actual reference.
Before LOOKUP_CACHED, we always retried without LOOKUP_RCU, and hence
they'd end up being valid. But if a caller specifies LOOKUP_CACHED, then
we will not be retrying without LOOKUP_RCU.

Fix this by clearing the stack link depth when we unlazy.

Fixes: 6c6ec2b0a3e0 ("fs: add support for LOOKUP_CACHED")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Al, not sure if this is the right fix for the situation, but it's
definitely a problem. Observed by doing a LOOKUP_CACHED of something with
links, using /proc/self/comm as the example in the attached way to
demonstrate this problem.

diff --git a/fs/namei.c b/fs/namei.c
index 4cae88733a5c..20e706fe505a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -701,6 +701,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 out1:
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
+	nd->depth = 0;
 out:
 	rcu_read_unlock();
 	return false;
@@ -755,6 +756,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry, unsi
 
 out2:
 	nd->path.mnt = NULL;
+	nd->depth = 0;
 out1:
 	nd->path.dentry = NULL;
 out:

-- 
Jens Axboe


--------------1AB8B81F96D255D88DCA2EF9
Content-Type: text/x-csrc; charset=UTF-8;
 name="link-RESOLVE_CACHED.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="link-RESOLVE_CACHED.c"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <linux/openat2.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/types.h>

#define RESOLVE_CACHED	0x20

static int io_openat2(const char *path, int dfd)
{
	struct open_how how;
	int ret;

	memset(&how, 0, sizeof(how));
	how.flags = O_RDONLY;
	how.resolve = RESOLVE_CACHED;

	ret = syscall(437, dfd, path, &how, sizeof(how));
	if (ret == -1)
		return -errno;
	return ret;
}

int main(int argc, char *argv[])
{
	mkdir("/proc2", 0644);
	mount("none", "/proc2", "proc", 0, NULL);
	io_openat2("/proc2/self/comm", -1);
	umount("/proc2");
	return 0;
}

--------------1AB8B81F96D255D88DCA2EF9--
