Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD57E372220
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 22:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhECU5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhECU5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 16:57:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0184EC061573;
        Mon,  3 May 2021 13:56:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so5229924pfn.6;
        Mon, 03 May 2021 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ISb0cEJn/7F/3TtJvKP0v8My0FRJZ8xOdzR0+u3IDM=;
        b=X2LYPV03KJa0WiKUvHzZlq3gX2IE/ZN7fdXCeAD02mn89dv1MGa4ep7OxQNBNt5K1f
         k6PSETcSSjB7MNd3AsgXFjAlS8HOGz5cT99RfA4kdLhTg5uajfK6XIN9XEcAiOM+KuUK
         IcXCp7Oh/hXCrxghVxk/TzRQ4rpUxcSzmnzzOzRyjJW6kGLfFjLt0ClCu7otNgTVgzaz
         NF+R9yAyqDpC1VVOUjbdNkJVjef7TqsOqq/altSzWOXRYvXIBhTfj6IzfypYGcjx9uOL
         n+DDE6Zxm4BeJavH6cz9xTstMN18pPsvYB8bwCiXMZNJwdXzVM/Jk8bwX/l+OYUuB2FT
         2DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ISb0cEJn/7F/3TtJvKP0v8My0FRJZ8xOdzR0+u3IDM=;
        b=HFbnBHyf262Cj+kbqK7m2Ytt3EvcCKTzofUWMfQKM9LvoC9Oz2i8Q9VlTocnSrnEjK
         kpjX9f2yrmTw9DmvGHIokun9JWC2rtPPCyRjDxfwkZWIlNyX7X8T1gt7EXrMXjxmYV8o
         zTNzoMgnMlQM+RRH953JlhfFkXSQE0VU5SJ+UW1sMJ7/0EFUi3ZwwPmxZXMtEghlMSlA
         heS3nWMDezz1PSEHg3GXdeieNBR3uEHokS4JcLEItbVMltyQg2bsYwlVCyGVAGlvVIPd
         TG0Gac6Ir+Qf8qkN4H2S+v20leFP2LfZOPxGsw5MME94CghYupNdptt/ISvJxwTigTyt
         /8fQ==
X-Gm-Message-State: AOAM532vzPx4xCh6uTxODufE/HLKceIT0Zq9y39gh8ULVGqp+tgI8jcf
        3gFZNmJyze4W+BAVcrgjYjvVu3PnIjAe3d59zis=
X-Google-Smtp-Source: ABdhPJyMelyHs+7yuYWU+8MljvJSGL/BqBE7f0QdUrabwR/X1bc+pXnifT/5HvsfM/WzFoniSpOlvb1tJCAHhrbZRoE=
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr629996pjv.129.1620075417477;
 Mon, 03 May 2021 13:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
 <20210503204907.34013-11-andriy.shevchenko@linux.intel.com> <YJBi5NU2WmZPYbBG@zeniv-ca.linux.org.uk>
In-Reply-To: <YJBi5NU2WmZPYbBG@zeniv-ca.linux.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 May 2021 23:56:41 +0300
Message-ID: <CAHp75VfZKX_oYzoAA9Mbya1_+hP6+1mDKqyfy9d=hsokEAGQsQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] nfsd: Avoid non-flexible API in seq_quote_mem()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 3, 2021 at 11:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 03, 2021 at 11:49:05PM +0300, Andy Shevchenko wrote:
> > string_escape_mem_ascii() followed by seq_escape_mem_ascii() is completely
> > non-flexible and shouldn't be exist from day 1.
> >
> > Replace it with properly called string_escape_mem().
>
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
>
> Reason: use of seq_get_buf().  Which should have been static inline in
> fs/seq_file.c, to start with.

I see.

> Again, any new uses of seq_get_buf()/seq_commit() are grounds for automatic
> NAK.  These interfaces *will* be withdrawn.

You meant that this is no way to get rid of this guy?
Any suggestions how to replace that API with a newer one?


-- 
With Best Regards,
Andy Shevchenko
