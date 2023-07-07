Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C404A74B52A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjGGQj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 12:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjGGQjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:39:52 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5489A2114;
        Fri,  7 Jul 2023 09:39:09 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1b3f722fdafso2036848fac.3;
        Fri, 07 Jul 2023 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688747944; x=1691339944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBpXki4u1X99CxTnYCWnJqotbifSeXm/9mqo4B1zoO4=;
        b=SB8Cw93IbtUjza4lIhf/GxMz3hT4XxCpiikufodX81JhC/OGMW7e9/dxV/YJfdbqV1
         8COrWe2WB+BrBciC5m73hh7DLh9o+Wigbaizpdek3w8RfG/VwuwWAG0MxvenAZ7Phlzz
         jHJ7FByqV5Kif0sMOI4jhwnw4nWxBT/l/TwtBn2t6GfS+Ncqia2jtVVX0Utke6YaevCW
         zF8eZtw7q78O3mCHlI1LQ/BQ0kewDPlZKYqmyx2s7dw+oCvB39MocFjDRYcrGroraGfF
         /FPyqmgtpwcjkIGrlXfUo1V3Cx81QGlQVDhyC1/z18Qu/JZ+SHLIslV4aec8oV+ZGCkz
         iTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688747944; x=1691339944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBpXki4u1X99CxTnYCWnJqotbifSeXm/9mqo4B1zoO4=;
        b=RBzD0WNyVyOYPIBQjXBqkImtQoGB/bP5zWShjsxtcGCA7kBz7zggAeQ8EyZ7p3mMdV
         kM+bZgb+eTy13V0Jagln3eGBmQyZrOzmvCkhLX1mbEkToKK76v7sRmeGdGmZ4LH562Xx
         H3OsoUlVm5N0BFmHYDyWnE8jSuLqKbpec/qcfQLGT26ArVp2N1EagCitLKhRBmR/8zmI
         aURub4CHhMePtRN6Lf/FWWh1jI1Xt2WsUr/c1VP0ff6nul5Glr5kzQwa4g3Zic+N0p7T
         nqL542ITAVPshfEczFBhIggsUi2FZQ5Tc9pOU9MM1KChtWhoJCEgoizGTjQIOiRADJYa
         vcAQ==
X-Gm-Message-State: ABy/qLZCodqYwY5YV/AeLCt7PGHThlW2RaQDiGLdL1Te1985vyeV8QhU
        CuV0raXb5xp2yVQK3jNupVnXbSbn8MZLVdiq
X-Google-Smtp-Source: APBJJlHT/l/Ob7ORmQyBHvvpmoKmd9F+aGnyTkOUqPlzUuMkKi6g4H0B9x+R3MSaLBeWoidELJODZA==
X-Received: by 2002:a05:6870:5b84:b0:1b0:1c15:3f16 with SMTP id em4-20020a0568705b8400b001b01c153f16mr7136788oab.52.1688747943359;
        Fri, 07 Jul 2023 09:39:03 -0700 (PDT)
Received: from fedora ([121.135.181.61])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090a3d0d00b00262eb0d141esm1885157pjc.28.2023.07.07.09.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:39:02 -0700 (PDT)
Date:   Sat, 8 Jul 2023 01:38:52 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-mm@kvack.org
Subject: [BUG mm-unstable] BUG: KASAN: use-after-free in
 shrink_folio_list+0x9f4/0x1ae0
Message-ID: <ZKg/J3OG3kQ9ynSO@fedora>
References: <20230628104852.3391651-1-dhowells@redhat.com>
 <20230628104852.3391651-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AHQ8Dlxzo78Yy+15"
Content-Disposition: inline
In-Reply-To: <20230628104852.3391651-3-dhowells@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--AHQ8Dlxzo78Yy+15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 11:48:52AM +0100, David Howells wrote:
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

Hi David,

I was bisecting a use-after-free BUG on the latest mm-unstable,
where HEAD is 347e208de0e4 ("rmap: pass the folio to __page_check_anon_rmap()").

According to my bisection, this is the first bad commit.
Use-After-Free is triggered on reclamation path when swap is enabled.
(and couldn't trigger without swap enabled)

the config, KASAN splat, bisect log are attached.
hope this isn't too late :(

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
>     ver #7)
>      - Make NFS set AS_RELEASE_ALWAYS.
>     
>     ver #4)
>      - Split out merging of folio_has_private()/filemap_release_folio() call
>        pairs into a preceding patch.
>      - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
>     
>     ver #3)
>      - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
>      - Moved a '&&' to the correct line.
>     
>     ver #2)
>      - Rewrote entirely according to Willy's suggestion[1].
> 
>  fs/9p/cache.c           |  2 ++
>  fs/afs/internal.h       |  2 ++
>  fs/cachefiles/namei.c   |  2 ++
>  fs/ceph/cache.c         |  2 ++
>  fs/nfs/fscache.c        |  3 +++
>  fs/smb/client/fscache.c |  2 ++
>  include/linux/pagemap.h | 16 ++++++++++++++++
>  mm/internal.h           |  5 ++++-
>  8 files changed, 33 insertions(+), 1 deletion(-)
> 
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
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 9d3d64921106..da73b97e19a9 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -681,6 +681,8 @@ static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
>  {
>  #ifdef CONFIG_AFS_FSCACHE
>  	vnode->netfs.cache = cookie;
> +	if (cookie)
> +		mapping_set_release_always(vnode->netfs.inode.i_mapping);
>  #endif
>  }
>  
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index d9d22d0ec38a..7bf7a5fcc045 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -585,6 +585,8 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
>  	if (ret < 0)
>  		goto check_failed;
>  
> +	clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &object->cookie->flags);
> +
>  	object->file = file;
>  
>  	/* Always update the atime on an object we've just looked up (this is
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 177d8e8d73fe..de1dee46d3df 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -36,6 +36,8 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
>  				       &ci->i_vino, sizeof(ci->i_vino),
>  				       &ci->i_version, sizeof(ci->i_version),
>  				       i_size_read(inode));
> +	if (ci->netfs.cache)
> +		mapping_set_release_always(inode->i_mapping);
>  }
>  
>  void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info *ci)
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index 8c35d88a84b1..b05717fe0d4e 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -180,6 +180,9 @@ void nfs_fscache_init_inode(struct inode *inode)
>  					       &auxdata,      /* aux_data */
>  					       sizeof(auxdata),
>  					       i_size_read(inode));
> +
> +	if (netfs_inode(inode)->cache)
> +		mapping_set_release_always(inode->i_mapping);
>  }
>  
>  /*
> diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
> index 8f6909d633da..3677525ee993 100644
> --- a/fs/smb/client/fscache.c
> +++ b/fs/smb/client/fscache.c
> @@ -108,6 +108,8 @@ void cifs_fscache_get_inode_cookie(struct inode *inode)
>  				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
>  				       &cd, sizeof(cd),
>  				       i_size_read(&cifsi->netfs.inode));
> +	if (cifsi->netfs.cache)
> +		mapping_set_release_always(inode->i_mapping);
>  }
>  
>  void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update)
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a56308a9d1a4..a1176ceb4a0c 100644
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
> +	clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>  {
>  	return mapping->gfp_mask;
> diff --git a/mm/internal.h b/mm/internal.h
> index a76314764d8c..86aef26df905 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -175,7 +175,10 @@ static inline void set_page_refcounted(struct page *page)
>   */
>  static inline bool folio_needs_release(struct folio *folio)
>  {
> -	return folio_has_private(folio);
> +	struct address_space *mapping = folio->mapping;
> +
> +	return folio_has_private(folio) ||
> +		(mapping && mapping_release_always(mapping));
>  }
>  
>  extern unsigned long highest_memmap_pfn;
> 

--AHQ8Dlxzo78Yy+15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.decoded"
Content-Transfer-Encoding: quoted-printable

# swapon swap=0D
[    7.718310] Adding 6291452k swap on swap.  Priority:-2 extents:58 across=
:6716992k FS=0D
# stress-ng-=08=1B[J --bigheap 12=0D
stress-ng: info:  [297] defaulting to a 86400 second (1 day, 0.00 secs) run=
 per stressor=0D
stress-ng: info:  [297] dispatching hogs: 12 bigheap=0D
[   12.792516] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
[   12.793329] BUG: KASAN: use-after-free in shrink_folio_list (./arch/x86/=
include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-=
generic/bitops/instrumented-non-atomic.h:142 ./include/linux/pagemap.h:279 =
mm/internal.h:187 mm/vmscan.c:2067)=20
[   12.794005] Read of size 8 at addr ffff8880053bd029 by task kswapd0/108=
=0D
[   12.794679] =0D
[   12.795372] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.796097] Call Trace:=0D
[   12.796341]  <TASK>=0D
[   12.796586] dump_stack_lvl (lib/dump_stack.c:107)=20
[   12.796948] print_report (mm/kasan/report.c:365 (discriminator 1) mm/kas=
an/report.c:475 (discriminator 1))=20
[   12.797378] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   12.797961] ? folio_referenced (mm/rmap.c:918)=20
[   12.798521] stack segment: 0000 [#1] PREEMPT SMP KASAN NOPTI=0D
[   12.798787] ? __virt_addr_valid (./include/linux/mmzone.h:1908 (discrimi=
nator 1) ./include/linux/mmzone.h:2004 (discriminator 1) arch/x86/mm/physad=
dr.c:65 (discriminator 1))=20
[   12.799526] ? __phys_addr (arch/x86/mm/physaddr.h:7 arch/x86/mm/physaddr=
=2Ec:28)=20
[   12.799979] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.800234] ? shrink_folio_list (./arch/x86/include/asm/bitops.h:207 ./a=
rch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-=
non-atomic.h:142 ./include/linux/pagemap.h:279 mm/internal.h:187 mm/vmscan.=
c:2067)=20
[   12.800833] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   12.801134] kasan_report (mm/kasan/report.c:590)=20
[ 12.801498] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   12.801749] ? shrink_folio_list (./arch/x86/include/asm/bitops.h:207 ./a=
rch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-=
non-atomic.h:142 ./include/linux/pagemap.h:279 mm/internal.h:187 mm/vmscan.=
c:2067)=20
[   12.802997] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   12.803299] kasan_check_range (mm/kasan/generic.c:173 (discriminator 1) =
mm/kasan/generic.c:187 (discriminator 1))=20
[   12.803472] =0D
[   12.803826] shrink_folio_list (./arch/x86/include/asm/bitops.h:207 ./arc=
h/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-no=
n-atomic.h:142 ./include/linux/pagemap.h:279 mm/internal.h:187 mm/vmscan.c:=
2067)=20
[   12.804103] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   12.804213] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   12.804509] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   12.804995] ? lruvec_is_sizable (mm/vmscan.c:4557 (discriminator 1))=20
[   12.805325] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   12.805820] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   12.806112] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   12.806612] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169)=
=20
[   12.806899] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   12.807385] ? __pfx___call_rcu_common.constprop.0 (kernel/rcu/tree.c:262=
3)=20
[   12.807709] FS:  00007f5484d60cc0(0000) GS:ffff888036180000(0000) knlGS:=
0000000000000000=0D
[   12.808194] evict_folios (mm/vmscan.c:5182)=20
[   12.808595] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.809150] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   12.809508] CR2: 00007f5483ad5010 CR3: 0000000006d2c000 CR4: 00000000000=
006e0=0D
[   12.809916] ? __pfx_prune_icache_sb (fs/inode.c:890)=20
[   12.810200] Call Trace:=0D
[   12.810690] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   12.810990]  <TASK>=0D
[   12.811161] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   12.811507] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   12.811664] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   12.811955] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   12.812156] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   12.812497] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   12.812732] shrink_one (mm/vmscan.c:5403)=20
[   12.812999] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   12.813270] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   12.813522] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   12.813795] ? sched_clock_cpu (kernel/sched/clock.c:394 (discriminator 1=
))=20
[   12.814048] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   12.814356] ? record_times (kernel/sched/psi.c:771)=20
[   12.814635] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   12.814940] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   12.815189] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   12.815489] ? pgdat_balanced (./arch/x86/include/asm/atomic64_64.h:15 ./=
include/linux/atomic/atomic-arch-fallback.h:2560 ./include/linux/atomic/ato=
mic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:3161 ./include/l=
inux/mmzone.h:1006 ./include/linux/mmzone.h:1482 mm/vmscan.c:7217)=20
[   12.815764] ? __mem_cgroup_uncharge_list (mm/memcontrol.c:7192)=20
[   12.816074] balance_pgdat (mm/vmscan.c:7324 mm/vmscan.c:7505)=20
[   12.816347] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169)=
=20
[   12.816683] ? record_times (kernel/sched/psi.c:771)=20
[   12.816941] evict_folios (mm/vmscan.c:5182)=20
[   12.817260] ? __pfx_balance_pgdat (mm/vmscan.c:7376)=20
[   12.817523] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   12.817768] ? finish_task_switch.isra.0 (./arch/x86/include/asm/paravirt=
=2Eh:700 kernel/sched/sched.h:1378 kernel/sched/core.c:5133 kernel/sched/co=
re.c:5251)=20
[   12.818059] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   12.818349] ? __switch_to (./include/linux/thread_info.h:127 (discrimina=
tor 2) arch/x86/kernel/process.h:17 (discriminator 2) arch/x86/kernel/proce=
ss_64.c:629 (discriminator 2))=20
[   12.818689] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   12.819025] ? __schedule (kernel/sched/core.c:6592)=20
[   12.819287] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   12.819641] ? lock_timer_base (kernel/time/timer.c:1000)=20
[   12.819900] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   12.820178] ? __pfx___timer_delete_sync (kernel/time/timer.c:1544)=20
[   12.820458] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   12.820804] ? set_pgdat_percpu_threshold (mm/vmstat.c:332 (discriminator=
 1))=20
[   12.821125] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   12.821430] ? finish_wait (./include/linux/list.h:329 (discriminator 4) =
kernel/sched/wait.c:409 (discriminator 4))=20
[   12.821772] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   12.822100] kswapd (mm/vmscan.c:7765)=20
[   12.822354] shrink_one (mm/vmscan.c:5403)=20
[   12.822624] ? __pfx_kswapd (mm/vmscan.c:7698)=20
[   12.822837] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   12.823075] ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:11=
5 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (dis=
criminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discrimina=
tor 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/li=
nux/spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:111=
 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4))=20
[   12.823333] ? __kernel_text_address (kernel/extable.c:79 (discriminator =
1))=20
[   12.823597] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:418)=
=20
[   12.823906] ? unwind_get_return_address (arch/x86/kernel/unwind_orc.c:36=
9 (discriminator 1))=20
[   12.824208] ? __pfx_set_cpus_allowed_ptr (kernel/sched/core.c:3194)=20
[   12.824570] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   12.824888] ? __pfx_kswapd (mm/vmscan.c:7698)=20
[   12.825217] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   12.825502] kthread (kernel/kthread.c:389)=20
[   12.825750] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   12.826072] ? __pfx_kthread (kernel/kthread.c:342)=20
[   12.826307] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   12.826571] ret_from_fork (arch/x86/entry/entry_64.S:314)=20
[   12.826826] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   12.827122]  </TASK>=0D
[   12.827368] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   12.827699] =0D
[   12.827853] try_to_free_pages (mm/vmscan.c:7060)=20
[   12.828174] The buggy address belongs to the physical page:=0D
[   12.828284] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   12.828572] page:(____ptrval____) refcount:0 mapcount:-128 mapping:00000=
00000000000 index:0x0 pfn:0x53bd=0D
[   12.828944] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   12.829253] flags: 0xfffffc0000000(node=3D0|zone=3D1|lastcpupid=3D0x1fff=
ff)=0D
[   12.829887] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   12.830156] page_type: 0xffffff7f(buddy)=0D
[   12.830600] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   12.830978] raw: 000fffffc0000000 ffffea000009a688 ffffea0000104608 0000=
000000000000=0D
[   12.831239] ? mas_destroy (lib/maple_tree.c:5606)=20
[   12.831662] raw: 0000000000000000 0000000000000000 00000000ffffff7f 0000=
000000000000=0D
[   12.832171] ? mas_store_prealloc (lib/maple_tree.c:5524)=20
[   12.832430] page dumped because: kasan: bad access detected=0D
[   12.832945] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   12.833234] =0D
[   12.833235] Memory state around the buggy address:=0D
[   12.833618] ? rb_next (lib/rbtree.c:503)=20
[   12.833959]  ffff8880053bcf00: 00 00 00 00 00 00 00 00 fc fc fc fc fc 00=
 00 00=0D
[   12.834067] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   12.834399]  ffff8880053bcf80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc=
 fc fc=0D
[   12.834625] __alloc_pages (mm/page_alloc.c:4526)=20
[   12.834631] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   12.834637] ? userfaultfd_unmap_complete (fs/userfaultfd.c:878)=20
[   12.834644] ? avc_has_perm_noaudit (security/selinux/avc.c:1159)=20
[   12.835127] >ffff8880053bd000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff ff=0D
[   12.835470] __folio_alloc (mm/page_alloc.c:4548)=20
[   12.835915]                                   ^=0D
[   12.836114] vma_alloc_folio (./include/linux/mempolicy.h:75 (discriminat=
or 1) ./include/linux/mempolicy.h:80 (discriminator 1) mm/mempolicy.c:2241 =
(discriminator 1))=20
[   12.836389]  ffff8880053bd080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff ff=0D
[   12.836648] ? __pfx_vma_alloc_folio (mm/mempolicy.c:2162)=20
[   12.836913]  ffff8880053bd100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff ff=0D
[   12.837298] ? __pte_offset_map (./arch/x86/include/asm/pgtable.h:816 (di=
scriminator 2) ./include/linux/pgtable.h:92 (discriminator 2) ./include/lin=
ux/pgtable.h:107 (discriminator 2) mm/pgtable-generic.c:251 (discriminator =
2))=20
[   12.837526] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
[   12.837765] do_anonymous_page (mm/memory.c:4110)=20
[   12.856683] __handle_mm_fault (mm/memory.c:3667 mm/memory.c:4945 mm/memo=
ry.c:5085)=20
[   12.857012] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   12.857350] ? find_vma (mm/mmap.c:1861)=20
[   12.857621] ? __pfx_find_vma (mm/mmap.c:1861)=20
[   12.857906] handle_mm_fault (mm/memory.c:5250)=20
[   12.858201] do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   12.858532] exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x=
86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   12.858815] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   12.859120] RIP: 0033:0x55868cae5bb6=0D
[ 12.859401] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   12.860651] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   12.861017] RAX: 0000000000000000 RBX: 0000000002dd0000 RCX: 00000000000=
00001=0D
[   12.861502] RDX: 0000000000000000 RSI: 00007f5483ad5010 RDI: 00000000001=
8db5b=0D
[   12.861981] RBP: 00007f5480d15010 R08: 000000037b4d480c R09: 00000000000=
00000=0D
[   12.862466] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   12.862939] R13: 00007f5480d15010 R14: 00007f5483ad5010 R15: 00007fff9ae=
412d0=0D
[   12.863419]  </TASK>=0D
[   12.863617] Modules linked in:=0D
[   12.863891] ---[ end trace 0000000000000000 ]---=0D
[   12.864245] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 12.864636] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   12.865908] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   12.866319] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   12.866835] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   12.867352] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   12.867857] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   12.868373] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   12.868881] FS:  00007f5484d60cc0(0000) GS:ffff888036180000(0000) knlGS:=
0000000000000000=0D
[   12.869500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.869925] CR2: 00007f5483ad5010 CR3: 0000000006d2c000 CR4: 00000000000=
006e0=0D
[   12.870474] ------------[ cut here ]------------=0D
[   12.870830] WARNING: CPU: 7 PID: 320 at kernel/exit.c:818 do_exit (kerne=
l/exit.c:818 (discriminator 1))=20
[   12.871432] Modules linked in:=0D
[   12.872333] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.872989] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[ 12.873336] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   12.874628] RSP: 0018:ffff88800e687e60 EFLAGS: 00010286=0D
[   12.875026] RAX: 0000000000000000 RBX: ffff888004820000 RCX: ffffffffa81=
71c65=0D
[   12.875550] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880048=
20d08=0D
[   12.876046] RBP: ffff88800e679400 R08: 0000000000000001 R09: ffffed1001c=
d0fc1=0D
[   12.876576] R10: 0000000000000003 R11: 0000000000000001 R12: 00000000000=
0000b=0D
[   12.877083] R13: ffff888004820c20 R14: ffff88800e671180 R15: 00000000000=
00007=0D
[   12.877251] stack segment: 0000 [#2] PREEMPT SMP KASAN NOPTI=0D
[   12.877674] FS:  00007f5484d60cc0(0000) GS:ffff888036180000(0000) knlGS:=
0000000000000000=0D
[   12.878135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.878137] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   12.878535] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[ 12.878962] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   12.879392] CR2: 00007f5483ad5010 CR3: 0000000006d2c000 CR4: 00000000000=
006e0=0D
[   12.879637] RSP: 0018:ffff888005927040 EFLAGS: 00010282=0D
[   12.879915] Call Trace:=0D
[   12.881195] =0D
[   12.881198] RAX: 0000000000000000 RBX: ffffea0000384580 RCX: 00000000000=
00000=0D
[   12.881200] RDX: ffff888006992880 RSI: 0000000000000008 RDI: ffff8880059=
27008=0D
[   12.881203] RBP: d8ffff888004e19d R08: 1ffff110009c3204 R09: fffff940000=
708b0=0D
[   12.881205] R10: ffffea0000384587 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   12.881207] R13: ffff888004e18f69 R14: ffff888004e18f69 R15: ffff888004e=
19029=0D
[   12.881211] FS:  00007f5484d60cc0(0000) GS:ffff888036080000(0000) knlGS:=
0000000000000000=0D
[   12.881214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.881216] CR2: 00007f54839af010 CR3: 0000000007880000 CR4: 00000000000=
006e0=0D
[   12.881220] Call Trace:=0D
[   12.881784]  <TASK>=0D
[   12.882142]  <TASK>=0D
[   12.882145] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   12.882357] ? __warn (kernel/panic.c:673)=20
[   12.882444] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   12.883007] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.883466] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   12.883474] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   12.884031] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   12.884454] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   12.884462] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   12.885037] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   12.885490] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   12.885497] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   12.885501] ? sysvec_call_function_single (arch/x86/kernel/smp.c:287 (di=
scriminator 3))=20
[   12.885957] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   12.886336] ? __mem_cgroup_uncharge_list (mm/memcontrol.c:7192)=20
[   12.886536] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   12.886673] ? __count_memcg_events (mm/memcontrol.c:913 (discriminator 8=
0))=20
[   12.886854] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.887014] evict_folios (mm/vmscan.c:5182)=20
[   12.887267] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.887445] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   12.887719] ? handle_mm_fault (mm/memory.c:5250)=20
[   12.887904] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   12.888246] ? __pfx_do_exit (kernel/exit.c:810)=20
[   12.888435] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   12.888795] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   12.889112] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:425 (discrimin=
ator 2))=20
[   12.889120] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   12.889420] make_task_dead (kernel/exit.c:972)=20
[   12.889629] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   12.890009] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   12.890257] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   12.890264] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   12.890607] rewind_stack_and_make_dead (??:?)=20
[   12.890868] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   12.891212] RIP: 0033:0x55868cae5bb6=0D
[   12.891439] shrink_one (mm/vmscan.c:5403)=20
[ 12.891727] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   12.891905] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   12.892196] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   12.892533] ? bpf_ksym_find (./include/linux/rbtree_latch.h:118 (discrim=
inator 2) ./include/linux/rbtree_latch.h:208 (discriminator 2) kernel/bpf/c=
ore.c:686 (discriminator 2))=20
[   12.892873] =0D
[   12.892875] RAX: 0000000000000000 RBX: 0000000002dd0000 RCX: 00000000000=
00001=0D
[   12.893145] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:425 (discrimin=
ator 2))=20
[   12.893151] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   12.893154] ? kernel_text_address (kernel/extable.c:125 (discriminator 1=
) kernel/extable.c:94 (discriminator 1))=20
[   12.893472] RDX: 0000000000000000 RSI: 00007f5483ad5010 RDI: 00000000001=
8db5b=0D
[   12.893724] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   12.894098] RBP: 00007f5480d15010 R08: 000000037b4d480c R09: 00000000000=
00000=0D
[   12.894307] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   12.894644] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   12.894830] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   12.895271] R13: 00007f5480d15010 R14: 00007f5483ad5010 R15: 00007fff9ae=
412d0=0D
[   12.895467] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   12.895838]  </TASK>=0D
[   12.896072] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   12.896496] ---[ end trace 0000000000000000 ]---=0D
[   12.896679] try_to_free_pages (mm/vmscan.c:7060)=20
[   12.919416] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   12.919908] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   12.920341] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   12.920912] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   12.921522] ? __mem_cgroup_uncharge_list (mm/memcontrol.c:7192)=20
[   12.922029] ? __pfx___mem_cgroup_uncharge_list (mm/memcontrol.c:7187)=20
[   12.922583] ? kmem_cache_free (mm/slub.c:1818 (discriminator 2) mm/slub.=
c:3801 (discriminator 2) mm/slub.c:3823 (discriminator 2))=20
[   12.923012] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   12.923531] ? __mod_memcg_lruvec_state (mm/memcontrol.c:628 (discriminat=
or 4) mm/memcontrol.c:619 (discriminator 4) mm/memcontrol.c:826 (discrimina=
tor 4))=20
[   12.924019] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   12.924580] __alloc_pages (mm/page_alloc.c:4526)=20
[   12.924984] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   12.925444] ? __pfx_release_pages (mm/swap.c:961)=20
[   12.925898] ? __pfx_lru_add_fn (mm/swap.c:164)=20
[   12.926335] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   12.926854] ? __pfx_lru_add_fn (mm/swap.c:164)=20
[   12.927283] ? lru_add_fn (./include/linux/mm_inline.h:317 (discriminator=
 1) mm/swap.c:199 (discriminator 1))=20
[   12.927691] __folio_alloc (mm/page_alloc.c:4548)=20
[   12.928085] vma_alloc_folio (./include/linux/mempolicy.h:75 (discriminat=
or 1) ./include/linux/mempolicy.h:80 (discriminator 1) mm/mempolicy.c:2241 =
(discriminator 1))=20
[   12.928513] ? __pfx_vma_alloc_folio (mm/mempolicy.c:2162)=20
[   12.928976] ? set_pte (./arch/x86/include/asm/paravirt.h:436)=20
[   12.929360] ? __pfx_set_pte (./arch/x86/include/asm/paravirt.h:435)=20
[   12.929773] ? __pte_offset_map (./arch/x86/include/asm/pgtable.h:816 (di=
scriminator 2) ./include/linux/pgtable.h:92 (discriminator 2) ./include/lin=
ux/pgtable.h:107 (discriminator 2) mm/pgtable-generic.c:251 (discriminator =
2))=20
[   12.930222] do_anonymous_page (mm/memory.c:4110)=20
[   12.930667] __handle_mm_fault (mm/memory.c:3667 mm/memory.c:4945 mm/memo=
ry.c:5085)=20
[   12.931120] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   12.931613] ? find_vma (mm/mmap.c:1861)=20
[   12.931988] ? __pfx_find_vma (mm/mmap.c:1861)=20
[   12.932415] handle_mm_fault (mm/memory.c:5250)=20
[   12.932841] do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   12.933288] exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x=
86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   12.933701] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   12.934130] RIP: 0033:0x55868cae5bb6=0D
[ 12.934532] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   12.936251] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   12.936790] RAX: 0000000000009000 RBX: 0000000003970000 RCX: 00000000000=
00001=0D
[   12.937483] RDX: 0000000000000000 RSI: 00007f548167d010 RDI: 00000000001=
7f8cb=0D
[   12.938156] RBP: 00007f547dd14010 R08: 000000037b4c43fe R09: 00000000000=
00000=0D
[   12.938849] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   12.939538] R13: 00007f547dd14010 R14: 00007f5481674010 R15: 00007fff9ae=
412d0=0D
[   12.940217]  </TASK>=0D
[   12.940511] Modules linked in:=0D
[   12.940866] BUG: unable to handle page fault for address: 00000000000028=
08=0D
[   12.940910] ---[ end trace 0000000000000000 ]---=0D
[   12.941329] #PF: supervisor write access in kernel mode=0D
[   12.941332] #PF: error_code(0x0002) - not-present page=0D
[   12.941334] PGD 0 P4D 0 =0D
[   12.941338] Oops: 0002 [#3] PREEMPT SMP KASAN NOPTI=0D
[   12.941771] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 12.942443] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   12.942561] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.942564] RIP: 0010:__blk_flush_plug (./include/linux/list.h:449 ./inc=
lude/linux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   12.942902] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[ 12.943266] Code: 39 04 24 0f 84 d0 00 00 00 4d 8b 65 18 48 8b 7c 24 10 48=
 8b 6c 24 48 e8 90 b4 a7 ff 49 8d 7c 24 08 49 8b 5d 20 e8 32 b5 a7 ff <4d> =
89 74 24 08 48 89 df 4c 89 64 24 48 e8 20 b5 a7 ff 48 89 2b 48=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	39 04 24             	cmp    %eax,(%rsp)
   3:	0f 84 d0 00 00 00    	je     0xd9
   9:	4d 8b 65 18          	mov    0x18(%r13),%r12
   d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  12:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
  17:	e8 90 b4 a7 ff       	call   0xffffffffffa7b4ac
  1c:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  21:	49 8b 5d 20          	mov    0x20(%r13),%rbx
  25:	e8 32 b5 a7 ff       	call   0xffffffffffa7b55c
  2a:*	4d 89 74 24 08       	mov    %r14,0x8(%r12)		<-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
  37:	e8 20 b5 a7 ff       	call   0xffffffffffa7b55c
  3c:	48 89 2b             	mov    %rbp,(%rbx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
   5:	48 89 df             	mov    %rbx,%rdi
   8:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
   d:	e8 20 b5 a7 ff       	call   0xffffffffffa7b532
  12:	48 89 2b             	mov    %rbp,(%rbx)
  15:	48                   	rex.W
[   12.943270] RSP: 0018:ffff88800e6879b8 EFLAGS: 00010282=0D
[   12.943273] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000000=
00000=0D
[   12.943848] =0D
[   12.944929] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87980=0D
[   12.944932] RBP: ffff88800e687a00 R08: 0000000000000000 R09: ffffed1000a=
56197=0D
[   12.944934] R10: ffff8880052b0cbf R11: 0000000000000001 R12: 00000000000=
02800=0D
[   12.944936] R13: ffff88800e687650 R14: ffff88800e687a00 R15: dead0000000=
00100=0D
[   12.944940] FS:  0000000000000000(0000) GS:ffff888036180000(0000) knlGS:=
0000000000000000=0D
[   12.945566] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   12.945821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.946194] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   12.947207] CR2: 0000000000002808 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   12.947212] Call Trace:=0D
[   12.947213]  <TASK>=0D
[   12.947215] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[   12.947589] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   12.947975] ? page_fault_oops (arch/x86/mm/fault.c:707 (discriminator 1)=
)=20
[   12.948106] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   12.948494] ? __pfx_is_prefetch.isra.0 (arch/x86/mm/fault.c:122)=20
[   12.948980] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   12.949365] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:635)=20
[   12.949368] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   12.949868] FS:  00007f5484d60cc0(0000) GS:ffff888036080000(0000) knlGS:=
0000000000000000=0D
[   12.950310] ? search_bpf_extables (kernel/bpf/core.c:737)=20
[   12.950316] ? fixup_exception (arch/x86/mm/extable.c:254)=20
[   12.950875] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.951195] ? release_pages (mm/swap.c:961)=20
[   12.951204] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   12.951583] CR2: 00007f54839af010 CR3: 0000000007880000 CR4: 00000000000=
006e0=0D
[   12.951943] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   12.952102] ------------[ cut here ]------------=0D
[   12.952182] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   12.952346] WARNING: CPU: 5 PID: 305 at kernel/exit.c:818 do_exit (kerne=
l/exit.c:818 (discriminator 1))=20
[   12.952679] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   12.952873] Modules linked in:=0D
[   12.953203] ? __pfx___blk_flush_plug (block/blk-core.c:1144)=20
[   12.953207] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   12.953439] =0D
[   12.953770] schedule (./arch/x86/include/asm/current.h:41 (discriminator=
 1) ./include/linux/thread_info.h:185 (discriminator 1) ./include/linux/sch=
ed.h:2240 (discriminator 1) kernel/sched/core.c:6788 (discriminator 1))=20
[   12.954191] schedule_preempt_disabled (./arch/x86/include/asm/preempt.h:=
80 (discriminator 10) kernel/sched/core.c:6846 (discriminator 10))=20
[   12.954194] rwsem_down_write_slowpath (./include/linux/instrumented.h:96=
 kernel/locking/rwsem.c:1180)=20
[   12.954579] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.954785] ? __pfx_rwsem_down_write_slowpath (kernel/locking/rwsem.c:11=
08)=20
[   12.954973] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.955248] ? down_trylock (kernel/locking/semaphore.c:145)=20
[ 12.955444] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   12.955661] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem=
=2Ec:1315 kernel/locking/rwsem.c:1574)=20
[   12.956205] RSP: 0018:ffff888005927e60 EFLAGS: 00010286=0D
[   12.956494] ? __pfx_down_write (kernel/locking/rwsem.c:1571)=20
[   12.956850] =0D
[   12.957138] exit_mmap (./arch/x86/include/asm/jump_label.h:27 ./include/=
linux/jump_label.h:207 ./include/linux/mmap_lock.h:35 ./include/linux/mmap_=
lock.h:95 mm/mmap.c:3207)=20
[   12.957144] ? __pfx_exit_mmap (mm/mmap.c:3174)=20
[   12.957702] RAX: 0000000000000000 RBX: ffff888006992880 RCX: ffffffffa81=
71c65=0D
[   12.957977] ? task_cputime (kernel/sched/cputime.c:860)=20
[   12.958231] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880069=
93588=0D
[   12.958509] ? delayed_uprobe_remove.part.0 (kernel/events/uprobes.c:325)=
=20
[   12.958725] RBP: ffff88800482f300 R08: 0000000000000001 R09: ffffed1000b=
24fc1=0D
[   12.958835] __mmput (kernel/fork.c:1354)=20
[   12.958989] R10: 0000000000000003 R11: 617254206c6c6143 R12: 00000000000=
0000b=0D
[   12.959472] do_exit (./include/linux/instrumented.h:68 ./include/asm-gen=
eric/bitops/instrumented-non-atomic.h:141 ./include/linux/thread_info.h:118=
 kernel/exit.c:568 kernel/exit.c:861)=20
