Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351616F4B42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 22:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjEBUUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 16:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjEBUUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 16:20:48 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F310FF;
        Tue,  2 May 2023 13:20:43 -0700 (PDT)
Received: from meshulam.tesarici.cz (nat-97.starnet.cz [178.255.168.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 6FA1714DA42;
        Tue,  2 May 2023 22:20:39 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1683058840; bh=c6+AjJZEdge9Ayz4MLe/nHAKX7Tv0/ZFK/0DiJPO/9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nPG1qjOr7v6urxTa/dDsxEUlZEa5MDcMqqkvEnzLRd+gOpEDFo3qmkwegYOYej8ZD
         QTjGWTTox7AQ163g0WgPoZ5rP6EuCPxbnvCFDJub2qlRJj3nCyaLkJ3lmzrYjeUvoJ
         I4fMaBworaYA333m1PUKTtEiXnPqJC5rCYzJY9jQ2/pvFI2SR3TudZyUI/BtIkzm4K
         RDtJZNtPk/NZIgn2bz3E8SWJfhfoXpuuXFbWhWc7sUo1cnDE41kYe6YEm0R6gS9db+
         etfaPN6CirTgig9v30TjT9Ua3hv9pvMHL0OJQdrDWCwq0nkICa5BEM3ApRSc5Jx6zl
         4Oj1rVA8EEZtw==
Date:   Tue, 2 May 2023 22:20:38 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 03/40] fs: Convert alloc_inode_sb() to a macro
Message-ID: <20230502222038.57a47a85@meshulam.tesarici.cz>
In-Reply-To: <ZFFrP8WKRFgZRzoB@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
        <20230501165450.15352-4-surenb@google.com>
        <20230502143530.1586e287@meshulam.tesarici.cz>
        <ZFFrP8WKRFgZRzoB@moria.home.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2 May 2023 15:57:51 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Tue, May 02, 2023 at 02:35:30PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Mon,  1 May 2023 09:54:13 -0700
> > Suren Baghdasaryan <surenb@google.com> wrote:
> >  =20
> > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > >=20
> > > We're introducing alloc tagging, which tracks memory allocations by
> > > callsite. Converting alloc_inode_sb() to a macro means allocations wi=
ll
> > > be tracked by its caller, which is a bit more useful.
> > >=20
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  include/linux/fs.h | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >=20
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 21a981680856..4905ce14db0b 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2699,11 +2699,7 @@ int setattr_should_drop_sgid(struct mnt_idmap =
*idmap,
> > >   * This must be used for allocating filesystems specific inodes to s=
et
> > >   * up the inode reclaim context correctly.
> > >   */
> > > -static inline void *
> > > -alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp=
_t gfp)
> > > -{
> > > -	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
> > > -}
> > > +#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cach=
e, &_sb->s_inode_lru, _gfp) =20
> >=20
> > Honestly, I don't like this change. In general, pre-processor macros
> > are ugly and error-prone. =20
>=20
> It's a one line macro, it's fine.

It's not the same. A macro effectively adds a keyword, because it gets
expanded regardless of context; for example, you can't declare a local
variable called alloc_inode_sb, and the compiler errors may be quite
confusing at first. See also the discussion about patch 19/40 in this
series.

> > Besides, it works for you only because __kmem_cache_alloc_lru() is
> > declared __always_inline (unless CONFIG_SLUB_TINY is defined, but then
> > you probably don't want the tracking either). In any case, it's going
> > to be difficult for people to understand why and how this works. =20
>=20
> I think you must be confused. kmem_cache_alloc_lru() is a macro, and we
> need that macro to be expanded at the alloc_inode_sb() callsite. It's
> got nothing to do with whether or not __kmem_cache_alloc_lru() is inline
> or not.

Oh no, I am not confused. Look at the definition of
kmem_cache_alloc_lru():

void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
			   gfp_t gfpflags)
{
	return __kmem_cache_alloc_lru(s, lru, gfpflags);
}

See? No _RET_IP_ here. That's because it's here:

static __fastpath_inline
void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
			     gfp_t gfpflags)
{
	void *ret =3D slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);

	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);

	return ret;
}

Now, if __kmem_cache_alloc_lru() is not inlined, then this _RET_IP_
will be somewhere inside kmem_cache_alloc_lru(), which is not very
useful.

But what is __fastpath_inline? Well, it depends:

#ifndef CONFIG_SLUB_TINY
#define __fastpath_inline __always_inline
#else
#define __fastpath_inline
#endif

In short, if CONFIG_SLUB_TINY is defined, it's up to the C compiler
whether __kmem_cache_alloc_lru() is inlined or not.

> > If the actual caller of alloc_inode_sb() is needed, I'd rather add it
> > as a parameter and pass down _RET_IP_ explicitly here. =20
>=20
> That approach was considered, but adding an ip parameter to every memory
> allocation function would've been far more churn.

See my reply to patch 19/40. Rename the original function, but add an
__always_inline function with the original signature, and let it take
care of _RET_IP_.

Petr T
