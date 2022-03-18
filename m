Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1600C4DD247
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 02:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiCRBLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 21:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiCRBLu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:11:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F129169B01;
        Thu, 17 Mar 2022 18:10:33 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I0uaMc002587;
        Thu, 17 Mar 2022 18:10:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=OrJZ3bgVZCAeNzWQyEpDdcbo/rJKI5Fz+6MdHg+7q/s=;
 b=P/0rhpMNaQRQvh9VQeGpd8PJYetqVnrDJ4QfMS8t1BoQMOkyrAnF7JPOhI6Tz5I27cQ9
 hajiVviI7t82iGy8/6KHs5bjyRWcUOhg5o+rNx3nhRERq8sLP6cM/k8qPELumhlHpLdt
 hFPQfb7A81jjWKBX/a8+p/7lx5Y2apupsx0= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3evfyx021s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 18:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h62Z2+mLKE7yQIcMm86fykxRp/HL0o0o0p1/PgLvdqVgE2gVvJlOrtfPgTzYWMg/zNeiRaQIHvdB20yze+62F1X5S7PzNPotIwBps142tobkPX+t37iC+PZ/6yoTLgPnyOZc5Qcb9pWmRh4cw/NJUz97u1X+4B1TAJPbPyKKcq0sEeAFDjQiEAtr9gtkqxAMKTyJQIqtDe73oQI7kAnYLLcgcGJIClcNBhcvPAGOySiSBlu6pjAjsZLfFs5p8+i/kB4DOJ+CFHCwWst3x3olQ8I7tYEPCZb+Bkr658cU1v3Cl8PK/CKPjEleudG2F4oupuGuD/p9TX0x9hG5eZaDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrJZ3bgVZCAeNzWQyEpDdcbo/rJKI5Fz+6MdHg+7q/s=;
 b=Gv2NoZ8Lbv7/7Cxg73A3Z5I4Nrwje8oNMDQupmdCz5yiMkeK+TDq32E8pmOaAvX2vRDNXK1A8klc2pVkPXCueJ7THe43dSGmz+X1o16zSCBpC2323G4LvQo1ulETGqDTSkuUaOMLPlH9GC3fH/zDx9IuYeUxAtNgMBsIk/ULTdZd6v+Ufl1zGoyd4uNq/ksL4oLupYnd7r3q+g0sZC/jmcj/tQZOEYv7PnSZ/nbf77KUdV+u97l5tzDP5+HIlZilE6uJpvo5pbr0TnTrvhW+4pAOU6VTYUcW1Y8uOk9EIXfALoJ/8sSvEYPh4tqlopQOTfdd33/+bFFyS+0AwFSDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN7PR15MB2321.namprd15.prod.outlook.com (2603:10b6:406:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 01:10:30 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c476:aaa5:bac1:c383]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c476:aaa5:bac1:c383%9]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 01:10:30 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
