Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ABD296409
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900993AbgJVRtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 13:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900943AbgJVRtD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:49:03 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58989205CA;
        Thu, 22 Oct 2020 17:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603388943;
        bh=3M4q1AUzE86IrFjVI2Fx8qvLy0zAJTNJFVgWfdIdoS4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=2SFmbM5HxkVpGZlzG1ndI3TMSmGOegr72gop/M3d73kIg1CFZnKxGtGcKyezck+mZ
         O+kCIqz76ma3ykjBvmEgHBffAgre35RBYSQrrVwnng/jiCNp1fOpZJttEX9hcKFqey
         qBPAkG7FegbGwpqDFZNgK/OzszfouwU5/DBHuJXs=
Message-ID: <b2dc8ec275e9fc379398f95aba237e1224c86330.camel@kernel.org>
Subject: Re: [PATCH] locks: Fix UBSAN undefined behaviour in
 flock64_to_posix_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>, Luo Meng <luomeng12@huawei.com>
Cc:     bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 22 Oct 2020 13:48:58 -0400
In-Reply-To: <20201022172500.GA3613750@gmail.com>
References: <20201022020341.2434316-1-luomeng12@huawei.com>
         <20201022172500.GA3613750@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-10-22 at 10:25 -0700, Eric Biggers wrote:
> On Thu, Oct 22, 2020 at 10:03:41AM +0800, Luo Meng wrote:
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
> 
> Given what the bounds check just above does, wouldn't it make more sense to
> parenthesize 'l->l_len - 1' instead?  So:
> 
> 		fl->fl_end = fl->fl_start + (l->l_len - 1);
> 
> Also FWIW, the Linux kernel uses the -fwrapv compiler flag, so signed integer
> overflow is defined.  IMO it's still best avoided though...
> 

That does seem less ambiguous.

Luo, if you're OK with that approach, I can just fix it up in-tree.
-- 
Jeff Layton <jlayton@kernel.org>

