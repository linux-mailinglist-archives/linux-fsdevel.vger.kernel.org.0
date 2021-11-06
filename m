Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF30446BB7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Nov 2021 02:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbhKFBUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 21:20:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56212 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230081AbhKFBUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 21:20:20 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5MiPKv007620;
        Sat, 6 Nov 2021 01:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=M9jhbUBcIo4cb3Gy+6fcjeWbupCNj4NDO1ybCw0PP9w=;
 b=N9oSs2Gj1UgYi3DgX4sP2x7Bb8gwxOcUS/Af8o+3JFId2ZgJ2kyTvFPpm4madGVfwaet
 8CEU1gP/2CyaPvBdxU4WLlyxhmzKByQ5jU9FkCrB1v2lLC7u4at9XsOLYWYTxecmiqTQ
 P9CbAtlK7hD1yjfDRvK+bC+nCxY4xo+SdRjwZafpJRqmNl+B0HUC1O+DsYlIRU7l6Ubr
 PdOHGJ/s69XD52kW9J2rkB5H669TiyZrUoIeRU+WMQFEuziHnoRSVf31Z2UuAIIFHr+X
 OsO97vbHwlRXLniAOaUPO3yjsP41BpxcVOwEVs9Nx/8rPyfMbWCGQfFwLqutU1aLMW1B wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7hwtkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Nov 2021 01:17:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A615qcr064740;
        Sat, 6 Nov 2021 01:17:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3030.oracle.com with ESMTP id 3c5fra86a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Nov 2021 01:17:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJnCaa4tWxH3IGk1giYgRFV77qpvAHMlhGnjjqK40jsMWgmvuFf0+MOZr6zb0fjEekDn17KUwzkn22L8bAVQ6bsrZlftWafuzuEfSKHX8wMqY9ifGtdUNfKgYVoQNcfbqFzoV6OeGv9YG8+F4aIet61WMZN4cCreA/YL9f2gm+Se7131Es9EEQb9YqmhQMweOyIn9gDVo1uHrZ4J02DmakF8DU0/hRwudWcESo/LjgSU3gILkyE/56cPvS2Gwbr4F8Tuukvsc20q5SWPmbF51qQq255XLXUSNWpWcwvDLcjlvcDmfMrbdNeOkEjGRIHU5NtNdw0gmmRT/U3ysTxPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9jhbUBcIo4cb3Gy+6fcjeWbupCNj4NDO1ybCw0PP9w=;
 b=AxYB7VMrfL4yGWpkx6/l6ucO8z2Ozqq+AsMo+s1/2XwqdrOlSCS96opHc3FB6st67fnKiOWf6Tvc0pTSEtV7X4kxpN9pZWKMgXBTxP5b4o1XHntzMf54FhlKrEl9Az/NKwXFZXas7lJekvQJ3svjxXqFMPA0ZV4dVIq+EiI7HIVf+5maf8qncy8BzsC+l07kBb8AjdYXcH8ASb51kZ76/qWVCl+ODHC42Jhq8tka3jG7QMgAhJfRfUxILHt5/cYU6pkFAyxkvb+pSodg20En7t52F7bv19f+jHB4KWh15VgBxIljuThp4o8DE1UVNP6HBsOh8WDLQpRGdrNZswUepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9jhbUBcIo4cb3Gy+6fcjeWbupCNj4NDO1ybCw0PP9w=;
 b=WSkcSvAnCmtEdMGJ+4kKuixUhhARC612l2Z6srb6iwkwNqKEol/q+g20HUz476PQNxcztGjaneGWfsRU8UPlCFGN2UkJnZRB/4G6HwCtp1MVGui/2fu9zQ4et3yGamY5e7/1S2eDXQz5E+xvEP6BmYYVEqbfO4E1Dc4Cfv91cN4=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5890.namprd10.prod.outlook.com (2603:10b6:a03:3ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Sat, 6 Nov
 2021 01:16:57 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.013; Sat, 6 Nov 2021
 01:16:57 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v2 0/2] Dax poison recovery
