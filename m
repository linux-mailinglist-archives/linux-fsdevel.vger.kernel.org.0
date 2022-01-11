Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2975248B65D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350422AbiAKTAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:00:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350339AbiAKTAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:00:22 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BI1hdM032072;
        Tue, 11 Jan 2022 18:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=dU3OUmaZaBuqD+PTIKLIGbhcAC9qHfJqQU+JmhJBNjw=;
 b=XvpqBCLd0fBbXr0trSTr0lJRaK33bYQBlDedF0udjYYXc8yr6TokxgeQpEAvhsCok0NW
 MUuD2iZWdN5BNMgORspAwGAbgP7O/HB82POB2R69qABqPCWCnJmUFSlZz3kH5cn7cVrb
 WTrp3dLUznvBcCs+K/vUKhM5LCmiznjWOdxug98Uj+KAcjCnMGnpa/V8gIA7pldakA/F
 6Pod8QHQdsXbNy7DkZHxlBF4Kj/lDm766w68KnTJ9D6FogsX3hLmBBKupybn4hvrm9Ih
 DiKt/+5iUb6/hbWBrWKu9CU4U20Ufx/rdHCBfrP+t/h7uejbTQLkytoNohFbylWhfkbf RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx43an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:59:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BIpdrC110997;
        Tue, 11 Jan 2022 18:59:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3df42n7d2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFV1c80YNvJIW2N9eoQ4hlMdfbHtdZDcwqaJCNIhKUlkbDK5qVmokiXDxuSwiMx5TMtFd6qrdsozb3wYF7ypFe5YbAwUmG+d91TNtuXLiS+NqucL1M/6fswiYSraWgJrLZYykrev5cUm6GXhu0x8dritmn9OZRWUlYJQXRF1aAmteA1syxqx1zBN4s7XtPu71y5Yh7WDuCBHUs6vYt9BsfUtlL+ChED4Elko9Z18kgbifC1PA4OAY5+3lPHjVuQmdt61eKFyI5LZ6FNIL2RUl4KWFMrT1iRG+jDblOirvX8UzHLtOxfErIoU21fJOGKo4inzG+aM5D89xy1Q8O9NDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU3OUmaZaBuqD+PTIKLIGbhcAC9qHfJqQU+JmhJBNjw=;
 b=CiUqgXMpJGM5PiUYWTZRYSWhL5d8yka+ngYDZ4y4/K3mrBKRKetfoULc6HmLCb91WC0DMk67gr3tyxeNZLhHTAmQQ57v+rsHWBmkuyfn6HvT8CDTvQoww1QL9d3xejO3IS1nmiE+1KbQjN4nqXhr1CTSv+/OIL4o3Rb5AONz6nwczuQdrt2d7nPW8oTvrDq5c4aQWjpFrRLwcUGLCwEVUPbVCARH/cJrUBb7Vfwf3zqsq9tlVxpCuB82gF0GgoTSWmJRfTND+xOuXKyeTPMqWc7aZUmi+Z5r4z1EndRPk84TEXdUZqhQGq1vVFTFNqyu2/0VJX10rsiNxhkMVmLWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU3OUmaZaBuqD+PTIKLIGbhcAC9qHfJqQU+JmhJBNjw=;
 b=OhIz3r28uQ3CI8GETDXZfOAh2LofqGDTpuvq8mC/ocGAcZhEhjVGXGnsJKSbUwAKaZWnN/woe/e05Ndg0nIp6x6wn0QioVpb+rCrkQ72DeAsq05RQgi7GQ+MJwGkdQPdoakPIucLsvkrLZrldItBKz8SQ/7hZ93bSnGuo5YDawk=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 18:59:47 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:59:46 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3 0/7] DAX poison recovery
