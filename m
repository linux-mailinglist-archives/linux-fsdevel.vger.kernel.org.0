Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28A44659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfFMQu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbfFMDmZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92B14B0ABB;
        Thu, 13 Jun 2019 03:42:24 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CCCD5DA34;
        Thu, 13 Jun 2019 03:42:24 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 300A31806B16;
        Thu, 13 Jun 2019 03:42:19 +0000 (UTC)
Date:   Wed, 12 Jun 2019 23:42:18 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     rdunlap@infradead.org, jack@suse.cz, kvm@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com, david@fromorbit.com,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
        dm-devel@redhat.com, adilger kernel <adilger.kernel@dilger.ca>,
        zwisler@kernel.org, aarcange@redhat.com,
        dave jiang <dave.jiang@intel.com>, jstaron@google.com,
        linux-nvdimm@lists.01.org,
        vishal l verma <vishal.l.verma@intel.com>, david@redhat.com,
        willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org,
        jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org,
        kilobyte@angband.pl, riel@surriel.com,
        yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com,
        pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>,
        lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
        tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        snitzer@redhat.com, darrick wong <darrick.wong@oracle.com>,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        imammedo@redhat.com
Message-ID: <165204827.34945594.1560397338620.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190612162012.06b4af7f.cohuck@redhat.com>
References: <20190612124527.3763-1-pagupta@redhat.com> <20190612124527.3763-3-pagupta@redhat.com> <20190612162012.06b4af7f.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 2/7] virtio-pmem: Add virtio pmem
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.133, 10.4.195.21]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: fhRQKNWPndesm/uRD8iV/XnY9gJKfQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 13 Jun 2019 03:42:24 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> 
> > This patch adds virtio-pmem driver for KVM guest.
> > 
> > Guest reads the persistent memory range information from
> > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > creates a nd_region object with the persistent memory
> > range information so that existing 'nvdimm/pmem' driver
> > can reserve this into system memory map. This way
> > 'virtio-pmem' driver uses existing functionality of pmem
> > driver to register persistent memory compatible for DAX
> > capable filesystems.
> > 
> > This also provides function to perform guest flush over
> > VIRTIO from 'pmem' driver when userspace performs flush
> > on DAX memory range.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Jakub Staron <jstaron@google.com>
> > Tested-by: Jakub Staron <jstaron@google.com>
> > ---
> >  drivers/nvdimm/Makefile          |   1 +
> >  drivers/nvdimm/nd_virtio.c       | 125 +++++++++++++++++++++++++++++++
> >  drivers/nvdimm/virtio_pmem.c     | 122 ++++++++++++++++++++++++++++++
> >  drivers/nvdimm/virtio_pmem.h     |  55 ++++++++++++++
> >  drivers/virtio/Kconfig           |  11 +++
> >  include/uapi/linux/virtio_ids.h  |   1 +
> >  include/uapi/linux/virtio_pmem.h |  35 +++++++++
> >  7 files changed, 350 insertions(+)
> >  create mode 100644 drivers/nvdimm/nd_virtio.c
> >  create mode 100644 drivers/nvdimm/virtio_pmem.c
> >  create mode 100644 drivers/nvdimm/virtio_pmem.h
> >  create mode 100644 include/uapi/linux/virtio_pmem.h
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thank you Cornelia for the review.

Best regards,
Pankaj
> 
> 
