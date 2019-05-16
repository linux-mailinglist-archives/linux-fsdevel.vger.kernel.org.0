Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13161FF8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 08:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEPG2Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 02:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfEPG2Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 02:28:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21F1B3DDBE;
        Thu, 16 May 2019 06:28:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F29145D9C3;
        Thu, 16 May 2019 06:28:22 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 973501806B11;
        Thu, 16 May 2019 06:28:21 +0000 (UTC)
Date:   Thu, 16 May 2019 02:28:20 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        KVM list <kvm@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christoph Hellwig <hch@infradead.org>,
        Len Brown <lenb@kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        david <david@fromorbit.com>, cohuck@redhat.com,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Adam Borowski <kilobyte@angband.pl>,
        yuval shaia <yuval.shaia@oracle.com>, jstaron@google.com
Message-ID: <1906905099.29162562.1557988100975.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gEr_zPJEQp3k89v2UXfHp9PQwnJXY+W99HwXfxpvua_w@mail.gmail.com>
References: <20190514145422.16923-1-pagupta@redhat.com> <20190514145422.16923-2-pagupta@redhat.com> <CAPcyv4gEr_zPJEQp3k89v2UXfHp9PQwnJXY+W99HwXfxpvua_w@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] libnvdimm: nd_region flush callback support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.65.16.97, 10.4.195.4]
Thread-Topic: libnvdimm: nd_region flush callback support
Thread-Index: VrjlK3y+QUdLL94hHE7OyUkrop5Ojw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 16 May 2019 06:28:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> >
> > This patch adds functionality to perform flush from guest
> > to host over VIRTIO. We are registering a callback based
> > on 'nd_region' type. virtio_pmem driver requires this special
> > flush function. For rest of the region types we are registering
> > existing flush function. Report error returned by host fsync
> > failure to userspace.
> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/acpi/nfit/core.c     |  4 ++--
> >  drivers/nvdimm/claim.c       |  6 ++++--
> >  drivers/nvdimm/nd.h          |  1 +
> >  drivers/nvdimm/pmem.c        | 13 ++++++++-----
> >  drivers/nvdimm/region_devs.c | 26 ++++++++++++++++++++++++--
> >  include/linux/libnvdimm.h    |  8 +++++++-
> >  6 files changed, 46 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 5a389a4f4f65..08dde76cf459 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -2434,7 +2434,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_blk,
> > unsigned int bw,
> >                 offset = to_interleave_offset(offset, mmio);
> >
> >         writeq(cmd, mmio->addr.base + offset);
> > -       nvdimm_flush(nfit_blk->nd_region);
> > +       nvdimm_flush(nfit_blk->nd_region, NULL);
> >
> >         if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
> >                 readq(mmio->addr.base + offset);
> > @@ -2483,7 +2483,7 @@ static int acpi_nfit_blk_single_io(struct nfit_blk
> > *nfit_blk,
> >         }
> >
> >         if (rw)
> > -               nvdimm_flush(nfit_blk->nd_region);
> > +               nvdimm_flush(nfit_blk->nd_region, NULL);
> >
> >         rc = read_blk_stat(nfit_blk, lane) ? -EIO : 0;
> >         return rc;
> > diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> > index fb667bf469c7..13510bae1e6f 100644
> > --- a/drivers/nvdimm/claim.c
> > +++ b/drivers/nvdimm/claim.c
> > @@ -263,7 +263,7 @@ static int nsio_rw_bytes(struct nd_namespace_common
> > *ndns,
> >         struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
> >         unsigned int sz_align = ALIGN(size + (offset & (512 - 1)), 512);
> >         sector_t sector = offset >> 9;
> > -       int rc = 0;
> > +       int rc = 0, ret = 0;
> >
> >         if (unlikely(!size))
> >                 return 0;
> > @@ -301,7 +301,9 @@ static int nsio_rw_bytes(struct nd_namespace_common
> > *ndns,
> >         }
> >
> >         memcpy_flushcache(nsio->addr + offset, buf, size);
> > -       nvdimm_flush(to_nd_region(ndns->dev.parent));
> > +       ret = nvdimm_flush(to_nd_region(ndns->dev.parent), NULL);
> > +       if (ret)
> > +               rc = ret;
> >
> >         return rc;
> >  }
> > diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> > index a5ac3b240293..0c74d2428bd7 100644
> > --- a/drivers/nvdimm/nd.h
> > +++ b/drivers/nvdimm/nd.h
> > @@ -159,6 +159,7 @@ struct nd_region {
> >         struct badblocks bb;
> >         struct nd_interleave_set *nd_set;
> >         struct nd_percpu_lane __percpu *lane;
> > +       int (*flush)(struct nd_region *nd_region, struct bio *bio);
> 
> So this triggers:
> 
> In file included from drivers/nvdimm/e820.c:7:
> ./include/linux/libnvdimm.h:140:51: warning: ‘struct bio’ declared
> inside parameter list will not be visible outside of this definition
> or declaration
>   int (*flush)(struct nd_region *nd_region, struct bio *bio);
>                                                    ^~~

Sorry! for this. Fixed now.

> I was already feeling uneasy about trying to squeeze this into v5.2,
> but this warning and the continued drip of comments leads me to
> conclude that this driver would do well to wait one more development
> cycle. Lets close out the final fixups and let this driver soak in
> -next. Then for the v5.3 cycle I'll redouble my efforts towards the
> goal of closing patch acceptance at the -rc6 / -rc7 development
> milestone.

o.k. Will wait for Mike's ACK on device mapper patch and send the v10
with final fix-ups. Thank you for your help.

Best regards,
Pankaj



> 
