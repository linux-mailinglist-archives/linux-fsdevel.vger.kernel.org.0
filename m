Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C1D407467
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 03:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhIKBYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 21:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbhIKBYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 21:24:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC72C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 18:23:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s12so6147896ljg.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4IZXGqyyPS/3gl1bsfFMnsNboMEKQsnCSzncunEclBM=;
        b=jCX9zDMo49nOV3IOfezERHmktfCTBaQmMBv9QK1ta5zGQvukqzL/gDxAxIelisPUT9
         BU5p91qDXyTEypoJxnHJoMqpSZTMd1Gfd/qFrJ3+Hx0G/3Jj4mb9qWgcZLItSTEVxvDM
         fRukEQ9K9oPJKZI+PwlcuAnJ6v/jIZs2MN7ufHRqf7C6g1B1BJRJoWwna8bNsVM8LAGJ
         9dR5JbJamURRO0wJM9Tz5kzHF7zekW19L1Ya6Ymsp+j2wVk6S/zGw8yyJR16qvaKlyd2
         Lk1PfqAixr4bbpyOaS6nKeDJj7Ow7saZ4q30NPJ/pyp/nAaKFriyKN9mbBfJrhIZHgbL
         SPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4IZXGqyyPS/3gl1bsfFMnsNboMEKQsnCSzncunEclBM=;
        b=ptVnE8IXLJkle+HXmAoIoh8woh1kjm0LmFClIYf20c5Xjcv2rWlATkYaPtJ7B3GYa9
         aZJr+ONRxslxZQW3WVhOgkgqtuJukkGodjnIy//VNeGyyP+HTueGcPrw8ApYz2pGZiIE
         VOjJ8EWJfCMh38H/2cNqydFUOZuMvwPEVIGwqlm5G7Zo9RkSTfz4kpon0L58KJ36FGUk
         N0hlm3fFj/LroLfJJXKSYLYfhKowTH0B/37n3lCyahSa+TF0qfbAOJLTB0lx4kxjlLeV
         hJfvLy8FrLVDpDZH2ogkCrlZ+Fo3o1/vgVDvmTBQp9n5zXYDP0kk72OBoq4QqaP6wbuU
         SsDg==
X-Gm-Message-State: AOAM5332Yfl6CqPlXFVHStqb/Q4hiAKKsF8TYSmdTXF/t2wZspnF2isE
        w8utSBm7NXITm83o6cQXy/PVZw==
X-Google-Smtp-Source: ABdhPJxtZY/KCpu89PNzdv+QdbNeRfB7TooMICYo8cBT5ONUxDVhUaQeoToWaG3xicjMUmSINR0udQ==
X-Received: by 2002:a2e:9bc2:: with SMTP id w2mr395498ljj.266.1631323405005;
        Fri, 10 Sep 2021 18:23:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u15sm38657lfk.26.2021.09.10.18.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 18:23:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E7F9A1027D1; Sat, 11 Sep 2021 04:23:24 +0300 (+03)
Date:   Sat, 11 Sep 2021 04:23:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <20210911012324.6vb7tjbxvmpjfhxv@box.shutemov.name>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTu9HIu+wWWvZLxp@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:16:28PM -0400, Kent Overstreet wrote:
> So we should listen to the MM people.

Count me here.

I think the problem with folio is that everybody wants to read in her/his
hopes and dreams into it and gets disappointed when see their somewhat
related problem doesn't get magically fixed with folio.

Folio started as a way to relief pain from dealing with compound pages.
It provides an unified view on base pages and compound pages. That's it.

It is required ground work for wider adoption of compound pages in page
cache. But it also will be useful for anon THP and hugetlb.

Based on adoption rate and resulting code, the new abstraction has nice
downstream effects. It may be suitable for more than it was intended for
initially. That's great.

But if it doesn't solve your problem... well, sorry...

The patchset makes a nice step forward and cuts back on mess I created on
the way to huge-tmpfs.

I would be glad to see the patchset upstream.

-- 
 Kirill A. Shutemov
