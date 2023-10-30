Return-Path: <linux-fsdevel+bounces-1526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35107DB4E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 09:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9B21C208A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 08:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB90FD27E;
	Mon, 30 Oct 2023 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4gTJher"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B5D267;
	Mon, 30 Oct 2023 08:12:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504ACA2;
	Mon, 30 Oct 2023 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698653537; x=1730189537;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N7fgkNsYqzyQEPdyjc5ZvJhPw1EHpN8HXepKO0W0mGg=;
  b=d4gTJher4XgPHEUYvoXBGn+3UFCW7TVR4aXbDJIhLY9aTxofF9aiwi6l
   uCHnO0Wunq4qK5kAYZpOff8IpLyaiw7T+FqcfKTVQqETFJQQ9nwUJ7jSx
   P92zZMHc9bPUoEb9S7tEIw7gfRlJgTXeQImKy8fz57dztjP1fL5VM+fmR
   4GZKl+JxiyuOtVpheNvR2+pJX2JPpdEUchVnMK9a8PneDZIUlUe4lzp+3
   OtQBmCtEdU4A54uJINhUqtK+WFGkokRUD0p6Tg8RIFVzpQAQ9eSNHbexV
   kosp3nY5iRcmQWDpM4q3PqvmGGB9MbBdDI1Rz86HVUl1ArpGK75aVL4aN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="390888816"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="390888816"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:12:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="830612580"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="830612580"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 01:12:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 01:12:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 01:12:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 01:12:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKR9snjzNe/Ze86/qVyvbmy4AQSAF5la52gpnZexKPjrurBMmU1F8x0WKpvEL6sfPcz6f0Y3f+e/n6XoIHe38SK6OmsfUWa69hPx5bh1Mb8j/RSRmp1mou/RfwNhzqwNsFfRRRcpdTEsp87pjIyBdBKXlPR4yKak7R2DvVoQA6E85XPg4pqZXQ7E063yjLYfHSIC1gD4XkmJoU56tYad7BVjGbfFbS4iCXGbppebi2r1T62/NPg3t/E9l5hoUIpBlsSs16UrWQ5Af5JIqkDXlIo73+dNuB8imoentRNfdQfndKL0wVW2CVVdUfScDVURgSDXKCGJOz19sO+5Q82mNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9vkp1CJIfW1AIEPRn0itXrQbWQ42HgzTp/f393cgFg=;
 b=fBK+a9k2esbaO4oiP0mi+tmuzoOLrCMwU2/Sl3kUqXJQH30CQHnfE5GKZvMnZeI9uMcn7K+JC344rHzF+XgXlJne+snOdtgXCYunbIYJQjqmG2eiqvdWtOfnUQvhzo0PljACSw/JIzlVV0oVxhtbHJX03tD3e2U1fkeozyVcfxW16nEJrQsK6DvVKVxsjbaPRD8yfB+1sqNjyFPUPDVK6kafCvVZ7PIP0yjRvlRu+dGBIzrzUYG6ws5rxoZcacPozZh58hZUHcdWUaO3Kb1YfeSbfRY4m3BVsOv66I5jZlmCaho5Dt1EDeqG3B0/k3uAo/+zgNCSOeKFjE7eDPu7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DS7PR11MB7782.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.27; Mon, 30 Oct 2023 08:12:07 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::6227:c967:5d1d:2b72]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::6227:c967:5d1d:2b72%5]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 08:12:07 +0000
Date: Mon, 30 Oct 2023 16:11:47 +0800
From: Chao Gao <chao.gao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	"Oliver Upton" <oliver.upton@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
	"Michael Ellerman" <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>,
	"Paul Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, <kvm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Xu Yilun
	<yilun.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba
	<tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy
	<amoorthy@google.com>, David Matlack <dmatlack@google.com>, Yu Zhang
	<yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Vlastimil Babka
	<vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>, Ackerley Tng
	<ackerleytng@google.com>, "Maciej Szmigiero" <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, Liam
 Merwick <liam.merwick@oracle.com>, "Isaku Yamahata"
	<isaku.yamahata@gmail.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
