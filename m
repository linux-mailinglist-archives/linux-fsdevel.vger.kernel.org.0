Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5537271FFE2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjFBLCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjFBLCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:02:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CFDC0;
        Fri,  2 Jun 2023 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685703734; x=1717239734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x5TK1Q7B4VvTYfbihXXWsk0nSOb0dSVKG3MNQQMWcb8=;
  b=AYuIcQphQawHqS4fnnjfw8K4O1Sy7fdU9q9nv8Tup9Ca2x/IajeaowSS
   LqtBNcus96VbXaT+NUf2lxXDv7dgahWDY97fVvOpYjL+zl2AkJYkBTgR7
   nBfegWdYgdMGqWg0bxx7eEkvHnETvinVRkc/9YW3nym13/9fqVNx+YBf1
   Yq5fK47jRaf7Aw0Nqy4oUD6+Y10g86mJna8hwtD2KlckcgI6yFzmXHPBk
   Y/DQSiqTHZNOiakhxFnAsH7+Ftaarw8U9ePvGH921vefaXivjLS60LoDo
   3NS3LqwvWChsaZ1vF5xeD60TO3fO2L0OcXvFi5gW7NUL6pWMTAZ6EY+PE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="354690997"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="354690997"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="737495240"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="737495240"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2023 04:01:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 04:01:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 04:01:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 04:01:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 04:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZQ6X94hPf1ut2pZz3VCpZzRhDA16nx/8mHTYr4fujrNA8MMZxnReLL42vwgng5d3h5FP/ebvZb6hypo/h+G2tczsrqhDFVnqFzv47lTKCQCbxKqn3vntSgvxhNLTwyFi2dcYfdxKE0g6VytsoKHS4+THD8t9M9qiF6VeGl5NqNEO0hBgEEofn8fU5U32Tm+Bfy3iT8XyE5x1o1w9798FwY/xjWignX/ypkHFCTlGeTxbOUybqFRYf70Lu6yX9NOhci1wnojieaZSnaKADXiJV0CZ2IlScE8R4oNxZ2TvRFhM2rTNfJ9psPB8CSihmK8y1+vjBlLnAfNgsNJsFDNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTcHJtp6LKNtNnm69u1sy82T2OOxwvO4LYZCVTyOCAg=;
 b=I9MzkwOV8M5UUNJ8k0E8psTdEfDQMEWGLsNGcK3jS70ctFrXktx0/oHqw0mL88PNmyqeZCouqS3pNcGczHWTxoVKX7/SMmO28xx9dIFZeP5E8CLQDjkq9hPT+hBV2fzgL6Q2xT19mUs7buglu/1a/ldKDMphvg+mEU7K4Vl+fafdRInKdoIUpVDx6m/ZOqMmJ2kt7RCRNxemF3S9WPyNf9Yn5tTLZyE7XHl7/diiWU9kL/kDuyFkPVbHlCxVQUbTWYyEJsT0f/CAlVnFcGxCG259i3RJZKZ1WETFNjQ/ppTGs55y36Czr86EGuzOJhAfiZ9XuVCrC6YZu7Jt7AavBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26; Fri, 2 Jun
 2023 11:01:53 +0000
