Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44014356B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhJUAOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:14:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20264 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhJUAOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:14:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KLtHCY000751;
        Thu, 21 Oct 2021 00:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3TfhDz8ts8IWEO4GcwpgTLL8y4U50rZdN2FCxSu4rM4=;
 b=D/nI6OMISifpZ6QsRIxT4f+91onCeRbLMCGBTX4HeqpFyKRa41lfTL35ohZnoPo2Q7wD
 nQ5FtKHuxVAGmbz0p/lpUTKuh0GCNJ83dP6KmKghXIKHxERbxTm1eDAupGeBJ1xXBVwU
 vuKTaycF1pNjWCiQVN2/ctjMpQFXBxClA1v4v/t96NAzCmGXN8C5Rm5yy+fKbHp2F3hQ
 yvC4uFVQBN/T5Gke712TpYYLwsdtJlrEl2mdfvUJjDx5SvGpMwDTG2ydkvAXx2M3gcCV
 MCXImKf0DUPIsLUNmmkCYfXjHJe0JcQ4cygALMZO3J8OrKmBwySy/hkF5dqWSJltBlg2 rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkw4ua7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L0BbUg133229;
        Thu, 21 Oct 2021 00:11:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3020.oracle.com with ESMTP id 3br8gv1kmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIQWgOkbV8Z/gPvXH2PlgW27M3tZPi6yxWOPargXW9HhHLmXgbJ5WNFQjesW7qutbfcP8JUzhvIDtxXwwxrd1x96NQhPHUEzMQQxzcQ2lfq4X9eUUvrLvTbv/iQBuCoh1NyzFU3ztiwzn/0JQRV05FJyq1GPcbqM+MSS0JaLGPbd42EUSkeQmJfrBe73PDvWn0eY11lYi1UeFTVyPGvqtauQwTNJgx38yEkKFh1WhrjC49pUZnFkVvQ1XNP4FRfrNWviE1kQltNw6VBFRhObBI85wJWGQnMmleW9wXA3eyHHqIQ2eVIwOmNKX97bKgTJ7GPPZON94deJgIyCSf8QPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TfhDz8ts8IWEO4GcwpgTLL8y4U50rZdN2FCxSu4rM4=;
 b=g4pSS7g4EOljzsGMeqDyEXfxB/1KBhlf/7XSa513+QdmZ6q1GWACkOigWt4+Q92HX0AC4jP/0SiWyt9huvXSNk5wB45dS4PrfZZYrkMoYh7rWXvIODD1odEbyK7HRj/CPPh9xWBgl0f8FkdTjO5HVSR0rHZBSBShPzz6vGRy/wIKgHlKPEufJTdQudpREOmKl18mW4/dl8ezfDYbcbaRXLhBI7t+V+xp1kDnT0thFMHaSMJtGru4h4M/dZB325n2xGAyMSWZxDDnd9zbid9ZS47QyoJ0Tkvus2Ttj5sMIZpQy3IMABeUFdPaJSo5zMoRcq7buTHUuzU8INPsNXc05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TfhDz8ts8IWEO4GcwpgTLL8y4U50rZdN2FCxSu4rM4=;
 b=KqUcBvZPjGXMzyaJcpJEpvHowzrxoxiF4cBYynRj+CfbI51hYkE9/4ijXUlRZgsZjvuQikw77XXfZKjT1iBfdEipC7jPuk+0FPbqBFA4jdxIoY4yImmBnm+lDsBpC92ZDlNExDA+sHTZSdtRffkQzdIlPj4tpaWqH9spqyC/Iik=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2759.namprd10.prod.outlook.com (2603:10b6:a02:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 00:11:32 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 00:11:31 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA flag
Date:   Wed, 20 Oct 2021 18:10:53 -0600
Message-Id: <20211021001059.438843-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1d) by SN4PR0801CA0003.namprd08.prod.outlook.com (2603:10b6:803:29::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 00:11:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bdc4054-b965-4a02-4d0e-08d994275602
X-MS-TrafficTypeDiagnostic: BYAPR10MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR10MB275974784E4DF11E7DD383F5F3BF9@BYAPR10MB2759.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kiZra+6GwNJuA7EHr3m68jccyB5Fy7lp95KWKYccc258awB0TQbKec/bQt3zZFujGlx+e0U8nY2CVLAxR4PNcdX4RjyVKG+kkII6VkqYLwFDsv3xUK7WrCP2feNUhefuDGc0q+mlq+hQ4hzCa2pKu3zoc3/2INWzlTx4T92eOYmDb5e2sqMZYstQFTIrtidU6jiuMjmXeWopQ6dUEYaMSoah0mmUS4tJvPgJMtqqJ9WIrNGfMvL72Pmvrc0kHKwTLjgT6vV8lgN/Fw3My9K0yBSd4ert3X81PC/dZUbcGevCBrwaVfUinAwjSRzbbPbWa9CReIkY9V1LV5GHBHikWRIwhTCBNplPetbxuCaJPl7mu7DVWcQpVKv3gMM0PY0XLVJU0X7SrTcAvo+h1vZhpKg7b0Hkdxcwj0CPD9hBqrK5xuOnSkQSAoruRwZRSf38ilG+DDoTRQ6jqtgEYOUe7C3NgHfmWYLPJsjy0hfrt9h8A9o6zrbX+e24byl7KhR2sLpTXllzRg/bsrxjLSApG5eADbgAR2KuOnA9Ed8r5T04dwmfYWuVfrnj9A36x3kXktrsgceOZ0YYkOM+oSwto4AnABcy5/bGYPlsVmMWrhb8hr6s02XRbNMrjO8mwsbcoyBjD8ztqnnqpZbkNtkSQBGpCJoCUCLgs7TAieaQlF0yWdPLNErrYSOU24iQuBvxyOt22c0irveYRsUIQHA0UTjUxQx5iugJWC+wTkxNMRTdnB8W2XBCqxF1TYyAfayBx3U9hh2OB2bfzvZYzDUow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(1076003)(66946007)(66476007)(7416002)(6666004)(38100700002)(83380400001)(36756003)(66556008)(921005)(508600001)(6486002)(8676002)(966005)(86362001)(186003)(7696005)(52116002)(8936002)(44832011)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AE3Ot1Rwxl305UrOvKqtKvXUFdKdAtLAkC3duMFGlkPez4LiXEpBjSuDTuJT?=
 =?us-ascii?Q?pd+W6j992cwe4wiqr9URM79Vb2eTBdrigg6TA6ps9vArIMi6FLRzwS7EnrxE?=
 =?us-ascii?Q?ztjCxi4jSoq6iart0IvSs+rx91d8SQDL4I5sk6o/d/orb4hMewAoyyVifvrq?=
 =?us-ascii?Q?7p7Rx8MNoXGNZ7VDghRIaK42FemyDHgEWJ6ktQpncLBoCp/O6JYuEkNV6Zqg?=
 =?us-ascii?Q?PbtUTvXp+JHPyZfQ6Ey1I/ejR0Ca2SfSYtq5mGEz0rBpJxiyE5g5xyea2P9e?=
 =?us-ascii?Q?nlF3nMBQ7uQgI8N8zbEjp9g+QHU2kD6+OeUVZv1KVBDg0fqaPbCF5sN88dpG?=
 =?us-ascii?Q?vm+uO69NRKVFwV3BPctX8FJn3ZsbtqrnJWGny+GUjjE3mJy+RESM8wTcS8KK?=
 =?us-ascii?Q?BClFiozJE7aJm4rJgcWyifbEqkfFLcrobAWe4DfWdLKsWaoSjQQXhO1awiEA?=
 =?us-ascii?Q?4sy+Vc/CdNtzNjPInc814mMnAEHXHyVCW/3mia1Fe0nsX9A2noiSxQ5oROSY?=
 =?us-ascii?Q?771gNR9N10op7xC5jfJ5JiyogfVtVcDUNghWPhkp/0IXKM8GeDtdppIp5lFX?=
 =?us-ascii?Q?+daOIAQxbojyO+pmPMtrreoDvI4daMPKJ1kMwZj6YpjKV7mLR5B6P786FPUz?=
 =?us-ascii?Q?D4c+mqoa4CR3qqu4L2dI/apK5b2C2fwoMwiP8GmWCdrB1M1jx7QwVEeZ6EUb?=
 =?us-ascii?Q?e048iJXKbOzm1NKkxX2jHjvYLGA/n6K9dpmtynAaXblqQ1FCRIA2mudUbUaE?=
 =?us-ascii?Q?NZ+qBRZ+vJdkJx+qxz63MX919+IBd1dwyTVTX8ibYWrJjEida4x2OH8WHD6p?=
 =?us-ascii?Q?4ZSSyBgNpf9mTzzjrfMs4nUnDy3/CkNJ+7IasSwL+IAesBzlwsmrR7B0VEhC?=
 =?us-ascii?Q?6/NgJwk3rEVczidklVacN+XFX04Gr0WqZHa+unvkStsXJTw04HC+N51Q7+v3?=
 =?us-ascii?Q?JK1G2cjQxAzdhmR/DUYS7iOxpNw8WN2nPRp09wyL/Sc9hr7b28MJD4K5xKg0?=
 =?us-ascii?Q?1IFUVq0LUVjOIdOC6Gqltm/J3c/2Jf/LhMkpmtemEdg0uGGxzb7xICL/rqlE?=
 =?us-ascii?Q?AaKjgkMuIBYrNhMH683N8triSjAI0uhFC8OgGsxz6EcvUCSRqRHhczRWb9Zw?=
 =?us-ascii?Q?ucy7y3pLOd+MECw3O3S55HPz42qNcuJ35Z4EQcRe2cBQY1M23522GxuBv/NX?=
 =?us-ascii?Q?GfT9IF9vcAKYX4uXT+1ltav0DyeUhS1hOEj/hCBRBryugQLLxJp9edTvDd8s?=
 =?us-ascii?Q?oVTLdMUrOfWogaVcwxv9c1vHT0sbvF+97rxAR8nsvHydUUSsA9STUoA/RoET?=
 =?us-ascii?Q?69WNvUtO8pQcPg5mkSpqhSgk/TqP1GQHo0oPH/eY0EzqFw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdc4054-b965-4a02-4d0e-08d994275602
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:11:31.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2759
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210000
X-Proofpoint-GUID: 0KA887F-VCCNbcrToOBGkWKl_hmjeh76
X-Proofpoint-ORIG-GUID: 0KA887F-VCCNbcrToOBGkWKl_hmjeh76
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set is a follow up to below conversation
  https://lore.kernel.org/linux-xfs/20210927210750.GH1756565@dread.disaster.area/
where Dave Chinner proposed a single flag RWF_RECOVER_DATA to
be added to the system calls preadv2() and pwritev2() for the
purpose of user directed recovery from data loss due to poison
in a dax range.

The idea is that when a dax range is poisoned, this flag gives
preadv2() permission to fetch as much clean data as possible,
and permission for pwritev2() to attempt to clear poison(s)
in the range and then store the good data over.

This feature maybe deployed by user process' signal handler
in response to SIGBUS with BUS_MCEERR_AR or BUS_ADRERR when
the 'si_addr' points to a dax range; or, simply when not sure
of a poison free range. This approach does not fragment the
dax backend, if it is unable to clear poison, it will fail
the pwritev2() so that the situation is explicit to the user.
This approach is not recommended to normal non-recovery 
code path due to potential performance impact incurred by
poison checking.

Also, this approach is an alternative to the existing
punch-a-hole-followed-by-pwrite approach which does not clear
poison, but instead, allocates a discontiguous clean backend
range to satisfy the pwrite().

Jane Chu (6):
  dax: introduce RWF_RECOVERY_DATA flag to preadv2() and pwritev2()
  dax: prepare dax_direct_access() API with DAXDEV_F_RECOVERY flag
  pmem: pmem_dax_direct_access() to honor the DAXDEV_F_RECOVERY flag
  dm,dax,pmem: prepare dax_copy_to/from_iter() APIs with
    DAXDEV_F_RECOVERY
  dax,pmem: Add data recovery feature to pmem_copy_to/from_iter()
  dm: Ensure dm honors DAXDEV_F_RECOVERY flag on dax only

 drivers/dax/super.c             | 19 ++++---
 drivers/md/dm-linear.c          | 12 ++---
 drivers/md/dm-log-writes.c      | 17 ++++---
 drivers/md/dm-stripe.c          | 12 ++---
 drivers/md/dm-target.c          |  2 +-
 drivers/md/dm-writecache.c      |  4 +-
 drivers/md/dm.c                 | 16 +++---
 drivers/nvdimm/pmem.c           | 88 ++++++++++++++++++++++++++++-----
 drivers/nvdimm/pmem.h           |  2 +-
 drivers/s390/block/dcssblk.c    | 13 +++--
 fs/dax.c                        | 24 ++++++---
 fs/fuse/dax.c                   |  2 +-
 fs/fuse/virtio_fs.c             | 12 ++---
 include/linux/dax.h             | 15 +++---
 include/linux/device-mapper.h   |  4 +-
 include/linux/fs.h              |  1 +
 include/linux/iomap.h           |  1 +
 include/uapi/linux/fs.h         |  5 +-
 tools/testing/nvdimm/pmem-dax.c |  2 +-
 19 files changed, 173 insertions(+), 78 deletions(-)

-- 
2.18.4

