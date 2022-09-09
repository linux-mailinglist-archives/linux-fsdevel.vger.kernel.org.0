Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284FD5B3E34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiIIRw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 13:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIIRwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:52:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174AE9752B
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662745945; x=1694281945;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yWz18Xy//+0kE2+tFgsmDgQUVpEerQAwggXK+AWWGBg=;
  b=h583TR0danHRUO/moOcFgcA1cHvOdXW0kSp33dtKnkarnwLZmUpEjF93
   HU+zQeF+rIw2OkwNcqYun6b80QQA/8Y7aZ9Ni5ouTOefIB9W0BYiLoeZL
   og829PrPfOSa/tREQdpBGD84XQ8NMwUz5LTe92Lmdwy+dlrFlNkwg4VWy
   62TXkIBMtlc/AnbQGDGAw6P7IE999Hi56z7a08luj4ruhSnGbSj6dSS7e
   t71EzUmRzFVgJc0B+6zbAE2JZobG5epPYEwDv10/RerOqEj0wEbf5E74t
   cTwZNwvdawOqyl5yYEbgYM4qvFzGnnJyx0JRt2Slz9ZnRRDEZQH4MHkYr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298872786"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="298872786"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 10:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="860482007"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 09 Sep 2022 10:52:24 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 10:52:23 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 10:52:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 10:52:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 10:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwFsyrPOvf4l8GLi0STw8dW6IJ7+G36BXDZx/AgwdKlFExw5Ej+eBD8d7Cg8LtfnTlWRGJPIvMBJBESxNAlmUavPMNw3vTXUkyyc9j9XVP++dI7TvaZvth01zYWmi5mDPWKzVPjpnyZjEJ5KnHADQml94ndBbwIt6p4CVUqa/4v3wq5lGDzzQcldixLIF7PIbUMMOTDH2+boxl9Jr7DJH9+xB+8QaaTU3+pcZPn8cp7svk3J7YNgwQzLnDOG7gZTj5RFNLXbhQUiAoKwedQgsyc2r+4921MoSHAW2Y7j+8veelCs2FysNHPFDllsAm/SbS8LTmJV3FYgKxTh/y3wRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IzJmKEjAIaba/hEwIZsyT4gWhHmfAKxVA40dI8Q6GQ=;
 b=djjECtioIgIWCv7g2d1gfGWXsnzsUvz+JYig193f7k0RyOatPYBDkj2ha02SXCsrbvp4px3BAInESZWfw6QQq72QnqnO3o6wJfgIgE97neFIozKVi5SNTlsdf2Np6nBiaeVLggv2M//Smv5jwNf4rltv5D2hdHWtpaFHk/7dP1Peg23evDSSxxGfPNF/fp3rErOPL2xRTToZStTLADRLhLsQdLYCNZ2BjOnF5IX1CZCehMoPp+J7vTZ5au7P4wUaVdj37IrfdbiDd3zLIsjgSQoWt/lBlHwWUI+NFwfWc2b30xa3L9jb8xb8bLNMUqZ8MjVhRi8RZaEMtnNhvcIsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB5625.namprd11.prod.outlook.com
 (2603:10b6:510:ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 17:52:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 17:52:20 +0000
Date:   Fri, 9 Sep 2022 10:52:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <631b7d5214e77_58016294a2@dwillia2-xfh.jf.intel.com.notmuch>
References: <6317a26d3e1ed_166f2946e@dwillia2-xfh.jf.intel.com.notmuch>
 <6317ebde620ec_166f29466@dwillia2-xfh.jf.intel.com.notmuch>
 <YxiVfn8+fR4I76ED@nvidia.com>
 <6318d07fa17e7_166f29495@dwillia2-xfh.jf.intel.com.notmuch>
 <6318e66861c87_166f294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <YxjxUPS6pwHwQhRh@nvidia.com>
 <631902ef5591a_166f2941c@dwillia2-xfh.jf.intel.com.notmuch>
 <Yxo5NMoEgk+xKyBj@nvidia.com>
 <631a420ad2f28_166f29423@dwillia2-xfh.jf.intel.com.notmuch>
 <YxspQQ7ElQSAN/l3@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxspQQ7ElQSAN/l3@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH0PR11MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: c54439a6-b2ff-413d-87de-08da928c0b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5Y9MabOG6mJ7BNufnISmChPj856H8TJmH4ncGU35hUxM4jd2WThYSrQPxXOB1tRNESkWvUy0W2kLmvxZ/TJohdbrjmYLA7Jm6ReZ8lsb6YH76SUyHLDJXeBcQz2zvzjFOm11KrKTHvmZkeFdXRqc1aBKFRbpjli2T8cdVJt5ZTBTM07o//ufBzUClmRdxkeXmTF1tLpFPzMidaTtLz3ZQsuxwL8LzWjDDVrqFDPxiVBjPLbOLRU4sO93/cZoVYavOdpYeQSEumZ3HgedtSkwrmNMfO03x4jT69a23F6mgCp3mjbQiRTsRqKaIRi4xCcrVAReCLAD5aih28oE42zpoU5zO2HOi3NwwrTzpGiuL9bo9kspVXYVRv6HrB4tuC2WWvtMGNs1yEafFUysIoZTGJqROe8/OWo/Np9aAxZzUyMVAx7ygBEF7gkDd3sipfbCcOykHv5gO9cBLlMO7x1w5l83NP6jlfoVT7v5Sx8lylifYr3wwTfL8pzFQ8ri097Pr440RnfmQsRlykhhx9/vFF1I+UQrpEJhWxgqICA2fv66/sOkvTfepH/IdTk/50sANJWToFId0NY1rPB6zgsxdPbx1cGxft+xahWQIvKaniQGA5+CZqIoD9wud4GMwCxgDmfJ6M/Y3iRahTKDGJdEuvf4xBQQLSbir7bMDXcz5XcfZORWMJzFdhWvO+4tcY3Qi0DZd+i/gcqw2T+klRjMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(39860400002)(136003)(478600001)(41300700001)(6486002)(186003)(26005)(9686003)(6506007)(83380400001)(6512007)(2906002)(5660300002)(8936002)(7416002)(54906003)(316002)(110136005)(66946007)(8676002)(4326008)(66556008)(66476007)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xcBAcB8P+wKBHKVhHHRTH6Wkp2Dx6htbak6eLckjkQXC8O0LDp1BI/mnPMag?=
 =?us-ascii?Q?Nna9YWTnYmwE8+Gprad0EhO9dSKMqevln4nSnfY1bLai65zGwOhx4caBCxvR?=
 =?us-ascii?Q?yAkLZGwAbh7QC6VDo2SGwC6XGDmAa8FRqjaNoT52aYKMMPh9JjKVWMr0ZoTX?=
 =?us-ascii?Q?iFitGnKskdns6DegTP++m3rNFPrxrCBc3RRK274Penc+wPnYhZ2OZUH3KEtV?=
 =?us-ascii?Q?V+s02f+uOm67J2AqnOAmPSN2/6dhT0pAxKWlC+UWDq5+0Vz8+4sRlVRvbdLW?=
 =?us-ascii?Q?NgGxO05vqwpDEW9TFTrql+ph8vBP/2zFnW8Yq9CIr5QGHRS3FXU3wleIvQiZ?=
 =?us-ascii?Q?vkR7WJ6J1AlIVG0IueuqL07Go+B8l/SGETHfXQLe5rMUXA2CY+VkWlB1Um0T?=
 =?us-ascii?Q?kbLULZsZoAuRtXfQuRwZ8wTJi0TahmtLxvfLcJUnc+mwjtIeXMzlgsroiWHD?=
 =?us-ascii?Q?XDTDitDZzUFKD98b9fkFLcqs/ytIOkpbpQXOcfagXJcI10xzRli7vsncDT0s?=
 =?us-ascii?Q?Dg3YeLU4qX21OUFUWIYoxKqJk6q9t0lTseh1H8z4rto+RUCz/rEJjslMOVSM?=
 =?us-ascii?Q?tx0KfZyTIzUgK42lkUcdpBDirQhnC73np0Mhl9STJZ7nAqkOkYV1xOlfeymZ?=
 =?us-ascii?Q?EUSWZxDZyYQqku4cZBtjnHKQJLCJ4jibhlA7yeEPk433Ij6AuV5AN7UklRY0?=
 =?us-ascii?Q?OO6kTxuaqkiCPlvyvk9JGyvIaM12Hmb5b3VZZxv3U2viOyPYfe+5P1Cv2+YK?=
 =?us-ascii?Q?/jIe4QFbjrSwRSLn8MJ9KbnfML6/3ZLcVzfdfHYuT9PNQMrguJOtm7GsGDhB?=
 =?us-ascii?Q?+BedvQOsux8LIdI9G3AUMAhrGeUgfHmKNiUoYUhX7UqCfTBciTYzj6tCXhbs?=
 =?us-ascii?Q?3U0jB+UkOYK8Dp9SY2PJ1eh9wVq2EGL+rYLjuoPSBL89ml3g4CzUiTLqBViG?=
 =?us-ascii?Q?OqEXjxBW6JAavNcJalyiBzdK0oGY37IPI3dvtin9zWvBELcrFQrTMmndWhA1?=
 =?us-ascii?Q?pSG8/IC/G7UQl+CtfDJcrQFc4NNIpbFecl82UCIq5rzLa0ITmkCdXEc5emiO?=
 =?us-ascii?Q?mKiXadQUK8VkeVsLjVFTORqnNrgBPG5ouSsmJ+WAYvHvI7IxL35eG6a3/Evn?=
 =?us-ascii?Q?/g/pGY4YVmXWeOWWNCZlDivwMH34sNZv9XjDmsfofilrmDDafMAQgh59k5uQ?=
 =?us-ascii?Q?Dk1t/ihRz9tKL0lNnMTLUQxzcbB4fm2fRpjPZXxIyAQVQY9G1/9Gih5+hZnV?=
 =?us-ascii?Q?GCnozcL7E/EDOPMlkl49WYYrDy9GGmfzVLyaN5Hneif030aNdCV2seXE1wpe?=
 =?us-ascii?Q?zn8KFFpYtdabr+BIP83CVk8eTLLrskK136iyj7mS3NVa9w+vLmQZqTzAFb1u?=
 =?us-ascii?Q?ccqjPQzoa6UUkpumn27rXlQqARCHR2fP9cVDRE0FSsHja9jnHpios//YTtGs?=
 =?us-ascii?Q?k6Jxj/d42J+6g0dqTioDQrBLl7aI9EUczwhZriqR6uwpZXmrHvM9g+0oXitB?=
 =?us-ascii?Q?5gnXJS4tIQ2AKr2Z1YBSmC3Nq0rZG/qlTzCfgiAHaBrkxi3aegbXeYeK/lgH?=
 =?us-ascii?Q?H1vP1cKNmUfPiYVaJKZXLqnwGwKPowgntrCqwK4WKpQRhVxw13QFLpxZNaMo?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c54439a6-b2ff-413d-87de-08da928c0b03
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 17:52:20.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Jdg7SmYgH+mzq3abMidtwb0uHH5bHGmhHzxJ2nXh6VG6qNi2+/qcpSrZLgiu84/Xj4ymBxbVsa2oqXQ6mlKP8dAO6+1wYf+FhhH58KtnDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5625
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Thu, Sep 08, 2022 at 12:27:06PM -0700, Dan Williams wrote:
> >    flag lets the fsdax core track when it has already dropped a page
> >    reference, but still has use for things like memory-failure to
> >    opportunistically use page->mapping on a 0-reference page.
> 
> This is not straightforward, as discussed before the page->mapping is
> allowed to change while the refcount is zero, so there is no generic
> way to safely obtain a pointer to the address space from a 0 reference
> page.

Agree.

> 
> You'd have to pass the 0 reference page into a new pgmap operation
> which could obtain an appropriate internal lock to read page->mapping.

Correct, that's what the memory-failure code does via dax_lock_page().
It pins the pgmap, freezes page->mapping associations via
rcu_read_lock(), speculatively reads page->mapping, takes the Xarray
lock, revalidates page->mapping is the one we read speculatively, and
then finally locks the entry in place until the memory-failure handling
completes.