Date:   Fri,  5 Nov 2021 19:16:36 -0600
Message-Id: <20211106011638.2613039-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1c) by SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Sat, 6 Nov 2021 01:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e472e7d-d0d5-4b79-c217-08d9a0c32099
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5890:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5890E337003C5BA51796D6ADF38F9@SJ0PR10MB5890.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IylPGcI1JhvnDtNX8MH++yHXpr28a84cIApx/8kkzUNwFa1EOWZ7UZ3x5oNbJxfl8Y9ud52gFWKzDdbmv4W1RvIr+t+Or7GwVleayEYy84HjvVM4ZIAk+EcEh79rwyQwdc6rahkOEsAV0N3lYaeSFkg2oG+eaij5oyuXFoWnp/okmCEmcg1yHEJXKiRxAueD7DF7Xpg4ay4sVFa276cTHzW4e0LopL0bKiHr1nB1eZvfUXDX1H56J2YInI+1Fc2pPidqmz/vAHCQa4MgocFZhtfXNQnZ5MVWDblNnFJK4jT9BXBIX2OY8M4g6e1Lf43K8/pFCWuHSGFPoSwUD52wt0vUb6oIeXBolwwtV2pb8hP1qXe65d9cWP9vHk64WhJ1KVVJU75uDARBrdLqefO3rW/h7h8+jZiUoOtApaUQQkdzIArOsvkpESlO7V1r8+moU05FSlQ3D5kht4fjLsmVexDobZGhFZIlbZWQUL4KaDr1LtWihELhACGB2rsiwj23bG4Q3gOAn5o2VMQZLX8tknsO8TKWg7zdQ+3jxMtDgac5ZKJAeBqD3x+vc9QY/5ldROgvJ5gJnQ5J1302QngvECbGVcTzGdY5YNfCRKPi7ztFYDSNCOA1iV9uUuMpCcLXopX1H7N8IzQcZ5MRJPbO5L72+PBTLAFzZhsPbEb5USHDNYai41Jgzti2Z80IedfXB9roxKu1XXWVosh2CM21NsXhNCZr01Y/Rc25lAvAmb3R/ptqhvXN3+7eI2wb9h1zdD8oA4H4otnN64azIRjkVB+JNsxXdJqPGx2j0fqIdeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(921005)(36756003)(8676002)(316002)(86362001)(66476007)(66946007)(508600001)(2906002)(44832011)(6486002)(83380400001)(2616005)(5660300002)(186003)(52116002)(7416002)(7696005)(1076003)(6666004)(966005)(38100700002)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5GoRDRRJw4dpzi+1Xyl6SzVjqXI9ML3IIdzK17ZKIDNsLQjRa/l0uAbPiuYX?=
 =?us-ascii?Q?mMOyUtCx2X0rKDovyX+r4qskFK2goLb+Y8c9RfHzUPiFOFI7PAevclk8vGUH?=
 =?us-ascii?Q?8SqBgO2iinX9rTmw8SJP/ZcQkfFUVctZ5rHo4gYV+CGYeBz3KK6/OuB5389T?=
 =?us-ascii?Q?nUKXRFYEGwJKppNJvmnEKwgfH+aqtKfzhqacnk5z+sWYPsCMFMK7N5WTrV2N?=
 =?us-ascii?Q?uUlcHNhbJTnS2bM5HgerUZtP5M4qAegWfQ7ZaogNk6rL42ruVNpKaWJWKIg4?=
 =?us-ascii?Q?lkCReM7cftjeWoLI7EH0JQSOHSHZlrsRz65zhmPKmaA62eV19XJOYxC1bCC3?=
 =?us-ascii?Q?heRcmdIQ6FbP8GeTrpeufkoWiTB93l1tVk9BYVEYl0ERIOkFp4SsDswwcYdN?=
 =?us-ascii?Q?n/tPn60uKX08ByEGcpG2bWRzViwGuH1MNY3xY0AuwWz9vkWjPjYehN2n9zMc?=
 =?us-ascii?Q?2Y6NT7Ekn1abmjdBsMLNqp0dhmBxUEf1HYXfRJXrqoBEB5XHs3trZ8gXCslX?=
 =?us-ascii?Q?Ck0dbQrMRR9LOiuBs+WME2VHLMjTbQaXg/FHkTXKIqnnYQ6FCk+OS5NiTKHQ?=
 =?us-ascii?Q?Q62vfO3HLCBoBbe+3j/TZM9aIPWyJszQMBbDGsyZex097rtb7xcPNze6pKd9?=
 =?us-ascii?Q?jJzsrXrrpVgIREaBCQT1zuJn3yyaq8jWsHnD6GtQTkDFmGulpe07F20V2dtO?=
 =?us-ascii?Q?hAGQzRayHIRb0J3LifgWbj65ZOjdtLYI5xOkPhHwTxX0kk6ONV14zxUcxW6h?=
 =?us-ascii?Q?dkb6Qney0DZnWSIpH1hopO8ea4POn94uIeeHUS5l7DLYNCmsqXKa+SqNWkuJ?=
 =?us-ascii?Q?xcMiPW0biETc7e3+dCyDzU9+fvqOJe02+0Ocw/JBkfEnKgoKRqw2MaPeRTV1?=
 =?us-ascii?Q?+OzMRAbNeU5Lkak0gbBJiGUkKx8dztL34k8E38+sVWTvAVqhWrHDiTVGkppS?=
 =?us-ascii?Q?1Ksll+QSYytw7oJDLeM3YHahvyIuFJKKpfwD8D0t6gCRh0svrjcd0RhPVPEF?=
 =?us-ascii?Q?8T4AW0DxyWcbpvT+2Ftjtsr19H1bVR3m451IBiEQ6g01u+t/dP5sPeAOHgdn?=
 =?us-ascii?Q?IS+8pUQhbIHj/wpnGRWTECOkSrHpsEqJJ5Umm9LFuIzQa+rftf6/dZ6Fh6ue?=
 =?us-ascii?Q?tRbhrI8ojyHO81y7iuTxLEAPPZFQOv05jsOVSwSDvLfnZ64ByCI0EMnewRnT?=
 =?us-ascii?Q?0HybeiS7+LPUB30iGBm43iYnhQqfNepfjWSP7ftqs2YUjTxglGfPNC73W6ts?=
 =?us-ascii?Q?WJtMj8rXcxqvegnQ3eIhk5oUrKviFpZVSQLe4taKaxVMUqyP3PAHaAk4xaX5?=
 =?us-ascii?Q?6x5eRqS06U/9dShq6qbBQu+5KaCBlw6RiZUPtic4VC97ABSVw5P4TPO1MYKt?=
 =?us-ascii?Q?UCrkJJO136az1illUGlJGxmwArWq+xObB5IeK0XIelN/hhjVH6uvyKh4krsa?=
 =?us-ascii?Q?zkskARTiWzW808VcUtE3NSRY5+YFEV3FwrKnH64TPixE9WAR5A+tzxFriZHa?=
 =?us-ascii?Q?4a94Km5X2mjEDL0A0plpp9udqErvJVpBEZpZ5bqEFRmJVq/ib2lPMHxR75y3?=
 =?us-ascii?Q?Zqi9lEYLyzkkfzLEKSP4DFPC6BAYcunGUrKfXBLrMbsnfkSSA0Hq5WV8sDGu?=
 =?us-ascii?Q?tHNdxdJ6UIx0+/QVbpQGM3qST8fGijdrgucs6G9pQt1s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e472e7d-d0d5-4b79-c217-08d9a0c32099
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2021 01:16:57.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOnoP67j+UOVcGwWKVjVkVXmiALZy5zKemVk4hnRPh+dddKBjsVRcTb8z4kSTm7FFBreC2Z8aj4D5xq4iIobgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5890
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10159 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111060005
X-Proofpoint-GUID: CPkNVKGBaWMZvCf0yu8jj_ZI2Mh2uXD8
X-Proofpoint-ORIG-GUID: CPkNVKGBaWMZvCf0yu8jj_ZI2Mh2uXD8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Up till now, the method commonly used for data recovery from
dax media error has been a combination of hole-punch followed
by a pwrite(2). The downside of this method is that it causes
fragmentation of the pmem backend, which brings a host of
very challenging issues.

