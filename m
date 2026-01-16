Return-Path: <linux-fsdevel+bounces-74193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D058D37A69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97235311E08C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471B395DAC;
	Fri, 16 Jan 2026 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3LZGhnM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62CA78F2E;
	Fri, 16 Jan 2026 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585027; cv=fail; b=kvcePPxRNq4hcjjc0oOw0HaqliB6UnPgFrsiKhMp6Id6F67yyPKW+69UHtiFD9yGkOyU6z4Un4JqgEZFfRLB9NJdZx3W9a0FRnwzVURHfG8eLRdV3axJuZuhfRT2jMer60Mp7dJj96jwCZfO04AYAqjdPmz+GobQcvEXm0jr1No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585027; c=relaxed/simple;
	bh=1mLLK/ak0FvRFYl4Mh6M8RDD/BUgBoxOziWMpqaCXys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AJtGaEa5XWw9aiKsSPY4RMM7ZndSQMtd2uP2wjeyy0Vvg42WseealCJbiBxo2gO3SmjDLER+lNz9c6AKQ/yP6VdIPd0Se8Q23x4XFsjw34FOiFDCPCEYJxDecHEaNp2i8EOtOyBnm+bs/rEN4KKdEx0Mkjsu5E42EQbMW8FkLdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3LZGhnM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768585026; x=1800121026;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1mLLK/ak0FvRFYl4Mh6M8RDD/BUgBoxOziWMpqaCXys=;
  b=c3LZGhnMKGkf2A8SzhjwQ9RjQ3wlcwg/uYs2RDt0ZEV5U2vI6xlfYOmf
   9NmJDI5yeAxLZqWLb/EkZua2JkfTYWkvEtaAv88FUO8aPsLvKPBIBhCcg
   yvG0jeiUCwSX8eO54uva9R+ZofwhrOjqU5uazCOywQ2hqQHIcFGTaPqgp
   WBeejs4rSSFbJzKCH3sZiMzc7RxM254kvJaR6fiFES+dBk2OFxJsLAveE
   T6ep2S7H2sFasmoNRmRxKjnpRv9NoRtWfyYPS7dMksNYQp8S9V5GTeLw+
   1xaQTdijmuKt18amSreWIQVgryjwFViKc+JM8MDHHi1Vcli8Pi5HdlFKY
   g==;
