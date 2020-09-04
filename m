Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7447225D764
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 13:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgIDLcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 07:32:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15786 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbgIDLYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599218645; x=1630754645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JB6HGQqW19ILOHMaTvPG/o/FMCEl8p488+kquzEUeRQ=;
  b=RBLyjXh7hQHvfpbEgLO0faieSEuqkBmTpS2t2535khvZ/CZXW4PwiLVO
   3Cfpf/XD8LooeskePzyKsF7mfxV+VZ8/gXv8UTAx2qVPEVdqKvTYPXQiw
   azS1EmmZh4HgBlU9LIncCswq33TnG33mEY7TaC9A5QkJevPCVuSI33WQt
   oFGj3xB9weYPx9aGR2ilXTTJcfnegpfeFsrRkTOdpqNzYGrs2iwUBTV/K
   PmUF50XpOKG59NwVS/73vmc8E5vBa/ZeiGh43yhuNi8OPQfJrMb9nmy3P
   aS9pZ/HDn6BwWQVclOpg2UBLXhaBfAzWqamE/1X/HRwCyFvALnPqlrF2w
   g==;
IronPort-SDR: OwEltOVpGtB+v6HQEfg5gbg3HQQKxpSWY8lGFaPcsdx/KCzEJtg0z4SFgfCl9HD4kJWfSfeMBB
 wlwHQpj3EJ0CO+B8qwT4khT2ZjpRAFWR+MIxnE8cAh2jtab7bsDXuJBYoQJXePsSU9MuTawYvu
 kv4hcqgNTBT/bT+Depxj5reDfa5r1cdtbcImDDN6YxTGn5H6MxJwhm01SyNDR0JTmy0DZAG+qj
 F4Or/sndDINzDWobgvBOzMjsqJzqyGfyhzh4qm67uWFO+OLsgcseGnZTf0IX2cVWKiI7WWjcsC
 Rnw=
X-IronPort-AV: E=Sophos;i="5.76,389,1592841600"; 
   d="scan'208";a="249852274"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 19:24:12 +0800
IronPort-SDR: YL/RJjAvwqHxyyIzPjHnyadQoHfzNXSysr7ybB7c7xe6amzBVnvjdeTWfAHoeOoIqdnP5a6ceA
 pD1OI57Ds7hQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 04:10:07 -0700
IronPort-SDR: CQtkA5JdTyjF5B9SykHLnefOAOyX7w5hYBy/l0eusccuiL90swoLQi3B3mYFqsO3fQVMPLs5Cg
 M06SlZP6bZ6A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2020 04:23:33 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] zonefs: introduce -o explicit-open mount option
Date:   Fri,  4 Sep 2020 20:23:25 +0900
Message-Id: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a mount option for explicitly opening a device's zones when opening
the seq zone file for writing. This way we prevent resource exhaustion on
devices that export a maximum open zones limit. 

Johannes Thumshirn (3):
  zonefs: introduce helper for zone management
  zonefs: open/close zone on file open/close
  zonefs: document the explicit-open mount option

 Documentation/filesystems/zonefs.rst |  15 +++
 fs/zonefs/super.c                    | 179 +++++++++++++++++++++++++--
 fs/zonefs/zonefs.h                   |  10 ++
 3 files changed, 196 insertions(+), 8 deletions(-)

-- 
2.26.2

