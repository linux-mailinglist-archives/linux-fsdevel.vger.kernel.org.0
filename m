Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC797263F38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 10:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgIJIAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 04:00:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52840 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgIJIAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599724812; x=1631260812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J7eVRHI5KzuODcCb+ijAusvscqbOm7gW3sHVMV67o4o=;
  b=JDIFC3w9Rc63Pok2fG0Wm60lIDMwwunIOtnfs2GTs2UtkP7fnPGgxcHy
   TRs248ReMrnaauG5l/GntHUFt3GKt89J/swtoeiHsAxPF9XYpZfzOb3yH
   1b8oj/zERaG2dE6gRTXErb4clzmD9HoHI/gbZYVzFQzlp37iB9cGFPWBj
   kIUNh9QFDkNvQz9a0uLv628hvy2IfZ5eUrzJuljjqUWizvQXAnU0mswXl
   mzQ0ZfeObr7Mm+0Za33vAqgWHW1gBEB3JyFq01tlRht80ICkW4agEtH2K
   QbkToJKfGGvkU92fWJkVdwocz5GhY9MeBoCviS2NxP3FkerM3gR0IpNCQ
   Q==;
IronPort-SDR: E2nUnQGIT6mRi33TqE92MZlsyZooL10cIY5AzmscInjz29wK2gNo1kXqGXo9ZwwiacG9Mh4da8
 pyzQxe/g0/T408iYa9VRv0TBlXnVRhdsu3H/80h1Qcc9T28nWgbXgkENzQVKGNFGZiammHKzEs
 PUG59AP+qYr8v1s3j5DwY2CsurRUraS+8o0+Wr++IXj4rY9Ho0ai89tr2f+RiqnRcpwHwxSWkp
 T/Wal59V5oDWbatVSG29vWnAQPDT5AtSS+n4IJ96hSKCbbD4qEq04eKbXIM3sFtfLrbmVMosq5
 f30=
X-IronPort-AV: E=Sophos;i="5.76,412,1592841600"; 
   d="scan'208";a="148233433"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 16:00:11 +0800
IronPort-SDR: HLZPEouRxgsA0ABIzSKbOgnadQz27qPS5sEt+IsCduK7uT4NXF6BTcVwcZXuKnG7K3dKLohg0I
 SasTnFbUD6tQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:47:27 -0700
IronPort-SDR: qsRaiC090n3q10WxAiWWbDYueZJHDrghACBBQilq2B+h8pkKZFtCkj5aO5CEMZIFHPkEJCWlHy
 mrylMvoaP0FA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 01:00:10 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/3] zonefs: introduce -o explicit-open mount option
Date:   Thu, 10 Sep 2020 16:59:54 +0900
Message-Id: <20200910075957.7307-1-johannes.thumshirn@wdc.com>
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

Changes to v2:
- Clear ZONEFS_ZONE_OPEN flag on error
- Fix missing newline

Johannes Thumshirn (3):
  zonefs: introduce helper for zone management
  zonefs: open/close zone on file open/close
  zonefs: document the explicit-open mount option

 Documentation/filesystems/zonefs.rst |  15 ++
 fs/zonefs/super.c                    | 198 +++++++++++++++++++++++++--
 fs/zonefs/zonefs.h                   |  10 ++
 3 files changed, 213 insertions(+), 10 deletions(-)

-- 
2.26.2

