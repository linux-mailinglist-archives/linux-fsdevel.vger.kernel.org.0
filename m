Return-Path: <linux-fsdevel+bounces-49301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E8ABA44E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72CE7AF1CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009F27FB28;
	Fri, 16 May 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBzVjpX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF319006B;
	Fri, 16 May 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424899; cv=fail; b=kJQL+ARQJSZIF/UXwCtIIFwxQwTWIu7qxSrZC451AOjQFElzO9wmVlOtYj7uID2lnj2pOnMuVCO9w9mOrIoXLJDzCOcSHbFi8BUkW/sU0J8uRsTjAJjnMtsBUOU6lujMKCuiziHuFFWTs521yglMscTR3IyH5K3gGoezTnM/pgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424899; c=relaxed/simple;
	bh=fgDNheve08PnGj3Tv8hucFMVyjrooF9u/47KZhTS408=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=apMKiJBSniEXcXMuDX/EcQV6Vm/OGdXS3He6tGXoEC2bro+J+klDn70GwyLEhQObXoAm3WcQCd8kw6D4yQ2L9JdBzEHvhy5MKfR4YmmcpoAFg48JRshwR+jPNapoR3Jxdqc4gDByPBsQScPXQpluisLx0RBN0KyPDitVvgGQLMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBzVjpX7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747424898; x=1778960898;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fgDNheve08PnGj3Tv8hucFMVyjrooF9u/47KZhTS408=;
  b=kBzVjpX7HGMatl4Q1cvcDQb3xIruxMIaDO5fPup8q/qYNqX4Eul8mI48
   9EUP5S+zbiXwqK4kyvGTbkM6t8Q89JTr5xq3REIGyAemrkU05c0k/E8tL
   sm0CSRBDpqP8Rb/OkNArL0RvFiA9QBE5fVgg1/pRekURpAIQXkiJThZA5
   /8WFTXLXYmZA+w/6QRMoFRj0O/X9GxQjKluwtBaKPxl67WTisBha7yDwd
   60i8M9lMn/jwQNSaZOMndgUrvHo9zKhIR6LFNvicWLG0O5cqTYfodxcBz
   est1NIE8zct55GUMm+1Y4iOvYV+f1gNZH7zMv1HfhcCKnMJzpTsvnyxeb
   w==;
X-CSE-ConnectionGUID: 91lsa/DUQOmcQYPb8C0CCA==
X-CSE-MsgGUID: XvQ8xbT8SUe6zx6nZtP3Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="66814520"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="66814520"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 12:48:17 -0700
X-CSE-ConnectionGUID: 5IQQDwY2Ta6J8Rr1LiH3QA==
X-CSE-MsgGUID: Lgt1c5zPRUiUHmz4+Hs2og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139271499"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 12:48:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 12:48:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 12:48:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 12:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kikJgwhaW3nFjgYQDclniQteWEfmSKc3J9CrjFjCMnpeAkyO34WCUNuTk3OdxSbVr7xmRa0CduO5Nwg6TKojIftta+pzPUPq+MVJGTK7ugJtfShF/2XHoip4WsgFQMMdgJmP+sA3jcJuulwNknCxeUTmLMuNp5RkrjVdRcMR9GsogNy9ZyifwweIjsGOyb/ay+ZQz9SOcaSThKpITZsLhyQGBg5Suz4RurRRJ9byYY4xtPex/Syd0X7KEUQYYaaAjotNmEelSnzuerBppatggBe9UErvZkRxMsqPhfFAe6rl5be0kQsDv03jQc3uTdAXWiZNQvmq7kxGDd3TTiPXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT3fWFAf0RsQ/Ri8D4UeOnXV+9xcIfhaWVxevJ8Zz8g=;
 b=idoh/d0zUr68r29SGq4qO004UTjq5ZgMitPi7a9AGqPBgUgWD0hCMnrIga4bR29W/bsPw3IPoHIpMbU8piyoLQnd/jtiwuEmOM4PnEvGHM2JZJgl7vet5qEskeBl0AYgJD+jimQm+pEEDYQkg0toPp3UdVp0+H/UD/uSd2UelT+r3JFvFL5TwdOwGexNYaLT83+S79XjbphKfNiN3DRAsw/UIq37V43pE/9UTR38CRqXGwv0PnfyGBbfw3el+5qVYoTDeSldUfofZke2BT7G63reRqU6E2JTFWzkWkkkccb3CiUh7+OdTkRwu2OFT80Iecom0zVLKO/ukCPxfTmZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 19:48:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 19:48:08 +0000
