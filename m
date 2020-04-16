Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A611AC660
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgDPOim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 10:38:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34735 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392865AbgDPODz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587045832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqNWTV6ibWHAYecuUg/f0mQYawS204pEjfXNqmocQ9E=;
        b=ROO4P0kLBKrBYxVyx2xq91s6j45HyGKZX/RrDyfbic/4yaEV487CiFJFd/HL59G+IsTY7o
        Xr88KmXgLQtD+BafzLPAjoILqbcvKFfM23zgCTNXxEuQNBKK8yzPi8yvn/7IZwKM+QTXX3
        JAcrP7govqGcYpHERApPnsLFEzchxos=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-EIRHOlcjPGawr2hvxywR4g-1; Thu, 16 Apr 2020 10:03:47 -0400
X-MC-Unique: EIRHOlcjPGawr2hvxywR4g-1
Received: by mail-qk1-f199.google.com with SMTP id p8so18676353qkp.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 07:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqNWTV6ibWHAYecuUg/f0mQYawS204pEjfXNqmocQ9E=;
        b=oSu6J/9Xym1nD7GjILdCbIzRQXYDAnmoeBdaz4jXpnefqhjC6SXOePfmRiuUAVSIvb
         juwYcPVglWAS+qfn1VdqmNA/ZLnzhXIsg53BXJD6fASegQCFraqe/X1moYZ0CQHjt5dA
         uyBnM4XedItUvxiZsoTLWhR4pcpxxtf9HLGW/oM1bhwa5amnR9y9yh4IF57dTa+K7yeg
         2KVIwFQFcBKvbHdO3/yvxCiEG39wPiVl2MuLKFz6y6Vmo6DSpa7ZgKLB0QMDBeGOXbYk
         L4+shQPHVHunYoc5JOez5hNan/0NgBEfBHG52OO1u2STOA7DxCdnmSK1w29YY8HA67Zj
         npaQ==
X-Gm-Message-State: AGi0PuYCahSa5auxAqviuocRLB82bjTca24tY2/6U80/3ctEkMhx6VNa
        wVkrqZoaDRw1wUt4ciWTaNJZL6bFIdtmVGu1l0mDm+ZKmyhtev1xuvvNRwcQ5ges8eLqGqRs2+R
        EaQuXmbc+5QPq8YxQ8SChUQvLxe8DLSqxdfiA7y8o5A==
X-Received: by 2002:a37:9a10:: with SMTP id c16mr19346933qke.315.1587045826445;
        Thu, 16 Apr 2020 07:03:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypIOGaB6XGMi+S5WCvthl1W3PtQu0I7MzsD1dN7WOwFfSIONcLsNF8ssYTL8FncJRF+6rTCfkeJhsdcRefOo53g=
X-Received: by 2002:a37:9a10:: with SMTP id c16mr19346886qke.315.1587045826052;
 Thu, 16 Apr 2020 07:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200109133045.382356-1-cmaiolino@redhat.com> <20200109133045.382356-3-cmaiolino@redhat.com>
 <87tv1tv6qt.fsf@notabene.neil.brown.name>
