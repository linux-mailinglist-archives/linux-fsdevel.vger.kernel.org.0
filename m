Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE88C173D03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 17:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgB1QfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 11:35:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24969 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgB1QfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582907719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fHdhFTbN6MmSbeB96emcKmmClPxoPnJtYjBRwbsxQXA=;
        b=VPjMrldeCywOSzJwshJiVFxDMK9ko15lvARkt2+Sg7KJt6xrq2DbToeL6YF94gsuuVP6nw
        77rxBlV2GgexnmIWsP30J+DEL3t0YNdrQLDiJ1HnGLoSIqOUJ6/tEL7ZDvVysoacxt6s8H
        M0X1mrrhLywbpdWrkDTAXsdXcUwcShI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-Q4Rf6BBGOCyJsuNU7mjueg-1; Fri, 28 Feb 2020 11:35:15 -0500
X-MC-Unique: Q4Rf6BBGOCyJsuNU7mjueg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12855107ACC5;
        Fri, 28 Feb 2020 16:35:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B48A90F5B;
        Fri, 28 Feb 2020 16:35:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BED052257D2; Fri, 28 Feb 2020 11:35:10 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     vgoyal@redhat.com, david@fromorbit.com, jmoyer@redhat.com,
        dm-devel@redhat.com
Subject: [PATCH v6 0/6] dax/pmem: Provide a dax operation to zero page range
Date:   Fri, 28 Feb 2020 11:34:50 -0500
Message-Id: <20200228163456.1587-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V6 of patches. These patches are also available at.

Changes since V5:

- Dan Williams preferred ->zero_page_range() to only accept PAGE_SIZE
  aligned request and clear poison only on page size aligned zeroing. So
  I changed it accordingly.=20

- Dropped all the modifications which were required to support arbitrary
  range zeroing with-in a page.

- This patch series also fixes the issue where "truncate -s 512 foo.txt"
  will fail if first sector of file is poisoned. Currently it succeeds
  and filesystem expectes whole of the filesystem block to be free of
  poison at the end of the operation.

Christoph, I have dropped your Reviewed-by tag on 1-2 patches because
these patches changed substantially. Especially signature of of
dax zero_page_range() helper.

Thanks
Vivek

Vivek Goyal (6):
  pmem: Add functions for reading/writing page to/from pmem
  dax, pmem: Add a dax operation zero_page_range
  s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
  dm,dax: Add dax zero_page_range operation
  dax: Use new dax zero page method for zeroing a page
  dax,iomap: Add helper dax_iomap_zero() to zero a range

 drivers/dax/super.c           | 20 ++++++++
 drivers/md/dm-linear.c        | 18 +++++++
 drivers/md/dm-log-writes.c    | 17 ++++++
 drivers/md/dm-stripe.c        | 23 +++++++++
 drivers/md/dm.c               | 30 +++++++++++
 drivers/nvdimm/pmem.c         | 97 ++++++++++++++++++++++-------------
 drivers/s390/block/dcssblk.c  | 15 ++++++
 fs/dax.c                      | 59 ++++++++++-----------
 fs/iomap/buffered-io.c        |  9 +---
 include/linux/dax.h           | 21 +++-----
 include/linux/device-mapper.h |  3 ++
 11 files changed, 221 insertions(+), 91 deletions(-)

--=20
2.20.1

