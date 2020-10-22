Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63641296120
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368204AbgJVOvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368201AbgJVOvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:51:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF9C0613CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SbMpuVWWxgXMVfuxUGBPNLWGxfsP/J0seak81KWV01U=; b=tJu1s1tnkx29v6TJ6OJ4r8MHq0
        SYuGz0e+ye7/ryTZj5AjwTmHzTuciOgv2plAxPpN4Et1Lo7N1oXQBzNZvplTPa+rQK9d8gWDYMjnf
        JJTQh8HUPifnntO//7XYxSYi6eK6jmlycadRRtc8c+8i5d/rhbaaWB8CQhYJh1jNqSUO+/MOyo2Wf
        c8vsNGcKIddKE3A7KuxbBK4mOtup13tXyfDfjKQrRT2ZbQzqDcXur9IWuC5mys9ON+AC7Dc10z8VC
        0qpbFZBCTofrze/+bghNmYDT9Y0ccINzpxVtq1x5P3Wx3vRY5I7NvInLb7AhTtB5AZ9CZG6OvdJHd
        UoIgKeGA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVbvl-0004j1-QE; Thu, 22 Oct 2020 14:51:05 +0000
Date:   Thu, 22 Oct 2020 15:51:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Luo Meng <luomeng12@huawei.com>, bfields@fieldses.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] locks: Fix UBSAN undefined behaviour in
 flock64_to_posix_lock
Message-ID: <20201022145105.GT20115@casper.infradead.org>
References: <20201022020341.2434316-1-luomeng12@huawei.com>
 <3cb0aeaa4e75b5dd4c0e6bb8b04f277f7162a581.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cb0aeaa4e75b5dd4c0e6bb8b04f277f7162a581.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 09:21:35AM -0400, Jeff Layton wrote:
> On Thu, 2020-10-22 at 10:03 +0800, Luo Meng wrote:
> > When the sum of fl->fl_start and l->l_len overflows,
> > UBSAN shows the following warning:
> > 
> > UBSAN: Undefined behaviour in fs/locks.c:482:29
> > signed integer overflow: 2 + 9223372036854775806
> > cannot be represented in type 'long long int'
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0xe4/0x14e lib/dump_stack.c:118
> >  ubsan_epilogue+0xe/0x81 lib/ubsan.c:161
> >  handle_overflow+0x193/0x1e2 lib/ubsan.c:192
> >  flock64_to_posix_lock fs/locks.c:482 [inline]
> >  flock_to_posix_lock+0x595/0x690 fs/locks.c:515
> >  fcntl_setlk+0xf3/0xa90 fs/locks.c:2262
> >  do_fcntl+0x456/0xf60 fs/fcntl.c:387
> >  __do_sys_fcntl fs/fcntl.c:483 [inline]
> >  __se_sys_fcntl fs/fcntl.c:468 [inline]
> >  __x64_sys_fcntl+0x12d/0x180 fs/fcntl.c:468
> >  do_syscall_64+0xc8/0x5a0 arch/x86/entry/common.c:293
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > Fix it by moving -1 forward.
> > 
> > Signed-off-by: Luo Meng <luomeng12@huawei.com>
> > ---
> >  fs/locks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 1f84a03601fe..8489787ca97e 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -542,7 +542,7 @@ static int flock64_to_posix_lock(struct file *filp, struct file_lock *fl,
> >  	if (l->l_len > 0) {
> >  		if (l->l_len - 1 > OFFSET_MAX - fl->fl_start)
> >  			return -EOVERFLOW;
> > -		fl->fl_end = fl->fl_start + l->l_len - 1;
> > +		fl->fl_end = fl->fl_start - 1 + l->l_len;
> >  
> >  	} else if (l->l_len < 0) {
> >  		if (fl->fl_start + l->l_len < 0)
> 
> Wow, ok. Interesting that the order would have such an effect here, but
> it seems legit. I'll plan to merge this for v5.11. Let me know if we
> need to get this in earlier.

It's the kind of pedantic correctness thing that should be merged because
C doesn't exactly define the behaviour.  eg a sign-magnitude machine
will behave differently from a twos-complement machine.  The fact that
nobody's made a sign-magnitude integer arithmetic machine in the last
60 years does not matter to the C spec.

It's a shame there's no uoff_t since it would be defined.
