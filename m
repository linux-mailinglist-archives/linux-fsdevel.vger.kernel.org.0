Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ABB406DBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhIJOsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 10:48:05 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:39848 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhIJOsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:48:04 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOhjZ-002vI7-Qg; Fri, 10 Sep 2021 14:42:29 +0000
Date:   Fri, 10 Sep 2021 14:42:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <YTtu1V1c1emiYII9@zeniv-ca.linux.org.uk>
References: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 07:57:49AM -0600, Jens Axboe wrote:

> It was just a quick hack, might very well be too eager to go through
> those motions. But pondering this instead of sleeping, we don't need to
> copy all of iov_iter in order to restore the state, and we can use the
> same advance after restoring. So something like this may be more
> palatable. Caveat - again untested, and I haven't tested the performance
> impact of this at all.

You actually can cut it down even more - nr_segs + iov remains constant
all along, so you could get away with just 3 words here...  I would be
surprised if extra memory traffic had shown up - it's well within the
noise from register spills, (un)inlining, etc.  We are talking about
3 (or 4, with your variant) extra words on one stack frame (and that'd
be further offset by removal of ->truncated); I'd still like to see the
profiling data, but concerns about extra memory traffic due to that
are, IMO, misplaced.
