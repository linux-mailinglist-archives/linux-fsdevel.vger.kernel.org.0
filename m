Return-Path: <linux-fsdevel+bounces-801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69537D055F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 01:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A93428200E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 23:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9A3450DD;
	Thu, 19 Oct 2023 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/IRaJFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640A19440;
	Thu, 19 Oct 2023 23:23:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F346C124;
	Thu, 19 Oct 2023 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697757828; x=1729293828;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9q51xMKpOqTNxKPj3WYQ7KS0PEq3Na0ag+ZZZWy3hE8=;
  b=P/IRaJFF9QIIqh+xYGY9410fwNNhJxiptjiooJCEqshetptWe4MfbnIB
   8ZKbf2zzmI+wZDaJYf/Nr+BHxgQcVWHoIqyt2fkPJAxkBzVhOEc7wxox8
   h9wwwQImo6+1kWEiBwEpn8M8dxqj2pJ8+4pL70+wG38FepMReP3fc01UZ
   AUr+t7IlchdadY/02aajLBi9gFfGfpX7qWAnRg5mwosOVUwB80lE2Cwdw
   NX39utTtxkKF7Y1z9A/5IFq+axfZ/cSyAtHyuHlKEBLAY+Wt0N/B3bu+6
   G8D73uadcrkVXxRqJN3nUoSu2tV6pyq5G4H/ZiLJSKWM5QuJZiyAB1yyQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="452868816"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="452868816"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 16:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="847881606"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="847881606"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 16:23:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 16:23:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 16:23:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 16:23:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 16:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8ZgWbJSbSwqiy+GL+g8fKs3bGkmy2xIa6keCMKX0DFi0FrZ7znhndv2d3oRwARajkLACUfnFKG2HrwzTXLzhb2ietLqsT3H6ScayVEwW0iTPwqpDz71UDKZ/eLTUaXfIi3TkUDhsEE/Edhlmfg2GcYjc+s0FWugw+KX5XUpj41KxwkgQDaWnwdi4QoXme1XFi25ryJZsn5xLzEukE4TFtehAnbFIDwxrnAnvaxuXLDkr2gpG40QtAeceEuU4Cvx2GL/wSkbxmJoTsOPUqK4pZpxj//yxj6NtXWC3zRS8R/pdLjrtkmhRlzjBXP/H0eh5gDjjeZ9/IhzexJfnNlhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AIT6Mw5NE+RWeerLeDVpBI6GsIjM16lJKQz97bQEqI=;
 b=VyqpcuEC3u1Jqvf+NYoqvBX8p/PYy3PSl14NVTaS1Jfclcq/abwnL4sxY5v5sDT7P7YQ2AfH6Q0WTPsm54FDdQtn2styVSe0EMzYQapb0U5FojLzbbA1tO3ApHsrqKGgaig2OX98lg/nxLVtnvcUsBk8NcscdXgFZPcaE4LbmCFOekdDK01sW/6eThV4xtQygy4oIHdCKsoyrQLo7gYtJiCLNHMalpKaropl73hShDz/EKNKkQD6UU+SqhSWkiD0psAn6qvEXyVXyucv0f7Isnx0MFhV32oIWFTVZHspUfxOGaLWqt2NgusFA7XINcg4XZ1G5iQIDB3mwyCKwo+ObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 23:23:42 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 23:23:41 +0000
Date: Fri, 20 Oct 2023 07:23:31 +0800
From: Philip Li <philip.li@intel.com>
To: Heiko Carstens <hca@linux.ibm.com>
CC: kernel test robot <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Linux Memory Management List
	<linux-mm@kvack.org>, <amd-gfx@lists.freedesktop.org>, <kvm@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 2dac75696c6da3c848daa118a729827541c89d33
