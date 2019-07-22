Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00EA70284
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfGVOkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 10:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfGVOkw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:40:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5BD32190D;
        Mon, 22 Jul 2019 14:40:49 +0000 (UTC)
Date:   Mon, 22 Jul 2019 10:40:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
Message-ID: <20190722104048.463397a0@gandalf.local.home>
In-Reply-To: <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
        <20190722025043.166344-13-gaoxiang25@huawei.com>
        <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
        <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
        <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Jul 2019 09:16:22 +0300
Amir Goldstein <amir73il@gmail.com> wrote:

> CC kernel/trace maintainers for RB_PAGE_HEAD/RB_PAGE_UPDATE
> and kernel/locking maintainers for RT_MUTEX_HAS_WAITERS

Interesting.

> 
> > (Is there some use scenerios in overlayfs and fanotify?...)  
> 
> We had one in overlayfs once. It is gone now.
> 
> >
> > and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)
> >
> > Therefore, I tend to keep silence and just promote EROFS... some better ideas?...
> >  
> 
> Writing example conversion patches to demonstrate cleaner code
> and perhaps reduce LOC seems the best way.

Yes, I would be more interested in seeing patches that clean up the
code than just talking about it.

> 
> Also pointing out that fixing potential bugs in one implementation is preferred
> to having to patch all copied implementations.
> 
> I wonder if tagptr_unfold_tags() doesn't need READ_ONCE() as per:
> 1be5d4fa0af3 locking/rtmutex: Use READ_ONCE() in rt_mutex_owner()
> 
> rb_list_head() doesn't have READ_ONCE()

Hmm, even if the compiler decided to reread the data, it would still
need to clear the extra bits wouldn't it? Or am I missing something?

-- Steve

> Nor does hlist_bl_first() and BPF_MAP_PTR().
> 
> Are those all safe due to safe call sites? or potentially broken?

