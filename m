Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538A429DA71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 00:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390291AbgJ1XXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 19:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390215AbgJ1XW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:22:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB9C0613CF;
        Wed, 28 Oct 2020 16:22:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so731707pfa.10;
        Wed, 28 Oct 2020 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGhTX+QoKKIYbk2DtoD0kZCPq/4dwaRTmF09BFXOKRg=;
        b=UwpwHOAIrOUZ3VsldkGy9LlB9HRl97EOhvjHuUua4zqFTAEsyBHubxirHKz9lUNJ1i
         PlWRBdnv849Mr2rG9Qk53+ooQ0m5c9A7PAbFZxhe88L3RQYklHtFgdCT56LyWnh36qBS
         K5r1ctyINrpp5brPvXhavtQnG7ndISohEcFftKy6rDiyZwFtMzqN5EkSEBz4ey+JBXW+
         /nBRfheIakDqZIlQjPdbAFYdAwFTB4wV4v+jA8yBEXjI9eaSjXPRK18cLZ2XsDWhTGin
         b3T97jXkz+jdwzn/2/wQj/9UOv8O0qZAarEZdDeLeAWeGv5jet8rCPTFFJQ26T/e7m7D
         VZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGhTX+QoKKIYbk2DtoD0kZCPq/4dwaRTmF09BFXOKRg=;
        b=XmLrpUe5hD2QTu/8yVluXRnX94kDwvKrZsMp/yvTAsh2aLwTAeoZvYeth26tySibLQ
         FDr73jlNbHU7nJK1UElTqxrvs7hl/RXtelKgra7DaCW9riMnh/eKNSzCJJ5ijyK76Kzj
         iBvAYNDCszJXbuzqcWBd4GirQtKzCLg1V+i/Iuos7s7Wuwa7/b3g0VyBnRpUNBFn6Jtl
         oUgVfNZ1i7SNbVn7XAynKEJMp8tWPJo+uZqVjya5ZhBMNMEoNzOZh86Jvt1D1FWn7b+m
         zgF0e/kgnZO027PP0/mufEQgPgQHVLBGvDq4+8AYMVCJpnlf5a2ddv9AeZW75B/HA4y8
         +MKQ==
X-Gm-Message-State: AOAM530nuSP/ptOP/QtNQFUJ+7P2wYa69Mppi/DkjSVfr6/dd//k7oxa
        adIpNiThBJtst9SrHYGn+AhJXss+u9w96IQX5RleDAXs7ink0A==
X-Google-Smtp-Source: ABdhPJzlFcb2JynAI0WXnNEGu7JRacOWUNzqnje/fCwil96Oqvd9bDTj47PizXdk6M4wAbt43M3EvnLeJ7HNwHBG+8E=
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr1252324pjb.228.1603927345933;
 Wed, 28 Oct 2020 16:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201026155730.542020-1-tasleson@redhat.com> <CAHp75Vfno9LULSfvwYA+4bEz4kW1Z7c=65HTy-O0fgLrzVA24g@mail.gmail.com>
 <71148b03-d880-8113-bd91-25dadef777c7@redhat.com> <ec93ba9e-ead9-f49a-d569-abf4c06a60eb@redhat.com>
In-Reply-To: <ec93ba9e-ead9-f49a-d569-abf4c06a60eb@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 01:22:09 +0200
Message-ID: <CAHp75VfngLah7nkARydc-BAivtyCQbHhcEGFLHLRHpXFSE_PwQ@mail.gmail.com>
Subject: Re: [PATCH] buffer_io_error: Use dev_err_ratelimited
To:     Tony Asleson <tasleson@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 11:05 PM Tony Asleson <tasleson@redhat.com> wrote:
> On 10/28/20 3:45 PM, Tony Asleson wrote:
> > On 10/26/20 5:07 PM, Andy Shevchenko wrote:
>
> >>> +       dev_err_ratelimited(gendev,
> >>> +               "Buffer I/O error, logical block %llu%s\n",
> >>
> >>> +               (unsigned long long)bh->b_blocknr, msg);
> >>
> >> It's a u64 always (via sector_t), do we really need a casting?
> >
> > That's a good question, grepping around shows *many* instances of this
> > being done.  I do agree that this doesn't seem to be needed, but maybe
> > there is a reason why it's done?
>
> According to this:
>
> https://www.kernel.org/doc/html/v5.9/core-api/printk-formats.html
>
> This should be left as it is, because 'sector_t' is dependent on a
> config option.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/types.h?id=72deb455b5ec619ff043c30bc90025aa3de3cdda

Staled documentation. You may send a patch to fix it (I Cc'ed
Christoph and Jonathan).
It means that it doesn't go under this category and the example should
be changed to something else.


-- 
With Best Regards,
Andy Shevchenko
