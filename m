Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E6305696
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhA0JOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 04:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhA0JMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:12:12 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436C1C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 01:11:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id l9so1616819ejx.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 01:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TfZZl8PAbAVTCtt4nQNes7IujOJMmLRPRF7/Y9rK9Vo=;
        b=b+Lnk6LAE+nkp9wqxfFccb4OZYzBekoFCPCbN7XcGTePmZI3QYVJe+OFWdJF900gZ6
         YXnX0bukQa2tQ1sBU5qLTNPm31IRL0XGFR1C6pXYJtTkCQhs1iEsLBfrYg2Ek3SzoyyT
         6KWsC/5GeTXsVIEfBLkd1athnsj98/OEZD/9s9LAJjKggqL2qysrfu+xaMXI4bkla47S
         CASUq4Msm1c6I3O9dABNjYGnDB47sYYZwN6v8AAcNywGqh2LyO4ZgcE5yDtS8U2qkxEf
         9bpISs16P0RhojAJSEhYAt4IyQph+dXaFkjo8z+EzsZOoOsCp6Z28eGat8mHoDgHm+vy
         g7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TfZZl8PAbAVTCtt4nQNes7IujOJMmLRPRF7/Y9rK9Vo=;
        b=LP2wzG//7MVU66nSk+oNw4w+oYw1sKbV0N+81y/VXU91USxCfta0jJ+zDn1gq4L7e6
         fnfR7K6sUWUmC2kn/bxaI83bH4XIgxxuHjcCE4h/NT1++0VFM3RlRPVKYPbq8MINKNhQ
         S2mEjzi1HkZB28WDqeuXwRElG/JqBP4VsDyWRjF5Llo473dcbSBSL4JxnvvN1P6Q3qLy
         sTt5/4i1dHjsKkso9exnyQiyqphMi7T4kV/TOQo6Gmjg4dV3k9QB34vtxQMO3ri4M0aq
         NlZcNHmGU5U4edmhD7iI/ATWw2k32Z8tSH+ubhP7jU1Bv/u/UA5wB+lzMq5dfJlmAvaC
         +v0A==
X-Gm-Message-State: AOAM5328p1vpYZYbpgkyYbWFbHvtvmStMi0mQDhUeCEkclezYFHITosp
        fmbN3UH18PiU6V/ui2xIReznKiTywv/7U/D1PWQa
X-Google-Smtp-Source: ABdhPJypBm0DEUs9BOCccci8Ote3fGceFY3ywzu2SqtiZ/6zSNasUSc1CJB6p1slbKSfi/mwEWK1VX09P8/HKmZz0XQ=
X-Received: by 2002:a17:907:3d86:: with SMTP id he6mr6036372ejc.174.1611738689957;
 Wed, 27 Jan 2021 01:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20210119045920.447-1-xieyongji@bytedance.com> <20210119045920.447-2-xieyongji@bytedance.com>
 <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com> <CACycT3sN0+dg-NubAK+N-DWf3UDXwWh=RyRX-qC9fwdg3QaLWA@mail.gmail.com>
 <6a5f0186-c2e3-4603-9826-50d5c68a3fda@redhat.com>
In-Reply-To: <6a5f0186-c2e3-4603-9826-50d5c68a3fda@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 27 Jan 2021 17:11:19 +0800
Message-ID: <CACycT3sqDgccOfNcY_FNcHDqJ2DeMbigdFuHYm9DxWWMjkL7CQ@mail.gmail.com>
Subject: Re: Re: [RFC v3 01/11] eventfd: track eventfd_signal() recursion
 depth separately in different cases
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
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

On Wed, Jan 27, 2021 at 11:38 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/1/20 =E4=B8=8B=E5=8D=882:52, Yongji Xie wrote:
> > On Wed, Jan 20, 2021 at 12:24 PM Jason Wang <jasowang@redhat.com> wrote=
:
> >>
> >> On 2021/1/19 =E4=B8=8B=E5=8D=8812:59, Xie Yongji wrote:
> >>> Now we have a global percpu counter to limit the recursion depth
> >>> of eventfd_signal(). This can avoid deadlock or stack overflow.
> >>> But in stack overflow case, it should be OK to increase the
> >>> recursion depth if needed. So we add a percpu counter in eventfd_ctx
> >>> to limit the recursion depth for deadlock case. Then it could be
> >>> fine to increase the global percpu counter later.
> >>
> >> I wonder whether or not it's worth to introduce percpu for each eventf=
d.
> >>
> >> How about simply check if eventfd_signal_count() is greater than 2?
> >>
> > It can't avoid deadlock in this way.
>
>
> I may miss something but the count is to avoid recursive eventfd call.
> So for VDUSE what we suffers is e.g the interrupt injection path:
>
> userspace write IRQFD -> vq->cb() -> another IRQFD.
>
> It looks like increasing EVENTFD_WAKEUP_DEPTH should be sufficient?
>

Actually I mean the deadlock described in commit f0b493e ("io_uring:
prevent potential eventfd recursion on poll"). It can break this bug
fix if we just increase EVENTFD_WAKEUP_DEPTH.

Thanks,
Yongji
