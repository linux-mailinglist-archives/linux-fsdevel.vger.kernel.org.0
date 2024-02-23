Return-Path: <linux-fsdevel+bounces-12634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79A98620CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 00:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19716B22F5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8529314DFF0;
	Fri, 23 Feb 2024 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCKeUhD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01314DFD2;
	Fri, 23 Feb 2024 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732244; cv=fail; b=suDRCvRdUTaEt/kXX8Xj0x+WHh6AURAZhxQ89uyUM+/Mw+H7mdaeGRcvUGw/jOg+0ZI+uEv26LsQpq8IrHdSXPdAZWHjnFVIQRiwJ/yYvj8Te8ZEmLBBlITC8dMFSydjb/K3n9Mt+WfhHEta6nedFmaq7MuhkrJIYzSlMoZSb/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732244; c=relaxed/simple;
	bh=R+nrnn6jbEKc+IHBSRFr6RKxaC/VSZqzBGFXdN8eJTY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AoKZv9SubqAuvHreiuQdOoYEBf8J10d1CMnBSfb4iO/MS4j267k5FwdEET3xt1UsGt6MeFKG2meyZKwglXgcxz5nI0ZCklINJPAzFnmVAYMLTDpVhrERf7s9ywHAN84iGxQhNwNYdoaOukJO9+olsJo1y5uXPTZW4q+MnlnYK28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCKeUhD/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708732243; x=1740268243;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R+nrnn6jbEKc+IHBSRFr6RKxaC/VSZqzBGFXdN8eJTY=;
  b=oCKeUhD/v4/48Epdlbi1ew+s2IvhJYGDXdKjqYlhkTlqIQH5MSKuB2YP
   MbcnKDWxH52IxhTT1G/cuq02bP7FtJcgYGV8HwNkv2U3W+YS6y85fmQgS
   as8dQPuA2cMSazEJWTXOuxB1tueQtnzXRnOc0RBc8lgZ7Sx7quKYH5b5z
   nvDi8Ei0GzJ+nAqyJR6LelGu4i5v7T/mePIqwp4mthEbrtYMoZpVcylJw
   sesHPunq0cUXe9XBpySNMyJkLbxIr+/pb8b+K1D83vhrQRv3Do6rYVjTZ
   zJJoVm49uRM91L7sVQ1T7Nc55R3Wff0q7tmFnIrt73QW/PLUgBDDYykCJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3588233"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3588233"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 15:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6064308"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 15:50:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 15:50:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 15:50:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 15:50:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/Qt+LbIwm608EDscj/wjQ9yNiV0crsjogoPVfCihM51gfuGqNYBT3GmOdMDZRWcICRA6UEA+Z6XDD34pYMSy8Xy8hyUsl8pbT5otH7Rum9kwvf3KXD/fFjxrKPjk56R1ygQ1h1t7TcZrmp+fexFbUxUglh2zl6RBnwTBb4rhm+4qtF0A1kI5Zo4cpz2CcCdnACa38vw86t08/dRS6nCIQqw4on2VfnN3/sNMLvXLTmZVrfK5/F/wumqwY8xPsc5oSbH7Jni62CBCgzilfnhY5C6XoqVDyCHBAY5iOP8d4DDDNY2G+OUb9IqwrO5H3U9ZL6HgxekVqrbp8ZKqm9XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uwr0SlvOuGnd77fo8wuAzM6ljI4toNet8jj1GON4xs=;
 b=KVWNANXrQoYvbShI0aLpIhTrNdRkrHWIjaIVWFJNikhAHKH50f2IKnkQVrtLGyMN+xwJ0VJIC+Ht69ffOJCqfIvohKvnIXDAE1Y2FULG0ibNLCFTx4yu552V8GRYs3TYKoJK7uoymsVy6Oc2qELwrfr1D0Eo3qPZujxDOrzOtrRcRqPQ0sdmWbMYAY+/Srh3yaFQNR7silChtgVIpCF6YSJnJoWFCMN1QwcaGXLPDbApik0LGVbp7r4LBfONv3fY8LZUzcyGn6o4oxNYhRKyMdsXqi+F4pj2Z53Yy7AotJe1fDeBCAP/exT/7KWrNCEMs+X9OwISKJvv9Cd3U1ZFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 23 Feb
 2024 23:50:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 23:50:37 +0000
Date: Fri, 23 Feb 2024 15:50:33 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, John Groves <John@groves.net>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<john@jagalactic.com>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig
	<hch@infradead.org>, <dave.hansen@linux.intel.com>,
	<gregory.price@memverge.com>
