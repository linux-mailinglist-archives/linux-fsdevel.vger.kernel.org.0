Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5D31391
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfEaRMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 13:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfEaRMv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 13:12:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C2FA85365;
        Fri, 31 May 2019 17:12:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B5C958CA2;
        Fri, 31 May 2019 17:12:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190531164444.GD2606@hirez.programming.kicks-ass.net>
References: <20190531164444.GD2606@hirez.programming.kicks-ass.net> <CAG48ez0R-R3Xs+3Xg9T9qcV3Xv6r4pnx1Z2y=Ltx7RGOayte_w@mail.gmail.com> <20190528162603.GA24097@kroah.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk> <4031.1559064620@warthog.procyon.org.uk> <20190528231218.GA28384@kroah.com> <31936.1559146000@warthog.procyon.org.uk> <16193.1559163763@warthog.procyon.org.uk> <21942.1559304135@warthog.procyon.org.uk> <606.1559312412@warthog.procyon.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dhowells@redhat.com, Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15400.1559322762.1@warthog.procyon.org.uk>
Date:   Fri, 31 May 2019 18:12:42 +0100
Message-ID: <15401.1559322762@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 31 May 2019 17:12:51 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:

> > > (and it has already been established that refcount_t doesn't work for
> > > usage count scenarios)
> > 
> > ?
> > 
> > Does that mean struct kref doesn't either?
> 
> Indeed, since kref is just a pointless wrapper around refcount_t it does
> not either.
> 
> The main distinction between a reference count and a usage count is that
> 0 means different things. For a refcount 0 means dead. For a usage count
> 0 is merely unused but valid.

Ah - I consider the terms interchangeable.

Take Documentation/filesystems/vfs.txt for instance:

  dget: open a new handle for an existing dentry (this just increments
	the usage count)

  dput: close a handle for a dentry (decrements the usage count). ...

  ...

  d_lookup: look up a dentry given its parent and path name component
	It looks up the child of that given name from the dcache
	hash table. If it is found, the reference count is incremented
	and the dentry is returned. The caller must use dput()
	to free the dentry when it finishes using it.

Here we interchange the terms.

Or https://www.kernel.org/doc/gorman/html/understand/understand013.html
which seems to interchange the terms in reference to struct page.

David
