Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAEA3D08F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhGUFyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 01:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhGUFyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:54:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9826CC0613DD;
        Tue, 20 Jul 2021 23:33:44 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u14so1647673ljh.0;
        Tue, 20 Jul 2021 23:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgZ3yjomTzlMCFEBY2QOLzdcWRgyC4eVhW9WC+FWjOI=;
        b=tQ8qIzLK6bqfVALG6GEQIfaZ1m2r/Tt4OX9AAorqyfmfoAwESt4rRHHYH0nAgWXreX
         E2KEoOx7x+Rhh2FpIqFlWiShWxY4PF6BxxXHhR9FWt5NADi5LtM0j7RSYef6HUAWrQ0A
         yAUdS0e4zRfrVDi97stCd4s35iRLaQriRr4i6hBE3DRw0TTgVFYLqnitHUsAIgjpJo6d
         aYobLw59ffWcESJoaSaBgyc7RfHLWj11PRqyhEXU/trsyv9lY2wSEzmPraBWS65tsnAR
         V9L+Ayhxlw/BOSY1QCg5YVU4EQKvYx8vtXYW0PiySFH21XLCgRlI/6hDVYtOS1uB8NyO
         KktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgZ3yjomTzlMCFEBY2QOLzdcWRgyC4eVhW9WC+FWjOI=;
        b=jKVc7tHngy9DBb9sS6qgspAMuv3uZPZvR4NxtBO2SOBcn29ubRBXwlToxK47KcBpYs
         KziNZq2xymjZlszcl70AlgMZv0Q+jyiOvpzmwGnpSQ0F6+qNekmUEc+XYCwLi5xA+3bP
         nChF4dnADXbkG1xwlk+aORUv0zQIwVxAMz6w9J8P0+SGK2D++RBDoH+2unMGPVrNlFLl
         LqI0fx0qoQvp3OnXiHHuPpcdyPaQ1fOhKqEBAufG1cJesuragI5lOQg6MD+R3Z7kwyRx
         /EhVcRAm5FpKO3AbYiQnxAgS95p1COKiKoF5HUC9g9Fzxct2PggtuElFNECpXlJLKnFd
         Ee/A==
X-Gm-Message-State: AOAM533tHVddIycFDvFizFe+RwrRagjJL6944RcPCm5m4x9Axu5MJZrT
        ehu8LNLNqdK5DuZPrLf5bIEod0ISGR6hjczH0BY=
X-Google-Smtp-Source: ABdhPJy8FqL1N/64ODDDPq+8rZqX7KUcnsar0gsoAGKviKNVxsjmkj4HPXdXyveyZFbgQ4idXyq8IYk94UXyBJ7iC28=
X-Received: by 2002:a2e:a5c6:: with SMTP id n6mr29681111ljp.204.1626849222792;
 Tue, 20 Jul 2021 23:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia> <YPc9viRAKm6cf2Ey@casper.infradead.org>
In-Reply-To: <YPc9viRAKm6cf2Ey@casper.infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 21 Jul 2021 08:33:30 +0200
Message-ID: <CAHpGcMJ-E5LYz1E7Qf9=LQES=jB0V-Pjq1rSg=7GxXwJ1mh2Gw@mail.gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 20. Juli 2021 um 23:19 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
> On Tue, Jul 20, 2021 at 01:42:24PM -0700, Darrick J. Wong wrote:
> > > -   BUG_ON(page_has_private(page));
> > > -   BUG_ON(page->index);
> > > -   BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > > +   /* inline source data must be inside a single page */
> > > +   BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> >
> > Can we reduce the strength of these checks to a warning and an -EIO
> > return?

Yes, we could do that.

> I'm not entirely sure that we need this check, tbh.

I wanted to make sure the memcpy / memset won't corrupt random kernel
memory when the filesystem gets the iomap_begin wrong.

> > > +   /* handle tail-packing blocks cross the current page into the next */
> > > +   size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> > > +                PAGE_SIZE - poff);
> > >
> > >     addr = kmap_atomic(page);
> > > -   memcpy(addr, iomap->inline_data, size);
> > > -   memset(addr + size, 0, PAGE_SIZE - size);
> > > +   memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > > +   memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> >
> > Hmm, so I guess the point of this is to support reading data from a
> > tail-packing block, where each file gets some arbitrary byte range
> > within the tp-block, and the range isn't aligned to an fs block?  Hence
> > you have to use the inline data code to read the relevant bytes and copy
> > them into the pagecache?
>
> I think there are two distinct cases for IOMAP_INLINE.  One is
> where the tail of the file is literally embedded into the inode.
> Like ext4 fast symbolic links.  Taking the ext4 i_blocks layout
> as an example, you could have a 4kB block stored in i_block[0]
> and then store bytes 4096-4151 in i_block[1-14] (although reading
> https://www.kernel.org/doc/html/latest/filesystems/ext4/dynamic.html
> makes me think that ext4 only supports storing 0-59 in the i_blocks;
> it doesn't support 0-4095 in i_block[0] and then 4096-4151 in i_blocks)
>
> The other is what I think erofs is doing where, for example, you'd
> specify in i_block[1] the block which contains the tail and then in
> i_block[2] what offset of the block the tail starts at.

Andreas
