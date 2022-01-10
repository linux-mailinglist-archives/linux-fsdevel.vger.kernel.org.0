Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286E9489C71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiAJPoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 10:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235108AbiAJPoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641829462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GwsjTdK6v2LnBFhWI+JJOy9OQSY+yI1I9CwqbFn3SQ=;
        b=BBe4NaoKQSbWyzM93tQDsHo2EmSH51X5nnoZWp5KwDypX/ekOsoHDd7XDz+dTiWJ6R4jDO
        ZjbTtht5MYmc7FRRkiiVF79G+poA9M1GyIjY9wC+93DDqcgFLE91hz+czZQhxoMpaDB6pn
        AGkgOu6dPrY5MLVMPX8CGLZgv99WFes=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-_MKjntZGOLWaEuCYLjfnIA-1; Mon, 10 Jan 2022 10:44:21 -0500
X-MC-Unique: _MKjntZGOLWaEuCYLjfnIA-1
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b003458e02cea0so9098550wms.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 07:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1GwsjTdK6v2LnBFhWI+JJOy9OQSY+yI1I9CwqbFn3SQ=;
        b=QphqpW6GDb/v4W4QhPmZ+MGIrfICE5nHGsiacrECC3gLlPXtOGa1HO+MHplhmqG0rP
         NDyls67WYqHQr4gTvN/9d0qEDsCMS3CejwMgRXseeCbYsO24bpO+V3g+Tx5ej7Hnzfii
         gevXdNG5NL1HxMtnh6Vv/k+SFvy6rNsjvRoK3UYkUR7R5+PPRrIPx9L8feWuw0RXltfz
         Xh3wOdMHw+gT+zV9QJ0yh1xEQdGpy/aC+n83hqquB7FYmLEjMlmif/tw2uupGiulltYs
         5+twLPplC7mS6p/AUR54PpJBV0VZoa++NDLQJBW5+S5q3cQ4b9emFvvXgvd9D4jfq+N3
         dGgQ==
X-Gm-Message-State: AOAM5306BfWFGqImtWXWIn1Ae7GqCSFTW4GzJ4BwEjQ/um4MfU05lsEd
        FwkVdGepc7qp243Bt0uIrhCkF9V66FRDNsI9iPZ66bBAEXjZPNK0tMO7SIscHBOCbm6PPgBn/i+
        fmvQmj69sQxewCqu9NxQ+E8QORg==
X-Received: by 2002:adf:f807:: with SMTP id s7mr184314wrp.638.1641829460439;
        Mon, 10 Jan 2022 07:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGlziNjGEYg/AKCCVR6dHJcBIW6ndhJ3HU0fYXJaw1aGDnRw1EG3ab/feKEGmla/24mvGOMw==
X-Received: by 2002:adf:f807:: with SMTP id s7mr184278wrp.638.1641829460157;
        Mon, 10 Jan 2022 07:44:20 -0800 (PST)
Received: from redhat.com ([2.55.148.228])
        by smtp.gmail.com with ESMTPSA id s1sm6891060wmh.35.2022.01.10.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 07:44:19 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:44:14 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
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
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Joe Perches <joe@perches.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 00/13] Introduce VDUSE - vDPA Device in Userspace
Message-ID: <20220110103938-mutt-send-email-mst@kernel.org>
References: <20210830141737.181-1-xieyongji@bytedance.com>
 <20220110075546-mutt-send-email-mst@kernel.org>
 <CACycT3v1aEViw7vV4x5qeGVPrSrO-BTDvQshEX35rx_X0Au2vw@mail.gmail.com>
 <20220110100911-mutt-send-email-mst@kernel.org>
 <CACycT3v6jo3-8ATWUzf659vV94a2oRrm-zQtGNDZd6OQr-MENA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACycT3v6jo3-8ATWUzf659vV94a2oRrm-zQtGNDZd6OQr-MENA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:24:40PM +0800, Yongji Xie wrote:
