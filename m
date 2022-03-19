Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF704DE681
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 07:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbiCSGb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 02:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbiCSGbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 02:31:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9E92D638F;
        Fri, 18 Mar 2022 23:30:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J3CLUq001925;
        Sat, 19 Mar 2022 06:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=m3d2i1c4LKmCJX7BC/CCYxj8s31yz5Gw7yMTH6eEnzo=;
 b=sa/lQOvPAec8XwpVYYr/YNCvRrfI2uLN8kNwyUBwck1OO5+GjMHgU9kvhn02hPo+HEc4
 NT3LxLkkkZ1wQw4wYk9RgYasqB08RwsufApWfS6bXKgbom3puwKurtlfQvPdvUcKN5TC
 2G5ZUgjlfQLAr80IMzElrCYRq/XfhpmeFRd9lXfDJqWQTeTYuFcQ5D1yuVHFL5Xupvdh
 4YOaRGgtSFivXjnnAZE11pAIirhX0o/EoWs8O1ZFbS75WdDcCfwI2W/NkwRbWbyrqNHP
 ZhFAsbI19eTPaQb/An/Xtr9gjbNu4PPcjf53ofVBewuOijRVuGp+vE79ThnGNam/ygnS rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72a844w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:29:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22J6MkAK028031;
        Sat, 19 Mar 2022 06:29:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by userp3020.oracle.com with ESMTP id 3ew8mfrwm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNBzYct6uDlzKC7KBh4Gm25Kf8ixJJWps+3WlcYN4BjFYkQKZpGTFOXmRqvi393nih9Wx6RyMU3YjJiYDId7lllAdoYI9cqRE0NBXEEV2CEqlLSSOP/KKSmTXdufNI3QM20HA+JYsoMTcmNKY+P5GqzELGkpG3w5nA0GJ/vL4O2syHXRZ3qA4Ns8nGz1prtJQunlpRIOfe4kcCxg9ysg+sBJxih5JwafwdHCL8D/CwLndL0xaRxMAbCJ395Rrrjk/lLagHlILGwFI8rlDP/bNcRmjpujzGuhdjKcqFQKT/xm+8dJGQgl9EcTR4ZK7s+3FQ7xlpslUPq+DDdVaiBJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3d2i1c4LKmCJX7BC/CCYxj8s31yz5Gw7yMTH6eEnzo=;
 b=gEnVn3cHMqQhSUmvDjLSW9Z+wLj+N2PkoCTPXXMI9S+v8RfPKu6p3zLAGZnbowFQwzW/CKRmYxpx5IVekITXOu5xZG8emJPKZDxEdTiSPz3s+JPQZQE36e+OJIpZ+L8pg/kzcBoIE8ReeoxdN0WZESl+SQmY4cv8AlPHaV2zFieRmXIr+LVkL81AEIQXG4kMoqG9tF9fxJLKV3plyY3JkEVsLkidc8R9f2A9gEda3Q86+u+aDth/lHYwCQA85jnR8s1d1MvphwykP+Y1dkXX5V4NrbeT4oNh6M3JHwsHVFnJGnbSMMxw9YG9Nrr0dVDTPAX10b6FsGQIrHnSu92Q2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3d2i1c4LKmCJX7BC/CCYxj8s31yz5Gw7yMTH6eEnzo=;
 b=I0NXcg0y/ZZj4fnCPir631wvOd2ps2+9FAfyAjglN27/5jIEwHRpfGHphLeUKK7n7DmCeqUBqVFs2Qb+a9SwS05Ix9QseKgoN3JA/wDx4ZVxC8s35c361jX40jtJJqesO8l4jv/1IiYJU4ogA+uMZJw8fyn+9OMlBI9Jg7pLyEk=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY4PR10MB1798.namprd10.prod.outlook.com (2603:10b6:903:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sat, 19 Mar
 2022 06:29:25 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%8]) with mapi id 15.20.5081.019; Sat, 19 Mar 2022
 06:29:25 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v6 5/6] pmem: refactor pmem_clear_poison()
