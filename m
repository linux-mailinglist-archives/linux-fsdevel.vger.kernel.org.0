Return-Path: <linux-fsdevel+bounces-49897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10E3AC4A99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 10:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9345017C87E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA924BBFC;
	Tue, 27 May 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjWbnt+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23552248F6A;
	Tue, 27 May 2025 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335715; cv=fail; b=f6f+nsQszYUzZh4Nffr9h1cbQJcDTLrjFTN58waqwFZRaNrpeCMybV0xep6fHQPJ9fSCrWEUbbYUVwqlyA17EQQeUO4JQKQxC62w0rpw6epJAD0IlYaba10GRUgtLmNquGPtqoJa/9eIF/qXB+rZ52XrnmeFkl1WGAJRtcmUGdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335715; c=relaxed/simple;
	bh=CKPKIRAq1AD/JPYw1WnxAZGcfKW2B2xo1aIjt+QbUJw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JPLi9x6jLoZ7ZmVW4868pAgeCzzqYlI88+Of/Av0IubexdeU1WBQJbetK2qCJOrpt+ZCUpJM0eJMurR7UDJz60sn30L1YQtT8DLDSZ96WLUwnI5uJsWRyh1ndI7yxW05xSi5Z0PSXX65L2AsL4ZYVfV7PtPlOa+U4EdfutUrJkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjWbnt+n; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748335713; x=1779871713;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=CKPKIRAq1AD/JPYw1WnxAZGcfKW2B2xo1aIjt+QbUJw=;
  b=IjWbnt+n3pZYKYftOxR1lRGa54u/K31gKHLeMMtp/69+qOx/3xSQ9ZuT
   ykvRbL7bXmede7lKGC4mtj5jOXGkancMEn1KV8ADH4RH/feqOI40tlQqh
   RWJROgiH2gBbo/SHriAlqY8e3Ps8H/TQKgYZiPYoMnOlc7uYf4leyiSLy
   +rhntnv+rp2AF5jgG7hibtTQ782IXA2jpBGhDVjNjg+DGkYLa1iu85QhG
   JUhK9BgobvLG8FYG8RPyCV6otbQ5HQ3jdEQp6jXmcb90zI511pgbZuMrK
   EmwYapJsaMWiaJkXjI/KxeThAAVnTBkv5twG1DRjav0UY7WovLU6ZO14o
   g==;