Date: Fri, 16 May 2025 14:48:37 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Ackerley Tng <ackerleytng@google.com>, <kvm@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <afranji@google.com>
CC: <ackerleytng@google.com>, <aik@amd.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <jgowans@amazon.com>,
	<jhubbard@nvidia.com>, <jroedel@suse.de>, <jthoughton@google.com>,
	<jun.miao@intel.com>, <kai.huang@intel.com>, <keirf@google.com>,
	<kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<michael.roth@amd.com>, <mpe@ellerman.id.au>, <muchun.song@linux.dev>,
	<nikunj@amd.com>, <nsaenz@amazon.es>, <oliver.upton@linux.dev>,
	<palmer@dabbelt.com>, <pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <pdurrant@amazon.co.uk>, <peterx@redhat.com>,
	<pgonda@google.com>, <pvorel@suse.cz>, <qperret@google.com>,
	<quic_cvanscha@quicinc.com>, <quic_eberman@quicinc.com>,
	<quic_mnalajal@quicinc.com>, <quic_pderrin@quicinc.com>,
	<quic_pheragu@quicinc.com>, <quic_svaddagi@quicinc.com>,
	<quic_tsoni@quicinc.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <seanjc@google.com>, <shuah@kernel.org>,
	<steven.price@arm.com>, <steven.sistare@oracle.com>,
	<suzuki.poulose@arm.com>, <tabba@google.com>, <thomas.lendacky@amd.com>,
	<usama.arif@bytedance.com>, <vannapurve@google.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yan.y.zhao@intel.com>, <yilun.xu@intel.com>, <yuzenghui@huawei.com>,
	<zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Message-ID: <6827969540b5d_345b8829485@iweiny-mobl.notmuch>
