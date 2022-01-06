Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16C6485F43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 04:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiAFDff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 22:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiAFDff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 22:35:35 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ECDC061245
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 19:35:34 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id d201so3672394ybc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 19:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VhCtBh9G+9Rq3UzhrUmX4qOWZGDQBagUdx1KxmXNCUU=;
        b=Unx7MsOTF3iBIkzcDjUGc/Hwk1xF3imXeLxXvHDk3YAGS/3Q1gvF0MmE2Gz+qlqSKf
         UimyQLdx13fXmvEnS7nvvLDfUXqbqkKPQuyb/StgtYIogr5z2y37q7eN3BK68GOoP7D0
         BQTDY1+UtpFGDwOWQ2Y79VEfk1Po8m3bCB6Qq0RSduk0Bpn4kk0uYvPEpfYe/FMbW+oQ
         yKI14c1UJXhWmMFMLGm/yldfRNvJD3aJaYaDonTthjth8433U+wEco2cmgNjPb1lLk+D
         FU0xnMSpGtIqeZZ2VJbilITNZvItjLMKlMIpid+Xvf+25diKXAEYiFKMoBym3Iwqhcta
         iCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VhCtBh9G+9Rq3UzhrUmX4qOWZGDQBagUdx1KxmXNCUU=;
        b=AZTQFWe+Lvv3+HOgbO79i1P6+udBoyVl4SVZnbBxV5aA0ZbKGbtNkZvyeUFMtPoQF7
         8mvaQy1o4NVjxwlP0yU182YdPmXUD7htZlP68VG1VfyPBf9v9yX49aNbSEf2xHKKYI2T
         n7jch18PZPJs9ZpjfZHfp51fKV7+jcgus/e0fIQOqeWMkwSnhQ0EJdvT5GW5xHOolANp
         aIG3QBtRI3LD9qmc5FQ/kj7vgOWmg4ngP7mKIocEKprfEJVxjnGrAhAbTxGqjYSdzfZD
         IfSwFxcWn38c54gIKPRXgMtD6T0xyR3D4mlPhyCEcaFLLwZJDZLdG1Z9iuIIVLSyA4nA
         SKqg==
X-Gm-Message-State: AOAM533jjmcot6trntspqyWyIvP0PVYAmj9ijzoBS+J2Q1l8V9hsCVx/
        IY2S9nsywGSyoC2CIJrCF5BzW9KY0P/kyRP9Mka/Ng==
X-Google-Smtp-Source: ABdhPJxLB871qfyaC0YcbeoW0XO6II0Pr+i3wgfkb5I1MNAgQRDDpwl/ZkNrhj0iJGor2gwCYyskjboIbezk1yYDgxI=
X-Received: by 2002:a25:3890:: with SMTP id f138mr63404636yba.703.1641440134052;
 Wed, 05 Jan 2022 19:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-14-songmuchun@bytedance.com> <20220105170348.GA21070@blackbody.suse.cz>
In-Reply-To: <20220105170348.GA21070@blackbody.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 6 Jan 2022 11:34:58 +0800
Message-ID: <CAMZfGtWhYOFCKtFoHB7vsKmpEdj9F-axkba6p9EpuPUp3BK-ag@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] mm: memcontrol: reuse memory cgroup ID for kmem ID
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 6, 2022 at 1:03 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Mon, Dec 20, 2021 at 04:56:46PM +0800, Muchun Song <songmuchun@bytedan=
ce.com> wrote:
> > There are two idrs being used by memory cgroup, one is for kmem ID,
> > another is for memory cgroup ID. The maximum ID of both is 64Ki.
> > Both of them can limit the total number of memory cgroups.
> > Actually, we can reuse memory cgroup ID for kmem ID to simplify the
> > code.
>
> An interesting improvement.
>
> I'm a bit dense -- what's the purpose the MEM_CGROUP_ID_DIFF offset?

Hi Michal and Mika,

MEM_CGROUP_ID_DIFF is introduced to be consistent with before
that kmem ID starts with -1 and has no holes. Actually, it can be dropped
and make memcg->kmemcg_id equal to memcg->id.id directly.

> Couldn't this deduplication be extended to only use mem_cgroup.id.id
> instead of mem_cgroup.kmemcg_id? (With a boolean telling whether kmem
> accounting is active.)
>

Not easy to completely remove memcg->kmemcg_id since this filed
will be used to sync list_lru reparenting which will change
memcg->kmemcg_id to its parent's kmem ID (more details refers to
memcg_drain_all_list_lrus() in patch 10 of this series).

Thanks.
