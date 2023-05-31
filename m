Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D07717D38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 12:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjEaKbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 06:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjEaKbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 06:31:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818B2B3;
        Wed, 31 May 2023 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685529072; x=1717065072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TbLlLql41FrmzjRhdQIsGzUapaL4W4ZQnuR7RNW1/80=;
  b=kXvn3XFm9122Nlx2d5oAkdSX8sX+GxcpqfXJ/ILKAuidhlimCgOr4wmX
   Frny27WV2xZma2v6sHZCbbwIesJ8Raaz6Qyenir96ovC4roxFT9SG1cSk
   IrSTZAnU8x6EyXjZ0CK9JQFJ2pnd+IbBawfHymjjZgCdxSnqhWwEPGfR9
   h9l0D+H/PG+opTMmXD+qF7mgtFSpvElTiR7bV40vY1SRbDS0wB7y+lmOI
   swe5CHHknJAUVTvEd6LjyxQz1iJ2E2qeRaYZowXVzEjFumYfx1OuhhFxj
   TybIwNuXCnourYoUZZewIkPd7mXi5IMi1yZ5l2E3wUyM9bMSf08/pSwXQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="355204680"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="355204680"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 03:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="736618489"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="736618489"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2023 03:31:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 03:31:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 03:31:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 03:31:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 03:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzecxzlqW1yuQ4FlOWs4G7BXgIMbnbix2UgJ38I4jZ7kXRCU96YD5gJVj9G2sXaVShVMdYBHaFfNPvH/+kjCUsmZb1Bbq0BFLZKWpy/KS7JcZfa2HODp/ftegvUVvPNI8r/cTVSeCRgaAeR3NTnkT94SYlOvSPJoRj/3JJ73WNMcGr2Cd8CoP8HnekMkquRTccRTRJBl1OU+gRrafPXaZa7rKvGLj6qv1aVsMP2bDlbTEEhFqkxxkSAcGk94a7+TuUuHmHAjgZR76nx4ThZ+3HOlnBsp/AQSTvqc7ag2+0awmfuAJQ5o4pg/LEDIrR7PKuccB/zr2OzPac+RxOyhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GRouIvN9s65iDAT4w1WZnSZpctKiJ20UhrYItyw72U=;
 b=PD/9pE2uZ5cM+fwX4TL3tThf51WU4QWsCbY3gEwFIo61uAkmF1r3l5FZgFAI8NPPEseuRmJxkMQog4CNooxcFaxuBuFmb1pJ77ZloAHqMTAv4KNzJDViRdV6V0BLFLW+Hcm7/cS+0y402gQiEFMYcxpOOSuU0sg+7JYEuQ05XxfErx4szvGsEPzObQJ5O6DfCjbN9ebZ3qqWe1rWXE97oTWqY7oAI1ZmltnYvC2NFWn9n/+5+wWpT9MhGukXw3yD0qBmXupKyhBOGxKg2YjClG8924wsPTGHFBj1pnS4zXBM0vGtEJu+Y/DysJzNpfmOQktcSeVuWKzlTFfCDD4Pzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23)
 by PH8PR11MB7117.namprd11.prod.outlook.com (2603:10b6:510:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 10:31:09 +0000
Received: from CO1PR11MB4931.namprd11.prod.outlook.com
 ([fe80::e0d:8516:eb9f:f932]) by CO1PR11MB4931.namprd11.prod.outlook.com
 ([fe80::e0d:8516:eb9f:f932%3]) with mapi id 15.20.6433.020; Wed, 31 May 2023
 10:31:09 +0000
From:   "Chen, Zhiyin" <zhiyin.chen@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zou, Nanhai" <nanhai.zou@intel.com>,
        "Feng, Xiaotian" <xiaotian.feng@intel.com>
Subject: RE: [PATCH] fs.h: Optimize file struct to prevent false sharing
Thread-Topic: [PATCH] fs.h: Optimize file struct to prevent false sharing
Thread-Index: AQHZkptsjNDfJ+8hD0ijYnqkdkJlwK9ygmoAgAEeaoCAAFkcQA==
Date:   Wed, 31 May 2023 10:31:09 +0000
Message-ID: <CO1PR11MB4931D767C5277A37F24C824DE4489@CO1PR11MB4931.namprd11.prod.outlook.com>
References: <20230530020626.186192-1-zhiyin.chen@intel.com>
 <20230530-wortbruch-extra-88399a74392e@brauner>
 <20230531015549.GA1648@quark.localdomain>
In-Reply-To: <20230531015549.GA1648@quark.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4931:EE_|PH8PR11MB7117:EE_
x-ms-office365-filtering-correlation-id: c3a25801-4084-4fa6-a7d0-08db61c22604
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1p4ahJTF7GfxbGoD6EvJRYrsr7Gr2/Lnk+aZecApQJ5YQEUF4o/82mY4ZOFmCo6HnXXOKhWpcvE/+ye6bBVDuE2LIqut8IEQF5Vq9W4l9+U7QAAytWz7ZVj8drMMcdqL3L3FRiw1YO0/V3b43Hazs0ARqz3HomTgu7fA1/6Li0ZoycyH7MalrWvUyfrFSjHeFQY3GXrA9e8LWMPBmAUyp6sV9sQqogNvmdntKDEUmj+uISBezigSR03M4QCj6MyzGmrLf3q/3Se7IukVtVWSiQd9eSEMbp2rYj7nWRRmQWcPWCJbQtAImC5/VgC4bY/YrlISNzni3i0kN8CrHnzoOAzNS0sg9LtjUvxVd4vEX5wwzfS/d95qWaej4NokJ3yQ48sa+aulDOoISAWScoKHBBNwt+PCpRm1kOUwUvUXIThwcOBtRfn8W5GIHkldSFu0KczM/jtNliNYwGnF7/0orWoYkrbInrokAkDPrf518BTnedFATy+WRX9R+Tjv4HtCOcFgrW3Ss9V+2HHiCASlOzSIjl5BLstPG87Uck3dWcewJx3AmrRdrE4RX+kAwBv1ozMEc9MlwseUCH/ZjxhdyVppogLAfiNu09ZNBBvW4SNYS/5KbQrnmCTG0x9zkn0q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4931.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(83380400001)(2906002)(33656002)(86362001)(38070700005)(122000001)(38100700002)(82960400001)(55016003)(8936002)(8676002)(107886003)(5660300002)(4326008)(52536014)(316002)(71200400001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(7696005)(6506007)(26005)(186003)(9686003)(54906003)(53546011)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?imNCKa8RsL3neU0em0FxHYvWDJTu8dXP/OoQazrRkiFVQpSUBLZWseRo6Ky7?=
 =?us-ascii?Q?KSU8Cqs72Egm1NP6W8AG5LVcol+TYS67a4SUzf7xVeo8M4jcN9TyMnNnRkm2?=
 =?us-ascii?Q?iY6gaEZl3B0uYT13ZseyebfImbSV4WWfjphjwIRKh5wDzUPGb6emDahuVF/x?=
 =?us-ascii?Q?rtgpbZuY4w1gSIK2wETP5mQpmUQzgo22czMAhY1SBfSpu5GRbnupv3EE3SyH?=
 =?us-ascii?Q?s4rXrS5qmby8HsLjWop7njAKunJWchSNvqxBZfy+/VKu3MEvPgyKnqX1Uj/0?=
 =?us-ascii?Q?oqJ81RuRgZQaxQdxNtezki4fflWnuBkBTvzE5ymSvlkcBA32UnOnfvivvXzc?=
 =?us-ascii?Q?h6q2GO7pfrYlMAgjFCvDySievuuZ0qPHVvzW90xHkxvwCEMJikDGL8duhDsN?=
 =?us-ascii?Q?6+VYm2gBAQOfl/3nFrLEDjOq56I3D1p6ush0+xBMuS51+3CDa7cqB9u7Egyb?=
 =?us-ascii?Q?/B1vKBZkb39oUPzg4OPkwAtDinOIKcgY1xc75HG1KtCvg4RpFI6IWFB4HLgJ?=
 =?us-ascii?Q?VLpW/u2UoQ8PaK8+fSmVAb6MiWqn+rwJY/HF8LWgUfB3fThvAcZZO4z85c9A?=
 =?us-ascii?Q?3NKk4I/T47K/KJxZovsiYjpZIDa44Wx4tOv1fE8Zopa/tvmZfnm3tNqFzuIw?=
 =?us-ascii?Q?uq4VSzj4xEmozEzG1zD03W+o7uMKTJ1TSIoziD/frFvaz5lX/GufvwWYS27O?=
 =?us-ascii?Q?Upk7YUX7V4owyShBQKaeiIvklgTheWjjHsLwYrW1rM0rFNA6nkQ55ZtnesMa?=
 =?us-ascii?Q?im/r166XYVwv3KnZHCtowDV84iF6/qoeTIFXdmgtqaeWqOqhefbw3Nu4dSQF?=
 =?us-ascii?Q?4EYkzag+IaK9VkbY4DSVrBQP09PRtVpIcEsBlXOIUgem/lPF+jiYFNzKqaVD?=
 =?us-ascii?Q?YRI6fQ9vbJIHV2S/4L7el6FM2gxS+J9p3m15ZkjfMg6gClcNWfNQ8qhWwzg0?=
 =?us-ascii?Q?lYn14BFqr6yXHmL1QnXm7G7cw7Hx3t5yTSaVGe43q2C6JGakBPdqJWOUZZZC?=
 =?us-ascii?Q?52ULHLQfqtXDHSWtifWa7oelgXbzxrR//2YMA2x4rlv1lmjm/QLQB0twxmQB?=
 =?us-ascii?Q?XEF5NrvhppPZX38QKrBBdC6JNJWPus8JZWeDvypoI/CHvTi0SiveWdMA+Ozf?=
 =?us-ascii?Q?kncFEkLhasSN+KotcfnD1g7mnNwUfqxZPFOyoBqUL2lY7GHFW3xwAIrzjKIy?=
 =?us-ascii?Q?LgEkvr13cwpt22mcxIh0IA2jtbFJuvognDHqhWfjXgJyrfCwkVybR8JGAN7G?=
 =?us-ascii?Q?CiGHLrLKd/C9GfPlOyo2PIJimFy79LRJKI2jJdlXRl/DSl1AGV1SlarIY7Hh?=
 =?us-ascii?Q?feI6lRXcouHU13gB3/LqBSFMBJHuW3poZ6VqhGGcXgcEVkbDCem0kNEAHyXl?=
 =?us-ascii?Q?WX5MtuiFo86zdm1PJyd7n/6s4ijEHk2q6UE6u8MsEPZBuCI8FyRWRFCfT0tv?=
 =?us-ascii?Q?0BcLZrW/ZaGNa2tWYSRdWII9SQkeEXuO5tSfisgri/unTLjJo/Xozc4ebWnX?=
 =?us-ascii?Q?YzUfce9jHkREJsR39X4XRc83IUQ6jTs+xOJathCyLlWo3HVf/lRD8ZcA5u3/?=
 =?us-ascii?Q?gmyKFTW/R/0EtdEefojPfC/yFp3Bb79GmB6UDhdt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4931.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a25801-4084-4fa6-a7d0-08db61c22604
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 10:31:09.1958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQo4uRrV5nah2UZkom/STGV2ZWkKzqgWc266zXKQ2+1LaaeIji0FOXh+gC4/hymZnbvY2yDtUPh+7owATLbDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7117
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Eric said, CONFIG_RANDSTRUCT_NONE is set in the default config=20
and some production environments, including Ali Cloud. Therefore, it=20
is worthful to optimize the file struct layout.

Here are the syscall test results of unixbench.

Command: numactl -C 3-18 ./Run -c 16 syscall

Without patch
------------------------
224 CPUs in system; running 16 parallel copies of tests
System Call Overhead                        5611223.7 lps   (10.0 s, 7 samp=
les)
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    5611223.7   3740.8
                                                                   =3D=3D=
=3D=3D=3D=3D=3D=3D
System Benchmarks Index Score (Partial Only)                         3740.8

With patch
------------------------------------------------------------------------
224 CPUs in system; running 16 parallel copies of tests
System Call Overhead                        7567076.6 lps   (10.0 s, 7 samp=
les)
System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    7567076.6   5044.7
                                                                   =3D=3D=
=3D=3D=3D=3D=3D=3D
System Benchmarks Index Score (Partial Only)                         5044.7

> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Wednesday, May 31, 2023 9:56 AM
> To: Christian Brauner <brauner@kernel.org>
> Cc: Chen, Zhiyin <zhiyin.chen@intel.com>; viro@zeniv.linux.org.uk; linux-
> fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
>=20
> On Tue, May 30, 2023 at 10:50:42AM +0200, Christian Brauner wrote:
> > On Mon, May 29, 2023 at 10:06:26PM -0400, chenzhiyin wrote:
> > > In the syscall test of UnixBench, performance regression occurred
> > > due to false sharing.
> > >
> > > The lock and atomic members, including file::f_lock, file::f_count
> > > and file::f_pos_lock are highly contended and frequently updated in
> > > the high-concurrency test scenarios. perf c2c indentified one
> > > affected read access, file::f_op.
> > > To prevent false sharing, the layout of file struct is changed as
> > > following
> > > (A) f_lock, f_count and f_pos_lock are put together to share the
> > > same cache line.
> > > (B) The read mostly members, including f_path, f_inode, f_op are put
> > > into a separate cache line.
> > > (C) f_mode is put together with f_count, since they are used
> > > frequently at the same time.
> > >
> > > The optimization has been validated in the syscall test of
> > > UnixBench. performance gain is 30~50%, when the number of parallel
> > > jobs is 16.
> > >
> > > Signed-off-by: chenzhiyin <zhiyin.chen@intel.com>
> > > ---
> >
> > Sounds interesting, but can we see the actual numbers, please?
> > So struct file is marked with __randomize_layout which seems to make
> > this whole reordering pointless or at least only useful if the
> > structure randomization Kconfig is turned off. Is there any precedence
> > to optimizing structures that are marked as randomizable?
>=20
> Most people don't use CONFIG_RANDSTRUCT.  So it's still worth optimizing
> struct layouts for everyone else.
>=20
> - Eric
