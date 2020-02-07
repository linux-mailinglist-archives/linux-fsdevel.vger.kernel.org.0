Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130C8155E56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 19:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGSoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 13:44:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47610 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGSoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:44:05 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j08bj-008ztl-KQ; Fri, 07 Feb 2020 18:44:03 +0000
Date:   Fri, 7 Feb 2020 18:44:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: Re: BUG: sleeping function called from invalid context in __kmalloc
Message-ID: <20200207184403.GD23230@ZenIV.linux.org.uk>
References: <000000000000d895bd059dffb65c@google.com>
 <000000000000e2de9d059dffefe3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e2de9d059dffefe3@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 09:44:10AM -0800, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    90568ecf Merge tag 'kvm-5.6-2' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b26831e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=69fa012479f9a62
> dashboard link: https://syzkaller.appspot.com/bug?extid=98704a51af8e3d9425a9
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172182b5e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590aab5e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com

commit 4fbc0c711b2464ee1551850b85002faae0b775d5
Author: Xiubo Li <xiubli@redhat.com>
Date:   Fri Dec 20 09:34:04 2019 -0500

    ceph: remove the extra slashes in the server path

is broken.  You really should not do blocking allocations under spinlocks.
What's more, this is pointless - all you do with the results of two such
calls is strcmp_null, for pity sake...  You could do the comparison in
one pass, no need for all of that.  Or you could do a normalized copy when
you parse options, store that normalized copy in addition to what you are
storing now and compare _that_.
