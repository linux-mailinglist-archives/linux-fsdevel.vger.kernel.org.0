Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DE2FCB36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 07:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbhATGyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 01:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbhATGyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 01:54:11 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EA9C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 22:52:50 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b21so15623752edy.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 22:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OUwyk7xtJXT5NiDavD07ZTFekT45AnyTwd1+tu8BV2s=;
        b=pnwim4oCTPJUkeAUxNAT5zomyWF/8LBZ1cr/prJSrtoyHr6HXwRulATLeGbM/zO+Ds
         iqSkBnm5FA9GpCYr9mahnXVLdDvm3bdZX5GeRjmIUXWkd0oW4aY7i0dX6thJBZ3mMVSV
         kWWzYR0S87bDJHTos/rkGTLnwTAx9SG+OZRig4PiWcIGWCrfXuJmOjX0DzJnInkNrP35
         pB4N6RKJdbQJV87bfF3r/Bm8NHvVpa5erF24fOAXjjbO5h7EtqLSRTdmt2rPNoqOJQ/v
         xZ5GndPVEXc7GmGALiHmeXTnM/YhXGYk4iKYyiuWGdXGm8MYsZHmPZawRrhsinkdASfM
         xHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OUwyk7xtJXT5NiDavD07ZTFekT45AnyTwd1+tu8BV2s=;
        b=BYpwiPvr+dtIo23ecz+ymttPWKf5YYT9PJIWkyPaHGd8ft+khR8fvhndk1yHOkcWQI
         EHrcKiZW+gjYjZ/1VZd1Yn8vbsCWw0vgum/0hrZwInDYIeizTHro00yMdiUkZ2aMhVd6
         a+eiar7N1T5Agmi9rxPohD1tLyWLsgcyAy6Pw3HYLsTj9NaiHIa0xywm/OhkrJyGYQ0E
         Khwc2ExF6kOalYmRlr6E31Q2wSdNfd0cwnJEgxXLOVP36OPz+NK+HqhxgdRuNiIwCjLV
         99h8eiuWkK1hve6wTOgFt6htSWs4vZGUM+GgHhDdV5IzfNQekkiyj1VHJlpgFgWEAKQn
         MyNw==
X-Gm-Message-State: AOAM532SD0gCa5c0iby0XZlSiPweHLnQGdd6ONW16I7RoDpe+nv0Rku4
        B+BjrkWbHmpKeAKHua0oSpzM+La7GhxXZTPGvAJs
X-Google-Smtp-Source: ABdhPJz8mSZjfHOOyqb5onfPHShDdIVRGCg/2N4z9UKpZS1PnUlAPw4lgExHz6G+gVcVSgVIvukJvyXD7wAAibCHYOw=
X-Received: by 2002:a05:6402:407:: with SMTP id q7mr6214637edv.312.1611125568895;
 Tue, 19 Jan 2021 22:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20210119045920.447-1-xieyongji@bytedance.com> <20210119045920.447-2-xieyongji@bytedance.com>
 <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com>
In-Reply-To: <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 20 Jan 2021 14:52:38 +0800
Message-ID: <CACycT3sN0+dg-NubAK+N-DWf3UDXwWh=RyRX-qC9fwdg3QaLWA@mail.gmail.com>
Subject: Re: Re: [RFC v3 01/11] eventfd: track eventfd_signal() recursion
 depth separately in different cases
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, sgarzare@redhat.com,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, bcrl@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 12:24 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/1/19 =E4=B8=8B=E5=8D=8812:59, Xie Yongji wrote:
> > Now we have a global percpu counter to limit the recursion depth
> > of eventfd_signal(). This can avoid deadlock or stack overflow.
> > But in stack overflow case, it should be OK to increase the
> > recursion depth if needed. So we add a percpu counter in eventfd_ctx
> > to limit the recursion depth for deadlock case. Then it could be
> > fine to increase the global percpu counter later.
>
>
> I wonder whether or not it's worth to introduce percpu for each eventfd.
>
> How about simply check if eventfd_signal_count() is greater than 2?
>

It can't avoid deadlock in this way. So we need a percpu counter for
each eventfd to limit the recursion depth for deadlock cases. And
using a global percpu counter to avoid stack overflow.

Thanks,
Yongji
