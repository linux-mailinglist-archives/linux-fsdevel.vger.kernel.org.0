Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76925BBE30
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIRNvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIRNvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 09:51:00 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FBE1CB38;
        Sun, 18 Sep 2022 06:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663509059; x=1695045059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JOe7XaRamQ8Iu/OfFoMs5vEKw30I5MFDyJr1Ff7z628=;
  b=AAxgl1c0kKr1aVJamhSY4sqMKje9yNDl6N+Wof+LJ56omNgxg3AzBW3H
   cXtGDlnTAYWrHDLUtWFYiNBJyjPnl3Wmi+s28mOJ52JjCXHulqMG1V5fP
   keXv2Je+nYlvpNfmD8pwc9XDG3PIPIqaxnIco8e4ZUByqE8M7PQGg2zjb
   g=;
X-IronPort-AV: E=Sophos;i="5.93,325,1654560000"; 
   d="scan'208";a="131249096"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-f20e0c8b.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 13:50:44 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-f20e0c8b.us-east-1.amazon.com (Postfix) with ESMTPS id 7A7D69FD2A;
        Sun, 18 Sep 2022 13:50:42 +0000 (UTC)
Received: from EX19D013UWB001.ant.amazon.com (10.13.138.52) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sun, 18 Sep 2022 13:50:37 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWB001.ant.amazon.com (10.13.138.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Sun, 18 Sep 2022 13:50:37 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Sun, 18 Sep 2022 13:50:36
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 927094D0F; Sun, 18 Sep 2022 13:50:36 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <yangyicong@hisilicon.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andriy.shevchenko@intel.com>, <farbere@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH] libfs: fix negative value support in simple_attr_write()
Date:   Sun, 18 Sep 2022 13:50:36 +0000
Message-ID: <20220918135036.33595-1-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()"), a user trying set a negative value will get a
'-EINVAL' error, because simple_attr_write() was modified to use
kstrtoull() which can handle only unsigned values, instead of
simple_strtoll().

This breaks all the places using DEFINE_DEBUGFS_ATTRIBUTE() with format
of a signed integer.

The u64 value which attr->set() receives is not an issue for negative
numbers.
The %lld and %llu in any case are for 64-bit value. Representing it as
unsigned simplifies the generic code, but it doesn't mean we can't keep
their signed value if we know that.

This change basically reverts the mentioned commit, but uses kstrtoll()
instead of simple_strtoll() which is obsolete.

Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 fs/libfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 31b0ddf01c31..3bccd75815db 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1016,7 +1016,7 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 		goto out;
 
 	attr->set_buf[size] = '\0';
-	ret = kstrtoull(attr->set_buf, 0, &val);
+	ret = kstrtoll(attr->set_buf, 0, &val);
 	if (ret)
 		goto out;
 	ret = attr->set(attr->data, val);
-- 
2.37.1

