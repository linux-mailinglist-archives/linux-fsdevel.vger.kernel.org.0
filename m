Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0150262CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 12:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgIIK0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 06:26:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43807 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgIIK0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599647192; x=1631183192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vUnlFL6ZoStBr1SN/OJj89d1tponNEJ96OblJTM9Tsk=;
  b=RES23UU9XkP+jtM+TE8Virh44ZnizkKzihZMXFDgUFLXABL9gbLqAwpT
   E3c0d7+ajfbjy7yVmREZmOVevw1+sVrJzqmfdPeFP7CqP1K/05RtGl7Pr
   fSe0eQG2vv1r2BSDqbIeNO7vjfjBcO0GRzelWqKy6R6qgKjuIqKnbAVgB
   aSolfjtzqallG9QiEhgxz89yJ1bcK7OdEmILXCaHVD3TkHNJ0aJYtRJMc
   Oi79HTA6x+LSmfImCmAEgboOPHpiVkH6GyYouhYkR75IVLaalj++bhI/I
   2ZsuZ34vu25oe7PM65FRidYYAkfu0iN0rt2gQ4uGhwOZBUdi3BlpMi0fo
   A==;
IronPort-SDR: HJZpqXtcXkEweJ/nZi7Ws3B9p0BZ5KTzA8RrEjjDr/1CWquzrKfZCvTudPU0X+EbZZzKdmNQV4
 gH4+YcRMt0Vu8S28o31bthILI7Ff1XIaE5y4Fdkp5KTWT8azmP7yNciRxZMuDduuaLBPvXd7dn
 NFxVSHBv6HrYqx9T96zNpAJpngQp5oZk1B/XEY9DtRvOPKmkdOR5gaQHIoqpJRsnLLFPRL2Lk0
 R2CldGid1/D181ecm55qdrkf/EWQh2LTQwgi8JY0zSQODBF1dG1l1/Omnrw77l9BdnpHDB7tk8
 Kcc=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="256499999"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 18:26:31 +0800
IronPort-SDR: UaPam9DNsjxJ8jjN6ZOM4SoG3CH+sgXR3vadBJlCNZcXe9Af77+iFnKskzgJ0xcebS4JKA+NGG
 9F6juQd0lhHw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 03:13:49 -0700
IronPort-SDR: FZ/Du9NzmwMFvH4MNRqqilIHnXkvMuXfuxz7dYnJgPzOshmnmi3Id91vM4uHHymoBdHfxWy0/2
 CcojNW76vy1w==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Sep 2020 03:26:30 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/3] zonefs: introduce -o explicit-open mount option
Date:   Wed,  9 Sep 2020 19:26:11 +0900
Message-Id: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
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
 fs/zonefs/super.c                    | 187 +++++++++++++++++++++++++--
 fs/zonefs/zonefs.h                   |  10 ++
 3 files changed, 202 insertions(+), 10 deletions(-)

-- 
2.26.2