References: <cover.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: MW4PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:303:8e::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: de9e5940-c8ca-4aab-80c2-08dd94b2948d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XSf4Q0mqE/R23LfEHMeM1Kr8I8aVAv5zcs3YX2Ea2g0CLfAIVfA9q9tn45d9?=
 =?us-ascii?Q?IYwr6+bnf+H7tZUuqb2DZUA/LWRbM0aGO+l2jmFzCWIQymP1FWVqgOE5Djhv?=
 =?us-ascii?Q?Gk2cog6BALnc9CY7teg3H82jMsRhU6ymtZrpqzBVcm4usS+uOSdmx+lBs/Iw?=
 =?us-ascii?Q?TVy/Z5/zJ6YQL4yJ4hvUL5GS9AVNL/+rG5IYRW53ydUJCzIZ4l0VoQ1G9VBf?=
 =?us-ascii?Q?qwnzvUdk70k9yFNsZwI4TKVPB5sDOf2HfwiXSfvhU1T8BCF+5w90TbwiJEqT?=
 =?us-ascii?Q?pCLJFRYvTzJZta+VeYa0yCwn+Wzb+aye5ok6+oHWcAdW4bMS6h+ZYCNv/3Qu?=
 =?us-ascii?Q?5GM+w2+XNvIxEEThYk1tO5SCzLkcHXQPF3qh0zWCQ/be1eygtbu1MSp1U63x?=
 =?us-ascii?Q?y2R+FzB+r08rG4wNnCaMkTjpgZvg9awSc3XMFALH4GIO0/Ri65r034Yta/gb?=
 =?us-ascii?Q?xraMiuyyguXT0iKCoCfcWSqG/GrCqU9u3cogBZ1uArqTUSqI2G0FzFye98Ua?=
 =?us-ascii?Q?dmbYqDzdDVIfd1onQFYQSn0hY0VCu3HI13pGWdY2Ox2DeZMkUW5oUl0S3z+J?=
 =?us-ascii?Q?nvSgcCdGcZR3M9l7vuoZOqw2zaBcBsnJAa1NdBHnBZRw93QabzHo6Ox5/nBW?=
 =?us-ascii?Q?vIyirI1OPIjG2VpZSvKTLEO0U4tljigcCNuGBEFVPDqeR2O9XGMiHRe/wst3?=
 =?us-ascii?Q?nF7wLB3ejBjXgAfVPPqRwMY+2VESiC6SEFav9eilbb7xX0MhsDWyICbTkonF?=
 =?us-ascii?Q?eGu6/+wjc0SXDxtwUSRi4x5jvZUZ1f2w3sak3qC8Q1PsoBHjJ7CRNZSbDfVo?=
 =?us-ascii?Q?arcM75Vzy44PVGvfuJDyJi0Gv0wdXIvq13hnYuD/22RNxmBQ1P2zmcmEDZfy?=
 =?us-ascii?Q?uhWPN5waRTi5Ygiplgf0RMppt+6kRO0kVieRpZy+2tT+qI8CfUiQF3SRXNFD?=
 =?us-ascii?Q?mTXwsLIzT0Ctu9y/E/UORQkQSGME3FD+VYYw8baH6cGmwt09xRXeMWAXhDj7?=
 =?us-ascii?Q?IkKCysJ9A74WYLtuoqFlWQi8bHf3HpSFokC3x4WAcXbQrnQn2I0wyFrjd2dB?=
 =?us-ascii?Q?SBmd+XE7GOx1IE4fhfgDVaB2vE53mbZnmdmUotywCAcFWS1bV4xTrQwImpuB?=
 =?us-ascii?Q?4Ns5hUKMtsUca60caVxcFIEt86f0DphDY91bP9Rp1MQqw+urqwZBA0hkm+D7?=
 =?us-ascii?Q?nzA/oJGpUuEdkenxIYn6gmu2Klv1cf/uF+r00WwKjUxr+p/kwSd1jR4lRIiG?=
 =?us-ascii?Q?gmQZ9oy5U+2qM08NlIoep9+/Y+t6rddu8tNp/9tAZrQW/A1+s63rbZnYnTOe?=
 =?us-ascii?Q?1uCPSY/tmVFCbqn6AuINB5VHaXaQ6/gjWt7AqXgqJKctiQZCAEA2IynjUJmP?=
 =?us-ascii?Q?0u7t4NCeHTdpM2rx3tl8oMn7wl/f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vU4b6pS+5C5ge6hD11Q/8gNQ7FBNAwCEVsMuPhRQzn4TpQTImr/bVNAyHL9b?=
 =?us-ascii?Q?EHAKIxV1Lglwvvo87m7qgNLJUvhxBUzwEBv1hU9IuFbrEn3/oPlWf4wcFwih?=
 =?us-ascii?Q?6F3hes5L3qvcjCgrneGWc29Q9AtMIVC56lekcNbz0Y4SJzg1Azy9OovqbiAO?=
 =?us-ascii?Q?Hg1PGtL1+XN5SogboAuU5+DXsexwUFzJXjEFOcoOU5gZmHYRzjlzIWd6L1xT?=
 =?us-ascii?Q?ZVBOmOPtiXraZ1gc+F9jltaXr5OTcaqn5GkkSTZMkpafJ4BmIJjLYUIBZh5V?=
 =?us-ascii?Q?ISRHKieD9FbmkIeiLaPPNCzW2EbwjtwC6RBNkikczVAo7+MVcjIN/m/6/zkp?=
 =?us-ascii?Q?iKNRX5ql/p+mftyGSKhWvWdQ6N7K8mYWQOO7wpVLjSm+vKm1dJpEUKuejXq2?=
 =?us-ascii?Q?lidorlAvhL1FTfcU7TVgQAlqALikyh8Db9NZPcDrDN+G3S5LMcybXfurNdPC?=
 =?us-ascii?Q?VuR73XRzVnp+gA5D9Q++pKDazsZ1T1KLfEkzJQZoA2gMWx7NWEv0Y/ekh0Go?=
 =?us-ascii?Q?mt3RkcTsMzUYm88wxurf3P8bGtGSma4slrBYFfcD8Vp9tkuqdY8JV0UwfWVv?=
 =?us-ascii?Q?0dAHle7HVwDZ8rsool1jIYCKbxa97sACf571rXPHtRx0svlF162L6LrcfW4s?=
 =?us-ascii?Q?94d4m2P+wMNs6wGCtfJipptlrxAfH2TsLdHBlfg9Gi1WxDxljH9AjubqXX99?=
 =?us-ascii?Q?Ps/pT3+txB0VoviodWwVz/LEqDX3Lk/VC5IwdaCWftVe6POzA8oTgjQc0pQD?=
 =?us-ascii?Q?3t4hXiNFwB2fpo6DDiDLQi4GZQ4P/EeNpS4CmQlO5r2LudJD4PkRjG0Cx8LY?=
 =?us-ascii?Q?Pe0tPt0fyho8zRUid6/olGCBpWkq5g1lGrg/hYjxPFeFv0OVepn8Jks4P9JH?=
 =?us-ascii?Q?xPDDISaQQ8fzihP5Sz8ITJ+0TAutdxMyBZsQv0eqPC3AQ5bjsbBF/A2w/KbP?=
 =?us-ascii?Q?AT6/rmZirSFKl/yfeqa4m0dSXXIaNXZFK+zVzr+EiIUICPGbNuhcKKBZYT+L?=
 =?us-ascii?Q?vltD9vOA0hdblz9rrJpEM16st2jYPoNv8x5yJMA8cVmJtsEzMNs3ON/Qr7g/?=
 =?us-ascii?Q?szYvR4HgN8B1Kt4U8zFGQXvev/tl0Xh9kPJ9cnjmAY53FHlXoYFoYgE8V3pO?=
 =?us-ascii?Q?B+UPP1KsQXAN74PrBOKKh8lWlX9JSO431U/XlRig86etngqfPX7HzDWUMmfo?=
 =?us-ascii?Q?EADoMRIs21e6vGpd1M2NkMo1KuYsSV9hpvnaRMU6oh2c7tYNiJEgqNYLvW38?=
 =?us-ascii?Q?ONrjpfXsYUchA6+sB+M+32SOBmVBlfcNz+beGru2lvSGDqD8HPuB/6TSnOKo?=
 =?us-ascii?Q?Fl243MNAF08qbbhfPCO0bHnTwUVrES/FxviNXgNk8ZE0++FrKogXyHQf3T7V?=
 =?us-ascii?Q?iA5CgaiYOrK0sKTigj7KHVb7dSGWBEi7F7iUGkdlyXhprS19xq41ts/4hls0?=
 =?us-ascii?Q?4bmGI6lVvgpLw4vcF67BdhfeGyGRa8xvlFgaBeoILJI95kD41XqQbKJcplbm?=
 =?us-ascii?Q?e8evdjPA4M8Irb0hy0SUXp82MRsqCVApz9IbBkYbpj8wJnt/Nt3OvRGBfTFS?=
 =?us-ascii?Q?Rk0nZwrpKXhuXYzkuszn1iFJvZdTUHkO6FNOWhJr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de9e5940-c8ca-4aab-80c2-08dd94b2948d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:48:08.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ0gbEOwZbKrGFXr6q0JDlpTOSdo0a2YV+JDHI7ZQw+s0QTOQkzEBr92dulJuepPvb1XYo9bXG2eRzXE3wpixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-OriginatorOrg: intel.com