X-CSE-ConnectionGUID: nake/3gcRyWR1femW/lDFQ==
X-CSE-MsgGUID: uQpOJm0mR32BF9YpdGElIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="81272531"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="81272531"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 09:37:04 -0800
X-CSE-ConnectionGUID: JSbdOqhiQXmHrOVJRZ8Fng==
X-CSE-MsgGUID: 1aVVpv5SROWxW3dapzT9dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="235985509"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 09:37:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 09:37:03 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 09:37:03 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 09:37:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8WW1kNPkta1LfI9tfQet3FRzvj307R2cJcZo/bWrwZztAV4RWegntOPup0K0uRu0WtvbYInK8Rrb3mnSYcNcDqFQSBncvH15uPur7kMskhuTIMH4zL9O3SMp9r1xmhJQqt0oud1pEjyH1F+Fl24nuEYJhtF6bLKvMTWKDafZfan4+DHaQj7ME3omQAj+FKWhdc8Ihm2mdvvTcLf4Rk15CNiMeZhGFB/5F228bk+NV3MowcbSlz5L4d26vQNHApcPUqpBHjynDbgHmj4m6VoFHkxVVYBTSSbQtBHk6YpWsnl5YifELY3BA7sMk5XtiZlVhpSwA0PfciP5l3uY42UHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mLLK/ak0FvRFYl4Mh6M8RDD/BUgBoxOziWMpqaCXys=;
 b=hstnRG9NyaoS5uExGqtoqVqeMb4sEuxwzpvQ6gswuV2ElVrlRzqndqrqSa1fKC6DZlaFbyuW27CYMIFtozbr7McdDRPaVgxzMlQsmvq69HkZAlu33jwPU/qnLXMKOU/xFur/5eyykqNyLhNf/Y8fnGcQ4anyCbwfDvNl9lxKD+VJ/twepRI5inDH4LaXG85sYrQ4DP4+gIQiM8Nllf6SYvqA/VkvyDOmdkMY4sKDtO0zF8Xs3Ax3Y+yfPdXn2hb340FG0rcTXP2fyBdAfY/TLEBnozxATTDFdFsCHrcdebNsctKsQtLZXJoJQ5WlmxK22BQT8AbZAFt4YIOJmgYY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 17:37:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 17:36:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kalyazin@amazon.com" <kalyazin@amazon.com>, "kernel@xen0n.name"
	<kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: "david@kernel.org" <david@kernel.org>, "svens@linux.ibm.com"
	<svens@linux.ibm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "jgross@suse.com"
	<jgross@suse.com>, "surenb@google.com" <surenb@google.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de"
	<pfalcato@suse.de>, "x86@kernel.org" <x86@kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org"
	<maz@kernel.org>, "peterx@redhat.com" <peterx@redhat.com>, "ast@kernel.org"
	<ast@kernel.org>, "Annapurve, Vishal" <vannapurve@google.com>,
	"pjw@kernel.org" <pjw@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>,
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"jmattson@google.com" <jmattson@google.com>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hpa@zytor.com"
	<hpa@zytor.com>, "song@kernel.org" <song@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jthoughton@google.com"
	<jthoughton@google.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"itazur@amazon.co.uk" <itazur@amazon.co.uk>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"andrii@kernel.org" <andrii@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "derekmn@amazon.com"
	<derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "jackmanb@google.com" <jackmanb@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jannh@google.com"
	<jannh@google.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kas@kernel.org" <kas@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHchnGR8zlgd593vU675Y8ML/1Q0bVT6T2AgAD7kQCAAAm5AIAAH4kAgAACwQA=
Date: Fri, 16 Jan 2026 17:36:59 +0000
Message-ID: <c42cc00f3902673b1a964c3d098b8c3f236cf9a1.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
	 <20260114134510.1835-8-kalyazin@amazon.com>
	 <e619ded526a2f9a4cec4f74383cef31519624935.camel@intel.com>
	 <294bca75-2f3e-46db-bb24-7c471a779cc1@amazon.com>
	 <bb58a21f91113ca39f8888d718d4450a5fd72808.camel@intel.com>
	 <318407ba-ecb6-4691-8911-645fb8c20250@amazon.com>
