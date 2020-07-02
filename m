Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE32128BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgGBPye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 11:54:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46032 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBPyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593705273; x=1625241273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=REDp/j//+rstq6qASxwCu01PzRiD+wjaJB1mP3fHxbs=;
  b=UZFn4JX826oVkIWiXuzbZhryMqouL3o+GPWml5Io/BbHynxZJOJXrqRg
   +0C9b+N2HX0M8JPaBPDGHdvvw/pjikgSeyYCKa2nWEMliy8GnQw+eoO7J
   4vDt6VxAewQJHcDiHNvHQcIaI0ZTsyw6SMF9Ft4/jtl9BAmgy8Y4Ic4ZZ
   RFG9SWSy2+suw9WuyGDXKhOSohVJWk/NCohjSqq3BNWq/a++CklVudaFG
   iFJzGvoZpc0iokh4vQcXmD304cqNcpYM+TDZY4hPeLgWS7sErvWPVSLdl
   t8g36JkBs/mmuLeiGD8mQXlT0R6TpL6AxZZvEqjy9yAOFZCgAMsWyDI91
   Q==;
IronPort-SDR: XlpN76dCl1kHZIt8DzLU2DrhZ0u/a1jCmnfU8La440BRsOJj1trLR6FkAXxJh0wYdXXk+PncrM
 aSOnhfdmKAuJQAyKuLTPfOq+t/gmA9oFSqnqi5SQ9IxXW5QUVL7bmhI5omCleC2OZQuixvEwL2
 JTKahU3glmrlDTQ01YInPU8eTTcRY7R+hRF0WtAYJ23VlNKt9wM05RM/OoLxhsOIiQuYcx/2Sl
 rY5ojebNhxKwQc4oCv0ke8MTxd5+ailNtIdL5hn40D4IoINGmKCAAmRwZ10p7894rCHdnMcrWa
 xzc=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="250729145"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 23:54:13 +0800
IronPort-SDR: mMRvhmwt2X/whS5JgMDj04iT11hKxdGRYDtwrRMAh4d3IqU4a711ov8F9KJdC5A7RFelfEkFyu
 6n0V0YLBORWWKuRdDHt/R82sBiqJMrZdc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 08:42:27 -0700
IronPort-SDR: 97YX9WJQ/bKlkxmCGpn2oWWEOZtPdf0qqcJbzReK9Opc5AUN3KnYlW1mKVFRfMdSVK+kLqD0QP
 zvvGtEVt4s7Q==
WDCIronportException: Internal
Received: from aravind-workstation.hgst.com (HELO localhost.localdomain) ([10.64.18.44])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 08:54:11 -0700
From:   Aravind Ramesh <aravind.ramesh@wdc.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, hch@lst.de
Cc:     Damien.LeMoal@wdc.com, niklas.cassel@wdc.com,
        matias.bjorling@wdc.com, Aravind Ramesh <aravind.ramesh@wdc.com>
Subject: [PATCH 0/2] f2fs: zns zone-capacity support
Date:   Thu,  2 Jul 2020 21:23:59 +0530
Message-Id: <20200702155401.13322-1-aravind.ramesh@wdc.com>
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
space of a namespace into zones. Each zone provides a LBA range that shall
be written sequentially. An explicit reset of zone is needed to write to
the zone again.

ZNS defines a per-zone capacity which can be equal or less than the
zone-size. Zone-capacity is the number of usable blocks in the zone.
This patchset implements support for ZNS devices with a zone-capacity
that is less that the device zone-size.

The first patch checks if zone-capacity is less than zone-size, if it is,
then any segment which starts after the zone-capacity is marked as
not-free in the free segment bitmap at initial mount time. These segments
are marked as permanently used so they are not allocated for writes and
consequently not needed to be garbage collected. In case the zone-capacity
is not aligned to default segment size(2MB), then a segment can start
before the zone-capacity and span across zone-capacity boundary.
Such spanning segments are also considered as usable segments.

The second patch tracks the usable blocks in a spanning segment, so that
during writes and GC, usable blocks in spanning segment is calculated to
ensure writes/reads do not cross the zone-capacity boundary.

This series is based on the git tree
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git branch dev
and requires the below patch in order to build.
https://lore.kernel.org/linux-nvme/20200701063720.GA28954@lst.de/T/#m19e0197ae1837b7fe959b13fbc2a859b1f2abc1e

The above patch has been merged to the nvme-5.9 branch in the git tree:
git://git.infradead.org/nvme.git

Jaegeuk, perhaps you can carry this patch through your tree as well ?


Aravind Ramesh (2):
  f2fs: support zone capacity less than zone size
  f2fs: manage zone capacity during writes and gc

 fs/f2fs/f2fs.h    |   5 ++
 fs/f2fs/gc.c      |  27 +++++---
 fs/f2fs/gc.h      |  42 +++++++++++--
 fs/f2fs/segment.c | 154 ++++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/segment.h |  12 ++--
 fs/f2fs/super.c   |  41 ++++++++++--
 6 files changed, 247 insertions(+), 34 deletions(-)

-- 
2.19.1

