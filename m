Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3873D3FA139
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhH0VmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 17:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhH0VmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:42:12 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F77C0613D9;
        Fri, 27 Aug 2021 14:41:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a15so10474230iot.2;
        Fri, 27 Aug 2021 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZLiKEdmxy2XymDIV79zNDsfKqVBV5SHf0jshhrTnSg=;
        b=UY+h+XuCx+JsjRmG9x4MbhZKnih3FW6xx7c8U2nqe0reS52OXYNkd30F3rgFF2gc8h
         ++hzosS6lZ3I4aJgTlFWy5hgy+agZLOYYo3NR22f0e2XrsGpEeogYxFe0OVz/1k9QrKk
         kq4UHdbCpsSJ7qQgrP4blPM9Ix3BTTn2EleLpPkWcgB5/6io9O3fOAiVR+IVkYGJHOGW
         TDVEy8IqoGyw8+2OAD+MWpJtHPHpHIow7MuQsh3DsM5+FJr5Ue5iim0E0Y8Dn42aw5D7
         Rk1GDVnH9IjUAsB2RJlWlZz/KODQn/fjI46vMkCwRqkAg5G4TMW2rfkR7R0Xw7D54SBz
         smQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZLiKEdmxy2XymDIV79zNDsfKqVBV5SHf0jshhrTnSg=;
        b=T3bK/DLYB3S14PSlY6WuGBLaNsmO2LeHGbX7jgHA3p74h1sObP1+qJiUI7iQXIcLdz
         EqfKeKWOfmrpsQZNYm4Uxva1fYOFBha7LaejDvYQ8mAbIv6BQbHy/tRgE9kPZf0/hIom
         dAV4tbBqNOTUk4Uck70u9H9oK63QO39R0rLaMzTZLwOcDAiIPpH+ECAYo3RLdM/GXDjq
         /7iv2FCgsMDv7SI38IiO7KZwtFgQuqVtQsjj/iMlAXihmXh/Kcj8svR5sN9kRujmpm9+
         RZ5kdGVuSA94qasFRhTk4YWuG8ZcrBNdBFI93pK6yC31LspYq53Ur1c6PTBbi3LAKSQ2
         JxUA==
X-Gm-Message-State: AOAM530fDuSZ7ud+32bzATxxzURw4o/CALUG5TkkdZUNfhk5F/jmzYgk
        X9/IQz2QJHGxhd7eNso+RpQHyrAuTD6By/9sAoI=
X-Google-Smtp-Source: ABdhPJyp4H1blX3LEu8j1s0mTA9EKMgRd2uYuAVN5JE6aTJmk/SpUOZAOkACDtaTD5IPGlE78hMZyI4/e2tq3PKbHQE=
X-Received: by 2002:a6b:6319:: with SMTP id p25mr9282044iog.100.1630100482648;
 Fri, 27 Aug 2021 14:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org> <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org> <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia> <YSjxlNl9jeEX2Yff@cmpxchg.org> <YSkyjcX9Ih816mB9@casper.infradead.org>
In-Reply-To: <YSkyjcX9Ih816mB9@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 27 Aug 2021 14:41:11 -0700
Message-ID: <CAA9_cmeVK9S2e8ECh3dTaNzUgQHC8uo7DBhENgnvoR3s+w-2Mg@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:47 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Aug 27, 2021 at 10:07:16AM -0400, Johannes Weiner wrote:
> > We have the same thoughts in MM and growing memory sizes. The DAX
> > stuff said from the start it won't be built on linear struct page
> > mappings anymore because we expect the memory modules to be too big to
> > manage them with such fine-grained granularity.
>
> Well, I did.  Then I left Intel, and Dan took over.  Now we have a struct
> page for each 4kB of PMEM.  I'm not particularly happy about this change
> of direction.

Page-less DAX left more problems than it solved. Meanwhile,
ZONE_DEVICE has spawned other useful things like peer-to-peer DMA.

I am more encouraged by efforts to make the 'struct page' overhead
disappear, first from Muchun Song for hugetlbfs and recently Joao
Martins for device-dax.  If anything, I think 'struct page' for PMEM /
DAX *strengthens* the case for folios / better mechanisms to reduce
the overhead of tracking 4K pages.
