Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15A23B395D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 00:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhFXWou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 18:44:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26034 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232850AbhFXWor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:44:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OMb1UA019506;
        Thu, 24 Jun 2021 22:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=GsnV2PQ/pK9pVRtn/lE6zCqysG0ZOjDKHjLpwSQa2hY=;
 b=WH8cm9M7wvft2aXbZYrAC4KnOLM5NmMSp8utofljrrIJb0aijJfJWCmgDFcKlMO0oPK2
 rAu1bm1NsmQHe94EAfC6dAwMDHlgdGae3TE4hJqu3tKv5+Sm56gzuWB25CbpYX8DfEsB
 78iK4STUo1IQFXZkz/P8MJF1KPvhxxBDLjvtG2+qfGxJiBOloN5r6Z1pWwZmxaNknm63
 C+QX1M36KYRiE/f6+GP7qqLPHVRt7FEYdkrq9V8UYJnKkk/S6kh4Dstt3jU/mVnMvhz3
 ALd+XEN6x/aYIjdTHXiFuy1ctJy8C6kHGOlFu/o3xO2D2749pwF1kbnmiJiLukmjmayC Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2ahr1yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 22:41:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15OMZjeC089540;
        Thu, 24 Jun 2021 22:41:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 39d2px8qvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 22:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8A6pD9zKIEA73GVfGR1knSCOCrHE1eeUeo6x+1N2wiMIHyNnacEdKONwU7egq3rXHPXqQEOkIVyc/DOVPmUg1gufB9jYron3HlNXhJ49Dfno30Lo+vH2WzhHZdiPfbX7uXspODoJGh68uePlc0+1YmiTYwDSx/BWcygB076IRU+gKAjiQWk4neXv0H0/iC1pNDyqKsB73v/DqZHDKaa13deRCoL/Zeyst9QR1SIcUT6KsQVW3fHuR79avhXKU7rGe+wOTkMOhK62ue8v7gb9xoNo2p7+yHdUsdKczhbIiCnFhdrGEpWPgLkhdk+hZ/2wOEcfDiIZ+mit3x6KIIjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsnV2PQ/pK9pVRtn/lE6zCqysG0ZOjDKHjLpwSQa2hY=;
 b=gBHmz+Uuc+Nlnm1kmMfmxJElRi21L75QUWYU59YodhWd4+As4moix8O53TsZdcwSexEvuIVf4TQw616Z5iZ2AQeTRzvAkHBXwOmAkkC8bdWhCxri5RyPNRjsgD/zG59/KHTfz2a/8jEkouRqORf6m6tWm/p+JvFdHoE96Af7jjpiXZVDs0/vtlptXaj4uKuJ4QGCnuNGfg1GRvabXTji/SLyiC0iVSMi8NRuU+ocirXvEMuQ4gnRt23sF2bBFh+xML/c+mbsSzpXp8pVB7x0B+4q1z9tBwsxtzlkBwDpFWVvjEBG60+9jHvSdFj+4wEMgh/nKJsVnAdXL4b9dq129Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsnV2PQ/pK9pVRtn/lE6zCqysG0ZOjDKHjLpwSQa2hY=;
 b=A+ArYBlfDZP3IKGr5tpeo4QrhwGBS8XZICgLj9iHVaZjpfYwm6B30usbGoG86PBH9z73i3Wu2gF/z6CJO05mrmJfSiV6cSH3exrotBIDSGez2cVM5xMfuJ0kKPfWLVUqbSPaCmI9Y4B1NWmbpayfzPZF7xAv2PNW39Q4hLe/UuI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 24 Jun
 2021 22:41:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796%7]) with mapi id 15.20.4264.023; Thu, 24 Jun 2021
 22:41:56 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tulmoqxf.fsf@ca-mkp.ca.oracle.com>
References: <YND8p7ioQRfoWTOU@relinquished.localdomain>
        <20210622220639.GH2419729@dread.disaster.area>
        <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
        <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
        <YNOdunP+Fvhbsixb@relinquished.localdomain>
        <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
        <YNOuiMfRO51kLcOE@relinquished.localdomain>
        <YNPnRyasHVq9NF79@casper.infradead.org>
        <YNQi3vgCLVs/ExiK@relinquished.localdomain>
        <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
        <YNTO1T6BEzmG6Uj5@relinquished.localdomain>
        <CAHk-=wi37_ccWmq1EKTduS8ms_=KpyY2LwJV7roD+s=ZkBkjCw@mail.gmail.com>
