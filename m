Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D822332D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgG3NRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3NR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:17:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F368C0619D5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2020 06:17:26 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h1so19995655otq.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2020 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l6NNuTlAlb+T71eovQReK+men4boXEXZJmc745e1mek=;
        b=Tj45p5a06zkqFl6bUdtEmCxMS67sh1pLfLaP0MJK1JKsob6GFGtCQSeLESCL2s30Bo
         ou0Hr4WM+OKrYig/4okfOklio8NyYxv+hqW65aWlMC+/KH2ReSdB2qWfNUvAmIpCL5GB
         NCD+kQkkx7Q/TROpmA3URVMeplfnD5XbvU6DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l6NNuTlAlb+T71eovQReK+men4boXEXZJmc745e1mek=;
        b=Z8UM1ocRltpKUBbo90eKBpw/7jd6bb4424BRQwSdIBSa8lTCUmJubAmIKKTK81B3/p
         20rmhSTrc6dXc1NG6FrvfLhgK/qQDBsyiv3SWYX9StBppz7nmqFBn86FEkBCksiDMAkr
         ldihOoi9y2x8QL1ljPGWtsp7OA9KE659jS69xgvS/F6T1ELIX4+FVNRBwx5H5ooMcjKn
         3/qFhV3R5Q27Ed0pmgcIq9TJDsAP9fsNHLOow7otxair6k9KFcdpfwsJIhVMh44qY7Ge
         WDZ4O8YRcHXN2pC/qA7G3jeM1uHguYGyCfheX5oSfHAswMNGDRLqAVwBoJfu3QG4jMth
         U5jg==
X-Gm-Message-State: AOAM532SPAuBoaiqkJ0qASFYj99B68EsiL+0zjq7w7eAlu47Jic0bw2d
        idKrOrJ9I9+TzeEpG1mW6nGkfT9GTfgYXN9zq9K8Og==
X-Google-Smtp-Source: ABdhPJyT+P5EKFUT/rekKMDvcsT0JZ6B1aXbsvpwMmAI2gySdtJl4PHRq6e+n9dVUTuKG5DRk4IoPKAkcy7FpSExRU8=
X-Received: by 2002:a9d:6052:: with SMTP id v18mr2134622otj.303.1596115045756;
 Thu, 30 Jul 2020 06:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200728135839.1035515-1-daniel.vetter@ffwll.ch> <38cbc4fb-3a88-47c4-2d6c-4d90f9be42e7@shipmail.org>
In-Reply-To: <38cbc4fb-3a88-47c4-2d6c-4d90f9be42e7@shipmail.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 30 Jul 2020 15:17:14 +0200
Message-ID: <CAKMK7uFe-70DE5qOBJ6FwD8d_A0yZt+h5bCqA=e9QtYE1qwASQ@mail.gmail.com>
Subject: Re: [PATCH] dma-resv: lockdep-prime address_space->i_mmap_rwsem for dma-resv
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 2:17 PM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
>
> On 7/28/20 3:58 PM, Daniel Vetter wrote:
> > GPU drivers need this in their shrinkers, to be able to throw out
> > mmap'ed buffers. Note that we also need dma_resv_lock in shrinkers,
> > but that loop is resolved by trylocking in shrinkers.
> >
> > So full hierarchy is now (ignore some of the other branches we already
> > have primed):
> >
> > mmap_read_lock -> dma_resv -> shrinkers -> i_mmap_lock_write
> >
> > I hope that's not inconsistent with anything mm or fs does, adding
> > relevant people.
> >
> Looks OK to me. The mapping_dirty_helpers run under the i_mmap_lock, but
> don't allocate any memory AFAICT.
>
> Since huge page-table-entry splitting may happen under the i_mmap_lock
> from unmap_mapping_range() it might be worth figuring out how new page
> directory pages are allocated, though.

ofc I'm not an mm expert at all, but I did try to scroll through all
i_mmap_lock_write/read callers. Found the following:

- kernel/events/uprobes.c in build_map_info:

            /*
             * Needs GFP_NOWAIT to avoid i_mmap_rwsem recursion through
             * reclaim. This is optimistic, no harm done if it fails.
             */

- I got lost in the hugetlb.c code and couldn't convince myself it's
not allocating page directories at various levels with something else
than GFP_KERNEL.

So looks like the recursion is clearly there and known, but the
hugepage code is too complex and flying over my head.
-Daniel

>
> /Thomas
>
>
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
