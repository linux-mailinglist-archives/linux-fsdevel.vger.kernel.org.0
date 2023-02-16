Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6146069967E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBPOAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 09:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPOAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:00:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F340ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 05:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676555977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xEH9h33TQSqPPiPDsBdeDp7ByTBzbtZLpeGkYEW8pJk=;
        b=JQkjONjSaqNj1kjJyRFESjy3rK21lRvwmzWV1ocY4OBKaNOASABKVWVbCJ4DlOeFO35zoY
        V9xmWtyjd2d6bQMpKRbMIt2m+08pBQpYbWaxGOvhTLAXgBBQdxIN0sg6tLf2CA84ThLIpc
        Y2YWdyHJma7UQL+BTFmYuqhU7og939s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-83-G8RbpxmzMPKMXSYimDwi3A-1; Thu, 16 Feb 2023 08:59:35 -0500
X-MC-Unique: G8RbpxmzMPKMXSYimDwi3A-1
Received: by mail-pj1-f70.google.com with SMTP id v1-20020a17090abb8100b0023470d96ae6so1282089pjr.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 05:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEH9h33TQSqPPiPDsBdeDp7ByTBzbtZLpeGkYEW8pJk=;
        b=w/+SbkhoGoIzEgBOCwrUCzvdq6PVYI9cMXs/1PuB2r1hqhtrUOkTUBYd5Ntc5bMqdS
         5M8uK9ZBrIKNBTgaGFXo/lpvJ6iRvy0mZacUSQyEzPsQxbKdG67IEfVYFhoj/mX5zNZk
         aiNmFOGcEF6HT6l8Ek4AeNAROOWrGeNejFwrS15654YlGsi0PS20iMD50IJbSrBuQNbo
         /mFiNe5v/RDWHwhfMykfKdrGMWCvYXqi3F9IeA/BN1n8B+m+Au8G4t9VPI3HhlBamLcJ
         wVHkQ4VbZ+sR06HTnTCE7JXITAc+wxfIKiLT/dj4SsGCgjeQAS6JGQ4T5QoNnSUpcuiC
         w1+g==
X-Gm-Message-State: AO0yUKWFO4NC491XH/fwZXFRKKAyVkG5styNvTxd60eqKokN9vQf1+lQ
        l07Kc+tqN94RuJ1m7cz95Krhp8j747PioFMTkFr2Txgh/P1cL3j2Gxd+78uGXA+GgoEyZJnUIiM
        mnDpvyP2nbkrxgSN9eLP/0AWINVJLrttsVhGJ9vFwQA==
X-Received: by 2002:a63:375a:0:b0:4cd:fd18:8ccb with SMTP id g26-20020a63375a000000b004cdfd188ccbmr792417pgn.43.1676555974840;
        Thu, 16 Feb 2023 05:59:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+fnE4zZrwJsp2nenn4dAhNJXa5kjnLl2S0zfctKiolwaM2jNY3wF/FKP7SRJni882H8wLcwDW2NvsCxga0P3o=
X-Received: by 2002:a63:375a:0:b0:4cd:fd18:8ccb with SMTP id
 g26-20020a63375a000000b004cdfd188ccbmr792412pgn.43.1676555974531; Thu, 16 Feb
 2023 05:59:34 -0800 (PST)
MIME-Version: 1.0
References: <167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk>
 <167172133121.2334525.2608800018126833569.stgit@warthog.procyon.org.uk>