[   12.959478] ? __pfx_do_exit (kernel/exit.c:810)=20
[   12.959726] R13: ffff8880069934a0 R14: ffff88800580abc0 R15: 00000000000=
00007=0D
[   12.959971] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   12.960451] FS:  00007f5484d60cc0(0000) GS:ffff888036080000(0000) knlGS:=
0000000000000000=0D
[   12.960724] make_task_dead (kernel/exit.c:972)=20
[   12.960936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.961127] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   12.962140] CR2: 00007f54839af010 CR3: 0000000007880000 CR4: 00000000000=
006e0=0D
[   12.962329] rewind_stack_and_make_dead (??:?)=20
[   12.962599] Call Trace:=0D
[   12.962807] RIP: 0033:0x55868cae5bb6=0D
[   12.962890]  <TASK>=0D
[ 12.963066] Code: Unable to access opcode bytes at 0x55868cae5b8c.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   12.963279] ? __warn (kernel/panic.c:673)=20
[   12.963659] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   12.963858] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.964230] =0D
[   12.964231] RAX: 0000000000000000 RBX: 0000000002dd0000 RCX: 00000000000=
00001=0D
[   12.964233] RDX: 0000000000000000 RSI: 00007f5483ad5010 RDI: 00000000001=
8db5b=0D
[   12.964235] RBP: 00007f5480d15010 R08: 000000037b4d480c R09: 00000000000=
00000=0D
[   12.964521] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   12.964888] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   12.965053] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   12.965428] R13: 00007f5480d15010 R14: 00007f5483ad5010 R15: 00007fff9ae=
412d0=0D
[   12.965433]  </TASK>=0D
[   12.965434] Modules linked in:=0D
[   12.965615] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   12.965813] =0D
[   12.966196] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   12.966423] CR2: 0000000000002808=0D
[   12.966852] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.967046] ---[ end trace 0000000000000000 ]---=0D
[   12.967046] stack segment: 0000 [#4] PREEMPT SMP KASAN NOPTI=0D
[   12.967054] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.967056] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 12.967064] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   12.967067] RSP: 0018:ffff8880040174a8 EFLAGS: 00010282=0D
[   12.967071] RAX: 0000000000000000 RBX: ffffea0000d85a40 RCX: 00000000000=
00000=0D
[   12.967073] RDX: ffff888002a3a880 RSI: 0000000000000008 RDI: ffff8880040=
17470=0D
[   12.967076] RBP: a0ffff888003f702 R08: 1ffff11000ded804 R09: fffff940001=
b0b48=0D
[   12.967078] R10: ffffea0000d85a47 R11: 000000000000001d R12: 00000000000=
00cc0=0D
[   12.967081] R13: ffff888006f6bf69 R14: ffff888006f6bf69 R15: ffff888006f=
6c029=0D
[   12.967084] FS:  0000000000000000(0000) GS:ffff888036200000(0000) knlGS:=
0000000000000000=0D
[   12.967087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.967089] CR2: 00007f5483c44010 CR3: 0000000002328000 CR4: 00000000000=
006e0=0D
[   12.967092] Call Trace:=0D
[   12.967093]  <TASK>=0D
[   12.967095] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   12.967100] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   12.967106] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   12.967111] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   12.967116] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   12.967121] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   12.967126] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   12.967130] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   12.967136] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   12.967140] ? lruvec_is_sizable (mm/vmscan.c:4557 (discriminator 1))=20
[   12.967144] ? __mem_cgroup_uncharge_list (mm/memcontrol.c:7192)=20
[   12.967150] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   12.967156] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169)=
=20
[   12.967158] ? __pfx___call_rcu_common.constprop.0 (kernel/rcu/tree.c:262=
3)=20
[   12.967165] evict_folios (mm/vmscan.c:5182)=20
[   12.967169] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   12.967172] ? __pfx_prune_icache_sb (fs/inode.c:890)=20
[   12.967179] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   12.967184] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   12.967190] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   12.967193] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   12.967200] shrink_one (mm/vmscan.c:5403)=20
[   12.967206] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   12.967211] ? sched_clock_cpu (kernel/sched/clock.c:394 (discriminator 1=
))=20
[   12.967216] ? record_times (kernel/sched/psi.c:771)=20
[   12.967221] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   12.967227] ? pgdat_balanced (./arch/x86/include/asm/atomic64_64.h:15 ./=
include/linux/atomic/atomic-arch-fallback.h:2560 ./include/linux/atomic/ato=
mic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:3161 ./include/l=
inux/mmzone.h:1006 ./include/linux/mmzone.h:1482 mm/vmscan.c:7217)=20
[   12.967232] balance_pgdat (mm/vmscan.c:7324 mm/vmscan.c:7505)=20
[   12.967237] ? record_times (kernel/sched/psi.c:771)=20
[   12.967241] ? __pfx_balance_pgdat (mm/vmscan.c:7376)=20
[   12.967245] ? finish_task_switch.isra.0 (./arch/x86/include/asm/paravirt=
=2Eh:700 kernel/sched/sched.h:1378 kernel/sched/core.c:5133 kernel/sched/co=
re.c:5251)=20
[   12.967250] ? __switch_to (./include/linux/thread_info.h:127 (discrimina=
tor 2) arch/x86/kernel/process.h:17 (discriminator 2) arch/x86/kernel/proce=
ss_64.c:629 (discriminator 2))=20
[   12.967255] ? __schedule (kernel/sched/core.c:6592)=20
[   12.967258] ? lock_timer_base (kernel/time/timer.c:1000)=20
[   12.967265] ? __pfx___timer_delete_sync (kernel/time/timer.c:1544)=20
[   12.967274] ? set_pgdat_percpu_threshold (mm/vmstat.c:332 (discriminator=
 1))=20
[   12.967280] ? finish_wait (./include/linux/list.h:329 (discriminator 4) =
kernel/sched/wait.c:409 (discriminator 4))=20
[   12.967286] kswapd (mm/vmscan.c:7765)=20
[   12.967297] ? __pfx_kswapd (mm/vmscan.c:7698)=20
[   12.967300] ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:11=
5 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (dis=
criminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discrimina=
tor 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/li=
nux/spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:111=
 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4))=20
[   12.967304] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:418)=
=20
[   12.967308] ? __pfx_set_cpus_allowed_ptr (kernel/sched/core.c:3194)=20
[   12.967313] ? __pfx_kswapd (mm/vmscan.c:7698)=20
[   12.967316] kthread (kernel/kthread.c:389)=20
[   12.967320] ? __pfx_kthread (kernel/kthread.c:342)=20
[   12.967323] ret_from_fork (arch/x86/entry/entry_64.S:314)=20
[   12.967328]  </TASK>=0D
[   12.967329] Modules linked in:=0D
[   12.967356] ---[ end trace 0000000000000000 ]---=0D
[   12.967358] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.967362] ? handle_mm_fault (mm/memory.c:5250)=20
[   12.967366] ? __pfx_do_exit (kernel/exit.c:810)=20
[   12.967370] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   12.967374] make_task_dead (kernel/exit.c:972)=20
[   12.967377] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   12.967380] rewind_stack_and_make_dead (??:?)=20
[   12.967386] RIP: 0033:0x55868cae5bb6=0D
[ 12.967389] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   12.967392] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   12.967395] RAX: 0000000000009000 RBX: 0000000003970000 RCX: 00000000000=
00001=0D
[   12.967397] RDX: 0000000000000000 RSI: 00007f548167d010 RDI: 00000000001=
7f8cb=0D
[   12.967398] RBP: 00007f547dd14010 R08: 000000037b4c43fe R09: 00000000000=
00000=0D
[   12.967400] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   12.967402] R13: 00007f547dd14010 R14: 00007f5481674010 R15: 00007fff9ae=
412d0=0D
[   12.967406]  </TASK>=0D
[   12.967407] ---[ end trace 0000000000000000 ]---=0D
[   12.967596] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   12.968098] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 12.968336] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[ 12.968461] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   12.968634] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   12.968738] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   12.969025] =0D
[   12.969191] =0D
[   12.969482] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   12.969699] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   12.969783] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   12.970155] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   12.970487] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   12.970490] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   12.970826] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   12.971000] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   12.971354] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   12.971516] FS:  0000000000000000(0000) GS:ffff888036180000(0000) knlGS:=
0000000000000000=0D
[   12.971852] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   12.971959] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.972116] FS:  0000000000000000(0000) GS:ffff888036200000(0000) knlGS:=
0000000000000000=0D
[   12.972379] CR2: 0000000000002808 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   12.972462] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.972464] CR2: 00007f5483c44010 CR3: 0000000002328000 CR4: 00000000000=
006e0=0D
[   12.972684] note: stress-ng-bighe[320] exited with irqs disabled=0D
[   12.972858] ------------[ cut here ]------------=0D
[   12.973053] Fixing recursive fault but reboot is needed!=0D
[   12.973304] WARNING: CPU: 8 PID: 108 at kernel/exit.c:818 do_exit (kerne=
l/exit.c:818 (discriminator 1))=20
[   12.973720] BUG: scheduling while atomic: stress-ng-bighe/320/0x00000000=
=0D
[   12.974126] Modules linked in:=0D
[   12.974720] Modules linked in:=0D
[   12.974966] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.976125] =0D
[   12.976410] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.976806] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[ 12.977164] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   12.977504] Call Trace:=0D
[   12.977847] RSP: 0018:ffff888004017e60 EFLAGS: 00010286=0D
[   12.978179]  <TASK>=0D
[   12.978182] dump_stack_lvl (lib/dump_stack.c:107)=20
[   12.978567] =0D
[   12.978842] __schedule_bug (kernel/sched/core.c:5936)=20
[   12.979179] RAX: 0000000000000000 RBX: ffff888002a3a880 RCX: ffffffffa81=
71c65=0D
[   12.979301] __schedule (./arch/x86/include/asm/preempt.h:35 (discriminat=
or 1) kernel/sched/core.c:5963 (discriminator 1) kernel/sched/core.c:6604 (=
discriminator 1))=20
[   12.979407] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888002a=
3b588=0D
[   12.979550] ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discr=
iminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discriminat=
or 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) .=
/include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spin=
lock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discri=
minator 4) kernel/locking/spinlock.c:154 (discriminator 4))=20
[   12.979713] RBP: ffff8880021db200 R08: 0000000000000001 R09: ffffed10008=
02fc1=0D
[   12.979894] ? vprintk_emit (./arch/x86/include/asm/paravirt.h:700 ./arch=
/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:1972 kernel/printk/p=
rintk.c:2306)=20
[   12.980093] R10: 0000000000000003 R11: 303030203a325243 R12: 00000000000=
0000b=0D
[   12.980303] ? vprintk_emit (kernel/printk/printk.c:2269)=20
[   12.980528] R13: ffff888002a3b4a0 R14: ffff888002a11a40 R15: 00000000000=
00007=0D
[   12.980749] ? __pfx_vprintk_emit (kernel/printk/printk.c:2269)=20
[   12.980954] FS:  0000000000000000(0000) GS:ffff888036200000(0000) knlGS:=
0000000000000000=0D
[   12.981190] ? __pfx___schedule (kernel/sched/core.c:6592)=20
[   12.981197] ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:11=
5 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (dis=
criminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discrimina=
tor 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/li=
nux/spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:111=
 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4))=20
[   12.981379] stack segment: 0000 [#5] PREEMPT SMP KASAN NOPTI=0D
[   12.981390] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.981392] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 12.981402] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   12.981406] RSP: 0018:ffff88800438f040 EFLAGS: 00010282=0D
[   12.981409] RAX: 0000000000000000 RBX: ffffea00003855c0 RCX: 00000000000=
00000=0D
[   12.981412] RDX: ffff8880024fd100 RSI: 0000000000000008 RDI: ffff8880043=
8f008=0D
[   12.981415] RBP: d8ffff888004e19d R08: 1ffff110009c3204 R09: fffff940000=
70ab8=0D
[   12.981418] R10: ffffea00003855c7 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   12.981420] R13: ffff888004e18f69 R14: ffff888004e18f69 R15: ffff888004e=
19029=0D
[   12.981425] FS:  00007f5484d60cc0(0000) GS:ffff888035f00000(0000) knlGS:=
0000000000000000=0D
[   12.981428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.981431] CR2: 00007f5480d04010 CR3: 0000000001d0e000 CR4: 00000000000=
006e0=0D
[   12.981434] Call Trace:=0D
[   12.981439]  <TASK>=0D
[   12.981440] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   12.981450] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   12.981459] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   12.981465] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   12.981474] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   12.981483] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   12.981489] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   12.981496] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   12.981501] ? sysvec_call_function (arch/x86/kernel/smp.c:278 (discrimin=
ator 3))=20
[   12.981505] ? __mem_cgroup_uncharge_list (mm/memcontrol.c:7192)=20
[   12.981515] ? __count_memcg_events (mm/memcontrol.c:913 (discriminator 8=
0))=20
[   12.981521] evict_folios (mm/vmscan.c:5182)=20
[   12.981525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.981527] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   12.981531] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   12.981540] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   12.981545] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:425 (discrimin=
ator 2))=20
[   12.981553] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   12.981557] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   12.981564] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   12.981572] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   12.981581] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   12.981585] shrink_one (mm/vmscan.c:5403)=20
[   12.981591] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   12.981597] ? __zone_watermark_ok (mm/page_alloc.c:2966)=20
[   12.981607] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   12.981612] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   12.981617] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   12.981625] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   12.981632] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   12.981637] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   12.981643] try_to_free_pages (mm/vmscan.c:7060)=20
[   12.981650] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   12.981657] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   12.981665] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   12.981675] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   12.981681] ? __mem_cgroup_uncharge_list (mm/memcontrol.c:7192)=20
[   12.981686] ? __pfx___mem_cgroup_uncharge_list (mm/memcontrol.c:7187)=20
[   12.981691] ? mas_destroy (lib/maple_tree.c:5606)=20
[   12.981698] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   12.981704] ? __mod_memcg_lruvec_state (mm/memcontrol.c:628 (discriminat=
or 4) mm/memcontrol.c:619 (discriminator 4) mm/memcontrol.c:826 (discrimina=
tor 4))=20
[   12.981708] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   12.981715] __alloc_pages (mm/page_alloc.c:4526)=20
[   12.981721] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   12.981726] ? __pfx_release_pages (mm/swap.c:961)=20
[   12.981732] ? __pfx_lru_add_fn (mm/swap.c:164)=20
[   12.981737] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   12.981742] ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discr=
iminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discriminat=
or 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) .=
/include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spin=
lock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discri=
minator 4) kernel/locking/spinlock.c:154 (discriminator 4))=20
[   12.981746] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)=20
[   12.981751] __folio_alloc (mm/page_alloc.c:4548)=20
[   12.981756] vma_alloc_folio (./include/linux/mempolicy.h:75 (discriminat=
or 1) ./include/linux/mempolicy.h:80 (discriminator 1) mm/mempolicy.c:2241 =
(discriminator 1))=20
[   12.981762] ? __pfx_vma_alloc_folio (mm/mempolicy.c:2162)=20
[   12.981766] ? set_pte (./arch/x86/include/asm/paravirt.h:436)=20
[   12.981772] ? __pfx_set_pte (./arch/x86/include/asm/paravirt.h:435)=20
[   12.981777] ? __pte_offset_map (./arch/x86/include/asm/pgtable.h:816 (di=
scriminator 2) ./include/linux/pgtable.h:92 (discriminator 2) ./include/lin=
ux/pgtable.h:107 (discriminator 2) mm/pgtable-generic.c:251 (discriminator =
2))=20
[   12.981784] do_anonymous_page (mm/memory.c:4110)=20
[   12.981791] __handle_mm_fault (mm/memory.c:3667 mm/memory.c:4945 mm/memo=
ry.c:5085)=20
[   12.981797] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   12.981803] ? find_vma (mm/mmap.c:1861)=20
[   12.981809] ? __pfx_find_vma (mm/mmap.c:1861)=20
[   12.981815] handle_mm_fault (mm/memory.c:5250)=20
[   12.981821] do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   12.981827] exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x=
86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   12.981832] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   12.981836] RIP: 0033:0x55868cae5bb6=0D
[ 12.981840] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   12.981843] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   12.981846] RAX: 000000000000a000 RBX: 0000000002ca0000 RCX: 00000000000=
00001=0D
[   12.981846] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   12.981852] do_task_dead (kernel/sched/core.c:6729)=20
[   12.981861] make_task_dead (./include/linux/refcount.h:201 ./include/lin=
ux/refcount.h:250 ./include/linux/refcount.h:267 kernel/exit.c:982)=20
[   12.981865] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   12.981870] rewind_stack_and_make_dead (??:?)=20
[   12.981875] RIP: 0033:0x55868cae5bb6=0D
[ 12.981878] Code: Unable to access opcode bytes at 0x55868cae5b8c.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   12.981880] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   12.981883] RAX: 0000000000000000 RBX: 0000000002dd0000 RCX: 00000000000=
00001=0D
[   12.981885] RDX: 0000000000000000 RSI: 00007f5483ad5010 RDI: 00000000001=
8db5b=0D
[   12.981888] RBP: 00007f5480d15010 R08: 000000037b4d480c R09: 00000000000=
00000=0D
[   12.981890] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   12.981892] R13: 00007f5480d15010 R14: 00007f5483ad5010 R15: 00007fff9ae=
412d0=0D
[   12.981896]  </TASK>=0D
[   12.982215] CR2: 00007f5483c44010 CR3: 0000000002328000 CR4: 00000000000=
006e0=0D
[   12.982596] RDX: 0000000000000000 RSI: 00007f54839af010 RDI: 00000000001=
72bcd=0D
[   12.982960] Call Trace:=0D
[   12.983205] RBP: 00007f5480d15010 R08: 000000037b4b58b1 R09: 00000000000=
00000=0D
[   12.983207] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   12.983210] R13: 00007f5480d15010 R14: 00007f54839a5010 R15: 00007fff9ae=
412d0=0D
[   12.983496]  <TASK>=0D
[   12.983789]  </TASK>=0D
[   12.984126] ? __warn (kernel/panic.c:673)=20
[   12.984421] Modules linked in:=0D
[   12.984737] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.984991] =0D
[   12.984993] BUG: unable to handle page fault for address: ffffffffaa8547=
a6=0D
[   12.985032] ---[ end trace 0000000000000000 ]---=0D
[   12.985038] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 12.985049] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   12.985053] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   12.985061] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   12.985067] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   12.985071] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   12.985076] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   12.985079] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   12.985095] FS:  00007f5484d60cc0(0000) GS:ffff888035f00000(0000) knlGS:=
0000000000000000=0D
[   12.985102] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.985108] CR2: 00007f5480d04010 CR3: 0000000001d0e000 CR4: 00000000000=
006e0=0D
[   12.985147] ------------[ cut here ]------------=0D
[   12.985149] WARNING: CPU: 2 PID: 307 at kernel/exit.c:818 do_exit (kerne=
l/exit.c:818 (discriminator 1))=20
[   12.985159] Modules linked in:=0D
[   12.985169] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.985174] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[ 12.985179] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   12.985186] RSP: 0018:ffff88800438fe60 EFLAGS: 00010286=0D
[   12.985189] RAX: 0000000000000000 RBX: ffff8880024fd100 RCX: ffffffffa81=
71c65=0D
[   12.985192] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880024=
fde08=0D
[   12.985194] RBP: ffff888005ca5000 R08: 0000000000000001 R09: ffffed10008=
71fc1=0D
[   12.985197] R10: 0000000000000003 R11: 00000000ffffffff R12: 00000000000=
0000b=0D
[   12.985199] R13: ffff8880024fdd20 R14: ffff888005cbd780 R15: 00000000000=
00007=0D
[   12.985208] FS:  00007f5484d60cc0(0000) GS:ffff888035f00000(0000) knlGS:=
0000000000000000=0D
[   12.985211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.985214] CR2: 00007f5480d04010 CR3: 0000000001d0e000 CR4: 00000000000=
006e0=0D
[   12.985218] Call Trace:=0D
[   12.985222]  <TASK>=0D
[   12.985226] ? __warn (kernel/panic.c:673)=20
[   12.985232] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   12.985245] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   12.985250] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   12.985255] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   12.985259] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.985264] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.985269] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:418)=
=20
[   12.985279] ? __pfx_do_exit (kernel/exit.c:810)=20
[   12.985285] make_task_dead (kernel/exit.c:972)=20
[   12.985296] rewind_stack_and_make_dead (??:?)=20
[   12.985300] RIP: 0000:0x0=0D
[ 12.985304] Code: Unable to access opcode bytes at 0xffffffffffffffd6.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   12.985306] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 000000=
0000000000=0D
[   12.985309] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000=0D
[   12.985311] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000=0D
[   12.985314] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000=0D
[   12.985315] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000=0D
[   12.985317] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   12.985321]  </TASK>=0D
[   12.985323] ---[ end trace 0000000000000000 ]---=0D
[   12.986056] #PF: supervisor write access in kernel mode=0D
[   12.986060] #PF: error_code(0x0003) - permissions violation=0D
[   12.986412] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.986660] PGD b059067 P4D b059067 =0D
[   12.986915] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   12.987286] PUD b05a063 PMD 800000000a8001e1 =0D
[   12.987299] Oops: 0003 [#6] PREEMPT SMP KASAN NOPTI=0D
[   12.987577] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   12.987827] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   12.988166] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   12.988541] RIP: 0010:__blk_flush_plug (./include/linux/list.h:449 ./inc=
lude/linux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   12.988805] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   12.988810] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[ 12.989064] Code: 39 04 24 0f 84 d0 00 00 00 4d 8b 65 18 48 8b 7c 24 10 48=
 8b 6c 24 48 e8 90 b4 a7 ff 49 8d 7c 24 08 49 8b 5d 20 e8 32 b5 a7 ff <4d> =
89 74 24 08 48 89 df 4c 89 64 24 48 e8 20 b5 a7 ff 48 89 2b 48=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	39 04 24             	cmp    %eax,(%rsp)
   3:	0f 84 d0 00 00 00    	je     0xd9
   9:	4d 8b 65 18          	mov    0x18(%r13),%r12
   d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  12:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
  17:	e8 90 b4 a7 ff       	call   0xffffffffffa7b4ac
  1c:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  21:	49 8b 5d 20          	mov    0x20(%r13),%rbx
  25:	e8 32 b5 a7 ff       	call   0xffffffffffa7b55c
  2a:*	4d 89 74 24 08       	mov    %r14,0x8(%r12)		<-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
  37:	e8 20 b5 a7 ff       	call   0xffffffffffa7b55c
  3c:	48 89 2b             	mov    %rbp,(%rbx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
   5:	48 89 df             	mov    %rbx,%rdi
   8:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
   d:	e8 20 b5 a7 ff       	call   0xffffffffffa7b532
  12:	48 89 2b             	mov    %rbp,(%rbx)
  15:	48                   	rex.W
[   12.989351] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   12.989677] RSP: 0018:ffff8880059279b8 EFLAGS: 00010246=0D
[   12.990023] ? handle_mm_fault (mm/memory.c:5250)=20
[   12.990273] =0D
[   12.990275] RAX: 0000000000000000 RBX: ffffffffa85a6a00 RCX: ffffffffa8b=
8cc6e=0D
[   12.990278] RDX: 0000000000000005 RSI: dffffc0000000000 RDI: ffffffffaa8=
547a6=0D
[   12.990281] RBP: ffff888005927a00 R08: 1ffffffff550a8f4 R09: ffffed10008=
61b57=0D
[   12.990510] ? __pfx_do_exit (kernel/exit.c:810)=20
[   12.990760] R10: ffff88800430dabf R11: 617254206c6c6143 R12: ffffffffaa8=
5479e=0D
[   12.991063] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   12.991425] R13: ffff888005927650 R14: ffff888005927a00 R15: dead0000000=
00100=0D
[   12.991430] FS:  0000000000000000(0000) GS:ffff888036080000(0000) knlGS:=
0000000000000000=0D
[   12.991761] make_task_dead (kernel/exit.c:972)=20
[   12.992005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   12.992234] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   12.992496] CR2: ffffffffaa8547a6 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   12.992738] rewind_stack_and_make_dead (??:?)=20
[   12.992892] Call Trace:=0D
[   12.993114] RIP: 0033:0x55868cae5bb6=0D
[   12.993436]  <TASK>=0D
[ 12.993680] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   12.993960] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[   12.994228] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   12.994535] ? page_fault_oops (arch/x86/mm/fault.c:707 (discriminator 1)=
)=20
[   12.994790] =0D
[   12.995051] ? __pfx_is_prefetch.isra.0 (arch/x86/mm/fault.c:122)=20
[   12.995381] RAX: 000000000000a000 RBX: 0000000002ca0000 RCX: 00000000000=
00001=0D
[   12.995631] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:635)=20
[   12.996884] RDX: 0000000000000000 RSI: 00007f54839af010 RDI: 00000000001=
72bcd=0D
[   12.997235] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   12.997729] RBP: 00007f5480d15010 R08: 000000037b4b58b1 R09: 00000000000=
00000=0D
[   12.998211] ? search_bpf_extables (kernel/bpf/core.c:737)=20
[   12.998711] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   12.999192] ? fixup_exception (arch/x86/mm/extable.c:254)=20
[   12.999201] ? exc_page_fault (arch/x86/mm/fault.c:1485 arch/x86/mm/fault=
=2Ec:1543)=20
[   12.999688] R13: 00007f5480d15010 R14: 00007f54839a5010 R15: 00007fff9ae=
412d0=0D
[   12.999844] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.000172]  </TASK>=0D
[   13.000527] ? __pfx___rmqueue_pcplist (mm/page_alloc.c:2761)=20
[   13.000876] ---[ end trace 0000000000000000 ]---=0D
[   13.002139] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.203823] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.204913] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.206033] ? __pfx___blk_flush_plug (block/blk-core.c:1144)=20
[   13.207229] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   13.208352] schedule (./arch/x86/include/asm/current.h:41 (discriminator=
 1) ./include/linux/thread_info.h:185 (discriminator 1) ./include/linux/sch=
ed.h:2240 (discriminator 1) kernel/sched/core.c:6788 (discriminator 1))=20
[   13.209251] schedule_preempt_disabled (./arch/x86/include/asm/preempt.h:=
80 (discriminator 10) kernel/sched/core.c:6846 (discriminator 10))=20
[   13.210333] rwsem_down_write_slowpath (./include/linux/instrumented.h:96=
 kernel/locking/rwsem.c:1180)=20
[   13.211459] ? __pfx_rwsem_down_write_slowpath (kernel/locking/rwsem.c:11=
08)=20
[   13.212688] ? __pfx_folio_activate_fn (mm/swap.c:328)=20
[   13.213773] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem=
=2Ec:1315 kernel/locking/rwsem.c:1574)=20
[   13.214622] ? __pfx_down_write (kernel/locking/rwsem.c:1571)=20
[   13.215576] exit_mmap (./arch/x86/include/asm/jump_label.h:27 ./include/=
linux/jump_label.h:207 ./include/linux/mmap_lock.h:35 ./include/linux/mmap_=
lock.h:95 mm/mmap.c:3207)=20
[   13.216411] ? __pfx_exit_mmap (mm/mmap.c:3174)=20
[   13.217342] ? task_cputime (kernel/sched/cputime.c:860)=20
[   13.218253] ? delayed_uprobe_remove.part.0 (kernel/events/uprobes.c:325)=
=20
[   13.219464] __mmput (kernel/fork.c:1354)=20
[   13.220243] do_exit (./include/linux/instrumented.h:68 ./include/asm-gen=
eric/bitops/instrumented-non-atomic.h:141 ./include/linux/thread_info.h:118=
 kernel/exit.c:568 kernel/exit.c:861)=20
