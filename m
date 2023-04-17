Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B806E50DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 21:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjDQT1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDQT13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:27:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7857D8A;
        Mon, 17 Apr 2023 12:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfO0v248Jv9FSRQyY1iiBPXACk3RUie/NzfIRC2mlA7prpaQEwG+zgACWcm4GwMmcvXBokpSIBpm52FJegz6vEZxI8WYj8CfUs8rxuuYK02Z1fpssICDBLZ73Yw1i6eTGLzzONpOmO7b4iy8jcmAlPpLhOeBbRFvoV3wZ19zVsGQ6M0ZHJuJWNrYd4BSUTo/gQFlBgXUnSzFbRucSDZUvYb+SnFd9c2EW5DdPpt/4rowP5xwa3S1Flb7MD42rpWj3Km3Sn6lzdJIC9GPuBofzJvbWshqNEhZ5IWYkTT0MswYgHXL8ya4Mdou0S0w+ZEdhgL1rbtHbjXVtj/QaSELeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8hM0uY7iViOju5/VTvhwFko9AWPOITOTUCQTTPzuug=;
 b=QD8X1A9RXgX8N9ca9aWi09FusaGI6JDu+mz3YX39ONqWrgKVBPk0Hect+7eoZ+XG3La54xrcL0XRgB9FGgBNbaRbYjj3/phZSaAvpL70EZ+5GFma8wh6nncnbburm+515UmBAZDTCUY1mbnLUvR2rg8y/xpNlvJqkQX3EPVk1iPPJHdchoiu4rwhprphtP3aoCPgqDBzTeTd8HAJGmHffoILvcomfxlF52sPFHrIUOqdFmbbMgGcgtNQ7ZInW7lfWMqeAQziXICypNchwu2SixFnTbz5mnXNJR0ibIFByiOO/cym4kvd3rvVSQ2kQu+eFigAz6u1agbz7+XgSGgwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8hM0uY7iViOju5/VTvhwFko9AWPOITOTUCQTTPzuug=;
 b=DUE1V4GegSFA4ojJchXfwWO5OedQje25KsXcuoUVU5MFSHTM7bBornI96vvjgD09pxqRjEAFxID989NmD3rIxtnNY+2pA4lJuA2oeR5x5QEjsgRl3R7llVDmmHdKMMfnfr/SyV62Dxuhz1FLqsQAdo7ZrbMn5sCgC9nbSIFV+Lry3oHNXa6dTu/60Y3eIx5u0bacbPz06FaN0usPl3Fasnenc5cicQ6vCDV9DpK+nPMYik504vxgwExuS7oD0/Bx6NgnW0pUiqdozMhSJ8PWZ5sU7snS3grS/1RLcJdr5XN6LUidpXLzv0jl7zuURcwZ9a4psZyZFBaqTYrLb/eo8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 19:27:00 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::80d4:b482:3e2f:ae9c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::80d4:b482:3e2f:ae9c%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 19:27:00 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Split a folio to any lower order folios
