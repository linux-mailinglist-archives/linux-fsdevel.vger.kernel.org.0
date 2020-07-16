Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A093222062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 12:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGPKQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 06:16:21 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17296 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgGPKQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594894580; x=1626430580;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mCJ+DHWMICH7L2RO924Jrny5czmBf1BYr6Qtz0uDY+k=;
  b=r4W8b3R8s+zbFI0iTE5c6T2mCM3ykzP+KTxVgPDRa7uVCBfXfQE0AnGM
   rpOx3TXHNI6gEuDztz3Nm3jBVNfxcUpx+Qtaf7jHiyX1PyOJLdpWOEv6P
   JuJ4wwLSgGrg67Gi4zfhbGUABjidZ7Wrx4ZaWdYAZ43kBZ6nXT4/O0itZ
   qpfUJhSAgldGO0Xf0GcrQVLX0fF26O2o6C3tfy5eOOlQbJZxkQKpN0zEd
   ANhTnmI1Jj2fTWWR/VfUhoxZptYI5J89fFIosTorzZMQczRG6tK1YvkDH
   AW3MsI8KxIE//rrGkYUblgqt0tVw1p72827GM6MY9H67MoJ8UXOK2qVOI
   A==;
IronPort-SDR: rI0UwYdNEemSDO7R1Nn+amRjgpJqp/w4MJhSQYP2YdWHwovVzj8BGkvf1WrvdJxf7qKIzjSMZO
 tniZwEixuGLecwLVi7WSv2lbhWopXvuEwFXi7fQO9EYuTor6OOe3L+/z/4oAOuTAglMOGGlpdV
 Ri5msGpmc8tRyJiOglxTFu59c/cvnKr22brwjSEMP9/FVfpXjsPsfEGjc9XWGM+VrD/du/Brhd
 fQHaKxBSNsxQNdGT33J5Pf45cGtdluKfehuG2/9m1ZRzL5plUq9TRQ5irVyEcsVrPCQ9kxcxT6
 6dw=
X-IronPort-AV: E=Sophos;i="5.75,358,1589212800"; 
   d="scan'208";a="146905372"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 18:16:20 +0800
IronPort-SDR: rCLHRYATFdOcmo8RWYpT8vzKPA8BHJMYeAjAcDpxGKtO3n5FnIar1B+oReZFouLcqsuaZjPYwU
 RHYq5nZuTBrbwfqwoHP0YEQkHJiki9mVU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 03:04:44 -0700
IronPort-SDR: izEK1Bo/wh1IteeCSuelEi2cLZW/52TgID0zqFoPqnPRxVaX+p/WC0WLGVgPl9VoCOxlmy40gv
 x6aFCCJsj4aA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 03:16:19 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] zonefs: add support zone capacity support
Date:   Thu, 16 Jul 2020 19:16:12 +0900
Message-Id: <20200716101614.3468-1-johannes.thumshirn@wdc.com>
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

Johannes Thumshirn (2):
  zonefs: add zone-capacity support
  zonefs: update documentation to reflect zone size vs capacity

 Documentation/filesystems/zonefs.rst | 17 +++++++++--------
 fs/zonefs/super.c                    |  9 +++++----
 fs/zonefs/zonefs.h                   |  3 +++
 3 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.26.2

