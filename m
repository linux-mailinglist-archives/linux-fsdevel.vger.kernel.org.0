Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B76155E6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 19:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGSwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 13:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgBGSwm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:52:42 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C3720726;
        Fri,  7 Feb 2020 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581101561;
        bh=1fPUpahFbFrdmo+G2FpKxW0c9tef6lnxo3A//I49Yn4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Px8yZkKquSafUjko2+zT+OthRQvFHtIF/dhlG18IAuK3pcgOFwrckMsNqm0Cu2vMP
         zTxMyifmxEehpFJildZPqr+peXPHfgeJ3Cd4no7vhnHVd3lcPHjZi60Rc0VaCRTf1U
         YbZKBqEvweD9HtqxqEeqyTWFMji5iMYFcc5YJPOs=
Message-ID: <65e24f83cb44950a627d4225d08207c7910c87b6.camel@kernel.org>
Subject: Re: BUG: sleeping function called from invalid context in __kmalloc
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 07 Feb 2020 13:52:39 -0500
In-Reply-To: <20200207184403.GD23230@ZenIV.linux.org.uk>
References: <000000000000d895bd059dffb65c@google.com>
         <000000000000e2de9d059dffefe3@google.com>
         <20200207184403.GD23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-02-07 at 18:44 +0000, Al Viro wrote:
> On Fri, Feb 07, 2020 at 09:44:10AM -0800, syzbot wrote:
> > syzbot has found a reproducer for the following crash on:
> > 
> > HEAD commit:    90568ecf Merge tag 'kvm-5.6-2' of git://git.kernel.org/pub..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15b26831e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=69fa012479f9a62
> > dashboard link: https://syzkaller.appspot.com/bug?extid=98704a51af8e3d9425a9
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172182b5e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590aab5e00000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com
> 
> commit 4fbc0c711b2464ee1551850b85002faae0b775d5
> Author: Xiubo Li <xiubli@redhat.com>
> Date:   Fri Dec 20 09:34:04 2019 -0500
> 
>     ceph: remove the extra slashes in the server path
> 
> is broken.  You really should not do blocking allocations under spinlocks.
> What's more, this is pointless - all you do with the results of two such
> calls is strcmp_null, for pity sake...  You could do the comparison in
> one pass, no need for all of that.  Or you could do a normalized copy when
> you parse options, store that normalized copy in addition to what you are
> storing now and compare _that_.

Thanks Al,

I'll take a closer look and we'll either fix this up or drop it for now.

-- 
Jeff Layton <jlayton@kernel.org>

