Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFF14F6C1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 06:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgBAFew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 00:34:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52930 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgBAFew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 00:34:52 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixlQf-005YzV-TQ; Sat, 01 Feb 2020 05:34:50 +0000
Date:   Sat, 1 Feb 2020 05:34:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+190005201ced78a74ad6@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in path_openat
Message-ID: <20200201053449.GH23230@ZenIV.linux.org.uk>
References: <000000000000b926cf059d7c6552@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b926cf059d7c6552@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:48:11PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ccaaaf6f Merge tag 'mpx-for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=115bda4ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=879390c6b09ccf66
> dashboard link: https://syzkaller.appspot.com/bug?extid=190005201ced78a74ad6
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1674c776e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1565e101e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+190005201ced78a74ad6@syzkaller.appspotmail.com

Already reported; see if the following fixes that:

diff --git a/fs/namei.c b/fs/namei.c
index 4167109297e0..db6565c99825 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3333,8 +3333,8 @@ static int do_last(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
-	kuid_t dir_uid = dir->d_inode->i_uid;
-	umode_t dir_mode = dir->d_inode->i_mode;
+	kuid_t dir_uid = nd->inode->i_uid;
+	umode_t dir_mode = nd->inode->i_mode;
 	int open_flag = op->open_flag;
 	bool will_truncate = (open_flag & O_TRUNC) != 0;
 	bool got_write = false;
