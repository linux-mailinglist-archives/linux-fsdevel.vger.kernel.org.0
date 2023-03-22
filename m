Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC5F6C593C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 23:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCVWDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 18:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCVWDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:03:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C92C15B;
        Wed, 22 Mar 2023 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679522600; x=1711058600;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gJ3QJ1/X4gmFN4WB5RG31Gnye08HK7GsJnLs9UWcERI=;
  b=MEaV+q4qeMW6hQJT3aLMPy26crAxFL5AoWS/68xSySN5wOel5V/NS7rC
   6Jufy7LDUq1qIL6jzaSrJ629aUHe5JBvoj/UG7ZuQYmrSQmy3QIA2m4Ps
   THSIRFGJv76zwLLFBxNA6VXRZ1MxqULsaeB6CpnlN0kx07JBYaImT7JZX
   b909CLzNvyM1FyjnNsK36iU4YEMxMFBw75EulAf2INKfnct4WNQozTJsQ
   JLsvM+6uluvmEsm4LWt6GZa5KRig1LYEzOVp5yEcHt6jVfcNJncJ8JvRh
   YobFUUujjdLuxgd73LKr75mzwlqy9vTh9qlDtZsGR/mYme8c2i09aUP+E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319735770"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319735770"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 15:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="712416164"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="712416164"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2023 15:03:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 15:03:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 15:03:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 15:03:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 15:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c59XoFX6sMei/Qqc2P+d/VSsFfd+lUJKDNPntkVB1uwRnimgvujZ7lr04WvtbmofUav0rFtwrRnZZE6FmbtWSTA6WwCEOhnNNprVojEy6YrVnAYmdhvV23BE9443TQzi8+PbvqdSGqzyfch8DB4HIA+tOcE8sxjmBUyVD4bNkIquL1pGS4kt3+E7n4JttduitEccgXFiccVW8JxrxmsINiGth/SNnkRQZCPe5Sf+OZvoPA1LIz4200U10+GtMMDGwW9fb4TsQjWQPq6gHEIzvmYpKhNTRtM7V4YCX9EeP91cLmf8NypKwhqiGocALxGt5AMaXpOomyn20365JSWhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrlk2mYS1hOCdZWHILV2Qw6aV8qi3TWG1ReYdz4YJCo=;
 b=OZlovhNog+Igru3nmuBbJVjJMh3PUu3xoOfc4UVVMJNerbRQQZvhScwhqf/P85xU1RdQWRm2TK80LFfazd3Eqz3KtzNEV2eC1oQ+P4HjMyC8+K+jmok+eQlSzFvuXcWBwA0JROKCZK9Dd2GgvleivaqXHYW6yrWAprG9o7R35bJmf0LAY0MlsVEP2FlSnGY8/d/VYubj6yOiDQj6Rlpg9VnbhOYUy2HbOfbbZuq/ghVrSizSGVe1amk7l2MLCu280I3z52YbDkHaJjXaZ9iqYZ5U3TW9MWgPCoS7Cjg44CUPvIVSzooKJWP4HpcTyTadb5uvWP2wOlR/RJpG6cKJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6650.namprd11.prod.outlook.com (2603:10b6:510:1a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 22:03:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 22:03:16 +0000
Date:   Wed, 22 Mar 2023 15:03:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>, <ying.huang@intel.com>
CC:     <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <a.manzanares@samsung.com>, <viacheslav.dubeyko@bytedance.com>,
        <dan.j.williams@intel.com>
Subject: RE: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
References: <87y1oe74g5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CGME20230322043354epcas2p2227bcad190a470d635b92f92587dc69e@epcas2p2.samsung.com>
 <20230322043353.143487-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230322043353.143487-1-ks0204.kim@samsung.com>
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a7009f-2124-4075-4b1a-08db2b213c8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bb07BbAzt1r98/zskc3phax5l8E+jT0NvwxEzAOfEJiU/OPuWq2jZcLKTY99B/LR95kboXWYzRevPgnruc+RAUN4IumIDPq2FaEhQ9yxi/ECdhlQHvgE3ClNir+uqWeEKBKRRFv/EHbxKoeg4xrLHpLzJYH7n0hKRQx7MROrlSzMK6ppWbkZHfb3wB7H9irtgLEdZFpbQRGtXg6gpH4wmzrTRivH2IkIlMmIxC42fOMr4g3bp2/IMfQIkawNhTGfn9l7xvLPd/B+s7V4zcoVNV4BAtX0cmYpHCsS1/tguO1YEA16U50dPUtfFDMxuCNsUaqTx2ECgg4AbAk6zJSik38uloYIAiNKeGQGC+0YqQKfS/4PZVCOtNAh3keNYPP9eiPEHo1HQf1u1PmDReeaJKcknH8X6hmHJ9GZ/XUGPPqR2eD41UFdLaSK8UOU771VOObeoHp6KcrdfBylr8D0+mJ6xqTeZEh3XCPg83wfTu48E9Cc15NKS6AEhX1cRk3RjE4LKV8p2+d0sXcIi1UWhlCucz2Eeicy6fVMybkrMc5n3kfYsInCksw7udC0G0HvZlov6H/zNKPjwnWonzJ7D1epbfvj2BC7jDvvRqaf3K2PkwUWX01NfbzUUK9i/zKeEb0H1Ie+JYrOhUrQHvwnXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199018)(38100700002)(6506007)(8676002)(6636002)(316002)(66556008)(66946007)(66476007)(5660300002)(4326008)(41300700001)(8936002)(478600001)(2906002)(86362001)(107886003)(6666004)(186003)(6512007)(9686003)(26005)(82960400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3LhTHAfpLr9+Wus2njEa5hPAoczTcICvf3/h0RJyqxBXKD13nWKs+vw5ZGm?=
 =?us-ascii?Q?5QUdUhG9AXN4fhrnpJhFMsNHVuc+YAtg4sG/3xdqk9KH5Ao/yQYgmyFTtk5T?=
 =?us-ascii?Q?ifTx2z6PlaJgSuSWynCxLlBUVsum2Ic2sOl8oVDT8B/1AlJQw/0taMuZVCSW?=
 =?us-ascii?Q?HiREqcg1TEWvYIrb9CTfieavhhC2hdLVdeDyFW1l3TW0nkFJO6o5Fqb0znCg?=
 =?us-ascii?Q?+iH8E2Bd+c9XPwUHwHlXtP014OJL0dKGqA9XA2Hx1OSybY9RrniL3igkEn7w?=
 =?us-ascii?Q?UfttiOmCVdPFcExJP++FbvE6fwQL6XCwzBKu1LICF1i4bUXiG96D00xBxsrr?=
 =?us-ascii?Q?/aGuYFG3jGB0tP4KY3KrtnlJFbKlQKPerJZITEhvnx9S4nyPQJe6KPr6sKrG?=
 =?us-ascii?Q?HPBYBl3o4g9gzBrykT6UDaFgtOoXUnHoWSLkDJxc8eE3r6GJ9alvuhi9lHHh?=
 =?us-ascii?Q?+0PPrcV6/OJmpfPXGsSwwRES8QGGTeYSjykgZ3e7J0Xf3kBvsrIjtTrJnsvM?=
 =?us-ascii?Q?tmGa1Yw+vZe0Lbs6ulbRfvwiZiUZAYmn1uhUvhwYhHMn9FBODJ2tAq64QVJq?=
 =?us-ascii?Q?bxMiufkds8vIj0AweRNAmPs7cCafZ8h+QpJu8SGkZIwfRfMvNI4CjEO+B/kc?=
 =?us-ascii?Q?seJJ8xVjYyJEzd8YeDhyDVyWGVZ3EBu/LWfINij0mEjsF33meAymTu0MEdjY?=
 =?us-ascii?Q?4m7+t3GsXKPmqL7Rb26BE84rjcnxyrHqdAHIFeQe6nkyBgdy3db8HZjI6bSz?=
 =?us-ascii?Q?S3qL95TbZpczEJOY4nCChdPFgcxduoyJ8lYj0wyBUcDcxard9aElXRcnaWTG?=
 =?us-ascii?Q?zHAOipqCBgg2JGN6sNSYD75qk5+n5A4VpP7wWPrp7QWEQGKIuyolXgmDPpyG?=
 =?us-ascii?Q?NmujnKzpv7QGb06p7A9NRJpPJcAGhvsXmNElAG1t1eKzDNeQzHVn7d68M0wK?=
 =?us-ascii?Q?l7QBSDQlL14+uzjc5MidPGOkvANi044qYuFDnwagKfrsjK94rYvDmClvvzPk?=
 =?us-ascii?Q?Y58K++TEO4KBKTkkJ1QbWU618jfiE+FyRjLneqX5wXBEp70jeOoYteL3lXHQ?=
 =?us-ascii?Q?XlQcLtLJ1XSAAxLdFQxQf6qJ2KRnIgBmSyLFR2pOHBNK0ytTauod8BEdeW93?=
 =?us-ascii?Q?QqO1TMcARBt254MO2IKeqrgD7xqOwPCJ+nQVyvhxJw8pBO3pS9vZg4v+gFoX?=
 =?us-ascii?Q?3bBppcfycvkdDYbbwUuJT9zqkhl/kDn+RavPMTQnQ9fpWeWFgJiC+krHFb9h?=
 =?us-ascii?Q?YCdk6KQlfVl6sFk2WX1RwPdwfvujNrLqXkL74ttR+yBTt1nMh7TvlSi93nD8?=
 =?us-ascii?Q?r+JGQykqfHc0TIh24kJRvfHVy/aHSXCFLkMe+ponvJcBqu+7wZhdBZki77uy?=
 =?us-ascii?Q?uAiIWcYmW0KQVYvOcvosbuSaMGSMC3+sqjLHZcqMiLExvOUoE+9IyQrGkAzj?=
 =?us-ascii?Q?XU2TkIKMsp8MAOd/NKGSBPvfpFgAxj+SlfH6xROeDJKQzGzYk4k15+0rlBRb?=
 =?us-ascii?Q?mUcX2oOnCdA/X9YT3HpJHWCZ/UeL3RvCmxCMRnzVj0j3IAedAgHff0DcB+U4?=
 =?us-ascii?Q?ADOHZzBuY6lqwhnCkS/AwrR1UMfs1PHs9ny1G26LGDoXgn4U3Wz7gph0UPBl?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a7009f-2124-4075-4b1a-08db2b213c8f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 22:03:15.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kH74fbn6cK0DF8VkiStgMPi5D/xcob9nZZQxK1uK5SnLm7NKEIXw8hw1/cZSrrIuuMb7OdJ2aBFqM/51meV8szPLNFxuEpscZRLu3MgLRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6650
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kyungsan Kim wrote:
[..]
> >In addition to CXL memory, we may have other kind of memory in the
> >system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
> >memory in GPU card, etc.  I guess that we need to consider them
> >together.  Do we need to add one zone type for each kind of memory?
> 
> We also don't think a new zone is needed for every single memory
> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
> manage multiple volatile memory devices due to the increased device
> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
> represent extended volatile memories that have different HW
> characteristics.

Some advice for the LSF/MM discussion, the rationale will need to be
more than "we think the ZONE_EXMEM can be used to represent extended
volatile memories that have different HW characteristics". It needs to
be along the lines of "yes, to date Linux has been able to describe DDR
with NUMA effects, PMEM with high write overhead, and HBM with improved
bandwidth not necessarily latency, all without adding a new ZONE, but a
new ZONE is absolutely required now to enable use case FOO, or address
unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
maintainability concern of "fewer degress of freedom in the ZONE
dimension" starts to dominate.
