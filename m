Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74D35268A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 08:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBGTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 02:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBGTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:19:49 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB493C0613E6;
        Thu,  1 Apr 2021 23:19:47 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y17so3992021ila.6;
        Thu, 01 Apr 2021 23:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44Sen/sBOu6E6dI3+swHBDOOeHMhhOSYmQFra7wWgWM=;
        b=A4p8Q5kjRHDn7T1INRDlx1CA46ppc5lqZ9Y5tR22QbUQE4JmcSLSlTgRavElqkFlPN
         q2VqXolnBSooi3TAnCKxfmdmoeu+IDoWIDyk1qKyvMoAcqTT3maX/YrDW7W/IS3yJvwp
         QkxUoA01apspYrU/jnabqO1W5aDfr+S4jaUwDhfbT5JwrYD9M1pF2bHwKyezTzloLyxO
         OFrqpJ2ugJ6hUC5Nqv7TjX2lcd4mMQD3rnlX8FoA3NtAHoI7JdEIWG6WELjODpSiwsg+
         QlocUunyDDwSHHrVpgI4zBj621hipJDLxF4+pUAvmXTG4mVm99szOgnj4Yf64ENg2Oej
         Cihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44Sen/sBOu6E6dI3+swHBDOOeHMhhOSYmQFra7wWgWM=;
        b=soxWOfQLLNWOxLuPYXjW35KnZhKQNcmq+aaJ3mqt4Hg+sfCeS//uLjJ9ulHafAYZyC
         XsOAzw3xrnAeTN/+nn+43sdQ+Zmcx1HEqz4qRMWhXomJdPIrmwFk9yolRH9jzdlbrO5b
         upRCOhm7s0D8ZneZkHk1kWttCXAKvTy6okfAFVjoVqGBPYTezSxAFScjs/L115lW4UJO
         4520VimBjGsPMgBAAEX5D9pi2JBMfcksZxcC30oUOnNSYTFnJuTzuvO3srhSgYzTN+xr
         v5przxZCvEX3ikrIMr4eOM+QqvrJrSoUHggZxzQ3mlmEdQHhEmF0P4/899HNSnxLqEEN
         IaXA==
X-Gm-Message-State: AOAM533z+SNuddo31JWswXjd6c6mIVRcT2LHdVaLeHXJk0u70LHD/43L
        ySO1KsfK8pgSEOBr9IbkswDEBURA60gp2Xj8ngQ=
X-Google-Smtp-Source: ABdhPJyzJEDKTydXW/A8QNmnZ8I6gAv437PMJVIRUEJjpmVTLK9+HqMwT5rc+FLlIgZfP19axW8IHW9mwXXEe+KHAAk=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr9814763ile.72.1617344387083;
 Thu, 01 Apr 2021 23:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210325032202.GS1719932@casper.infradead.org>
In-Reply-To: <20210325032202.GS1719932@casper.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 2 Apr 2021 09:19:36 +0300
Message-ID: <CAOQ4uxikP_GFNYzgatON2dRQyiHvTBP5iO4Xk091ruLUBDMt-w@mail.gmail.com>
Subject: Re: [RFC] Convert sysv filesystem to use folios exclusively
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 5:43 AM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> I decided to see what a filesystem free from struct page would look
> like.  I chose sysv more-or-less at random; I wanted a relatively simple
> filesystem, but I didn't want a toy.  The advantage of sysv is that the
> maintainer is quite interested in folios ;-)
>
> $ git grep page fs/sysv
> fs/sysv/dir.c:#include <linux/pagemap.h>
> fs/sysv/dir.c:          if (offset_in_page(diter->pos)) {
> fs/sysv/inode.c:        .get_link       = page_get_link,
> fs/sysv/inode.c:        truncate_inode_pages_final(&inode->i_data);
> fs/sysv/itree.c:        block_truncate_page(inode->i_mapping, inode->i_size, get_block);
> fs/sysv/itree.c:                truncate_pagecache(inode, inode->i_size);
> fs/sysv/itree.c:        .readpage = sysv_read_folio,
> fs/sysv/itree.c:        .writepage = sysv_write_folio,

I would like to address only the social engineering aspect of the s/page/folio
conversion.

Personally, as a filesystem developer, I find the concept of the folio
abstraction very useful and I think that the word is short, clear and witty.

But the example above (writepage = sysv_write_folio) just goes to show
how deeply rooted the term 'page' is throughout the kernel and this is
just the tip of the iceberg. There are documents, comments and decades
of using 'page' in our language - those will be very hard to root out.

My first impression from looking at sample patches is that 90% of the churn
does not serve any good purpose and by that, I am referring to the
conversion of local variable names and struct field names s/page/folio.

Those conversions won't add any clarity to subsystems that only need to
deal with the simple page type (i.e. non-tail pages).
The compiler type checks will have already did that job already and changing
the name of the variables does not help in this case.

I think someone already proposed the "boring" name struct page_head as
a replacement for the "cool" name struct folio.

Whether it's page_head, page_ref or what not, anything that can
be written in a way that these sort of "thin" conversions make sense:

-static int sysv_readpage(struct file *file, struct page *page)
+static int sysv_readpage(struct file *file, struct page_head *page)
 {
       return block_read_full_page(page, get_block);
 }

So when a filesystem developer reviews your conversion patch
he goes: "Whatever, if the compiler says this is fine, it's fine".

Thanks,
Amir.
