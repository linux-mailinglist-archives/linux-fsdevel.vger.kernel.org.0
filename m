Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1392260AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgGTNVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 09:21:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30727 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTNVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595251284; x=1626787284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Klp40IXFRfykxqXv0ieuRbbceWs2kn4JK5Xl1pwgA6Q=;
  b=GaIdC1RnNXcw47TI3djNF8hRsiEcos+GR1cnCJPIminJN1KqcwV86zX9
   BJ8eABh0C45O5+Mj6EdVphdXxy2EDdZAKh4OklUAntyDMo6rwuMhUKBgE
   1hFdy6ahAqHj5veAOVjOp95pDFQFrnfGTbpFfO9OVsM7ZujY8/Knz49VW
   +JFTioaXkbpw18pgfFqPoR35+K7Z8uC/t/CBh7Ugfr58t2MeNSyN/i1m5
   dTaUCK1/HkLLDpiu4KR+ibrIoYkmVwHUBJIOW+zSmlhEdFgbBZwDp8Xmj
   zaXjjFh24uaPXxL7qvhM2l3QBtdvwzCgTzFeauuZ3miXSUyuq+Nk5+Ayg
   Q==;
IronPort-SDR: /ejbYnXezN4AzDhgSTnNIHcfgEcG4OUS5pMkm2JOagCOF8cLVmZgdtE0VIiGarVLulrXWBfM3P
 F6eTVU0lHk/KrrDdiWQkbfxRkMyIDtvN2lRgm2fDFhZqfFukdgTBjmm/asICqBH/5dvNMj1JdK
 1p4DPtSY728Is++jLcxRUX1iohUXQmdU+rpI6nqQ3VA31c8Ocwf0Uw8DYFWjEQBeUfz0scPIaV
 EEI41k7E4ySR4uwLyLE09T8fPMXvWDGuyCsCCPJ6k/P0AlEXu5twZ+04cy5nuD8wRZXJML3S5Q
 9t0=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="143013745"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 21:21:24 +0800
IronPort-SDR: CEWoFJsLYC+jEzycTydLw6FO107fiAEzWXd53hXId9de0JdDQs7tBf4bAJ9VRxbOQSYvmzf1oF
 GSKw1LfOCrIDU0bQ30jF74Mpt4lLuBZeM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 06:09:42 -0700
IronPort-SDR: 8wP0avL392kUdZ9prGrLcXPg6OP2dHq4FSoAkiUn+Mtf9XDaV+YAZ/9+xYic7XiCaFrtxXQM4Y
 6+ex6w3gEZUQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jul 2020 06:21:23 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] zonefs: use zone-append for aio with rwf append
Date:   Mon, 20 Jul 2020 22:21:16 +0900
Message-Id: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When an asynchronous I/O, that has the RWF_APPEND flag set, get's submitted
to a sequential zone-file in zonefs, issue this I/O using REQ_OP_ZONE_APPEND.

On a successful write, the location the data has been written to is returned
in AIOs res2 field.

This series has no regressions to current zonefs-tests and specific tests will
be introduced as well.

Damien Le Moal (1):
  fs: fix kiocb ki_complete interface

Johannes Thumshirn (1):
  zonefs: use zone-append for AIO as well

 drivers/block/loop.c              |   3 +-
 drivers/nvme/target/io-cmd-file.c |   3 +-
 drivers/target/target_core_file.c |   3 +-
 fs/aio.c                          |   2 +-
 fs/io_uring.c                     |   5 +-
 fs/zonefs/super.c                 | 143 ++++++++++++++++++++++++++----
 fs/zonefs/zonefs.h                |   3 +
 include/linux/fs.h                |   2 +-
 8 files changed, 139 insertions(+), 25 deletions(-)

-- 
2.26.2

