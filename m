Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC58F1856F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 08:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfEIGah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 02:30:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46738 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfEIGah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 02:30:37 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hOcZe-0003dA-OF; Thu, 09 May 2019 06:30:34 +0000
Date:   Thu, 9 May 2019 07:30:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+494c7ddf66acac0ad747@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: general protection fault in do_move_mount
Message-ID: <20190509063034.GQ23075@ZenIV.linux.org.uk>
References: <000000000000eb704c05886de151@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000eb704c05886de151@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 08, 2019 at 10:40:06PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    80f23212 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ab8dd0a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=40a58b399941db7e
> dashboard link: https://syzkaller.appspot.com/bug?extid=494c7ddf66acac0ad747
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+494c7ddf66acac0ad747@syzkaller.appspotmail.com

*Ugh*

That's a bloody dumb leftover from very old variant of that thing;
the following should fix it.

do_move_mount(): fix an unsafe use of is_anon_ns()

What triggers it is a race between mount --move and umount -l
of the source; we should reject it (the source is parentless *and*
not the root of anon namespace at that), but the check for namespace
being an anon one is broken in that case - is_anon_ns() needs
ns to be non-NULL.  Better fixed here than in is_anon_ns(), since
the rest of the callers is guaranteed to get a non-NULL argument...

Reported-by: syzbot+494c7ddf66acac0ad747@syzkaller.appspotmail.com
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 3357c3d65475..ffb13f0562b0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2599,7 +2599,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	if (attached && !check_mnt(old))
 		goto out;
 
-	if (!attached && !is_anon_ns(ns))
+	if (!attached && !(ns && is_anon_ns(ns)))
 		goto out;
 
 	if (old->mnt.mnt_flags & MNT_LOCKED)
