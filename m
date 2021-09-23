Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52939416897
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243381AbhIWXug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 19:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhIWXue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 19:50:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15867C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 16:49:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id e16so5307438qts.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HAmJkHQDJJuagQxHQwV8veFd6rRsJ19PYDz/eTz1rB4=;
        b=K14UTK5w94Mq7Y7d0WepqQG3vE1pbUyxcPERyofOaaiyIVHxbYyK8CI3+1lVRKwB0g
         UGxogD+nvTWvrZQxq/FLDZ6pHz3qeBwZrqjFVAaElpacm1PBmVp4mepBXiWOr0KLSr0F
         7JnWgQzbHfZJLJ6PjzcnIPJBq3MvzmnViyCCEKTVeT6dKhEXNkeosQ+TQYcWcrs+YvcJ
         9vT+vOuW8zPALzddhzo4Ap+JWxJf42oQOtPTZSz1tqd4GHEfzK2J1n9TD2I/fu+4Ja8D
         9FOg9+FIrgexLSYC7Hj+LAlJ74Zbhod48eyXJrVO5YIftatm4yzHbPA2//17GLe94VsH
         UOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HAmJkHQDJJuagQxHQwV8veFd6rRsJ19PYDz/eTz1rB4=;
        b=w5+KUFh/pfuHC3IJ+NwtBV5GRCRSYWwhZkmGenmeWcMSDz2YD3HwhZVL+p2354nvLx
         FWT2Wb/4FtIE5xkg/xT9/99BK5D5yYw6YOYB/ewpCNXfEh+ZseK5H8uTQDojnswI+sTg
         ZU303dqV4ASAyuwARpJ7anl3eDo8MPILeGpQZYCMeUZmbxRaYlzoyXuSqvr9nabjBdMw
         eWdD7KHzcQrV/TxhbibLgGl74by7PW0pRiEAcD+GwOSGoUKSrPvSJt/bP6eO5gxFL+QM
         qUfFaibyVMa23Sagki1qF/mbcjYFuZ7I7c0I3Eo95ynvxOlpdszTvqeogcGDPgc4Uma4
         n5AQ==
X-Gm-Message-State: AOAM533Pd+PJj7bk1Ud7pcgAX5CtH+oje/fGKJvdJkCZ+640ysTY51cL
        1rVzc6ffX3HQWGVysp3oxUn8BQ==
X-Google-Smtp-Source: ABdhPJyx4r0Ikvv2wOuAIuqSR2EMgA05qTmirNIFyEVLKHf+GXDLUUM3y7l0TeXUlNB2314011zgvQ==
X-Received: by 2002:a05:622a:1792:: with SMTP id s18mr1465593qtk.136.1632440940819;
        Thu, 23 Sep 2021 16:49:00 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q14sm5171666qkl.44.2021.09.23.16.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:48:58 -0700 (PDT)
Date:   Thu, 23 Sep 2021 16:48:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Zi Yan <ziy@nvidia.com>
cc:     Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: Mapcount of subpages
In-Reply-To: <2A311B26-8B33-458E-B2C1-8BA2CF3484AA@nvidia.com>
Message-ID: <77b59314-5593-1a2e-293c-b66e8235ad@google.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <YUvzINep9m7G0ust@casper.infradead.org> <YUwNZFPGDj4Pkspx@moria.home.lan> <YUxnnq7uFBAtJ3rT@casper.infradead.org> <20210923124502.nxfdaoiov4sysed4@box.shutemov.name> <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
 <CAHbLzkrELUKR2saOkA9_EeAyZwdboSq0HN6rhmCg2qxwSjdzbg@mail.gmail.com> <2A311B26-8B33-458E-B2C1-8BA2CF3484AA@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Sep 2021, Zi Yan wrote:
> On 23 Sep 2021, at 17:54, Yang Shi wrote:
> > On Thu, Sep 23, 2021 at 2:10 PM Hugh Dickins <hughd@google.com> wrote:
> >>
> >> NR_FILE_MAPPED being used for /proc/meminfo's "Mapped:" and a couple
> >> of other such stats files, and for a reclaim heuristic in mm/vmscan.c.
> >>
> >> Allow ourselves more slack in NR_FILE_MAPPED accounting (either count
> >> each pte as if it mapped the whole THP, or don't count a THP's ptes
> >> at all - you opted for the latter in the "Mlocked:" accounting),
> >> and I suspect subpage _mapcount could be abandoned.
> >
> > AFAIK, partial THP unmap may need the _mapcount information of every
> > subpage otherwise the deferred split can't know what subpages could be
> > freed.

I believe Yang Shi is right insofar as the decision on whether it's worth
queuing for deferred split is being done based on those subpage _mapcounts.
That is a use I had not considered, and I've given no thought to how
important or not it is.

> 
> Could we just scan page tables of a THP during deferred split process
> instead? Deferred split is a slow path already, so maybe it can afford
> the extra work.

But unless I misunderstand, actually carrying out the deferred split
already unmaps, uses migration entries, and remaps the remaining ptes:
needing no help from subpage _mapcounts to do those, and free the rest.

Hugh
