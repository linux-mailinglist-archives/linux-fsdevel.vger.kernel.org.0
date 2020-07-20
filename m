Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5365E225A66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 10:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgGTIwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 04:52:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15083 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgGTIwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595235131; x=1626771131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=05owFcyNM8IjVRwbauic5lfY7gnHLkEzZXqacpF5REQ=;
  b=cP6g+pqxWy9/DztdhYwKqm9CgGQSjQAtfMbgHKQimAlkwi2nAr6GY6j7
   g3b6pV58LIyyLGwDlbQSj2imdCdZAN+SACOjzB2e6rxa0dhdeaUDflpZ3
   nYwYW5CWBWiuQ/cYetYUOyuuN+dF9x26Cn5jvLXWR5Yt+vGyA5LWjhCop
   TdR4yZJXIcUQC0TOhB+9qixoiJJjIh00/+R7wpmQZXG/5HvkcDf0A1Byt
   UDb7B2G03rqdMhAKBW26Y/c6f4URphAB60VTy79hsEwM9H/ugyhRBNXJt
   Tzk5k0X5M8+fT30DIhjf1Ya9Yqm9qwuiMWpVdXhRoqG+N5l9cViIT1YTJ
   Q==;
IronPort-SDR: 7hpPth+O8t2vapSHEbrynS81lzx+yvZQj95TMH7D7avcyQe0gMq0NGQBLHoKjCtRAWLOnlnMB3
 RROM5dxXo3hxnuRsWHjyxHQTV34IxEadrq07jpQZlo4FwbB8dhlwyOCqLHKCni2LXWQVaoW8Wt
 bBZW+APYPLSg4nE14nbLk98kp+PpfbViTNVzzCjXivO6VL5I848WltkvU9HisQXyTYpBw4Ewy2
 nUITl/0wFZ276Hxt8skK4hy9PMXaecRWPtlLNhUe3E76k1y/e/F5siipbKTcvPNljnjDx/ou+h
 wCo=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="252171861"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 16:52:11 +0800
IronPort-SDR: 9bHGek/j862nkODWXxQvZETbTKQ82eJ6UlKt5VhwQfRTfpfZnuhZrjCsfdIDiOhESqOO7qYJdc
 BeYDuHanRQxT9adnBcEQ1kJb9U+/JnABM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 01:40:30 -0700
IronPort-SDR: L1QIchpz1u/HA/5RhkDQa7h5TwYP/yTHm8nPufpLXhSWwcd3HxE1arMdybl8MpL/Yg/EG9QOfm
 q8zD61PHguLg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jul 2020 01:52:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] zonefs: add support zone capacity support
Date:   Mon, 20 Jul 2020 17:52:06 +0900
Message-Id: <20200720085208.27347-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for zone capacity to zonefs. For devices which expose a zone capacity
that is different to the zone's size, the maximum zonefs file size will be set
to the zone's (usable) capacity, not the zone size.

Changes to v1:
- Fix zone size calculation for aggregated conventional zones 

Johannes Thumshirn (2):
  zonefs: add zone-capacity support
  zonefs: update documentation to reflect zone size vs capacity

 Documentation/filesystems/zonefs.rst | 22 ++++++++++++----------
 fs/zonefs/super.c                    | 11 +++++++----
 fs/zonefs/zonefs.h                   |  3 +++
 3 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.26.2