Date:   Tue, 11 Jan 2022 11:59:23 -0700
Message-Id: <20220111185930.2601421-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb9460d2-b31e-41f2-206b-08d9d5348934
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5647:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5647220B43C69C9D08C0A981F3519@SJ0PR10MB5647.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifn49xF473S6Ee10Hyvv6NYP+upsk5gtz3EFljIx/YRd3KgXY91Mxg/AsS5lJy1cYVpXSk9vaSjHCCMmOvw+i4x0MJlufE0HvyOc0xGsLBzQpneKXqp7EmRilHDRz/Ya140dyuNcwa2qXHuZMEO1C85n3v/knSV9ZNas+Sl2l4K5JktxrXE5C9XG9QgbsgvGxKXNYdtotr8ik9ZgQFlD9X3YTr08UTkEI5RhqsptnMBHIdmlA+4Yanp0xaGkZLnsxp8cfHNBpCDM7gZXRn2eDdveuW3qc4amcOQwsGjXhKKzEuSXuz+G1M5p6bys/vG4uY6sUAndzmcvLLN6eh6qjBPm4xgBggxUK5NTms8HBMzxDePT7VaHFltQJGqf0G9tYQzEiHGtW287dBfCJw+e5KrYmY5im9aiKkNTscZOc29EiR/AeATfdk6Rappgl20rFL+5quRnMSDKeovXynNn4V5uT9WAzXSE/vZunrg0KBxeSFBhVje48Bw3o+ygnFVEdGo+wpqDpduR3SfFEtk0goIu8Ts+3hUpNJJ2o9puAK4B5rxBOBDvE/FD0Zbdhll8A+WUea3NbvCor3PVxVY8iswPlP6KuuijHArJ/cdX7Kh6Lcrlb6Ot1JWW9lE2F0e0wWe/vvGg+I4BJda3rgAt8amvlKkzywlK4epPMZNE8iVGT2v9gRDrWc0R1D2BUTdzag20EQ4vWLJ/VulZGECBuYapG1jeAeFBsUdbzbkqQ0RTY3v7cZRyWTkKXzFvLMriOLeE8iIV2+4lxLVIY1yusghXg4CIHOXGVvf3Zhcm8/58fvSfTp49ql26bHRytf0j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66476007)(508600001)(6512007)(44832011)(66556008)(66946007)(86362001)(83380400001)(1076003)(38100700002)(6486002)(36756003)(316002)(8936002)(6666004)(2616005)(966005)(921005)(7416002)(6506007)(2906002)(186003)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+wilDQdSaki24aJVLpVwGKr9CvfWXM8wrAB9iC/6ogJtDu1hmQlxi0eXU+s?=
 =?us-ascii?Q?h9pSpymWJABXz64KlSAd6sv3cihwTrN3zyzuqXXBiFVn5oI018Ze+ZkxCSr+?=
 =?us-ascii?Q?5g7YkZJq7Fmoa3JwJen61jxAa0D65eI16V3bYko0O1ctCpgutx+6bWc8DmXY?=
 =?us-ascii?Q?EG7LgY8TrUGPyUawWiZyajuWHi9bWbbYlocWU/OdO3VosvnrPLk8Kw8uEZok?=
 =?us-ascii?Q?Ukw7c9Owg5tGaKq4nU78IL2WJSw6D78BeVnzdXdNYFSEzDhq7DLItuQgcumT?=
 =?us-ascii?Q?piawu1S0NEqeit1L5rAKjVu/4CZ16Z/9CVj2l0vSCUatyq6b9dsQnNkWbF2c?=
 =?us-ascii?Q?nyK3ii7kTVZWPvhIEaAHQZxKfwzPWHR6EJYNIsICrtPsxjxs8kWj9xG25Rsg?=
 =?us-ascii?Q?Lj9qxT0MTYwZdcOB/cbDyQ23gZQV8rdk6epVJnlnTcydJbMpF7rOt0nQJc7m?=
 =?us-ascii?Q?0dMDzfrSfB/pLH5t1OS6seXj6DGXho7/LTJhiU0gt9F1xsZh5Gpt45UAELMy?=
 =?us-ascii?Q?Wj6F5/i9hzFYG/myTOH8TCEC9J5WQQpo1geK9zx95nPcsYndhk0SNpFehwWg?=
 =?us-ascii?Q?8SyIuTjZ/FyVvT7yebsZptPb3wDWx01Eoh9b2nGBHDSb/8mee22l03qjz7HW?=
 =?us-ascii?Q?IzSsqauvTKLYji1zAUN2Qoy+1kO15loQqbcwHFupTu5Wd5SqV+jgeNqFd1SD?=
 =?us-ascii?Q?CD+lAaf/L2ETwYAW4PuSx83FsEGuRKRKsm+iWsyyuEpqfwoXzevqmy/9Jo0A?=
 =?us-ascii?Q?UYW+Zd25fNHWg6PShhhPUbpH5wThI5laCKAYahmg8CJYWwv84PHzHtj0XJKH?=
 =?us-ascii?Q?hi5GsxHVObdnY0ZZQgEmnwThqD1NrpsVsR+BTl0gA4tEHdYpb/rWPg8uDWHf?=
 =?us-ascii?Q?znxsiHeNehd0D+ItDpBVeeBSy47z4eiBVemfc+CbFo/gNkqxGFm7jOZXk27q?=
 =?us-ascii?Q?ULhux+bjepHDnv13pGCjoq84KN+U1PNUx+vyVMBWujVWiFITSmP9KPn6lajn?=
 =?us-ascii?Q?R4qP2r2aQ6SjOFiF77j9uR2ESb+f8ClinC9WdkQLcYWqCBQg/Hx9cYBy1u79?=
 =?us-ascii?Q?3hgM3YlH/UOgsYuLDzvm4xyPlMHYWQfNvedtONBgjmHaG9f928BGcNLBtm6A?=
 =?us-ascii?Q?8GmpUyu196L92CwMWxHO4ELUbkTsBu2e3sWYaSLxdmhvhbDVOiMC9wYojtVG?=
 =?us-ascii?Q?RwAaqGDWP9+VBTJ3EnbSk/K90YPxsRd6m/Rqxb8+97muO0UY/ZzmwLahiDco?=
 =?us-ascii?Q?hGVOXlV5p7TtIsyXrmK90/RiKfDKzXNV3WLWi8vdRq1WHJGVV6NZgYvX4DnD?=
 =?us-ascii?Q?49Mj7nQd4whYslr78ceKMoWtUrIxtzbEwln//RvZulDueBxeiQvWUMU/8qeI?=
 =?us-ascii?Q?wPa3HfGOVdnUW3I2CcftgpoKXvsCU8ucFnjKOggOonaAYnz4rCRVLUHtvkD4?=
 =?us-ascii?Q?S+APnDuH7XZP/KbdJrxkufkDlXEE/Txdhwku4UvSaLaenCx/uuUecEGfMs+2?=
 =?us-ascii?Q?yVCzGeXewfPVubhVWjWbx6mx/jcDD9jNajGSbmDomHEp4v9k/UT3/5Q/B6os?=
 =?us-ascii?Q?9BUKCvDlr2ccivJaI+isrcRFHGUbxaZt8S6Es+EklMqKUk+bLdSMiERWEFzq?=
 =?us-ascii?Q?zZIuhWn/v7eXqsbagJ26kr5gIhGktgkk0ijKV414QWnD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9460d2-b31e-41f2-206b-08d9d5348934
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:59:46.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhWgVKdX5LUoTyVeb3DC/NI5++N1iAqzS8QSOqj/L5JtJZf+TVGHeEhIrJaTepA5BY18cq6ivRR0dr8xKhHzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110101
X-Proofpoint-GUID: O8L4oDIDyb68Snz-vv4Y6U5aZjS8PH-n
X-Proofpoint-ORIG-GUID: O8L4oDIDyb68Snz-vv4Y6U5aZjS8PH-n
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In v3, dax recovery code path is independent of that of
normal write. Competing dax recovery threads are serialized,
racing read threads are guaranteed not overlapping with the
recovery process.

