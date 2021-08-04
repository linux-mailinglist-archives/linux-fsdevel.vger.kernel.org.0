Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81F23DFD9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhHDJIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 05:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhHDJIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:08:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07F6C0613D5
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Aug 2021 02:08:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e19so2668042ejs.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 02:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vHxgnDbRze3cfbummo1oFdspd0VXUkioTGyKAxbmjBY=;
        b=rrLb5avlbWWVVZAoiqSf4GuH1Tep3672/ZPFrJ1q2sFsUjVxFnNVB7tKQ6xXG4rhnv
         1PpAczmI/qacC7vsiZ2BEcntWSoQhW130Qwg+GEKxWvTPhhjdU0zMqHukOrvN7jIhUoV
         Nsn2eb0p8F8I1ZJcwL62tBSr6vb1HYCK7y/HkosE9AxRt7VX5in8838+OKYoj/JdigCO
         22pQ6zrUz1MLqHboxSN2WElTA63GZmG1OcBMMKNc/LoDbjlq6Lf4z01rVYSWbqkkn5bl
         mqGmd/oNyGjYpPMnG5vHW8RpUjXvzzZbHlRoL8cVzBdZSTws01CqFaXWZkQX3ftOVtMV
         f9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vHxgnDbRze3cfbummo1oFdspd0VXUkioTGyKAxbmjBY=;
        b=pWCUQHQVc0ShLpkJz6rv9WvirsAaiZNVLDFpahL0WgDd8NO58pvFxr9XpDR+krOkc0
         geMgFyC3LwCAqFXe1ALgt16L4vvJZKGjoRPYQzy53VzVZLTHrUQd1hj880jTU6mNsq1j
         MVCm/s/+wdE7bEXDPK4NACuiwIPaxsZdbF4RGDbR+26fWN1VGR6U013QBjJ71XxQ8BOs
         Dr8/DEwfT96RyQHxmQw8Q30siLNPOpipHzd3EmQ/2YVNjQthLoo4RoWjmrtefyUwzrcI
         XKQO+bZOCioCmwm8L7GvIuHlEPEeMCc3Hh0Dtbw18qr6gQBi4cYXKewLp07M6CY6ZysI
         eEZA==
X-Gm-Message-State: AOAM533Q/W5pYDLhE0GOMVnoDNtWKHciWZv5UaMHiceKTWd9ZYficN6P
        eLuJx1mX/x2coOzmyIDoXV/onZ7fzfAoVNUApEWk
X-Google-Smtp-Source: ABdhPJz7ndtSUpcqEgNkoVHcDwP0fq03BR0Lre7qDAvevyBxeyuNZM0taxEDcIn1Kzh847IXKZfSmIisXg0eBWVCt2c=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr24219405ejs.197.1628068080494;
 Wed, 04 Aug 2021 02:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com> <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com> <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
 <fdcb0224-11f9-caf2-a44e-e6406087fd50@redhat.com> <CACycT3v0EQVrv_A1K1bKmiYu0q5aFE=t+0yRaWKC7T3_H3oB-Q@mail.gmail.com>
 <bd48ec76-0d5c-2efb-8406-894286b28f6b@redhat.com>
In-Reply-To: <bd48ec76-0d5c-2efb-8406-894286b28f6b@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 4 Aug 2021 17:07:49 +0800
Message-ID: <CACycT3tUwJXUV24PK7OvzPrHYYeQ5Q3qUW_vbuFMjwig0dBw2g@mail.gmail.com>
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in register_virtio_device()
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Joe Perches <joe@perches.com>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 4, 2021 at 4:54 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/8/4 =E4=B8=8B=E5=8D=884:50, Yongji Xie =E5=86=99=E9=81=93:
> > On Wed, Aug 4, 2021 at 4:32 PM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> =E5=9C=A8 2021/8/3 =E4=B8=8B=E5=8D=885:38, Yongji Xie =E5=86=99=E9=81=
=93:
> >>> On Tue, Aug 3, 2021 at 4:09 PM Jason Wang <jasowang@redhat.com> wrote=
:
> >>>> =E5=9C=A8 2021/7/29 =E4=B8=8B=E5=8D=883:34, Xie Yongji =E5=86=99=E9=
=81=93:
> >>>>> The device reset may fail in virtio-vdpa case now, so add checks to
> >>>>> its return value and fail the register_virtio_device().
> >>>> So the reset() would be called by the driver during remove as well, =
or
> >>>> is it sufficient to deal only with the reset during probe?
> >>>>
> >>> Actually there is no way to handle failure during removal. And it
> >>> should be safe with the protection of software IOTLB even if the
> >>> reset() fails.
> >>>
> >>> Thanks,
> >>> Yongji
> >>
> >> If this is true, does it mean we don't even need to care about reset
> >> failure?
> >>
> > But we need to handle the failure in the vhost-vdpa case, isn't it?
>
>
> Yes, but:
>
> - This patch is for virtio not for vhost, if we don't care virtio, we
> can avoid the changes
> - For vhost, there could be two ways probably:
>
> 1) let the set_status to report error
> 2) require userspace to re-read for status
>
> It looks to me you want to go with 1) and I'm not sure whether or not
> it's too late to go with 2).
>

Looks like 2) can't work if reset failure happens in
vhost_vdpa_release() and vhost_vdpa_open().

Thanks,
Yongji
