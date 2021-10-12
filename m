Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5642AFA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 00:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhJLW3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 18:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232299AbhJLW3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 18:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634077626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11TQf4w46vxOJoeO7+popc8HKFJ+HG521dDzvTk1Lk8=;
        b=CCim/VJdRbUa5rDB04uHkAP9HpU7Smt2FiLxFxud9UL+7h0ySk2bDESFiGRR+rkuhJx64t
        wEyujfkP6KZHUjGlp1IkS2o4Vgt/71rkrWTNhPqXSlmgxmIsK80iNw5NTOz76AV6k8kuJe
        0t9jr5jT4fp0Kp4woUttDMZfmhAOonk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-ZtLXWYbeM0qBQNdtqEmReg-1; Tue, 12 Oct 2021 18:27:05 -0400
X-MC-Unique: ZtLXWYbeM0qBQNdtqEmReg-1
Received: by mail-pj1-f72.google.com with SMTP id ge16-20020a17090b0e1000b001a06598a6e2so532011pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 15:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=11TQf4w46vxOJoeO7+popc8HKFJ+HG521dDzvTk1Lk8=;
        b=GEg8EF/gN9886FNd6wMWfrgKPre84grApxrJ81O57BIoqWKeEjItEa2v+dVvYlU67C
         MyyUVkCoj9cjTRxOtroR1lwEzOd2I0yjM6LsUBqdW1cnhhHWZkhlu9tASRjPD0iLrEdK
         8QRyCuxljm66R/Hqk7zTZ3Xf/OxvNuYO+Uh1TveumPqhRezmt6D6gB/wuxbp02oxW/4a
         XCVbuNYmXU63YK2+O5XzoaVgKqNrmWT6fPhjy7TuynKvFCZIeqz5SfeAwq7Ib6EKlxYK
         awR/2dbFxqs4zt81dyztt8FfRUPsP3Y9OvNLziQ6TZaUNOhkBjcwxPFw1PkmPv6CY/14
         Fcbw==
X-Gm-Message-State: AOAM53331kDneY4pbOadmg7v0duiUjpwOgqyy2JXe6OEvNkVRi6EvfMX
        SxsyctUpGsDORmmk3kWKoc8DUAbwMD9qsTzRq6mWklP1QctAMLPiX6CHdT3X9wRegSvsRiszkuP
        wAVEp8zLNRKfW7Jk54V6D6vzgjw==
X-Received: by 2002:a17:902:784c:b0:138:f4e5:9df8 with SMTP id e12-20020a170902784c00b00138f4e59df8mr32406560pln.14.1634077622746;
        Tue, 12 Oct 2021 15:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBA8O2OyyLjqqHonyZMbXGzyNSBUEqrTLwK9Uzpcpvikl0VbwmqaUyOmIPtZKgrZY8iK/tcA==
X-Received: by 2002:a17:902:784c:b0:138:f4e5:9df8 with SMTP id e12-20020a170902784c00b00138f4e59df8mr32406524pln.14.1634077622340;
        Tue, 12 Oct 2021 15:27:02 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j6sm12131143pgq.0.2021.10.12.15.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 15:27:01 -0700 (PDT)
Date:   Wed, 13 Oct 2021 06:26:55 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 4/5] mm: shmem: don't truncate page if memory failure
 happens
Message-ID: <YWYLr3vOTgLDNiNL@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-5-shy828301@gmail.com>
 <YWTrbgf0kpwayWHL@t490s>
 <CAHbLzkrJ9YZYUS+T64L9vFzg77qVg2SZ4DBGC013kgGTRvpieA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkrJ9YZYUS+T64L9vFzg77qVg2SZ4DBGC013kgGTRvpieA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 12:17:33PM -0700, Yang Shi wrote:
