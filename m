Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7F649F02C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 01:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbiA1Azo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 19:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344826AbiA1Azh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:55:37 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BB8C061714;
        Thu, 27 Jan 2022 16:55:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u6so8569829lfm.10;
        Thu, 27 Jan 2022 16:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPfqXqCnZQyWiLqoHqK+K6Sm6LUScfhldLkzmE86PYs=;
        b=IXbqPfPdxYWCCRNoB5GfmBm6gLtq2qsPcU2U0XAgwmZC/2NB+VofkA0Tyg4WFvGMe2
         2gTZWhR2vFaKK6Xcnrb4oEfJ9onGUnpmx8wdsDn6clYhsVtbxpsZjy9dLiYJekUbygbM
         +i0w0WD5QCRgupooJ+RnKWaajxrZ0Rx5/TWxqgA1nQytmuZeZAjPAHa3HdEl5LtOTz11
         3wsGl3AN6iEH+Pu28JLYvnmJCtryxgsmfiEI0+L0LTbMmspnTdmbTIzsIXMxbLVVzDmU
         aCwMYNOsRFtnLsBEm7VxH7479aggALchljZoXiLpH8UOsbAFPzpgimBLX1g1o+SfSdml
         MH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPfqXqCnZQyWiLqoHqK+K6Sm6LUScfhldLkzmE86PYs=;
        b=tsfObk3M4lT9wdcjjT3m86Ta010CYKifYJcmP9Vf01fYnjpRaWIcduHUlEyTUleyoh
         Lbi5abL8+o95/E+TPODx2ECccnLyqAI4j8vdgZYfDuZWI79bA5tdiFGryKt1iTVHWYth
         WNtyfsEn016W32iC2NqCvF+cLvquhFPLWu79MEurEZy8yqVyjyDoST5AtihYUDVEIknB
         6UVepgKbOSvGof05n447xRYT8FpaD1CsX7JkR91fx1FNm4APvP9pqud4fGcCyXEZNKl+
         CVb3icZZPbprC7WBeh4Ci+QdQ58vHsfn+3Z3KQaWckw0asyCP2+7k1SbK85DfLKZB9u3
         LPeg==
X-Gm-Message-State: AOAM530PdIrF7bdqaE2uwIniZIsNBeGNO9wWF8NjdyS4EDcQGhHBkz57
        FHJZFKAk+z3a1VGx/if5IbohlIVxrXK/6y20j08=
X-Google-Smtp-Source: ABdhPJzKkwANx18s3dz7Q6/hs30nwVNez2elfD83wDb90hd4JZz6ctQ4An4hiHzAurhZiBcQe+MaSlifuxq5XFTdoWY=
X-Received: by 2002:a05:6512:2289:: with SMTP id f9mr4272518lfu.537.1643331334748;
 Thu, 27 Jan 2022 16:55:34 -0800 (PST)
MIME-Version: 1.0
References: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
 <164329937835.843658.13129382687019174242.stgit@warthog.procyon.org.uk>
In-Reply-To: <164329937835.843658.13129382687019174242.stgit@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 27 Jan 2022 18:55:23 -0600
Message-ID: <CAH2r5mu4FeX2x=Xd0jDnQopTfhOBP_P91-NH-A+bNdx6THCu8A@mail.gmail.com>
Subject: Re: [PATCH 4/4] cifs: Implement cache I/O by accessing the cache directly
To:     David Howells <dhowells@redhat.com>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Regression tests so far on Dave's cifs fscache patch series are going
fine.  First series of tests I ran were this:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/11/builds/160
but I have to run additional tests with fscache enabled etc.

I saw that checkpatch had some minor complaints on this patch (patch
4) which I cleaned up, but was wondering other's thoughts on this
checkpatch warning:

WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code
rather than BUG() or BUG_ON()
#101: FILE: fs/cifs/file.c:4449:

ie

+ page = readahead_page(ractl);
+ BUG_ON(!page);

