Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AC929D69C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgJ1WOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgJ1WOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:14:35 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E8C0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 15:14:35 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t6so576379qvz.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0lgr981PCkceQMgroek9L0hv+osAnCX7HPzr76CpgTQ=;
        b=EVSFS2u4VnosZdlCuB6zdjl7fBwBAjYX2gkFMt9FqTxB9e7qNI8b54WmFqw6R0bjsB
         prA+uftMLHrjmWze1YJwVDhbLm5Jj59ad9poDfxT/BzVl4PO4gb3/U5TDgvUbecdVSig
         xe58I2tsDly4z1lDx7BTce3TwPAFsO68cRUfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lgr981PCkceQMgroek9L0hv+osAnCX7HPzr76CpgTQ=;
        b=b2FbihRjfun1spi5JrnnBf0bdbXxrdwBF+CqQt3WZv88IIaKlpArChIAdecPGBmzm+
         25JgdNCIRmBrBX2JxsHdNWQvdBynaDtof+6xNmQCn0ciSC15wf59fq9Z/3ah54n3nCzk
         CuXfKjLH0gdFBdCxPo41Bthpfnndw8apRE7GpDpeWo+h1Ac65/smc742TRYj9d9DMUfB
         gqphS5gHJjBcP9NG46vkYBPhOKW5HEFfg7M0bsfMDP5MA2DRhoI5iuVoHZOFTKNQuMYd
         rpZAM6x14OS6bZ52k0dYuHX2xwsPfvBzT1MlInUJBPNg2zgrbC24yyJS089fM/0LXOl5
         L6Fg==
X-Gm-Message-State: AOAM531zptuUzjcVhf0Twpl61fPIgEkszOEqdwRgkzyankkXkqTQRKL0
        glKhcw0XE7RvL/4lE/tlOmRT5l0ZVuj304LSVSVDMpWpm0DeVg==
X-Google-Smtp-Source: ABdhPJzBLdh0FAd5knuPL95LSW2YSG9dOqJ/fK6CBqNUAi1zcFb2eCEV3rNoAm8N+e4PLapUV4OjiuC/YUv79kxVZ0w=
X-Received: by 2002:a1f:a94c:: with SMTP id s73mr1239168vke.19.1603916973556;
 Wed, 28 Oct 2020 13:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw> <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com> <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
 <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com>
 <20201020204226.GA376497@redhat.com> <CAJfpegsi8UFiYyPrPbQob2x4X7NKSnciEz-a=5YZtFCgY0wL6w@mail.gmail.com>
 <20201021201249.GB442437@redhat.com>
In-Reply-To: <20201021201249.GB442437@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 28 Oct 2020 21:29:22 +0100
Message-ID: <CAJfpegsaLrbJ7bjJVBC3=vLzWZcF+GtTpGjVKYYOE3mjKyuVAw@mail.gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:12 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>

> D. If one does a partial page write of a page which is not uptodate, then
>    keep page locked and do not try to send multiple pages in that write.
>    If page is uptodate, then release page lock and continue to add more
>    pages to same request.
>
> IOW, if head page is partial (and it is not uptodate), we will just
> send first WRITE with head page. Rest of the pages will go in second
> WRITE and tail page could be locked if it was a partial write and
> page was not uptodate. Please have a look at attached patch.

Looks good.

> I still some concerns though with error handling. Not sure what to
> do about it.
>
> 1. What happens if WRITE fails. If we are writing a full page and we
>   already marked it as Uptodate (And not dirty), then we have page
>   cache in page where we wrote data but could not send it to disk
>   (and did not mark dirty as well). So if a user reads the page
>   back it might get cache copy or get old copy from disk (if page
>   cache copy was released).

AFAICS this is what happens on write failure in current code IF the
page was uptodate previously.   Moving the SetPageUptodate() before
the WRITE makes this happen in all cases.

On write failure the page the uptodate flag should be cleared, which
should partially solve the above issue.  There still remains a window
where a concurrent read or load would get the wrong data, but I don't
think anybody cares (same happens with buffered write).

> 2. What happens if it is a partial page write to an Uptodate page
>   in cache and that WRITE fails. Now we have same error scenario
>   as 1. In fact this is true for even current code and not
>   necessarily a new scenario.

Same as above: need to clear uptodate flag.

> 3. Current code marks a page Uptodate upon WRITE completion if
>    it was full page WRITE. What if page was uptodate to begin
>    with and write fails. So current code will not mark it
>    Uptodate but it is already uptodate and we have same problem as 1.

Yes.

> Apart from above, there are some other concerns as well.
>
> So with this patch, if a page is Uptodate we drop lock and send WRITE.
> Otherwise we keep page lock and send WRITE. This should probably be
> fine from read or fault read point of view. Given we are holding inode
> lock, that means write path is not a problem as well. But
>
> What if page is redirtied through a write mapping
> -------------------------------------------------
> If page is redirtied through writable mmap, then two writes for same
> page can go in any order. But in synchronous write we are carrying
> pointer to page cache page, so it probably does not matter. We will
> just write same data twice.

It's not that simple.  Data dirtied through an mmap will be written
back using a temporary page.  So a WRITE request with such a page can
be in flight while a write(2) triggers a synchronous WRITE request for
the same data.  The two WRITEs are not ordered in any way and in fact
the page lock doesn't help, so this is not a new issue.   OTOH this
does not appear to be a problem in real life, since without msync() it
is not guaranteed that the memory mapping is synchronized with the
backing file (Linux has stronger guarantees, but test suites such as
fsx assume the lesser guarantees by POSIX).

This could be fixed to conform to the stronger coherency guarantee by
calling fuse_wait_on_page_writeback() after having gotten a locked
page in the synchronous writeback path.

>
> What about races with direct_IO read
> ------------------------------------
> If a WRITE is in progress, it is probably not marked dirty so
> generic_file_read_iter() will probably not block on
> filemap_write_and_wait_range() and continue mapping->a_ops->direct_IO().
> And that means it can read previous disk data before this WRITE is
> complete.

Synchronous write vs. direct IO read shouldn't be a problem as long as
the server provides a coherent view of the file to both.

Thanks,
Miklos
