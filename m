Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7556434589D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 08:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhCWHZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 03:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhCWHZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:25:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E374C061763
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 00:25:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b7so25423789ejv.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xwa51kxw61uMIow80uqDkY+H/GARiTsVnf3Sas4+BxM=;
        b=K/Y1f+FygYeHZ5bZBkEb+W+x4FQXWevwHu7nVAHSjHVtzShBuR+2g4FsS0kJzfB6Vy
         VVwcas8GBISn7nl+PoNKFfW4EktWkZWdfe7V6IXLHkWp1zEZC6hF9n0f+y8hnWEnn678
         bM2VOCVidgBxJJ7sHbiL6YqHT7ClwnTp1H6GfexhjZX5TAd7sYmJYCVyVM3dPzNdgjXp
         +Qq1sveuTC1kxYnTl3bnJC7WJ+Z5RIIs1fHT6Tw3rQE53wfy5yPnAQ650qEzQBUAamIp
         o/HlhyEARhMSvBBR5AeMuhWpQd/mMgr22U1IrIO9bKFBljAaC/j6nTrbC+LGXrHLs8hF
         AVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xwa51kxw61uMIow80uqDkY+H/GARiTsVnf3Sas4+BxM=;
        b=pLqAJQXg57D+fUQbWbCpLRIhkcHuC6DeTW8mjwmIbdmpcBTrVXIa3FYjbPGtwNa/wk
         aFACEMr5jPUHS9DQzTdMs7ahredNSk3HklB7PS7KA2Zh4qtoAoX17Or8L9p7HQ9X0VNw
         BXP4ev2jtf0nmSMWDuK5tzTpb0MzkJRm1etj3xJM+Rzvvmd9kDZDi+uYsixZdOwDb0iK
         pR8QWd3JV2+FQIUzgWVoZ23c2n52a9enfAq99RxACD27zBLKMbZx4aT+NQeBFssckaTN
         2W6rf4xfgHvALI4wpuXBWTv+10KwzeuKeo93l2U8VDSXABMTaFJ5IYor3iJ+byhfVX6v
         IAbQ==
X-Gm-Message-State: AOAM531pZme6fJoJ7SGsdz3gfLyXbfKsDs3+4b0u4F5MVL8LBoHONZyq
        D9D/BmYqLiskmb6/t0VB/7B/67bsL6MZWW9sqV92
X-Google-Smtp-Source: ABdhPJzJm68SUj19rBv+WCUqBy2FNifWaazEUCLQ3Uhyia48gmLbT4tJs0m9MQ2KYMXowDVwKahrwolbYciM+aEhnp8=
X-Received: by 2002:a17:907:a042:: with SMTP id gz2mr3554509ejc.174.1616484329008;
 Tue, 23 Mar 2021 00:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210315053721.189-1-xieyongji@bytedance.com> <20210315053721.189-4-xieyongji@bytedance.com>
 <38a2ae38-ebf7-3e3b-3439-d95a6f49b48b@redhat.com>
In-Reply-To: <38a2ae38-ebf7-3e3b-3439-d95a6f49b48b@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 23 Mar 2021 15:25:18 +0800
Message-ID: <CACycT3vg=+08YWLrVPHATwFvCjEzmKuTLdX3=stLQqrsm-+1Vg@mail.gmail.com>
Subject: Re: Re: [PATCH v5 03/11] vhost-vdpa: protect concurrent access to
 vhost device iotlb
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
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:02 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/3/15 =E4=B8=8B=E5=8D=881:37, Xie Yongji =E5=86=99=E9=81=93=
:
> > Use vhost_dev->mutex to protect vhost device iotlb from
> > concurrent access.
> >
> > Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Please cc stable for next version.
>

Sure.

Thanks,
Yongji
