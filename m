Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88381265FA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgIKMgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:36:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38415 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgIKMfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827725; x=1631363725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qgEBWgJSMacwtA3SUdTXH5qAHlX9ODJTm0ZOwmpKHYs=;
  b=oEq5XTyDn8aRFhFGFkLVK2EwzM6au6ujcJm2paWeTvvsYH39FVtZBhR0
   QDShe0v7mfQ/2rUwfaQY0wAZxNdEggRosflODdpXUkB6jSILMUOhHlIeH
   YJMO9/aPr/co99doQqPESoyWrQaXu+XSglqJrDrgpokSNggSfRnbSpIYj
   ds7qbTTIpH7cDSuvq29ed86pZcefMepWla4aV7ypSk7YFkbLSLSHSsEsu
   2mx+uRXI9n2bWVkfnMMw3bKzRls8/Yi7JDGM/MjJNFolbdkBOslJmRqbL
   mtTBJbg/ecMBto3x551/KeoAkUKNytGuAUGgka3CXCJ/e8qWbXET8WUJe
   g==;
IronPort-SDR: YK3Vn34xC2oprHHT69bQ0KkvjzMAa7tHjlXgd7q8CrH8V5sZgL05SaH6oHHC31pTcLEa2HoZnY
 pwYYUztMqOv3h/VEaS3/HhdZ6YrCkxCuCaz6xvGT40A89CaaHGI71fayeLytYHAc5Sr4DPNCo9
 LagSLFtFIm4FjS9ii/JyB9/t9xGsX55dVBOmHwF4pRQGkRlVkUGHU/JCyKXG3YCIZ8tjtYwh7O
 WBX1u+p97DW30YMZum6D4dpMRIxij2++N9hxHEuhqHWwOb+HmyGPCg3YKDknww6BnQYfwVVazG
 5rU=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125970"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:21 +0800
IronPort-SDR: XoRNsWX9u0oFxIiW9t0QJpjCB9hLgpvkNTgOE+AJzzkAjZnpXdD9K3CWCkLxuoToQPk/4fZMwf
 JLhPbh30qbZw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:42 -0700
IronPort-SDR: lPOPGaxgV5z3Z/JgDqRGQJYTZnqZtJo4dCFm7A5TmqySZN/1/d30FNcQZbgzSWMsmFbBmRb6zX
 7qDFRkQaBcqA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:19 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 09/39] btrfs: disallow inode_cache in ZONED mode
Date:   Fri, 11 Sep 2020 21:32:29 +0900
Message-Id: <20200911123259.3782926-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode_cache use pre-allocation to write its cache data. However,
pre-allocation is completely disabled in ZONED mode.

We can technically enable inode_cache in the same way as relocation.
However, inode_cache is rarely used and the man page discourage using it.
So, let's just disable it for now.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8cd43d2d5611..e47698d313a5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -297,5 +297,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 		return -EOPNOTSUPP;
 	}
 
+	if (btrfs_test_pending(info, SET_INODE_MAP_CACHE)) {
+		btrfs_err(info,
+		  "cannot enable inode map caching with ZONED mode");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
-- 
2.27.0

