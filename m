Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3AB225E87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 14:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgGTM3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 08:29:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47819 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgGTM3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595248148; x=1626784148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=55QNxlA1YCEf0z2mImV5L5aJ0heVKZjhahUIfFPYNMI=;
  b=mITTJwFkhfr/NQGM0Tb7CY5b9WB0MVMUgoC7kHz8UK41BWTRI7rG4w6c
   eN/nU7m6EAUXe84yjBeZGARuue6Aj0YacHeOEnDrTq/ZQBBtuIHfQKFuu
   8BQvTTaAXyqnHng2UUHtD5T0swch4EDxAcBTnWryIaHIx4F2Ww/mUjYFj
   kaqFRy5JbjFGeoarOw+cKfPWf3x+bDNVM5fy3KZH/6HHYLMYoADope3Ft
   RpVYExfbbb/V+1YO5cGJNTz21GnyizHF9AGHpC0rOM38iskDLSYL73BqC
   yFfQ106tgjfhdLLsCm44p6WweLNnKSBPeN0cPYKHTfp9G5gMbsYZg6/lD
   g==;
IronPort-SDR: GmCKBcE0Sy1kUt2RNk7N+/iem1votYP3mhBsF3KQ4y/H2kiQMuiKYzTq70fcOfkce39fSuzqjL
 SFoTmysRT9/MNIM4a5XSIeXCqywCdyQnUJJKamO+yrWwDTwOfA4WswFUofe3/VcE5XYktbIcKC
 nFwnUj/0Y6e0zp++UUlTpmywP54YwRb22MQK8e/ygPm06njdq8lMQqda3mNlBatZG/KN719KZ2
 +tuqXtp85g+3MNy5VjS0jEoxw0GAMOz/EWoGy5HQLzk0QEerMmLvO6md446bEkgm3cXGHINbWS
 rj4=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="142913127"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 20:29:07 +0800
IronPort-SDR: 5f2OMPc+BO1AzTElyL7yjqWCZGQ5RqFio+PK9LI1BYjkOl6dZvLNM87OuRAF0gkQXArpEt8AHX
 1TZYxu9kliW6vdShYRc8zmahFCl8p7pzo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 05:16:52 -0700
IronPort-SDR: LVNWpz1bHfvvCZ7kcUl2rtHojFbET4Gk3yGHRjHBsvHwysgh0t9LqXZnwclG1sF8dIZl+ezRzu
 rKu0V8SNNJCg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jul 2020 05:29:07 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/2] zonefs: add support zone capacity support
Date:   Mon, 20 Jul 2020 21:29:01 +0900
Message-Id: <20200720122903.6221-1-johannes.thumshirn@wdc.com>
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

Changes to v2:
- Update aggr_cnv case
- Fixup changelog

Changes to v1:
- Fix zone size calculation for aggregated conventional zones 

Johannes Thumshirn (2):
  zonefs: add zone-capacity support
  zonefs: update documentation to reflect zone size vs capacity

 Documentation/filesystems/zonefs.rst | 22 ++++++++++++----------
 fs/zonefs/super.c                    | 15 +++++++++++----
 fs/zonefs/zonefs.h                   |  3 +++
 3 files changed, 26 insertions(+), 14 deletions(-)

-- 
2.26.2

