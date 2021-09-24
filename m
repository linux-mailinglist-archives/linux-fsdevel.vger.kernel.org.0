Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4344168E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 02:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbhIXA1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 20:27:21 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:49633
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232143AbhIXA1U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqvlpFjP4Jx/Uw6KxduXQD07qyowv12IMnA+lZWzcFuGuvr/j+FLBPrcm13jicaXvaE+JJXm66UsWqssh1fl7KKUYYj6WPB6DgFs2y22okaX2hXtxRQupG3SIVd7vCerowyQETMecFnVK2/RUUkQ+DFGGDRsIbhez7n1XLhIrqlzt6XLkyJsSTvjjIz8AKfmRLppeG9MqlQfvAK2/t4FpeUja9ZSIAMD9o2XVOELi/VFwg/LLZn/7uDJw1jIx/3C3TzxNiDzxlOUWiMUaHl3shnof+ISh5v30ojv3Tpt3xuRNdqzFSQhSBPZ9WIh45+1Gp+dHzEMu01e9vxjYdpl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=roL5fFBLAouBp2/15L3AQkYctoNwIBXDiMZchfSrJws=;
 b=gkR6StfvwlJRQO1h9kBy6ILypIX3dsRfMMITx0t+5U2qv8/t/7VOzsLjo5+Np3jkXPbvdt97ZOzy5JlHzCw5Yzx2Ox2mQ/ywAy4DiIPycZhmtiwlfqer8lFieIcW9FWgklyL4pN+xSyLkyZeA2kDqCKTvgV+u5kh5FkqqoPUC/nccTJvm1sn5Q58HkbLbEkCtnHjELNf9uxmIqUiu2bExIIE9uhdwbEbh1tPKKt+So3mhpxOEZRqrW2e3aBomPvPIrZO7XcWsLttYkhSwedzblNQPpxG/m6GDAjgF/U5/yZcfguribKza5a5aV3TaIpyJQUCDcV4yaFv5QYJy6ELtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roL5fFBLAouBp2/15L3AQkYctoNwIBXDiMZchfSrJws=;
 b=e1816BxDqGhQ54+PEQ2Yuv0Q5p/xrahviNIGJD0fTdCJSi01rszNLtJcut2A/XyO3PqGYSkZkIURMbF2TXeXxBFetfsaVXPPp4j6XF+r8jRoKrrXBYuc4p0Q7IGHNgXys1YMUwaFpjEQ6qodHadwYo+zgKyXjNXizrSDQvKBCYY8D8inwmKShc7D+HHYkGTT/1B9UY/Ke1MB++OiHqk4hTIUOu3/XScdxEEjqryICmD62jIqkQKYHkB0SHv9Vj7MW7h50GD+OmWoxoTzgYdgN6S1syp7yYmllqhG200cCgssYGptCjZjT1f55s3+pzuoRGw+iYC0NSteHAOJ1v263Q==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 00:25:46 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::7965:aa96:5d5d:8e69]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::7965:aa96:5d5d:8e69%7]) with mapi id 15.20.4544.015; Fri, 24 Sep 2021
 00:25:46 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: Mapcount of subpages