[   13.221067] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.221976] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.223137] make_task_dead (kernel/exit.c:972)=20
[   13.224152] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.225181] rewind_stack_and_make_dead (??:?)=20
[   13.226332] RIP: 0033:0x55868cae5bb6=0D
[ 13.227203] Code: Unable to access opcode bytes at 0x55868cae5b8c.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   13.228630] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.229845] RAX: 0000000000009000 RBX: 0000000003970000 RCX: 00000000000=
00001=0D
[   13.231464] RDX: 0000000000000000 RSI: 00007f548167d010 RDI: 00000000001=
7f8cb=0D
[   13.233067] RBP: 00007f547dd14010 R08: 000000037b4c43fe R09: 00000000000=
00000=0D
[   13.234682] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.236294] R13: 00007f547dd14010 R14: 00007f5481674010 R15: 00007fff9ae=
412d0=0D
[   13.237912]  </TASK>=0D
[   13.238499] Modules linked in:=0D
[   13.239333] CR2: ffffffffaa8547a6=0D
[   13.240255] ---[ end trace 0000000000000000 ]---=0D
[   13.240257] stack segment: 0000 [#7] PREEMPT SMP KASAN NOPTI=0D
[   13.241511] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   13.241940] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.241943] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 13.243312] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[ 13.243899] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.243904] RSP: 0018:ffff888004277040 EFLAGS: 00010282=0D
[   13.243908] RAX: 0000000000000000 RBX: ffffea0000385740 RCX: 00000000000=
00000=0D
[   13.245933] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.246306] RDX: ffff888006a28000 RSI: 0000000000000008 RDI: ffff8880042=
77008=0D
[   13.246309] RBP: d8ffff888004e19d R08: 1ffff110009c3204 R09: fffff940000=
70ae8=0D
[   13.246312] R10: ffffea0000385747 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.246315] R13: ffff888004e18f69 R14: ffff888004e18f69 R15: ffff888004e=
19029=0D
[   13.250558] =0D
[   13.251879] FS:  00007f5484d60cc0(0000) GS:ffff888036300000(0000) knlGS:=
0000000000000000=0D
[   13.251883] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.253070] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.253590] CR2: 00007f5481214010 CR3: 0000000005196000 CR4: 00000000000=
006e0=0D
[   13.253594] Call Trace:=0D
[   13.254764] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.255296]  <TASK>=0D
[   13.255299] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   13.256903] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.257433] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   13.259071] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.259216] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   13.260920] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.261400] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   13.262806] FS:  0000000000000000(0000) GS:ffff888036080000(0000) knlGS:=
0000000000000000=0D
[   13.263421] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   13.263910] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.264501] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   13.264919] CR2: ffffffffaa8547a6 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   13.265167] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   13.266583] note: stress-ng-bighe[305] exited with irqs disabled=0D
[   13.266866] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   13.268583] Fixing recursive fault but reboot is needed!=0D
[   13.268765] ? _raw_spin_trylock (./arch/x86/include/asm/atomic.h:115 (di=
scriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrimi=
nator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4=
) ./include/asm-generic/qspinlock.h:97 (discriminator 4) ./include/linux/sp=
inlock.h:192 (discriminator 4) ./include/linux/spinlock_api_smp.h:89 (discr=
iminator 4) kernel/locking/spinlock.c:138 (discriminator 4))=20
[   13.283086] ? __list_add_valid (lib/list_debug.c:30)=20
[   13.283569] ? free_unref_page_commit (mm/page_alloc.c:2461)=20
[   13.284091] evict_folios (mm/vmscan.c:5182)=20
[   13.284534] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   13.285008] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   13.286001] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   13.286604] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   13.289346] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   13.289825] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   13.290395] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   13.290896] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   13.291445] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   13.291903] shrink_one (mm/vmscan.c:5403)=20
[   13.292330] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   13.292810] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   13.293332] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   13.293911] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   13.294406] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   13.294956] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   13.295544] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   13.296124] try_to_free_pages (mm/vmscan.c:7060)=20
[   13.296642] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   13.297209] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   13.297737] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   13.298400] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   13.299109] ? __pfx_do_vmi_align_munmap (mm/mmap.c:2430)=20
[   13.299702] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   13.300305] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   13.300944] __alloc_pages (mm/page_alloc.c:4526)=20
[   13.301419] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   13.301940] ? __pfx_call_function_single_prep_ipi (kernel/sched/core.c:3=
903)=20
[   13.302601] __folio_alloc (mm/page_alloc.c:4548)=20
[   13.303041] vma_alloc_folio (./include/linux/mempolicy.h:75 (discriminat=
or 1) ./include/linux/mempolicy.h:80 (discriminator 1) mm/mempolicy.c:2241 =
(discriminator 1))=20
[   13.303554] ? __pfx_vma_alloc_folio (mm/mempolicy.c:2162)=20
[   13.304108] ? smp_call_function_single_async (./arch/x86/include/asm/pre=
empt.h:95 (discriminator 1) kernel/smp.c:678 (discriminator 1))=20
[   13.304751] ? __pte_offset_map (./arch/x86/include/asm/pgtable.h:816 (di=
scriminator 2) ./include/linux/pgtable.h:92 (discriminator 2) ./include/lin=
ux/pgtable.h:107 (discriminator 2) mm/pgtable-generic.c:251 (discriminator =
2))=20
[   13.305279] do_anonymous_page (mm/memory.c:4110)=20
[   13.305780] __handle_mm_fault (mm/memory.c:3667 mm/memory.c:4945 mm/memo=
ry.c:5085)=20
[   13.306301] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   13.306858] ? find_vma (mm/mmap.c:1861)=20
[   13.307295] ? __pfx_find_vma (mm/mmap.c:1861)=20
[   13.307779] handle_mm_fault (mm/memory.c:5250)=20
[   13.308260] do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.308776] exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x=
86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.309239] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.309741] RIP: 0033:0x55868cae5bb6=0D
[ 13.310187] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   13.312158] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.312766] RAX: 0000000002ff0000 RBX: 0000000003000000 RCX: 00000000000=
00001=0D
[   13.313539] RDX: 0000000000000000 RSI: 00007f5480d04010 RDI: 00000000000=
e440c=0D
[   13.314321] RBP: 00007f547dd14010 R08: 000000037b2f9c29 R09: 00000000000=
00000=0D
[   13.315103] R10: 0000000003000000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.315901] R13: 00007f5480d15010 R14: 00007f547dd14010 R15: 00007fff9ae=
412d0=0D
[   13.317098]  </TASK>=0D
[   13.317427] Modules linked in:=0D
[   13.317837] stack segment: 0000 [#8] PREEMPT SMP KASAN NOPTI=0D
[   13.317884] ---[ end trace 0000000000000000 ]---=0D
[   13.318328] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.318725] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   13.319426] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 13.320178] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[ 13.320625] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.321033] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.322357] RSP: 0018:ffff888006a97040 EFLAGS: 00010282=0D
[   13.322361] RAX: 0000000000000000 RBX: ffffea00003857c0 RCX: 00000000000=
00000=0D
[   13.322364] RDX: ffff888004825100 RSI: 0000000000000008 RDI: ffff888006a=
97008=0D
[   13.323688] =0D
[   13.324054] RBP: d8ffff888004e19d R08: 1ffff110009c3204 R09: fffff940000=
70af8=0D
[   13.324442] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.324942] R10: ffffea00003857c7 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.325462] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.325577] R13: ffff888004e18f69 R14: ffff888004e18f69 R15: ffff888004e=
19029=0D
[   13.326080] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.326599] FS:  00007f5484d60cc0(0000) GS:ffff888036380000(0000) knlGS:=
0000000000000000=0D
[   13.326602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.327113] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.327622] CR2: 00007f5481485010 CR3: 0000000006dee000 CR4: 00000000000=
006e0=0D
[   13.328132] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.328640] Call Trace:=0D
[   13.329210] FS:  00007f5484d60cc0(0000) GS:ffff888036300000(0000) knlGS:=
0000000000000000=0D
[   13.329623]  <TASK>=0D
[   13.330128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.330635] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   13.331160] CR2: 00007f5481214010 CR3: 0000000005196000 CR4: 00000000000=
006e0=0D
[   13.331362] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   13.332033] ------------[ cut here ]------------=0D
[   13.332182] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   13.332649] WARNING: CPU: 10 PID: 315 at kernel/exit.c:818 do_exit (kern=
el/exit.c:818 (discriminator 1))=20
[   13.332890] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   13.333462] Modules linked in:=0D
[   13.333735] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   13.334112] =0D
[   13.334419] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   13.335331] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   13.335339] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   13.335589] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.335946] ? _raw_spin_trylock (./arch/x86/include/asm/atomic.h:115 (di=
scriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrimi=
nator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4=
) ./include/asm-generic/qspinlock.h:97 (discriminator 4) ./include/linux/sp=
inlock.h:192 (discriminator 4) ./include/linux/spinlock_api_smp.h:89 (discr=
iminator 4) kernel/locking/spinlock.c:138 (discriminator 4))=20
[   13.336072] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.336447] ? __list_add_valid (lib/list_debug.c:30)=20
[ 13.337108] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   13.337449] ? free_unref_page_commit (mm/page_alloc.c:2461)=20
[   13.337814] RSP: 0018:ffff888004277e60 EFLAGS: 00010286=0D
[   13.338514] evict_folios (mm/vmscan.c:5182)=20
[   13.338856] =0D
[   13.339210] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   13.339567] RAX: 0000000000000000 RBX: ffff888006a28000 RCX: ffffffffa81=
71c65=0D
[   13.340975] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   13.340982] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   13.341330] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888006a=
28d08=0D
[   13.341703] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   13.341965] RBP: ffff888004262800 R08: 0000000000000001 R09: ffffed10008=
4efc1=0D
[   13.342082] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   13.342397] R10: 0000000000000003 R11: 30303020203a5346 R12: 00000000000=
0000b=0D
[   13.342898] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   13.343431] R13: ffff888006a28c20 R14: ffff88800298b480 R15: 00000000000=
00007=0D
[   13.343853] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   13.346537] FS:  00007f5484d60cc0(0000) GS:ffff888036300000(0000) knlGS:=
0000000000000000=0D
[   13.346655] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   13.347260] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.347634] shrink_one (mm/vmscan.c:5403)=20
[   13.347641] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   13.347648] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   13.347653] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   13.347658] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   13.347665] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   13.347672] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   13.347677] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   13.347685] try_to_free_pages (mm/vmscan.c:7060)=20
[   13.347691] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   13.347698] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   13.347707] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   13.348313] CR2: 00007f5481214010 CR3: 0000000005196000 CR4: 00000000000=
006e0=0D
[   13.348710] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   13.349352] Call Trace:=0D
[   13.349634] ? kasan_save_free_info (mm/kasan/generic.c:524 (discriminato=
r 1))=20
[   13.350043]  <TASK>=0D
[   13.350305] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   13.350312] ? mas_destroy (lib/maple_tree.c:5593)=20
[   13.350591] ? __warn (kernel/panic.c:673)=20
[   13.350885] ? kmem_cache_free (mm/slub.c:1818 (discriminator 2) mm/slub.=
c:3801 (discriminator 2) mm/slub.c:3823 (discriminator 2))=20
[   13.351230] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.351515] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   13.351831] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   13.352184] __alloc_pages (mm/page_alloc.c:4526)=20
[   13.352547] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   13.352842] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   13.353193] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   13.353476] ? __pfx_mas_store_prealloc (lib/maple_tree.c:5524)=20
[   13.353878] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   13.354393] ? rb_next (lib/rbtree.c:503)=20
[   13.354402] __folio_alloc (mm/page_alloc.c:4548)=20
[   13.354836] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.355017] vma_alloc_folio (./include/linux/mempolicy.h:75 (discriminat=
or 1) ./include/linux/mempolicy.h:80 (discriminator 1) mm/mempolicy.c:2241 =
(discriminator 1))=20
[   13.355343] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.355502] ? __pfx_vma_alloc_folio (mm/mempolicy.c:2162)=20
[   13.355860] ? handle_mm_fault (mm/memory.c:5250)=20
[   13.356126] ? __pte_offset_map (./arch/x86/include/asm/pgtable.h:816 (di=
scriminator 2) ./include/linux/pgtable.h:92 (discriminator 2) ./include/lin=
ux/pgtable.h:107 (discriminator 2) mm/pgtable-generic.c:251 (discriminator =
2))=20
[   13.356373] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.356667] do_anonymous_page (mm/memory.c:4110)=20
[   13.356918] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.357315] __handle_mm_fault (mm/memory.c:3667 mm/memory.c:4945 mm/memo=
ry.c:5085)=20
[   13.357322] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   13.357592] make_task_dead (kernel/exit.c:972)=20
[   13.357863] ? find_vma (mm/mmap.c:1861)=20
[   13.358120] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.358454] ? __pfx_find_vma (mm/mmap.c:1861)=20
[   13.358784] rewind_stack_and_make_dead (??:?)=20
[   13.359157] handle_mm_fault (mm/memory.c:5250)=20
[   13.359164] do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.359504] RIP: 0033:0x55868cae5bb6=0D
[   13.359764] exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x=
86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[ 13.360040] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   13.360315] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.360320] RIP: 0033:0x55868cae5bb6=0D
[   13.360634] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[ 13.360912] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   13.361266] =0D
[   13.361595] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.361926] RAX: 0000000002ff0000 RBX: 0000000003000000 RCX: 00000000000=
00001=0D
[   13.362221] =0D
[   13.362223] RAX: 0000000000000000 RBX: 0000000003510000 RCX: 00000000000=
00001=0D
[   13.362226] RDX: 0000000000000000 RSI: 00007f5481214010 RDI: 00000000000=
5efdf=0D
[   13.362555] RDX: 0000000000000000 RSI: 00007f5480d04010 RDI: 00000000000=
e440c=0D
[   13.362907] RBP: 00007f547dd14010 R08: 000000037b6c1bbe R09: 00000000000=
00000=0D
[   13.363253] RBP: 00007f547dd14010 R08: 000000037b2f9c29 R09: 00000000000=
00000=0D
[   13.363619] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.363916] R10: 0000000003000000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.364188] R13: 00007f547dd14010 R14: 00007f5481214010 R15: 00007fff9ae=
412d0=0D
[   13.364194]  </TASK>=0D
[   13.364508] R13: 00007f5480d15010 R14: 00007f547dd14010 R15: 00007fff9ae=
412d0=0D
[   13.364817] Modules linked in:=0D
[   13.365191]  </TASK>=0D
[   13.365510] =0D
[   13.365839] ---[ end trace 0000000000000000 ]---=0D
[   13.366136] BUG: unable to handle page fault for address: ffffffffaa8547=
a6=0D
[   13.366167] ---[ end trace 0000000000000000 ]---=0D
[   13.366169] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 13.366175] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.366179] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.366183] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.366185] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.366188] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.366191] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.366199] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.366204] FS:  00007f5484d60cc0(0000) GS:ffff888036380000(0000) knlGS:=
0000000000000000=0D
[   13.366208] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.366210] CR2: 00007f5481485010 CR3: 0000000006dee000 CR4: 00000000000=
006e0=0D
[   13.366236] ------------[ cut here ]------------=0D
[   13.366241] WARNING: CPU: 11 PID: 311 at kernel/exit.c:818 do_exit (kern=
el/exit.c:818 (discriminator 1))=20
[   13.366250] Modules linked in:=0D
[   13.366260] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.366263] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[ 13.366272] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   13.366281] RSP: 0018:ffff888006a97e60 EFLAGS: 00010286=0D
[   13.366292] RAX: 0000000000000000 RBX: ffff888004825100 RCX: ffffffffa81=
71c65=0D
[   13.366295] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880048=
25e08=0D
[   13.366302] RBP: ffff88800e67e400 R08: 0000000000000001 R09: ffffed1000d=
52fc1=0D
[   13.366305] R10: 0000000000000003 R11: 00000000ffffffff R12: 00000000000=
0000b=0D
[   13.366310] R13: ffff888004825d20 R14: ffff88800e6771c0 R15: 00000000000=
00007=0D
[   13.366315] FS:  00007f5484d60cc0(0000) GS:ffff888036380000(0000) knlGS:=
0000000000000000=0D
[   13.366319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.366325] CR2: 00007f5481485010 CR3: 0000000006dee000 CR4: 00000000000=
006e0=0D
[   13.366332] Call Trace:=0D
[   13.366334]  <TASK>=0D
[   13.366336] ? __warn (kernel/panic.c:673)=20
[   13.366341] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.366351] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   13.366358] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   13.366364] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   13.366373] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   13.366383] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.366388] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.366398] ? handle_mm_fault (mm/memory.c:5250)=20
[   13.366403] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.366409] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.366418] make_task_dead (kernel/exit.c:972)=20
[   13.366424] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.366430] rewind_stack_and_make_dead (??:?)=20
[   13.366438] RIP: 0033:0x55868cae5bb6=0D
[   13.367913] #PF: supervisor write access in kernel mode=0D
[   13.367916] #PF: error_code(0x0003) - permissions violation=0D
[   13.367919] PGD b059067 P4D b059067 PUD b05a063 =0D
[ 13.368304] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   13.368570] PMD 800000000a8001e1 =0D
[   13.368948] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.370273] =0D
[   13.370275] Oops: 0003 [#9] PREEMPT SMP KASAN NOPTI=0D
[   13.370411] =0D
[   13.370786] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.371312] RAX: 0000000000000000 RBX: 0000000003510000 RCX: 00000000000=
00001=0D
[   13.371426] RIP: 0010:__blk_flush_plug (./include/linux/list.h:449 ./inc=
lude/linux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.371938] RDX: 0000000000000000 RSI: 00007f5481214010 RDI: 00000000000=
5efdf=0D
[ 13.372495] Code: 39 04 24 0f 84 d0 00 00 00 4d 8b 65 18 48 8b 7c 24 10 48=
 8b 6c 24 48 e8 90 b4 a7 ff 49 8d 7c 24 08 49 8b 5d 20 e8 32 b5 a7 ff <4d> =
89 74 24 08 48 89 df 4c 89 64 24 48 e8 20 b5 a7 ff 48 89 2b 48=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	39 04 24             	cmp    %eax,(%rsp)
   3:	0f 84 d0 00 00 00    	je     0xd9
   9:	4d 8b 65 18          	mov    0x18(%r13),%r12
   d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  12:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
  17:	e8 90 b4 a7 ff       	call   0xffffffffffa7b4ac
  1c:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  21:	49 8b 5d 20          	mov    0x20(%r13),%rbx
  25:	e8 32 b5 a7 ff       	call   0xffffffffffa7b55c
  2a:*	4d 89 74 24 08       	mov    %r14,0x8(%r12)		<-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
  37:	e8 20 b5 a7 ff       	call   0xffffffffffa7b55c
  3c:	48 89 2b             	mov    %rbp,(%rbx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
   5:	48 89 df             	mov    %rbx,%rdi
   8:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
   d:	e8 20 b5 a7 ff       	call   0xffffffffffa7b532
  12:	48 89 2b             	mov    %rbp,(%rbx)
  15:	48                   	rex.W
[   13.372501] RSP: 0018:ffff88800438f9b8 EFLAGS: 00010246=0D
[   13.373008] RBP: 00007f547dd14010 R08: 000000037b6c1bbe R09: 00000000000=
00000=0D
[   13.373531] =0D
[   13.373532] RAX: 0000000000000000 RBX: ffffffffa85a6a00 RCX: ffffffffa8b=
8cc6e=0D
[   13.373536] RDX: 0000000000000005 RSI: dffffc0000000000 RDI: ffffffffaa8=
547a6=0D
[   13.374043] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.374565] RBP: ffff88800438fa00 R08: 1ffffffff550a8f4 R09: ffffed1000a=
dca97=0D
[   13.374569] R10: ffff8880056e54bf R11: 0000000000000000 R12: ffffffffaa8=
5479e=0D
[   13.374572] R13: ffff88800438f650 R14: ffff88800438fa00 R15: dead0000000=
00100=0D
[   13.375078] R13: 00007f547dd14010 R14: 00007f5481214010 R15: 00007fff9ae=
412d0=0D
[   13.375631] FS:  0000000000000000(0000) GS:ffff888035f00000(0000) knlGS:=
0000000000000000=0D
[   13.375634] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.375823]  </TASK>=0D
[   13.376378] CR2: ffffffffaa8547a6 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   13.376383] Call Trace:=0D
[   13.376385]  <TASK>=0D
[   13.376641] ---[ end trace 0000000000000000 ]---=0D
[   13.376825] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[   13.466648] ? page_fault_oops (arch/x86/mm/fault.c:707 (discriminator 1)=
)=20
[   13.467184] ? __pfx_is_prefetch.isra.0 (arch/x86/mm/fault.c:122)=20
[   13.467765] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:635)=20
[   13.468311] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.468844] ? search_bpf_extables (kernel/bpf/core.c:737)=20
[   13.469393] ? fixup_exception (arch/x86/mm/extable.c:254)=20
[   13.469897] ? exc_page_fault (arch/x86/mm/fault.c:1485 arch/x86/mm/fault=
=2Ec:1543)=20
[   13.470401] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.470908] ? __pfx___rmqueue_pcplist (mm/page_alloc.c:2761)=20
[   13.471472] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.472029] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.472622] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.473245] ? __pfx___blk_flush_plug (block/blk-core.c:1144)=20
[   13.473972] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   13.474526] schedule (./arch/x86/include/asm/current.h:41 (discriminator=
 1) ./include/linux/thread_info.h:185 (discriminator 1) ./include/linux/sch=
ed.h:2240 (discriminator 1) kernel/sched/core.c:6788 (discriminator 1))=20
[   13.474963] schedule_preempt_disabled (./arch/x86/include/asm/preempt.h:=
80 (discriminator 10) kernel/sched/core.c:6846 (discriminator 10))=20
[   13.475676] rwsem_down_write_slowpath (./include/linux/instrumented.h:96=
 kernel/locking/rwsem.c:1180)=20
[   13.476303] ? __pfx_rwsem_down_write_slowpath (kernel/locking/rwsem.c:11=
08)=20
[   13.476964] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem=
=2Ec:1315 kernel/locking/rwsem.c:1574)=20
[   13.477433] ? __pfx_down_write (kernel/locking/rwsem.c:1571)=20
[   13.477939] exit_mmap (./arch/x86/include/asm/jump_label.h:27 ./include/=
linux/jump_label.h:207 ./include/linux/mmap_lock.h:35 ./include/linux/mmap_=
lock.h:95 mm/mmap.c:3207)=20
[   13.478409] ? __pfx_exit_mmap (mm/mmap.c:3174)=20
[   13.478906] ? task_cputime (kernel/sched/cputime.c:860)=20
[   13.479401] ? delayed_uprobe_remove.part.0 (kernel/events/uprobes.c:325)=
=20
[   13.480011] __mmput (kernel/fork.c:1354)=20
[   13.480446] do_exit (./include/linux/instrumented.h:68 ./include/asm-gen=
eric/bitops/instrumented-non-atomic.h:141 ./include/linux/thread_info.h:118=
 kernel/exit.c:568 kernel/exit.c:861)=20
[   13.480897] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.481383] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.481931] make_task_dead (kernel/exit.c:972)=20
[   13.482430] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.482935] rewind_stack_and_make_dead (??:?)=20
[   13.483534] RIP: 0033:0x55868cae5bb6=0D
[ 13.484008] Code: Unable to access opcode bytes at 0x55868cae5b8c.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   13.484744] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.485397] RAX: 000000000000a000 RBX: 0000000002ca0000 RCX: 00000000000=
00001=0D
[   13.486221] RDX: 0000000000000000 RSI: 00007f54839af010 RDI: 00000000001=
72bcd=0D
[   13.487053] RBP: 00007f5480d15010 R08: 000000037b4b58b1 R09: 00000000000=
00000=0D
[   13.487880] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.488771] R13: 00007f5480d15010 R14: 00007f54839a5010 R15: 00007fff9ae=
412d0=0D
[   13.489633]  </TASK>=0D
[   13.489971] Modules linked in:=0D
[   13.490416] CR2: ffffffffaa8547a6=0D
[   13.490871] ---[ end trace 0000000000000000 ]---=0D
[   13.490871] BUG: unable to handle page fault for address: ffffffffaa8547=
a6=0D
[   13.491274] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   13.491890] #PF: supervisor write access in kernel mode=0D
[ 13.492350] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.492800] #PF: error_code(0x0003) - permissions violation=0D
[   13.494403] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.494884] PGD b059067 =0D
[   13.495063] =0D
[   13.495523] P4D b059067 =0D
[   13.495752] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.495890] PUD b05a063 =0D
[   13.496101] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.496637] PMD 800000000a8001e1 =0D
[   13.496828] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.497415] =0D
[   13.497708] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.498272] Oops: 0003 [#10] PREEMPT SMP KASAN NOPTI=0D
[   13.498405] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.499361] FS:  0000000000000000(0000) GS:ffff888035f00000(0000) knlGS:=
0000000000000000=0D
[   13.499954] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.500565] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.501157] RIP: 0010:__blk_flush_plug (./include/linux/list.h:449 ./inc=
lude/linux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.501807] CR2: ffffffffaa8547a6 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[ 13.502235] Code: 39 04 24 0f 84 d0 00 00 00 4d 8b 65 18 48 8b 7c 24 10 48=
 8b 6c 24 48 e8 90 b4 a7 ff 49 8d 7c 24 08 49 8b 5d 20 e8 32 b5 a7 ff <4d> =
89 74 24 08 48 89 df 4c 89 64 24 48 e8 20 b5 a7 ff 48 89 2b 48=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	39 04 24             	cmp    %eax,(%rsp)
   3:	0f 84 d0 00 00 00    	je     0xd9
   9:	4d 8b 65 18          	mov    0x18(%r13),%r12
   d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  12:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
  17:	e8 90 b4 a7 ff       	call   0xffffffffffa7b4ac
  1c:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  21:	49 8b 5d 20          	mov    0x20(%r13),%rbx
  25:	e8 32 b5 a7 ff       	call   0xffffffffffa7b55c
  2a:*	4d 89 74 24 08       	mov    %r14,0x8(%r12)		<-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
  37:	e8 20 b5 a7 ff       	call   0xffffffffffa7b55c
  3c:	48 89 2b             	mov    %rbp,(%rbx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
   5:	48 89 df             	mov    %rbx,%rdi
   8:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
   d:	e8 20 b5 a7 ff       	call   0xffffffffffa7b532
  12:	48 89 2b             	mov    %rbp,(%rbx)
  15:	48                   	rex.W
[   13.502610] note: stress-ng-bighe[307] exited with irqs disabled=0D
[   13.503126] RSP: 0018:ffff888006a979b8 EFLAGS: 00010246=0D
[   13.504688] Fixing recursive fault but reboot is needed!=0D
[   13.505071] =0D
[   13.505073] RAX: 0000000000000000 RBX: ffffffffa85a6a00 RCX: ffffffffa8b=
8cc6e=0D
[   13.515435] RDX: 0000000000000005 RSI: dffffc0000000000 RDI: ffffffffaa8=
547a6=0D
[   13.516314] RBP: ffff888006a97a00 R08: 1ffffffff550a8f4 R09: ffffed1000a=
56a97=0D
[   13.517197] R10: ffff8880052b54bf R11: 0000000000000000 R12: ffffffffaa8=
5479e=0D
[   13.518092] R13: ffff888006a97650 R14: ffff888006a97a00 R15: dead0000000=
00100=0D
[   13.518974] FS:  0000000000000000(0000) GS:ffff888036380000(0000) knlGS:=
0000000000000000=0D
[   13.520033] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.520778] CR2: ffffffffaa8547a6 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   13.521679] Call Trace:=0D
[   13.522054]  <TASK>=0D
[   13.522373] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[   13.522783] ? page_fault_oops (arch/x86/mm/fault.c:707 (discriminator 1)=
)=20
[   13.523271] ? __pfx_is_prefetch.isra.0 (arch/x86/mm/fault.c:122)=20
[   13.523836] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:635)=20
[   13.524359] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.524858] ? search_bpf_extables (kernel/bpf/core.c:737)=20
[   13.525372] ? fixup_exception (arch/x86/mm/extable.c:254)=20
[   13.525854] ? exc_page_fault (arch/x86/mm/fault.c:1485 arch/x86/mm/fault=
=2Ec:1543)=20
[   13.526325] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.526824] ? __pfx___rmqueue_pcplist (mm/page_alloc.c:2761)=20
[   13.527373] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.527870] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.528373] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.528865] ? __pfx___blk_flush_plug (block/blk-core.c:1144)=20
[   13.529411] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   13.529917] schedule (./arch/x86/include/asm/current.h:41 (discriminator=
 1) ./include/linux/thread_info.h:185 (discriminator 1) ./include/linux/sch=
ed.h:2240 (discriminator 1) kernel/sched/core.c:6788 (discriminator 1))=20
[   13.530339] schedule_preempt_disabled (./arch/x86/include/asm/preempt.h:=
80 (discriminator 10) kernel/sched/core.c:6846 (discriminator 10))=20
[   13.530873] rwsem_down_write_slowpath (./include/linux/instrumented.h:96=
 kernel/locking/rwsem.c:1180)=20
[   13.531427] ? __pfx_rwsem_down_write_slowpath (kernel/locking/rwsem.c:11=
08)=20
[   13.532011] ? __pfx_folio_activate_fn (mm/swap.c:328)=20
[   13.532551] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem=
=2Ec:1315 kernel/locking/rwsem.c:1574)=20
[   13.532969] ? __pfx_down_write (kernel/locking/rwsem.c:1571)=20
[   13.533446] exit_mmap (./arch/x86/include/asm/jump_label.h:27 ./include/=
linux/jump_label.h:207 ./include/linux/mmap_lock.h:35 ./include/linux/mmap_=
lock.h:95 mm/mmap.c:3207)=20
[   13.533865] ? __pfx_exit_mmap (mm/mmap.c:3174)=20
[   13.534327] ? task_cputime (kernel/sched/cputime.c:860)=20
[   13.534784] ? delayed_uprobe_remove.part.0 (kernel/events/uprobes.c:325)=
=20
[   13.535364] __mmput (kernel/fork.c:1354)=20
[   13.535765] do_exit (./include/linux/instrumented.h:68 ./include/asm-gen=
eric/bitops/instrumented-non-atomic.h:141 ./include/linux/thread_info.h:118=
 kernel/exit.c:568 kernel/exit.c:861)=20
[   13.536180] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.536636] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.537135] make_task_dead (kernel/exit.c:972)=20
[   13.537603] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.538076] rewind_stack_and_make_dead (??:?)=20
[   13.538636] RIP: 0033:0x55868cae5bb6=0D
[ 13.539075] Code: Unable to access opcode bytes at 0x55868cae5b8c.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   13.539758] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.540353] RAX: 0000000000000000 RBX: 0000000003510000 RCX: 00000000000=
00001=0D
[   13.541099] RDX: 0000000000000000 RSI: 00007f5481214010 RDI: 00000000000=
5efdf=0D
[   13.541847] RBP: 00007f547dd14010 R08: 000000037b6c1bbe R09: 00000000000=
00000=0D
[   13.542637] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.543496] R13: 00007f547dd14010 R14: 00007f5481214010 R15: 00007fff9ae=
412d0=0D
[   13.544387]  </TASK>=0D
[   13.544745] Modules linked in:=0D
[   13.545201] CR2: ffffffffaa8547a6=0D
[   13.545692] ---[ end trace 0000000000000000 ]---=0D
[   13.545694] stack segment: 0000 [#11] PREEMPT SMP KASAN NOPTI=0D
[   13.546126] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 13.547175] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.547918] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.549637] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.550458] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   13.554041] =0D
[ 13.554461] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.554881] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.555015] RSP: 0018:ffff888006977040 EFLAGS: 00010282=0D
[   13.556401] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.556935] =0D
[   13.557337] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.557869] RAX: 0000000000000000 RBX: ffffea00003856c0 RCX: 00000000000=
00000=0D
[   13.557993] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.558534] RDX: ffff8880048aa880 RSI: 0000000000000008 RDI: ffff8880069=
77008=0D
[   13.559060] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.559597] RBP: d8ffff888004e19d R08: 1ffff110009c3204 R09: fffff940000=
70ad8=0D
[   13.560128] FS:  0000000000000000(0000) GS:ffff888036380000(0000) knlGS:=
0000000000000000=0D
[   13.560663] R10: ffffea00003856c7 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.561187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.561803] R13: ffff888004e18f69 R14: ffff888004e18f69 R15: ffff888004e=
19029=0D
[   13.562331] CR2: ffffffffaa8547a6 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   13.562755] FS:  00007f5484d60cc0(0000) GS:ffff888036100000(0000) knlGS:=
0000000000000000=0D
[   13.563274] note: stress-ng-bighe[311] exited with irqs disabled=0D
[   13.563794] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.564412] Fixing recursive fault but reboot is needed!=0D
[   13.564825] CR2: 0000557449969255 CR3: 0000000003864000 CR4: 00000000000=
006e0=0D
[   13.573083] Call Trace:=0D
[   13.573439]  <TASK>=0D
[   13.573746] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   13.574136] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   13.574574] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   13.575023] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   13.575534] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   13.576053] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   13.576589] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   13.577091] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   13.577637] ? __mem_cgroup_uncharge_list (mm/memcontrol.c:7192)=20
[   13.578208] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169)=
=20
[   13.578762] evict_folios (mm/vmscan.c:5182)=20
[   13.579214] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   13.579737] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   13.580317] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   13.580896] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   13.581403] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   13.581982] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   13.582514] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   13.583065] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   13.583572] shrink_one (mm/vmscan.c:5403)=20
[   13.584007] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   13.584473] ? __kernel_text_address (kernel/extable.c:79 (discriminator =
1))=20
[   13.584995] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   13.585494] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   13.586030] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   13.586514] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   13.587023] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   13.587594] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   13.588151] try_to_free_pages (mm/vmscan.c:7060)=20
[   13.588647] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   13.589177] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   13.589665] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   13.590301] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   13.590970] ? mas_update_gap (lib/maple_tree.c:1720 lib/maple_tree.c:170=
2)=20
[   13.591456] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   13.592020] ? __pfx_mas_store_prealloc (lib/maple_tree.c:5524)=20
[   13.592569] ? rb_next (lib/rbtree.c:503)=20
[   13.592978] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   13.593598] __alloc_pages (mm/page_alloc.c:4526)=20
[   13.594050] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   13.594563] ? khugepaged_enter_vma (mm/khugepaged.c:456 (discriminator 1=
) mm/khugepaged.c:451 (discriminator 1))=20
[   13.595071] ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discr=
iminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discriminat=
or 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) .=
/include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spin=
lock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discri=
minator 4) kernel/locking/spinlock.c:154 (discriminator 4))=20
[   13.595544] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)=20
[   13.596044] __folio_alloc (mm/page_alloc.c:4548)=20
[   13.596493] vma_alloc_folio (./include/linux/mempolicy.h:75 (discriminat=
or 1) ./include/linux/mempolicy.h:80 (discriminator 1) mm/mempolicy.c:2241 =
(discriminator 1))=20
[   13.596954] ? __pfx_vma_alloc_folio (mm/mempolicy.c:2162)=20
[   13.597469] ? set_pte (./arch/x86/include/asm/paravirt.h:436)=20
[   13.597879] ? __pfx_set_pte (./arch/x86/include/asm/paravirt.h:435)=20
[   13.598339] ? __pte_offset_map (./arch/x86/include/asm/pgtable.h:816 (di=
scriminator 2) ./include/linux/pgtable.h:92 (discriminator 2) ./include/lin=
ux/pgtable.h:107 (discriminator 2) mm/pgtable-generic.c:251 (discriminator =
2))=20
[   13.598838] do_anonymous_page (mm/memory.c:4110)=20
[   13.599320] __handle_mm_fault (mm/memory.c:3667 mm/memory.c:4945 mm/memo=
ry.c:5085)=20
[   13.599833] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   13.600374] ? find_vma (mm/mmap.c:1861)=20
[   13.600804] ? __pfx_find_vma (mm/mmap.c:1861)=20
[   13.601266] handle_mm_fault (mm/memory.c:5250)=20
[   13.601747] do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.602245] exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x=
86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.602711] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.603190] RIP: 0033:0x55868cae5bb6=0D
[ 13.603645] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   13.607782] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.608363] RAX: 0000000000001000 RBX: 0000000003780000 RCX: 00000000000=
00001=0D
[   13.609103] RDX: 0000000000000000 RSI: 00007f5481485010 RDI: 00000000001=
d77d0=0D
[   13.609866] RBP: 00007f547dd14010 R08: 000000037b6416c4 R09: 00000000000=
00000=0D
[   13.610653] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.611430] R13: 00007f547dd14010 R14: 00007f5481484010 R15: 00007fff9ae=
412d0=0D
[   13.612201]  </TASK>=0D
[   13.612524] Modules linked in:=0D
[   13.612931] stack segment: 0000 [#12] PREEMPT SMP KASAN NOPTI=0D
[   13.612986] ---[ end trace 0000000000000000 ]---=0D
[   13.613391] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.613395] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   13.613745] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 13.614343] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.614348] RSP: 0018:ffff8880029fed88 EFLAGS: 00010286=0D
[   13.614352] RAX: 0000000000000000 RBX: ffffea0000385840 RCX: 00000000000=
00000=0D
[ 13.614999] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.615384] RDX: ffff888006a2d100 RSI: 0000000000000008 RDI: ffff8880029=
fed50=0D
[   13.615388] RBP: d8ffff888004e19d R08: 1ffff110009c3204 R09: fffff940000=
70b08=0D
[   13.615391] R10: ffffea0000385847 R11: 000000000000001d R12: 00000000004=
00dc0=0D
[   13.615394] R13: ffff888004e18f69 R14: ffff888004e18f69 R15: ffff888004e=
19029=0D
[   13.615777] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.617147] FS:  00007f5484d60cc0(0000) GS:ffff888036200000(0000) knlGS:=
0000000000000000=0D
[   13.617151] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.617552] =0D
[   13.618072] CR2: ffffffffffffffd6 CR3: 000000000520a000 CR4: 00000000000=
006e0=0D
[   13.619448] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.619970] Call Trace:=0D
[   13.620511] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.621026]  <TASK>=0D
[   13.621565] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.621960] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   13.622565] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.622985] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   13.623115] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.623646] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   13.624177] FS:  00007f5484d60cc0(0000) GS:ffff888036100000(0000) knlGS:=
0000000000000000=0D
[   13.624366] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   13.624894] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.625058] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   13.625600] CR2: 0000557449969255 CR3: 0000000003864000 CR4: 00000000000=
006e0=0D
[   13.625854] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   13.626413] ------------[ cut here ]------------=0D
[   13.626636] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   13.627157] WARNING: CPU: 6 PID: 313 at kernel/exit.c:818 do_exit (kerne=
l/exit.c:818 (discriminator 1))=20
[   13.627440] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   13.628020] Modules linked in:=0D
[   13.628331] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   13.628759] =0D
[   13.629090] ? lruvec_is_sizable (mm/vmscan.c:4557 (discriminator 1))=20
[   13.629095] ? _raw_spin_trylock (./arch/x86/include/asm/atomic.h:115 (di=
scriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrimi=
nator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4=
) ./include/asm-generic/qspinlock.h:97 (discriminator 4) ./include/linux/sp=
inlock.h:192 (discriminator 4) ./include/linux/spinlock_api_smp.h:89 (discr=
iminator 4) kernel/locking/spinlock.c:138 (discriminator 4))=20
[   13.630043] ? __list_add_valid (lib/list_debug.c:30)=20
[   13.630404] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.630802] ? free_unref_page_commit (mm/page_alloc.c:2461)=20
[   13.631347] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.631671] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[ 13.631899] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   13.632245] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169)=
=20
[   13.632251] evict_folios (mm/vmscan.c:5182)=20
[   13.632378] RSP: 0018:ffff888006977e60 EFLAGS: 00010286=0D
[   13.632700] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   13.633004] =0D
[   13.633612] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   13.633913] RAX: 0000000000000000 RBX: ffff8880048aa880 RCX: ffffffffa81=
71c65=0D
[   13.634565] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   13.634570] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:425 (discrimin=
ator 2))=20
[   13.634922] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880048=
ab588=0D
[   13.635231] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   13.635236] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   13.635560] RBP: ffff88800477f300 R08: 0000000000000001 R09: ffffed1000d=
2efc1=0D
[   13.636920] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   13.636928] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   13.637291] R10: 0000000000000003 R11: 3030303030302052 R12: 00000000000=
0000b=0D
[   13.637571] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   13.637955] R13: ffff8880048ab4a0 R14: ffff888004775780 R15: 00000000000=
00007=0D
[   13.638264] shrink_one (mm/vmscan.c:5403)=20
[   13.638270] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   13.638404] FS:  00007f5484d60cc0(0000) GS:ffff888036100000(0000) knlGS:=
0000000000000000=0D
[   13.638795] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   13.639325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.639705] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   13.640005] CR2: 0000557449969255 CR3: 0000000003864000 CR4: 00000000000=
006e0=0D
[   13.640564] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   13.640873] Call Trace:=0D
[   13.641260] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   13.641853]  <TASK>=0D
[   13.642260] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   13.642660] ? __warn (kernel/panic.c:673)=20
[   13.643191] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   13.643520] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.644071] try_to_free_pages (mm/vmscan.c:7060)=20
[   13.644359] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   13.644637] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   13.645229] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   13.645543] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   13.645962] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   13.646318] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   13.646850] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   13.647142] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   13.647340] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.647672] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   13.647835] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.648196] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   13.648202] ? kmem_cache_free (mm/slub.c:1818 (discriminator 2) mm/slub.=
c:3801 (discriminator 2) mm/slub.c:3823 (discriminator 2))=20
[   13.648462] ? handle_mm_fault (mm/memory.c:5250)=20
[   13.648821] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   13.649083] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.649399] __alloc_pages (mm/page_alloc.c:4526)=20
[   13.649677] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.650022] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   13.650302] make_task_dead (kernel/exit.c:972)=20
[   13.650602] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   13.650887] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.651315] ? __pfx_native_flush_tlb_one_user (arch/x86/mm/tlb.c:1142)=
=20
[   13.651639] rewind_stack_and_make_dead (??:?)=20
[   13.652087] ? _find_first_bit (lib/find_bit.c:101 (discriminator 10))=20
[   13.652092] ? policy_node (mm/mempolicy.c:1875)=20
[   13.652358] RIP: 0033:0x55868cae5bb6=0D
[   13.652815] pte_alloc_one (./include/asm-generic/pgalloc.h:63 arch/x86/m=
m/pgtable.c:33)=20
[ 13.653078] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   13.653463] __pte_alloc (mm/memory.c:440 (discriminator 1))=20
[   13.653771] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.654079] ? __pfx___pte_alloc (mm/memory.c:439)=20
[   13.654505] =0D
[   13.654507] RAX: 0000000000001000 RBX: 0000000003780000 RCX: 00000000000=
00001=0D
[   13.654510] RDX: 0000000000000000 RSI: 00007f5481485010 RDI: 00000000001=
d77d0=0D
[   13.654512] RBP: 00007f547dd14010 R08: 000000037b6416c4 R09: 00000000000=
00000=0D
[   13.654515] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.654517] R13: 00007f547dd14010 R14: 00007f5481484010 R15: 00007fff9ae=
412d0=0D
[   13.654523]  </TASK>=0D
[   13.654525] ---[ end trace 0000000000000000 ]---=0D
[   13.684991] ? flush_tlb_mm_range (./arch/x86/include/asm/paravirt.h:700 =
arch/x86/mm/tlb.c:1034)=20
[   13.685555] move_page_tables (mm/mremap.c:571 (discriminator 1))=20
[   13.686080] ? copy_vma (mm/mmap.c:3347)=20
[   13.686543] ? __pfx_move_page_tables (mm/mremap.c:496)=20
[   13.687094] ? percpu_counter_add_batch (lib/percpu_counter.c:93 (discrim=
inator 1))=20
[   13.687666] ? __pfx_vm_unmapped_area (mm/mmap.c:1655)=20
[   13.688196] move_vma (mm/mremap.c:648)=20
[   13.688677] ? __pfx_move_vma (mm/mremap.c:588)=20
[   13.689154] ? __pfx_arch_get_unmapped_area_topdown (arch/x86/kernel/sys_=
x86_64.c:164)=20
[   13.689821] ? find_vma_intersection (mm/mmap.c:1844)=20
[   13.690365] ? cap_mmap_addr (security/commoncap.c:1425)=20
[   13.690845] ? __pfx_bpf_lsm_mmap_addr (./include/linux/lsm_hook_defs.h:1=
73)=20
[   13.691411] ? security_mmap_addr (security/security.c:2678 (discriminato=
r 7))=20
[   13.691939] __do_sys_mremap (mm/mremap.c:1096)=20
[   13.692460] ? __pfx___do_sys_mremap (mm/mremap.c:911)=20
[   13.693165] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   13.693845] ? cgroup_rstat_updated (kernel/cgroup/rstat.c:42 (discrimina=
tor 3))=20
[   13.694513] ? __count_memcg_events (mm/memcontrol.c:628 (discriminator 4=
) mm/memcontrol.c:619 (discriminator 4) mm/memcontrol.c:914 (discriminator =
4))=20
[   13.695087] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:425 (discrimin=
ator 2))=20
[   13.695637] do_syscall_64 (arch/x86/entry/common.c:50 (discriminator 1) =
arch/x86/entry/common.c:80 (discriminator 1))=20
[   13.696116] ? up_read (./arch/x86/include/asm/atomic64_64.h:79 (discrimi=
nator 5) ./include/linux/atomic/atomic-arch-fallback.h:2730 (discriminator =
5) ./include/linux/atomic/atomic-long.h:184 (discriminator 5) ./include/lin=
ux/atomic/atomic-instrumented.h:3289 (discriminator 5) kernel/locking/rwsem=
=2Ec:1347 (discriminator 5) kernel/locking/rwsem.c:1616 (discriminator 5))=
=20
[   13.696575] ? do_user_addr_fault (arch/x86/mm/fault.c:1425 (discriminato=
r 1))=20
[   13.697127] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.697639] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:12=
0)=20
[   13.698268] RIP: 0033:0x7f5484e68025=0D
[ 13.698755] Code: 74 21 48 8d 44 24 08 c7 44 24 b8 20 00 00 00 4c 8b 44 24=
 f0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 19 00 00 00 0f 05 <48> =
