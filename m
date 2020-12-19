Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303662DEFD3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 14:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgLSN0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 08:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgLSN0C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 08:26:02 -0500
Message-ID: <f622563d89515a834c299a07012f500e4c026e98.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608384321;
        bh=AbZt8MrTsW6gktMQu+ojm4NdA+G7zkkOnPh4A6KAkrY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R6BT2ihI9U266xqn5Nxmpkrr1hTGL3fTriEnsMyiHjYNjQQR2pRPHEchnk0eCEAWF
         ScfPRuWLUi8zc++MviNSi7zElY0HBjsY0WoBSiSiBk47e1OPocH39KDU3qHtA6C2Uj
         B0ZZyDXGvoWISkP8cqnEqOzdq46T0WsgsfCO0pGQvAV1RE3svjVqu7MrIrqJVZSZJR
         QlZzDs0LU2JIk/JG22rzzm2vHKDNP+WTNc45abFw43u2yWt4nDo1OyujGAeAvLjvjt
         TR4WqkfoCY/VgS4KDKH5VzKfnZnTtnRuqoWqrrEp5R3+WPr2TTKAYg3wbXZny34h4F
         lC7FdJerDQvow==
Subject: Re: [PATCH v3] errseq: split the ERRSEQ_SEEN flag into two new flags
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Date:   Sat, 19 Dec 2020 08:25:19 -0500
In-Reply-To: <f84f3259d838f132029576b531d81525abd4e1b8.camel@kernel.org>
References: <20201217150037.468787-1-jlayton@kernel.org>
         <20201219061331.GQ15600@casper.infradead.org>
         <f84f3259d838f132029576b531d81525abd4e1b8.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-12-19 at 07:53 -0500, Jeff Layton wrote:
> On Sat, 2020-12-19 at 06:13 +0000, Matthew Wilcox wrote:
> > On Thu, Dec 17, 2020 at 10:00:37AM -0500, Jeff Layton wrote:
> > > Overlayfs's volatile mounts want to be able to sample an error for their
> > > own purposes, without preventing a later opener from potentially seeing
> > > the error.
> > 
> > umm ... can't they just copy the errseq_t they're interested in, followed
> > by calling errseq_check() later?
> > 
> 
> They don't want the sampling for the volatile mount to prevent later
> openers from seeing an error that hasn't yet been reported.
> 
> If they copy the errseq_t (or just do an errseq_sample), and then follow
> it with a errseq_check_and_advance then the SEEN bit will end up being
> set and a later opener wouldn't see the error.
> 
> Aside from that though, I think this patch clarifies things a bit since
> the SEEN flag currently means two different things:
> 
> 1/ do I need to increment the counter when recording another error?
> 
> 2/ do I need to report this error to new samplers (at open time)
> 
> That was ok before, since we those conditions were always changed
> together, but with the overlayfs volatile mount use-case, it no longer
> does.
> 
> > actually, isn't errseq_check() buggy in the face of multiple
> > watchers?  consider this:
> > 
> > worker.es starts at 0
> > t2.es = errseq_sample(&worker.es)
> > errseq_set(&worker.es, -EIO)
> > t1.es = errseq_sample(&worker.es)
> > t2.err = errseq_check_and_advance(&es, t2.es)
> > 	** this sets ERRSEQ_SEEN **
> > t1.err = errseq_check(&worker.es, t1.es)
> > 	** reports an error, even though the only change is that
> > 	   ERRSEQ_SEEN moved **.
> > 
> > i think errseq_check() should be:
> > 
> > 	if (likely(cur | ERRSEQ_SEEN) == (since | ERRSEQ_SEEN))
> > 		return 0;
> > 
> > i'm not yet convinced other changes are needed to errseq.  but i am
> > having great trouble understanding exactly what overlayfs is trying to do.
> 
> I think you're right on errseq_check. I'll plan to do a patch to fix
> that up as well.
> 

I take it back. This isn't a problem for a couple of (non-obvious)
reasons:

1/ any "real" sample will either have the SEEN bit set or be 0. In the
first case, errseq_check will return true (which is correct). In the
second any change from what you sampled will have to have been a
recorded error.

2/ ...but even if that weren't the case and you got a false positive
from errseq_check, all of the existing callers call
errseq_check_and_advance just afterward, which handles this correctly.

Either way, splitting the flag in two means that we do need to take the
flag bits into account, so errseq_same masks them off before comparing.

> I too am having a bit of trouble understanding all of the nuances here.
> My current understanding is that it depends on the "volatility" of the
> mount:
> 
> normal (non-volatile): they basically want to be able to track errors as
> if the files were being opened on the upper layer. For this case I think
> they should aim to just do all of the error checking against the upper
> sb and ignore the overlayfs s_wb_err field. This does mean pushing the
> errseq_check_and_advance down into the individual filesystems in some
> fashion though.
> 
> volatile: they want to sample at mount time and always return an error
> to syncfs if there has been another error since the original sample
> point. This sampling should also not affect later openers on the upper
> layer (or on other overlayfs mounts).
> 
> I'm not 100% clear on whether I understand both use-cases correctly
> though.

-- 
Jeff Layton <jlayton@kernel.org>