In-Reply-To: <167172133121.2334525.2608800018126833569.stgit@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 16 Feb 2023 08:58:58 -0500
Message-ID: <CALF+zO=P1QbKmyE7c+4CQZyWKM5PeU1GqgPxUnerWc9B03OxCA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Rohith Surabattula <rohiths.msft@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-ext4@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 10:02 AM David Howells <dhowells@redhat.com> wrote:
>
> Fscache has an optimisation by which reads from the cache are skipped until
> we know that (a) there's data there to be read and (b) that data isn't
> entirely covered by pages resident in the netfs pagecache.  This is done
> with two flags manipulated by fscache_note_page_release():
>
>         if (...
>             test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
>             test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
>                 clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
>
> where the NO_DATA_TO_READ flag causes cachefiles_prepare_read() to indicate
> that netfslib should download from the server or clear the page instead.
>
> The fscache_note_page_release() function is intended to be called from
> ->releasepage() - but that only gets called if PG_private or PG_private_2
> is set - and currently the former is at the discretion of the network
> filesystem and the latter is only set whilst a page is being written to the
> cache, so sometimes we miss clearing the optimisation.
>
> Fix this by following Willy's suggestion[1] and adding an address_space
> flag, AS_RELEASE_ALWAYS, that causes filemap_release_folio() to always call
> ->release_folio() if it's set, even if PG_private or PG_private_2 aren't
> set.
>
> Note that this would require folio_test_private() and page_has_private() to
> become more complicated.  To avoid that, in the places[*] where these are
> used to conditionalise calls to filemap_release_folio() and
> try_to_release_page(), the tests are removed the those functions just
> jumped to unconditionally and the test is performed there.
>
> [*] There are some exceptions in vmscan.c where the check guards more than
> just a call to the releaser.  I've added a function, folio_needs_release()
> to wrap all the checks for that.
>
> AS_RELEASE_ALWAYS should be set if a non-NULL cookie is obtained from
> fscache and cleared in ->evict_inode() before truncate_inode_pages_final()
> is called.
>
> Additionally, the FSCACHE_COOKIE_NO_DATA_TO_READ flag needs to be cleared
> and the optimisation cancelled if a cachefiles object already contains data
> when we open it.
>
> Changes:
> ========
> ver #4)
>  - Split out merging of folio_has_private()/filemap_release_folio() call
>    pairs into a preceding patch.
>  - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
>
> ver #3)
>  - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
>  - Moved a '&&' to the correct line.
>
> ver #2)
>  - Rewrote entirely according to Willy's suggestion[1].
>
> Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Dave Wysochanski <dwysocha@redhat.com>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: linux-cachefs@redhat.com
> cc: linux-cifs@vger.kernel.org
> cc: linux-afs@lists.infradead.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: ceph-devel@vger.kernel.org
> cc: linux-nfs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
>
> Link: https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/ [1]
> Link: https://lore.kernel.org/r/164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/166869495238.3720468.4878151409085146764.stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/1459152.1669208550@warthog.procyon.org.uk/ # v3 also
> Link: https://lore.kernel.org/r/166924372614.1772793.3804564782036202222.stgit@warthog.procyon.org.uk/ # v4
> ---
>
>  fs/9p/cache.c           |    2 ++
>  fs/afs/internal.h       |    2 ++
>  fs/cachefiles/namei.c   |    2 ++
>  fs/ceph/cache.c         |    2 ++
>  fs/cifs/fscache.c       |    2 ++
>  include/linux/pagemap.h |   16 ++++++++++++++++
>  mm/internal.h           |    5 ++++-
>  7 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/fs/9p/cache.c b/fs/9p/cache.c
> index cebba4eaa0b5..12c0ae29f185 100644
> --- a/fs/9p/cache.c
> +++ b/fs/9p/cache.c
> @@ -68,6 +68,8 @@ void v9fs_cache_inode_get_cookie(struct inode *inode)
>                                        &path, sizeof(path),
>                                        &version, sizeof(version),
>                                        i_size_read(&v9inode->netfs.inode));
> +       if (v9inode->netfs.cache)
> +               mapping_set_release_always(inode->i_mapping);
>
>         p9_debug(P9_DEBUG_FSC, "inode %p get cookie %p\n",
>                  inode, v9fs_inode_cookie(v9inode));
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 9ba7b68375c9..8e4afaeb6bff 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -680,6 +680,8 @@ static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
>  {
>  #ifdef CONFIG_AFS_FSCACHE
>         vnode->netfs.cache = cookie;
> +       if (cookie)
> +               mapping_set_release_always(vnode->netfs.inode.i_mapping);
>  #endif
>  }
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 03ca8f2f657a..50b2ee163af6 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -584,6 +584,8 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
>         if (ret < 0)
>                 goto check_failed;
>
> +       clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &object->cookie->flags);
> +
>         object->file = file;
>
>         /* Always update the atime on an object we've just looked up (this is
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 177d8e8d73fe..de1dee46d3df 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -36,6 +36,8 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
>                                        &ci->i_vino, sizeof(ci->i_vino),
>                                        &ci->i_version, sizeof(ci->i_version),
>                                        i_size_read(inode));
> +       if (ci->netfs.cache)
> +               mapping_set_release_always(inode->i_mapping);
>  }
>
>  void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info *ci)
> diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
> index f6f3a6b75601..79e9665dfc90 100644
> --- a/fs/cifs/fscache.c
> +++ b/fs/cifs/fscache.c
> @@ -108,6 +108,8 @@ void cifs_fscache_get_inode_cookie(struct inode *inode)
>                                        &cifsi->uniqueid, sizeof(cifsi->uniqueid),
>                                        &cd, sizeof(cd),
>                                        i_size_read(&cifsi->netfs.inode));
> +       if (cifsi->netfs.cache)
> +               mapping_set_release_always(inode->i_mapping);
>  }
>
>  void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update)
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 29e1f9e76eb6..a0d433e0addd 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -199,6 +199,7 @@ enum mapping_flags {
>         /* writeback related tags are not used */
>         AS_NO_WRITEBACK_TAGS = 5,
>         AS_LARGE_FOLIO_SUPPORT = 6,
> +       AS_RELEASE_ALWAYS,      /* Call ->release_folio(), even if no private data */
>  };
>
>  /**
> @@ -269,6 +270,21 @@ static inline int mapping_use_writeback_tags(struct address_space *mapping)
>         return !test_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
>  }
>
> +static inline bool mapping_release_always(const struct address_space *mapping)
> +{
> +       return test_bit(AS_RELEASE_ALWAYS, &mapping->flags);
> +}
> +
> +static inline void mapping_set_release_always(struct address_space *mapping)
> +{
> +       set_bit(AS_RELEASE_ALWAYS, &mapping->flags);
> +}
> +
> +static inline void mapping_clear_release_always(struct address_space *mapping)
> +{
> +       clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>  {
>         return mapping->gfp_mask;
> diff --git a/mm/internal.h b/mm/internal.h
> index c4c8e58e1d12..5421ce8661fa 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -168,7 +168,10 @@ static inline void set_page_refcounted(struct page *page)
>   */
>  static inline bool folio_needs_release(struct folio *folio)
>  {
> -       return folio_has_private(folio);
> +       struct address_space *mapping = folio->mapping;
> +
> +       return folio_has_private(folio) ||
> +               (mapping && mapping_release_always(mapping));
>  }
>
>  extern unsigned long highest_memmap_pfn;
>
>

What is the status of this patch?  I think it may be stalled but I'm not sure
if maybe it's in progress behind the scenes, or in someone's testing tree?

FWIW, this is still needed for the NFS netfs conversion patches [1]
(I will post a v11 soon), to avoid a perf regression seen by my unit
tests as well as by Daire Byrne and Ben Maynard re-export environments.

Thanks.

[1] https://marc.info/?l=linux-nfs&m=166749188616723&w=4

