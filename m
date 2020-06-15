Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515B31F8F49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgFOHTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 03:19:24 -0400
Received: from mail-am6eur05on2136.outbound.protection.outlook.com ([40.107.22.136]:33504
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728417AbgFOHTX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:19:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M54AwBy+CLUn7U/QKMfOnjWeBZMEA+gPx6cfar0PRAUqya6n1/oaoI/vCvjkgBmhaAf+9FT0iFc1yz2sOmvTDC7U41xh3WLL0uS75xoZsudYBBSSnyAZvY6kd3QOWo8/t4I9OGEpqXySSOMK16KfnQu4ZenNDYmz/BMvEC0em5zmmkypYZJkP3OVxgeC/XmR1sQPuoQFxK4ql4uvYMshP1kIler0Y2wr1R4YnRVS3L4ko6tFP4ltdyqtyBzXLBTV0k5I/7Lw7vHHZjSIYnJjuN6LDMF0yvEGB0Fxe59BwK8F7uoPAnzgbubyrhPJ+x+jPzFi4qJBNDM+stOMtGl3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o4RtKmf54Nia0VwwJnhVkeFjsqf24Dt5F75JZJVtzE=;
 b=Kf5RVolEx5gQSf+SU8ff1qbfoqphdkBCh0GN2/+KLJsuWazhpB3jefV6oKUxYGpYhm5vt1bESkeNo/UfZzpjvU5SskPIG0OmzstAnhE3bvmIYbbQoFLvhtHBtMAbYjONYCJiSRago6Tl5dVbf1E4EAniC/Ky6LJcgGHfHWzxt4qmKtOQIPYWmdF2CbKB0o3dltOIuZtXqW4lhj5mTtj4s2pa/LYka5aVCWyuR1a05sPelIm0pgw8XkTuls3j7RbDN8jic51U+R5XGFidhUt1ZYpjYe+izUZvkITI4j2JFsvXsRM8cWBbKyOOs6HpN3/DrVaNJX/vx9G1Kih5pMBufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o4RtKmf54Nia0VwwJnhVkeFjsqf24Dt5F75JZJVtzE=;
 b=vmHpQNGaw6hyEknj+M/8Osjk5RzYVhElHZqPfhU7nE/4QqTruHvBfm0t6JKAenEHyX17ALAYZ6m0MYduIrcKBjXSx2fBLRA8FRDYvFv/Ky0IDXosoImiKyaMynVVCrqfRK6TR2tIMu4vqdWyhKlxO8MeMJm32CSnrcMugr/aHjs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB5459.eurprd08.prod.outlook.com (2603:10a6:208:186::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 07:19:20 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 07:19:20 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse: fixed WARNING:at_fs/fuse/file.c:#tree_insert[fuse]
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>
References: <ea00a67e-5a61-2e70-215e-004e3dcc57c1@virtuozzo.com>
Message-ID: <b80b820d-8cec-fdb2-546c-1085cb3a9db8@virtuozzo.com>
Date:   Mon, 15 Jun 2020 10:19:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <ea00a67e-5a61-2e70-215e-004e3dcc57c1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0902CA0001.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::11) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM4PR0902CA0001.eurprd09.prod.outlook.com (2603:10a6:200:9b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 07:19:19 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e62e7e7-164a-4c5a-6b7d-08d810fc6bef
X-MS-TrafficTypeDiagnostic: AM0PR08MB5459:
X-Microsoft-Antispam-PRVS: <AM0PR08MB5459812B09696B5C906E20E5AA9C0@AM0PR08MB5459.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wrnmgm0lF0TLweVOWWSW2j9okNfjuildEWOy5g3ujWSxy/VaqTvhF9jVrxp3hFZPfJpjT4IP8A6JLVk2o/xBvP4T9MSIUXTUJwvhGMOME4f4Fk/NFcbIqcZolwF02bT4h5rgY1ms6oXmoOyyAVI8HxxDxDSBqM6Gxzh1SzMZbALG7xT1Yrv8+WavDUYbix5iAopo33vZBlPGPfjBy/sjyBSbehmdxYaHNGxWVvlXelCQd1PqWdwePFbaVqTB2XaFRu+CUqJCdO9NZ8JxbgM17DqxQrg0bR4Iz6E70haWnadAbJo6MBSKHT2SvUD/lf3/sKH9ArZvl7sPqXMMzprMcK+l5zv2LSiSDHx5xOjxN8MyjVV+s4x2Enz/doxCiTXF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39830400003)(478600001)(8936002)(52116002)(316002)(16576012)(8676002)(36756003)(186003)(16526019)(31686004)(2906002)(6486002)(2616005)(956004)(83380400001)(6916009)(4326008)(66946007)(66476007)(26005)(86362001)(66556008)(31696002)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: i2bN6qJ9fw7FXgk8vS9KQoN/WF3S1gQj7EP5lJqtOk+gVZBsWE1q+spAwahh00Hq476mAaSTwX6/kTmbmBPSAQ9GGu2WQ87UcsUpqMg18bEoV4o8I8IzLijljFFSH4DYBCfjsqAVZOLGs8cV9L25o+g/tPYIsPJJIaaOuk3WQ8PRCpV3BJUXWfPupJBMRn0IIHhgYVplGBbqHI6iYjfKJi79jIunHBe591fM0sJ8b9FR+O636E8vZggH7kVNfYzJKzbZpxhAqD7z0gO4UGpZsqb7YecMPWq0SHspvbTbW7CxaujaOZ/ns4cAalLWzU/N7AbMd1twFYgnUfRtLtvxe5bJbYM8Xyhlp/IuaEdKsHo65xBZ6rKdOcssALccFAEcU1YNkG2JX5s2oHHT3YutlVb7WE2vpZfqdLbsr+8lFfFEuk06Y3a+acPjk2DPztm/FJsSJEiOfSbljWJuPjmg5+QtT2QN0RzIvx7641GP26A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e62e7e7-164a-4c5a-6b7d-08d810fc6bef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 07:19:20.3030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HV4McBFnBuD44hlhVpbtZGLKqzyslTXfNID05uXv/Z2auOMAUjyEJ9FS6pWq1YKEjjUzYt8fXKgfSEuf5MAOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5459
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel test robot <rong.a.chen@intel.com> detected warning after apply of 
6b2fb79963fb ("fuse: optimize writepages search")

WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
RIP: 0010:tree_insert+0xab/0xc0 [fuse]
Call Trace:
 fuse_writepages_fill+0x5da/0x6a0 [fuse]
 write_cache_pages+0x171/0x470
 fuse_writepages+0x8a/0x100 [fuse]
 do_writepages+0x43/0xe0

It was triggered by WARN_ON(!wpa->ia.ap.num_pages) 

Though fuse_writepages_fill() calls tree_insert() with
wpa->ia.ap.num_pages = 0 and increments it a bit later.

Fixes: 6b2fb79963fb ("fuse: optimize writepages search")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e573b0c..1771396 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1677,11 +1677,11 @@ void fuse_flush_writepages(struct inode *inode)
 static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
 {
 	pgoff_t idx_from = wpa->ia.write.in.offset >> PAGE_SHIFT;
-	pgoff_t idx_to = idx_from + wpa->ia.ap.num_pages - 1;
+	pgoff_t idx_to = idx_from + (wpa->ia.ap.num_pages ?
+				wpa->ia.ap.num_pages - 1 : 0);
 	struct rb_node **p = &root->rb_node;
 	struct rb_node  *parent = NULL;
 
-	WARN_ON(!wpa->ia.ap.num_pages);
 	while (*p) {
 		struct fuse_writepage_args *curr;
 		pgoff_t curr_index;
-- 
1.8.3.1

