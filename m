Return-Path: <linux-fsdevel+bounces-4538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA7800290
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 05:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E75B20D10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 04:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF069BE55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI5v9iyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88E51703;
	Thu, 30 Nov 2023 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701398850; x=1732934850;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JL2jyVNROU3DmAB1FhsB2diLyAYYzZw/xRHbPHZdXJI=;
  b=iI5v9iygYuCD/4kYDfu2bRAPoFNVhGdc+LCReZvlVRfY9kGKF0MnuqB9
   cqEWYnMrga3FAzKKuoRFjrpeXUGHZq4UXv347Rinj5ymiQASWa/igJFPC
   hEPx5zhj0fa3R3Z4fbrNQG+B5gMpdIqBGU195PaxdILtH9Kr2IKo5Wn6Y
   J1TzC95eliabwzHR4hu+PmFEv7ve90f2plJiCpUNMFF9VxrnO1P9XLsGt
   QehJSXpVehgFBT1/KL1JyN5XFnJgMeCw+Se3uBYeP62jbdsashwa/5HaV
   3pGoDsNKTqsjmu6ZkFTMijT099YZOReIzLM8Ki+QYH8HGhlxv8KEPUcme
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="393164323"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="393164323"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 18:43:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="860408590"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="860408590"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 18:43:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 18:43:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 18:43:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 18:43:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J06fg/inIlrMVw99hPs0RbW16iCxOHNh3ZbiNhfxcpXIe5hipIJjod1LziN7IOMXaipnRIs+7Pv7X3tyuloiQqgaOUEEUH2oGB2ojlgxCQ7XEI16muBthEXcBZrgZQHd5abvEbvm9QgnEFc80In1I+5HfW+5cvHGoNmqh+BZzqp756aAxu7wPaz7Q04T5fOBpzgOiTiWw+XbDOhpkEbMjaL9LBEbkr3QKDsAYZeGZVpwQ5g9NQY5rD/P80sJq4woABMyEupo5XMsHVZfDzMUHqSdrFiI6Rfh0NQQQoUwptdKYebvrZ1AE04gA1FleKKD8l2KQr18Wx1OoTcAa9BLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FwEr1lOPKhEnwVJxFXoqz92IsECuODWdbeN5Sqgj0w=;
 b=U373aD0sZZNDSGvOAC6UcD779cwhEbtexZ+Th5ScfynLNs0HP56DumJwm1YFFBFrJvr513jt3tkJTebmIo0NiavjLZdYUfkkytHCbay082C7vXSxB8RCmWno5QpjxM6Lla2vYJiLVof6oWrqlWFdsSqPKku/YwrkATUpjxVJbbFKCxsstorIRhebTrxdsKGTBwp5eXVjjB6BZVBERwWA9G9DfdOyeEEkT5BUJ4D9GICDof8bQIP4g4V2Ezf1EoDz5hFLa59v+qKyWLr+okXCPIllgMC0QpTgW7F+zmqrigYyu7bC0GyXMlPQ4UNyZoypK00K/JVtpBYP0g6X2G86GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7813.namprd11.prod.outlook.com (2603:10b6:208:402::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 02:42:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 02:42:55 +0000
Date: Fri, 1 Dec 2023 10:42:46 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	<linux-doc@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()]  1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <ZWlIJmMX3I0eDs8W@xsang-OptiPlex-9020>
References: <202311300906.1f989fa8-oliver.sang@intel.com>
 <20231130075535.GN38156@ZenIV>
 <ZWlBNSblpWghkJyW@xsang-OptiPlex-9020>
