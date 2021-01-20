Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47782FCB29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 07:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbhATGqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 01:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbhATGp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 01:45:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C9C0613C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 22:44:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id dj23so21865130edb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 22:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=awHFENDHpSgXNCFvxRpb7rmLK90gRrgZnQPYnvBPgnc=;
        b=xV7eseVydqeNtWhSFSleOckNhm5fLNJabUt/tK2xayIYrcHZC9XFp4n8pMFlG3Y5xy
         w/IpPTE7BplvUlayXdODXrE6N+J3aEkcE6AhUVusF2ooHUTMG7HTxMBn2ZbJ7AafLA53
         i8oM4kBlqJx5RPo/GDX2RfvIQUCoUVMwNO9+Sd6a2d5DiDuEnuHA8T+yXcjehEi8+rEZ
         30WBCJegSPciZTd5MK/fcmQqTfY9lXXEC9jo/dhI+H73P+PoJHu2gwGH65UVrDnM++Q7
         t0xUYJmI4zghuucN6tzDr8RbgCJoaXQtvAbXY4hMo48ivs1aP5A73Xg79qAp4HSwzplJ
         PMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=awHFENDHpSgXNCFvxRpb7rmLK90gRrgZnQPYnvBPgnc=;
        b=NoXrhslYHT8C1u5c75hENjPZs1EJGYCEDxpsByx+5XwW1RBuE/P+8VGvKIuKNMkXGm
         wNmWfZGejSOuPjs/hLvjYxgB6c6x7ZdU+Q2e6rrFkBo4f6S8AI1jfht3QPKrf2KCAFjr
         Hc2Q1MTcKIYMTYjdj5wlYXuwC85m7hd3yedQY2pjHA2J5ppBEBccMTCu4suQD50VUuKn
         vKI4uiFsRReSkIxV0K+izP6MVONVp6iugBCPLJpvMl4nexcj5mfDargxJwmrE2Yfcssw
         hrTnhd0TaoKbSIkrClB7KHN0EgCLYd+5wLQ0eCXdv61hsHnaJqrcor84l1Oc5SIpppMH
         sQOw==
X-Gm-Message-State: AOAM531sUKzfXBZ1IbIhYVPAI40fB3kmHs6zZR173PoK39YYU9XAAwrU
        2s/q+q72UZWITBpbxgqbrcB+MGAUd1QTWjhy2r5d
X-Google-Smtp-Source: ABdhPJx0sMXnqlQ8lzSp/rChsvvxS/AZYoGtK+bkAoS67Se/guN/SdAuI3TVMPEKXrD0Ab3nmellLx0Sza0G3TU7i8Y=
X-Received: by 2002:a05:6402:3589:: with SMTP id y9mr6275234edc.344.1611125086314;
 Tue, 19 Jan 2021 22:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20210119045920.447-1-xieyongji@bytedance.com> <20210119045920.447-5-xieyongji@bytedance.com>
 <8fbcb4c3-a09a-a00a-97e2-dde0a03be5a9@redhat.com>
In-Reply-To: <8fbcb4c3-a09a-a00a-97e2-dde0a03be5a9@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 20 Jan 2021 14:44:35 +0800
Message-ID: <CACycT3vxi-Rkaixdd7Wa6t0ELXHgPJDLp6nwFYkXbr7kFrhyCA@mail.gmail.com>
Subject: Re: Re: [RFC v3 04/11] vhost-vdpa: protect concurrent access to vhost
 device iotlb
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

On Wed, Jan 20, 2021 at 11:44 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/1/19 =E4=B8=8B=E5=8D=8812:59, Xie Yongji wrote:
> > Introduce a mutex to protect vhost device iotlb from
> > concurrent access.
> >
> > Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/vhost/vdpa.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 448be7875b6d..4a241d380c40 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -49,6 +49,7 @@ struct vhost_vdpa {
> >       struct eventfd_ctx *config_ctx;
> >       int in_batch;
> >       struct vdpa_iova_range range;
> > +     struct mutex mutex;
>
>
> Let's use the device mutex like what vhost_process_iotlb_msg() did.
>

Looks fine.

Thanks,
Yongji