3d 00 f0 ff ff 76 10 48 8b 15 dc ed 0a 00 f7 d8 64 89 02 48 83=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	74 21                	je     0x23
   2:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
   7:	c7 44 24 b8 20 00 00 	movl   $0x20,-0x48(%rsp)
   e:	00=20
   f:	4c 8b 44 24 f0       	mov    -0x10(%rsp),%r8
  14:	48 89 44 24 c0       	mov    %rax,-0x40(%rsp)
  19:	48 8d 44 24 d0       	lea    -0x30(%rsp),%rax
  1e:	48 89 44 24 c8       	mov    %rax,-0x38(%rsp)
  23:	b8 19 00 00 00       	mov    $0x19,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	76 10                	jbe    0x42
  32:	48 8b 15 dc ed 0a 00 	mov    0xaeddc(%rip),%rdx        # 0xaee15
  39:	f7 d8                	neg    %eax
  3b:	64 89 02             	mov    %eax,%fs:(%rdx)
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	76 10                	jbe    0x18
   8:	48 8b 15 dc ed 0a 00 	mov    0xaeddc(%rip),%rdx        # 0xaedeb
   f:	f7 d8                	neg    %eax
  11:	64 89 02             	mov    %eax,%fs:(%rdx)
  14:	48                   	rex.W
  15:	83                   	.byte 0x83
[   13.700845] RSP: 002b:00007fff9ae41108 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000019=0D
[   13.701785] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5484e=
68025=0D
[   13.704855] RDX: 0000000003001000 RSI: 0000000002ff1000 RDI: 00007f5480d=
15000=0D
[   13.705690] RBP: 0000000003001000 R08: 0000000000000000 R09: 00000000000=
00000=0D
[   13.706549] R10: 0000000000000001 R11: 0000000000000246 R12: 00007f5480d=
15010=0D
[   13.707424] R13: 0000000002ff1000 R14: 00007f5480d15000 R15: 0000000002f=
f1000=0D
[   13.708269]  </TASK>=0D
[   13.708621] Modules linked in:=0D
[   13.709062] BUG: unable to handle page fault for address: 00000000000028=
08=0D
[   13.709106] ---[ end trace 0000000000000000 ]---=0D
[   13.710984] #PF: supervisor write access in kernel mode=0D
[   13.710988] #PF: error_code(0x0002) - not-present page=0D
[   13.710992] PGD 0 P4D 0 =0D
[   13.711434] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 13.711443] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.712016] Oops: 0002 [#13] PREEMPT SMP KASAN NOPTI=0D
[   13.712459] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.713388] =0D
[   13.715206] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.715211] RIP: 0010:__blk_flush_plug (./include/linux/list.h:449 ./inc=
lude/linux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.715661] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.715674] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.715678] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.715682] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.715685] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.715699] FS:  00007f5484d60cc0(0000) GS:ffff888036200000(0000) knlGS:=
0000000000000000=0D
[   13.715703] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.715707] CR2: ffffffffffffffd6 CR3: 000000000520a000 CR4: 00000000000=
006e0=0D
[   13.715808] ------------[ cut here ]------------=0D
[   13.715814] WARNING: CPU: 8 PID: 309 at kernel/exit.c:818 do_exit (kerne=
l/exit.c:818 (discriminator 1))=20
[   13.715863] Modules linked in:=0D
[   13.715880] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.715894] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[ 13.715913] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   13.715925] RSP: 0018:ffff8880029ffe60 EFLAGS: 00010282=0D
[   13.715931] RAX: 0000000000000000 RBX: ffff888006a2d100 RCX: ffffffffa81=
71c65=0D
[   13.715936] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888006a=
2de08=0D
[   13.715942] RBP: ffff888004261e00 R08: 0000000000000001 R09: ffffed10005=
3ffc1=0D
[   13.715948] R10: 0000000000000003 R11: 00000000ffffffff R12: 00000000000=
0000b=0D
[   13.715960] R13: ffff888006a2dd20 R14: ffff888002988000 R15: 00000000000=
00007=0D
[   13.715966] FS:  00007f5484d60cc0(0000) GS:ffff888036200000(0000) knlGS:=
0000000000000000=0D
[   13.715971] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.715975] CR2: ffffffffffffffd6 CR3: 000000000520a000 CR4: 00000000000=
006e0=0D
[   13.715982] Call Trace:=0D
[   13.715992]  <TASK>=0D
[   13.715995] ? __warn (kernel/panic.c:673)=20
[   13.716005] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.716014] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   13.716046] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   13.716063] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   13.716072] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   13.716138] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.716148] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.716163] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.716171] ? up_read (./arch/x86/include/asm/atomic64_64.h:79 (discrimi=
nator 5) ./include/linux/atomic/atomic-arch-fallback.h:2730 (discriminator =
5) ./include/linux/atomic/atomic-long.h:184 (discriminator 5) ./include/lin=
ux/atomic/atomic-instrumented.h:3289 (discriminator 5) kernel/locking/rwsem=
=2Ec:1347 (discriminator 5) kernel/locking/rwsem.c:1616 (discriminator 5))=
=20
[   13.716179] ? do_user_addr_fault (arch/x86/mm/fault.c:1425 (discriminato=
r 1))=20
[   13.716187] make_task_dead (kernel/exit.c:972)=20
[   13.716194] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.716202] rewind_stack_and_make_dead (??:?)=20
[   13.716213] RIP: 0033:0x7f5484e68025=0D
[ 13.716222] Code: 74 21 48 8d 44 24 08 c7 44 24 b8 20 00 00 00 4c 8b 44 24=
 f0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 19 00 00 00 0f 05 <48> =
3d 00 f0 ff ff 76 10 48 8b 15 dc ed 0a 00 f7 d8 64 89 02 48 83=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	74 21                	je     0x23
   2:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
   7:	c7 44 24 b8 20 00 00 	movl   $0x20,-0x48(%rsp)
   e:	00=20
   f:	4c 8b 44 24 f0       	mov    -0x10(%rsp),%r8
  14:	48 89 44 24 c0       	mov    %rax,-0x40(%rsp)
  19:	48 8d 44 24 d0       	lea    -0x30(%rsp),%rax
  1e:	48 89 44 24 c8       	mov    %rax,-0x38(%rsp)
  23:	b8 19 00 00 00       	mov    $0x19,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	76 10                	jbe    0x42
  32:	48 8b 15 dc ed 0a 00 	mov    0xaeddc(%rip),%rdx        # 0xaee15
  39:	f7 d8                	neg    %eax
  3b:	64 89 02             	mov    %eax,%fs:(%rdx)
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	76 10                	jbe    0x18
   8:	48 8b 15 dc ed 0a 00 	mov    0xaeddc(%rip),%rdx        # 0xaedeb
   f:	f7 d8                	neg    %eax
  11:	64 89 02             	mov    %eax,%fs:(%rdx)
  14:	48                   	rex.W
  15:	83                   	.byte 0x83
[   13.716228] RSP: 002b:00007fff9ae41108 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000019=0D
[   13.716236] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5484e=
68025=0D
[   13.716240] RDX: 0000000003001000 RSI: 0000000002ff1000 RDI: 00007f5480d=
15000=0D
[   13.716244] RBP: 0000000003001000 R08: 0000000000000000 R09: 00000000000=
00000=0D
[   13.716248] R10: 0000000000000001 R11: 0000000000000246 R12: 00007f5480d=
15010=0D
[   13.716252] R13: 0000000002ff1000 R14: 00007f5480d15000 R15: 0000000002f=
f1000=0D
[   13.716258]  </TASK>=0D
[   13.716260] ---[ end trace 0000000000000000 ]---=0D
[ 13.762511] Code: 39 04 24 0f 84 d0 00 00 00 4d 8b 65 18 48 8b 7c 24 10 48=
 8b 6c 24 48 e8 90 b4 a7 ff 49 8d 7c 24 08 49 8b 5d 20 e8 32 b5 a7 ff <4d> =
89 74 24 08 48 89 df 4c 89 64 24 48 e8 20 b5 a7 ff 48 89 2b 48=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	39 04 24             	cmp    %eax,(%rsp)
   3:	0f 84 d0 00 00 00    	je     0xd9
   9:	4d 8b 65 18          	mov    0x18(%r13),%r12
   d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  12:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
  17:	e8 90 b4 a7 ff       	call   0xffffffffffa7b4ac
  1c:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  21:	49 8b 5d 20          	mov    0x20(%r13),%rbx
  25:	e8 32 b5 a7 ff       	call   0xffffffffffa7b55c
  2a:*	4d 89 74 24 08       	mov    %r14,0x8(%r12)		<-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
  37:	e8 20 b5 a7 ff       	call   0xffffffffffa7b55c
  3c:	48 89 2b             	mov    %rbp,(%rbx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
   5:	48 89 df             	mov    %rbx,%rdi
   8:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
   d:	e8 20 b5 a7 ff       	call   0xffffffffffa7b532
  12:	48 89 2b             	mov    %rbp,(%rbx)
  15:	48                   	rex.W
[   13.765044] RSP: 0018:ffff8880042779b8 EFLAGS: 00010282=0D
[   13.765817] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000000=
00000=0D
[   13.766829] RDX: ffff888006a28000 RSI: 0000000000000008 RDI: ffff8880042=
77980=0D
[   13.767797] RBP: ffff888004277a00 R08: 0000000000000000 R09: ffffed10004=
5d017=0D
[   13.768797] R10: ffff8880022e80bf R11: 30303020203a5346 R12: 00000000000=
02800=0D
[   13.769793] R13: ffff888004277650 R14: ffff888004277a00 R15: dead0000000=
00100=0D
[   13.770796] FS:  0000000000000000(0000) GS:ffff888036300000(0000) knlGS:=
0000000000000000=0D
[   13.771954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.772802] CR2: 0000000000002808 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   13.773735] Call Trace:=0D
[   13.774121]  <TASK>=0D
[   13.774522] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[   13.775055] ? page_fault_oops (arch/x86/mm/fault.c:707 (discriminator 1)=
)=20
[   13.775700] ? __pfx_is_prefetch.isra.0 (arch/x86/mm/fault.c:122)=20
[   13.776409] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:635)=20
[   13.777085] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.777756] ? search_bpf_extables (kernel/bpf/core.c:737)=20
[   13.778428] ? fixup_exception (arch/x86/mm/extable.c:254)=20
[   13.779059] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.779669] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.780328] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.780968] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.781586] ? __pfx___blk_flush_plug (block/blk-core.c:1144)=20
[   13.782277] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   13.782918] schedule (./arch/x86/include/asm/current.h:41 (discriminator=
 1) ./include/linux/thread_info.h:185 (discriminator 1) ./include/linux/sch=
ed.h:2240 (discriminator 1) kernel/sched/core.c:6788 (discriminator 1))=20
[   13.783418] schedule_preempt_disabled (./arch/x86/include/asm/preempt.h:=
80 (discriminator 10) kernel/sched/core.c:6846 (discriminator 10))=20
[   13.784116] rwsem_down_write_slowpath (./include/linux/instrumented.h:96=
 kernel/locking/rwsem.c:1180)=20
[   13.784843] ? __pfx_rwsem_down_write_slowpath (kernel/locking/rwsem.c:11=
08)=20
[   13.785595] ? __pfx_folio_activate_fn (mm/swap.c:328)=20
[   13.786234] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem=
=2Ec:1315 kernel/locking/rwsem.c:1574)=20
[   13.786766] ? __pfx_down_write (kernel/locking/rwsem.c:1571)=20
[   13.787342] exit_mmap (./arch/x86/include/asm/jump_label.h:27 ./include/=
linux/jump_label.h:207 ./include/linux/mmap_lock.h:35 ./include/linux/mmap_=
lock.h:95 mm/mmap.c:3207)=20
[   13.787854] ? __pfx_exit_mmap (mm/mmap.c:3174)=20
[   13.788392] ? task_cputime (kernel/sched/cputime.c:860)=20
[   13.788959] ? delayed_uprobe_remove.part.0 (kernel/events/uprobes.c:325)=
=20
[   13.789861] __mmput (kernel/fork.c:1354)=20
[   13.790327] do_exit (./include/linux/instrumented.h:68 ./include/asm-gen=
eric/bitops/instrumented-non-atomic.h:141 ./include/linux/thread_info.h:118=
 kernel/exit.c:568 kernel/exit.c:861)=20
[   13.790751] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.791285] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.791860] make_task_dead (kernel/exit.c:972)=20
[   13.792473] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.792884] rewind_stack_and_make_dead (??:?)=20
[   13.793322] RIP: 0033:0x55868cae5bb6=0D
[ 13.793816] Code: Unable to access opcode bytes at 0x55868cae5b8c.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   13.794487] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.794900] RAX: 0000000002ff0000 RBX: 0000000003000000 RCX: 00000000000=
00001=0D
[   13.795439] RDX: 0000000000000000 RSI: 00007f5480d04010 RDI: 00000000000=
e440c=0D
[   13.795972] RBP: 00007f547dd14010 R08: 000000037b2f9c29 R09: 00000000000=
00000=0D
[   13.796535] R10: 0000000003000000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.797418] R13: 00007f5480d15010 R14: 00007f547dd14010 R15: 00007fff9ae=
412d0=0D
[   13.798271]  </TASK>=0D
[   13.798617] Modules linked in:=0D
[   13.799078] CR2: 0000000000002808=0D
[   13.799530] ---[ end trace 0000000000000000 ]---=0D
[   13.799532] stack segment: 0000 [#14] PREEMPT SMP KASAN NOPTI=0D
[   13.799930] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 13.801543] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.802143] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.803739] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.805590] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   13.805765] =0D
[ 13.806896] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.807402] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.807723] RSP: 0000:ffff888002507040 EFLAGS: 00010282=0D
[   13.809030] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.809569] =0D
[   13.809833] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.810379] RAX: 0000000000000000 RBX: ffffea0000385940 RCX: 00000000000=
00000=0D
[   13.810533] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.811082] RDX: ffff888004412880 RSI: 0000000000000008 RDI: ffff8880025=
07008=0D
[   13.811713] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.812264] RBP: d8ffff888004e19d R08: 1ffff110009c3204 R09: fffff940000=
70b28=0D
[   13.812895] FS:  0000000000000000(0000) GS:ffff888036300000(0000) knlGS:=
0000000000000000=0D
[   13.813449] R10: ffffea0000385947 R11: c91c073e7bbf7c02 R12: 00000000001=
40dca=0D
[   13.814067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.814693] R13: ffff888004e18f69 R14: ffff888004e18f69 R15: ffff888004e=
19029=0D
[   13.815316] CR2: 0000000000002808 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   13.815770] FS:  00007f5484d60cc0(0000) GS:ffff888035e00000(0000) knlGS:=
0000000000000000=0D
[   13.816388] note: stress-ng-bighe[315] exited with irqs disabled=0D
[   13.816927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.819302] Fixing recursive fault but reboot is needed!=0D
[   13.819742] CR2: 00007f547f569010 CR3: 00000000051f6000 CR4: 00000000000=
006f0=0D
[   13.819747] Call Trace:=0D
[   13.819750]  <TASK>=0D
[   13.819752] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   13.819769] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   13.819779] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   13.819787] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   13.819798] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   13.819807] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   13.819813] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   13.819821] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   13.819826] ? lruvec_is_sizable (mm/vmscan.c:4557 (discriminator 1))=20
[   13.819830] ? __pfx_blake2s.constprop.0 (./include/crypto/blake2s.h:89)=
=20
[   13.819839] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   13.819844] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169)=
=20
[   13.819849] ? chacha_block_generic (lib/crypto/chacha.c:77)=20
[   13.819860] evict_folios (mm/vmscan.c:5182)=20
[   13.819867] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   13.819871] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   13.819877] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   13.819882] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:425 (discrimin=
ator 2))=20
[   13.819889] ? cgroup_rstat_updated (kernel/cgroup/rstat.c:42 (discrimina=
tor 3))=20
[   13.819897] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   13.819901] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   13.819914] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   13.819922] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   13.819927] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   13.819933] shrink_one (mm/vmscan.c:5403)=20
[   13.819939] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   13.819945] ? __zone_watermark_ok (mm/page_alloc.c:2966)=20
[   13.819956] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   13.819961] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   13.819966] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   13.819974] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   13.819982] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   13.819988] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   13.819994] try_to_free_pages (mm/vmscan.c:7060)=20
[   13.820001] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   13.820009] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   13.820022] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   13.820032] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   13.820039] ? mas_destroy (lib/maple_tree.c:5593)=20
[   13.820045] ? kmem_cache_free (mm/slub.c:1818 (discriminator 2) mm/slub.=
c:3801 (discriminator 2) mm/slub.c:3823 (discriminator 2))=20
[   13.820052] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   13.820057] ? mas_update_gap (lib/maple_tree.c:1720 lib/maple_tree.c:170=
2)=20
[   13.820063] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   13.820070] __alloc_pages (mm/page_alloc.c:4526)=20
[   13.820076] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   13.820083] ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discr=
iminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discriminat=
or 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) .=
/include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spin=
lock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discri=
minator 4) kernel/locking/spinlock.c:154 (discriminator 4))=20
[   13.820088] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)=20
[   13.820092] __folio_alloc (mm/page_alloc.c:4548)=20
[   13.820098] vma_alloc_folio (./include/linux/mempolicy.h:75 (discriminat=
or 1) ./include/linux/mempolicy.h:80 (discriminator 1) mm/mempolicy.c:2241 =
(discriminator 1))=20
[   13.820106] ? __pfx_vma_alloc_folio (mm/mempolicy.c:2162)=20
[   13.820110] ? set_pte (./arch/x86/include/asm/paravirt.h:436)=20
[   13.820117] ? __pfx_set_pte (./arch/x86/include/asm/paravirt.h:435)=20
[   13.820121] ? __pte_offset_map (./arch/x86/include/asm/pgtable.h:816 (di=
scriminator 2) ./include/linux/pgtable.h:92 (discriminator 2) ./include/lin=
ux/pgtable.h:107 (discriminator 2) mm/pgtable-generic.c:251 (discriminator =
2))=20
[   13.820133] do_anonymous_page (mm/memory.c:4110)=20
[   13.820143] __handle_mm_fault (mm/memory.c:3667 mm/memory.c:4945 mm/memo=
ry.c:5085)=20
[   13.820151] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   13.820157] ? find_vma (mm/mmap.c:1861)=20
[   13.820165] ? __pfx_find_vma (mm/mmap.c:1861)=20
[   13.820172] handle_mm_fault (mm/memory.c:5250)=20
[   13.820177] do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.820184] exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x=
86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.820191] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.820196] RIP: 0033:0x55868cae5bb6=0D
[ 13.820201] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   13.820205] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.820209] RAX: 0000000000006000 RBX: 0000000007860000 RCX: 00000000000=
00001=0D
[   13.820211] RDX: 0000000000000000 RSI: 00007f547f569010 RDI: 00000000004=
eec10=0D
[   13.820214] RBP: 00007f5477d13010 R08: 00000003915e8153 R09: 00000000000=
00000=0D
[   13.820216] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.820219] R13: 00007f5477d13010 R14: 00007f547f563010 R15: 00007fff9ae=
412d0=0D
[   13.820224]  </TASK>=0D
[   13.820225] Modules linked in:=0D
[   13.820232] BUG: unable to handle page fault for address: ffffffffaa8547=
a6=0D
[   13.820237] #PF: supervisor write access in kernel mode=0D
[   13.820241] #PF: error_code(0x0003) - permissions violation=0D
[   13.820245] PGD b059067 P4D b059067 PUD b05a063 PMD 800000000a8001e1 =0D
[   13.820254] Oops: 0003 [#15] PREEMPT SMP KASAN NOPTI=0D
[   13.820264] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.820268] RIP: 0010:__blk_flush_plug (./include/linux/list.h:449 ./inc=
lude/linux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[ 13.820290] Code: 39 04 24 0f 84 d0 00 00 00 4d 8b 65 18 48 8b 7c 24 10 48=
 8b 6c 24 48 e8 90 b4 a7 ff 49 8d 7c 24 08 49 8b 5d 20 e8 32 b5 a7 ff <4d> =
89 74 24 08 48 89 df 4c 89 64 24 48 e8 20 b5 a7 ff 48 89 2b 48=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	39 04 24             	cmp    %eax,(%rsp)
   3:	0f 84 d0 00 00 00    	je     0xd9
   9:	4d 8b 65 18          	mov    0x18(%r13),%r12
   d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  12:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
  17:	e8 90 b4 a7 ff       	call   0xffffffffffa7b4ac
  1c:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  21:	49 8b 5d 20          	mov    0x20(%r13),%rbx
  25:	e8 32 b5 a7 ff       	call   0xffffffffffa7b55c
  2a:*	4d 89 74 24 08       	mov    %r14,0x8(%r12)		<-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
  37:	e8 20 b5 a7 ff       	call   0xffffffffffa7b55c
  3c:	48 89 2b             	mov    %rbp,(%rbx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
   5:	48 89 df             	mov    %rbx,%rdi
   8:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
   d:	e8 20 b5 a7 ff       	call   0xffffffffffa7b532
  12:	48 89 2b             	mov    %rbp,(%rbx)
  15:	48                   	rex.W
[   13.820295] RSP: 0018:ffff8880069779b8 EFLAGS: 00010246=0D
[   13.820299] RAX: 0000000000000000 RBX: ffffffffa85a6a00 RCX: ffffffffa8b=
8cc6e=0D
[   13.820302] RDX: 0000000000000005 RSI: dffffc0000000000 RDI: ffffffffaa8=
547a6=0D
[   13.820305] RBP: ffff888006977a00 R08: 1ffffffff550a8f4 R09: ffffed1000e=
67017=0D
[   13.820308] R10: ffff8880073380bf R11: 3030303030302052 R12: ffffffffaa8=
5479e=0D
[   13.820311] R13: ffff888006977650 R14: ffff888006977a00 R15: dead0000000=
00100=0D
[   13.820317] FS:  0000000000000000(0000) GS:ffff888036100000(0000) knlGS:=
0000000000000000=0D
[   13.820320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.820323] CR2: ffffffffaa8547a6 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   13.820328] Call Trace:=0D
[   13.820331]  <TASK>=0D
[   13.820334] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[   13.820341] ? page_fault_oops (arch/x86/mm/fault.c:707 (discriminator 1)=
)=20
[   13.820346] ? __pfx_is_prefetch.isra.0 (arch/x86/mm/fault.c:122)=20
[   13.820351] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:635)=20
[   13.820356] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.820362] ? search_bpf_extables (kernel/bpf/core.c:737)=20
[   13.820370] ? fixup_exception (arch/x86/mm/extable.c:254)=20
[   13.820380] ? release_pages (mm/swap.c:961)=20
[   13.820390] ? exc_page_fault (arch/x86/mm/fault.c:1485 arch/x86/mm/fault=
=2Ec:1543)=20
[   13.820395] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.820400] ? __pfx___rmqueue_pcplist (mm/page_alloc.c:2761)=20
[   13.820407] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.820414] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.820418] ---[ end trace 0000000000000000 ]---=0D
[   13.820420] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.820421] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 13.820427] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.820427] ? __pfx___blk_flush_plug (block/blk-core.c:1144)=20
[   13.820431] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.820434] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.820435] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   13.820437] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.820440] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.820441] schedule (./arch/x86/include/asm/current.h:41 (discriminator=
 1) ./include/linux/thread_info.h:185 (discriminator 1) ./include/linux/sch=
ed.h:2240 (discriminator 1) kernel/sched/core.c:6788 (discriminator 1))=20
[   13.820443] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.820446] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.820447] schedule_preempt_disabled (./arch/x86/include/asm/preempt.h:=
80 (discriminator 10) kernel/sched/core.c:6846 (discriminator 10))=20
[   13.820450] FS:  00007f5484d60cc0(0000) GS:ffff888035e00000(0000) knlGS:=
0000000000000000=0D
[   13.820454] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.820453] rwsem_down_write_slowpath (./include/linux/instrumented.h:96=
 kernel/locking/rwsem.c:1180)=20
[   13.820456] CR2: 00007f547f569010 CR3: 00000000051f6000 CR4: 00000000000=
006f0=0D
[   13.820463] ? __pfx_rwsem_down_write_slowpath (kernel/locking/rwsem.c:11=
08)=20
[   13.820473] ? __pfx_folio_activate_fn (mm/swap.c:328)=20
[   13.820484] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem=
=2Ec:1315 kernel/locking/rwsem.c:1574)=20
[   13.820488] ------------[ cut here ]------------=0D
[   13.820490] ? __pfx_down_write (kernel/locking/rwsem.c:1571)=20
[   13.820490] WARNING: CPU: 0 PID: 301 at kernel/exit.c:818 do_exit (kerne=
l/exit.c:818 (discriminator 1))=20
[   13.820497] exit_mmap (./arch/x86/include/asm/jump_label.h:27 ./include/=
linux/jump_label.h:207 ./include/linux/mmap_lock.h:35 ./include/linux/mmap_=
lock.h:95 mm/mmap.c:3207)=20
[   13.820502] Modules linked in:=0D
[   13.820503] ? __pfx_exit_mmap (mm/mmap.c:3174)=20
[   13.820509] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.820507] ? task_cputime (kernel/sched/cputime.c:860)=20
[   13.820511] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[ 13.820516] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   13.820520] RSP: 0000:ffff888002507e60 EFLAGS: 00010286=0D
[   13.820523] RAX: 0000000000000000 RBX: ffff888004412880 RCX: ffffffffa81=
71c65=0D
[   13.820520] ? delayed_uprobe_remove.part.0 (kernel/events/uprobes.c:325)=
=20
[   13.820526] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880044=
13588=0D
[   13.820529] RBP: ffff888006b64600 R08: 0000000000000001 R09: ffffed10004=
a0fc1=0D
[   13.820532] R10: 0000000000000003 R11: 00000000ffffffff R12: 00000000000=
0000b=0D
[   13.820531] __mmput (kernel/fork.c:1354)=20
[   13.820534] R13: ffff8880044134a0 R14: ffff888006b5a300 R15: 00000000000=
00007=0D
[   13.820538] FS:  00007f5484d60cc0(0000) GS:ffff888035e00000(0000) knlGS:=
0000000000000000=0D
[   13.820539] do_exit (./include/linux/instrumented.h:68 ./include/asm-gen=
eric/bitops/instrumented-non-atomic.h:141 ./include/linux/thread_info.h:118=
 kernel/exit.c:568 kernel/exit.c:861)=20
[   13.820542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.820545] CR2: 00007f547f569010 CR3: 00000000051f6000 CR4: 00000000000=
006f0=0D
[   13.820548] Call Trace:=0D
[   13.820547] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.820550]  <TASK>=0D
[   13.820553] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   13.820552] ? __warn (kernel/panic.c:673)=20
[   13.820560] make_task_dead (kernel/exit.c:972)=20
[   13.820561] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.820566] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.820572] rewind_stack_and_make_dead (??:?)=20
[   13.820566] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   13.820581] RIP: 0033:0x55868cae5bb6=0D
[ 13.820585] Code: Unable to access opcode bytes at 0x55868cae5b8c.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   13.820584] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   13.820588] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.820591] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   13.820592] RAX: 0000000000001000 RBX: 0000000003780000 RCX: 00000000000=
00001=0D
[   13.820596] RDX: 0000000000000000 RSI: 00007f5481485010 RDI: 00000000001=
d77d0=0D
[   13.820596] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   13.820599] RBP: 00007f547dd14010 R08: 000000037b6416c4 R09: 00000000000=
00000=0D
[   13.820602] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.820602] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.820605] R13: 00007f547dd14010 R14: 00007f5481484010 R15: 00007fff9ae=
412d0=0D
[   13.820608] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   13.820611]  </TASK>=0D
[   13.820612] Modules linked in:=0D
[   13.820615] CR2: ffffffffaa8547a6=0D
[   13.820614] ? handle_mm_fault (mm/memory.c:5250)=20
[   13.820617] ---[ end trace 0000000000000000 ]---=0D
[   13.820619] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.820619] BUG: kernel NULL pointer dereference, address: 0000000000000=
008=0D
[   13.820619] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   13.820625] #PF: supervisor write access in kernel mode=0D
[   13.820625] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[ 13.820626] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.820628] #PF: error_code(0x0002) - not-present page=0D
[   13.820631] PGD 0 =0D
[   13.820631] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.820630] make_task_dead (kernel/exit.c:972)=20
[   13.820633] P4D 0 =0D
[   13.820634] =0D
[   13.820636] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.820636] Oops: 0002 [#16] PREEMPT SMP KASAN NOPTI=0D
[   13.820636] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.820639] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.820642] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.820641] rewind_stack_and_make_dead (??:?)=20
[   13.820645] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.820645] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.820646] RIP: 0033:0x55868cae5bb6=0D
[   13.820648] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[ 13.820649] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   13.820647] RIP: 0010:__blk_flush_plug (./include/linux/list.h:449 ./inc=
lude/linux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.820653] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   13.820653] FS:  0000000000000000(0000) GS:ffff888036100000(0000) knlGS:=
0000000000000000=0D
[   13.820655] =0D
[ 13.820656] Code: 39 04 24 0f 84 d0 00 00 00 4d 8b 65 18 48 8b 7c 24 10 48=
 8b 6c 24 48 e8 90 b4 a7 ff 49 8d 7c 24 08 49 8b 5d 20 e8 32 b5 a7 ff <4d> =
89 74 24 08 48 89 df 4c 89 64 24 48 e8 20 b5 a7 ff 48 89 2b 48=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	39 04 24             	cmp    %eax,(%rsp)
   3:	0f 84 d0 00 00 00    	je     0xd9
   9:	4d 8b 65 18          	mov    0x18(%r13),%r12
   d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  12:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
  17:	e8 90 b4 a7 ff       	call   0xffffffffffa7b4ac
  1c:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  21:	49 8b 5d 20          	mov    0x20(%r13),%rbx
  25:	e8 32 b5 a7 ff       	call   0xffffffffffa7b55c
  2a:*	4d 89 74 24 08       	mov    %r14,0x8(%r12)		<-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
  37:	e8 20 b5 a7 ff       	call   0xffffffffffa7b55c
  3c:	48 89 2b             	mov    %rbp,(%rbx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
   5:	48 89 df             	mov    %rbx,%rdi
   8:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
   d:	e8 20 b5 a7 ff       	call   0xffffffffffa7b532
  12:	48 89 2b             	mov    %rbp,(%rbx)
  15:	48                   	rex.W
[   13.820657] RAX: 0000000000006000 RBX: 0000000007860000 RCX: 00000000000=
00001=0D
[   13.820657] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.820660] RDX: 0000000000000000 RSI: 00007f547f569010 RDI: 00000000004=
eec10=0D
[   13.820660] CR2: ffffffffaa8547a6 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   13.820660] RSP: 0018:ffff8880029ffa88 EFLAGS: 00010286=0D
[   13.820662] RBP: 00007f5477d13010 R08: 00000003915e8153 R09: 00000000000=
00000=0D
[   13.820663] =0D
[   13.820665] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000=0D
[   13.820665] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   13.820666] note: stress-ng-bighe[313] exited with irqs disabled=0D
[   13.820667] RDX: ffff888006a2d100 RSI: 0000000000000008 RDI: ffff8880029=
ffa50=0D
[   13.820668] R13: 00007f5477d13010 R14: 00007f547f563010 R15: 00007fff9ae=
412d0=0D
[   13.820670] RBP: ffff8880029ffad0 R08: 0000000000000001 R09: ffffed1000d=
45a23=0D
[   13.820673] R10: ffff888006a2d11b R11: 0000000000000000 R12: 00000000000=
00000=0D
[   13.820673]  </TASK>=0D
[   13.820676] ---[ end trace 0000000000000000 ]---=0D
[   13.820675] R13: ffff8880029ff398 R14: ffff8880029ffad0 R15: dead0000000=
00100=0D
[   13.820680] FS:  00007f5484d60cc0(0000) GS:ffff888036080000(0000) knlGS:=
0000000000000000=0D
[   13.820684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.820687] CR2: 0000000000000008 CR3: 000000000520a000 CR4: 00000000000=
006e0=0D
[   13.820691] Call Trace:=0D
[   13.820693] Fixing recursive fault but reboot is needed!=0D
[   13.820694]  <TASK>=0D
[   13.820698] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[   13.820705] ? page_fault_oops (arch/x86/mm/fault.c:707 (discriminator 1)=
)=20
[   13.820710] ? __pfx_is_prefetch.isra.0 (arch/x86/mm/fault.c:122)=20
[   13.820714] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:635)=20
[   13.820719] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.820725] ? search_bpf_extables (kernel/bpf/core.c:737)=20
[   13.820730] ? fixup_exception (arch/x86/mm/extable.c:254)=20
[   13.820736] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.820741] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   13.820748] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.820754] ? __blk_flush_plug (./include/linux/list.h:449 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   13.820760] ? __pfx___blk_flush_plug (block/blk-core.c:1144)=20
[   13.820766] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   13.820772] schedule (./arch/x86/include/asm/current.h:41 (discriminator=
 1) ./include/linux/thread_info.h:185 (discriminator 1) ./include/linux/sch=
ed.h:2240 (discriminator 1) kernel/sched/core.c:6788 (discriminator 1))=20
[   13.820776] schedule_preempt_disabled (./arch/x86/include/asm/preempt.h:=
80 (discriminator 10) kernel/sched/core.c:6846 (discriminator 10))=20
[   13.820780] rwsem_down_read_slowpath (kernel/locking/rwsem.c:1072)=20
[   13.820787] ? __pfx_rwsem_down_read_slowpath (kernel/locking/rwsem.c:997=
)=20
[   13.820795] ? finish_task_switch.isra.0 (./arch/x86/include/asm/atomic.h=
:67 (discriminator 1) ./include/linux/atomic/atomic-arch-fallback.h:2261 (d=
iscriminator 1) ./include/linux/atomic/atomic-instrumented.h:1376 (discrimi=
nator 1) ./include/linux/sched/mm.h:53 (discriminator 1) ./include/linux/sc=
hed/mm.h:82 (discriminator 1) ./include/linux/sched/mm.h:109 (discriminator=
 1) kernel/sched/core.c:5278 (discriminator 1))=20