Ackerley Tng wrote:
> Hello,
> 
> This patchset builds upon discussion at LPC 2024 and many guest_memfd
> upstream calls to provide 1G page support for guest_memfd by taking
> pages from HugeTLB.
> 
> This patchset is based on Linux v6.15-rc6, and requires the mmap support
> for guest_memfd patchset (Thanks Fuad!) [1].

Trying to manage dependencies I find that Ryan's just released series[1]
is required to build this set.

[1] https://lore.kernel.org/all/cover.1747368092.git.afranji@google.com/

Specifically this patch:
	https://lore.kernel.org/all/1f42c32fc18d973b8ec97c8be8b7cd921912d42a.1747368092.git.afranji@google.com/

	defines

	alloc_anon_secure_inode()

Am I wrong in that?

> 
> For ease of testing, this series is also available, stitched together,
> at https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-support-rfc-v2
> 

I went digging in your git tree and then found Ryan's set.  So thanks for
the git tree.  :-D

However, it seems this add another dependency which should be managed in
David's email of dependencies?

Ira

> This patchset can be divided into two sections:
> 
> (a) Patches from the beginning up to and including "KVM: selftests:
>     Update script to map shared memory from guest_memfd" are a modified
>     version of "conversion support for guest_memfd", which Fuad is
>     managing [2].
> 
> (b) Patches after "KVM: selftests: Update script to map shared memory
>     from guest_memfd" till the end are patches that actually bring in 1G
>     page support for guest_memfd.
> 
> These are the significant differences between (a) and [2]:
> 
> + [2] uses an xarray to track sharability, but I used a maple tree
>   because for 1G pages, iterating pagewise to update shareability was
>   prohibitively slow even for testing. I was choosing from among
>   multi-index xarrays, interval trees and maple trees [3], and picked
>   maple trees because
>     + Maple trees were easier to figure out since I didn't have to
>       compute the correct multi-index order and handle edge cases if the
>       converted range wasn't a neat power of 2.
>     + Maple trees were easier to figure out as compared to updating
>       parts of a multi-index xarray.
>     + Maple trees had an easier API to use than interval trees.
> + [2] doesn't yet have a conversion ioctl, but I needed it to test 1G
>   support end-to-end.
> + (a) Removes guest_memfd from participating in LRU, which I needed, to
>   get conversion selftests to work as expected, since participation in
>   LRU was causing some unexpected refcounts on folios which was blocking
>   conversions.
> 
> I am sending (a) in emails as well, as opposed to just leaving it on
> GitHub, so that we can discuss by commenting inline on emails. If you'd
> like to just look at 1G page support, here are some key takeaways from
> the first section (a):
> 
> + If GUEST_MEMFD_FLAG_SUPPORT_SHARED is requested during guest_memfd
>   creation, guest_memfd will
>     + Track shareability (whether an index in the inode is guest-only or
>       if the host is allowed to fault memory at a given index).
>     + Always be used for guest faults - specifically, kvm_gmem_get_pfn()
>       will be used to provide pages for the guest.
>     + Always be used by KVM to check private/shared status of a gfn.
> + guest_memfd now has conversion ioctls, allowing conversion to
>   private/shared
>     + Conversion can fail if there are unexpected refcounts on any
>       folios in the range.
> 
> Focusing on (b) 1G page support, here's an overview:
> 
> 1. A bunch of refactoring patches for HugeTLB that isolates the
>    allocation of a HugeTLB folio from other HugeTLB concepts such as
>    VMA-level reservations, and HugeTLBfs-specific concepts, such as
>    where memory policy is stored in the VMA, or where the subpool is
>    stored on the inode.
> 2. A few patches that add a guestmem_hugetlb allocator within mm/. The
>    guestmem_hugetlb allocator is a wrapper around HugeTLB to modularize
>    the memory management functions, and to cleanly handle cleanup, so
>    that folio cleanup can happen after the guest_memfd inode (and even
>    KVM) goes away.
> 3. Some updates to guest_memfd to use the guestmem_hugetlb allocator.
> 4. Selftests for 1G page support.
> 
> Here are some remaining issues/TODOs:
> 
> 1. Memory error handling such as machine check errors have not been
>    implemented.
> 2. I've not looked into preparedness of pages, only zeroing has been
>    considered.
> 3. When allocating HugeTLB pages, if two threads allocate indices
>    mapping to the same huge page, the utilization in guest_memfd inode's
>    subpool may momentarily go over the subpool limit (the requested size
>    of the inode at guest_memfd creation time), causing one of the two
>    threads to get -ENOMEM. Suggestions to solve this are appreciated!
> 4. max_usage_in_bytes statistic (cgroups v1) for guest_memfd HugeTLB
>    pages should be correct but needs testing and could be wrong.
> 5. memcg charging (charge_memcg()) for cgroups v2 for guest_memfd
>    HugeTLB pages after splitting should be correct but needs testing and
>    could be wrong.
> 6. Page cache accounting: When a hugetlb page is split, guest_memfd will
>    incur page count in both NR_HUGETLB (counted at hugetlb allocation
>    time) and NR_FILE_PAGES stats (counted when split pages are added to
>    the filemap). Is this aligned with what people expect?
> 
> Here are some optimizations that could be explored in future series:
> 
> 1. Pages could be split from 1G to 2M first and only split to 4K if
>    necessary.
> 2. Zeroing could be skipped for Coco VMs if hardware already zeroes the
>    pages.
> 
> Here's RFC v1 [4] if you're interested in the motivation behind choosing
> HugeTLB, or the history of this patch series.
> 
> [1] https://lore.kernel.org/all/20250513163438.3942405-11-tabba@google.com/T/
> [2] https://lore.kernel.org/all/20250328153133.3504118-1-tabba@google.com/T/
> [3] https://lore.kernel.org/all/diqzzfih8q7r.fsf@ackerleytng-ctop.c.googlers.com/
> [4] https://lore.kernel.org/all/cover.1726009989.git.ackerleytng@google.com/T/
> 