> On Mon, Oct 11, 2021 at 6:57 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Sep 30, 2021 at 02:53:10PM -0700, Yang Shi wrote:
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 88742953532c..75c36b6a405a 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> > >       struct inode *inode = mapping->host;
> > >       struct shmem_inode_info *info = SHMEM_I(inode);
> > >       pgoff_t index = pos >> PAGE_SHIFT;
> > > +     int ret = 0;
> > >
> > >       /* i_rwsem is held by caller */
> > >       if (unlikely(info->seals & (F_SEAL_GROW |
> > > @@ -2466,7 +2467,17 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> > >                       return -EPERM;
> > >       }
> > >
> > > -     return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > > +     ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> > > +
> > > +     if (*pagep) {
> > > +             if (PageHWPoison(*pagep)) {
> > > +                     unlock_page(*pagep);
> > > +                     put_page(*pagep);
> > > +                     ret = -EIO;
> > > +             }
> > > +     }
> > > +
> > > +     return ret;
> > >  }
> > >
> > >  static int
> > > @@ -2555,6 +2566,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > >                       unlock_page(page);
> > >               }
> > >
> > > +             if (page && PageHWPoison(page)) {
> > > +                     error = -EIO;
> > > +                     break;
> > > +             }
> > > +
> > >               /*
> > >                * We must evaluate after, since reads (unlike writes)
> > >                * are called without i_rwsem protection against truncate
> >
> > [...]
> >
> > > @@ -4193,6 +4216,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> > >               page = ERR_PTR(error);
> > >       else
> > >               unlock_page(page);
> > > +
> > > +     if (PageHWPoison(page))
> > > +             page = ERR_PTR(-EIO);
> > > +
> > >       return page;
> > >  #else
> > >       /*
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 7a9008415534..b688d5327177 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -233,6 +233,11 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> > >               goto out;
> > >       }
> > >
> > > +     if (PageHWPoison(page)) {
> > > +             ret = -EIO;
> > > +             goto out_release;
> > > +     }
> > > +
> > >       ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > >                                      page, false, wp_copy);
> > >       if (ret)
> > > --
> > > 2.26.2
> > >
> >
> > These are shmem_getpage_gfp() call sites:
> >
> >   shmem_getpage[151]             return shmem_getpage_gfp(inode, index, pagep, sgp,
> >   shmem_fault[2112]              err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, SGP_CACHE,
> >   shmem_read_mapping_page_gfp[4188] error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
> >
> > These are further shmem_getpage() call sites:
> >
> >   collapse_file[1735]            if (shmem_getpage(mapping->host, index, &page,
> >   shmem_undo_range[965]          shmem_getpage(inode, start - 1, &page, SGP_READ);
> >   shmem_undo_range[980]          shmem_getpage(inode, end, &page, SGP_READ);
> >   shmem_write_begin[2467]        return shmem_getpage(inode, index, pagep, SGP_WRITE);
> >   shmem_file_read_iter[2544]     error = shmem_getpage(inode, index, &page, sgp);
> >   shmem_fallocate[2733]          error = shmem_getpage(inode, index, &page, SGP_FALLOC);
> >   shmem_symlink[3079]            error = shmem_getpage(inode, 0, &page, SGP_WRITE);
> >   shmem_get_link[3120]           error = shmem_getpage(inode, 0, &page, SGP_READ);
> >   mcontinue_atomic_pte[235]      ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
> >
> > Wondering whether this patch covered all of them.
> 
> No, it doesn't need. Not all places care about hwpoison page, for
> example, truncate, hole punch, etc. Only the APIs which return the
> data back to userspace or write back to disk need care about if the
> data is corrupted or not since. This has been elaborated in the cover
> letter.

I see, sorry I missed that.  However I still have two entries unsure in above
list that this patch didn't cover (besides fault path, truncate, ...):

  collapse_file[1735]            if (shmem_getpage(mapping->host, index, &page,
  shmem_get_link[3120]           error = shmem_getpage(inode, 0, &page, SGP_READ);

IIUC the 1st one is when we want to collapse a file thp, should we stop the
attempt if we see a hwpoison small page?

The 2nd one should be where we had a symlink shmem file and the 1st page which
stores the link got corrupted.  Should we fail the get_link() then?

-- 
Peter Xu