Message-ID: <ZTG6c3E7ti1uFI5y@rli9-mobl>
References: <202310190456.pryB092r-lkp@intel.com>
 <20231019153205.9160-A-hca@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231019153205.9160-A-hca@linux.ibm.com>
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|BN9PR11MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe60795-c231-43ea-4313-08dbd0fa6e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbiZ3soXsj/7SRZTahePHso3lcaLUhJt+sPcDWpytqAfgh6XFLXu//mBi/oATw9K6n/CVFIneiTit803btRdxjmYWZ7jDkusm65wj+BKJMNMaUt96Yj6qgMThFhyCUckdWo5rWLiQ7BfNQw3gbtSi+4UUme0bpV61YI2zlDwia7LKKbAuqz8OhFlrLh1y9ZMyYqOp4q8ec/H2BmATXTg6F+rMv/T9PoC9AcMPQBjIPab7x8r/ngjsaZ0BfZLF4oG6S9bBrdnkdndJDDgzWcjyhiJBlqNWiXZoyOo3CmSe7SJhxbJ3h28gBEzudSdQGTrx2srL9YUk5PFrAmdYds/o5b1KWw0ycRf0ZZZ8ghnN4n3Lz3YVeHXKDzLO5snS+TLt1RO30AwSAFM699KBgfHqrQF4DTQlGzUIDXyeeleRNbEiBCagpAxURxaBtvwzAe0WzW+HhuBrEmezZTW6PqAo6ksXwDAIBDvC6eioK41JziFMAw7b52Zi5Ol1IYFgXQHqFIGa/prXned1fdOpdORRLJmJcOGTddVbyP3k94xEK4ZZaHjJiH/m7j1UwtCEMxI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82960400001)(26005)(38100700002)(41300700001)(83380400001)(8676002)(86362001)(8936002)(66556008)(54906003)(7416002)(66946007)(4326008)(316002)(2906002)(44832011)(5660300002)(6916009)(66476007)(6486002)(6506007)(478600001)(6666004)(6512007)(9686003)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bi6TRHk/GbJtCdVWJf46sJDmbNgkR6sCSHu7UFZkpEAFl08JDR5WeauF+q8z?=
 =?us-ascii?Q?fi+qPjcDpR7xvwenjH0Qm8E18NJ5owvPt4hcaYh+SSdDF5HGnjya/wXdmv2g?=
 =?us-ascii?Q?2Xzwr1e4GwST3H2cJkK3kLkyq+k+mSAd/KaZkmteuPl5MKmn2lVqestKn8o0?=
 =?us-ascii?Q?mbebC4w2+5W7gS8Qft/QIVbzaQwfNXxPcKZ9hml47s0C3G7aobYryaVzsqRo?=
 =?us-ascii?Q?ujnn0M+/no1rFb7e1W/jsaEGmJnK+M3P/AcjHpGImVoFJ59yH+PANmO3cSyl?=
 =?us-ascii?Q?Ic1rXi2IlkuW+u8q/j2mMkx/nYM83qY0HB1TFEix/RlTItcpIYqrBKr6hvAQ?=
 =?us-ascii?Q?nq8rH+O92LigwjyhRmGaJJm7QbLDZMqFRs3FSGalzCa4kO07bOf0fZgtgkFA?=
 =?us-ascii?Q?aGMeabfs//arb1S9jDUhA0V+eoSwM+WAhJ7qjZZzYNzrIrfAwgEbayC7fvoZ?=
 =?us-ascii?Q?jsJrYuqx46+xXlyq6nIN+v7hXpRhBjX+Kp7RF/Vx2OVLeIehrwinkqQ1y/P2?=
 =?us-ascii?Q?sMi/EZrfBv8nRxqOvTIO6b3hFL/guQMleGdAzX3duBQkZCUOnlnsaAzMjCU+?=
 =?us-ascii?Q?CvkH/EWkyhXwEZB4xKBzqu9OJNUSclPR/KvKPtYSDPM1pu8yofb6qKBNHNtY?=
 =?us-ascii?Q?uPg4XnRZZhjoBHtjT1luqh1ULOg/KeqM80A6IVH3/h3TRYKJKbjURueDOrJI?=
 =?us-ascii?Q?wjdLKyK5ylZS/5sjExpYUmCA5cpWNhlmnjyeRaEBTxlEqfYaBLZ9m0OTrqWl?=
 =?us-ascii?Q?qVck8Xn1qKhV0jihXIEX87JC1yprMtWna7QCbFf7azq3AOnrPK+uT9hrAq17?=
 =?us-ascii?Q?8sLrt+tey98qa16+2o6C7+c0RCBMwY07TRuUg3WeM27Agd5TLWak4V8IqP1W?=
 =?us-ascii?Q?VXJ0mYrJL41ZwBdVqhEqsB/7fMZ86LQLu78kVOoN1ZjCUAoQVGaC7DOLG9Aj?=
 =?us-ascii?Q?QmnypCT/7dS92Mz4bUU0avzFI8E4YKn+IHE9VYLweMneQuN/1G+PQ7dUBUvz?=
 =?us-ascii?Q?mI/Z6SKkTlAknIdTFyveEYttapEyvgnsIXI9WR9s4Pl1SS7vrSxVwDOGrKr4?=
 =?us-ascii?Q?hXmzUsVwbpT5NI/y72eU/+OpQzcjWZvbDlCYQhORMzYMMRqfKJb1uY8Zv7tR?=
 =?us-ascii?Q?7dliELFPMLSIi4TcuynplqbePasj5vyQjxdaY1Lhl042F5C/Z4rT9r9ol0vY?=
 =?us-ascii?Q?pEMncbRMxKV0HM5t4VFYgC2Xvi7BpcCM8QA2eNcdwtOE9gZWhYGGEGjr9W8g?=
 =?us-ascii?Q?4SZP10F9s+PhtOWTvg0rUNU0wNe8U7ceN3WElKB2vh2S/m029fddaEVYvP/K?=
 =?us-ascii?Q?8wb/2Qjh/UMiK+tLMbGAQewibwe2hIhGZH1eDDKe39ATEwphLnplpN5LpkWE?=
 =?us-ascii?Q?dKV5Q+58fGma+n6cWZnPISIniu53twpHmHoJZWdVPfxoR3cwJX42TbOcW+hJ?=
 =?us-ascii?Q?srPDc6C6CB94jRddhNEwJaXcLS3yU7vStuGY2J0Cx4MnvyP9mMbDagnvawKZ?=
 =?us-ascii?Q?AxF9Ikh3xoBod/sRqrQgJXxTgXZxTeC3bERd/9pQo1h2ZL8lUDyQ6yQi/neU?=
 =?us-ascii?Q?1VFJffn2fyjOfE55IS3Pp4vMlTq7PFBf1tvtYrKH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe60795-c231-43ea-4313-08dbd0fa6e3d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 23:23:41.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pryZnC4Xcowf2QHpafKlLxt8fZRJcgkqKD30rGADyKy59+MtQWGLP6z0HNt19oo2ZIhnP8Gv+JkaJfC3gIh7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5545
