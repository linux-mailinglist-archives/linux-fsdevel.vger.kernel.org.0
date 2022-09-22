Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411F65E5898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 04:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIVCeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 22:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIVCeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:34:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151DC25DE;
        Wed, 21 Sep 2022 19:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663814074; x=1695350074;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3fIG5ydaadME2hNf7MrwHBuy5Bc162NLt6KuvuaOJnk=;
  b=XTRpQJ4yDwv8up5MoPsE8pm/Kd9/skz3zH9KlOvWv7Vx2TsaJFsZLWKv
   irbnMIANudhtUV1D5/6Oz4TLsJFc032y7KAGX7TnDkoMA1zlmW4c5d81C
   uF1pfzPr+lNrJIHTtR6St7gCNY0UaGXLYJBo83gTEbYbCZ987/ULDPmhD
   7q2kpQsJuWcXbNRjNmoOLJXRusDL+5U3JXWNv8Dy1xiJabsc/b1Yo5Ma+
   8PnJ/p3GkBDNCURWRKBswSVUjFjKJR/6vuXhau/yIy85A6v8IOv47jsDC
   WxjtnyIivi0QKsIUdc+SBK4qIJtSAzEbH30etNXGdi1EUYechAfHGClVK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="301021360"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="301021360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 19:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762004338"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2022 19:34:32 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 19:34:33 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 19:34:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 19:34:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 19:34:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEhcJNitFtdFddckLM1X4OTIqrQ1jRY0bSbfSZNJLqQBVAafSiOAePopuMA0RMlMb6k1Ge0IzK8RHzYHE8p6ZbsyHwusH8rm5vXDkj9roynq3+W8XK/Mxe+GKq8N8iqQ/hkjDkT/xzhuFLf5e0Cy1zEMO3w370SCu0uJT/voHEUZ2EHor9gEKIFJIQhVs8w40ahLG9yDidOMBjR8rioN0iHzvPsrrjXtZLgf/ZV2ZzOjBkqK9AzlZmWf4ACYLNXzaMtwcvWXEEWys/JVmO+RWX87idYCE0nG0hecpBo6sGYsn6CGToqhRwrD9jEoRlY3Bu1YBUpaYUbOK4YZlxlhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A+ui7vRAbklnLzN/47mUtV9QEWE7k3vt4vmvAb24EA=;
 b=DPLUJAHaCzSUrToyLNVxOe08Hv17BP0NuJ1sAOYkWYbKS7uNgBe82J/Aw5ulJ3UeIGOUdbkYpDINv6106RBZ64V7dg4xp75tSSvjBDUuL7ZK5sI5/tKYGfUkX3iQyk10wjYRVRwSTarUgbxjuRI5i+IItTVG3Slw3Y66JwC90/QYUW2S3WI4oaT2Bvuzy5eNtOPWthRdJy5AZ2jbfP1DvJ2NwDwt80jsMOEl7pn67dTWl1kOCQjl4AuLykQzABdWOtLOZUDy0iJv/CDDFVId3J6lyYtrkgLhnyW4oOBXsx54N5MqlvNzBLNhFucTZRlZl2uDS+AuUjmb72VUNv0HAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH0PR11MB5474.namprd11.prod.outlook.com
 (2603:10b6:610:d5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 02:34:24 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 02:34:24 +0000
Date:   Wed, 21 Sep 2022 19:34:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, <akpm@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages
 to a zero reference count
Message-ID: <632bc9acdbad1_349629435@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
 <YyssywF6HmZrfqhD@nvidia.com>
 <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
 <Yyuml1tSKPmvLS6P@nvidia.com>
 <632bad8e685d5_349629438@dwillia2-xfh.jf.intel.com.notmuch>
 <87v8pgmbl8.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v8pgmbl8.fsf@nvdebian.thelocal>
X-ClientProxiedBy: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CH0PR11MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: 0000c22e-cc7d-4296-a137-08da9c42f65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKja2iLOdMVyfmlxOz9r9TVMFFnJmAajbMF5UteN8T6CbFfTri8gplHvOi/upVqoUtpI+Ecs7cKpUN84ih/veq5PtagYvtRMx9vsT30qkgLlhtj8CWYaJ34IrjAXyGUteCWv946n709HWWHbe+pjyneKFLaQ2DohDdz7V2OHvH2jTsx4e9Ee13V2noowA+U+tOx/K1C1k/mzfrZJcCkS986gG/dfdy8Q88Wjq3k/ra9XcyOmqEumq2RUYaHB/0zuALYUgL9jpOwwsrN4T0mibuFdH4bjK+HHLbcfsVoVYe3jW8AKB2YQ4UBeG1fQNIG1fgeh7wIEGxJQdQw6esqi8M904ocKIyVPWA4omfSRgX+RINMUR0OMC5mLbNxXtzs75RasApbQuBavErEUQ1/T8DCKknHGqFI74pZJ+L6LjOaDebLTuZCaBj/0UProkAH3ILF96vvfB1f2F9yV8FuP4JDE3P/0CQn1T/1mr7+dRPxqwo3nRikuMUhrk7BhFqGbyDmQP905K/UjWOZzTEOm+o7GqT/k1Rtv4zHpB8tVXPT6fHyIeuBpr7gZ7dgWj1xM/77c6EwaV9UYnlS05612bkwuZZY8KeHL0X1+3pC9kU++NjIkibjYhDfDbI6ZArGivwkDfufzZpCgC6tnO5yYfe3jIymDUhXhEsszWRqz1pnWxk8zqwqblKT2Txf0XeQV4nPqZoZWU75S3VubAOzzWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(6512007)(6486002)(26005)(9686003)(41300700001)(6666004)(6506007)(316002)(110136005)(54906003)(186003)(8676002)(66556008)(66476007)(5660300002)(83380400001)(2906002)(38100700002)(7416002)(86362001)(66946007)(4326008)(478600001)(8936002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BH93NjxWkvPqNbhUokBrR9G6RmTsWBIae6dVvUKEER1NNk+4ItcUrt9Wb0Wk?=
 =?us-ascii?Q?oDJ97O9rPVR4DfzluBdXXRUvprqb4R0uvhJSZV5xusIyFCAbeI2LEpaCQZvZ?=
 =?us-ascii?Q?xf3PA5XukHs0KLBme4yssBBS/FDb9/iOAXZGg+CidktozMMUVJhccavILg9r?=
 =?us-ascii?Q?7DiFEYy0xKm1aEN++4DvwT6SyZj3o2KCLeN4lEIibLm94nIAZSaJ5tMDpcMB?=
 =?us-ascii?Q?0H+HhfeiswusAFdMmopuYlS1fvd87dCzvKehjwY69EgMabzIkPu9QjcBOrmH?=
 =?us-ascii?Q?Kd1ib+WZnDUC7QV5hHgBTPIFFP/797o9M9StW7yNecPjuiWYt+8EWPuXYT4B?=
 =?us-ascii?Q?Nq2f32Z1ym630N4DAtyUUML4C/EpFEreTRdM4KX9i2oeW5J/6SIJyaopYojS?=
 =?us-ascii?Q?VOTMhkZBs+fVJG8lZd/GLT5Louy1HYbzFoKsEwCEJoodsKIg359BfQn0UgBD?=
 =?us-ascii?Q?05MsscAZpJkG9K2R20eQtkQIveRJWYnYx65h10HcywtgXxohIdg9UkHW7IjL?=
 =?us-ascii?Q?nPLUmak2Jh9Fwlv18EWw9YKVKYtNw72URW808KzBBelZ39laQEBeZys1PW6N?=
 =?us-ascii?Q?YZn/FWDKTWN7jZFT1LcybdsUoszmxFRFvBtuJk3V0kcT89QD7hZ+25labtVp?=
 =?us-ascii?Q?K/F/9YZuH1ugGfqzqielmtxXndnGPfGr8K9D4Bueh9sgLNUt7MLTaryDPmOM?=
 =?us-ascii?Q?GQW5VAEnPANLwuF+haCDydlQRsvpgc79wAWKRDDR4CtpFCjxWknd9yhEeGqs?=
 =?us-ascii?Q?Mn0VRRS5v2U02RlCgLPywz6CMR8EnQpvjRE5X/tAbnB6RxsU5yslPIh2HrqP?=
 =?us-ascii?Q?X8OAtuOrPn+iwp/rNcDdGlP7keSYOaq3Cw9F5LD5QgEBB2bVTG9Y/JZAj3AB?=
 =?us-ascii?Q?mVC+pjdS9gSMqByhYwupIO3DkFQh3xsHzh2GaU26jRVnRvr5Ekzj9SqvUPZI?=
 =?us-ascii?Q?2ug7fgkNp7oFUlGrPgVapfTKGSoDVTQ400NZFCt+QUlx8YgPpTiKhwtfFE6O?=
 =?us-ascii?Q?dHJeDZQ9V8k8m8rS3VAnyAc9IvFCkALJWQF8hu65XkkgaMe16eDfnq7Z1S8c?=
 =?us-ascii?Q?A39/E4AEFKTwueij8ys3mLhcoeBU6wrwW0Kz8A8awvqdZMLg2h0BCUBbOaG0?=
 =?us-ascii?Q?nwSaL7oCgJa+s0twVCEFmNZylCUPs8W8AGuXpxnzUYYGcNQ50SVOo48jL8uX?=
 =?us-ascii?Q?1SB7Rrm5yYAxU75FR9kFqv0a6X8Ezs71saKSECBRGWu7wBai4AA7fspG4eEx?=
 =?us-ascii?Q?iGJAVTpEpN/06O4FOANNna7iEV8Z3xmAwAEfeJkWHbppJSVVAvbufskbxtCk?=
 =?us-ascii?Q?UCwVpx5ASQoLzvUFKbESt4oPXzsEtM+uDAoIGxZhP+3RgTdCLdOgBSmqd33j?=
 =?us-ascii?Q?DsBNZBLu9iU5wraBUbXd4mJvFTsGkf1lx4tjAqfkuuDzBKKBEHomigSsL53d?=
 =?us-ascii?Q?3tWMjBbdrIn20HBfALbT3n4M1n/ErWIpsshLBZaZpfGONwrhl7O/84vfYxTm?=
 =?us-ascii?Q?EaPoDPHXKiDnxd+ggyllsB5ZKStOhDjlQQQ+cOzTj4othNHw/PkJZ5A1Vel3?=
 =?us-ascii?Q?UhFO0LbJSlT2vDNA8G9lAfzrh1d/olS392aG5AR5N+PsAKTY2jz1bl5Ywehm?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0000c22e-cc7d-4296-a137-08da9c42f65a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 02:34:24.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMKQmNL9lj/cCjqX8zI5iRqSWiaCYMr5j4cR1WQedXLkH42eXeEC5BFIvcOl54KcA8p+JomigaHNnHIk/bHfa9G8NMndnSREoGQAn3hcgns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alistair Popple wrote:
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > Jason Gunthorpe wrote:
> >> On Wed, Sep 21, 2022 at 04:45:22PM -0700, Dan Williams wrote:
> >> > Jason Gunthorpe wrote:
> >> > > On Thu, Sep 15, 2022 at 08:36:43PM -0700, Dan Williams wrote:
> >> > > > The initial memremap_pages() implementation inherited the
> >> > > > __init_single_page() default of pages starting life with an elevated
> >> > > > reference count. This originally allowed for the page->pgmap pointer to
> >> > > > alias with the storage for page->lru since a page was only allowed to be
> >> > > > on an lru list when its reference count was zero.
> >> > > >
> >> > > > Since then, 'struct page' definition cleanups have arranged for
> >> > > > dedicated space for the ZONE_DEVICE page metadata, and the
> >> > > > MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
> >> > > > page->_refcount transition to route the page to free_zone_device_page()
> >> > > > and not the core-mm page-free. With those cleanups in place and with
> >> > > > filesystem-dax and device-dax now converted to take and drop references
> >> > > > at map and truncate time, it is possible to start MEMORY_DEVICE_FS_DAX
> >> > > > and MEMORY_DEVICE_GENERIC reference counts at 0.
> >> > > >
> >> > > > MEMORY_DEVICE_{PRIVATE,COHERENT} still expect that their ZONE_DEVICE
> >> > > > pages start life at _refcount 1, so make that the default if
> >> > > > pgmap->init_mode is left at zero.
> >> > >
> >> > > I'm shocked to read this - how does it make any sense?
> >> >
> >> > I think what happened is that since memremap_pages() historically
> >> > produced pages with an elevated reference count that GPU drivers skipped
> >> > taking a reference on first allocation and just passed along an elevated
> >> > reference count page to the first user.
> >> >
> >> > So either we keep that assumption or update all users to be prepared for
> >> > idle pages coming out of memremap_pages().
> >> >
> >> > This is all in reaction to the "set_page_count(page, 1);" in
> >> > free_zone_device_page(). Which I am happy to get rid of but need from
> >> > help from MEMORY_DEVICE_{PRIVATE,COHERENT} folks to react to
> >> > memremap_pages() starting all pages at reference count 0.
> >>
> >> But, but this is all racy, it can't do this:
> >>
> >> +	if (pgmap->ops && pgmap->ops->page_free)
> >> +		pgmap->ops->page_free(page);
> >>
> >>  	/*
> >> +	 * Reset the page count to the @init_mode value to prepare for
> >> +	 * handing out the page again.
> >>  	 */
> >> +	if (pgmap->init_mode == INIT_PAGEMAP_BUSY)
> >> +		set_page_count(page, 1);
> >>
> >> after the fact! Something like that hmm_test has already threaded the
> >> "freed" page into the free list via ops->page_free(), it can't have a
> >> 0 ref count and be on the free list, even temporarily :(
> >>
> >> Maybe it nees to be re-ordered?
> >>
> >> > > How on earth can a free'd page have both a 0 and 1 refcount??
> >> >
> >> > This is residual wonkiness from memremap_pages() handing out pages with
> >> > elevated reference counts at the outset.
> >>
> >> I think the answer to my question is the above troubled code where we
> >> still set the page refcount back to 1 even in the page_free path, so
> >> there is some consistency "a freed paged may have a refcount of 1" for
> >> the driver.
> >>
> >> So, I guess this patch makes sense but I would put more noise around
> >> INIT_PAGEMAP_BUSY (eg annotate every driver that is using it with the
> >> explicit constant) and alert people that they need to fix their stuff
> >> to get rid of it.
> >
> > Sounds reasonable.
> >
> >> We should definately try to fix hmm_test as well so people have a good
> >> reference code to follow in fixing the other drivers :(
> >
> > Oh, that's a good idea. I can probably fix that up and leave it to the
> > GPU driver folks to catch up with that example so we can kill off
> > INIT_PAGEMAP_BUSY.
> 
> I'm hoping to send my series that fixes up all drivers using device
> coherent/private later this week or early next. So you could also just
> wait for that and remove INIT_PAGEMAP_BUSY entirely.

Oh, perfect, thanks!