> On Mon, Jan 10, 2022 at 11:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jan 10, 2022 at 09:54:08PM +0800, Yongji Xie wrote:
> > > On Mon, Jan 10, 2022 at 8:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Aug 30, 2021 at 10:17:24PM +0800, Xie Yongji wrote:
> > > > > This series introduces a framework that makes it possible to implement
> > > > > software-emulated vDPA devices in userspace. And to make the device
> > > > > emulation more secure, the emulated vDPA device's control path is handled
> > > > > in the kernel and only the data path is implemented in the userspace.
> > > > >
> > > > > Since the emuldated vDPA device's control path is handled in the kernel,
> > > > > a message mechnism is introduced to make userspace be aware of the data
> > > > > path related changes. Userspace can use read()/write() to receive/reply
> > > > > the control messages.
> > > > >
> > > > > In the data path, the core is mapping dma buffer into VDUSE daemon's
> > > > > address space, which can be implemented in different ways depending on
> > > > > the vdpa bus to which the vDPA device is attached.
> > > > >
> > > > > In virtio-vdpa case, we implements a MMU-based software IOTLB with
> > > > > bounce-buffering mechanism to achieve that. And in vhost-vdpa case, the dma
> > > > > buffer is reside in a userspace memory region which can be shared to the
> > > > > VDUSE userspace processs via transferring the shmfd.
> > > > >
> > > > > The details and our user case is shown below:
> > > > >
> > > > > ------------------------    -------------------------   ----------------------------------------------
> > > > > |            Container |    |              QEMU(VM) |   |                               VDUSE daemon |
> > > > > |       ---------      |    |  -------------------  |   | ------------------------- ---------------- |
> > > > > |       |dev/vdx|      |    |  |/dev/vhost-vdpa-x|  |   | | vDPA device emulation | | block driver | |
> > > > > ------------+-----------     -----------+------------   -------------+----------------------+---------
> > > > >             |                           |                            |                      |
> > > > >             |                           |                            |                      |
> > > > > ------------+---------------------------+----------------------------+----------------------+---------
> > > > > |    | block device |           |  vhost device |            | vduse driver |          | TCP/IP |    |
> > > > > |    -------+--------           --------+--------            -------+--------          -----+----    |
> > > > > |           |                           |                           |                       |        |
> > > > > | ----------+----------       ----------+-----------         -------+-------                |        |
> > > > > | | virtio-blk driver |       |  vhost-vdpa driver |         | vdpa device |                |        |
> > > > > | ----------+----------       ----------+-----------         -------+-------                |        |
> > > > > |           |      virtio bus           |                           |                       |        |
> > > > > |   --------+----+-----------           |                           |                       |        |
> > > > > |                |                      |                           |                       |        |
> > > > > |      ----------+----------            |                           |                       |        |
> > > > > |      | virtio-blk device |            |                           |                       |        |
> > > > > |      ----------+----------            |                           |                       |        |
> > > > > |                |                      |                           |                       |        |
> > > > > |     -----------+-----------           |                           |                       |        |
> > > > > |     |  virtio-vdpa driver |           |                           |                       |        |
> > > > > |     -----------+-----------           |                           |                       |        |
> > > > > |                |                      |                           |    vdpa bus           |        |
> > > > > |     -----------+----------------------+---------------------------+------------           |        |
> > > > > |                                                                                        ---+---     |
> > > > > -----------------------------------------------------------------------------------------| NIC |------
> > > > >                                                                                          ---+---
> > > > >                                                                                             |
> > > > >                                                                                    ---------+---------
> > > > >                                                                                    | Remote Storages |
> > > > >                                                                                    -------------------
> > > > >
> > > > > We make use of it to implement a block device connecting to
> > > > > our distributed storage, which can be used both in containers and
> > > > > VMs. Thus, we can have an unified technology stack in this two cases.
> > > > >
> > > > > To test it with null-blk:
> > > > >
> > > > >   $ qemu-storage-daemon \
> > > > >       --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
> > > > >       --monitor chardev=charmonitor \
> > > > >       --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 \
> > > > >       --export type=vduse-blk,id=test,node-name=disk0,writable=on,name=vduse-null,num-queues=16,queue-size=128
> > > > >
> > > > > The qemu-storage-daemon can be found at https://github.com/bytedance/qemu/tree/vduse
> > > >
> > > > It's been half a year - any plans to upstream this?
> > >
> > > Yeah, this is on my to-do list this month.
> > >
> > > Sorry for taking so long... I've been working on another project
> > > enabling userspace RDMA with VDUSE for the past few months. So I
> > > didn't have much time for this. Anyway, I will submit the first
> > > version as soon as possible.
> > >
> > > Thanks,
> > > Yongji
> >
> > Oh fun. You mean like virtio-rdma? Or RDMA as a backend for regular
> > virtio?
> >
> 
> Yes, like virtio-rdma. Then we can develop something like userspace
> rxe、siw or custom protocol with VDUSE.
> 
> Thanks,
> Yongji

Would be interesting to see the spec for that.
The issues with RDMA revolved around the fact that current
apps tend to either use non-standard propocols for connection
establishment or use UD where there's IIRC no standard
at all. So QP numbers are hard to virtualize.
Similarly many use LIDs directly with the same effect.
GUIDs might be virtualizeable but no one went to the effort.

To say nothing about the interaction with memory overcommit.

-- 
MST

