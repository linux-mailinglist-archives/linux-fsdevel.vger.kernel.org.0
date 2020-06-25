Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C42209BAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbgFYJC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 05:02:59 -0400
Received: from mail-eopbgr50134.outbound.protection.outlook.com ([40.107.5.134]:62951
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389773AbgFYJC7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7CPOfU1hqrF1sRlkOvoTvqHSHIwxOriOOB8124IyrM2OPLTFaNqGiOV6xIyeeS/VbT+YekdUFRyVU4yamrdnMaDJhia6ODiSoizRUMMYfboYgNWTGrM57bj9qe3Zv6WMQwMncOloPFTHt516DofTfUKu8X6tOVTHPx6dPBWxwpV/ZD6C48Zkh80rtyODMoc/Dco3CfFmf0rWVTRw7uCJIIXsnqBZ2glXNYC6ZCSHlihy091UANTWjhIG4wxRwmzCfNV5kx+2eFycleqaS4cAXVf2YoXpvWvp6BvUXpgKJEJcspJNdJXHjMOpzWq2CsD68hXoYAMt7hAGEJK1Qy0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+fdArmRm3RUrqMUGuP4wws1W9DIayvTtD9Vkv9lfzQ=;
 b=S8S7c0oSzBawhRQqapHnixPxdgjpotxt3PNcm2SYtAvsIxEFUnmEms2sLkLhRT8miTOMFN+53lpHJiv0XCl5oEMl+l4f8YQZ5F0Tkb53hSFl+VXtb8UBOTNp/rDc21R43JLdLu6J8TQFjBoksatPDy7wi/RsdbIAVZgJJIrm5zKOzeZc3RTi2NmwItmb/IrqYVphjUPXZqT4nk6T/Q+Mmk6WHT5w/obR0G3TWB/1bjhMBbP7bZ+OwVmup4mjddeSVhQF/+jIkZubELdkq/mfteu/X26TQU5QwyLVLnLEJBkKcya4FCRBkK7q/YtwVttdEwwWnooDvG1CY+4c1S++XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+fdArmRm3RUrqMUGuP4wws1W9DIayvTtD9Vkv9lfzQ=;
 b=qn80U2eukZhr1xYXL6428tcy2W5FlntkrlapTHn3q0qhPcrdRX2GU4Z74Fd0TEMOV+ReBUf3Xdoy1ScRpN4WSbWPsGshKmNgnqT96CagmMKUxDuC653whYcGUIX2JBQcUydxYU1rGUppZcMWgZUGmtIU/IcQi2WKi3FJ0SsTqj8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM4PR0802MB2227.eurprd08.prod.outlook.com (2603:10a6:200:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Thu, 25 Jun
 2020 09:02:55 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3131.023; Thu, 25 Jun 2020
 09:02:55 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in
 tree_insert
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
Message-ID: <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com>
Date:   Thu, 25 Jun 2020 12:02:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0036.eurprd03.prod.outlook.com
 (2603:10a6:205:2::49) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM4PR0302CA0036.eurprd03.prod.outlook.com (2603:10a6:205:2::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 09:02:54 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8755055c-6b48-4435-220f-08d818e68c82
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2227:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB22277F06E4A2450277496768AA920@AM4PR0802MB2227.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcfFnlEfjIkSbqA7CRkkbGZe379XQKV2wQCHKo465MfcCfYrob7yRVnZxHG+8Wti3O/K2EiMl0WVm8rezb8dM//ZO4f17cnE17q/c9OFvENKnYZ7R4R2bCd6X1AZGi03XB+kWQHFQoVbp9E7fiEkqMsXU61bkoj7rgXKNpLgzYmPOL8K2qx1fRl8sNFgsWu1zKcYRKujFs2mCyH3AZeSn9E1k8MAVW5f0nlc+BATY/UAbiHU+bFsSkkS9lqz161PCYWVCqk2GC2osmEodcchdYNdaODupNlKPb8dFfzmsfXx2FPDHDE3FBt5xBuEPxv3IafDYhqqU3Ps2b75gdj89dcyKxxaXTgasuuL4E5FZpGxoZ7Ub4K6cCNz+CjXydKB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39840400004)(2906002)(2616005)(6916009)(31686004)(4326008)(956004)(478600001)(52116002)(186003)(16526019)(54906003)(26005)(8936002)(8676002)(31696002)(83380400001)(316002)(66946007)(66556008)(66476007)(86362001)(16576012)(6486002)(5660300002)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cT7EKso7dfdl9SNtwWamuPRlfy2lTbZCvOuHUhX+FZA/vH6P+dfNYgwOY4g7+CBuhgI72I4xk+3rRfGcQodLTKyrmRq6Fmabw4jhweWvlCm/jxIYrzODHEn04jZlV7997FSv5vSRL3deyYbhYL1i3K0MQBWHDf4m4eYV3XBMsONzzscmt/P/sz7ABLfCmFMz7XA35QzFXrkasNEOLHwvVaxre55PJWCWWuyC5JqC3hM44vfwvct8tUjc+7f8lIs+jDm+YkVAGNXwwa0wRDD6CFMbC8tOftr14Gk7gxkQArfuwZ8WsV4c7lIkDyMC6hnPGkdOcIJMgl06ejSgpDJSKmDho6q/MinQHRyXcapW0cmllrQ+kQOhVD0QErs5G4Wr+ac+4087JdCc4WEOpbSyaxQnbNuXI6UxGaysta2sf+6jaPpkDZNncmHlPy4Mdl7dC/kbSR9S3v1GAGwwj8REEoyvohsiF5pNeZkxALu/K6w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8755055c-6b48-4435-220f-08d818e68c82
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 09:02:55.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/2OACbbR+k527LYzVqNg423KTKX1AXCPTYwhoo/Uz9LPx5vQ8FKmnSrcxx/1mEjQpXVcbwEL7Sw7PXhc5Hfyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2227
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In current implementation fuse_writepages_fill() tries to share the code:
for new wpa it calls tree_insert() with num_pages = 0
then switches to common code used non-modified num_pages
and increments it at the very end.

Though it triggers WARN_ON(!wpa->ia.ap.num_pages) in tree_insert()
 WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
 RIP: 0010:tree_insert+0xab/0xc0 [fuse]
 Call Trace:
  fuse_writepages_fill+0x5da/0x6a0 [fuse]
  write_cache_pages+0x171/0x470
  fuse_writepages+0x8a/0x100 [fuse]
  do_writepages+0x43/0xe0

This patch re-works fuse_writepages_fill() to call tree_insert()
with num_pages = 1 and avoids its subsequent increment and
an extra spin_lock(&fi->lock) for newly added wpa.

Fixes: 6b2fb79963fb ("fuse: optimize writepages search")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c | 56 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e573b0c..cf267bd 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1966,10 +1966,9 @@ static bool fuse_writepage_in_flight(struct fuse_writepage_args *new_wpa,
 	struct fuse_writepage_args *old_wpa;
 	struct fuse_args_pages *new_ap = &new_wpa->ia.ap;
 
-	WARN_ON(new_ap->num_pages != 0);
+	WARN_ON(new_ap->num_pages != 1);
 
 	spin_lock(&fi->lock);
-	rb_erase(&new_wpa->writepages_entry, &fi->writepages);
 	old_wpa = fuse_find_writeback(fi, page->index, page->index);
 	if (!old_wpa) {
 		tree_insert(&fi->writepages, new_wpa);
@@ -1977,7 +1976,6 @@ static bool fuse_writepage_in_flight(struct fuse_writepage_args *new_wpa,
 		return false;
 	}
 
-	new_ap->num_pages = 1;
 	for (tmp = old_wpa->next; tmp; tmp = tmp->next) {
 		pgoff_t curr_index;
 
@@ -2020,7 +2018,7 @@ static int fuse_writepages_fill(struct page *page,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct page *tmp_page;
 	bool is_writeback;
-	int err;
+	int index, err;
 
 	if (!data->ff) {
 		err = -EIO;
@@ -2083,44 +2081,48 @@ static int fuse_writepages_fill(struct page *page,
 		wpa->next = NULL;
 		ap->args.in_pages = true;
 		ap->args.end = fuse_writepage_end;
-		ap->num_pages = 0;
+		ap->num_pages = 1;
 		wpa->inode = inode;
-
-		spin_lock(&fi->lock);
-		tree_insert(&fi->writepages, wpa);
-		spin_unlock(&fi->lock);
-
+		index = 0;
 		data->wpa = wpa;
+	} else {
+		index = ap->num_pages;
 	}
 	set_page_writeback(page);
 
 	copy_highpage(tmp_page, page);
-	ap->pages[ap->num_pages] = tmp_page;
-	ap->descs[ap->num_pages].offset = 0;
-	ap->descs[ap->num_pages].length = PAGE_SIZE;
+	ap->pages[index] = tmp_page;
+	ap->descs[index].offset = 0;
+	ap->descs[index].length = PAGE_SIZE;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
 
 	err = 0;
-	if (is_writeback && fuse_writepage_in_flight(wpa, page)) {
-		end_page_writeback(page);
-		data->wpa = NULL;
-		goto out_unlock;
+	if (is_writeback) {
+		if (fuse_writepage_in_flight(wpa, page)) {
+			end_page_writeback(page);
+			data->wpa = NULL;
+			goto out_unlock;
+		}
+	} else if (!index) {
+		spin_lock(&fi->lock);
+		tree_insert(&fi->writepages, wpa);
+		spin_unlock(&fi->lock);
 	}
-	data->orig_pages[ap->num_pages] = page;
-
-	/*
-	 * Protected by fi->lock against concurrent access by
-	 * fuse_page_is_writeback().
-	 */
-	spin_lock(&fi->lock);
-	ap->num_pages++;
-	spin_unlock(&fi->lock);
+	data->orig_pages[index] = page;
 
+	if (index) {
+		/*
+		 * Protected by fi->lock against concurrent access by
+		 * fuse_page_is_writeback().
+		 */
+		spin_lock(&fi->lock);
+		ap->num_pages++;
+		spin_unlock(&fi->lock);
+	}
 out_unlock:
 	unlock_page(page);
-
 	return err;
 }
 
-- 
1.8.3.1