This patch is an attempt to provide an alternative way for
dax users to perform data recovery from pmem media error without
fragmenting the pmem backend.

Dax media error may be manifested to user process via SIGBUS
with .si_code BUS_MCEERR_AR when a load instruction consumes
a poison in the media, or SIGBUS with .si_code BUS_ADRERR when
a page fault handler fails to resolve due to existing poison
record, or IO error returned from a block read or write.

With the patch in place, the way for user process to recover
the data can be just a pwrite(2) to a page aligned range without
the need to punch-a-hole. In case of BUS_MCEERR_AR, the range
is incidated by the signal payload: .si_addr and .si_addr_lsb.
In case of BUS_ADRERR, the range is the user mapping page size
starting from .si_addr. If the clue of media error come from
block IO error, the range is a stretch of the block IO range
to page aligned range.

Changes from v1:
- instead of giving user the say to start dax data recovery,
  let dax-filesystem decide when to enter data recovery mode.
  Hence 99% of the non-dax usage of pwrite and its variants
  aren't aware of dax specific recovering.
- Instead of exporting dax_clear_error() API that does one thing,
  combine dax {poison-clearing, error-record-update, writing-good-data}
  in one tight operation to better protect data integrity.
- some semantics and format fixes

v1: 
https://lore.kernel.org/lkml/20211029223233.GB449541@dread.disaster.area/T/
  
Jane Chu (2):
  dax: Introduce normal and recovery dax operation modes
  dax,pmem: Implement pmem based dax data recovery

 drivers/dax/super.c             | 15 +++---
 drivers/md/dm-linear.c          | 14 +++---
 drivers/md/dm-log-writes.c      | 19 +++++---
 drivers/md/dm-stripe.c          | 14 +++---
 drivers/md/dm-target.c          |  2 +-
 drivers/md/dm-writecache.c      |  8 +--
 drivers/md/dm.c                 | 16 +++---
 drivers/nvdimm/pmem.c           | 86 +++++++++++++++++++++++++++++----
 drivers/nvdimm/pmem.h           |  2 +-
 drivers/s390/block/dcssblk.c    | 13 +++--
 fs/dax.c                        | 32 +++++++++---
 fs/fuse/dax.c                   |  4 +-
 fs/fuse/virtio_fs.c             | 12 +++--
 include/linux/dax.h             | 18 ++++---
 include/linux/device-mapper.h   |  5 +-
 tools/testing/nvdimm/pmem-dax.c |  2 +-
 16 files changed, 187 insertions(+), 75 deletions(-)

-- 
2.18.4

