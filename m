Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08344A02BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 22:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351394AbiA1Vcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 16:32:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30076 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351295AbiA1Vcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:32:42 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SK45bl004956;
        Fri, 28 Jan 2022 21:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HACBNB6Dlbd22EoArX9+ZdfgySBwzu2+nWVxtO7kBp8=;
 b=1Hd1fWipswtrwXaw3XLo4MraXyNtX8qhoUAiG0SVkuZWeIcnIdtzMIGTogkCO7YDGpMj
 q7hYZpT9cqs+kKR0IC/N6E59ALlNTWHnz2YsD9PCwcafii/C+Ez3HZvThCOoLTn/HFnV
 kbdp+LNFXulv36K59YMFCc4xZFRV92X3ECevEPCSMa/HlbAmLwDFTZwVurKs9OKaDiOR
 ufBmUTXNbk8VrB6HqHqb9zDLlXmha4xKe4as2/oCsJYA8djwerLSi78THfZKhiGAEzh4
 oBluHeLDtBT5X+WC7Tv9fRfCH0HeeSnJPKDK6ghgLHDtb/7e5XquQWOtdh/re6A0+Iar dA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnkcm8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SLQvTQ134945;
        Fri, 28 Jan 2022 21:32:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3020.oracle.com with ESMTP id 3dtaxd6uub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIOwEygL62p5CcFdyoTn7CpYdcOOo0Al0+WFkX2lRIL51+OoheGOXZV0YjFGY2/1HV7sGLKlk+lRY7y7wOZlgBSqKPF6ckzB0c6A2Q5M6fC4HV9qTWjuQinQF4IVFgt/ZHv/7vFBRszhET3wew8DeefokmR11824JrqivKdixRR69dHVGevrWEVAG5M/qMHfI3YiTlk7XgCd1NX3Kc+g4E1QyHjad5guAzBYoO0Zl+bKndJCMMh8Tg3NeW2Mzj5ZwAUrUxGVdr/tRwRFPQhCnEZbRBO7IVW4ELIMjpir5x8j9j+G6UhMqGnGfZChlnGAo8TerVhgn0Ri7WORS46IwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HACBNB6Dlbd22EoArX9+ZdfgySBwzu2+nWVxtO7kBp8=;
 b=nyAYFXSa71A1Yjyj8dCR9Je8Tj0Yfw6t2jfE71nJSI2pCkYjCVIZlyLiATJea4cL2spL25ZyfkEqb7rK9SRFH44nkU0ykLurRe2Qe283CNblgcC2UYN/L88O3Nmb1GKjFf7G0kny5cohHFpyRljUJikOLUx55T6Z7BGV3SfKZ2AyCvdyplSIP1lWAYf3K6DR6hWSezwWUnjqwSU7osDyavr0NYM7SrVvNQGC21rYz6w39nMC69m58KHGvHtCFWydvIKfemY3BfxXo4H1l/bSQ9GQmIy0YvIE0zZ2pUeSUjThEiwSbgbobfPVHjoAVr7lb1X3ZO+IyPuL+NwnI2ugfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HACBNB6Dlbd22EoArX9+ZdfgySBwzu2+nWVxtO7kBp8=;
 b=G+4RMn2BaKe5biHqBpaYRjNIi+V5HXnm/qkdu18BrKwYI8r8+jQzL2maDqyb/9DUEmnHtKcMv6RtnyXe4uMaHc0/UMZs6ySQ3YDAnDv0Nb1YjSvOeJ9FeFnpjonzLG6ddM0/IO0K2drcI6eeqasWUw4ByOaEio1gusrdIId4pAQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 21:32:24 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 21:32:24 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v5 3/7] dm: make dm aware of target's DAXDEV_RECOVERY capability
