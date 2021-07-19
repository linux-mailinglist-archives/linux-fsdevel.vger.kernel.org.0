Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA843CDEFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 17:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbhGSPHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345993AbhGSPFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:05:10 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E29C08EC69;
        Mon, 19 Jul 2021 08:03:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p186so20402375iod.13;
        Mon, 19 Jul 2021 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zCoPhFkD+zAaGzAd+PDtfOcHPP03UMo9Xh9adgd6gSw=;
        b=LzM/vCCPOOvtsTmJDetXjpPpvCkinoXeAZ56eEnBCJqG7Q6+GBs8iuAKY9jKLcK0oV
         K7SjG+5D0f9b+1gfCJSbnjQu9CtDrlsz35hOlrFghqwFAtxYJq1ng61rlyWX2fHu/cNM
         VHVnDZxqbdakaU4zDmHkYu9dV0HmrNi6cTsLTLE733AvOKrMgHW4F8WnPmWifumV5xUY
         vIJqd2ehiO2jK6gssfh5UpzMM8Bcu5BAW1ZEAmQLpNEYZO5VWe27NRwuBz/r65O4k1LK
         oUw9eSnyjYr6w7oRovn4n43hMK9syu0t9PMhCl3DGMiw4P7mrumvkdhc9jWJLI9co2Uw
         zKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zCoPhFkD+zAaGzAd+PDtfOcHPP03UMo9Xh9adgd6gSw=;
        b=rZKcsn0D14RuA5N2Dsc65WhYz3WVypKFagT/dWvVZ7QNbjYStlwdv0jlspoLodB0f8
         GAJcQpLUuf2g56Wpe7IRFfhB0I4XTBF9gQugR7iuDkTS277PnIjKNlb6cITj0TurgHwg
         /Z8W+kkgUlBmHFrUwQ0h34TfGAQcBARUb53yTS8gLa4xd7Q9Pf5QqfNEyaJBbcfW5Exy
         /vmtuxsMN2zRQPyrzR9SpNmh2WQwUR5k4h8+wNpqD30b+Q4X4H4H5J8djLPDI1cAiVnw
         D8uOYsMp473U+clbYgqjwsTpVfcMk9I3qhu5jHqWZ/iD3Jt6nYV0x/nW41Os2WTEfhCh
         87Ug==
X-Gm-Message-State: AOAM532ESkLAAekFItYyBCu0zxmG1Ad82uD/CVaEMuXHSM7IeaVVApa/
        7xVxtZqwieVz8s2z2wXJL8WgWaIP3UtoDVVzxwA=
X-Google-Smtp-Source: ABdhPJx1VgtuccRfyVyDs5ZIB0RONKxf+mW64rOLbDsAn5cVTSrT1Z9UhRQSuO9JQnSZV+BXxuzpY510s3RjGEolVRw=
X-Received: by 2002:a5d:928f:: with SMTP id s15mr19005278iom.142.1626708724777;
 Mon, 19 Jul 2021 08:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
 <YPWUBhxhoaEp8Frn@casper.infradead.org> <YPWaUNeV1K13vpGF@B-P7TQMD6M-0146.local>
In-Reply-To: <YPWaUNeV1K13vpGF@B-P7TQMD6M-0146.local>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Mon, 19 Jul 2021 17:31:51 +0200
Message-ID: <CAHpGcM+V+_AxTBwp_eq6R3osH0CMA5N-o8bzBKW3uMsBZY6KWA@mail.gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
To:     Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mo., 19. Juli 2021 um 17:29 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> On Mon, Jul 19, 2021 at 04:02:30PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 19, 2021 at 10:47:47PM +0800, Gao Xiang wrote:
> > > @@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > >     unsigned poff, plen;
> > >     sector_t sector;
> > >
> > > -   if (iomap->type == IOMAP_INLINE) {
> > > -           WARN_ON_ONCE(pos);
> > > -           iomap_read_inline_data(inode, page, iomap);
> > > -           return PAGE_SIZE;
> > > -   }
> > > -
> > > -   /* zero post-eof blocks as the page may be mapped */
> > >     iop = iomap_page_create(inode, page);
> > > +   /* needs to skip some leading uptodated blocks */
> > >     iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> > >     if (plen == 0)
> > >             goto done;
> > >
> > > +   if (iomap->type == IOMAP_INLINE) {
> > > +           iomap_read_inline_data(inode, page, iomap, pos);
> > > +           plen = PAGE_SIZE - poff;
> > > +           goto done;
> > > +   }
> >
> > This is going to break Andreas' case that he just patched to work.
> > GFS2 needs for there to _not_ be an iop for inline data.  That's
> > why I said we need to sort out when to create an iop before moving
> > the IOMAP_INLINE case below the creation of the iop.
>
> I have no idea how it breaks Andreas' case from the previous commit
> message: "
> iomap: Don't create iomap_page objects for inline files
> In iomap_readpage_actor, don't create iop objects for inline inodes.
> Otherwise, iomap_read_inline_data will set PageUptodate without setting
> iop->uptodate, and iomap_page_release will eventually complain.
>
> To prevent this kind of bug from occurring in the future, make sure the
> page doesn't have private data attached in iomap_read_inline_data.
> "
>
> After this patch, iomap_read_inline_data() will set iop->uptodate with
> iomap_set_range_uptodate() rather than set PageUptodate() directly,
> so iomap_page_release won't complain.

Yes, that actually looks fine.

Thanks,
Andreas
