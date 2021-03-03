Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C62732C539
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447496AbhCDATu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbhCCMqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:46:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9FEC061794
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Mar 2021 04:45:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w21so29764988edc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Mar 2021 04:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R8skQwAyF26/dHYrwyzTfCWe7/xsgSlpBg6SohjtuMU=;
        b=M9+WohZueIjBPaWnkvFfCCJcyA4ohQ62DRT+1mOaiXit1hvnGCpavxKpPAJV433Ixg
         Z7nUobMvzFrDyt9f5sO7hw2xdkgza2WNo6BthDU2QZnyQopCcOhFLAZvHUtNte1ESHw5
         D10DAlAWVvUNpBDmnP2S0LXdQGRtyFc2bioJl9DQhHLFnTdQ+UcIQAPnadgR1JNKIRI8
         6OrlUMazokOELlAthZ8B0LSmTHgFOUeW+l+AH5s2F0zJFVpMRzZjvONslAws5iE0PtIU
         ujklNQEtA39rr80UFQgL+Pvg24fVOfBer4BHDW2UEy49Bxqguvcfru/00JklRMpzJqa5
         onFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R8skQwAyF26/dHYrwyzTfCWe7/xsgSlpBg6SohjtuMU=;
        b=VyUj8Cs5yRNQC4KDdU7wQYTJcwo1eQFbP22B5Z+K8cA+ZoNHQfpG+AVqJLmXHBL6cA
         7U6xOHCZq493hyPdhtmjnCt0v9G2Y7vqY4NooxjBznXhnfR6szeMPwpmKb8Y1im94FGB
         3DZ/FuNOH7GcigrxisuUpLpZIOrK3nv+rDTT10T9Yl39Sx7uJVtx1WszYUQW+At0ZNN7
         VVt3AmKRTN4Iko98kBziebVqIB9efebwsX/9zVA7zIM64dVVista2Q/iNjveWFan3ysV
         nnwpJmFNFF9RMPCoNoFqJzZJ94plwsQ87z+wLKSEp4AFU+VnVeq0r0Nf1yyCvklOT89i
         plBw==
X-Gm-Message-State: AOAM533SZFzo/PwCsYhyE4IrvhZCfWXaWGwccLUfsW5lVRhi3Otw2ne7
        EkmbtvV/+mf4VEMDA3YMXTHqKLxmKnIb5RIzz+N5
X-Google-Smtp-Source: ABdhPJzY5dY8rzSlTmThaFjqIEA9/mJwFnnFopLzk/4LSnjv4XCq/ywwVBb/7S4wVk7veXN48JsIe5IA5eR19VTHk9g=
X-Received: by 2002:a05:6402:3589:: with SMTP id y9mr25340347edc.344.1614775549443;
 Wed, 03 Mar 2021 04:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20210223115048.435-1-xieyongji@bytedance.com> <20210223115048.435-6-xieyongji@bytedance.com>
 <e2232e4a-d74a-63c9-1e75-b61e4a7aefed@nextfour.com>
In-Reply-To: <e2232e4a-d74a-63c9-1e75-b61e4a7aefed@nextfour.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 3 Mar 2021 20:45:38 +0800
Message-ID: <CACycT3tFS=UOUqFKNP0R8fztymz+p9RP_d0843xDbVFd_govEw@mail.gmail.com>
Subject: Re: Re: [RFC v4 05/11] vdpa: Support transferring virtual addressing
 during DMA mapping
To:     =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
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

On Wed, Mar 3, 2021 at 6:52 PM Mika Penttil=C3=A4 <mika.penttila@nextfour.c=
om> wrote:
>
>
>
> On 23.2.2021 13.50, Xie Yongji wrote:
> > This patch introduces an attribute for vDPA device to indicate
> > whether virtual address can be used. If vDPA device driver set
> > it, vhost-vdpa bus driver will not pin user page and transfer
> > userspace virtual address instead of physical address during
> > DMA mapping. And corresponding vma->vm_file and offset will be
> > also passed as an opaque pointer.
>
> In the virtual addressing case, who is then responsible for the pinning
> or even mapping physical pages to the vaddr?
>

Actually there's no need to pin the physical pages any more in this
case. The vDPA device should be able to access the user space memory
with virtual address if this attribute is set to true. For example, in
VDUSE case, we will make use of the vma->vm_file to support sharing
the memory between VM and VDUSE daemon.

Thanks,
Yongji
