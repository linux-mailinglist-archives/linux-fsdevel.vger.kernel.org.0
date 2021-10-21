Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA34356C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhJUAOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:14:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37902 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbhJUAOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:14:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KNjJrX019159;
        Thu, 21 Oct 2021 00:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rDb12PtZNgwTC1TYwBkAnpIWDw9Pt6HblK1iL44AkUU=;
 b=ZW/9hTO1jUKL+n8QzLRCnSq5cfz+N74UkwyUxbuBTwBzGc7KNHfFMzH6YS8mmO7+YGBw
 aEYiJSR7vMiMBVn3x8LcsBnJgChQsYbXGR7TYUnT69RMwSetrpIxVknxKCgdXWuT5v+5
 ZBUFhRS6UKgGHZpJXqg4vgedkQ0VSDa5r1AqoXPUOWS9YPpghRZqVAEZn2uYiWvYsxZ4
 K4AUkRzBqpWLAdxRMEErwN79eU9g+MJZAhJ5tg68dYNv038Kz7Undl7LO/i3/UmE1w7i
 qRLMQLceC/V5C+S6/wKvXhuJkWV44UUYQ6sRLh+OACllYZv6a4bSLwB2sEwKLEH6SgWv LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btqyphuu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:12:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L0BD3W010014;
        Thu, 21 Oct 2021 00:12:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by aserp3020.oracle.com with ESMTP id 3bqpj7vuvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:12:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1s2sBqsFk2Wei9l4OZbIuXPWhekb3J4yjfQp5oHQI8YB9F4/p5Ykd6QCmDAXpdRPx8VTCH6w8wfquK5jkI2bxBIIpuIipOl58JlmWuH4AK6KuVMDNIjR3V7nHhwZV8AEe8OXEUMKV9KOcviYnbKIhQsKkCVYW9ev7w8Aiha0yI1kfw+Ymg84YrtPtmSVhoS/2a9UOmaRwDcWsJGiPH857bdvDmhPdx07MPgBinI8qL6Zztye8nRFLAYg02h8bEP/v9nIQB6oc8J82lJCLGQhUpjliF6f0sdEi1I0m78bV0+5Es5JSsS8O8sdYi8swutU38ueku3BybDUyD5fNr1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDb12PtZNgwTC1TYwBkAnpIWDw9Pt6HblK1iL44AkUU=;
 b=O8qG3Dd6rmCesxeV2LtXFzlOghHOARGj6JslQbtSO87a6JBUxmNsvHiqIckVaeU/AZUQ+k4dGiwMT1kL3+c9cf4F5CwzGSkqnX1eh6ZxT+GWcm0EMdfAwv+IK0j+WOsPPas+D4B1iWtPExPuQysui6ZsAp/TKd+omYWNTmluV7Kobu1hMjJO/On+45ouKJeytckWMp5iuDI3oXxs/9L3yyfCmYu1n+0dUUxh/mx5pzL6ROm45ixXHwxQqOteLpKmYQ5cqMb1Czbn+hbDh3J1WYVIEw8vN1055pQ+1+Q8C+ZI1P7OaE2dwqfGW7xBKwul1vIk/krl4vekscr7VhzYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDb12PtZNgwTC1TYwBkAnpIWDw9Pt6HblK1iL44AkUU=;
 b=rKpx11dpxDYSYqNg2MaPwyp9aTgY980PhGBW67cRFi4qF5Jz6pckfCDz1uW9cOekYCYBa4Z4xrhBUgHV8Wgyt2BMCuj3r1PNNe3ZHtoeDlLSAfVgJTNZ9O18B3t3aBjgWxbH2VnCPR69rtpgGpTc900aAuNz6sr8rM9fXd0WpQo=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2759.namprd10.prod.outlook.com (2603:10b6:a02:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 00:12:02 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 00:12:02 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 6/6] dm: Ensure dm honors DAXDEV_F_RECOVERY flag on dax only
