Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FB04739CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 01:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbhLNAx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 19:53:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61640 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242767AbhLNAxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:53:52 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLEcaL022072;
        Tue, 14 Dec 2021 00:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=pI+3/77VPPy8Tl2qH/DQ9k4hMlg2avKEUVXFwiO0Xjo=;
 b=MZyxMhs54fKXV3+bYZV52U6vHPZojsjBCwIMokGzRrDdc7VP8pElzy623uIhCwu3dQMk
 VdiRwC7rgr3hIGtN8VNiRPHRGYjhBcdZyaj/J3wUrMMf96RtW7/liisdUINMCrWCnjkM
 IBWFq0vcEQJ1P5PIjkLnh49XT28twBhSd/30rCz+L1snFxuTAOYYvLF7rqtF1w1lEjfX
 Aw+yCH1oYltqjX+U1QO8fG58zZlkyFsueUyQd5s4WryhDGPMBp3jIuyVD7eVF0vKn9VF
 FXAG1x1NtmdpCLkgLXcE+TgH1CHxUg9B6sbxN9R2hFtOWdI8zGgnB85C3eGc1BiYKvtz rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nfaf9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0fm8e122494;
        Tue, 14 Dec 2021 00:53:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3cvj1d37w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUycLenU6dVElbmwa6yBsVoYOC3fW+OegbVHgnB9i2XKwYFOOwCZraFYWDrr0A1TWDAD4EbCUiM2AvvMRqveE0wjeWNAGjbITpi+1fNR0WserwfnhSRwEp4hS91emQkGrt/wabo2NwT/6ivY4BXtbX+h+t9jHSmze2hero2H4hvdHtNxikSfuS1oT0wNkJVO0yQbz67Q1Ou/tv6buqIwDbFtepu6uN+IroSrpCjslgjRArHuNM6o1ySW39Qq7bOY/cp3wVfcPrrZVSwFGWAp+wWgMJGpycnHKKS6feLZgbxd3srKNFtm8FxlyN4YyX+KMNgENlukIJB5kBJzvQzcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI+3/77VPPy8Tl2qH/DQ9k4hMlg2avKEUVXFwiO0Xjo=;
 b=Wj/xcfEKs3hY1M15nHtW0JisNr8ryc1ODS/V7b8NrtvjsMM91YUUtqzAD8YcTzHyOOlHK5OaMtLyTOgeUHRlbFMldMPV4PUx/lJto6TnbEjLxa4+6J0EMBO8cY952mTj6K/ut6c4A1KPIaO1WJ+x088IaXYXy2bpqEQWCcxQrO4iVsA3Pl99ejquvjKeO6+OHIk2nDXRVrByzrQptP+BT26Yu31LyQ5AqIWPVMigrOQt+Kw8RGabt93o2ImKIbqSwVolEzx0hBvYSRiFE15BWJsyR1eRZezoaCmhy96oemScWZ4MeTqDb8WZ7jpsPYxBDvhrore2gLnU3AtZscWQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI+3/77VPPy8Tl2qH/DQ9k4hMlg2avKEUVXFwiO0Xjo=;
 b=nTK5BVoIbzYNNROn3ZNrE01LLyYNc7UgrOjo7id773b0HCpFKdGAELL6KTBm+kwoU/OO/5qX1/g/pWzej4PdJ4NhgwN3aU3p/fCPhXGxbxOyO3xE6Ps77NijBzvLHJRHvsj511KqID6HMwf7SPagNiabq18D6uAR6QKIMulC1h0=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB3893.namprd10.prod.outlook.com (2603:10b6:610:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 00:53:48 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 00:53:48 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
Date:   Mon, 13 Dec 2021 16:53:36 -0800
Message-Id: <20211214005337.161885-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214005337.161885-1-stephen.s.brennan@oracle.com>
References: <20211214005337.161885-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:806:27::35) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe398783-f645-4664-c3c4-08d9be9c2ff6
X-MS-TrafficTypeDiagnostic: CH2PR10MB3893:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB389302E85884C4AAA25D342CDB759@CH2PR10MB3893.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p04GH3VXcoApV9uUpeXqTVht2fdDb7tCkiapRx8+56o6BNCIJcBmlSZMHXqeqIjvZV6/wBl6PWI2ktfcgCl+GOQDGk5H8bhWL1AwJnmgohdNTjgj2y98OEEjSMa6fJOkcAQZKADtyQRIVj5q0wapG7FmO5318YXHR0Gb8/xp6bjx9rQsxQAZ4hwBX14KsD4K3RaOCcZAaB+zghY9t/TS1i/U52+5bVOFhfnR6s7TsqgwPHTgYFPLBMXBRwP51nK8Pc+AROqqBZt00e399kzG+37Bw27rTh/ZtpNMoWpsh/vJT8Q9cjDlFJvrvcXoXsAefxqOgeyIBpC+rFC0yvHMynuOC1RBLqAqZ7l5TRWG4Q28CrOMT/tn9bpWuCBiZzxGxdRW+rVaGfvsJwDnfz5VmDqJ4RpyzMUHJTaTus72q1HtgER51mqJE3Cxj4dm104LGCR2JeQ1KSAMCRjJ5bLlaAOeXnHef5BwXRfkhFEi1MYfqZCM9FXttMSlnxAGkdWqDJYz7y50CjkUQVzWq+kbLv6egCs1lBSmo48q4YeorG2xDRA5djBAe5RjuAXmawWSUxj0KgEoWjEjwhG+KC/cohdtShUcVptZjhp9cvzjvkII0Qza+vW1rHtDeLOqVyyJdiPa+olZyOXPmMTTDcA5966XjVn8Nv37nQltfiCOjHlt0de0pLT6X6PymQlSozU+AFx3h9bFRUQjPMwmOiW5PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(36756003)(66556008)(66476007)(26005)(6506007)(6486002)(83380400001)(103116003)(38100700002)(38350700002)(6512007)(66946007)(316002)(4326008)(1076003)(54906003)(8936002)(2906002)(186003)(6666004)(8676002)(52116002)(5660300002)(508600001)(2616005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uRhaAfpAc3d4qm41KUnpNdAPLnl+QepvsZi+rIVC394DHY+m5Lkpszl0mBqN?=
 =?us-ascii?Q?3SQWkbk2KVsdTrqlPA6yCRyxBVpwFgTz0jrnfUD83tKjztARqY4gNfvufQ/m?=
 =?us-ascii?Q?kL4fD6JoEg2sMR0axEOL5pVsiCCWn/Dep7cl1N16B33jMooxa3AwMc/iiUhg?=
 =?us-ascii?Q?bdyNnjZ/MBWj6GKHEQU93htCFoujyDGt2SACmAWpJfwdoZaytY/AY0Eq/HAA?=
 =?us-ascii?Q?tRTq4Os6QYyJvo7/MU12HZeoUVKHhnHmAiH8GT+vPpJ/YLaNj0c4tnMDZfQo?=
 =?us-ascii?Q?kO7kds9K6tvYgea5PlRrRs3soEY9DbQ6fq6zGXlP5exrVag8tZCSRWw8ni0n?=
 =?us-ascii?Q?tAK3NEOJyGMFmW13kiEvRVO1xh1AUs4MEwLDCXb+J9RpGCKLOR3F0nq2BjOC?=
 =?us-ascii?Q?d3wZsiZsWIkC1xg4UqpM0auqfajaKgBDK7s6RUcjafD60TG6knwdNzzS1UKz?=
 =?us-ascii?Q?BqrFNYiQAN/xrje5Og57p7z9sZkL3IvhOuGA9x+BxJj/Cp0bqWS3h3U3iB8n?=
 =?us-ascii?Q?p+6q3j8DEh9NYNa45PcaxCp6jwY3pWXS1HK4zHlyFhyba9Y4UMEHLdk088u9?=
 =?us-ascii?Q?fJDAIusjW8Nzw8SEzHx3t1b3m10NFzw0wB5iiRLf4nQWyCmQvMA3ONZz85N3?=
 =?us-ascii?Q?HgxGl1SHSG7D9I813sr8KLpjeU9XENURW+xn8MTVEh66MlSvm1xAKNkbIISS?=
 =?us-ascii?Q?CNqCqxR0+bpAF7vdPCDJcCrDVJ31DACH2gj5x4Z271tq3MfDXc6HWpzEWq3f?=
 =?us-ascii?Q?/wQemTjRpgsV0GiJW8v/EnlMV8l9drP6Xg2SQftg8q9OruY1E1fJirAjlw35?=
 =?us-ascii?Q?fU+lUsHRTmXU5PjJkz9UZTSwlXlQPEzauXNxPktxGo0QrL1Btgi3L+vFQAM9?=
 =?us-ascii?Q?oRKOKwZLJ4Ssxzk+1PIbjA34WiA/B+1I51BI+X/vv6TAH2o4bkQ1kMksjCIN?=
 =?us-ascii?Q?BKQiQW3KkYMTvFdY+vfnM4BDqDTagzzGQFFGUpRpjxyc9vUnED0wjyJ/68AI?=
 =?us-ascii?Q?WGJ5ucHaBSqApJxaZcKpkB2KRANA7rpJvS6qF/GQ//kTXJa/oej02agkuQeT?=
 =?us-ascii?Q?k7S2kLBIh91H/XhSvj13ydnbhhGfN/TtIDkLJ8O7E3GzrOM5/+exltaWOms5?=
 =?us-ascii?Q?BYkvQKw9XTG1UL9EOe1L587wYs+3XlSfDX2IUKTX8XSmpV9mzCwqTzilc/qw?=
 =?us-ascii?Q?MOYD03bv+ShO8XNZ8oD8HftO9FDl7IlhgTKm8uqPEh0h225SQTEHXb69TzHr?=
 =?us-ascii?Q?Zuwk6poO6zLuyIALI2N1annEakiQ/ivK2J4nF10mIqTV2Yr8R5CGK0BwahZS?=
 =?us-ascii?Q?0XoaRy4ZnU5CM8G0F5JAsgZ9q/5aZRJYVXSf47cpmWq2brS+8rJZE+FVVeWu?=
 =?us-ascii?Q?6Hqi5sbXeURol0/EgbnW4c+xaXyRW5kuUIBQ5H4Yyx89nK0nNPf5Zk0+NEBW?=
 =?us-ascii?Q?A+UFMhoQXGrPUiDn1XGO5O3LM8kzBzYZ/XFRAZhlF3z9unnd3IvOz/xCzj6I?=
 =?us-ascii?Q?yU9cv+t6P+apPQ8Odd2+QAZRJwWAWASeCkPWO+4dFQ5FGJ7N194WqawoLgyA?=
 =?us-ascii?Q?EgUuUL5DphhFYCQ+OCUMSg/NZi9LWIywNayb+Zv22de8Xvzb+sey6QPVTY4w?=
 =?us-ascii?Q?NwJlfFZRoZysjbFGdIRMlk+eVxeOUvMVWSHcH6E2wtpJNI1C5lJcVKFqxOF8?=
 =?us-ascii?Q?MMoWfQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe398783-f645-4664-c3c4-08d9be9c2ff6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 00:53:47.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HymrENI/MUnhoVXCKnzfSu++zWmj4lhZLnq55ZSnT6YTxw7S0Lx7UCdkZRN7xkpr+/KkNJ5ra7w2/GyHAh1t3dQp2gy6rlA8rCm6EWesvDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3893
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140001
X-Proofpoint-ORIG-GUID: ttUHbSxXJbyaQkp8dbDL7l3kyegcUqgV
X-Proofpoint-GUID: ttUHbSxXJbyaQkp8dbDL7l3kyegcUqgV
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

This lets skip remaining siblings at seeing d_is_tail_negative().

Co-authored-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Co-authored-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/dcache.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 685b91866e59..9083436f5dcb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1366,12 +1366,14 @@ EXPORT_SYMBOL(shrink_dcache_sb);
  * @D_WALK_QUIT:	quit walk
  * @D_WALK_NORETRY:	quit when retry is needed
  * @D_WALK_SKIP:	skip this dentry and its children
+ * @D_WALK_SKIP_SIBLINGS: skip siblings and their children
  */
 enum d_walk_ret {
 	D_WALK_CONTINUE,
 	D_WALK_QUIT,
 	D_WALK_NORETRY,
 	D_WALK_SKIP,
+	D_WALK_SKIP_SIBLINGS,
 };
 
 /**
@@ -1402,6 +1404,7 @@ static void d_walk(struct dentry *parent, void *data,
 		break;
 	case D_WALK_QUIT:
 	case D_WALK_SKIP:
+	case D_WALK_SKIP_SIBLINGS:
 		goto out_unlock;
 	case D_WALK_NORETRY:
 		retry = false;
@@ -1433,6 +1436,9 @@ static void d_walk(struct dentry *parent, void *data,
 		case D_WALK_SKIP:
 			spin_unlock(&dentry->d_lock);
 			continue;
+		case D_WALK_SKIP_SIBLINGS:
+			spin_unlock(&dentry->d_lock);
+			goto skip_siblings;
 		}
 
 		if (!list_empty(&dentry->d_subdirs)) {
@@ -1444,6 +1450,7 @@ static void d_walk(struct dentry *parent, void *data,
 		}
 		spin_unlock(&dentry->d_lock);
 	}
+skip_siblings:
 	/*
 	 * All done at this level ... ascend and resume the search.
 	 */
-- 
2.30.2

