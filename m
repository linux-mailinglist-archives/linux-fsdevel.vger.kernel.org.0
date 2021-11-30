Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B23463B78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 17:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbhK3QSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 11:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbhK3QSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:18:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5CC061746;
        Tue, 30 Nov 2021 08:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E095B81A55;
        Tue, 30 Nov 2021 16:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB047C53FC1;
        Tue, 30 Nov 2021 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638288913;
        bh=P8o3xJoZ9GulqCm3by9ySAYZOhiX00eAxdialhufxvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OetwOYtBIbikZ7LhnB77SBsvM18Jm92Lg+sWp1Bvq5NVYWIn707PetzCzKVQF1gBH
         hNp2rvzS0GtDyA/Bx2OpdVp0YnKbr+LEQ2zKIXjGaHGVfTHD1CNhgpEYU5J9PMG+00
         IhCpzigsWUjK+JLVGt8LYCrs8x0B/a3b9CCnAQG4P6L7x38XQJ+PGJ+UkP6cuKfFtQ
         +w7m1GQzxL2JB1Iyi/KFgpyMccj7+60rXdqdDGz77eXCn910146xaAcM4AoJcraRc7
         1HbdNXcgXI29uQxAK6lwOENIPqHsaiCEzKVtpoMFZ7seIi08nc1OU1mWsQlaTVmu5o
         8Enk0P0netdMA==
Date:   Tue, 30 Nov 2021 09:15:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 51/64] cachefiles: Implement the I/O routines
Message-ID: <YaZOCk9zxApPattb@archlinux-ax161>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
 <163819647945.215744.17827962047487125939.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163819647945.215744.17827962047487125939.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 02:34:39PM +0000, David Howells wrote:
> Implement the I/O routines for cachefiles.  There are two sets of routines
> here: preparation and actual I/O.
> 
> Preparation for read involves looking to see whether there is data present,
> and how much.  Netfslib tells us what it wants us to do and we have the
> option of adjusting shrinking and telling it whether to read from the
> cache, download from the server or simply clear a region.
> 
> Preparation for write involves checking for space and defending against
> possibly running short of space, if necessary punching out a hole in the
> file so that we don't leave old data in the cache if we update the
> coherency information.
> 
> Then there's a read routine and a write routine.  They wait for the cookie
> state to move to something appropriate and then start a potentially
> asynchronous direct I/O operation upon it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com

This patch as commit 0443b01eccbb ("cachefiles: Implement the I/O
routines") in -next causes the following clang warning/error:

fs/cachefiles/io.c:489:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (pos == 0)
            ^~~~~~~~
fs/cachefiles/io.c:492:6: note: uninitialized use occurs here
        if (ret < 0) {
            ^~~
fs/cachefiles/io.c:489:2: note: remove the 'if' if its condition is always true
        if (pos == 0)
        ^~~~~~~~~~~~~
fs/cachefiles/io.c:440:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 error generated.

It is the same one that has been reported two other times over the past
two months:

https://lore.kernel.org/r/202110150048.HPNa2Mn7-lkp@intel.com/
https://lore.kernel.org/r/202111070451.bsfAyznx-lkp@intel.com/

Should ret just be initialized to zero or does it need to be set to
something else if pos is not equal to zero at the end?

Cheers,
Nathan
