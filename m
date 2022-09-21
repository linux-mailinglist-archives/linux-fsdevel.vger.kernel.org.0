Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344395C00F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIUPTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiIUPS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:18:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F18E0CA;
        Wed, 21 Sep 2022 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663773534; x=1695309534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oYHO9sKKZOzbKUVDzER1gdyBoQQbwQ/RzTw6anjsz38=;
  b=PTM9YsBonzvCpUqrLqos/Zt2PhRjRNFCDMFBs8WAGbWJ9mkTcbQdu7ep
   I3cqpffUiTjSno6L4yG8OCWCdz0Yc5j6ZvQMUsInAqHq0ukTThX6WTt4T
   s0U+m7z2W621bf2xZVxTePWNwbGwMMAdsKylXEMaYlvnnX9RJ+hk7M8yX
   t1kjAbr2JXAIhtrzLul/Rx7d7IqMTsjpfS/9XepGaKyoKHgTZ+2hTOqrc
   7clPWu/+TxSSjbxgK3je8Xj3MtSl/MzUl3X8mCdJM1Sy4oOSOBvjRdr1K
   qIQbGsRdG262wY81oT99+N271D5f6yMRtomGR7EffTtC3xmXgV0r/RRqU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="386318015"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="386318015"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="948195190"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2022 08:18:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 08:18:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 08:18:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 08:18:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 08:18:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5d1VPVZWvL8QiU8NzUX6TRA50NlfsrqNh33tc7szULrNd7F9pAD6QQI4mTABI9Z5hSrxgFHi6aW5XKMFr1bJn+XK/+2SVS7Fc1HMPCLH4Uzswx6LgQBhy0AOt2M+4SmGannEPSH5blW1F0bM1KhaZ7c8d0z0oQpX3YfPhOirFZM3QeJJ1Cw7OLPL4r0IJmm9NacD/dJ2boSgDC0r2iVaicAsX4bOpHWrcyYxsw77mbcalAlg5mh8QchPGQJlEr0cUessQLGFGOmodwL81xHiPqctWEY3smTacNcKwhf5URKaridTEI5NfT6BgL/tvsef2gtzxx2tIEB+69ycUfkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBb9EDLy4fbU2k+uu7o9LYeOJ2EIar7rI7W4wkgLyrU=;
 b=OVSINQaoJrpbDH/dCgFso51p9O8LZlxqReNJfzuXDg+P5MuvAoZ0w9HNlD5LAwfCi7ogNbMWORVSWbBsQiZ0rrcE8lDK6259HyVRxvkBlNbGi4TzxHPmZnXTt2fT3qGm+rx1vJ1GM/C0oTqjVzNbFaSKPcWyWuXG9tvsriSYYABT0+u+qrI07vfq6xf70erkWibLA8XuvQ0AA7+Bo9QLoqAMdxosqzUstw4/mZeYSxxbu2wlJjc9bRY+bG7DkYJVUEu1+x9iI2JA85l73QDaEPcXyQimM/C0MOv3E5toJ2Go0QQT+Uv1Uav4bjt7vHQuwYsfLk4RJWByagsw6StviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB7350.namprd11.prod.outlook.com
 (2603:10b6:8:105::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 15:18:42 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 15:18:41 +0000
Date:   Wed, 21 Sep 2022 08:18:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
 <YysZrdF/BSQhjWZs@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YysZrdF/BSQhjWZs@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM4PR11MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dccb2ca-07d9-4a6b-19b4-08da9be490fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mJmlSuZPnuLgkQIyDvSbvSRtjjV/6hQ3E27rZDCdqvjSJvQbyB5TdByLw1nKxhozSeIzNdvXJCOa0Xc4zAPM/cbNp/cH8Zz3QU1HAdRRGGJZ41hDD70TUfa5lfkNYJhOCEDAFe06rOZy1rShNxLxs8Qf1C4xwgYihWVQ9L0fs1DYiMABQYZQzFxaaRjIPUD0eqGh1mmiD5OQW55yHpBzZQqVsLXY+eS21A2baC7yW7C/AjgGHLz5QW9oqAjFev4kOSrXSOqSAR29jBzeywiEexbxjkqssMYQBdy7lqM0vrMNLVQsTYNI/Rdx2+4Az9RDcpHeEKVHACNZpk1zDKKJdcLSNFYg3JmjTF+naqv0Vv4ddkhrI5cxVWRq1gFfP3GQj1dInRbLF41zNo0ovFPZrhji+OiGDlDrXoT6UdX5l6R9tgSgyYd1zTUK+g+ggGXc9ABrdAFI5VupKEU+h4bQ65rr3i2sUyLxPFrUKHmoU3FhI3Ej4bwym2uX9VRdK12yKwR1lThGzgbfGgVkX0S43DrR5nSsXyPTVvZ5wxZYgX+7VzPNwQY7z1Ic3IafyfheY4fpeuKURXxPRhtkHJgNAnXNTvysfdgOFgdkeMzk0/Hk/z96nyY0iVbo/SuaLrmG78NCooAXZSW3H7ZBLU8CX1cps4icfBzvsRU/9UquZnpqfVF4s43Wmh47IG8UGPEkwep9YMiHDDF85N02d/uQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(4326008)(83380400001)(82960400001)(186003)(41300700001)(38100700002)(26005)(6512007)(5660300002)(7416002)(9686003)(6486002)(478600001)(6666004)(6506007)(8936002)(66946007)(86362001)(8676002)(66556008)(66476007)(54906003)(110136005)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xjFArwJyi19KjNXS1n2b+NRYObKNRxykIbTERcXujVIGxRyRLnA0Urz5DiL?=
 =?us-ascii?Q?9EwuL0bWSntvlhY9nKAOuL7buR5cSh6qupilCq3PtBCEZNOjrRu1Q5SL5Q+X?=
 =?us-ascii?Q?FNbV6+yGuV5PdwJ72kL3MTj//JzhBdlqv8rM/nrbck2CMd4ayNm7ENzZHCvk?=
 =?us-ascii?Q?dh2dxXQQpDUsFqHQ1B4AbY/PmRmUT1HovF9llrwZhU7zoyj5jWKMcBFrnGNU?=
 =?us-ascii?Q?aoArxPR8mE24k1PciJixhshdV5HeYJB0JGXBPnULZY5nWQ+rR50kc2IHCfPH?=
 =?us-ascii?Q?C/1yzzpbhjAF/y3cGZD5DrqtE66NQNWLPJ8qnT242Vw7BdHCip2WP/a417k1?=
 =?us-ascii?Q?JlVI56zo+CG/oh7Pc4Ipjl9R85Ln07kz/vvRaS+LFB6Z91DXmMMXlvGXRvAK?=
 =?us-ascii?Q?GiXGjSjWlWzJ1OqLfHoCI+2lLfZ+e4/7AaaTfgnmj42V/2ckZZMR5VWIrnaU?=
 =?us-ascii?Q?a/B70Jua7j+zlfMyPFIhpjPtlEVROrgPhSQQ3H7GVtDDj7CL3YSxjX8PRQCP?=
 =?us-ascii?Q?WqbKiHUi30fkGgVEuTjBPiV2mlSLtwqX7i4SDsVWycSS+xeBRNYZ9vbfcX8Y?=
 =?us-ascii?Q?nAY570aFI0BxrmcqHPaEDCFq/snux7SJ3x8nntq1Sru6+VvwYi58cgesMvhm?=
 =?us-ascii?Q?jCGeGA0ssOWJhdz7UDAI9gcQTpy22GXuh5zod6l3UiBAaMsqM2OwRORIHm7l?=
 =?us-ascii?Q?lpf1yY54dVphUGUX8uWgukGrHFZxa/mna7kb8BxGXBWTvEHsYvvVC+svcbKf?=
 =?us-ascii?Q?WJd/2dbE7xSkL7YtEwRcE6HaifTTuI/MemHGIBDjksIoYxmtTomY7F1YIIgx?=
 =?us-ascii?Q?r1xhLMq0Izrxx6O2CkMfuShsSRUCrX7eJfge4U4vJDl55nF5WOQiUcdQTCFf?=
 =?us-ascii?Q?PjB5ZnZRC9Zoee8Ith3xAAlzpxuiHBooYD646VZyu7kacVdRszuxHNZSjx/z?=
 =?us-ascii?Q?44efWzhV6ybxHhyl5LaaVeXfD19IiNU3f/3EWL2DZipvo7oOsWd0i6qYN3GP?=
 =?us-ascii?Q?LJBgQnCDXSySM8TM+c7530C22tgCr3xPk9qVoojTqNzd7MfK3uquGHhqgkBw?=
 =?us-ascii?Q?HcuB41pZgPlS6KTMFRSDcLI2+woqj0huljVsMT4D8B1nPzO7xsZ9JCE7NVWq?=
 =?us-ascii?Q?VS5pp8YoQB+l7F2j2ZNFh2EbvcEV2Bhj+5iJGy11Gn3726y2uc4NaI3vWW7b?=
 =?us-ascii?Q?PmU+bqB0X4xXUPbn6Xgdp5Hl3kVYEPbehAWH09ca/WwRnIAVZRqQ2prUZXU8?=
 =?us-ascii?Q?gG0huRZrLwv3TtzLsC0zmT6PMBMsUE4QF3kbmjQxg38sdm5n+RmazUpCvdba?=
 =?us-ascii?Q?9H4AmxsFORp468rMZaHdvqo0+vJ5OunjALX3XtPsnPDJI5B9RkPRMaytVS4s?=
 =?us-ascii?Q?2l/NquB004vwvQtnlO/gw5E5szvcc5W9rru34hhBsxLZB3xSnPmgVqCK7LdO?=
 =?us-ascii?Q?xSPWyqbzqXTlhsQJ3whFw1rlFIVlSSUtZoU/1GpUyxivDzVYPhzgo4TiytGX?=
 =?us-ascii?Q?tml2wJJnM9j7V/QOecDfBHeGayACOu7CPnimib4L3je95/GAO5n8qW2QRKP1?=
 =?us-ascii?Q?hN2mr8jR6YszsSk1JAZOjGhcR9OhZaDW3GtmWhRGG76QM/OpBIA9aQz5jix6?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dccb2ca-07d9-4a6b-19b4-08da9be490fa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 15:18:41.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hUdP0M8tIB9QHVN2DCghDNtlGaQFa0qEkmA0w2pcDwf5BEhRHUCUVCPn8unAOM6ujGdfHLnsqWgmSNxc6aNUiX63z6gNVntKnOvir9Xj5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7350
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Thu, Sep 15, 2022 at 08:36:07PM -0700, Dan Williams wrote:
> > The percpu_ref in 'struct dev_pagemap' is used to coordinate active
> > mappings of device-memory with the device-removal / unbind path. It
> > enables the semantic that initiating device-removal (or
> > device-driver-unbind) blocks new mapping and DMA attempts, and waits for
> > mapping revocation or inflight DMA to complete.
> 
> This seems strange to me
> 
> The pagemap should be ref'd as long as the filesystem is mounted over
> the dax. The ref should be incrd when the filesystem is mounted and
> decrd when it is unmounted.
> 
> When the filesystem unmounts it should zap all the mappings (actually
> I don't think you can even unmount a filesystem while mappings are
> open) and wait for all page references to go to zero, then put the
> final pagemap back.
> 
> The rule is nothing can touch page->pgmap while page->refcount == 0,
> and if page->refcount != 0 then page->pgmap must be valid, without any
> refcounting on the page map itself.
> 
> So, why do we need pgmap refcounting all over the place? It seems like
> it only existed before because of the abuse of the page->refcount?

Recall that this percpu_ref is mirroring the same function as
blk_queue_enter() whereby every new request is checking to make sure the
device is still alive, or whether it has started exiting.

So pgmap 'live' reference taking in fs/dax.c allows the core to start
failing fault requests once device teardown has started. It is a 'block
new, and drain old' semantic.
