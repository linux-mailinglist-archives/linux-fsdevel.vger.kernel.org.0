Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E01241DC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgHKQFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgHKQFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:05:41 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF4BC06174A;
        Tue, 11 Aug 2020 09:05:41 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5WmM-00DeT8-FM; Tue, 11 Aug 2020 16:05:34 +0000
Date:   Tue, 11 Aug 2020 17:05:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
Message-ID: <20200811160534.GL1236603@ZenIV.linux.org.uk>
References: <1842689.1596468469@warthog.procyon.org.uk>
 <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:20:24AM -0700, Linus Torvalds wrote:

> I don't think this works for the reasons Al says, but a slight
> modification might.
> 
> IOW, if you do something more along the lines of
> 
>        fd = open(""foo/bar", O_PATH);
>        metadatafd = openat(fd, "metadataname", O_ALT);
> 
> it might be workable.
> 
> So you couldn't do it with _one_ pathname, because that is always
> fundamentally going to hit pathname lookup rules.
> 
> But if you start a new path lookup with new rules, that's fine.

Except that you suddenly see non-directory dentries get children.
And a lot of dcache-related logics needs to be changed if that
becomes possible.

I agree that xattrs are garbage, but this approach won't be
a straightforward solution.  Can those suckers be passed to
...at() as starting points?  Can they be bound in namespace?
Can something be bound *on* them?  What do they have for inodes
and what maintains their inumbers (and st_dev, while we are at
it)?  Can _they_ have secondaries like that (sensu Swift)?
Is that a flat space, or can they be directories?

Only a part of the problems is implementation-related (and those are
not trivial at all); most the fun comes from semantics of those things.
And answers to the implementation questions are seriously dependent upon
that...
