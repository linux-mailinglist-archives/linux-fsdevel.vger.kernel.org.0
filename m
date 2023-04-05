Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BD36D7382
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 06:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbjDEEtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 00:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjDEEtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:49:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E7B2D56;
        Tue,  4 Apr 2023 21:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680670129; x=1712206129;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8mATAK9EhaS/nrNe3oUaFBitpJCEeFXy/Lk4in6HNbI=;
  b=ZhND4FeqADIK6li5l7R8xFfX+QCLlZxBdOkR5fiUU6zWXzFM/Dqn711a
   I6WwvqUXEJPRGdqScGbI2vebrddDZd9yRvBAtlPVuFF0s6bZADrUMZUHe
   45gOUo+0xGZWSMul+MbXSL7CoJUYizhvt9YpZosgGvRkERP0shw1ZzcRv
   c+4bNa78tuILg88E7s77l1RMTqwKWCuUe5EoaWC8+wqrK7THyaSqNLP6f
   rOW0h+Iw78Ja436CLz99P2gG3NcXy4032aynSVGduQRzzO55ByVWb6jf6
   VvFXm+Zfy7QwpP0HDQkFGqAWEAy2YAXFsND3clO49iEVvbWWJapsHaWfL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="342387963"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="342387963"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 21:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="751140557"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="751140557"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2023 21:48:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 21:48:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 21:48:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 21:48:48 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 21:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh4g1w69Bu5qslHx184NOnpfYAOA5jgrhiiRE9j8kgtGDFj/aeAWcRWX5n9hD7a72A8cxLJ9MEq/HNONzr76ZRwebELs2iKuFemjszT+Zj7Nfn9eonGmEcRiC4VG47t8Y8NbH0puqCbgi8bhNDp9030HVogE6EgGXSdD+RoEhEO66v/rOQbkIcEEmZ70HvHqQ//XQ/Qi2z8fz6CBpQ946XKVKwRCWUk1WAGzOMKdwgvnfMMPYNbDUneKKmvqrTPmmpTRXi18o5k1K2KvruLF+rypuK07e+dpCD4JrPIXyWN7iqw3NlGdFi7csqqf6Ltr8CvJlc5MKvgDyh415J8xZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwmOWgEwi58/07fjMr6/t5oFQtlNeCFHJY4HiTboSYg=;
 b=Y0H53QJFFKqfCLowwks8HbD6kRlXngRRaJnBuGHrtaVG3oab5oxlOV0kYC+Q3yYAszHDKUZvUSDIm7zouLFSNKwRan3UpsdT92ARLx3LFK72i4UPSMrLNYcK2dU/dXNgao/1UUVpOuzu98zOfTtkpVuBhDTgmAbod43sbbZ78sPNC2vmDlAbGuAZytMBcgqeA+3hVqvwt6nIooqyIbHPhf7rtgIYxi1Zml945pnlSknS/epV9EfQxJW++p1atRNoSXyA9AdyUdeI0vGdnKC8z1GQBCaP7VXepU5T6HtQ5RNBG1kH3/GBAvbsrdrBr6IZywAk+napgkweRHSbvUJG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5124.namprd11.prod.outlook.com (2603:10b6:303:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42; Wed, 5 Apr
 2023 04:48:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 04:48:44 +0000
Date:   Tue, 4 Apr 2023 21:48:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>, <willy@infradead.org>
CC:     <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <a.manzanares@samsung.com>, <viacheslav.dubeyko@bytedance.com>,
        <dan.j.williams@intel.com>, <seungjun.ha@samsung.com>,
        <wj28.lee@samsung.com>
Subject: RE: Re: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes
 for CXL
Message-ID: <642cfda9ccd64_21a8294fd@dwillia2-xfh.jf.intel.com.notmuch>
References: <ZCbX6+x1xJ0tnwLw@casper.infradead.org>
 <CGME20230405020027epcas2p4682d43446a493385b60c39a1dbbf07d6@epcas2p4.samsung.com>
 <20230405020027.413578-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230405020027.413578-1-ks0204.kim@samsung.com>
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1477eb-d6ad-4224-4e06-08db3591092c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klCXymfn89PhV+CO5plnaAWtVYsTmfK+EhceFOvPATL+H9fT/7xLhN0BltsS9Oow9wYLVFbwRINpBzRho3xjwpBqWKscKlydDwtiqmJVSCwLQl5ji0FUSKcxnnYnu4j3LaZ9ioObObSZirPNTEo0iX5BoZFWv7Jp6HS78E5/aafFYlA+//sUDCYD87KcKb1xpr2LDlryzPRPRZffeiOSNESCDiS2ujzP+/LACTvNPgJ7OZrHcnMFxsB3JKpjdx7r2F4NdxV9rF74QuqZkYl+EcRYnwomn//bcz5UsUEfuXJG8tz6ysYtx2Wl32se3KGwTCHKNFnaKGqyaQYyttqpeiCExlVzrmGn4vEooMQMuslHRUyS1E9STLfOfgiPF0MutcRyYmzUoOVFBFsSpbGk0JBp2Bn3FZY3iXcZ8ttbS7nwgExlXm/wrTCeCfFDxFD13teAaKXE4Hn7iiyfyVHmj/xbv6ECDYbZcHHiLshZP4Tl4NzOcR01/fxQLLT7Hi6LO3ljA5S0JeaKFVzMORAQV5Lnlwt6JgsxfNC+Z+ONT+UXCr1MaV1SOAWUKB7COWI6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(316002)(4326008)(8676002)(66476007)(66556008)(66946007)(6486002)(8936002)(41300700001)(478600001)(6666004)(7416002)(2906002)(5660300002)(82960400001)(86362001)(38100700002)(6506007)(83380400001)(6512007)(9686003)(186003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyC5k4aob4p7OE7SyXK6j1o2iBpEQvKM22S7ae6knP5qPMDCmPCfXBd3WNrj?=
 =?us-ascii?Q?ekYVT5fyisupqumB75ezDeOE8kh+bR6MoVxY3LGQG8B00bdn5u9Fie7VRv3b?=
 =?us-ascii?Q?GgsV29tehrBv/5LLZHSzS+toe6UMk9tKQDCTCJYx2/T/m/zlKztr3Skv3FXQ?=
 =?us-ascii?Q?LF0idnb3eKpi4Hcxk2aes7hVNnLF4dWLl0j4iwb51pnS3ZmW4w3ZV03L4C1q?=
 =?us-ascii?Q?Hf/BWEBp2kcJeH9gTbFGaZ/YY4uuFIZGjcKkNbCD929sDQflyYntE9XeZrGm?=
 =?us-ascii?Q?xmCiOFOLudaNxUT3CnaIK49ByJG/oT64tKTKwsSzNfNvNtYZ/QUHWWEWZM+4?=
 =?us-ascii?Q?a0alys3xiRln74pqiNT59aj4q/seS3c529OxYGE4/Dc4/+8dKNwbAUiB0OBt?=
 =?us-ascii?Q?Nu5XiwCCJ2Otv2VTWawH5V9jTs12ShNQRuRkG17J+c3xkfKLYkfO1Apa6sAv?=
 =?us-ascii?Q?4s5sTu1xISGwI2h9+KkdcDNe3OJw2+bfMz22bPqBzn6ksjDfCd+YQOWy9mui?=
 =?us-ascii?Q?eKqIjrjrKG7i2I4v5rymPSY5kaav75KJEBx9I9dqpGvx/EYoQ0UGzXO1YjNx?=
 =?us-ascii?Q?vXhlFZ8+LYCLQXY+gFoffUtM3Aa8Wop593DgbnzHFmrRYRLAcHwmsshf4tsi?=
 =?us-ascii?Q?3RJj+9Q+j/+cbMT05o8ZuGB8T/Zi4Xc8AT3MxzHku3v8+M9taNjR2j7pOP6C?=
 =?us-ascii?Q?/5TIxKOBAfMGHcHbu6TFSQs7o2KBBEDNEuCZxKa9hjkSKvz4WoDD7UU8NdEg?=
 =?us-ascii?Q?cbhJkmktKUZ+SgeWQehwmN1r81AyoagOB+rlITotO/bB7Gh/pYZOI6cl1Vfs?=
 =?us-ascii?Q?QzxF1iZ4HGQflrMoxd5EmEW9ZUuo9UDgP218p5LoQVei8kJw3NT/n0rohJkG?=
 =?us-ascii?Q?yxHXnWyRv3Z4ITDwsbDuo8fG8jRZhOWr+pRxaiTB7SeRGXTPrrVnKEGX3luO?=
 =?us-ascii?Q?k5bQjIFve6G4IRVhbbEH4TW7lWXz1Pvi0sNc5gFMqwj1vjyDdUbdVnn1ia2C?=
 =?us-ascii?Q?y1Syb+erUODnbY4qZwuCYUGSFYDJs4Rap6TlMy67vVDGB1+CSZJnlq2ZENXT?=
 =?us-ascii?Q?H8a59g/Pl88ZRkqvSAX6YEVuQ3ItD2zKFoWp/FFecSSsJ1JSZVm3NdEfbO52?=
 =?us-ascii?Q?NGYn8DbFtnJKWvrcp25GW5ueUgsd1xUKsJgk7ekl5ZuR1bKfeMS9Zp7tkdpo?=
 =?us-ascii?Q?QcisJsqHBoM39hAscXY7HC9uAoQVL/a7ki1WAxIBkvVYe4XJBWM6yJo0WNPb?=
 =?us-ascii?Q?9NfrgpWhZeA1mi27AV+3k79gEhi1FclPjME4870C/C8T/IDQ9VHKWBPUyJXB?=
 =?us-ascii?Q?rtsvr8yJQcY4LgYPzlAX7A0ibXVcrsNdof2WU6nKUGpyYvvpn/z9LVOZ8PGE?=
 =?us-ascii?Q?gp7jS+K0kH6bCPsdapZUNVEkERuQmmmVsveO22D2dwSrw968XJEfxJMHD7dJ?=
 =?us-ascii?Q?sONwI8HOEmVU2YCgmRgTWqaAUBCaFgPMcrCoXfe7oNX2BlsdtG9X2sCRNKrJ?=
 =?us-ascii?Q?/vm2wFoLCQnlAUp9XmXRqUAspVPooH2kjfHpIq2glY8DthWsiuo0XUIphmPe?=
 =?us-ascii?Q?68tP6E/uKeHM00wB4wc0+3aJI7SpBZptUQhtSVi8Ljri3TH3q53uFpmtcTwn?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1477eb-d6ad-4224-4e06-08db3591092c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 04:48:44.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tK7d4tOAzE0t63hWOZMaUbh8vmUu0PVrgZt62u/9FelmTM7P7TEz+qHJnGyjaE2YAVTMme/CoXb/IQeI0c8bI73iX9nGr6CW6yXR7xThljE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kyungsan Kim wrote:
> >On Fri, Mar 31, 2023 at 08:37:15PM +0900, Kyungsan Kim wrote:
> >> >> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
> >> >
> >> >This sounds dangerously confused.  Do you want the EXMEM to be removable
> >> >or not?  If you do, then allocations from it have to be movable.  If
> >> >you don't, why go to all this trouble?
> >> 
> >> I'm sorry to make you confused. We will try more to clearly explain our thought.
> >> We think the CXL DRAM device should be removable along with HW pluggable nature.
> >> For MM point of view, we think a page of CXL DRAM can be both movable and unmovable. 
> >> An user or kernel context should be able to determine it. Thus, we think dedication on the ZONE_NORMAL or the ZONE_MOVABLE is not enough.
> >
> >No, this is not the right approach.  If CXL is to be hot-pluggable,
> >then all CXL allocations must be movable.  If even one allocation on a
> >device is not movable, then the device cannot be removed.  ZONE_EXMEM
> >feels like a solution in search of a problem
> 
> We know the situation. When a CXL DRAM channel is located under ZONE_NORMAL,
> a random allocation of a kernel object by calling kmalloc() siblings makes the entire CXL DRAM unremovable.
> Also, not all kernel objects can be allocated from ZONE_MOVABLE.
> 
> ZONE_EXMEM does not confine a movability attribute(movable or unmovable), rather it allows a calling context can decide it.
> In that aspect, it is the same with ZONE_NORMAL but ZONE_EXMEM works for extended memory device.
> It does not mean ZONE_EXMEM support both movability and kernel object allocation at the same time.
> In case multiple CXL DRAM channels are connected, we think a memory consumer possibly dedicate a channel for movable or unmovable purpose.
> 

I want to clarify that I expect the number of people doing physical CXL
hotplug of whole devices to be small compared to dynamic capacity
devices (DCD). DCD is a new feature of the CXL 3.0 specification where a
device maps 1 or more thinly provisioned memory regions that have
individual extents get populated and depopulated by a fabric manager.

In that scenario there is a semantic where the fabric manager hands out
100G to a host and asks for it back, it is within the protocol that the
host can say "I can give 97GB back now, come back and ask again if you
need that last 3GB".

In other words even pinned pages in ZONE_MOVABLE are not fatal to the
flow. Alternatively, if a deployment needs 100% guarantees that the host
will return all the memory it was assigned when asked there is always
the option to keep that memory out of the page allocator and just access
it via a device. That's the role device-dax plays for "dedicated" memory
that needs to be set aside from kernel allocations.

This is to say something like ZONE_PREFER_MOVABLE semantics can be
handled within the DCD protocol, where 100% unpluggability is not
necessary and 97% is good enough.
