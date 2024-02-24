Return-Path: <linux-fsdevel+bounces-12652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE5D86229E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 05:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606D1B23E08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 04:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00415171B0;
	Sat, 24 Feb 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbWMh+Ch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177A2905;
	Sat, 24 Feb 2024 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708749028; cv=fail; b=SaXGR1gCofx977LLzZFzJaOqVnHAKhK46aXaiA4s//mbJFJDN53UcTU5qENtB/1SgpP33vFoWsIaBMtOo9bKI4qE6d5x5T6nhPtrWM3L77qQTWhFy5fVaFs2RO4Re745aB1J5/W8vlGRhz95H/h2b61kRqhRN0ILrIAsFTkRIE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708749028; c=relaxed/simple;
	bh=Yru5OvyKucHpUK9pN7UkV/A4a3OqCmwsI0AEse412bs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rq2sQ5weAqKdm68K8sOr1rmw5sSZn+hRh8EvWgC+yY46bwoC7KHmgD8QgwxjVeTdpJgfd+SLecDxWK/1lt104KTEZog4lI+LwVWqH1Wc68YEeNK5KYmk5UChahUZrRjjNmeaJJc/of5ccGiio3rgzCYJQhW/ZGvtAPstjitMzhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbWMh+Ch; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708749027; x=1740285027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Yru5OvyKucHpUK9pN7UkV/A4a3OqCmwsI0AEse412bs=;
  b=EbWMh+ChTSJHPb9MN5Hq4T/MrK/dN1uLGpgzWYuT5kkmsqm2/znIylAl
   EnyrIiHyVvPV65kGfUTmie9DPzV9vPFbkXYVV/+gTwGmOJ7VRiPBd9SJr
   skcYhs5u6SE2u4nComr/SduX3DnygunIiJgZUcEiL0pLCNvDE2Dx4vDYY
   J249BtsFLokFe1reZJ2YOjO7vvK/5+79ROArUN/G0Ja3R0IcQUg2DF90m
   3aXUbtf6kJncRrp6rT5+1d62PrREWwLDLxFutcjaBnjcmhrPrA9Jrv884
   UgZ18u1GDDqBY6+kZqxh0rNERXOOvHK/spm414BZZTPB+SNQTm9tVfytV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3253025"
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="3253025"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 20:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="6601212"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 20:30:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 20:30:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 20:30:24 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 20:30:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzwXXGuRewWmzpszE2pNICYSLgoZM6hWLwJqw8J53FEJKZdTZf9dhGPhJTB8+W9yff02mu3aTMsQjgnrNwnectlr5AdiEFJcueElAueYo0kjwCenfWnaeHkdMg+ES0s1IJpZ8CldmJInUZMNtuG/DSomBse3pEzwgAGkY707oAb0QfALwY1dSP2FLK58fHCrlccCvRGPT2/gS+OgDzAmMqFiVOChKQYByKrHKxzs3kzQNlfxSR9KL0gfmmec0bAwQmOB/OnzuUQO2MSFGgILzPDmtVLzHBCpYraHKqg2s9S3bj6NUkjURu9UMF56FYzRrS6K/ow3hdt90FSe9qruXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzqe+JbuosEWAzvemVu8fRWd5iIFg4lQ0JIZ6i8Obdk=;
 b=YiitM/Is9GsJKO28NNQsglzR6n+Ao5HDU0jTQt5bDbQ4/wxsOVv74SM7YTUp1E/VrqoisvMO9a2ztTdIbvYKFFfRnB2tO5IWCWTmD+zXnBza7rlw1yBgYgtr1+/xOjgfb19fajmlPS1Fu63pzudfeY/6ynZQj62u3IvexheRpkCGrRNRvS6Q9rN0Jt5yzSl26GJ/PPaLe8GUzhNmcjZ+948Vn9vltGoRO4cM9xj5KYJp3MzUPrrMt1SsLYAcRCSoMeqPFG91yC1M68oLDbk7IPmtMC9DwT137E1IyQiSF+/K+Fi1bwmFWtzfg6gXJBqgEc1mRVSwl77PR7h8J6JEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Sat, 24 Feb
 2024 04:30:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Sat, 24 Feb 2024
 04:30:22 +0000
Date: Fri, 23 Feb 2024 20:30:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Matthew Wilcox <willy@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Hansen <dave.hansen@intel.com>, John Groves <John@groves.net>, "John
 Groves" <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 16/20] famfs: Add fault counters