Date:   Sat, 19 Mar 2022 00:28:32 -0600
Message-Id: <20220319062833.3136528-6-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220319062833.3136528-1-jane.chu@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff731b21-4de3-4ac7-3e2e-08da0971d03a
X-MS-TrafficTypeDiagnostic: CY4PR10MB1798:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1798E0E9931C1FC341563E92F3149@CY4PR10MB1798.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paAS/Y84TQ6hkW/JLc+m6KtLnhML5FxwrxxrKRIwkz3s3QD2cH7FUQ34B37y9QA6uowbWeFyWwWyEEHMuo1N8cBcUtN2i1FUwCoj0LFcxBVZA7UQigovBpnAwIX1P+XOwzv01AY/cQ3Li04pGU0fGSdDDKid8+ty1yjwVqi/wrykn0UZRDM/biaKUmCEaDpAfxRMM9/gB6PfOZdeGnCDM8njOuiEj49fhCDscmqCKV8zmtkM8qZaFRInbG7RUEDNxjd4XtGVtxxEdPYgLbIQfp1lfqEn8M0C/nbPCUEZJnjyylsWG927stwqdru6NZbVs3hJrCWUZ6FJdf8JiGjlnFighqMU/UNNrqJgkaQV07jn+T92F+fXgwUj/EHx18ykFPnYAU39NxFSjRpMT4gLvt4UXaKpdffqnXCt+6yLqcHPWx8Vm251c8e4zkLk4iGN9akQOq+gch5iWM9fUyY0ZxjxOYBNkXHqz6+Vc87T3BRwUqtsp42PCTaYgnPvhMfBzNo34tTVstwk1xVMDeo9lLdsXQL7JyFu2xSI4CKqrs79bUrDuxhvGWQUYrijPwWntae4dpsjpbNs2e1N+p9CJcWmnLjrDyvogZ7b15Dex9QmHv9ZSRPUeJzcJG3PcIvpULV1OzIuq5GVHm6MSh0LLdRonCkEukZqvD7df1Hl39WU2U0jM4pMb3yDPb7CFIN0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(6512007)(66476007)(8676002)(83380400001)(66556008)(316002)(6506007)(2906002)(38100700002)(66946007)(508600001)(44832011)(5660300002)(8936002)(7416002)(36756003)(1076003)(6486002)(86362001)(186003)(2616005)(921005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0R42Bw60kqrRT3eBvL7jFBpeDP5VMw/+WfxZkI36Itr8WvaCnEmNkmXhUUo?=
 =?us-ascii?Q?roYiwSgXuhxIC0d8QQ0sV9trOLg3mhxjhUQcue6Cv3E98vOeScL0EMkZ3GeZ?=
 =?us-ascii?Q?HUZ1sw3EPNaQMAcdWaLnj+fEA6AF5rkC813TPrpe+eAZJg8NP7FGgmh2hAv+?=
 =?us-ascii?Q?1raCjJrKiEhMleyYXVN4k6VsIAmUbhCqynoht8avt7H0InszopkeAwrtiTsB?=
 =?us-ascii?Q?1shEGkHd5yXGvR2V47fmJNUoH8LSFCELtpuaMrniwyUL4oyrznblSADv+LDy?=
 =?us-ascii?Q?AA0kEJTzx2AuUZyRp4ztkk/n5zn5gKj1AThp0k5qB2NUvNfZqnveBrGFVNx4?=
 =?us-ascii?Q?/6kWCGiR4c3bpW7H3RaR6fokAHbG1fK2L9Li1cp0d+/FzfXhUc26S0/bl3iY?=
 =?us-ascii?Q?w7Am5VVK9INAJCiAEgUZwy4hYF50rsriw9IFWu/qficSNkQcbDwp6P0ANajx?=
 =?us-ascii?Q?9PvBhcrN78SzBiZ5Pj0nx+q+qn3SGfeZ4ZzNAnG8GkBTOlGUAFCLfMRLHYZ0?=
 =?us-ascii?Q?WHG2Z/otH3M0UKoFog83Rh+o9433AYcHgiXQ3T+Fbm/Jkx+2RUiUU2DB2wYB?=
 =?us-ascii?Q?TomDDH0o0v6aZGGQ0q+C/5Nbn/9fXSZe5uh5rnTLCI6zqZtsvR3OQyWNtIHz?=
 =?us-ascii?Q?sGFItN0PkjuJwX7T6Bl0e86wb223KbVLqBU8t1Vc18rALlRPvqRa2r56NQSP?=
 =?us-ascii?Q?1dUTOmlDfm+LqdJIsSgjLTFSy8CzE76E8KMh+yF1y9QDky2bj339pKtO3nu0?=
 =?us-ascii?Q?sDCepHC+9ow86lycjT/j4hzwlZznWigp3SexGAdH0/SJQG3TcbAfc7f1jaQC?=
 =?us-ascii?Q?Du1jXln8x4hQERTamndjq4mcahCpZ5naKueiZKf/Sko1SadSlLpbPURAeJSB?=
 =?us-ascii?Q?u3PWsazsWsONF3S6MKTi0EcRGBnVp+iS2Z/R9+lU/M2hpdMPjbzej085wyTn?=
 =?us-ascii?Q?b8T1EaNitn5EVCKv1egukm65I7ou25uoiZ+t9WqbmZ6mKLhTJs4MmHU9aq+P?=
 =?us-ascii?Q?9wXxUEja9LJqjpGQq05uy5bms1FfD5FqWUJxbJxDbgpQxEsimS7iD2vq+aPR?=
 =?us-ascii?Q?1qsnA/Uj1y1H/ns0tdLhOUeDraw5qEPa4ESaraGv8Hy1CVrytVNSMNtBHXaZ?=
 =?us-ascii?Q?2kT6iKBuvs6K4b9igp9LRwlFDwy13d8AjyUTbcMxTGKgEpF4aNFqWkrt7CyT?=
 =?us-ascii?Q?YRYtWZATi0dvyipk3cXzdoGlEyRK57wsf5c0g73Z9K1W2tRat3g5ca6AaUoN?=
 =?us-ascii?Q?QWWeSz/YzENYrf8L07W1rjdJs1sIODTHzNrrfF75sTEyEbHQ8sZCdyneDEBW?=
 =?us-ascii?Q?2qPNsxktqXIMLoTdYeS37Tped77TlL67OZPdFuBlJhUYvhfb1s8qJoEbZ/fN?=
 =?us-ascii?Q?6+v84IVy/2jsvVYH6mqCpwl7zYxs5+EeeCmhX7aEcSr8znnFZGpQBHAOrvYp?=
 =?us-ascii?Q?F2+YU/Vdgffp7j5g52/hJbnS1vaf5v9vS8pBZxAR/eQoMbAyi4d5fQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff731b21-4de3-4ac7-3e2e-08da0971d03a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2022 06:29:25.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4TH/Ph8H0gSf0ZPbrq1zZQuxEtX6sSIRVssH74hWAnaKpLwvY1nphUmlvTiAabUibZ7L1dU9LDs5fHbwIESew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1798
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10290 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203190038
X-Proofpoint-GUID: 4oZ6RGTnhXNXOFF_gMavcjLIr8l2ndsq
X-Proofpoint-ORIG-GUID: 4oZ6RGTnhXNXOFF_gMavcjLIr8l2ndsq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor the pmem_clear_poison() in order to share common code
later.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 81 ++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 7cdaa279beca..18f357fbef69 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -45,10 +45,27 @@ static struct nd_region *to_region(struct pmem_device *pmem)
 	return to_nd_region(to_dev(pmem)->parent);
 }
 
