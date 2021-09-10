Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753EE40661B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhIJD3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:29:06 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:59322 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJD3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:29:06 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOXCk-002n9d-In; Fri, 10 Sep 2021 03:27:54 +0000
Date:   Fri, 10 Sep 2021 03:27:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 09:22:30PM -0600, Jens Axboe wrote:
> On 9/9/21 9:11 PM, Al Viro wrote:
> > On Thu, Sep 09, 2021 at 09:05:13PM -0600, Jens Axboe wrote:
> >> On 9/9/21 8:57 PM, Al Viro wrote:
> >>> On Thu, Sep 09, 2021 at 03:19:56PM -0600, Jens Axboe wrote:
> >>>
> >>>> Not sure how we'd do that, outside of stupid tricks like copy the
> >>>> iov_iter before we pass it down. But that's obviously not going to be
> >>>> very efficient. Hence we're left with having some way to reset/reexpand,
> >>>> even in the presence of someone having done truncate on it.
> >>>
> >>> "Obviously" why, exactly?  It's not that large a structure; it's not
> >>> the optimal variant, but I'd like to see profiling data before assuming
> >>> that it'll cause noticable slowdowns.
> >>
> >> It's 48 bytes, and we have to do it upfront. That means we'd be doing it
> >> for _all_ requests, not just when we need to retry. As an example, current
> >> benchmarks are at ~4M read requests per core. That'd add ~200MB/sec of
> >> memory traffic just doing this copy.
> > 
> > Umm...  How much of that will be handled by cache?
> 
> Depends? And what if the iovec itself has been modified in the middle?
> We'd need to copy that whole thing too. It's just not workable as a
> solution.

Huh?  Why the hell would we need to copy iovecs themselves?  They are never
modified by ->read_iter()/->write_iter().

That's the whole fucking point of iov_iter - the iovec itself is made
constant, with all movable parts taken to iov_iter.

Again, we should never, ever modify the iovec (or bvec, etc.) array in
->read_iter()/->write_iter()/->sendmsg()/etc. instances.  If you see such
behaviour anywhere, report it immediately.  Any such is a blatant bug.
