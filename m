Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9393157D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 21:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhBIUkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 15:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhBIUgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:36:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD6C0698C9;
        Tue,  9 Feb 2021 12:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9PYzIG6VvFHVs429ghg6/nrJjbK9f+NrPZ9mDOkm3m8=; b=G2VJE0QJamzd2pjoFy5TzT5vj5
        4IOmM3oPj3xT/DfmsXL8I6c4PYFxhifeBzF52kpN+FLAgCUcxO84KB2tupu5TxmyB8M7qJhJEfRjQ
        UaM8c6gLmnEJkDwZnbCLQefcXUuVt8lGg73WHryoyUZPoKC2fwVBFkHofsmD5qYsSfkyLkb8jBrno
        Z9xQnZnznKPL8Uwgr3+4Jln6Ng49DoZ/2bKLhH/uRED9V7KMe5DtIoWE+s2qFeEAas6kg/6NqZHA2
        B3ppHvpyFSFXXmV30NT5F2jqMFMcY5NdcSpqLeIP/eozD3s//9Wqgpg497BVDETnqXVKEdfe9nSV+
        8Biyd4IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9ZVu-007usA-1c; Tue, 09 Feb 2021 20:21:35 +0000
Date:   Tue, 9 Feb 2021 20:21:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper
 library
Message-ID: <20210209202134.GA308988@casper.infradead.org>
References: <591237.1612886997@warthog.procyon.org.uk>
 <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:06:41AM -0800, Linus Torvalds wrote:
> So I'm looking at this early, because I have more time now than I will
> have during the merge window, and honestly, your pull requests have
> been problematic in the past.

Thanks for looking at this early.

> The PG_fscache bit waiting functions are completely crazy. The comment
> about "this will wake up others" is actively wrong, and the waiting
> function looks insane, because you're mixing the two names for
> "fscache" which makes the code look totally incomprehensible. Why
> would we wait for PF_fscache, when PG_private_2 was set? Yes, I know
> why, but the code looks entirely nonsensical.

Yeah, I have trouble with the private2 vs fscache bit too.  I've been
trying to persuade David that he doesn't actually need an fscache
bit at all; he can just increment the page's refcount to prevent it
from being freed while he writes data to the cache.

> But the thing that makes me go "No, I won't pull this", is that it has
> all the same hallmark signs of trouble that I've complained about
> before: I see absolutely zero sign of "this has more developers
> involved".

I've been involved!  I really want to get rid of the address_space
readpages op.  The only remaining users are the filesystems which
use fscache and it's hard to convert them with the old infrastructure.
I'm not 100% convinced that the new infrastructure is good, but I am
convinced that it's better than the old infrastructure.

> There's not a single ack from a VM person for the VM changes. There's
> no sign that this isn't yet another "David Howells went off alone and
> did something that absolutely nobody else cared about".

I'm pretty bad about sending R-b for patches when I've only given them
a quick once-over.  I tend to only do it for patches that I've given an
appropriately deep amount of thought to (eg almost none for spelling
fixes and days for page cache related patches).  I'll see what I feel
comfortable with for this patchset.

> See my problem? I need to be convinced that this makes sense outside
> of your world, and it's not yet another thing that will cause problems
> down the line because nobody else really ever used it or cared about
> it until we hit a snag.

My major concern is that we haven't had any feedback from Trond or Anna.
I don't know if they're just too busy or if there's something else going
on, but it'd be nice to hear something.
