Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08362719A16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 12:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjFAKsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 06:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjFAKsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:48:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB849D;
        Thu,  1 Jun 2023 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685616483; x=1717152483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8lQ/Ah9P8y3eBrsNtfuy0o/pnnoyx47OcG81eo8OWas=;
  b=O0VHT0Q9Gy2uVx/XZptIjuKdKXbi5wnTiZLdP+H8P4+YIP9BnOsgOQrL
   QRod/FhNIemgTdLvK8LA7benQ3HuEQm5e6WCzwpG0nEUa9VLTKb2XOyqI
   2LRbss/STJ2UuCHzAnAXE+PZeGjkBUXP0ax81/vElCDm3HskqfNBLkoyt
   ZIJcZ11WJJml0jZ5FlcCHnrF0Lb4mq4cqYTbBuvkZrB3h6sTzDd1smrwB
   7mcpd0zD2t9KbCWxzSw4lvdygipYKKkgiFRZQ2rjN0Q/mLVR40aZoGAjK
   /OiYdPsPku1Cc+q//H0p3O+RM7hHTmTJgTs9DasDM+Dj+uN0wrYzIn6F8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="353018852"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="353018852"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 03:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="701496452"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="701496452"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 01 Jun 2023 03:48:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 03:48:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 03:48:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 03:48:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 03:48:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMti9FqYbzo5bhzwQRrzKqS2l5ajH4dRCAhEpqh94sai+PvyXwCM6K2EQ5fcaGEktyETFhIr8GSiiLrIc8dldeksurQqxP695WRXQB8+A+pWZ5jtlLkxDfVYgOeS6Rcp8zK5+lWfhQ4/2KfFl4QLbpUPUZ+cW9uYjr+0u9FseAVxnJaaKB+5UKU1ojtMUJ+ZJ/E27BG9q8JPV7cyylklJhRJzBvaTIfhb2CmdkCK8jWbwIULMpErK2Nm6P11pP273SgqOCjaBBKnmEKlnekZQDnJD7VTk4amBotveZXcvQ8m6wO2Hccr7K1WhbyjVm6iSpDNStTzDqDJ+2TyFUl+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jALweXIs+LwWQH/ki6MiJTi5zN/mXyy9QA5yx4qKBw=;
 b=GNfmg923ApCXD4qY9bQy2SweAP+uYJriZQO9x9R3BCS+nIbl1tOTBFc2KYFyxtN+AvTjZe1kMMGwHnFmfOlYMoFFAooHZ4ApyFZ9i5HID5DWSxfcklKcY9gqMrqG5GKez9WDBptvGFc5tJlynVCEHClYsl6JhVBmId5g0Kajif/mh+/2mwbA6ZETk5uNrhrRdmxmLoQXcgCxu6tVR6yDsg/mFEJMxtoI7bM4nxexUs56WqV/smZeR92cC8kK8///r3yU9Z2YEi6FmDOUsDupVGxwKi7D+/5Tmx7CGQWksWzReopZszZx+/1LLC9Z8nWOYAKf8DMBmq4pum5VDSmORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23)
 by SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 10:47:53 +0000
