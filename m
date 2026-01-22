Return-Path: <linux-fsdevel+bounces-75132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wANINdRqcmnckQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:22:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E746C4D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E82E13097A2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A529BDA5;
	Thu, 22 Jan 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRRRzKvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A53254A3;
	Thu, 22 Jan 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103398; cv=fail; b=M9IpEy2pX75CpyIeK+AZpACoyXw5S/xnynY4p+4ssiJXVLcjMNXlUAzYoNQb0TL9+sx8c3n6mSdI+z56JZ3VR3amv0XMyfrz987cKSUEDUoCTnEKNT9OqXBUdJaE9bDED/SqgwVfe0bBrGSbw57cB14rByxaFLSdmRuEuI4ulSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103398; c=relaxed/simple;
	bh=8cMCTbmTLrFgnOAVXWWJjSYicBvG4bUePq6gsqZcHXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lVnq/1PbwEMN0UpetFQysKIC1AhxX0lDbeCjlNc0nyew3EKTDHwwsAQxGNW0J18IUPniBZvSSDvkK80OEed3/U1TMY68GuydwQIvUOOKWwjO42BH+XSUgH2D7dZQM9lsy8alp3Li5MOI2Ux8yGzYM0T1NEDP0qG2HzzLDEe2b3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRRRzKvr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769103377; x=1800639377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8cMCTbmTLrFgnOAVXWWJjSYicBvG4bUePq6gsqZcHXQ=;
  b=jRRRzKvrhZMA1B87dS/tc4GcBKxrACAmICNl8q6Mhx1UI1FNWFfSaWn8
   aNBvrRSZSpUFa6PWz8TVELG5eOblmj5OB6+R6nERz9FMM9st8EsSI1z10
   YpEALA/DX7Re/6DWwM1Yj6IxMq6mMISmXX8Xnjs84TfsDeVheBebypkgv
   bByxFMyPZ95iweew6WiWVlfBfJehoO9gCBOfHtsNaL7llwG08Pqlfp3FY
   rAEZTv849HuANMVCo7z3dVSX/MclM3rNReg/EIRCsIsk1wxSFhNC/fm/u
   WNpdvxvygNDp7FR2HbyFxNel/BlxqB7pW5CxVaGfurQNBYl3bbURNoZql
   w==;
