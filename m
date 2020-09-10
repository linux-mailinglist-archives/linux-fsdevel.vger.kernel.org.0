Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0034F2651DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIJVEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 17:04:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23579 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbgIJOhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599748672; x=1631284672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9n+pb+QvRYEsyZNbn3X61RdBlcjKLrY/IZPZpw0DcwA=;
  b=gIFzo7hQpznG9Hz15lzzsxmKYYEjHq5iPcwvDhKE7tCt4PCt5jkhI6zi
   t+/YOZ+QWtkToKPikiON6H3AjlfMjCKYrM10/oMBx8GfEiMzLXg0kieIT
   ZBonhgXES4HsSXSjwsrLHro8gTugr+T7dMPsjgSGcl0LfZZ29C+qBcrgW
   VU8jdp4LZnkb9mtu95XHX3icAKq3zDmfo4zR1MCqXlc+fWL1NbxU1MYSW
   iziwiZNvES8A33c37wPEk/f5J9o5OLs6yhzWMgZXzQllyB4gPW45UnYxl
   Dul/ukDTiAIHuofSNQ7mdEP9MEtW7irT1489Xhq1vT1DPIKkabERCKGNZ
   Q==;
IronPort-SDR: KEsrR9IqaRPHL4GMrQBhM0PDGu3nFeQj1AQPtbu/9+eNZ+5OQWa0mFmPA5VHSFz+YAlsLdYNmu
 yRKidNPSrjJ7yXflz7JHHKK82beKTTe2mg3yiXURvVW+jIHJi8HhtwhMJrDxKCNVJBWRpDM4sG
 fecSXlNTMjIpR52yRcgxxgkl0br51ztbZpHL5sS5s4vG6wuCNJ5UO5h7g/UWU2Ugt7lXZCXlog
 J5uAOWO4mIo5/JEI8zEX4nYi18TmiyK+D3lN1VDBjM74Vjo1KJC7FutaWNfEu4Eag14QSk1gbD
 /5Y=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; 
   d="scan'208";a="148261184"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 22:37:50 +0800
IronPort-SDR: DDI6/jHHdZqmHMwtgsYeJXKI+gM09rwG6v7bGVvnAg9zJcWROVBwbUa5PwhNPstxrxGFBTDHum
 PG/hxuXWgelA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 07:24:13 -0700
IronPort-SDR: K5I3UOBQ4srkozSfc2+GluISiMBbMOz/Qkg8XH76eyyGKowpYxL1b7C1V5BvF0KzNDw84ecaDz
 ZsZhZap7MyoA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Sep 2020 07:37:49 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 0/4] zonefs: introduce helper for zone management
Date:   Thu, 10 Sep 2020 23:37:40 +0900
Message-Id: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
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

Changes to v3:
- Introduce unlocked zonefs_io_error
- Rework failure of zone close on file close

Changes to v2:
- Clear ZONEFS_ZONE_OPEN flag on error
- Fix missing newline

Johannes Thumshirn (4):
  zonefs: introduce helper for zone management
  zonefs: provide zonefs_io_error variant that can be called with
    i_truncate_mutex held
  zonefs: open/close zone on file open/close
  zonefs: document the explicit-open mount option

 Documentation/filesystems/zonefs.rst |  15 ++
 fs/zonefs/super.c                    | 239 ++++++++++++++++++++++++---
 fs/zonefs/zonefs.h                   |  10 ++
 3 files changed, 244 insertions(+), 20 deletions(-)

-- 
2.26.2

