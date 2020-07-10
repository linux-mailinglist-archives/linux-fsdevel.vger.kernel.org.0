Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D7121BC81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGJRoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 13:44:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42721 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594403064; x=1625939064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cbc3oM6oIgo9G4kTaaD0VNdPm5ejczfoBNVZTRiYqc0=;
  b=Ak6I+Yd2ZQBOmVDZYsc7QPwFfgOC2VFCmq54E+74LGP4eYn956ZPcqeN
   l7GJ+HMq1TJJnvEvCPcZ2zX0Pnu4G3W9sFyN3HZRCq2Fla03cSLRwyeVK
   AXMNLcj4+qoLm8AeyaP2XSp5bdRN1y4rHPSvq5Mt5im6OHSwmZGRNa85P
   kTDqFtKVPS1s7kixtMm42dTTrFPP8nDV/g6DUt1q+UxBV48S0HH4lgRGc
   deIShTjhKatsKiqUZXEk5jeWRgLd2dvD8v421tcZbbW9NXAFE8zBDtJW8
   /PhQsAuiaRQRXNN6mzkgIPy+wxqmknwSdDIYkeluJSHjqYnOlefnkhioM
   w==;
IronPort-SDR: 4ZAeyr2EJOtogwpiCXj9TKBJS2dwy5dTv8ZfxA5Y5z6wu9aycVcucwwwxekWsgkxLyXj38Ouy0
 ckd100fgAJCZWI6AjxgxZlh3khoEB9D7LLBldZKUBPaHizvGWcLFcdl4wH6MpTcpymh2yTs5qE
 8/p5unWxnpCHYgAsAJel1euAcroXY9y45OK03kMfZeZPfAKwPv8PgCdBcapgehWhUMEvlmpn0Y
 lkijziJol23qMmPTeltoyq1bkiA1oNbfL6L4j5M1DRqSDGQl7W7CqGjoO7vhOyxyDx/outyp6q
 HVc=
X-IronPort-AV: E=Sophos;i="5.75,336,1589212800"; 
   d="scan'208";a="245178501"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2020 01:44:23 +0800
IronPort-SDR: 95sf03RibGJjppJ6zTgVf050Q5gYWvIlKUv+y+p4n+kEY8cnPzVwf39419cVTOObyuKNdVW/pU
 NwHYNFXx9sJscdvFxuSPjnhkSHZAshHgU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 10:32:02 -0700
IronPort-SDR: blztnjK4Hr8mDDnOtUyUAVCX9Zd4cdtNa2WcuJVOvCmTXnXU9rOLJV21Gxa2bdRBhvM2Go+ebd
 hSRVNrEM6l3w==
WDCIronportException: Internal
Received: from aravind-workstation.hgst.com (HELO localhost.localdomain) ([10.64.18.44])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Jul 2020 10:43:58 -0700
From:   Aravind Ramesh <aravind.ramesh@wdc.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, hch@lst.de
Cc:     Damien.LeMoal@wdc.com, niklas.cassel@wdc.com,
        matias.bjorling@wdc.com, Aravind Ramesh <aravind.ramesh@wdc.com>
Subject: [PATCH v2 0/1]  f2fs: zns zone-capacity support
Date:   Fri, 10 Jul 2020 23:13:52 +0530
Message-Id: <20200710174353.21988-1-aravind.ramesh@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NVM Express Zoned Namespace command set specification allows host software
to communicate with a NVM subsystem using zones. ZNS defines a host-managed
zoned block device model for NVMe devices. It divides the logical address
space of a namespace into zones. Each zone provides a LBA range that
shall be written sequentially. An explicit reset of zone is needed to write to
the zone again.

ZNS defines a per-zone capacity which can be equal or less than the
zone-size. Zone-capacity is the number of usable blocks in the zone.
This patchset implements support for ZNS devices with a zone-capacity
that is less that the device zone-size.

This patch checks if zone-capacity is less than zone-size, if it is,
then any segment which starts after the zone-capacity is marked as
not-free in the free segment bitmap at initial mount time. These segments
are marked as permanently used so they are not allocated for writes and
consequently not needed to be garbage collected. In case the zone-capacity
is not aligned to default segment size(2MB), then a segment can start
before the zone-capacity and span across zone-capacity boundary.
Such spanning segments are also considered as usable segments. It tracks
the usable blocks in a spanning segment, so that during writes and GC,
usable blocks in spanning segment is calculated to ensure writes/reads
do not cross the zone-capacity boundary.

This patch is based on the git tree
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git branch dev
and requires the below patch in order to build.
https://lore.kernel.org/linux-nvme/20200701063720.GA28954@lst.de/T/#m19e0197ae1837b7fe959b13fbc2a859b1f2abc1e

The above patch has been merged to the nvme-5.9 branch in the git tree:
git://git.infradead.org/nvme.git

Aravind Ramesh (1):
  f2fs: support zone capacity less than zone size

 Documentation/filesystems/f2fs.rst |  15 +++
 fs/f2fs/f2fs.h                     |   5 +
 fs/f2fs/gc.c                       |  27 +++--
 fs/f2fs/gc.h                       |  42 +++++++-
 fs/f2fs/segment.c                  | 154 ++++++++++++++++++++++++++---
 fs/f2fs/segment.h                  |  21 ++--
 fs/f2fs/super.c                    |  41 ++++++--
 7 files changed, 267 insertions(+), 38 deletions(-)

-- 
2.19.1

