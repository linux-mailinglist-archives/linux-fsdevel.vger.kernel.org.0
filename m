Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A867D265C0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgIKI47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 04:56:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58876 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIKI46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599814618; x=1631350618;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e7W7Ym1ERz96mzYJdYmNXtXtwbLre6nKVbK/TDUoB7U=;
  b=ZiS48BX1HKfaEsKkl8iE6yT4YEHGDxSIVriS6bCoa/0zPdOzWChdCEvE
   2JeV0D26ORIsEUu/knTGUEPpSocXhQ3EbssiiWzR2ulOvCeqPMY9X/pEq
   BnOvvqWuvKIt+De4gQpYl0hc6cSrVQPBjbHwLBSeskIhfss9djzPRonJH
   6srmLlxos3OXg7dfldijfbgmX5Z7KYV8WOBkqPDCtgQb0xnNyyBLcgstn
   qCv6U1brrSqvgtm8YSuk5cuC5uVWexp+rg4C9vZzd9czI03YLLC9xSJhy
   lSbZn4+/jiSNzyMp5DE5aetaeXjPSdkGcYbRqZ2F+8FUdvCsV2xP9Pd12
   w==;
IronPort-SDR: vCY9exTIm9wQc0u6cfvHEAuKjNQzKfOscUiA2zF4XKBMCdhj0AZObfQ2ABI4Z7znzkbgBnqYzM
 riv0E2qrtFxtAe98Hul3a+ecY2k+RdPIbNFhT/F87lHp4L3wSsHgXnkuH4hqBm7eFF2ny1ay70
 Js0ZiANFdyOQ+8MuzWc72MA4fXcSN/MzFov5oZJO/qh1W7lMbCY1USyfoZo9ZP2OtBfYnDTls6
 0cv4gCYMO4Ta2Z1l272/m3xDvPkVivnoMjYCQ6OSubJ9np4/JP+b1/bLwImaEkyV9kO+mQi0P2
 4x8=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="147041237"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 16:56:57 +0800
IronPort-SDR: aFsoVbFxxHXWYbGzbyQzAOhVLe8uUeHOzhXUaj6/KxfgoX+kicCUGjemvD2CoqKL1Jrz75Q4yK
 OFoQ7/6K+Dog==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 01:44:14 -0700
IronPort-SDR: 0H2LJFbuza9n/CE1QeSZQLMFp9xdF0T3m7JvezDPIwyK34Zqyhac/7DD/1WH0ZucT8WLhfQQor
 s9Nkb9uIg2wA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2020 01:56:56 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 0/4] zonefs: introduce helper for zone management
Date:   Fri, 11 Sep 2020 17:56:47 +0900
Message-Id: <20200911085651.23526-1-johannes.thumshirn@wdc.com>
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

Changes to v4:
- Clarify comments

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
 fs/zonefs/super.c                    | 221 +++++++++++++++++++++++++--
 fs/zonefs/zonefs.h                   |  10 ++
 3 files changed, 233 insertions(+), 13 deletions(-)

-- 
2.26.2

