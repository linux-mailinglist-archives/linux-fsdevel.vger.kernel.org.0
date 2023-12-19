Return-Path: <linux-fsdevel+bounces-6469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5B481805B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 05:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D941F24BDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 04:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E68F4D;
	Tue, 19 Dec 2023 04:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJ6WD6+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0C8BE1;
	Tue, 19 Dec 2023 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702958704; x=1734494704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lAIBHAnKQLNk3H2ZVeUuXmX5TifiObDmxlqSoFlzUX8=;
  b=JJ6WD6+WtgaodSV6PlkzikZwLA82/Z7gUxh2Mck2nJDfnDqH3fOpLtGC
   CxMCHPtGVoVvotnUrjgyUldfslvaJE69XchRA8v0mFa2QNAjFJ9XB4HHh
   C585QtXt70EJhlFDG+TOE8xdF0+INul4Wwj2tVOP1rprP4hO2O7ySF2cu
   9erZ3QJAHB087ByriAs2XxnECkOBluUYNb4L3nIiYgoMA9DAhAEdzROi+
   G7PINv+guVIpgWPM74HafCJ8+dtSTIY2+NxGaf2A7cYPdIxOON0OZPpY4
   qDApVk0RBj+Y+lLn3p9P2Az7R2D8HaIhnDYfV3/CA8mgiKPrSRD+IioPb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="375094625"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="375094625"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="899214701"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="899214701"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 20:05:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 20:05:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 20:05:01 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 20:05:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg+keC518cSGUOM6qHJ2uTzakMT/vprQo/PbiPO+rlXtWtrOqBauuIDDElApIJQZlTmz+bS+vbS/kNbz52E9Hegkd7XHk5impJJG5Xhj2ege/IcXBM9eeNbb110WC85cPDSuOHHUps3+VRpspawByWkBxC0qXUJFuQmADcJFTp2IoslwHZD8AoybvXSGX3fLUk4IN7o+wHcGpYsK6itFGtcJIGOyOAUhv95K8xuBNl12IWVnh0Q57UWdZwDYTlzTsMtskskkNclEF6xlMIJtH407IaerXJlv8v9hbTlPzWpcqhLx6MtbiB43RicPgG6mkJNIJq3hnKhkdKvXIzZPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv4KZnXygKUEIgLMLvbTLmQQ+V+ZED9ufGYjhGzZ2qA=;
 b=XwtZiZFNeJLB04AH4Cx2nRD2udgMO5yJVU5nuNfNf6Yox4ISyVKOrblmKcMIS+/Lnm8Pj4Wq4a6C0114LlPycc+uGouR6C3AjDDsVGfN6C2C9VOvEKXB7X1tL1XDXHvKYl98TuY04pQaBnFWA8Ye8Gd1B/5kkr1je26PyjdMyBT8Hh2VosIJGoar3XsywZEQuuTYeXjFE0RkPxhN2QhoFOKc+HmhaAztvYY6+Qfs7ArYWKbaqnsZYrDKXtxob1Dy36l8FTl7jzZ4BaCOJ0bgl+pvdh/Oje1N46t2zOwph6Y1/pJCA9FpUv/qYZcSxNV70HVWpJTzzmGTGisDNacayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 04:04:59 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 04:04:59 +0000
