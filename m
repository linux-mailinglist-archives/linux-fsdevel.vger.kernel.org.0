Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192365620CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiF3REa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiF3RE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A12F9FF9;
        Thu, 30 Jun 2022 10:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5CDD620F7;
        Thu, 30 Jun 2022 17:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2705C34115;
        Thu, 30 Jun 2022 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656608667;
        bh=9xTkLvgI2j49cZwwhHy9LRORG3NfysC2tN2iVVZbtoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7iyBhtzWLJQUZm7drY70udlT/Dgm/rPn+6mGsNZC+R/SOFn73f+O8ANjsP7hCeMi
         p8U0DbwIeQkyWeYC4vjV6ztUCeVE8xIFZ3pQFGSbW8YOfxH7gFnUs56d6YG0jKsc7r
         8fHUp+qEkwrG1RD1JuApaLwyQPvuGoS2wH/fwo/8edZ6BrDLLNRPi/sDc8PTYz7oQS
         69jnQ9Mg/TsMawN9EcLNmUzxOwuu50O1dPQVKGY2+LyiFtAl55GepALEEq+Xq/0rVX
         FZnUetPQWveOQUZi/spoaQvkLHBjAVpD1oX37ScZwO919Qsbb6102Y008wrzjt0aQa
         vwMUOgW07yjZA==
Date:   Thu, 30 Jun 2022 20:04:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 truncate_inode_partial_folio
Message-ID: <Yr3XjPs9WJU6DLU6@kernel.org>
References: <000000000000f94c4805e289fc47@google.com>
 <YrvYEdTNWcvhIE7U@sol.localdomain>
 <CAJHvVcgoeKhqFTN5aGfQ53GbRDYJsfkRjeUM-yO5AROC0A8ekQ@mail.gmail.com>
 <Yr1jKwz2+SGxjcuW@kernel.org>
 <CAJHvVciyL0i-8HaAWSo9rvbJn-_yqhCmj2FEPhUU=7TdMnKrag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHvVciyL0i-8HaAWSo9rvbJn-_yqhCmj2FEPhUU=7TdMnKrag@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:14:07AM -0700, Axel Rasmussen wrote:
> On Thu, Jun 30, 2022 at 1:47 AM Mike Rapoport <rppt@kernel.org> wrote:
> > On Wed, Jun 29, 2022 at 09:30:12AM -0700, Axel Rasmussen wrote:
> > > On Tue, Jun 28, 2022 at 9:41 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > On Tue, Jun 28, 2022 at 03:59:26PM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    941e3e791269 Merge tag 'for_linus' of git://git.kernel.org..
> > > > > git tree:       upstream
> > > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1670ded4080000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=9bd2b7adbd34b30b87e4
> > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140f9ba8080000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15495188080000
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
> > > > >
> > > >
> > > > I think this is a bug in memfd_secret.  secretmem_setattr() can race with a page
> > > > being faulted in by secretmem_fault().  Specifically, a page can be faulted in
> > > > after secretmem_setattr() has set i_size but before it zeroes out the partial
> > > > page past i_size.  memfd_secret pages aren't mapped in the kernel direct map, so
> > > > the crash occurs when the kernel tries to zero out the partial page.
> > > >
> > > > I don't know what the best solution is -- maybe a rw_semaphore protecting
> > > > secretmem_fault() and secretmem_setattr()?  Or perhaps secretmem_setattr()
> > > > should avoid the call to truncate_setsize() by not using simple_setattr(), given
> > > > that secretmem_setattr() only supports the size going from zero to nonzero.
> > >
> > > From my perspective the rw_semaphore approach sounds reasonable.
> > >
> > > simple_setattr() and the functions it calls to do the actual work
> > > isn't a tiny amount of code, it would be a shame to reimplement it in
> > > secretmem.c.
> > >
> > > For the rwsem, I guess the idea is setattr will take it for write, and
> > > fault will take it for read? Since setattr is a very infrequent
> > > operation - a typical use case is you'd do it exactly once right after
> > > opening the memfd_secret - this seems like it wouldn't make fault
> > > significantly less performant. It's also a pretty small change I
> > > think, just a few lines.
> >
> > Below is my take on adding a semaphore and making ->setattr() and ->fault()
> > mutually exclusive. It's only lightly tested so I'd appreciate if Eric
> > could give it a whirl.
> >
> > With addition of semaphore to secretmem_setattr() it seems we don't need
> > special care for size changes, just calling simple_setattr() after taking
> > the semaphore should be fine. Thoughts?
> 
> The patch below looks correct to me. I do think we still need the
> check which prevents truncating a memfd_secret with an existing
> nonzero size, though, because I think simple_setattr's way of doing
> that still BUGs in a non-racy way (rwsem doesn't help with this). The
> patch below keeps this, so maybe I'm just misinterpreting "we don't
> need special care for size changes".

It really was a question, because I was too lazy to dig into
simple_setattr() and I know you investigated it :)
 
> I haven't booted+tested it, I'll leave that to Eric since he already
> has a reproducer setup for this. But, for what it's worth, feel free
> to take:
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks!

-- 
Sincerely yours,
Mike.
