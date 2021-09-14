Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAEA40B327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhINPcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 11:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234425AbhINPca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631633472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=28uHVFlIgd259Tk0Onl6nVW85p5Wip9eeWyZFWWQ7Gw=;
        b=ImrDIv+I+29ylSFtfMfosmc9PO4/0ApDWaDK2EA4JyLUVy0ndfEOO6By9+NL0REIZ2gkPH
        LIUUalgIaQO3nPi/H934Cp53BHfX6BA0goOsgdl475FxTLWRm+ZnKNoM0w/lVpfypGsYJ8
        I+n7Nt2usp3sPIOly19JWa2/h5i36Ng=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-fqkAVwqoPTyPMbJwArhz0Q-1; Tue, 14 Sep 2021 11:31:11 -0400
X-MC-Unique: fqkAVwqoPTyPMbJwArhz0Q-1
Received: by mail-ed1-f71.google.com with SMTP id e7-20020aa7d7c7000000b003d3e6df477cso889674eds.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 08:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28uHVFlIgd259Tk0Onl6nVW85p5Wip9eeWyZFWWQ7Gw=;
        b=ORHEmTERIs/NF48ccb+CO5HlLbFM8vXu1jQA59UytUGPRDleXSxTOjzN3iBVuL3YWH
         Vga2niIPcIm8vVKCQrbJpWhtTGmuqLBwyYVhZSFUXK3Bd94Si6/vltY6YtQc58AHqvcf
         4WnvnLfDdlxrJGQiqMnhwtZgNr0p5eOo+HA5y5YSJcXEk5toa5IrJ8vpehJUOUuLEYvI
         kRB5Ivv8UOcvUcW01xg0wBFynek4ca1xFLc9HmSFH1b8ymN2G+olPpEGj4kX+fAAh2F/
         CiabHwNcjfxo/DcsS21o0ZS89uTmbovg68w77gUKiSW98WYx1Nzda76EQXfgMc6XE/Qa
         /3Ww==
X-Gm-Message-State: AOAM5307fLxlO+hhPjgFrn9qpDEpkO/5EZ1fyWlEckRW7xufAgIHYhL+
        BmRw5MQMIulR82YBMXtc3hUitorVvxKuwbPGM8NQVX5RINmsF6vKyOiBQnkHq6l4Gq3jqnlQsWF
        E7MG8rY767WaKJHK1v1XUg1VMCSt7w7yxVS/e7+LX6g==
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr19741339ejc.119.1631633467789;
        Tue, 14 Sep 2021 08:31:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBCsPMH/stPuTNHWIjWdIDFCeRDqb2JZpOnn0wdJ4EAfdOma5ARu4H6YXdUtlU3P33pyF7rZaoQLtYtlKQ92E=
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr19741147ejc.119.1631633465397;
 Tue, 14 Sep 2021 08:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
