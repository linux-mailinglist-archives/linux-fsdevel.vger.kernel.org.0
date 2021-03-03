Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4796E32C56C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbhCDAUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:39 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11463 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386450AbhCCSPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:15:35 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603fd21c0001>; Wed, 03 Mar 2021 10:14:52 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 18:14:51 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Mar 2021 18:14:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI+9gJEy7L+gGkuV5WY/QrSjasQIswnwDsarhtU5EDdVrzgQNUJfOuRNzrAk3suq1Bpm2Qx2LiEEc1Flq7Tw0P1rMmim7bgTN4hRbP9asMvvThh5yyJBSxBGwqOyCKxNkwx7arBnEWMMvrz/TaQt8YFqHW5noLDvDb7EW71hjxT3awkEXJ9sX2jKKOjyz+mlsl6ul1uqYdpPrKKc3yjFoi5Urdd4/0lnhOiP7WT++fF47snn4iVV+Zt1eAqbxyFZG0IcC5EfFtcRxdDtMVL28eWObfNyClRtBNXsVtpwaPlPRL7ciUxmcHuMr0H/uLyWBVn0gm1sXf8nwdEAVtQBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxHZTb1EMC0NqfNR3MSde4iuUoriIXG1U04URZaKJxk=;
 b=TxZwtgWE5yalHIg7eeVZALnI7Q//NbzGDjVFD732/9rZmBKO4ouHy5UF2PXv7M1LLzUaGaNwaiHO3LiGUQ0+qIQFcOmZkhJ1EtPRNz8gHngo5x0lzfxKyN1JTOaPEHXTiAMZdqZPvQ/fgpMOm0zlW7vkVXVS3zzZqxhR4P8sREtq6189QEM5xGap2dkhvbURcYBsV8lQw9iY/ntXhSMMlOGWk0QSRi59FTb6x5mUM77+NBXZklP7YbYw4JF2HV2ONXGsfbVw3hh4gau4EtlCJJH8SiZ8oDAIIQ0BO9G/ebEPML1WrlPzGZ7vAhyXzAeeHJ6AmmwCaGz9YEX61pD5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 18:14:50 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::9428:ff6a:7f2:5976]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::9428:ff6a:7f2:5976%6]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 18:14:50 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     "pintu@codeaurora.org" <pintu@codeaurora.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pintu.ping@gmail.com" <pintu.ping@gmail.com>
Subject: RE: [PATCH] mm/compaction: remove unused variable
 sysctl_compact_memory
Thread-Topic: [PATCH] mm/compaction: remove unused variable
 sysctl_compact_memory
Thread-Index: AQHXD411mHVMaaygcESwzSP7eEOUu6pxIlMggAEy8oCAADvyQA==
Date:   Wed, 3 Mar 2021 18:14:50 +0000
Message-ID: <BYAPR12MB3416A388F9635A0F8799E49BD8989@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <1614707773-10725-1-git-send-email-pintu@codeaurora.org>
 <BYAPR12MB3416C9FD5D10AFB930E1C023D8999@BYAPR12MB3416.namprd12.prod.outlook.com>
 <d3a2ef132c8deee8ced530367c81479c@codeaurora.org>
