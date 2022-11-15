Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD855628E3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 01:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiKOAWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 19:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiKOAWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:22:46 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D60C1CFF7;
        Mon, 14 Nov 2022 16:22:44 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 00387C01F; Tue, 15 Nov 2022 01:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668471768; bh=LIstCPb4xQT8VC3InWGVD6DG7uFdDJigM2d8zkWyzlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmFHY8C6Z9RrnQSYNhcMMnQHIHu+kheEP2L0G4XpsjdXsPsVuneAYMDhYQl2/v1H8
         i8bseV8XSAmaLwe9R8hXDVQnpAXEg3avqHYSHTHoeKDzhmTmZYx1ywqvuGzUKoQIRl
         bvVPEQV4Af+uxYgLbUBaUY5nTeTe9W7Ki5kz+wAO+vdg+AraWtCZjs+JyMXdAthn3l
         kal7xACCnzdq+f/tHPcTwTw733nXRHdzav9kpyP7dz0z6Qf2v9cA3tOxPpO7Xkf08y
         mGTM4vYOosKAf3I+aCefhS9jDQIWkzvOIKMxY7UFlyPwubz/47x4WNtwhuO7iIsu1T
         iFoCA0ybafUIw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id E9DB3C009;
        Tue, 15 Nov 2022 01:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668471766; bh=LIstCPb4xQT8VC3InWGVD6DG7uFdDJigM2d8zkWyzlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCzYdsKheoEw3SbPdq8dVompXvyIFPrTv8JxCFNOG8Sv6HDGCCc8EJ9TZ1mJpAJBP
         dfuVrLiLq6tLoPjg4vx7OnksEJRCe7+wk8srl2FEfVJUHcjtGwcL/HsmLnl7hxdJJO
         aAoNMpEDlxjtDi5MM90FWnau+y1nrDpmXPlLGgo+4TqQmnSnJRW9oMhrUC4NSrf2YI
         kwkv/XQ7cOL1UiwjAM4vHnFOYQEuzfy0wyv+LAwoyoMRSBGmD7j/7m8dWCIq6wXmGd
         HBU3jACL9WMITVf23xsnCvYbaZt3Cc3GmPhLK9M9qGkjB66Hluj/ez6JPYz8fB704q
         zmA+Da+v6VOiA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 675ffca7;
        Tue, 15 Nov 2022 00:22:33 +0000 (UTC)
Date:   Tue, 15 Nov 2022 09:22:18 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, dwysocha@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
Message-ID: <Y3Lbul7FZncNVwVZ@codewreck.org>
References: <166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Mon, Nov 14, 2022 at 04:02:20PM +0000:
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

Not familiar with the common code so just glanced at it and asked stupid
questions.

> diff --git a/fs/9p/cache.c b/fs/9p/cache.c
> index cebba4eaa0b5..12c0ae29f185 100644
> --- a/fs/9p/cache.c
> +++ b/fs/9p/cache.c
> @@ -68,6 +68,8 @@ void v9fs_cache_inode_get_cookie(struct inode *inode)
>  				       &path, sizeof(path),
>  				       &version, sizeof(version),
>  				       i_size_read(&v9inode->netfs.inode));
> +	if (v9inode->netfs.cache)
> +		mapping_set_release_always(inode->i_mapping);
>  
>  	p9_debug(P9_DEBUG_FSC, "inode %p get cookie %p\n",
>  		 inode, v9fs_inode_cookie(v9inode));
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 4d1a4a8d9277..b553fe3484c1 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -394,6 +394,7 @@ void v9fs_evict_inode(struct inode *inode)
>  	version = cpu_to_le32(v9inode->qid.version);
>  	fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
>  				      &version);
> +	mapping_clear_release_always(inode->i_mapping);

any harm in setting this if netfs isn't enabled?
(just asking because you checked in fs/9p/cache.c above)

>  	clear_inode(inode);
>  	filemap_fdatawrite(&inode->i_data);
>  
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bbccb4044222..3db9a6225bc0 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -199,6 +199,7 @@ enum mapping_flags {
>  	/* writeback related tags are not used */
>  	AS_NO_WRITEBACK_TAGS = 5,
>  	AS_LARGE_FOLIO_SUPPORT = 6,
> +	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
>  };
>  
>  /**
> @@ -269,6 +270,21 @@ static inline int mapping_use_writeback_tags(struct address_space *mapping)
>  	return !test_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
>  }
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
> +	set_bit(AS_RELEASE_ALWAYS, &mapping->flags);

clear_bit certainly?

> +}
> +
>  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>  {
>  	return mapping->gfp_mask;
> diff --git a/mm/truncate.c b/mm/truncate.c
> index c0be77e5c008..0d4dd233f518 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -19,7 +19,6 @@
>  #include <linux/highmem.h>
>  #include <linux/pagevec.h>
>  #include <linux/task_io_accounting_ops.h>
> -#include <linux/buffer_head.h>	/* grr. try_to_release_page */
>  #include <linux/shmem_fs.h>
>  #include <linux/rmap.h>
>  #include "internal.h"
> @@ -276,7 +275,7 @@ static long mapping_evict_folio(struct address_space *mapping,
>  	if (folio_ref_count(folio) >
>  			folio_nr_pages(folio) + folio_has_private(folio) + 1)
>  		return 0;
> -	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
> +	if (!filemap_release_folio(folio, 0))

should this (and all others) check for folio_needs_release instead of has_private?
filemap_release_folio doesn't check as far as I can see, but perhaps
it's already fast and noop for another reason I didn't see.

>  		return 0;
>  
>  	return remove_mapping(mapping, folio);

--
Dominique
