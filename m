Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7918396A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 20:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCLT0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 15:26:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56540 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgCLT0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:26:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCTSq-00AIsn-AL; Thu, 12 Mar 2020 19:25:52 +0000
Date:   Thu, 12 Mar 2020 19:25:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stefan Metzmacher <metze@samba.org>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200312192552.GK23230@ZenIV.linux.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 09:24:49AM -0700, Linus Torvalds wrote:
> Would that be basically just an AT_EMPTY_PATH kind of thing? IOW,
> you'd be able to remove a file by doing
> 
>    fd = open(path.., O_PATH);
>    unlinkat(fd, "", AT_EMPTY_PATH);
> 
> Hmm. We have _not_ allowed filesystem changes without that last
> component lookup. Of course, with our dentry model, we *can* do it,
> but this smells fairly fundamental to me.

That's a bloody bad idea.  It breeds fuckloads of corner cases, it does not
match the locking model at all and I don't want to even think of e.g.
the interplay with open-by-fhandle ("Parent?  What parent?"), etc.

Fundamentally, there are operations on objects and there are operations
on links to objects.  Mixing those is the recipe for massive headache.

> It might avoid some of the extra system calls (ie you could use
> openat2() to do the path walking part, and then
> unlinkat(AT_EMPTY_PATH) to remove it, and have a "fstat()" etc in
> between the verify that it's the right type of file or whatever - and
> you'd not need an unlinkat2() with resolve flags).
> 
> I think Al needs to ok this kind of change. Maybe you've already
> discussed it with him and I just missed it.

They have not.  And IME samba folks tend to present the set of
primitives they want without bothering to explain what do they
want to factorize that way, let alone why it should be factorized
that way...
