Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA98189AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 14:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEIMY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 08:24:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfEIMY0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 08:24:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D91C307D98F;
        Thu,  9 May 2019 12:24:26 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA6435C226;
        Thu,  9 May 2019 12:24:25 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 257BD41F58;
        Thu,  9 May 2019 12:24:25 +0000 (UTC)
Date:   Thu, 9 May 2019 08:24:24 -0400 (EDT)
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
        Paolo Bonzini <pbonzini@redhat.com>, kilobyte@angband.pl,
        yuval shaia <yuval.shaia@oracle.com>
Message-ID: <511098535.27565704.1557404664499.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4hRdvypEj4LBTMfUFm80BdpRYbOugrkkj-3Kk_LErXPqQ@mail.gmail.com>
References: <20190426050039.17460-1-pagupta@redhat.com> <20190426050039.17460-4-pagupta@redhat.com> <CAPcyv4hRdvypEj4LBTMfUFm80BdpRYbOugrkkj-3Kk_LErXPqQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] libnvdimm: add dax_dev sync flag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.88, 10.4.195.16]
Thread-Topic: libnvdimm: add dax_dev sync flag
Thread-Index: ojaRi4mgEPnvOvl3Gx+91mTiXiceZg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 09 May 2019 12:24:26 +0000 (UTC)
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
> [..]
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index 0dd316a74a29..c97fc0cc7167 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -7,6 +7,9 @@
> >  #include <linux/radix-tree.h>
> >  #include <asm/pgtable.h>
> >
> > +/* Flag for synchronous flush */
> > +#define DAXDEV_F_SYNC true
> 
> I'd feel better, i.e. it reads more canonically, if this was defined
> as (1UL << 0) and the argument to alloc_dax() was changed to 'unsigned
> long flags' rather than a bool.

Sure, Will send a v8 with suggested changes.

Thank You,
Pankaj

> 
