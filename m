Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1494A02CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 22:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351588AbiA1VdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 16:33:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38074 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351416AbiA1Vcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:32:46 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SK47cf025842;
        Fri, 28 Jan 2022 21:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Ks1lDdZOoeu+ebY6MNA+Kn7IVzJQAEX4+SArnEKkR/M=;
 b=X/Kyz8ddmvxkwJziF7x8ArpIVmLa/53s0n4KJa/zT+Ldz7crmmvTaQ9Vt/Pq7vjbNQ5q
 VCZl30xX0HD0tPVqBWWSurR6FddA3JrBxuxcoaklQrHPetMPbhVCCeHl5MqbC2LkTZt7
 XI3LfIuLCiAoIqBzqNLPYLl1YB4TL2cp9PllsKw+dqFNhJINMJn+jiDk08ZESPqd3uWI
 ryh+IVCIYVepJdLc3DYzgN4u/p4zxtKBcAuLAWTOdYuj8HzV4XdMAg+pKLLJc9w2Qgyl
 3iLTMSjo3cOH39fAceY1A8pYrZLff3qBvFytYFOvVfRq4BNNdbeHJTEjqUEQdHFIqiRY mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duxnp4224-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SLQvDm134966;
        Fri, 28 Jan 2022 21:32:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 3dtaxd6uyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN0A0U52s8U2fCGpQ5/XltJ0KP0oDGA6w1CwXqcm4NBX5iEDPTYp51XAgWCpLYcHLaqKd+ZCeAFup/LUB/xLZB48W54TBh9TKZjxy/6qhEKYA3NQruX48KFrhQuxrW7r1SRi20tEOFf+GpdjiHuysIHrQyhg7vmkE1vUlPKcv4RX5Va0wwvM7dkWam6PHTRoF89JOh6JXe8uSqbqq2/FOgPyFVaxZJ0uvsQLISk6mrb6+PF1ukDbK+xCgnHuV4RYcLpTV8W3dtxl1MvimeAQbKXwONRbEYc+UCDQa5hhBW/zpdeoYD+MMJasT/kc4VuGTCWWOPZtIxBvWIzJxgXyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks1lDdZOoeu+ebY6MNA+Kn7IVzJQAEX4+SArnEKkR/M=;
 b=GJdJapgV92T+/Ta6sj77lAzFwEQ9U37JIzRE0LG1AWwxvoGjy2AN/pX32/gpW6y4Iw5CS7djVqjfnp03X2ULtlTJr9QmOvTlKlQbSHqu+F5vIQf2bPFChJ5RnIEGDS6J8VDp1Ho4i2aNDWb3bxY/m6KnPy/Mp06/AapTCZ5tl2KEnA4vSh0AOqkIllbxFHTduUbjishp0xlE1klvIKcSYa2eFFdkbUZL6ijt+fu//scOMrTQxcUyp9PNZ/E5l9CbUeqobhVSBD2ddMd7e6VaAWcdVrZntUkFuR4S+aiaaOo1KiXRKy/w9VmpjbgJ3CKtyK+XqY1lfO39chLcOPdB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks1lDdZOoeu+ebY6MNA+Kn7IVzJQAEX4+SArnEKkR/M=;
 b=hZ/AGsHfWLRGlnnvYmTzxBKWfWrnQ5OhGhKWbyZyxZUAY3rSeXrHN3FZHXb0z4Hz2NGkae/HDoF2SLSb6oGgmCulmFrumbybTTNwUtHEUkS8gJYI7K+XwASdfrZOJ/P1fkGBQEFrs/tGFLiGSnd1cvj3lbvm8FgWsuI/15uMp+s=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BLAPR10MB4866.namprd10.prod.outlook.com (2603:10b6:208:325::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 21:32:35 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 21:32:35 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v5 7/7] pmem: fix pmem_do_write() avoid writing to 'np' page
