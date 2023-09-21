Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BA67A970D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjIURLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjIURKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071f.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::71f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D134A5E3;
        Thu, 21 Sep 2023 10:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVN6q5tiBioZhkz6kUzvbrVC/iDyK6Pcdyu64k4oUws3lm57nwGmAxgnE3oEpFbzT4NJJTYhbxPLF641UcTmiBrsGwaL+tE6z++gT59PI9RO3I4cAEEpjNyWkAsFaeAJrIRHpEMDv9f8Fza3cn+z2OddCspB1pi8zQW2f3SagmbHQIJlSM0pdEx9+L4LfNDz1QI7uyAuIne3Rm7+QKczM9Vik9B394dVmIAeaK3bqNrIOvqMGJRDetMMrCdjIA8S32H2eJqwt/2hjE1GBC96dqadK1g6y37UqmY+8EXHS0ZbK8yn7NGaUwZ/kUVlDOlzVx0n9PB/A47tDQ65C1rZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hie0CU6WHQFYyWZ1gCWFxOHUJnosO1rkhWfrjMFTl18=;
 b=JeYodLsuSui+q8P4Kc23GCq5LRN5jWYRzXDWDm82PJgX9kbjIMtWCbGoe7ZFHu+pe/LDBdFtggeYKcr7jaNFjfTiJ5gZb+SVX2vjEvtX+7nuvt0VTayCZjZL+ocb//+vm9MKbHb6e9r12hNJBnGVvXDgpYGgAmZOjG+9EELs8aiekrJUor+1MiRI9u5O0+j/dRwn+BFvHHH52aMUdEAbBtTRBZB4lFYowUCZ7ivuzPhe4lPKTzoS85tKL/SqVFc7b4LMu80PqdvFjmIailqPy78M+M+G/lZ5/LzVm3yoSpIy4I3wPV4Jkb/bO4pLZiK7fZNMtGEBewlD0CKZpX2R7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hie0CU6WHQFYyWZ1gCWFxOHUJnosO1rkhWfrjMFTl18=;
 b=G3PZZ7wkgAJlI5lfuKna4lmOyeTnekkzlwmnnY8ssy6KIe7JZnC9HXA7nDoQ72q8VQxV/gmdIRVWf99w0fxACfPAHb596L39ba7ZkmgKj2HqYOGk3J/UtSanHNwst/3CrwdmZRCt1X3ezhyKdR8aPBKif1VfrGoJDmxCddxjhbB2yBM8sDg6OpO3U4fjjJ82aktQnr9awy3gGzUYErSMDJHbkgkDMhxvTHUpT2UorTU/8CEPhGYpFSzCwPfCcBObjjj6mrtgoCx+wOKQr7DCcDUQLHsIL+PJFINXbf1adE1jRCsoYy/LrVlZYFyhCLEIgG7wPo/GrMidMBi8w01Aog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 JH0PR06MB6917.apcprd06.prod.outlook.com (2603:1096:990:67::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Thu, 21 Sep 2023 08:16:07 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::1d4d:f221:b9dd:74d1]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::1d4d:f221:b9dd:74d1%6]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 08:16:07 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org (open list:PAGE CACHE),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] mm/filemap: increase usage of folio_next_index() helper
