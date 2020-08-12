Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD88242482
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 06:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHLEPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 00:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgHLEPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:15:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD724C06174A;
        Tue, 11 Aug 2020 21:15:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5iAY-00Dt2T-Pi; Wed, 12 Aug 2020 04:15:18 +0000
Date:   Wed, 12 Aug 2020 05:15:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arnd@arndb.de, christian.brauner@ubuntu.com, hch@lst.de,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com>
Subject: [PATCH] Re: KASAN: use-after-free Read in path_init (2)
Message-ID: <20200812041518.GO1236603@ZenIV.linux.org.uk>
References: <000000000000f0724405aca59f64@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f0724405aca59f64@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:17:16PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5631c5e0 Merge tag 'xfs-5.9-merge-7' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17076984900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=afba7c06f91e56eb
> dashboard link: https://syzkaller.appspot.com/bug?extid=bbeb1c88016c7db4aa24
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1502ce02900000

fix breakage in do_rmdir()

putname() should happen only after we'd *not* branched to
retry, same as it's done in do_unlinkat().

Fixes: e24ab0ef689d "fs: push the getname from do_rmdir into the callers"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namei.c b/fs/namei.c
index fde8fe086c09..9fa10c614de7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3770,11 +3770,11 @@ long do_rmdir(int dfd, struct filename *name)
 	mnt_drop_write(path.mnt);
 exit1:
 	path_put(&path);
-	putname(name);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
+	putname(name);
 	return error;
 }
 