[   13.820801] down_read (./arch/x86/include/asm/preempt.h:95 (discriminato=
r 1) kernel/locking/rwsem.c:1257 (discriminator 1) kernel/locking/rwsem.c:1=
263 (discriminator 1) kernel/locking/rwsem.c:1522 (discriminator 1))=20
[   13.820806] ? __schedule (kernel/sched/core.c:6592)=20
[   13.820810] ? __pfx_down_read (kernel/locking/rwsem.c:1518)=20
[   13.820815] ? check_panic_on_warn (./arch/x86/include/asm/atomic.h:85 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:555 (discrimi=
nator 4) ./include/linux/atomic/atomic-arch-fallback.h:1011 (discriminator =
4) ./include/linux/atomic/atomic-instrumented.h:454 (discriminator 4) kerne=
l/panic.c:239 (discriminator 4))=20
[   13.820822] acct_collect (./arch/x86/include/asm/jump_label.h:27 ./inclu=
de/linux/jump_label.h:207 ./include/linux/mmap_lock.h:35 ./include/linux/mm=
ap_lock.h:143 kernel/acct.c:564)=20
[   13.820829] ? __pfx_acct_collect (kernel/acct.c:554)=20
[   13.820834] ? acct_update_integrals (kernel/tsacct.c:133 kernel/tsacct.c=
:159)=20
[   13.820841] ? exit_itimers (./include/linux/list.h:292 (discriminator 2)=
 kernel/time/posix-timers.c:1098 (discriminator 2))=20
[   13.820847] ? sched_mm_cid_before_execve (./arch/x86/include/asm/irqflag=
s.h:134 (discriminator 1) kernel/sched/sched.h:1392 (discriminator 1) kerne=
l/sched/sched.h:1684 (discriminator 1) kernel/sched/core.c:12024 (discrimin=
ator 1))=20
[   13.820854] ? hrtimer_active (kernel/time/hrtimer.c:1621 (discriminator =
2))=20
[   13.820861] do_exit (kernel/exit.c:855)=20
[   13.820867] ? __pfx_do_exit (kernel/exit.c:810)=20
[   13.820872] ? up_read (./arch/x86/include/asm/atomic64_64.h:79 (discrimi=
nator 5) ./include/linux/atomic/atomic-arch-fallback.h:2730 (discriminator =
5) ./include/linux/atomic/atomic-long.h:184 (discriminator 5) ./include/lin=
ux/atomic/atomic-instrumented.h:3289 (discriminator 5) kernel/locking/rwsem=
=2Ec:1347 (discriminator 5) kernel/locking/rwsem.c:1616 (discriminator 5))=
=20
[   13.820877] ? do_user_addr_fault (arch/x86/mm/fault.c:1425 (discriminato=
r 1))=20
[   13.820882] make_task_dead (kernel/exit.c:972)=20
[   13.820887] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   13.820892] rewind_stack_and_make_dead (??:?)=20
[   13.820896] RIP: 0033:0x7f5484e68025=0D
[ 13.820901] Code: 74 21 48 8d 44 24 08 c7 44 24 b8 20 00 00 00 4c 8b 44 24=
 f0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 19 00 00 00 0f 05 <48> =
3d 00 f0 ff ff 76 10 48 8b 15 dc ed 0a 00 f7 d8 64 89 02 48 83=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	74 21                	je     0x23
   2:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
   7:	c7 44 24 b8 20 00 00 	movl   $0x20,-0x48(%rsp)
   e:	00=20
   f:	4c 8b 44 24 f0       	mov    -0x10(%rsp),%r8
  14:	48 89 44 24 c0       	mov    %rax,-0x40(%rsp)
  19:	48 8d 44 24 d0       	lea    -0x30(%rsp),%rax
  1e:	48 89 44 24 c8       	mov    %rax,-0x38(%rsp)
  23:	b8 19 00 00 00       	mov    $0x19,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping =
instruction
  30:	76 10                	jbe    0x42
  32:	48 8b 15 dc ed 0a 00 	mov    0xaeddc(%rip),%rdx        # 0xaee15
  39:	f7 d8                	neg    %eax
  3b:	64 89 02             	mov    %eax,%fs:(%rdx)
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	76 10                	jbe    0x18
   8:	48 8b 15 dc ed 0a 00 	mov    0xaeddc(%rip),%rdx        # 0xaedeb
   f:	f7 d8                	neg    %eax
  11:	64 89 02             	mov    %eax,%fs:(%rdx)
  14:	48                   	rex.W
  15:	83                   	.byte 0x83
[   13.820905] RSP: 002b:00007fff9ae41108 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000019=0D
[   13.820909] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5484e=
68025=0D
[   13.820911] RDX: 0000000003001000 RSI: 0000000002ff1000 RDI: 00007f5480d=
15000=0D
[   13.820914] RBP: 0000000003001000 R08: 0000000000000000 R09: 00000000000=
00000=0D
[   13.820916] R10: 0000000000000001 R11: 0000000000000246 R12: 00007f5480d=
15010=0D
[   13.820918] R13: 0000000002ff1000 R14: 00007f5480d15000 R15: 0000000002f=
f1000=0D
[   13.820924]  </TASK>=0D
[   13.820925] Modules linked in:=0D
[   13.820927] CR2: 0000000000000008=0D
[   13.820931] stack segment: 0000 [#17] PREEMPT SMP KASAN NOPTI=0D
[   13.820941] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   13.820944] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   13.820962] ---[ end trace 0000000000000000 ]---=0D
[   13.820964] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 13.820969] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.820973] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   13.820976] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   13.820979] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   13.820983] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   13.820986] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   13.820990] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   13.820995] FS:  00007f5484d60cc0(0000) GS:ffff888036080000(0000) knlGS:=
0000000000000000=0D
[   13.820999] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.821002] CR2: 0000000000000008 CR3: 000000000520a000 CR4: 00000000000=
006e0=0D
[   13.821009] Fixing recursive fault but reboot is needed!=0D
[ 13.987367] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   13.988838] RSP: 0018:ffff88800138ef98 EFLAGS: 00010286=0D
[   13.989316] RAX: 0000000000000000 RBX: ffffea00003859c0 RCX: 00000000000=
00000=0D
[   13.989973] RDX: ffff888001360000 RSI: 0000000000000008 RDI: ffff8880013=
8ef60=0D
[   13.990616] RBP: d8ffff888004e19d R08: 1ffff110009c3204 R09: fffff940000=
70b38=0D
[   13.991303] R10: ffffea00003859c7 R11: 000000000000001d R12: 00000000004=
00dc0=0D
[   13.991915] R13: ffff888004e18f69 R14: ffff888004e18f69 R15: ffff888004e=
19029=0D
[   13.992543] FS:  0000000000000000(0000) GS:ffff888035e80000(0000) knlGS:=
0000000000000000=0D
[   13.993208] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   13.993688] CR2: 00007f548167d010 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   13.994259] Call Trace:=0D
[   13.994525]  <TASK>=0D
[   13.994750] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   13.995037] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   13.995383] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   13.995722] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   13.996084] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   13.996498] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   13.996892] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   13.997309] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   13.997685] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   13.998074] ? lruvec_is_sizable (mm/vmscan.c:4557 (discriminator 1))=20
[   13.998619] ? _raw_spin_trylock (./arch/x86/include/asm/atomic.h:115 (di=
scriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrimi=
nator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4=
) ./include/asm-generic/qspinlock.h:97 (discriminator 4) ./include/linux/sp=
inlock.h:192 (discriminator 4) ./include/linux/spinlock_api_smp.h:89 (discr=
iminator 4) kernel/locking/spinlock.c:138 (discriminator 4))=20
[   13.999148] ? __list_add_valid (lib/list_debug.c:30)=20
[   13.999669] ? asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/id=
tentry.h:645)=20
[   14.000313] evict_folios (mm/vmscan.c:5182)=20
[   14.000801] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   14.001333] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   14.001956] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   14.002581] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:425 (discrimin=
ator 2))=20
[   14.003099] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   14.005324] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   14.005938] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   14.006520] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   14.007128] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   14.007654] shrink_one (mm/vmscan.c:5403)=20
[   14.008136] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   14.008639] ? __pfx_compact_zone (mm/compaction.c:2352)=20
[   14.009182] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   14.009714] ? compact_zone_order (mm/compaction.c:2628 (discriminator 2)=
)=20
[   14.010256] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   14.010820] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   14.011429] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   14.012023] try_to_free_pages (mm/vmscan.c:7060)=20
[   14.012548] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   14.013115] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   14.013645] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   14.014324] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   14.015034] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   14.015659] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   14.016335] __alloc_pages (mm/page_alloc.c:4526)=20
[   14.016812] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   14.017351] ? kmem_cache_alloc_node (mm/slub.c:3472 mm/slub.c:3515)=20
[   14.017917] ? copy_process (./include/linux/list.h:945 (discriminator 2)=
 kernel/fork.c:2327 (discriminator 2))=20
[   14.018441] copy_process (./include/linux/gfp.h:237 ./include/linux/gfp.=
h:260 kernel/fork.c:358 kernel/fork.c:1118 kernel/fork.c:2335)=20
[   14.018910] ? newidle_balance (kernel/sched/sched.h:1627 kernel/sched/fa=
ir.c:11940)=20
[   14.019423] ? update_load_avg (kernel/sched/fair.c:4257)=20
[   14.019931] ? __pfx_copy_process (kernel/fork.c:2253)=20
[   14.020465] ? psi_group_change (./arch/x86/include/asm/bitops.h:207 ./ar=
ch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-n=
on-atomic.h:142 kernel/sched/psi.c:876)=20
[   14.020998] ? record_times (kernel/sched/psi.c:771)=20
[   14.021477] ? finish_task_switch.isra.0 (./arch/x86/include/asm/paravirt=
=2Eh:700 kernel/sched/sched.h:1378 kernel/sched/core.c:5133 kernel/sched/co=
re.c:5251)=20
[   14.022076] kernel_clone (./include/linux/random.h:26 kernel/fork.c:2918=
)=20
[   14.022554] ? __schedule (kernel/sched/core.c:6592)=20
[   14.023025] ? __pfx_kernel_clone (kernel/fork.c:2877)=20
[   14.023577] ? __set_cpus_allowed_ptr (kernel/sched/core.c:3176)=20
[   14.024138] kernel_thread (kernel/fork.c:2968)=20
[   14.024594] ? __pfx_kernel_thread (kernel/fork.c:2968)=20
[   14.025137] ? __pfx_kthread (kernel/kthread.c:342)=20
[   14.025642] ? __list_del_entry_valid (lib/list_debug.c:62)=20
[   14.026214] kthreadd (kernel/kthread.c:412 kernel/kthread.c:747)=20
[   14.026682] ? __pfx_kthreadd (kernel/kthread.c:720)=20
[   14.027176] ret_from_fork (arch/x86/entry/entry_64.S:314)=20
[   14.027674]  </TASK>=0D
[   14.027987] Modules linked in:=0D
[   14.028407] BUG: kernel NULL pointer dereference, address: 0000000000000=
79d=0D
[   14.028439] ---[ end trace 0000000000000000 ]---=0D
[   14.029036] #PF: supervisor write access in kernel mode=0D
[   14.029480] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   14.029949] #PF: error_code(0x0002) - not-present page=0D
[ 14.030429] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   14.030886] PGD 0 =0D
[   14.032562] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   14.032747] P4D 0 =0D
[   14.032935] =0D
[   14.033417] =0D
[   14.033419] Oops: 0002 [#18] PREEMPT SMP KASAN NOPTI=0D
[   14.033556] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   14.033795] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   14.034193] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   14.034196] RIP: 0010:__blk_flush_plug (./include/linux/list.h:452 ./inc=
lude/linux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   14.034657] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[ 14.035116] Code: 48 8b 6c 24 48 e8 90 b4 a7 ff 49 8d 7c 24 08 49 8b 5d 20=
 e8 32 b5 a7 ff 4d 89 74 24 08 48 89 df 4c 89 64 24 48 e8 20 b5 a7 ff <48> =
89 2b 48 8d 7d 08 e8 14 b5 a7 ff 48 8b 04 24 48 89 5d 08 49 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
   5:	e8 90 b4 a7 ff       	call   0xffffffffffa7b49a
   a:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
   f:	49 8b 5d 20          	mov    0x20(%r13),%rbx
  13:	e8 32 b5 a7 ff       	call   0xffffffffffa7b54a
  18:	4d 89 74 24 08       	mov    %r14,0x8(%r12)
  1d:	48 89 df             	mov    %rbx,%rdi
  20:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
  25:	e8 20 b5 a7 ff       	call   0xffffffffffa7b54a
  2a:*	48 89 2b             	mov    %rbp,(%rbx)		<-- trapping instruction
  2d:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  31:	e8 14 b5 a7 ff       	call   0xffffffffffa7b54a
  36:	48 8b 04 24          	mov    (%rsp),%rax
  3a:	48 89 5d 08          	mov    %rbx,0x8(%rbp)
  3e:	49                   	rex.WB
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 89 2b             	mov    %rbp,(%rbx)
   3:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
   7:	e8 14 b5 a7 ff       	call   0xffffffffffa7b520
   c:	48 8b 04 24          	mov    (%rsp),%rax
  10:	48 89 5d 08          	mov    %rbx,0x8(%rbp)
  14:	49                   	rex.WB
  15:	89                   	.byte 0x89
[   14.035121] RSP: 0018:ffff8880025079b8 EFLAGS: 00010282=0D
[   14.035124] RAX: 0000000000000000 RBX: 000000000000079d RCX: 00000000000=
00000=0D
[   14.035548] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   14.036024] RDX: ffff888004412880 RSI: 0000000000000008 RDI: ffff8880025=
07980=0D
[   14.036346] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   14.036863] RBP: ffff888002507a00 R08: 0000000000000000 R09: ffffed1000d=
48197=0D
[   14.037916] FS:  0000000000000000(0000) GS:ffff888035e80000(0000) knlGS:=
0000000000000000=0D
[   14.038210] R10: ffff888006a40cbf R11: 0000000000000000 R12: ffff888006b=
b0008=0D
[   14.038212] R13: ffff888002507650 R14: ffff888002507a00 R15: dead0000000=
00100=0D
[   14.038216] FS:  00007f5484d60cc0(0000) GS:ffff888036100000(0000) knlGS:=
0000000000000000=0D
[   14.038616] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.039180] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.039185] CR2: 000000000000079d CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   14.039190] Call Trace:=0D
[   14.039638] CR2: 00007f548167d010 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   14.040289]  <TASK>=0D
[   14.040292] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[   14.040926] ------------[ cut here ]------------=0D
[   14.041648] ? page_fault_oops (arch/x86/mm/fault.c:707 (discriminator 1)=
)=20
[   14.042065] WARNING: CPU: 1 PID: 2 at kernel/exit.c:818 do_exit (kernel/=
exit.c:818 (discriminator 1))=20
[   14.042741] ? __pfx_is_prefetch.isra.0 (arch/x86/mm/fault.c:122)=20
[   14.042747] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:635)=20
[   14.043228] Modules linked in:=0D
[   14.043769] ? __blk_flush_plug (./include/linux/list.h:452 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   14.044104] =0D
[   14.044765] ? search_bpf_extables (kernel/bpf/core.c:737)=20
[   14.045592] ? fixup_exception (arch/x86/mm/extable.c:254)=20
[   14.045724] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   14.046025] ? release_pages (mm/swap.c:961)=20
[   14.046321] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.046704] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[ 14.047105] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   14.047553] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   14.047809] RSP: 0018:ffff88800138fe60 EFLAGS: 00010282=0D
[   14.048109] ? __blk_flush_plug (./include/linux/list.h:452 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   14.048374] =0D
[   14.048526] ? __blk_flush_plug (./include/linux/list.h:452 ./include/lin=
ux/list.h:491 block/blk-core.c:1106 block/blk-core.c:1146)=20
[   14.048766] RAX: 0000000000000000 RBX: ffff888001360000 RCX: ffffffffa81=
71c65=0D
[   14.049468] ? __pfx___blk_flush_plug (block/blk-core.c:1144)=20
[   14.049702] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880013=
60d08=0D
[   14.050545] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   14.050772] RBP: ffff888001385000 R08: 0000000000000001 R09: ffffed10002=
71fc1=0D
[   14.051168] schedule (./arch/x86/include/asm/current.h:41 (discriminator=
 1) ./include/linux/thread_info.h:185 (discriminator 1) ./include/linux/sch=
ed.h:2240 (discriminator 1) kernel/sched/core.c:6788 (discriminator 1))=20
[   14.051402] R10: 0000000000000003 R11: 3030303030302052 R12: 00000000000=
0000b=0D
[   14.053148] schedule_preempt_disabled (./arch/x86/include/asm/preempt.h:=
80 (discriminator 10) kernel/sched/core.c:6846 (discriminator 10))=20
[   14.053156] rwsem_down_write_slowpath (./include/linux/instrumented.h:96=
 kernel/locking/rwsem.c:1180)=20
[   14.053408] R13: ffff888001360c20 R14: ffff88800137e900 R15: 00000000000=
00007=0D
[   14.053912] ? __pfx_rwsem_down_write_slowpath (kernel/locking/rwsem.c:11=
08)=20
[   14.054181] FS:  0000000000000000(0000) GS:ffff888035e80000(0000) knlGS:=
0000000000000000=0D
[   14.054340] ? down_trylock (kernel/locking/semaphore.c:145)=20
[   14.054578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.055251] down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem=
=2Ec:1315 kernel/locking/rwsem.c:1574)=20
[   14.055529] CR2: 00007f548167d010 CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   14.056193] ? __pfx_down_write (kernel/locking/rwsem.c:1571)=20
[   14.056448] Call Trace:=0D
[   14.057123] exit_mmap (./arch/x86/include/asm/jump_label.h:27 ./include/=
linux/jump_label.h:207 ./include/linux/mmap_lock.h:35 ./include/linux/mmap_=
lock.h:95 mm/mmap.c:3207)=20
[   14.057345]  <TASK>=0D
[   14.058022] ? __pfx_exit_mmap (mm/mmap.c:3174)=20
[   14.058325] ? __warn (kernel/panic.c:673)=20
[   14.058772] ? task_cputime (kernel/sched/cputime.c:860)=20
[   14.059205] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.059712] ? delayed_uprobe_remove.part.0 (kernel/events/uprobes.c:325)=
=20
[   14.060194] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   14.060572] __mmput (kernel/fork.c:1354)=20
[   14.060894] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   14.061224] do_exit (./include/linux/instrumented.h:68 ./include/asm-gen=
eric/bitops/instrumented-non-atomic.h:141 ./include/linux/thread_info.h:118=
 kernel/exit.c:568 kernel/exit.c:861)=20
[   14.061642] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   14.062026] ? __pfx_do_exit (kernel/exit.c:810)=20
[   14.062200] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   14.062536] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   14.062661] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.063028] make_task_dead (kernel/exit.c:972)=20
[   14.063243] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.063603] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   14.063805] ? __list_del_entry_valid (lib/list_debug.c:62)=20
[   14.064298] rewind_stack_and_make_dead (??:?)=20
[   14.064304] RIP: 0033:0x55868cae5bb6=0D
[   14.064507] ? __pfx_do_exit (kernel/exit.c:810)=20
[ 14.064678] Code: Unable to access opcode bytes at 0x55868cae5b8c.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   14.064864] ? kthreadd (kernel/kthread.c:412 kernel/kthread.c:747)=20
[   14.065133] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   14.065137] RAX: 0000000000006000 RBX: 0000000007860000 RCX: 00000000000=
00001=0D
[   14.065140] RDX: 0000000000000000 RSI: 00007f547f569010 RDI: 00000000004=
eec10=0D
[   14.065379] make_task_dead (kernel/exit.c:972)=20
[   14.065692] RBP: 00007f5477d13010 R08: 00000003915e8153 R09: 00000000000=
00000=0D
[   14.065914] rewind_stack_and_make_dead (??:?)=20
[   14.066310] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   14.066313] R13: 00007f5477d13010 R14: 00007f547f563010 R15: 00007fff9ae=
412d0=0D
[   14.066516] RIP: 0000:0x0=0D
[   14.066868]  </TASK>=0D
[ 14.067069] Code: Unable to access opcode bytes at 0xffffffffffffffd6.=0D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   14.067433] Modules linked in:=0D
[   14.067437] CR2: 000000000000079d=0D
[   14.067439] ---[ end trace 0000000000000000 ]---=0D
[   14.067441] stack segment: 0000 [#19] PREEMPT SMP KASAN NOPTI=0D
[   14.067451] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   14.067454] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 14.067464] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   14.067469] RSP: 0018:ffff888006f87040 EFLAGS: 00010282=0D
[   14.067478] RAX: 0000000000000000 RBX: ffffea0000385a40 RCX: 00000000000=
00000=0D
[   14.067481] RDX: ffff888002742880 RSI: 0000000000000008 RDI: ffff888006f=
87008=0D
[   14.067485] RBP: d8ffff888004e19d R08: 1ffff110009c3204 R09: fffff940000=
70b48=0D
[   14.067488] R10: ffffea0000385a47 R11: d533d7f006007076 R12: 00000000001=
40dca=0D
[   14.067492] R13: ffff888004e18f69 R14: ffff888004e18f69 R15: ffff888004e=
19029=0D
[   14.067497] FS:  00007f5484d60cc0(0000) GS:ffff888036380000(0000) knlGS:=
0000000000000000=0D
[   14.067502] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.067505] CR2: ffffffffaa8547a6 CR3: 000000000484a000 CR4: 00000000000=
006e0=0D
[   14.067510] Call Trace:=0D
[   14.067513]  <TASK>=0D
[   14.067515] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumps=
tack.c:434 arch/x86/kernel/dumpstack.c:447)=20
[   14.067525] ? do_trap (arch/x86/kernel/traps.c:124 arch/x86/kernel/traps=
=2Ec:165)=20
[   14.067534] ? do_error_trap (arch/x86/kernel/traps.c:88 arch/x86/kernel/=
traps.c:186)=20
[   14.067543] ? exc_stack_segment (arch/x86/kernel/traps.c:373 (discrimina=
tor 2))=20
[   14.067550] ? asm_exc_stack_segment (./arch/x86/include/asm/idtentry.h:5=
63)=20
[   14.067557] ? filemap_release_folio (mm/filemap.c:4082 (discriminator 1)=
)=20
[   14.067565] shrink_folio_list (mm/vmscan.c:2068 (discriminator 1))=20
[   14.067574] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   14.067579] ? lruvec_is_sizable (mm/vmscan.c:4557 (discriminator 1))=20
[   14.067585] ? __pfx_blake2s.constprop.0 (./include/crypto/blake2s.h:89)=
=20
[   14.067594] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   14.067600] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169)=
=20
[   14.067606] ? chacha_block_generic (lib/crypto/chacha.c:77)=20
[   14.067616] evict_folios (mm/vmscan.c:5182)=20
[   14.067625] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   14.067630] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   14.067637] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   14.067643] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:425 (discrimin=
ator 2))=20
[   14.067652] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   14.067658] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   14.067671] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   14.067680] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   14.067687] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   14.067693] shrink_one (mm/vmscan.c:5403)=20
[   14.067700] RSP: 0000:0000000000000000 EFLAGS: 00000000=0D
[   14.067700] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   14.067707] ? __zone_watermark_ok (mm/page_alloc.c:2966)=20
[   14.067715] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   14.067721] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   14.067727] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   14.067737] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   14.067746] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   14.067753] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   14.067761] try_to_free_pages (mm/vmscan.c:7060)=20
[   14.067768] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   14.067777] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[   14.067789] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   14.067801] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   14.067811] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   14.067818] ? mas_destroy (lib/maple_tree.c:5606)=20
[   14.067826] ? mas_update_gap (lib/maple_tree.c:1720 lib/maple_tree.c:170=
2)=20
[   14.067833] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   14.067841] __alloc_pages (mm/page_alloc.c:4526)=20
[   14.067849] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   14.067856] ? hugepage_vma_check (./include/linux/huge_mm.h:109 (discrim=
inator 1) mm/huge_memory.c:113 (discriminator 1))=20
[   14.067866] ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discr=
iminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discriminat=
or 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) .=
/include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spin=
lock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discri=
minator 4) kernel/locking/spinlock.c:154 (discriminator 4))=20
[   14.067871] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)=20
[   14.067877] __folio_alloc (mm/page_alloc.c:4548)=20
[   14.067885] vma_alloc_folio (./include/linux/mempolicy.h:75 (discriminat=
or 1) ./include/linux/mempolicy.h:80 (discriminator 1) mm/mempolicy.c:2241 =
(discriminator 1))=20
[   14.067894] ? __pfx_vma_alloc_folio (mm/mempolicy.c:2162)=20
[   14.067899] ? set_pte (./arch/x86/include/asm/paravirt.h:436)=20
[   14.067908] ? __pfx_set_pte (./arch/x86/include/asm/paravirt.h:435)=20
[   14.067913] ? __pte_offset_map (./arch/x86/include/asm/pgtable.h:816 (di=
scriminator 2) ./include/linux/pgtable.h:92 (discriminator 2) ./include/lin=
ux/pgtable.h:107 (discriminator 2) mm/pgtable-generic.c:251 (discriminator =
2))=20
[   14.067927] do_anonymous_page (mm/memory.c:4110)=20
[   14.067938] __handle_mm_fault (mm/memory.c:3667 mm/memory.c:4945 mm/memo=
ry.c:5085)=20
[   14.067948] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   14.067956] ? find_vma (mm/mmap.c:1861)=20
[   14.067960] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 14.067966] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   14.067969] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   14.067972] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   14.067974] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   14.067976] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   14.067978] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   14.067980] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   14.067984] FS:  00007f5484d60cc0(0000) GS:ffff888036100000(0000) knlGS:=
0000000000000000=0D
[   14.067987] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.067989] CR2: 000000000000079d CR3: 000000000b054000 CR4: 00000000000=
006e0=0D
[   14.067993] note: stress-ng-bighe[301] exited with irqs disabled=0D
[   14.068028] Fixing recursive fault but reboot is needed!=0D
[   14.068198]  ORIG_RAX: 0000000000000000=0D
[   14.068566] ? __pfx_find_vma (mm/mmap.c:1861)=20
[   14.068913] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000=0D
[   14.069242] handle_mm_fault (mm/memory.c:5250)=20
[   14.069552] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000=0D
[   14.070217] do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   14.070224] exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x=
86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   14.070689] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000=0D
[   14.071035] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   14.071494] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000=0D
[   14.071920] RIP: 0033:0x55868cae5bb6=0D
[   14.072447] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000=0D
[ 14.073100] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   14.073105] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   14.073269]  </TASK>=0D
[   14.073491] =0D
[   14.073978] ---[ end trace 0000000000000000 ]---=0D
[   14.074266] RAX: 0000000000003000 RBX: 0000000003640000 RCX: 00000000000=
00001=0D
[   14.074270] RDX: 0000000000000000 RSI: 00007f5481347010 RDI: 00000000001=
82552=0D
[   14.160207] RBP: 00007f547dd14010 R08: 00000003821269c5 R09: 00000000000=
00000=0D
[   14.161024] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   14.161832] R13: 00007f547dd14010 R14: 00007f5481344010 R15: 00007fff9ae=
412d0=0D
[   14.162617]  </TASK>=0D
[   14.162919] Modules linked in:=0D
[   14.163313] BUG: kernel NULL pointer dereference, address: 0000000000000=
000=0D
[   14.163613] ---[ end trace 0000000000000000 ]---=0D
[   14.163754] #PF: supervisor read access in kernel mode=0D
[   14.164166] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[   14.164444] #PF: error_code(0x0000) - not-present page=0D
[ 14.164892] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   14.165181] PGD 0 P4D 0 =0D
[   14.165185] Oops: 0000 [#20] PREEMPT SMP KASAN NOPTI=0D
[   14.166804] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   14.166938] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   14.167392] =0D
[   14.167816] RIP: 0010:dump_page (./include/linux/page-flags.h:296 (discr=
iminator 2) mm/debug.c:136 (discriminator 2))=20
[   14.168288] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[ 14.168752] Code: 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 57=
 41 56 41 55 49 89 f5 41 54 55 53 48 89 fb 48 83 ec 30 e8 9e d3 0b 00 <48> =
8b 03 48 83 f8 ff 0f 84 b2 03 00 00 4c 8d 7b 08 4c 89 ff e8 85=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	f3 0f 1e fa          	endbr64
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	41 57                	push   %r15
  13:	41 56                	push   %r14
  15:	41 55                	push   %r13
  17:	49 89 f5             	mov    %rsi,%r13
  1a:	41 54                	push   %r12
  1c:	55                   	push   %rbp
  1d:	53                   	push   %rbx
  1e:	48 89 fb             	mov    %rdi,%rbx
  21:	48 83 ec 30          	sub    $0x30,%rsp
  25:	e8 9e d3 0b 00       	call   0xbd3c8
  2a:*	48 8b 03             	mov    (%rbx),%rax		<-- trapping instruction
  2d:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  31:	0f 84 b2 03 00 00    	je     0x3e9
  37:	4c 8d 7b 08          	lea    0x8(%rbx),%r15
  3b:	4c 89 ff             	mov    %r15,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 03             	mov    (%rbx),%rax
   3:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
   7:	0f 84 b2 03 00 00    	je     0x3bf
   d:	4c 8d 7b 08          	lea    0x8(%rbx),%r15
  11:	4c 89 ff             	mov    %r15,%rdi
  14:	e8                   	.byte 0xe8
  15:	85                   	.byte 0x85
[   14.168897] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   14.169135] RSP: 0000:ffff888006abeeb8 EFLAGS: 00010082=0D
[   14.169139] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000=0D
[   14.169141] RDX: ffff8880069d0000 RSI: 0000000000000008 RDI: ffff888006a=
bee80=0D
[   14.169142] RBP: 0000000000000000 R08: 0000000000000000 R09: fffff940000=
1f4c0=0D
[   14.169781] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   14.170791] R10: ffffea00000fa607 R11: ffffffffa9a01286 R12: ffff888006a=
bef78=0D
[   14.170794] R13: ffffffffa9db9f00 R14: 0000000060001001 R15: ffff888006b=
b0000=0D
[   14.170797] FS:  00007f5484d60cc0(0000) GS:ffff888036180000(0000) knlGS:=
0000000000000000=0D
[   14.170800] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.171444] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   14.171812] CR2: 0000000000000000 CR3: 0000000001d10000 CR4: 00000000000=
006e0=0D
[   14.172466] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   14.172980] Call Trace:=0D
[   14.173636] FS:  00007f5484d60cc0(0000) GS:ffff888036380000(0000) knlGS:=
0000000000000000=0D
[   14.174107]  <TASK>=0D
[   14.174109] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dum=
pstack.c:434)=20
[   14.174759] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.175320] ? page_fault_oops (arch/x86/mm/fault.c:707 (discriminator 1)=
)=20
[   14.175327] ? __pfx_is_prefetch.isra.0 (arch/x86/mm/fault.c:122)=20
[   14.176046] CR2: ffffffffaa8547a6 CR3: 000000000484a000 CR4: 00000000000=
006e0=0D
[   14.176442] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:635)=20
[   14.176447] ? dump_page (./include/linux/page-flags.h:296 (discriminator=
 2) mm/debug.c:136 (discriminator 2))=20
[   14.176450] ? search_bpf_extables (kernel/bpf/core.c:737)=20
[   14.177114] ------------[ cut here ]------------=0D
[   14.177618] ? fixup_exception (arch/x86/mm/extable.c:254)=20
[   14.178282] WARNING: CPU: 11 PID: 303 at kernel/exit.c:818 do_exit (kern=
el/exit.c:818 (discriminator 1))=20
[   14.178451] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   14.179194] Modules linked in:=0D
[   14.179342] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   14.179635] =0D
[   14.180024] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   14.180694] ? dump_page (./include/linux/page-flags.h:296 (discriminator=
 2) mm/debug.c:136 (discriminator 2))=20
[   14.181354] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   14.181689] ? dump_page (./include/linux/page-flags.h:296 (discriminator=
 2) mm/debug.c:136 (discriminator 2))=20
[   14.182009] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.182297] __delete_from_swap_cache (mm/swap_state.c:157 (discriminator=
 1))=20
