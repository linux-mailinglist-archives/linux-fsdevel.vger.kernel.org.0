Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B48372EBDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 21:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbjFMTXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbjFMTXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:23:32 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7387A1BF5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 12:23:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-50-124.bstnma.fios.verizon.net [108.7.50.124])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35DJMpIH031051
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 15:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686684174; bh=x4bH0s8sk+x+D8ORgv9QPq4Fl5wC5y50BBhTUE3PEHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hUNa/f9TnE7YcFoj9FSOzas6igUk+jh/IYb+h2fp//7Cq5uL/HBech/Qmp1+5+LF+
         Lev7xFs/Z1bYfC8pjP14xn62sX3QKR+mHEciofov/aSq6lmAmOCnSGwTMzrAcb7a+N
         x/hQUwRZQ8O1mIrbkj+BEV+KZpdX0ln6sm83HuXvXa6HohezX7ohqlBjCc83KybS4D
         rJ9RNU7L+/TMaF/b5tfW7A/t0xcUMcTY1SxxsHJx5bpVKmjkBelp0/hComOGCA7ql+
         pF53x1Yyj9u9C6wq33E3zf57UY43XgMnh0/SSEtswgGNc4iSUwiUUtqmVqa2wBt21E
         vi0o67TcwH1nQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1056115C00B0; Tue, 13 Jun 2023 15:22:51 -0400 (EDT)
Date:   Tue, 13 Jun 2023 15:22:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230613192251.GA3865@mit.edu>
References: <20230612161614.10302-1-jack@suse.cz>
 <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:49:38AM +0200, Dmitry Vyukov wrote:
> On Mon, 12 Jun 2023 at 18:16, Jan Kara <jack@suse.cz> wrote:
> >
> > Writing to mounted devices is dangerous and can lead to filesystem
> > corruption as well as crashes. Furthermore syzbot comes with more and
> > more involved examples how to corrupt block device under a mounted
> > filesystem leading to kernel crashes and reports we can do nothing
> > about. Add config option to disallow writing to mounted (exclusively
> > open) block devices. Syzbot can use this option to avoid uninteresting
> > crashes. Also users whose userspace setup does not need writing to
> > mounted block devices can set this config option for hardening.
> 
> +syzkaller, Kees, Alexander, Eric
> 
> We can enable this on syzbot, however I have the same concerns as with
> disabling of XFS_SUPPORT_V4:
> https://github.com/google/syzkaller/issues/3918#issuecomment-1560624278
> 
> It's useful to know the actual situation with respect to
> bugs/vulnerabilities and one of the goals of syzbot is surfacing this
> situation.

So from my perspective, it's not a "vulernability".  It's another
example of "syzbot is porting that root can screw you".  The question
about whether the attacker has write access to the block device is a
threat model question.  If you have write access to the block device,
you can set the setuid bit on a copy of /bin/bash; but is that a
"vulernability"?  Not really....

Yes, from the lockdown perspective, what thight might mean is that
"root can run arbitrary code in ring0".  But for most distributions,
given that they allow users to provide custom modules (for exanple,
for Nvidia or other GPU support) that were not built by the
distribution, they can run arbitrary code in ring 0 because root can
provide an arbitrary kernel module.  If you are 100% locked down,
perhaps that's not the case.  But this is a very specialized use case,
and more to the point, asking upstream to worry about this is
effectively an unfunded mandate.


> For some areas there is mismatch between upstream kernel and
> downstream distros. Upstream says "this is buggy and deprecated",
> which is fine in itself if not the other part: downstream distros
> simply ignore that (maybe not even aware) and keep things enabled for
> as long as possible. Stopping testing this is moving more in this
> direction: silencing warnings and pretending that everything is fine,
> when it's not.
> 
> I wonder if there is a way to at least somehow bridge this gap.
> 
> There is CONFIG_BROKEN, but not sure if it's the right thing here.
> Maybe we add something like CONFIG_INSECURE.

"INSECURE" is not really accurate, because it presumes a certain treat
model, and it's not neccessarily one that everyone has signed off as
being one that they need to worry about.

So I'd put it differently.  We need to have a way of filtering out
those syzbot reports which are caused by allowing a privileged user to
be able to dynamically nodify the block device for a mounted file
system.  One way to do that is to simply surpress them.  For example,
we did that when we taught syzbot not to try to set the real-time
priority for a userspace task to MAX_RT_PRIO, which starves kernel
threads and causes the system to malfunction.  That's not a "kernel
bug", that's a userspace bug, and teaching syzbot not to do the stupid
thing made sense.

If you think there are some subset of people who are about syzbot
reports that are caused by dynamically modifying the underlying block
device while it is mounted, what if we can somehow attach a label to
the syzbot report, indicating that it was caused by modifying a
moutned block device?  That way, upstream can ignore it as a stupid
syzbot thing, and you can keep it as a "theoretical vulnerability".
And we don't have to debate the question of which threat model is the
more reasonable one.

						- Ted