Date:   Thu, 24 Jun 2021 18:41:52 -0400
In-Reply-To: <CAHk-=wi37_ccWmq1EKTduS8ms_=KpyY2LwJV7roD+s=ZkBkjCw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 24 Jun 2021 14:07:02 -0700")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SN7PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:806:122::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SN7PR04CA0117.namprd04.prod.outlook.com (2603:10b6:806:122::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 22:41:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 832c0392-b7c7-4dce-48f1-08d937614563
X-MS-TrafficTypeDiagnostic: PH0PR10MB4535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB45352DBFA42D36F6792C5A908E079@PH0PR10MB4535.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CIFnNLubn275Of1DUv+6H1VWrKR/aLE9rUAlB/ZSkmSZZcRrCe5ieL1yGYCsl3n6UlJOKCQyazNiIqYJ7As+lxErstzcR56vS2iyU9YJqe91BVEEZvA7V86LT6o+e+mpniMDaESxpskikLZVtdekT89xweQpn7ZJz55kSEnRAd00nDVeL2C+UrOwhTVzfK+guan5Tpl4Ui0ylf1+PSCzWX52WZj41a9yTc+Ft/6/N6NqVw/DLYyk0aZ5Hl/0qcGej3ZLEUp2X4d9PG4Z063YvsT+cSFNhbV6v3DN7lp4qpcykc6XvRpjPd6Yx/R4gNbiooZEbBDTwHDaf8vQm4OIydGuKCPI7WvzglBiTyiMdxgwTSIQIAnl5dXM8k4QaAhAbB6e0HsngyQcKceY3Yd2A4MPu+9sGeH+Ghwy+J0KdX8gxiVewaWSDvnPahL4EAoZpJRfO5cSBWBz5E+0KdheL0bdfsz9g2I3gxRBGDzrxMj75K1D/QHEy5piA7VBBXw1By6DmSArCLkAB8M6LxrCiPrPk/pj5Cihp2NS4dHiXH9qHhKuGLm8nVwtvIc69DJCcJrkkK/saAVleqRHG6De88nMTHIUNeMgRUrleJGJQCCv87i5MYuIjslT+jXlPKZzGGJJW1ffIV6XYMzYhFA1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(136003)(396003)(346002)(376002)(8936002)(86362001)(2906002)(8676002)(6916009)(54906003)(7416002)(4326008)(83380400001)(7696005)(316002)(956004)(66556008)(478600001)(5660300002)(36916002)(66946007)(38350700002)(38100700002)(26005)(52116002)(186003)(55016002)(66476007)(6666004)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TRIGOfKEiAigObgi4SU88iLTa+EC9kC2hXNvhmko77eIXv2ArQ5+IjwZCGtX?=
 =?us-ascii?Q?2EyQZJcZP7OQSTctTdleWd4oADEnslpzfjxu65DmpKYzzqKcRY214LZybzzA?=
 =?us-ascii?Q?Sg7Yaezei/RwxtCOHaOj3Koz9YO/kNcfu4tf10X7ppYvTzqEGFp/POYVQo/Z?=
 =?us-ascii?Q?GMUUeN0+LQ2q87oli6iaeaKyqMO1vsc7cZ/i8Q05Kne4qoC6RxXD1s7LryNW?=
 =?us-ascii?Q?ohKT89crFFMVjQSfRwg6jT3C9dAOHXseFjutHtBNfSioxXCz+BvPfuQRRuPV?=
 =?us-ascii?Q?lN5ZOpp/LGGcEynDEbC/tLNOIDTdeQ5/BIM0Tvh2fY1NwQTjVOmcrMgxwQLE?=
 =?us-ascii?Q?e7uSgTWl2pfGy1COHtoMbG9d0iMzgKHoCGYK45Dg6q9T9IcHrLwVhVYxQjoB?=
 =?us-ascii?Q?P2kj34QzyCrbvb4GVaJ8sxHPo0nKiVhgbAtnNTSQBzCfuwK/M5gFHUD95RB9?=
 =?us-ascii?Q?XRexBTKa/eJhhwn0s/8RleP7sjkLpd0CDfKsiVMjwE6HJ64m+89SusnXIEOX?=
 =?us-ascii?Q?wemAHf+UMuTyO0beBKy57mxrRlktcC/Kj+1P8VQnUlafyGcDcd70v64yfg7t?=
 =?us-ascii?Q?7GDzDF1XgL0tPeP3dAxBzgkBryK7BKkMJOINyAZTWlLc6wCxSD8I/uTWvDFu?=
 =?us-ascii?Q?nsU+hjLoRHfogTBvuHvNLwbz0XRrsS6F1TnyZuK6EtwSFva9YDtcd3PWsiE7?=
 =?us-ascii?Q?RkAui4We0ES8ajw95RwMJ0sMai+ATbvuYOuIIwQ4rhpoEHRkQhrql1lYM6Zz?=
 =?us-ascii?Q?gG3ilbjmtRXN29RVg+gmBU6287amxbeIflflmzgTjsq3/wTcR6m9ka69n/y3?=
 =?us-ascii?Q?VWoFnPM/WbPt/EmhKwbk+kWHIq54Tr65YklHAp3noD8bke9IIMv9RjCKyqfa?=
 =?us-ascii?Q?654VxW1cP604QmeYJCv4iPr5IMHHBMSEJvGJ2dE1CcTs48kUFcTrVACY7czM?=
 =?us-ascii?Q?5N5uFoFEicSqAmfEEsAqMkHzI8ODwdbN7AAemhc6ZNkvsafXokfuHmCvumGe?=
 =?us-ascii?Q?alXEl9oP542Kqqi918kXes1Psk7DePkJ6SYR/EWnQNIEl8a2vx8dzdbAlv2j?=
 =?us-ascii?Q?zLQr9oFESpb761LZOhgxxiiXRK4x8K4En0c9i4B4vQuiQ1GLraP259H/qS4k?=
 =?us-ascii?Q?oqXroguTnZCMeLqzePOn+R9p/etnORbxyJEvcHXKGZ//tN7gR7/TBmUqISHA?=
 =?us-ascii?Q?70Ikp7AnYJYAxs9G8cL/u5Dew8kzn4q3E3xhpuuAHHjHw+iSxXeqrd1lJjKe?=
 =?us-ascii?Q?riDay/P4Pggw/AmZNUCpiarxqD7pR8R2YygnwTf0t+yQ8Rm8as/7G58HyL0s?=
 =?us-ascii?Q?oSThIzSGSdxiatQUaDH7ZUEj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832c0392-b7c7-4dce-48f1-08d937614563
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 22:41:56.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J611Vv6AghW5TKqn50ykPmPRQ4vwKXUReAQKC0oZaDOnKGiGD+UwJqkTSaQYOqScQDLtskNhWx2JpVjc6SiK7LMU0nFNgpRtXVUJKGFYT6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=810 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240125
X-Proofpoint-ORIG-GUID: jOMxUIBI7gU72380mUP5m_fYEDzi9AMU
X-Proofpoint-GUID: jOMxUIBI7gU72380mUP5m_fYEDzi9AMU
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Linus,

> I also worry that this "raw compressed data" thing isn't the only
> thing people will want to do. I could easily see some kind of
> "end-to-end CRC read/write" where the user passes in not just the
> data, but also checksums for it to validate it (maybe because you're
> doing a file copy and had the original checksums, but also maybe
> because user space simply has a known good copy and doesn't want
> errors re-introduced due to memory corruption).

We already support passing CRCs down to be validated by the hardware for
both NVMe and SCSI. This currently only works from the block layer
down. When enabled, the checksums are generated by the block layer for
writes and the data is validated against the checksums sent by the
storage on reads.

Over the years various attempts at adding support for passing the
checksum buffers in from userland have failed for exactly the reasons
outlined in this thread (Joel, Darrick, Bob). Would love to have a
generic way of passing this kind of information...

-- 
Martin K. Petersen	Oracle Linux Engineering