[   14.182304] ? __pfx___delete_from_swap_cache (mm/swap_state.c:142)=20
[ 14.182727] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   14.182955] ? __pfx_folio_referenced (mm/rmap.c:904)=20
[   14.183633] RSP: 0018:ffff888006f87e60 EFLAGS: 00010286=0D
[   14.183908] ? __pfx_workingset_update_node (mm/workingset.c:602)=20
[   14.184205] =0D
[   14.184440] ? folio_memcg (./arch/x86/include/asm/bitops.h:207 ./arch/x8=
6/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-at=
omic.h:142 ./include/linux/page-flags.h:479 ./include/linux/memcontrol.h:38=
0 ./include/linux/memcontrol.h:433)=20
[   14.184590] RAX: 0000000000000000 RBX: ffff888002742880 RCX: ffffffffa81=
71c65=0D
[   14.184820] ? workingset_eviction (mm/workingset.c:202 mm/workingset.c:2=
55 mm/workingset.c:394)=20
[   14.185578] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880027=
43588=0D
[   14.185765] __remove_mapping (mm/vmscan.c:1431)=20
[   14.186577] RBP: ffff88800453da00 R08: 0000000000000001 R09: ffffed1000d=
f0fc1=0D
[   14.186767] shrink_folio_list (mm/vmscan.c:2102 (discriminator 1))=20
[   14.187150] R10: 0000000000000003 R11: 3030303030302052 R12: 00000000000=
0000b=0D
[   14.187411] ? __pfx_shrink_folio_list (mm/vmscan.c:1708)=20
[   14.187885] R13: ffff8880027434a0 R14: ffff888004533480 R15: 00000000000=
00007=0D
[   14.189000] ? lruvec_is_sizable (mm/vmscan.c:4557 (discriminator 1))=20
[   14.189005] ? __pfx_blake2s.constprop.0 (./include/crypto/blake2s.h:89)=
=20
[   14.189452] FS:  00007f5484d60cc0(0000) GS:ffff888036380000(0000) knlGS:=
0000000000000000=0D
[   14.189844] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:115 (d=
iscriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discrim=
inator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator =
4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/=
spinlock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:120 (di=
scriminator 4) kernel/locking/spinlock.c:170 (discriminator 4))=20
[   14.190329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.190416] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169)=
=20
[   14.190754] CR2: ffffffffaa8547a6 CR3: 000000000484a000 CR4: 00000000000=
006e0=0D
[   14.191285] ? chacha_block_generic (lib/crypto/chacha.c:77)=20
[   14.191292] evict_folios (mm/vmscan.c:5182)=20
[   14.191714] Call Trace:=0D
[   14.192163] ? __pfx_evict_folios (mm/vmscan.c:5152)=20
[   14.192167] ? __pfx_crng_fast_key_erasure (drivers/char/random.c:297)=20
[   14.192553]  <TASK>=0D
[   14.193085] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:16=
1)=20
[   14.193344] ? __warn (kernel/panic.c:673)=20
[   14.193836] ? crng_make_state (./include/linux/spinlock.h:405 drivers/ch=
ar/random.c:342)=20
[   14.194140] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.194813] ? mem_cgroup_get_nr_swap_pages (./arch/x86/include/asm/atomi=
c64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2560 ./include/li=
nux/atomic/atomic-long.h:38 ./include/linux/atomic/atomic-instrumented.h:31=
61 ./include/linux/swap.h:475 mm/memcontrol.c:7559)=20
[   14.195157] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   14.195463] try_to_shrink_lruvec (mm/vmscan.c:5358)=20
[   14.196107] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   14.196384] ? __pfx_try_to_shrink_lruvec (mm/vmscan.c:5340)=20
[   14.196838] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   14.197142] ? get_random_u8 (drivers/char/random.c:530 (discriminator 1)=
)=20
[   14.197147] shrink_one (mm/vmscan.c:5403)=20
[   14.197714] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   14.197998] shrink_node (mm/vmscan.c:5453 mm/vmscan.c:5570 mm/vmscan.c:6=
510)=20
[   14.198279] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.198472] ? __zone_watermark_ok (mm/page_alloc.c:2966)=20
[   14.198730] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.199030] ? __pfx_shrink_node (mm/vmscan.c:6504)=20
[   14.199182] ? handle_mm_fault (mm/memory.c:5250)=20
[   14.199594] ? bad_range (./include/linux/mm.h:1827 (discriminator 2) mm/=
page_alloc.c:490 (discriminator 2))=20
[   14.199791] ? __pfx_do_exit (kernel/exit.c:810)=20
[   14.200127] ? zone_reclaimable_pages (./include/linux/vmstat.h:231 (disc=
riminator 1) mm/vmscan.c:643 (discriminator 1))=20
[   14.200132] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2))=20
[   14.200352] ? do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   14.200760] do_try_to_free_pages (mm/vmscan.c:6757 mm/vmscan.c:6825)=20
[   14.200985] make_task_dead (kernel/exit.c:972)=20
[   14.201299] ? __pfx_do_try_to_free_pages (mm/vmscan.c:6809)=20
[   14.201304] ? get_page_from_freelist (./include/linux/mmzone.h:1592 mm/p=
age_alloc.c:3151)=20
[   14.201528] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch=
/x86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   14.201906] try_to_free_pages (mm/vmscan.c:7060)=20
[   14.202158] rewind_stack_and_make_dead (??:?)=20
[   14.202479] ? __pfx_try_to_free_pages (mm/vmscan.c:7027)=20
[   14.202694] RIP: 0033:0x55868cae5bb6=0D
[   14.203029] ? psi_task_change (kernel/sched/psi.c:920 (discriminator 1))=
=20
[ 14.203290] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   14.203569] __alloc_pages_slowpath.constprop.0 (./include/linux/sched/mm=
=2Eh:380 (discriminator 1) mm/page_alloc.c:3717 (discriminator 1) mm/page_a=
lloc.c:3736 (discriminator 1) mm/page_alloc.c:4141 (discriminator 1))=20
[   14.203838] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   14.204054] ? __pfx___alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:=
3986)=20
[   14.204323] =0D
[   14.204640] ? mas_store_prealloc (lib/maple_tree.c:5524)=20
[   14.204865] RAX: 0000000000003000 RBX: 0000000003640000 RCX: 00000000000=
00001=0D
[   14.205148] ? __pfx_mas_store_prealloc (lib/maple_tree.c:5524)=20
[   14.205154] ? __pfx_get_page_from_freelist (mm/page_alloc.c:3137)=20
[   14.205496] RDX: 0000000000000000 RSI: 00007f5481347010 RDI: 00000000001=
82552=0D
[   14.205855] ? hugepage_vma_check (./include/linux/huge_mm.h:109 (discrim=
inator 1) mm/huge_memory.c:113 (discriminator 1))=20
[   14.206191] RBP: 00007f547dd14010 R08: 00000003821269c5 R09: 00000000000=
00000=0D
[   14.206613] ? prepare_alloc_pages.constprop.0 (mm/page_alloc.c:4299 (dis=
criminator 1) mm/page_alloc.c:4262 (discriminator 1))=20
[   14.206829] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   14.207292] __alloc_pages (mm/page_alloc.c:4526)=20
[   14.207298] ? __pfx___alloc_pages (mm/page_alloc.c:4479)=20
[   14.207578] R13: 00007f547dd14010 R14: 00007f5481344010 R15: 00007fff9ae=
412d0=0D
[   14.207939] ? vma_merge (mm/mmap.c:1025)=20
[   14.208202]  </TASK>=0D
[   14.208645] ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discr=
iminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2155 (discriminat=
or 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) .=
/include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spin=
lock.h:186 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discri=
minator 4) kernel/locking/spinlock.c:154 (discriminator 4))=20
[   14.209002] ---[ end trace 0000000000000000 ]---=0D
[   14.209350] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)=20
[   14.209356] __folio_alloc (mm/page_alloc.c:4548)=20
[   14.244333] vma_alloc_folio (./include/linux/mempolicy.h:75 (discriminat=
or 1) ./include/linux/mempolicy.h:80 (discriminator 1) mm/mempolicy.c:2241 =
(discriminator 1))=20
[   14.244676] ? __pfx_vma_alloc_folio (mm/mempolicy.c:2162)=20
[   14.245047] ? set_pte (./arch/x86/include/asm/paravirt.h:436)=20
[   14.245376] ? __pfx_set_pte (./arch/x86/include/asm/paravirt.h:435)=20
[   14.245711] ? __pte_offset_map (./arch/x86/include/asm/pgtable.h:816 (di=
scriminator 2) ./include/linux/pgtable.h:92 (discriminator 2) ./include/lin=
ux/pgtable.h:107 (discriminator 2) mm/pgtable-generic.c:251 (discriminator =
2))=20
[   14.246068] do_anonymous_page (mm/memory.c:4110)=20
[   14.246448] __handle_mm_fault (mm/memory.c:3667 mm/memory.c:4945 mm/memo=
ry.c:5085)=20
[   14.246821] ? __pfx___handle_mm_fault (mm/memory.c:4996)=20
[   14.247247] ? find_vma (mm/mmap.c:1861)=20
[   14.247582] ? __pfx_find_vma (mm/mmap.c:1861)=20
[   14.247929] handle_mm_fault (mm/memory.c:5250)=20
[   14.248321] do_user_addr_fault (arch/x86/mm/fault.c:1393)=20
[   14.248737] exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x=
86/mm/fault.c:1495 arch/x86/mm/fault.c:1543)=20
[   14.249123] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)=
=20
[   14.249549] RIP: 0033:0x55868cae5bb6=0D
[ 14.249914] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   14.251629] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   14.252131] RAX: 0000000000008000 RBX: 000000000b670000 RCX: 00000000000=
00001=0D
[   14.252856] RDX: 0000000000000000 RSI: 00007f548337b010 RDI: 00000000000=
fc0b6=0D
[   14.253545] RBP: 00007f5477d13010 R08: 00000003cbfe16ee R09: 00000000000=
00000=0D
[   14.254156] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   14.254994] R13: 00007f5477d13010 R14: 00007f5483373010 R15: 00007fff9ae=
412d0=0D
[   14.255852]  </TASK>=0D
[   14.256149] Modules linked in:=0D
[   14.256515] CR2: 0000000000000000=0D
[   14.256845] ---[ end trace 0000000000000000 ]---=0D
[   14.257338] RIP: 0010:filemap_release_folio (mm/filemap.c:4082 (discrimi=
nator 1))=20
[ 14.257878] Code: 48 8b 45 00 f6 c4 80 75 40 4d 85 ed 74 4e 49 8d bd b8 00=
 00 00 e8 61 b6 13 00 49 8b ad b8 00 00 00 48 8d 7d 48 e8 51 b6 13 00 <48> =
8b 45 48 48 85 c0 74 29 44 89 e6 48 89 df 5b 5d 41 5c 41 5d 41=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 00          	mov    0x0(%rbp),%rax
   4:	f6 c4 80             	test   $0x80,%ah
   7:	75 40                	jne    0x49
   9:	4d 85 ed             	test   %r13,%r13
   c:	74 4e                	je     0x5c
   e:	49 8d bd b8 00 00 00 	lea    0xb8(%r13),%rdi
  15:	e8 61 b6 13 00       	call   0x13b67b
  1a:	49 8b ad b8 00 00 00 	mov    0xb8(%r13),%rbp
  21:	48 8d 7d 48          	lea    0x48(%rbp),%rdi
  25:	e8 51 b6 13 00       	call   0x13b67b
  2a:*	48 8b 45 48          	mov    0x48(%rbp),%rax		<-- trapping instructi=
on
  2e:	48 85 c0             	test   %rax,%rax
  31:	74 29                	je     0x5c
  33:	44 89 e6             	mov    %r12d,%esi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	5b                   	pop    %rbx
  3a:	5d                   	pop    %rbp
  3b:	41 5c                	pop    %r12
  3d:	41 5d                	pop    %r13
  3f:	41                   	rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8b 45 48          	mov    0x48(%rbp),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 29                	je     0x32
   9:	44 89 e6             	mov    %r12d,%esi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	5b                   	pop    %rbx
  10:	5d                   	pop    %rbp
  11:	41 5c                	pop    %r12
  13:	41 5d                	pop    %r13
  15:	41                   	rex.B
[   14.259440] RSP: 0018:ffff88800e687040 EFLAGS: 00010282=0D
[   14.259887] RAX: 0000000000000000 RBX: ffffea00002beb80 RCX: 00000000000=
00000=0D
[   14.260486] RDX: ffff888004820000 RSI: 0000000000000008 RDI: ffff88800e6=
87008=0D
[   14.261056] RBP: a1bc9b7db8000000 R08: 1ffff11000da5cf4 R09: fffff940000=
57d70=0D
[   14.261675] R10: ffffea00002beb87 R11: 000000000000001d R12: 00000000001=
40dca=0D
[   14.262297] R13: ffff888006d2e6e9 R14: ffff888006d2e6e9 R15: ffff888006d=
2e7a9=0D
[   14.262903] FS:  00007f5484d60cc0(0000) GS:ffff888036180000(0000) knlGS:=
0000000000000000=0D
[   14.263658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.264182] CR2: 0000000000000000 CR3: 0000000001d10000 CR4: 00000000000=
006e0=0D
[   14.264797] note: stress-ng-bighe[318] exited with irqs disabled=0D
[   14.265354] note: stress-ng-bighe[318] exited with preempt_count 1=0D
[   14.265883] ------------[ cut here ]------------=0D
[   14.266336] WARNING: CPU: 7 PID: 318 at kernel/exit.c:818 do_exit (kerne=
l/exit.c:818 (discriminator 1))=20
[   14.266964] Modules linked in:=0D
[   14.267993] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014=0D
[   14.268746] RIP: 0010:do_exit (kernel/exit.c:818 (discriminator 1))=20
[ 14.269133] Code: bb d8 09 00 00 31 f6 e8 0d bf ff ff e9 2f fc ff ff 0f 0b=
 e9 67 f2 ff ff 4c 89 e6 bf 05 06 00 00 e8 14 9e 01 00 e9 f8 f3 ff ff <0f> =
0b e9 cb f2 ff ff 48 89 df e8 20 86 1b 00 e9 9c f5 ff ff 48 89=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	bb d8 09 00 00       	mov    $0x9d8,%ebx
   5:	31 f6                	xor    %esi,%esi
   7:	e8 0d bf ff ff       	call   0xffffffffffffbf19
   c:	e9 2f fc ff ff       	jmp    0xfffffffffffffc40
  11:	0f 0b                	ud2
  13:	e9 67 f2 ff ff       	jmp    0xfffffffffffff27f
  18:	4c 89 e6             	mov    %r12,%rsi
  1b:	bf 05 06 00 00       	mov    $0x605,%edi
  20:	e8 14 9e 01 00       	call   0x19e39
  25:	e9 f8 f3 ff ff       	jmp    0xfffffffffffff422
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2fc
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 20 86 1b 00       	call   0x1b8659
  39:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5da
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 cb f2 ff ff       	jmp    0xfffffffffffff2d2
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 20 86 1b 00       	call   0x1b862f
   f:	e9 9c f5 ff ff       	jmp    0xfffffffffffff5b0
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   14.270612] RSP: 0000:ffff888006abfe60 EFLAGS: 00010286=0D
[   14.271051] RAX: 0000000000000000 RBX: ffff8880069d0000 RCX: ffffffffa81=
71c65=0D
[   14.271700] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880069=
d0d08=0D
[   14.272351] RBP: ffff888005ca5500 R08: 0000000000000001 R09: ffffed1000d=
57fc1=0D
[   14.272981] R10: 0000000000000003 R11: 0000000000000001 R12: 00000000000=
00009=0D
[   14.273698] R13: ffff8880069d0c20 R14: ffff888005cb8000 R15: 00000000000=
00000=0D
[   14.274387] FS:  00007f5484d60cc0(0000) GS:ffff888036180000(0000) knlGS:=
0000000000000000=0D
[   14.275164] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   14.275743] CR2: 0000000000000000 CR3: 0000000001d10000 CR4: 00000000000=
006e0=0D
[   14.276373] Call Trace:=0D
[   14.276629]  <TASK>=0D
[   14.276865] ? __warn (kernel/panic.c:673)=20
[   14.277232] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.277585] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[   14.277941] ? handle_bug (arch/x86/kernel/traps.c:324 (discriminator 1))=
=20
[   14.278330] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))=20
[   14.278698] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)=
=20
[   14.279079] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.279481] ? do_exit (kernel/exit.c:818 (discriminator 1))=20
[   14.279821] ? __pfx__printk (kernel/printk/printk.c:2323)=20
[   14.280244] ? __pfx_do_exit (kernel/exit.c:810)=20
[   14.280613] ? _prb_read_valid (kernel/printk/printk_ringbuffer.c:1894)=
=20
[   14.281016] make_task_dead (kernel/exit.c:972)=20
[   14.281423] rewind_stack_and_make_dead (??:?)=20
[   14.281908] RIP: 0033:0x55868cae5bb6=0D
[ 14.282328] Code: 8b 57 10 31 c0 48 85 d2 74 27 49 8b 0f 48 3b 11 77 1f e9=
 d1 00 00 00 8a 0d 6f 35 4f 00 84 c9 0f 84 c3 00 00 00 48 85 d2 75 17 <41> =
88 04 06 4c 01 e0 49 8d 34 06 48 89 74 24 08 4c 39 d0 72 d8 eb=0D
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	8b 57 10             	mov    0x10(%rdi),%edx
   3:	31 c0                	xor    %eax,%eax
   5:	48 85 d2             	test   %rdx,%rdx
   8:	74 27                	je     0x31
   a:	49 8b 0f             	mov    (%r15),%rcx
   d:	48 3b 11             	cmp    (%rcx),%rdx
  10:	77 1f                	ja     0x31
  12:	e9 d1 00 00 00       	jmp    0xe8
  17:	8a 0d 6f 35 4f 00    	mov    0x4f356f(%rip),%cl        # 0x4f358c
  1d:	84 c9                	test   %cl,%cl
  1f:	0f 84 c3 00 00 00    	je     0xe8
  25:	48 85 d2             	test   %rdx,%rdx
  28:	75 17                	jne    0x41
  2a:*	41 88 04 06          	mov    %al,(%r14,%rax,1)		<-- trapping instruc=
tion
  2e:	4c 01 e0             	add    %r12,%rax
  31:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
  35:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  3a:	4c 39 d0             	cmp    %r10,%rax
  3d:	72 d8                	jb     0x17
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	41 88 04 06          	mov    %al,(%r14,%rax,1)
   4:	4c 01 e0             	add    %r12,%rax
   7:	49 8d 34 06          	lea    (%r14,%rax,1),%rsi
   b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  10:	4c 39 d0             	cmp    %r10,%rax
  13:	72 d8                	jb     0xffffffffffffffed
  15:	eb                   	.byte 0xeb