Date:   Thu, 23 Sep 2021 20:25:39 -0400
X-Mailer: MailMate (1.14r5820)
Message-ID: <24B432CB-5CBB-4309-A9D0-6E1C4395A013@nvidia.com>
In-Reply-To: <77b59314-5593-1a2e-293c-b66e8235ad@google.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <YUvzINep9m7G0ust@casper.infradead.org> <YUwNZFPGDj4Pkspx@moria.home.lan>
 <YUxnnq7uFBAtJ3rT@casper.infradead.org>
 <20210923124502.nxfdaoiov4sysed4@box.shutemov.name>
 <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
 <CAHbLzkrELUKR2saOkA9_EeAyZwdboSq0HN6rhmCg2qxwSjdzbg@mail.gmail.com>
 <2A311B26-8B33-458E-B2C1-8BA2CF3484AA@nvidia.com>
 <77b59314-5593-1a2e-293c-b66e8235ad@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_BB7A2B28-15AB-4DDB-AD71-3CA2B9217E65_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:91::31) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [169.254.242.113] (216.228.112.21) by BL0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend Transport; Fri, 24 Sep 2021 00:25:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 898be47b-0215-4ae0-f746-08d97ef1da39
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4270F6C115DA7699875D85DDC2A49@MN2PR12MB4270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcJy65oOqNb2KPUpn7CZhMHhX6HRMACXoa0M1ssawje2WvyI40x5Kwyof7cEKKC2Vz4bDjA03SMNMSk7hINrkyxfy1IVjyqb06PRkiTw4IyAdHKJ56GcQ3t1M2uyLLiUogFYBcFUuTul+jMzj38cJxNrja6H2+voWk0K35oauvLGO7mb+xkJ+d4oCQ0i+3nhhN63n0TrpDl1dcFVFT5at18hmoDWtnRZ7MRatBR4s3DS5VTLc7WZyuzLsV+t28Bhl3e50neVaN3IMaB52mT7XRKQsbUL6p1rZkGg3w08uM1AYsJI8gSWk3RYU+cVcYfsVAMDDVRDm0ajxvDPq3bDcDx8/a/WQZyFY1oCRn9jKp50P3xVpccLmYXALY8qp3T8MdpVZC47ezV9Av8kXXAZBb7h+IrOMlXOG3AAFYLV1lebln0S08yiGIRXVEfWUUOK60vQlKwONpn3a3wGtZ4joNerwtLUsBgx+ndi24lo4tEO0lGCLNf9Br7tSeaGV4DqVOUtbi7HfvgCBtPch2ILWJTYcmcLv3D+ImYk984s6O8vQzSVf5MtUeRB+tJNnluaOel53AyE9k7C+Ru+FSWCPo4KRj5QqTc9s+kOjpgeD6hxOjS5Qv1t9RWQGmI+PIK+GgxrebeyFoeJJKTa8GSpvlMX1fC5d7aNwNghQXF862I+rUe41KD7o6pAZAsvE2P+gA8f/mkjluPRGxgUnjBVfqbCPcscr8fFsvT2yhmErx37V8BJ7GrJAYFtkUf8JmjE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(316002)(8676002)(6486002)(956004)(3480700007)(7416002)(508600001)(2616005)(21480400003)(83380400001)(86362001)(8936002)(26005)(33656002)(6666004)(38100700002)(66556008)(66946007)(7116003)(2906002)(53546011)(36756003)(186003)(54906003)(4326008)(66476007)(235185007)(6916009)(5660300002)(78286007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/TQYO1A1pG7ePUqyNcYsTph6/LJ82pO7g71H4/sddRpjdAAcVBsxodjnQpM?=
 =?us-ascii?Q?ellBlvqdmoFAVRgoebKOKuJZNffcEdRccBaSGgKyCn4IT8T3JtEFHMm4XITK?=
 =?us-ascii?Q?a/vNtItrHxPF9EwxwWNkXdvvtwT5AKjg8ytrNohfu0UAmDZEDQsuLFV26VG3?=
 =?us-ascii?Q?xegCjJWfLu3wLlOGFngph9QCBL49+tXkZaupiS+PkBE7jfJHyGP8jYwiXBAL?=
 =?us-ascii?Q?4FbtR8cJ4tNOAFTq/EHkyL9secrGC9kPxqCQoclGcJ4nYkaLL2QptdyE7Wg+?=
 =?us-ascii?Q?yaWooAmOe32gER/1DC5wyOLQnldrEXcUYe/iKJ/rnv++j38jb29Kk11iX+Dh?=
 =?us-ascii?Q?jrYlJFdjLe6CZ9NtzmZHTf9SgVe+vGJEdyYWFR0TuPx7Smla7dW1v2DZdfu1?=
 =?us-ascii?Q?WnC1WWisRpFM0wW9YtQ5OG/ceyf3M4IBlpXLIK99EkA2UzjgrP45KLl3zogW?=
 =?us-ascii?Q?6XmA/0o3tCvtECBB4Ny4yCKMOCjoRKh+gKb1DxJjMwqZI76HrwBR9ji524bm?=
 =?us-ascii?Q?Bl9tC2gkRiJNVC9GWdKBw70iY8181DoVEZlcbDSyu5Kw9YhFdLpLVcdbAG96?=
 =?us-ascii?Q?AwWDoWkLw+XXQkeMkeqES9qCn5ti1CUkQqyP0m3Wqe+ODX9Ab9CyEb0WEUvy?=
 =?us-ascii?Q?Dv7qsD9FqTKwgGjZ82djONh3FcSPd0jgptbrBnWsDd0QIe3yUvLezFJkXMGi?=
 =?us-ascii?Q?n8eXyvoVi9bPvFuYosQrQF7LM6a433GxEzpI23r3WkPCwReeNRFdm5tyJceQ?=
 =?us-ascii?Q?FmIFOnw1SqAB1M8u8GHDtowMerBCBLO7hZQxRzX4H9SxKVhZCnV5ZnrZmSak?=
 =?us-ascii?Q?gBQnIuh2kY59Dx0YKFtFhsdnB5tEoMqalb87kI1+McprdB1s+f/WqhXYgsjE?=
 =?us-ascii?Q?UQy/KcVL1YooRXO1eqwSO65Dh2Ipcuf8f3m+RTdRPLPRhqhw6Po6N/fsfXcJ?=
 =?us-ascii?Q?4Q5c8izKOobJxxU7cYDn9d+FMzvDz306I2UICV7AI/Aisd+vrvccjkGismwT?=
 =?us-ascii?Q?jEJKcuEmyASDGZhKIEVQVn7YOdtRcZI7hwlqoxRHwKXJ34sd0raKPR+5NYZB?=
 =?us-ascii?Q?ZJCUvA+7tAF1KYj2nU909/5H1UEgpL57jTUm8whb8MWEMRRjr7SE56cZHbH1?=
 =?us-ascii?Q?XKjI47fQbqIjI9hFiCPjAPoiSFT+sj0g5HsMcCaV3G2M/azCCg9xF56jRcKV?=
 =?us-ascii?Q?hnZjP4Lplw90RlpYV5wzhSZ+PR004LA/3B6WmTKACHwi6+ZdlhuEGpk9o24Q?=
 =?us-ascii?Q?Zh1G9hqitDNtW7NgAPp83/1/KSfp3UIK6Fl6qonMqGYQO67qQFlTzrsV5/zk?=
 =?us-ascii?Q?tiup6v6YPqMLTa9ZEKI9rY6I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898be47b-0215-4ae0-f746-08d97ef1da39
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 00:25:46.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHTtzNGlbvZwi5pgynEortkYIfSXTFutXx1Z8QTd/9Lgz8JzDjb0tRDzu35dBXYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_BB7A2B28-15AB-4DDB-AD71-3CA2B9217E65_=
Content-Type: text/plain

On 23 Sep 2021, at 19:48, Hugh Dickins wrote:

> On Thu, 23 Sep 2021, Zi Yan wrote:
>> On 23 Sep 2021, at 17:54, Yang Shi wrote:
>>> On Thu, Sep 23, 2021 at 2:10 PM Hugh Dickins <hughd@google.com> wrote:
>>>>
>>>> NR_FILE_MAPPED being used for /proc/meminfo's "Mapped:" and a couple
>>>> of other such stats files, and for a reclaim heuristic in mm/vmscan.c.
>>>>
>>>> Allow ourselves more slack in NR_FILE_MAPPED accounting (either count
>>>> each pte as if it mapped the whole THP, or don't count a THP's ptes
>>>> at all - you opted for the latter in the "Mlocked:" accounting),
>>>> and I suspect subpage _mapcount could be abandoned.
>>>
>>> AFAIK, partial THP unmap may need the _mapcount information of every
>>> subpage otherwise the deferred split can't know what subpages could be
>>> freed.
>
> I believe Yang Shi is right insofar as the decision on whether it's worth
> queuing for deferred split is being done based on those subpage _mapcounts.
> That is a use I had not considered, and I've given no thought to how
> important or not it is.
>
>>
>> Could we just scan page tables of a THP during deferred split process
>> instead? Deferred split is a slow path already, so maybe it can afford
>> the extra work.
>
> But unless I misunderstand, actually carrying out the deferred split
> already unmaps, uses migration entries, and remaps the remaining ptes:
> needing no help from subpage _mapcounts to do those, and free the rest.

You are right. unmap_page() during THP split is scanning the page tables
already.

For deciding whether to queue a THP for deferred split, we probably can
keep PageDoubleMap bit to indicate if any subpage is PTE mapped.

But without subpage _mapcount, detecting extra pins to a THP before split
might be not as easy as with it. This means every THP split will need to
perform unmap_page(), then check the remaining page_count to see if
THP split is possible. That would also introduce extra system-wide overheads
from unmapping pages. Am I missing anything?


--
Best Regards,
Yan, Zi

--=_MailMate_BB7A2B28-15AB-4DDB-AD71-3CA2B9217E65_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmFNGwMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKTUUP/i6Zs51g5xfPrQGWv50OUQRKTOTS7awsOY+m
BKiIAsVutyVQFpj7uLLFSbCcrptfflrweVeHTPx2Dnvdm441S0ZQpqcZSPoQHxPa
3d7GL5fC8Tr3pm9rV2O+tNi0AQY3xxw64vlAjKgbbUj0NbI93aG0KqXkDIaKTQcy
q9LEgXAMYL1V4T1stA+rjq1PnmabANJgsEFkmt6vM2K7nIrlYr+sUHOaG5nFavtv
bsWgfBFndYsbgpAGMNYJoU43MAxbLRAVyelNjoWcwJYOFtlgu7Xyjo5IVrs1rhzB
ICTid48sc7Gj4WgvYeNcMMiupfyELSsIP1JjP6nBwNrw/kIY2DNqEs6SS5ZUrz7y
5mUdnvGlO7gRM26Fn5Bv/2tCl9/IlFgZsJwd+v8X4p/vIAl8ABrj5gHcvd/BO3yK
mvMguZchMihvL0H5lDJrbsQELDuWQyysNr0fe92bV6iZ2iqMKgQqGKcNjtv1sLtp
KSqLTslNslzxU3fzLZvc1WzZrob99+DDZgQtLLMP4sUOmcCssBgDhTXAtlI4oAm1
i1kfEIj7Nz5A4/MMK+cY34/5HJPSsmOLs27v746QXNon/OoLj7vlfYNSohrea9NJ
l6lOPwUPDS7pVw0UG2rCgxR+tGUFsHPMUzotDv6BBQfQK8ilH+TPAX6aCiRddQ7g
IVHz9T7W
=aXh0
-----END PGP SIGNATURE-----

--=_MailMate_BB7A2B28-15AB-4DDB-AD71-3CA2B9217E65_=--
