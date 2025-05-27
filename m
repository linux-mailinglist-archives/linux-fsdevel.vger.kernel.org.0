Return-Path: <linux-fsdevel+bounces-49886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A66AC4742
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 06:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F657AA2EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 04:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766E31D90DD;
	Tue, 27 May 2025 04:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGg9ItPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD4136347;
	Tue, 27 May 2025 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748320872; cv=fail; b=FlhXwMzDcaQmG22dwxEcmLMXqrh3/WhuHcEejL3R3yxYE4lBPdYAz9YohOGkh8zxIT8auRRHcObK1bXX9UKPWAo4qFJ60w+SEgRCFiuW4daAm7VzfbaV1ipBbOTjolz9HyIFI297ooY608z37ZKAXB8/dBqf19cn/8xXcj1pOiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748320872; c=relaxed/simple;
	bh=Gx1LDIVJcPcytsX6vNW+70uGGU87xxTQKftb9KRtIpA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fjA2nAt5UumIR+ivajOtLQCPBlMIM0I7qXdQyf8RRW7u+7wtSRNpHctEjzQTqxCF5Rjx9KOtzBuqlLTZo1kJmLBm6wBIWZaQ6c0xkPtTUO53hbu6LiOAdAGIxp9AM2CeQAoPm5LEQr+NA7wt2M6olm+1Rgcd+9IRw/3s17X/dt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGg9ItPY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748320871; x=1779856871;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Gx1LDIVJcPcytsX6vNW+70uGGU87xxTQKftb9KRtIpA=;
  b=jGg9ItPYllXTbkYo7dnqH/XVZJg+HtJAXH3wCsrO0c9VHYgTTUNWZh5b
   eBgp27L5PILa4yTyFUj/Jo6z1TdEY+M0urOFON1DSEx9ch+uWZOpJRTwm
   FXQk+TM5UcCJjX4knIcWRXvN7dR7nKCccDF5M+hGdPUVsvU6xiew8GsP2
   BPlwEdwAFsPfGIMsifx2Ug1K+5rp5cbTeVSZSrcsntNNzh96Ol3eiFZea
   ngOkrV9LcMc7FZAZ2Y24VTJ3iwRGRGKUC1D0POS7BqOI7vDmkS34F1JKB
   2WtNlo8BjVXkyTebofXe3tZh/YuoYqE3zOHvz2fq8A39DSBgTBWtWH/b8
   Q==;
X-CSE-ConnectionGUID: YSkrbGraRj6Toys8vjzYLw==
X-CSE-MsgGUID: +qoGk8acQLehVK65ggnI9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="54097627"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="54097627"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 21:41:09 -0700
X-CSE-ConnectionGUID: hJOyd6pWQEuymyYDcp3nSA==
X-CSE-MsgGUID: iiGMGzc+QiqJw3nLkty42w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="142992509"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 21:41:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 21:41:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 21:41:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.57)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 21:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsbNVAdmDpVefS1FI3P9e7PbX8QHpwfQDtEIAuz78iz4hicJg3vofCDjPhwKZtsF5TOXJPAVGrK+Mqs8hPWFljHEQLt/s//NjHtGOX/K+ZsmliE9IjZ+eT6BQq9x1gWG8p2Jw/EIvSyEJ22pKsSdRKi09r1E7TsBycsheQeqRF9Un+4XauIlWXEKzCmy4Y4NeUj+/9sh5pjTWc7O0hcqst8rHswlXHpNAB81pjkIe7R7y1/FJ4ogzoo6DIQ1koKMuX1kIx5MCqGDx+Upr8oLXCI5J/rip9LQHut5Lc2yV1hkccemUG04ZtXeRJ6EUKvw0o+SpDu3/9yOGloUHMrnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbsUWWoO9j17FrfTg2Z0a3H0aKshJ4C2CEMgSBdrSBs=;
 b=lccP17/v9BguoqpM4xpdsasjl+9Jcbt/e0qzgHVtlApNh6GQyY77Ht9rRtgUP02HmSB2hdsvBB52+GahhatxCI8yj2J8g+xudifk00tGQYhAzV/JGZ0D0D7CznEnmGfCdQh1wgzYAC+dVYd/J8LydJ844RhVRP2KtAq+yKwtxtLTK1gk1FBYJ1dxD+rRd+cikH/B18hfyogveKA5uCkzUGqzTXixvEhyOwMymyyQuNybzf9WwWGtd3tgD6JDsKwm/KKq6DSx1aFbtKi6XDN0YcMhvaVb4E1uGxLRPxUmqcvp9xdYQ0fkQ7wnUawUVasgMFPbp7DmGY6bCknkgMVswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ5PPF183C9380E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::815) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 04:41:04 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 04:41:04 +0000
