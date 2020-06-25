Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3AD209BEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403822AbgFYJaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 05:30:24 -0400
Received: from mail-eopbgr80113.outbound.protection.outlook.com ([40.107.8.113]:15842
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390163AbgFYJaX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:30:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD1qaQ04SqXPvRtCQpggmRBoSpBluDxTZAiD1lKJkPzefAIVbl7XOVZqraL3oYsk+vtDFC/8trQeMLvclfD5LFBhkUhEzDuMKTAAjtKfpjsq1S7wDCCFN4izVxUGuD/NaltjXVZqwdsVdzknHfCmhQmehqsDbjYpc8/lKCFPG/NfTQ5r5xBBSEjGHJlB9nUY3u95+FQfyukrri1VwwZfGf4zTQWorjtodyGi3sgxQi6xG9CNCcRPHD26WP1VswKHjGGlccwznn023spwoHeY+V+xxU7aAydFsI9cXzTDha1rx/M+oVhJHfMVRBSDoJW0F644k2ij08inHc53FllI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4jAZu2zoOkPzGrFPzyNilwS/XNg7v2B2KKMho9IOTo=;
 b=S+TpMzoqaM8K/tvYHoKklFWYXM8AHkoBVwkMrURPaApY5rt1rsMTbFMu6sHqnoeaCMiGI9lQdXPMJGTd8d+3py5W0rMoiXcSFzeL7B079J9neU8NimyYaknngnh/Af7qE9oyuHzxJlxky2QNAwmnjdKFipcqrdEaBRvzyd8Ww5bpC/U7lX4Oi/8eJuhlGzwvHlN1Jk2VbUg12Bb/72e8c8xdXJfj/7xqp0EPv+6Lr1gCKbRCpEGQJ5oMBRqNKT/PXu3ZeDOnkId58lrKh3JUUV0ABz6SLxOR/IWOdUoEATYSsK6D7SoKkArAOBd5mbr31nbNj5/fUfVZ2RBOsFqunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4jAZu2zoOkPzGrFPzyNilwS/XNg7v2B2KKMho9IOTo=;
 b=VFHe/x5taYNSo2b3M/+ZLMCFcFYQP7byoLlfJ5gGhePLByFV0z7z8A2uj8Roelp4Ap+Y9aPwr6PIzW6DfL8Sn7vQ/bMZV66XQUmaN5I++nadZFl87w/5DKtD3YC8k1H5weZA7im7++M4NabOZWBUnxnx5Ov+ZzBirR1HCrGRMwk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB4052.eurprd08.prod.outlook.com (2603:10a6:208:12d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 09:30:20 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3131.023; Thu, 25 Jun 2020
 09:30:20 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse_writepages_fill: simplified "if-else if" constuction
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
Message-ID: <446f0df5-798d-ab3a-e773-39d9f202c092@virtuozzo.com>
Date:   Thu, 25 Jun 2020 12:30:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:208:1::36) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR04CA0059.eurprd04.prod.outlook.com (2603:10a6:208:1::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 09:30:19 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f90bb525-ff49-42ae-f922-08d818ea60d3
X-MS-TrafficTypeDiagnostic: AM0PR08MB4052:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB40524FF9788A70FC513F9856AA920@AM0PR08MB4052.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sa9Yo64xAezgXB/HnQ0oK8QkFkSxJsrTQP7CbO/dIGzRw52usMxVtI3E3K+PJxTkTiiGwrQIfA7ndzqzeLxrsZkE+ODdhHoU75wZvrX6OnCMkSOgoEsstMPGuYJRxPw68XivXd4/P5OgDhMMZ8F2GpmeW2eYecwARxgrXjJyAqNomkjKg0RoQAkDYzFP5gQYv82+sh8VDvrACAULJqufrJ8lu3PxI7Y6w+EiO95uJrQr3m0LIc/dwx3kc1UNo3a6rwo1sC+gv8O7Pa+W4Xog7A9J79GotlCp/hly3PufaWFZ8rdMUHgPZmxtWgiW1aK25GaGYFbPISX4jiZoGLeIyRd2TAP8uCfSBpy9fR/4o5NzpO/kqG3hhQ6cLsvNvh3W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39840400004)(86362001)(6486002)(36756003)(316002)(66476007)(16526019)(478600001)(66556008)(54906003)(2616005)(6916009)(956004)(4326008)(16576012)(5660300002)(8936002)(186003)(31696002)(52116002)(2906002)(31686004)(8676002)(26005)(83380400001)(66946007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +vHGOwaq79zXQMIMck8mLdGEu7lcrG/hnGq5Cix97p5/cQfTOTny2tCdSX7lFgexQa0N9YBWt0fRKAeNg1wzP/Ei/FH6LSf4Uq7fdj010gNaGuNlKN5YI/r4/K5EleDx09XsEAkNBAjDqz9xlVRb+Gq1aiqCVgvD0aONSoFruO5JpkBartf6YTUG5rYEJj5ZZD/YEjzM8fR76LsDgsOLBc7AnkorJF1U+gpAECXGxx2aTgusI4+NI0rthGV1CIMRDbCpFcusnhZfkHyhqH8PIce9ZMb5p+rD1iKQ6vn8ldRmOS+DAORw3EYQvqV7YaZ9fbPpNK33hpzU68X1ZWYAVRhzX29bFPm5idzE51HIc5FeL6DhCy/zt5ZkEIhzchyLg5W/ednwCz+UTIc23H3Z28ZYnf112ug3JN9pweYW4tBL7WVADetAmyBPylIB0OZk/+RHry83j5CNeOHVZqn/BfGAiG+rVX6wYrbT5O+wsxI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90bb525-ff49-42ae-f922-08d818ea60d3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5140.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 09:30:20.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtsgIANtzTypXW2RfjBctszovU0X2L6/8q88/469Ox2XjDjOPx2VePNH4Hm3Odv05qKJpIlbgtgMhWYcmHa01w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4052
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fuse_writepages_fill uses following construction:
if (wpa && ap->num_pages &&
    (A || B || C)) {
	action;
} else if (wpa && D) {
	if (E) {
		the same action;
	}
}

- ap->num_pages check is always true and can be removed
- "if" and "else if" calls the same action and can be merged.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cf267bd..c023f7f0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2035,17 +2035,14 @@ static int fuse_writepages_fill(struct page *page,
 	 */
 	is_writeback = fuse_page_is_writeback(inode, page->index);
 
-	if (wpa && ap->num_pages &&
+	if (wpa &&
 	    (is_writeback || ap->num_pages == fc->max_pages ||
 	     (ap->num_pages + 1) * PAGE_SIZE > fc->max_write ||
-	     data->orig_pages[ap->num_pages - 1]->index + 1 != page->index)) {
+	     (data->orig_pages[ap->num_pages - 1]->index + 1 != page->index) ||
+	     ((ap->num_pages == data->max_pages) &&
+				(!fuse_pages_realloc(data))))) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
-	} else if (wpa && ap->num_pages == data->max_pages) {
-		if (!fuse_pages_realloc(data)) {
-			fuse_writepages_send(data);
-			data->wpa = NULL;
-		}
 	}
 
 	err = -ENOMEM;
-- 
1.8.3.1

