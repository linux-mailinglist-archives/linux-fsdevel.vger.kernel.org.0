Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBBF5B9748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIOJRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 05:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIOJRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:17:51 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC2FB41;
        Thu, 15 Sep 2022 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663233471; x=1694769471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pQo+/JNgUJ+QgvySKCUdfpookNqLFHbWcJ3oz/oxzAw=;
  b=Vpt+uNUl6XbUsskrTsXKGfeJHFed250n63nIb/cvJLrSlzot7O1RAmzy
   EZ+0rdcAekKxP//bnty9RtNcm8cBc9JIhcmc5Iybwk6wbfVl8ZM/KszIU
   DXSynYwoyPzzPNNZ2LYefrZagKn/Dj+k/XqA3zhLXQkVKUsFovg9oEYjU
   M=;
X-IronPort-AV: E=Sophos;i="5.93,317,1654560000"; 
   d="scan'208";a="130381582"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-8bf71a74.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 09:15:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-8bf71a74.us-east-1.amazon.com (Postfix) with ESMTPS id DDED9C17A6;
        Thu, 15 Sep 2022 09:15:46 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 15 Sep 2022 09:15:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 15 Sep 2022 09:15:46 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 15 Sep 2022 09:15:45
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 173E34B3C; Thu, 15 Sep 2022 09:15:44 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <yangyicong@hisilicon.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andriy.shevchenko@intel.com>, <farbere@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH] libfs: fix error format in simple_attr_write()
Date:   Thu, 15 Sep 2022 09:15:44 +0000
Message-ID: <20220915091544.42767-1-farbere@amazon.com>
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

In commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()"), simple_attr_write() was changed to use kstrtoull()
instead of simple_strtoll() to convert a string got from a user.
A user trying to set a negative value will get an error.

This is wrong since it breaks all the places that use
DEFINE_DEBUGFS_ATTRIBUTE() with format of a signed integer.

For the record there are 43 current users of signed integer which are
likely to be effected by this:

$ git grep -n -A1 -w DEFINE_DEBUGFS_ATTRIBUTE | grep ');' |
sed 's,.*\(".*%.*"\).*,\1,' | sort | uniq -c
  1 "%08llx\n"
  5 "0x%016llx\n"
  5 "0x%02llx\n"
  5 "0x%04llx\n"
 13 "0x%08llx\n"
  1 "0x%4.4llx\n"
  3 "0x%.4llx\n"
  4 "0x%llx\n"
  1 "%1lld\n"
 40 "%lld\n"
  2 "%lli\n"
129 "%llu\n"
  1 "%#llx\n"
  2 "%llx\n"

u64 is not an issue for negative numbers.
The %lld and %llu in any case are for 64-bit value, representing it as
unsigned simplifies the generic code, but it doesn't mean we can't keep
their signed value if we know that.

This change uses sscanf() to fix the problem since it does the conversion
based on the supplied format string.

Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
Signed-off-by: Eliav Farber <farbere@amazon.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 fs/libfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 31b0ddf01c31..4815c6b4fa02 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1016,9 +1016,12 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 		goto out;
 
 	attr->set_buf[size] = '\0';
-	ret = kstrtoull(attr->set_buf, 0, &val);
-	if (ret)
+	ret = sscanf(attr->set_buf, attr->fmt, &val);
+	if (ret != 1) {
+		ret = -EINVAL;
 		goto out;
+	}
+
 	ret = attr->set(attr->data, val);
 	if (ret == 0)
 		ret = len; /* on success, claim we got the whole input */
-- 
2.37.1