Date: Tue, 27 May 2025 12:38:29 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>, <kvm@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <aik@amd.com>, <ajones@ventanamicro.com>,
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
	<yilun.xu@intel.com>, <yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
Message-ID: <aDVBxa2IY8V7dluq@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
 <aDU/0+XLZKv5kae7@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aDU/0+XLZKv5kae7@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ5PPF183C9380E:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa886b5-3b0c-4ff4-85c6-08dd9cd8b03f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5OzaPfHReNQ8gMeOG2xFI9C3mIE+3EwQf1R42iLye3ZvbXQKTwoOAXdcH9WY?=
 =?us-ascii?Q?Qf4S4BPIRdd/UmeyZ1w3wjxf10fYuRfdexpzOt7Y+CfF0kutiXsN+/m6AodI?=
 =?us-ascii?Q?dWUb+jrvLjzHEEC/aBRm86yYXDDKa+nWnF5v7RLOm+TfMKN8DnlUsczbGfjF?=
 =?us-ascii?Q?v4Nz6Up9UIOJ8AATgvA/Cl8zCtktIrsYuZZ6H5oyq1SGvWyK4W96T+BKZpme?=
 =?us-ascii?Q?Uo/rAjRmqEC1Pyd5IZq8FQb/J2BtjrNxH4mAe66NxpSLdUIVRJzhGZZfG883?=
 =?us-ascii?Q?C8gqOoQepnem93MqlgoECmRnFfYiSp+f4D+3MY3wZzYrqh3H7b+MUPBjJig4?=
 =?us-ascii?Q?2WmpS4Sw034MY2J2cilOfiif4O6R2ckunnWLtUyja+cgPKIeqEtaPztF90Wx?=
 =?us-ascii?Q?lBpLM3Uw60BPpexw4kngS21VgAtnqTg6T5qPK6QqJ59KmNQE7IQbcX0TYaAQ?=
 =?us-ascii?Q?wqdHPXKH3VJOvhPb3KSwh7BLZ8O9mLif6VA9hg98wN/zoIzu3Ua742u/LAWA?=
 =?us-ascii?Q?4lptAGZYwnaXWTvfuWclbjWRmaWsB1wjmtGKMcKu1A+8nvxqzz0qZa12E/qG?=
 =?us-ascii?Q?+pQCoZX9mqh0+BEtFE3GfFVNEfPrWxqzofh/CLWYL0XlgyT/lGEYsyGySgjK?=
 =?us-ascii?Q?OYDYn9ryNNDq4a/4Py9XKs1zgkhWVD1jqqAzW4xItTN5FmL46kJDg21fHY0E?=
 =?us-ascii?Q?4MzOFzvkviyb8qbdVSzZ75E5EnLwwvpe7tJg0XwvAqVGLQ0y35kYb8Tlxwi1?=
 =?us-ascii?Q?Fd5epu+sjAO4TSqV2CCQGtVeBNDmYbub8rUCgnZ5fQPpk7ryXhnb2dJVnAgR?=
 =?us-ascii?Q?QvxrTHxHfCti7pd+HDgT0QCfdiwMDb3aVSaHd5CaaZwsr+77ZWdE7sSMi27U?=
 =?us-ascii?Q?9fYfpAsgXZbl+0GEnhMWSF4BeTTytF2TArb25NC5EjbNmcObGqNq+o9B3pZS?=
 =?us-ascii?Q?arflXOcXfn9OtqDRqGYh6cgetNyegITnhTtjfebPrxsWZzADHHR/th/NMWrh?=
 =?us-ascii?Q?eHeOMm3wDOq2M3uDAFcl90ryD/bDAC7C51eygpt5xoELa/0fSmq94E2+Q310?=
 =?us-ascii?Q?KHPXLt1mvaknaVEXgrd+cbbYq/mjQxnNBxGMsJfGE8MvjGE/m8TuQ4W9bcW/?=
 =?us-ascii?Q?t3FnbkmMsyTP0696Xtgpgl2DPWqMfLd8Q6jk0pyt9eTv5nYXdQZ+WKUpeZT4?=
 =?us-ascii?Q?CUXTVX2WzNg0LByD2dFD1ZCleDVIie53e+gdYQBJeeRVRzk2zCVVXz6ntrnm?=
 =?us-ascii?Q?D+uv5Lh0exhfpTkY8AvHnVe/PJ4v83MDwIZ0d69RcHTs9uFlO+k7j0hvRzm7?=
 =?us-ascii?Q?j1NB/p5C4sqgNtjBBLb8Tn5R79fTMVjoYWW8QaPSKxAabYsIEPPNtSYFfIt2?=
 =?us-ascii?Q?plXwQhM0//UMJFEzFsv+7uDxYJQodHYDwE8JWSIg2QqamgiELY75QS14E/rh?=
 =?us-ascii?Q?EZIOSkLI2bpQvqyYC9HTKa+bkqL4gEGtnRYTIvq9Y7yugAnCVkZrqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iSWnp0hljT+UwnopHPAGpBFO8iT5r6iV1RLMwrbi99UqxMAf0yzmAyKY1ALg?=
 =?us-ascii?Q?T5EgrJP4DqTe3cclDvS0oX92SCuPhUOm4jzol0AkImeHHHKUPx8Q3KLbOb0C?=
 =?us-ascii?Q?C0pQ9R8cW1opA28GDUy66X5ZdXJO3f5phETiQTDpV6pn6/Vzvc2JeFGBKz9k?=
 =?us-ascii?Q?sYhL51MvZyrt8rDIONqXdHqwyTSSoOkb4YBCYkZea9CSMzKnZQhY/4nBJS6U?=
 =?us-ascii?Q?wZhgoxp47s7JYHcRO1AHr0IqnueFZnYbSBwtH7FCMeRPi5wPYy0dWC8Q+fXa?=
 =?us-ascii?Q?3iSBuDqo5ckpVNGw4tTSY66ji7W5yjW3pmkYhLbuAaL4QQRCrr/VLxHlhlf0?=
 =?us-ascii?Q?9I4E2rPrlAG6/MQEswrbXk8uKbB9R5Ot0OF68Mb7rZE3P2as/0sg4nDMhHHA?=
 =?us-ascii?Q?NnwfmtuA3hZM68xSA++A+LHUB5ts+mU6vgQSL6uP/AjdAS8EsItAkAmC0WRd?=
 =?us-ascii?Q?W3P7O+BDdkFll4kTIm3CDEnhTL7IkqrZILsP/D2WRWa2RhQx/jXfAIPByTbL?=
 =?us-ascii?Q?DRIVVW+o0e3u0JX72kuU8rUnX3EmyusRJX/inLHgCutBiEbfJ1gyd3djIASZ?=
 =?us-ascii?Q?2hp5rNm3EZydfN38xgzYxy9mDleyU2Nml13y+xN7Bamqx5QvZpM/Lsecat6G?=
 =?us-ascii?Q?3u0wv70Q5Mr9JyAVQPCD38MB/q8fz0T1sm/7q1FwTK/CAD/RhkzkjiveaFcd?=
 =?us-ascii?Q?1BScXWbAW9zBDcla5hgI/ZjYmUXt38px6bLIzhD1738Mxe3bL3mn3yEHCv3d?=
 =?us-ascii?Q?vwLvtG5xw801IYRu5GPzE2L0WKJLUmIcjVLTzlwPLTtrucMyR3HlCR2mAPXG?=
 =?us-ascii?Q?xDg9cBpAcig0NppcdDQ3VRGkZSRmee0AGto9DiAj7S+2RxSgIV6wbGyTOVsg?=
 =?us-ascii?Q?MmgvLJ6gbsoe062J85dORJ68ja9SJ4RqJ292IG0ASqklbspm0llhm7aUUwBl?=
 =?us-ascii?Q?HkVy0hUR1fiNisFmmw3nrSrG2wAHMcEUxu1SOYwtRWdpYGGHbscqkpsgbvmS?=
 =?us-ascii?Q?HxMdo0tAy8aUyfg0RF73ozfPSgFv3Qa1mZPZayH1HMHpWH4VlrlwwpXOP3p4?=
 =?us-ascii?Q?CAG32jO0OW+/RTZ/AZYsy0OO90w31/xTI6Q2m9l2xcPfZZHZyS+8gEpT+uIv?=
 =?us-ascii?Q?uRs4uzNwXSc4xkTivaWwSGz21Kw5JB0vsPmibijFwKCqTj0TsQj9+JY/7r41?=
 =?us-ascii?Q?MVIxbnwo1a6k0HR2zVCiW7NWstCBIFF1OmN+KFZ8GqitzOD6VfneoytTn1UJ?=
 =?us-ascii?Q?uj+8t3Xe/2QK3BkqXRTrF/yiTS/9/7RPFYPp8Vo3CndSMbHJ80MjM2NLRyvO?=
 =?us-ascii?Q?z0xDLLd+cMX/lIukd4cdnp6dn+udI48wq99jTniytVug3i5XlfN/UUVUNqlg?=
 =?us-ascii?Q?nF0BUV3e3vsIiz4IkifzEGV5SEqeP2RSVF/Iiqro8S0KP9RbFAYzdmxPr7VZ?=
 =?us-ascii?Q?LvWcA+wcz//76LtON7Lvf+LHiStRiJRTqDhNb3cvlofBaaFGVL48/BBXF+Wh?=
 =?us-ascii?Q?OCpI23CKB3zWCc8OvZEZ2KPW9zInUyDvzt50i26JmhBIZumnfg9yyTh+l9qR?=
 =?us-ascii?Q?3I2cq+IdlnXxFjUoXL4x+RHUjTo4fhZISMpMKPYN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa886b5-3b0c-4ff4-85c6-08dd9cd8b03f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 04:41:04.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IL0BcglGre9VfiJcGivY6rCtfuO0AD1fGmm7Fv5MiaTjna0qLsja+9XhE1MqS9YL00Y99lO+TaWtATFan7xYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183C9380E
