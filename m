Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A3161993
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgBQSRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:17:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39814 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729869AbgBQSRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581963441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QLSHE2VWqBfvikw59u2hpmf5ebtQkqK0yTUskCOtUmM=;
        b=QIun2OyLn9LbQCTkmHDMWJ1ACk+ftm8AOJ3dkXZHcSz0pOWYncvU+X5nDIeQT/roAUc5/k
        NnvC14zkraw17cbRG6K/jShiqaXMMI31uOUAyCANIsti56/HvPnIF5tIq/ohO7j1mgBkUb
        EFgoijuGTFntuqdCiPpm4zS7fHJSdXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-cLXb4cAzMSOrhSq6EHDIoA-1; Mon, 17 Feb 2020 13:17:12 -0500
X-MC-Unique: cLXb4cAzMSOrhSq6EHDIoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DCA3140A;
        Mon, 17 Feb 2020 18:17:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5919E60BFB;
        Mon, 17 Feb 2020 18:17:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id F04EB2257D2; Mon, 17 Feb 2020 13:17:07 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, vishal.l.verma@intel.com, vgoyal@redhat.com
Subject: [PATCH v4 0/7] dax/pmem: Provide a dax operation to zero range of memory
Date:   Mon, 17 Feb 2020 13:16:46 -0500
Message-Id: <20200217181653.4706-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V4 of patches. These patches are also available at.

https://github.com/rhvgoyal/linux/commits/dax-zero-range-v4

Changes since V3.

- Rebased patches on top of 5.6-rc1
- Took care of some of the comments from Christoph.
- Captured some Reviewed-by tags in some of the patches. =20

Previous version of patches are here.
v3:
https://lore.kernel.org/linux-fsdevel/20200214125717.GA18654@redhat.com/T=
/#t
v2:
https://lore.kernel.org/linux-fsdevel/20200203200029.4592-1-vgoyal@redhat=
.com/
v1:
https://lore.kernel.org/linux-fsdevel/20200123165249.GA7664@redhat.com/

Thanks
Vivek

Vivek Goyal (7):
  pmem: Add functions for reading/writing page to/from pmem
  pmem: Enable pmem_do_write() to deal with arbitrary ranges
  dax, pmem: Add a dax operation zero_page_range
  s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
  dm,dax: Add dax zero_page_range operation
  dax,iomap: Start using dax native zero_page_range()
  dax,iomap: Add helper dax_iomap_zero() to zero a range

 drivers/dax/super.c           |  19 ++++++
 drivers/md/dm-linear.c        |  21 +++++++
 drivers/md/dm-log-writes.c    |  19 ++++++
 drivers/md/dm-stripe.c        |  26 ++++++++
 drivers/md/dm.c               |  31 +++++++++
 drivers/nvdimm/pmem.c         | 115 +++++++++++++++++++++++-----------
 drivers/s390/block/dcssblk.c  |  17 +++++
 fs/dax.c                      |  53 ++++------------
 fs/iomap/buffered-io.c        |   9 +--
 include/linux/dax.h           |  20 ++----
 include/linux/device-mapper.h |   3 +
 11 files changed, 233 insertions(+), 100 deletions(-)

--=20
2.20.1

