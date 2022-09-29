Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02515F00DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 00:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiI2Wo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 18:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiI2WoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:44:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEAFCE30;
        Thu, 29 Sep 2022 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664491180; x=1696027180;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r+IZ1dwz0tGzGpq4RYbrEuKFkiLDyIDKs5QsVTg4kC8=;
  b=IULeuxGyalXxZxfOXiQ/W899/iwKYSJeru+X4TnGRwmHMf8RXAJlL350
   1fO4S/mwDiCRpAtCFD+cPusMMbIjcB10fuUx/nk28GYxaxF2yUfz76zZG
   FJrzbYLwzX6t9JxXmT4HwmF/FuXIMEp3iZG1HWGH/BmHwpGcxlDLcOoRt
   KGw73Q9IaaBKVmG2SpKb7RNBDQtiNthY+kpukaN8Nn6unQeqEltAwLkn2
   gQvUC+78Lo7a0QUOe85i/JGREBuNGaG1P8h9YkZ6JvpLmHithp5PO9i7V
   DWDVuhFtWj2dm4aGgWYAR+O+TQPohKVVj/05guB4OO1qscrAMv0+Yy4eT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="328421883"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="328421883"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="600188230"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="600188230"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 29 Sep 2022 15:38:19 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 15:38:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 15:38:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 15:38:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 15:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0/LY71qpXvhIMhNv9pWzGNhEi8xOxKBkKX5vyDlvK46hw5uYSxkjl94iTvsbPNpDthGvttKL9HR49eMN89Sunoprph8VX0/XZ6jI67DoHuwdKXf42UMEQw0cyTgUpc6C9sDA9fAGKHRIzvel6HM6zBEFW1mTfweEsz2AFtg73ZzzjBDk+vzqx7ALDAXND5n9qHzeMjviwoI+HQXCNhw6vgviOGWmCJXHQOEmF+yaL8jwZHnyh0EMoki1GAy6noXts4LpKcT98sMLohtCf49IOY0V3j5z0ZPtnR9JvtTz/c55OVwEPvTOy/U82qkBPb6JHSv4xYnrLkr2JoCnBAlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73ec8lKl1dSy4aSe7mcdgbIPlEkAsK/gU0XqM52efv0=;
 b=fa2RMmlZ1QhlTKkLiviPb8ztmJ29YiprYT4Lo3v++Rw5Yeiz9GNIxF5woGeTLTq67r5yRmH2e91GQtT48CdZkb4qAF3JYPwU0Jbqr9pm82VF88ZC0FyF9UkJz7QfB0cRiR0SiQOzphWoCFEtQKs/86porCRyjZwVXtt+jsbR/fqSQhFsDE/PDYHEhjn2OfmANqCZyeiwqvrFHQKEDGWDofvJDA0zpL/Tvbc65MqcimBHObgMgVWMWFtHEjB6vAKpSiDlnbWIQc1Pie9lVzG2dVoj0WGxv6xe7ZXBQqa8hGqDtsZW1XiG14sEkCVrFd+KvU+ZPnDjtIv+igSLBUuTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7091.namprd11.prod.outlook.com
 (2603:10b6:806:29a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Thu, 29 Sep
 2022 22:38:15 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5676.017; Thu, 29 Sep
 2022 22:38:15 +0000
Date:   Thu, 29 Sep 2022 15:38:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 12/18] devdax: Move address_space helpers to the DAX
 core
Message-ID: <63361e5471f48_795a6294be@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329937873.2786261.10966526479509910698.stgit@dwillia2-xfh.jf.intel.com>
 <87y1u5jpus.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87y1u5jpus.fsf@nvdebian.thelocal>