X-OriginatorOrg: intel.com

On Thu, Oct 19, 2023 at 05:32:05PM +0200, Heiko Carstens wrote:
> On Thu, Oct 19, 2023 at 04:07:35AM +0800, kernel test robot wrote:
> > arch/s390/include/asm/ctlreg.h:129:9: warning: array subscript 0 is outside array bounds of 'struct ctlreg[0]' [-Warray-bounds=]
> > arch/s390/include/asm/ctlreg.h:80:9: warning: array subscript 0 is outside array bounds of 'struct ctlreg[0]' [-Warray-bounds=]
> ...
> > |-- s390-defconfig
> > |   `-- arch-s390-include-asm-ctlreg.h:warning:array-subscript-is-outside-array-bounds-of-struct-ctlreg
> ...
> > s390                                defconfig   gcc  
> 
> I'm wondering how this warning can appear in the builds. array-bounds
> warnings are explicitly disabled, see init/Kconfig: CC_NO_ARRAY_BOUNDS. And
> as expected, if I compile the kernel with gcc, defconfig, and with or
> without W=1 the option -Wno-array-bounds is passed to the compiler.
> 
> And also as expected I do not see the above warnings.
> 
> So something is quite odd here.

Sorry about this Heiko, this is a bug in the bot that it wrongly ignores
the CC_NO_ARRAY_BOUNDS config and always test with -Warray-bounds. We
will fix this asap.

> 