Message-ID: <65d970db2d7dd_2509b29435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1708709155.git.john@groves.net>
 <43245b463f00506016b8c39c0252faf62bd73e35.1708709155.git.john@groves.net>
 <05a12c0b-e3e3-4549-b02e-442e4b48a86d@intel.com>
 <l66vdkefx4ut73jis52wvn4j6hzj5omvrtpsoda6gbl27d4uwg@yolm6jx4yitn>
 <65d8fa6736a18_2509b29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ytyzwnrpxrc4pakw763qytiz2uft66qynwbjqhuuxrs376xiik@iazam6xcqbhv>
 <b26fc2d6-207c-4d93-b9a3-1fa81fd89f6c@intel.com>
 <65d92f49ee454_1711029468@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zdlpj3hW8mUfPv_L@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zdlpj3hW8mUfPv_L@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1f9e7e-eb09-4a46-fb6e-08dc34f150a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWo4/+xwSHMhVKGXLQ30Knd7ik3m8Wr50s7QBcX3IBDJzb49Odxr9DftA9qz9ow9gZ/YTw+g9AL00lM0qNMHiz+Jz1DyrR1m1LK5XIf6YkhMs71+sY9IecZddwYolR4QaObb7rga8szTyC0nZFamfKK5shqzGrKm+OWaOcZoGQ1yien97hIrV4SpylyBmSZQcyXx8f6dVe5JAgRFZlEMsSjm/ZFxkGhHDqVGethE8/LvpJzo9X9A2oWZdMRitFIDMitoYqxEy8N/aHG4mRumWPQ9d3Cdf7ZrRM5tSwKt7AoAlVeo/XNTixi2WpiTT9HfcN8aBCcewQ8k+2dBfnmOCR/4hgSeknmUm58sktlxqS8g75OrkQWQ+jQJYzWo4Zmg+30XeMO0jvkcnhzeP4LnHZuwbdsyvKB+2YNdjSaH6ITJ81iYW5hi0vXqMhodBLgfb0W3A0GCZooR8WvDnM+P7Y7rqjFvdsi3cuaDDpDY0bSAvnTU8CqXgQbQ8tW3EAIG65JXpGsMPX8mvu242nUxDvBElct3dqHT8cZRgY/3LPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9YvITWLBHsFKJ7jAgGiwFO9E9WPCExiQ/K7DIQKQmNEcekrV6McE5kBxwug?=
 =?us-ascii?Q?3FnyV58B4DW0DQ+CyvArtefADGjAb1AfgFZxYKlCyeyw2Jlq/PUGFkZqHx9w?=
 =?us-ascii?Q?On6K4lBptfakdMGZuzYufKwAwijvz7A3WjIuWMRx4D0DVi2w7n8bKPmN7v+p?=
 =?us-ascii?Q?KtD7V9unNb5VCH60tw9iDNog2pZMLNr3AMCIVLm4gIsMfEhXlCYe6CKIG2AT?=
 =?us-ascii?Q?cVXZdP1HTh9lo1mcFNsDQgjxcBSrQISUk43sdGZoMw0N9RmmVmv0UwHSKBIX?=
 =?us-ascii?Q?m0kfEMH1WuI2aEJVEKXfIbd89mQW3CsJ++JO9lqtFDzyXRk5B/i6dbm8oXSJ?=
 =?us-ascii?Q?D0ykEbwSr9rCtQzy1vaPpTd4iRop322pK3ecRLgrcaV/gcj5xwXOR4dMG6eA?=
 =?us-ascii?Q?dlK8cfrrkg/jwnuspyGJZj34vSY+SgBXDJcZJ93MhAitHvOMehm5u8hT0qPx?=
 =?us-ascii?Q?dCpxzTMWa7bGogS6XasqRLhcoptG5vdG2M61ZEfVV0kA0n5vdzsQWo+3ARRN?=
 =?us-ascii?Q?VF9UOtMSAAyNDsHzAMkQBKr2LbL1d52EnYxMMByX8BKhl0BZLcviLMWSoKr3?=
 =?us-ascii?Q?k4HmbLsqu/h+zp1uw1BWW/j7lZjxbhYigY1vp5ovb+Bx99pPe2cIxREgCf3K?=
 =?us-ascii?Q?GjnKnUzbQJfnI23PzfoNvj4X8Xo3U/Iz66Rs5hotyDZtLpL0bXWGaKGcErMv?=
 =?us-ascii?Q?frUG3oNBIHUyAXNP9OcMVAewyGm7GSkP+EQ0RC9ug1c11/KiFHUbNWBV7B64?=
 =?us-ascii?Q?PlAGVyLI5GNvqXBXPrBAvVHAGHYl6h+1hQaXG+fyzJu+8439TCOa2Ci9Ryf7?=
 =?us-ascii?Q?+W4gHGp0dWerOIJtb/sjwEvD56zaRiSZW9cXkC0E9HBsirJ766bJIb6GIuEy?=
 =?us-ascii?Q?w3+wfGegQxrzrdxwzW0hoO3dvlMQ7EUeSmHXdNKYLqRQLMeJ9fzrIxJ62NS8?=
 =?us-ascii?Q?oY85CEiXWzPLTPMVS+Ulpa6FkEkYOW5z7GmCZBOdjKE3dlG2YZ7QJHmBCAuR?=
 =?us-ascii?Q?qS8nyxRq+O7LYvq5SlITatSjMh9D1QxdM5qSCZkwo61sL0OXzJnqxR1zCcZD?=
 =?us-ascii?Q?r1tL/4gPXiL2AdIGciX2eFAJKJwu8MeXe3E9TSf2NWVR1m715MCi67MzXvHp?=
 =?us-ascii?Q?2oEw78Np1RqlNl/kLRpFMRxI6Z2ibfrrdNkiDZOuCEXFT6+UzcHoZ+e9bt3U?=
 =?us-ascii?Q?c1xs0E3+Q0tUbnhVDsAzDlI/Mk+MxmqlNzLZTLkJeQCok4uXYK1x8Cmhl0Db?=
 =?us-ascii?Q?hxKglv1qqGPgsXLmgtsY0blnsnLgH1doTR9ch3fWI8H4JgUfWh6q/OWeOIb5?=
 =?us-ascii?Q?6TZvfYrmG0DFpqTw/V3YvG4TsEIDK73kY4GIEqma7nUqrHuddjc+5gowaj9p?=
 =?us-ascii?Q?xzws32qBH0JKIAr1yqbdSo8MnmsUGn4uZC91N3r1dFLcxXMI0qvnmXaVaMpZ?=
 =?us-ascii?Q?nqN67Yg3ue7VoVFjyPSPrNBUyDWePQXYMJO4SzXWC3Mfm+lNfhyXjWxoMusI?=
 =?us-ascii?Q?11Wkrki4KlHkjQER2GDqzuqnPbTK+RzOOBuviSGdCAH4X9JbpB66Dk8QYOBh?=
 =?us-ascii?Q?enOxZL36OU8tXzXYf/HFNxnqXWVyfiOGNLZRVLhcddq06hLbuQKiY24jXphy?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1f9e7e-eb09-4a46-fb6e-08dc34f150a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 04:30:22.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWR+upVW11YkzP0usDXixR0qsvDjwHRw11A2iWYP8Arl35nEKa+LgLtx8XZCmwJFGSTiDbRySXiig0lwdPrrq60Ur62JC3SKmFAqgxxDK40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5549
X-OriginatorOrg: intel.com

Matthew Wilcox wrote:
> On Fri, Feb 23, 2024 at 03:50:33PM -0800, Dan Williams wrote:
> > Certainly something like that would have satisified this sanity test use
> > case. I will note that mm_account_fault() would need some help to figure
> > out the size of the page table entry that got installed. Maybe
> > extensions to vm_fault_reason to add VM_FAULT_P*D? That compliments
> > VM_FAULT_FALLBACK to indicate whether, for example, the fallback went
> > from PUD to PMD, or all the way back to PTE.
> 
> ugh, no, it's more complicated than that.  look at the recent changes to
> set_ptes().  we can now install PTEs of many different sizes, depending
> on the architecture.  someday i look forward to supporting all the page
> sizes on parisc (4k, 16k, 64k, 256k, ... 4G)

Nice!

There are enough bits in vm_fault_t to represent many page sizes instead
of the entry type as I suggested, but I would defer to you or Dave on
how to make "installed pte size" generically traceable per Dave's
suggestion.

