Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70E4287416
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgJHM1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 08:27:20 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:33432
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729963AbgJHM1Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:27:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9UOlTcX740sKR95rQsLBpVP6WFvvDFQHHVRiEYM/duf8LMnJc17yW5Bq+gyXQSuBhKpPSP1OoJ7KfVMHGNzmNNXEiz0m/uaW55KzunIOxtUn/vbL3JwCyiMZeb/7V+jMpLCZFxGRfjTzyZwKsWchnqcoCqC/2IDGRpSukgEFyxgtBA8jlqw26kWqaK4/4i6QoEjY6Xui53eRd9aDKa9wtBn4Ds2YnDPh0Hu8ClW4loTNNCvyexhtIFWB78ICpxYowEqPxXjsCbTYarZAa3KRMc1RMDohDA/b+OtQFVt3di7glz+gEbSTSS6w4lIG/tHTezFqh2GTHb92MNZqBkiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AXQJ/zIQPA6jZaA19ielLnhq2gohOuE5mCfAYzCK1A=;
 b=Dcmcn5lb6Ka2kfmFzMc6tsV5SkcdZXVZ54E3qccpmRKWZJsyXebt9UhC1EOc0FmV/1gCS8A+vcypwwGIjTYl8VW9G8rfdg+ZjC413J7lnZaJzjctlcWRObERqst5u5cfs949ACvydnQhZjCNKpjoKGX8jVJKsdwzYAWMOMTWkBpRqcjeo3qJvX+lj/24GY77rH/N2NJgemkIf1OF4EHwL/xSagYNlByyVbOA9fBXil3i/Ka5bAnDQQj9YQtdiB47a4YRv12QxMTMwZEZY3yrpH0ygDT1BgTaqp8WqqZdNlxGFagTq9fr1U5CZLAFuHZIc5djtqeNiXJ+ad/zNf6xFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AXQJ/zIQPA6jZaA19ielLnhq2gohOuE5mCfAYzCK1A=;
 b=IEUspo+NktatnSHLOLNgpt/uDs2bem43Rnw7/0aBQM+Y8m60/kMTTMTFya8w84Tnb20/nVp87TAOb1ctHek3CZyL+Kxr5gGnVW2EHK9D/10Iz/cw5LhA218nyYCoLTwTZXedQFEu6tLkz6UmkqjiV5e6pRvCYgguKFVGPGj3+v4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2347.eurprd07.prod.outlook.com (2603:10a6:3:6f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11; Thu, 8 Oct 2020 12:27:00 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 12:27:00 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/13] selftests: proc: fix warning: _GNU_SOURCE redefined
Date:   Thu,  8 Oct 2020 15:26:30 +0300
Message-Id: <20201008122633.687877-11-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [131.228.2.17]
X-ClientProxiedBy: HE1PR08CA0076.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::47) To HE1PR07MB3450.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.17) by HE1PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:7:2a::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 12:26:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c71a2c5d-6e42-463b-6020-08d86b857440
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB23470BEEF7B2777BEF3F527DB40B0@HE1PR0701MB2347.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftUUnHAhw2d86T1ZPSHKFO/0otWY3C2CLR2wJ1Q2culefnpv46DQNUg+saBPA1o/i56kS1l5mFgHy6ucXkYaosuATkIRjfCoUHZmXL+0bF4Iw5HzEPH9i9y6Nbpc7cCH0m/y2JqoLtuYMSwBSuKqOHVCoVWQb/pgtHDNMiyxqnomC5zC8IUevmHhy8VwL4hL+lp4A+2wQkJSMjKxIWflvZHKEsVOZtGOeS8ESnP8tNrReaF1QuggyfwkQC7WfT0E4NTqukR3WX7dl6kWexE7PDMIvbdNaDHQtEnUCWE8/MWW27Zf4wXDEAxTcorx12nIfgDx2uT1Q6x77xo59flQtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(66476007)(103116003)(36756003)(5660300002)(6666004)(86362001)(66946007)(2906002)(54906003)(6486002)(4326008)(1076003)(316002)(6512007)(6916009)(26005)(52116002)(8936002)(83380400001)(186003)(478600001)(16526019)(6506007)(8676002)(956004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: z5e5HB3M2SJsZW3JI6Q4uI1T5wm/DOW0N8ELIaJBLXcb9wuyEzIRamJk5lVfbaA44J1pHdBBHKyefYrOowHYvNPczJxsAGdTCyKJyMXSEinNWUbDfADTFaZlD2FtoYbwV80D/3bLZGlTK0T06SSrhchHkM/jTXOuzDVYfG2j4AUi8VlGc0UNtIWDpWkvHOW8MPxE0h8nJsAYNXcY3CH+NR7PDd3kFbfGnWHZGhwZ79GzXc2G5CyI1oKRg+ec/CQZGlssT033HCmd5HwV07IMnI/PXs37AzlLiuZSMIF6zYPWJsNC+BFrDCYonMTivQvuQEQsL+fdXIPjxnvW19jNDkno4uF0QywMm+A5FfI4+atCI17akZvwV4AAV+4QimIapq/MByGmC0xe9lNtb1+Iypih1VYvhuGX1U0pp8SgCr/sPAeavekbxzpavI5V8YfSiLl0ejXwPtlsP3u5tUwOg4xPMvS9S/jfMzsaKuTt3kB6lNneB+YcdJFZxVQzFeFxZE2002sYNlajGyJYdrXFzggGh3zpsNlvYgkc4acopcky9QtVQz4CTKTM51RtdYYoAnQhpeTz2fAO5K5r0tXlCG+zU4us8LICv3fmEpWMbdcUESRMUcCrJJADDc90mvehwdv1+d2vlIOILfL9Fcx+hw==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71a2c5d-6e42-463b-6020-08d86b857440
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 12:27:00.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fytmCR4InArBmABdXuRMQjLCddLOqcAu2gkIvAVIvMhEdiILVHa1iArDS4fp5xK2JCWPyiju1YllEslJWklFjXFtLdjK/yk0JRSPBsIl2Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2347
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makefile already contains -D_GNU_SOURCE, so we can remove it from the
*.c files.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/testing/selftests/proc/proc-loadavg-001.c  | 1 -
 tools/testing/selftests/proc/proc-self-syscall.c | 1 -
 tools/testing/selftests/proc/proc-uptime-002.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-loadavg-001.c b/tools/testing/selftests/proc/proc-loadavg-001.c
index 471e2aa28077..fb4fe9188806 100644
--- a/tools/testing/selftests/proc/proc-loadavg-001.c
+++ b/tools/testing/selftests/proc/proc-loadavg-001.c
@@ -14,7 +14,6 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 /* Test that /proc/loadavg correctly reports last pid in pid namespace. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <sched.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/proc/proc-self-syscall.c b/tools/testing/selftests/proc/proc-self-syscall.c
index 9f6d000c0245..8511dcfe67c7 100644
--- a/tools/testing/selftests/proc/proc-self-syscall.c
+++ b/tools/testing/selftests/proc/proc-self-syscall.c
@@ -13,7 +13,6 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/proc/proc-uptime-002.c b/tools/testing/selftests/proc/proc-uptime-002.c
index 30e2b7849089..e7ceabed7f51 100644
--- a/tools/testing/selftests/proc/proc-uptime-002.c
+++ b/tools/testing/selftests/proc/proc-uptime-002.c
@@ -15,7 +15,6 @@
  */
 // Test that values in /proc/uptime increment monotonically
 // while shifting across CPUs.
-#define _GNU_SOURCE
 #undef NDEBUG
 #include <assert.h>
 #include <unistd.h>
-- 
2.26.2

