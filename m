Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1608F38B43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfFGNLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfFGNLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913083; x=1591449083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xqnDdtcrbB/JuA69zVboBOpPg+hMLEFntRJfoMfWmVE=;
  b=D6jZBY8nytzqV8nzHZotEopg1kOiSaNUPMHkCsX0x4evNSIbMk3zu0xY
   EK1Wyy/HREzQ4u5D6xJ/jqRE8V8FNY6lClNP3eq4Ujia6TmiNBecfYW6I
   CT/HygpB11aWnQsDYKgk7TMKyVDX/ypZazegXGU8svMS8z6+LLvOYh10a
   hcOekk49w0PpK12PlzZ3967+eROcJOB+3pc7dKkIsOFvbv3BrzYX4G2TX
   aEEI8rNsVvmL1gbsRa8UWaU53x8bfZ2ZO40lR37LO02VVUIsI8nw7KP62
   em1VM62cDiX6Hb2lOOOCW8Oy5MutwwwZ7R9N/eWoH38dB0OKH4ZqVSU7x
   g==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027786"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:23 +0800
IronPort-SDR: p1i5SJ9Gkevvu9Ac5/JCfeb9kBSps/bGLwNMEsQb/pjl7y5dgB77+0TlRB46bC8H/00gZFXPW3
 0CQLTLFZEX6newzAyzu0YJX2GMnm3XWgdc7tnQxi3jM8510zivrarSacpksHNU2olIKUnYrGui
 bYZayL9NEV1lgmAcJAQa4ujDpJEFPMSgN6D22actEwDQPDfnOZnrlg9RcDcAl4RWANAO2q3Jus
 zzYRQdJCvoOVK9aMiCepTnXno0x+3+grHQ5lqJRsskgbjzrQPcMskC7f17LIzeFeAw4PJFeazh
 62hFYrg9ZlQhI3xSXLwo+F4d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:40 -0700
IronPort-SDR: ZkdpoyZeYXGA6DvrPn+rNtzz+woX9jTuSHowB6NDPVP4u2BMZsWyaLpqxeyMjN8tG39U2MTOSK
 U1ojklXNwTbbdUmJ3VBD/A/Rq6ou5d+4VM8T1s9Hj7lp6JtY1/LEUdwlYY2i9qFDPE0GblK2E2
 J5gcbC0SetZ+3ggH0xiLEQRcQfUJ5IIxuEDpmSfLGa+aIXClwCTXiezmMyTAqj6DBKc4sHrECe
 S7MfeZekClyCcw11njl4dtxqYaHfoax+uNxPPGlvyv8uqWsilj4Xpc66wT0KIHPq0hDaw1ZTaR
 c8I=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 05/19] btrfs: disable direct IO in HMZONED mode
Date:   Fri,  7 Jun 2019 22:10:11 +0900
Message-Id: <20190607131025.31996-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Direct write I/Os can be directed at existing extents that have already
been written. Such write requests are prohibited on host-managed zoned
block devices. So disable direct IO support for a volume with HMZONED mode
enabled.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6bebc0ca751d..89542c19d09e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8520,6 +8520,9 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 	unsigned int blocksize_mask = fs_info->sectorsize - 1;
 	ssize_t retval = -EINVAL;
 
+	if (btrfs_fs_incompat(fs_info, HMZONED))
+		goto out;
+
 	if (offset & blocksize_mask)
 		goto out;
 
-- 
2.21.0

