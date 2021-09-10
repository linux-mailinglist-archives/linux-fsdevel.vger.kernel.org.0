Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709CA406E3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 17:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhIJPgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 11:36:03 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40486 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhIJPgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:36:03 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOiW7-002vpN-NE; Fri, 10 Sep 2021 15:32:39 +0000
Date:   Fri, 10 Sep 2021 15:32:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <YTt6l9gDX+kXwtBW@zeniv-ca.linux.org.uk>
References: <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <YTtu1V1c1emiYII9@zeniv-ca.linux.org.uk>
 <75caf6d6-26d4-7146-c497-ed89b713d878@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75caf6d6-26d4-7146-c497-ed89b713d878@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 09:08:02AM -0600, Jens Axboe wrote:

> > You actually can cut it down even more - nr_segs + iov remains constant
> > all along, so you could get away with just 3 words here...  I would be
> 
> Mmm, the iov pointer remains constant? Maybe I'm missing your point, but
> the various advance functions are quite happy to increment iter->iov or
> iter->bvec, so we need to restore them. From a quick look, looks like
> iter->nr_segs is modified for advancing too.
> 
> What am I missing?

i->iov + i->nr_segs does not change - the places incrementing the former
will decrement the latter by the same amount.  So it's enough to store
either of those - the other one can be recovered by subtracting the
saved value from the current i->iov + i->nr_segs.