Message-ID: <df9e1899-cc09-4fef-b999-05feeb0c41fa@intel.com>
Date: Tue, 19 Dec 2023 09:34:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/50] x86/lib/cache-smp.c: fix missing include
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <tglx@linutronix.de>, <x86@kernel.org>,
	<tj@kernel.org>, <peterz@infradead.org>, <mathieu.desnoyers@efficios.com>,
	<paulmck@kernel.org>, <keescook@chromium.org>, <dave.hansen@linux.intel.com>,
	<mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
	<boqun.feng@gmail.com>, <brauner@kernel.org>, Borislav Petkov <bp@alien8.de>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216024834.3510073-4-kent.overstreet@linux.dev>
 <76af02dd-1f16-41ad-86c7-3202146d0085@intel.com>
 <20231219020605.edmlnz2hgjb4h4im@moria.home.lan>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20231219020605.edmlnz2hgjb4h4im@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a89228-5bc1-499a-057e-08dc0047ab25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzGcglnHTXrp8g7VRcBMa/4fE6TTXyA/TbKfKQoE/4Oa14oY2NbaN5yoLo1DuwR84zq7wgl88H9/C/aFK3YtmEk7ZMYlQjCYkY2i3UoLqM+CyQ01XAwnFxzIXreV9gGi1P+5H5IBcl8m/rAzQdnij+ldSuvewHPq/7FThFpjDPi1C5gep2BSGZ50OQynJ9ADSyy+BQUyn7xj5pxTOnXkrPDhLrfV5dRYxq9IHKVPIo4+eDC7aNtfS9FyCvyJeYb6CE2JNRiX+ZdLDTm14VLv6FOLAJykKX2W2D2vZxhCwRilRRMWBAMbuCwCvrxY0fqnN+Q8KMxMBUJNdFlLV7KRkht/IGbJ08rkwqr52kQooCsCMFluOCWzu8paL2OzSGtqGLqkFpoDlNpfXMBlN9Qn+zyXseoVQJxEIlU4aro5qhZMKa7YGUnoQ42m+m2vAfVYlueyI+W0V7iKicT7TK549EgHDnsvG2Dbdy0y1PhDSYzzZcX6r+vKjUSTF+RaQx8nEl/Fr1IaCUCNOyVKxQ0IDWLpzIXvgY6bohxt8f4/NOUJ2df5/OVNkSPmD6oXQKADhsMNnbXGYTBs3+bj76gBxPEBXApQh7lXPWhwxEVA/lmQ7B1MFj3xb8nMuTpiPjq5PLcwr342ycHm12tgJ5e/4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(66946007)(2616005)(6916009)(316002)(66476007)(478600001)(38100700002)(6486002)(966005)(26005)(44832011)(8936002)(4326008)(8676002)(6506007)(6512007)(53546011)(31686004)(6666004)(7416002)(5660300002)(4744005)(2906002)(86362001)(82960400001)(36756003)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnFGVWF6cysrVkFkRzZnaWc1Ui9CcG56YytTVVdMZzNHdmdBZWR1aEtNQytB?=
 =?utf-8?B?MVFNamtwNFlPRDEvWUxqSDBiNytKZW1lY1JOM241ZlJXOGFlK1J3cFhyUS9K?=
 =?utf-8?B?eGhjSGRtN1AzS3F1SXpkc0ZvbmRGVGRmZDk1VGF1a3AxREVhbytsU1B4UHlO?=
 =?utf-8?B?enkrRjVmUTg5dGpxTFJkZjVieVhrYUxzSHdBY2E5eERkYzBMMUZydXRGSUsw?=
 =?utf-8?B?VHNqVDY3VzdGSzBvZko1SDVqS2J6TVIwRk1SNUt0TjVWbGhZWjk2eEoyVjJY?=
 =?utf-8?B?RU5lNG9aNVpRM3JzNEJaSHNmR2o1QzRCMVZGUEpFZDRjeFg1RjdFYW5zSmJz?=
 =?utf-8?B?UmFqMlY2M0l3TEsrcGlOVmhvc2d1Mm1oK1ZlNytybTExVkc2c3dMNkdqRDN1?=
 =?utf-8?B?YjZUVS84VFpnNlpkaUxQSmtYL3ZDYzNBbnNqaXl4Rzk3KzI5bXN6UVU5SnhO?=
 =?utf-8?B?ZTM5Yk9oN0RiZG1qT1NJc21SZWNwTlQ2VGgwZU1hQWZoVVRNQmI5R3U3UStD?=
 =?utf-8?B?UGNQL0RXMml3RXcyRzdVYlNvTmI3WmxnMHZoNE9vaytDU1dRV2hiOUI3ZWhV?=
 =?utf-8?B?WTR6OFhzdjhoaTQ2SEJ2Ty9SaU9WeHczWnZ0QXFMOWVNR0FNcEpQdU01MXU0?=
 =?utf-8?B?WmdEM3I5SnF5eld0UTRRczFxRFo2dWtGVHRSRFhLeVMyYWJ0U2EvS2xjbjZY?=
 =?utf-8?B?VFdlOXlvQ2ZnSVdlR2cyQm9jS3dYLy9Ta3ZBOFVERXYyV2tCeDJ2Nnl4dEh0?=
 =?utf-8?B?QWxzWHBDb0N1N2UwNTd1MzJ6UkFtMkNBVi9YeVJNNXplRHZFUlZnQzFBcnlo?=
 =?utf-8?B?Z05CNkxYdnZjSXhITlB5cUFYdjNyZkVaMllhbjMwaThkQkgyalYzSkFJcG04?=
 =?utf-8?B?S1N6eStmT3N5M2U0THNrQ0M1eW9jdCtaZVBGQVA4Ti9zZDF1T3pMb29KQ3kr?=
 =?utf-8?B?dEcrOTlZRG4rU0tNdk55SHY3UnRWMUd1QWswZ3hwN1NWcW9TUitTbGZwT1Fl?=
 =?utf-8?B?ODY0WkR3VGNhejJFNGZRUGZBZms4MVh1VnB2aS9FVWkyKzRQRFRmT010byt6?=
 =?utf-8?B?a2svUXZFZUVBOHA5VnlGVnVuOEUvNVd6a3NJYmdXOW9JaXhHRVl1cThCc0dw?=
 =?utf-8?B?UlZHMnVBVHRhS0thSHZxUi9EbEI5ekVNQ256bnR0VUtQRjdzekdzbE5SWGZl?=
 =?utf-8?B?cUV0QmxOakVVTXJvamt6aVQwMzNPNmxkbm9QTTEweTRhWE1BblFNTUNLRk9n?=
 =?utf-8?B?RUdQUmxsWmJVdmNQNVYrNXlTYXFMS3N0bzRaT2p0cU9KZ1o4Y1lmSkdrK3FG?=
 =?utf-8?B?b3J3bTZBc3EwM3A5S05zejVyQ2dkL25yeDN3djUyY2VadThlT2QvelpKYkc5?=
 =?utf-8?B?akF5MUdGQndoMHZ0M29OTG5vaFhxbDJscVlhenhsaHVtNXZmSXhJVVUzNXFl?=
 =?utf-8?B?NkhJWTJmeUdjTXQyMXBHWDltVGRHZWtDZFJKVjBSdFlrRlQwNkFaTnArR2JI?=
 =?utf-8?B?a2syU2dmVHJGS2pQNytrSGlEbHZsY3V6TmZkS3E4bm14bStSeTNEWVBJaHVw?=
 =?utf-8?B?N1J3bXJPdXJiR3I0YUhFRmVJbE1EbVVwUTRZWE1xdUVhaWlOOGtUTFEvYUda?=
 =?utf-8?B?RThlNUZRVkc4dDAxVm5BNXlVR0hXN1pSSmIxVjBJb3FnZEJGZnNYNFVRM20z?=
 =?utf-8?B?cVlsVm5LUjlYZUtrNk5rYWIzOGtEUXBDMEdhN0Y2am0vdmVMKzdxN2JxVmZq?=
 =?utf-8?B?QUx2UEsyWUdpcDVVTlRLSXBoZWdwa1dFRWNGNU1OMExkckk2Um9KdklyWmtM?=
 =?utf-8?B?TUQyZDQreW9XR24zeHhpZHdKcGVXaEhadDk2djJyb1h3VlZ2TzBhak5KWS9H?=
 =?utf-8?B?WmY2eHVlcitVSlVmUm9HNmVlNDU1Q1hnNnZUYTRxYTl2MEhlT0ovR1ZYRDRn?=
 =?utf-8?B?K0Q1QXVkejNDNXUweGY5MzJBVWsyMTFuT0liR1JYZHBFT0U2OHYzZ2pvdkJW?=
 =?utf-8?B?Tk81OHhWN3FhUGtDb2NHQkJMVFZVcGdQWXRINTNBQitZV1NlaC9hR3B3UW1u?=
 =?utf-8?B?dlRYYXB0cFJHMU1tbkhLTXJRdW5pdFYzTzhOMmF6WmI2WndjN0Vqai9OL1lQ?=
 =?utf-8?Q?zH7pAM+DHiqtYB1PgBrby3/Xp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a89228-5bc1-499a-057e-08dc0047ab25
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 04:04:59.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD1SeqiR9hH/AFSGCFUfqY1I+JDJWmmC91VDxm3cvr0UtT6PNBWsVQB+InBBHRq+Eod6+1f/r2VCuXaNqIMYcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com

On 12/19/2023 7:36 AM, Kent Overstreet wrote:
> On Mon, Dec 18, 2023 at 04:18:29PM +0530, Sohil Mehta wrote:
>> I believe the norm is to have the linux/ includes first, followed by the
>> the asm/ ones. Shouldn't this case be the same?
> 
> I haven't seen that? I generally do the reverse, simpler includes first,
> not that I have any reason for that...

I couldn't find a kernel Documentation link handy. But, I found this
email from Boris:
https://lore.kernel.org/lkml/20190411135547.GH30080@zn.tnic/

I believe at least arch/x86 follows this for the most part. One simple
reason is to make it easier to find headers when a ton of them are
included in the same file.

Sohil

