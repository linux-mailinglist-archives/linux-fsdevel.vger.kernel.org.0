Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3E3684C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhDVQ1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 12:27:38 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:35206
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232670AbhDVQ1h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpjUT4KMnkybXTiSzEohto0ZgGECLPOWkWQgJ0jYzxrsMAk1MjwnAR5ddexNwi1YYC+ra4oVpMy5DhFAqXYO2YYgu3m1r7C8WIOS+a+og87fjHd2mwXv9Hd49JmG0FekKZXc9wUzr5TbvxHr/DZ20m12NMCwLx9q0UmkBWgQu9D3atWTCclPNqkCJvkfj0SB5j+6NgbQ3NtWRP5BdtfUM+HHdOQnIhw6acATJqXbpNyXxF8oSmg6mvNGxmcWC6yeSwvP7Jl21T6Vbcb+3PJtwKmyT+WS540MGtHfMRxHgC6djQACtLoCfTt6WMdG+ydjQG5Dl+tx7g+4zb64EOPAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFKahuwSD3xV27Eeva6mzGzfyEd0p0+my+n2YbcLlP4=;
 b=Yrbjf++LH2wrQzn2oMhLd8FALgEyMWE6hzw7YO7pW50F/ttxnWQLxZ+ZUX0NkbWtlsaDczZCJIu5Zl7BUX/WUoKkHJzK/5fbW0OUxwZUWWXt9AQv0kmANTE7Kl8llr89EUDxS8exqPEAQMKkrhkihggzLADvc7BCxjkJsU+fOKWIJqVr4HUu//9E8aCBHaVpVanUkfWF0iDMpsgfLl3PBlo9IT0wyp+k0bd365b41hSXSBujyfiD7B/7GgraZ8WkyeoHcGGb8Hw3Wgkh5Us4iyob53ZDwrtYLQoOeNbzkz1bXi3H2hfayQiDmiW0db0XQ3LxUrZvzkWBGujl3h8rpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFKahuwSD3xV27Eeva6mzGzfyEd0p0+my+n2YbcLlP4=;
 b=nQ3BLOaJtXBmeiPNrKWgayBE0XLQ/1kTYQETAzfneUYSEtTDNpBJyd0uCfjJMnNqlit21IdcJTYtBNadxUBZvChU1+hbVdD6lNCsjiBJ+wp3aR9A/hr/xJZ7u2ktu6o3j20IKuzaqRdUU+7ub5qlJLjXNiW6V/B+uYfiqZTxLBDbljqxSUkQeFSByZEPezNkFXupp4XGKXa3M/hvBoK+7Mg5CsCQuHUiPMUc1xJbnP/3/PxF4nADnW4MmPlVDKJArdfwWWrjJbKIJgrf/x11VtRjXpYwKxtt001cc4yZ8EfpLBfwZTYwDhe+xoaXlPO/yVxKV8f9NZ9M0PqrQi+vLQ==
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BYAPR12MB3320.namprd12.prod.outlook.com (2603:10b6:a03:d7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Thu, 22 Apr
 2021 16:27:00 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::e9aa:71fa:d0fd:1a7f]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::e9aa:71fa:d0fd:1a7f%6]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 16:27:00 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     chukaiping <chukaiping@baidu.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v2] mm/compaction:let proactive compaction order
 configurable
Thread-Topic: [PATCH v2] mm/compaction:let proactive compaction order
 configurable
