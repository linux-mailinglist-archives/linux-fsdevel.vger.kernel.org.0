Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41C71510A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 21:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBCUBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 15:01:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22345 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726971AbgBCUBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580760068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mq7eC6RWo7NxMEeb9FO/cFzew1eeG07ZdDsPtcMILro=;
        b=gj12A0MmruPEIyOBWrQ4ah4bIzd0HfSQaY5H/RPXZom102kPD1ivbSJYQFx6DcQa49XoeC
        ijJZaISJ/OBZ3zr7ajeRcXDGMO+PgB1Y5rybkiq1M2fBI9R3GJUGiuCe6cAL04eMEdzr32
        TZ77d4F0VEEe73Kof9APPiidZyEWik0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-uWyTju_KPoeAry3qqPmknA-1; Mon, 03 Feb 2020 15:00:50 -0500
X-MC-Unique: uWyTju_KPoeAry3qqPmknA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04E7E800D41;
        Mon,  3 Feb 2020 20:00:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 701831001B09;
        Mon,  3 Feb 2020 20:00:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 058A92202E9; Mon,  3 Feb 2020 15:00:45 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, vishal.l.verma@intel.com, dm-devel@redhat.com
Subject: [RFC PATCH 0/5][V2] dax,pmem: Provide a dax operation to zero range of memory
Date:   Mon,  3 Feb 2020 15:00:24 -0500
Message-Id: <20200203200029.4592-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V2 of patches. I posted V1 here.

https://lore.kernel.org/linux-fsdevel/20200123165249.GA7664@redhat.com/

Changes since V1.
- Took care of feedback from Christoph.
- Made ->zero_page_range() mandatory operation.
- Provided a generic helper to zero range for non-pmem drivers.
- Merged __dax_zero_page_range() and iomap_dax_zero()
- Made changes to dm drivers.
- Limited range zeroing to with-in single page.
- Tested patches with real hardware. =20

description
-----------
This is an RFC patch series to provide a dax operation to zero a range of
memory. It will also clear poison in the process.

Motivation from this patch comes from Christoph's feedback that he will
rather prefer a dax way to zero a range instead of relying on having to
call blkdev_issue_zeroout() in __dax_zero_page_range().

https://lkml.org/lkml/2019/8/26/361

My motivation for this change is virtiofs DAX support. There we use DAX
but we don't have a block device. So any dax code which has the assumptio=
n
that there is always a block device associated is a problem. So this
is more of a cleanup of one of the places where dax has this dependency
on block device and if we add a dax operation for zeroing a range, it
can help with not having to call blkdev_issue_zeroout() in dax path.

Thanks
Vivek

Vivek Goyal (5):
  dax, pmem: Add a dax operation zero_page_range
  s390,dax: Add dax zero_page_range operation to dcssblk driver
  dm,dax: Add dax zero_page_range operation
  dax,iomap: Start using dax native zero_page_range()
  dax,iomap: Add helper dax_iomap_zero() to zero a range

 drivers/dax/super.c           | 20 ++++++++++++
 drivers/md/dm-linear.c        | 18 +++++++++++
 drivers/md/dm-log-writes.c    | 17 ++++++++++
 drivers/md/dm-stripe.c        | 23 ++++++++++++++
 drivers/md/dm.c               | 30 ++++++++++++++++++
 drivers/nvdimm/pmem.c         | 50 +++++++++++++++++++++++++++++
 drivers/s390/block/dcssblk.c  |  7 ++++
 fs/dax.c                      | 60 ++++++++++++++---------------------
 fs/iomap/buffered-io.c        |  9 +-----
 include/linux/dax.h           | 17 ++++++----
 include/linux/device-mapper.h |  3 ++
 11 files changed, 204 insertions(+), 50 deletions(-)

--=20
2.18.1