Subject: Re: [RFC PATCH 16/20] famfs: Add fault counters
Message-ID: <65d92f49ee454_1711029468@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1708709155.git.john@groves.net>
 <43245b463f00506016b8c39c0252faf62bd73e35.1708709155.git.john@groves.net>
 <05a12c0b-e3e3-4549-b02e-442e4b48a86d@intel.com>
 <l66vdkefx4ut73jis52wvn4j6hzj5omvrtpsoda6gbl27d4uwg@yolm6jx4yitn>
 <65d8fa6736a18_2509b29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ytyzwnrpxrc4pakw763qytiz2uft66qynwbjqhuuxrs376xiik@iazam6xcqbhv>
 <b26fc2d6-207c-4d93-b9a3-1fa81fd89f6c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b26fc2d6-207c-4d93-b9a3-1fa81fd89f6c@intel.com>
X-ClientProxiedBy: MW4PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:303:b5::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 359be0a6-8901-47ed-f844-08dc34ca3b9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31cEkHEE7g61iokt0b5aHYYALfm8p2tpyP0bXeZYP0WwFdj9jJ+PHtPjOVEMkIcncJtAkftg14mTEkhCVH1R5CnGnABS7btMtclURwUpqfDpOykKkBaXVjL3eNhd4ECpGvXEQYtjbvgrE8ZN8DZhhDrjnkQh7h5FcZKUUX0qiSDl626rzn6NeW9UqmhZ2+wzKwoKMByXLvHhz3FgbKqMwVbdY5cY5wfKukR12AYY5X/lOrYRoVpGs0JqIAlDoB7mICFFlIqojGcCakxKuA9wuAz84flT5ujeRRrVOpNLPuNSvhBTWNdaua/iA4P0wAo1I4tHcMrunIujk9gXaXQSnT9oOUpsVfXnzwhsmv01lqzKWQvcWt17UxswriKSgFJu9r11cPw2A4I/aetJMguV9GZjac8vZz/EjRWCrMBenh+lSwWYWE/d8sFnDZ1pCQstqr2wF71aWC/p6XciSwJU6LGLSefhN7a2Vgas0rIZX7s3dmkT86kg0IfU2m0bCAPTuj7natNOc9OXwRMQbAC36w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9fvIdi1KTJfDN4fauKntNWGrGO3kXIMQf5KVMyf9L5QU1jQ0j4ZbNTKZsYzw?=
 =?us-ascii?Q?yufNmMK6enq88pXOsMtA9gSvPaklWzd8mpKw+0fPAVR2iaIopkYuLD7e2OJA?=
 =?us-ascii?Q?6xocNcLSlWu1Uo+nwaVflrFyK7w3D5/duZhypwI/PkbZxhuTEk72eGPfibMh?=
 =?us-ascii?Q?bAoBKNQj6ETwRgyz/8us3Lk09bAgmlLe+tn/WJBGu+f5+pb+2e540R9cfGB8?=
 =?us-ascii?Q?JNdDWlGDujUDlabwVztao6FFibpKQQImkXhKOoV87+AoxkLbXohmF+TsnVQ/?=
 =?us-ascii?Q?DYwfUp9XqXmbvp84AGbCx+F1aU6qSgyCoIj97nbYldmqYD0talECs0zsTQuL?=
 =?us-ascii?Q?z3hR0cgZNL8W8V4rYOtx8KsNmDHa8Gbu+0rBIQMEXjfGWvXNC2MbgUUJRWOf?=
 =?us-ascii?Q?7ou4DhHiovu5nsNmQnpcB3D6y5a4qCmAWdpk8YvxvhuwsdzbbNcUsRtW9cB2?=
 =?us-ascii?Q?vlRyxSTpyjxfgikj8jIzhyZnhPZDROcxsTzie234Cxb47kzFg3AP6ku6w43N?=
 =?us-ascii?Q?Ii3vDBsZhSaWV73P5DV8/Mhl2ZSlSuLSkPpkdQfBJOiK+cmNae51kczum7w6?=
 =?us-ascii?Q?5r5LsKUto7622I/BfdCniMzLSghAv2nKwtflHRiuoD4Dq0EsfB6nJtO3tsad?=
 =?us-ascii?Q?bFTUa5+Qznp7HNNtNMUnlbQBhAH4emsZCi77Ubs9OzF/tUF7kRVATdCcvpNb?=
 =?us-ascii?Q?2SNRNV/NsKfIRmpuZW97EZT1aACEUQ98tz9EL0fuEypYu8nGBkyhlfQwxXJ2?=
 =?us-ascii?Q?yr4NgIgCaT/qIOawmrzfZyzwfiWR7tTHqhGAz4sKTNZMtbokVE/0tW7/YvhR?=
 =?us-ascii?Q?8UWlm0axHO/xEaSBXgPMQvwpBF9jUbo9G/AGPCTtIHFoUobCXIVgC7UtJUjc?=
 =?us-ascii?Q?AhTbxybDCUuxuEoFUhQKV7ZMO0reWy8pWkw33fR6rnHTGsQc9aLdxFUBY3f8?=
 =?us-ascii?Q?Q9reTqzp2Xw8vrCnauQHoowVXlJtc0z+FugcrM+z3q9fbae1kgbvRyALyng0?=
 =?us-ascii?Q?2+AFNa7hjAstUifvZMexAtMUxCTZi/B0c4NBWmYGweTCW0K3u3TNyhXMI4HE?=
 =?us-ascii?Q?WiKJ1wZxeTDFtWKl+eLphWD7onil5s01J2ziWE0fHG700ikQE753uTRPeY1S?=
 =?us-ascii?Q?oxUWxs6FhzKFkFiF9fWFBCdar+R+/MZm+/2dB/lkZuWFZ/rsYJWmLJExaWMG?=
 =?us-ascii?Q?5tQ7zjfz/b3Jzn4BuGwuUEkeNq+2YQ7AAhdNSZRJ8AaVjtJxPeZV6OBjaVla?=
 =?us-ascii?Q?WAFGNlfjkpE1q5/2/6ExAE7fquDtiCJY2vQTVOWi+6J/NPbsEzDS7Z1UMYi9?=
 =?us-ascii?Q?7Em8+c4MEcF5i9pyGPUZhRfKp0a27zqPZWwxJ87shnmLjBgYOUcrgQJENx3m?=
 =?us-ascii?Q?3dbqtnOsZHgArWj+oEXN0Nz1LvuLo00GnRbzywo0Qyh1c2WA0OLBkbWcvR+M?=
 =?us-ascii?Q?PTGveCAEz/0hbUhbrlQv3poh9aAVIiVg2diEVmDJq+4TkbuBoZ0md37JoMuz?=
 =?us-ascii?Q?MzyH0ZNwLxSxLFfVwUTrhNAUHL2U4tzhlejdlkTbS4AC/X7HcRoykjgLUPdU?=
 =?us-ascii?Q?z4hwDhoAPPclCFPt7QX2QpKMHauTha3MglSIFD1+mIpFCfpwuM93WYOYVp8z?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 359be0a6-8901-47ed-f844-08dc34ca3b9e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 23:50:37.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXSePbOczYmwghFMe9p1EP8BAOvnJXwZlePlUMFO56hPMxF1+v/SrovSeqqm4lczPRHMq7cMzX48xVPAnZI94vh5I14To6NqyF8AuR1xRjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950
