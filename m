Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE37491017
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 19:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbiAQSKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 13:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiAQSKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:10:43 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB59C061574;
        Mon, 17 Jan 2022 10:10:43 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9WSi-002cYU-40; Mon, 17 Jan 2022 18:10:36 +0000
Date:   Mon, 17 Jan 2022 18:10:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 04:28:52PM +0000, Al Viro wrote:

> IOW, ->free_inode() is RCU-delayed part of ->destroy_inode().  If both
> are present, ->destroy_inode() will be called synchronously, followed
> by ->free_inode() from RCU callback, so you can have both - moving just
> the "finally mark for reuse" part into ->free_inode() would be OK.
> Any blocking stuff (if any) can be left in ->destroy_inode()...

BTW, we *do* have a problem with ext4 fast symlinks.  Pathwalk assumes that
strings it parses are not changing under it.  There are rather delicate
dances in dcache lookups re possibility of ->d_name contents changing under
it, but the search key is assumed to be stable.

What's more, there's a correctness issue even if we do not oops.  Currently
we do not recheck ->d_seq of symlink dentry when we dismiss the symlink from
the stack.  After all, we'd just finished traversing what used to be the
contents of a symlink that used to be in the right place.  It might have been
unlinked while we'd been traversing it, but that's not a correctness issue.

But that critically depends upon the contents not getting mangled.  If it
*can* be screwed by such unlink, we risk successful lookup leading to the
wrong place, with nothing to tell us that it's happening.  We could handle
that by adding a check to fs/namei.c:put_link(), and propagating the error
to callers.  It's not impossible, but it won't be pretty.

And that assumes we avoid oopsen on string changing under us in the first
place.  Which might or might not be true - I hadn't finished the audit yet.
Note that it's *NOT* just fs/namei.c + fs/dcache.c + some fs methods -
we need to make sure that e.g. everything called by ->d_hash() instances
is OK with strings changing right under them.  Including utf8_to_utf32(),
crc32_le(), utf8_casefold_hash(), etc.
