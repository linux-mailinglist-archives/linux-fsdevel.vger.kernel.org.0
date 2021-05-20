Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF0389D2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 07:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETFo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 01:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40586 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230325AbhETFoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 01:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621489413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjW4Njna3bnKmMjSqk9By1QrG7BREpE+oMFazMCyiuc=;
        b=RRL8DDhaYPVgtloo0xdB9F+BwAiHuFpShr+4nTgLXyodQoMbecFPVCmHErHlgY8lGBpoFw
        lQ9X9zZGlghDbTj+k0q7TaoY+Z+A1PqdOhBsd8BCcXvRmTp6DBG7EIMICc8EbVTvEa5D9y
        RZb/Ra/NsF+RicdPJ23beF6Mlg0MuAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-ybr9uaOWP1a2-YJCVvoPZw-1; Thu, 20 May 2021 01:43:31 -0400
X-MC-Unique: ybr9uaOWP1a2-YJCVvoPZw-1
Received: by mail-wm1-f72.google.com with SMTP id b206-20020a1c1bd70000b02901713122405eso1028052wmb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 22:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GjW4Njna3bnKmMjSqk9By1QrG7BREpE+oMFazMCyiuc=;
        b=b0j08ysP46rjRwojs5tdbrBq8fveBitllT06QQD8IihoJXR+hxtRKS7QPt7XJ0EiwV
         ZuJoh0y2KQDw+jSApnrchNbLBo0Se6tR5ljf5qfvgfwCWwLDCdFPGbYTHINQ5bxRCf4d
         V4l5Ybd7rJYXILpCO92U+YgtlHnFQ75HcbxGwVMZmqefNYX/V6ZVwpITofF6tIT0do9P
         V8hl3IWnevDGVFhtNRPzkljGc/+HzXVetVjalmKIykNbTi8K4pg7RcsOHCBZej2Lyt3q
         2SFJNBzf7Z7UC9LNjB9nVEvls5n6JWtlrsKw866rf6DcJiltQs1rAnLeFcIRnBcy0Bt8
         i96w==
X-Gm-Message-State: AOAM530YOD0Zdx+0OgwmdEU8teMTRL/LClagaGYAGTwLvGXTRIlMxTdu
        OdLAFMpVgocLzGKu6cLj/2j70Qps6/tDrIqecAy6guVI0klJ8c8U3ZpinpeC2A70+eOLTJIJ5td
        VW1RQ38PPFlfsXGDkLh/XzHFTlw==
X-Received: by 2002:a5d:524b:: with SMTP id k11mr2308296wrc.292.1621489410041;
        Wed, 19 May 2021 22:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPmuJaJcBIzoz51cJHFKBEGSMwRicV/EJnxc2pubykB7VVTdZU5S/RsC7BPoTegDy8gNdFLQ==
X-Received: by 2002:a5d:524b:: with SMTP id k11mr2308281wrc.292.1621489409886;
        Wed, 19 May 2021 22:43:29 -0700 (PDT)
Received: from redhat.com (bzq-79-181-160-222.red.bezeqint.net. [79.181.160.222])
        by smtp.gmail.com with ESMTPSA id t16sm1717230wrb.66.2021.05.19.22.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 22:43:29 -0700 (PDT)
Date:   Thu, 20 May 2021 01:43:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        joro@8bytes.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v7 04/12] virtio-blk: Add validation for block size
 in config space
Message-ID: <20210520013921-mutt-send-email-mst@kernel.org>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-5-xieyongji@bytedance.com>
 <CACycT3s1rEvNnNkJKQsHGRsyLPADieFdVkb1Sp3GObR0Vox5Fg@mail.gmail.com>
 <20210519144206.GF32682@kadam>
 <CACycT3veubBFCg9omxLDJJFP7B7QH8++Q+tKmb_M_hmNS45cmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3veubBFCg9omxLDJJFP7B7QH8++Q+tKmb_M_hmNS45cmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 01:25:16PM +0800, Yongji Xie wrote:
> On Wed, May 19, 2021 at 10:42 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, May 19, 2021 at 09:39:20PM +0800, Yongji Xie wrote:
> > > On Mon, May 17, 2021 at 5:56 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > >
> > > > This ensures that we will not use an invalid block size
> > > > in config space (might come from an untrusted device).
> >
> > I looked at if I should add this as an untrusted function so that Smatch
> > could find these sorts of bugs but this is reading data from the host so
> > there has to be some level of trust...
> >
> 
> It would be great if Smatch could detect this case if possible. The
> data might be trusted in traditional VM cases. But now the data can be
> read from a userspace daemon when VDUSE is enabled.
> 
> > I should add some more untrusted data kvm functions to Smatch.  Right
> > now I only have kvm_register_read() and I've added kvm_read_guest_virt()
> > just now.
> >
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >  drivers/block/virtio_blk.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index ebb4d3fe803f..c848aa36d49b 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -826,7 +826,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > >         err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> > > >                                    struct virtio_blk_config, blk_size,
> > > >                                    &blk_size);
> > > > -       if (!err)
> > > > +       if (!err && blk_size > 0 && blk_size <= max_size)
> > >
> > > The check here is incorrect. I will use PAGE_SIZE as the maximum
> > > boundary in the new version.
> >
> > What does this bug look like to the user?
> 
> The kernel will panic if the block size is larger than PAGE_SIZE.

Kernel panic at this point is par for the course IMHO.
Let's focus on eliminating data corruption for starters.

> > A minimum block size of 1 seems pretty crazy.  Surely the minimum should be > higher?
> >
> 
> Yes, 512 is better here.
> 
> Thanks,
> Yongji