Thread-Topic: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
Thread-Index: AQHYOlmGNQgmUdDgp0OWw19sweVp7azEVTeA
Date:   Fri, 18 Mar 2022 01:10:30 +0000
Message-ID: <96F2D93B-2043-44C3-8062-C639372A0212@fb.com>
References: <20220317234827.447799-1-shy828301@gmail.com>
In-Reply-To: <20220317234827.447799-1-shy828301@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7942aaf5-f7da-4ac6-3b54-08da087c1850
x-ms-traffictypediagnostic: BN7PR15MB2321:EE_
x-microsoft-antispam-prvs: <BN7PR15MB2321E17DE5B105DB0DD9A257B3139@BN7PR15MB2321.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yinZ6vnPgUVKzUMrQOI5hixFYNwZjaXEH/I/W9t0yt/KL8t2Kapl2TxkvGz+rcDwmCGOyEIQA90Waa95rJo4620xyPlMAV07nQxV9309NF8ni8eswKjM2JuYFnZBM6V7C7Sxi7V2o1uFfCBj3QZ0zZ+Kx0fRcdQGO8Jg/gYmtO7qBWpbyXlyZaeKKUv/wtbGsOwy6FWt5Tdu8xaQh6ZPPVTRtgIDaUm4k70nE3Wmz72/GGC9vSzxrT5YC+OjMHBmwoPl0/n0gYinka7twi//QPlZhupbKnaRUbQjX8kJaQt04Xp4vDUc3Lty3b6ZL/2tyNJMLtuFmMV6qEGwRJzvd94TcDQBw3mXBPBYVyosTZghAT83pEHzpS+BCEj1tXpPD+FT3huxR+7pq9sX/h1u3UfvoxpdyZ84JkriF2dvFxWtOlxQ1p4rDLk77oQza2Xp5B0OGgfC3+pivoIHkdoI+ASQ5KXF4qjA4ONCmkcxevjzOx2mqvm/jJnn61iJcEs/yAoWx6QEX8xHE3BK4JatkhWpoie0+0QZPFrdxArCNM7W9BnrY6aNWBXLyvET6vCwvDst1+LaDZylofkrGbO5ActeI7Vee/Rc7MLykZLPn/nfAT9IsUH+NGS3rnp4g6919jvDwSdKr6MmS+BEHFd2x7oNVRLPRSlgC10+QSq9J2ZAu+LUeJU3PnHnqC8CwTmu4bdj5Da8A7Oyq4aJekO17VjMzd4jOCoZ+MrYhN1LwLsaZlgWPfGyTsTK0d1w+xAaJaW2fF7mUEsFeYLdP4B4bGGesHircC4Y9Lia8YMaWy39WOz1ELCnY7PjOPlwJLZkPTCrRVmggIqPrTc6fR3FgDQp22wHULhMqq9FbDQ9s/E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(7416002)(83380400001)(71200400001)(36756003)(8936002)(86362001)(6506007)(966005)(38070700005)(91956017)(6486002)(8676002)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(33656002)(76116006)(6916009)(54906003)(53546011)(186003)(6512007)(122000001)(2616005)(508600001)(316002)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e8OlCamG/tvr99z3XEkudLjbGyGANpLkxsuc1e0zSFmpXBr/Py1o919madEl?=
 =?us-ascii?Q?XPkJAF3NEvqA8DuBKP58usOF8xQZfVkTnnESH8+z37BNDGl/bWIi7EMQ600b?=
 =?us-ascii?Q?I9173IbWRTYCo0XELRnXAjFhqb/hV1cjYXZ3GrSEu0pZIhdZLY5yD5HhuVei?=
 =?us-ascii?Q?jIyNiXdmKCSZXOozXgbygxEd2K4wvZ/+necCKJAxmIws21wc+9eaq5pHEHWd?=
 =?us-ascii?Q?tkMQCdXBeoDgZ+FSck2CBvklek7XglZEJ4GwLwwbocQ1BQU1pSLrmYVOez3A?=
 =?us-ascii?Q?sWySY13FOTeNqslQgY+XFGmJukc0NPdtAu3zgF57Dh+RqR5mAegmqZwZfEiW?=
 =?us-ascii?Q?Sgh8sV1SoRN4sxhp7RdrbBD5e5qIebrAeNuoQObLnLBlh0pMoENawnawonWV?=
 =?us-ascii?Q?tQz4dJp3mdZToAMqWAB8iryhEmZX3ZrEHPGZCkyip+sDP0OKocXMRsX4cuUI?=
 =?us-ascii?Q?BwTiRlNMFl0xGevtc12/yW3yp+U+NSH4SzbkeLhHwDgztcpvRDudixBIus/K?=
 =?us-ascii?Q?VF7haq2hXl0YYtdBAl5S6GYGwrlrVgw97GnrH9QDdiNKH4bbiZr/BW8Z6w4L?=
 =?us-ascii?Q?9cIM5JkLxeT5/UycFyfgEBd8flX1homB32NsaTeZ4b3GRZvX33VicZk+fbJM?=
 =?us-ascii?Q?qynJm7MgVg5SQTFyZI4zF1mIgSQf1oW46MKRIczHpZDm4AhOaskOoZllEuS7?=
 =?us-ascii?Q?NJoAQlikFl/NA0ciDpjLXTG6BBXyfkteiM5rYnxpd/NkDXTZZ817xSAKpJfe?=
 =?us-ascii?Q?FD/MKXNNxzkD9IFcA4C29JYhaUKLKaIlw0XBWE1uw/hqH9hT3xv1ZzyMhee1?=
 =?us-ascii?Q?LjGDgp7hxbCD08ZSKIh3LyPBtniYYdjKxxTK2aRXjTwLnab8elUDSsZkXM1V?=
 =?us-ascii?Q?I0kgh/AVx+3WE3yPpUB1hveeJMNc5B41DJ9Qkeb/pTv5sszcOsq7xx5jOvsv?=
 =?us-ascii?Q?8dmR4p+C8KbJMhIi4nxg5g+GWw+tyxaIi+HmW1N7q2K539ZiPyo0HeWnS01O?=
 =?us-ascii?Q?42lrEkY+6fm7K+0yyTA3JFRCcm3xzXm1lObbhIaJiRTu3teT8cqqLP6GBmmb?=
 =?us-ascii?Q?Cgm3sgFacEtuBZkAevpcnRXZOjAFIks9ItwKJ5SqJY8qMeQEQrW411sSKM5f?=
 =?us-ascii?Q?KP44vOVdLjOY5JvLVOM5IjB28/HEX+M3urvHOawfxO0FaDX+hY/SJKVabkJd?=
 =?us-ascii?Q?bzW27ogKKQfH8IrDjPgRFLaBSPgkbHc9Nc9bu91wfJH8HV7Yf5+siv93B2dZ?=
 =?us-ascii?Q?FQ6TtjNcrLiRvpxitNRojo36IPV5Eo3yYRD2nw2N3aF9Qx8o87qzOd+lWjuY?=
 =?us-ascii?Q?ioxRGNylnY+9/iKiMt0QtvN8vy0lDx6Hcr5mNMp9UneWNQkMVya/SKGH9Gkt?=
 =?us-ascii?Q?0FCJxXQdrbCSHLlDA6rEgvDnZCGHXB8BSS3NrNSFRH/6nyxWYagSAC35IU8V?=
 =?us-ascii?Q?0k150uKVb/51Td4MgtAu5hBdl9b2kCPkTeJ2KJyeX8t+aVAdDUMzcFLXt1ay?=
 =?us-ascii?Q?toh6MrFFF73jmMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0636B14C8F0EE044AFAE647D0AC3B5A7@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7942aaf5-f7da-4ac6-3b54-08da087c1850
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 01:10:30.2599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xBtxny9QBCChVByJzJJbWwNGuynrrlIX0x7+SKUcmSMHZhgDtasrrtSWRGzh1Mh3cAoqcGQfQ8AclwU++4Mkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2321
X-Proofpoint-ORIG-GUID: zDZMzu2GFpY1dElYZiNG1owQmrbOmJhP
X-Proofpoint-GUID: zDZMzu2GFpY1dElYZiNG1owQmrbOmJhP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_07,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 17, 2022, at 4:48 PM, Yang Shi <shy828301@gmail.com> wrote:
> 
> 
> Changelog
> v2: * Collected reviewed-by tags from Miaohe Lin.
>    * Fixed build error for patch 4/8.
> 
> The readonly FS THP relies on khugepaged to collapse THP for suitable
> vmas.  But it is kind of "random luck" for khugepaged to see the
> readonly FS vmas (see report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/) since currently the vmas are registered to khugepaged when:
>  - Anon huge pmd page fault
>  - VMA merge
>  - MADV_HUGEPAGE
>  - Shmem mmap
> 
> If the above conditions are not met, even though khugepaged is enabled
> it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
> explicitly to tell khugepaged to collapse this area, but when khugepaged
> mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
> is not set.
> 
> So make sure readonly FS vmas are registered to khugepaged to make the
> behavior more consistent.
> 
> Registering the vmas in mmap path seems more preferred from performance
> point of view since page fault path is definitely hot path.
> 
> 
> The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
> The patch 8 converts ext4 and xfs.  We may need convert more filesystems,
> but I'd like to hear some comments before doing that.
> 
> 
> Tested with khugepaged test in selftests and the testcase provided by
> Vlastimil Babka in https://lore.kernel.org/lkml/df3b5d1c-a36b-2c73-3e27-99e74983de3a@suse.cz/
> by commenting out MADV_HUGEPAGE call.

LGTM. For the series:

Acked-by: Song Liu <song@kernel.org>

> 
> 
> b/fs/ext4/file.c                 |    4 +++
> b/fs/xfs/xfs_file.c              |    4 +++
> b/include/linux/huge_mm.h        |    9 +++++++
> b/include/linux/khugepaged.h     |   69 +++++++++++++++++++++----------------------------------------
> b/include/linux/sched/coredump.h |    3 +-
> b/kernel/fork.c                  |    4 ---
> b/mm/huge_memory.c               |   15 +++----------
> b/mm/khugepaged.c                |   71 ++++++++++++++++++++++++++++++++++++++++++++-------------------
> b/mm/shmem.c                     |   14 +++---------
> 9 files changed, 102 insertions(+), 91 deletions(-)
> 