Date:   Wed, 20 Oct 2021 18:10:59 -0600
Message-Id: <20211021001059.438843-7-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211021001059.438843-1-jane.chu@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1d) by SN4PR0801CA0003.namprd08.prod.outlook.com (2603:10b6:803:29::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 00:12:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3086f6e0-b295-4ae8-3830-08d9942767f9
X-MS-TrafficTypeDiagnostic: BYAPR10MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2759CF48A81FADD320728D33F3BF9@BYAPR10MB2759.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwUxeInXWh+dgh6GbaS/ZG2Nv9S0cNJ6M42dZaeHBDJs558Q90G0R2h30G+aA3dCh2LfzmJWyQA/ahTIb91NfBH9wHpRUhPbLz24LQwxTDi2nc/xAnN81kzemmPwmScfKMnCd7/XDyPhNWepbqP7QhOJG/zrvKDustSxzm/HfGh4o5epcm/eNGP6fBFBnssAbDxt2nCnv4qpz/1+OKzrUhVmjQ9c0/wPCAa9WFhx2pRUtBlj+iqMPv/AF4kvb6otCDzlfbF6S9YH6BBLGvXXCSjDPvAp3qZMIvPDeMPU2rWMuEXGxzjNGrYzFgxJbJb0TjgDCSMAT28yHD/I11P91WFAub1FnuSHFRk3aKzHaNcXYE10DyJwa+YvavKRJ69ZB3NiS2/JycT1JWrbsyPkIelWMNA26e/3FVsoy83xHacU916cXMiiVuI9rZAUsd39hJk88SVbBHi5f972R8ZvpNZx+xCVg9n4pXEM6ARcSocBkGxcAHXwPzA5d5jxD/wpZu/x3vBTcacXOaCpPicCnYwiaSSI9DWOBaxNAzNM9sM3P/jYeH1YUA/eaLlA9fubW+bxuFpxRaNZahyUxaK4AC1B65GAErZBXlHRpDPpSIyDVDI/ug4nOCZc7qlLl6ZeOLx2FaMycGoOyu2JjwI7/9n5XbMup6N64gRaHe8etM3IVwf7o8zfY5cDzPMdMpPW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(1076003)(66946007)(66476007)(7416002)(38100700002)(83380400001)(36756003)(66556008)(921005)(508600001)(6486002)(8676002)(86362001)(186003)(7696005)(52116002)(8936002)(44832011)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1JriRzLKMTs+EtHmGlcariODedtlWhYMtDDMliqQ+PnnOYwKb+N265nSqLb7?=
 =?us-ascii?Q?8TImsA4Pmr5rNPkLiMJLcMJtzDHoo9bxJeIzfLWjqjB+TJV/qy2JLPWxmUPE?=
 =?us-ascii?Q?cO473bekRvRPx32LXD+5J2ZBvmmaBBSUMlXCdK3+mZll4QjuDJ0+jPbTxT8c?=
 =?us-ascii?Q?J8E5Z5RkTcdxdlFJR+I9jo8VxRyNGJDvmpH0Z3uDKgEzlRX/C07RxtaXhwqq?=
 =?us-ascii?Q?c475/0ZCWr2829X+9FzM0tggHKJwGeVLLB21iIyZG5BW3iEtJDsSjNG5CWKO?=
 =?us-ascii?Q?NlU458r2dPNhZQgamu61TBQ48pimdGVZP3gIZ1h1lMB7FKhHMrBA2EIScmHT?=
 =?us-ascii?Q?9YM4qC0eIcO0bWwFvE5JhK3Va2FKziCN1gh482FtlfefF4ZB6maXsgA9L6wE?=
 =?us-ascii?Q?3F+wRWJ75CwPNSEkA2rkSXT0PrUUU8JHo4Ec90iopP10Z5yR6S/zlqu3AiWm?=
 =?us-ascii?Q?KxslpKSQMHgqVEYdiTCTuacobcyruTAU/cRpNxZFHjYKtEr37Mdcw3HWyA2Z?=
 =?us-ascii?Q?ViDB5NN4tgFilwSBcFHCOYcRw7TgDO7XWb/rRydso0C1zs4ZzEl0xs+zN45G?=
 =?us-ascii?Q?xx3q7dOKU0SSoToXmzYzWxb8hvniCBfxrb4rCSMftf38CJTcQHYLr4P9rOqM?=
 =?us-ascii?Q?mY3SrVDiW2c+JvM88GmR5hwhjBXUBEl2Lyz8SvRaSArKg1q9JasUbZvHXzue?=
 =?us-ascii?Q?KN6jZtKmRwy+29XBZSSoxbTsYjVbjxlzkg030EPGvGyudI2SLvgr4kY/ztmG?=
 =?us-ascii?Q?3p98F6isss1Qv3T9jlOBQJOj2ZavTBQMj5B7GkKmLKULreEB9fAKXMAuQ+NP?=
 =?us-ascii?Q?4mV/IUkmR7RwkoMFwhCBDANQ+VzRO8pcmSJNLS1jW9eHseVV8vP1ktu7mmG5?=
 =?us-ascii?Q?bycp7geH8gJK/zT4KpPmqq8yjBkQwJKeKfCNLy59Exc3U0T5FldExKael5dJ?=
 =?us-ascii?Q?vTE+Z00seULukXaTTKSJ6VnRTWIfiVT+hAC9UW90qjVU6aflWzlasKKCWFWY?=
 =?us-ascii?Q?4SHs8qoQF2x0cVRX2ln5ED8cCX44z3lCkknCULe9XyxKK87lu4OjvMrIQbZx?=
 =?us-ascii?Q?80+GsibrZcRIlcyPNwpVZgtOXfEWg5my2Ae8H7IJIlZPmy96I+0Y9TLi0wPy?=
 =?us-ascii?Q?SexNpj68zuim3kxt7xsEVW6ad51jnZPtwTgzpOZo3XJ/IAOF49aJXcswzWgA?=
 =?us-ascii?Q?xUg/HPAipIfuTuiRVYAHYkLH29pu9panYqfrB3FeLj5l6DIBhTqf1v8Pzkhh?=
 =?us-ascii?Q?xZngUX68nlU3KeSsKt9FJvrnPzInBPqPsTWS8TqeOoNFe7H/mG7R0mN5tYSg?=
 =?us-ascii?Q?v3/dtJeqUjuVbQbM1WoYTD4HRUc8Xbozeto1fjJ6YE1RTQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3086f6e0-b295-4ae8-3830-08d9942767f9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:12:02.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2759
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210000
X-Proofpoint-ORIG-GUID: jlTJ0Uy0HZJPhubLMe06VMJMPNG1rwVD
X-Proofpoint-GUID: jlTJ0Uy0HZJPhubLMe06VMJMPNG1rwVD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dm_dax_direct_access() supports DAXDEV_F_RECOVERY, so it may
translate a poisoned range. But if dm_dax_copy_to/from_iter()
don't have a dax_copy_to/from_iter() foundation underneath,
performing load/store over poisoned range is dangerous and
should be avoided.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/md/dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 764183ddebc1..5f7fe64d3c37 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1058,6 +1058,8 @@ static size_t dm_dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (!ti)
 		goto out;
 	if (!ti->type->dax_copy_from_iter) {
+		if (flags & DAXDEV_F_RECOVERY)
+			goto out;
 		ret = copy_from_iter(addr, bytes, i);
 		goto out;
 	}
@@ -1082,6 +1084,8 @@ static size_t dm_dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (!ti)
 		goto out;
 	if (!ti->type->dax_copy_to_iter) {
+		if (flags & DAXDEV_F_RECOVERY)
+			goto out;
 		ret = copy_to_iter(addr, bytes, i);
 		goto out;
 	}
-- 
2.18.4

