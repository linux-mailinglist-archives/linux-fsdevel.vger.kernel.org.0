Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1946E62A5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfGHU3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 16:29:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33816 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbfGHU3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:29:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkaGl-0006h2-GX; Mon, 08 Jul 2019 20:29:51 +0000
Date:   Mon, 8 Jul 2019 21:29:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+f70e9b00f8c7d4187bd0@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at lib/lockref.c:LINE!
Message-ID: <20190708202951.GY17978@ZenIV.linux.org.uk>
References: <000000000000b519af058d3091d1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b519af058d3091d1@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 12:37:06PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d58b5ab9 Add linux-next specific files for 20190708
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=123d6887a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf9882946ecc11d9
> dashboard link: https://syzkaller.appspot.com/bug?extid=f70e9b00f8c7d4187bd0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173375c7a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1536f9bfa00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f70e9b00f8c7d4187bd0@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at lib/lockref.c:189!

Mea culpa...  It's "Teach shrink_dcache_parent() to cope with mixed-filesystem
shrink lists", and the fix should be simply this:

diff --git a/fs/dcache.c b/fs/dcache.c
index d8732cf2e302..d85d8f2c8c97 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1555,6 +1555,7 @@ void shrink_dcache_parent(struct dentry *parent)
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
 			struct dentry *parent;
+			spin_lock(&data.victim->d_lock);
 			if (!shrink_lock_dentry(data.victim)) {
 				rcu_read_unlock();
 			} else {