Content-Type: multipart/mixed; boundary="YbMrZlPVpQg7sRDG"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWlBNSblpWghkJyW@xsang-OptiPlex-9020>
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cb571a-3714-4743-e0f8-08dbf217381c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RplLgFvuiwI2RgV3unQt3aj08TYOUAb/hQJlYn3+9ze213GlBEKfq3aEdvSb1nOpGPHPesag/0dmFTuEn5LkfRSgDEKwG9vHMveE1atJQ56119/2/Z+wWVEfOJOY5UqYE9R5Z+wDbIg95A9Wy8U7K45MFGQPsydEtg342gSoLWGanLKQVrTxVeeyuw0uu7BqW62cdhY29bMQjT9OERHWNH/1eTOoh9MGDG7I3o312K3Y9psPRZZzR+Q1CTnXoZ2EtlHUcuAI7NR+pfy5/+NrchWzPem0Yq8G7rRiQjY9QJjew7kmBSowTG9CUh6yTG7mgw/b2ct/6OchR6+SmHIvhqGAN/OqVSHdodBM9e250YCMJpVtm7VudJTA0shCK0MGUDJr2eWcub4uKlLwg7C8lG4dLOgwQmW9GJZTqy0TMgfVuUERwIvkHh/NGfSuzZRhy4ynQLsMf7ShYIRBvZ/l95fyAQxuybBlWLG1EA8/yjSD3YctsROcGAm4QI1XefLQSs3xoZD6Z1tXOI4cmE49fhFeUtatqRSe+bZUDgfGVsfpz0uf0GM4vgKeLe0sAQT/hwRVy76aBAY6RQkwFzxzENXuf83JWO/CeaRiOKI9d/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(966005)(107886003)(6666004)(44144004)(9686003)(6512007)(83380400001)(235185007)(8936002)(4326008)(8676002)(44832011)(30864003)(41300700001)(5660300002)(2906002)(478600001)(19627235002)(33716001)(6486002)(66556008)(316002)(66946007)(6916009)(66476007)(26005)(82960400001)(38100700002)(86362001)(2700100001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?30I7Rfh1WU9beuQ2g+8j/AA2CTBEhBsZFM4CvBbO1ylONfQUTELgm+4XQ7?=
 =?iso-8859-1?Q?uBYEPkXSIcxI/16Fyl+Wf52pVA93LPUJ7QL5DGtYPVBfwA222P53/51bgF?=
 =?iso-8859-1?Q?JQ/2yvOFnojuaoN9V+jjpGp8aUdGa+6ac0L6EF+bu/vCvNDx6cO3xPv3+0?=
 =?iso-8859-1?Q?7gKCl1k7iucM+XmRJQC7J7finggwIYt6TsHBZj3MVQZXJvDDQmpjSY2wcs?=
 =?iso-8859-1?Q?lev3tKm8+KAiMPAD/HVcBwjCvA8xUtK6frJLWRrYJ6eDN5H3I8vRol1h1M?=
 =?iso-8859-1?Q?/L31fDLEAjt4OEyAWorUjRRTgd5j5WiYz91ig6mXTynzybV+lsH9Nt/F8x?=
 =?iso-8859-1?Q?vpK5FvFXGWr7yUGiQpLTGbj9AJaH7aYDMaotymd6l/3yYIpUudi85c25lz?=
 =?iso-8859-1?Q?zXvqSEnHTfi+xX1PoSeWXVGU1N7NqRc3ph0DAF2c4mlHAroE6xaGA/n5Is?=
 =?iso-8859-1?Q?ToNrlRpWzDZhEKPUmD1KultwDr4xB9iNcJdZfxC12yszvy1NkghkmhYw3d?=
 =?iso-8859-1?Q?sosizyFf+9Kw3nv/+x2N8+Ksdfjvan/k9WZidJiVDQCOGcnsuZ3QA7lGYG?=
 =?iso-8859-1?Q?im9uOmJb+ebhqrUSn9znp93r/Jd2UoKdSB9oiUlbUUaEyiyXnVy2il5vDf?=
 =?iso-8859-1?Q?YPehWr1BS2lf0baTGQfJURSnGlz/bbPnnh359R3iXCxI5QVD/UkpuQEtiv?=
 =?iso-8859-1?Q?eh4Ckf3odpETHuk8DfdE7Su55nH6m507koCdrMkZ8q/sLV6XlX2buRbkir?=
 =?iso-8859-1?Q?u22IzJmqdQx5JX4oo5E9oIcJRcFaRB3YQTdwCRZ+GI3kZXncbKD4A+QhBV?=
 =?iso-8859-1?Q?01iujkE0rSUNJ1aJYe3CK+imRrjElyxV57iNZlgiZO9/4+bvwTnsvbvXGO?=
 =?iso-8859-1?Q?/zYKV82DIVnnnqkzkyyXT55Vx1xAc7iYQCfPuFg9rdhfdkf049Ht1c6btK?=
 =?iso-8859-1?Q?8AZJVBup93iXJ4ZCB9j9Bv+pmP5jBHGNmADtWiL3itAbzeEYQkqYxzxQcp?=
 =?iso-8859-1?Q?x1C+UaI/1U7tJr/ttSpCvGC3qoSWEVEuzFThN5Rwc6VYER/DY5I94Ifffi?=
 =?iso-8859-1?Q?aObHwVEBujVJ0USMm3pFfYzDynR8otBJT0hgrOs1vmXCo0s4j7LbyhkVdA?=
 =?iso-8859-1?Q?BBx+srNb26YjvN0FMvw5lQG8ss//+IprmcUVnxRDH2BUxZCEwBGr7Wwr6e?=
 =?iso-8859-1?Q?jzyz2cBlzb4NA/EMh2BPiNhqBgkUZO8Hp7HSBHBA0W4TT7Ql4QHBDoyZir?=
 =?iso-8859-1?Q?Yo16TWfymJZLM7a6T9zwotdzsWmde3KRKgd8NmQSaZOTZzzQXy7sfbCp2d?=
 =?iso-8859-1?Q?+p22sGTY28AT/DkMqyu5phNIwZ5RMtNYggt/f3bfQGCNYosJqsF8g+4sZU?=
 =?iso-8859-1?Q?i1i2Zbz6lIuCXAWILpfPUx6rQbpm+qx2p3ak09MzzWPGymzTNHLLUiy+bB?=
 =?iso-8859-1?Q?8QzpD8lw3v9duxm4yH6jJbZ1ELEFMxHp8aDZfWD/k/mZg/xGnw4Yd+oKU+?=
 =?iso-8859-1?Q?/uyG2Fdo4oMuzz8Gnb6UvfNBCuZTyslPJRS7atxcXtlWGGfbqbYn9vv6Zp?=
 =?iso-8859-1?Q?9lYGKLRjkjUXPDR+YT1YCosI6PwV63lSJo4q4sEBKhblB8cGqIes7Lksam?=
 =?iso-8859-1?Q?QZQe2AdKlbYa1Y7MtAJtsqg7d/2Z9NqWSsu9L4QJnEyryrgUwnNY+Ikw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cb571a-3714-4743-e0f8-08dbf217381c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 02:42:55.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro/lZ3fI681Go71Izj08oq9LhOl5dAS31yyr+R6W0h1z31l6eD1gis0FAuqR+qc9soPBnfTsiZ7KjcyJ2Bsiaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7813
X-OriginatorOrg: intel.com

--YbMrZlPVpQg7sRDG
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

sorry, missed the attachment.

On Fri, Dec 01, 2023 at 10:13:09AM +0800, Oliver Sang wrote:
> hi, Al Viro,
> 
> On Thu, Nov 30, 2023 at 07:55:35AM +0000, Al Viro wrote:
> > On Thu, Nov 30, 2023 at 12:54:01PM +0800, kernel test robot wrote:
> > 
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20231130/202311300906.1f989fa8-oliver.sang@intel.com
> > > 
> > > =========================================================================================
> > > class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
> > >   os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s
> > > 
> > > commit: 
> > >   e3640d37d0 ("d_prune_aliases(): use a shrink list")
> > >   1b738f196e ("__dentry_kill(): new locking scheme")
> > 
> > Very interesting...  Out of curiosity, what effect would the following
> > have on top of 1b738f196e?
> 
> I applied the patch upon 1b738f196e (as below fec356fd0c), but seems less
> useful.
> 
> (I also rebuild and rerun 1b738f196e and its parent since we have some config
> updates, now 3 commits are built with same config, as attached. since rerun,
> you would see the data have some difference for 1b738f196e and its parent,
> but similar as before)
> 
> for stress-ng (full comparison as below [1]):
> 
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s
> 
> commit:
>   e3640d37d0 ("d_prune_aliases(): use a shrink list")
>   1b738f196e ("__dentry_kill(): new locking scheme")
>   fec356fd0c ("fix for 1b738f196e from Al Viro")
> 
> e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 fec356fd0c7d05c7dbcbaf593c3
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     323525 ±  4%     -28.6%     230913 ±  2%     -27.1%     235723 ±  4%  stress-ng.sysinfo.ops
>       5415 ±  3%     -28.9%       3848 ±  2%     -27.5%       3928 ±  4%  stress-ng.sysinfo.ops_per_sec
> 
> 
> for unixbench (full comparison as below [2]):
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp9/shell1/unixbench
> 
> commit:
>   e3640d37d0 ("d_prune_aliases(): use a shrink list")
>   1b738f196e ("__dentry_kill(): new locking scheme")
>   fec356fd0c ("fix for 1b738f196e from Al Viro")
> 
> 
> e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 fec356fd0c7d05c7dbcbaf593c3
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>      35237           -15.4%      29823           -15.4%      29798        unixbench.score
> 
> 
> 
> [1]
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s
> 
> commit:
>   e3640d37d0 ("d_prune_aliases(): use a shrink list")
>   1b738f196e ("__dentry_kill(): new locking scheme")
>   fec356fd0c ("fix for 1b738f196e from Al Viro")
> 
> e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 fec356fd0c7d05c7dbcbaf593c3
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>       1416 ± 22%    +589.0%       9760 ±151%     -45.1%     777.25 ± 32%  sched_debug.cfs_rq:/.load_avg.max
>     533.10 ± 21%     +33.9%     713.75 ± 24%     +53.0%     815.50 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.max
>       3146 ± 47%     -65.7%       1080 ±  7%     -64.3%       1123 ±  3%  time.involuntary_context_switches
>       3.41 ±  3%     -25.8%       2.53 ±  3%     -24.4%       2.58 ±  5%  time.user_time
>     323525 ±  4%     -28.6%     230913 ±  2%     -27.1%     235723 ±  4%  stress-ng.sysinfo.ops
>       5415 ±  3%     -28.9%       3848 ±  2%     -27.5%       3928 ±  4%  stress-ng.sysinfo.ops_per_sec
>       3146 ± 47%     -65.7%       1080 ±  7%     -64.3%       1123 ±  3%  stress-ng.time.involuntary_context_switches
>      25957            +1.4%      26330            +1.8%      26423        proc-vmstat.nr_slab_reclaimable
>     463457 ±  3%      +7.1%     496419            +6.5%     493401        proc-vmstat.numa_hit
>     397193 ±  4%      +8.3%     430180            +7.6%     427182        proc-vmstat.numa_local
>     567604 ±  5%     +10.9%     629697           +11.0%     629767        proc-vmstat.pgalloc_normal
>     525529 ±  6%     +11.9%     588107 ±  2%     +11.9%     588208        proc-vmstat.pgfree
>       7100 ± 29%     -19.8%       5693 ± 41%     -48.6%       3651 ± 68%  numa-meminfo.node0.Active
>       5321 ± 38%     -35.3%       3444 ± 89%     -56.1%       2338 ±111%  numa-meminfo.node0.Active(file)
>     211480 ± 15%     -25.2%     158279 ± 38%     +26.0%     266468 ± 12%  numa-meminfo.node0.AnonPages.max
>       2007 ±104%     +80.4%       3621 ± 81%    +144.9%       4916 ± 54%  numa-meminfo.node1.Active(file)
>     163193 ± 11%     +36.4%     222671 ± 31%     -36.3%     103907 ± 35%  numa-meminfo.node1.AnonPages
>       2500 ±197%    +149.8%       6245 ± 98%    +236.9%       8421 ± 69%  numa-meminfo.node1.Inactive(file)
>      30483 ±  5%      -7.8%      28110 ±  3%      -0.8%      30225 ±  5%  numa-meminfo.node1.Shmem
>       1330 ± 38%     -35.3%     861.17 ± 89%     -56.1%     584.50 ±111%  numa-vmstat.node0.nr_active_file
>       1330 ± 38%     -35.3%     861.17 ± 89%     -56.1%     584.50 ±111%  numa-vmstat.node0.nr_zone_active_file
>     501.85 ±104%     +80.4%     905.34 ± 81%    +144.9%       1229 ± 54%  numa-vmstat.node1.nr_active_file
>      40727 ± 11%     +36.7%      55672 ± 31%     -36.3%      25940 ± 36%  numa-vmstat.node1.nr_anon_pages
>     625.02 ±197%    +149.8%       1561 ± 98%    +236.9%       2105 ± 69%  numa-vmstat.node1.nr_inactive_file
>       7628 ±  5%      -7.9%       7028 ±  3%      -0.9%       7557 ±  5%  numa-vmstat.node1.nr_shmem
>     501.85 ±104%     +80.4%     905.34 ± 81%    +144.9%       1229 ± 54%  numa-vmstat.node1.nr_zone_active_file
>     625.02 ±197%    +149.8%       1561 ± 98%    +236.9%       2105 ± 69%  numa-vmstat.node1.nr_zone_inactive_file
>       0.04 ±  8%     -30.7%       0.03 ± 13%    +542.8%       0.28 ±195%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.01 ± 15%     -25.5%       0.01 ±  8%     -11.3%       0.01 ± 20%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       3820 ±  2%     +10.2%       4210 ±  2%      +5.9%       4044 ± 10%  perf-sched.total_wait_and_delay.max.ms
>       3820 ±  2%     +10.2%       4210 ±  2%      +5.9%       4044 ± 10%  perf-sched.total_wait_time.max.ms
>       0.13 ±109%     -97.8%       0.00 ±158%     -46.6%       0.07 ±162%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast.walk_component
>       0.19 ± 88%     -85.6%       0.03 ± 62%     -93.2%       0.01 ±136%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
>       0.15 ±100%     -98.1%       0.00 ±158%     -54.5%       0.07 ±162%  perf-sched.wait_time.max.ms.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast.walk_component
>       0.55 ± 76%     -95.2%       0.03 ± 62%     -97.2%       0.02 ±124%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
>       1.63           +11.8%       1.82           +10.8%       1.81        perf-stat.i.MPKI
>  1.119e+09 ±  2%     -11.7%  9.883e+08           -11.1%  9.943e+08 ±  2%  perf-stat.i.branch-instructions
>       0.74            +0.1        0.79            +0.1        0.79 ±  2%  perf-stat.i.branch-miss-rate%
>    8657774 ±  2%      -4.7%    8250673 ±  2%      -4.8%    8244070 ±  2%  perf-stat.i.cache-misses
>   22243026 ±  3%      -6.2%   20859613 ±  2%      -5.1%   21119529 ±  3%  perf-stat.i.cache-references
>       3.76 ±  2%     +18.1%       4.43           +17.3%       4.40 ±  2%  perf-stat.i.cpi
>  1.429e+09 ±  2%     -13.5%  1.236e+09           -12.8%  1.246e+09 ±  2%  perf-stat.i.dTLB-loads
>       0.01            +0.0        0.01            +0.0        0.01 ±  3%  perf-stat.i.dTLB-store-miss-rate%
>      40681            +1.1%      41124            +2.5%      41696        perf-stat.i.dTLB-store-misses
>  6.991e+08 ±  2%     -18.2%  5.715e+08 ±  2%     -17.1%  5.796e+08 ±  3%  perf-stat.i.dTLB-stores
>  5.579e+09 ±  2%     -12.9%  4.858e+09           -12.3%  4.893e+09 ±  2%  perf-stat.i.instructions
>       0.30 ±  2%     -13.6%       0.26           -13.2%       0.26 ±  2%  perf-stat.i.ipc
>       0.06 ± 66%      -7.8%       0.05 ± 74%    +136.9%       0.14 ± 48%  perf-stat.i.major-faults
>     482.25 ±  2%      -5.8%     454.13 ±  2%      -5.0%     458.03 ±  2%  perf-stat.i.metric.K/sec
>      50.70 ±  2%     -13.9%      43.66           -13.2%      44.03 ±  2%  perf-stat.i.metric.M/sec
>    4621654 ±  3%      -5.9%    4348981 ±  2%      -6.2%    4336159 ±  2%  perf-stat.i.node-load-misses
>      86.87            +1.7       88.62            +1.3       88.20        perf-stat.i.node-store-miss-rate%
>     478923 ±  4%     -12.7%     418279 ±  6%      -8.8%     436833 ±  7%  perf-stat.i.node-stores
>       1.55 ±  2%      +9.5%       1.70            +8.6%       1.69        perf-stat.overall.MPKI
>       0.86            +0.1        0.96 ±  2%      +0.1        0.95 ±  3%  perf-stat.overall.branch-miss-rate%
>       3.58 ±  2%     +15.6%       4.14           +15.0%       4.12 ±  2%  perf-stat.overall.cpi
>       2307 ±  2%      +5.6%       2435 ±  2%      +5.8%       2440 ±  2%  perf-stat.overall.cycles-between-cache-misses
>       0.01            +0.0        0.01            +0.0        0.01 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
>       0.28 ±  2%     -13.5%       0.24           -13.0%       0.24 ±  2%  perf-stat.overall.ipc
>      87.65            +1.2       88.87            +0.7       88.37        perf-stat.overall.node-store-miss-rate%
>    1.1e+09 ±  2%     -11.7%  9.716e+08           -11.2%  9.774e+08 ±  2%  perf-stat.ps.branch-instructions
>    8518482 ±  2%      -4.7%    8118194 ±  2%      -4.8%    8112169 ±  2%  perf-stat.ps.cache-misses
>   21885056 ±  3%      -6.2%   20519540 ±  2%      -5.1%   20773225 ±  3%  perf-stat.ps.cache-references
>  1.405e+09 ±  2%     -13.5%  1.215e+09           -12.8%  1.225e+09 ±  2%  perf-stat.ps.dTLB-loads
>      39970            +1.1%      40404            +2.4%      40947        perf-stat.ps.dTLB-store-misses
>  6.877e+08 ±  2%     -18.3%  5.621e+08 ±  2%     -17.1%    5.7e+08 ±  3%  perf-stat.ps.dTLB-stores
>  5.487e+09 ±  2%     -13.0%  4.776e+09           -12.3%   4.81e+09 ±  2%  perf-stat.ps.instructions
>       0.06 ± 66%      -7.3%       0.05 ± 74%    +137.1%       0.14 ± 48%  perf-stat.ps.major-faults
>    4548215 ±  3%      -5.9%    4279880 ±  2%      -6.2%    4267801 ±  2%  perf-stat.ps.node-load-misses
>     470504 ±  4%     -12.7%     410550 ±  6%      -8.9%     428587 ±  7%  perf-stat.ps.node-stores
>  3.443e+11 ±  2%     -13.1%  2.992e+11           -12.4%  3.016e+11 ±  2%  perf-stat.total.instructions
>      18.88           -18.9        0.00           -18.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.terminate_walk
>      18.44           -18.4        0.00           -18.4        0.00        perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_lookupat.filename_lookup
>      17.06           -17.1        0.00           -17.1        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.terminate_walk.path_lookupat
>       8.57            -7.8        0.80 ±  7%      -7.8        0.76 ±  8%  perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
>      17.14            -4.6       12.53            -4.9       12.26        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup
>      17.38            -4.3       13.06            -4.5       12.85        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_path_at_empty
>       9.32            -2.4        6.89            -2.4        6.95 ±  2%  perf-profile.calltrace.cycles-pp.open64
>       9.22            -2.4        6.82            -2.3        6.87 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       9.22            -2.4        6.83            -2.3        6.88 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>       9.19            -2.4        6.80            -2.3        6.85 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       9.18            -2.4        6.80            -2.3        6.84 ±  2%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       8.63            -2.2        6.42            -2.2        6.47 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       8.59            -2.2        6.40            -2.2        6.44 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
>       7.74            -2.1        5.66 ±  2%      -2.1        5.65 ±  2%  perf-profile.calltrace.cycles-pp.__xstat64
>       7.66            -2.1        5.60 ±  2%      -2.1        5.60 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
>       7.65            -2.1        5.59 ±  2%      -2.1        5.59 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
>       7.62            -2.0        5.58 ±  2%      -2.1        5.57 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
>       7.30            -2.0        5.34 ±  2%      -2.0        5.33 ±  2%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
>       6.77            -1.8        5.00 ±  2%      -1.8        4.99 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
>       6.52            -1.7        4.78 ±  2%      -1.7        4.78 ±  2%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.48            -1.7        4.76 ±  2%      -1.7        4.75 ±  2%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
>       7.13 ±  3%      -1.5        5.63            -1.5        5.58        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk
>       5.90 ±  2%      -1.3        4.62            -1.3        4.56        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat
>       5.93 ±  2%      -1.2        4.68            -1.3        4.65 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup
>       3.25 ±  2%      -0.9        2.40            -0.8        2.45 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>       1.67            -0.9        0.82 ±  3%      -0.8        0.83 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
>       3.22 ±  2%      -0.8        2.37 ±  3%      -0.9        2.34 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
>       4.01            -0.8        3.19 ±  2%      -0.8        3.18 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
>       1.67 ±  7%      -0.7        0.96 ±  4%      -0.7        0.98        perf-profile.calltrace.cycles-pp.__close
>       1.58 ±  6%      -0.7        0.90 ±  4%      -0.7        0.92        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       1.58 ±  6%      -0.7        0.90 ±  4%      -0.7        0.92        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
>       1.55 ±  7%      -0.7        0.88 ±  4%      -0.7        0.90        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       2.29 ±  7%      -0.6        1.66 ±  8%      -0.6        1.65 ±  7%  perf-profile.calltrace.cycles-pp.syscall
>       2.20 ±  7%      -0.6        1.60 ±  8%      -0.6        1.58 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
>       1.29 ±  7%      -0.6        0.68 ±  4%      -0.6        0.71        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       2.19 ±  7%      -0.6        1.59 ±  8%      -0.6        1.58 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>       2.16 ±  8%      -0.6        1.57 ±  8%      -0.6        1.56 ±  6%  perf-profile.calltrace.cycles-pp.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>       2.51 ±  2%      -0.6        1.93            -0.6        1.92        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>       2.49            -0.6        1.92            -0.6        1.91        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
>       0.84 ±  7%      -0.6        0.27 ±100%      -0.4        0.44 ± 44%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
>       2.14 ±  4%      -0.5        1.62 ±  3%      -0.5        1.63 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
>       1.93 ±  4%      -0.5        1.41 ±  3%      -0.5        1.43 ±  5%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>       2.12 ±  3%      -0.5        1.61 ±  3%      -0.5        1.62 ±  2%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
>       1.14 ±  3%      -0.5        0.64 ±  6%      -0.5        0.67 ±  7%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.path_lookupat.filename_lookup
>       1.35 ±  6%      -0.5        0.86 ±  5%      -0.5        0.86 ±  4%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
>       1.64 ±  5%      -0.5        1.16 ±  7%      -0.5        1.18 ±  6%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.98 ±  4%      -0.5        1.52            -0.4        1.54 ±  2%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_openat
>       2.00 ±  4%      -0.5        1.55            -0.4        1.58 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.do_filp_open
>       2.00 ±  4%      -0.5        1.55            -0.4        1.58 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sys_openat2
>       1.94 ±  3%      -0.4        1.51 ±  3%      -0.5        1.48 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.vfs_statx
>       1.08 ± 33%      -0.4        0.66 ±  3%      -0.4        0.68 ±  7%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
>       1.39 ±  3%      -0.4        0.98 ±  4%      -0.4        0.98 ±  4%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
>       1.19 ±  5%      -0.3        0.84 ±  7%      -0.3        0.84 ±  5%  perf-profile.calltrace.cycles-pp.user_get_super.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>       1.01 ± 18%      -0.3        0.67 ±  4%      -0.4        0.66 ±  5%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
>       0.79 ±  6%      -0.3        0.47 ± 46%      -0.3        0.48 ± 46%  perf-profile.calltrace.cycles-pp.shmem_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64
>       0.98 ± 13%      -0.3        0.67 ±  3%      -0.3        0.68 ±  7%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
>       1.11 ±  2%      -0.3        0.83 ±  3%      -0.3        0.84 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
>       1.12 ±  2%      -0.3        0.84 ±  3%      -0.3        0.85 ±  2%  perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
>       0.99 ±  6%      -0.3        0.74 ±  3%      -0.3        0.73 ±  3%  perf-profile.calltrace.cycles-pp.fstatfs64
>       0.82 ±  7%      -0.2        0.59 ±  7%      -0.2        0.59 ±  4%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
>       0.81 ±  7%      -0.2        0.61 ±  3%      -0.2        0.61 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatfs64
>       0.79 ±  7%      -0.2        0.60 ±  4%      -0.2        0.60 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatfs64
>       0.74 ±  7%      -0.2        0.56 ±  4%      -0.2        0.56 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_fstatfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatfs64
>       0.66 ±  5%      +0.2        0.88 ±  4%      +0.2        0.89 ±  6%  perf-profile.calltrace.cycles-pp.down_read.walk_component.path_lookupat.filename_lookup.user_path_at_empty
>       0.57 ±  5%      +0.2        0.80 ±  5%      +0.3        0.84 ±  3%  perf-profile.calltrace.cycles-pp.__legitimize_mnt.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
>       0.00            +0.6        0.61 ±  6%      +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel
>       0.00            +0.7        0.72 ±  7%      +0.7        0.69 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
>       0.00            +0.8        0.78 ±  7%      +0.7        0.75 ±  8%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
>       0.00            +1.2        1.24            +1.2        1.23 ±  5%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_lookupat.filename_lookup
>      31.75            +1.4       33.19            +1.2       32.95        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
>       0.00            +1.7        1.70 ±  2%      +1.7        1.69 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
>       0.00            +1.7        1.75            +1.7        1.74        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
>       5.79 ±  2%      +2.5        8.30            +2.4        8.21 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
>       6.47            +2.6        9.06            +2.5        9.02        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
>       6.97            +2.6        9.62            +2.6        9.57        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
>       7.13            +2.8        9.93            +2.9        9.99        perf-profile.calltrace.cycles-pp.step_into.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
>       6.55            +3.0        9.54            +3.0        9.60        perf-profile.calltrace.cycles-pp.dput.step_into.path_lookupat.filename_lookup.user_path_at_empty
>      17.13 ±  2%      +4.5       21.66            +4.4       21.55        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
>      16.40            +5.5       21.86            +5.4       21.79        perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
>      16.35            +5.5       21.82            +5.4       21.75        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty
>      13.19            +5.6       18.77            +5.6       18.74        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.user_path_at_empty
>      11.12 ±  2%      +6.0       17.09            +5.9       16.99        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
>      10.54 ±  2%      +6.1       16.61            +6.0       16.51        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
>      11.69 ±  2%      +6.2       17.90 ±  2%      +6.1       17.84        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.path_lookupat
>      11.71 ±  2%      +6.2       17.92 ±  2%      +6.1       17.85        perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.path_lookupat.filename_lookup
>      68.92            +6.4       75.32            +6.1       74.98        perf-profile.calltrace.cycles-pp.__statfs
>      68.63            +6.5       75.10            +6.1       74.76        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__statfs
>      68.58            +6.5       75.06            +6.2       74.73        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
>      68.45            +6.5       74.98            +6.2       74.64        perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
>      68.22            +6.6       74.80            +6.2       74.46        perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
>      65.82            +7.3       73.09            +6.9       72.76        perf-profile.calltrace.cycles-pp.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +7.4        7.43            +7.5        7.48        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
>      63.75            +7.5       71.23            +7.2       70.93        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
>      63.59            +7.5       71.10            +7.2       70.81        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs
>       0.00            +8.6        8.58            +8.6        8.64        perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.path_lookupat
>       0.00            +9.3        9.34            +9.4        9.40        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.path_lookupat.filename_lookup
>       0.00           +21.7       21.74           +21.7       21.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_lookupat
>       0.00           +22.0       22.02           +22.0       21.98        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_lookupat.filename_lookup
>      29.00           -29.0        0.00           -29.0        0.00        perf-profile.children.cycles-pp.fast_dput
>       8.50            -8.5        0.00            -8.5        0.00        perf-profile.children.cycles-pp.lock_for_kill
>      17.17            -4.6       12.56            -4.9       12.31        perf-profile.children.cycles-pp.d_alloc_parallel
>      17.42            -4.3       13.08            -4.5       12.88        perf-profile.children.cycles-pp.__lookup_slow
>      13.42            -3.5        9.91            -3.5        9.92 ±  2%  perf-profile.children.cycles-pp.link_path_walk
>       9.35            -2.4        6.91            -2.4        6.97 ±  2%  perf-profile.children.cycles-pp.open64
>       9.37            -2.4        6.98            -2.4        7.01 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
>       9.36            -2.4        6.97            -2.4        7.00 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
>       8.81            -2.2        6.60            -2.2        6.63 ±  2%  perf-profile.children.cycles-pp.do_filp_open
>       8.78            -2.2        6.58            -2.2        6.61 ±  2%  perf-profile.children.cycles-pp.path_openat
>       7.77            -2.1        5.68 ±  2%      -2.1        5.67 ±  2%  perf-profile.children.cycles-pp.__xstat64
>       7.67            -2.0        5.62 ±  2%      -2.1        5.61 ±  2%  perf-profile.children.cycles-pp.__do_sys_newstat
>       7.35            -2.0        5.38 ±  2%      -2.0        5.38 ±  2%  perf-profile.children.cycles-pp.vfs_statx
>      38.44            -1.2       37.22            -1.3       37.12        perf-profile.children.cycles-pp.dput
>       2.71 ±  6%      -0.9        1.76 ±  3%      -0.9        1.77 ±  3%  perf-profile.children.cycles-pp.inode_permission
>       2.90 ±  6%      -0.8        2.10 ±  6%      -0.8        2.12 ±  4%  perf-profile.children.cycles-pp.statfs_by_dentry
>       1.70 ±  6%      -0.7        0.98 ±  4%      -0.7        1.00        perf-profile.children.cycles-pp.__close
>       1.56 ±  7%      -0.7        0.88 ±  4%      -0.7        0.90        perf-profile.children.cycles-pp.__x64_sys_close
>       1.71 ±  7%      -0.6        1.06 ±  3%      -0.6        1.08 ±  5%  perf-profile.children.cycles-pp.kernfs_iop_permission
>       2.32 ±  7%      -0.6        1.68 ±  8%      -0.7        1.66 ±  6%  perf-profile.children.cycles-pp.syscall
>       2.63 ±  2%      -0.6        2.00 ±  2%      -0.7        1.97 ±  5%  perf-profile.children.cycles-pp.lockref_put_return
>       1.30 ±  7%      -0.6        0.69 ±  4%      -0.6        0.72        perf-profile.children.cycles-pp.__fput
>       2.11 ±  7%      -0.6        1.51 ±  7%      -0.6        1.54 ±  6%  perf-profile.children.cycles-pp.__percpu_counter_sum
>       2.16 ±  7%      -0.6        1.57 ±  8%      -0.6        1.56 ±  6%  perf-profile.children.cycles-pp.__do_sys_ustat
>       1.59 ±  3%      -0.5        1.04 ±  5%      -0.5        1.12 ±  8%  perf-profile.children.cycles-pp.__d_lookup_rcu
>       1.93 ±  4%      -0.5        1.41 ±  3%      -0.5        1.44 ±  5%  perf-profile.children.cycles-pp.do_open
>       2.07 ±  2%      -0.5        1.57 ±  3%      -0.5        1.60 ±  4%  perf-profile.children.cycles-pp.complete_walk
>       1.39 ±  2%      -0.4        0.95 ±  5%      -0.4        0.98 ±  5%  perf-profile.children.cycles-pp.lockref_get
>       1.39 ±  4%      -0.4        0.99 ±  4%      -0.4        0.99 ±  4%  perf-profile.children.cycles-pp.do_dentry_open
>       2.48 ±  6%      -0.4        2.08 ±  3%      -0.4        2.12        perf-profile.children.cycles-pp.down_read
>       1.39 ±  7%      -0.4        1.01 ±  9%      -0.4        1.03 ±  7%  perf-profile.children.cycles-pp.shmem_statfs
>       0.50            -0.4        0.14 ± 16%      -0.4        0.12 ± 14%  perf-profile.children.cycles-pp._raw_spin_trylock
>       0.62 ±  8%      -0.4        0.26 ±  6%      -0.4        0.26 ±  6%  perf-profile.children.cycles-pp.dcache_dir_close
>       1.12 ± 23%      -0.4        0.76 ±  2%      -0.3        0.79 ±  3%  perf-profile.children.cycles-pp.try_to_unlazy_next
>       1.19 ±  6%      -0.4        0.84 ±  7%      -0.3        0.84 ±  5%  perf-profile.children.cycles-pp.user_get_super
>       1.20 ±  6%      -0.3        0.86 ±  5%      -0.3        0.87 ±  4%  perf-profile.children.cycles-pp.getname_flags
>       0.87 ±  5%      -0.3        0.54 ±  4%      -0.3        0.55 ±  8%  perf-profile.children.cycles-pp.__traverse_mounts
>       0.40 ± 43%      -0.3        0.10 ± 14%      -0.3        0.10 ± 11%  perf-profile.children.cycles-pp.ret_from_fork
>       0.40 ± 43%      -0.3        0.10 ± 13%      -0.3        0.10 ± 11%  perf-profile.children.cycles-pp.ret_from_fork_asm
>       0.40 ± 44%      -0.3        0.10 ± 11%      -0.3        0.10 ± 11%  perf-profile.children.cycles-pp.kthread
>       1.08 ±  8%      -0.3        0.78 ±  3%      -0.3        0.78 ±  9%  perf-profile.children.cycles-pp.up_read
>       0.97 ±  5%      -0.3        0.70 ±  5%      -0.3        0.71 ±  6%  perf-profile.children.cycles-pp.ext4_statfs
>       1.05 ±  6%      -0.3        0.78 ±  3%      -0.3        0.77 ±  3%  perf-profile.children.cycles-pp.fstatfs64
>       0.77 ±  8%      -0.2        0.55 ±  6%      -0.2        0.56 ±  5%  perf-profile.children.cycles-pp.strncpy_from_user
>       0.83 ±  4%      -0.2        0.64 ±  4%      -0.2        0.62 ±  5%  perf-profile.children.cycles-pp.path_put
>       0.56 ± 18%      -0.2        0.38 ±  6%      -0.2        0.40 ± 12%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
>       0.63 ±  5%      -0.2        0.45            -0.2        0.44 ±  8%  perf-profile.children.cycles-pp._find_next_or_bit
>       0.74 ±  8%      -0.2        0.56 ±  4%      -0.2        0.57 ±  3%  perf-profile.children.cycles-pp.__do_sys_fstatfs
>       0.59 ±  7%      -0.2        0.42 ±  9%      -0.2        0.40 ± 10%  perf-profile.children.cycles-pp.__d_lookup
>       0.65 ±  7%      -0.2        0.49 ±  5%      -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.fd_statfs
>       0.52 ±  5%      -0.2        0.36 ±  8%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.dcache_dir_open
>       0.52 ±  5%      -0.2        0.36 ±  8%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.d_alloc_cursor
>       0.52 ± 11%      -0.2        0.37 ± 10%      -0.2        0.35 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
>       0.60 ±  4%      -0.1        0.46 ±  8%      -0.2        0.45 ±  6%  perf-profile.children.cycles-pp.alloc_empty_file
>       0.45 ±  7%      -0.1        0.32 ±  6%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
>       0.42 ± 11%      -0.1        0.29 ±  7%      -0.2        0.25 ±  7%  perf-profile.children.cycles-pp.path_init
>       0.44 ±  5%      -0.1        0.32 ±  8%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.security_file_alloc
>       0.39 ±  8%      -0.1        0.28 ±  6%      -0.1        0.27 ± 10%  perf-profile.children.cycles-pp.__check_object_size
>       0.46 ±  5%      -0.1        0.35 ±  8%      -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.init_file
>       0.45 ±  6%      -0.1        0.34 ±  7%      -0.1        0.32 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc
>       0.32 ±  6%      -0.1        0.21 ±  5%      -0.1        0.20 ±  9%  perf-profile.children.cycles-pp.super_lock
>       0.39 ±  7%      -0.1        0.28 ±  8%      -0.1        0.30 ±  9%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
>       0.34 ± 11%      -0.1        0.23 ±  8%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.nd_jump_root
>       0.23 ± 11%      -0.1        0.13 ± 13%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.apparmor_file_free_security
>       0.23 ± 12%      -0.1        0.14 ± 13%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.security_file_free
>       0.28 ± 11%      -0.1        0.20 ±  6%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.open_last_lookups
>       0.26 ±  8%      -0.1        0.18 ±  6%      -0.1        0.20 ±  8%  perf-profile.children.cycles-pp._copy_to_user
>       0.25 ±  5%      -0.1        0.18 ±  5%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.ioctl
>       0.18 ±  7%      -0.1        0.11 ± 10%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.generic_permission
>       0.19 ± 12%      -0.1        0.13 ± 11%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.set_root
>       0.18 ±  9%      -0.1        0.12 ± 10%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.generic_fillattr
>       0.19 ±  8%      -0.1        0.14 ±  7%      -0.1        0.13 ± 12%  perf-profile.children.cycles-pp.check_heap_object
>       0.18 ±  7%      -0.1        0.12 ± 11%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.simple_statfs
>       0.17 ± 12%      -0.1        0.12 ± 10%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.vfs_getattr_nosec
>       0.30 ± 10%      -0.1        0.24 ±  7%      -0.1        0.21 ± 11%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.17 ±  3%      -0.1        0.12 ±  4%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       0.15 ±  8%      -0.1        0.10 ± 16%      -0.1        0.09 ± 28%  perf-profile.children.cycles-pp.vfs_statfs
>       0.12 ±  4%      -0.1        0.06 ± 14%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.may_open
>       0.13 ± 12%      -0.1        0.08 ± 13%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.security_file_open
>       0.13 ± 13%      -0.1        0.08 ± 14%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.apparmor_file_open
>       0.14 ±  5%      -0.0        0.09 ± 10%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.common_perm_cond
>       0.19 ± 12%      -0.0        0.14 ±  3%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.do_statfs_native
>       0.15 ±  6%      -0.0        0.10 ±  5%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.security_inode_getattr
>       0.21 ±  6%      -0.0        0.17 ±  8%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.__cond_resched
>       0.12 ± 27%      -0.0        0.08 ± 14%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.autofs_d_manage
>       0.14 ± 11%      -0.0        0.10 ± 18%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.filp_flush
>       0.08 ± 17%      -0.0        0.05 ± 48%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.fsnotify_grab_connector
>       0.07 ± 12%      -0.0        0.04 ± 45%      -0.1        0.02 ±142%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>       0.10 ± 17%      -0.0        0.07 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__x64_sys_ioctl
>       0.11 ±  9%      -0.0        0.08 ±  8%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__check_heap_object
>       0.10 ±  7%      -0.0        0.07 ±  9%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.stress_sysinfo
>       0.09 ± 14%      -0.0        0.07 ±  8%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.__virt_addr_valid
>       0.10 ± 13%      +0.1        0.15 ± 10%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.___d_drop
>       0.01 ±200%      +0.1        0.08 ± 12%      +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.__wake_up
>       0.03 ± 82%      +0.1        0.12 ±  3%      +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.__d_lookup_unhash
>       0.07 ± 10%      +0.1        0.18 ±  8%      +0.1        0.22 ± 13%  perf-profile.children.cycles-pp.__d_rehash
>       1.08 ±  3%      +0.2        1.23 ±  7%      +0.3        1.33 ±  8%  perf-profile.children.cycles-pp.__legitimize_mnt
>       0.11 ± 13%      +0.2        0.30 ±  5%      +0.2        0.29 ±  6%  perf-profile.children.cycles-pp.__call_rcu_common
>       0.00            +0.2        0.21 ±  7%      +0.2        0.21 ± 10%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
>       0.21 ± 11%      +0.3        0.48 ±  3%      +0.3        0.52 ±  8%  perf-profile.children.cycles-pp.__d_add
>       0.22 ±  9%      +0.3        0.49 ±  4%      +0.3        0.54 ±  8%  perf-profile.children.cycles-pp.simple_lookup
>      33.96            +0.8       34.74            +0.6       34.52        perf-profile.children.cycles-pp.walk_component
>       8.16            +2.4       10.57            +2.5       10.64        perf-profile.children.cycles-pp.step_into
>       7.00            +2.6        9.64            +2.6        9.59        perf-profile.children.cycles-pp.d_alloc
>      22.54            +3.1       25.68            +3.0       25.50        perf-profile.children.cycles-pp.lockref_get_not_dead
>      22.81            +3.7       26.49            +3.7       26.46        perf-profile.children.cycles-pp.__legitimize_path
>      21.77            +4.0       25.80            +4.0       25.74        perf-profile.children.cycles-pp.try_to_unlazy
>      21.12            +4.4       25.50            +4.3       25.42        perf-profile.children.cycles-pp.terminate_walk
>      15.42            +4.9       20.34            +4.9       20.32        perf-profile.children.cycles-pp.lookup_fast
>      70.33            +5.7       76.06            +5.4       75.76        perf-profile.children.cycles-pp.filename_lookup
>      63.07            +5.7       68.81            +5.4       68.51        perf-profile.children.cycles-pp._raw_spin_lock
>      70.14            +5.8       75.93            +5.5       75.63        perf-profile.children.cycles-pp.path_lookupat
>      58.67            +6.1       64.81            +5.8       64.51        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>      69.05            +6.4       75.42            +6.0       75.08        perf-profile.children.cycles-pp.__statfs
>      68.46            +6.5       74.98            +6.2       74.65        perf-profile.children.cycles-pp.__do_sys_statfs
>      68.23            +6.6       74.81            +6.2       74.47        perf-profile.children.cycles-pp.user_statfs
>      65.85            +7.3       73.10            +6.9       72.77        perf-profile.children.cycles-pp.user_path_at_empty
>       0.79 ±  5%      +9.6       10.40            +9.6       10.43        perf-profile.children.cycles-pp.__dentry_kill
>       2.73 ±  2%      -1.1        1.68            -1.1        1.65 ±  4%  perf-profile.self.cycles-pp.lockref_get_not_dead
>       2.60            -0.6        1.98 ±  2%      -0.7        1.94 ±  5%  perf-profile.self.cycles-pp.lockref_put_return
>       1.56 ±  3%      -0.5        1.02 ±  5%      -0.5        1.10 ±  8%  perf-profile.self.cycles-pp.__d_lookup_rcu
>       4.40 ±  2%      -0.4        3.98 ±  3%      -0.4        4.00 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
>       2.42 ±  6%      -0.4        2.04 ±  3%      -0.4        2.07        perf-profile.self.cycles-pp.down_read
>       0.50 ±  2%      -0.4        0.14 ± 16%      -0.4        0.12 ± 14%  perf-profile.self.cycles-pp._raw_spin_trylock
>       1.30 ±  7%      -0.4        0.94 ±  8%      -0.3        0.97 ±  8%  perf-profile.self.cycles-pp.__percpu_counter_sum
>       1.07 ±  7%      -0.3        0.77 ±  3%      -0.3        0.77 ±  8%  perf-profile.self.cycles-pp.up_read
>       0.75 ±  2%      -0.3        0.47 ±  6%      -0.2        0.52 ±  9%  perf-profile.self.cycles-pp.lockref_get
>       0.85 ±  6%      -0.2        0.60 ±  8%      -0.3        0.58 ±  6%  perf-profile.self.cycles-pp.inode_permission
>       0.56 ±  6%      -0.2        0.40 ±  6%      -0.1        0.42 ±  2%  perf-profile.self.cycles-pp.user_get_super
>       0.40 ± 12%      -0.1        0.26 ±  9%      -0.2        0.24 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.49 ±  4%      -0.1        0.35 ±  3%      -0.1        0.34 ± 10%  perf-profile.self.cycles-pp._find_next_or_bit
>       0.37 ±  6%      -0.1        0.26 ±  6%      -0.1        0.26 ±  5%  perf-profile.self.cycles-pp.do_dentry_open
>       0.39 ±  6%      -0.1        0.28 ±  8%      -0.1        0.30 ±  8%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
>       0.38 ±  8%      -0.1        0.27 ±  7%      -0.1        0.29 ±  6%  perf-profile.self.cycles-pp.strncpy_from_user
>       0.23 ± 11%      -0.1        0.13 ± 13%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.apparmor_file_free_security
>       0.26 ± 11%      -0.1        0.17 ± 10%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.link_path_walk
>       0.25 ±  8%      -0.1        0.18 ±  9%      -0.1        0.18 ±  7%  perf-profile.self.cycles-pp._copy_to_user
>       0.25 ±  6%      -0.1        0.19 ±  5%      -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.shmem_statfs
>       0.37 ±  5%      -0.1        0.31 ±  8%      -0.0        0.32 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.26 ±  6%      -0.1        0.20 ± 10%      -0.1        0.19 ±  9%  perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.14 ±  8%      -0.1        0.08 ± 16%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.generic_permission
>       0.18 ±  7%      -0.1        0.12 ± 11%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.simple_statfs
>       0.17 ± 11%      -0.1        0.11 ± 12%      -0.1        0.11 ± 12%  perf-profile.self.cycles-pp.generic_fillattr
>       0.15 ± 10%      -0.1        0.09 ±  9%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.lookup_fast
>       0.18 ±  6%      -0.1        0.13 ± 12%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.filename_lookup
>       0.15 ±  9%      -0.1        0.10 ± 16%      -0.1        0.09 ± 27%  perf-profile.self.cycles-pp.vfs_statfs
>       0.19 ±  5%      -0.1        0.14 ± 12%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.statfs_by_dentry
>       0.28 ± 10%      -0.0        0.24 ±  8%      -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.13 ±  8%      -0.0        0.08 ±  8%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.common_perm_cond
>       0.13 ± 12%      -0.0        0.08 ± 14%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.apparmor_file_open
>       0.17 ± 11%      -0.0        0.13 ±  9%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__statfs
>       0.18 ±  8%      -0.0        0.14 ± 11%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.step_into
>       0.12 ±  9%      -0.0        0.08 ± 11%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
>       0.11 ±  4%      -0.0        0.08 ±  8%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.getname_flags
>       0.08 ±  9%      -0.0        0.05 ± 45%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.check_heap_object
>       0.10 ±  7%      -0.0        0.07 ±  7%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.10 ±  9%      -0.0        0.07 ± 10%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.__do_sys_statfs
>       0.08 ±  7%      -0.0        0.05 ± 47%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.13 ±  5%      -0.0        0.10 ± 10%      -0.0        0.09 ± 11%  perf-profile.self.cycles-pp.__cond_resched
>       0.07 ±  6%      -0.0        0.05 ± 45%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.__check_object_size
>       0.09 ± 11%      -0.0        0.06 ± 13%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.stress_sysinfo
>       0.10 ±  7%      -0.0        0.08 ± 12%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.__check_heap_object
>       0.10 ±  7%      -0.0        0.08 ± 10%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.do_syscall_64
>       0.09 ± 17%      -0.0        0.07 ± 20%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.set_root
>       0.09 ± 15%      -0.0        0.07 ± 11%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.__virt_addr_valid
>       0.08 ± 10%      -0.0        0.06 ± 13%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.fstatfs64
>       0.06 ± 14%      +0.0        0.10 ± 10%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.dput
>       0.10 ± 13%      +0.1        0.15 ± 10%      +0.1        0.15 ± 10%  perf-profile.self.cycles-pp.___d_drop
>       0.01 ±200%      +0.1        0.08 ±  6%      +0.1        0.08 ± 18%  perf-profile.self.cycles-pp.__d_add
>       0.03 ± 82%      +0.1        0.12 ±  6%      +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.__d_lookup_unhash
>       0.07 ± 10%      +0.1        0.18 ±  7%      +0.1        0.21 ± 15%  perf-profile.self.cycles-pp.__d_rehash
>       1.06 ±  3%      +0.2        1.21 ±  7%      +0.3        1.31 ±  8%  perf-profile.self.cycles-pp.__legitimize_mnt
>       0.00            +0.2        0.21 ±  8%      +0.2        0.21 ± 10%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
>       0.09 ± 18%      +0.3        0.39 ±  5%      +0.3        0.39 ±  5%  perf-profile.self.cycles-pp.__dentry_kill
>       0.57 ±  7%      +0.8        1.42 ±  3%      +0.7        1.23 ±  4%  perf-profile.self.cycles-pp.d_alloc_parallel
>      58.29            +5.9       64.24            +5.7       63.96        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> 
> 
> [2]
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp9/shell1/unixbench
> 
> commit:
>   e3640d37d0 ("d_prune_aliases(): use a shrink list")
>   1b738f196e ("__dentry_kill(): new locking scheme")
>   fec356fd0c ("fix for 1b738f196e from Al Viro")
> 
> 
> e3640d37d0562963 1b738f196eacb71a3ae1f1039d7 fec356fd0c7d05c7dbcbaf593c3
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>  1.364e+08 ±  6%     +16.1%  1.584e+08           +15.5%  1.575e+08        cpuidle..usage
>     441644 ± 15%     +24.0%     547554           +23.6%     546067        vmstat.system.cs
>     261268 ± 11%     +20.2%     313947           +19.9%     313253        vmstat.system.in
>   4.91e+08           -15.4%  4.154e+08           -15.3%   4.16e+08        numa-numastat.node0.local_node
>   4.91e+08           -15.4%  4.155e+08           -15.3%   4.16e+08        numa-numastat.node0.numa_hit
>  4.872e+08           -15.1%  4.139e+08           -15.3%  4.127e+08        numa-numastat.node1.local_node
>  4.872e+08           -15.1%  4.139e+08           -15.3%  4.127e+08        numa-numastat.node1.numa_hit
>   4.91e+08           -15.4%  4.155e+08           -15.3%   4.16e+08        numa-vmstat.node0.numa_hit
>   4.91e+08           -15.4%  4.154e+08           -15.3%   4.16e+08        numa-vmstat.node0.numa_local
>  4.872e+08           -15.1%  4.139e+08           -15.3%  4.127e+08        numa-vmstat.node1.numa_hit
>  4.872e+08           -15.1%  4.139e+08           -15.3%  4.127e+08        numa-vmstat.node1.numa_local
>      94.24 ± 19%     +39.3%     131.32 ±  8%     +21.8%     114.80 ± 12%  sched_debug.cfs_rq:/.runnable_avg.min
>      80.86 ± 20%     +44.9%     117.18 ±  9%     +25.8%     101.70 ± 15%  sched_debug.cfs_rq:/.util_avg.min
>     366562 ± 25%     -25.6%     272726 ±  4%     -14.9%     312032 ± 15%  sched_debug.cpu.avg_idle.max
>      58176 ±  7%     -14.1%      49984 ±  3%      -9.2%      52808 ±  7%  sched_debug.cpu.avg_idle.stddev
>    9790886           -11.9%    8621542           -12.1%    8605511        time.involuntary_context_switches
>    1005638           -32.8%     675724 ±  3%     -31.5%     689261        time.major_page_faults
>  1.424e+09           -15.5%  1.203e+09           -15.6%  1.202e+09        time.minor_page_faults
>       5634           -16.3%       4714           -16.3%       4717        time.user_time
>  1.423e+08           +19.9%  1.706e+08           +19.5%    1.7e+08        time.voluntary_context_switches
>  1.361e+08 ±  6%     +16.1%   1.58e+08           +15.5%  1.572e+08        turbostat.C1
>       0.20 ±  5%      -9.8%       0.18 ±  8%     -12.2%       0.18        turbostat.IPC
>       0.86 ± 42%      -0.9        0.00            -0.9        0.00        turbostat.PKG_%
>     302367           +10.4%     333804           +12.5%     340026        turbostat.POLL
>       0.03 ± 13%      +0.0        0.04 ±  9%      +0.0        0.04        turbostat.POLL%
>      35237           -15.4%      29823           -15.4%      29798        unixbench.score
>    9790886           -11.9%    8621542           -12.1%    8605511        unixbench.time.involuntary_context_switches
>    1005638           -32.8%     675724 ±  3%     -31.5%     689261        unixbench.time.major_page_faults
>  1.424e+09           -15.5%  1.203e+09           -15.6%  1.202e+09        unixbench.time.minor_page_faults
>       5634           -16.3%       4714           -16.3%       4717        unixbench.time.user_time
>  1.423e+08           +19.9%  1.706e+08           +19.5%    1.7e+08        unixbench.time.voluntary_context_switches
>   94125276           -15.3%   79705880           -15.4%   79659908        unixbench.workload
>  9.783e+08           -15.2%  8.293e+08           -15.3%  8.287e+08        proc-vmstat.numa_hit
>  9.782e+08           -15.2%  8.293e+08           -15.3%  8.286e+08        proc-vmstat.numa_local
>    1370380            -6.6%    1280337            -6.7%    1278475        proc-vmstat.pgactivate
>  1.034e+09           -15.2%  8.762e+08           -15.3%  8.756e+08        proc-vmstat.pgalloc_normal
>  1.429e+09           -15.5%  1.207e+09           -15.6%  1.206e+09        proc-vmstat.pgfault
>  1.033e+09           -15.2%  8.755e+08           -15.3%  8.748e+08        proc-vmstat.pgfree
>   56430676           -15.3%   47783381           -15.4%   47750943        proc-vmstat.pgreuse
>      49542           -15.6%      41803           -15.7%      41769        proc-vmstat.thp_fault_alloc
>   20816069           -15.3%   17633995           -15.4%   17618805        proc-vmstat.unevictable_pgs_culled
>       2.74 ± 13%     +11.7%       3.06           +11.7%       3.06        perf-stat.i.MPKI
>       1.74 ±  8%      +0.1        1.84            +0.1        1.84        perf-stat.i.branch-miss-rate%
>     443434 ± 15%     +24.1%     550391           +23.7%     548526        perf-stat.i.context-switches
>     118140 ± 15%      +9.9%     129799            +9.3%     129095        perf-stat.i.cpu-migrations
>       2.99            +5.5%       3.15            +5.4%       3.15        perf-stat.overall.MPKI
>       1.83            +0.0        1.87            +0.0        1.87        perf-stat.overall.branch-miss-rate%
>       1.69           +11.3%       1.88           +11.4%       1.88        perf-stat.overall.cpi
>     566.13            +5.5%     597.00            +5.7%     598.56        perf-stat.overall.cycles-between-cache-misses
>       0.12            -0.0        0.12 ±  2%      -0.0        0.12        perf-stat.overall.dTLB-store-miss-rate%
>       0.59           -10.1%       0.53           -10.3%       0.53        perf-stat.overall.ipc
>      37.30            +1.8       39.06            +1.6       38.92        perf-stat.overall.node-store-miss-rate%
>     576160            +2.9%     592690            +2.7%     591830        perf-stat.overall.path-length
>     443139 ± 15%     +24.0%     549513           +23.6%     547703        perf-stat.ps.context-switches
>     118077 ± 15%      +9.8%     129616            +9.2%     128929        perf-stat.ps.cpu-migrations
>  5.423e+13           -12.9%  4.724e+13           -13.1%  4.714e+13        perf-stat.total.instructions
>       0.02 ± 35%     -42.5%       0.01 ± 42%     -47.8%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
>       0.02 ± 15%     -35.8%       0.01 ±  9%     -38.7%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
>       0.02 ± 73%     -57.4%       0.01 ± 40%     -64.3%       0.01 ± 30%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
>       0.04 ± 76%     -73.1%       0.01 ± 69%     -37.9%       0.03 ± 55%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
>       0.07 ±132%     -76.4%       0.02 ± 19%     -62.3%       0.03 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
>       0.04 ± 59%     -64.2%       0.01 ± 76%     -69.8%       0.01 ± 35%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
>       0.03 ±  8%     -33.5%       0.02 ± 17%     -43.3%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
>       0.01 ± 27%     -61.1%       0.00 ± 72%     -36.1%       0.00 ± 77%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.dcache_dir_close.__fput.__x64_sys_close
>       0.02 ± 15%     -26.2%       0.01 ± 18%     -30.1%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
>       0.04 ± 30%     -58.6%       0.02 ± 29%     -54.1%       0.02 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
>       0.02 ± 27%     -57.0%       0.01 ± 30%     -31.0%       0.01 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
>       0.02 ±150%     -78.4%       0.00 ± 12%     -75.5%       0.00 ± 29%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_expand
>       0.02 ± 20%     -64.3%       0.01 ± 26%     -36.6%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
>       0.03 ± 19%     -36.5%       0.02 ± 30%     -26.9%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
>       0.02 ± 87%     -40.3%       0.01 ± 85%     -62.1%       0.01 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
>       0.01 ± 24%     -14.6%       0.01 ± 55%     -48.8%       0.00 ± 54%  perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
>       0.04 ± 43%     -61.1%       0.01 ± 65%     -62.1%       0.01 ± 64%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
>       0.01           -12.5%       0.01           -10.4%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>       0.02 ± 18%     -25.9%       0.02 ± 32%     -39.9%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
>       0.02 ± 12%     -28.7%       0.02 ± 18%     -42.6%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
>       0.03 ±  3%     -14.6%       0.03 ±  9%     -10.4%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.02 ±  7%     -36.2%       0.01 ± 13%     -35.2%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>       0.02 ±  4%     -44.1%       0.01 ±  5%     -36.4%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       0.02 ± 12%     -24.5%       0.01 ±  8%     -34.0%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       0.02 ±  5%     -35.4%       0.01 ±  4%     -38.4%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>       0.02 ±  3%     -32.3%       0.01 ±  4%     -32.3%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.02 ±  3%     -44.1%       0.01 ±  3%     -44.1%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
>       0.02 ±  2%     -18.6%       0.01 ±  2%     -18.6%       0.01 ±  2%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
>       0.01 ±  4%     -30.0%       0.01 ±  4%     -30.0%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
>       0.01 ±  4%     -28.6%       0.01 ±  5%     -25.7%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
>       0.02 ±  8%     -28.2%       0.02 ± 11%     -24.2%       0.02 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>       0.02 ±  8%     -36.4%       0.01 ±  6%     -36.4%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.03           -10.6%       0.02 ±  4%     -11.8%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.05 ± 71%     -55.3%       0.02 ± 92%     -78.0%       0.01 ± 90%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.__handle_mm_fault
>       0.92 ± 34%     -49.5%       0.47 ±100%     -58.2%       0.39 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
>       0.79 ± 42%     -66.7%       0.26 ± 70%      +2.3%       0.81 ± 63%  perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
>       0.15 ±122%     -95.1%       0.01 ± 18%     -96.0%       0.01 ± 23%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
>       1.31 ± 18%     -41.7%       0.76 ± 35%     -39.6%       0.79 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
>       0.02 ± 82%     -79.6%       0.00 ± 76%     -78.5%       0.00 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_link.insert_vm_struct.__install_special_mapping
>       0.18 ±216%     -97.2%       0.01 ± 30%     -98.2%       0.00 ± 61%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.alloc_bprm.do_execveat_common.isra
>       0.08 ±126%     -91.5%       0.01 ± 22%     -94.2%       0.00 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.01 ± 31%     -64.3%       0.00 ± 75%     -42.9%       0.00 ± 76%  perf-sched.sch_delay.max.ms.__cond_resched.dput.dcache_dir_close.__fput.__x64_sys_close
>       0.96 ± 32%     -65.2%       0.33 ± 22%     -51.3%       0.47 ± 26%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
>       0.13 ±121%     -74.0%       0.03 ±165%     -91.0%       0.01 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_cow_fault.do_fault
>       1.06 ± 42%     -53.8%       0.49 ± 47%     -68.5%       0.33 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
>       0.48 ± 68%     -76.7%       0.11 ± 90%     -54.2%       0.22 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
>       0.49 ± 43%     -59.3%       0.20 ± 69%     -40.0%       0.30 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
>       0.76 ± 29%     -69.9%       0.23 ± 65%     -15.5%       0.64 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
>       0.35 ± 90%     -37.0%       0.22 ±127%     -80.2%       0.07 ±105%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
>       0.36 ± 56%     -53.8%       0.17 ± 77%     -73.6%       0.10 ± 73%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
>       0.25 ±154%     -93.0%       0.02 ± 74%     -40.8%       0.15 ±107%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       7.41 ± 15%     +31.6%       9.75 ± 11%     +21.6%       9.01 ± 11%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
>       1.55 ±  8%     -29.7%       1.09 ±  9%     -26.3%       1.14 ± 29%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
>       2.91 ± 81%     -60.7%       1.14 ± 13%     -27.8%       2.10 ±110%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
>       1.51 ±  7%     -17.8%       1.24 ± 13%     -22.7%       1.17 ± 22%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
>      23.59 ±  6%      +9.9%      25.94 ± 14%     +12.1%      26.45 ±  4%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>       1.89 ±  8%      +5.6%       2.00 ± 14%     +31.2%       2.48 ± 21%  perf-sched.sch_delay.max.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.02           -19.3%       0.02 ±  3%     -20.2%       0.02 ±  2%  perf-sched.total_sch_delay.average.ms
>       1.52           -10.0%       1.37           -10.1%       1.37        perf-sched.total_wait_and_delay.average.ms
>    1435243           +13.3%    1626751           +13.5%    1629491        perf-sched.total_wait_and_delay.count.ms
>       1.50            -9.8%       1.35           -10.0%       1.35        perf-sched.total_wait_time.average.ms
>      22.26 ± 26%     -41.9%      12.94 ± 38%     -38.2%      13.76 ± 47%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
>       1.37 ± 73%     +93.0%       2.65 ± 15%    +143.6%       3.35 ± 44%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
>       1.54 ±116%    +198.3%       4.61 ± 64%    +207.3%       4.75 ± 29%  perf-sched.wait_and_delay.avg.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
>       2.61 ± 75%    +137.8%       6.21 ± 45%    +101.5%       5.26 ± 39%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
>       5.01 ± 30%     +60.3%       8.03 ± 39%     +60.0%       8.02 ± 27%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
>       3.22 ± 67%     +95.1%       6.29 ± 40%      +5.0%       3.38 ± 55%  perf-sched.wait_and_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
>       3.54           +18.6%       4.20           +18.4%       4.19        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       6.54           +13.3%       7.41           +13.2%       7.40        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       1.90           +22.2%       2.32           +26.2%       2.40        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>      24.82 ±  3%      -9.8%      22.38 ±  3%      -9.5%      22.45 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       0.26           -16.6%       0.22           -16.7%       0.22        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
>       0.24           -11.4%       0.21           -11.4%       0.21        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
>       0.24           -16.3%       0.20           -16.5%       0.20        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
>       0.16           -17.9%       0.13           -17.6%       0.13        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
>       0.31 ± 10%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
>       0.12 ±  5%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
>       0.24 ±  4%     -12.8%       0.21 ±  5%     -12.1%       0.21 ±  3%  perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       7.03           +11.1%       7.81           +10.6%       7.78        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      11.50 ± 14%     -59.4%       4.67 ± 81%     -39.1%       7.00 ± 54%  perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
>     103.17 ± 11%     -31.0%      71.17 ± 13%     -29.9%      72.33 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
>     136.83 ±  7%     -27.3%      99.50 ± 13%     -23.5%     104.67 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
>     676.67 ±  4%     -35.9%     433.83 ±  6%     -31.3%     465.00 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
>      36.83 ± 11%     -42.1%      21.33 ± 51%     -20.8%      29.17 ± 17%  perf-sched.wait_and_delay.count.__cond_resched.dput.__fput.task_work_run.do_exit
>       4131           -20.5%       3284           -20.6%       3281        perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      43604           -13.4%      37756           -13.0%      37942        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>      15.83 ± 22%     +45.3%      23.00 ± 34%     +61.1%      25.50 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
>     468.00 ±  3%     -23.6%     357.50 ±  5%     -21.4%     368.00 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
>       1.50 ±126%    +211.1%       4.67 ± 58%    +288.9%       5.83 ± 34%  perf-sched.wait_and_delay.count.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>     838.83 ±  4%     -14.9%     714.00 ±  4%     -13.5%     725.33 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
>      94940           -10.3%      85118           -10.2%      85273        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>      75003           -10.4%      67207           -10.2%      67318        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>      40580           -22.7%      31376           -24.2%      30777        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
>      74192            +9.9%      81531           +11.1%      82410        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
>     832443           +30.9%    1089632           +31.1%    1091462        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
>      11573 ±  4%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
>      13294 ±  6%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
>      21167           -10.4%      18974           -10.2%      19016        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>      10543           -10.4%       9447           -10.2%       9471        perf-sched.wait_and_delay.count.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      35.12 ±  3%    +919.7%     358.10 ±126%    +919.6%     358.05 ±126%  perf-sched.wait_and_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
>      34.12 ±  6%    +481.1%     198.26 ±180%     +12.1%      38.23 ±  2%  perf-sched.wait_and_delay.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
>      32.50 ±  5%      +6.3%      34.54 ± 11%     +14.4%      37.17        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
>      33.13 ±  5%      +9.5%      36.27 ±  3%     +10.2%      36.50 ±  8%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
>      13.58 ± 87%    +107.6%      28.20 ± 45%    +122.1%      30.17 ± 29%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
>      26.37 ± 36%     +17.1%      30.87 ± 34%     +34.7%      35.50 ±  7%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
>      27.24 ± 35%     +26.6%      34.48 ±  8%     +36.5%      37.19 ±  3%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
>      32.13 ±  7%    +511.2%     196.40 ±183%     +14.3%      36.73 ±  5%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
>      31.01 ± 16%     -51.4%      15.06 ± 56%      -6.9%      28.87 ± 34%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
>      34.54 ±  3%      +8.3%      37.41 ±  3%      +6.3%      36.71 ±  2%  perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
>      12.72 ±  8%     +21.7%      15.48 ±  9%     +31.2%      16.68 ± 16%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
>       6.20 ± 12%     -26.5%       4.56 ± 15%      -8.4%       5.67 ± 23%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
>      35.18 ±  6%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
>       3.84 ± 13%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
>      22.26 ± 26%     -41.9%      12.94 ± 38%     -38.2%      13.76 ± 47%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
>       0.19 ±  3%     -18.3%       0.16 ±  3%     -19.3%       0.15 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
>       0.23 ±  6%     -15.0%       0.19 ±  8%     -14.3%       0.20 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.change_pmd_range.isra.0.change_protection_range
>       0.22 ±  4%     -17.4%       0.18 ±  3%     -14.9%       0.18 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
>       0.21           -13.8%       0.18           -13.5%       0.18        perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
>       0.19 ± 46%     -41.2%       0.11 ± 68%     -54.6%       0.09 ± 62%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__anon_vma_prepare.do_cow_fault.do_fault
>       0.18 ± 13%     -15.3%       0.15 ± 15%     -14.2%       0.15 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.do_vmi_munmap
>       0.20 ±  7%     -17.3%       0.16 ±  5%     -19.0%       0.16 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
>       0.22 ±  5%      -8.2%       0.20 ±  7%     -12.3%       0.19 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
>       0.18 ± 31%     -23.3%       0.14 ± 23%     -44.6%       0.10 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.22 ±  7%     -14.9%       0.19 ±  8%      -8.6%       0.20 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>       1.80 ± 21%     +47.0%       2.64 ± 15%     +85.7%       3.34 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
>       0.21 ±  2%     -12.6%       0.18           -11.5%       0.19 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
>       0.20 ±  4%     -13.9%       0.17 ±  7%      -7.4%       0.19 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.lookup_open.isra
>       0.27 ±  5%     -25.8%       0.20 ±  3%     -27.9%       0.19 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
>       0.22           -13.7%       0.19           -12.8%       0.19        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
>       0.21 ±  4%      -9.2%       0.19 ±  2%      -9.5%       0.19 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
>       0.24 ± 11%     -12.6%       0.21 ±  9%     -17.3%       0.20 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
>       0.21 ±  2%     -12.2%       0.18           -11.4%       0.18        perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
>       1.68 ±100%    +175.3%       4.63 ± 63%    +181.8%       4.74 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
>       0.69 ± 16%    +107.8%       1.43 ± 42%     +90.3%       1.31 ± 50%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
>       0.21 ±  7%     -15.3%       0.18 ±  4%     -14.2%       0.18 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
>       2.81 ± 62%    +120.7%       6.20 ± 45%     +87.0%       5.25 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
>       5.00 ± 30%     +60.4%       8.02 ± 39%     +60.1%       8.00 ± 27%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
>       0.16 ±  4%     -13.6%       0.14 ± 10%     -21.0%       0.12 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
>       0.26 ± 11%     -17.3%       0.22 ±  9%     -10.9%       0.24 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
>       0.05 ± 28%     -62.0%       0.02 ± 39%     -57.7%       0.02 ± 24%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping.map_vdso
>       0.19 ±  9%     -16.7%       0.16 ±  2%     -16.0%       0.16 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
>       0.23           -14.6%       0.19 ±  2%     -12.7%       0.20 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
>       0.24 ± 16%     -17.1%       0.20 ±  6%     -24.5%       0.18 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
>       0.24 ± 15%     -34.4%       0.16 ± 17%     -45.7%       0.13 ± 53%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
>       0.22 ±  2%     -13.6%       0.19 ±  6%      -9.6%       0.20 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
>       0.01 ± 80%    +816.0%       0.08 ± 46%    +598.0%       0.06 ±121%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
>       3.33 ± 59%     +88.0%       6.27 ± 41%      +5.3%       3.51 ± 46%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
>       0.25 ±  6%     -27.0%       0.18 ±  4%     -22.4%       0.19 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
>       0.20 ±  3%     -18.9%       0.17 ±  3%     -18.7%       0.17 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
>       0.23 ±  7%     -13.1%       0.20 ±  3%     -15.9%       0.20 ±  3%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
>       3.51           +18.7%       4.17           +18.6%       4.16        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       6.50           +13.4%       7.38           +13.3%       7.37        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.14           -21.4%       0.11 ±  2%     -17.8%       0.12 ±  2%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
>       1.88           +22.6%       2.31           +26.6%       2.39        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>      24.82 ±  3%      -9.8%      22.38 ±  3%      -9.5%      22.45 ±  3%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       0.24           -13.8%       0.21           -14.1%       0.21        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
>       0.23           -10.9%       0.20           -10.9%       0.20        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
>       0.22           -15.5%       0.19           -15.9%       0.19        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
>       0.12 ± 12%     -24.4%       0.09 ±  4%     -19.8%       0.10 ± 11%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
>       0.15           -16.9%       0.12           -16.9%       0.12        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
>       0.30 ± 10%     +14.8%       0.35 ± 12%     +12.9%       0.34 ± 12%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
>       0.12 ±  5%     -22.5%       0.09 ±  5%     -28.0%       0.08 ±  6%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
>       0.22 ±  5%     -10.8%       0.20 ±  5%     -10.1%       0.20 ±  3%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       7.01           +11.1%       7.79           +10.7%       7.76        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.50 ± 37%     -26.4%       0.37 ± 21%     -40.8%       0.29 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
>       4.42 ± 66%     +96.1%       8.66 ± 19%     +62.7%       7.19 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_anonymous_page
>       1.75 ± 11%     -29.0%       1.24 ± 19%     -19.2%       1.41 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
>       9.82 ±  9%     +22.6%      12.05 ± 10%     +22.7%      12.06 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
>      35.11 ±  3%    +919.9%     358.10 ±126%    +919.8%     358.04 ±126%  perf-sched.wait_time.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
>      34.11 ±  6%    +481.0%     198.16 ±180%     +12.0%      38.19 ±  2%  perf-sched.wait_time.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
>       1.06 ± 23%     -42.4%       0.61 ± 30%     -49.8%       0.53 ± 37%  perf-sched.wait_time.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
>       1.05 ± 51%     -69.6%       0.32 ± 42%     -74.1%       0.27 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.vma_modify.mprotect_fixup
>      32.50 ±  5%      +6.3%      34.53 ± 11%     +14.4%      37.17        perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
>      33.06 ±  6%      +9.6%      36.23 ±  3%     +10.4%      36.50 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
>       1.40 ± 21%      -8.8%       1.28 ± 49%     -42.1%       0.81 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
>       0.40 ± 44%     -39.6%       0.24 ± 14%     -49.8%       0.20 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.97 ±129%     -65.9%       0.33 ± 12%     -58.8%       0.40 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
>       1.24 ± 11%     -24.6%       0.93 ± 16%     -17.4%       1.02 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
>       7.94 ± 17%     +27.2%      10.09 ± 12%      +7.5%       8.53 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
>       0.46 ± 30%     -33.6%       0.31 ± 19%     -36.8%       0.29 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_cow_fault.do_fault
>       1.43 ± 24%     -48.0%       0.75 ± 25%     -53.0%       0.67 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
>      14.60 ± 74%     +93.0%      28.19 ± 45%    +106.6%      30.16 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
>      26.36 ± 36%     +17.1%      30.86 ± 35%     +34.7%      35.50 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
>      27.23 ± 35%     +26.6%      34.47 ±  8%     +36.5%      37.18 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
>      32.12 ±  7%    +511.5%     196.39 ±183%     +14.4%      36.72 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
>       0.61 ± 31%     -58.6%       0.25 ± 43%     -59.1%       0.25 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping.map_vdso
>       1.41 ± 43%     -53.1%       0.66 ± 18%     -34.0%       0.93 ± 39%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
>       1.02 ± 78%     -43.6%       0.58 ± 38%     -64.6%       0.36 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
>      30.99 ± 16%     -51.4%      15.05 ± 56%      -6.9%      28.86 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
>       0.03 ±105%   +1059.1%       0.35 ± 39%    +719.9%       0.25 ±140%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
>      34.44 ±  3%      +8.6%      37.40 ±  3%      +6.4%      36.65 ±  2%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
>      28.01 ± 29%     +34.5%      37.66 ±  9%      +6.8%      29.90 ± 32%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>       0.35 ± 50%     -70.6%       0.10 ±103%     -45.0%       0.19 ± 43%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
>       6.75 ± 10%     +20.3%       8.13 ±  7%     +30.8%       8.83 ± 12%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
>       3.65 ± 12%     -29.2%       2.58 ± 15%      -2.4%       3.56 ± 22%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
>       4.19 ± 10%     -33.7%       2.78 ± 28%     -35.7%       2.69 ± 34%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
>       3.83 ± 13%     -34.5%       2.51 ± 21%     -37.5%       2.40 ±  9%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
>      14.35            -6.2        8.12 ±  7%      -6.6        7.75 ±  4%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      14.09            -6.2        7.90 ±  7%      -6.6        7.52 ±  4%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>      12.77 ±  2%      -6.0        6.80 ±  8%      -6.3        6.44 ±  5%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      12.75            -6.0        6.78 ±  8%      -6.3        6.42 ±  5%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.18            -4.8        4.41 ± 13%      -5.1        4.09 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
>       6.70 ±  2%      -4.3        2.40 ± 20%      -4.6        2.14 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
>       6.06 ±  3%      -4.1        2.00 ± 14%      -4.2        1.83 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
>       8.36            -4.0        4.34 ± 10%      -4.2        4.12 ±  5%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
>       5.19 ±  2%      -3.5        1.65 ± 14%      -3.7        1.52 ±  9%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
>       6.11            -3.0        3.13 ±  2%      -2.9        3.20 ±  2%  perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
>       4.80 ±  2%      -2.9        1.88 ± 14%      -3.1        1.74 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
>       5.30            -2.5        2.80 ±  9%      -2.6        2.66 ±  5%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
>       9.77            -2.4        7.32            -2.5        7.24        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.77            -2.4        7.32            -2.5        7.24        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.77            -2.4        7.32            -2.5        7.24        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       4.67 ±  2%      -2.4        2.28 ± 11%      -2.5        2.15 ±  6%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
>       4.25 ±  2%      -2.3        1.94 ± 13%      -2.5        1.80 ±  7%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
>       4.21 ±  2%      -2.3        1.91 ± 13%      -2.4        1.77 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
>       8.19            -2.3        5.89 ±  2%      -2.4        5.78        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
>       8.20            -2.3        5.90 ±  2%      -2.4        5.80        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       8.17            -2.3        5.87 ±  2%      -2.4        5.76        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
>       3.70 ±  2%      -2.3        1.41 ± 11%      -2.4        1.32 ±  6%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
>       3.48 ±  2%      -2.2        1.26 ± 12%      -2.3        1.17 ±  7%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
>       3.41 ±  2%      -2.2        1.23 ± 12%      -2.3        1.14 ±  7%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
>       3.61 ±  3%      -2.2        1.43 ± 28%      -2.5        1.16 ±  6%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
>       3.34 ±  2%      -2.1        1.20 ± 13%      -2.2        1.11 ±  7%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap
>       3.48 ±  3%      -2.1        1.35 ± 29%      -2.4        1.08 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
>       3.31 ±  2%      -2.1        1.18 ± 13%      -2.2        1.09 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.unmap_region
>       8.90            -2.1        6.82            -2.2        6.71        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.33            -2.0        7.28            -2.2        7.18        perf-profile.calltrace.cycles-pp.execve
>       9.32            -2.0        7.28            -2.2        7.16        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>       9.32            -2.0        7.28            -2.2        7.17        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
>       9.32            -2.0        7.28            -2.2        7.17        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>       9.31            -2.0        7.26            -2.1        7.16        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>       8.29            -2.0        6.29            -2.1        6.20        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
>       8.28            -2.0        6.28            -2.1        6.19        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
>       8.18            -2.0        6.19            -2.1        6.10        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
>       4.59            -1.6        2.96 ±  8%      -1.8        2.82        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       4.39            -1.6        2.79            -1.7        2.74        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
>       3.74            -1.5        2.22 ±  3%      -1.6        2.16        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
>       4.12 ±  5%      -1.5        2.65            -1.5        2.60        perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
>       3.69 ±  2%      -1.4        2.24 ±  6%      -1.5        2.15 ±  3%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
>       3.42            -1.4        1.98 ±  4%      -1.5        1.92        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
>       2.89 ±  2%      -1.3        1.58 ±  9%      -1.4        1.48 ±  4%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
>       2.36 ±  2%      -1.3        1.09 ± 10%      -1.4        0.98 ±  8%  perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
>       2.32 ±  2%      -1.3        1.06 ± 11%      -1.4        0.96 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
>       2.29 ±  3%      -1.3        1.04 ± 11%      -1.4        0.94 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
>       7.41            -1.2        6.19            -1.2        6.18        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
>       2.11 ±  3%      -1.2        0.91 ± 11%      -1.3        0.82 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
>       4.75            -1.1        3.61            -1.2        3.54        perf-profile.calltrace.cycles-pp.__libc_fork
>       6.74            -1.1        5.61            -1.1        5.61        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
>       6.70            -1.1        5.58            -1.1        5.57        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       4.19            -1.1        3.13 ±  2%      -1.1        3.07        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>       4.19            -1.1        3.13 ±  2%      -1.1        3.07        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>       4.19            -1.1        3.14 ±  2%      -1.1        3.07        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
>       4.19            -1.1        3.14 ±  2%      -1.1        3.07        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>       3.43            -1.0        2.42 ±  2%      -1.1        2.37        perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
>       3.41            -1.0        2.40 ±  2%      -1.1        2.36        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
>       5.90            -1.0        4.91            -1.0        4.91        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       5.62            -0.9        4.67            -0.9        4.68        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>       1.68            -0.7        0.96 ±  5%      -0.8        0.92        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
>       1.18 ±  3%      -0.7        0.47 ± 45%      -0.8        0.43 ± 44%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exec_mmap
>       3.70            -0.7        3.02            -0.7        3.05        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>       1.35 ±  3%      -0.7        0.70 ± 13%      -0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
>       1.27 ±  3%      -0.6        0.64 ± 14%      -0.7        0.59 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
>       3.37            -0.6        2.74            -0.6        2.77        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>       1.24 ±  4%      -0.6        0.62 ± 14%      -0.7        0.58 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
>       3.19            -0.6        2.59            -0.6        2.62        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
>       2.94            -0.5        2.42            -0.5        2.42        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
>       1.71            -0.5        1.23 ±  3%      -0.5        1.22        perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.71            -0.5        1.23 ±  3%      -0.5        1.21        perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.75            -0.5        2.28            -0.5        2.26        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>       1.22            -0.5        0.74 ±  6%      -0.5        0.71 ±  2%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.20            -0.5        0.73 ±  6%      -0.5        0.70 ±  2%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.56            -0.5        1.10 ±  3%      -0.5        1.08        perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.15            -0.5        0.69 ±  6%      -0.5        0.66 ±  2%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.41            -0.4        0.97 ±  4%      -0.5        0.95        perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
>       1.38            -0.4        0.94 ±  4%      -0.5        0.92        perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
>       2.34            -0.4        1.92            -0.4        1.91        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
>       2.19            -0.4        1.80            -0.4        1.79        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
>       1.88            -0.4        1.51            -0.3        1.54        perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
>       0.93 ±  2%      -0.4        0.57 ±  7%      -0.4        0.55 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
>       0.61            -0.4        0.25 ±100%      -0.2        0.42 ± 44%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
>       0.61            -0.4        0.25 ±100%      -0.3        0.34 ± 70%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
>       1.34 ±  3%      -0.4        0.98 ±  5%      -0.4        0.96 ±  5%  perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
>       1.32 ±  3%      -0.3        0.98 ±  5%      -0.4        0.95 ±  5%  perf-profile.calltrace.cycles-pp.elf_load.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm
>       0.59 ±  2%      -0.3        0.25 ±100%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp._IO_default_xsputn
>       1.65            -0.3        1.34            -0.3        1.36        perf-profile.calltrace.cycles-pp.setlocale
>       1.38            -0.3        1.08 ±  2%      -0.3        1.08        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
>       1.82            -0.3        1.52            -0.3        1.51        perf-profile.calltrace.cycles-pp.__mmap
>       1.79            -0.3        1.49            -0.3        1.49        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       1.79            -0.3        1.49            -0.3        1.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
>       1.36            -0.3        1.06 ±  2%      -0.3        1.06        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
>       1.30            -0.3        1.00            -0.3        0.99        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.30            -0.3        1.00            -0.3        0.99        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.75            -0.3        1.46            -0.3        1.46        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       1.73            -0.3        1.45            -0.3        1.44        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       1.08            -0.2        0.84            -0.2        0.84        perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
>       0.66 ±  2%      -0.2        0.43 ± 44%      -0.1        0.52        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups.path_openat
>       0.66 ±  2%      -0.2        0.43 ± 44%      -0.1        0.52        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
>       0.87 ±  4%      -0.2        0.64 ±  6%      -0.2        0.62 ±  5%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary.search_binary_handler
>       0.84 ±  3%      -0.2        0.61 ±  6%      -0.2        0.60 ±  5%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary
>       0.82 ±  3%      -0.2        0.59 ±  7%      -0.2        0.58 ±  6%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp
>       1.42            -0.2        1.20            -0.2        1.20        perf-profile.calltrace.cycles-pp._dl_addr
>       0.74            -0.2        0.52 ±  2%      -0.2        0.51        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.74            -0.2        0.52 ±  2%      -0.2        0.51        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.88 ±  2%      -0.2        0.67 ±  3%      -0.2        0.66        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>       1.08            -0.2        0.88            -0.2        0.89        perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
>       1.04            -0.2        0.85            -0.2        0.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
>       1.02            -0.2        0.84            -0.2        0.85        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
>       1.03            -0.2        0.85            -0.2        0.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
>       1.02            -0.2        0.83            -0.2        0.84        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
>       1.08            -0.2        0.92 ±  2%      -0.2        0.91 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
>       1.08 ±  2%      -0.2        0.92 ±  2%      -0.2        0.91        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
>       0.82            -0.2        0.66 ±  2%      -0.2        0.66 ±  2%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>       0.74 ±  2%      -0.2        0.58            -0.1        0.60        perf-profile.calltrace.cycles-pp.down_read.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
>       1.05            -0.2        0.89 ±  2%      -0.2        0.88 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
>       0.72 ±  2%      -0.2        0.56            -0.1        0.58        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.open_last_lookups.path_openat.do_filp_open
>       0.86            -0.1        0.71            -0.1        0.72        perf-profile.calltrace.cycles-pp.elf_load.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
>       0.91            -0.1        0.77 ±  2%      -0.1        0.77        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mmap.begin_new_exec
>       0.87 ±  2%      -0.1        0.74 ±  2%      -0.1        0.73        perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.73            -0.1        0.59 ±  2%      -0.1        0.60        perf-profile.calltrace.cycles-pp.wait4
>       0.71            -0.1        0.58 ±  2%      -0.1        0.58        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
>       0.82            -0.1        0.69 ±  2%      -0.1        0.68        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exec_mmap
>       0.71            -0.1        0.58 ±  2%      -0.1        0.58        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
>       0.82            -0.1        0.70            -0.1        0.70        perf-profile.calltrace.cycles-pp.__strcoll_l
>       0.76            -0.1        0.65            -0.1        0.64        perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>       0.72            -0.1        0.61 ±  2%      -0.1        0.61        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>       0.67            -0.1        0.57            -0.1        0.57 ±  2%  perf-profile.calltrace.cycles-pp.copy_strings.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.78            +0.0        0.81            +0.0        0.81        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
>       1.34            +0.1        1.39            +0.0        1.39 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat
>       1.00            +0.1        1.06            +0.1        1.06        perf-profile.calltrace.cycles-pp.open64
>       0.98            +0.1        1.05            +0.1        1.05        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       0.98            +0.1        1.05            +0.1        1.05        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>       0.97            +0.1        1.04            +0.1        1.04        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       0.97            +0.1        1.04            +0.1        1.04        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       1.38            +0.1        1.46            +0.1        1.46 ±  2%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup
>       0.73            +0.1        0.84            +0.1        0.86        perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
>       0.74            +0.1        0.85            +0.1        0.86        perf-profile.calltrace.cycles-pp.unlinkat
>       0.73            +0.1        0.85            +0.1        0.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
>       0.73            +0.1        0.85            +0.1        0.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
>       0.72            +0.1        0.84            +0.1        0.86        perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
>       0.56 ±  3%      +0.1        0.70 ±  2%      +0.1        0.69 ±  3%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
>       0.66 ±  2%      +0.2        0.83 ±  2%      +0.2        0.82 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
>       0.69 ±  2%      +0.2        0.85 ±  2%      +0.2        0.84 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
>       0.82 ±  3%      +0.2        1.01            +0.2        1.00 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
>       0.75 ±  2%      +0.2        0.96 ±  4%      +0.2        0.98 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
>       0.71 ±  3%      +0.2        0.93 ±  4%      +0.2        0.95 ±  3%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
>       0.71 ±  3%      +0.2        0.94 ±  4%      +0.2        0.95 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
>       0.71 ±  3%      +0.2        0.94 ±  4%      +0.2        0.95 ±  3%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
>       0.64 ±  3%      +0.2        0.88 ±  3%      +0.3        0.89 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_filp_open
>       0.66 ±  2%      +0.2        0.90 ±  3%      +0.3        0.92 ±  2%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
>       1.71            +0.2        1.96            +0.2        1.95        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       0.53            +0.3        0.78            +0.3        0.79 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
>       0.57 ±  2%      +0.3        0.82 ±  3%      +0.3        0.83 ±  2%  perf-profile.calltrace.cycles-pp.step_into.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
>       0.53 ±  2%      +0.3        0.79 ±  4%      +0.3        0.80 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.open_last_lookups.path_openat.do_filp_open
>       1.96            +0.3        2.30            +0.3        2.30 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
>       2.22            +0.5        2.70            +0.5        2.71 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
>       2.90            +0.5        3.41            +0.5        3.39        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       3.02            +0.5        3.54            +0.5        3.54        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       3.00            +0.5        3.53            +0.5        3.52        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       0.00            +0.5        0.55 ±  2%      +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
>       3.26            +0.6        3.81            +0.5        3.79        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       3.89            +0.6        4.48            +0.6        4.47        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       3.90            +0.6        4.49            +0.6        4.48        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       3.89            +0.6        4.48            +0.6        4.47        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       3.96            +0.6        4.56            +0.6        4.55        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>       0.00            +0.6        0.61 ±  2%      +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_lookupat
>       0.00            +0.6        0.62            +0.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_lookupat
>       0.00            +0.6        0.63 ±  2%      +0.6        0.63 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_lookupat.filename_lookup
>       3.60            +0.6        4.24 ±  2%      +0.7        4.29        perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>       1.42 ±  2%      +0.7        2.11 ±  2%      +0.7        2.11 ±  2%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
>       0.00            +0.7        0.69 ±  3%      +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open
>       0.00            +0.7        0.71 ±  3%      +0.7        0.72 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
>       2.66            +0.7        3.39            +0.7        3.38 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
>       0.00            +0.7        0.74 ±  3%      +0.7        0.75 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_openat
>       0.00            +0.7        0.75 ±  2%      +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
>       1.58 ±  2%      +0.8        2.33 ±  2%      +0.8        2.33        perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
>       0.00            +0.8        0.75 ±  2%      +0.8        0.75 ±  4%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
>       1.60 ±  2%      +0.8        2.36 ±  2%      +0.8        2.36 ±  2%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
>       0.00            +0.8        0.76 ±  4%      +0.8        0.78 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.open_last_lookups
>       0.00            +0.8        0.78 ±  4%      +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.open_last_lookups.path_openat
>       2.94            +0.8        3.74            +0.8        3.74 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.82            +0.8        3.64            +0.8        3.64 ±  2%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.81            +0.8        3.64            +0.8        3.63 ±  2%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.79            +0.8        3.62            +0.8        3.62 ±  2%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
>       2.63 ± 11%      +0.8        3.47            +0.9        3.49 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath
>       2.51 ± 10%      +0.9        3.42            +0.9        3.44        perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled
>       2.13 ±  2%      +1.0        3.12            +1.0        3.13 ±  2%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
>       3.85            +1.1        4.97 ±  4%      +1.2        5.07        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read
>       3.20            +1.3        4.55            +1.4        4.56        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
>       3.20            +1.4        4.56            +1.4        4.56        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk
>       3.56 ±  2%      +1.6        5.11            +1.6        5.13 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk.path_openat
>       3.64 ±  2%      +1.6        5.25            +1.6        5.27 ±  2%  perf-profile.calltrace.cycles-pp.down_read.walk_component.link_path_walk.path_openat.do_filp_open
>       9.02            +1.9       10.96 ±  2%      +2.2       11.22        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
>       9.10            +2.1       11.17 ±  2%      +2.3       11.42        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
>       0.00            +3.0        2.95 ±  2%      +3.0        3.02 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel
>       0.00            +3.0        3.04 ±  2%      +3.1        3.11 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
>       1.25            +3.1        4.34 ±  2%      +3.2        4.45 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
>       1.28            +3.1        4.36 ±  2%      +3.2        4.47 ±  2%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
>       0.00            +3.1        3.11 ±  2%      +3.2        3.18 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
>       2.26 ±  2%      +3.8        6.09 ±  2%      +4.0        6.21 ±  2%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
>       1.97 ±  2%      +3.9        5.84 ±  2%      +4.0        5.96 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
>       2.41            +4.0        6.45 ±  2%      +4.2        6.57 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
>       0.00            +4.1        4.06 ±  3%      +4.2        4.17 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.link_path_walk
>       2.46 ±  2%      +4.2        6.70 ±  5%      +4.3        6.75        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
>       0.00            +4.2        4.24 ±  2%      +4.4        4.35 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_openat
>       2.91            +4.2        7.16 ±  2%      +4.4        7.32        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
>       3.06            +4.4        7.44 ±  2%      +4.5        7.61        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
>       1.93 ±  2%      +4.4        6.35 ±  2%      +4.5        6.46        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
>       1.96 ±  2%      +4.5        6.45 ±  2%      +4.6        6.56        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
>       3.34            +4.6        7.91 ±  2%      +4.7        8.08        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
>       3.49            +4.6        8.08 ±  2%      +4.8        8.25 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>       3.47            +4.6        8.06 ±  2%      +4.8        8.23 ±  2%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
>       0.00            +4.6        4.64 ±  3%      +4.8        4.77 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
>      56.81            +6.1       62.89            +6.3       63.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      56.78            +6.1       62.86            +6.3       63.05        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      15.15            +7.5       22.67            +7.9       23.06        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
>       0.00            +7.8        7.81 ±  2%      +8.0        7.97 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
>       0.00            +7.9        7.86 ±  2%      +8.0        8.02 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
>      16.57           +10.6       27.14           +11.1       27.65        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
>      26.43           +15.3       41.72           +16.0       42.44        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      26.36           +15.3       41.65           +16.0       42.37        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
>      25.29           +15.3       40.58           +16.0       41.30        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      25.26           +15.3       40.56           +16.0       41.28        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      18.46 ±  2%      -9.3        9.17 ± 10%      -9.9        8.54 ±  5%  perf-profile.children.cycles-pp.down_write
>      17.62 ±  2%      -9.1        8.49 ± 11%      -9.8        7.86 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>      17.05 ±  2%      -9.0        8.05 ± 12%      -9.6        7.42 ±  6%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
>      15.24 ±  3%      -8.5        6.70 ± 13%      -9.1        6.11 ±  7%  perf-profile.children.cycles-pp.osq_lock
>       8.12            -8.1        0.00            -8.1        0.00        perf-profile.children.cycles-pp.fast_dput
>      17.23            -7.1       10.15 ±  6%      -7.5        9.73 ±  3%  perf-profile.children.cycles-pp.vm_mmap_pgoff
>      17.01            -7.0        9.97 ±  6%      -7.5        9.55 ±  3%  perf-profile.children.cycles-pp.do_mmap
>      16.65            -7.0        9.66 ±  6%      -7.4        9.24 ±  3%  perf-profile.children.cycles-pp.mmap_region
>      14.52            -6.3        8.26 ±  7%      -6.6        7.90 ±  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
>      10.35            -4.7        5.70 ±  8%      -4.9        5.42 ±  4%  perf-profile.children.cycles-pp.do_vmi_munmap
>      10.25            -4.6        5.61 ±  8%      -4.9        5.34 ±  4%  perf-profile.children.cycles-pp.do_vmi_align_munmap
>       9.30            -4.2        5.10 ±  7%      -4.5        4.84 ±  3%  perf-profile.children.cycles-pp.free_pgtables
>       7.85 ±  2%      -3.9        3.92 ± 10%      -4.2        3.66 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma
>      12.10            -3.5        8.63 ±  2%      -3.6        8.47        perf-profile.children.cycles-pp.__mmput
>      12.06            -3.5        8.60 ±  2%      -3.6        8.44        perf-profile.children.cycles-pp.exit_mmap
>       6.66            -3.3        3.37 ± 10%      -3.5        3.18 ±  5%  perf-profile.children.cycles-pp.vma_prepare
>       7.04            -3.0        4.04 ±  7%      -3.2        3.87 ±  3%  perf-profile.children.cycles-pp.__split_vma
>       9.94            -2.5        7.46            -2.6        7.39        perf-profile.children.cycles-pp.do_group_exit
>       9.94            -2.5        7.47            -2.6        7.39        perf-profile.children.cycles-pp.__x64_sys_exit_group
>       9.93            -2.5        7.46            -2.6        7.38        perf-profile.children.cycles-pp.do_exit
>      10.60            -2.3        8.26            -2.5        8.14        perf-profile.children.cycles-pp.do_execveat_common
>      10.62            -2.3        8.28            -2.5        8.16        perf-profile.children.cycles-pp.__x64_sys_execve
>       8.22            -2.3        5.92 ±  2%      -2.4        5.81        perf-profile.children.cycles-pp.exit_mm
>       8.96            -2.1        6.87            -2.2        6.77        perf-profile.children.cycles-pp.bprm_execve
>       9.33            -2.0        7.28            -2.2        7.18        perf-profile.children.cycles-pp.execve
>       4.28            -2.0        2.26 ±  8%      -2.1        2.14 ±  4%  perf-profile.children.cycles-pp.unmap_region
>       8.29            -2.0        6.29            -2.1        6.20        perf-profile.children.cycles-pp.exec_binprm
>       8.28            -2.0        6.28            -2.1        6.19        perf-profile.children.cycles-pp.search_binary_handler
>       8.18            -2.0        6.19            -2.1        6.11        perf-profile.children.cycles-pp.load_elf_binary
>      10.54            -1.7        8.80            -1.8        8.79        perf-profile.children.cycles-pp.asm_exc_page_fault
>       9.48            -1.6        7.88            -1.6        7.88        perf-profile.children.cycles-pp.exc_page_fault
>       9.43            -1.6        7.84            -1.6        7.84        perf-profile.children.cycles-pp.do_user_addr_fault
>       8.63            -1.5        7.17            -1.4        7.18        perf-profile.children.cycles-pp.handle_mm_fault
>       8.23            -1.4        6.84            -1.4        6.85        perf-profile.children.cycles-pp.__handle_mm_fault
>       5.37            -1.3        4.03 ±  2%      -1.4        3.95        perf-profile.children.cycles-pp.kernel_clone
>       4.92            -1.3        3.66 ±  2%      -1.3        3.58        perf-profile.children.cycles-pp.__do_sys_clone
>       4.82            -1.3        3.57 ±  2%      -1.3        3.50        perf-profile.children.cycles-pp.copy_process
>       4.39            -1.2        3.16            -1.3        3.10        perf-profile.children.cycles-pp.begin_new_exec
>       4.20            -1.2        3.00 ±  2%      -1.3        2.94        perf-profile.children.cycles-pp.exec_mmap
>       4.79            -1.1        3.64            -1.2        3.57        perf-profile.children.cycles-pp.__libc_fork
>       3.74            -1.1        2.60 ±  3%      -1.2        2.52        perf-profile.children.cycles-pp.dup_mm
>       3.43            -1.1        2.32 ±  4%      -1.2        2.26        perf-profile.children.cycles-pp.dup_mmap
>       5.47            -1.0        4.47            -1.0        4.51        perf-profile.children.cycles-pp.do_fault
>       5.02            -0.9        4.09            -0.9        4.13        perf-profile.children.cycles-pp.do_read_fault
>       4.85            -0.9        3.96            -0.9        3.99        perf-profile.children.cycles-pp.filemap_map_pages
>       3.58            -0.6        2.96            -0.6        2.96        perf-profile.children.cycles-pp.unmap_vmas
>       3.32            -0.6        2.74            -0.6        2.73        perf-profile.children.cycles-pp.unmap_page_range
>       2.86            -0.6        2.30            -0.5        2.34        perf-profile.children.cycles-pp.next_uptodate_folio
>       3.21            -0.6        2.66            -0.6        2.64        perf-profile.children.cycles-pp.zap_pmd_range
>       2.46            -0.6        1.90 ±  3%      -0.6        1.88 ±  3%  perf-profile.children.cycles-pp.elf_load
>       3.15            -0.5        2.60            -0.6        2.59        perf-profile.children.cycles-pp.zap_pte_range
>       1.03 ±  2%      -0.5        0.51 ± 10%      -0.5        0.48 ±  5%  perf-profile.children.cycles-pp.vma_expand
>       1.71            -0.5        1.23 ±  3%      -0.5        1.22        perf-profile.children.cycles-pp.__x64_sys_mprotect
>       1.71            -0.5        1.23 ±  3%      -0.5        1.21        perf-profile.children.cycles-pp.do_mprotect_pkey
>       1.56            -0.5        1.10 ±  3%      -0.5        1.08        perf-profile.children.cycles-pp.mprotect_fixup
>       2.14            -0.4        1.69            -0.5        1.68        perf-profile.children.cycles-pp.tlb_finish_mmu
>       1.53            -0.4        1.08 ±  3%      -0.4        1.08 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
>       1.41            -0.4        0.97 ±  4%      -0.5        0.95        perf-profile.children.cycles-pp.vma_modify
>       1.93            -0.4        1.52            -0.4        1.51        perf-profile.children.cycles-pp.tlb_batch_pages_flush
>       1.48 ±  3%      -0.4        1.09 ±  5%      -0.4        1.06 ±  5%  perf-profile.children.cycles-pp.load_elf_interp
>       1.61            -0.4        1.26            -0.4        1.24        perf-profile.children.cycles-pp.release_pages
>       1.66            -0.3        1.35            -0.3        1.37        perf-profile.children.cycles-pp.setlocale
>       1.83            -0.3        1.52            -0.3        1.52        perf-profile.children.cycles-pp.__mmap
>       1.85            -0.3        1.58            -0.3        1.55        perf-profile.children.cycles-pp.kmem_cache_alloc
>       1.24 ±  2%      -0.3        0.96 ±  3%      -0.3        0.95        perf-profile.children.cycles-pp.alloc_empty_file
>       1.69            -0.3        1.42            -0.3        1.42        perf-profile.children.cycles-pp.vma_interval_tree_insert
>       1.39            -0.2        1.14            -0.2        1.15        perf-profile.children.cycles-pp.__open64_nocancel
>       0.89 ±  3%      -0.2        0.65 ±  3%      -0.2        0.64        perf-profile.children.cycles-pp.init_file
>       1.48            -0.2        1.25            -0.2        1.24 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol
>       0.78 ±  3%      -0.2        0.55 ±  3%      -0.2        0.55 ±  2%  perf-profile.children.cycles-pp.security_file_alloc
>       1.19            -0.2        0.96            -0.2        0.96 ±  2%  perf-profile.children.cycles-pp.page_remove_rmap
>       1.41            -0.2        1.19            -0.2        1.18 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
>       1.07            -0.2        0.85 ±  2%      -0.2        0.84 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
>       1.43            -0.2        1.22            -0.2        1.21        perf-profile.children.cycles-pp._dl_addr
>       0.67 ±  4%      -0.2        0.47 ±  4%      -0.2        0.47 ±  3%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
>       1.30            -0.2        1.10 ±  2%      -0.2        1.09        perf-profile.children.cycles-pp.ret_from_fork_asm
>       1.26            -0.2        1.07 ±  2%      -0.2        1.07        perf-profile.children.cycles-pp.ret_from_fork
>       0.47 ±  4%      -0.2        0.30 ±  6%      -0.2        0.30 ±  3%  perf-profile.children.cycles-pp.security_file_free
>       0.74            -0.2        0.56 ±  2%      -0.2        0.55        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.46 ±  4%      -0.2        0.29 ±  6%      -0.2        0.30 ±  3%  perf-profile.children.cycles-pp.apparmor_file_free_security
>       1.00            -0.2        0.83            -0.2        0.82        perf-profile.children.cycles-pp.set_pte_range
>       1.06            -0.2        0.89            -0.2        0.89 ±  2%  perf-profile.children.cycles-pp.do_anonymous_page
>       0.90 ±  2%      -0.2        0.74 ±  3%      -0.2        0.74 ±  2%  perf-profile.children.cycles-pp._compound_head
>       0.97            -0.2        0.81            -0.2        0.80        perf-profile.children.cycles-pp.get_page_from_freelist
>       1.52            -0.2        1.36            -0.2        1.34        perf-profile.children.cycles-pp.kmem_cache_free
>       1.05            -0.2        0.89 ±  2%      -0.2        0.88 ±  2%  perf-profile.children.cycles-pp.kthread
>       0.86            -0.2        0.70 ±  3%      -0.2        0.69        perf-profile.children.cycles-pp.vma_complete
>       0.93            -0.2        0.78            -0.1        0.78        perf-profile.children.cycles-pp.perf_event_mmap
>       0.90            -0.1        0.76            -0.1        0.76        perf-profile.children.cycles-pp.perf_event_mmap_event
>       0.94            -0.1        0.80 ±  2%      -0.1        0.79        perf-profile.children.cycles-pp.mas_store_prealloc
>       0.73            -0.1        0.59 ±  2%      -0.1        0.60        perf-profile.children.cycles-pp.wait4
>       0.22 ±  3%      -0.1        0.08 ±  4%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
>       0.87 ±  2%      -0.1        0.74 ±  2%      -0.1        0.73        perf-profile.children.cycles-pp.smpboot_thread_fn
>       1.60            -0.1        1.47 ±  2%      -0.1        1.46        perf-profile.children.cycles-pp.__do_softirq
>       0.83            -0.1        0.70            -0.1        0.70        perf-profile.children.cycles-pp.__strcoll_l
>       0.95            -0.1        0.82            -0.1        0.81        perf-profile.children.cycles-pp.wp_page_copy
>       0.70            -0.1        0.57 ±  2%      -0.1        0.58        perf-profile.children.cycles-pp.kernel_wait4
>       0.70            -0.1        0.57 ±  2%      -0.1        0.58        perf-profile.children.cycles-pp.__do_sys_wait4
>       0.68            -0.1        0.56 ±  2%      -0.1        0.56        perf-profile.children.cycles-pp.do_wait
>       0.56 ±  3%      -0.1        0.43 ±  2%      -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.release_empty_file
>       1.38            -0.1        1.26 ±  2%      -0.1        1.24        perf-profile.children.cycles-pp.rcu_do_batch
>       1.43            -0.1        1.30 ±  2%      -0.1        1.29        perf-profile.children.cycles-pp.rcu_core
>       0.78            -0.1        0.66            -0.1        0.66 ±  2%  perf-profile.children.cycles-pp.copy_strings
>       0.66            -0.1        0.55            -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
>       0.98            -0.1        0.87            -0.1        0.86 ±  2%  perf-profile.children.cycles-pp.__slab_free
>       0.60            -0.1        0.50            -0.1        0.50        perf-profile.children.cycles-pp.perf_iterate_sb
>       0.51 ±  2%      -0.1        0.41 ±  2%      -0.1        0.42        perf-profile.children.cycles-pp.do_open
>       0.64            -0.1        0.54 ±  2%      -0.1        0.53        perf-profile.children.cycles-pp.mas_wr_store_entry
>       0.28 ±  2%      -0.1        0.18 ±  2%      -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
>       0.60            -0.1        0.50 ±  2%      -0.1        0.50        perf-profile.children.cycles-pp.copy_page_range
>       0.58            -0.1        0.48 ±  2%      -0.1        0.48        perf-profile.children.cycles-pp.copy_p4d_range
>       0.68            -0.1        0.58 ±  4%      -0.1        0.56        perf-profile.children.cycles-pp.mm_init
>       0.59            -0.1        0.50            -0.1        0.49        perf-profile.children.cycles-pp.lock_vma_under_rcu
>       0.57            -0.1        0.48 ±  4%      -0.1        0.48        perf-profile.children.cycles-pp.vma_interval_tree_remove
>       0.63 ±  2%      -0.1        0.54 ±  2%      -0.1        0.54 ±  3%  perf-profile.children.cycles-pp._IO_default_xsputn
>       0.80            -0.1        0.71            -0.1        0.69 ±  2%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
>       0.52            -0.1        0.43 ±  3%      -0.1        0.44 ±  3%  perf-profile.children.cycles-pp.vfs_read
>       0.45 ±  3%      -0.1        0.36 ±  2%      -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.dup_task_struct
>       0.54            -0.1        0.45 ±  3%      -0.1        0.46 ±  2%  perf-profile.children.cycles-pp.ksys_read
>       0.48            -0.1        0.39 ±  3%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.__fput
>       0.60            -0.1        0.51 ±  3%      -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.__mmdrop
>       0.60 ±  2%      -0.1        0.51 ±  2%      -0.1        0.51        perf-profile.children.cycles-pp.sync_regs
>       0.49            -0.1        0.40 ±  3%      -0.1        0.41 ±  2%  perf-profile.children.cycles-pp.read
>       0.50            -0.1        0.42            -0.1        0.42        perf-profile.children.cycles-pp.clear_page_erms
>       0.48 ±  4%      -0.1        0.40 ±  4%      -0.1        0.40 ±  3%  perf-profile.children.cycles-pp.run_ksoftirqd
>       1.71            -0.1        1.63            -0.1        1.62        perf-profile.children.cycles-pp.up_write
>       0.48 ±  2%      -0.1        0.39 ±  3%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.task_work_run
>       0.59            -0.1        0.50 ±  3%      -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.getname_flags
>       1.94            -0.1        1.85            -0.1        1.85        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       0.55            -0.1        0.47 ±  2%      -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio
>       0.63            -0.1        0.55            -0.1        0.54 ±  2%  perf-profile.children.cycles-pp.find_idlest_cpu
>       0.59            -0.1        0.51 ±  2%      -0.1        0.52        perf-profile.children.cycles-pp.native_irq_return_iret
>       0.46            -0.1        0.38 ±  2%      -0.1        0.38        perf-profile.children.cycles-pp.rmqueue
>       2.10            -0.1        2.02            -0.1        2.01        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.50            -0.1        0.42 ±  2%      -0.1        0.42        perf-profile.children.cycles-pp.vm_area_alloc
>       0.49            -0.1        0.41            -0.1        0.41        perf-profile.children.cycles-pp.__vfork
>       0.47            -0.1        0.39 ±  2%      -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
>       0.32 ±  5%      -0.1        0.24 ±  3%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.alloc_thread_stack_node
>       0.41 ±  3%      -0.1        0.34            -0.1        0.34        perf-profile.children.cycles-pp.folio_add_file_rmap_range
>       0.44 ±  2%      -0.1        0.36 ±  2%      -0.1        0.36        perf-profile.children.cycles-pp.mas_wr_node_store
>       0.35 ±  3%      -0.1        0.28            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.do_dentry_open
>       0.41 ±  2%      -0.1        0.34            -0.1        0.34        perf-profile.children.cycles-pp.do_task_dead
>       0.44            -0.1        0.36            -0.1        0.36        perf-profile.children.cycles-pp.do_cow_fault
>       0.45            -0.1        0.38            -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.strnlen_user
>       0.46            -0.1        0.40            -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.mas_wr_bnode
>       0.44            -0.1        0.37 ±  4%      -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
>       0.44            -0.1        0.38 ±  2%      -0.1        0.37        perf-profile.children.cycles-pp.mas_walk
>       0.38            -0.1        0.31 ±  2%      -0.1        0.31        perf-profile.children.cycles-pp.free_pages_and_swap_cache
>       0.41            -0.1        0.34 ±  3%      -0.1        0.35        perf-profile.children.cycles-pp.perf_event_mmap_output
>       0.45 ±  2%      -0.1        0.38 ±  2%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.get_arg_page
>       0.34            -0.1        0.28            -0.1        0.27 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
>       0.54            -0.1        0.48            -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
>       0.36 ±  2%      -0.1        0.29 ±  3%      -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.free_swap_cache
>       0.47 ±  2%      -0.1        0.40 ±  3%      -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.alloc_bprm
>       0.36 ±  2%      -0.1        0.30            -0.1        0.30        perf-profile.children.cycles-pp.__perf_sw_event
>       0.44            -0.1        0.38            -0.1        0.37        perf-profile.children.cycles-pp.__x64_sys_vfork
>       0.67            -0.1        0.61 ±  2%      -0.1        0.59 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
>       0.40 ±  2%      -0.1        0.34 ±  2%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.pte_alloc_one
>       0.31 ±  3%      -0.1        0.25            -0.1        0.25        perf-profile.children.cycles-pp.__rb_insert_augmented
>       0.31            -0.1        0.24 ±  2%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.lru_add_drain
>       0.39            -0.1        0.33 ±  2%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
>       0.64            -0.1        0.58            -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
>       0.40            -0.1        0.34 ±  2%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.mas_split
>       0.31            -0.1        0.25 ±  2%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.lru_add_drain_cpu
>       0.38            -0.1        0.32            -0.1        0.32        perf-profile.children.cycles-pp.mtree_range_walk
>       0.41            -0.1        0.35            -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.create_elf_tables
>       0.50            -0.1        0.44            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
>       0.31            -0.1        0.25 ±  4%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.pipe_read
>       0.29            -0.1        0.24 ±  3%      -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__do_wait
>       0.39 ±  2%      -0.1        0.33 ±  2%      -0.1        0.34        perf-profile.children.cycles-pp.setup_arg_pages
>       0.44 ±  3%      -0.1        0.38 ±  2%      -0.1        0.37        perf-profile.children.cycles-pp.__cond_resched
>       0.41 ±  2%      -0.1        0.35 ±  2%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.sched_exec
>       0.37 ±  2%      -0.1        0.31 ±  3%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.get_user_pages_remote
>       0.36 ±  2%      -0.1        0.30 ±  2%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.__get_user_pages
>       0.41 ±  2%      -0.1        0.35 ±  3%      -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
>       0.41 ±  2%      -0.1        0.36 ±  2%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.31 ±  2%      -0.1        0.25 ±  2%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
>       0.39            -0.1        0.34 ±  2%      -0.1        0.33        perf-profile.children.cycles-pp.__mem_cgroup_charge
>       0.36 ±  2%      -0.1        0.30 ±  3%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
>       0.39            -0.1        0.34 ±  5%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.pcpu_alloc
>       0.37            -0.1        0.32            -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.__vm_area_free
>       0.34            -0.1        0.28 ±  3%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.free_unref_page_commit
>       0.20 ±  5%      -0.1        0.15 ±  5%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.__vmalloc_node_range
>       0.36            -0.1        0.31 ±  2%      -0.1        0.31        perf-profile.children.cycles-pp.mas_preallocate
>       0.42 ±  2%      -0.1        0.36            -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.wake_up_new_task
>       0.29            -0.1        0.24 ±  2%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__anon_vma_prepare
>       0.33            -0.1        0.28 ±  2%      -0.1        0.28        perf-profile.children.cycles-pp.copy_pte_range
>       0.93            -0.1        0.88            -0.1        0.87 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
>       0.22 ±  2%      -0.0        0.16 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__rb_erase_color
>       0.38 ±  2%      -0.0        0.33 ±  2%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map_lock
>       0.32 ±  2%      -0.0        0.27 ±  2%      -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.get_unmapped_area
>       0.28 ±  2%      -0.0        0.23 ±  3%      -0.0        0.24        perf-profile.children.cycles-pp.mas_next_slot
>       0.37 ±  2%      -0.0        0.33            -0.0        0.33        perf-profile.children.cycles-pp.___perf_sw_event
>       0.27 ±  3%      -0.0        0.22 ±  4%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp._IO_fwrite
>       0.26 ±  2%      -0.0        0.22 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__close
>       0.32 ±  2%      -0.0        0.28            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.shift_arg_pages
>       0.22            -0.0        0.18 ±  2%      -0.1        0.17        perf-profile.children.cycles-pp.rmqueue_bulk
>       0.28 ±  2%      -0.0        0.24 ±  3%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
>       0.14 ±  9%      -0.0        0.09 ±  7%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.__get_vm_area_node
>       0.28 ±  3%      -0.0        0.23 ±  2%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
>       0.30 ±  2%      -0.0        0.26 ±  2%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.__pte_alloc
>       0.31            -0.0        0.27 ±  5%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.vfs_write
>       0.26            -0.0        0.22 ±  4%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.free_pcppages_bulk
>       0.14 ±  9%      -0.0        0.10 ± 24%      -0.1        0.09 ± 19%  perf-profile.children.cycles-pp.osq_unlock
>       0.13 ±  8%      -0.0        0.09 ± 10%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.alloc_vmap_area
>       0.30            -0.0        0.25            -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.write
>       0.24 ±  3%      -0.0        0.20 ±  3%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.__fxstat64
>       0.20 ±  9%      -0.0        0.15 ±  2%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.inode_permission
>       0.25            -0.0        0.21 ±  3%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__wp_page_copy_user
>       0.32            -0.0        0.28 ±  6%      -0.1        0.27 ±  2%  perf-profile.children.cycles-pp.ksys_write
>       1.15            -0.0        1.10            -0.1        1.10        perf-profile.children.cycles-pp.irq_exit_rcu
>       0.29            -0.0        0.24 ±  2%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
>       0.27            -0.0        0.22 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.free_unref_page
>       0.31            -0.0        0.26            -0.0        0.27 ±  2%  perf-profile.children.cycles-pp._IO_padn
>       0.28 ±  3%      -0.0        0.24 ±  5%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.memset_orig
>       0.28 ±  3%      -0.0        0.24            -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.copy_string_kernel
>       0.25            -0.0        0.21 ±  3%      -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
>       0.22 ±  3%      -0.0        0.18 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.wait_task_zombie
>       0.43 ±  2%      -0.0        0.39 ±  2%      -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       0.78 ±  2%      -0.0        0.74 ±  2%      -0.0        0.75 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.59            -0.0        0.55 ±  2%      -0.0        0.55        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
>       0.29            -0.0        0.25 ±  4%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_sum
>       0.25 ±  3%      -0.0        0.21 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__x64_sys_close
>       0.29 ±  2%      -0.0        0.26            -0.0        0.26        perf-profile.children.cycles-pp.flush_tlb_mm_range
>       0.28 ±  2%      -0.0        0.25            -0.0        0.25        perf-profile.children.cycles-pp.__check_object_size
>       0.21 ±  4%      -0.0        0.17 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.do_open_execat
>       0.11 ±  4%      -0.0        0.08 ±  6%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.security_file_open
>       0.77 ±  2%      -0.0        0.73 ±  2%      -0.0        0.73        perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.71 ±  2%      -0.0        0.68 ±  2%      -0.0        0.67 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.19 ±  3%      -0.0        0.16 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.memmove
>       0.23 ±  2%      -0.0        0.20 ±  4%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.rep_stos_alternative
>       0.22 ±  2%      -0.0        0.19            -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.__pmd_alloc
>       0.20 ±  4%      -0.0        0.17 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__close_nocancel
>       0.24            -0.0        0.21 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.mas_alloc_nodes
>       0.17 ±  2%      -0.0        0.13 ±  2%      -0.0        0.13        perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
>       0.20 ±  2%      -0.0        0.16 ±  3%      -0.0        0.16        perf-profile.children.cycles-pp.mem_cgroup_commit_charge
>       0.26 ±  2%      -0.0        0.23 ±  3%      -0.0        0.24        perf-profile.children.cycles-pp.try_charge_memcg
>       0.22 ±  2%      -0.0        0.19 ±  5%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.copy_page_to_iter
>       0.18 ±  4%      -0.0        0.15            -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__do_sys_newfstat
>       0.20 ±  2%      -0.0        0.16 ±  4%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp._exit
>       0.11 ±  3%      -0.0        0.08 ±  6%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.apparmor_file_open
>       0.20            -0.0        0.17 ±  2%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__count_memcg_events
>       0.21 ±  2%      -0.0        0.17 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
>       0.22 ±  3%      -0.0        0.18 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.map_vdso
>       0.23 ±  3%      -0.0        0.19 ±  2%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.anon_vma_clone
>       0.37 ±  2%      -0.0        0.34 ±  2%      -0.0        0.34        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       0.22 ±  2%      -0.0        0.19 ±  5%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp._copy_to_iter
>       0.22 ±  2%      -0.0        0.19 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.vm_unmapped_area
>       0.24 ±  3%      -0.0        0.21 ±  5%      -0.0        0.21 ±  5%  perf-profile.children.cycles-pp.filemap_read
>       0.19 ±  4%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.d_path
>       0.18            -0.0        0.15 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.exit_notify
>       0.26            -0.0        0.23 ±  3%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
>       0.19 ±  2%      -0.0        0.16 ±  2%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__pud_alloc
>       0.20 ±  3%      -0.0        0.17 ±  4%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.__install_special_mapping
>       0.18 ±  2%      -0.0        0.15 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mas_store_gfp
>       0.18 ±  2%      -0.0        0.15 ±  4%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.release_task
>       0.20 ±  2%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mas_find
>       0.20 ±  2%      -0.0        0.18 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.schedule_tail
>       0.18 ±  2%      -0.0        0.15 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.do_brk_flags
>       0.19 ±  3%      -0.0        0.16 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.memcg_account_kmem
>       0.20 ±  3%      -0.0        0.17 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>       0.11            -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.security_mmap_file
>       0.10            -0.0        0.07 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.wait_for_completion_state
>       0.13 ±  3%      -0.0        0.11 ±  4%      -0.0        0.11        perf-profile.children.cycles-pp.__unfreeze_partials
>       0.16 ±  3%      -0.0        0.13 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.lru_add_fn
>       0.20 ±  2%      -0.0        0.18 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.malloc
>       0.19            -0.0        0.16 ±  3%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp._IO_file_xsputn
>       0.16 ±  3%      -0.0        0.13            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.insert_vm_struct
>       0.18 ±  2%      -0.0        0.15 ±  5%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.pgd_alloc
>       0.17 ±  3%      -0.0        0.14 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
>       0.18 ±  4%      -0.0        0.16 ±  5%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mas_store
>       0.18 ±  2%      -0.0        0.15 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__get_free_pages
>       0.22 ±  2%      -0.0        0.20 ±  3%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__memcpy
>       0.18 ±  2%      -0.0        0.15 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_charge
>       0.15 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
>       0.15 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.down_read_trylock
>       0.14 ±  3%      -0.0        0.11            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sched_move_task
>       0.15            -0.0        0.12 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__filemap_get_folio
>       0.12 ±  5%      -0.0        0.09 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.vfs_fstat
>       0.16 ±  2%      -0.0        0.13 ±  3%      -0.0        0.14        perf-profile.children.cycles-pp.brk
>       0.16 ±  6%      -0.0        0.13 ±  6%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.wmemchr
>       0.15 ±  4%      -0.0        0.13 ±  4%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp._copy_from_user
>       0.21 ±  4%      -0.0        0.19            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func
>       0.10            -0.0        0.08 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__wait_for_common
>       0.18 ±  2%      -0.0        0.15 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.check_heap_object
>       0.15 ±  2%      -0.0        0.12 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__do_sys_brk
>       0.14 ±  3%      -0.0        0.11 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.fopen
>       0.14 ±  3%      -0.0        0.11 ±  3%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.remove_vma
>       0.10 ±  4%      -0.0        0.08            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.schedule_timeout
>       0.21            -0.0        0.18 ±  6%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_init_many
>       0.15 ±  3%      -0.0        0.13 ±  3%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__mod_memcg_state
>       0.15 ±  3%      -0.0        0.13 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__put_anon_vma
>       0.17 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.move_page_tables
>       0.16 ±  4%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__cxa_atexit
>       0.23 ±  2%      -0.0        0.20 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>       0.13 ±  5%      -0.0        0.11            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__do_fault
>       0.14 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__sysconf
>       0.14 ±  2%      -0.0        0.12 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.open_exec
>       0.14 ±  2%      -0.0        0.12 ±  6%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.prepend_path
>       0.11 ±  6%      -0.0        0.09 ±  5%      -0.0        0.09        perf-profile.children.cycles-pp.__perf_event_header__init_id
>       0.15 ±  3%      -0.0        0.13 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.mas_empty_area_rev
>       0.13 ±  2%      -0.0        0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
>       0.12 ±  4%      -0.0        0.09 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.do_wp_page
>       0.14 ±  3%      -0.0        0.12 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.vma_link
>       0.18 ±  2%      -0.0        0.16 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.balance_fair
>       0.14            -0.0        0.12 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.do_notify_parent
>       0.18 ±  3%      -0.0        0.16 ±  2%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
>       0.10            -0.0        0.08            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.folio_mark_accessed
>       0.16 ±  3%      -0.0        0.14 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.worker_thread
>       0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__vsnprintf_chk
>       0.11 ±  6%      -0.0        0.09 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.vm_normal_page
>       0.10 ±  3%      -0.0        0.08 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_state
>       0.13 ±  2%      -0.0        0.11 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
>       0.13 ±  4%      -0.0        0.11            -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
>       0.10 ±  4%      -0.0        0.08 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__free_one_page
>       0.07            -0.0        0.05            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.security_inode_getattr
>       0.11 ±  6%      -0.0        0.09 ±  7%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp._setjmp
>       0.12 ±  4%      -0.0        0.10 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.mas_rev_awalk
>       0.16 ±  3%      -0.0        0.14 ±  9%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.generic_perform_write
>       0.13 ±  3%      -0.0        0.11 ±  6%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__get_user_8
>       0.13 ±  5%      -0.0        0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mas_push_data
>       0.12 ±  6%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.alloc_fd
>       0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.handle_pte_fault
>       0.08 ±  8%      -0.0        0.06            -0.0        0.06        perf-profile.children.cycles-pp.mas_pop_node
>       0.10 ±  3%      -0.0        0.08            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__p4d_alloc
>       0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__exit_signal
>       0.08 ±  4%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.apparmor_mmap_file
>       0.12 ±  4%      -0.0        0.10 ±  6%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.put_cred_rcu
>       0.11            -0.0        0.09 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.process_one_work
>       0.15 ±  2%      -0.0        0.13 ±  5%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.free_pgd_range
>       0.15            -0.0        0.13 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__put_user_4
>       0.17 ±  2%      -0.0        0.16 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp._find_next_bit
>       0.10            -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp._copy_to_user
>       0.08 ±  6%      -0.0        0.06            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.mast_fill_bnode
>       0.08 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.move_queued_task
>       0.10 ±  3%      -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.pipe_write
>       0.09 ±  4%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.filemap_fault
>       0.12 ±  4%      -0.0        0.11 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.mas_wr_walk
>       0.10 ±  4%      -0.0        0.09 ±  7%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.free_percpu
>       0.10 ±  6%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.getenv
>       0.09            -0.0        0.07 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.copy_present_pte
>       0.11 ±  4%      -0.0        0.09            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
>       0.08 ±  5%      -0.0        0.07 ± 10%      -0.0        0.07        perf-profile.children.cycles-pp.__task_pid_nr_ns
>       0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.stop_one_cpu
>       0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.cpu_stopper_thread
>       0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.mas_topiary_replace
>       0.09 ±  4%      -0.0        0.07 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.delayed_vfree_work
>       0.09 ±  4%      -0.0        0.07 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.find_mergeable_anon_vma
>       0.11 ±  4%      -0.0        0.10 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>       0.12 ±  6%      -0.0        0.10            -0.0        0.10        perf-profile.children.cycles-pp.do_faccessat
>       0.14 ±  3%      -0.0        0.13 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.generic_file_write_iter
>       0.10 ±  5%      -0.0        0.08            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.fput
>       0.10 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__pte_offset_map
>       0.10 ±  5%      -0.0        0.08 ±  7%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__snprintf_chk
>       0.09            -0.0        0.08 ±  6%      -0.0        0.08        perf-profile.children.cycles-pp.acct_collect
>       0.09 ±  5%      -0.0        0.08 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__sigsuspend
>       0.14 ±  4%      -0.0        0.12 ±  6%      -0.0        0.12        perf-profile.children.cycles-pp.free_p4d_range
>       0.11 ±  3%      -0.0        0.09 ±  5%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
>       0.11 ±  4%      -0.0        0.09 ±  7%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.strchrnul@plt
>       0.09 ±  5%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.unmap_single_vma
>       0.08 ±  4%      -0.0        0.07 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.migration_cpu_stop
>       0.11 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__kernel_read
>       0.11 ±  6%      -0.0        0.09 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.expand_downwards
>       0.11 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.prepare_creds
>       0.09 ±  4%      -0.0        0.07 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.vm_brk_flags
>       0.14 ±  3%      -0.0        0.12 ±  6%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.ptep_clear_flush
>       0.10 ±  5%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.count
>       0.10            -0.0        0.09 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__munmap
>       0.07 ±  6%      -0.0        0.06            -0.0        0.06        perf-profile.children.cycles-pp.__mod_node_page_state
>       0.07 ±  6%      -0.0        0.06            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.perf_event_task_output
>       0.07 ±  6%      -0.0        0.06            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.touch_atime
>       0.07            -0.0        0.06 ±  8%      -0.0        0.06        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
>       0.08            -0.0        0.07 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.simple_write_begin
>       0.09 ±  5%      -0.0        0.08            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.evict
>       0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
>       0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.vfree
>       0.08            -0.0        0.07 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.prepend_copy
>       0.08 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
>       0.08 ±  5%      -0.0        0.07 ±  8%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.perf_output_begin
>       0.11            -0.0        0.10 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.mas_leaf_max_gap
>       0.10 ±  4%      -0.0        0.09 ±  7%      -0.0        0.09        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
>       0.10 ±  5%      -0.0        0.08 ±  5%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__fsnotify_parent
>       0.11 ±  3%      -0.0        0.10 ±  5%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.mas_update_gap
>       0.07 ±  5%      -0.0        0.06            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
>       0.09            -0.0        0.08 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mt_find
>       0.07 ±  5%      -0.0        0.06            -0.0        0.06        perf-profile.children.cycles-pp.finish_fault
>       0.07 ± 11%      -0.0        0.06 ± 97%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.main
>       0.07 ± 11%      -0.0        0.06 ± 97%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.run_builtin
>       0.06 ±  6%      -0.0        0.05            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.sigsuspend
>       0.10 ±  3%      -0.0        0.09            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__tlb_remove_page_size
>       0.08 ±  4%      -0.0        0.07            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.cfree
>       0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.__send_signal_locked
>       0.08 ±  4%      -0.0        0.07 ±  8%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.filemap_get_entry
>       0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.arch_dup_task_struct
>       0.08 ±  4%      -0.0        0.07            -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.get_zeroed_page
>       0.06 ±  6%      -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.__wake_up_sync_key
>       0.08            -0.0        0.07 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.lock_mm_and_find_vma
>       0.10 ±  3%      -0.0        0.09            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.refill_obj_stock
>       0.07            -0.0        0.06 ±  9%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.complete_signal
>       0.08 ±  5%      -0.0        0.08 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp._IO_setb
>       0.08 ±  6%      -0.0        0.07 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.truncate_inode_pages_range
>       0.07            -0.0        0.06 ±  9%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.copy_from_kernel_nofault
>       0.09            -0.0        0.08            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
>       0.07            -0.0        0.06 ±  9%      -0.0        0.06        perf-profile.children.cycles-pp.__getrlimit
>       0.06 ±  6%      -0.0        0.05 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__x64_sys_rt_sigsuspend
>       0.06            -0.0        0.05 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>       0.06            -0.0        0.05 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.remove_vm_area
>       0.06 ±  7%      -0.0        0.06 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.security_bprm_creds_for_exec
>       0.06 ±  7%      -0.0        0.06 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.kmalloc_trace
>       0.07 ±  7%      -0.0        0.06            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.pte_offset_map_nolock
>       0.06 ±  7%      -0.0        0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.apparmor_bprm_creds_for_exec
>       0.06 ±  6%      -0.0        0.06 ±  8%      -0.0        0.05        perf-profile.children.cycles-pp.dup_userfaultfd
>       0.06            +0.0        0.07            +0.0        0.07        perf-profile.children.cycles-pp.reweight_entity
>       0.06            +0.0        0.07            +0.0        0.07        perf-profile.children.cycles-pp.llist_reverse_order
>       0.11 ±  4%      +0.0        0.12 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
>       0.05 ±  8%      +0.0        0.07 ±  5%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.resched_curr
>       0.12 ±  5%      +0.0        0.14 ±  3%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
>       0.08 ±  8%      +0.0        0.10 ±  3%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.wakeup_preempt
>       0.10 ±  4%      +0.0        0.12 ±  3%      +0.0        0.12        perf-profile.children.cycles-pp.wake_affine
>       0.18 ±  2%      +0.0        0.20 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.16 ±  2%      +0.0        0.18 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.menu_select
>       0.15 ±  3%      +0.0        0.17 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
>       0.21 ±  4%      +0.0        0.23            +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.update_blocked_averages
>       0.18 ±  4%      +0.0        0.20            +0.0        0.20        perf-profile.children.cycles-pp.update_rq_clock
>       0.09 ±  5%      +0.0        0.11 ±  3%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.llist_add_batch
>       0.11 ±  3%      +0.0        0.14 ±  2%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
>       0.09 ±  4%      +0.0        0.12 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__smp_call_single_queue
>       0.17 ±  5%      +0.0        0.20 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.find_busiest_queue
>       0.31 ±  3%      +0.0        0.35            +0.0        0.34        perf-profile.children.cycles-pp.select_task_rq
>       0.02 ±141%      +0.0        0.05 ±  7%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.poll_idle
>       0.03 ± 70%      +0.0        0.07 ±  5%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__filename_parentat
>       0.03 ± 70%      +0.0        0.07 ±  5%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.path_parentat
>       0.08 ±  7%      +0.0        0.12 ±  4%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__legitimize_mnt
>       0.23 ±  2%      +0.0        0.26            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp._find_next_and_bit
>       0.19 ±  3%      +0.0        0.23 ±  3%      +0.0        0.24 ±  4%  perf-profile.children.cycles-pp.complete_walk
>       0.25 ±  3%      +0.0        0.30 ±  2%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
>       0.67            +0.0        0.72            +0.1        0.72 ±  2%  perf-profile.children.cycles-pp.update_load_avg
>       0.16 ±  2%      +0.0        0.20 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
>       0.33 ±  3%      +0.0        0.38 ±  2%      +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.cpu_util
>       0.31 ±  3%      +0.1        0.36            +0.1        0.37 ±  3%  perf-profile.children.cycles-pp.__d_alloc
>       0.50 ±  2%      +0.1        0.56            +0.1        0.55 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
>       0.16 ±  3%      +0.1        0.21 ±  4%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.lockref_get
>       0.15 ±  4%      +0.1        0.21 ±  3%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.copy_fs_struct
>       0.00            +0.1        0.06 ±  6%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.___d_drop
>       0.00            +0.1        0.06 ±  7%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__d_lookup_unhash
>       0.24 ±  2%      +0.1        0.30 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.__call_rcu_common
>       0.00            +0.1        0.06 ± 11%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__wake_up
>       0.84            +0.1        0.90            +0.1        0.90        perf-profile.children.cycles-pp.try_to_wake_up
>       1.00            +0.1        1.06            +0.1        1.06        perf-profile.children.cycles-pp.open64
>       0.66 ±  2%      +0.1        0.73            +0.1        0.72 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
>       0.10 ±  3%      +0.1        0.17 ±  3%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
>       0.01 ±223%      +0.1        0.08            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__d_rehash
>       0.49            +0.1        0.56 ±  2%      +0.1        0.56 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
>       0.34 ±  2%      +0.1        0.42 ±  2%      +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.idle_cpu
>       0.74            +0.1        0.81            +0.1        0.80 ±  3%  perf-profile.children.cycles-pp.activate_task
>       0.65            +0.1        0.73            +0.1        0.73 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
>       0.20 ±  7%      +0.1        0.30 ±  5%      +0.1        0.32 ±  6%  perf-profile.children.cycles-pp.exit_fs
>       0.68            +0.1        0.77            +0.1        0.77        perf-profile.children.cycles-pp.wake_up_q
>       0.78            +0.1        0.88            +0.1        0.88        perf-profile.children.cycles-pp.rwsem_wake
>       0.32 ±  4%      +0.1        0.42            +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
>       0.63 ±  2%      +0.1        0.74            +0.1        0.74 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
>       0.74            +0.1        0.86            +0.1        0.86        perf-profile.children.cycles-pp.unlinkat
>       0.73            +0.1        0.84            +0.1        0.86        perf-profile.children.cycles-pp.__x64_sys_unlinkat
>       0.26 ±  4%      +0.1        0.38 ±  3%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.path_put
>       0.73            +0.1        0.84            +0.1        0.86        perf-profile.children.cycles-pp.do_unlinkat
>       0.32 ±  9%      +0.1        0.44 ±  8%      +0.1        0.45 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>       0.13 ±  2%      +0.1        0.27 ±  2%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.__d_add
>       0.65 ±  2%      +0.1        0.80            +0.1        0.78 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
>       0.14 ±  3%      +0.1        0.28            +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.simple_lookup
>       0.78 ±  2%      +0.2        0.94 ±  2%      +0.2        0.93 ±  3%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>       0.80 ±  2%      +0.2        0.96            +0.2        0.96 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function_single
>       0.94 ±  2%      +0.2        1.13            +0.2        1.12 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
>       0.78 ±  2%      +0.2        0.99 ±  3%      +0.2        1.01        perf-profile.children.cycles-pp.lookup_open
>       1.90            +0.5        2.37            +0.5        2.36 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>       2.95            +0.5        3.46            +0.5        3.45        perf-profile.children.cycles-pp.acpi_idle_enter
>       2.94            +0.5        3.45            +0.5        3.44        perf-profile.children.cycles-pp.acpi_safe_halt
>       3.06            +0.5        3.58            +0.5        3.58        perf-profile.children.cycles-pp.cpuidle_enter_state
>       2.63            +0.5        3.16            +0.5        3.17        perf-profile.children.cycles-pp.update_sg_lb_stats
>       3.07            +0.5        3.60            +0.5        3.60        perf-profile.children.cycles-pp.cpuidle_enter
>       2.84            +0.6        3.39            +0.6        3.41        perf-profile.children.cycles-pp.update_sd_lb_stats
>       2.88            +0.6        3.43            +0.6        3.45        perf-profile.children.cycles-pp.find_busiest_group
>       3.31            +0.6        3.87            +0.6        3.86        perf-profile.children.cycles-pp.cpuidle_idle_call
>       3.90            +0.6        4.49            +0.6        4.48        perf-profile.children.cycles-pp.start_secondary
>       3.96            +0.6        4.56            +0.6        4.54        perf-profile.children.cycles-pp.do_idle
>       3.96            +0.6        4.56            +0.6        4.55        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       3.96            +0.6        4.56            +0.6        4.55        perf-profile.children.cycles-pp.cpu_startup_entry
>       3.82            +0.6        4.42 ±  2%      +0.7        4.47        perf-profile.children.cycles-pp.open_last_lookups
>       3.83            +0.7        4.53            +0.7        4.56        perf-profile.children.cycles-pp.load_balance
>       4.17            +0.8        4.93            +0.8        4.96        perf-profile.children.cycles-pp.newidle_balance
>       4.21            +0.8        5.00            +0.8        5.05        perf-profile.children.cycles-pp.pick_next_task_fair
>       3.17            +0.8        3.98            +0.8        3.98 ±  2%  perf-profile.children.cycles-pp.filename_lookup
>       3.15            +0.8        3.96            +0.8        3.96 ±  2%  perf-profile.children.cycles-pp.path_lookupat
>       3.30            +0.8        4.12            +0.8        4.12 ±  2%  perf-profile.children.cycles-pp.__do_sys_newstat
>       3.16            +0.8        4.00            +0.8        4.01 ±  2%  perf-profile.children.cycles-pp.vfs_statx
>       6.22            +0.9        7.12            +0.9        7.14        perf-profile.children.cycles-pp.__schedule
>       5.24            +1.0        6.20            +1.0        6.22        perf-profile.children.cycles-pp.schedule
>       4.21            +1.1        5.35            +1.2        5.37        perf-profile.children.cycles-pp.schedule_preempt_disabled
>       4.27 ±  2%      +1.4        5.67            +1.4        5.70 ±  2%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
>       4.41            +1.4        5.86            +1.5        5.90 ±  2%  perf-profile.children.cycles-pp.down_read
>      78.66            +2.1       80.80            +2.2       80.82        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      78.60            +2.1       80.74            +2.2       80.77        perf-profile.children.cycles-pp.do_syscall_64
>      10.67            +2.1       12.81            +2.4       13.06        perf-profile.children.cycles-pp.__lookup_slow
>      11.22            +2.2       13.45 ±  2%      +2.5       13.71        perf-profile.children.cycles-pp.d_alloc_parallel
>       2.16            +3.5        5.64 ±  2%      +3.6        5.77 ±  2%  perf-profile.children.cycles-pp.step_into
>       3.82            +4.3        8.11 ±  2%      +4.4        8.24        perf-profile.children.cycles-pp.lookup_fast
>       3.35            +4.5        7.81 ±  2%      +4.6        7.95        perf-profile.children.cycles-pp.try_to_unlazy
>       3.33            +4.5        7.79 ±  2%      +4.6        7.93        perf-profile.children.cycles-pp.__legitimize_path
>       4.24            +4.5        8.78 ±  2%      +4.7        8.96        perf-profile.children.cycles-pp.d_alloc
>       3.49            +4.5        8.04 ±  2%      +4.7        8.18        perf-profile.children.cycles-pp.lockref_get_not_dead
>       4.00            +4.9        8.90 ±  2%      +5.1        9.05        perf-profile.children.cycles-pp.terminate_walk
>      12.88            +5.8       18.63 ±  2%      +6.1       19.01        perf-profile.children.cycles-pp.dput
>      17.51            +7.8       25.35            +8.2       25.74        perf-profile.children.cycles-pp.walk_component
>       0.35            +8.7        9.02 ±  2%      +8.9        9.21        perf-profile.children.cycles-pp.__dentry_kill
>      19.14           +11.0       30.14           +11.5       30.66        perf-profile.children.cycles-pp.link_path_walk
>      19.01           +14.6       33.62 ±  2%     +15.3       34.32        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>      20.14           +14.8       34.92 ±  2%     +15.5       35.61        perf-profile.children.cycles-pp._raw_spin_lock
>      27.57           +15.1       42.70           +15.8       43.42        perf-profile.children.cycles-pp.__x64_sys_openat
>      27.55           +15.1       42.68           +15.8       43.40        perf-profile.children.cycles-pp.do_sys_openat2
>      26.90           +15.2       42.10           +15.9       42.82        perf-profile.children.cycles-pp.do_filp_open
>      26.83           +15.2       42.03           +15.9       42.75        perf-profile.children.cycles-pp.path_openat
>      15.06 ±  2%      -8.4        6.62 ± 13%      -9.0        6.04 ±  7%  perf-profile.self.cycles-pp.osq_lock
>       2.66            -0.5        2.14            -0.5        2.17        perf-profile.self.cycles-pp.next_uptodate_folio
>       1.49            -0.4        1.05 ±  3%      -0.4        1.05 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>       1.67            -0.3        1.40            -0.3        1.40        perf-profile.self.cycles-pp.vma_interval_tree_insert
>       0.99            -0.2        0.77            -0.2        0.76        perf-profile.self.cycles-pp.release_pages
>       1.10            -0.2        0.89            -0.2        0.89 ±  2%  perf-profile.self.cycles-pp.page_remove_rmap
>       0.65 ±  4%      -0.2        0.45 ±  4%      -0.2        0.45 ±  2%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
>       1.28            -0.2        1.08            -0.2        1.08        perf-profile.self.cycles-pp._dl_addr
>       0.94            -0.2        0.76 ±  3%      -0.2        0.76        perf-profile.self.cycles-pp.up_write
>       0.46 ±  3%      -0.2        0.28 ±  6%      -0.2        0.29 ±  3%  perf-profile.self.cycles-pp.apparmor_file_free_security
>       0.97            -0.2        0.80 ±  2%      -0.2        0.81        perf-profile.self.cycles-pp.filemap_map_pages
>       0.77            -0.2        0.62 ±  2%      -0.2        0.62        perf-profile.self.cycles-pp.down_write
>       0.82 ±  2%      -0.1        0.67 ±  3%      -0.2        0.66 ±  2%  perf-profile.self.cycles-pp._compound_head
>       0.88            -0.1        0.75            -0.1        0.75        perf-profile.self.cycles-pp.zap_pte_range
>       0.21 ±  2%      -0.1        0.08 ±  6%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp._raw_spin_trylock
>       0.81            -0.1        0.69            -0.1        0.69        perf-profile.self.cycles-pp.__strcoll_l
>       1.03            -0.1        0.92            -0.1        0.91        perf-profile.self.cycles-pp.kmem_cache_free
>       0.96            -0.1        0.86            -0.1        0.85 ±  2%  perf-profile.self.cycles-pp.__slab_free
>       0.56            -0.1        0.47 ±  4%      -0.1        0.47        perf-profile.self.cycles-pp.vma_interval_tree_remove
>       0.61            -0.1        0.52            -0.1        0.51 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.60 ±  2%      -0.1        0.51 ±  2%      -0.1        0.50        perf-profile.self.cycles-pp.sync_regs
>       0.59 ±  2%      -0.1        0.50            -0.1        0.50 ±  3%  perf-profile.self.cycles-pp._IO_default_xsputn
>       0.50            -0.1        0.41            -0.1        0.42        perf-profile.self.cycles-pp.clear_page_erms
>       0.59            -0.1        0.51 ±  2%      -0.1        0.52        perf-profile.self.cycles-pp.native_irq_return_iret
>       0.55            -0.1        0.47 ±  2%      -0.1        0.48        perf-profile.self.cycles-pp.lockref_get_not_dead
>       0.38 ±  2%      -0.1        0.31            -0.1        0.30 ±  2%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
>       0.44 ±  2%      -0.1        0.37            -0.1        0.38 ±  2%  perf-profile.self.cycles-pp.strnlen_user
>       0.48            -0.1        0.42            -0.1        0.41 ±  2%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
>       0.33 ±  2%      -0.1        0.27 ±  2%      -0.1        0.27        perf-profile.self.cycles-pp.free_swap_cache
>       0.29 ±  3%      -0.1        0.23 ±  3%      -0.1        0.23        perf-profile.self.cycles-pp.__rb_insert_augmented
>       0.38            -0.1        0.32            -0.1        0.32        perf-profile.self.cycles-pp.mtree_range_walk
>       0.54            -0.1        0.48 ±  2%      -0.1        0.47        perf-profile.self.cycles-pp.mod_objcg_state
>       0.18 ±  4%      -0.1        0.13 ±  2%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
>       0.44            -0.1        0.39            -0.1        0.38 ±  3%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
>       0.37 ±  2%      -0.1        0.32            -0.1        0.32 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.28 ±  2%      -0.1        0.22 ±  2%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
>       0.19 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__rb_erase_color
>       0.25 ±  3%      -0.0        0.20 ±  4%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp._IO_fwrite
>       0.28            -0.0        0.24 ±  3%      -0.0        0.25 ±  2%  perf-profile.self.cycles-pp._IO_padn
>       0.14 ±  9%      -0.0        0.10 ± 24%      -0.0        0.09 ± 19%  perf-profile.self.cycles-pp.osq_unlock
>       0.30            -0.0        0.26 ±  2%      -0.0        0.25 ±  2%  perf-profile.self.cycles-pp.set_pte_range
>       0.27 ±  3%      -0.0        0.23 ±  5%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.memset_orig
>       0.25 ±  2%      -0.0        0.21 ±  3%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.mas_next_slot
>       0.31 ±  3%      -0.0        0.27            -0.0        0.27        perf-profile.self.cycles-pp.___perf_sw_event
>       0.24            -0.0        0.20 ±  2%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
>       0.22 ±  2%      -0.0        0.18 ±  2%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.mmap_region
>       0.58            -0.0        0.54 ±  2%      -0.0        0.54        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
>       0.21            -0.0        0.17 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap_output
>       0.11 ±  4%      -0.0        0.07 ± 10%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.apparmor_file_open
>       0.16            -0.0        0.13 ±  5%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
>       0.20            -0.0        0.17 ±  4%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.mas_wr_node_store
>       0.17 ±  2%      -0.0        0.14 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.lock_vma_under_rcu
>       0.17 ±  4%      -0.0        0.14 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.link_path_walk
>       0.23 ±  4%      -0.0        0.20 ±  2%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
>       0.14 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.down_read_trylock
>       0.09 ± 15%      -0.0        0.06 ±  6%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.inode_permission
>       0.16 ±  3%      -0.0        0.14 ±  7%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.strncpy_from_user
>       0.17 ±  2%      -0.0        0.14 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp._IO_file_xsputn
>       0.34            -0.0        0.32 ±  2%      -0.0        0.32 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.13 ±  5%      -0.0        0.11 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__fput
>       0.15 ±  4%      -0.0        0.12 ±  6%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp._copy_from_user
>       0.21            -0.0        0.18 ±  6%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__percpu_counter_sum
>       0.19            -0.0        0.17 ±  4%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
>       0.22 ±  2%      -0.0        0.20            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__cond_resched
>       0.09 ±  5%      -0.0        0.07 ±  6%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.vm_area_dup
>       0.13 ±  2%      -0.0        0.11 ±  3%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.14 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.handle_mm_fault
>       0.14 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.malloc
>       0.18 ±  2%      -0.0        0.16 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
>       0.12 ±  4%      -0.0        0.10 ±  6%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
>       0.12 ±  5%      -0.0        0.10 ±  7%      -0.0        0.10        perf-profile.self.cycles-pp.__get_user_8
>       0.20            -0.0        0.18 ±  4%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__memcpy
>       0.10 ±  4%      -0.0        0.08            -0.0        0.08        perf-profile.self.cycles-pp.rcu_all_qs
>       0.08 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.apparmor_mmap_file
>       0.09 ±  6%      -0.0        0.07 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.unmap_page_range
>       0.12            -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_wr_walk
>       0.11 ±  3%      -0.0        0.10 ±  5%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.unmap_vmas
>       0.09 ±  6%      -0.0        0.07 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.perf_iterate_sb
>       0.09 ±  5%      -0.0        0.07            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.unmap_single_vma
>       0.08            -0.0        0.06 ±  7%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__task_pid_nr_ns
>       0.11 ±  4%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_rev_awalk
>       0.13 ±  5%      -0.0        0.11 ±  3%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.obj_cgroup_charge
>       0.09            -0.0        0.08 ±  6%      -0.0        0.08        perf-profile.self.cycles-pp.__free_one_page
>       0.13 ±  3%      -0.0        0.11 ±  6%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.mas_walk
>       0.11 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.unlink_anon_vmas
>       0.11 ±  3%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.do_user_addr_fault
>       0.09 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__pte_offset_map
>       0.08 ±  4%      -0.0        0.06 ±  7%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.anon_vma_clone
>       0.18 ±  6%      -0.0        0.17 ±  4%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
>       0.07            -0.0        0.06 ±  8%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__mod_node_page_state
>       0.17 ±  2%      -0.0        0.16 ±  3%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
>       0.08 ±  4%      -0.0        0.06 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__split_vma
>       0.08 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__perf_sw_event
>       0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.mas_preallocate
>       0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__snprintf_chk
>       0.06 ±  7%      -0.0        0.05            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
>       0.08 ±  5%      -0.0        0.07            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.vm_normal_page
>       0.08 ±  5%      -0.0        0.07            -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.asm_exc_page_fault
>       0.08 ±  5%      -0.0        0.07            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.generic_permission
>       0.07            -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
>       0.08 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06        perf-profile.self.cycles-pp.perf_output_begin
>       0.08 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__libc_fork
>       0.09 ±  5%      -0.0        0.08 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
>       0.07 ±  5%      -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp.mas_pop_node
>       0.06 ±  7%      -0.0        0.05 ±  8%      -0.0        0.05        perf-profile.self.cycles-pp.d_path
>       0.06 ±  6%      -0.0        0.05            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__check_object_size
>       0.08 ±  4%      -0.0        0.07            -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.dup_mmap
>       0.08 ±  4%      -0.0        0.07            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__virt_addr_valid
>       0.24 ±  3%      -0.0        0.23 ± 22%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
>       0.08 ±  5%      -0.0        0.08 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mas_prev_slot
>       0.07            -0.0        0.06            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.copy_strings
>       0.09 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.mas_topiary_replace
>       0.08 ±  5%      -0.0        0.08 ±  6%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap_event
>       0.06 ±  7%      -0.0        0.05 ±  8%      -0.0        0.05        perf-profile.self.cycles-pp.lru_add_fn
>       0.06            -0.0        0.05            -0.0        0.05        perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.06            -0.0        0.05 ±  7%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.mab_mas_cp
>       0.06            +0.0        0.07            +0.0        0.07        perf-profile.self.cycles-pp.llist_reverse_order
>       0.22 ±  2%      +0.0        0.24 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.__schedule
>       0.13 ±  2%      +0.0        0.14 ±  2%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.newidle_balance
>       0.14 ±  4%      +0.0        0.16 ±  4%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
>       0.05 ±  8%      +0.0        0.07 ±  5%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.resched_curr
>       0.12            +0.0        0.14 ±  3%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.update_rq_clock_task
>       0.14 ±  6%      +0.0        0.16 ±  3%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
>       0.18 ±  2%      +0.0        0.20 ±  3%      +0.0        0.20 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.16 ±  6%      +0.0        0.18 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.update_sd_lb_stats
>       0.11 ±  4%      +0.0        0.13 ±  2%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.release_empty_file
>       0.14 ±  4%      +0.0        0.16            +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.update_rq_clock
>       0.15 ±  6%      +0.0        0.17 ±  2%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.find_busiest_queue
>       0.12 ±  4%      +0.0        0.14 ±  4%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.load_balance
>       0.09 ±  5%      +0.0        0.11 ±  3%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.llist_add_batch
>       0.20 ±  3%      +0.0        0.24 ±  2%      +0.0        0.24 ±  4%  perf-profile.self.cycles-pp._find_next_and_bit
>       0.07 ±  6%      +0.0        0.11 ±  3%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.__legitimize_mnt
>       0.12 ± 11%      +0.0        0.16 ±  6%      +0.0        0.16 ± 12%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
>       0.29 ±  3%      +0.0        0.33 ±  2%      +0.0        0.33 ±  3%  perf-profile.self.cycles-pp.cpu_util
>       0.18 ±  5%      +0.0        0.22 ±  4%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.d_alloc
>       0.13 ±  5%      +0.0        0.18 ±  2%      +0.1        0.19 ±  5%  perf-profile.self.cycles-pp.down_read
>       0.00            +0.1        0.05 ±  7%      +0.0        0.04 ± 45%  perf-profile.self.cycles-pp.__d_add
>       0.00            +0.1        0.06            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__d_lookup_unhash
>       0.00            +0.1        0.06            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.___d_drop
>       0.32 ±  3%      +0.1        0.39 ±  2%      +0.1        0.40 ±  2%  perf-profile.self.cycles-pp.idle_cpu
>       0.09 ±  4%      +0.1        0.17 ±  2%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
>       0.00            +0.1        0.08 ±  6%      +0.1        0.08        perf-profile.self.cycles-pp.__d_rehash
>       1.72            +0.1        1.86            +0.1        1.86        perf-profile.self.cycles-pp._raw_spin_lock
>       0.00            +0.2        0.16 ±  2%      +0.2        0.16 ±  3%  perf-profile.self.cycles-pp.__dentry_kill
>       0.20 ±  3%      +0.3        0.48            +0.3        0.47 ±  3%  perf-profile.self.cycles-pp.d_alloc_parallel
>       1.33            +0.3        1.61            +0.3        1.61        perf-profile.self.cycles-pp.acpi_safe_halt
>       1.90            +0.4        2.26 ±  2%      +0.4        2.27        perf-profile.self.cycles-pp.update_sg_lb_stats
>      18.76           +14.4       33.21 ±  2%     +15.1       33.90        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> 
> 
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index b212a65ed190..d4a95e690771 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -1053,16 +1053,14 @@ void d_prune_aliases(struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(d_prune_aliases);
> >  
> > -static inline void shrink_kill(struct dentry *victim)
> > +static inline void shrink_kill(struct dentry *victim, struct list_head *list)
> >  {
> > -	do {
> > -		rcu_read_unlock();
> > -		victim = __dentry_kill(victim);
> > -		rcu_read_lock();
> > -	} while (victim && lock_for_kill(victim));
> >  	rcu_read_unlock();
> > -	if (victim)
> > +	victim = __dentry_kill(victim);
> > +	if (victim) {
> > +		to_shrink_list(victim, list);
> >  		spin_unlock(&victim->d_lock);
> > +	}
> >  }
> >  
> >  void shrink_dentry_list(struct list_head *list)
> > @@ -1084,7 +1082,7 @@ void shrink_dentry_list(struct list_head *list)
> >  			continue;
> >  		}
> >  		d_shrink_del(dentry);
> > -		shrink_kill(dentry);
> > +		shrink_kill(dentry, list);
> >  	}
> >  }
> >  
> > @@ -1514,7 +1512,7 @@ void shrink_dcache_parent(struct dentry *parent)
> >  				spin_unlock(&data.victim->d_lock);
> >  				rcu_read_unlock();
> >  			} else {
> > -				shrink_kill(data.victim);
> > +				shrink_kill(data.victim, &data.dispose);
> >  			}
> >  		}
> >  		if (!list_empty(&data.dispose))

