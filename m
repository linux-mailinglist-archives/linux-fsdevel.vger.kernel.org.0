Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5AC4DE66C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 07:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiCSGbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 02:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242252AbiCSGbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 02:31:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64741AA8D3;
        Fri, 18 Mar 2022 23:29:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J1VW7c017377;
        Sat, 19 Mar 2022 06:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4AdHtv0Iq+UP1JeVBfXLHyEl3dBQcbQI1fPp32fdsvU=;
 b=nDQAbpWvqU4oZSOSTsqsCfO8sXcfwQdX/xbH1DCCT7PyPG2Sk0Qo81qxLq2Zn0Fjhtn2
 HCloyyrNMWEKHW/IsefVDKDq+ru5fV7Oy2xhnGJR6C7VVYoyfMmKJe2tso9pKv8fRRPc
 IA53Osr8pAIzELjB5BHgsRFKrNZRN/QiIIYaL5GJNMGjgOEkNaIjjNCrlz/eqlvgpCZh
 jlY6F8lCrF2WtQxxyG72xwR8k48AKA9wQseZKFwxdakrOPPjDez8gV6+4iBwGzJdmaGX
 gZQh+xapTUhMV61Oqyn8a1SkamhhXChCro3LRDwMjMlIVZ8Dq5BFYtWguOuYIwB85iIr uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcg5pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:29:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22J6MICS027495;
        Sat, 19 Mar 2022 06:28:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by userp3020.oracle.com with ESMTP id 3ew8mfrwhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:28:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKrAZE/gpKMdsxFM4mgSO0srUn1h91OgmGuE2Bw7WZGvJEtrRu6y2y4KE6gRrKxD46RrK+T+0UUrjnZxemjcVqe+9BehhstQNy+RgvH82uLswial8ZrMTa2a8E7Ss2r3jqeDrIHte1mym7R8kUx+XVt5rFZqiQAc1L0V6T7JT7fsrrdHIV4fLBG71xn0oEfWqEV9GsZOLhrc0PYVMqqp0WgTlcr20ctyPomaNmjm75KOoC6ZM2z2Zi7/V4KwgBpApBokmhiO/EJ/G93SQlkPSJztzsGaYcueIJ5Q+G1sq5EHWrd8hW1Ovu1vv1beH1vczJsAbY3LGyMoRLA2Iz5uMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AdHtv0Iq+UP1JeVBfXLHyEl3dBQcbQI1fPp32fdsvU=;
 b=fIyBCxrJBFcKpcmk3U1WtPgpgo+Yd1+41Ns7rndUanGC2aU/GL984yYkQH70LlYEf0JfDxBCTgH0Rjt3XhEL4kPuT3S8zYz28M0iXFV7lgOwkxciod/+a6ucIHCL/R/F+HP1/xHMkokBu1bT46egLgDBqvGK18rKI1G/X+HwRJV+TsQ3+nIFf8szqCJk4cQRcBMttNdYAhq6HEtjwxlFCazlK6ShDrJ1alMCicvpWMoTGIYRv3zKGHGeA/+lH7l5XxD2f1ONb+90UssCgKbAoyytlzokKY0uyEbED9kD7z/jrgnEI4Od3lHC9ioy3xa+JObcsZk7xCOIczzNOB55Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AdHtv0Iq+UP1JeVBfXLHyEl3dBQcbQI1fPp32fdsvU=;
 b=JswslQgLMP1x7L2NUYGFO6TknO8SorUdhsnDvYlWJK+3+LQQgSC9G1W+H2RpGLB6w3EgJX0zJq/B1i4kiRvhVLI7wq8b6LLUyMHih1GR+trI/ldKTsWsg3D02chDjIkxUvViDG2SvUt6l+kbsbbbuuo4s0jkfYDH2bRAfvBRFDI=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY4PR10MB1798.namprd10.prod.outlook.com (2603:10b6:903:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sat, 19 Mar
 2022 06:28:57 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%8]) with mapi id 15.20.5081.019; Sat, 19 Mar 2022
 06:28:56 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v6 0/6] DAX poison recovery
