Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C632932A52C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443468AbhCBLrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349602AbhCBKml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:42:41 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50343C061793
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 02:32:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g3so24465981edb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Mar 2021 02:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aHiivO66cBlvi2omwE76dmO7GHvGNT96Cj5+nu42PGg=;
        b=I3uOr+q0RQRgiQgCS80GYwUSkTQnW9aaq4gmyDrvqidORji3JQgKK5Gk6gXKJx4JN6
         Kdw/xd8w7zZL+nnUxuSZdMOnoz9eiyotnG5IKpT+Ud7NlWqTrt6YooiYlRRVi02JJMMr
         4VYaUBZaNWsU4GxWuGvtyzk3NIV5/ZljDQKPkS7H3te3Wt54mTXFOXDjC2JdrQuaoHhI
         QtV+wrlNU3ReiikOrRqrSIVv+puzwruHdJKxH4oXnS6xb8gPwknLRq7pC4a/EOpknuQO
         +skcqqGEbtLCSfYhVvBfpY3tTCreILgdD5pwsxFpWM3+87sOSq+Bypy84M9wCvwAd7bE
         Twvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aHiivO66cBlvi2omwE76dmO7GHvGNT96Cj5+nu42PGg=;
        b=GC3nNXwGrA3EizNlorpEOiT3rUmQp+3Zr2JVbI43n2Z4LWXugJX1ukFnmMDVSbKnXg
         XoNrh+1DPRn95xyUs6FSDeA35hKJYjctAiFSNcQzHg2eDrb23DGg1H7WsVwEZOUFaRws
         vwg0h/x+L+7fsnuQWFP7sl6pjO8H4CKTDvKw21mY4MjtA/Or+Y9Gf6hy1Hu6knn/fAne
         yczPwwdPzoEZWuNcoUOHyvAYhydHam3Cm9LCPoZQK0DjXNrv3yUQqEEdc9W+fn+1VCeb
         ewZKqhH0PijwSQ3K8rEGuVKM6aJ2ns5Mbg4mGzvdkLK7UAMrJMgf4nzT16wwhdrPlSIG
         b9pA==
X-Gm-Message-State: AOAM530aEtqQKv3aOL2L/LLqIPks4RUS23fpf5VLZNX5hkRR6i+qSb7m
        3i/cEhj1L3c835JGiMRcM/eL9isX+5i6j181nf6O
X-Google-Smtp-Source: ABdhPJzlkbp8GXrzTY+Abm6IQL/bSnnCkhRKckW2ZUkdVHBw9ERA3un1YwUAbOK+Sq4gG6u3AkoG0LR4jYRsbg5g92Q=
X-Received: by 2002:a05:6402:180b:: with SMTP id g11mr10194555edy.195.1614681131866;
 Tue, 02 Mar 2021 02:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20210223115048.435-1-xieyongji@bytedance.com> <20210223115048.435-2-xieyongji@bytedance.com>
 <22e96bd6-0113-ef01-376e-0776d7bdbcd8@redhat.com>
In-Reply-To: <22e96bd6-0113-ef01-376e-0776d7bdbcd8@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 2 Mar 2021 18:32:01 +0800
Message-ID: <CACycT3vYA-2ut31KqzL2osGHDxRB_fTJBGyt4M7FvNkfv7zu7w@mail.gmail.com>
Subject: Re: Re: [RFC v4 01/11] eventfd: Increase the recursion depth of eventfd_signal()
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 2, 2021 at 2:44 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/2/23 7:50 =E4=B8=8B=E5=8D=88, Xie Yongji wrote:
> > Increase the recursion depth of eventfd_signal() to 1. This
> > is the maximum recursion depth we have found so far.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> It might be useful to explain how/when we can reach for this condition.
>

Fine.

Thanks,
Yongji