--YbMrZlPVpQg7sRDG
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.7.0-rc1-00021-gfec356fd0c7d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.7.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_CACHESTAT_SYSCALL=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y

#
# Kexec and crash features
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_IMA_KEXEC=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
# CONFIG_KEXEC_SIG is not set
CONFIG_KEXEC_JUMP=y
CONFIG_CRASH_DUMP=y
CONFIG_CRASH_HOTPLUG=y
CONFIG_CRASH_MAX_MEMORY_RANGES=8192
# end of Kexec and crash features
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_INTEL_TDX_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
CONFIG_PERF_EVENTS_AMD_UNCORE=y
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_LATE_LOADING=y
# CONFIG_MICROCODE_LATE_FORCE_MINREV is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_CET=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
# CONFIG_X86_USER_SHADOW_STACK is not set
# CONFIG_INTEL_TDX_HOST is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_ARCH_SUPPORTS_KEXEC=y
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
CONFIG_ARCH_SELECTS_KEXEC_FILE=y
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_DUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
CONFIG_CPU_SRSO=y
# CONFIG_SLS is not set
# CONFIG_GDS_FORCE_MITIGATION is not set
CONFIG_ARCH_HAS_ADD_PAGES=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_EMULATION_DEFAULT_DISABLED is not set
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
# CONFIG_KVM_PROVE_MMU is not set
CONFIG_KVM_EXTERNAL_WRITE_TRACKING=y
CONFIG_KVM_MAX_NR_VCPUS=4096
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y
CONFIG_AS_WRUSS=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_HOTPLUG_CORE_SYNC=y
CONFIG_HOTPLUG_CORE_SYNC_DEAD=y
CONFIG_HOTPLUG_CORE_SYNC_FULL=y
CONFIG_HOTPLUG_SPLIT_STARTUP=y
CONFIG_HOTPLUG_PARALLEL=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_PMD_MKWRITE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
# CONFIG_MODULE_SIG_SHA3_256 is not set
# CONFIG_MODULE_SIG_SHA3_384 is not set
# CONFIG_MODULE_SIG_SHA3_512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB_DEPRECATED is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_RANDOM_KMALLOC_CACHES is not set
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PCP_BATCH_SCALE_MAX=5
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_MEMFD_CREATE=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y
CONFIG_LOCK_MM_AND_FIND_VMA=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_XGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_SIGPOOL=y
# CONFIG_TCP_AO is not set
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
CONFIG_BT_LE_L2CAP_ECRED=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBCM4377 is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Cache Drivers
#
# end of Cache Drivers

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
CONFIG_UNACCEPTED_MEMORY=y
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Qualcomm firmware drivers
#
# end of Qualcomm firmware drivers

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_HOST_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_INTEL_MEI_GSC_PROXY is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_BITMAP_FILE=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_REMOTE_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
# CONFIG_NETCONSOLE_EXTENDED_LOG is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NETKIT is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_PDS_CORE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_IDPF is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88Q2XXX_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_F81604 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
# CONFIG_USB_NET_CDC_EEM is not set
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
CONFIG_USB_NET_NET1080=y
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
# CONFIG_USB_EPSON2888 is not set
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=y
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_VL600 is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_USB_RTL8153_ECM=y
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
# CONFIG_ATH12K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
# CONFIG_MT7921S is not set
# CONFIG_MT7921U is not set
# CONFIG_MT7996E is not set
# CONFIG_MT7925E is not set
# CONFIG_MT7925U is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_MOCK is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
# CONFIG_PINCTRL_METEORLAKE is not set
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_DS4520 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ELKHARTLAKE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
# CONFIG_FUEL_GAUGE_MM8013 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_HS3001 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWERZ is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2991 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_MAX31827 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ACBEL_FSG032 is not set
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_MPQ7932 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TDA38640 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
# CONFIG_SENSORS_HP_WMI is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CS42L43_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77541 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS6594_I2C is not set
# CONFIG_MFD_TPS6594_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=m
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_MA901 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_RADIO_SI470X is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# Microchip Technology, Inc. media platform drivers
#