Date:   Sat, 19 Mar 2022 00:28:27 -0600
Message-Id: <20220319062833.3136528-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2d9f55b-cbe1-4291-a40d-08da0971bf07
X-MS-TrafficTypeDiagnostic: CY4PR10MB1798:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB17980AE1BF3BF108A174C849F3149@CY4PR10MB1798.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Dq1Y3EysgEPbQKG8ZI3WDeNlBuTODkjc/kPAHJ2wHIYqx0piONDuuyF7IJ6u0jvMGAmBS7gz/YK35/WTziXcNfci2XUNlOiqUdpp9DfF4XQC2hSe1CjpelzBvSfYM8LE/6dQlaNfzr9EEAHOP3YZzpQxvLLzb2lPeAiZFMjmXu8XGBdSlM1suoqNYAnbbJWW1h6XmkgN3O00PROVNVBCZZlahm1qPnv90P5WbHka65fjXYNBW40Ggc3iiFzl8IJDMBIrHXRJYNw1mtazs3QRTkt8l6fhDz6IMpSFZ+uZCrIQKOM0LeskYcrlNRdX4u5IOpAyLO4EhgM6exi2JFjp3A90xJb/HR7wYW/vQ5L8WwhtTXsGI0QYlaDelPysSTmu9YzO3POPTku5l32N8U1ylPXW3Q4jUUHrVl4rofw3v163YeJJSnCzpqM8MhwEfKvP1HGOit8czUpjT17NjvxUFfVxxwHUynib2dJM1YE9VVsVbmLL1jy7L6mSJEwBqIHj05LqPCZH38EYZnsPjDLOJMGwqTvjNfiG20OGzvSYV3LzDE6Ce0T0wkgd0P0FgFhc4vdI8naJqcsugbhUSA3yC5RQvEDAOtTKMp2D3VQyA0ane+H1OQuiHRLt4DKQET0pfSqQSV+1j0zMul6aujYFAXHX8nRkqUuKRzwGAlU2yvyu8C2xIPZ7qXapZrqdM+Ir5THc0yvdCERfhfutxj3OhICqvrvk3o5R8CRrdZVBJemDukne4xgI1amxxfaa6kdqH4GmIvONPryoL5/nIqUXCMLeNgOe7O2hQneEDnrBXmgpVnBbjQGi3SVFVFMClcM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(6512007)(66476007)(8676002)(83380400001)(66556008)(316002)(6506007)(2906002)(38100700002)(66946007)(508600001)(44832011)(966005)(5660300002)(8936002)(7416002)(36756003)(1076003)(6486002)(86362001)(186003)(2616005)(921005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q4GcftBlqGcRlNVsaCKLsBxGr3+lj3Q/zChm7r9PqZof1RM2cXU7avrZ2N7f?=
 =?us-ascii?Q?b+5eLRSznlfUO1MWw4Op8WnNalRJ5y78ekwwKjAl88RM4C3OCNmaUgEMNIVM?=
 =?us-ascii?Q?JBMDsnPkHeAgPqLQSsBqaCZ7oiJN/rVM0XVGe+lkxeBo1Z0Yi4OFpOGz6BBU?=
 =?us-ascii?Q?mVnWHL7XA2QGh/vukxoFI6pguAQfn2mJJNoF5WMJuGZDCNIg0wat/Kiv2+U8?=
 =?us-ascii?Q?Z0IAIZ4YtZ43h5ZAyZfRah8l2XHLVm4BwdE/4CWSQtt0uDdy2CEd60u7TzlC?=
 =?us-ascii?Q?rYaltOcT7+Ib2HcJqhS8oPvFd+m8jMfH9Dkm7WspnbX3QHtymNdQXyCN3TCK?=
 =?us-ascii?Q?QeB0GdbNnrJi5j6Jvq74cO191lS30V2SsVK6Uw0YCdUdOqKRzPCJ+xmd62F/?=
 =?us-ascii?Q?KJrQPpHPRXri8hIBTbs2jzRDpE5WNVPrnCVT6Gsx58gN0vevZcsUdIVK859N?=
 =?us-ascii?Q?jVlwcl0Pnx4lL7ZKlsT9ZpERVpzvz2WB7MHSiv3/ia2QiT5Xzxu0fUBUGgGm?=
 =?us-ascii?Q?pB9QW7xrV3xysT6O/q0d8f11SJfBWWmAvftVUaW0eblYqVCCsJy1ShrhkWhy?=
 =?us-ascii?Q?rVndFDBNAmyx66CpB5uaDM+u1ANOT4D/naPuZ2IAO0/K+Re3Y5kyPCZDeJxS?=
 =?us-ascii?Q?iN+umTU2aHO9xVCDeAiqqEJdQuRv2M+iYPR8p4+V6uFYELhZbkUpACXwEaZA?=
 =?us-ascii?Q?aqQGaKIiHyEJoVmhI5FJViHxVpz+bdmKjkHLf09VAQxeeJPtH2++gFSA0OHD?=
 =?us-ascii?Q?orp6aKpO9dLRUAwgnSXEjuVBXuJT/t7mw3lSNgbm48VIYqeLEqbJ25ZgsTBE?=
 =?us-ascii?Q?se3HRaGfp2o5ijIeO4RTkvZ2CTaMl/mKuNpBdmwJcTNdIu22pqSkvj2fDiDI?=
 =?us-ascii?Q?PElYNWcQsEqGXvfGzIzyM6Y8xKIqsfE+/i+4mM64d0QuG2L2VoSf86d4ym1b?=
 =?us-ascii?Q?h8+u1Uu4bnr7PU4Fs1FiWk64G/kb45gmKAh9tCeyO09Kskz0kNbuKD+NhsVg?=
 =?us-ascii?Q?IM2tGCGFzvhrGblCUWxwg8JaKMJqQrP9RX5neb3IDKbGET7ZyXQB6eHGY/pd?=
 =?us-ascii?Q?7WsIRQWiAcwrVwB/CDhKP0IHZjdYJlvPGFIvmqIjFsUestmlQ28uGC4XFdbc?=
 =?us-ascii?Q?AVpo7biH3ienXn9Z2SDA2XapKuJhZPS4TO5Vv/RzQvv24HyhEiaa/Aj+Suh+?=
 =?us-ascii?Q?1YLvwGeL2DFtQ2HxU4rkEas+rXrd3aoR9NsriEUldGlo2wFFIOLHel3LaOEO?=
 =?us-ascii?Q?Vz/h5O7Z9SsxYuJdGuDpYEWWwm4fI57blPJPwRdkPwfyi20/3MrdnufQxo/8?=
 =?us-ascii?Q?Pn2VvndvWhXwFQ/Y0bJLvU7bVG4M5+y4p88UghIEA2xeuvrJcfTrhnZYvjk8?=
 =?us-ascii?Q?gsRq6aWsVwAgVy2KJYex0ylYI9TyFCQI/et9mmwCmzpgppbNpv8rv5b124YZ?=
 =?us-ascii?Q?83mLZrtami4Ip6zCtPhh1fST5oUC7w6GMD5/Oo+YISDy/cL7kazwIw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d9f55b-cbe1-4291-a40d-08da0971bf07
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2022 06:28:56.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3/4BRPyacuYIQER7dSRk4zQcH61jKIaNtRIkQSZvxqKLjhXfHqUW2hPTEvyvDYXlhIVP/e9bcpb6eaPxFIyWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1798
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10290 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203190038
X-Proofpoint-GUID: RmwJNbKd_ExqLUtVqUfRu_s3-RairxE7
X-Proofpoint-ORIG-GUID: RmwJNbKd_ExqLUtVqUfRu_s3-RairxE7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In this series, dax recovery code path is independent of that of
normal write. Competing dax recovery threads are serialized,
racing read threads are guaranteed not overlapping with the
recovery process.

In this phase, the recovery granularity is page, future patch
will explore recovery in finer granularity.

Changelog:
v5->v6:
  . per Christoph, move set{clear}_mce_nospec() inline functions out
    of include/linux/set_memory.h and into arch/x86/mm/pat/set_memory.c
    file, so that no need to export _set_memory_present().
  . per Christoph, ratelimit warning message in pmem_do_write()
  . per both Christoph and Dan, switch back to adding a flag to
    dax_direct_access() instead of embedding the flag in kvaddr
  . suggestions from Christoph for improving code structure and
    readability
  . per Dan, add .recovery_write to dev_pagemap.ops instead of adding
    it to dax_operations, such that, the DM layer doesn't need to be
    involved explicitly in dax recoovery write
  . per Dan, is_bad_pmem() takes a seqlock, so no need to place it
    under recovery_lock. 
  Many thanks for both reviewers!
  
v4->v5:
  Fixed build errors reported by kernel test robot

v3->v4:
  Rebased to v5.17-rc1-81-g0280e3c58f92

References:
v4 https://lore.kernel.org/lkml/20220126211116.860012-1-jane.chu@oracle.com/T/
v3 https://lkml.org/lkml/2022/1/11/900
v2 https://lore.kernel.org/all/20211106011638.2613039-1-jane.chu@oracle.com/
Disussions about marking poisoned page as 'np'
https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/

Jane Chu (6):
  x86/mm: fix comment
  x86/mce: relocate set{clear}_mce_nospec() functions
  mce: fix set_mce_nospec to always unmap the whole page
  dax: add DAX_RECOVERY flag and .recovery_write dev_pgmap_ops
  pmem: refactor pmem_clear_poison()
  pmem: implement pmem_recovery_write()

 arch/x86/include/asm/set_memory.h |  52 ---------
 arch/x86/kernel/cpu/mce/core.c    |   6 +-
 arch/x86/mm/pat/set_memory.c      |  47 +++++++-
 drivers/dax/super.c               |  23 +++-
 drivers/md/dm-linear.c            |   4 +-
 drivers/md/dm-log-writes.c        |   5 +-
 drivers/md/dm-stripe.c            |   4 +-
 drivers/md/dm-target.c            |   2 +-
 drivers/md/dm-writecache.c        |   5 +-
 drivers/md/dm.c                   |   5 +-
 drivers/nvdimm/pmem.c             | 182 +++++++++++++++++++++---------
 drivers/nvdimm/pmem.h             |   3 +-
 drivers/s390/block/dcssblk.c      |   4 +-
 fs/dax.c                          |  32 +++++-
 fs/fuse/dax.c                     |   4 +-
 include/linux/dax.h               |  12 +-
 include/linux/device-mapper.h     |   2 +-
 include/linux/memremap.h          |   7 ++
 include/linux/set_memory.h        |  11 +-
 tools/testing/nvdimm/pmem-dax.c   |   2 +-
 20 files changed, 269 insertions(+), 143 deletions(-)

-- 
2.18.4

