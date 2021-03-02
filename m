Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542F832A52B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443463AbhCBLrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379954AbhCBKVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:21:20 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685CC061788
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 02:20:33 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mm21so33891452ejb.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Mar 2021 02:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yi8wECcwdBRjg7+URRAywGRh6tS4eye0VU27h7CmQYU=;
        b=BV6R8yFKOB05YsyrxRNeCYJYo4Z1LOohGqQ6dB4bVxO9DfKPQiKSIYEpIurIDq4ZC+
         V4R+0rigcAUXOrWxLGrWHLrU4b48J9GxhVUOt2O/kY82XxtKQX/OfHgcT605GYAjLinc
         p8JowBmG/U/JhO8dCF3As2f8B8y60LMDVkBV9Ka0tqeUVcFT+T6i59o4uVhgpNoAh8bl
         s2IVwV4GBuuhzB4354dXUermv/hVxYEDweBUAHicsAtl6oMKBqR0FXwczSlyQEHdIUlr
         2S28ialJ+lgr/uZ24N2gkdzrasQeFwHoRHC3JNytS8wpxbK93ISyhK+BP74WTqQRnBlw
         834g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yi8wECcwdBRjg7+URRAywGRh6tS4eye0VU27h7CmQYU=;
        b=drnFp1AqQxYUaUx8920WXkfsZ6o8k5Vj6pqgtk5So4rzuOAD/KvvT22ofzrgDjEVAe
         PczjJNfAIdrcD+ldipLYim0PeJPT9aevUON+N0bgj2Gr9JlOjDjE9t+SRj725IkjvLFd
         qozCmzE4nHECBzUQQCgMbs/f7P7sbADyJXh0iVyvbbA+LZa4xZDsNKcvFd1zOJHzJupD
         Nx+dssPEUAWWbh/FvLAoNUVzBbtybVlxY4hE53OtNAg/4BP7HQM0nS/97iaSKqW+Dpmg
         /2wx2+D8eMpJUxVXoaMrYuE/K/G8WDYE4GxI4GQ18Dmj58N6NUVmGqwNgLxnPWWy1oLa
         5Fcg==
X-Gm-Message-State: AOAM5307A9k+YQfNGzfwsO2i1n9WCgPuDSRcXW7qKEEimY0RneCpo4Zi
        8WETX1yiQeW2aH48tM0oFOmx+XG1gM4bvbQCGL1j
X-Google-Smtp-Source: ABdhPJyBWqFKanD0h+041MluNJeF05cCpfSJ5Sc1CvWrsgH4neTtL6sAPV38+UELsymwPahh831ZljvgeIkDlIg5wcc=
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr19229620ejc.197.1614680431831;
 Tue, 02 Mar 2021 02:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20210223115048.435-1-xieyongji@bytedance.com> <20210223115048.435-3-xieyongji@bytedance.com>
 <a170e0ec-f0cf-e23f-0ca7-e8a5bfd1cf31@redhat.com>
In-Reply-To: <a170e0ec-f0cf-e23f-0ca7-e8a5bfd1cf31@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 2 Mar 2021 18:20:21 +0800
Message-ID: <CACycT3skiem9ZXKCrg4nKcw4jPPCNGwCnRtDUtVhZ7YJJ-se1w@mail.gmail.com>
Subject: Re: Re: [RFC v4 02/11] vhost-vdpa: protect concurrent access to vhost
 device iotlb
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

On Tue, Mar 2, 2021 at 2:47 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/2/23 7:50 =E4=B8=8B=E5=8D=88, Xie Yongji wrote:
> > Use vhost_dev->mutex to protect vhost device iotlb from
> > concurrent access.
> >
> > Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/vhost/vdpa.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index c50079dfb281..5500e3bf05c1 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -723,6 +723,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhos=
t_dev *dev,
> >       if (r)
> >               return r;
> >
> > +     mutex_lock(&dev->mutex);
>
>
> I think this should be done before the vhost_dev_check_owner() above.
>

Agree. Will do it in v5.

Thanks,
Yongji