[   14.284026] RSP: 002b:00007fff9ae41160 EFLAGS: 00010246=0D
[   14.284517] RAX: 0000000000008000 RBX: 000000000b670000 RCX: 00000000000=
00001=0D
[   14.285083] RDX: 0000000000000000 RSI: 00007f548337b010 RDI: 00000000000=
fc0b6=0D
[   14.285699] RBP: 00007f5477d13010 R08: 00000003cbfe16ee R09: 00000000000=
00000=0D
[   14.286427] R10: 0000000000010000 R11: 00007fff9aeea080 R12: 00000000000=
01000=0D
[   14.287055] R13: 00007f5477d13010 R14: 00007f5483373010 R15: 00007fff9ae=
412d0=0D
[   14.287758]  </TASK>=0D
[   14.287998] ---[ end trace 0000000000000000 ]---=0D
QEMU 7.2.1 monitor - type 'help' for more information=0D
(qemu) q=1B[K=0D

--AHQ8Dlxzo78Yy+15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bisect.log"

git bisect start
# status: waiting for both good and bad commits
# bad: [347e208de0e407689f4e4c596e9e38deafebe4f2] rmap: pass the folio to __page_check_anon_rmap()
git bisect bad 347e208de0e407689f4e4c596e9e38deafebe4f2
# status: waiting for good commit(s), bad commit known
# good: [6a0cd1a3b0aac0ad6d4323655637f815b246388c] lib: dhry: fix sleeping allocations inside non-preemptable section
git bisect good 6a0cd1a3b0aac0ad6d4323655637f815b246388c
# bad: [d005e8086e0142ce407732d255a1f34d6bcf65dc] fs/buffer: clean up block_commit_write
git bisect bad d005e8086e0142ce407732d255a1f34d6bcf65dc
# good: [415eb0b660ee9ede18450b55ab9317a94adfa411] mm: handle userfaults under VMA lock
git bisect good 415eb0b660ee9ede18450b55ab9317a94adfa411
# good: [d18136724b3d4793fac5e5790d8a36a610a0bb09] selftests/mm: add -a to run_vmtests.sh
git bisect good d18136724b3d4793fac5e5790d8a36a610a0bb09
# bad: [bec1b30fc8079fe249826a7e7ad02d3bd0a01623] maple_tree: add test for mas_wr_modify() fast path
git bisect bad bec1b30fc8079fe249826a7e7ad02d3bd0a01623
# good: [37901b7d8ba94d7c1d8f31adf5f25d81e7124521] fs/address_space: add alignment padding for i_map and i_mmap_rwsem to mitigate a false sharing.
git bisect good 37901b7d8ba94d7c1d8f31adf5f25d81e7124521
# bad: [4fdae84e72d64076a76d1c79071645ea3a66b09b] mm, netfs, fscache: stop read optimisation when folio removed from pagecache
git bisect bad 4fdae84e72d64076a76d1c79071645ea3a66b09b
# good: [4a43b79d2e551a85e601b8be240285f2b8bea714] mm: merge folio_has_private()/filemap_release_folio() call pairs
git bisect good 4a43b79d2e551a85e601b8be240285f2b8bea714
# first bad commit: [4fdae84e72d64076a76d1c79071645ea3a66b09b] mm, netfs, fscache: stop read optimisation when folio removed from pagecache

--AHQ8Dlxzo78Yy+15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 6.4.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (GCC) 13.1.1 20230614 (Red Hat 13.1.1-4)"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=130101
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_UAPI_HEADER_TEST=y
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_KERNEL_ZSTD=y
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_TIME_KUNIT_TEST=m
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
CONFIG_USERMODE_DRIVER=y
CONFIG_BPF_PRELOAD=y
CONFIG_BPF_PRELOAD_UMD=m
CONFIG_BPF_LSM=y
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=18
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_FORCE is not set
# CONFIG_BOOT_CONFIG_EMBED is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_CACHESTAT_SYSCALL=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
CONFIG_X86_NUMACHIP=y
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_512GB=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_PV_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
CONFIG_XEN_DEBUG_FS=y
CONFIG_XEN_PVH=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PV_MSR_SAFE=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_ACRN_GUEST=y
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
CONFIG_PERF_EVENTS_AMD_UNCORE=y
CONFIG_PERF_EVENTS_AMD_BRS=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
CONFIG_SLS=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=m
CONFIG_DPTF_PCH_FIVR=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_ACPI_PFRUT=m
CONFIG_ACPI_PCC=y
CONFIG_ACPI_FFH=y
CONFIG_PMIC_OPREGION=y
CONFIG_BYTCRC_PMIC_OPREGION=y
CONFIG_CHTCRC_PMIC_OPREGION=y
CONFIG_XPOWER_PMIC_OPREGION=y
CONFIG_BXT_WC_PMIC_OPREGION=y
CONFIG_CHT_WC_PMIC_OPREGION=y
CONFIG_CHT_DC_TI_PMIC_OPREGION=y
# CONFIG_TPS68470_PMIC_OPREGION is not set
CONFIG_ACPI_VIOT=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_AMD_PSTATE=y
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
CONFIG_X86_AMD_PSTATE_UT=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_X86_SGX_KVM=y
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_SMM=y
CONFIG_KVM_XEN=y
CONFIG_KVM_EXTERNAL_WRITE_TRACKING=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_IMA_KEXEC=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HOTPLUG_CORE_SYNC=y
CONFIG_HOTPLUG_CORE_SYNC_DEAD=y
CONFIG_HOTPLUG_CORE_SYNC_FULL=y
CONFIG_HOTPLUG_SPLIT_STARTUP=y
CONFIG_HOTPLUG_PARALLEL=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_DEBUGFS=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODULE_UNLOAD_TAINT_TRACKING=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=y
CONFIG_MODULE_SIG_HASH="sha512"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/usr/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_FC_APPID=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_CGROUP_IOPRIO=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB_DEPRECATED is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_MEMFD_CREATE=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
# CONFIG_LRU_GEN_STATS is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_LOCK_MM_AND_FIND_VMA=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_DBGFS=y
CONFIG_DAMON_RECLAIM=y
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
CONFIG_XFRM_INTERFACE=m
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XFRM_ESPINTCP=y
CONFIG_SMC=m
CONFIG_SMC_DIAG=m
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=m
CONFIG_NET_HANDSHAKE=y
CONFIG_NET_HANDSHAKE_KUNIT_TEST=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
CONFIG_INET_ESPINTCP=y
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
CONFIG_INET6_ESPINTCP=y
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=y
CONFIG_MPTCP_IPV6=y
CONFIG_MPTCP_KUNIT_TEST=m
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
CONFIG_NFT_REJECT_NETDEV=m
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NF_FLOW_TABLE_PROCFS=y
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_MH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
CONFIG_IP_VS_TWOS=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_SRH=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
CONFIG_RDS=m
CONFIG_RDS_RDMA=m
CONFIG_RDS_TCP=m
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_NONE=m
# CONFIG_NET_DSA_TAG_AR9331 is not set
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_LEGACY=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
CONFIG_NET_DSA_TAG_HELLCREEK=m
CONFIG_NET_DSA_TAG_GSWIP=m
CONFIG_NET_DSA_TAG_DSA_COMMON=m
CONFIG_NET_DSA_TAG_DSA=m
CONFIG_NET_DSA_TAG_EDSA=m
CONFIG_NET_DSA_TAG_MTK=m
CONFIG_NET_DSA_TAG_KSZ=m
CONFIG_NET_DSA_TAG_OCELOT=m
CONFIG_NET_DSA_TAG_OCELOT_8021Q=m
CONFIG_NET_DSA_TAG_QCA=m
CONFIG_NET_DSA_TAG_RTL4_A=m
CONFIG_NET_DSA_TAG_RTL8_4=m
# CONFIG_NET_DSA_TAG_RZN1_A5PSW is not set
CONFIG_NET_DSA_TAG_LAN9303=m
CONFIG_NET_DSA_TAG_SJA1105=m
CONFIG_NET_DSA_TAG_TRAILER=m
CONFIG_NET_DSA_TAG_XRS700X=m
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
CONFIG_6LOWPAN_DEBUGFS=y
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
CONFIG_6LOWPAN_GHC_UDP=m
CONFIG_6LOWPAN_GHC_ICMPV6=m
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=m
CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=m
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=m
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_MQPRIO_LIB=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_ACT_GATE=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=m
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_TRACING=y
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_QRTR=m
# CONFIG_QRTR_TUN is not set
CONFIG_QRTR_MHI=m
CONFIG_NET_NCSI=y
CONFIG_NCSI_OEM_CMD_GET_MAC=y
CONFIG_NCSI_OEM_CMD_KEEP_PHY=y
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_YAM=m
# end of AX.25 network device drivers

CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
CONFIG_CAN_J1939=m
CONFIG_CAN_ISOTP=m
CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
CONFIG_BT_LE_L2CAP_ECRED=y
CONFIG_BT_6LOWPAN=m
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
# CONFIG_BT_AOSPEXT is not set
# CONFIG_BT_DEBUGFS is not set
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_QCA=m
CONFIG_BT_MTK=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_POLL_SYNC=y
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_MTK=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIUART_INTEL=y
CONFIG_BT_HCIUART_BCM=y
CONFIG_BT_HCIUART_RTL=y
CONFIG_BT_HCIUART_QCA=y
CONFIG_BT_HCIUART_AG6XX=y
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBCM4377=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
CONFIG_BT_MTKSDIO=m
CONFIG_BT_MTKUART=m
CONFIG_BT_HCIRSI=m
CONFIG_BT_VIRTIO=m
CONFIG_BT_NXPUART=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=m
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_INJECT_RX_DELAY is not set
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=y
# CONFIG_RXPERF is not set
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
CONFIG_MCTP=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=m
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_XEN=m
CONFIG_NET_9P_RDMA=m
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_SPI=m
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=m
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_SIM=m
CONFIG_NFC_PORT100=m
# CONFIG_NFC_VIRTUAL_NCI is not set
# CONFIG_NFC_FDP is not set
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
CONFIG_NFC_PN544_MEI=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
CONFIG_NFC_PN532_UART=m
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_I2C=m
CONFIG_NFC_MICROREAD_MEI=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
# CONFIG_NFC_MRVL_I2C is not set
# CONFIG_NFC_MRVL_SPI is not set
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
CONFIG_NFC_NXP_NCI=m
CONFIG_NFC_NXP_NCI_I2C=m
# CONFIG_NFC_S3FWRN5_I2C is not set
# CONFIG_NFC_S3FWRN82_UART is not set
# CONFIG_NFC_ST95HF is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
CONFIG_NETDEV_ADDR_LIST_TEST=m

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_EDR=y
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_XEN_PCIDEV_FRONTEND=m
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_P2PDMA=y
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=m
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=m
CONFIG_CXL_PMEM=m
CONFIG_CXL_MEM=m
CONFIG_CXL_PORT=m
CONFIG_CXL_SUSPEND=y
CONFIG_CXL_REGION=y
# CONFIG_CXL_REGION_INVALIDATION_TEST is not set
CONFIG_CXL_PMU=m
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_KUNIT=m
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_RAM=m
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_REGMAP_SOUNDWIRE_MBQ=m
CONFIG_REGMAP_SCCB=m
CONFIG_REGMAP_SPI_AVMM=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=m
# CONFIG_MHI_BUS_DEBUG is not set
CONFIG_MHI_BUS_PCI_GENERIC=m
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_FW_CS_DSP=m
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
CONFIG_EFI_TEST=m
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
CONFIG_EFI_COCO_SECRET=y
CONFIG_UNACCEPTED_MEMORY=y
CONFIG_EFI_EMBEDDED_FIRMWARE=y
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_GNSS_USB=m
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_MCHP48L640=m
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_MXIC is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_NAND_ARASAN is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
CONFIG_MTD_NAND_ECC_MXIC=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_FD_RAWCMD is not set
CONFIG_CDROM=y
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
# CONFIG_ZRAM_WRITEBACK is not set
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_ZRAM_MULTI_COMP=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_XEN_BLKDEV_BACKEND=m
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_RBD=m
CONFIG_BLK_DEV_UBLK=m
CONFIG_BLKDEV_UBLK_LEGACY_OPCODES=y
CONFIG_BLK_DEV_RNBD=y
CONFIG_BLK_DEV_RNBD_CLIENT=m
CONFIG_BLK_DEV_RNBD_SERVER=m

#
# NVME Support
#
CONFIG_NVME_COMMON=m
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=m
CONFIG_NVME_AUTH=y
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=m
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=m
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=m
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
CONFIG_INTEL_MEI_GSC=m
CONFIG_INTEL_MEI_HDCP=m
CONFIG_INTEL_MEI_PXP=m
# CONFIG_INTEL_MEI_GSC_PROXY is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
CONFIG_ECHO=m
CONFIG_BCM_VK=m
CONFIG_BCM_VK_TTY=y
CONFIG_MISC_ALCOR_PCI=m
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=m
CONFIG_UACCE=m
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
# CONFIG_PVPANIC_PCI is not set
CONFIG_GP_PCI1XXXX=m
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=4
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
CONFIG_SCSI_MPI3MR=m
CONFIG_SCSI_SMARTPQI=m
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_FLASHPOINT=y
CONFIG_SCSI_MYRB=m
CONFIG_SCSI_MYRS=m
CONFIG_VMWARE_PVSCSI=m
CONFIG_XEN_SCSI_FRONTEND=m
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
CONFIG_SCSI_SNIC=m
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_FDOMAIN=m
CONFIG_SCSI_FDOMAIN_PCI=m
CONFIG_SCSI_ISCI=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
CONFIG_QEDI=m
CONFIG_QEDF=m
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
CONFIG_SCSI_EFCT=m
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
CONFIG_SCSI_BFA_FC=m
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_CHELSIO_FCOE=m
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=3
CONFIG_SATA_AHCI_PLATFORM=m
CONFIG_AHCI_DWC=m
CONFIG_SATA_INIC162X=m
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
CONFIG_PATA_EFAR=m
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
CONFIG_PATA_NS87415=m
CONFIG_PATA_OLDPIIX=m
CONFIG_PATA_OPTIDMA=m
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
CONFIG_PATA_TRIFLEX=m
CONFIG_PATA_VIA=m
CONFIG_PATA_WINBOND=m

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=m
CONFIG_PATA_MPIIX=m
CONFIG_PATA_NS87410=m
CONFIG_PATA_OPTI=m
CONFIG_PATA_PCMCIA=m
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
CONFIG_DM_EBS=m
CONFIG_DM_ERA=m
CONFIG_DM_CLONE=m
CONFIG_DM_MIRROR=y
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_MULTIPATH_HST=m
CONFIG_DM_MULTIPATH_IOA=m
CONFIG_DM_DELAY=m
CONFIG_DM_DUST=m
CONFIG_DM_INIT=y
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING=y
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
CONFIG_SBP_TARGET=m
CONFIG_REMOTE_TARGET=m
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_FC=m
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
CONFIG_WIREGUARD=m
# CONFIG_WIREGUARD_DEBUG is not set
CONFIG_EQUALIZER=m
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
CONFIG_VXLAN=m
CONFIG_GENEVE=m
CONFIG_BAREUDP=m
CONFIG_GTP=m
CONFIG_AMT=m
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=m
CONFIG_VSOCKMON=m
CONFIG_MHI_NET=m
CONFIG_SUNGEM_PHY=m
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
CONFIG_ATM_TCP=m
# CONFIG_ATM_LANAI is not set
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_NICSTAR=m
# CONFIG_ATM_NICSTAR_USE_SUNI is not set
# CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
CONFIG_ATM_HE=m
# CONFIG_ATM_HE_USE_SUNI is not set
CONFIG_ATM_SOLOS=m

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
CONFIG_B53_SPI_DRIVER=m
CONFIG_B53_MDIO_DRIVER=m
CONFIG_B53_MMAP_DRIVER=m
CONFIG_B53_SRAB_DRIVER=m
CONFIG_B53_SERDES=m
CONFIG_NET_DSA_BCM_SF2=m
CONFIG_NET_DSA_LOOP=m
CONFIG_NET_DSA_HIRSCHMANN_HELLCREEK=m
# CONFIG_NET_DSA_LANTIQ_GSWIP is not set
CONFIG_NET_DSA_MT7530=m
CONFIG_NET_DSA_MT7530_MDIO=m
CONFIG_NET_DSA_MT7530_MMIO=m
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON is not set
CONFIG_NET_DSA_MV88E6XXX=m
CONFIG_NET_DSA_MV88E6XXX_PTP=y
# CONFIG_NET_DSA_AR9331 is not set
CONFIG_NET_DSA_QCA8K=m
CONFIG_NET_DSA_QCA8K_LEDS_SUPPORT=y
# CONFIG_NET_DSA_SJA1105 is not set
CONFIG_NET_DSA_XRS700X=m
CONFIG_NET_DSA_XRS700X_I2C=m
CONFIG_NET_DSA_XRS700X_MDIO=m
CONFIG_NET_DSA_REALTEK=m
# CONFIG_NET_DSA_REALTEK_MDIO is not set
# CONFIG_NET_DSA_REALTEK_SMI is not set
CONFIG_NET_DSA_REALTEK_RTL8365MB=m
CONFIG_NET_DSA_REALTEK_RTL8366RB=m
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
# CONFIG_NET_DSA_VITESSE_VSC73XX_SPI is not set
# CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_3C589=m
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=m
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=m
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_AMD_XGBE=m
CONFIG_AMD_XGBE_DCB=y
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_PDS_CORE=m
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_SPI_AX88796C=m
CONFIG_SPI_AX88796C_COMPRESSION=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
CONFIG_BCMGENET=m
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
CONFIG_MACB_PCI=m
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=m
CONFIG_CHELSIO_T1_1G=y
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
CONFIG_CHELSIO_T4_DCB=y
# CONFIG_CHELSIO_T4_FCOE is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_CHELSIO_IPSEC_INLINE=m
CONFIG_CHELSIO_TLS_DEVICE=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_NET_VENDOR_DAVICOM=y
CONFIG_DM9051=m
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
# CONFIG_BE2NET_HWMON is not set
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_ENGLEDER=y
CONFIG_TSNEP=m
# CONFIG_TSNEP_SELFTESTS is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_FUJITSU is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_FUN_CORE=m
CONFIG_FUN_ETH=m
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_GVE=m
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=m
CONFIG_E1000=m
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
CONFIG_IGB_DCA=y
CONFIG_IGBVF=m
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCA=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBE_IPSEC=y
CONFIG_IXGBEVF=m
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
CONFIG_IAVF=m
CONFIG_I40EVF=m
CONFIG_ICE=m
CONFIG_ICE_SWITCHDEV=y
CONFIG_ICE_HWTS=y
CONFIG_FM10K=m
CONFIG_IGC=m
CONFIG_JME=m
CONFIG_NET_VENDOR_ADI=y
CONFIG_ADIN1110=m
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_OCTEON_EP=m
CONFIG_PRESTERA=m
CONFIG_PRESTERA_PCI=m
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
# CONFIG_MLX5_FPGA is not set
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_EN_ARFS=y
CONFIG_MLX5_EN_RXNFC=y
CONFIG_MLX5_MPFS=y
CONFIG_MLX5_ESWITCH=y
CONFIG_MLX5_BRIDGE=y
CONFIG_MLX5_CLS_ACT=y
CONFIG_MLX5_TC_CT=y
CONFIG_MLX5_TC_SAMPLE=y
CONFIG_MLX5_CORE_EN_DCB=y
CONFIG_MLX5_CORE_IPOIB=y
CONFIG_MLX5_EN_MACSEC=y
CONFIG_MLX5_EN_IPSEC=y
CONFIG_MLX5_EN_TLS=y
CONFIG_MLX5_SW_STEERING=y
CONFIG_MLX5_SF=y
CONFIG_MLX5_SF_MANAGER=y
CONFIG_MLXSW_CORE=m
CONFIG_MLXSW_CORE_HWMON=y
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=m
CONFIG_MLXSW_I2C=m
CONFIG_MLXSW_SPECTRUM=m
CONFIG_MLXSW_SPECTRUM_DCB=y
CONFIG_MLXSW_MINIMAL=m
CONFIG_MLXFW=m
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
CONFIG_KSZ884X_PCI=m
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_MICROSOFT_MANA=m
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
CONFIG_FEALNX=m
# CONFIG_NET_VENDOR_NI is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
CONFIG_NS83820=m
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=m
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
# CONFIG_NFP_APP_ABM_NIC is not set
CONFIG_NFP_NET_IPSEC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_8390=y
CONFIG_PCMCIA_AXNET=m
CONFIG_NE2K_PCI=m
CONFIG_PCMCIA_PCNET=m
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=m
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_IONIC=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_LL2=y
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_QED_RDMA=y
CONFIG_QED_ISCSI=y
CONFIG_QED_FCOE=y
CONFIG_QED_OOO=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=m
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=m
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=m
CONFIG_NET_VENDOR_SIS=y
CONFIG_SIS900=m
CONFIG_SIS190=m
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
# CONFIG_SFC_MCDI_LOGGING is not set
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
CONFIG_SFC_SIENA=m
CONFIG_SFC_SIENA_MTD=y
CONFIG_SFC_SIENA_MCDI_MON=y
CONFIG_SFC_SIENA_SRIOV=y
CONFIG_SFC_SIENA_MCDI_LOGGING=y
CONFIG_NET_VENDOR_SMSC=y
CONFIG_PCMCIA_SMC91C92=m
CONFIG_EPIC100=m
CONFIG_SMSC911X=m
CONFIG_SMSC9420=m
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=m
# CONFIG_STMMAC_SELFTESTS is not set
# CONFIG_STMMAC_PLATFORM is not set
CONFIG_DWMAC_INTEL=m
# CONFIG_DWMAC_LOONGSON is not set
# CONFIG_STMMAC_PCI is not set
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_CASSINI=m
CONFIG_NIU=m
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=m
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_MSE102X=m
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VIA_VELOCITY=m
CONFIG_NET_VENDOR_WANGXUN=y
CONFIG_LIBWX=m
CONFIG_NGBE=m
CONFIG_TXGBE=m
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=m
CONFIG_WIZNET_W5300=m
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=y
CONFIG_WIZNET_W5100_SPI=m
CONFIG_NET_VENDOR_XILINX=y
CONFIG_XILINX_EMACLITE=m
# CONFIG_XILINX_AXI_EMAC is not set
CONFIG_XILINX_LL_TEMAC=m
CONFIG_NET_VENDOR_XIRCOM=y
CONFIG_PCMCIA_XIRC2PS=m
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_SFP=m

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
CONFIG_ADIN_PHY=m
# CONFIG_ADIN1100_PHY is not set
CONFIG_AQUANTIA_PHY=m
CONFIG_AX88796B_PHY=m
CONFIG_BROADCOM_PHY=m
CONFIG_BCM54140_PHY=m
CONFIG_BCM7XXX_PHY=m
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BCM_NET_PHYPTP=m
CONFIG_CICADA_PHY=m
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=m
CONFIG_MARVELL_88X2222_PHY=m
CONFIG_MAXLINEAR_GPHY=m
CONFIG_MEDIATEK_GE_PHY=m
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_T1S_PHY=m
CONFIG_MICROCHIP_PHY=m
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=m
CONFIG_MOTORCOMM_PHY=m
CONFIG_NATIONAL_PHY=m
CONFIG_NXP_CBTX_PHY=m
CONFIG_NXP_C45_TJA11XX_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_NCN26000_PHY=m
CONFIG_AT803X_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=m
CONFIG_DP83822_PHY=m
# CONFIG_DP83TC811_PHY is not set
CONFIG_DP83848_PHY=m
# CONFIG_DP83867_PHY is not set
CONFIG_DP83869_PHY=m
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=m
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_RX_OFFLOAD=y
CONFIG_CAN_CAN327=m
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
CONFIG_CAN_CTUCANFD=m
CONFIG_CAN_CTUCANFD_PCI=m
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
CONFIG_CAN_M_CAN_PCI=m
# CONFIG_CAN_M_CAN_PLATFORM is not set
# CONFIG_CAN_M_CAN_TCAN4X5X is not set
CONFIG_CAN_PEAK_PCIEFD=m
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=m
CONFIG_CAN_MCP251X=m
CONFIG_CAN_MCP251XFD=m
# CONFIG_CAN_MCP251XFD_SANITY is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB=m
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_F81604 is not set
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_MCBA_USB=m
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set

#
# MCTP Device Drivers
#
CONFIG_MCTP_SERIAL=m
# CONFIG_MCTP_TRANSPORT_I2C is not set
# end of MCTP Device Drivers

CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
CONFIG_MDIO_BCM_UNIMAC=m
# CONFIG_MDIO_GPIO is not set
CONFIG_MDIO_I2C=m
CONFIG_MDIO_MVUSB=m
# CONFIG_MDIO_MSCC_MIIM is not set
CONFIG_MDIO_REGMAP=m
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=m
CONFIG_PCS_LYNX=m
CONFIG_PCS_MTK_LYNXI=m
# end of PCS device drivers

# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
# CONFIG_PPPOE_HASH_BITS_1 is not set
# CONFIG_PPPOE_HASH_BITS_2 is not set
CONFIG_PPPOE_HASH_BITS_4=y
# CONFIG_PPPOE_HASH_BITS_8 is not set
CONFIG_PPPOE_HASH_BITS=4
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=m
CONFIG_USB_LAN78XX=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=m
CONFIG_USB_NET_SR9700=m
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=m
CONFIG_USB_NET_SMSC95XX=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=m
CONFIG_USB_IPHETH=m
CONFIG_USB_SIERRA_NET=m
CONFIG_USB_VL600=m
CONFIG_USB_NET_CH9200=m
CONFIG_USB_NET_AQC111=m
CONFIG_USB_RTL8153_ECM=m
CONFIG_WLAN=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K=m
CONFIG_ATH5K_DEBUG=y
# CONFIG_ATH5K_TRACER is not set
CONFIG_ATH5K_PCI=y
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_COMMON_DEBUG=y
CONFIG_ATH9K_BTCOEX_SUPPORT=y
CONFIG_ATH9K=m
CONFIG_ATH9K_PCI=y
CONFIG_ATH9K_AHB=y
CONFIG_ATH9K_DEBUGFS=y
# CONFIG_ATH9K_STATION_STATISTICS is not set
# CONFIG_ATH9K_DYNACK is not set
# CONFIG_ATH9K_WOW is not set
CONFIG_ATH9K_RFKILL=y
# CONFIG_ATH9K_CHANNEL_CONTEXT is not set
CONFIG_ATH9K_PCOEM=y
CONFIG_ATH9K_PCI_NO_EEPROM=m
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_ATH9K_HWRNG is not set
# CONFIG_ATH9K_COMMON_SPECTRAL is not set
CONFIG_CARL9170=m
CONFIG_CARL9170_LEDS=y
# CONFIG_CARL9170_DEBUGFS is not set
CONFIG_CARL9170_WPC=y
# CONFIG_CARL9170_HWRNG is not set
CONFIG_ATH6KL=m
CONFIG_ATH6KL_SDIO=m
CONFIG_ATH6KL_USB=m
CONFIG_ATH6KL_DEBUG=y
# CONFIG_ATH6KL_TRACING is not set
CONFIG_AR5523=m
CONFIG_WIL6210=m
CONFIG_WIL6210_ISR_COR=y
# CONFIG_WIL6210_TRACING is not set
CONFIG_WIL6210_DEBUGFS=y
CONFIG_ATH10K=m
CONFIG_ATH10K_CE=y
CONFIG_ATH10K_PCI=m
CONFIG_ATH10K_SDIO=m
CONFIG_ATH10K_USB=m
# CONFIG_ATH10K_DEBUG is not set
CONFIG_ATH10K_DEBUGFS=y
# CONFIG_ATH10K_SPECTRAL is not set
# CONFIG_ATH10K_TRACING is not set
CONFIG_WCN36XX=m
# CONFIG_WCN36XX_DEBUGFS is not set
CONFIG_ATH11K=m
# CONFIG_ATH11K_AHB is not set
CONFIG_ATH11K_PCI=m
# CONFIG_ATH11K_DEBUG is not set
# CONFIG_ATH11K_DEBUGFS is not set
# CONFIG_ATH11K_TRACING is not set
CONFIG_ATH12K=m
# CONFIG_ATH12K_DEBUG is not set
# CONFIG_ATH12K_TRACING is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_B43=m
CONFIG_B43_BCMA=y
CONFIG_B43_SSB=y
CONFIG_B43_BUSES_BCMA_AND_SSB=y
# CONFIG_B43_BUSES_BCMA is not set
# CONFIG_B43_BUSES_SSB is not set
CONFIG_B43_PCI_AUTOSELECT=y
CONFIG_B43_PCICORE_AUTOSELECT=y
CONFIG_B43_SDIO=y
CONFIG_B43_BCMA_PIO=y
CONFIG_B43_PIO=y
CONFIG_B43_PHY_G=y
CONFIG_B43_PHY_N=y
CONFIG_B43_PHY_LP=y
CONFIG_B43_PHY_HT=y
CONFIG_B43_LEDS=y
CONFIG_B43_HWRNG=y
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=m
CONFIG_B43LEGACY_PCI_AUTOSELECT=y
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=y
CONFIG_B43LEGACY_LEDS=y
CONFIG_B43LEGACY_HWRNG=y
# CONFIG_B43LEGACY_DEBUG is not set
CONFIG_B43LEGACY_DMA=y
CONFIG_B43LEGACY_PIO=y
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=y
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
CONFIG_BRCMUTIL=m
CONFIG_BRCMSMAC=m
CONFIG_BRCMSMAC_LEDS=y
CONFIG_BRCMFMAC=m
CONFIG_BRCMFMAC_PROTO_BCDC=y
CONFIG_BRCMFMAC_PROTO_MSGBUF=y
CONFIG_BRCMFMAC_SDIO=y
CONFIG_BRCMFMAC_USB=y
CONFIG_BRCMFMAC_PCIE=y
# CONFIG_BRCM_TRACING is not set
# CONFIG_BRCMDBG is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y

#
# Debugging Options
#
CONFIG_IWLWIFI_DEBUG=y
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
CONFIG_P54_COMMON=m
CONFIG_P54_USB=m
CONFIG_P54_PCI=m
# CONFIG_P54_SPI is not set
CONFIG_P54_LEDS=y
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
CONFIG_LIBERTAS_THINFIRM=m
# CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
CONFIG_LIBERTAS_THINFIRM_USB=m
CONFIG_MWIFIEX=m
CONFIG_MWIFIEX_SDIO=m
CONFIG_MWIFIEX_PCIE=m
CONFIG_MWIFIEX_USB=m
CONFIG_MWL8K=m
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_MT7601U=m
CONFIG_MT76_CORE=m
CONFIG_MT76_LEDS=y
CONFIG_MT76_USB=m
CONFIG_MT76_SDIO=m
CONFIG_MT76x02_LIB=m
CONFIG_MT76x02_USB=m
CONFIG_MT76_CONNAC_LIB=m
CONFIG_MT76x0_COMMON=m
CONFIG_MT76x0U=m
CONFIG_MT76x0E=m
CONFIG_MT76x2_COMMON=m
CONFIG_MT76x2E=m
CONFIG_MT76x2U=m
CONFIG_MT7603E=m
CONFIG_MT7615_COMMON=m
CONFIG_MT7615E=m
CONFIG_MT7663_USB_SDIO_COMMON=m
CONFIG_MT7663U=m
CONFIG_MT7663S=m
CONFIG_MT7915E=m
CONFIG_MT7921_COMMON=m
CONFIG_MT7921E=m
CONFIG_MT7921S=m
CONFIG_MT7921U=m
CONFIG_MT7996E=m
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_WLAN_VENDOR_PURELIFI is not set
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_RT2X00=m
CONFIG_RT2400PCI=m
CONFIG_RT2500PCI=m
CONFIG_RT61PCI=m
CONFIG_RT2800PCI=m
CONFIG_RT2800PCI_RT33XX=y
CONFIG_RT2800PCI_RT35XX=y
CONFIG_RT2800PCI_RT53XX=y
CONFIG_RT2800PCI_RT3290=y
CONFIG_RT2500USB=m
CONFIG_RT73USB=m
CONFIG_RT2800USB=m
CONFIG_RT2800USB_RT33XX=y
CONFIG_RT2800USB_RT35XX=y
CONFIG_RT2800USB_RT3573=y
CONFIG_RT2800USB_RT53XX=y
CONFIG_RT2800USB_RT55XX=y
CONFIG_RT2800USB_UNKNOWN=y
CONFIG_RT2800_LIB=m
CONFIG_RT2800_LIB_MMIO=m
CONFIG_RT2X00_LIB_MMIO=m
CONFIG_RT2X00_LIB_PCI=m
CONFIG_RT2X00_LIB_USB=m
CONFIG_RT2X00_LIB=m
CONFIG_RT2X00_LIB_FIRMWARE=y
CONFIG_RT2X00_LIB_CRYPTO=y
CONFIG_RT2X00_LIB_LEDS=y
CONFIG_RT2X00_LIB_DEBUGFS=y
# CONFIG_RT2X00_DEBUG is not set
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_RTL8180=m
CONFIG_RTL8187=m
CONFIG_RTL8187_LEDS=y
CONFIG_RTL_CARDS=m
CONFIG_RTL8192CE=m
CONFIG_RTL8192SE=m
CONFIG_RTL8192DE=m
CONFIG_RTL8723AE=m
CONFIG_RTL8723BE=m
CONFIG_RTL8188EE=m
CONFIG_RTL8192EE=m
CONFIG_RTL8821AE=m
CONFIG_RTL8192CU=m
CONFIG_RTLWIFI=m
CONFIG_RTLWIFI_PCI=m
CONFIG_RTLWIFI_USB=m
# CONFIG_RTLWIFI_DEBUG is not set
CONFIG_RTL8192C_COMMON=m
CONFIG_RTL8723_COMMON=m
CONFIG_RTLBTCOEXIST=m
CONFIG_RTL8XXXU=m
CONFIG_RTL8XXXU_UNTESTED=y
CONFIG_RTW88=m
CONFIG_RTW88_CORE=m
CONFIG_RTW88_PCI=m
CONFIG_RTW88_SDIO=m
CONFIG_RTW88_USB=m
CONFIG_RTW88_8822B=m
CONFIG_RTW88_8822C=m
CONFIG_RTW88_8723D=m
CONFIG_RTW88_8821C=m
CONFIG_RTW88_8822BE=m
CONFIG_RTW88_8822BS=m
CONFIG_RTW88_8822BU=m
CONFIG_RTW88_8822CE=m
CONFIG_RTW88_8822CS=m
CONFIG_RTW88_8822CU=m
CONFIG_RTW88_8723DE=m
# CONFIG_RTW88_8723DS is not set
CONFIG_RTW88_8723DU=m
CONFIG_RTW88_8821CE=m
CONFIG_RTW88_8821CS=m
CONFIG_RTW88_8821CU=m
# CONFIG_RTW88_DEBUG is not set
# CONFIG_RTW88_DEBUGFS is not set
CONFIG_RTW89=m
CONFIG_RTW89_CORE=m
CONFIG_RTW89_PCI=m
CONFIG_RTW89_8852A=m
CONFIG_RTW89_8852B=m
CONFIG_RTW89_8852C=m
# CONFIG_RTW89_8851BE is not set
CONFIG_RTW89_8852AE=m
CONFIG_RTW89_8852BE=m
CONFIG_RTW89_8852CE=m
# CONFIG_RTW89_DEBUGMSG is not set
# CONFIG_RTW89_DEBUGFS is not set
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_RSI_91X=m
CONFIG_RSI_DEBUGFS=y
CONFIG_RSI_SDIO=m
CONFIG_RSI_USB=m
CONFIG_RSI_COEX=y
# CONFIG_WLAN_VENDOR_SILABS is not set
CONFIG_WLAN_VENDOR_ST=y
CONFIG_CW1200=m
CONFIG_CW1200_WLAN_SDIO=m
CONFIG_CW1200_WLAN_SPI=m
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WL1251=m
CONFIG_WL1251_SPI=m
CONFIG_WL1251_SDIO=m
CONFIG_WL12XX=m
CONFIG_WL18XX=m
CONFIG_WLCORE=m
CONFIG_WLCORE_SDIO=m
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
CONFIG_QTNFMAC=m
CONFIG_QTNFMAC_PCIE=m
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_PCMCIA_WL3501 is not set
CONFIG_USB_NET_RNDIS_WLAN=m
CONFIG_MAC80211_HWSIM=m
CONFIG_VIRT_WIFI=m
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
CONFIG_IEEE802154_AT86RF230=m
CONFIG_IEEE802154_MRF24J40=m
CONFIG_IEEE802154_CC2520=m
CONFIG_IEEE802154_ATUSB=m
CONFIG_IEEE802154_ADF7242=m
CONFIG_IEEE802154_CA8210=m
# CONFIG_IEEE802154_CA8210_DEBUGFS is not set
CONFIG_IEEE802154_MCR20A=m
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_DEBUGFS=y
CONFIG_WWAN_HWSIM=m
CONFIG_MHI_WWAN_CTRL=m
CONFIG_MHI_WWAN_MBIM=m
CONFIG_IOSM=m
CONFIG_MTK_T7XX=m
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_XEN_NETDEV_BACKEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_USB4_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set
CONFIG_INPUT_KUNIT_TEST=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_APPLESPI=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=m
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=m
CONFIG_KEYBOARD_CYPRESS_SF=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADC=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=m
CONFIG_JOYSTICK_IFORCE_232=m
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_WALKERA0701=m
CONFIG_JOYSTICK_PSXPAD_SPI=m
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
CONFIG_JOYSTICK_PXRC=m
CONFIG_JOYSTICK_QWIIC=m
# CONFIG_JOYSTICK_FSIA6B is not set
# CONFIG_JOYSTICK_SENSEHAT is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=m
CONFIG_TABLET_USB_PEGASUS=m
CONFIG_TABLET_SERIAL_WACOM4=m
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
CONFIG_TOUCHSCREEN_CY8CTMA140=m
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP5=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_HYCON_HY46XX=m
CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX=m
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_ILITEK=m
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=m
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MSG2638=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS=m
CONFIG_TOUCHSCREEN_IMAGIS=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=m
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_COLIBRI_VF50=m
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_TOUCHSCREEN_ZINITIX=m
CONFIG_TOUCHSCREEN_HIMAX_HX83112B=m
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ARIZONA_HAPTICS is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_GPIO_VIBRA=m
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=m
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=m
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IBM_PANEL is not set
# CONFIG_INPUT_IMS_PCU is not set
CONFIG_INPUT_IQS269A=m
CONFIG_INPUT_IQS626A=m
CONFIG_INPUT_IQS7222=m
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_SOC_BUTTON_ARRAY=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_RT5120_PWRKEY=m
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LEGACY_TIOCSTI is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_PCI1XXXX=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DFL=m
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_KGDB_NMI is not set
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_CONSOLE_POLL=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_IPWIRELESS=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
CONFIG_NULL_TTY=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_IPMB=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_SSIF_IPMI_BMC=m
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_APPLICOM is not set
CONFIG_MWAVE=m
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_SPI_CR50=y
CONFIG_TCG_TIS_I2C=m
CONFIG_TCG_TIS_I2C_CR50=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=m
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m
CONFIG_XILLYUSB=m
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_AMD_MP2=m
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_CHT_WC=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=m
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
CONFIG_I2C_CP2615=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PCI1XXXX=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_ALTERA_CORE=m
CONFIG_SPI_ALTERA_DFL=m
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=m
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_MICROCHIP_CORE=m
CONFIG_SPI_MICROCHIP_CORE_QSPI=m
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PCI1XXXX=m
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
CONFIG_PTP_1588_CLOCK_IDT82P33=m
CONFIG_PTP_1588_CLOCK_IDTCM=m
CONFIG_PTP_1588_CLOCK_VMW=m
# CONFIG_PTP_1588_CLOCK_OCP is not set
CONFIG_PTP_DFL_TOD=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_CY8C95X0=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_ELKHARTLAKE=m
CONFIG_PINCTRL_EMMITSBURG=m
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=m
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_METEORLAKE=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_REGMAP=m
CONFIG_GPIO_IDIO_16=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_TANGIER=m
CONFIG_GPIO_AMD_FCH=m
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_FXL6408=m
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=m
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_CRYSTAL_COVE=y
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_ELKHARTLAKE=m
CONFIG_GPIO_TPS68470=m
CONFIG_GPIO_WHISKEY_COVE=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCI_IDIO_16=m
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=m
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=m
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

CONFIG_W1=m
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_CW2015=m
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SAMSUNG_SDI=y
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_AXP20X_POWER is not set
CONFIG_AXP288_CHARGER=m
CONFIG_AXP288_FUEL_GAUGE=m
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_LTC4162L=m
CONFIG_CHARGER_MAX77976=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_RT9467=m
CONFIG_CHARGER_RT9471=m
CONFIG_CHARGER_CROS_USBPD=m
CONFIG_CHARGER_CROS_PCHG=m
CONFIG_CHARGER_BD99954=m
CONFIG_BATTERY_SURFACE=m
CONFIG_CHARGER_SURFACE=m
CONFIG_BATTERY_UG3105=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_AXI_FAN_CONTROL=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_CORSAIR_CPRO=m
CONFIG_SENSORS_CORSAIR_PSU=m
CONFIG_SENSORS_DRIVETEMP=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_I8K=y
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2947_SPI=m
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX31760=m
# CONFIG_MAX31827 is not set
CONFIG_SENSORS_MAX6620=m
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MC34VR500=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_MLXREG_FAN=m
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT6775_I2C=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_NZXT_KRAKEN2=m
CONFIG_SENSORS_NZXT_SMART2=m
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_OXP=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ACBEL_FSG032 is not set
CONFIG_SENSORS_ADM1266=m
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_BPA_RS600=m
CONFIG_SENSORS_DELTA_AHE50DC_FAN=m
CONFIG_SENSORS_FSP_3Y=m
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_DPS920AB=m
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LM25066_REGULATOR=y
CONFIG_SENSORS_LT7182S=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2888=m
CONFIG_SENSORS_MP2975=m
CONFIG_SENSORS_MP5023=m
CONFIG_SENSORS_MPQ7932_REGULATOR=y
CONFIG_SENSORS_MPQ7932=m
CONFIG_SENSORS_PIM4328=m
CONFIG_SENSORS_PLI1209BC=m
CONFIG_SENSORS_PLI1209BC_REGULATOR=y
CONFIG_SENSORS_PM6764TR=m
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_Q54SJ108A2=m
# CONFIG_SENSORS_STPDDC60 is not set
CONFIG_SENSORS_TDA38640=m
CONFIG_SENSORS_TDA38640_REGULATOR=y
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_TPS546D24=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_XDPE152=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SBTSI=m
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SY7636A=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC2305=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA238=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP464=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_SENSORS_ASUS_WMI=m
CONFIG_SENSORS_ASUS_EC=m
# CONFIG_SENSORS_HP_WMI is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=m
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_INTEL_TCC_COOLING=m
CONFIG_INTEL_HFI_THERMAL=y
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_MLX_WDT=m
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ADVANTECH_EC_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_EXAR_WDT=m
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=m
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=m
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
CONFIG_TQMX86_WDT=m
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=m
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_BLOCKIO=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_B43_PCI_BRIDGE=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_BLOCKIO=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=m
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=m
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_BXTWC=m
CONFIG_INTEL_SOC_PMIC_CHTWC=y
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_INTEL_SOC_PMIC_MRFLD=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_PMC_BXT=m
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_SY7636A=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=m
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RT5120=m
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS6594_I2C is not set
# CONFIG_MFD_TPS6594_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
CONFIG_MFD_ARIZONA=m
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=m
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_INTEL_M10_BMC_CORE=m
CONFIG_MFD_INTEL_M10_BMC_SPI=m
CONFIG_MFD_INTEL_M10_BMC_PMCI=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=m
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX20411=m
# CONFIG_REGULATOR_MAX77826 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_RAA215300 is not set
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT4803=m
CONFIG_REGULATOR_RT4831=m
CONFIG_REGULATOR_RT5120=m
CONFIG_REGULATOR_RT5190A=m
CONFIG_REGULATOR_RT5739=m
CONFIG_REGULATOR_RT5759=m
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6190=m
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_RTQ6752=m
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_SY7636A=m
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS68470=m
CONFIG_RC_CORE=y
CONFIG_BPF_LIRC_MODE2=y
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_RCMM_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_XMP_DECODER=m
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
CONFIG_IR_IGORPLUGUSB=m
CONFIG_IR_IGUANA=m
CONFIG_IR_IMON=m
CONFIG_IR_IMON_RAW=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_MCEUSB=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_STREAMZAP=m
CONFIG_IR_TOY=m
CONFIG_IR_TTUSBIR=m
CONFIG_IR_WINBOND_CIR=m
CONFIG_RC_ATI_REMOTE=m
CONFIG_RC_LOOPBACK=m
CONFIG_RC_XBOX_DVD=m
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=m
# CONFIG_CEC_CROS_EC is not set
CONFIG_CEC_GPIO=m
CONFIG_CEC_SECO=m
CONFIG_CEC_SECO_RC=y
CONFIG_USB_PULSE8_CEC=m
CONFIG_USB_RAINSHADOW_CEC=m
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_MEM2MEM_DEV=m
# CONFIG_V4L2_FLASH_LED_CLASS is not set
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_GSPCA=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
CONFIG_USB_GSPCA_DTCS033=m
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
CONFIG_USB_GSPCA_KINECT=m
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
CONFIG_USB_GSPCA_STK1135=m
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
CONFIG_USB_GSPCA_TOUPTEK=m
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_GL860=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_USB_S2255=m
CONFIG_VIDEO_USBTV=m
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y

#
# Analog TV USB devices
#
CONFIG_VIDEO_GO7007=m
CONFIG_VIDEO_GO7007_USB=m
CONFIG_VIDEO_GO7007_LOADER=m
CONFIG_VIDEO_GO7007_USB_S2250_BOARD=m
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_STK1160_COMMON=m
CONFIG_VIDEO_STK1160=m

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_AS102=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_DVBSKY=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
CONFIG_DVB_USB_ZD1301=m
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_CXUSB_ANALOG=y
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_VP7045=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
CONFIG_VIDEO_EM28XX_V4L2=m
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_SOLO6X10=m
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
CONFIG_VIDEO_TW686X=m
# CONFIG_VIDEO_ZORAN is not set

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_DT3155 is not set
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
CONFIG_VIDEO_HEXIUM_GEMINI=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_MXB=m

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7134_GO7007=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
CONFIG_DVB_DM1105=m
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NETUP_UNIDVB=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_DVB_SMIPCIE=m
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_VIDEO_IPU3_CIO2=m
CONFIG_CIO2_BRIDGE=y
CONFIG_RADIO_ADAPTERS=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_SHARK=m
CONFIG_RADIO_SHARK2=m
CONFIG_RADIO_SI4713=m
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_TEA5764=m
# CONFIG_RADIO_TEF6862 is not set
CONFIG_RADIO_WL1273=m
CONFIG_USB_DSBR=m
CONFIG_USB_KEENE=m
CONFIG_USB_MA901=m
CONFIG_USB_MR800=m
# CONFIG_USB_RAREMONO is not set
CONFIG_RADIO_SI470X=m
CONFIG_USB_SI470X=m
CONFIG_I2C_SI470X=m
# CONFIG_USB_SI4713 is not set
# CONFIG_PLATFORM_SI4713 is not set
# CONFIG_I2C_SI4713 is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
CONFIG_VIDEO_CADENCE_CSI2RX=m
CONFIG_VIDEO_CADENCE_CSI2TX=m

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# Microchip Technology, Inc. media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# Verisilicon media platform drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIM2M=m
CONFIG_VIDEO_VICODEC=m
CONFIG_VIDEO_VIMC=m
CONFIG_VIDEO_VIVID=m
CONFIG_VIDEO_VIVID_CEC=y
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VISL=m
# CONFIG_VISL_DEBUGFS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_TTPCI_EEPROM=m
CONFIG_UVC_COMMON=m
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set
CONFIG_VIDEO_V4L2_TPG=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=m
CONFIG_VIDEO_CCS_PLL=m
CONFIG_VIDEO_AR0521=m
CONFIG_VIDEO_HI556=m
CONFIG_VIDEO_HI846=m
CONFIG_VIDEO_HI847=m
CONFIG_VIDEO_IMX208=m
CONFIG_VIDEO_IMX214=m
CONFIG_VIDEO_IMX219=m
CONFIG_VIDEO_IMX258=m
CONFIG_VIDEO_IMX274=m
CONFIG_VIDEO_IMX290=m
CONFIG_VIDEO_IMX296=m
CONFIG_VIDEO_IMX319=m
CONFIG_VIDEO_IMX355=m
CONFIG_VIDEO_MAX9271_LIB=m
CONFIG_VIDEO_MT9M001=m
# CONFIG_VIDEO_MT9M111 is not set
CONFIG_VIDEO_MT9P031=m
CONFIG_VIDEO_MT9T112=m
CONFIG_VIDEO_MT9V011=m
CONFIG_VIDEO_MT9V032=m
CONFIG_VIDEO_MT9V111=m
CONFIG_VIDEO_OG01A1B=m
CONFIG_VIDEO_OV02A10=m
CONFIG_VIDEO_OV08D10=m
CONFIG_VIDEO_OV08X40=m
CONFIG_VIDEO_OV13858=m
CONFIG_VIDEO_OV13B10=m
CONFIG_VIDEO_OV2640=m
CONFIG_VIDEO_OV2659=m
CONFIG_VIDEO_OV2680=m
CONFIG_VIDEO_OV2685=m
# CONFIG_VIDEO_OV2740 is not set
CONFIG_VIDEO_OV4689=m
CONFIG_VIDEO_OV5647=m
CONFIG_VIDEO_OV5648=m
CONFIG_VIDEO_OV5670=m
CONFIG_VIDEO_OV5675=m
CONFIG_VIDEO_OV5693=m
CONFIG_VIDEO_OV5695=m
CONFIG_VIDEO_OV6650=m
CONFIG_VIDEO_OV7251=m
CONFIG_VIDEO_OV7640=m
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV772X=m
CONFIG_VIDEO_OV7740=m
CONFIG_VIDEO_OV8856=m
CONFIG_VIDEO_OV8858=m
CONFIG_VIDEO_OV8865=m
CONFIG_VIDEO_OV9640=m
CONFIG_VIDEO_OV9650=m
CONFIG_VIDEO_OV9734=m
CONFIG_VIDEO_RDACM20=m
# CONFIG_VIDEO_RDACM21 is not set
CONFIG_VIDEO_RJ54N1=m
CONFIG_VIDEO_S5C73M3=m
CONFIG_VIDEO_S5K5BAF=m
CONFIG_VIDEO_S5K6A3=m
CONFIG_VIDEO_CCS=m
CONFIG_VIDEO_ET8EK8=m
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=m
CONFIG_VIDEO_AK7375=m
CONFIG_VIDEO_DW9714=m
CONFIG_VIDEO_DW9768=m
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
CONFIG_VIDEO_LM3560=m
CONFIG_VIDEO_LM3646=m
# end of Flash devices

#
# audio, video and radio I2C drivers auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_SONY_BTF_MPX=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_SAA6588=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TVP5150=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
CONFIG_VIDEO_SAA6752HS=m
CONFIG_VIDEO_M52790=m

#
# SPI I2C drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
CONFIG_VIDEO_GS1662=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Tuner drivers auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=m

#
# DVB Frontend drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_MT312=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
CONFIG_DVB_AS102_FE=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_EC100=m
CONFIG_DVB_GP8PSK_FE=m
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_ZL10353=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_VES1820=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_MXL692=m
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_HELENE=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_DRX39XYJ=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KUNIT_TEST_HELPERS=m
CONFIG_DRM_KUNIT_TEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_DMA_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SUBALLOC_HELPER=m
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_FP=y
CONFIG_DRM_AMD_DC_SI=y
# CONFIG_DEBUG_KERNEL_DC is not set
CONFIG_DRM_AMD_SECURE_DISPLAY=y
# end of Display Engine Configuration

CONFIG_HSA_AMD=y
CONFIG_HSA_AMD_SVM=y
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_NOUVEAU_DEBUG_PUSH is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
# CONFIG_DRM_NOUVEAU_SVM is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_PXP=y
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=m
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_MKSSTATS=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_GM12U320=m
CONFIG_DRM_PANEL_MIPI_DBI=m
CONFIG_DRM_SIMPLEDRM=y
# CONFIG_TINYDRM_HX8357D is not set
CONFIG_TINYDRM_ILI9163=m
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=m
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN_FRONTEND is not set
CONFIG_DRM_VBOXVIDEO=m
CONFIG_DRM_GUD=m
CONFIG_DRM_SSD130X=m
CONFIG_DRM_SSD130X_I2C=m
CONFIG_DRM_SSD130X_SPI=m
CONFIG_DRM_HYPERV=m
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_IO_HELPERS=y
CONFIG_FB_SYS_HELPERS=y
CONFIG_FB_SYS_HELPERS_DEFERRED=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_XEN_FBDEV_FRONTEND=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_KTZ8866=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_RT4831=m
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
# CONFIG_SND_SEQ_UMP is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
# CONFIG_SND_PCMTEST is not set
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_SB_COMMON=m
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
CONFIG_SND_ALS300=m
CONFIG_SND_ALS4000=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
CONFIG_SND_FM801=m
CONFIG_SND_FM801_TEA575X_BOOL=y
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_SCODEC_CS35L41=m
CONFIG_SND_HDA_CS_DSP_CONTROLS=m
CONFIG_SND_HDA_SCODEC_CS35L41_I2C=m
CONFIG_SND_HDA_SCODEC_CS35L41_SPI=m
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CS8409=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=1
CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM=y
# CONFIG_SND_HDA_CTL_DEV_ID is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
# CONFIG_SND_INTEL_BYT_PREFER_SOF is not set
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
# CONFIG_SND_USB_AUDIO_MIDI_V2 is not set
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
CONFIG_SND_DICE=m
CONFIG_SND_OXFW=m
CONFIG_SND_ISIGHT=m
CONFIG_SND_FIREWORKS=m
CONFIG_SND_BEBOB=m
CONFIG_SND_FIREWIRE_DIGI00X=m
CONFIG_SND_FIREWIRE_TASCAM=m
CONFIG_SND_FIREWIRE_MOTU=m
CONFIG_SND_FIREFACE=m
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST=m
CONFIG_SND_SOC_UTILS_KUNIT_TEST=m
CONFIG_SND_SOC_ACPI=m
CONFIG_SND_SOC_ADI=m
CONFIG_SND_SOC_ADI_AXI_I2S=m
CONFIG_SND_SOC_ADI_AXI_SPDIF=m
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
CONFIG_SND_SOC_AMD_ST_ES8336_MACH=m
CONFIG_SND_SOC_AMD_ACP3x=m
CONFIG_SND_SOC_AMD_RV_RT5682_MACH=m
CONFIG_SND_SOC_AMD_RENOIR=m
CONFIG_SND_SOC_AMD_RENOIR_MACH=m
CONFIG_SND_SOC_AMD_ACP5x=m
CONFIG_SND_SOC_AMD_VANGOGH_MACH=m
CONFIG_SND_SOC_AMD_ACP6x=m
CONFIG_SND_SOC_AMD_YC_MACH=m
CONFIG_SND_AMD_ACP_CONFIG=m
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
CONFIG_SND_SOC_AMD_RPL_ACP6x=m
CONFIG_SND_SOC_AMD_PS=m
CONFIG_SND_SOC_AMD_PS_MACH=m
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_SOC_CHV3_I2S is not set
# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_CATPT=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
CONFIG_SND_SOC_INTEL_CML_H=m
CONFIG_SND_SOC_INTEL_CML_LP=m
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_AVS=m

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219=m
CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC=m
CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO=m
CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=m
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98927=m
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A=m
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373=m
CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825=m
CONFIG_SND_SOC_INTEL_AVS_MACH_PROBE=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT274=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT286=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT298=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682=m
CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567=m
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_HDA_DSP_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_MAXIM_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_REALTEK_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_CIRRUS_COMMON=m
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_WM5102_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_SOF_WM8804_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=m
CONFIG_SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m
CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=m
CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH=m
CONFIG_SND_SOC_INTEL_SOF_PCM512x_MACH=m
CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH=m
CONFIG_SND_SOC_INTEL_SOF_NAU8825_MACH=m
CONFIG_SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH=m
CONFIG_SND_SOC_INTEL_SOF_DA7219_MAX98373_MACH=m
CONFIG_SND_SOC_INTEL_SOF_SSP_AMP_MACH=m
CONFIG_SND_SOC_INTEL_EHL_RT5660_MACH=m
CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=m
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI_DEV=m
CONFIG_SND_SOC_SOF_PCI=m
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_ACPI_DEV=m
CONFIG_SND_SOC_SOF_DEBUG_PROBES=m
CONFIG_SND_SOC_SOF_CLIENT=m
CONFIG_SND_SOC_SOF=m
CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=y
CONFIG_SND_SOC_SOF_IPC3=y
CONFIG_SND_SOC_SOF_INTEL_IPC4=y
CONFIG_SND_SOC_SOF_AMD_TOPLEVEL=m
CONFIG_SND_SOC_SOF_AMD_COMMON=m
CONFIG_SND_SOC_SOF_AMD_RENOIR=m
CONFIG_SND_SOC_SOF_AMD_REMBRANDT=m
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
CONFIG_SND_SOC_SOF_INTEL_COMMON=m
CONFIG_SND_SOC_SOF_BAYTRAIL=m
CONFIG_SND_SOC_SOF_BROADWELL=m
CONFIG_SND_SOC_SOF_MERRIFIELD=m
CONFIG_SND_SOC_SOF_INTEL_SKL=m
CONFIG_SND_SOC_SOF_SKYLAKE=m
CONFIG_SND_SOC_SOF_KABYLAKE=m
CONFIG_SND_SOC_SOF_INTEL_APL=m
CONFIG_SND_SOC_SOF_APOLLOLAKE=m
CONFIG_SND_SOC_SOF_GEMINILAKE=m
CONFIG_SND_SOC_SOF_INTEL_CNL=m
CONFIG_SND_SOC_SOF_CANNONLAKE=m
CONFIG_SND_SOC_SOF_COFFEELAKE=m
CONFIG_SND_SOC_SOF_COMETLAKE=m
CONFIG_SND_SOC_SOF_INTEL_ICL=m
CONFIG_SND_SOC_SOF_ICELAKE=m
CONFIG_SND_SOC_SOF_JASPERLAKE=m
CONFIG_SND_SOC_SOF_INTEL_TGL=m
CONFIG_SND_SOC_SOF_TIGERLAKE=m
CONFIG_SND_SOC_SOF_ELKHARTLAKE=m
CONFIG_SND_SOC_SOF_ALDERLAKE=m
CONFIG_SND_SOC_SOF_INTEL_MTL=m
CONFIG_SND_SOC_SOF_METEORLAKE=m
CONFIG_SND_SOC_SOF_HDA_COMMON=m
CONFIG_SND_SOC_SOF_HDA_MLINK=m
CONFIG_SND_SOC_SOF_HDA_LINK=y
CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=y
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_HDA=m
CONFIG_SND_SOC_SOF_HDA_PROBES=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=m
CONFIG_SND_SOC_SOF_XTENSA=m

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_ARIZONA=m
CONFIG_SND_SOC_WM_ADSP=m
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
CONFIG_SND_SOC_ADAU7118_HW=m
CONFIG_SND_SOC_ADAU7118_I2C=m
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=m
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_AW8738=m
CONFIG_SND_SOC_AW88395_LIB=m
CONFIG_SND_SOC_AW88395=m
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
# CONFIG_SND_SOC_CHV3_CODEC is not set
CONFIG_SND_SOC_CROS_EC_CODEC=m
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS35L36=m
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
CONFIG_SND_SOC_CS35L41_SPI=m
CONFIG_SND_SOC_CS35L41_I2C=m
CONFIG_SND_SOC_CS35L45=m
CONFIG_SND_SOC_CS35L45_SPI=m
CONFIG_SND_SOC_CS35L45_I2C=m
CONFIG_SND_SOC_CS35L56=m
CONFIG_SND_SOC_CS35L56_SHARED=m
CONFIG_SND_SOC_CS35L56_I2C=m
CONFIG_SND_SOC_CS35L56_SPI=m
CONFIG_SND_SOC_CS35L56_SDW=m
CONFIG_SND_SOC_CS42L42_CORE=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L42_SDW=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS42L83=m
CONFIG_SND_SOC_CS4234=m
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=m
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_ES7134=m
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8326=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
CONFIG_SND_SOC_HDA=m
# CONFIG_SND_SOC_ICS43432 is not set
CONFIG_SND_SOC_IDT821034=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98520=m
CONFIG_SND_SOC_MAX98363=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
CONFIG_SND_SOC_MAX98373_SDW=m
# CONFIG_SND_SOC_MAX98388 is not set
CONFIG_SND_SOC_MAX98390=m
CONFIG_SND_SOC_MAX98396=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM186X_SPI=m
CONFIG_SND_SOC_PCM3060=m
CONFIG_SND_SOC_PCM3060_I2C=m
CONFIG_SND_SOC_PCM3060_SPI=m
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_PEB2466 is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT274=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT1011=m
CONFIG_SND_SOC_RT1015=m
CONFIG_SND_SOC_RT1015P=m
CONFIG_SND_SOC_RT1308=m
CONFIG_SND_SOC_RT1308_SDW=m
CONFIG_SND_SOC_RT1316_SDW=m
CONFIG_SND_SOC_RT1318_SDW=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5659=m
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_I2C=m
CONFIG_SND_SOC_RT5682_SDW=m
CONFIG_SND_SOC_RT5682S=m
CONFIG_SND_SOC_RT700=m
CONFIG_SND_SOC_RT700_SDW=m
CONFIG_SND_SOC_RT711=m
CONFIG_SND_SOC_RT711_SDW=m
CONFIG_SND_SOC_RT711_SDCA_SDW=m
CONFIG_SND_SOC_RT712_SDCA_SDW=m
CONFIG_SND_SOC_RT712_SDCA_DMIC_SDW=m
# CONFIG_SND_SOC_RT722_SDCA_SDW is not set
CONFIG_SND_SOC_RT715=m
CONFIG_SND_SOC_RT715_SDW=m
CONFIG_SND_SOC_RT715_SDCA_SDW=m
# CONFIG_SND_SOC_RT9120 is not set
# CONFIG_SND_SOC_SDW_MOCKUP is not set
# CONFIG_SND_SOC_SGTL5000 is not set
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
CONFIG_SND_SOC_SIMPLE_MUX=m
CONFIG_SND_SOC_SMA1303=m
CONFIG_SND_SOC_SPDIF=m
# CONFIG_SND_SOC_SRC4XXX_I2C is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS2562=m
CONFIG_SND_SOC_TAS2764=m
CONFIG_SND_SOC_TAS2770=m
CONFIG_SND_SOC_TAS2780=m
# CONFIG_SND_SOC_TAS2781_I2C is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS5805M=m
CONFIG_SND_SOC_TAS6424=m
CONFIG_SND_SOC_TDA7419=m
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TFA989X is not set
CONFIG_SND_SOC_TLV320ADC3XXX=m
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
CONFIG_SND_SOC_TLV320ADCX140=m
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WCD938X_SDW is not set
CONFIG_SND_SOC_WM5102=m
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=m
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8731_I2C=m
CONFIG_SND_SOC_WM8731_SPI=m
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
CONFIG_SND_SOC_WM8940=m
# CONFIG_SND_SOC_WM8960 is not set
CONFIG_SND_SOC_WM8961=m
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_WSA881X is not set
CONFIG_SND_SOC_WSA883X=m
# CONFIG_SND_SOC_WSA884X is not set
CONFIG_SND_SOC_ZL38060=m
CONFIG_SND_SOC_MAX9759=m
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
CONFIG_SND_SOC_NAU8315=m
CONFIG_SND_SOC_NAU8540=m
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8821=m
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
CONFIG_SND_XEN_FRONTEND=m
CONFIG_SND_VIRTIO=m
CONFIG_AC97_BUS=m
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
CONFIG_HID_BIGBEN_FF=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CP2112=m
CONFIG_HID_CREATIVE_SB0540=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELAN=m
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
CONFIG_HID_EVISION=m
CONFIG_HID_EZKEY=m
CONFIG_HID_FT260=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_GLORIOUS=m
CONFIG_HID_HOLTEK=m
CONFIG_HOLTEK_FF=y
CONFIG_HID_VIVALDI_COMMON=m
# CONFIG_HID_GOOGLE_HAMMER is not set
CONFIG_HID_VIVALDI=m
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
# CONFIG_HID_VRC2 is not set
CONFIG_HID_XIAOMI=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LETSKETCH=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=m
CONFIG_HID_MAYFLASH=m
CONFIG_HID_MEGAWORLD_FF=m
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NINTENDO=m
CONFIG_NINTENDO_FF=y
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=y
# CONFIG_HID_NVIDIA_SHIELD is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=m
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PLAYSTATION=m
CONFIG_PLAYSTATION_FF=y
CONFIG_HID_PXRC=m
CONFIG_HID_RAZER=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SEMITEK=m
CONFIG_HID_SIGMAMICRO=m
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_STEAM_FF=y
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_TOPRE=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_U2FZERO=m
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=m
CONFIG_HID_MCP2221=m
CONFIG_HID_KUNIT_TEST=m
# end of Special HID drivers

#
# HID-BPF support
#
CONFIG_HID_BPF=y
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

CONFIG_I2C_HID=y
CONFIG_I2C_HID_ACPI=m
# CONFIG_I2C_HID_OF is not set
CONFIG_I2C_HID_CORE=m

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
CONFIG_AMD_SFH_HID=m
# end of AMD SFH HID Support

#
# Surface System Aggregator Module HID support
#
CONFIG_SURFACE_HID=m
CONFIG_SURFACE_KBD=m
# end of Surface System Aggregator Module HID support

CONFIG_SURFACE_HID_CORE=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_SL811_CS is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set
CONFIG_USB_XEN_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
CONFIG_USBIP_VHCI_HCD=m
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=m
# CONFIG_USBIP_DEBUG is not set

#
# USB dual-mode controller drivers
#
CONFIG_USB_CDNS_SUPPORT=m
# CONFIG_USB_CDNS3 is not set
CONFIG_USB_CDNSP_PCI=m
# CONFIG_USB_CDNSP_HOST is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_XR=m
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_APPLE_MFI_FASTCHARGE=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
# CONFIG_TYPEC_RT1711H is not set
CONFIG_TYPEC_TCPCI_MAXIM=m
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_WCOVE=m
CONFIG_TYPEC_UCSI=m
CONFIG_UCSI_CCG=m
CONFIG_UCSI_ACPI=m
CONFIG_UCSI_STM32G0=m
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_ANX7411 is not set
CONFIG_TYPEC_RT1719=m
CONFIG_TYPEC_HD3SS3220=m
CONFIG_TYPEC_STUSB160X=m
CONFIG_TYPEC_WUSB3801=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=m
CONFIG_TYPEC_MUX_GPIO_SBU=m
CONFIG_TYPEC_MUX_PI3USB30532=m
CONFIG_TYPEC_MUX_INTEL_PMC=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
CONFIG_TYPEC_NVIDIA_ALTMODE=m
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_ALCOR=m
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
CONFIG_MMC_TOSHIBA_PCI=m
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_APU=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_LEDS_TRIGGER_TTY=m

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y

#
# Speakup console speech
#
CONFIG_SPEAKUP=m
CONFIG_SPEAKUP_SYNTH_ACNTSA=m
CONFIG_SPEAKUP_SYNTH_APOLLO=m
CONFIG_SPEAKUP_SYNTH_AUDPTR=m
CONFIG_SPEAKUP_SYNTH_BNS=m
CONFIG_SPEAKUP_SYNTH_DECTLK=m
# CONFIG_SPEAKUP_SYNTH_DECEXT is not set
CONFIG_SPEAKUP_SYNTH_LTLK=m
CONFIG_SPEAKUP_SYNTH_SOFT=m
CONFIG_SPEAKUP_SYNTH_SPKOUT=m
CONFIG_SPEAKUP_SYNTH_TXPRT=m
# CONFIG_SPEAKUP_SYNTH_DUMMY is not set
# end of Speakup console speech

CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
CONFIG_INFINIBAND_BNXT_RE=m
CONFIG_INFINIBAND_CXGB4=m
CONFIG_INFINIBAND_EFA=m
CONFIG_INFINIBAND_ERDMA=m
CONFIG_INFINIBAND_HFI1=m
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
CONFIG_INFINIBAND_IRDMA=m
CONFIG_MANA_INFINIBAND=m
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_MTHCA=m
CONFIG_INFINIBAND_MTHCA_DEBUG=y
CONFIG_INFINIBAND_OCRDMA=m
CONFIG_INFINIBAND_QEDR=m
CONFIG_INFINIBAND_QIB=m
CONFIG_INFINIBAND_QIB_DCA=y
CONFIG_INFINIBAND_USNIC=m
CONFIG_INFINIBAND_VMWARE_PVRDMA=m
CONFIG_INFINIBAND_RDMAVT=m
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
CONFIG_INFINIBAND_IPOIB_DEBUG=y
CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
CONFIG_INFINIBAND_RTRS=m
CONFIG_INFINIBAND_RTRS_CLIENT=m
CONFIG_INFINIBAND_RTRS_SERVER=m
CONFIG_INFINIBAND_OPA_VNIC=m
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
CONFIG_EDAC_I10NM=m
CONFIG_EDAC_PND2=m
CONFIG_EDAC_IGEN6=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_LIB_KUNIT_TEST=m
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=m
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=m
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=m
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV3028=m
CONFIG_RTC_DRV_RV3032=m
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_SD3078=m

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=m
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=m
CONFIG_RTC_DRV_DS1343=m
CONFIG_RTC_DRV_DS1347=m
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=m
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IDXD_SVM=y
CONFIG_INTEL_IDXD_PERFMON=y
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
CONFIG_XILINX_XDMA=m
CONFIG_AMD_PTDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_DW_EDMA=m
CONFIG_DW_EDMA_PCIE=m
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_LINEDISP=m
CONFIG_HD44780_COMMON=m
CONFIG_HD44780=m
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=m
# CONFIG_LCD2S is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_UIO_DFL=m
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y

#
# VFIO support for PCI devices
#
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_VGA=y
CONFIG_VFIO_PCI_IGD=y
CONFIG_MLX5_VFIO_PCI=m
# end of VFIO support for PCI devices

CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VBOXGUEST=m
CONFIG_NITRO_ENCLAVES=m
CONFIG_ACRN_HSM=m
CONFIG_EFI_SECRET=m
CONFIG_SEV_GUEST=m
CONFIG_TDX_GUEST_DRIVER=m
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_VDPA=m
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
CONFIG_VDPA=m
CONFIG_VDPA_SIM=m
CONFIG_VDPA_SIM_NET=m
CONFIG_VDPA_SIM_BLOCK=m
CONFIG_VDPA_USER=m
CONFIG_IFCVF=m
CONFIG_MLX5_VDPA=y
CONFIG_MLX5_VDPA_NET=m
# CONFIG_MLX5_VDPA_STEERING_DEBUG is not set
CONFIG_VP_VDPA=m
CONFIG_ALIBABA_ENI_VDPA=m
CONFIG_SNET_VDPA=m
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_RING=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST_VDPA=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_MEMORY_HOTPLUG_LIMIT=512
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=m
CONFIG_XEN_GRANT_DEV_ALLOC=m
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PCI_STUB=y
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
CONFIG_XEN_SCSI_BACKEND=m
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=m
CONFIG_XEN_UNPOPULATED_ALLOC=y
CONFIG_XEN_GRANT_DMA_OPS=y
CONFIG_XEN_VIRTIO=y
# CONFIG_XEN_VIRTIO_FORCE_GRANT is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
CONFIG_RTL8723BS=m
CONFIG_R8712U=m
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
CONFIG_STAGING_MEDIA=y
# CONFIG_INTEL_ATOMISP is not set
# CONFIG_DVB_AV7110 is not set
CONFIG_VIDEO_IPU3_IMGU=m
# CONFIG_STAGING_MEDIA_DEPRECATED is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
CONFIG_QLGE=m
# CONFIG_VME_BUS is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_ACPI=m
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=m
CONFIG_CHROMEOS_TBMC=y
CONFIG_CROS_EC=m
CONFIG_CROS_EC_I2C=m
# CONFIG_CROS_EC_ISHTP is not set
CONFIG_CROS_EC_SPI=m
CONFIG_CROS_EC_UART=m
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
# CONFIG_CROS_EC_DEBUGFS is not set
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_EC_TYPEC=m
CONFIG_CROS_HPS_I2C=m
CONFIG_CROS_USBPD_LOGGER=m
CONFIG_CROS_USBPD_NOTIFY=m
CONFIG_CHROMEOS_PRIVACY_SCREEN=m
CONFIG_CROS_TYPEC_SWITCH=m
# CONFIG_WILCO_EC is not set
CONFIG_CROS_KUNIT=m
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
CONFIG_MLXREG_LC=m
CONFIG_NVSW_SN2201=m
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE3_WMI=m
CONFIG_SURFACE_3_POWER_OPREGION=m
CONFIG_SURFACE_ACPI_NOTIFY=m
CONFIG_SURFACE_AGGREGATOR_CDEV=m
CONFIG_SURFACE_AGGREGATOR_HUB=m
CONFIG_SURFACE_AGGREGATOR_REGISTRY=m
CONFIG_SURFACE_AGGREGATOR_TABLET_SWITCH=m
CONFIG_SURFACE_DTX=m
CONFIG_SURFACE_GPE=m
CONFIG_SURFACE_HOTPLUG=m
CONFIG_SURFACE_PLATFORM_PROFILE=m
CONFIG_SURFACE_PRO3_BUTTON=m
CONFIG_SURFACE_AGGREGATOR=m
CONFIG_SURFACE_AGGREGATOR_BUS=y
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_HUAWEI_WMI=m
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
CONFIG_NVIDIA_WMI_EC_BACKLIGHT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_GIGABYTE_WMI=m
# CONFIG_YOGABOOK is not set
CONFIG_ACERHDF=m
CONFIG_ACER_WIRELESS=m
CONFIG_ACER_WMI=m
CONFIG_AMD_PMF=m
# CONFIG_AMD_PMF_DEBUG is not set
CONFIG_AMD_PMC=m
CONFIG_AMD_HSMP=m
CONFIG_ADV_SWBUTTON=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
CONFIG_ASUS_WIRELESS=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_ASUS_TF103C_DOCK=m
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_ALIENWARE_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_LAPTOP=m
# CONFIG_DELL_RBU is not set
CONFIG_DELL_RBTN=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_PRIVACY=y
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_DDV=m
CONFIG_DELL_WMI_LED=m
CONFIG_DELL_WMI_SYSMAN=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=m
CONFIG_X86_PLATFORM_DRIVERS_HP=y
CONFIG_HP_ACCEL=m
CONFIG_HP_WMI=m
CONFIG_WIRELESS_HOTKEY=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_LENOVO_YMC=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_THINKPAD_LMI=m
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=m
CONFIG_INTEL_ATOMISP2_PM=m
CONFIG_INTEL_IFS=m
CONFIG_INTEL_SAR_INT1092=m
CONFIG_INTEL_SKL_INT3472=m
CONFIG_INTEL_PMC_CORE=y
CONFIG_INTEL_PMT_CLASS=m
CONFIG_INTEL_PMT_TELEMETRY=m
CONFIG_INTEL_PMT_CRASHLOG=m

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_TPMI=m
CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TELEMETRY=m
CONFIG_INTEL_WMI=y
CONFIG_INTEL_WMI_SBL_FW_UPDATE=m
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL_TPMI=m
CONFIG_INTEL_UNCORE_FREQ_CONTROL=m
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_BXTWC_PMIC_TMU=m
CONFIG_INTEL_BYTCRC_PWRSRC=m
CONFIG_INTEL_CHTDC_TI_PWRBTN=m
CONFIG_INTEL_CHTWC_INT33FE=m
CONFIG_INTEL_ISHTP_ECLITE=m
CONFIG_INTEL_MRFLD_PWRBTN=m
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_RST=m
CONFIG_INTEL_SDSI=m
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_INTEL_TPMI=m
CONFIG_INTEL_TURBO_MAX_3=y
CONFIG_INTEL_VSEC=m
CONFIG_MSI_EC=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
CONFIG_PCENGINES_APU2=m
CONFIG_BARCO_P50_GPIO=m
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=m
CONFIG_TOSHIBA_WMI=m
# CONFIG_ACPI_CMPC is not set
CONFIG_COMPAL_LAPTOP=m
CONFIG_LG_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_SYSTEM76_ACPI=m
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_SERIAL_MULTI_INSTANTIATE=m
CONFIG_MLX_PLATFORM=m
CONFIG_TOUCHSCREEN_DMI=y
CONFIG_X86_ANDROID_TABLETS=m
CONFIG_FW_ATTR_CLASS=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
CONFIG_INTEL_SCU_PLATFORM=m
CONFIG_INTEL_SCU_IPC_UTIL=m
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_WINMATE_FM07_KEYS=m
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI544=m
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_TPS68470=m
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_XILINX_VCU=m
CONFIG_CLK_KUNIT_TEST=m
CONFIG_CLK_GATE_KUNIT_TEST=m
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
CONFIG_IOMMUFD=m
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_AMD=m
CONFIG_SOUNDWIRE_CADENCE=m
CONFIG_SOUNDWIRE_INTEL=m
# CONFIG_SOUNDWIRE_QCOM is not set
CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=m

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

CONFIG_WPCM450_SOC=m

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_QMI_HELPERS=m
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_AXP288=m
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_INTEL_CHT_WC=m
CONFIG_EXTCON_INTEL_MRFLD=m
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_EXTCON_USBC_TUSB320=m
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_GTS_HELPER=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
CONFIG_ADXL313=m
CONFIG_ADXL313_I2C=m
CONFIG_ADXL313_SPI=m
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
CONFIG_ADXL355=m
CONFIG_ADXL355_I2C=m
CONFIG_ADXL355_SPI=m
CONFIG_ADXL367=m
CONFIG_ADXL367_SPI=m
CONFIG_ADXL367_I2C=m
CONFIG_ADXL372=m
CONFIG_ADXL372_SPI=m
CONFIG_ADXL372_I2C=m
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
# CONFIG_BMI088_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=m
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_IIO_KX022A=m
CONFIG_IIO_KX022A_SPI=m
CONFIG_IIO_KX022A_I2C=m
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=m
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=m
CONFIG_MMA8452=m
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
CONFIG_MSA311=m
CONFIG_MXC4005=m
CONFIG_MXC6255=m
# CONFIG_SCA3000 is not set
CONFIG_SCA3300=m
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD4130=m
# CONFIG_AD7091R5 is not set
CONFIG_AD7124=m
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7280 is not set
# CONFIG_AD7291 is not set
CONFIG_AD7292=m
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7766=m
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
CONFIG_AD7949=m
# CONFIG_AD799X is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
CONFIG_DLN2_ADC=m
CONFIG_ENVELOPE_DETECTOR=m
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
CONFIG_INTEL_MRFLD_ADC=m
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
CONFIG_MAX11205=m
CONFIG_MAX11410=m
CONFIG_MAX1241=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
CONFIG_MCP3911=m
# CONFIG_NAU7802 is not set
CONFIG_RICHTEK_RTQ6056=m
CONFIG_SD_ADC_MODULATOR=m
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=m
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7924=m
CONFIG_TI_ADS1100=m
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_ADS8344=m
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
CONFIG_TI_ADS131E08=m
CONFIG_TI_LMP92064=m
# CONFIG_TI_TLC4541 is not set
CONFIG_TI_TSC2046=m
# CONFIG_VF610_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_AD74115=m
CONFIG_AD74413R=m
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_ADA4250 is not set
CONFIG_HMC425=m
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
CONFIG_PMS7003=m
CONFIG_SCD30_CORE=m
CONFIG_SCD30_I2C=m
CONFIG_SCD30_SERIAL=m
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
# CONFIG_SPS30_I2C is not set
# CONFIG_SPS30_SERIAL is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
CONFIG_AD3552R=m
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
CONFIG_LTC2688=m
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
CONFIG_AD5766=m
CONFIG_AD5770R=m
# CONFIG_AD5791 is not set
CONFIG_AD7293=m
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
CONFIG_DPOT_DAC=m
# CONFIG_DS4424 is not set
CONFIG_LTC1660=m
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
CONFIG_MAX5522=m
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=m
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Filters
#
# CONFIG_ADMV8818 is not set
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
CONFIG_ADF4377=m
# CONFIG_ADMV1013 is not set
# CONFIG_ADMV1014 is not set
# CONFIG_ADMV4420 is not set
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
CONFIG_ADXRS290=m
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_FXAS21002C_SPI=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
# CONFIG_HDC100X is not set
CONFIG_HDC2010=m
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
CONFIG_ADIS16475=m
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
CONFIG_BOSCH_BNO055=m
CONFIG_BOSCH_BNO055_SERIAL=m
CONFIG_BOSCH_BNO055_I2C=m
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
CONFIG_FXOS8700_SPI=m
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=m
CONFIG_INV_ICM42600_I2C=m
CONFIG_INV_ICM42600_SPI=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=m
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=m
CONFIG_AL3010=m
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
CONFIG_BH1750=m
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=m
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP002=m
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
# CONFIG_JSA1212 is not set
CONFIG_ROHM_BU27034=m
CONFIG_RPR0521=m
CONFIG_LTR501=m
CONFIG_LTRF216A=m
CONFIG_LV0104CS=m
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=m
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=m
CONFIG_PA12203001=m
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=m
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
# CONFIG_VEML6070 is not set
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
CONFIG_SENSORS_RM3100_SPI=m
# CONFIG_TI_TMAG5273 is not set
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

CONFIG_IIO_RESCALE_KUNIT_TEST=m
CONFIG_IIO_FORMAT_KUNIT_TEST=m

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=m
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=m
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=m
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
CONFIG_MCP41010=m
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_IIO_CROS_EC_BARO=m
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
CONFIG_ICP10100=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_CROS_EC_MKBP_PROXIMITY=m
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=m
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=m
CONFIG_SX9310=m
CONFIG_SX9324=m
CONFIG_SX9360=m
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_LTC2983=m
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=m
CONFIG_MLX90632=m
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
CONFIG_TMP117=m
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
CONFIG_MAX30208=m
CONFIG_MAX31856=m
CONFIG_MAX31865=m
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
CONFIG_NTB_IDT=m
CONFIG_NTB_INTEL=m
CONFIG_NTB_EPF=m
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
CONFIG_PWM_CRC=y
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_DWC=m
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_RESET_TI_TPS380X=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_INTEL_RAPL_TPMI is not set
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
CONFIG_USB4=m
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_CXL=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
CONFIG_NVMEM_LAYOUT_SL28_VPD=m
CONFIG_NVMEM_LAYOUT_ONIE_TLV=m
# end of Layout Types

CONFIG_NVMEM_RMEM=m

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_PROTO_BASIC=m
CONFIG_STM_PROTO_SYS_T=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_MGR_XILINX_SPI=m
CONFIG_FPGA_MGR_MACHXO2_SPI=m
CONFIG_FPGA_BRIDGE=m
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
CONFIG_FPGA_DFL_FME_BRIDGE=m
CONFIG_FPGA_DFL_FME_REGION=m
CONFIG_FPGA_DFL_AFU=m
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=m
CONFIG_FPGA_DFL_PCI=m
CONFIG_FPGA_M10_BMC_SEC_UPDATE=m
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
CONFIG_FPGA_MGR_LATTICE_SYSCONFIG=m
CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI=m
CONFIG_TEE=m
# CONFIG_AMDTEE is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=m
# end of Multiplexer drivers

# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=m
CONFIG_INTEL_QEP=m
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
# CONFIG_OCFS2_FS_STATS is not set
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
CONFIG_F2FS_FS_LZO=y
CONFIG_F2FS_FS_LZORLE=y
CONFIG_F2FS_FS_LZ4=y
CONFIG_F2FS_FS_LZ4HC=y
CONFIG_F2FS_FS_ZSTD=y
CONFIG_F2FS_IOSTAT=y
CONFIG_F2FS_UNFAIR_RWSEM=y
CONFIG_ZONEFS_FS=m
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
CONFIG_FUSE_DAX=y
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_FAT_KUNIT_TEST=m
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
CONFIG_NTFS3_FS=m
# CONFIG_NTFS3_64BIT_CLUSTER is not set
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_UBIFS_FS=m
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
CONFIG_UBIFS_FS_AUTHENTICATION=y
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=m
CONFIG_PSTORE_LZ4_COMPRESS=m
CONFIG_PSTORE_LZ4HC_COMPRESS=m
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=m
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
CONFIG_EROFS_FS_SECURITY=y
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_ZIP_LZMA=y
# CONFIG_EROFS_FS_PCPU_KTHREAD is not set
CONFIG_VBOXSF_FS=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=m
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=m
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
CONFIG_NFS_SWAP=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_NFS_FSCACHE=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
CONFIG_NFSD_BLOCKLAYOUT=y
CONFIG_NFSD_SCSILAYOUT=y
CONFIG_NFSD_FLEXFILELAYOUT=y
CONFIG_NFSD_V4_2_INTER_SSC=y
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_SUNRPC_SWAP=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=y
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=y
CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=m
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
CONFIG_CEPH_FSCACHE=y
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CEPH_FS_SECURITY_LABEL=y
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
CONFIG_CIFS_SWN_UPCALL=y
# CONFIG_CIFS_SMB_DIRECT is not set
CONFIG_CIFS_FSCACHE=y
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=m
CONFIG_CODA_FS=m
CONFIG_AFS_FS=m
CONFIG_AFS_DEBUG=y
CONFIG_AFS_FSCACHE=y
# CONFIG_AFS_DEBUG_CURSOR is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_INFINIBAND=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_PLATFORM_KEYRING=y
CONFIG_INTEGRITY_MACHINE_KEYRING=y
# CONFIG_INTEGRITY_CA_MACHINE_KEYRING is not set
CONFIG_LOAD_UEFI_KEYS=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_KEXEC=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
# CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
CONFIG_IMA_DEFAULT_HASH_SHA256=y
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha256"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_APPRAISE_MODSIG=y
# CONFIG_IMA_TRUSTED_KEYRING is not set
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,integrity,selinux,bpf,landlock"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_FIPS=y
CONFIG_CRYPTO_FIPS_NAME="Linux Kernel Cryptographic API"
# CONFIG_CRYPTO_FIPS_CUSTOM_VERSION is not set
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=m
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=m
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=m
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=m
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XCTR=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_GENIV=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLYVAL=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_JITTERENTROPY_TESTINTERFACE is not set
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
CONFIG_CRYPTO_STATS=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=m
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=m
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=m
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_4XXX=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE=y
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_FLAGS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=m
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
CONFIG_OBJAGG=m
# end of Library routines

CONFIG_PLDMFW=y
CONFIG_ASN1_ENCODER=y
CONFIG_POLYNOMIAL=m

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=3
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x0
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_KGDB=y
CONFIG_KGDB_HONOUR_BLOCKLIST=y
CONFIG_KGDB_SERIAL_CONSOLE=y
CONFIG_KGDB_TESTS=y
# CONFIG_KGDB_TESTS_ON_BOOT is not set
CONFIG_KGDB_LOW_LEVEL_TRAP=y
# CONFIG_KGDB_KDB is not set
CONFIG_ARCH_HAS_EARLY_DEBUG=y
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_KASAN_STACK=y
# CONFIG_KASAN_VMALLOC is not set
CONFIG_KASAN_KUNIT_TEST=m
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
# CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
# CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_FUNCTION_GRAPH_RETVAL is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FPROBE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_FPROBE_EVENTS=y
CONFIG_PROBE_EVENTS_BTF_ARGS=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_DA_MON_EVENTS=y
CONFIG_DA_MON_EVENTS_ID=y
CONFIG_RV=y
CONFIG_RV_MON_WWNR=y
CONFIG_RV_REACTORS=y
CONFIG_RV_REACT_PRINTK=y
CONFIG_RV_REACT_PANIC=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=m
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
CONFIG_KUNIT_ALL_TESTS=m
CONFIG_KUNIT_DEFAULT_ENABLED=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FUNCTION_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
CONFIG_CPUMASK_KUNIT_TEST=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
CONFIG_TEST_SORT=m
# CONFIG_TEST_DIV64 is not set
CONFIG_KPROBES_SANITY_TEST=m
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_PARMAN is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
CONFIG_TEST_VMALLOC=m
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=m
CONFIG_CHECKSUM_KUNIT=m
CONFIG_HASH_KUNIT_TEST=m
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
CONFIG_HASHTABLE_KUNIT_TEST=m
CONFIG_LINEAR_RANGES_TEST=m
CONFIG_CMDLINE_KUNIT_TEST=m
CONFIG_BITS_TEST=m
CONFIG_SLUB_KUNIT_TEST=m
CONFIG_RATIONAL_KUNIT_TEST=m
CONFIG_MEMCPY_KUNIT_TEST=m
CONFIG_MEMCPY_SLOW_KUNIT_TEST=y
CONFIG_IS_SIGNED_TYPE_KUNIT_TEST=m
CONFIG_OVERFLOW_KUNIT_TEST=m
CONFIG_STACKINIT_KUNIT_TEST=m
CONFIG_FORTIFY_KUNIT_TEST=m
CONFIG_STRCAT_KUNIT_TEST=m
CONFIG_STRSCPY_KUNIT_TEST=m
CONFIG_SIPHASH_KUNIT_TEST=m
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_OBJAGG is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--AHQ8Dlxzo78Yy+15--
