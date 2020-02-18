Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0233E163562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBRVtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:49:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52561 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727996AbgBRVtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582062547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1p+PXNm2PJYLW1uVQOTPJCQ5UcLMDsrk6u8/ZoFcnWE=;
        b=Pd7wrAR9rNSCSPQZBjNbXP7hMfeAJ/IUJFUKrg6g3B49tckuwkU/xdjIUxFHm8GvRzbqIy
        em2gnKrhXFif+qIVel6X1hHBiUrBDEVH0vOooDtQMvJmVmZuF9anNipNVBA9OA+W+YxXG7
        xbzbDHv2KlXZVSDAU8LRY5mEk42Gy10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-Cb2kwYg5MtaqK_KBzRzjrA-1; Tue, 18 Feb 2020 16:48:57 -0500
X-MC-Unique: Cb2kwYg5MtaqK_KBzRzjrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB46010CE784;
        Tue, 18 Feb 2020 21:48:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08AC790534;
        Tue, 18 Feb 2020 21:48:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8A4B52257D2; Tue, 18 Feb 2020 16:48:52 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, vishal.l.verma@intel.com, vgoyal@redhat.com
Subject: [PATCH v5 0/8] dax/pmem: Provide a dax operation to zero range of memory
Date:   Tue, 18 Feb 2020 16:48:33 -0500
Message-Id: <20200218214841.10076-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,=20

This is V5 of patches. These patches are also available at.

https://github.com/rhvgoyal/linux/commits/dax-zero-range-v5

Changes since V4:

- Rebased on top of 5.6-rc2
- Added a separate patch so that pmem_clear_poison() accepts arbitrary
  offset and len and aligns these as needed. This takes away the burden
  of aligning from callers.

Previous versions of patches are here.
v4:
https://lore.kernel.org/linux-fsdevel/20200217181653.4706-1-vgoyal@redhat=
.com/
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

Vivek Goyal (8):
  pmem: Add functions for reading/writing page to/from pmem
  drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and
    len
  pmem: Enable pmem_do_write() to deal with arbitrary ranges
  dax, pmem: Add a dax operation zero_page_range
  s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
  dm,dax: Add dax zero_page_range operation
  dax,iomap: Start using dax native zero_page_range()
  dax,iomap: Add helper dax_iomap_zero() to zero a range

 drivers/dax/super.c           |  19 +++++
 drivers/md/dm-linear.c        |  21 ++++++
 drivers/md/dm-log-writes.c    |  19 +++++
 drivers/md/dm-stripe.c        |  26 +++++++
 drivers/md/dm.c               |  31 ++++++++
 drivers/nvdimm/pmem.c         | 134 +++++++++++++++++++++++-----------
 drivers/s390/block/dcssblk.c  |  17 +++++
 fs/dax.c                      |  53 ++++----------
 fs/iomap/buffered-io.c        |   9 +--
 include/linux/dax.h           |  20 ++---
 include/linux/device-mapper.h |   3 +
 11 files changed, 246 insertions(+), 106 deletions(-)

--=20
2.20.1