Received: from CO1PR11MB4931.namprd11.prod.outlook.com
 ([fe80::1765:4b41:1b87:4e4]) by CO1PR11MB4931.namprd11.prod.outlook.com
 ([fe80::1765:4b41:1b87:4e4%4]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 11:01:53 +0000
From:   "Chen, Zhiyin" <zhiyin.chen@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Christian Brauner <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zou, Nanhai" <nanhai.zou@intel.com>,
        "Feng, Xiaotian" <xiaotian.feng@intel.com>
Subject: RE: [PATCH] fs.h: Optimize file struct to prevent false sharing
Thread-Topic: [PATCH] fs.h: Optimize file struct to prevent false sharing
Thread-Index: AQHZkptsjNDfJ+8hD0ijYnqkdkJlwK9ygmoAgAEeaoCAAFkcQIAA//EAgAC35MCAAQCKAIAAcmKQ
Date:   Fri, 2 Jun 2023 11:01:53 +0000
Message-ID: <CO1PR11MB4931E6E751831DB311D7F42AE44EA@CO1PR11MB4931.namprd11.prod.outlook.com>
References: <20230530020626.186192-1-zhiyin.chen@intel.com>
 <20230530-wortbruch-extra-88399a74392e@brauner>
 <20230531015549.GA1648@quark.localdomain>
 <CO1PR11MB4931D767C5277A37F24C824DE4489@CO1PR11MB4931.namprd11.prod.outlook.com>
 <ZHfKmG5RtgrMb6OT@dread.disaster.area>
 <CO1PR11MB49317EB3364DB47F1FF6839FE4499@CO1PR11MB4931.namprd11.prod.outlook.com>
 <ZHk8Dmvr1hl/o6+a@dread.disaster.area>
In-Reply-To: <ZHk8Dmvr1hl/o6+a@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4931:EE_|DM6PR11MB4627:EE_
x-ms-office365-filtering-correlation-id: a5266c19-dbdd-4c56-f0be-08db6358c61c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yCEWvzUWjorn3ZaIGrKk0xk3wl6ttqWc9l8GmlYqrcTjIlFMJMHdOdwx2g5J8NQk6HmGOzSa2omcUnp5oQrGOffuqdz15fFmipuDCl9IQT9vKrPA2ONmxtTtu5xB8cLQJ8EOp89ucSUctJVF0Twc0OWD6teFsymPL92K9BVu6Ag3nah6LyoS12gJCxvzzlYM2f4ThS1Db98yPyrWaY8ef2zibYRecNnZ/0FDODGjd9yfaforYrRUMcOxYRIySsDy16ru6SJ3dBiXPVWmNhnlrD4Z8AOoj78QRy62scqS99OtqjZkyWCA3ufPiq6X7lNrWig62MTm51nWvDfqwHl1bHW6FBtfMW9gYcXhOc1UEebtdsxeEgCejUMwWRpTT3/uBbkBi+WpBw3ZlNFWTvNSBA+9r34fTE4xTtR5VRmkMWRLnSwqcaVylf+7nANTP+ChMpmr6ZbhE3B7pN6tEBhh0LdtWiw1SHpq/lRBOTLastUARipvWaX3Jty6qtaszLO3ippeQVr7l9DSWQOBF/tqBkFcwpPYxVCQd6wgApP0ZkwVH+H3zY2KLiUT9yMe0Tn2hSDhhYec5vacVs1Vaz0MqTkNxsgpKmpzRp9bra92W2CF8VHUzQk5yRdUUwvikezI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4931.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(86362001)(5660300002)(38070700005)(52536014)(8936002)(30864003)(2906002)(64756008)(38100700002)(316002)(4326008)(6916009)(82960400001)(122000001)(66446008)(66946007)(76116006)(66556008)(66476007)(8676002)(54906003)(33656002)(478600001)(71200400001)(41300700001)(107886003)(6506007)(9686003)(186003)(83380400001)(55016003)(7696005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pzEHVkSr/iyOGpj0JzdEozKhBVVauwO926Dpw3wqZJWhFsUWmdqFacPIFklA?=
 =?us-ascii?Q?E+9XD5Bmk5y1TSS8T1f5lWcDiUxs/+Na8ttTCwnpmPmuuVLhJS8q5OrjFYuE?=
 =?us-ascii?Q?HCeAEg80gJv6KrBLC9JvfayJdkVdDfLjoXNUb4gqkoUQNwqO3vhiwJnth0tp?=
 =?us-ascii?Q?32gRSyOTvTxBQzyCj5wsoMxdqduQCYPBJkz+KZh/ZmB5fTymi9BPNafJiCRn?=
 =?us-ascii?Q?cEdcMCpOsKmxrRZYPkA5N3ekk8q9VlTgzNDEdjg1oIHNm9cXcL6AMgJp00NI?=
 =?us-ascii?Q?C6DI4LJ8BQksRnWRufld2b11lIWVURPg4J5a0TBkhhlVFP4WQ0SqPg07vjTt?=
 =?us-ascii?Q?8Ig7g4AGoiQNU6diz8HtgctPh+R3rGMN9/YPaSy258DkDlQ9f5fHDjDfRvNA?=
 =?us-ascii?Q?UuZ2J/Kv38Npas05KVHvKX2fGsNI4QNUsbJj0KcZ70JZLGwESJNGtI7KwjSS?=
 =?us-ascii?Q?2FGnTKrxcC1U4dkLoiaGwEiYErewKBh1lO1aO/JRLQBOXz7FfKijXa1nzEj0?=
 =?us-ascii?Q?GAYWGZx7u/idCgZFq+VD4tX94EbjrA1ZObb5H7YegvMyg34mRu1giNmUhmYA?=
 =?us-ascii?Q?nvK+ZbeWSj1pUof5QXsAdqFQCKmsHIUT+q2vp9ikW0DgB0o7Q6hhm1NXw4oB?=
 =?us-ascii?Q?CTRDt7HSjhNAgNaGRp5E7aqO8FjcWFcRs97h0ViQse8XGtM+V/lokQz4Bj4M?=
 =?us-ascii?Q?Nr9CuWIWD/LLh38j61mbYoDmYmzk/IpxHVAiAH9LBlcmDY3xPGRKbVn9rYHq?=
 =?us-ascii?Q?embez+UZ2ly9KoNzHgUWRpb1SSdQM2R9URS7EWAEGAHhy10VLjnjRnhOov7A?=
 =?us-ascii?Q?aOgN95wXJcJmW5Ka+hlMiO+lLQrmwW45tQ172sjnycT54q0pYWtae2VqKK+c?=
 =?us-ascii?Q?K92sgAjh3FBvs5O84JGIQb4XRGqBjMRgsLfrf3R8hh0S9xY0fBsMgUA/leyJ?=
 =?us-ascii?Q?8hJXdreY3aeoshVF6c7kGYJQsu2oNQokxkTOBJW+37hCiuh3QHJypA0b6psq?=
 =?us-ascii?Q?teEnhIebquIiWgC1inAH1bvuX5zDKXO52/QqSK3rk3buhtZpoSoPR4f66sDj?=
 =?us-ascii?Q?xgiCHD7cpp06RMrIyrMMB+addCyBmSOVeYe0QUrzZZbpOr936+Q480MaxS+M?=
 =?us-ascii?Q?hsUZvWAHQwsHwdqkep1X+NMcJPh/6OHIVFxM2Bo70MCh9iHFuuGAErWz/N/T?=
 =?us-ascii?Q?fVCIxABdF224n5N4rZ7sgyqvE86esBqlsOZ2ukVr7cI/rP4MmurYRNy4yxcA?=
 =?us-ascii?Q?lDfuBEodHGpeNX9cV2DHeu8mHQ0bpc87nABaMBlpzFR1GD7zfqM+21YWM5BU?=
 =?us-ascii?Q?i2aCWNMiVQsU1HrZ2pJgsn9ysouQpv+H/1A/3dYXIx46ar5oHFzf6zpBN+vG?=
 =?us-ascii?Q?Ggwj0Y1PjXLv/BQJiqBtjKVRnCrrgTegIAgKJ6Qp8AyOWqFP+LJ1ZM/XI400?=
 =?us-ascii?Q?mivGoaYwW25J938Va4fT6EG8FwFFobO6fygOLiF/q8knEvFHtqUwC13UHC/h?=
 =?us-ascii?Q?91txVBbnuGL9yP6b3JTD01H0hVL51i0S63e69tuJ9kIZFB2ePnHWyItNXVe8?=
 =?us-ascii?Q?GVOEprgBecxNpk4un7syjHXejCfjJH5dj5qkyN+x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4931.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5266c19-dbdd-4c56-f0be-08db6358c61c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 11:01:53.4764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6kd4iX51GHftwQGnXGfCpDRiupe/yEeCVxwVueETJWcAeOrDR2DfJuB4bYqOUgZEZ7ybaqD9TZgsxtUPOOgHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
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

> > Good questions.
> > perf has been applied to analyze the performance. In the syscall test,
> > the patch can reduce the CPU cycles for filp_close. Besides, the HITM
> > count is also reduced from
> > 43182 to 33146.
> > The test is not restricted to a set of adjacent cores. The numactl
> > command is only used to limit the number of processing cores.
>=20
> And, in doing so, it limits the physical locality of the cores being used=
 to 3-18.
> That effectively puts them all on the socket because the test is not usin=
g all
> 16 CPUs and the scheduler tends to put all related tasks on the same sock=
et if
> there are enoguh idle CPUs to do so....
>=20
> > In most situations, only 8/16/32 CPU
> > cores are used. Performance improvement is still obvious, even if
> > non-adjacent CPU cores are used.
> >
> > No matter what CPU type, cache size, or architecture, false sharing is
> > always negative on performance. And the read mostly members should be
> put together.
> >
> > To further prove the updated layout effectiveness on some other codes
> > path, results of fsdisk, fsbuffer, and fstime are also shown in the new
> commit message.
> >
> > Actually, the new layout can only reduce false sharing in high-contenti=
on
> situations.
> > The performance gain is not obvious, if there are some other
> > bottlenecks. For instance, if the cores are spread across multiple
> > sockets, memory access may be the new bottleneck due to NUMA.
> >
> > Here are the results across NUMA nodes. The patch has no negative
> > effect on the performance result.
> >
> > Command:  numactl -C 0-3,16-19,63-66,72-75 ./Run -c 16 syscall fstime
> > fsdisk fsbuffer With Patch Benchmark Run: Thu Jun 01 2023 03:13:52 -
> > 03:23:15
> > 224 CPUs in system; running 16 parallel copies of tests
> >
> > File Copy 1024 bufsize 2000 maxblocks        589958.6 KBps  (30.0 s, 2 =
samples)
> > File Copy 256 bufsize 500 maxblocks          148779.2 KBps  (30.0 s, 2 =
samples)
> > File Copy 4096 bufsize 8000 maxblocks       1968023.8 KBps  (30.0 s, 2 =
samples)
> > System Call Overhead                        5804316.1 lps   (10.0 s, 7 =
samples)
>=20
> Ok, so very small data buffers and file sizes which means the working set=
 of
> the benchmark is almost certainly going to be CPU cache resident.
>=20
> This is a known problem with old IO benchmarks on modern CPUs - the data
> set is small enough that it often fits mostly in the CPU cache and so sma=
ll
> variations in code layout can make 20-30% difference in performance for f=
ile
> copy benchmarks. Use a different compiler, or even a different filesystem=
,
> and the amazing gain goes away and may even result in a regression....
>=20
> For example, this has been a known problem with IOZone for at least
> 15 years now, making it largely unreliable as a benchmarking tool.
> Unless, of course, you know exactly what you are doing and can avoid all =
the
> tests that are susceptible to CPU cache residency variations....
>=20
> > System Benchmarks Partial Index              BASELINE       RESULT    I=
NDEX
> > File Copy 1024 bufsize 2000 maxblocks          3960.0     589958.6   14=
89.8
> > File Copy 256 bufsize 500 maxblocks            1655.0     148779.2    8=
99.0
> > File Copy 4096 bufsize 8000 maxblocks          5800.0    1968023.8   33=
93.1
> > System Call Overhead                          15000.0    5804316.1   38=
69.5
> >                                                                    =3D=
=3D=3D=3D=3D=3D=3D=3D
> > System Benchmarks Index Score (Partial Only)                         20=
47.8
> >
> > Without Patch
> > Benchmark Run: Thu Jun 01 2023 02:11:45 - 02:21:08
> > 224 CPUs in system; running 16 parallel copies of tests
> >
> > File Copy 1024 bufsize 2000 maxblocks        571829.9 KBps  (30.0 s, 2 =
samples)
> > File Copy 256 bufsize 500 maxblocks          147693.8 KBps  (30.0 s, 2 =
samples)
> > File Copy 4096 bufsize 8000 maxblocks       1938854.5 KBps  (30.0 s, 2 =
samples)
> > System Call Overhead                        5791936.3 lps   (10.0 s, 7 =
samples)
> >
> > System Benchmarks Partial Index              BASELINE       RESULT    I=
NDEX
> > File Copy 1024 bufsize 2000 maxblocks          3960.0     571829.9   14=
44.0
> > File Copy 256 bufsize 500 maxblocks            1655.0     147693.8    8=
92.4
> > File Copy 4096 bufsize 8000 maxblocks          5800.0    1938854.5   33=
42.9
> > System Call Overhead                          15000.0    5791936.3   38=
61.3
> >                                                                    =3D=
=3D=3D=3D=3D=3D=3D=3D
> > System Benchmarks Index Score (Partial Only)                         20=
19.5
>=20
> Yeah, that's what I thought we'd see. i.e. as soon as we go off-socket, t=
here's
> no actual performance change. This generally means there is no difference=
 in
> cacheline sharing across CPUs between the two tests. You can likely use `=
perf
> stat` to confirm this from the hardware l1/l2/llc data cache miss counter=
s; I'd
> guess they are nearly identical with/without the patch.
>=20
> If this truly was a false cacheline sharing situation, the cross-socket t=
est
> results should measurably increase in perofrmance as the frequently
> accessed read-only data cacheline is shared across all CPU caches instead=
 of
> being bounced exclusively between CPUs.
> The amount of l1/l2/llc data cache misses during the workload should redu=
ce
> measurably if this is happening.
>=20
> As a technical note, if you want to split data out into different cacheli=
nes, you
> should be using annotations like '____cacheline_aligned_in_smp' to align
> structures and variables inside structures to the start of a new cachelin=
e. Not
> only is this self documenting, it will pad the structure appropriately to=
 ensure
> that the update-heavy variable(s) you want isolated to a new cacheline ar=
e
> actually on a separate cacheline.  It may be that the manual cacheline
> separation isn't quite good enough to show improvement on multi-socket
> machines, so improving the layout via explicit alignment directives may s=
how
> further improvement.
>=20
> FYI, here's an example of how avoiding false sharing should improve
> performance when we go off-socket. Here's a comparison of the same 16-
> way workload, one on a 2x8p dual socket machine (machine A), the other
> running on a single 16p CPU core (machine B). The workload used 99% of al=
l
> available CPU doing bulk file removal.
>=20
> commit b0dff466c00975a3e3ec97e6b0266bfd3e4805d6
> Author: Dave Chinner <mailto:dchinner@redhat.com>
> Date:   Wed May 20 13:17:11 2020 -0700
>=20
>     xfs: separate read-only variables in struct xfs_mount
>=20
>     Seeing massive cpu usage from xfs_agino_range() on one machine;
>     instruction level profiles look similar to another machine running
>     the same workload, only one machine is consuming 10x as much CPU as
>     the other and going much slower. The only real difference between
>     the two machines is core count per socket. Both are running
>     identical 16p/16GB virtual machine configurations
>=20
>     Machine A:
>=20
>       25.83%  [k] xfs_agino_range
>       12.68%  [k] __xfs_dir3_data_check
>        6.95%  [k] xfs_verify_ino
>        6.78%  [k] xfs_dir2_data_entry_tag_p
>        3.56%  [k] xfs_buf_find
>        2.31%  [k] xfs_verify_dir_ino
>        2.02%  [k] xfs_dabuf_map.constprop.0
>        1.65%  [k] xfs_ag_block_count
>=20
>     And takes around 13 minutes to remove 50 million inodes.
>=20
>     Machine B:
>=20
>       13.90%  [k] __pv_queued_spin_lock_slowpath
>        3.76%  [k] do_raw_spin_lock
>        2.83%  [k] xfs_dir3_leaf_check_int
>        2.75%  [k] xfs_agino_range
>        2.51%  [k] __raw_callee_save___pv_queued_spin_unlock
>        2.18%  [k] __xfs_dir3_data_check
>        2.02%  [k] xfs_log_commit_cil
>=20
>     And takes around 5m30s to remove 50 million inodes.
>=20
>     Suspect is cacheline contention on m_sectbb_log which is used in one
>     of the macros in xfs_agino_range. This is a read-only variable but
>     shares a cacheline with m_active_trans which is a global atomic that
>     gets bounced all around the machine.
>=20
>     The workload is trying to run hundreds of thousands of transactions
>     per second and hence cacheline contention will be occurring on this
>     atomic counter. Hence xfs_agino_range() is likely just be an
>     innocent bystander as the cache coherency protocol fights over the
>     cacheline between CPU cores and sockets.
>=20
>     On machine A, this rearrangement of the struct xfs_mount
>     results in the profile changing to:
>=20
>        9.77%  [kernel]  [k] xfs_agino_range
>        6.27%  [kernel]  [k] __xfs_dir3_data_check
>        5.31%  [kernel]  [k] __pv_queued_spin_lock_slowpath
>        4.54%  [kernel]  [k] xfs_buf_find
>        3.79%  [kernel]  [k] do_raw_spin_lock
>        3.39%  [kernel]  [k] xfs_verify_ino
>        2.73%  [kernel]  [k] __raw_callee_save___pv_queued_spin_unlock
>=20
>     Vastly less CPU usage in xfs_agino_range(), but still 3x the amount
>     of machine B and still runs substantially slower than it should.
>=20
>     Current rm -rf of 50 million files:
>=20
>                     vanilla         patched
>     machine A       13m20s          6m42s
>     machine B       5m30s           5m02s
>=20
>     It's an improvement, hence indicating that separation and further
>     optimisation of read-only global filesystem data is worthwhile, but
>     it clearly isn't the underlying issue causing this specific
>     performance degradation.
>=20
>     Signed-off-by: Dave Chinner <mailto:dchinner@redhat.com>
>     Reviewed-by: Christoph Hellwig <mailto:hch@lst.de>
>     Reviewed-by: Darrick J. Wong <mailto:darrick.wong@oracle.com>
>     Signed-off-by: Darrick J. Wong <mailto:darrick.wong@oracle.com>
>=20
> Notice how much of an improvement occurred on the 2x8p system vs a
> single 16p core when the false sharing was removed? The 16p core showed
> ~10% reduction in CPU time, whilst the 2x8p showed a 50% reduction in CPU
> time. That's the sort of gains I'd expect if false sharing was an issue f=
or this
> workload. The lack of multi-socket performance improvement tends to
> indicate that false sharing is not occurring and that something else has
> resulted in the single socket performance increases....
>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> mailto:david@fromorbit.com


Thanks for your questions and comments.

Certainly, both data buffers and file sizes are very small in UnixBench. Th=
e file copy=20
test results are only shown to prove that the patch has no negative effect =
on the=20
IO performance or some other codes path. In the real world, different perfo=
rmance
 problems have different bottlenecks and need different corresponding solut=
ions.=20
Here, this patch can only reduce false sharing in high-contention situation=
s where=20
different threads and processes handle the same file. Therefore, there is n=
o obvious=20
performance improvement if the bottleneck is something else. However, a rea=
sonable=20
layout of file struct is still necessary.

As it is known well, '____cacheline_aligned_in_smp' can be used to separate=
 data into=20
different cache lines. However, the size of the corresponding struct also b=
ecomes larger=20
which could cause more memory costs and performance regression in some othe=
r cases.=20
Therefore, in this patch, the file struct is only re-layouted carefully.=20
To deep dive into the performance, perf c2c is used instead of perf stat. B=
ecause the count=20
of HITM (Hit Modification) can help to identify the problem of false sharin=
g. The perf c2c=20
results are attached as plain text.

With the analysis of the perf c2c result.=20
(1) In all of the four cases, more than 99% HITM is caused by the same addr=
ess,  which is the=20
file operator actually.=20
(2) Compare the results between running on single NUMA node and running on =
multi NUMA=20
nodes. Both load remote HITM and load remote DRAM increase much more, which=
 caused=20
performance regression. In UnixBench, the syscall test run less iterations =
in specific
 duration (10s) when it is running across numa nodes and the HITM is also l=
ess even if the
 same kernel is used.=20
(3) Compare the results between kernel with patch and kernel without patch.=
  The number=20
of HITM is decreased, no matter the test is running on single NUMA node or =
multiple NUMA=20
nodes.

Above all, this patch can reduce false sharing caused by file struct in hig=
h-contention situation.=20
However, if the false sharing is not the bottleneck (i.e. when running on m=
ultiple NUMA nodes,=20
remote DRAM access may be the new bottleneck), this patch cannot bring obvi=
ous=20
performance improvement.

If any else performance data should be shown, please feel free to let me kn=
ow. Cheers.

(a.1) Single Numa Node
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
            Trace Event Information
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Total records                     :   12591573
  Locked Load/Store Operations      :     371850
  Load Operations                   :     594693
  Loads - uncacheable               :          0
  Loads - IO                        :          0
  Loads - Miss                      :          0
  Loads - no mapping                :          0
  Load Fill Buffer Hit              :     136631
  Load L1D hit                      :     346615
  Load L2D hit                      :        113
  Load LLC hit                      :     111273
  Load Local HITM                   :      86212
  Load Remote HITM                  :         16
  Load Remote HIT                   :          0
  Load Local DRAM                   :         16
  Load Remote DRAM                  :         45
  Load MESI State Exclusive         :         45
  Load MESI State Shared            :         16
  Load LLC Misses                   :         77
  Load access blocked by data       :        320
  Load access blocked by address    :     359024
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
           Shared Data Cache Line Table
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#
#        ----------- Cacheline ---------------      Tot  ------- Load Hitm =
-------    Total   =20
# Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHi=
tm =20
# .....  ..................  ....  ......  .......  .......  .......  .....=
..  .......  .......  .......  ....... =20
#
      0  0xff2dfd8dfd4cd200     1   86964   99.80%    86058    86058       =
 0  =20

(a.2) Multi Numa Node
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
            Trace Event Information
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Total records                     :   12168050
  Locked Load/Store Operations      :     293778
  Load Operations                   :     422976
  Loads - uncacheable               :          2
  Loads - IO                        :          0
  Loads - Miss                      :          0
  Loads - no mapping                :          0
  Load Fill Buffer Hit              :      99324
  Load L1D hit                      :     248307
  Load L2D hit                      :        130
  Load LLC hit                      :      58779
  Load Local HITM                   :      48665
  Load Remote HITM                  :      13471
  Load Remote HIT                   :          0
  Load Local DRAM                   :       2658
  Load Remote DRAM                  :      13776
  Load MESI State Exclusive         :      13776
  Load MESI State Shared            :       2658
  Load LLC Misses                   :      29905
  Load access blocked by data       :        373
  Load access blocked by address    :     258037
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
           Shared Data Cache Line Table
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#
#        ----------- Cacheline ---------------      Tot  ------- Load Hitm =
-------   =20
# Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHi=
tm =20
# .....  ..................  ....  ......  .......  .......  .......  .....=
..  .......  .......  .......  ....... =20
#
      0  0xff2dfd8dfd4cd200     1   59737   99.43%    61780    48409    133=
71  =20

(b) Without Patch
(b.1) Single Numa Node
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
            Trace Event Information
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Total records                     :   12919299
  Locked Load/Store Operations      :     373015
  Load Operations                   :     764465
  Loads - uncacheable               :          0
  Loads - IO                        :          0
  Loads - Miss                      :          0
  Loads - no mapping                :          0
  Load Fill Buffer Hit              :     269056
  Load L1D hit                      :     395309
  Load L2D hit                      :         75
  Load LLC hit                      :     100013
  Load Local HITM                   :      95001
  Load Remote HITM                  :          3
  Load Remote HIT                   :          0
  Load Local DRAM                   :          7
  Load Remote DRAM                  :          5
  Load MESI State Exclusive         :          5
  Load MESI State Shared            :          7
  Load LLC Misses                   :         15
  Load access blocked by data       :        335
  Load access blocked by address    :     545957
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
           Shared Data Cache Line Table
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#
#        ----------- Cacheline ---------------      Tot  ------- Load Hitm =
-------   =20
# Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHi=
tm =20
# .....  ..................  ....  ......  .......  .......  .......  .....=
..  .......  .......  .......  ....... =20
#
      0  0xff33448e58b68400     0  220190   99.79%    94801    94801       =
 0  =20

(b.2) Multi Numa Node
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
            Trace Event Information
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Total records                     :   12409259
  Locked Load/Store Operations      :     325557
  Load Operations                   :     625900
  Loads - uncacheable               :          0
  Loads - IO                        :          0
  Loads - Miss                      :         18
  Loads - no mapping                :          0
  Load Fill Buffer Hit              :     219323
  Load L1D hit                      :     324152
  Load L2D hit                      :         87
  Load LLC hit                      :      64345
  Load Local HITM                   :      61334
  Load Remote HITM                  :      16979
  Load Remote HIT                   :          0
  Load Local DRAM                   :        756
  Load Remote DRAM                  :      17219
  Load MESI State Exclusive         :      17219
  Load MESI State Shared            :        756
  Load LLC Misses                   :      34954
  Load access blocked by data       :        387
  Load access blocked by address    :     443196
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
           Shared Data Cache Line Table
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#
#        ----------- Cacheline ---------------      Tot  ------- Load Hitm =
-------   =20
# Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHi=
tm =20
# .....  ..................  ....  ......  .......  .......  .......  .....=
..  .......  .......  .......  ....... =20
#
      0  0xff33448e58b68400     0  190537   99.71%    78088    61176    169=
12  =20

Best Regards
Zhiyin