Date:   Fri, 28 Jan 2022 14:31:46 -0700
Message-Id: <20220128213150.1333552-4-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220128213150.1333552-1-jane.chu@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:806:121::16) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed6b6b23-c610-42c2-1f7a-08d9e2a5acb2
X-MS-TrafficTypeDiagnostic: DS7PR10MB5022:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5022936A531418DE8ECAABB9F3229@DS7PR10MB5022.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tj8suhPnBqAYVKSy33RP+GSPu7ECYiDQZV0shJnFtatgp/FXz9ygjlrdSNPEPKbmxzRbdDaqFFdJCfh4Jpih4m6IX2MsnK2gCjpLBtn2Y71hKGi0AXptoyn9tvVemYJLs+Lj//UcEIuK9uQ4YEEsWYZQm7qXjJSv1wAdovZtuAJH8z5ZGoWoXitj6J6S6358bo6tSEo8gWoleH182i7MrFZpQkIOiznPRCA8Z4oul0fO0LMUC14bwMUXDafVkRWQmo03zZNGsn+nSTRPIM9v2W1VoiXagV7H2qoDUOYnWKlBuLdqlxo6nJN2C6lDLuykwhFxKwX4B5SWaq1BztCzC04it9bD+aeqpsCNjru+twPPVTc2WlTypKy6cg9Hee5vBRndD/ZMijTNPMUtlhVsHC1O6N6QQ29YFoQA3v4ZZ/RqtlPvC4mLTHXIY36kZG5q/KlmGtAUfymNod24gYBnKWxMy6t6ARPpdrRFGc45azbtY0Z9OSv3luRA7jbT5U0x7VnC8fvmIZQP+W+a8SqqLLd4lnazmnloNJ19S1o1bLlxmASCt19hDGkaqYNbyfR50N1J2kbd0PR4yJiHSt4LXcDB8a20ZJWo64aB5lbAgCH/sos73NDDdOlFoNdFV88XlPFBqwfXWP9AUj3Pz8sNcqDq3E17oHxUMV+NkdWbTsZU3PDiSaqA7t7dwqsKICZnzIzYmntEjUgtO9kul9difg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(6666004)(83380400001)(2906002)(8936002)(52116002)(66946007)(508600001)(66556008)(66476007)(36756003)(86362001)(6486002)(316002)(186003)(1076003)(2616005)(7416002)(38100700002)(921005)(5660300002)(44832011)(8676002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2K2lo+1m2lRPwfXpsTgPTRQ/28kcmoBMDGIngaJSWHLtnF8pk7BUlYNkTfy/?=
 =?us-ascii?Q?fhXpBle0g1AxEZKoG0tTL+iB9zDcTkKVWokbphcfy2QWcRPqg2DVSslI/1rh?=
 =?us-ascii?Q?OnA9XPv1iGQk3bkzclT05K/puFCwcP+Q++oOTP7UXy7haHWU7RPRMVmqjPGw?=
 =?us-ascii?Q?UKIIIo2S1Q/n7JoXdB4StI+XxzvHNaKG60uD83lzfzr6sRD4wPnSrDWTP9YV?=
 =?us-ascii?Q?mV+FmueDG95KvbZtFoJPd7OXTq8C397eYqs511Zccz0N6IL4avreTg0Cjpmi?=
 =?us-ascii?Q?STv4MHCDhlP+Q0z7fMrQNfKv0ekWgSmrqCCvpYav53T2KaNpSjEdCu+NRxYP?=
 =?us-ascii?Q?xzsJlPyIh8F4BxCLSbnhYXPKBky0eZG3Ik84nyKXcrR1ejwXKhooztpfM82d?=
 =?us-ascii?Q?ihZ6w+rkggGmdSEaUqfUOEJjv4yYodNiV4mPr3EzdfFmLCCVVkFeEe3jLdLg?=
 =?us-ascii?Q?chpJeqSW/WjycAuoSiXnEx1KEI7oIhgw8hWL8du5/tXJ+WAgnolhqHbLAaoB?=
 =?us-ascii?Q?W8SpSjboEmIat2fBaWPxTBDO/IgB2brOXHsasyn6pHG2K+EQ1MvK0nFvfVLG?=
 =?us-ascii?Q?PpX0kTxDL4I8s/xVKFIYIIEw6aDBC7ppacb3+OwOk8SUnTwCe9rKKogCeZSs?=
 =?us-ascii?Q?nf/5Jzfe5sN+ftXkPOGXLZYSXDvXlawS5kseM27JLTD1MV3Cko/0XbXBRLCQ?=
 =?us-ascii?Q?v2ixkxNX2Kxb8tBkh8OM8wKOmOGrXl1rtC9dxK32cAgJWNg/e5iKeZ5bj/5h?=
 =?us-ascii?Q?tLhorhJ2f8aluTiLzD4HH/1x4H3z+Z9iSIOIKmEoel6fS1Tkoqrgo1Qq/lVN?=
 =?us-ascii?Q?wPLxGpniJE/BeyoilwG9zERv3bpJAp3tQOU0OFHD7auzQeBqIGD3xNsLWnkv?=
 =?us-ascii?Q?7q4VUypF8XWePj4RGfL0aFByYWz8x1GYDJvdpsqx7wswYjC/ctuv767t2gqM?=
 =?us-ascii?Q?w6XAQfZhniMwOFkGUXsCAGHJpwne0xP3ticEglM8UARm20D2BpnCbQ7UNmaC?=
 =?us-ascii?Q?XLaOP4I0oS7xBIXeMMJCX4NKki9gy8WkQpfVzFVBDMuuIvQon5JdZcdaB/VB?=
 =?us-ascii?Q?28kqzaIcmuEClz4NVQwr5vUBIBW/4++2PmdESwXtj6IdfznjOm94MqDEBENJ?=
 =?us-ascii?Q?hKi3FmnfPbzlSGpaZPave96vAk7U46tKcu//ZjuJUCcA7nes2Om3DY4Hglfj?=
 =?us-ascii?Q?bNey0s5DZrl3YBZ+i42PpsrUmnoGFSfThCeFenoXFoL90/znTHWbiUhhR1RI?=
 =?us-ascii?Q?72+tmQfCGvSMLLlDaoZHwtf7sMx03VLOwoVy8KN9Gltvz/mXn5oMJIFmYYWw?=
 =?us-ascii?Q?bbon7R0ytWWZ5MOZIOETOch23CwYQ22PCqRU9GYW9pA5saoEV7Gahb2Y+MTy?=
 =?us-ascii?Q?AaqcJ7yaoE1XEFoGw807I8r4NXzq0h2OAnyD/7OcxQ7A+r0f/hzenpgGmIZZ?=
 =?us-ascii?Q?Gs0KWl1ARt+dcDcMXi+h/pmEEmdy+HurW8uv6EvZqpCMuFv/SMQEKQCMO29I?=
 =?us-ascii?Q?V8CwQfy/Jxyo4OD40VY022gqStwb4bp7TmuFJ4yAweInO57d2pBuU6FWs8O8?=
 =?us-ascii?Q?Dnc6FLpWvHnz3D1EwfpWPprRnxZnXYVrehb/DZ57QCkLQuqz0tSoEgQ1o3HX?=
 =?us-ascii?Q?cHdSAlNZeY44gVxH5JsChNMMLNxwcrImW0MvU9VPS4eO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6b6b23-c610-42c2-1f7a-08d9e2a5acb2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 21:32:24.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5O3kfvv7wtlQs5bF5UjEQDWtimSsRnfYCsIfBL6TsNbPVduz4p7K6NbEWsRobUwkHOsbDvY1VzJg4wcg61+dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280122
