Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2252E44C434
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 16:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhKJPVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 10:21:38 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:39474 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhKJPVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:21:37 -0500
Received: by mail-ed1-f51.google.com with SMTP id r12so11961343edt.6;
        Wed, 10 Nov 2021 07:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mO3hph1YkCApcCuLSKx4NqEPJzPi9cWVsNMhXuQPk3w=;
        b=5IOrj4xgidzAdICKGA9OLjt/Es4HP4/BqeNEMST285iP2ys4EPGeyAGYJgGci0etmd
         Gvw2c3hRvQp7K55+lzqWsRBgLVn4f17WAO5TYPZqr8fBzEyBdninV6AYiBqIxc6BKqvk
         oh39HC2FfjpkXuOCH/sgEp/d4gedGb7wIMM7B9y6ok0XkYkcleQubdEgEwoCzEPt3fx5
         eJRiQvkXdWNolYt2p4d9PSDVrqauSybieGCyljYqd3ZqTsK0QS8ff/BFAznUzpGZYU9f
         BBuc23bqXTjXtZwouKe7+QY45oEncK9cfxht5SBtwiDKZCLWRHO8jxS3J8btDaeCQNiN
         BHBw==
X-Gm-Message-State: AOAM531D4OGnGw/J6rOo2GGYza+UM8UkD9bbpt0E+L12kxebpxvwjFJs
        003jW4swiulG0GUmQk5zaT5pzH9S+USyEp4r
X-Google-Smtp-Source: ABdhPJwnYjlHdTMWVCJvkQQtkFQdNPEUIsDquASVQ6Zr8+bb8R87wH69RFXVDr6LUnAG3ZStsXi84Q==
X-Received: by 2002:a17:906:538d:: with SMTP id g13mr508060ejo.62.1636557526490;
        Wed, 10 Nov 2021 07:18:46 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id mc3sm26442ejb.24.2021.11.10.07.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 07:18:44 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id d24so4716255wra.0;
        Wed, 10 Nov 2021 07:18:44 -0800 (PST)
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr627335wrx.86.1636557523979;
 Wed, 10 Nov 2021 07:18:43 -0800 (PST)
MIME-Version: 1.0
References: <163649323416.309189.4637503793406396694.stgit@warthog.procyon.org.uk>
In-Reply-To: <163649323416.309189.4637503793406396694.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Wed, 10 Nov 2021 11:18:32 -0400
X-Gmail-Original-Message-ID: <CAB9dFdvOM=QPGxNj1GpZkedd_kq9HWsc__MpUJevOGfSsNfopQ@mail.gmail.com>
Message-ID: <CAB9dFdvOM=QPGxNj1GpZkedd_kq9HWsc__MpUJevOGfSsNfopQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] netfs, 9p, afs, ceph: Support folios, at least partially
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        kafs-testing@auristor.com, Ilya Dryomov <idryomov@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 5:28 PM David Howells <dhowells@redhat.com> wrote:
>
>
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

The updated series passed our automated test suite, which is mostly
targeted afs testing, but with a framework that also relies on 9p.

So you can reapply:
Tested-by: kafs-testing@auristor.com

Marc
