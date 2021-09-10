Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0961C406631
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhIJDhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:37:23 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:59454 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhIJDhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:37:22 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOXKk-002nGL-82; Fri, 10 Sep 2021 03:36:10 +0000
Date:   Fri, 10 Sep 2021 03:36:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 09:30:03PM -0600, Jens Axboe wrote:

> > Again, we should never, ever modify the iovec (or bvec, etc.) array in
> > ->read_iter()/->write_iter()/->sendmsg()/etc. instances.  If you see
> > such behaviour anywhere, report it immediately.  Any such is a blatant
> > bug.
> 
> Yes that was wrong, the iovec is obviously const. But that really
> doesn't change the original point, which was that copying the iov_iter
> itself unconditionally would be miserable.

Might very well be true, but... won't your patch hit the reimport on
every short read?  And the cost of uaccess in there is *much* higher
than copying of 48 bytes into local variable...

Or am I misreading your patch?  Note that short reads on reaching
EOF are obviously normal - it's not a rare case at all.