#
# Nuvoton media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# Verisilicon media platform drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m
CONFIG_VIDEO_CAMERA_SENSOR=y
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX296 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9M114 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV01A10 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV08X40 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV4689 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8858 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9719 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_WM8775 is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TC358746 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

#
# Video serializers and deserializers
#
# end of Video serializers and deserializers

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# CONFIG_VIDEO_GS1662 is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_MT312=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_EC100=m
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_VES1820=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_MXL692=m
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=m
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_HELENE=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_DRX39XYJ=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_I915_GVT=y
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_LOONGSON is not set
# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
CONFIG_FB_CORE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DEVICE=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_IOMEM_FOPS=y
CONFIG_FB_IOMEM_HELPERS=y
CONFIG_FB_IOMEM_HELPERS_DEFERRED=y
CONFIG_FB_SYSMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_STADIA_FF is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_NVIDIA_SHIELD is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_PCI_AMD=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set
# CONFIG_USB_XEN_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_LJCA is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# CONFIG_TYPEC_MUX_NB7VPQ904M is not set
# CONFIG_TYPEC_MUX_PTN36502 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_AW200XX is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_PCA995X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO=m
CONFIG_VFIO_GROUP=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y

#
# VFIO support for PCI devices
#
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
# end of VFIO support for PCI devices

CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# CONFIG_XEN_VIRTIO is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
# CONFIG_INSPUR_PLATFORM_PROFILE is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
# CONFIG_SEL3350_PLATFORM is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

#
# PM Domains
#

#
# Amlogic PM Domains
#
# end of Amlogic PM Domains

#
# Broadcom PM Domains
#
# end of Broadcom PM Domains

#
# i.MX PM Domains
#
# end of i.MX PM Domains

#
# Qualcomm PM Domains
#
# end of Qualcomm PM Domains
# end of PM Domains

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_BUFFER_HEAD=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_SCRUB_STATS is not set
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_BCACHEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set
# CONFIG_OVERLAY_FS_DEBUG is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_TMPFS_QUOTA is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_NLS_UCS2_UTILS=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SELINUX_DEBUG is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
# CONFIG_IMA_KEXEC is not set
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

#
# Hardening of kernel data structures
#
CONFIG_LIST_HARDENED=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Hardening of kernel data structures

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_GENIV=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=64
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=32
CONFIG_CRYPTO_JITTERENTROPY_OSR=1
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_FLAGS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
# CONFIG_SWIOTLB_DYNAMIC is not set
CONFIG_DMA_COHERENT_POOL=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# CONFIG_LWQ_TEST is not set
# end of Library routines

CONFIG_ASN1_ENCODER=y
CONFIG_FIRMWARE_TABLE=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
# CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
# CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_FUNCTION_GRAPH_RETVAL is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--YbMrZlPVpQg7sRDG--

