Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A06B741D51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 02:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjF2AlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 20:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF2AlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6186B210E
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 17:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687999209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBoFOtIWRHIKoWf0lrD2wG9OyN2hTf5a/5og68Y1whI=;
        b=J8NjtdXPZB9CNuuTxyjT2qAaQht3XQCyUXgRNWYGFxqlJ+9wQOf3yfSx2EtIas3YXpHGeC
        QezVT1nT7ZVfOEQrr0vnit3pTjVikDnQZil8G4hTWcOHE7ivZPTLg3jIFRX8LOCkiKHRiK
        biMr53cbBNE3IZuM0rjDwrdBMP6xFrI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-s8eMhMDtOlShkMZx80mrCQ-1; Wed, 28 Jun 2023 20:40:08 -0400
X-MC-Unique: s8eMhMDtOlShkMZx80mrCQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-53425d37fefso78910a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 17:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687999207; x=1690591207;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBoFOtIWRHIKoWf0lrD2wG9OyN2hTf5a/5og68Y1whI=;
        b=MWtbpxUl/SJpTVtLxqvuWQZh35WvOnDy7VM8goBc+wvUYtK4R74lkPr80N3BjEU9io
         IDETMmG/zbh97LRVPTSfdvjOpFhxBe9JZuezam6fafV4S45vxu7MCts6p7vhwQDvVO7Q
         c4V+Qza3/DTFUemQ9E2hS6x1EnOA5H4E1XYO8bC6HEmf5Qj5GB1Y8kPebqoIb1dwjE9z
         itEZy4wG6j6Q2yEDbsQlpXjDiVPbIRiLCKMwjy36Z+bCQzlW3SQexhPJAbWrlhSHXdm/
         7r0eEKJwXTWNTv9roZqGJ6GQzBTLXefA+ab2uCy1oeY/UBy8h5mVXUaKAFeBVAZt5CBf
         5KjA==
X-Gm-Message-State: AC+VfDwKO9K8LuBUKotzHDSUNRScnojOQG5AQRHNiQ8VD3xpiFVhr2yu
        STrOUMrzrItwHDVjujAUBpdN5PAcQjYHuFnnc7haRz7DeSkOulJPT2ucBRD+S3Ra3oeIg5GodRw
        173kUIlxr2YzBjmqz2O/EPxEkS/pdR75G6IXN
X-Received: by 2002:a05:6a21:32a2:b0:125:699a:599b with SMTP id yt34-20020a056a2132a200b00125699a599bmr15662839pzb.34.1687999206974;
        Wed, 28 Jun 2023 17:40:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vLdftDDvS6DadhOeggrwPU/ORSuzVvDK1nPTA87qiG12zTXbeuXwcom3dX8ucd1whR5HDYQ==
X-Received: by 2002:a05:6a21:32a2:b0:125:699a:599b with SMTP id yt34-20020a056a2132a200b00125699a599bmr15662825pzb.34.1687999206657;
        Wed, 28 Jun 2023 17:40:06 -0700 (PDT)
Received: from [10.72.13.91] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d14-20020aa78e4e000000b0067acbc74977sm4268764pfr.96.2023.06.28.17.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 17:40:06 -0700 (PDT)
Message-ID: <41e1c831-29de-8494-d925-6e2eb379567f@redhat.com>
Date:   Thu, 29 Jun 2023 08:39:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Linux-cachefs] [PATCH v7 2/2] mm, netfs, fscache: Stop read
 optimisation when folio removed from pagecache
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        linux-cifs@vger.kernel.org,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Steve French <sfrench@samba.org>, linux-cachefs@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org,
        Dominique Martinet <asmadeus@codewreck.org>
References: <20230628104852.3391651-1-dhowells@redhat.com>
 <20230628104852.3391651-3-dhowells@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230628104852.3391651-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/28/23 18:48, David Howells wrote:
