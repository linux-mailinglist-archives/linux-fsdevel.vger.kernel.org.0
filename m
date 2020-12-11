Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E602D6D9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 02:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbgLKBcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 20:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389890AbgLKBbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:31:43 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE565C0613D6;
        Thu, 10 Dec 2020 17:31:03 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knXGn-000SL0-2o; Fri, 11 Dec 2020 01:30:53 +0000
Date:   Fri, 11 Dec 2020 01:30:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
Message-ID: <20201211013053.GA107834@ZenIV.linux.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 21, 2020 at 10:21:17AM -0800, Linus Torvalds wrote:
> So I think conceptually this is the right thing to do, but I have a
> couple of worries:
> 
>  - do we really need all those different versions? I'm thinking
> "iter_full" versions in particular. They I think the iter_full version
> could just be wrappers that call the regular iter thing and verify the
> end result is full (and revert if not). No?

Umm...  Not sure - iov_iter_revert() is not exactly light.  OTOH, it's
on a slow path...  Other variants:
	* save local copy, run of normal variant on iter, then copy
the saved back on failure
	* make a local copy, run the normal variant in _that_, then
copy it back on success.

Note that the entire thing is 5 words, and we end up reading all of
them anyway, so I wouldn't bet which variant ends up being faster -
that would need testing to compare.

I would certainly like to get rid of the duplication there, especially
if we are going to add copy_to_iter_full() and friends (there are
use cases for those).

>  - I worry a bit about the indirect call overhead and spectre v2.
> 
>    So yeah, it would be good to have benchmarks to make sure this
> doesn't regress for some simple case.
> 
> Other than those things, my initial reaction is "this does seem cleaner".

It does seem cleaner, all right, but that stuff is on fairly hot paths.
And I didn't want to mix the overhead of indirect calls into the picture,
so it turned into cascades of ifs with rather vile macros to keep the
size down.

It looks like the cost of indirects is noticable.  OTOH, there are
other iov_iter patches floating around, hopefully getting better
code generation.  Let's see how much do those give and if they win
considerably more than those several percents, revisit this series.
