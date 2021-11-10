Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D3744C224
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 14:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhKJNfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 08:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhKJNfv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:35:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA7C6611AD;
        Wed, 10 Nov 2021 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636551184;
        bh=2fOPQfcnnYGsAAsZbIczysSMHxsigaGOJywncfgF58U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aT56LUYcfryK8afAqwV7QUlb1VOXsox2IRfA9k3CQD+AbWS5WrGR5btKvGGSJw1ls
         kFhWTJ4+M8oryzYoJ2toZRmUpEUUVvY/UgV9dixyoQyLKeGu8HxPOXYfAyY8pjK0C1
         E6B6e/oPwiOypZoBEsUDC5OkTlSMrm+mkU9bP9KiJ4CWgTtNjS17BjA5xORv9hQvO6
         vA2R1gri9i/NKNOZ7ocjQy59+mN4hsXC9+Akms+CiFVvMgCjmjjX2tvvhVrq/MplG2
         6ZbhmUnzqNdRKoO5KEhCc1jpiUMoqZf5GbU82wKzu98hTjWGLqJ5FgkIKysU9v6qAN
         RqDtNznsE/6YQ==
Message-ID: <a0212b723317677e8601b3f58927eab03ef784de.camel@kernel.org>
Subject: Re: [PATCH v4 0/5] netfs, 9p, afs, ceph: Support folios, at least
 partially
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kafs-testing@auristor.com, Ilya Dryomov <idryomov@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Nov 2021 08:33:01 -0500
In-Reply-To: <163649323416.309189.4637503793406396694.stgit@warthog.procyon.org.uk>
References: <163649323416.309189.4637503793406396694.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-11-09 at 21:27 +0000, David Howells wrote:
> Here's a set of patches to convert netfs, 9p and afs to use folios and to
> provide sufficient conversion for ceph that it can continue to use the
> netfs library.  Jeff Layton is working on fully converting ceph.
> 
> This has been rebased on to the 9p merge in Linus's tree[5] so that it has
> access to both the 9p conversion to fscache and folios.
> 
> Changes
> =======
> ver #4:
>  - Detached and sent the afs symlink split patch separately.
>  - Handed the 9p netfslibisation patch off to Dominique Martinet.
>  - Added a patch to foliate page_endio().
>  - Fixed a bug in afs_redirty_page() whereby it didn't set the next page
>    index in the loop and returned too early.
>  - Simplified a check in v9fs_vfs_write_folio_locked()[4].
>  - Undid a change to afs_symlink_readpage()[4].
>  - Used offset_in_folio() in afs_write_end()[4].
>  - Rebased on 9p-folio merge upstream[5].
> 
> ver #3:
>  - Rebased on upstream as folios have been pulled.
>  - Imported a patch to convert 9p to netfslib from my
>    fscache-remove-old-api branch[3].
>  - Foliated netfslib.
> 
> ver #2:
>  - Reorder the patches to put both non-folio afs patches to the front.
>  - Use page_offset() rather than manual calculation[1].
>  - Fix folio_inode() to directly access the inode[2].
> 
> David
> 
> Link: https://lore.kernel.org/r/YST/0e92OdSH0zjg@casper.infradead.org/ [1]
> Link: https://lore.kernel.org/r/YST8OcVNy02Rivbm@casper.infradead.org/ [2]
> Link: https://lore.kernel.org/r/163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk/ [3]
> Link: https://lore.kernel.org/r/YYKa3bfQZxK5/wDN@casper.infradead.org/ [4]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f89ce84bc33330607a782e47a8b19406ed109b15 [5]
> Link: https://lore.kernel.org/r/2408234.1628687271@warthog.procyon.org.uk/ # v0
> Link: https://lore.kernel.org/r/162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/163005740700.2472992.12365214290752300378.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/163584174921.4023316.8927114426959755223.stgit@warthog.procyon.org.uk>/ # v3
> ---
> David Howells (5):
>       folio: Add a function to change the private data attached to a folio
>       folio: Add a function to get the host inode for a folio
>       folio: Add replacements for page_endio()
>       netfs, 9p, afs, ceph: Use folios
>       afs: Use folios in directory handling
> 
> 
>  fs/9p/vfs_addr.c           |  83 +++++----
>  fs/9p/vfs_file.c           |  20 +--
>  fs/afs/dir.c               | 229 ++++++++++--------------
>  fs/afs/dir_edit.c          | 154 ++++++++--------
>  fs/afs/file.c              |  68 ++++----
>  fs/afs/internal.h          |  46 ++---
>  fs/afs/write.c             | 347 ++++++++++++++++++-------------------
>  fs/ceph/addr.c             |  80 +++++----
>  fs/netfs/read_helper.c     | 165 +++++++++---------
>  include/linux/netfs.h      |  12 +-
>  include/linux/pagemap.h    |  23 ++-
>  include/trace/events/afs.h |  21 +--
>  mm/filemap.c               |  64 ++++---
>  mm/page-writeback.c        |   2 +-
>  14 files changed, 666 insertions(+), 648 deletions(-)
> 
> 
> 
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Tested-by: Dominique Martinet <asmadeus@codewreck.org>
> Tested-by: kafs-testing@auristor.com
> 

I know this already has my Tested-by, but I ran some more tests with
this series yesterday and it did fine:

(Re-)Tested-by: Jeff Layton <jlayton@kernel.org>
