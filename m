Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4764E244F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 11:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbiCUK2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346320AbiCUK2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:28:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C1DBD2D;
        Mon, 21 Mar 2022 03:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUMcUDWE2vms9UVYdesLGI5h6X40ctyuC423lT6HxansfLS7hA/TpShnsz3ptuZSrcgTPUGdtQDVeqL4Ye8rTc9HYEG7IJBFf0DhQJgpVOAeP/TFSXmHYbatYfCZhckK+Dkqe4+UHDyOaSng1Sxw2sVvAfGIPqNPq2w7XwU1F2BMEn7yYQeY8o3i/CqyyLwTV9BNhatHTiv8HgW+gXqwM3sIPqgi7uVyau6eNbMZTCu98deXIwAzC7XglUbamD+t9Doj/cqZCbovL8VUQe7d3mo9yeAVcL+DQFYgopGqd6xKqzHYgFWWElaks6/bPcVrKKEvwKmbKApgR63aubbp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCLLRohJjok8TqVwRzKwzDc6MNI2v7ZjwAyyQWt5yQA=;
 b=L9Tj39MAAd8YtY9/QkKPQnPj7zM9kcYABKm2sUHSMUAzI8EV7J6XXWlrGyILKu6YDff087RqJlPKlXBnoIbZR9NKP4c/K95ZSCz07fVtZ/q2VRl70uptWl08U77thNJ9ZVqUXLbUdJqWRHSFyVyGpL+sCejxcbmd+WkhksAatD9VqPviWwV3VkU1b7Nta6w3t7d8ATNSWhJEt7DeIwRB5WK4yffexH4AOhAhUXUciYdJjRquRLjU2Q6Gn/kVxcz1KCGfE5HL2VL2U7FcuG3vpBTBWZCZOlJLVvvy8oW6WnRgKFdrdLFHwxMCoHRfxYL36eyH6/Hu7D33BuIz/f2LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCLLRohJjok8TqVwRzKwzDc6MNI2v7ZjwAyyQWt5yQA=;
 b=cTqzL2oQXPqQampB+Hys7qpwgSN+e10WBpjCUqr5P0cedTmuhlCjKTEmWc9yLaeAysnRmCJujhilVWVckdhACL0P8lPMNHRuPH/Cpc+wdnZsLJLhEY3MzL+Jv2EJ2QnnxeldvU/OLQ6+bTdN7ylC1erru/XAXCoXYCMn5NTIAaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by PUZPR06MB4575.apcprd06.prod.outlook.com (2603:1096:301:a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 10:27:13 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 10:27:13 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Shuah Khan <shuah@kernel.org>, Guo Zhengkui <guozhengkui@vivo.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH linux-next] selftests/proc: fix array_size.cocci warning