In-Reply-To: <d3a2ef132c8deee8ced530367c81479c@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [2601:646:9302:1050:692e:4093:3a83:fe96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aaf3035-6960-4e7c-594c-08d8de703c59
x-ms-traffictypediagnostic: BY5PR12MB4177:
x-microsoft-antispam-prvs: <BY5PR12MB41777D69489E4E4520CECE6AD8989@BY5PR12MB4177.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cqa3EqG9mwK8WWqdwHIzsUJZBC5y8S/6cMOuGabWoV0eEYhP7N6CDxLCs7zdsnIHKnBB2BD47ykANMYu8NJJvgbQr5dC4uYfgncqHY+5ff1XNeeSLM+xxcBtvPOpqubnIXqfeTPEuVK/pEhAwKfaQm7M9lMbpQCzEQpSglmnwqEhDRYeKWGnTPzijQEyPA+QI3TRxZLkQ1781yzXAdBuKhOlvwibCIApkH3lenEfaPrK30wj/0iVYD83MWZeSiJkVNaWmpXFC8K8d9DZWgm4ydOXnyPsauOQLPtOpz/XpbOer3fjeWdhqOjpMyHSDQG8w2lN64yGe2C/iVMq524hanAzWpEV1F6V2UolP2LWtfP6ELL4VJ8+c4yfU4z24OOrrlMyGApo6RBn08no785mXuk2pR10axNkqD7TyCF7pPHDeT3XSSEJEZnyEQOYhh57pOpjCCLHDstJ9tD2ZyvQc7Ox23pf4uW3nuDyRDE4FSNTy6RY5POZ8/ihPOkEwPVSz2VHfcen6q5hNEJniB/Plg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(53546011)(55016002)(8936002)(8676002)(186003)(316002)(7696005)(2906002)(86362001)(71200400001)(66476007)(54906003)(9686003)(76116006)(66946007)(52536014)(4326008)(66556008)(64756008)(66446008)(33656002)(478600001)(6506007)(83380400001)(5660300002)(7416002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DYe5UlEdGLaITemmT/yx0KY+g67fV7b1SJgGazZD2eAsDUOlEjqvYvB2JfgR?=
 =?us-ascii?Q?t5bUc5Qw5VSi90VnMAz2BsUMYPLOHAgzFwYVHKEBClgi+8ooIWkFZRr39baL?=
 =?us-ascii?Q?+8HjtfX5KDQ1GtX4KAeBVcBB293Wmegb4nCwexxpFmembmDv0Lsa46uV107a?=
 =?us-ascii?Q?o/U+NxYj/gZCm5TmFcr1Pa0xpp3jXIyULl7hv9eF6vGKhtempZKyEc6jTpHC?=
 =?us-ascii?Q?lgutgrLsq7+9nMFD6h4CdziVP553/fiIFShxF5l39kX+6VaWU180ROoUzGG2?=
 =?us-ascii?Q?rjyztqOwyM5ngUoFbncZ7KJsu7elTAaI4NP1rqCBIy6GdjxHmySMI/m0FDIk?=
 =?us-ascii?Q?U0QuDTk1RK5hU0FGUec74+SHkgGA+Bg/5N6Rolk77PmIZnKLJ9mS6b49nQ/g?=
 =?us-ascii?Q?j7HyLuaaFR8tbV+0LUiIIh4kFyhPt5f8uhtaxEae+RJiVmQer2l5cw5u+Z16?=
 =?us-ascii?Q?ahGJd2irocqpmJjoREeLVcRG60RbbEcbJMwdv67qfSz2AhvbbnOaOe27UNrL?=
 =?us-ascii?Q?g54r/xutwXk2QbcLQEkYRhV4zQ5nWvSSZCdGtHz+CoyV0hnRuAxYhfbyCAdu?=
 =?us-ascii?Q?OCgGQTGtKdp07F7l8dJa9G5sbve5Uf/ExpsY+D3yVOpKDm3fPDWK6UxdczqF?=
 =?us-ascii?Q?dZBdj751cPxTH7NvTG1+/fcCVh9KcwW714OdA2px5yusWU0PMFrRxBts9DNE?=
 =?us-ascii?Q?8MUTlxU1NiSeJfaOGRpYk/T/Yc9DwL3KufHpR2dIR2TAmWVM+170xBGqTxBC?=
 =?us-ascii?Q?l6X6KEUnuA4xBGC+9R+2pkCOnOPZo6ludv12H4SQqgqS0Wkcw9CEew22f1Da?=
 =?us-ascii?Q?mnBtkX2mz7wh4ef6SwxLsZbSbNyo5OW/zCmjYeN3v/VXzKWO7ykrJ5JdIHNX?=
 =?us-ascii?Q?Eg8FRqZlzq/O1fGifS5EX2NihFMion0CPGRpOanXsWrLwt33nkGz+A1YxGNK?=
 =?us-ascii?Q?iIp49FQh6JIIIZasn9UuJhDsXReszi984Yi6Sx0BLpP/aJSrJCPrc3KdNkYs?=
 =?us-ascii?Q?O7WJ3pKzi9YMDVX3Vc5ghF5UDkowU+66/imxMjeibY6G8cjmXufaTJoGiBxi?=
 =?us-ascii?Q?ZS8nL1nbMONEtaEL7brDEHFuqA2xrDupDDmDUpEEGutmGf4YtWv9hUU6RUz5?=
 =?us-ascii?Q?XKkfF5HeyM9ZyNbnqdvmVaDw9zbewcqz6GvytiMW58yCTmIcm9mu3SduVeMI?=
 =?us-ascii?Q?/NgqtIvlBZR8G3HujaHSCWlSWkQxpsOLhgM1ian3GE5GaJKH5R9e+UBv7JEP?=
 =?us-ascii?Q?3kGWs+/D2Fqf2XUdtyV1kRrTqfNPTE+QKM405fi4fanT+PJzEav5xbZG3yg1?=
 =?us-ascii?Q?XYACMw2LoguO0rUuaRwj2l2TLXZ6oy5JOFIJcF8tMI8SRzaqAEaxSGP/qyBA?=
 =?us-ascii?Q?fhLVCH0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaf3035-6960-4e7c-594c-08d8de703c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 18:14:50.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XvimWbCuzlzU7cYn2eyXliFLIP/p2OA6uRAY1BkZkFEvM7mv7OhV3ru5ZQhh2BDq+QEbqLGiKBqwuEQLrE2xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614795292; bh=yxHZTb1EMC0NqfNR3MSde4iuUoriIXG1U04URZaKJxk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:x-header:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         x-ms-exchange-transport-forked:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=B22Q8YasibF+GC3jNHTv5ro0ggEwN/tl206k97NvjK+WP2kcpDpi3+SG/lKGiHWhm
         qiRBx3x0Z638my66lSOaYf/ILd2kFZnD0TW4Yep33do4iaLNAMKlhUk3FMjQ7+Q+JS
         WitCrKJ+y9d8d0OXZ9KnuhgiKTSiSnk+TB+f//dZcRch309lI5gQT0sY0SOAwKVM4e
         xLDbxzK+LiJZy4+Or2JcXpIGcU/Kb0VogDNkVBCnHbSM8d9ITk91nt4YWPJy1vQZqQ
         2Ltt6NRXZRC6ED8xFrti4YHh15/dDndfJr2X9PO+dLBkUtU1efC1UKx9LMePUxVsVo
         xrWBouIty861A==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf
> Of pintu@codeaurora.org
> Sent: Wednesday, March 3, 2021 6:34 AM
> To: Nitin Gupta <nigupta@nvidia.com>
> Cc: linux-kernel@vger.kernel.org; akpm@linux-foundation.org; linux-
> mm@kvack.org; linux-fsdevel@vger.kernel.org; iamjoonsoo.kim@lge.com;
> sh_def@163.com; mateusznosek0@gmail.com; bhe@redhat.com;
> vbabka@suse.cz; yzaikin@google.com; keescook@chromium.org;
> mcgrof@kernel.org; mgorman@techsingularity.net; pintu.ping@gmail.com
> Subject: Re: [PATCH] mm/compaction: remove unused variable
> sysctl_compact_memory
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On 2021-03-03 01:48, Nitin Gupta wrote:
> >> -----Original Message-----
> >> From: pintu=3Dcodeaurora.org@mg.codeaurora.org
> >> <pintu=3Dcodeaurora.org@mg.codeaurora.org> On Behalf Of Pintu Kumar
> >> Sent: Tuesday, March 2, 2021 9:56 AM
> >> To: linux-kernel@vger.kernel.org; akpm@linux-foundation.org; linux-
> >> mm@kvack.org; linux-fsdevel@vger.kernel.org; pintu@codeaurora.org;
> >> iamjoonsoo.kim@lge.com; sh_def@163.com;
> mateusznosek0@gmail.com;
> >> bhe@redhat.com; Nitin Gupta <nigupta@nvidia.com>; vbabka@suse.cz;
> >> yzaikin@google.com; keescook@chromium.org; mcgrof@kernel.org;
> >> mgorman@techsingularity.net
> >> Cc: pintu.ping@gmail.com
> >> Subject: [PATCH] mm/compaction: remove unused variable
> >> sysctl_compact_memory
> >>
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> The sysctl_compact_memory is mostly unsed in mm/compaction.c It just
> >> acts as a place holder for sysctl.
> >>
> >> Thus we can remove it from here and move the declaration directly in
> >> kernel/sysctl.c itself.
> >> This will also eliminate the extern declaration from header file.
> >
> >
> > I prefer keeping the existing pattern of listing all compaction
> > related tunables together in compaction.h:
> >
> >       extern int sysctl_compact_memory;
> >       extern unsigned int sysctl_compaction_proactiveness;
> >       extern int sysctl_extfrag_threshold;
> >       extern int sysctl_compact_unevictable_allowed;
> >
>=20
> Thanks Nitin for your review.
> You mean, you just wanted to retain this extern declaration ?
> Any real benefit of keeping this declaration if not used elsewhere ?
>=20

I see that sysctl_compaction_handler() doesn't use the sysctl value at all.
So, we can get rid of it completely as Vlastimil suggested.

> >
> >> No functionality is broken or changed this way.
> >>
> >> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
> >> Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
> >> ---
> >>  include/linux/compaction.h | 1 -
> >>  kernel/sysctl.c            | 1 +
> >>  mm/compaction.c            | 3 ---
> >>  3 files changed, 1 insertion(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> >> index
> >> ed4070e..4221888 100644
> >> --- a/include/linux/compaction.h
> >> +++ b/include/linux/compaction.h
> >> @@ -81,7 +81,6 @@ static inline unsigned long compact_gap(unsigned
> >> int
> >> order)  }
> >>
> >>  #ifdef CONFIG_COMPACTION
> >> -extern int sysctl_compact_memory;
> >>  extern unsigned int sysctl_compaction_proactiveness;  extern int
> >> sysctl_compaction_handler(struct ctl_table *table, int write,
> >>                         void *buffer, size_t *length, loff_t *ppos);
> >> diff --git a/kernel/sysctl.c b/kernel/sysctl.c index c9fbdd8..66aff21
> >> 100644
> >> --- a/kernel/sysctl.c
> >> +++ b/kernel/sysctl.c
> >> @@ -198,6 +198,7 @@ static int max_sched_tunable_scaling =3D
> >> SCHED_TUNABLESCALING_END-1;  #ifdef CONFIG_COMPACTION  static int
> >> min_extfrag_threshold;  static int max_extfrag_threshold =3D 1000;
> >> +static int sysctl_compact_memory;
> >>  #endif
> >>
> >>  #endif /* CONFIG_SYSCTL */
> >> diff --git a/mm/compaction.c b/mm/compaction.c index
> 190ccda..ede2886
> >> 100644
> >> --- a/mm/compaction.c
> >> +++ b/mm/compaction.c
> >> @@ -2650,9 +2650,6 @@ static void compact_nodes(void)
> >>                 compact_node(nid);
> >>  }
> >>
> >> -/* The written value is actually unused, all memory is compacted */
> >> -int sysctl_compact_memory;
> >> -
> >
> >
> > Please retain this comment for the tunable.
>=20
> Sorry, I could not understand.
> You mean to say just retain this last comment and only remove the
> variable ?
> Again any real benefit you see in retaining this even if its not used?
>=20
>=20

You are just moving declaration of sysctl_compact_memory from compaction.c
to sysctl.c. So, I wanted the comment "... all memory is compacted" to be r=
etained
with the sysctl variable. Since you are now getting rid of this variable co=
mpletely,
this comment goes away too.

Thanks,
Nitin