In this phase, the recovery granularity is page, future patch
will explore recovery in finer granularity.

Please refer to below discussions for more information:
v2:
https://lore.kernel.org/all/20211106011638.2613039-1-jane.chu@oracle.com/
Disussions about marking poisoned page as 'np':
https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/

Jane Chu (7):
  mce: fix set_mce_nospec to always unmap the whole page
  dax: introduce dax device flag DAXDEV_RECOVERY
  dm: make dm aware of target's DAXDEV_RECOVERY capability
  dax: add dax_recovery_write to dax_op and dm target type
  pmem: add pmem_recovery_write() dax op
  dax: add recovery_write to dax_iomap_iter in failure path
  pmem: fix pmem_do_write() avoid writing to 'np' page

 arch/x86/include/asm/set_memory.h |  17 ++---
 arch/x86/kernel/cpu/mce/core.c    |   6 +-
 arch/x86/mm/pat/set_memory.c      |   8 ++-
 drivers/dax/super.c               |  53 ++++++++++++++++
 drivers/md/dm-linear.c            |  13 ++++
 drivers/md/dm-log-writes.c        |  14 +++++
 drivers/md/dm-stripe.c            |  13 ++++
 drivers/md/dm-table.c             |  33 ++++++++++
 drivers/md/dm.c                   |  27 ++++++++
 drivers/nvdimm/pmem.c             | 101 +++++++++++++++++++++++++++---
 drivers/nvdimm/pmem.h             |   1 +
 fs/dax.c                          |  25 +++++++-
 include/linux/dax.h               |   9 +++
 include/linux/device-mapper.h     |   3 +
 include/linux/set_memory.h        |   2 +-
 15 files changed, 298 insertions(+), 27 deletions(-)

-- 
2.18.4