Message-ID: <ZT9lQ9c7Bik6FIpw@chao-email>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-14-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231027182217.3615211-14-seanjc@google.com>
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DS7PR11MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 0492113d-a4d0-4a22-4f72-08dbd91fe8a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IW6w/QjkvzkXweV4lRD4ALJJE/n7n54hL8mSCjWHjSaCLzqdxibA9dABe06l0+6sHr1I1Ou+9Zycg3qgjsSdQ9BBaAMNHJHnUBJ28aZ1iKDbYVpzKt5qMKTfR1ecRZkiHrZXhJIfcmEwtSb254AzJQwMIAKNuC7MqqTRlL0H3MBhSwc2vIiuc+qTGRPXeEU8DeIKnUEPgoBiUoYJY1HwiUGgfsXEKJho2Op8NI9X8W9/SE7BwYAOy+u8HVNfPWwTaF0gyFmEb0hBVSuQnYWfeh40Atgp3BP1BFWFr/NZEwWqVQqFk/CQuyeKyYrO1LpWICaFdFN7MdzPZw2TqPOgnrA9x3rM3NpC1Ozd0WtB/s76S+ARQKoceEUVGrPWIKWvtsfaBY+SSZUV5FDoxaehHNtm9gSIGdCAjCEhpNAMUaq2etUl4FlfCaPMiNV5HZvdzX5f/zKC593U6na4MsH6aW8Xl4u4cWae0EVsjgTpDcfPDl8ulSILcgfIw4J1diz++gnVPHIamR0iVaCBEorx7a2eyUiirgi3Bx4FScEwRdGbaWNQy101LhUKPvPVDWEB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(5660300002)(41300700001)(7416002)(2906002)(7406005)(54906003)(66946007)(66556008)(66476007)(6486002)(8936002)(8676002)(4326008)(44832011)(478600001)(316002)(6916009)(33716001)(38100700002)(83380400001)(86362001)(9686003)(6512007)(6506007)(6666004)(26005)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PI9DcH28XxTUT57eRoZ+dDxXY7h0KtSmfut7rIfbLrakHC93YTpMht0me4NP?=
 =?us-ascii?Q?+dZbsEOijvLTO78IU9qzCUDHO7FbPDkcDFwkgKDu51oGTb8Lc475xJptX/R9?=
 =?us-ascii?Q?JJhdmCgmXbt1QhLlYhWdMvTgjj8/MOcU375ZVoNkr9/6OqU+bRZE32yRA7he?=
 =?us-ascii?Q?2aeCqmjIU7hbGP8WruM4QYEUFOp0tZV+O15aPG016Qonq1vojJj1fXvUlUcL?=
 =?us-ascii?Q?1jGStrE9NjHp1HAZTqQx2k4GmmTN0dPVV+kKTqTxluCHm12JwEjd5BfXX0co?=
 =?us-ascii?Q?Wj5Dlfmjf7cK9gtHvxVCSDljax2HjCpGX4JFNRKDcwDzlmlcvrCwFITytVI7?=
 =?us-ascii?Q?CCxhwWocBeFJ722Fe/B4m5LhK101EyUMEEJeisubZFh+l6k5xiHRWhCPxYx7?=
 =?us-ascii?Q?3/f6HWbEXcxkeaTPjfUh1rOffHYw7IMGffvv4zpX5H2nxdlJWzfPnmR3zED2?=
 =?us-ascii?Q?XHv/m1ReO1jporBEAu/Cp/K5dOReZYF79Hdz3ER+nZn4+UirelcNCSFWeQN+?=
 =?us-ascii?Q?hjUilkET97E4YH+tzieMyNsK0FlWVcfslRVBa9DU6cS9GDWflyOUD3gcZ0V5?=
 =?us-ascii?Q?53yKJc3uVXSuWtqWr6Xdg5DsAT94IyKPyxpLRobQw0AoUVWy0zR40p+EDcq9?=
 =?us-ascii?Q?WygtI8kIRjOPlQ1tOl9OhvrM5t5y3JcgSaEFG0/mzSIT/CCoH0Z86Wnfqm3L?=
 =?us-ascii?Q?NqZgesKOjikw53iuIoUA1bgragghW9kbpbtnMySOtHYFM0OgIlKjGWbR5XoF?=
 =?us-ascii?Q?lZ4Ftv5dfEirm7UB/ktY1pGxqCm7ic6EZCt23e0vBlY8sw1aHZ9k2DVhpBXx?=
 =?us-ascii?Q?YcbhspeiiWAmGkZW0BFkkbr0xEG/4rtHVER4AsbLsHrEUyL5V286i/jEf+//?=
 =?us-ascii?Q?ijjaryACFRKtzrP+DyX9Wga6Qz6VAh3RbiG9GOOFT5U7V9Fbq1+wh/vFLILP?=
 =?us-ascii?Q?Ca4BssKHE5ETh31DPqQyCLP/M3n1DTkQbzYqh2aLbiFYlT9fL1mo0RiQEknB?=
 =?us-ascii?Q?sPMChZLKnWvVD5dp8L5Z/WbS4X/u3RtFyMYIf9zrbLPbr+hZyRRjC2koH7mK?=
 =?us-ascii?Q?uvXwSkV1vehdAJe3zjs1mS4E37PZMACc020CNztBVC7McUGnfY3siS82mNWn?=
 =?us-ascii?Q?1XYd/1mmLRoHSQEWTOm8ycDhGHBYOJcJzdTND6a9n3OIzAs7FTxgD/OF2l5I?=
 =?us-ascii?Q?DJsERjVPK0YY6NYMM3nJoSKR0bF9M4570q4vFT7Kc5MyojTyxO8SrNSsVM2I?=
 =?us-ascii?Q?w0o5rvtx5pskhuEFN6r0Av5sPX/deBxiJhsXiisbsJP/8amROtDpVgFa8cvy?=
 =?us-ascii?Q?jq7hG93xGAzWQZTa4a+jnaM5RVp3VImubvxTVo3P+FIVRJ+Q76A/tsk0aWOe?=
 =?us-ascii?Q?i00TTz/4zhtNgghMpM9f46oDgvIjkGb1O25c4Zozb4v3L6b0wJO4ly6QhCB2?=
 =?us-ascii?Q?hh8VE1fpvEefRFSFPwMj8wQT7J8yNfL2M9ib/pd7lfyvNq6F49xwm5HrmzKk?=
 =?us-ascii?Q?VoM6NbIbgPo6pxLPNf3622X0ug3UCp4E/hpJwnOx/sVh4JLD7ea5jFf3AWn+?=
 =?us-ascii?Q?AimAEb/L+MlyyYbAVjGZrYWAkTpuWRcuzY+IFxqR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0492113d-a4d0-4a22-4f72-08dbd91fe8a0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:12:07.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtLySxnyC6zgG2d7/Ju6fExQnsupAJ990YIT9LSkWZqTb+JKA9vsJHykP1HwwNUBTiYpU7iawhXJvFj6wwBmNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7782
