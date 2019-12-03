Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5510F4B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 02:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCBw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 20:52:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33967 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLCBw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:52:26 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so1859356iof.1;
        Mon, 02 Dec 2019 17:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxhmjFxB0fSH7WF0Z6dyOJrwDyDBweaa0/5KnNO4AIw=;
        b=Xah07E77EL/ykU6H/9fOr3zX6G7oIlWdMl7pW0DtOY4vE5v7mHQywBuRicQbOxpksI
         oVlMR+lFoPd7LKC19a9HB2/wy/+jDp1nqd76VCZFCXYDbcb0C0lFjdfWx07BFtI61NyQ
         ULUpd+qRbkc1lNFMKvsoL6LpvtelvqGIpA+TiKw+pssj6AYPYx8QilsR5BTdNjSgzXV4
         TzOcqVnnTq03A9VJMHGxKZI9llFscQefkxFMrIAIJ8purFDg+fn3Sgw7mITq1bI0VNc4
         ggGt0dKL3T+x/JX3njY7HBts2xJIycvxD925/sF8Btt8swkgBaabvykwCkAgzw+wuURe
         7mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxhmjFxB0fSH7WF0Z6dyOJrwDyDBweaa0/5KnNO4AIw=;
        b=hU6FQJAWDthk/buOxzAm/mmxDjZ12pcNOatoFfO1OFMXT4sRKOU5BiLmjzDrpptUhi
         HIzseY1+gdmSy1NdmtVooRUYFfX4QRPKMNhK7Xi5H4JMufM8AeHTvMyu1/Qfcxa0qxUq
         Cr4zOyPyjQ9g2b7FPlk5t8sUn3b7TYAadjMBzhukwDJojB6tjLNwC81r5v0XFaa84uje
         nMHZJVc7ReqOxsUitYgrjwdLmvAXN0SaiFlsdKGfWwPd5KUJ1ZY21BoH0a7mbUhZmF5E
         ypHBHvP+lkTI2qoYTAarcHhelx4xGuR3IKTuEPfOSKzvL4+4JXyr01mtaFojCEhk4zL3
         6k3A==
X-Gm-Message-State: APjAAAXp4RK/6DGAd1ivw/hL1rRWrV89kMpM25mPaUzgVatIQBdz4MQJ
        Qz1wpl1hQsMCGbnAMxADpiDnc5+8UKUrtQesH7U=
X-Google-Smtp-Source: APXvYqz/HtSAKmFvtGA3vewcbEqy6GpkXcTpGWeY7zvzD8UPDmBHZYqWa5qgMjPw9AT+xjcV03w5DfEQU74871jze0c=
X-Received: by 2002:a02:a915:: with SMTP id n21mr3314772jam.117.1575337945183;
 Mon, 02 Dec 2019 17:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20191129142045.7215-1-agruenba@redhat.com> <CAHk-=wj5caXKoukPyM7Zc6A0Q+E-pBGHSV64iZe8t98OerXR_w@mail.gmail.com>
In-Reply-To: <CAHk-=wj5caXKoukPyM7Zc6A0Q+E-pBGHSV64iZe8t98OerXR_w@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 3 Dec 2019 02:52:13 +0100
Message-ID: <CAHpGcMLe2Qy=RdcyFPav5Rfto9M4S9VdsX6E=b3FEywtUNQdqg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Fix page_mkwrite off-by-one errors
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 3. Dez. 2019 um 02:09 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:
>
> On Fri, Nov 29, 2019 at 6:21 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > +/**
> > + * page_mkwrite_check_truncate - check if page was truncated
> > + * @page: the page to check
> > + * @inode: the inode to check the page against
> > + *
> > + * Returns the number of bytes in the page up to EOF,
> > + * or -EFAULT if the page was truncated.
> > + */
> > +static inline int page_mkwrite_check_truncate(struct page *page,
> > +                                             struct inode *inode)
> > +{
> > +       loff_t size = i_size_read(inode);
> > +       pgoff_t end_index = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>
> This special end_index calculation seems to be redundant.
>
> You later want "size >> PAGE_SHIFT" for another test, and that's
> actually the important part.
>
> The "+ PAGE_SIZE - 1" case is purely to handle the "AT the page
> boundary is special" case, but since you have to calculate
> "offset_in_page(size)" anyway, that's entirely redundant - the answer
> is part of that.
>
> So I think it would be better to write the logic as
>
>         loff_t size = i_size_read(inode);
>         pgoff_t index = size >> PAGE_SHIFT;
>         int offset = offset_in_page(size);
>
>         if (page->mapping != inode->i_mapping)
>                 return -EFAULT;
>
>         /* Page is wholly past the EOF page */
>         if (page->index > index)
>                 return -EFAULT;
>         /* page is wholly inside EOF */
>         if (page->index < index)
>                 return PAGE_SIZE;
>         /* bytes in a page? If 0, it's past EOF */
>         return offset ? offset : -PAGE_SIZE;
>
> instead. That avoids the unnecessary "round up" part, and simply uses
> the same EOF index for everything.

And if we rearrange things slightly, we end up with:

        /* page is wholly inside EOF */
        if (page->index < index)
                return PAGE_SIZE;
        /* page is wholly past EOF */
        if (page->index > index || !offset)
                return -EFAULT;
        /* page is partially inside EOF */
        return offset;

Thanks,
Andreas