Received: from CO1PR11MB4931.namprd11.prod.outlook.com
 ([fe80::1765:4b41:1b87:4e4]) by CO1PR11MB4931.namprd11.prod.outlook.com
 ([fe80::1765:4b41:1b87:4e4%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 10:47:53 +0000
From:   "Chen, Zhiyin" <zhiyin.chen@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zou, Nanhai" <nanhai.zou@intel.com>,
        "Feng, Xiaotian" <xiaotian.feng@intel.com>
Subject: RE: [PATCH] fs.h: Optimize file struct to prevent false sharing
Thread-Topic: [PATCH] fs.h: Optimize file struct to prevent false sharing
Thread-Index: AQHZkptsjNDfJ+8hD0ijYnqkdkJlwK9ygmoAgAEeaoCAAFkcQIAA//EAgAC35MA=
Date:   Thu, 1 Jun 2023 10:47:53 +0000
Message-ID: <CO1PR11MB49317EB3364DB47F1FF6839FE4499@CO1PR11MB4931.namprd11.prod.outlook.com>
References: <20230530020626.186192-1-zhiyin.chen@intel.com>
 <20230530-wortbruch-extra-88399a74392e@brauner>
 <20230531015549.GA1648@quark.localdomain>
 <CO1PR11MB4931D767C5277A37F24C824DE4489@CO1PR11MB4931.namprd11.prod.outlook.com>
 <ZHfKmG5RtgrMb6OT@dread.disaster.area>
In-Reply-To: <ZHfKmG5RtgrMb6OT@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4931:EE_|SA2PR11MB5002:EE_
x-ms-office365-filtering-correlation-id: bc3e549a-649c-48ac-8d01-08db628da6da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ao02gOycTOlypj9Ne/n+yzFeZ7n5fuBXwuJ+BFBJyNeOSS3LUVQ983tdyyDex6wgSrfkwVgSOX8BDketIaQ/ECYieaTh/otD2cGIEE4Ke6kOVRbZMulAlm8lRI+w2iLu59MCNFrn8QjggH17zCHaufPQH9O+RyOIRO/q+yblp4fApIje8eKNWxD2co0LJwp36KWZAdYLT5IbAyillkcWDAHi2Mw01la7yNDejIv9brumUQUhKwQych5wXUV7gnCRaYkprJ7BgHKEnW9gtZGpfipB0/cNqYpV1kHWWOG/s4ZCR/Q4PMbIKkTVpF2P/+UvMxtg7XNosvMHXHtKK72fyGCHVF7iSkt/8nQ6yBEfmWUW+pFTT2r7darxMZGH62HpVb5+4tkXHGRm7BX12RbEUSCuJUKR89+tc+3gh0ZIdalyAnTpuKHccIvzDKtMzmY4AHFF9H31QXNkUcuoaeifnMXK0Faf12m+myoCuEAT9MyIjr8JS2UeyQWFOnZBF0x5FqvSrPKqz6LQIyy0vBLCwmz3fMAkkXM3GAOGGT5xlllm7ZStdjR7D/nf2sJQk9coQGSnlPvC3XE7ohgwsQkp3YEyMfQpksTEri9RFvXlbROaBymx3cOSoBAgSArwRIrj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4931.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(122000001)(82960400001)(38100700002)(86362001)(38070700005)(33656002)(8676002)(41300700001)(52536014)(55016003)(107886003)(9686003)(6506007)(53546011)(5660300002)(8936002)(186003)(83380400001)(316002)(66946007)(66476007)(66556008)(71200400001)(7696005)(66446008)(54906003)(478600001)(76116006)(4326008)(64756008)(6916009)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kuv2lClu32TQzM7wkAkyRETKpFAalxtpdD1/KfyVzto2W2OULQV0m1O1mWFu?=
 =?us-ascii?Q?JeoZXA5RB7UX7cOcfK9s9tguUHarm1rSkdTezsUrrAkiaXzcssbKsPMhrUuZ?=
 =?us-ascii?Q?Y/LybiIAuN/EkqaBJIpE//6gd7Pp+Utc+be0/NIKtv2ORKEa7T6zhKndccq0?=
 =?us-ascii?Q?DHLfB0OR1v3tTin18/LSvVjvVj+uPTTWtmx8eD9Ca7qQVhOAhP0jVGcQZwa6?=
 =?us-ascii?Q?JzGNbNbp57Tolk2Db5UD2hb6X5Ov6CtKg50q2hYVmDoSWG//WZJH/Xwnx1pk?=
 =?us-ascii?Q?V2UqQxYP11RkxxUkPcr4JKy+iyihAXDzska1ghl68QBvtdQXqcY3OzIvkJ7F?=
 =?us-ascii?Q?42uhXgkrZf/ZWPs4kwFGeOFtjZe8Hp9E7BfeKlZIFCh2iuRROsUMdMfpah2A?=
 =?us-ascii?Q?n9xNz8j6mZc3uHKqmPTaiwKb/hPH1RFNC+fbblOkB0jp6wSF+fQAdcw44scK?=
 =?us-ascii?Q?tYwKgdg3hLH1rTOXYv4gDLLHjLV5M92BfSWNEeNxRqOwtxS/WpB012L48zcZ?=
 =?us-ascii?Q?tPHxnzLauTa+CkguWqRYHz9GMHzEOORyAz+BrePRdCjbMh8xzaCGmkkIkFTi?=
 =?us-ascii?Q?++JgCh+9K+NgpNmdqjFJw8hpSLvfx39lALzy0BDGhWC2SHEwwah6hk4gLfSR?=
 =?us-ascii?Q?ai8QutPD21EFcWyhYkktoBkepPf7gRiSqdFPCj9mwaELWA2K2V+hBn97Ma2W?=
 =?us-ascii?Q?zZYM9T0FuYjaMZ1+jSCOX55Cqu4Luyy9aDn/wI/tm16Zj2LVDu28+mdMYpNz?=
 =?us-ascii?Q?F5pV+gXXjwiAfqErxfz9EQAKGnlmYpm7Suy29NXm7Ca77CScK1ryogFMskxw?=
 =?us-ascii?Q?Z7YP0ifsubSFRr2WXalYc2bw0rRdq06Qe5xwRHxUMgg5HoZfD9SyfMq011rk?=
 =?us-ascii?Q?d0NnUiQhWe/+cFSAmDidwLgfpThVgxWWgpASCdBxcDnPaMVDtUCx8xt2Dbkz?=
 =?us-ascii?Q?n5QspBRs8FZRm0lYJZyFQ9IdVCMit49tWiLDOcsFdPi+pcBPRIMutf2LI16y?=
 =?us-ascii?Q?z9YC6yoWOZZKYMa5tHp2bVINhFJm5J7qnGtgfN2nrIn/qQAR5/k3+eSWRF56?=
 =?us-ascii?Q?buniyK3Z7DI7bVY+CmG/OCsxlbIEuUUPOVbUprNXqsOTPu0IGtIyNeB1mYSB?=
 =?us-ascii?Q?5MYu/Wp13PbLrAa+25CvfKYcbcSDQ6S/MqoZ1XyMPf0/c/4DjWrZasRD4mZG?=
 =?us-ascii?Q?bvlZCrSGsABSZ/jTXV13wff3cEEgAwxQe3c71y+AlL09Ij3Z4YlhOGZebeMn?=
 =?us-ascii?Q?RA3lRpbMujXQrdGhODFA26Ty4qwygXSP3sIZcLNBkR7js67JlD+imQYNznl3?=
 =?us-ascii?Q?4H89BSRZ1/+QkOIcO/S6SXNEvbkZGXxmUz7dvvpoAswq33T79drYlK9AgiIs?=
 =?us-ascii?Q?Cdhqsr0AOKq52HFTfgCBDfh5yr6CEY8S7AFET7W6EDwvS1bRoeUhvFXsHKLA?=
 =?us-ascii?Q?CO7PM81IP8Z5/sFm3otBtfbZoinxzjwH6rYMtARVCpn1OfYD5mDgudpte6e0?=
 =?us-ascii?Q?yTpPE0mr5iy5dff7HfgXVjbz3GIQA3gefaqMS6+yuJPpXQ4TCVaWUrIiDUmh?=
 =?us-ascii?Q?mmbu9jWxPS83UDKSixI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4931.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3e549a-649c-48ac-8d01-08db628da6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 10:47:53.1814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCcwFBVmBQnTVsz0ouq1BlYSr0vJio4an8ujbwKPvB6lNrS4ZgFf64zURuwc0X2NKMKQLB7I+rxKeC5WHpQkhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Good questions.
perf has been applied to analyze the performance. In the syscall test, the =
patch can=20
reduce the CPU cycles for filp_close. Besides, the HITM count is also reduc=
ed from=20
43182 to 33146.
The test is not restricted to a set of adjacent cores. The numactl command =
is only=20
used to limit the number of processing cores. In most situations, only 8/16=
/32 CPU=20
cores are used. Performance improvement is still obvious, even if non-adjac=
ent=20
CPU cores are used.

No matter what CPU type, cache size, or architecture, false sharing is alwa=
ys=20
negative on performance. And the read mostly members should be put together=
.

To further prove the updated layout effectiveness on some other codes path,=
=20
results of fsdisk, fsbuffer, and fstime are also shown in the new commit me=
ssage.=20

Actually, the new layout can only reduce false sharing in high-contention s=
ituations.=20
The performance gain is not obvious, if there are some other bottlenecks. F=
or=20
instance, if the cores are spread across multiple sockets, memory access ma=
y be=20
the new bottleneck due to NUMA.

Here are the results across NUMA nodes. The patch has no negative effect on=
 the
performance result.

Command:  numactl -C 0-3,16-19,63-66,72-75 ./Run -c 16 syscall fstime fsdis=
k fsbuffer
With Patch
Benchmark Run: Thu Jun 01 2023 03:13:52 - 03:23:15
224 CPUs in system; running 16 parallel copies of tests

File Copy 1024 bufsize 2000 maxblocks        589958.6 KBps  (30.0 s, 2 samp=
les)
File Copy 256 bufsize 500 maxblocks          148779.2 KBps  (30.0 s, 2 samp=
les)
File Copy 4096 bufsize 8000 maxblocks       1968023.8 KBps  (30.0 s, 2 samp=
les)
System Call Overhead                        5804316.1 lps   (10.0 s, 7 samp=
les)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
File Copy 1024 bufsize 2000 maxblocks          3960.0     589958.6   1489.8
File Copy 256 bufsize 500 maxblocks            1655.0     148779.2    899.0
File Copy 4096 bufsize 8000 maxblocks          5800.0    1968023.8   3393.1
System Call Overhead                          15000.0    5804316.1   3869.5
                                                                   =3D=3D=
=3D=3D=3D=3D=3D=3D
System Benchmarks Index Score (Partial Only)                         2047.8

Without Patch
Benchmark Run: Thu Jun 01 2023 02:11:45 - 02:21:08
224 CPUs in system; running 16 parallel copies of tests

File Copy 1024 bufsize 2000 maxblocks        571829.9 KBps  (30.0 s, 2 samp=
les)
File Copy 256 bufsize 500 maxblocks          147693.8 KBps  (30.0 s, 2 samp=
les)
File Copy 4096 bufsize 8000 maxblocks       1938854.5 KBps  (30.0 s, 2 samp=
les)
System Call Overhead                        5791936.3 lps   (10.0 s, 7 samp=
les)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
File Copy 1024 bufsize 2000 maxblocks          3960.0     571829.9   1444.0
File Copy 256 bufsize 500 maxblocks            1655.0     147693.8    892.4
File Copy 4096 bufsize 8000 maxblocks          5800.0    1938854.5   3342.9
System Call Overhead                          15000.0    5791936.3   3861.3
                                                                   =3D=3D=
=3D=3D=3D=3D=3D=3D
System Benchmarks Index Score (Partial Only)                         2019.5

> -----Original Message-----
> From: Dave Chinner <david@fromorbit.com>
> Sent: Thursday, June 1, 2023 6:31 AM
> To: Chen, Zhiyin <zhiyin.chen@intel.com>
> Cc: Eric Biggers <ebiggers@kernel.org>; Christian Brauner
> <brauner@kernel.org>; viro@zeniv.linux.org.uk; linux-
> fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; Zou, Nanhai
> <nanhai.zou@intel.com>; Feng, Xiaotian <xiaotian.feng@intel.com>
> Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
>=20
> On Wed, May 31, 2023 at 10:31:09AM +0000, Chen, Zhiyin wrote:
> > As Eric said, CONFIG_RANDSTRUCT_NONE is set in the default config and
> > some production environments, including Ali Cloud. Therefore, it is
> > worthful to optimize the file struct layout.
> >
> > Here are the syscall test results of unixbench.
>=20
> Results look good, but the devil is in the detail....
>=20
> > Command: numactl -C 3-18 ./Run -c 16 syscall
>=20
> So the test is restricted to a set of adjacent cores within a single CPU =
socket,
> so all the cachelines are typically being shared within a single socket's=
 CPU
> caches. IOWs, the fact there are 224 CPUs in the machine is largely irrel=
evant
> for this microbenchmark.
>=20
> i.e. is this a microbenchmark that is going faster simply because the wor=
king
> set for the specific benchmark now fits in L2 or L3 cache when it didn't =
before?
>=20
> Does this same result occur for different CPUs types, cache sizes and
> architectures? What about when the cores used by the benchmark are
> spread across mulitple sockets so the cost of remote cacheline access is =
taken
> into account? If this is actually a real benefit, then we should see simi=
lar or
> even larger gains between CPU cores that are further apart because the co=
st
> of false cacheline sharing are higher in those systems....
>=20
> > Without patch
> > ------------------------
> > 224 CPUs in system; running 16 parallel copies of tests
> > System Call Overhead                        5611223.7 lps   (10.0 s, 7 =
samples)
> > System Benchmarks Partial Index              BASELINE       RESULT    I=
NDEX
> > System Call Overhead                          15000.0    5611223.7   37=
40.8
> >                                                                    =3D=
=3D=3D=3D=3D=3D=3D=3D
> > System Benchmarks Index Score (Partial Only)                         37=
40.8
> >
> > With patch
> > ----------------------------------------------------------------------
> > --
> > 224 CPUs in system; running 16 parallel copies of tests
> > System Call Overhead                        7567076.6 lps   (10.0 s, 7 =
samples)
> > System Benchmarks Partial Index              BASELINE       RESULT    I=
NDEX
> > System Call Overhead                          15000.0    7567076.6   50=
44.7
> >                                                                    =3D=
=3D=3D=3D=3D=3D=3D=3D
> > System Benchmarks Index Score (Partial Only)                         50=
44.7
>=20
> Where is all this CPU time being saved? Do you have a profile showing wha=
t
> functions in the kernel are running far more efficiently now?
>=20
> Yes, the results look good, but if all this change is doing is micro-opti=
mising a
> single code path, it's much less impressive and far more likley that it h=
as no
> impact on real-world performance...
>=20
> More information, please!
>=20
> -Dave.
>=20
> --
> Dave Chinner
> david@fromorbit.com
