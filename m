Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF12222319
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgGPM5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 08:57:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28352 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgGPM5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594904230; x=1626440230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O4pD4LKgfWrCrqA+gwkTvaHq9NmrFkB/x0RL4K2+7i8=;
  b=J0Ie/FN4A8EfybLWqCQU5Fd+yWmXBQ1pMYHOjjvlK2ZKfCTVKfKMABGf
   nrOq44emEkeeJLBTN4i/WpTijIuDbJwMetdujU4w+n+dRrkZX9sN0fLX3
   SJX77l9zv67K6udpOsnZKyqh++AswE5fiBe2CEwbNjIQ6dQMxpIA2aerj
   imJdKx2lWeEL/KUb0AY0I2jNxj+Q64e40h7qHbwbp4Pj9dFKf8UzNF+c7
   JYxPbWFGQ4JmZMK0c1ko3RNZDgVXrMb09NGrbwIJ5XqklUgRv8Ifckgbq
   PWoVJUNJO+2pqLP9GqYxTH8PrA1oMEA6g7YpI1om14GJOQtBRjo29RmM7
   Q==;
IronPort-SDR: Wm8PenXYJduie6FjamGoeTd7eC58kVl67/h4CMKyw3Fe/jVjvin/uQifnXTX85p+dqAFwrkQmJ
 rMiqA8Lz0rIZtn2JmjseojVsr0jHkcRTYWu/3jsNn7+a/xFftT2l+2siwCFI/+qCU3U+8/Fc57
 C3yF6plL2tD/i9qEv6livh3my0mnc6P9bKrx4HPOo6TTPNVPoBUwZve0mcuaroje5D8VYipZqN
 ciwLVmmsRJZUvSSOTUImoV75sSEksoCAlh9I1ySXQRST7iLKSrUb9oUW8sqR1CHIbwqVze7o5U
 WPg=
X-IronPort-AV: E=Sophos;i="5.75,359,1589212800"; 
   d="scan'208";a="251874254"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 20:57:10 +0800
IronPort-SDR: QPv+0bLS4E4CH1AOeTP/blcFmkbMSHH/bT1u4IoN25EOKDvKIfziZ6oyVpnCV2xpUvw7A93St4
 y82YXy8hefBIc/2tXnxEhZNIsxSK3EC/o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 05:45:00 -0700
IronPort-SDR: jwUi6ApyP6ObeZO3mn/yzERb4lN3QSYJn4ZXDLU21ymnn84Md26CFnNspBAwPANeIyxcqX8zyi
 QL1atI/7JmLA==
WDCIronportException: Internal
Received: from aravind-workstation.hgst.com (HELO localhost.localdomain) ([10.64.18.44])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 05:57:08 -0700
From:   Aravind Ramesh <aravind.ramesh@wdc.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, hch@lst.de
Cc:     Damien.LeMoal@wdc.com, niklas.cassel@wdc.com,
        matias.bjorling@wdc.com, Aravind Ramesh <aravind.ramesh@wdc.com>
Subject: [PATCH v3 0/1] f2fs: zns zone-capacity support
Date:   Thu, 16 Jul 2020 18:26:55 +0530
Message-Id: <20200716125656.3662-1-aravind.ramesh@wdc.com>
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
 fs/f2fs/gc.c                       |  25 +++--
 fs/f2fs/gc.h                       |  44 +++++++-
 fs/f2fs/segment.c                  | 156 ++++++++++++++++++++++++++---
 fs/f2fs/segment.h                  |  26 +++--
 fs/f2fs/super.c                    |  41 ++++++--
 7 files changed, 275 insertions(+), 37 deletions(-)

-- 
2.19.1