X-OriginatorOrg: intel.com

Dave Hansen wrote:
> On 2/23/24 12:39, John Groves wrote:
> >> We had similar unit test regression concerns with fsdax where some
> >> upstream change silently broke PMD faults. The solution there was trace
> >> points in the fault handlers and a basic test that knows apriori that it
> >> *should* be triggering a certain number of huge faults:
> >>
> >> https://github.com/pmem/ndctl/blob/main/test/dax.sh#L31
> > Good approach, thanks Dan! My working assumption is that we'll be able to make
> > that approach work in the famfs tests. So the fault counters should go away
> > in the next version.
> 
> I do really suspect there's something more generic that should be done
> here.  Maybe we need a generic 'huge_faults' perf event to pair up with
> the good ol' faults that we already have:
> 
> # perf stat -e faults /bin/ls
> 
>  Performance counter stats for '/bin/ls':
> 
>                104      faults
> 
> 
>        0.001499862 seconds time elapsed
> 
>        0.001490000 seconds user
>        0.000000000 seconds sys

Certainly something like that would have satisified this sanity test use
case. I will note that mm_account_fault() would need some help to figure
out the size of the page table entry that got installed. Maybe
extensions to vm_fault_reason to add VM_FAULT_P*D? That compliments
VM_FAULT_FALLBACK to indicate whether, for example, the fallback went
from PUD to PMD, or all the way back to PTE.

Then use cases like this could just add a dynamic probe in
mm_account_fault(). No real need for a new tracepoint unless there was a
use case for this outside of regression testing fault handlers, right?

