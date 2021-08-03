Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157FF3DE8F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhHCIy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 04:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhHCIy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:54:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ABDC06175F
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Aug 2021 01:54:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e19so35243336ejs.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1DVuCuuKly3zqPgMlidKVCYH4f+rj2v8udMt+8e+Uk8=;
        b=MZubOip1Xuw9qiOUr/kIGiSZitdzEOs8Ev3b4lxWtajhiEQKwydeyb77dkWORzxr+5
         I0/ejnvL4DaoVnpNpUdg1oEminxd1mRaWoZRj8bwrvUHNCn0mjNO300Pi9tAwh+Oi801
         gSSS8X1xcafLCF7kbMODXynVqrHdZKumBJxcRUfwNTScuorPWQugV7ZkkalNVMCNVs2R
         9s52YDDPCYkF8dKdTOXw8NBIEQgR4nrTX0bvsfLdbJPDO/EmX1CrkNhJHbYPSRZ4cKnG
         QlBsDHrNlcwlhk46REypbTfQobXYQHhXCY2QZ9BYzxXo0InKXaCkqgEdCaV0QNqRaA/C
         kpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1DVuCuuKly3zqPgMlidKVCYH4f+rj2v8udMt+8e+Uk8=;
        b=ZmKm5oKYMmFO8Fb0XJzDixIhfZoX8Ri6dL9egCgqrz5ZgWjEyaGnCyNVxMQRc4g91N
         vzEFmaFkaGUX0dvp5q4LMCppfBa56pSXVWF+GoUySEznQV3cchddjPR0IHi0qHqEDvGK
         fDv3eiV/3y2wM9hV4WPA2J69eokBjyC00tJ8YGUnGWQWJc/5r5XhDG7D5vTIOMFjhiDF
         uC0SZlDDqvJKxt0Z26fKoYJGI1IQYqwDHLY/QPPa7lPl5+I3qwE1t3ACjoja2jQD89TY
         LuPu66MYP8xK2wFv9U4+Hmo9cW7uKYVqkKSwx7Rda2whxhN7Y14TWojd4GZ85bTjG+Sr
         m97Q==
X-Gm-Message-State: AOAM532ggQZRbBCYerhdKpl8vsu4RhxBj2UluhkkZTQznxBSqgGdbKM6
        KkxJqV9+QkNiKhW3lh8+i+I1cs5YayOTTsno9Cr7
X-Google-Smtp-Source: ABdhPJzB2Rc0yO2aoVU5Tdu2hZC6usoNGChwlVypWWdIUMwNhodGIYWH6xML1M1VZIQCiXVlhOS7usO1CIDwdk4oZOA=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr19068058ejs.197.1627980854338;
 Tue, 03 Aug 2021 01:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210729073503.187-1-xieyongji@bytedance.com> <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
In-Reply-To: <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 3 Aug 2021 16:54:03 +0800
Message-ID: <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and free_iova_fast()
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

On Tue, Aug 3, 2021 at 3:41 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/7/29 =E4=B8=8B=E5=8D=883:34, Xie Yongji =E5=86=99=E9=81=93=
:
> > Export alloc_iova_fast() and free_iova_fast() so that
> > some modules can use it to improve iova allocation efficiency.
>
>
> It's better to explain why alloc_iova() is not sufficient here.
>

Fine.

Thanks,
Yongji