In-Reply-To: <87tv1tv6qt.fsf@notabene.neil.brown.name>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 16 Apr 2020 10:03:09 -0400
Message-ID: <CALF+zOnvtSHs7eyHt9igqu3z2MUPnggLyf2Ar7Z9ps+PjXkKGg@mail.gmail.com>
Subject: Re: [PATCH 2/5] cachefiles: drop direct usage of ->bmap method.
To:     NeilBrown <neilb@suse.de>
Cc:     Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 8, 2020 at 8:32 PM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, Jan 09 2020, Carlos Maiolino wrote:
>
> > Replace the direct usage of ->bmap method by a bmap() call.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> >  fs/cachefiles/rdwr.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
> > index 44a3ce1e4ce4..1dc97f2d6201 100644
> > --- a/fs/cachefiles/rdwr.c
> > +++ b/fs/cachefiles/rdwr.c
> > @@ -396,7 +396,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
> >       struct cachefiles_object *object;
> >       struct cachefiles_cache *cache;
> >       struct inode *inode;
> > -     sector_t block0, block;
> > +     sector_t block;
> >       unsigned shift;
> >       int ret;
> >
> > @@ -412,7 +412,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
> >
> >       inode = d_backing_inode(object->backer);
> >       ASSERT(S_ISREG(inode->i_mode));
> > -     ASSERT(inode->i_mapping->a_ops->bmap);
> >       ASSERT(inode->i_mapping->a_ops->readpages);
> >
> >       /* calculate the shift required to use bmap */
> > @@ -428,12 +427,14 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
> >        *   enough for this as it doesn't indicate errors, but it's all we've
> >        *   got for the moment
> >        */
> > -     block0 = page->index;
> > -     block0 <<= shift;
> > +     block = page->index;
> > +     block <<= shift;
> > +
> > +     ret = bmap(inode, &block);
> > +     ASSERT(ret < 0);
> >

I too am hitting this assert with a very simple test (see below) and I
saw ret == *block == 0
This used to fall through and be handled in 'else if / else'

        if (block) {
                /* submit the apparently valid page to the backing fs to be
                 * read from disk */
                ret = cachefiles_read_backing_file_one(object, op, page);
        } else if (cachefiles_has_space(cache, 0, 1) == 0) {
                /* there's space in the cache we can use */
                fscache_mark_page_cached(op, page);
                fscache_retrieval_complete(op, 1);
                ret = -ENODATA;
        } else {
                goto enobufs;
        }


Test:
systemctl start cachefilesd
mount -o vers=3,fsc 127.0.0.1:/export /mnt
dd if=/dev/zero of=/mnt/file1.bin bs=1M count=1
echo 3 > /proc/sys/vm/drop_caches
dd if=/mnt/file1.bin of=/dev/null
echo 3 > /proc/sys/vm/drop_caches
dd if=/mnt/file1.bin of=/dev/null

FWIW, the below is 5.7-rc1 kernel plus the 3 patches I posted to linux-nfs

[ 1613.017827] readahead_oops. (8973): drop_caches: 3
[ 1613.100768] readahead_oops. (8973): drop_caches: 3
[ 1613.126040] CacheFiles:
[ 1613.127317] CacheFiles: Assertion failed
[ 1613.129130] ------------[ cut here ]------------
[ 1613.130901] kernel BUG at fs/cachefiles/rdwr.c:434!
[ 1613.132856] invalid opcode: 0000 [#1] SMP PTI
[ 1613.134590] CPU: 3 PID: 9010 Comm: dd Kdump: loaded Not tainted
5.7.0-rc1-bz1790933-bz1793560-fix3+ #13
[ 1613.138250] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[ 1613.140544] RIP:
0010:cachefiles_read_or_alloc_page.cold+0x25c/0x361 [cachefiles]
[ 1613.143466] Code: 4c 89 c1 e8 05 05 97 c0 4c 8b 44 24 08 e9 b0 bb
ff ff 48 c7 c7 09 57 7d c0 e8 ef 04 97 c0 48 c7 c7 60 6c 7d c0 e8 e3
04 97 c0 <0f> 0b 48 c7 c7 09 57 7d c0 e8 d5 04 97 c0 48 c7 c7 60 6c 7d
c0 e8
[ 1613.188264] RSP: 0018:ffffa13d00527c40 EFLAGS: 00010246
[ 1613.190334] RAX: 000000000000001c RBX: ffff8e8533290600 RCX: 0000000000000000
[ 1613.193104] RDX: 0000000000000000 RSI: ffff8e8537cd9c28 RDI: ffff8e8537cd9c28
[ 1613.195875] RBP: ffff8e852c42ea80 R08: 000000000000028c R09: 000000000000002b
[ 1613.198698] R10: ffffa13d00527af0 R11: 0000000000000000 R12: 0000000000000000
[ 1613.201513] R13: ffffdc5b05673700 R14: ffff8e8526636c00 R15: ffff8e8533290668
[ 1613.204311] FS:  00007f45a30c7580(0000) GS:ffff8e8537cc0000(0000)
knlGS:0000000000000000
[ 1613.207470] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1613.209724] CR2: 000055c636d58000 CR3: 00000002331d2000 CR4: 00000000000406e0
[ 1613.212513] Call Trace:
[ 1613.213624]  __fscache_read_or_alloc_page+0x2a5/0x320 [fscache]
[ 1613.215999]  __nfs_readpage_from_fscache+0x49/0xf0 [nfs]
[ 1613.218128]  nfs_readpage+0xf8/0x260 [nfs]
[ 1613.219805]  generic_file_read_iter+0x6f3/0xe40
[ 1613.221639]  ? nfs3_proc_commit_setup+0x10/0x10 [nfsv3]
[ 1613.223726]  ? nfs_check_cache_invalid+0x33/0x90 [nfs]
[ 1613.225784]  nfs_file_read+0x6d/0xa0 [nfs]
[ 1613.227464]  new_sync_read+0x12a/0x1c0
[ 1613.228981]  vfs_read+0x9d/0x150
[ 1613.230295]  ksys_read+0x5f/0xe0
[ 1613.231624]  do_syscall_64+0x5b/0x1c0
[ 1613.233180]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1613.235191] RIP: 0033:0x7f45a2fef3e2





