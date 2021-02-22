Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42822321FA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 20:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhBVTH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 14:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhBVTGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:06:49 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DBAC06178C;
        Mon, 22 Feb 2021 11:06:09 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lEGWu-00HAo8-GG; Mon, 22 Feb 2021 19:06:01 +0000
Date:   Mon, 22 Feb 2021 19:06:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     netdev@vger.kernel.org
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCHSET] making unix_bind() undo mknod on failure
Message-ID: <YDQAmH9zSsaqf+Dg@zeniv-ca.linux.org.uk>
References: <20210129131855.GA2346744@infradead.org>
 <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
 <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
 <YCwIQmsxWxuw+dnt@zeniv-ca.linux.org.uk>
 <YC86WeSTkYZqRlJY@zeniv-ca.linux.org.uk>
 <YC88acS6dN6cU1y0@zeniv-ca.linux.org.uk>
 <CAM_iQpVpJwRNKjKo3p1jFvCjYAXAY83ux09rd2Mt0hKmvx=RgQ@mail.gmail.com>
 <YDFj3OZ4DMQSqylH@zeniv-ca.linux.org.uk>
 <CAM_iQpXX7SBGgUkBUY6BEjCqJYbHAUW5Z3VtV2U=yhiw1YJr=w@mail.gmail.com>
 <YDF6Z8QHh3yw7es9@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDF6Z8QHh3yw7es9@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 09:08:56PM +0000, Al Viro wrote:

> *shrug*
> 
> If anything, __unix_complete_bind() might make a better name for that,
> with dropping ->bindlock also pulled in, but TBH I don't have sufficiently
> strong preferences - might as well leave dropping the lock to caller.
> 
> I'll post that series to netdev tonight.

	Took longer than I hoped...  Anyway, here's the current variant;
it's 5.11-based, lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git misc.af_unix

Shortlog:
Al Viro (8):
      af_unix: take address assignment/hash insertion into a new helper
      unix_bind(): allocate addr earlier
      unix_bind(): separate BSD and abstract cases
      unix_bind(): take BSD and abstract address cases into new helpers
      fold unix_mknod() into unix_bind_bsd()
      unix_bind_bsd(): move done_path_create() call after dealing with ->bindlock
      unix_bind_bsd(): unlink if we fail after successful mknod
      __unix_find_socket_byname(): don't pass hash and type separately

Diffstat:
 net/unix/af_unix.c | 186 +++++++++++++++++++++++++++--------------------------
 1 file changed, 94 insertions(+), 92 deletions(-)

The actual fix is in #7/8, the first 6 are massage in preparation to that
and #8/8 is a minor followup cleanup.  Individual patches in followups.
Please, review.