In-Reply-To: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 14 Sep 2021 11:30:29 -0400
Message-ID: <CALF+zO=VHPzcp0A0KxpYW-0WnyxvM5gW5HmorzrMJ_arxxBchA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fscache: Replace and remove old I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 9:55 AM David Howells <dhowells@redhat.com> wrote:
>
>
> Here's a set of patches that removes the old fscache I/O API by the following
> means:
>
>  (1) A simple fallback API is added that can read or write a single page
>      synchronously.  The functions for this have "deprecated" in their names
>      as they have to be removed at some point.
>
>  (2) An implementation of this is provided in cachefiles.  It creates a kiocb
>      to use DIO to the backing file rather than calling readpage on the
>      backing filesystem page and then snooping the page wait queue.
>
>  (3) NFS is switched to use the fallback API.
>
>  (4) CIFS is switched to use the fallback API also for the moment.
>
>  (5) 9P is switched to using netfslib.
>
>  (6) The old I/O API is removed from fscache and the page snooping
>      implementation is removed from cachefiles.
>
> The reasons for doing this are:
>
>  (A) Using a kiocb to do asynchronous DIO from/to the pages of the backing
>      file is now a possibility that didn't exist when cachefiles was created.
>      This is much simpler than the snooping mechanism with a proper callback
>      path and it also requires fewer copies and less memory.
>
>  (B) We have to stop using bmap() or SEEK_DATA/SEEK_HOLE to work out what
>      blocks are present in the backing file is dangerous and can lead to data
>      corruption if the backing filesystem can insert or remove blocks of zeros
>      arbitrarily in order to optimise its extent list[1].
>
>      Whilst this patchset doesn't fix that yet, it does simplify the code and
>      the fix for that can be made in a subsequent patchset.
>
>  (C) In order to fix (B), the cache will need to keep track itself of what
>      data is present.  To make this easier to manage, the intention is to
>      increase the cache block granularity to, say, 256KiB - importantly, a
>      size that will span multiple pages - which means the single-page
>      interface will have to go away.  netfslib is designed to deal with
>      that on behalf of a filesystem, though a filesystem could use raw
>      cache calls instead and manage things itself.
>
> These patches can be found also on:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter-3
>
> David
>
> Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
> ---
> David Howells (8):
>       fscache: Generalise the ->begin_read_operation method
>       fscache: Implement an alternate I/O interface to replace the old API
>       nfs: Move to using the alternate (deprecated) fscache I/O API
>       9p: (untested) Convert to using the netfs helper lib to do reads and caching
>       cifs: (untested) Move to using the alternate (deprecated) fscache I/O API
>       fscache: Remove the old I/O API
>       fscache: Remove stats that are no longer used
>       fscache: Update the documentation to reflect I/O API changes
>
>
>  .../filesystems/caching/backend-api.rst       |  138 +--
>  .../filesystems/caching/netfs-api.rst         |  386 +-----
>  fs/9p/Kconfig                                 |    1 +
>  fs/9p/cache.c                                 |  137 ---
>  fs/9p/cache.h                                 |   98 +-
>  fs/9p/v9fs.h                                  |    9 +
>  fs/9p/vfs_addr.c                              |  174 ++-
>  fs/9p/vfs_file.c                              |   21 +-
>  fs/cachefiles/Makefile                        |    1 -
>  fs/cachefiles/interface.c                     |   15 -
>  fs/cachefiles/internal.h                      |   38 -
>  fs/cachefiles/io.c                            |   28 +-
>  fs/cachefiles/main.c                          |    1 -
>  fs/cachefiles/rdwr.c                          |  972 ---------------
>  fs/cifs/file.c                                |   64 +-
>  fs/cifs/fscache.c                             |  105 +-
>  fs/cifs/fscache.h                             |   74 +-
>  fs/fscache/cache.c                            |    6 -
>  fs/fscache/cookie.c                           |   10 -
>  fs/fscache/internal.h                         |   58 +-
>  fs/fscache/io.c                               |  140 ++-
>  fs/fscache/object.c                           |    2 -
>  fs/fscache/page.c                             | 1066 -----------------
>  fs/fscache/stats.c                            |   73 +-
>  fs/nfs/file.c                                 |   14 +-
>  fs/nfs/fscache-index.c                        |   26 -
>  fs/nfs/fscache.c                              |  161 +--
>  fs/nfs/fscache.h                              |   84 +-
>  fs/nfs/read.c                                 |   25 +-
>  fs/nfs/write.c                                |    7 +-
>  include/linux/fscache-cache.h                 |  131 --
>  include/linux/fscache.h                       |  418 ++-----
>  include/linux/netfs.h                         |   17 +-
>  33 files changed, 508 insertions(+), 3992 deletions(-)
>  delete mode 100644 fs/cachefiles/rdwr.c
>
>

I tested an earlier version of these with NFS, which identified a
couple issues which you fixed.  Last I checked my unit tests and
xfstests were looking good. I'll do some testing on this latest branch
/ patches and report back.