-static void hwpoison_clear(struct pmem_device *pmem,
-		phys_addr_t phys, unsigned int len)
+static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
 {
+	return pmem->phys_addr + offset;
+}
+
+static sector_t to_sect(struct pmem_device *pmem, phys_addr_t offset)
+{
+	return (offset - pmem->data_offset) / 512;
+}
+
+static phys_addr_t to_offset(struct pmem_device *pmem, sector_t sector)
+{
+	return sector * 512 + pmem->data_offset;
+}
+
+static void clear_hwpoison(struct pmem_device *pmem, phys_addr_t offset,
+		unsigned int len)
+{
+	phys_addr_t phys = to_phys(pmem, offset);
 	unsigned long pfn_start, pfn_end, pfn;
+	unsigned int blks = len / 512;
 
 	/* only pmem in the linear map supports HWPoison */
 	if (is_vmalloc_addr(pmem->virt_addr))
@@ -67,33 +84,47 @@ static void hwpoison_clear(struct pmem_device *pmem,
 		if (test_and_clear_pmem_poison(page))
 			clear_mce_nospec(pfn);
 	}
+
+	dev_dbg(to_dev(pmem), "%#llx clear %u sector%s\n",
+		(unsigned long long) to_sect(pmem, offset), blks,
+		blks > 1 ? "s" : "");
 }
 