On Thu, Jan 27, 2022 at 10:03 AM David Howells <dhowells@redhat.com> wrote:
>
> Move cifs to using fscache DIO API instead of the old upstream I/O API as
> that has been removed.  This is a stopgap solution as the intention is that
> at sometime in the future, the cache will move to using larger blocks and
> won't be able to store individual pages in order to deal with the potential
> for data corruption due to the backing filesystem being able insert/remove
> bridging blocks of zeros into its extent list[1].
>
> cifs then reads and writes cache pages synchronously and one page at a time.
>
> The preferred change would be to use the netfs lib, but the new I/O API can
> be used directly.  It's just that as the cache now needs to track data for
> itself, caching blocks may exceed page size...
>
> This code is somewhat borrowed from my "fallback I/O" patchset[2].
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: linux-cifs@vger.kernel.org
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
> Link: https://lore.kernel.org/r/202112100957.2oEDT20W-lkp@intel.com/ [2]
> ---
>
>  fs/cifs/file.c    |   55 +++++++++++++++++++++--
>  fs/cifs/fscache.c |  126 +++++++++++++++++++++++++++++++++++++++++++++--------
>  fs/cifs/fscache.h |   79 +++++++++++++++++++++------------
>  3 files changed, 207 insertions(+), 53 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index be62dc29dc54..1b41b6f2a04b 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -4276,12 +4276,12 @@ cifs_readv_complete(struct work_struct *work)
>                 } else
>                         SetPageError(page);
>
> -               unlock_page(page);
> -
>                 if (rdata->result == 0 ||
>                     (rdata->result == -EAGAIN && got_bytes))
>                         cifs_readpage_to_fscache(rdata->mapping->host, page);
>
> +               unlock_page(page);
> +
>                 got_bytes -= min_t(unsigned int, PAGE_SIZE, got_bytes);
>
>                 put_page(page);
> @@ -4396,7 +4396,11 @@ static void cifs_readahead(struct readahead_control *ractl)
>         struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(ractl->file);
>         struct TCP_Server_Info *server;
>         pid_t pid;
> -       unsigned int xid, last_batch_size = 0;
> +       unsigned int xid, nr_pages, last_batch_size = 0, cache_nr_pages = 0;
> +       pgoff_t next_cached = ULONG_MAX;
> +       bool caching = fscache_cookie_enabled(cifs_inode_cookie(ractl->mapping->host)) &&
> +               cifs_inode_cookie(ractl->mapping->host)->cache_priv;
> +       bool check_cache = caching;
>
>         xid = get_xid();
>
> @@ -4414,12 +4418,52 @@ static void cifs_readahead(struct readahead_control *ractl)
>         /*
>          * Chop the readahead request up into rsize-sized read requests.
>          */
> -       while (readahead_count(ractl) - last_batch_size) {
> -               unsigned int i, nr_pages, got, rsize;
> +       while ((nr_pages = readahead_count(ractl) - last_batch_size)) {
> +               unsigned int i, got, rsize;
>                 struct page *page;
>                 struct cifs_readdata *rdata;
>                 struct cifs_credits credits_on_stack;
>                 struct cifs_credits *credits = &credits_on_stack;
> +               pgoff_t index = readahead_index(ractl) + last_batch_size;
> +
> +               /*
> +                * Find out if we have anything cached in the range of
> +                * interest, and if so, where the next chunk of cached data is.
> +                */
> +               if (caching) {
> +                       if (check_cache) {
> +                               rc = cifs_fscache_query_occupancy(
> +                                       ractl->mapping->host, index, nr_pages,
> +                                       &next_cached, &cache_nr_pages);
> +                               if (rc < 0)
> +                                       caching = false;
> +                               check_cache = false;
> +                       }
> +
> +                       if (index == next_cached) {
> +                               /*
> +                                * TODO: Send a whole batch of pages to be read
> +                                * by the cache.
> +                                */
> +                               page = readahead_page(ractl);
> +                               BUG_ON(!page);
> +                               if (cifs_readpage_from_fscache(ractl->mapping->host,
> +                                                              page) < 0) {
> +                                       /*
> +                                        * TODO: Deal with cache read failure
> +                                        * here, but for the moment, delegate
> +                                        * that to readpage.
> +                                        */
> +                                       caching = false;
> +                               }
> +                               unlock_page(page);
> +                               next_cached++;
> +                               cache_nr_pages--;
> +                               if (cache_nr_pages == 0)
> +                                       check_cache = true;
> +                               continue;
> +                       }
> +               }
>
>                 if (open_file->invalidHandle) {
>                         rc = cifs_reopen_file(open_file, true);
> @@ -4435,6 +4479,7 @@ static void cifs_readahead(struct readahead_control *ractl)
>                 if (rc)
>                         break;
>                 nr_pages = min_t(size_t, rsize / PAGE_SIZE, readahead_count(ractl));
> +               nr_pages = min_t(size_t, nr_pages, next_cached - index);
>
>                 /*
>                  * Give up immediately if rsize is too small to read an entire
> diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
> index efaac4d5ff55..f98cfcc0d397 100644
> --- a/fs/cifs/fscache.c
> +++ b/fs/cifs/fscache.c
> @@ -134,37 +134,127 @@ void cifs_fscache_release_inode_cookie(struct inode *inode)
>         }
>  }
>
> +static inline void fscache_end_operation(struct netfs_cache_resources *cres)
> +{
> +       const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
> +
> +       if (ops)
> +               ops->end_operation(cres);
> +}
> +
>  /*
> - * Retrieve a page from FS-Cache
> + * Fallback page reading interface.
>   */
> -int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
> +static int fscache_fallback_read_page(struct inode *inode, struct page *page)
>  {
> -       cifs_dbg(FYI, "%s: (fsc:%p, p:%p, i:0x%p\n",
> -                __func__, CIFS_I(inode)->fscache, page, inode);
> -       return -ENOBUFS; // Needs conversion to using netfslib
> +       struct netfs_cache_resources cres;
> +       struct fscache_cookie *cookie = cifs_inode_cookie(inode);
> +       struct iov_iter iter;
> +       struct bio_vec bvec[1];
> +       int ret;
> +
> +       memset(&cres, 0, sizeof(cres));
> +       bvec[0].bv_page         = page;
> +       bvec[0].bv_offset       = 0;
> +       bvec[0].bv_len          = PAGE_SIZE;
> +       iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
> +
> +       ret = fscache_begin_read_operation(&cres, cookie);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
> +                          NULL, NULL);
> +       fscache_end_operation(&cres);
> +       return ret;
>  }
>
>  /*
> - * Retrieve a set of pages from FS-Cache
> + * Fallback page writing interface.
>   */
> -int __cifs_readpages_from_fscache(struct inode *inode,
> -                               struct address_space *mapping,
> -                               struct list_head *pages,
> -                               unsigned *nr_pages)
> +static int fscache_fallback_write_page(struct inode *inode, struct page *page,
> +                                      bool no_space_allocated_yet)
>  {
> -       cifs_dbg(FYI, "%s: (0x%p/%u/0x%p)\n",
> -                __func__, CIFS_I(inode)->fscache, *nr_pages, inode);
> -       return -ENOBUFS; // Needs conversion to using netfslib
> +       struct netfs_cache_resources cres;
> +       struct fscache_cookie *cookie = cifs_inode_cookie(inode);
> +       struct iov_iter iter;
> +       struct bio_vec bvec[1];
> +       loff_t start = page_offset(page);
> +       size_t len = PAGE_SIZE;
> +       int ret;
> +
> +       memset(&cres, 0, sizeof(cres));
> +       bvec[0].bv_page         = page;
> +       bvec[0].bv_offset       = 0;
> +       bvec[0].bv_len          = PAGE_SIZE;
> +       iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
> +
> +       ret = fscache_begin_write_operation(&cres, cookie);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = cres.ops->prepare_write(&cres, &start, &len, i_size_read(inode),
> +                                     no_space_allocated_yet);
> +       if (ret == 0)
> +               ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
> +       fscache_end_operation(&cres);
> +       return ret;
>  }
>
> -void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
> +/*
> + * Retrieve a page from FS-Cache
> + */
> +int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
>  {
> -       struct cifsInodeInfo *cifsi = CIFS_I(inode);
> +       int ret;
>
> -       WARN_ON(!cifsi->fscache);
> +       cifs_dbg(FYI, "%s: (fsc:%p, p:%p, i:0x%p\n",
> +                __func__, cifs_inode_cookie(inode), page, inode);
>
> +       ret = fscache_fallback_read_page(inode, page);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Read completed synchronously */
> +       SetPageUptodate(page);
> +       return 0;
> +}
> +
> +void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
> +{
>         cifs_dbg(FYI, "%s: (fsc: %p, p: %p, i: %p)\n",
> -                __func__, cifsi->fscache, page, inode);
> +                __func__, cifs_inode_cookie(inode), page, inode);
> +
> +       fscache_fallback_write_page(inode, page, true);
> +}
> +
> +/*
> + * Query the cache occupancy.
> + */
> +int __cifs_fscache_query_occupancy(struct inode *inode,
> +                                  pgoff_t first, unsigned nr_pages,
> +                                  pgoff_t *_data_first,
> +                                  unsigned int *_data_nr_pages)
> +{
> +       struct netfs_cache_resources cres;
> +       struct fscache_cookie *cookie = cifs_inode_cookie(inode);
> +       loff_t start, data_start;
> +       size_t len, data_len;
> +       int ret;
>
> -       // Needs conversion to using netfslib
> +       ret = fscache_begin_read_operation(&cres, cookie);
> +       if (ret < 0)
> +               return ret;
> +
> +       start = first * PAGE_SIZE;
> +       len = nr_pages * PAGE_SIZE;
> +       ret = cres.ops->query_occupancy(&cres, start, len, PAGE_SIZE,
> +                                       &data_start, &data_len);
> +       if (ret == 0) {
> +               *_data_first = data_start / PAGE_SIZE;
> +               *_data_nr_pages = len / PAGE_SIZE;
> +       }
> +
> +       fscache_end_operation(&cres);
> +       return ret;
>  }
> diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
> index c6ca49ac33d4..ed4b08df1961 100644
> --- a/fs/cifs/fscache.h
> +++ b/fs/cifs/fscache.h
> @@ -9,6 +9,7 @@
>  #ifndef _CIFS_FSCACHE_H
>  #define _CIFS_FSCACHE_H
>
> +#include <linux/swap.h>
>  #include <linux/fscache.h>
>
>  #include "cifsglob.h"
> @@ -58,14 +59,6 @@ void cifs_fscache_fill_coherency(struct inode *inode,
>  }
>
>
> -extern int cifs_fscache_release_page(struct page *page, gfp_t gfp);
> -extern int __cifs_readpage_from_fscache(struct inode *, struct page *);
> -extern int __cifs_readpages_from_fscache(struct inode *,
> -                                        struct address_space *,
> -                                        struct list_head *,
> -                                        unsigned *);
> -extern void __cifs_readpage_to_fscache(struct inode *, struct page *);
> -
>  static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode)
>  {
>         return CIFS_I(inode)->fscache;
> @@ -80,33 +73,52 @@ static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags
>                            i_size_read(inode), flags);
>  }
>
> -static inline int cifs_readpage_from_fscache(struct inode *inode,
> -                                            struct page *page)
> -{
> -       if (CIFS_I(inode)->fscache)
> -               return __cifs_readpage_from_fscache(inode, page);
> +extern int __cifs_fscache_query_occupancy(struct inode *inode,
> +                                         pgoff_t first, unsigned nr_pages,
> +                                         pgoff_t *_data_first,
> +                                         unsigned int *_data_nr_pages);
>
> -       return -ENOBUFS;
> +static inline int cifs_fscache_query_occupancy(struct inode *inode,
> +                                              pgoff_t first, unsigned nr_pages,
> +                                              pgoff_t *_data_first,
> +                                              unsigned int *_data_nr_pages)
> +{
> +       if (!cifs_inode_cookie(inode))
> +               return -ENOBUFS;
> +       return __cifs_fscache_query_occupancy(inode, first, nr_pages,
> +                                             _data_first, _data_nr_pages);
>  }
>
> -static inline int cifs_readpages_from_fscache(struct inode *inode,
> -                                             struct address_space *mapping,
> -                                             struct list_head *pages,
> -                                             unsigned *nr_pages)
> +extern int __cifs_readpage_from_fscache(struct inode *, struct page *);
> +extern void __cifs_readpage_to_fscache(struct inode *, struct page *);
> +
> +
> +static inline int cifs_readpage_from_fscache(struct inode *inode,
> +                                            struct page *page)
>  {
> -       if (CIFS_I(inode)->fscache)
> -               return __cifs_readpages_from_fscache(inode, mapping, pages,
> -                                                    nr_pages);
> +       if (cifs_inode_cookie(inode))
> +               return __cifs_readpage_from_fscache(inode, page);
>         return -ENOBUFS;
>  }
>
>  static inline void cifs_readpage_to_fscache(struct inode *inode,
>                                             struct page *page)
>  {
> -       if (PageFsCache(page))
> +       if (cifs_inode_cookie(inode))
>                 __cifs_readpage_to_fscache(inode, page);
>  }
>
> +static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
> +{
> +       if (PageFsCache(page)) {
> +               if (current_is_kswapd() || !(gfp & __GFP_FS))
> +                       return false;
> +               wait_on_page_fscache(page);
> +               fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
> +       }
> +       return true;
> +}
> +
>  #else /* CONFIG_CIFS_FSCACHE */
>  static inline
>  void cifs_fscache_fill_coherency(struct inode *inode,
> @@ -123,22 +135,29 @@ static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool upd
>  static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
>  static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags) {}
>
> -static inline int
> -cifs_readpage_from_fscache(struct inode *inode, struct page *page)
> +static inline int cifs_fscache_query_occupancy(struct inode *inode,
> +                                              pgoff_t first, unsigned nr_pages,
> +                                              pgoff_t *_data_first,
> +                                              unsigned int *_data_nr_pages)
>  {
> +       *_data_first = ULONG_MAX;
> +       *_data_nr_pages = 0;
>         return -ENOBUFS;
>  }
>
> -static inline int cifs_readpages_from_fscache(struct inode *inode,
> -                                             struct address_space *mapping,
> -                                             struct list_head *pages,
> -                                             unsigned *nr_pages)
> +static inline int
> +cifs_readpage_from_fscache(struct inode *inode, struct page *page)
>  {
>         return -ENOBUFS;
>  }
>
> -static inline void cifs_readpage_to_fscache(struct inode *inode,
> -                       struct page *page) {}
> +static inline
> +void cifs_readpage_to_fscache(struct inode *inode, struct page *page) {}
> +
> +static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
> +{
> +       return true; /* May release page */
> +}
>
>  #endif /* CONFIG_CIFS_FSCACHE */
>
>
>


-- 
Thanks,

Steve