In-Reply-To: <318407ba-ecb6-4691-8911-645fb8c20250@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: 6b5c1b60-8e82-42f0-50c7-08de5525da5a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?a3JjMUkxN2tJQktMdXh1UGNITlpxOFJsUU1uK0MrS3F4Z1NueDVjUGhITkdY?=
 =?utf-8?B?TXQyVDNzY2djOUROMFR6UWlFNlMvL0dvdVRlZWx6QVg5cnJKTFBXTkpWS0Vi?=
 =?utf-8?B?WVhvMUVrWGJTc1gyQzNBQnZvWVFuanJ4L1Nqb3A1ejJ6S3Y3cGtCV1c5TU53?=
 =?utf-8?B?MTJpTkY5V0xFc05NSXFNRHowcEpLWExJbXYwM1piN2l1R0Y5VWxubnhwQWRG?=
 =?utf-8?B?MUhqbXo1OVFuZEdXcUlNaU4wVXBmT0Z2dmtMMHhWeDI4eHZLT2RuRFFuMC9B?=
 =?utf-8?B?SkNIVWg3K0JiVHpjL1JySEhmWXZxemg4Ni9pNG56UnFCVksvM3FUNFp4Wnho?=
 =?utf-8?B?VmxMYUtRc09MODg0N0pYeTU5bDR4VEZFZGhsWmxuRDBHbml6ekVxYWthZTlY?=
 =?utf-8?B?T2g2cHcramwyK3ZPLzVidlFXRmluTlliRTJDTldDOFVYamlaTTFLak43Y0h5?=
 =?utf-8?B?dEYrMkNoUzdQS0taK2RQSXJvdmpTWVRidG1iSVl2Z3lhbHRhRlp5eDVsM0s1?=
 =?utf-8?B?MGkxdzhhZFdvZml5VFNkOE1mZmJpU1BWUThvVWgycm1ZeEc0eTZnWW42WlJU?=
 =?utf-8?B?aExlUDd2Z2gxbVhqcHcrd0cwMEsweE0zNFlwekFGblNsUGFwSEV3ZkRtdXl5?=
 =?utf-8?B?K29QM1ZxNWZyTERuZjQrNkNnWTJwZlI5YUhQaEJSOVh3ZGNwTzh6VEFscFpk?=
 =?utf-8?B?WmpLUUJleXI4bW5vKytrRVpKYkNXZ1IzMGVvOVJwQ1FZYjNORXBmTFBFQXlX?=
 =?utf-8?B?em5WaHdocnU4cVdvY1ZNUEYvaFdjZnF5aDlGODJ1SUdraUhtc090cEtpSU95?=
 =?utf-8?B?bGxHNzdleTVXT1FNQjRlZ1lPMDBFZXV6RU1GNHhTdEpRZ2k3akpwcWlQUW0v?=
 =?utf-8?B?SVBRaUVvMzB0cFpRUGNEQWZNQm14Mjg3d2xQVG1uWnFrOUdVcjc3RFNzSFJB?=
 =?utf-8?B?NjEvRUtReWJoZjVQajdpWkFOOVB0Tk5XT0FPNE1BSXY0d3U5ZWxCcUd1TGxL?=
 =?utf-8?B?RXl2aWNvU2NacEdkdkpVK0FGbnV3RGJBdDdlb2ZvT2pnc3NnVnJrcnZFUFN0?=
 =?utf-8?B?aEdLOC9TQWNoRC9HWnV1RlllYTNTTVcwekZyME5MZUlTWEdGVzJhMWZHK1RS?=
 =?utf-8?B?UFF4Q01KbDZjSktsanZQTFBFRTJOaUtreVF1VG9uM01COXhPNlhFV20rVUEx?=
 =?utf-8?B?K1FMUDFxZEZYQ1AyQVg3VjI1eGRLeit2bDhWSUM0bTk2OXFXUklqN05rUmxF?=
 =?utf-8?B?YkZRNUhwU3FsaE5nVVA2Q282TGVRTCtrQldpeEF6VDJkbnM0Y08rWW9LaXpS?=
 =?utf-8?B?cWJueHN5d3NnT3N5Tmh1bktGaXZDcTF1NS9uMGN6Tm5tSDhtMEtUU2VKZFc0?=
 =?utf-8?B?aWtINE5GeUJoc1VKb1dUWG92bllDNVJlRitXeWxFQmdHOFNrd3JkOHJidVEz?=
 =?utf-8?B?UFFNVmk3dEtSZnAzMjlmVDJxQlRqaE12MHRsejBMRllPSTF4VVMxT3Q5THV0?=
 =?utf-8?B?S3YxeEFYdmFiRWlZeDR1UG9wVm9ZYjFVbWN5ODJwbWZzV29vRVZWbXBIclZM?=
 =?utf-8?B?WWQvZGNFM2p3dVZQN2d1WjhpSE1pWVloaSt5Q1RkVEZjWVBhT1NjNDNIS3JR?=
 =?utf-8?B?M0ZWc3Z5MEc1ZlI2MjNVZEtqNnBVeWd0Rm4xTEZzOEphT3ZrVStQTmp6NTdZ?=
 =?utf-8?B?SC8wZWRIZHE0VXBlUHU4cjFNSUhxR3B3UUs3cVZSR0ZjdGEvaHJuQ2xoWXl1?=
 =?utf-8?B?d1pZaDRlWUZvYkYzUjNLVWJ3eXVld3RLaEF4b3IyR2gxaTdxb3BSZDlBT3I1?=
 =?utf-8?B?MWJmSnZqMDc2REYvcG1GSDIvV21zQ1VqZXQ1UUsxYlg0bnJZUklqR3Z2TlAr?=
 =?utf-8?B?SjRKZ2wxUmZBNGxwS1d4K0IrZForSWNiQzhsNS9zbjArRVZnUUdSaWN6U0xF?=
 =?utf-8?B?WUNxejR3RFFIMzNHVGltTlBEN0lveVNLWENvUDRNL2RUeFBRMCtIbU1WVEpn?=
 =?utf-8?B?eDdycTNSQ3hYSFhpYzdoVlp5QmZaUG83eDBqMHB6am9kTmRHY0tBdGlES1hR?=
 =?utf-8?B?OGt2NERNMnc4RmFiREJRZ1N6OTNJWUd1SWpSajhQWDY1TkNWM0J6aFVkclU1?=
 =?utf-8?B?YlJycmRLQkdadWdwbnRPZS9HM3VuZGp5QTY3YytwY2ZBNEwwQWd3S0VRdUcz?=
 =?utf-8?Q?9bBr1pCPfC0LXqb6TWOydwA7b1y8gAlKuKoBHnca/4h8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzFlT3VBVmJHRzFYQmE4WnAyLzh2QkUxQUZhdldVVTJiejI2VThsbTRCREds?=
 =?utf-8?B?QkNCcWtuQVFWWWZXN0RPYmF0clBaYUdNaTNhT3d0cW1BRU5GWWt2QnFDUXdl?=
 =?utf-8?B?cnJBeU14UHRxQUt1UGFiRzljeUJsT0JHYWZaL3kxN1ZyZVpCaWJkK0UxUHFk?=
 =?utf-8?B?YlE4TitWakhKcGw2U1JKeURnT1huOGZjYWsraEhVbnlkNmlUZGp2MGdURWFH?=
 =?utf-8?B?eW5MRUE2U2hpNVNpQUxqTVhVYlNVYlo1a3ZXSm5tS3FnVk83eWFVdW5IQjlL?=
 =?utf-8?B?bUZmYU56VHdGek1HWGpieE9uVWpjUEkyN21TOFd6clNkWUEwd0xvUTd2ZUdz?=
 =?utf-8?B?bS9sWWdWRUtua01KRXZZQzJkMHRrVnRHbGtJQXVnSjJ5b0t6R0E1Ti9MTUNv?=
 =?utf-8?B?MGt6RDArNUZwdzAzTlU2Y0Npb1oxWkpIblNCUk1YdEU0ZUo3YVZNSS9FVTRP?=
 =?utf-8?B?dFQrejk4RFRTVkpRSEVLZ0V4ZktZdVcycGtSclBpdjVGeUtodWcxd2FJTnJv?=
 =?utf-8?B?aG5BWWk0T2ZxY1VHTXdNT1NmWkRIV1JFT21HeFpMRnViZEtRWkU1enFrNmkw?=
 =?utf-8?B?USsvTkFhSHRDQWNSSkdiSW5yK1ZRQkhUaGZmNmdjNTQxT0RzVTBWNyt2VGdo?=
 =?utf-8?B?UU55UTN6SVFYeWVwdFloaHhoSU41V0JOZldZQUdteGgxU1BkVkpVUlljY3ZE?=
 =?utf-8?B?eENyTERMYkJrZFliZ0d6eGNBbmx6SnpycVlsNkVUUHh6dXprNmtRcUZ5SFNH?=
 =?utf-8?B?TEdWblEyU3Nldm9LS2liVGtlVTVBelJZTkhreVdnS1FDOUhheUduWFhnU0pT?=
 =?utf-8?B?YWtWTHNDbDlxNWt0UDVUVngvb0svdmdMQldCT2hLR203cTdrTmxPL1ROU2dj?=
 =?utf-8?B?amxjUjZXMTVQNWdlNTZ5WW1rOUw5blgycG9uUUpUbjA4aFpYeHA2S2Y0SDBl?=
 =?utf-8?B?bTk3RzIwYzluZnZieDRXdCsrVGE5ZkxEdlp5V3Qwc0Z2WnRCeUtBRUsyNEJM?=
 =?utf-8?B?VW9lR05FN1lCOGRuZzVvMitadGNQVFJ0R2x4TWdoWWF1MkFPRnlIMkxRM0wy?=
 =?utf-8?B?dFJhYkhPbENZTEt4REV6L2ZGcW1TRi9aRXNkclFCNFpHcGFiWW1TRkpnbEZr?=
 =?utf-8?B?Wk9xNWM3Z0ZQR0V2Mkd6MFlpWHJJc1kyaDNPRVpPQzZURHlxYlpsMkNTcmwy?=
 =?utf-8?B?TUp2em5IdEgrS2praTBUanVGVklnazZ1T2xlcktpSVJKYmZCUzJqQlNmdVlr?=
 =?utf-8?B?K2RvR3F3K0VFSDdxMWhtNXNYbkF6SVZQS0U5eU9ZcHp1eEp2dDlZZUo3YzdW?=
 =?utf-8?B?M1p1UFRjdW43Y1ErQldXK0pabXczVFFER3FRcm1vYzlkcERpTk9vakEwb0FY?=
 =?utf-8?B?L3hDZEZnMzl2YjU2SVZvbmphaHE3RE5nODNadFYwL3FMYmFLOXhzZ1RaeU0v?=
 =?utf-8?B?Tk9iWGFBaEg0R1cza0hUU2tuRFcwS2FwZDUzVlE2bE5CUlVLRzE3YlhDQUx3?=
 =?utf-8?B?R0xhbTNvSitRVGlrNkVleDZXdGNGK3ZHMFVJRjh6NW8ySEhsWElqMjF4YUpx?=
 =?utf-8?B?TU4wOW9YTjdtaythWk5Jays5RzBybHYrOU1jNTN1Ym54d2FPTVJyL1lrL0Fz?=
 =?utf-8?B?QXFGOUY0MHFYYjFvdjQvK1puRlJGWCt4RVhDQ0orOUZrWXpWeFNTOC92Y2NC?=
 =?utf-8?B?UWU3cFd3RW1FRlBZV2s0cjBueFdxVXpJYmd4SUJGV0c3ajUySXB2N1BQbDVE?=
 =?utf-8?B?MDROdmpPeTJGd1lKZzE0TXZ5TXJXM0p1SUVYdGY4dStCb2hoR0RiUlhDTkZ5?=
 =?utf-8?B?WmJES2IwbVF1Q0pDeUJrU0pzaE1IV1l2R3hEKzBnZ0VrdVdSVG9PNERVWmRw?=
 =?utf-8?B?QTRicnZpZ1VPTC9hSWJHWElPOGZDR3NpckhNUTh1cUI2aFROWWVJZ0VJbkNm?=
 =?utf-8?B?d1ppWUUvcFN0eXg2cTdQSXdHbCtmS0FiVVZkUSthSkVsbWVQVzdUaFg2bDJn?=
 =?utf-8?B?VUNlQ2ozZnBPQUFBSDVweHZzNDFBOHM2aGdzZWNyZk92RDIwOEFIdGhueDg4?=
 =?utf-8?B?TFdrUmcvZGJFcEUySUN2cWlOWUx0aTRjRlhtWkxJRGJKeG80YjJscFNkSnZZ?=
 =?utf-8?B?Y2lFRnZCOFQzQlZjaWJDYzljZ01CbTFicThRUlMwMGpOaDhEK0VkdDNHNEFE?=
 =?utf-8?B?ME80K0VSK1c4cVoxa2hQOHF2K2NKV1ZrdFZsSXVHdXArcmJaYmhxV2k2eG9T?=
 =?utf-8?B?K3FYNUxTdllLNHFBWmJBUlpZUjF1a2x1YmVqbmJ0Y1BSSTRzbFRveUYxVEgy?=
 =?utf-8?B?NERHZDhVbWYwNXhlUitod0hlOXRYdkxVb2NqMVBCMDhzYzNHemg1dDZQaUQr?=
 =?utf-8?Q?zMEUy11l7TXLlhAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4BD1583C05E9845A674CED21D760A85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5c1b60-8e82-42f0-50c7-08de5525da5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 17:36:59.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuCw13i7Ox8KSRkOFaPK2keMy97us2zwPRq34iTFrPS+Tpq/SFxgQiaz8VVeolag/QE6AAfRCourKm8LxndPl6eWBLmux5TPJJ/pOgDPjBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAxLTE2IGF0IDE3OjI4ICswMDAwLCBOaWtpdGEgS2FseWF6aW4gd3JvdGU6
