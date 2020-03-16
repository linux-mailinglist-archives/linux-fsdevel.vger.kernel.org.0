Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CEE18616B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 02:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgCPBt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 21:49:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43933 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgCPBt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:49:27 -0400
Received: by mail-io1-f65.google.com with SMTP id n21so15478312ioo.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2020 18:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoq2dm2wMdYmvERBny9tE6W3gD6b5KdDrVUkIqFMrbk=;
        b=Anh/jF7OcNxqH4rjeyCa4ugaeVhHAk1PRwDAFHIDH87cC7icS4Rn5glt3z4HIV7z1p
         sopw9Y9rvRapYILcvn8hq/10UEfcMqBryRSpfYlpRwKl2WaSvvB2/uElI2xkI5pklANR
         KFtkr62yG/Pm7zOFMa0cWMV9YhkdzVGD/BNA7KZFVzRX0+A0S61FsmYb1BAjqxQY5FqJ
         wycmJ4pqctxLUNeHwwHCdRsuDT9ZpQyzW0nSDmiTfkSpZ8/WlUj1KftmaRDF7gVuLrad
         3RgeWTHHR2xqbhdOKuwWmkmVtQr0hBKAqoiSS1+2G3Bdbg55Oz5MCHBVUct+L600MgkL
         CSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoq2dm2wMdYmvERBny9tE6W3gD6b5KdDrVUkIqFMrbk=;
        b=CJg9K4c4WtBfn0xIxnrhjLIoL8hqj2PTIpHgww9wtPUqhDyQJNWiiJEiPRnaZ4FKXg
         LkoyLVl8MH8CSS0a5ZA8QiZc94B+7NClQCILtf2joQF0N4awmmGBafTUr4WJTwOsDbV4
         qe/fI/wI/nNIGQjiW2c5QiYSdw04f1ObZCaFM/BfCkrbcZNMp4K7JJMJzkf9mRtgex+u
         tc5z+L4fey4CF/qoo4XbeueKdgU6ZQKNGrBQnqG7uVkgRmd95lWNY417iEMSnFe3FwfF
         dRmg6JGBxFIcxkQgWUIDfBiND+247sODjIkXlZkEl6qfo/dX1ZeuwuU9AVeK6ssjJvaP
         cc9A==
X-Gm-Message-State: ANhLgQ2CxGbrf1jeBy29Lir4n9WSrDT7sdBU4ixS13V9n5GUUnp8mMcL
        70PNhSxA/sblaOPZQkYjD61bNQatMC8i2uTG9pA=
X-Google-Smtp-Source: ADFU+vu4geqTV/LsCUJBg68QI3uBOWcuDWuhDYh1Th68uei++Exp9g0SEYeh9cAewcwPcjtzLCXmrGEP8H9Vv5FZWjI=
X-Received: by 2002:a02:c7cd:: with SMTP id s13mr8356495jao.81.1584323366115;
 Sun, 15 Mar 2020 18:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200315095342.10178-1-laoar.shao@gmail.com> <20200315095342.10178-2-laoar.shao@gmail.com>
 <20200315160332.GW22433@bombadil.infradead.org>
In-Reply-To: <20200315160332.GW22433@bombadil.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 16 Mar 2020 09:48:50 +0800
Message-ID: <CALOAHbBEt1wBe8hTk8c=WA0ZeDinH2bVZZtCwvv=qFG-8i6p1g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] mm, list_lru: make memcg visible to lru walker
 isolation function
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 16, 2020 at 12:03 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Mar 15, 2020 at 05:53:40AM -0400, Yafang Shao wrote:
> > +#define for_each_mem_cgroup_tree(iter, root)         \
> > +     for (iter = mem_cgroup_iter(root, NULL, NULL);  \
> > +          iter != NULL;                              \
> > +          iter = mem_cgroup_iter(root, iter, NULL))
> [...]
> > +#define for_each_mem_cgroup_tree(iter)               \
> > +     for (iter = NULL; iter; )
> > +
>
> That's not the same signature ...

for_each_mem_cgroup_tree() isn't used when CONFIG_MEMCG is not set, so
should remove it.

Thanks for pointing it out!

-- 
Yafang Shao
DiDi