Date:   Thu, 21 Sep 2023 16:15:35 +0800
Message-Id: <20230921081535.3398-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::15) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|JH0PR06MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bea5a8-1e15-4918-f150-08dbba7b015b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: On/jhM4q/0yUIQWOdG5uFL/t7ozgFGDoTO9BWjD/JODtpQg0ugqQrdM7qyRS1F+ONCu7pU+7Mlak4u8Bgrral/WKdVynymse8wXzuJCqBUnKiUglbStaYIg1Cza88UdP4265pRG5fHGjgWBBfM/k8emPowZZZ+VyjL9mz0V1PQ8nqwmyXBTZJTJt53tVM5aqp6sKYADAXX/GJVi4/zvN6EPowNzhoucXAryW2BqChqpcHNmOREBWGI63V+/n8fAcI/IolWQ6xwfXjXN59XManIELfwFqnjfMFO3A/4sY1tOse4fUarIx1vEUPtJS/tyqcUFysv9kPB103/sVrx1S57bmr3LMOZvNJz/raYLOvAPJ476Qdxhwj251c/NuYm6aVtVApUzAESFGgGbqcpsuSdcqVnxaQcbv+s08P+MM00M1o7gZXSxH+0UyHKVF/S8eNJYWjnwkuv0IouVajZQ1pY3bEvOP5dZyjrw38+W6qy4MKmF8Hl0APpzmLcAtG3PCePqBuQnpplCVzKJckrM3oDnIPwZrFp4CGFzAWLuqwv9h6fbwmBepdIP3j5NUnB2oNKu5HQ9YzuQCyb9W5TWZk7adGTxgcXn513lg8bygVRqRjSNuS5/UQnL4s9zq3ORo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199024)(186009)(1800799009)(26005)(41300700001)(1076003)(2616005)(36756003)(6666004)(107886003)(8936002)(8676002)(4326008)(52116002)(6512007)(6506007)(6486002)(110136005)(66556008)(66476007)(66946007)(316002)(4744005)(2906002)(478600001)(86362001)(38100700002)(38350700002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQG36OS+l+sJxaIq2sL4XhkmnBYwFlEfejgWBLbZQCW3OgFsPST7gh1uCxcC?=
 =?us-ascii?Q?RxyNvjOG5TxLpntvMLmyw1HI6nXx4+rmkGCrBxBYs5N5jdvzlysIY5uL1z87?=
 =?us-ascii?Q?CZ2LWHCL3ZTgtgV5s0P8wvOhEsRD7jhcmImHcT7epDBaSm2AgMwpt/7SCUkN?=
 =?us-ascii?Q?uWV3sFeV11hAKEBb7hbMpZg4S7KK2NSLtNK565c+aB8U1QcJYKu7MtYQExKZ?=
 =?us-ascii?Q?4VDu0QJ4KXJzlk1dTxFPceT51123Et6QUgknZmNLm/9lvjgnLrai7aB6gTFw?=
 =?us-ascii?Q?2m7BKEDZ3/OaYPnKYmPpU79HQpZGxLjF75ouQrOO+4cBjcw9hCuLTdmoUdF5?=
 =?us-ascii?Q?2scyL0k/wkUBU8GKlIn/QZbUXHJOfEQdw861EAnBvLQg/3HNEwl0+BsqY2Y/?=
 =?us-ascii?Q?SgprzlAmHW5XoWNIfBQZ8beWI+P0QTh7iLEJUE+AEOIQQOKydXdY/SUEmF/5?=
 =?us-ascii?Q?ydFe666b60gP1Ib0PYsJX3dLOyHp8/Q88/KhJfGl3ztcVHXrcFCl1SOYFE8o?=
 =?us-ascii?Q?+f5vQ1w/SoLRz/gAkKC10HA+vo6Tv73oih9rFG5QJrOfNQFS+bgJ6vExyO2V?=
 =?us-ascii?Q?Pnyl119aJiiV6OW5Z/rR2CfGHPjwQF8VlKNtZNB9LYvesLc7o8uwHGTU/dMd?=
 =?us-ascii?Q?MHZnYmrQfgiB0WkagCedGH0GdG2Z8tAXoLch4EOCLe1pWlmzB0umrnKqa5Mt?=
 =?us-ascii?Q?QSLsgyHUSrVZCzmNwvmozpv0w7UVEHl7SQngj0JeclhI4cQmXZLKYAN9+O8j?=
 =?us-ascii?Q?aeckQXYX+o7hmD6hXlCWnb1qOjWuyw0Cc0HTCGn3gB29x0bcHceL0Vj1BumU?=
 =?us-ascii?Q?aOTV4ivggaKKEzcPZ4LUhRj5UNJ5EWzytp3VIhzU899V8ZwkXsHirr0z/uyd?=
 =?us-ascii?Q?ZKPAhX+WChuJIxmdjOhy5l4+D2Wa+zTv1ixIiDtZkvAL4xSvySTuBm5eEabc?=
 =?us-ascii?Q?baj0UlD8o4t+qWxYpXJ/bsiE97PipWudn0QhAyhDu74eqB7qfti++KqkH3oK?=
 =?us-ascii?Q?EgOv9pic3IVK+d50pzWYBp8EXhJRx+nN01Q5RSqLsN51O5RFKTZdaKrHTCB5?=
 =?us-ascii?Q?cKnOxPEtwqHjkjJezacsCsJHHgSBXDPABUJ/W3q6x4k9J8ktAToBNjB99nSC?=
 =?us-ascii?Q?kL5HyP3dO6gm3uUgjlJSE/KDgOw32ljxTHiCfykolmLhUOQb7BMMFTuvJdX2?=
 =?us-ascii?Q?Uhzu1PMIk2XRUhYFSEGOSIquP4ZZd4gKso3Rgka//sCZIQ3x9hOKyBDGlwYO?=
 =?us-ascii?Q?k5opYFdiz2a2lBIzlM8Qva5d9GspQHIbRtsPLKziIlJtMR1ofD7TGIdCcukc?=
 =?us-ascii?Q?tpDX7YQp6cbwMwlKRFgJ2abHQqsSzwDkpiEDbwq00und9LePIGqQN+jWQsWt?=
 =?us-ascii?Q?crMoZ0ljFxor+eUSAVX2HpIcz6eQBc7OGcxHP/ryO8wr0REz8I/Ji+e7JyKF?=
 =?us-ascii?Q?tzbgviq3Rgp5UK0RL5AJXNap4G+PfiVsmkg9BEmWW3F0vxajKQaV3heNAsSm?=
 =?us-ascii?Q?d16/EJF7kiDKGD5dzK2XGbKC9GxHeYawOxncNZuMPDKSTLe0uyJ+3sPROdyC?=
 =?us-ascii?Q?c7tK5jJQBf7rw7MSN5lSup4LWwnXbp6iVPVyVhjS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bea5a8-1e15-4918-f150-08dbba7b015b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 08:16:07.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqw9x7vDjOIELOymA/3QiFXqH7KKn9P7hrM+2OrfGOD50/pccftbdDbuu8DXk+a05oMtLp6odNru6LvyrZEO6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6917
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
the existing helper folio_next_index() in filemap_map_pages().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4ea4387053e8..f8d0b97f9e94 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3591,7 +3591,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
-		end = folio->index + folio_nr_pages(folio) - 1;
+		end = folio_next_index(folio) - 1;
 		nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
 
 		if (!folio_test_large(folio))
-- 
2.39.0