DQo+ID4gDQo+ID4gSSBpbWFnaW5lIHRoaXMgZmVhdHVyZSBpcyByZWFsbHkgdGFyZ2V0ZWQgdG93
YXJkcyBtYWNoaW5lcyBydW5uaW5nDQo+ID4gYSBidW5jaCBvZiB1bnRydXN0ZWQgVk1zLCBzbyBj
bG91ZCBoeXBlcnZpc29ycyByZWFsbHkuIEluIHRoYXQgY2FzZQ0KPiA+IHRoZSBkaXJlY3QgbWFw
IHdpbGwgcHJvYmFibHkgYmUgY2FydmVkIHVwIHByZXR0eSBxdWljay4gRGlkIHlvdQ0KPiA+IGNv
bnNpZGVyIGp1c3QgYnJlYWtpbmcgdGhlIGZ1bGwgZGlyZWN0IG1hcCB0byA0ayBhdCB0aGUgc3Rh
cnQgd2hlbg0KPiA+IGl0J3MgaW4gdXNlPw0KPiANCj4gVGhhdCdzIGFuIGludGVyZXN0aW5nIHBv
aW50LCBJIGhhdmVuJ3QgdGhvdWdodCBhYm91dCBpdCBmcm9tIHRoaXMgDQo+IHBlcnNwZWN0aXZl
LsKgIFdlIHNob3VsZCBydW4gc29tZSB0ZXN0cyBpbnRlcm5hbGx5IHRvIHNlZSBpZiBpdCdkDQo+
IGhlbHAuICBUaGlzIHdpbGwgbGlrZWx5IGNoYW5nZSB3aXRoIHN1cHBvcnQgZm9yIGh1Z2UgcGFn
ZXMgY29taW5nIGluDQo+IHRob3VnaC4NCg0KVGhlIHRoaW5nIGlzLCB0aG9zZSBub19mbHVzaCgp
IGhlbHBlcnMgYWN0dWFsbHkgc3RpbGwgZmx1c2ggaWYgdGhleQ0KbmVlZCB0byBzcGxpdCBhIHBh
Z2UuIFBsdXMgaWYgdGhleSBuZWVkIHRvIGNsZWFyIG91dCBsYXp5IHZtYWxsb2MNCmFsaWFzZXMg
aXQgY291bGQgYmUgYW5vdGhlciBmbHVzaC4gVGhlcmUgYXJlIHByb2JhYmx5IGEgbG90IG9mDQpv
cHBvcnR1bml0aWVzIHRvIHJlZHVjZSBmbHVzaGluZyBldmVuIGJleW9uZCBwcmUtc3BsaXQuDQoN
Ckp1c3QgY3VyaW91cy4uLiBhcyBmYXIgYXMgcGVyZm9ybWFuY2UsIGhhdmUgeW91IHRlc3RlZCB0
aGlzIG9uIGEgYmlnDQptdWx0aS1zb2NrZXQgc3lzdGVtLCB3aGVyZSB0aGF0IGZsdXNoaW5nIHdp
bGwgaHVydCBtb3JlPyBJdCdzIHNvbWV0aGluZw0KdGhhdCBoYXMgYWx3YXlzIGJlZW4gYSBmZWFy
IGZvciB0aGVzZSBkaXJlY3RtYXAgdW5tYXBwaW5nIHNvbHV0aW9ucw0KDQo=

