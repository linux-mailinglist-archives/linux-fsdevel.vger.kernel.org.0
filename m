Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A547011D5B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfLLSes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 13:34:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52350 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbfLLSer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:34:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifTIR-0001bO-9B; Thu, 12 Dec 2019 18:34:43 +0000
Date:   Thu, 12 Dec 2019 18:34:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: corrupted list in __dentry_kill (2)
Message-ID: <20191212183443.GH4203@ZenIV.linux.org.uk>
References: <000000000000b6b03205997b71cf@google.com>
 <20191212061206.GE4203@ZenIV.linux.org.uk>
 <CACT4Y+YJuV8EGSx8K_5Qd0f+fUz8MHb1awyJ78Jf8zrNmKokrA@mail.gmail.com>
 <20191212133844.GG4203@ZenIV.linux.org.uk>
 <CACT4Y+ZQ6C07TcuAHwc-T+Lb2ZkigkqW32d=TF054RuPwUFimw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZQ6C07TcuAHwc-T+Lb2ZkigkqW32d=TF054RuPwUFimw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 04:57:14PM +0100, Dmitry Vyukov wrote:

> > Speaking of bisect hazards, I'd recommend to check how your bisect
> > went - the bug is definitely local to this commit and I really
> > wonder what had caused the bisect to go wrong in this particular
> > case.
> 
> I did not get the relation of folding to bisection. Or you mean these
> are just separate things?

Suppose instead of folding the fix in I would've done a followup commit
just with the fix.  And left the branch in that form, eventually getting
it pulled into mainline.  From that point on, *ANY* bisect stepping into
the first commit would've been thrown off.  For ever and ever, since
once it's in mainline, it really won't go away.

That's what folding avoids - accumulation of scar tissue, if you will.
Sure, there's enough cases when bug is found too late - it's already
in mainline or pulled into net-next or some other branch with similar
"no rebase, no reorder" policy.  But if you look at the patchsets posted
on the lists and watch them from iteration to iteration, you'll see
a _lot_ of fix-folding.  IME (both by my own practice and by watching
the patchsets posted by others) it outnumbers the cases when fix can't
be folded by quite a factor.  I wouldn't be surprised if it was an
order of magnitude...

Strict "never fold fixes" policy would've accelerated the accumulation
of bisect hazards in the mainline.  And while useful bisect may be a lost
cause for CI bots, it isn't that for intelligent developers.  Anything
that makes it more painful is not going to be welcome.