> > -     block = inode->i_mapping->a_ops->bmap(inode->i_mapping, block0);
> >       _debug("%llx -> %llx",
> > -            (unsigned long long) block0,
> > +            (unsigned long long) (page->index << shift),
> >              (unsigned long long) block);
> >
> >       if (block) {
> > @@ -711,7 +712,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
> >
> >       inode = d_backing_inode(object->backer);
> >       ASSERT(S_ISREG(inode->i_mode));
> > -     ASSERT(inode->i_mapping->a_ops->bmap);
> >       ASSERT(inode->i_mapping->a_ops->readpages);
> >
> >       /* calculate the shift required to use bmap */
> > @@ -728,7 +728,7 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
> >
> >       ret = space ? -ENODATA : -ENOBUFS;
> >       list_for_each_entry_safe(page, _n, pages, lru) {
> > -             sector_t block0, block;
> > +             sector_t block;
> >
> >               /* we assume the absence or presence of the first block is a
> >                * good enough indication for the page as a whole
> > @@ -736,13 +736,14 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
> >                *   good enough for this as it doesn't indicate errors, but
> >                *   it's all we've got for the moment
> >                */
> > -             block0 = page->index;
> > -             block0 <<= shift;
> > +             block = page->index;
> > +             block <<= shift;
> > +
> > +             ret = bmap(inode, &block);
> > +             ASSERT(!ret);
>
> Hi,
>  this change corrupts 'ret'.
>  Some paths from here down change ret, but some paths to do not.
>  So it is possible that this function would previously return -ENODATA
>  or -ENOBUFS, but now it returns 0.
>
>  This gets caught by a BUG_ON in __nfs_readpages_from_fscache().
>
>  Maybe a new variable should be introduced?
>  or maybe ASSERT(!bmap(..));
>  Or maybe if (bmap() != 0) ASSET(0);
>
> ??
>
> https://bugzilla.opensuse.org/show_bug.cgi?id=1168841
>
> NeilBrown
>
>
> >
> > -             block = inode->i_mapping->a_ops->bmap(inode->i_mapping,
> > -                                                   block0);
> >               _debug("%llx -> %llx",
> > -                    (unsigned long long) block0,
> > +                    (unsigned long long) (page->index << shift),
> >                      (unsigned long long) block);
> >
> >               if (block) {
> > --
> > 2.23.0

