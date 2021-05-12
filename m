Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60737B476
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 05:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhELDV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 23:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhELDV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 23:21:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C0C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 20:20:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m124so17158376pgm.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 20:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0E05OrXdqW9H2ReWLoImyNAZwoWDkKkUkvJVilZtAk=;
        b=VVRagCeMJog1E+4Kn5glvSDrq5Z9pScXTmoEgqtFvqbpwAp4+ssECkxAhdk/vtqDwj
         BZnaZgrR1jyX5rdx19eD0hi94IshSlJqglbb1GslPPXUQqb2Syw/GmM9YEmqHMaaXp81
         2r+T8R8DYzEQ/rQOrSEdkFWINQGvFlkm4RrBWbbVLwk/7ON2mUsH2/Y067k3NY2G8cf9
         t0jPJMrIJlf+GJ4buPS1vDmV8FYuO1GYcVG3PSCngqUEabK5nX2r5r6XoHVfUb1QKW0b
         Iipc35TkH1zgpr3J+ToxNIgfRWUUh4qNi/VAYS9P7T6JuZ35/1Oyd+hx7rXkRQBQW9Fa
         l+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0E05OrXdqW9H2ReWLoImyNAZwoWDkKkUkvJVilZtAk=;
        b=Ki15ytzdCbt02tUvsU/R1774w5fzp08L4VMDOZJ6HwMOpTKjib6p4bbCXjoI6Qdy3k
         Wp/nL+l3/9ymBJqwN7MckMZe9Xj0I6JOqUANVw0RM6+DpCRiy2BdWtbl4LbhL+R24sFo
         qNMpiayepsEsLMv+G+91iW5iIhJsrNZAL92EvR/HZLuAtlwfz1gdDW+1IDb7tcD+jvHO
         fdL3eTkXMcmNdO+SZA50aNqROFAMRnLuXN15iTSe7IMJ8KiOEfq5xxwX3ItiTfP3nx0f
         YlSz/AYHExDvW2G/dEehe1dWQpvUsSatJacraL4583L7W2zf7RtZsrzqeITsgf28ymYW
         q5gw==
X-Gm-Message-State: AOAM531HT2edxffBWHkhiAFS85DzJhiopLJAk7u6d0K0+WOMNb/glmyG
        OOGomP5VmbPRGfNCB9vZkxdSh5LCwX+gsba8ZGG0MA==
X-Google-Smtp-Source: ABdhPJyGmBzA6PB1rG2IFhsITR6WU/fAlG0hy4zTLptVYrtYuchEfeOpjh01hqqw+BQwMmZ4kbr6JD15UVyidm9h3CA=
X-Received: by 2002:a05:6a00:8c7:b029:20f:1cf4:d02 with SMTP id
 s7-20020a056a0008c7b029020f1cf40d02mr34091256pfu.49.1620789647824; Tue, 11
 May 2021 20:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210511104647.604-1-songmuchun@bytedance.com>
 <20210511104647.604-11-songmuchun@bytedance.com> <20210511234041.GP1872259@dread.disaster.area>
In-Reply-To: <20210511234041.GP1872259@dread.disaster.area>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 12 May 2021 11:20:10 +0800
Message-ID: <CAMZfGtV3cOY0JwMp_wr+PcHyYZsL4-2v-9YjXnPgpvJXgMvrTw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 10/17] fs: introduce alloc_inode_sb() to
 allocate filesystems specific inode
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        alexs@kernel.org, Wei Yang <richard.weiyang@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 7:40 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, May 11, 2021 at 06:46:40PM +0800, Muchun Song wrote:
> > The allocated inode cache will be added into its memcg lru list later,
> > but we do not allocate list_lru in the later patch. So the caller should
> > call kmem_cache_alloc_lru() to allocate inode and related list_lru.
> > Introduce alloc_inode_sb() to do that and convert all inodes allocation
> > to it.
>
> FWIW, this probably needs a documentation update to mention that
> inodes should always be allocated through alloc_inode_sb() rather
> than kmem_cache_alloc(). It's a "** mandatory **" requirement as per
> Documentation/filesytems/porting.rst.

Make sense to me. I'll fix it in the next version.

>
> Also,
>
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index c3c88fdb9b2a..d8d5d4eb68d6 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -41,6 +41,7 @@
> >  #include <linux/stddef.h>
> >  #include <linux/mount.h>
> >  #include <linux/cred.h>
> > +#include <linux/slab.h>
> >
> >  #include <asm/byteorder.h>
> >  #include <uapi/linux/fs.h>
> > @@ -3200,6 +3201,12 @@ extern void free_inode_nonrcu(struct inode *inode);
> >  extern int should_remove_suid(struct dentry *);
> >  extern int file_remove_privs(struct file *);
> >
> > +static inline void *
> > +alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
> > +{
> > +     return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
> > +}
> > +
>
> This really needs a kerneldoc comment explaining that it must be
> used for allocating inodes to set up the inode reclaim context
> correctly....

Will do.

>
> /me wonders if we should add a BUG_ON() check in inode_init_always()
> to capture filesystems that don't call through
> kmem_cache_alloc_lru() for inodes?

Good point. IMHO, I think that the BUG_ON check may be useful.
Actually, it can catch such bugs.

Any suggestions from others?

Thanks.

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