Thread-Index: AQHXNn8EHJajSRkDM02ntF/mlIkikqrAufsg
Date:   Thu, 22 Apr 2021 16:27:00 +0000
Message-ID: <BYAPR12MB3416361959DA9128870E92B7D8469@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <1618989713-20962-1-git-send-email-chukaiping@baidu.com>
In-Reply-To: <1618989713-20962-1-git-send-email-chukaiping@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5be3a6ca-99c7-49c6-455e-08d905ab74c0
x-ms-traffictypediagnostic: BYAPR12MB3320:
x-microsoft-antispam-prvs: <BYAPR12MB33207B8A0B4ED2DB074F505CD8469@BYAPR12MB3320.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bbYkL8SVez4iXgnarm0xccXTObjaw5nqHBuOk95ylJ42MyJiZO0wN18RCR+XX+y2ScEcJFI0GKauN+PUgnoB9Gvb0j5qsO7Aslx0N3vhdYu93qq5jk7jXVAye2RZVAy872OuD55d+TCqRcDav1gSJHMUQ8oVyb3I6b2hpKZKqmLydDnY0tkF6XXmvtLxjLzzL3irJuNKpuPsgdR1KqO15Ij1j2XuMrwM2I8mPuPOfbItRdQ7eSW3kX2F3eF4Kje/RY/Bdy9DYxOahRJd9FMpqd0ohACVa7pX6A2sTaay3m4ewOoCnejvT9dELxsOznKqBX2F3NmwJrxsbV+hUbWnRPd926IQmbJuPI6PS2VFDPPr9tl2M1Q3YPXvAL+9TaQod9NbCX2UfT0B2wR6FK9CzQ0BwA8tRYg4SKv7Tie5QPe/wjhBbgzO5kW26ylfuFERlUVIUyaab8UM2dmnoiZRYcpmK3p3QdHGqFvw0fP26BWO3sQNv6fgTEGKhj29qv3R29/UUvTpR/PwoM0JOgqIsPXWgR2JT2bHskDUEwT5tZ/O+EdG6YXW93MwdgLDC2XAiRwzzUN4AIGN0HDNeygnAkqgqMxokfAa1x8AE8H0i3dDAYR0OYa0Jk9eerAjOJL2Dqdp3GyfBY5+/PDUAFgXRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(66556008)(64756008)(66446008)(66476007)(66946007)(86362001)(33656002)(26005)(186003)(6506007)(52536014)(53546011)(316002)(5660300002)(54906003)(110136005)(8936002)(7416002)(921005)(38100700002)(71200400001)(8676002)(2906002)(7696005)(122000001)(55016002)(83380400001)(4326008)(478600001)(76116006)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B9nN642qvmXy5UJAIgCRDBR4t2R5/upQjZgiVlnd7CFyuoVTt7SF77i0gfNd?=
 =?us-ascii?Q?OfMMm7wKtIPiR9F+J+zSpB4ZNOVDxJ6WSwFbbRzoT24KylF0ceUvQZ8J26dV?=
 =?us-ascii?Q?fsXkvuSXidWvJG8ARiWQ4+QI3uFR5jlVk1wHGnaeZt/nHlr08NA0gCh8Ik8/?=
 =?us-ascii?Q?vy+Ad/aa8myI2n5WuSsTLI67KMb8Tsxi3MZISIVqo9eJZUt/LKFwwhVuFbAa?=
 =?us-ascii?Q?K7n08jZ9xgWwXCGnyPUBBYcsPUOIzZQ4COGKPuqB9OIns7DEjaK4jdFCRVZL?=
 =?us-ascii?Q?qnlm5Lhm8+qOZEtxssIzG3Rs1Yn1CeKUppbZxczKknxWcngEqExf7xUumWsq?=
 =?us-ascii?Q?CdFkxP1g6mJfbPSrOWyJHD22YULUpXD6Os5Bp7RvFt90BbZrhn1bN34+0CUN?=
 =?us-ascii?Q?Y9zAIybRaNQfjkVCO1rJGwdm7HYpuA/Vfk2nzaImigp6QdDOb0wHcBdEjUya?=
 =?us-ascii?Q?gsUwtITiE1C6o+xRgtzDPy7po7vuL5fo3no5tyZUjFU/1dw8pcu8PYW9/82H?=
 =?us-ascii?Q?lXVW+S86LPGnfdXBNjZ8Jy80eRC1Fdg86yUptn0FAhFMLn0Eo/nHXjuoeoQ+?=
 =?us-ascii?Q?ejElMtSu1GACqgzF1W45lS8SLjl7EI5i5X+9ATODfsLa89ihxo1wxu1yVNMu?=
 =?us-ascii?Q?lnaAh8PSGH82JR21x+rHzVH/++F7WRSuuy/Nc4mUBApT61KwG4ptjwDZl/c+?=
 =?us-ascii?Q?9dNJTKOE2GybCwQfsgX8yJBf3WzACdVUAzaJgGw9nstlpMp7uZEF4sxgbHC/?=
 =?us-ascii?Q?JhBV1uVtNWSQ1VFMfAXTK1VVT/l8ALpkKcwvF1lC4a2e//XBuFoyMUD2otEt?=
 =?us-ascii?Q?mEEP/HhhGzafV39eSCmw7ydavertZ2yXPyRc68Z624ZTp7Pu4M9wD3ZRcdU2?=
 =?us-ascii?Q?yrTJI1qc+yBnPn0ZT0frY+rBdK70XBdmmuRNLiXOcHwST2pbAXxtS/tvCE2f?=
 =?us-ascii?Q?TDxqNx9pKxjjDAlPYwxzVhL2J0dLuI1QrYpJW8UCHvByKkNesyaHR23wqeNm?=
 =?us-ascii?Q?ShypY/7dcszWoOY/OmRp2XpkbIYcblQeAsE9s+sS/NaKg7atw4DArywOYD2s?=
 =?us-ascii?Q?IC+nvpfoAwfq4snxBqA1UiJj1SDIhYLbVBXlkPQ89o7qxWxLiEAoU0fmmxm2?=
 =?us-ascii?Q?8KVYy7N3gDxC0dmFTY8Db2XWm5+FNmhcXzJUnJNEeMNVEiEhKgkTEbD+2o1F?=
 =?us-ascii?Q?B4kwIzzlrci8Hd/Lf82BEkyoCvoFdzLL9L0742yOH91Rr7n1QsIXygZVA58+?=
 =?us-ascii?Q?60s4peDsuk163WZSrdGAGYhCAvalpT2TAdr9kZDUUboIRqTmrDc9+GmWrEFd?=
 =?us-ascii?Q?Ut4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be3a6ca-99c7-49c6-455e-08d905ab74c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 16:27:00.3621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/EN5MAMEkk7DFx6hcshgRr2w9Z62wdi9N5KsZBWHdO7wH/7CsCEMHhR7sh/UhwLm2UvXdkA3NGFbFRSSUj/uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3320
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: chukaiping <chukaiping@baidu.com>
> Sent: Wednesday, April 21, 2021 12:22 AM
> To: mcgrof@kernel.org; keescook@chromium.org; yzaikin@google.com;
> akpm@linux-foundation.org; vbabka@suse.cz; Nitin Gupta
> <nigupta@nvidia.com>; bhe@redhat.com; khalid.aziz@oracle.com;
> iamjoonsoo.kim@lge.com; mateusznosek0@gmail.com; sh_def@163.com
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
> mm@kvack.org
> Subject: [PATCH v2] mm/compaction:let proactive compaction order
> configurable
>=20
> Currently the proactive compaction order is fixed to
> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
> normal 4KB memory, but it's too high for the machines with small normal
> memory, for example the machines with most memory configured as 1GB
> hugetlbfs huge pages. In these machines the max order of free pages is of=
ten
> below 9, and it's always below 9 even with hard compaction. This will lea=
d to
> proactive compaction be triggered very frequently. In these machines we o=
nly
> care about order of 3 or 4.
> This patch export the oder to proc and let it configurable by user, and t=
he
> default value is still COMPACTION_HPAGE_ORDER.
>

