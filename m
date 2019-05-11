Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387101A5E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 02:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfEKApw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 20:45:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbfEKApv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 20:45:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 264E2DF23;
        Sat, 11 May 2019 00:45:51 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D99122CFE6;
        Sat, 11 May 2019 00:45:50 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3309B41F56;
        Sat, 11 May 2019 00:45:50 +0000 (UTC)
Date:   Fri, 10 May 2019 20:45:49 -0400 (EDT)
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
Message-ID: <864186878.28040999.1557535549792.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
References: <20190510155202.14737-1-pagupta@redhat.com> <20190510155202.14737-4-pagupta@redhat.com> <CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] libnvdimm: add dax_dev sync flag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.14, 10.4.195.12]
Thread-Topic: libnvdimm: add dax_dev sync flag
Thread-Index: gVGO0BoaDll3U20KXC407XNgj3ThLg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 11 May 2019 00:45:51 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> >
> > This patch adds 'DAXDEV_SYNC' flag which is set
> > for nd_region doing synchronous flush. This later
> > is used to disable MAP_SYNC functionality for
> > ext4 & xfs filesystem for devices don't support
> > synchronous flush.
> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/dax/bus.c            |  2 +-
> >  drivers/dax/super.c          | 13 ++++++++++++-
> >  drivers/md/dm.c              |  3 ++-
> >  drivers/nvdimm/pmem.c        |  5 ++++-
> >  drivers/nvdimm/region_devs.c |  7 +++++++
> >  include/linux/dax.h          |  8 ++++++--
> >  include/linux/libnvdimm.h    |  1 +
> >  7 files changed, 33 insertions(+), 6 deletions(-)
> [..]
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index 043f0761e4a0..ee007b75d9fd 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1969,7 +1969,8 @@ static struct mapped_device *alloc_dev(int minor)
> >         sprintf(md->disk->disk_name, "dm-%d", minor);
> >
> >         if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
> > -               dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops);
> > +               dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops,
> > +                                                        DAXDEV_F_SYNC);
> 
> Apologies for not realizing this until now, but this is broken.
> Imaging a device-mapper configuration composed of both 'async'
> virtio-pmem and 'sync' pmem. The 'sync' flag needs to be unified
> across all members. I would change this argument to '0' and then
> arrange for it to be set at dm_table_supports_dax() time after
> validating that all components support synchronous dax.

o.k. Need to set 'DAXDEV_F_SYNC' flag after verifying all the target
components support synchronous DAX.

Just a question, If device mapper configuration have composed of both 
virtio-pmem or pmem devices, we want to configure device mapper for async flush?

Thank you,
Pankaj 
> 