X-ClientProxiedBy: BYAPR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::47) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cefcad1-bc00-42d3-2974-08daa26b4c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMOyU/2/b6N1QEFbNxVHiwrs29DQ591vTYZxSl2SnwvuO3bALwvYp8J+X4nv1OMorgb73QTv11qtAoR3Dv65z9BII5u30JiluV6TgnXh5BDi8wTvVZdrn4eWH2VFfq+5jSmWBTDuQcwB+lDSRca0VfIuUX+4biQMwHEW45Nn6mWSTLPnxpSlPoDKXBKnWUIcXzrYUOZNJ3gY5Fdf1fSgBA2lH1wxc2dBPT7wGD5MFxyE4dQtqDNs/qvHKZpLNhYPF+AkmdGHcg4PL2BjM3EZlLzSH6uQwu858tcQ0BcFUGr1z7HWnhbye5emEpbX3XE9DsDNUcERM3k2UzAquGFUy+aQOTg4eftkEiLES34rJJjGV+ygX3al17sEdkSMqP3DX9s98/abjoayfCVwVVIhIIgfJLNOI1DK7pMzNXVjgh7mtCujHlF3nuXiXq8z4hccFCkLW3DgqLDSiaCWjl7GzxPCNeWxRHQjYMkOdX4BVIG4rg/ekA+57e7hzXH9RI/6lG3z6Lsu7NrMG62PMwHQ+KZhuwLeiTg48uL7nU5w6Xns8uBdCQDaZ58WwS7PVZebGvp1udkpRjPxuvVOFpH5sxAc3Zn4DniwAxG58XVcvqydWviynLBMkid/TSRlSs6YwE62E1Ts9AszeE+I5ttdVVXf8J93r4Lm6bh8TgIu5+UEQWd9kwEb/eeJ42LKvzSfYOLPH3UG+btwvpVYjrX0Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199015)(83380400001)(38100700002)(82960400001)(66476007)(86362001)(66556008)(316002)(186003)(66946007)(110136005)(478600001)(41300700001)(6666004)(54906003)(8936002)(6512007)(9686003)(6486002)(7416002)(2906002)(4326008)(26005)(8676002)(5660300002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJCT64327Zk1+P6FS86jRLebvTpGoTaEcKdwtr3kPYO7+0YIg/NMmcXAMiE1?=
 =?us-ascii?Q?/kmYi3bZ7sNUBK1+MEsjnipCDeLbdyzcylh3grSccCqku4Z/tiRKaUi1+gTE?=
 =?us-ascii?Q?QobAu1YECU6aRPWG9laVWVKOET4UJb1p5Ur9g7HXNQfF3ZH0aNobvF8KWgli?=
 =?us-ascii?Q?IDlcxw5bcrSJF8AEZhxMFwzNUKrbIN//ivYwKhaQq8COBEuSQIxq9ipKtBjr?=
 =?us-ascii?Q?/3dq1mF/G9d3GGUr0rTbDrzsNWLwT4+v7tEnVWa9LOqD0aMFnUJo19MGm0H5?=
 =?us-ascii?Q?bCTBvQBFR1JlpLx4YzOYbvr59oVi2ykYuPuDP0qTzuFBy1z6jykx0HFlKuv8?=
 =?us-ascii?Q?XO6t8bNocQ4+H1oSmCv7g+ZEaTpb4es5FyTH3PRmtz7bqRg7xVdZjOTszma7?=
 =?us-ascii?Q?uB0Htki89NwCITo2P7atATwq4wVB2i19ALx0kap8YzeuvPR/VouVkh9+vqia?=
 =?us-ascii?Q?t0yxXngY/ZLEx68hD0WOXlGBF/pnbGZlOSUkSyUC+m95obuyAVEV6nPrDoFN?=
 =?us-ascii?Q?qKBAqpHy3/277FtvZ0ZoyFk1c48kYsLyhBuC/WotGzhhnNsp0vpLUuRgJc6q?=
 =?us-ascii?Q?lSwyqomCE1aEWYja0Kyb1VqYCVEfYjhfREPir3Y0ff8N4O+9jBK1ZT5XAIuf?=
 =?us-ascii?Q?P6EiSNKXZggNEzbH4bql4ALtX/vLwfD4l+/EVkuK93RtR8nQHFHafLJMB/g+?=
 =?us-ascii?Q?bAHlQwWbAIFLyl912KQoG+BGiiowu37kvp9jkt5yEDbf/DBPuYaFBt6CRqCz?=
 =?us-ascii?Q?3rR0RY+45E2VfBHCBQCjFW+42tts7RcluhNwEll67OW2WwVvhSws43tQZRiG?=
 =?us-ascii?Q?6OIUp4joJoU6TsGF+L+Wd3c3XZcgnVmH+qQCIRaB+E5/AOyKtGoP8kEgKClv?=
 =?us-ascii?Q?ns3OKr2j56G5psGqncA8QV9n5RYQQWqulj81L7G+y+cnCgLmUWAJEFmUhc8H?=
 =?us-ascii?Q?EY963cZIbg866FXn65dxv46ZRSjIl6eTv2NWMeXTxyDFN/Yf74fYS3BU3R2Z?=
 =?us-ascii?Q?0A2BF95dAyaoSrkk3BnYwfoyLNA09kCjEvH8huX9ld9+VS4frV1Nzvd5LhQ5?=
 =?us-ascii?Q?yM5iJI7dMYFKjwb9WRYJYOBbL8wDBzi/fpF93zsw9S3NnAzAuMUBA1Y2yve/?=
 =?us-ascii?Q?rzMm+fKcUo/K5EggxcNOHSLuD5cL7Zp0hHLPJrfWny6j9TojL4LUZCWD/1AE?=
 =?us-ascii?Q?FCMwYK8Bh6glxGVRLr/o6qb4AQhyOIpV2ewtdEP5mnWHjChw/KzNzrCEA03U?=
 =?us-ascii?Q?8IOokAoQ+NdZb0R4oDKJdJB8MGSyXu0G9TnP+lAY9xgxO+GeQ9fUw8GTQIc6?=
 =?us-ascii?Q?gEuVForrAzpHBfWvW7oslLIbhh55cSRmKjkmUYCHFMo6xrau2ctPu3MHpoU2?=
 =?us-ascii?Q?pa1aXE4N95iKZ6otlz7BP3upQ4/+8G+druriidhigsVVNzEaVAfc0V4z4pIL?=
 =?us-ascii?Q?j/x9MxNzb7EggTQ5A2TgbpXc/gS1+pjxiPw6ITapZFiaU/zPHDI/tRdVTjiT?=
 =?us-ascii?Q?aCooqJPskZVSbofAS3y5kA0aQCN4VZ/2Rolf6LOspTwg82AYa81CLWus6McP?=
 =?us-ascii?Q?53ZGzm8ygFqIRgjxIy//zCn/Gp1wz5EGXaR/MFBIZlC93CoQ4Baazn0z6WZk?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cefcad1-bc00-42d3-2974-08daa26b4c25
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 22:38:15.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5w+aji4qXJupkcL15EnrxPU/e0/LmnHLrW5WV9Ccr+I0fnpL7NRX3MtDTb5MX2gujoOw6iPVR5M8K9Iz860ANSXEVLfu0U6Wz8xuaJ8ta0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
> [...]
> 
> > +/**
> > + * dax_zap_mappings_range - find first pinned page in @mapping
> > + * @mapping: address space to scan for a page with ref count > 1
> > + * @start: Starting offset. Page containing 'start' is included.
> > + * @end: End offset. Page containing 'end' is included. If 'end' is LLONG_MAX,
> > + *       pages from 'start' till the end of file are included.
> > + *
> > + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> > + * 'onlined' to the page allocator so they are considered idle when
> > + * page->count == 1. A filesystem uses this interface to determine if
> 
> Minor nit-pick I noticed while reading this but shouldn't that be
> "page->count == 0" now?

I put this patch set down for a couple days to attend a conference and
now I am warming up my cache again. I believe the patch to make this
zero based comes later in this series, but I definitely did not come
back and fix this up in that patch, so good catch!
