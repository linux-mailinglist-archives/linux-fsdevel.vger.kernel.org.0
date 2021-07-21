Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495643D06B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 04:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhGUBq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 21:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhGUBqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:46:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1923FC061574;
        Tue, 20 Jul 2021 19:27:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a12so931870lfb.7;
        Tue, 20 Jul 2021 19:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IMEA7XUipMCPe6h8ouCsvI5CYO5wKR/xBeSj7gVT1/8=;
        b=ZL2tFxwrvAaDcgkunbrl2DXK4XIAXlxgvsjOXndmxdfQ1aP/4Oi8plfR3O0VsRQxf0
         Kj/IAHQTP8GgfPGfGebET4AOzmA/PyrMGb0D2skqhIVN8ZGr4m7y7dt9dY0HJ1YvZma+
         Hhly9/7QgO4cZ3IYYU0q3ebArfbUXGkcF1T+IssQW79jiLOkRyIDT9kS5wSXpUKIcLOP
         Byz6t0ncf330RJcnL5OoaL7Om/VfFJtU0KXn+O0cZaIzkieo4LWeopnRmZMEB6jodKSn
         iu3uwpNM8RQPwuKkfXg1+0rjQnsUlkA4190PRkHwObJXyUh2DsNWgGSBwbB+MjlFwoBC
         06vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IMEA7XUipMCPe6h8ouCsvI5CYO5wKR/xBeSj7gVT1/8=;
        b=V1dzQlS+OukHfmuQd1JN2gulz7b9maORxqrBjESq3KAtOxftFSf90ZvAx9I6pJykU0
         uDVvtYg8b6YPQOMtePmU1fo2skDmT/Gf9aDfVDk/n0AAZYLvBMjNuZeiZkutqDHtTekC
         9HF9OIiO1GzJgGEHXmlMjnlVwChnzm9AM9UPsWJIDM0L5l7giP+kbETlDRUglktUWYm9
         HUq269IfDnxTZwNa659th4/3AAgzl61VJ3V9oEbc7JJgQd38rLI9sm9D3AkTmBwvgrxu
         p6tJOXzX7+fKnx4qU3K+9Jvylk/7ne6KTtvoBN9p16Bo9U3IeRTyVxT8Zd5UqPIxG2F8
         WoEQ==
X-Gm-Message-State: AOAM530ATuAULtb5IG1Fp8mMcIXaVHp17xwgmrDG9/Ppw2zE/M0unc/P
        hXw8+mdWjoMu3O6nUfn7hyMqJXLFLjgg4C7v9ls=
X-Google-Smtp-Source: ABdhPJy6dCrVihE64G/2FDHlAuzGdom8CulvBOLoo9EPFdwRFwalBwnjn6yQF+6SCWyYI7tIAeVjr0Y7QC+APrGtAFU=
X-Received: by 2002:ac2:5482:: with SMTP id t2mr24222408lfk.135.1626834420374;
 Tue, 20 Jul 2021 19:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia> <YPc9viRAKm6cf2Ey@casper.infradead.org>
 <YPdkYFSjFHDOU4AV@B-P7TQMD6M-0146.local> <20210721001720.GS22357@magnolia> <YPdrSN6Vso98bLzB@B-P7TQMD6M-0146.local>
In-Reply-To: <YPdrSN6Vso98bLzB@B-P7TQMD6M-0146.local>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 21 Jul 2021 04:26:47 +0200
Message-ID: <CAHpGcM+8cp81=bkzFf3sZfKREM9VbXfePpXrswNJOLVcwEnK7A@mail.gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 21. Juli 2021 um 02:33 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> > And since you can only kmap one page at a time, an inline read grabs the
> > first part of the data in "page one" and then we have to call
> > iomap_begin a second time get a new address so that we can read the rest
> > from "page two"?
>
> Nope, currently EROFS inline data won't cross page like this.
>
> But in principle, yes, I don't want to limit it to the current
> EROFS or gfs2 usage. I think we could make this iomap function
> more generally (I mean, I'd like to make the INLINE extent
> functionity as general as possible,

Nono. Can we please limit this patch what we actually need right now,
and worry about extending it later?

> my v1 original approach
> in principle can support any inline extent in the middle of
> file rather than just tail blocks, but zeroing out post-EOF
> needs another iteration) and I don't see it add more code and
> complexity.

Thanks,
Andreas