X-CSE-ConnectionGUID: 2HjA5mKkRuKom8+CoFaWPw==
X-CSE-MsgGUID: HU6txiYNSH6t8iEkpGHg8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81072053"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81072053"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 09:36:08 -0800
X-CSE-ConnectionGUID: ft2IIORnRQO2c0XFZCbm3A==
X-CSE-MsgGUID: 4qptPPTFSbi5q5dMwlm0eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="238054007"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 09:36:04 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 09:36:03 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 09:36:03 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 09:36:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmoJnJvYJHYet8bQaQwDPNm2IKvwJ5u8EPVsU6246lA3lQ6x1JJpVZwLEtBglILggYrZ9ySTPnOsjAhdTUIQs7VPe93EU2KBmkv9ap18biCI+iLumQEXOcodnpwRU9FqmzPB+3gHeBRGC67tu+NQOOjc15tN6v47Ln4l6+8Aa4+aMmy5HLklYEGkDqcDJZ+rs79aHfc01SRN2aaBWUR3he6iEayd3f1UqH0lcVEkuwKEEXqenRUMPqJpghIacb4z3ioPflH3ruA9yCRwcNHk//1YPHui58JiDcHDHLBh8T4pq9kwatKDyu15lLvYxMW8DAp9Dr+WRnDPHlO6phTYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cMCTbmTLrFgnOAVXWWJjSYicBvG4bUePq6gsqZcHXQ=;
 b=v8ZjGSvbIE9KVqYn6Mo4in5vehg4niBT1HLGoRkDd8NBWXVXKJSpSol1LW/SdaAcbJHnzEL577v1zsDGYChzdv6T6h4mT0fTL++e6xze/csHoNcojO6z4HSVjx4UrkfuxrPwPPGLEJ3lMy3Pvytq1tyD3daiaHLrdkLHdy9lQvxYraSHgGS/FbGVAiOtIqsKYdLofAsJdVgEuUK0rcK0h/fw4aMcVpPhQNVFeA71ACWVakNP9f/uX/+9oRtoFcfQ3PIhb2v9WIbtl9SeahcfoW23+No6aeCPGSQXTxGs7xJ9hvTCP/cBq6knMjH4Z+YnNbWLZs0/xUZnuRC3Wm4pAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6321.namprd11.prod.outlook.com (2603:10b6:208:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 17:35:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 17:35:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "ackerleytng@google.com" <ackerleytng@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>
CC: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "jgross@suse.com"
	<jgross@suse.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"surenb@google.com" <surenb@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"x86@kernel.org" <x86@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"thuth@redhat.com" <thuth@redhat.com>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "maz@kernel.org" <maz@kernel.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "ast@kernel.org" <ast@kernel.org>,
	"pjw@kernel.org" <pjw@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>,
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"jmattson@google.com" <jmattson@google.com>, "luto@kernel.org"
	<luto@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "peterx@redhat.com" <peterx@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com"
	<coxu@redhat.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "song@kernel.org"
	<song@kernel.org>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"oupton@kernel.org" <oupton@kernel.org>, "kernel@xen0n.name"
	<kernel@xen0n.name>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jthoughton@google.com"
	<jthoughton@google.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Yu,
 Yu-cheng" <yu-cheng.yu@intel.com>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "prsampat@amd.com"
	<prsampat@amd.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "shijie@os.amperecomputing.com"
	<shijie@os.amperecomputing.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "jackabt@amazon.co.uk" <jackabt@amazon.co.uk>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "andrii@kernel.org"
	<andrii@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "joey.gouly@arm.com"
	<joey.gouly@arm.com>, "derekmn@amazon.com" <derekmn@amazon.com>,
	"xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jannh@google.com" <jannh@google.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kas@kernel.org"
	<kas@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHchnGR8zlgd593vU675Y8ML/1Q0bVT2boAgAE04ACAAAZHAIAJWwcAgAAOpYA=
Date: Thu, 22 Jan 2026 17:35:58 +0000
Message-ID: <ee9c649eed3893d852c3d20fb96bdc4904b7c295.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
	 <20260114134510.1835-8-kalyazin@amazon.com>
	 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
	 <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com>
	 <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
	 <CAEvNRgEbG-RhCTsX1D8a3MgEKN2dfMuKj0tY0MZZioEzjw=4Xw@mail.gmail.com>
In-Reply-To: <CAEvNRgEbG-RhCTsX1D8a3MgEKN2dfMuKj0tY0MZZioEzjw=4Xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6321:EE_
x-ms-office365-filtering-correlation-id: d4da2268-3ee9-4c00-6122-08de59dcb463
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YnNUM1E5TXpZSVh2Y09nOWJUQnE0dWhmUFpXckdCdDhDVGZyRkE4UFdtQU8x?=
 =?utf-8?B?b1hVc1hOK1NNSFBuTGhSbVo5UE8vMENvaEhkZkE0SWgzQmdTVDJOSnhOY1hI?=
 =?utf-8?B?QlI2WEx1cDdYYnNJZ2NSL0xBSitrczYzMm9nelZrWk5UTXdZVEJNdjMxbC9V?=
 =?utf-8?B?RTZoQ1VVTnVIUXc1V0NuS0xYMTdNYUprM1FRaUtRalpzam5jNnlEcW93NjFI?=
 =?utf-8?B?MFBlRWxBQzlIaVdDajlmam9qRXd5aWowNzJrN0J0WVFaOGkwVDdjMGNwdVlE?=
 =?utf-8?B?eHlSWnNnbDM3MG1sbmRhOHZGQ2cxMjgvUTFrNVczSnczOGliQlFyRUxDTmNq?=
 =?utf-8?B?TDlnK0Y2UDRZQS9CUGtvamEvRVltdU1keHBtZm45a1BiUFVrdWZzc1B4VE9U?=
 =?utf-8?B?NHJPVDhhY2UwU1BxWS9rSlRtNmg3cHdZN3dUaWZqR251MDk2ZUQ3NFYrSHkr?=
 =?utf-8?B?UnhsSzYvRFBBOUlUWWZISjk4Rk9YQUNYZzNucjFZQ0hoOTNhenVMS2pKb1Bs?=
 =?utf-8?B?OGJwRVlZYmJVTWM3Q2tYWXJCV2RuRlFETG1FTEgxd0dIRk0xMHg3b1hXTVNB?=
 =?utf-8?B?N2tnWTNuZHlWNzU4eEpTRVd4QkZnZ1l3eWRoa2lTUUJvZm1EYVp5WTZvcUlU?=
 =?utf-8?B?ZjQyclBNaEpuT3pua0xKTUY2czUwOWxMMnFJWHRaTXNSRnlUK0Rza1dJREVU?=
 =?utf-8?B?M2NISzFUbVA1c3RRM1lZL1ExUXBjUDNRN1A5dDIxMW44NXE3cWRDell1Mml1?=
 =?utf-8?B?d1Jyd1hFVzdqcVI3NFB2c2tGSWd2WjVlYkI2OGdJSXRSSWNIRnFPN0FEUDRh?=
 =?utf-8?B?VHJCYTRWSGZMMWhDSUg5SjU5Z2ovdm5iTnc5eHpzN3gvcitJTzN2ZmNhQ3Q4?=
 =?utf-8?B?bHBZbFpjN2p0dEdMWmZlUUJoZXk1REpydDh2dlMxaXRwMzBvTTdJR25yNVVD?=
 =?utf-8?B?YjR1T242ekYzeVdtL0ViQXFLNFdMUVhybGZpWHZSMG9Hbk5ZamFRY2xhUVdQ?=
 =?utf-8?B?bkdNMEo3OHo1Szd5WmNZZWIwc0Jjbi9GQXVxV1kwWklKRFBrdk16MTRRU3oz?=
 =?utf-8?B?UklLRzk2SE5IVmJMVmRLazM3c2dkZ09qaEhJODNOU0gxQVQvcFJrQTVpeXI3?=
 =?utf-8?B?NHIyMTNudUNKbUxRd0krQ2psNEpDdnBtaTJ1M2hDMER5RE5xRUloQ2V3d1Fm?=
 =?utf-8?B?ZWwzZ3pTSDYzZHBMdVNsQXBKTFRoQ2YzUmFCdDd1aCtaY0dWWmtld1ZLQ0dj?=
 =?utf-8?B?Wm9RMnN2SlVJajdhdjFZN1ZRUU1wVUR0ckFtM2ZISGpsSklTUU8wWGVlMkFE?=
 =?utf-8?B?UjVJejZ2UUF3bWhKTnBtQ3gxUExDVXQwN0NxSFAvcFFZTEhkc2x0OUVOcjFp?=
 =?utf-8?B?NStacEttU3ZCVTd1OGNKZHFLS2VaM0dUUG9nRFltK1psbEg4QUE0MTJYaVli?=
 =?utf-8?B?cEV2U2pYZmhyMjlMMWdsck8zYk5zYjVPbzQxdlA5ZzJjN2JXY1g1N0pLWk9U?=
 =?utf-8?B?YnhvaXc5MDZOc0wwWjMyMWJiMUdhNEsySVRGZ2liaDAxb1hvZCtMWHNqWnRR?=
 =?utf-8?B?dGo3bjdQL3E1d2FzZzM3Q2N1Vk5IMWd0dlBVdHRJU1JkbHNTS3MwaVY0emFJ?=
 =?utf-8?B?OGVMdEtYdGdJc1ZDaVFQQ1Q0MUdnYWc4MGZDUWtVd2k2ejFpMkZZTmlHTDUx?=
 =?utf-8?B?VjZhVE1jeTdZb0tINDN4dGlzRklmNDhUQ0t2eDJ3Ky9zSm9IcVIzei9ITDR0?=
 =?utf-8?B?OGJEK1ZmRVozaGpjdC9scENFajBRL1JyNW9kZVo3dGlFMTAzK3FISENQMzF2?=
 =?utf-8?B?ZjlybUhUUGZ4SmhlRVB6MzVMQmIwR1JTS0I1eHRkNGZqU0Nnb2NhcnVERFp5?=
 =?utf-8?B?Z3F5UERJVHFoWkZkbDlTV2JNeEppL09aNVdlMGFNdVNoaXB0L2dvcmtrSS9q?=
 =?utf-8?B?Q1ZvWFlsd0pxdUVFSExleTVobzV3RHhOYllzRVJ4VkQxZnNuVHlEa216QnBV?=
 =?utf-8?B?ekhDWHpjOFpIYnVid0FyLzJoN3hMS2lpV0lTQnhUeEk3ZUN5ZDMwakFDM1JJ?=
 =?utf-8?B?VGtrZlhlTjBLUU5rMVh3aGo0aE96QitrMmY5dU1kNGtUWmFGdVhPSFdFRU9T?=
 =?utf-8?B?Zk9qL2pYZ0pLZkVaNlc4R2wyVzk4azMxZkxEWnpZek1EQmVJUHZ5TlJzOGhI?=
 =?utf-8?Q?ywX3urLMK+u7dBSYmu8MgCI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFk0RGdPOEZGbU91anFHWVF5YTVBc3c0SDhKekF0amZkTWNkRUEvSXhLV28y?=
 =?utf-8?B?dTFlcnIwUjhSTXRteUJwaEN3cEplSE9qUzJ3eHdrYnliMmNFT3h5MnlRa2xU?=
 =?utf-8?B?bHd3azdzRHU1cXFNL090VHZ6eXNGc3BicDgvU0l1WHhKUG94QUhlZE1oMnpR?=
 =?utf-8?B?QzJmU0xlOCtJNkhnUHVpNW4xTWZsaDZPcU9pOU40N2w2T3NpQlFYOHBNdVNi?=
 =?utf-8?B?Z210WDdEU2Z5aWpCZmlIaXRTM1c3ZXRqZnJXV0lZb1RpVGlkYXNxcXgzV0xW?=
 =?utf-8?B?K0lLemtlUExPRnRIcjB6ajg4M1BTakh5ZzkwN0h3aGNnUFlSTU5ZY0ZxcGN1?=
 =?utf-8?B?K2tMamRNN1liTFFJWEpacy9kRGxHSkJRdXc5cjJBYXVMMHoxM0RpdXhoRmFZ?=
 =?utf-8?B?VUllamErNURBRU9wS2VtT2lPRGdVOGtDQnNPYXl0eEdUcHM5dFFDMm1PL09u?=
 =?utf-8?B?WXpBNGVyY3luMkNBdE54YzU3WHRud0RkVVhrZGtGM0l5MGRQSGdvN0lSSjVX?=
 =?utf-8?B?azlpSjFadENtNjltYmxGVSt2cFVDUC9NVlVRS3k5MXY0Vy9oTzh3QVkrOHFK?=
 =?utf-8?B?YkhoWUwwblFYNi9PM1pxVlI2RzllRzhIR1JqYjg3S05BT0pQRWlFSy9veWpC?=
 =?utf-8?B?eDBUU0FNS00xUy9JbFo3OUJZQXFLZTB1cWhvd0dPcExTR1IyQUpiOGdCRnRN?=
 =?utf-8?B?dHdaTDI0NS93QjhkYUZDOVVQTnhzeklhZlFQWC9NSWw1YytMRDRMMjRnUFhZ?=
 =?utf-8?B?anE0RkZoZU4xRG1La2JBYW5Kdm5Pb2E2a0FyMFpIU1M1MEtpUzRoS0dvcWxB?=
 =?utf-8?B?WG45UEJIUTJCMGZpNzlrM2Z6NjRaNWhpWTE2Y0pTcUZDZFFHU0EwOG9nb2Nh?=
 =?utf-8?B?ZEl3eEdtUDdqRjVKeUYxVGwyYW5TWHV0Z1JwK1hQN05OSzBENkFMa2dRYmhn?=
 =?utf-8?B?OWJwdWk5dmRDS1IwWW0rckJKSUlIR0Qzb1p3akhvWFovNTlTazh2WlpIWWxQ?=
 =?utf-8?B?MDRqS0xtUHIwSkRncDBsTlR1R0xIb3JUQzkxTWxvZ21xcXRvWjkzTnZyUXJP?=
 =?utf-8?B?WXJYV2xYRUZ6Z25aTkg4bXlyMlJ4YVU0bXFxYXpPZ3RzYXhFR1ZVVGMxYWxB?=
 =?utf-8?B?SlRGZHJBdEJmR1E2QnRZZjRUUFNuMVM4NVpiSlBBM1FmY043VlB3bjVYWWt0?=
 =?utf-8?B?eEpRVXZHYTc0blJrbU5KclZFVFk1b0JXaDY3OGdRZVBRMEpndGVKMVFxVTVm?=
 =?utf-8?B?U3ovSGMzSmUxMzNwV0MxNk5TWTBFVDRqUFVDWTRQajdOakphTytqYklicW5z?=
 =?utf-8?B?WXJ4dWRzelZPM20vbzNlVHhKbXZZZ1hScGFJR0VkNFlZeHNsK3lSaGNHTUpH?=
 =?utf-8?B?b2VNMHhlMk54clIzZDRTRHlINDNta3NzaXJtQTRyVE9JMFZqbEJwTHN3NE9r?=
 =?utf-8?B?czY1K0pISXlwdXNka05KT1hBcDYyYkpzVE80bzVnQ0g0c0dXaUxLVjhEZElO?=
 =?utf-8?B?OHNZbzZsQlR6Uk5GV1dSQWErNnk5NU41UnpjVGlHMDd4YnR0S0x5MjhiY210?=
 =?utf-8?B?TnBVakVwNlhielhRTFRlQzB3cis5MUZwVkg2ZjF5UGRwZFNuSGRwV05mMGlG?=
 =?utf-8?B?WDlIMks3QW5XdlArbHc5azQ3Y0h3SzYzU2ptM1l4dnZxZUJxZUcxbmRUbGVt?=
 =?utf-8?B?dnRLc0MzRkdXakJ6ZTNETmlQME1qYmxzZmdzMXZCWlVZMzl3c1dLbCtWR29N?=
 =?utf-8?B?Y0N5eU52QTVidWd4cU5UOGxVeFIxRENic29BQUhMNWd6b1UvdlhzNkxmMVRq?=
 =?utf-8?B?MmxaL2lqbmlBTDBZcjNmbUpjMXg2ZVVqQjFNckNKaUNSOXFBZDhqUmV4cTlF?=
 =?utf-8?B?dFBoY090Vk52dTRtamdQbnVKWFhuR1dlRTlkSUtKZjJ0eHFxRENPZHF3alBt?=
 =?utf-8?B?TTJoTGlEbU9CcWhIZmpPa1FVVER6bHpPczVsb2dTVEZnSjNrMkQvN1dxVWZ1?=
 =?utf-8?B?MzJiZVZ5ZG1JUlIrc1dwalh5ekw4R2doNnB6QlpYWFI0RTlPVDZOa2JJZEk5?=
 =?utf-8?B?blozTUxWUXUxVWZjbnd0aDUzWUR6ZzV4bEEyWGEyVnh0WHVTMmxmVzUxK3Zw?=
 =?utf-8?B?bnlESHUvazNlbUphaE56bDRQd21hWFoxV0QraURlYVlVVTdHR1cyeG5ReHI5?=
 =?utf-8?B?QXd1a3RWTXBvSUdwNFVWYjdzVG9CNFd5aVQ4Q3Q0dnMwR0lNa1Q0VWNkZXVz?=
 =?utf-8?B?OEM4TzlqNzRwLzMxT2RGbDJwSVQ1M0VxWHlXZUZRWlpTL2V2eTJyVXByT2d2?=
 =?utf-8?B?Q1RQSE1VV1d4N2ZmdHBmNC9RMmZNSFNyczU0UUJSMzUyV1VJOXRKRmM0Ly8x?=
 =?utf-8?Q?XNwtCUIGbWdztvvc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20EA4C40EE3F6344AD3A613DDCF3F53E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4da2268-3ee9-4c00-6122-08de59dcb463
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 17:35:58.7028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnVxWqHCDfVhOenj/GAEACYLuEH1aEq+XC1tcC25nS/Ia2dU9KzUz4VOzZNTdSMJffhp0WIb8HNuN+wyiPlrueuOWRSyOznfdNJJbXBBDLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6321
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75132-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,linux.ibm.com,suse.com,google.com,suse.cz,surriel.com,suse.de,redhat.com,dabbelt.com,ghiti.fr,linux.intel.com,linutronix.de,infradead.org,os.amperecomputing.com,linux.dev,linux-foundation.org,ziepe.ca,lists.linux.dev,oracle.com,xen0n.name,huawei.com,nvidia.com,intel.com,gmail.com,zytor.com,amd.com,loongson.cn,amazon.co.uk,iogearbox.net,lists.infradead.org,eecs.berkeley.edu,amazon.com,fomichev.me,alien8.de,lwn.net,kvack.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 81E746C4D0
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAxLTIyIGF0IDA4OjQ0IC0wODAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
IA0KPiBDYW4gd2UgZGlzYWJsZSBkaXJlY3QgbWFwIHJlbW92YWwgZm9yIGVycmF0YSBzeXN0ZW1z
IHVzaW5nIFREWCBvbmx5LA0KPiBpbnN0ZWFkIG9mIGFsbCBURFg/DQo+IA0KPiBJZiBpdCdzIGNv
bXBsaWNhdGVkIHRvIGZpZ3VyZSB0aGF0IG91dCwgd2UgY2FuIGRpc2FibGUgZGlyZWN0IG1hcA0K
PiByZW1vdmFsIGZvciBURFggZm9yIG5vdyBhbmQgZmlndXJlIHRoYXQgb3V0IGxhdGVyLg0KDQpJ
biB0aGVvcnksIGJ1dCBpdCBzdGlsbCB3b3VsZCByZXF1aXJlIGNoYW5nZXMgdG8gVERYIGNvZGUg
c2luY2UgaXQgZG9lcw0KdGhlIGNsZmx1c2ggdW5jb25kaXRpb25hbGx5IHRvZGF5LiBUbyBrbm93
IHdoZXRoZXIgY2xmbHVzaCBpcyBuZWVkZWQNCihpdCdzIGEgZGlmZmVyZW50IHRoaW5nIHRvIHRo
ZSBlcnJhdGEpLCB5b3UgbmVlZCB0byBjaGVjayBhIFREWCBtb2R1bGUNCmZsYWcuIChDTEZMVVNI
X0JFRk9SRV9BTExPQykNCg0KR29zaCwgeW91IGtub3cgd2hhdCwgSSBzaG91bGQgZG91YmxlIGNo
ZWNrIHRoYXQgd2UgZG9uJ3QgbmVlZCB0aGUNCmNsZmx1c2ggZnJvbSB0aGUgdm0gc2h1dGRvd24g
b3B0aW1pemF0aW9uLiBJdCBzaG91bGQgYmUgYSBkaWZmZXJlbnQNCnRoaW5nLCBidXQgZm9yIHdl
IGdhdmUgc2NydXRpbnkgdG8gdGhlIHdob2xlIExpbnV4IGZsb3cgd2hlbiB3ZSBkaWQNCnRoYXQu
IFNvIEknZCBoYXZlIHRvIGRvdWJsZSBjaGVjayBub3RoaW5nIHJlbGllZCBvbiBpdC4gV2UgY2Fu
IGZvbGxvdw0KdXAgaGVyZS4NCg0KPiANCj4gPiBUaGVuIHRoZXJlIGlzIHRoZSBjbGZ1c2guIEl0
IGlzIG5vdCBhY3R1YWxseSByZXF1aXJlZCBmb3IgdGhlIG1vc3QNCj4gPiBwYXJ0LiBUaGVyZSBp
cyBhIFREWCBmbGFnIHRvIGNoZWNrIHRvIHNlZSBpZiB5b3UgbmVlZCB0byBkbyBpdCwgc28NCj4g
PiB3ZSBjb3VsZCBwcm9iYWJseSByZW1vdmUgdGhlIGRpcmVjdCBtYXAgYWNjZXNzZXMgZm9yIHNv
bWUgc3lzdGVtcw0KPiA+IGFuZCBhdm9pZCB0ZW1wb3JhcnkgbWFwcGluZ3MuDQo+ID4gDQo+ID4g
U28gbG9uZyB0ZXJtLCBJIGRvbid0IHNlZSBhIHByb2JsZW0uIEZvciB0aGUgb2xkIHN5c3RlbXMg
aXQgd291bGQNCj4gPiBoYXZlIGV4dHJhIGNvc3Qgb2YgdGVtcG9yYXJ5IG1hcHBpbmdzIGF0IHNo
dXRkb3duLCBidXQgSSB3b3VsZCBoYXZlDQo+ID4gaW1hZ2luZWQgZGlyZWN0IG1hcCByZW1vdmFs
IHdvdWxkIGhhdmUgYmVlbiBjb3N0bHkgdG9vLg0KPiANCj4gSXMgdGhlcmUgYSB3YXkgdG8gY2hl
Y2sgaWYgdGhlIGNvZGUgaXMgcnVubmluZyBvbiB0aGUgZXJyYXRhIHN5c3RlbQ0KPiBhbmQgc2V0
IHVwIHRoZSB0ZW1wb3JhcnkgbWFwcGluZ3Mgb25seSBmb3IgdGhvc2U/DQoNClRoZSBURFggY29k
ZSB0b2RheSBkb2Vzbid0IGRvIGFueSByZW1hcHBpbmcgYmVjYXVzZSB0aGUgZGlyZWN0IG1hcCBp
cw0KcmVsaWFibHkgcHJlc2VudC4gVGhlcmUgaXNuJ3QgYSBmbGFnIG9yIGFueXRoaW5nIHRvIGp1
c3QgZG8gdGhlDQpyZW1hcHBpbmcgYXV0b21hdGljYWxseS4gV2Ugd291bGQgaGF2ZSB0byBkbyBz
b21lIHZtYWxsb2MgbWFwcGluZyBvcg0KdGVtcG9yYXJ5X21tIG9yIHNvbWV0aGluZy4NCg0KQ2Fu
IHlvdSBleHBsYWluIHdoYXQgdGhlIHVzZSBjYXNlIGlzIGZvciB1bm1hcHBpbmcgZW5jcnlwdGVk
IFREWA0KcHJpdmF0ZSBtZW1vcnkgZnJvbSB0aGUgaG9zdCBkaXJlY3QgbWFwPw0K

