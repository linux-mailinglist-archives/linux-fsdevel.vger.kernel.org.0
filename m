Return-Path: <linux-fsdevel+bounces-6360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E5816BF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 12:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADDE1F237EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CBF1A5BC;
	Mon, 18 Dec 2023 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHmIgOJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE6199DC;
	Mon, 18 Dec 2023 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702897734; x=1734433734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=la11LbUGxdVHMFzjWOtsiO2nT/ShMz0Yr/tNFa2iG/4=;
  b=WHmIgOJhWbrkPVMfpe+saRaE2Iy78FVsTPWltiEK31aZsev33ALzgPWd
   SsNWozVZvOq1vS4f4VeqNvB3/pFU4vMsH9uCl3cD9FXsfUTFtrKdWk0kf
   28zPWfWgHDD9LtlHFcUUXSSQW+9Cj5tYSMUU7PRimIwU08//ueYiupQUd
   K/fQeZrOy/E5XUAb6oRYx97/RJd0i/fT13kfM4AqZUJl+JmdclA002p2x
   hJWgesQ/XxIpj3VGEaZQ/eV3CXbxZKQuDijRfDPlB7LNZbcUc35pzK+Sg
   FSVZj8a4kpC4YZHMbUQFwUe7GipHrmlVh5dNJLGpuyOk7B/zy+H6QoUGX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="394364540"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="394364540"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="898929094"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="898929094"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 03:08:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 03:08:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 03:08:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 03:08:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvWMtzlD38WAW2C/W1qiqb9nkGxcPZ/ctY6jgC+qp4Gi0z6XwIEGXKTE+R+mcJDs+PsoALMKu37MIlIkYYocxZwDNUgYUj2dtLb8/fMrupWBZKhe3RKqrF5LG2NfDHmbtiyxNmWQyu7NJUrkQLP48pwfNUnFHcR5Wlb/AQcFwy25RI7fF2HELVdmTJRP9qPX3bgRV1DBgnlr5gs8X/DIe6dSh0FxE/CGQVOAiws4CllrcN2o0GBH5jlEKq6EaIyq9ri3mHhX/6Ejt20c2yXMPmao9jnT5FdJhQIYbu7W9vfJQ+7tFNcMhjatg0SNh6Hydq/fSI0Qkqk/UIC3a7p4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFXRlchvWN9ZnFAcBdzwpIG2bCXu88qykg46R/AcL6g=;
 b=hZymGuLKsQWiYQyW+1E0tm+FmpnFJnIof1HzL/nRyJcpMDrf7Id/saFTD8h8eFJMM/KfLDhXLhHkAGamT67LYSi1R0XnD0+cZw8rPjge1O7brK1Rpa62CHIEktoNO56M989yy4gJ2mJYZ2pEJ9bUBUBbask0ElhrP0NFrWvNoYQlxhCAf/w5jKt4UdqSkvyhVSBo9rnuZ0uQX9XUUbFRYQOY+CsxM2JFf0azUtGcyj7uv6dbjEsJZhdbVYcr7fSr1V5noZ5E/wdTH7gLBybTfaIEH82P4oLkOI0daRu8kS6q9Ir156QxBWtMIveFBnWsroR+aVTutblQrU7or+ncqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CYYPR11MB8331.namprd11.prod.outlook.com (2603:10b6:930:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 11:08:43 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 11:08:43 +0000
Message-ID: <5ae9ba1f-07b9-423e-bf74-175e57dda031@intel.com>
Date: Mon, 18 Dec 2023 16:38:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/50] x86/kernel/fpu/bugs.c: fix missing include
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, X86-kernel <x86@kernel.org>
CC: <tglx@linutronix.de>, <tj@kernel.org>, <peterz@infradead.org>,
	<mathieu.desnoyers@efficios.com>, <paulmck@kernel.org>,
	<keescook@chromium.org>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<brauner@kernel.org>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216024834.3510073-3-kent.overstreet@linux.dev>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20231216024834.3510073-3-kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::10) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CYYPR11MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 7858fcb6-6fed-4015-7584-08dbffb9b248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A05+zVMclDg3arLg3LyEnSwTlQezQ7KvVWhYIDS+fFRIh4bRF8BTEd5IuJhDbUlVrQ9VX+5aTFAvjc4va2jlD8VyBYYjgAeJICMlfPJt3lcJnZmv6UO5pfGswFj8nfeXtdgufLfokIZ3A0Z1IkYiZm2k3rVvfrlrOH+lDbuh1xLuKnUvsglQsJGtQlTJoIoCUOzolUiwJtLaJ1fjnTfyVwmwELJUkC+3EsJV/wduvN9SZf4Lhdm8xFc7nicQti+6keyk7FPmp8SNCk+MOvsC7LQ4jPf+mcCkVHoWKTFb90KzwMyi4YojlTNkpX9C3MgV/XxjAIStOW0icUVVUUDCdqeWJ919xQ0tJWZOYNLz4aumrJn53O6Jr/eHf8nckJ2INenVjaZDZCbGwPjs+GbIYCE6s6qA4QASrjCxWsPuNCZ04PGl9wRv7JkNV6XVscwC5UNXebPjqBfgTzZr1Vme8wxmF/cqB+hwkPeETdRnVw5w7yQN5OobKHizpOVbyOI+9D9GI8vu48SoyofRxb3zynQ8sD9r+BSHStNwL/tCOkXcpLzVvB8kPwcP9mKSA8Gunv05RY/tCZ/8bmlNemurlzyF4/P2RssIb0z9RCTpbRKE9ukIcrKYNBwn0qIT/heLGChSCaMJob2q+N0gy267ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8936002)(8676002)(4326008)(5660300002)(44832011)(38100700002)(2906002)(7416002)(53546011)(6666004)(6512007)(6506007)(316002)(66556008)(66476007)(110136005)(66946007)(4744005)(41300700001)(82960400001)(31686004)(6486002)(478600001)(26005)(31696002)(2616005)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2loSkI0QlU1WkpFZnhVSDloOEJEUFVsdnpuMHdtc3U3YkQzVmt4V1o5Sk1w?=
 =?utf-8?B?WXc5ckhzc3J5bFhubTdDZnArYXlCWWJoeDZrY2RIY1lyYkQ1RFpWYmwzSktS?=
 =?utf-8?B?Q0VyNGIxNzgvb3hvb25vcURQTnV4RzlNaHJ2R2F0SVZETGdrRDk4UVN3OXN2?=
 =?utf-8?B?bE91ZWpJWGJyTFptbjJGb0FmcWtsT1c2bEdhL29vV0RUZzVFeERKN25ydk4r?=
 =?utf-8?B?K05CR1ZPeDQ2V3diVkoxaHJNSFJMdWtDL09ZQyt6NTd4R2JVYXFQNGRqaUpl?=
 =?utf-8?B?T003cURGQXNveGtKWXlFV0c0MExFQ0d6Z01MYmVPOU91L3JVWXlKQ1doT1dV?=
 =?utf-8?B?Z2R5YzMzZGN5MHhHbTFlbW1KanZQZXdrYUF5NUVYZ1J3UTdJVjJsT3VEa2NK?=
 =?utf-8?B?ZmVYVlJubXFDUkpnSHRBTWR2elJnSUhSZjNZQlk2eCtscVRuQnRuQnpGbHFh?=
 =?utf-8?B?M0NhTndrTldOMG1mMjBjSTJxMWRXT3RFTGxsTHRKd2FNR3RucStiY3pnbExF?=
 =?utf-8?B?bjMwaEFNN1pva3BzVWZ2TmxaUnNNRWFWajRGUCtmcWFmN3dsU0xqand2emNG?=
 =?utf-8?B?dnlKdGdxMUgwRFNKNFVnUUMvTnpKeFJvUWJzNHk3Q3U2VDZ0dkg3eVZKL00w?=
 =?utf-8?B?dlRRWk11cXoxd25wcjlPd1p3TE12bmF4WXFGVFB3V00xR3h1YlI5Zk05V3hB?=
 =?utf-8?B?c1dKL0FNaWNRSTRZWVdtZG85dnNVT0JqWENhNE1nNDJNVk1iaERxYkR0NkVm?=
 =?utf-8?B?Ynk2cFB1NkN2ZXNHd2NoNVFGUWFGUWZ3VFd2cmp4ZXgrSjZ0WWNVSjI5clJV?=
 =?utf-8?B?Uy9xOGl0TVVBZU9XRnB0VG5hdDUxT1NLazhOcm9ET3U4TDhwOVE4bzloZi9G?=
 =?utf-8?B?eWk5YklZbngralZJVUErOHZidzUvQWF4dGVEVkExVzFuTDJGOFo2bGl1bkVQ?=
 =?utf-8?B?VUcvWm1KSS9TZ3V4RW9kWnB5V0RuM2c3QjVzTGRmZXRsUG9HSnpHdEN1a1J5?=
 =?utf-8?B?bG5rTmk4RURocldwMC9JOU9QYTZrYTR6MmdUR2psTTNGam8zVjVmUm1URmJ2?=
 =?utf-8?B?WDQxOVVDRnNoMGI0L0MrQUNaVTByL2ZRVGg4Y1JKallORnQ4aVRoYi9DS0hF?=
 =?utf-8?B?RFNKbXJpZkpIWkhnTDVrRTV6c1MzcytnVHlEWmZYSUhOMCtvcm9XakYvQnZ0?=
 =?utf-8?B?MUMrdURGYUFVbkhZYmkvS2h3eHBVUGc4OHhWbjMzdGlPR29aM09Xa2RzUVZ6?=
 =?utf-8?B?d1lnMWhEVFVDdDk4dm01azhvZUtWV1VGVkdDMTlta1pubXlUS1kzQWowWldC?=
 =?utf-8?B?eVpWSVVlVXE5YzBscWh3Qzd5QVlDSDlSZE5aMU81YmtHSlpBa1dDaDBVZDhB?=
 =?utf-8?B?NFdFTkRSNklsUDM0c1F1ZDhObm1wckpURFcwaFlaQ2Vpa01jRHA3RXIzS2xq?=
 =?utf-8?B?cFRJTWw4UStQL2dVZ2dzZ2k0OCsxOStpbklNUVR4SjgrVUhEOFBDU0FwRzdv?=
 =?utf-8?B?d1Z2WUZ1ZWRNTDh3N05rMEFRQ1JnSVlXaldWbjBUdXdOZ1FDQzR4M3I3eWhV?=
 =?utf-8?B?M0lmOGZIRWRGZnhzMUpMMjY3S3FVbzQwbnN5Vnp2d3AwaE1XNFpKdWNpa1Fv?=
 =?utf-8?B?RDlMUkQ2RUtFdFJvRFJJb3E5K2ZmQXpmdkYwOXltY2hrOFhaamd2M1RWYlBI?=
 =?utf-8?B?U3hzalBwMWFLNXRYQW83ckUzd2lFdFFLbDhBMzlyZHpSTEd6UWw2aEllYm5i?=
 =?utf-8?B?NnBSS0NZM2tWLzhsbThaWVA2YUg5ZEt5MitDRUZqWkJYeFRrNktiaks4a0Qv?=
 =?utf-8?B?NWplQ2VDaGZ5TTFxTHJ2SWFzeHZzV3BXUG9OaFR5R3BNaHh3cFNsZ0xWZzE5?=
 =?utf-8?B?OHN0WGJYZ1ZHbVpWSFBqMS9JSlBKZmJBK0VCNjFjemNLbG5aNktaK0VxQVp6?=
 =?utf-8?B?eitCM1ZQMWRVWGl3Wk1kSytydWlDTVF3STFheWhLNUZSZlJnUnl3bFpzUkRL?=
 =?utf-8?B?aTdQRVl1VTNOd05YbUw5NVk5dWR5RTFYeHVVSGczY0pwblJIY3VmYnlZM0dh?=
 =?utf-8?B?bjlYZFJoNW5JU3pWOGhKeUpjMzVnamI5UTIrbVd1UXd0aHF2UW9yQ2pLNndx?=
 =?utf-8?Q?6L7DzheIau/biwtT8j7xagxoP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7858fcb6-6fed-4015-7584-08dbffb9b248
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 11:08:43.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uxn86A6YEw6V4gxcAKopvwxZr8ju7Iiyldgyt5yCzPcGizqiPmtVP5Bwl1XYUSleqMOrdzyfOBR9HBi9J2GPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8331
X-OriginatorOrg: intel.com

For the x86 patches [2-5/50], should the patch subject be a bit more
generic rather than having the full file name listed.

For example, this patch could be "x86/fpu: Fix missing include".

On 12/16/2023 8:17 AM, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  arch/x86/kernel/fpu/bugs.c | 1 +
>  1 file changed, 1 insertion(+)
> 