Date:   Mon, 21 Mar 2022 18:25:17 +0800
Message-Id: <20220321102546.12569-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ea6273-2f9b-4446-c1db-08da0b255d07
X-MS-TrafficTypeDiagnostic: PUZPR06MB4575:EE_
X-Microsoft-Antispam-PRVS: <PUZPR06MB4575702BD403808FBA5381ACC7169@PUZPR06MB4575.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcIoPqW5H+rFyfkf+ijO52z30GYDmWn4uOdJC+6x3n09PUOaH6x1w5E6UcrV+BbMxlSCfUrn7ky9ee2S7e/obv9+YZ23iNf6IxSYb+/8cPhLB9xiOSONmoPLGOnKgGzBmPgZMRP/DmaEVAJT7ApwWvBn9yUxwWKpVizPhqk3IgZQYZTadSVoHrQV0O7TdluJbxn+RAQVADKqYAP+h+Ws6fbzLMTshj8yCz/J4dM/XZ+QypbsFopYBtbOf4rCGP+6gE4I3p5r9SKAKAtacmqS5WdsUsH94zIFTA3fmgTtXAXO8BR+K+KJBiW+sjfg8kEj/gLPgZG+je+1jXnoHeB3Nv/5fNcSHkLkV2mGzKs+2a2RSJ+yZlagwD/ZTtAtg+rkyEaP6y7ZU7Y9QKCxBKmVsRR1AJGsYusyjgvrESuzgrGsL5a7eprzOqngrVIag2wXOtl5JEgU9Yc7Hy+qF2xCGeQ3RV6rvyY6CJLQ94haNQxtD7J/U7X52k9n/ylnA1M5W4Pw+SodvC+gGiYK9ocucH5zmeAXN3jN410nlHJKq6PCRUm4lgSyCo+wkcrVRbAqTw+D+sX83P5UDoEyoue/01oixw21a2IW6Xhq4ddFDjSFAWtQ+GqzAi4/ZMj0m3Mvold7WVvZoXJSZ+T5iXCC4FXqhJmr2XFimDJIHtBH2q+uW0uxNXuc8TpweXhn2EX1JjzTGWy3H299LhSFeQTfTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(316002)(6486002)(66476007)(66946007)(66556008)(6506007)(6512007)(52116002)(110136005)(186003)(26005)(1076003)(2616005)(8936002)(2906002)(83380400001)(5660300002)(36756003)(508600001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+kmr0B4Mi2/xqE+KKbxtMq0u+afH41yXBnCQz8ma/PifBWMql8Xks7Kiy53a?=
 =?us-ascii?Q?/GzqoqpfYLM6eBCf2iqI/3ATcNWxY43anohX1KdI7TvPhFWcYt10TzXUFx6o?=
 =?us-ascii?Q?qN03VLk0gy6iG7EAYH76dJdXbw1+GlP207gNaPZjtL3rvUAi65IHA5TkO6C9?=
 =?us-ascii?Q?hoD5P1TCzekNfvUiBLVKtLg2OmlcROSqQ9geR1Fq8+wQ6piZJNM5eZxT7k8X?=
 =?us-ascii?Q?268ap76ccIXHDvKkVT8zKB4W0Zhn2k1PKry7gDkSIbacyB23MhUdLGvNiQZu?=
 =?us-ascii?Q?paek4z6FPyBlN268JtaySrNVpuvYWwAbOR5uOE5hig8f5L2tFdLMVbCL6k3J?=
 =?us-ascii?Q?+Nw5ER6qE6KWU9F22QU/oXQrAlFtksxMzOIW2IF9K1NrIK0/kt3+aTgUIXnb?=
 =?us-ascii?Q?tEkXufkxVSUFVY6wRkQz6ReoUsX0X6EuVy3XwF5RLIKitZEML4KKrCAtPXz7?=
 =?us-ascii?Q?OpOMbvpVEsGVMo8/I7ILP+ptIMpVJC9FCGkcASpr1CvG2DCrNvqmKggoe2OJ?=
 =?us-ascii?Q?4eSNuTEkU0QWUhn6YRKCy08L42ZpJ8PW71PJVA/wEw64Nw49zKrk73OOyzZ6?=
 =?us-ascii?Q?pOV6fwzYtDffpxWHdSzbjz/b/oUeMWsFZLwON9GDSN0oqRbQ/T3azoSnHVLJ?=
 =?us-ascii?Q?IKYjkTog3CPRwG9jAPsfNkb3oB573eAyqGazr9XIYBBSmpupMlCGQQeRgw1i?=
 =?us-ascii?Q?UU+w0fFvsM+Q0Fhrf1Jf93tOFa4Rc+F4zk5fWtQSZQYLVPqbLpqNOfk5bfR3?=
 =?us-ascii?Q?/x5+nqzRa0Z7dYSdXW3B0F7O6LFYwjAFxMSdrfiln6UNaKX4OFB1q/yb+n94?=
 =?us-ascii?Q?x9wQian67XLMSWA5oVVEnwYeMM9EJ/Spgrltnq5yD0igqrD/VZEs+mubhkRb?=
 =?us-ascii?Q?05+LDfv60woAJp4SDnKmQVB2GM6Z4NQC3JaVozZ48dO+jvxUHVMyoNq0/BjB?=
 =?us-ascii?Q?4musp1TOG90BXYc8gt4NG37wBZXI7mLNNKIECb/ixYSxLQP+jgNaqp4u8211?=
 =?us-ascii?Q?ETGS7vpJ5G75PEEVoUV9Kb/3XER/rTFXws4Eri7QBPxj1yQ3gai3YcZxjx6W?=
 =?us-ascii?Q?W8QKjKgM3QiIwSWzeae7bSTcOCHdLPxCBeoAe5iO3tn/ZPyeqqauNmi+2tGK?=
 =?us-ascii?Q?fBrF0TYwO3Sdh06gWFNSI346DubgtOkmOhCyeyVzAdyWv/niR/6Gpivins2Y?=
 =?us-ascii?Q?cFQQRdCLBFA5OlTGbZGet1u1Y8SWhRbsDFlm97LbQdVdlzWe1M6WF9zurxjN?=
 =?us-ascii?Q?U9q0weD3AVml0xa2mG1DuNHQE5K24rpVRqVUCAr9HqVOS2cANwViv0sy/LPj?=
 =?us-ascii?Q?J/F+N5MitM2KOQuu2ntzX2OpKowDNuZ0QaH9gZF4ECg2isgIsYT8Iz+mHNtY?=
 =?us-ascii?Q?1/15zjrZv9Im285rhNr2225JGkTUTXBEIus4/w9V3rLgKJkwUGkk8LGGlWRb?=
 =?us-ascii?Q?/Rvsd6jUn1ZNacTqI9SYrT/97wSId0to?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ea6273-2f9b-4446-c1db-08da0b255d07
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 10:27:13.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/73sjfAHGB4Ff0de95W4WmakTKHoYdmAUkzG35KzeJ57t4dmyEKt9WzkuxhcPHJLL38uwDghPP7zUkabYerIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4575
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following coccicheck warning:

tools/testing/selftests/proc/proc-pid-vm.c:371:26-27:
WARNING: Use ARRAY_SIZE
tools/testing/selftests/proc/proc-pid-vm.c:420:26-27:
WARNING: Use ARRAY_SIZE

It has been tested with gcc (Debian 8.3.0-6) 8.3.0 on x86_64.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 18a3bde8bc96..28604c9f805c 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -46,6 +46,8 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 
+#include "../kselftest.h"
+
 static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
 {
 	return syscall(SYS_execveat, dirfd, pathname, argv, envp, flags);
@@ -368,7 +370,7 @@ int main(void)
 		};
 		int i;
 
-		for (i = 0; i < sizeof(S)/sizeof(S[0]); i++) {
+		for (i = 0; i < ARRAY_SIZE(S); i++) {
 			assert(memmem(buf, rv, S[i], strlen(S[i])));
 		}
 
@@ -417,7 +419,7 @@ int main(void)
 		};
 		int i;
 
-		for (i = 0; i < sizeof(S)/sizeof(S[0]); i++) {
+		for (i = 0; i < ARRAY_SIZE(S); i++) {
 			assert(memmem(buf, rv, S[i], strlen(S[i])));
 		}
 	}
-- 
2.20.1

