Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6800D48B114
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 16:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbiAKPlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 10:41:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56030 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiAKPlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:41:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46A01212C5;
        Tue, 11 Jan 2022 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641915690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaeh72LNlQ3FJmzxxlOZxQSkNAPJwZlxowsmMRMGMVw=;
        b=QkQUdB1pCGs/AozhrpVo4RO6hfCBm6mA+j0o8+QY4VPSLEad2gkLp9Z2Zi6FGKeVFOCFAB
        1OIvfzfl9W3skPYEfJdcMqd6gu8dngI/GnVkd61ailOGuV+7R3wG1XeSD4fIBOsqatOtN6
        1S/hNCI5G+xKbJnqrpraVfeuQ5F6Y5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641915690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaeh72LNlQ3FJmzxxlOZxQSkNAPJwZlxowsmMRMGMVw=;
        b=yBs8AXrIO0pErgyQ4ypZm16jOB6JLTDyBoA6X3+KnQrptNo4hhneCtYwt/YVp/N8tTIYBx
        ewwPgGirOQl+rMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC9D913ADE;
        Tue, 11 Jan 2022 15:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E8oVNSml3WHRFAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 11 Jan 2022 15:41:29 +0000
Message-ID: <a72a4e3a-3af9-7a36-4583-6181f3579cfb@suse.cz>
Date:   Tue, 11 Jan 2022 16:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-3-songmuchun@bytedance.com>
 <Ydet1XmiY8SZPLUx@carbon.dhcp.thefacebook.com>
 <CAMZfGtWmwTLHdO6acx9_+nR68j-v9SKjMsq-0v4ZDeQORgaQ=w@mail.gmail.com>
 <Ydx/MFK72xrsXE0l@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 02/16] mm: introduce kmem_cache_alloc_lru
In-Reply-To: <Ydx/MFK72xrsXE0l@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/10/22 19:47, Roman Gushchin wrote:
> On Sun, Jan 09, 2022 at 02:21:22PM +0800, Muchun Song wrote:
>> On Fri, Jan 7, 2022 at 11:05 AM Roman Gushchin <guro@fb.com> wrote:
>> >
>> [...]
>> > >  /*
>> > >   * struct kmem_cache related prototypes
>> > > @@ -425,6 +426,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>> > >
>> > >  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
>> > >  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
>> > > +void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>> > > +                        gfp_t gfpflags) __assume_slab_alignment __malloc;
>> >
>> > I'm not a big fan of this patch: I don't see why preparing the lru
>> > infrastructure has to be integrated that deep into the slab code.
>> >
>> > Why can't kmem_cache_alloc_lru() be a simple wrapper like (pseudo-code):
>> >   void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>> >                            gfp_t gfpflags) {
>> >         if (necessarily)
>> >            prepare_lru_infra();
>> >         return kmem_cache_alloc();
>> >   }
>> 
>> Hi Roman,
>> 
>> Actually, it can. But there is going to be some redundant code similar
>> like memcg_slab_pre_alloc_hook() does to detect the necessity of
>> prepare_lru_infra() in the new scheme of kmem_cache_alloc_lru().
>> I just want to reduce the redundant overhead.
> 
> Is this about getting a memcg pointer?
> I doubt it's a good reason to make changes all over the slab code.
> Another option to consider adding a new gfp flag.

I'm not sure how a flag would help as it seems we really need to pass a
specific list_lru pointer and work with that. I was thinking if there was
only one list_lru per class of object it could be part of struct kmem_cache,
but investigating kmem_cache_alloc_lru() callers I see lru parameters:

- &nfs4_xattr_cache_lru - this is fixed
- xas->xa_lru potentially not fixed, although the only caller of
xas_set_lru() passes &shadow_nodes so effectively fixed
- &sb->s_dentry_lru - dynamic, boo

> Vlastimil, what do you think?

Memcg code is already quite intertwined with slab code, for better or worse,
so I guess the extra lru parameter in a bunch of inline functions won't
change much. I don't immediately see a better solution.

> Thanks!
> 

