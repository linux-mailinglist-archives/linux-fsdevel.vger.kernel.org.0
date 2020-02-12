Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A215AE24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 18:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgBLRID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 12:08:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728410AbgBLRIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581527278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uVtVcsiKhkuKKf+gRgkYGjwkWDveu2K52NRmmgOy/F0=;
        b=JgKFBE/+dnsXhH2r9vBJypHWD+ZJdagUdWJN2rFC96VpLGAWaR2CCimDc4gQecyKZWxTos
        rx/AW9yxn+OpHb6TXzJg1POHMplhEbxPB+4a2iUwqmzYD4zNzFSQEDGzYHgRhx1QnoFeGH
        eKqUu8G+XrnsY9dcooVXFSQB4GeBg0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-w09-80CIMHqzsasM6BehBw-1; Wed, 12 Feb 2020 12:07:51 -0500
X-MC-Unique: w09-80CIMHqzsasM6BehBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD1EDBA5;
        Wed, 12 Feb 2020 17:07:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2445C89F30;
        Wed, 12 Feb 2020 17:07:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AAF6C220A24; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, dm-devel@redhat.com, jack@suse.cz
Subject: [RFC PATCH 0/6] dax: Replace bdev_dax_pgoff() with dax_pgoff()
Date:   Wed, 12 Feb 2020 12:07:27 -0500
Message-Id: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently dax code assumes that there is always a block device
associated with it. And block device is passed around in few routines. I
am implementing DAX support for virtiofs and there is no block device
while we are using dax device. So I need dax code to move away from
this assumption that there is always a block device.

We seem to pass around block deivce only to calculate the partition
offset into dax device. bdev_dax_pgoff() does get_start_sect(bdev).

There are two proposed solutions to this problem.

- Get rid of kernel partition support for pmem devices.

- Caller stores offset into dax device and passes that in along with
  dax_device.

First solution was discussed recently in this thread.

https://lore.kernel.org/linux-fsdevel/20200107125159.GA15745@infradead.or=
g/

I feel we already shipped partition support for dax block devices and
going back now will be painful and its easy to break users out there
which are using partitions.

Hence I thought of writing patches for second proposal and see how bad
it looks. To me patches are fairly small and don't break backward=20
compatibility and seem like a good step in the direction of removing
dax assumptions about block device.

So I am posting this RFC patch series, which is just boot tested.

Any feedback or comments are welcome.

Thanks
Vivek
=20

Vivek Goyal (6):
  dax: Define a helper dax_pgoff() which takes in dax_offset as argument
  dax,iomap,ext4,ext2,xfs: Save dax_offset in "struct iomap"
  fs/dax.c: Start using dax_pgoff() instead of bdev_dax_pgoff()
  dax, dm/md: Use dax_pgoff() instead of bdev_dax_pgoff()
  drivers/dax: Use dax_pgoff() instead of bdev_dax_pgoff()
  dax: Remove bdev_dax_pgoff() helper

 drivers/dax/super.c        | 11 +++++------
 drivers/md/dm-linear.c     |  9 ++++++---
 drivers/md/dm-log-writes.c |  9 ++++++---
 drivers/md/dm-stripe.c     |  8 +++++---
 fs/dax.c                   | 13 ++++++-------
 fs/ext2/inode.c            |  1 +
 fs/ext4/inode.c            |  1 +
 fs/xfs/xfs_iomap.c         |  2 ++
 include/linux/dax.h        |  2 +-
 include/linux/iomap.h      |  1 +
 10 files changed, 34 insertions(+), 23 deletions(-)

--=20
2.20.1

