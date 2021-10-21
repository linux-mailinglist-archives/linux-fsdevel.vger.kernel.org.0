Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20B0436E7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 01:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhJUXpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 19:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhJUXpu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:45:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7B706120C;
        Thu, 21 Oct 2021 23:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634859814;
        bh=LE+sfzEXJlFl8jCsBBJvLQfsmo8JPatvzUNz5xSZVrk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TgMVshk590paFQtbeK7zsyr4l/2uZp8+iGE+Is7GOaqOs2fjIWdb1db0zUOZCD1D/
         qSIki3hnjNZxvH7hMUKP6OCN5hbiVGAv2XjSk4Vu4n2Brz1rBVrshn8bHukAQnfRRv
         anWSmxVujkZB4+3Vgc3zvaFf1bGC7CzMWQKe6CW34pKn5QSZJPQUjgeysNPUEJswMd
         t7htnv6dWAlApcY9+r9kUWKJKLIl3BAtQDDX9NUsRBx84qp+9TOpGx1yTzQZkj0kpU
         RPr0UXaSlLtDfKfBNDv1hq7rgvpN1ibPs6YRxvIs06BNymtP6Gi5hn9pZzMvTMTSzN
         l5WRtdh7ClJ1A==
Message-ID: <d70b28fb4392ac1aafb1b21d1b8da061be16104c.camel@kernel.org>
Subject: Re: [PATCH 00/67] fscache: Rewrite index API and management system
From:   Jeff Layton <jlayton@kernel.org>
To:     Steve French <smfrench@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        CIFS <linux-cifs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Steve French <sfrench@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Oct 2021 19:43:30 -0400
In-Reply-To: <CAH2r5msO7-QCXv6JQj2Tado9ZoWAHRkgq6-En18PeKSXFDdBLw@mail.gmail.com>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
         <YXHntB2O0ACr0pbz@relinquished.localdomain>
         <CAH2r5msO7-QCXv6JQj2Tado9ZoWAHRkgq6-En18PeKSXFDdBLw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-10-21 at 18:15 -0500, Steve French wrote:
> On Thu, Oct 21, 2021 at 5:21 PM Omar Sandoval <osandov@osandov.com> wrote:
> > 
> > On Mon, Oct 18, 2021 at 03:50:15PM +0100, David Howells wrote:
> > However, with the advent of the tmpfile capacity in the VFS, an opportunity
> > arises to do invalidation much more easily, without having to wait for I/O
> > that's actually in progress: Cachefiles can simply cut over its file
> > pointer for the backing object attached to a cookie and abandon the
> > in-progress I/O, dismissing it upon completion.
> 
> Have changes been made to O_TMPFILE?  It is problematic for network filesystems
> because it is not an atomic operation, and would be great if it were possible
> to create a tmpfile and open it atomically (at the file system level).
> 
> Currently it results in creating a tmpfile (which results in
> opencreate then close)
> immediately followed by reopening the tmpfile which is somewhat counter to
> the whole idea of a tmpfile (ie that it is deleted when closed) since
> the syscall results
> in two opens ie open(create)/close/open/close
> 
> 

In this case, O_TMPFILE is being used on the cachefiles backing store,
and that usually isn't deployed on a netfs. That said, Steve does have a
good point...

What happens if you do end up without O_TMPFILE support on the backing
store? Probably just opting to not cache in that case is fine. Does
cachefiles just shut down in that situation?
-- 
Jeff Layton <jlayton@kernel.org>