> Fscache has an optimisation by which reads from the cache are skipped until
> we know that (a) there's data there to be read and (b) that data isn't
> entirely covered by pages resident in the netfs pagecache.  This is done
> with two flags manipulated by fscache_note_page_release():
>
> 	if (...
> 	    test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
> 	    test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
> 		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
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
> Fixes: 1f67e6d0b188 ("fscache: Provide a function to note the release of a page")
> Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
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
> ---
>
> Notes:
>      ver #7)
>       - Make NFS set AS_RELEASE_ALWAYS.
>      
>      ver #4)
>       - Split out merging of folio_has_private()/filemap_release_folio() call
>         pairs into a preceding patch.
>       - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
>      
>      ver #3)
>       - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
>       - Moved a '&&' to the correct line.
>      
>      ver #2)
>       - Rewrote entirely according to Willy's suggestion[1].
>
>   fs/9p/cache.c           |  2 ++
>   fs/afs/internal.h       |  2 ++
>   fs/cachefiles/namei.c   |  2 ++
>   fs/ceph/cache.c         |  2 ++
>   fs/nfs/fscache.c        |  3 +++
>   fs/smb/client/fscache.c |  2 ++
>   include/linux/pagemap.h | 16 ++++++++++++++++
>   mm/internal.h           |  5 ++++-
>   8 files changed, 33 insertions(+), 1 deletion(-)

Just one question. Shouldn't do this in 'fs/erofs/fscache.c' too ?

>
> diff --git a/fs/9p/cache.c b/fs/9p/cache.c
> index cebba4eaa0b5..12c0ae29f185 100644
> --- a/fs/9p/cache.c
> +++ b/fs/9p/cache.c
> @@ -68,6 +68,8 @@ void v9fs_cache_inode_get_cookie(struct inode *inode)
>   				       &path, sizeof(path),
>   				       &version, sizeof(version),
>   				       i_size_read(&v9inode->netfs.inode));
> +	if (v9inode->netfs.cache)
> +		mapping_set_release_always(inode->i_mapping);
>   
>   	p9_debug(P9_DEBUG_FSC, "inode %p get cookie %p\n",
>   		 inode, v9fs_inode_cookie(v9inode));
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 9d3d64921106..da73b97e19a9 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -681,6 +681,8 @@ static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
>   {
>   #ifdef CONFIG_AFS_FSCACHE
>   	vnode->netfs.cache = cookie;
> +	if (cookie)
> +		mapping_set_release_always(vnode->netfs.inode.i_mapping);

If all the cookie need to do the same thing, then how about doing this 
in 'fscache_acquire_cookie()' ?

Thanks

- Xiubo

>   #endif
>   }
>   
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index d9d22d0ec38a..7bf7a5fcc045 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -585,6 +585,8 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
>   	if (ret < 0)
>   		goto check_failed;
>   
> +	clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &object->cookie->flags);
> +
>   	object->file = file;
>   
>   	/* Always update the atime on an object we've just looked up (this is
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 177d8e8d73fe..de1dee46d3df 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -36,6 +36,8 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
>   				       &ci->i_vino, sizeof(ci->i_vino),
>   				       &ci->i_version, sizeof(ci->i_version),
>   				       i_size_read(inode));
> +	if (ci->netfs.cache)
> +		mapping_set_release_always(inode->i_mapping);
>   }
>   
>   void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info *ci)
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index 8c35d88a84b1..b05717fe0d4e 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -180,6 +180,9 @@ void nfs_fscache_init_inode(struct inode *inode)
>   					       &auxdata,      /* aux_data */
>   					       sizeof(auxdata),
>   					       i_size_read(inode));
> +
> +	if (netfs_inode(inode)->cache)
> +		mapping_set_release_always(inode->i_mapping);
>   }
>   
>   /*
> diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
> index 8f6909d633da..3677525ee993 100644
> --- a/fs/smb/client/fscache.c
> +++ b/fs/smb/client/fscache.c
> @@ -108,6 +108,8 @@ void cifs_fscache_get_inode_cookie(struct inode *inode)
>   				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
>   				       &cd, sizeof(cd),
>   				       i_size_read(&cifsi->netfs.inode));
> +	if (cifsi->netfs.cache)
> +		mapping_set_release_always(inode->i_mapping);
>   }
>   
>   void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update)
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a56308a9d1a4..a1176ceb4a0c 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -199,6 +199,7 @@ enum mapping_flags {
>   	/* writeback related tags are not used */
>   	AS_NO_WRITEBACK_TAGS = 5,
>   	AS_LARGE_FOLIO_SUPPORT = 6,
> +	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
>   };
>   
>   /**
> @@ -269,6 +270,21 @@ static inline int mapping_use_writeback_tags(struct address_space *mapping)
>   	return !test_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
>   }
>   
> +static inline bool mapping_release_always(const struct address_space *mapping)
> +{
> +	return test_bit(AS_RELEASE_ALWAYS, &mapping->flags);
> +}
> +
> +static inline void mapping_set_release_always(struct address_space *mapping)
> +{
> +	set_bit(AS_RELEASE_ALWAYS, &mapping->flags);
> +}
> +
> +static inline void mapping_clear_release_always(struct address_space *mapping)
> +{
> +	clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
> +}
> +
>   static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>   {
>   	return mapping->gfp_mask;
> diff --git a/mm/internal.h b/mm/internal.h
> index a76314764d8c..86aef26df905 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -175,7 +175,10 @@ static inline void set_page_refcounted(struct page *page)
>    */
>   static inline bool folio_needs_release(struct folio *folio)
>   {
> -	return folio_has_private(folio);
> +	struct address_space *mapping = folio->mapping;
> +
> +	return folio_has_private(folio) ||
> +		(mapping && mapping_release_always(mapping));
>   }
>   
>   extern unsigned long highest_memmap_pfn;
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>