Date:   Fri, 28 Jan 2022 14:31:50 -0700
Message-Id: <20220128213150.1333552-8-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220128213150.1333552-1-jane.chu@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:806:121::16) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dad539e7-1599-4904-a4e1-08d9e2a5b332
X-MS-TrafficTypeDiagnostic: BLAPR10MB4866:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48661462E6A36E8C4A3A476BF3229@BLAPR10MB4866.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZltUfmli/SEkiU2MSJzaOXcUQ4q90o81k+T3l7wneDKvnTveUU9cSG+A4WLDMAc6EJzZmcnzN/oXonRIssVReJBr5A3mqsB79NCHm0GAXIrclw5y5noZrBWZPvHCG5bKeOXQmpbv5l6PJmX+C0GQ30m9jAxy0XBSNj0NMlsz0Nq3Vd//f3z4dYxyAE29k4szd+OhrWKACd5RksAyzAtcfvVWB6SIywXNEgcH6LhnLBi1P8gtBE+FOORqDADqMf1pE0bRSZz0tGCa2Rg4Pf82f8KJDAAskF/731HRJkZIx7XbPOvUjtp8YuoKWb4sYqMeApiFQcxvzVmktW0qZsYgiWPPiNZK7A5WgXH5oi5kf0N336PXou5WuFXcqSupxUxOtH5bjln2U04I9kpGdclblNUIltc9k1jzzt0E7BggIFEpQIr9JqgLt4OdVPrPjY3xlVU7rfGpPwr5F3DcIbd1Xiqt1wgvh58D/Wg1gA+PHiy+EWuibO5WikrmQtEEYjPP9rOd2s5IQoZo6I4AG0MjqXwMzscHS0W8Jza6MXxfeDBTI0V/Xr5ZWOmiD+kE8IiA8KJi/bCV9OUTQQbBA5/94S+LIUlHZH/IwOcJlJeS2lhFt5S08i92Gr3lbG1QvzQUgrsgVtLHoBUayPqHBbmG0s9NhA8dGbXkKHuSX+nDGZOPwN0gqTXSIfLRjsSs4YWI9eL0udqgYQX9gtiSgCk1hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(2906002)(2616005)(52116002)(4744005)(6506007)(38100700002)(44832011)(36756003)(6486002)(6512007)(6666004)(83380400001)(186003)(316002)(7416002)(508600001)(86362001)(66476007)(5660300002)(66946007)(8936002)(66556008)(1076003)(8676002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LKSxtD2WWDXpkHIMbPhl3U83dMRp42GBfrsUp/BY9mwg2ZIAbfD7lIZ5r7iY?=
 =?us-ascii?Q?XwG5zBuYLwyvu+Aht4E8RWvpDzoNq+cDED06c0X86xPsLzWG006zk0EtZw7m?=
 =?us-ascii?Q?rCa0xWaDV/P/6oRmKbyqoRM39c2e/Q8WvQv82XZCpjJvaT+/FeZWtwsNWwRf?=
 =?us-ascii?Q?RgN0gyjGR6b139izkNaFcA8SGfCdC/qGb2BQ2LCBImLn3P6+F05UwDoycxBC?=
 =?us-ascii?Q?t7qoDYZVXq+9vgq3L6/JIVx8Km0lG623/IM06lKprk2WbbCEGdraLU2Y2ZPW?=
 =?us-ascii?Q?z08m+wfmmGsbW4QdmLrxtJ4IroAi9eLmioNtg04ToHc3I3yjeszCGDKGqMF0?=
 =?us-ascii?Q?ePKegV2/jVRglb6TOLVNLxXN8Zpows6eeHqKX0H1qfyD7wlGvpWAka50MFUQ?=
 =?us-ascii?Q?wrz7m3pRK/uF5mUYQJUYMGcJ9udL6UVMMVkkccgA+Ced0YyZhOhb1h/tKUbj?=
 =?us-ascii?Q?Ui8hEuqrIV3hhLYDLZ1eP9jniSHD8gbPQ7wYRoR71khsDuftxgz5TA5TMBgU?=
 =?us-ascii?Q?/jnsQQQQSC52/QjOPWZPH8nnAcb95wpXF04N68ffTqT9IN1LRofRhvk067Xx?=
 =?us-ascii?Q?ZoyP9e7FgB6n8i9oyfloYLLeZfNXF3SR1KjriB/lVaTWn7rxE7Y+z4zNfEHJ?=
 =?us-ascii?Q?R0ixFOcyJg1k5DHVID0+ZY6QaPhGxBAyZMRFW4GzM1qeUN2NnW2b7ICuo4D+?=
 =?us-ascii?Q?phBAZlui/4ZhIYNnHJCqOSlQRf7nfwaSvVLAINk9yaZ0vQKSJaVwQ5yEGyuv?=
 =?us-ascii?Q?LSKRK10ijdDt3eRwP6gBkUz7t0SC6v25VcKEAEh9tmtR23lW7H1A9Myhf53S?=
 =?us-ascii?Q?fpl7rPRkg8rJ5RAyRytmpUzS5cuDNcjIauSJ2/IBy3jyxZXdMhdoD1yLN/vd?=
 =?us-ascii?Q?eYXdKABR7yVgPxCNS/uIY2xs4TEc0P914y4vznna3cimb1dM2KeqmWzvseyK?=
 =?us-ascii?Q?h/IKbsEmItEYt1mooBAPLULzJWBEnOg5vJEW/cnX+EdRZ9btmRvGJCjHtppC?=
 =?us-ascii?Q?U/ulTCHSSzuWXnqo32vT/cjGgDeF8isa4mH/ApuWMiGs/Wzz2KktGTYpXTCY?=
 =?us-ascii?Q?4Xhd0wjFPztp3tK1YwWaE+N1F81x0CQrS4Eyd1tzh+tLWP4QR9+mKLMXEnUc?=
 =?us-ascii?Q?JOu+WiP6j+zKDUTcutZtQ5rhQfa4ZKj0QmsrxGDQ2NSTY6aPckQxM+vxSSPJ?=
 =?us-ascii?Q?AGys6z5n1NSq46wld1kfTEu+3fheIG3BrlmJyMglIRfAq7K9Kb1G/NfvjYxN?=
 =?us-ascii?Q?Gsh5dOUogcQW+fpwJ6Fj9YryR4c1Rv3flZVOx4LL5QSRgTervZyaQR4nfa6P?=
 =?us-ascii?Q?HzeVizMEkmBsM/i6OmywHOkY8l+66UpFv6JXe1kG8HlRJKXIvwbiHvfOGkyn?=
 =?us-ascii?Q?YZOsl8rGPob2rfQl6tq1qjQB+9kXFnLo1UhuJCHcpYMw/3ZMkTZdIn6hpHLS?=
 =?us-ascii?Q?y6nv2BEeVr90DNdj0nC9oP5Xclpr9p+vMDEUd7peenePi5OWqZkESLBCjioi?=
 =?us-ascii?Q?0u546IOalh6QYZzTHQUJY4Q2hfFsa1qekSPvL5ZBbpz1zEe0+yyIjHF77UBk?=
 =?us-ascii?Q?Ddlw5zoVIMa164zx/yOAKEbRdQlie5hHW8elTsWXHOiut15373n2pE9ZbZXY?=
 =?us-ascii?Q?zgmRBCekWrzW3efq8CzZs/Fc2MR6+Zvb2kyut5VqmWJk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad539e7-1599-4904-a4e1-08d9e2a5b332
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 21:32:35.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIL8+19nqU/qKas+8j0GNk/OOHvh4m7rGoWdIOol7pAa/bfJHEefGhp5nxT/4rWZwzedFZPe7e8Qnh1H0bo06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4866
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280122
X-Proofpoint-GUID: sMkB169Skh_pr8g4gZFJpHr2jWlnLt40
X-Proofpoint-ORIG-GUID: sMkB169Skh_pr8g4gZFJpHr2jWlnLt40
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since poisoned page is marked as not-present, the first of the
two back-to-back write_pmem() calls can only be made when there
is no poison in the range, otherwise kernel Oops.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index f2d6b34d48de..283890084d58 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -187,10 +187,15 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	 * after clear poison.
 	 */
 	flush_dcache_page(page);
-	write_pmem(pmem_addr, page, page_off, len);
-	if (unlikely(bad_pmem)) {
-		rc = pmem_clear_poison(pmem, pmem_off, len);
+	if (!bad_pmem) {
 		write_pmem(pmem_addr, page, page_off, len);
+	} else {
+		rc = pmem_clear_poison(pmem, pmem_off, len);
+		if (rc == BLK_STS_OK)
+			write_pmem(pmem_addr, page, page_off, len);
+		else
+			pr_warn("%s: failed to clear poison\n",
+				__func__);
 	}
 
 	return rc;
-- 
2.18.4

