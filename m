Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82CA1A0DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfEJP7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 11:59:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEJP7z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 11:59:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B85A930842D1;
        Fri, 10 May 2019 15:59:54 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E5421FC;
        Fri, 10 May 2019 15:59:54 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 76BC33FB10;
        Fri, 10 May 2019 15:59:54 +0000 (UTC)
Date:   Fri, 10 May 2019 11:59:53 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Adam Borowski <kilobyte@angband.pl>, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, david <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm <linux-nvdimm@lists.01.org>
Message-ID: <1582528207.27988270.1557503993894.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4jPF70QECzpgDCwzasJT38eOqG9tfQRbo37OWg+YzGu_w@mail.gmail.com>
References: <20190429172649.8288-13-rgoldwyn@suse.de> <20190510153222.24665-1-kilobyte@angband.pl> <CAPcyv4jPF70QECzpgDCwzasJT38eOqG9tfQRbo37OWg+YzGu_w@mail.gmail.com>
Subject: Re: [PATCH for-goldwyn] btrfs: disallow MAP_SYNC outside of DAX
 mounts
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.148, 10.4.195.16]
Thread-Topic: btrfs: disallow MAP_SYNC outside of DAX mounts
Thread-Index: R9x6cQ2xHivFBl+OL2QrtCwDPNR03Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 10 May 2019 15:59:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> >
> > Even if allocation is done synchronously, data would be lost except on
> > actual pmem.  Explicit msync()s don't need MAP_SYNC, and don't require
> > a sync per page.
> >
> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > ---
> > MAP_SYNC can't be allowed unconditionally, as cacheline flushes don't help
> > guarantee persistency in page cache.  This fixes an error in my earlier
> > patch "btrfs: allow MAP_SYNC mmap" -- you'd probably want to amend that.
> >
> >
> >  fs/btrfs/file.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 362a9cf9dcb2..0bc5428037ba 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -2233,6 +2233,13 @@ static int btrfs_file_mmap(struct file   *filp,
> > struct vm_area_struct *vma)
> >         if (!IS_DAX(inode) && !mapping->a_ops->readpage)
> >                 return -ENOEXEC;
> >
> > +       /*
> > +        * Normal operation of btrfs is pretty much an antithesis of
> > MAP_SYNC;
> > +        * supporting it outside DAX is pointless.
> > +        */
> > +       if (!IS_DAX(inode) && (vma->vm_flags & VM_SYNC))
> > +               return -EOPNOTSUPP;
> > +
> 
> If the virtio-pmem patch set goes upstream prior to btrfs-dax support
> this will need to switch over to the new daxdev_mapping_supported()
> helper.

I was planning to do changes for virtio pmem & BTRFS. I was waiting for 
DAX support for BTRFS to merge upstream.

Thank you,
Pankaj 
 
> 
> https://lore.kernel.org/lkml/20190426050039.17460-5-pagupta@redhat.com/
> 
