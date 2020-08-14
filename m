Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C39324467C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgHNIay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 04:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgHNIax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:30:53 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F85C061384
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2020 01:30:53 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id e187so4800320ybc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2020 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnDVAQh+31C0t6VNGwQb4SjTxgNgsH3VtTdOtKZQqwA=;
        b=dnr4mLvlqaTviMNIb+lJPY5U9aWlRKE8rBtF9/XEX9gNmzomc3qYCO99SFNJMqBShI
         ID7CBkceR981pX1/9kqesB9Bqrrq5f2cFzFhV/5G2tyTb89F0zUk7JSbKaSZOw3HbQxf
         Zhq0gHvWTQCikK3g4ur3M4TmpQw/a0u37kQEwnJw81wKmuuqaGmI6H+HbLINFx15X0H+
         hOIxcXOllEOoPSzsZ0DKha77TGNiwyDY0h2iYQVxky7dQScxW7AX4U4wH+U/RcYsDB4c
         4QTpivy51hJ8Xe0EnMzKIsjUXatzwM8w9PRIj3RFXCY7hXh0uWmamBOgCcOWMtRYHo/u
         l8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnDVAQh+31C0t6VNGwQb4SjTxgNgsH3VtTdOtKZQqwA=;
        b=hXBtceJF6Y7TTIClC1VXyldoiJs8ViJmDUvdYRAzpu9vPOyX8zSI0zQXYCNp7RWaBM
         8ePl4AB0R53D/BJeZX5pPBR+Nn2A5AqaabOQtP/895ntqiyMhIqyYzJQrBFRKt98tdRF
         crkk+kN1r5Tq8QFn2rwJNqZmnbpib9ClLOjLwimkeI2fAcha11VSh6sLCOPLwO8NhVwe
         VALYeozHd6RIoIVYCbUI07PqH42IxFr2vQ6/7sX+8hKd9zbbLFYyRcQzuE6xNELuwY7h
         1iOMjnH5HjEF7DR9a68VR3mTy6r3qZ7+P1LZyNVFdvl7Z8uRfmYoIn+do5Fx/LJ5G8Nj
         8Ygw==
X-Gm-Message-State: AOAM532+mcAgrKWyUNwTaK5LPeSoB98BeG/5yFurEOT8Jty4r/FqJQvu
        9m6A6D9GfCaUcotk53D/5MGJ6eXNzngCutRPlE6txA==
X-Google-Smtp-Source: ABdhPJzFmN0idTb9mEjomYn0+86nKEa4RjZkPMilkwJ+OKxZWvgt6E6RuaAMSfAO02qLD8cIHXduF0Tu4Ob3gT084Vg=
X-Received: by 2002:a25:ab0f:: with SMTP id u15mr2246861ybi.7.1597393852250;
 Fri, 14 Aug 2020 01:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com> <1597284810-17454-2-git-send-email-chinwen.chang@mediatek.com>
In-Reply-To: <1597284810-17454-2-git-send-email-chinwen.chang@mediatek.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 14 Aug 2020 01:30:39 -0700
Message-ID: <CANN689FtXN-6tGkyGc9ja7rrZTTUEoW5omfEJ=PmOaft4YkaaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmap locking API: add mmap_lock_is_contended()
To:     Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Price <steven.price@arm.com>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 7:14 PM Chinwen Chang
<chinwen.chang@mediatek.com> wrote:
>
> Add new API to query if someone wants to acquire mmap_lock
> for write attempts.
>
> Using this instead of rwsem_is_contended makes it more tolerant
> of future changes to the lock type.
>
> Signed-off-by: Chinwen Chang <chinwen.chang@mediatek.com>

Acked-by: Michel Lespinasse <walken@google.com>
