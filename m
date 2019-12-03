Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0110F466
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 02:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLCBN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 20:13:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37777 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLCBN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:13:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so1463343lfc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 17:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f16wPMX3Hv5+5LpFCWWiK7eqWkk4a1TMh+b2JYuh2L4=;
        b=KquqAkqUVTyG83FELzXx6nZWqrQom0qPebBeM3l4nUnY0IjRxfw5jl9f4rhB4P0Ys1
         yMMjUqHh9Atftq9/aMH7vPLqvTYv5hjkMQeepjJof4arWmddxk+x0kYqi0oEsm1gm01r
         c0+/cFEMdOFDQe0735Al7ThhTziCMU1XmN/7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f16wPMX3Hv5+5LpFCWWiK7eqWkk4a1TMh+b2JYuh2L4=;
        b=F4bQ9dyHtN5RH3qkBqbTkJGJWxwNE+6vyCcVHWqRrPbq+nvz6ttCHWrfGjB1iUNzUA
         J9a5f0KI8nl6mEGJCyEvSgYhh6GMVzEpdS/HwkoZD4hv2F4/WBhVCTvnzmd6I8eTPp1l
         fN7tRr8E7scTBHm0uWbxwK86wignOQeifaqayNSV22YFussPasgcdSR1KvUlUAS1aid+
         ME+JhuE3JILoIGHbo8zyZJ7Wk6sMgWe8phjskT7Yp6cJ++mIZhe+9KZIfY7mKBiLyhBR
         YPDANO5uxS4bhsnhKzngICwyY/znxbAQvWYGuCA/awWyDNzTPIf8RXxWvx/uH+9KQqwY
         rw1A==
X-Gm-Message-State: APjAAAVwSbJobjHRLJS1BuuSaKVxTL04oz7IIeD785CcTZ9pvGctJu//
        0A+yrx+kvixkk9lUiR+n7y5SREnapd8=
X-Google-Smtp-Source: APXvYqx/q3iKnvCLCv9kJEK6XrBBX6FGlJIrNcevWjCoAORTkDnhYmvwLDhjOe+rxnFz05hITkukUg==
X-Received: by 2002:ac2:53a8:: with SMTP id j8mr1048960lfh.163.1575335604696;
        Mon, 02 Dec 2019 17:13:24 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i19sm486173ljj.24.2019.12.02.17.13.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 17:13:24 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id e28so1714948ljo.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 17:13:24 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr889870ljj.97.1575335193641;
 Mon, 02 Dec 2019 17:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20191129142045.7215-1-agruenba@redhat.com>
In-Reply-To: <20191129142045.7215-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Dec 2019 17:06:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5caXKoukPyM7Zc6A0Q+E-pBGHSV64iZe8t98OerXR_w@mail.gmail.com>
Message-ID: <CAHk-=wj5caXKoukPyM7Zc6A0Q+E-pBGHSV64iZe8t98OerXR_w@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Fix page_mkwrite off-by-one errors
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
        ceph-devel@vger.kernel.org,
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

On Fri, Nov 29, 2019 at 6:21 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> +/**
> + * page_mkwrite_check_truncate - check if page was truncated
> + * @page: the page to check
> + * @inode: the inode to check the page against
> + *
> + * Returns the number of bytes in the page up to EOF,
> + * or -EFAULT if the page was truncated.
> + */
> +static inline int page_mkwrite_check_truncate(struct page *page,
> +                                             struct inode *inode)
> +{
> +       loff_t size = i_size_read(inode);
> +       pgoff_t end_index = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;

This special end_index calculation seems to be redundant.

You later want "size >> PAGE_SHIFT" for another test, and that's
actually the important part.

The "+ PAGE_SIZE - 1" case is purely to handle the "AT the page
boundary is special" case, but since you have to calculate
"offset_in_page(size)" anyway, that's entirely redundant - the answer
is part of that.

So I think it would be better to write the logic as

        loff_t size = i_size_read(inode);
        pgoff_t index = size >> PAGE_SHIFT;
        int offset = offset_in_page(size);

        if (page->mapping != inode->i_mapping)
                return -EFAULT;

        /* Page is wholly past the EOF page */
        if (page->index > index)
                return -EFAULT;
        /* page is wholly inside EOF */
        if (page->index < index)
                return PAGE_SIZE;
        /* bytes in a page? If 0, it's past EOF */
        return offset ? offset : -PAGE_SIZE;

instead. That avoids the unnecessary "round up" part, and simply uses
the same EOF index for everything.

              Linus