-static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
-		phys_addr_t offset, unsigned int len)
+static void clear_bb(struct pmem_device *pmem, sector_t sector, long blks)
 {
-	struct device *dev = to_dev(pmem);
-	sector_t sector;
+	badblocks_clear(&pmem->bb, sector, blks);
+	if (pmem->bb_state)
+		sysfs_notify_dirent(pmem->bb_state);
+}
+
+static blk_status_t __pmem_clear_poison(struct pmem_device *pmem,
+		phys_addr_t offset, unsigned int len,
+		unsigned int *blks)
+{
+	phys_addr_t phys = to_phys(pmem, offset);
 	long cleared;
-	blk_status_t rc = BLK_STS_OK;
-
-	sector = (offset - pmem->data_offset) / 512;
-
-	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
-	if (cleared < len)
-		rc = BLK_STS_IOERR;
-	if (cleared > 0 && cleared / 512) {
-		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
-		cleared /= 512;
-		dev_dbg(dev, "%#llx clear %ld sector%s\n",
-				(unsigned long long) sector, cleared,
-				cleared > 1 ? "s" : "");
-		badblocks_clear(&pmem->bb, sector, cleared);
-		if (pmem->bb_state)
-			sysfs_notify_dirent(pmem->bb_state);
-	}
+	blk_status_t rc;
 
+	cleared = nvdimm_clear_poison(to_dev(pmem), phys, len);
+	*blks = cleared / 512;
+	rc = (cleared < len) ? BLK_STS_IOERR : BLK_STS_OK;
+	if (cleared <= 0 || *blks == 0)
+		return rc;
+
+	clear_hwpoison(pmem, offset, cleared);
 	arch_invalidate_pmem(pmem->virt_addr + offset, len);
+	return rc;
+}
+
+static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
+		phys_addr_t offset, unsigned int len)
+{
+	unsigned int blks;
+	blk_status_t rc;
+
+	rc = __pmem_clear_poison(pmem, offset, len, &blks);
+	if (blks > 0)
+		clear_bb(pmem, to_sect(pmem, offset), blks);
 
 	return rc;
 }
@@ -143,7 +174,7 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
 			sector_t sector, unsigned int len)
 {
 	blk_status_t rc;
-	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
+	phys_addr_t pmem_off = to_offset(pmem, sector);
 	void *pmem_addr = pmem->virt_addr + pmem_off;
 
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
@@ -158,7 +189,7 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 			struct page *page, unsigned int page_off,
 			sector_t sector, unsigned int len)
 {
-	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
+	phys_addr_t pmem_off = to_offset(pmem, sector);
 	void *pmem_addr = pmem->virt_addr + pmem_off;
 
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len))) {
-- 
2.18.4