X-Proofpoint-GUID: rE7T-fmfRUmJhOYH4mkoafNkr3zMWlYD
X-Proofpoint-ORIG-GUID: rE7T-fmfRUmJhOYH4mkoafNkr3zMWlYD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If one of the MD raid participating target dax device supports
DAXDEV_RECOVERY, then it'll be declared on the whole that the
MD device is capable of DAXDEV_RECOVERY.
And only when the recovery process reaches to the target driver,
it becomes deterministic whether a certain dax address range
maybe recovered, or not.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/md/dm-table.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e43096cfe9e2..8af8a81b6172 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -844,6 +844,36 @@ static bool dm_table_supports_dax(struct dm_table *t,
 	return true;
 }
 
+/* Check whether device is capable of dax poison recovery */
+static int device_poison_recovery_capable(struct dm_target *ti,
+	struct dm_dev *dev, sector_t start, sector_t len, void *data)
+{
+	if (!dev->dax_dev)
+		return false;
+	return dax_recovery_capable(dev->dax_dev);
+}
+
+static bool dm_table_supports_poison_recovery(struct dm_table *t,
+	iterate_devices_callout_fn func)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	/* Check if any DAX target supports poison recovery */
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->type->direct_access)
+			return false;
+
+		if (ti->type->iterate_devices &&
+		    ti->type->iterate_devices(ti, func, NULL))
+			return true;
+	}
+
+	return false;
+}
+
 static int device_is_rq_stackable(struct dm_target *ti, struct dm_dev *dev,
 				  sector_t start, sector_t len, void *data)
 {
@@ -2014,6 +2044,9 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 		if (dm_table_supports_dax(t, device_not_dax_synchronous_capable))
 			set_dax_synchronous(t->md->dax_dev);
+		if (dm_table_supports_poison_recovery(t,
+					device_poison_recovery_capable))
+			set_dax_recovery(t->md->dax_dev);
 	}
 	else
 		blk_queue_flag_clear(QUEUE_FLAG_DAX, q);
-- 
2.18.4