Date:   Mon, 17 Apr 2023 15:26:58 -0400
X-Mailer: MailMate (1.14r5963)
Message-ID: <8B784026-7C90-427D-91E2-2D551FA576D7@nvidia.com>
In-Reply-To: <b37d1876-0a74-aa52-7911-e6f78280caaa@redhat.com>
References: <20230403201839.4097845-1-zi.yan@sent.com>
 <20230404144727.e613116684dbd65a4b4745c1@linux-foundation.org>
 <49ee481e-452f-61c7-2da5-28de2cf3de2@google.com>
 <b37d1876-0a74-aa52-7911-e6f78280caaa@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6604F9BF-E972-4832-8F42-69193B2F72F2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3e7ef7-e48a-424a-cf58-08db3f79b75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTI2JUFktucxnNSs2UV9nMNlLfkIB1qA9Vkj3eSaGyuxPsX9iBvStBnk7GnejXes+Cheq+KO/u1gQNL/TRUCp8ZwdQL7kdCt3aNz61NU86kQm7iboJs0dY3lywKW3oLdxVIOzsWdT5/a0MgNfMmMd5oRbXsjCLr8dt/KREUaEFK8Ll//ykvGwDSptKPhLHD81RZ33O0cN4A0hsUxTOSn8XS1DNjp1zkZbb2ntG8eO+IC6dBMLPfV2g4kEhid8THHHbDAkBA1K6z/ro+zjvCfCDkPP0ImuzWKLf2NVn13yZB6Q6rN7YPRVdVk/UnkAOc8iQMkq3Bmlo7S8F/lgNRuwx9+t/gPrctGeFAIiRgRHZ71sz1KTMZxtwSpvMAk9fPuP7gbJwVekRkvexhQPr+66TMKf7P6Zl3K742jkY/N5KRPBIb0YWHALaxP9+XDzVeZq96ju8f3gAmDoyxlhTRq2dyx8B2e2vppBuExVD+Q5ZTtpvUlhI7Ab+ESEyrlD0VazKItpQK1szbKAAHzKT7CJe/WHu8VMYg9T+Tlcdi7TbNDD4sDLt7i4mzMJjhqy8HRpZWBVu6it23/MRCK2gpJnKl1F+EJ/f/dvlJvcfm89jSu0Ytw0mncMLq0f6k67ARwSeszuuUQRy/CnzXC9wwhrpsySIbixO2cQQbYSjwN4fJF1T2yWqW5b0QSW//XO1YF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(36756003)(7416002)(235185007)(2906002)(5660300002)(8936002)(8676002)(41300700001)(86362001)(33656002)(38100700002)(478600001)(54906003)(2616005)(26005)(6506007)(53546011)(6512007)(186003)(966005)(6486002)(6916009)(4326008)(66476007)(66556008)(66946007)(83380400001)(316002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?so1w7bj1Lt9bIFegK/TTn8E5QFoAmAjNJnnFsibJupuqNE1V0u7Zf/GlTSHe?=
 =?us-ascii?Q?X3+7y+KdhyFJnz5JxFeeq9ydZXq7GW7gCUrgN6gZCAD4Vhk2vIYjR19hQKrt?=
 =?us-ascii?Q?4WC7N++Ppn16uOw6nchPi8ZmskQuvMuZMG3xjXXuCw0TocE5F/JvPQT2+r/h?=
 =?us-ascii?Q?EhvrT2IoUD9tui8uIC0jncLGwnz/ujgqlbIW+vPKP8BFUYg6K8cCmj2JxBZb?=
 =?us-ascii?Q?YCIkWebigUOOMokdrFZBgAm+WseBCU6At2sLwj8Z0CNnzQehn3d+MHm4pOy8?=
 =?us-ascii?Q?kd76jDf7j5/aphMkl7RZSsFEDXSiZx2x4wb30NsmcOVqkYZYFLGMywXPHLeY?=
 =?us-ascii?Q?9fS55BbkGC5AOV4S6lcDSQk9D1HcBGlKM0uBTwScy2SsRkUPdTIvD+dXw1hc?=
 =?us-ascii?Q?XPMYRjWAu4pG7paSKjMzayR0KCpLYonHeXRSc8iYHMQoLtnFHqDdcOQErY4X?=
 =?us-ascii?Q?SnzhdyziELXVdNRDtpZfb4jLQJjIAGiFauQdqSO0IU8tYMoPiaCzUkhn2u2r?=
 =?us-ascii?Q?T9NVmYO2sQYaeHkwmN6wfG6FQ1z+bKvNB5mQKBgOIFAt88U289YpbnVM6c+d?=
 =?us-ascii?Q?AI9thczZe0zusnE+wVVMen9E3d07EE4Wm5XKYKTaWYmf3esAi599whdNkxcZ?=
 =?us-ascii?Q?I7G/564AeFrA75IbHyd0cI+6/tASfRDK+Xa6o5q8PzeS1XFqtE+cs3P6NX3W?=
 =?us-ascii?Q?cM59wC9pYSVYUoCdo/K1MgNRDtiElwLsQ+xU1SifA9RufY45JC1Pli/yGEWX?=
 =?us-ascii?Q?ctltp4/j9jYNMNKN6i5K0yn4EKIf+Y0tfqbSoXKQ9XNV6r0WdZ4+plwKzIQu?=
 =?us-ascii?Q?5CB1/Bn4aZvabwdn10mlSmozBUay1vAm+QLcU+cEhNEMMmUe87Y7VBLLlzD0?=
 =?us-ascii?Q?846OyXtoATZP2gZYZ+LlZ9AuNhQnxPhhamR/7s4RxvpaGmBr4XACNCmaU99j?=
 =?us-ascii?Q?OIhzJ31W5Nck7HrYywQbtYDXFtKvAAqumewGLEH/CnIe+bfgoZwzxvwkQyUG?=
 =?us-ascii?Q?ff+Dy4hiySEPYEyPpZx7LF39S+t0aPpXx/IPSoUgrBO0aeQCLpDhJiUy843i?=
 =?us-ascii?Q?R5H2AURnMttbGEWvMEZHVhdqKlB9vOwYz/zamwAG27sh4eQd52Qdaqaf3Xfe?=
 =?us-ascii?Q?Q6DtG7lWT6ibrd1pbyvJyAWXo5YQxbcUfRXzTRojORTEQGN6dqnCE2r/3QNi?=
 =?us-ascii?Q?8ZowsTZkRX0Axw2pXt5nJOr/smicp0QgjgHbUpJkRPvd/0JpRmgUbejJo6h0?=
 =?us-ascii?Q?kenEiQjkZhHlqqx82dd8O59qTjOaZrtfT/WpPDtBVaRouOL7ULwzM/GItBxp?=
 =?us-ascii?Q?JXmE02s8SJiO4vOqtaXcM6bIR+rFo5LxhgFKfnxqKfV31sfEfh7deAukvrP2?=
 =?us-ascii?Q?Ab514uv9YkPfwiQ/cJqpo4dgsVEmrl8kE2LS1oLgUDAibmT6AAQ+OTVZlxiN?=
 =?us-ascii?Q?BdN0JtOAAGvlVM2N1m87Uf5V6hzZbnX1G4GroGJ3Czk2vxySCe4bbmqPh7Wu?=
 =?us-ascii?Q?/Ve1jYhXmv6bOM9xi9zvk+i+lqAvC3FVhMt7vtl65EHf4s8H0lr4UUfXyVFQ?=
 =?us-ascii?Q?DUqQOmEZD57yKwccPLE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3e7ef7-e48a-424a-cf58-08db3f79b75e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 19:27:00.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qbozQR6RVBXpu4Q+QmuOc4Eq4jc/FWevxpqGb6d28MaLWnGN2F5bAEAeRkZzTAE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_6604F9BF-E972-4832-8F42-69193B2F72F2_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 17 Apr 2023, at 10:20, David Hildenbrand wrote:

> On 16.04.23 20:11, Hugh Dickins wrote:
>> On Tue, 4 Apr 2023, Andrew Morton wrote:
>>> On Mon,  3 Apr 2023 16:18:32 -0400 Zi Yan <zi.yan@sent.com> wrote:
>>>
>>>> File folio supports any order and people would like to support flexi=
ble orders
>>>> for anonymous folio[1] too. Currently, split_huge_page() only splits=
 a huge
>>>> page to order-0 pages, but splitting to orders higher than 0 is also=
 useful.
>>>> This patchset adds support for splitting a huge page to any lower or=
der pages
>>>> and uses it during file folio truncate operations.
>>>
>>> This series (and its v1 & v2) don't appear to have much in the way of=

>>> detailed review.  As it's at v3 and has been fairly stable I'll queue=

>>> it up for some testing now, but I do ask that some reviewers go throu=
gh
>>> it please.
>>
>> Andrew, please don't let this series drift into 6.4-rc1.
>>
>> I've seen a bug or two (I'll point out in response to those patches),
>> but overall I don't see what the justification for the series is: done=

>> because it could be done, it seems to me, but liable to add surprises.=

>>
>> The cover letter says "splitting to orders higher than 0 is also usefu=
l",
>> but it's not clear why; and the infrastructure provided seems unsuited=

>> to the one use provided - I'll say more on that truncation patch.
>
> I agree. Maybe this patch set is something we want to have in the futur=
e once actual consumers that can benefit are in place, such that we can s=
how actual performance numbers with/without.

Ryan is working on large folio for anonymous pages and has shown promisin=
g performance
results[1]. This patchset would avoid getting base pages during split if =
possible.

>
> Until then, "365 insertions(+), 68 deletions(-)" certainly needs some r=
easonable motivation.

Come on. 225 out of 365 insertions are self tests code. We need motivatio=
n to add
testing code?

[1] https://lore.kernel.org/linux-mm/20230414130303.2345383-1-ryan.robert=
s@arm.com/

--
Best Regards,
Yan, Zi

--=_MailMate_6604F9BF-E972-4832-8F42-69193B2F72F2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQ9nYIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU1JkQAJrMoZIPzydE0gILZ2WXiskAeFvMuzypdwEQ
QwzaXiXzsmCN0Ih2A7eEgAHuIBqOjpuXsC87kccE3GAxwYsAFSUFd7twc1bS4mi1
hx9Ygucmzk5XueYyn3Za8PLvWeh0rzDtgoktFvFlWHa95b5CsGM4YGW/EaKqTVng
C2XLl1aTc0GCKsaWb+TLeH97cLycoGaS9wPyBylZb2MM1wNnbokS9ygMUiepE8uH
9q9lql+d1ekfCDplF9b6KIK14DUe8X1y7QV6Lz1nUIUu1LW06j+3aKtDCwyrUH5u
NVDxZ8169ca3BbItV5q9Iq/2clUb4A7iOrw4HedZpSq5PdR/utSGQQa6mqGlOeWJ
yBKD4kjlFe4Tlomuwim98sle9iERBb+8TteFgxnMUNjDTV0jv6ylCNw4u9uoToCd
dlIDGK3DyQSEDvx/01q1zU9Ue5Qbj9DqSpZRIQb8ZHRr0fH+dTaN+gqAl+oETy1i
QANK67sJ7xE7wXiO0uJWlicVjZWJdszjH6xYc62c4blWMByi2Cs7Ep2JAHGqDY9i
5Kw1TMbM9rBM5eg0Bd/9IMrmn7Y1oXWpbcLWJm5qrRA8KyaeMguRRmn4KhT4OZmD
4Sb2OHYh//M2bZeYl45BxKgURDHWj6JdBcWBZQP99D6g2vKpBD+opbgBCj88pVR/
WqCmIjnb
=2EYe
-----END PGP SIGNATURE-----

--=_MailMate_6604F9BF-E972-4832-8F42-69193B2F72F2_=--