X-OriginatorOrg: intel.com

On Fri, Oct 27, 2023 at 11:21:55AM -0700, Sean Christopherson wrote:
>From: Chao Peng <chao.p.peng@linux.intel.com>
>
>In confidential computing usages, whether a page is private or shared is
>necessary information for KVM to perform operations like page fault
>handling, page zapping etc. There are other potential use cases for
>per-page memory attributes, e.g. to make memory read-only (or no-exec,
>or exec-only, etc.) without having to modify memslots.
>
>Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
>userspace to operate on the per-page memory attributes.
>  - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
>    a guest memory range.

>  - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
>    memory attributes.

This ioctl() is already removed. So, the changelog is out-of-date and needs
an update.

>
>+
>+:Capability: KVM_CAP_MEMORY_ATTRIBUTES
>+:Architectures: x86
>+:Type: vm ioctl
>+:Parameters: struct kvm_memory_attributes(in)

					   ^ add one space here?


>+static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
>+					  struct kvm_gfn_range *range)
>+{
>+	/*
>+	 * Unconditionally add the range to the invalidation set, regardless of
>+	 * whether or not the arch callback actually needs to zap SPTEs.  E.g.
>+	 * if KVM supports RWX attributes in the future and the attributes are
>+	 * going from R=>RW, zapping isn't strictly necessary.  Unconditionally
>+	 * adding the range allows KVM to require that MMU invalidations add at
>+	 * least one range between begin() and end(), e.g. allows KVM to detect
>+	 * bugs where the add() is missed.  Rexlaing the rule *might* be safe,

					    ^^^^^^^^ Relaxing

>@@ -4640,6 +4850,17 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> 	case KVM_CAP_BINARY_STATS_FD:
> 	case KVM_CAP_SYSTEM_EVENT_DATA:
> 		return 1;
>+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>+	case KVM_CAP_MEMORY_ATTRIBUTES:
>+		u64 attrs = kvm_supported_mem_attributes(kvm);
>+
>+		r = -EFAULT;
>+		if (copy_to_user(argp, &attrs, sizeof(attrs)))
>+			goto out;
>+		r = 0;
>+		break;

This cannot work, e.g., no @argp in this function and is fixed by a later commit:

	fcbef1e5e5d2 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")