X-CSE-ConnectionGUID: TlquUBHESmWy7J/2AZubRQ==
X-CSE-MsgGUID: wcLjqblzRn+c56WCYGJ24w==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="49568536"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="49568536"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 01:48:31 -0700
X-CSE-ConnectionGUID: xRxJznNQSx2QDNCv89guoQ==
X-CSE-MsgGUID: A6W8/kwSRfqQS99c8PvD/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="142577125"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 01:48:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 01:48:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 01:48:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 01:48:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3SyBcovSB6pOY0C8FIfHwuILhw03CPm1mZ1zKLn5hAT06rcpO0L3wC3PywA+/Urosq6lFxME8Yx9Pk0yk93Kbth0AdSggU0toAUuAtpOCJM8nbRP3xGU1Wu/Vou3zoRMH+InrOtByAXUVnZhcdB+Kv2Z9G8bYlydusA/glWmwHMnuNWQV770JnTO2iGFe2j00lQ/wVoI32jIdO0x8lEktL7WckTqyr5Jg9RJcJtcAmwf9vTd2BD2g1muU6pX+HSwuKHBltFFqUCfJLQC8tqRxUtpYhnqMqISUFXMwfLKb0aG23VmJeN7POM/etcT4VxxvJJyf0dbbaFJ9MWpnDqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNG+McTWe4AEScdElA4zyvWq3N7GBRoXZ3C+qxvIMj8=;
 b=BV7OUGoRj0671/Fks5mOEct+b4Y1od/8upCTHoS5IxYJTLVOfL26M7h3iKsl8m1m2T4fDHC1XQ+L2w6qGWcTPJAvVf1iNK9a2xE6rIWVm0TM4NPw20HoXkJjXtGfokYSt1AsaKuQGWkLN3wEzLkiQZNWyaOJljv+Izf5vs5VK43XJ8NbJqU97kFyCeaukPoGMbxo7KiS+ak5ydEyF0FHQQcgqqoLb9cRcnuUdTfSXBckf0ZBxzdWZK1ZriiUL+Oos3eTmHRCQcBhOcLY79W3OHE2PZqhHuGM6XG9mHgbXDB5VKMPtXGj0UB+f8ezaIC7XDFAhVeUqVBnWFMZxxv4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CH3PR11MB8708.namprd11.prod.outlook.com (2603:10b6:610:1be::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.29; Tue, 27 May 2025 08:48:25 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 08:48:25 +0000
Date: Tue, 27 May 2025 16:45:49 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
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
Message-ID: <aDV7vZ72S+uJDgmn@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: KL1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:820:c::15) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CH3PR11MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b13998-b099-4540-36cb-08dd9cfb3e5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aqiAUwrx9j5c28gwTqCStRs9by8w66DWVX/tyB6HuhqG87s1+dcjteZtJPJo?=
 =?us-ascii?Q?BV5v0Kr0gnLPRyxOfs3LtzXDAu9VmyxOf6GfvSmd531+RFVSGUT9Gxt2UCs8?=
 =?us-ascii?Q?qc3AACQxCVmzVupKb8A1C77IHAQQeda+nDzGfIHUAsqMa/RjGbcA2rSAxtF1?=
 =?us-ascii?Q?trw/Bv5/Lwyg7G0nIruceDZQ+5aqM/Bsp5vawzUmc2rfwFHLefL1cZAkQ1Xm?=
 =?us-ascii?Q?FWzvN3j4uuhKqe7yU7XoJLoDgAQ16NF22zsyv4e1BwzHrh0QICt648iXebSW?=
 =?us-ascii?Q?plvWcN5v6YkLfnjVJ+rXIZNPKH3KVspCt67NefN0kCXvSprbjAM4AhinEXKA?=
 =?us-ascii?Q?67GhBSXyY6G2Gq0zQSHZ1gdeOkzTTxgDQLusvrgen5xPj2JBxOp3mO4RyuO6?=
 =?us-ascii?Q?U0R5C9zCEwoPyH9Hi6OvCq32vEmaL0f3jcK9pZLMNaVnB6a6e7i8gf+9UKjQ?=
 =?us-ascii?Q?VF5dBVko0sAA3q8jOFdJRJ9G54iXymNs9fzt26ftTyPKRP8fWgZUK39tTHyC?=
 =?us-ascii?Q?iqMquu7XCYXJx4yytk6quWHvMVuE+UwMIA+GrG33hgi5WO0UpNK4y7hWIXUG?=
 =?us-ascii?Q?H3vKQveGvA2eEMoht7rcKKb/i3rMWLv/At6IIv3zZSdoYHo5HtKqmPBOw037?=
 =?us-ascii?Q?ZlIrtJyUdTcg6OUVtEusOJWC2Wc3sOmYPidC18OG0WkEoRUGFus6SFxGDBek?=
 =?us-ascii?Q?Kk8A88UMFDO415Bq/mzgxKkrkQ3ZhQ0iwJe4Q+OO18kosBf63YBl4IUfH0EK?=
 =?us-ascii?Q?PfLq3+vYK/3aJYptuqNtk+KeuS6r/JTRiwiq0vFOupDQxGjHAa1iMWMYJOFv?=
 =?us-ascii?Q?XxxCOYqzJRJ4+br7dHjigp44ChzOEQMj93zFpEooXXkVFH7GIls3mUww6V5c?=
 =?us-ascii?Q?6qXxFdBVD1Mg7relRdpqFjjykJaMcwaUV/9z3UETwdHr09tpFv7t0Bd+N5LQ?=
 =?us-ascii?Q?DCVLIXaVFKrTJdwrKASCqHwL+tVRLH/hMN00cQjnQWomkcJiHGkEfv/MoAUO?=
 =?us-ascii?Q?uX0bxiLtfQoftWBfvODq4Y3pojV8J9lPNNe5wiKQPuzcII6/FXlr6paRgNsy?=
 =?us-ascii?Q?Pw8IbAR2mJ4YWH7sGraMILcqt/SEkz486BHNx0h/8gsUlB8TECzxFA3sYKP1?=
 =?us-ascii?Q?MxOnrUj/AWVl/Q6s9TtDWeFIlbsFCCGKofE6W6++HtjVo166fXrmUAaXW3TL?=
 =?us-ascii?Q?NwdKrAzeWWBCK6PQ0Awhk3Zenr5ovupcxPxM2+L3/TXoO8WQJU/EtRi2kvXb?=
 =?us-ascii?Q?sXKUiYLWjeaWebMBSaZh//05WA3eMc5SzUzrbKrQ/kMDsiVuS4QdDAvwXtS6?=
 =?us-ascii?Q?qLyN+hO3fypu0k6nbdWlFaSw28wRpcxRqTNzHYEkzGhME4R4U0Q3gXBhO1D4?=
 =?us-ascii?Q?8yHwuDW5MaHvNTOUlmB8SzDRZ2LgvTiGBSH9C5t0S/kB3sgwMfJkOFfvxgkW?=
 =?us-ascii?Q?HvR5Esjl7IA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?heveNI/agmto1yD6zOBtA+/9PdDNsItzv2uVN/08aat1r1CKaWAPGgXIXdUu?=
 =?us-ascii?Q?bc8wnz7dAgu8wQQjmBFzGviU9awQmox/3aB0cdoJDqgz18AGyZwTM87X3zN2?=
 =?us-ascii?Q?0Pzj2Q3FPi7GwlGBcncV89gQk1A4UCui4TPnPGbLlPQ4nrD18H8I976whmnM?=
 =?us-ascii?Q?euu04kjfHB6ZPdg8n+iceJWJ75e+incvF8jsnuqIPzZD0FZQh+EA4XajyORZ?=
 =?us-ascii?Q?HjPGkX2A6IwyEEOclpvTxIaGa0ZJMw2LpZ1zuNTbpSxP6SshSxwqZEv1ZpV1?=
 =?us-ascii?Q?IK3dPcAwsXbuMen4SJIMyCtqpaLRprjNYg2mn2eGJoTH/it0d5pRhaMW8/Rr?=
 =?us-ascii?Q?WRJYeriUIhOJeoTLIirwW1HQ0Gtb6uk8DW4xuJz6qRF1p+eMQt+zWgLjEJJE?=
 =?us-ascii?Q?X8pJbwqNVANx3nasO+t9s9QvlkS+AjQsFKSXctEjlsycLCqFagTsqQR8V2hU?=
 =?us-ascii?Q?Im87zRuW+uBw2On5H6ZvwaGIb7kk6znBdMO6tXixlS26Jw0YcA6dWhBPkky4?=
 =?us-ascii?Q?6PBdHHb5mxG9T7lZvmLL4eHqJXAp20SwTVNI5jA4JUNDhmlelj2hk3CFXA4w?=
 =?us-ascii?Q?GiBKGcJyoHNRV0C3H5EhFP3b+Ljm4af8rh53oS8fgZ2/QXG6MQ1mywsM147K?=
 =?us-ascii?Q?59rb1XwygB4TpK3r2CtYrMR7yvPjQ+5PRv0Eeuk1yHT0fn/zyZUtzUCAxJWA?=
 =?us-ascii?Q?lY+6qR8e6zdfpaHI8e9UApcvw0fmITL6XfqefqCGtLizznrE9wvgvGT9S8iM?=
 =?us-ascii?Q?CCo83v0hAIAPbnVzQ0AwNy88ZbCfyVv9pGIUbEQaj6qg3Xdk+gKBU4liKycN?=
 =?us-ascii?Q?ymTOW8OL1kxfBFSIcIwai12JfmTe94ssBBXUw/S8E8IbkF7LATgNwGCfkTQ9?=
 =?us-ascii?Q?BBU8OAmvOovk1L8g5P1qykdr6NzK0VNJjU4FSK3+HYTO8og/kFQc6sk3QM5f?=
 =?us-ascii?Q?oKsmg9y+6cjimnMysEwoeADbpIdgORONMgcXQqED5wkcT6KOryB5vIVLv2SM?=
 =?us-ascii?Q?lAJ5dLjNrUR9uUGJ8Xjb/FbSyOG9ScSW9OWSEQB5sGQc6Ha6kk1DV4zm5SKu?=
 =?us-ascii?Q?N1kVYZmn5C/Czz0kq9HqwU60ZpyC+FE8ZQBhnhZbYpxy6q2oilTNy7MMhUOJ?=
 =?us-ascii?Q?NojoN3ty+oO3I4ZNbroEMjJPuhOgWnR1/i96VD1C88UkulPOqPY6ON7zeVEC?=
 =?us-ascii?Q?LoWMUZ0GwXscGrMw+2bXJuSC0LODrLSu7ue6smJFdCQOu1DAR7spOKvbe3we?=
 =?us-ascii?Q?MdSdz1Nk1a3ExX37/dg40j6zIM2AOs6FYrb3iEHxdwsovd0Io88c2pQmGKVT?=
 =?us-ascii?Q?IIQVls1x/Y+hD2y125QTbMazWDL0GQrnajYTFDB/K/UQ05EA948wGkqcVfHz?=
 =?us-ascii?Q?PR62ARUE++gqohAXlmpOLd4SZGAScpoH8IIF9yFnHWCPphZmlRi25eUxMUgL?=
 =?us-ascii?Q?cAf/SIg9T8lVbsRIK3v8rlgnlpo1oY3HTlNWwiPlYXFbNuK+ffBk7t5ikoF7?=
 =?us-ascii?Q?lJsPCc+rf4jMVcF/oka5XsovnOXTuK3rqwwh2D2X9N0dx1cCzDp+5Pu6WbgG?=
 =?us-ascii?Q?67CPo54FYkhyaQPd7ZSbUw0PhcP00TNZJhThOiod?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b13998-b099-4540-36cb-08dd9cfb3e5d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 08:48:25.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4r04zGLfzBvyD7IqwlZcbHlscwrptqQTteAFGeGDLs9Jsss6w/mrM0XdTUdHrnShiimeNTYdwEGIsNEOJQgPBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8708
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:42:17PM -0700, Ackerley Tng wrote:
> +static int kvm_gmem_convert_execute_work(struct inode *inode,
> +					 struct conversion_work *work,
> +					 bool to_shared)
> +{
> +	enum shareability m;
> +	int ret;
> +
> +	m = to_shared ? SHAREABILITY_ALL : SHAREABILITY_GUEST;
> +	ret = kvm_gmem_shareability_apply(inode, work, m);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Apply shareability first so split/merge can operate on new
> +	 * shareability state.
> +	 */
> +	ret = kvm_gmem_restructure_folios_in_range(
> +		inode, work->start, work->nr_pages, to_shared);
> +
> +	return ret;
> +}
> +
>  static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
>  				  size_t nr_pages, bool shared,
>  				  pgoff_t *error_index)
> @@ -371,18 +539,21 @@ static int kvm_gmem_convert_range(struct file *file, pgoff_t start,
>  
>  	list_for_each_entry(work, &work_list, list) {
>  		rollback_stop_item = work;
> -		ret = kvm_gmem_shareability_apply(inode, work, m);
> +
> +		ret = kvm_gmem_convert_execute_work(inode, work, shared);
>  		if (ret)
>  			break;
>  	}
>  
>  	if (ret) {
> -		m = shared ? SHAREABILITY_GUEST : SHAREABILITY_ALL;
>  		list_for_each_entry(work, &work_list, list) {
> +			int r;
> +
> +			r = kvm_gmem_convert_execute_work(inode, work, !shared);
> +			WARN_ON(r);
> +
>  			if (work == rollback_stop_item)
>  				break;
> -
> -			WARN_ON(kvm_gmem_shareability_apply(inode, work, m));
Could kvm_gmem_shareability_apply() fail here?

>  		}
>  	}
>  
> @@ -434,6 +605,277 @@ static int kvm_gmem_ioctl_convert_range(struct file *file,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_KVM_GMEM_HUGETLB
> +
> +static inline void __filemap_remove_folio_for_restructuring(struct folio *folio)
> +{
> +	struct address_space *mapping = folio->mapping;
> +
> +	spin_lock(&mapping->host->i_lock);
> +	xa_lock_irq(&mapping->i_pages);
> +
> +	__filemap_remove_folio(folio, NULL);
> +
> +	xa_unlock_irq(&mapping->i_pages);
> +	spin_unlock(&mapping->host->i_lock);
> +}
> +
> +/**
> + * filemap_remove_folio_for_restructuring() - Remove @folio from filemap for
> + * split/merge.
> + *
> + * @folio: the folio to be removed.
> + *
> + * Similar to filemap_remove_folio(), but skips LRU-related calls (meaningless
> + * for guest_memfd), and skips call to ->free_folio() to maintain folio flags.
> + *
> + * Context: Expects only the filemap's refcounts to be left on the folio. Will
> + *          freeze these refcounts away so that no other users will interfere
> + *          with restructuring.
> + */
> +static inline void filemap_remove_folio_for_restructuring(struct folio *folio)
> +{
> +	int filemap_refcount;
> +
> +	filemap_refcount = folio_nr_pages(folio);
> +	while (!folio_ref_freeze(folio, filemap_refcount)) {
> +		/*
> +		 * At this point only filemap refcounts are expected, hence okay
> +		 * to spin until speculative refcounts go away.
> +		 */
> +		WARN_ONCE(1, "Spinning on folio=%p refcount=%d", folio, folio_ref_count(folio));
> +	}
> +
> +	folio_lock(folio);
> +	__filemap_remove_folio_for_restructuring(folio);
> +	folio_unlock(folio);
> +}
> +
> +/**
> + * kvm_gmem_split_folio_in_filemap() - Split @folio within filemap in @inode.
> + *
> + * @inode: inode containing the folio.
> + * @folio: folio to be split.
> + *
> + * Split a folio into folios of size PAGE_SIZE. Will clean up folio from filemap
> + * and add back the split folios.
> + *
> + * Context: Expects that before this call, folio's refcount is just the
> + *          filemap's refcounts. After this function returns, the split folios'
> + *          refcounts will also be filemap's refcounts.
> + * Return: 0 on success or negative error otherwise.
> + */
> +static int kvm_gmem_split_folio_in_filemap(struct inode *inode, struct folio *folio)
> +{
> +	size_t orig_nr_pages;
> +	pgoff_t orig_index;
> +	size_t i, j;
> +	int ret;
> +
> +	orig_nr_pages = folio_nr_pages(folio);
> +	if (orig_nr_pages == 1)
> +		return 0;
> +
> +	orig_index = folio->index;
> +
> +	filemap_remove_folio_for_restructuring(folio);
> +
> +	ret = kvm_gmem_allocator_ops(inode)->split_folio(folio);
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0; i < orig_nr_pages; ++i) {
> +		struct folio *f = page_folio(folio_page(folio, i));
> +
> +		ret = __kvm_gmem_filemap_add_folio(inode->i_mapping, f,
> +						   orig_index + i);
Why does the failure of __kvm_gmem_filemap_add_folio() here lead to rollback,    
while the failure of the one under rollback only triggers WARN_ON()?

> +		if (ret)
> +			goto rollback;
> +	}
> +
> +	return ret;
> +
> +rollback:
> +	for (j = 0; j < i; ++j) {
> +		struct folio *f = page_folio(folio_page(folio, j));
> +
> +		filemap_remove_folio_for_restructuring(f);
> +	}
> +
> +	kvm_gmem_allocator_ops(inode)->merge_folio(folio);
> +err:
> +	WARN_ON(__kvm_gmem_filemap_add_folio(inode->i_mapping, folio, orig_index));
> +
> +	return ret;
> +}
> +
> +static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
> +						      struct folio *folio)
> +{
> +	size_t to_nr_pages;
> +	void *priv;
> +
> +	if (!kvm_gmem_has_custom_allocator(inode))
> +		return 0;
> +
> +	priv = kvm_gmem_allocator_private(inode);
> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_page(priv);
> +
> +	if (kvm_gmem_has_some_shared(inode, folio->index, to_nr_pages))
> +		return kvm_gmem_split_folio_in_filemap(inode, folio);
> +
> +	return 0;
> +}
> +
> +/**
> + * kvm_gmem_merge_folio_in_filemap() - Merge @first_folio within filemap in
> + * @inode.
> + *
> + * @inode: inode containing the folio.
> + * @first_folio: first folio among folios to be merged.
> + *
> + * Will clean up subfolios from filemap and add back the merged folio.
> + *
> + * Context: Expects that before this call, all subfolios only have filemap
> + *          refcounts. After this function returns, the merged folio will only
> + *          have filemap refcounts.
> + * Return: 0 on success or negative error otherwise.
> + */
> +static int kvm_gmem_merge_folio_in_filemap(struct inode *inode,
> +					   struct folio *first_folio)
> +{
> +	size_t to_nr_pages;
> +	pgoff_t index;
> +	void *priv;
> +	size_t i;
> +	int ret;
> +
> +	index = first_folio->index;
> +
> +	priv = kvm_gmem_allocator_private(inode);
> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> +	if (folio_nr_pages(first_folio) == to_nr_pages)
> +		return 0;
> +
> +	for (i = 0; i < to_nr_pages; ++i) {
> +		struct folio *f = page_folio(folio_page(first_folio, i));
> +
> +		filemap_remove_folio_for_restructuring(f);
> +	}
> +
> +	kvm_gmem_allocator_ops(inode)->merge_folio(first_folio);
> +
> +	ret = __kvm_gmem_filemap_add_folio(inode->i_mapping, first_folio, index);
> +	if (ret)
> +		goto err_split;
> +
> +	return ret;
> +
> +err_split:
> +	WARN_ON(kvm_gmem_allocator_ops(inode)->split_folio(first_folio));
guestmem_hugetlb_split_folio() is possible to fail. e.g.
After the stash is freed by guestmem_hugetlb_unstash_free_metadata() in
guestmem_hugetlb_merge_folio(), it's possible to get -ENOMEM for the stash
allocation in guestmem_hugetlb_stash_metadata() in
guestmem_hugetlb_split_folio().


> +	for (i = 0; i < to_nr_pages; ++i) {
> +		struct folio *f = page_folio(folio_page(first_folio, i));
> +
> +		WARN_ON(__kvm_gmem_filemap_add_folio(inode->i_mapping, f, index + i));
> +	}
> +
> +	return ret;
> +}
> +
> +static inline int kvm_gmem_try_merge_folio_in_filemap(struct inode *inode,
> +						      struct folio *first_folio)
> +{
> +	size_t to_nr_pages;
> +	void *priv;
> +
> +	priv = kvm_gmem_allocator_private(inode);
> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> +
> +	if (kvm_gmem_has_some_shared(inode, first_folio->index, to_nr_pages))
> +		return 0;
> +
> +	return kvm_gmem_merge_folio_in_filemap(inode, first_folio);
> +}
> +
> +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> +						pgoff_t start, size_t nr_pages,
> +						bool is_split_operation)
> +{
> +	size_t to_nr_pages;
> +	pgoff_t index;
> +	pgoff_t end;
> +	void *priv;
> +	int ret;
> +
> +	if (!kvm_gmem_has_custom_allocator(inode))
> +		return 0;
> +
> +	end = start + nr_pages;
> +
> +	/* Round to allocator page size, to check all (huge) pages in range. */
> +	priv = kvm_gmem_allocator_private(inode);
> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
> +
> +	start = round_down(start, to_nr_pages);
> +	end = round_up(end, to_nr_pages);
> +
> +	for (index = start; index < end; index += to_nr_pages) {
> +		struct folio *f;
> +
> +		f = filemap_get_folio(inode->i_mapping, index);
> +		if (IS_ERR(f))
> +			continue;
> +
> +		/* Leave just filemap's refcounts on the folio. */
> +		folio_put(f);
> +
> +		if (is_split_operation)
> +			ret = kvm_gmem_split_folio_in_filemap(inode, f);
kvm_gmem_try_split_folio_in_filemap()?

> +		else
> +			ret = kvm_gmem_try_merge_folio_in_filemap(inode, f);
> +
> +		if (ret)
> +			goto rollback;
> +	}
> +	return ret;
> +
> +rollback:
> +	for (index -= to_nr_pages; index >= start; index -= to_nr_pages) {
> +		struct folio *f;
> +
> +		f = filemap_get_folio(inode->i_mapping, index);
> +		if (IS_ERR(f))
> +			continue;
> +
> +		/* Leave just filemap's refcounts on the folio. */
> +		folio_put(f);
> +
> +		if (is_split_operation)
> +			WARN_ON(kvm_gmem_merge_folio_in_filemap(inode, f));
> +		else
> +			WARN_ON(kvm_gmem_split_folio_in_filemap(inode, f));
Is it safe to just leave WARN_ON()s in the rollback case?

Besides, are the kvm_gmem_merge_folio_in_filemap() and
kvm_gmem_split_folio_in_filemap() here duplicated with the
kvm_gmem_split_folio_in_filemap() and kvm_gmem_try_merge_folio_in_filemap() in
the following "r = kvm_gmem_convert_execute_work(inode, work, !shared)"?

> +	}
> +
> +	return ret;
> +}
> +
> +#else
> +
> +static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
> +						      struct folio *folio)
> +{
> +	return 0;
> +}
> +
> +static int kvm_gmem_restructure_folios_in_range(struct inode *inode,
> +						pgoff_t start, size_t nr_pages,
> +						bool is_split_operation)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
 