I agree with the idea of making the target order configurable as you may no=
t
always care about the hugepage order in particular.
=20
> Signed-off-by: chukaiping <chukaiping@baidu.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>=20
> Changes in v2:
>     - fix the compile error in ia64 and powerpc
>     - change the hard coded max order number from 10 to MAX_ORDER - 1
>=20
>  include/linux/compaction.h |    1 +
>  kernel/sysctl.c            |   11 +++++++++++
>  mm/compaction.c            |   14 +++++++++++---
>  3 files changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h inde=
x
> ed4070e..151ccd1 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int
> order)  #ifdef CONFIG_COMPACTION  extern int sysctl_compact_memory;
> extern unsigned int sysctl_compaction_proactiveness;
> +extern unsigned int sysctl_compaction_order;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>                         void *buffer, size_t *length, loff_t *ppos);  ext=
ern int
> sysctl_extfrag_threshold; diff --git a/kernel/sysctl.c b/kernel/sysctl.c =
index
> 62fbd09..a607d4d 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -195,6 +195,8 @@ enum sysctl_writes_mode {  #endif /* CONFIG_SMP
> */  #endif /* CONFIG_SCHED_DEBUG */
>=20
> +static int max_buddy_zone =3D MAX_ORDER - 1;
> +
>  #ifdef CONFIG_COMPACTION
>  static int min_extfrag_threshold;
>  static int max_extfrag_threshold =3D 1000; @@ -2871,6 +2873,15 @@ int
> proc_do_static_key(struct ctl_table *table, int write,
>                 .extra2         =3D &one_hundred,
>         },
>         {
> +               .procname       =3D "compaction_order",
> +               .data           =3D &sysctl_compaction_order,
> +               .maxlen         =3D sizeof(sysctl_compaction_order),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,

This should be SYSCTL_ONE. Fragmentation wrt order 0 is always going to be =
0.

Thanks,
Nitin