X-OriginatorOrg: intel.com

> > +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> > +						pgoff_t start, size_t nr_pages,
> > +						bool is_split_operation)
> > +{
> > +	size_t to_nr_pages;
> > +	pgoff_t index;
> > +	pgoff_t end;
> > +	void *priv;
> > +	int ret;
> > +
> > +	if (!kvm_gmem_has_custom_allocator(inode))
> > +		return 0;
> > +
> > +	end = start + nr_pages;
> > +
> > +	/* Round to allocator page size, to check all (huge) pages in range. */
> > +	priv = kvm_gmem_allocator_private(inode);
> > +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> > +
> > +	start = round_down(start, to_nr_pages);
> > +	end = round_up(end, to_nr_pages);
> > +
> > +	for (index = start; index < end; index += to_nr_pages) {
> > +		struct folio *f;
> > +
> > +		f = filemap_get_folio(inode->i_mapping, index);
> > +		if (IS_ERR(f))
> > +			continue;
> > +
> > +		/* Leave just filemap's refcounts on the folio. */
> > +		folio_put(f);
> > +
> > +		if (is_split_operation)
> > +			ret = kvm_gmem_split_folio_in_filemap(inode, f);
> The split operation is performed after kvm_gmem_unmap_private() within
> kvm_gmem_convert_should_proceed(), right?
> 
> So, it seems that that it's not necessary for TDX to avoid holding private page
> references, as TDX must have released the page refs after
> kvm_gmem_unmap_private() (except when there's TDX module or KVM bug).
Oops. Please ignore this one.
The unmap does not necessarily cover the entire folio range, so split still
requires TDX not to hold ref count.

