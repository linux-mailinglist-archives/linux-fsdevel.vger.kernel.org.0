Return-Path: <linux-fsdevel+bounces-74165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB78D33429
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 741ED30B24EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF933A9CA;
	Fri, 16 Jan 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5KM+KJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53C2EDD78;
	Fri, 16 Jan 2026 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577766; cv=fail; b=rINCGJXio8qbcPmVhP3ePvpvJWj6gsv9bwrPhX4colWPboNBA+fqrtfu9wxGTx10MqgRbOOUAfMp2F6pBETBXTvcjFk5/UJrdZRzMcjVTQ3MVhpLSvW9P0P8rIbgVSeiHsy4HyjdEdSqKPgu4t2GP3F3P2T/TtHJ1y/jDEjaNEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577766; c=relaxed/simple;
	bh=ovfAfUrUK6wxQxTjmzK4lPHjdwEnSwf8Bp/DUbog1no=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=scOxMALMeK0i0rSYkVfyEPWoN3hNZce4SOiXfgEBnMR8tiSRkDgwi5VLo3jwCJODzc5FuMHLaFlf8NyBnoT7D1FCDhgTLrq4FgvtGErF6kPuqmNdhVnIzvbtdqbEU3qT7dxDml+0bsIa3QcCAGoh9BlBjvsfz7iU0xFFOieyz98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5KM+KJo; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768577766; x=1800113766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ovfAfUrUK6wxQxTjmzK4lPHjdwEnSwf8Bp/DUbog1no=;
  b=L5KM+KJo+Bn2u73I7hPOVUIt28MFps/eETRbujXVFKLP4ZNhcmcOS1vQ
   TCeN1T+4ABqhzmDsBUN5QR8rSxmTlFBowW6gvg8re/dwPDMVG8FvjRTHG
   Cje77yzohpsyzvf5BeA/l/VMDrqLz+3Gh55Egr4zAxxOytBrN1iG3/qJE
   D5AQEQb7Tc2yXwBSB0SM0sSJKLLvaaAHsCTPkVGKn7mM64lViHKGl2e5Y
   egMX2LBfgzKJyqHLbz5wRyH+Me8RiM/RZnckrjD/mtg3zRndn7HPXqSgP
   X9QD2zV4GGg52qVvgK1pxsbRysxu6QzgxNnqJ3KU9nvxGpeIgkMwFfGPA
   Q==;
X-CSE-ConnectionGUID: ENOik3wDSvWRHP5uXW0biA==
X-CSE-MsgGUID: R9B8caxvRcehJh4ykH5xYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="72480327"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="72480327"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:36:04 -0800
X-CSE-ConnectionGUID: 3uz0fKoiQX2EgCnn8NPR9g==
X-CSE-MsgGUID: deAGQ0D9QxChwln+stvBqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="205320838"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:36:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 07:36:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 07:36:02 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 07:36:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCmiBxstFtvn6AlbUo4dQ+WZlfneITub5t7Dx289NWR+D69X6/6YypFNGg4dAk0yumdYbNQdrMgcZg2Tu24dIVf2EKcgI0BuawufRWsjy7Xbk0xjq2Es267bnMSik2FuPBR6yedb46snxvw81pp91Zbll8jNKF6Q/ZBU3bZghVX6vIROUpcCI175ZlvwKMjyn8TdcHbR6fqFb6Vt9hsnpDPScv19nSbDVl4178dhx/bG0AWMRC8Js62lAJjK4Yl3wPm97+IR4EBgo1fEK+u0MAuaXa0L5d7OFEZWbEVi///C6YefBgKaCmra5NJsJ9mgsVRAHa72IF7XRR+f6z2UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovfAfUrUK6wxQxTjmzK4lPHjdwEnSwf8Bp/DUbog1no=;
 b=LGSiyvx8QTYYxsD2vzP6Qc0sq/ug9e3h0vn12Z8ZRovYJfj4IeTVdVoSJ0/kZg2RmMjA2yM0oBGaukSd7MRbajpM7mJrRfXqxV4+PErbXIV6lreGcPma37XiY/XkZpqdOFMl64hf74xbV7+4cY9g4nxKUwBECBmpdW3CQ6QBwGgWhisr9vu0uugfebVXV3FslMEHD12QZPk8QnLvs2UE/j/HfZ7f2tKdK5C6PoY7ERK6Pr7DrC7RUDsyW5v/RV3I//4ff3D4RMDXkKl7rokNp9ChUHODyQS+4ceGFg7W1mESnJEFS7TG0XxmhonEIW8h9DZOaQKswBzXsX/Bs6LBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH0PR11MB8141.namprd11.prod.outlook.com (2603:10b6:610:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 15:35:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 15:35:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kalyazin@amazon.com" <kalyazin@amazon.com>, "kalyazin@amazon.co.uk"
	<kalyazin@amazon.co.uk>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "kvmarm@lists.linux.dev"
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
	<ryan.roberts@arm.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"jmattson@google.com" <jmattson@google.com>, "luto@kernel.org"
	<luto@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hpa@zytor.com"
	<hpa@zytor.com>, "song@kernel.org" <song@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "peterz@infradead.org" <peterz@infradead.org>,
	"oupton@kernel.org" <oupton@kernel.org>, "lorenzo.stoakes@oracle.com"
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
Thread-Index: AQHchnGR8zlgd593vU675Y8ML/1Q0bVT2boAgAELpoCAAAmigA==
Date: Fri, 16 Jan 2026 15:35:58 +0000
Message-ID: <4781ba9c5d16394cdd785d008cf2a2d81c5cda35.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
	 <20260114134510.1835-8-kalyazin@amazon.com>
	 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
	 <208b151b-f458-4327-94bc-eb3f32d20a68@amazon.com>
In-Reply-To: <208b151b-f458-4327-94bc-eb3f32d20a68@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH0PR11MB8141:EE_
x-ms-office365-filtering-correlation-id: fb9665a0-973f-407e-fff7-08de5514f23d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZDErdTZNQjAwYllXUTRycGVUNG9SRndtbzNqS2phVlJZRW5MeWozaU5qS2RY?=
 =?utf-8?B?cjd5UTkyQWs5VDRkNmFtTU1zY0p2NHpjaU85dE9pZnhCMXpvRWZBaVArWTEw?=
 =?utf-8?B?Yk96My9IQzVETUZ0end2QVlrTHJ4bS9JenhJSUxzdDcwQWhVaDlvZGhsMGVK?=
 =?utf-8?B?SGlzQXliTjZBWTJ5TkR5cFptUWZKNkF3aEdpQml3L2pDSGZWZjAzQ1VSUS9O?=
 =?utf-8?B?Z0xJOUMybDJ1d1VqSWRLeEdqRmtOT0FVTEpoVXhPNWU3b0dOR1NGOHB3cGRB?=
 =?utf-8?B?WDlkUkVqTXJNTU1iSnZuZ1VyRXVxVTcyYitoaXl4WU1ydVZTb0U2cUsvTEQ0?=
 =?utf-8?B?WUpHaWVtNksyMUpMamtvWFltUGpjOEhkM0ZNdm93S2Qvb0xJdXB0VW10QTY1?=
 =?utf-8?B?TGRFbnJOOUM2SVpuUEY4Rmx5NUdFRUM2blJvSkZBcGVVVHk1L1RsSEhTOEtD?=
 =?utf-8?B?bDcySUIzdzNuMy80V1VJTTN3Q3lSWnUzMVd6dTk1dzg2eVNkS2l6N1VSSlk3?=
 =?utf-8?B?MkR1N0puVWZKakhtajZ5b1pQZDZ2UlNIcDMvU2pzSkVxYk5XQ2hBN0NDK1dK?=
 =?utf-8?B?U2NVMWpwRWNTM0M5a1ZoUGdvTklxK216bktGNmhUamRvZUNmdGxuNVovejZi?=
 =?utf-8?B?Q2dXRUE4MlNrMGJtcXpYZ3U0QWl0ZURkM1REMFkwdU53eVNNMXp1N1BDelZu?=
 =?utf-8?B?T0NsWjVpdmV0VGlvN0xnRUJzbzB1QW9RQzAzcVJOZmo2YkpDMWpxem9CbGIv?=
 =?utf-8?B?eEFUMzBpWHV5d0J6bHZPMGJjd3dJU0pOVFB2a2Z4STBHOS9OU2J6V1M5MWFq?=
 =?utf-8?B?bkFrd3ZocWF0NU9GbDF5UjlQb3RXQ0VTME9Zd05hR2t5U1p1WUhpVVY1UW5K?=
 =?utf-8?B?NFJKRzg2MHlMSzBDVHhwOU5FWkprUlN5MnJocmViL05ubnYrT0g3SU9reWlq?=
 =?utf-8?B?SkZuWU1qU05BU1lZRFVIMTFRTDc1T29TOFd4cEtyMHFib0pJSjlLdUx6bWY1?=
 =?utf-8?B?dG9WSFdWd0dNM2hMRlpNTkt1NDFiWUVSZXNnUmxYWGcwaCtNeG1FUC9kZFho?=
 =?utf-8?B?QWRLaFBPcjd0M1hHQnhWT3pha3NRaXNaaXdzS0diZFlKRFBCNnkzbnBINUlo?=
 =?utf-8?B?STNpcnNhVEgyMXNiT2JINGJDZmJ4V1FwR3h4dHVxekY3RWluM3Q3dHA5b3A4?=
 =?utf-8?B?TFlaYlhPMVJWVEJ4cHJJRlBtak4wZm1QU1dlUllvNURYRlE5bllEMHNadHYx?=
 =?utf-8?B?ZXpwemlYbHNxWkJ0c29jY1pnLzZ2ZTJqKzQzZlE1dWdQeTNKdlhuSityNGRz?=
 =?utf-8?B?VUtHOUduODR0WlNzQWU5NUxyaUpudlZzLzN2ZWNqYUJ3TzJreXJ4WWtVUFox?=
 =?utf-8?B?aENkQTRMNUtucGgxeENWVE5TbDlPTmp3TFlsbUlFRVI2c3RFeUVMaEowOW1w?=
 =?utf-8?B?bWs3c1h5VEJKMGJnMTlZZkFHYWtGYzd1bkNEaGo1dlA3dG5pZzBrd09yVUVz?=
 =?utf-8?B?RXljOHhXd21BS3RkazM3V01naE10VGRTZ01ING5MejlxVVB0V2JDQzVNR2Iv?=
 =?utf-8?B?S3JwaGloWnJVdmp4YlE1c0xGS0J1ckhjcVFDZW8veXptQTJuczYwa0NURlFU?=
 =?utf-8?B?RCtGSU1Kb0ZUbU9Md3k0MjhIQW5SRFVYcjFObzdCaUhYM2ZIK2R6T0EzUzMv?=
 =?utf-8?B?YjNFVzRVUlBNQk9UcmpKRERhbk1hK1lFd1VXZnc1aTk0bExqQ0IyeFU0WFZx?=
 =?utf-8?B?ZExMekFrQk5PSzdGcmx2TUo4SVlUV0xJK1k5a2ZaK3ZaZ3ZEMHpDNHJRRTlS?=
 =?utf-8?B?aEU3Zm9BUGU3aVh0RkVVdUNnYmtlWTRlaS91Vzdmc3FjU0RVdVRkL0RoNFBW?=
 =?utf-8?B?dTRGY3lEdXVzOWQ1RVFsVkYyb0tBam9JSjRSV1pEWG5KN1VTZkNLa1JlZ01n?=
 =?utf-8?B?V2EzUGVLTEV0TDJEQ2xKVWw3SVpjb1dNMmgyYmRHTmh3NlcyVE5IRDdJTnMx?=
 =?utf-8?B?a2JJcHF6TVEwMlMvSkhaVHladjJQMms5WEpvOFJmeU5BZkp0ck10Z01tcFBX?=
 =?utf-8?B?RE9zTmpzaDJtTGRIejM0WmpaaGROUUgrLzR1ajlCYnBsSDJFWXJXRzFxWnE5?=
 =?utf-8?B?NHJwOUtTNUFSNEhnTkVtb3N1Vk5ZcGVLdDEweEs1VU5IR3NCc1NocnZaTzgy?=
 =?utf-8?Q?iII1PFSx0Iw+ODd6QEf8IjBWhjafi/0iCeuKJi83NpLd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a015Q1RQWGQ2bEtyQzdHTmFwTDh0TmtqSjcrdkVlc0o3NGNwcFUzQ2p2U05n?=
 =?utf-8?B?YTN1Sk1nWDZrbnR2ZmJ3S29ZS2RpK0xpcEEvU2dUbnhnUGFrMThkcWk2Q3Va?=
 =?utf-8?B?dWMwamhXbS9GTkMyR0NNZm5CMXFCdEEzTDNSSG9Eck96K1dhMjBhaXg1bzlq?=
 =?utf-8?B?REUzSXM4UERNQVNCSzVidWxqTDhVOWFETUo5cHZ0d2JCMTF3bTZNUnZvUGlh?=
 =?utf-8?B?WnphR2EyT1UyNmsySGI2eFJxS0hTRVM5Y3VyRkZ6eGZNTGpMMk9KcHFNeFJN?=
 =?utf-8?B?emVWNHlKN3dYSVZjazYvY3gvWkNWMnUrOGs0aVJ4Q25CSmlCRldZWGpxVkU1?=
 =?utf-8?B?bHJ4Tk1tdnpLZFR2dHJMUWN6T1MzV0tLKytEd2NHVHpoaWIvNk1OV0gxODJh?=
 =?utf-8?B?UW5NeWhyTkdPZmhseE9WLzNSeXlXS0JqWUpHSXIwb0ZXWis4TlpQYWs1QU1y?=
 =?utf-8?B?MkFtajlhT3JQVDJiRDE5dmZVcUZqQ1hxRFl1V25WVGp6d2Q0b2JYVmRDOUc0?=
 =?utf-8?B?UHR6bFFwRnNwVFBZVjNpYi9WVUpDdTA3YWdHVS9IcGRTeFVFWTRqYWl3VlJH?=
 =?utf-8?B?WlcrVkp6Q0Q3WW54TEhPUGlvakRnUUxwWm1GaVc4R25wUncxRXl4eXlJOHRw?=
 =?utf-8?B?ekFQY0pQcC9RQ1ZlblBndGx0ajNXSTNScDlYWkZyeTB6b21xcit1a2tYOVV3?=
 =?utf-8?B?elRCTysrZ0k2NXpqRUlxQlduUzhSVFhteDhxVm5GUFMzNEFUZnk3ZlVKTE91?=
 =?utf-8?B?SUYxZisxNjdCRnBTL2Vab3pQSXl0Rk1lajhmVHJnU2VKRUh6WjkwbmlJcStl?=
 =?utf-8?B?bFNoV3Q5MCtOZGZkUlRyQ2VldWNHc2lIL09YeVF0YTVSd3N2WlhWZGx6R2p1?=
 =?utf-8?B?WjV5Zis4Mk9tcjNBUDB1VklaaXhkdnNNeUJBRk94T1dQRkdMYUxPWEZmbjh4?=
 =?utf-8?B?TW5sbjFQUmtpWjVmdVFZa2tpOGl5VzlWeFJNcG9pem9yekVnNFNISWZOMGxw?=
 =?utf-8?B?UW51RWlqSUpPZXhqM214K2MxUUdSVklGMGtlWmlVQ1NtUncyY1VuY2NwQWMr?=
 =?utf-8?B?L0VhdktoQTFMR09UMVJFdW9KckxXMVhKSWxyL0dwSjAyZklKSVVvOVc1cEp6?=
 =?utf-8?B?QUhWYWdNS3VLOWNmQlVKZlQ3Nk5tQ1BiVlIxZUVuMHRWOGNUNUlwTEMxT1Zp?=
 =?utf-8?B?L1lWc2twbHIwcHJ6a1hBL2FKNi9DV1orTnVmTHNaU3B6ZkZiSUJMT1JSOVVQ?=
 =?utf-8?B?VFg0bnVick1rR2MvR1AyZnZlZm5PWEpEQ0ZPUEJzcHpxdUpYQ0g4bmNnekdy?=
 =?utf-8?B?SzZuWktkVUZmVlIvdWlLbzc4RURMbFdYSDZBZnV1eThuUHlrYkNIbGcwbUlF?=
 =?utf-8?B?K2FaaWxiVTZ2ZHd4clp4R3p6aGJtK21pOW1UdHFsMEdQcHorUmpDTWx1cW4w?=
 =?utf-8?B?RGgrRmFQY01adjR0cGVuTXhNTDlXWW4rUEVlYmdBZnlPZ1FpWDRDeFhTakF3?=
 =?utf-8?B?SFpnSDljZU8xcUIybjdrV2QvdDZTVS95Y2dKeFlzbVNhZWllcTJZT0szZk1I?=
 =?utf-8?B?dTI1NHo2b0I4S3YwM0gvbldyV0xqRnRycW5vbEgzNFBpYVhXWkd2RkZ3TkIy?=
 =?utf-8?B?VlVyTlBrRHVVNUNnYkNKbzYybEVJcTNHVEdvSXVWaFR6dmhOaTBUd0d5bHpV?=
 =?utf-8?B?cGxoTE0zNXZwcXNMa2wrOHJBb21zOFpIODJ3aDgvQjlpeVZwLzFzYy9nYzVz?=
 =?utf-8?B?ZVF6ZmkwbHhKSEtjQjgvUXRyUDhFMEV2Y3FxT1poTFR3L0lwK0g3d3RibnhY?=
 =?utf-8?B?dXJGQ2ZacVU4S3ozVTNRTU43b0w0NDRzQnJTUnlhbk1zaGc0TEszcy8ybUph?=
 =?utf-8?B?UXVSdmx0UGE1aEhyTGJ1UU5vS0NpaEkyQVhCekVBclUwVFJPb3k0VjlqN2FT?=
 =?utf-8?B?RWlYTERUb1hLZytPUTczZlpNUHdhQXlHWGNDKzNCV08xam04czZQZm10Qnlu?=
 =?utf-8?B?WVpPTllyeFNrclp3V3JLTTErUGhGTzZOaUp5Rkw5UlBaajl3Y25jaDFPcmt5?=
 =?utf-8?B?ZnZFRk1WbkhQcWdzaVhLVEV1Z1c3ODJYYkFjcXFzSWVNZ3RFQWZrcXZMdmVm?=
 =?utf-8?B?WTNaMk1MdXdlb0pSZkdpY2tjdzJ5UXBKSVNlVkhBN24yZThPeUpwT2xWWXlM?=
 =?utf-8?B?RkVFalRkKyt4VlVVclJOSkJRNThMMU1QcGNNY0syeVpTY3ZjSG5LcHQ5Z25P?=
 =?utf-8?B?aEtmZHVtdE9PK1ZpNlJ6Umx1UlFaM0VvVnFQZXhmVUZ3bGdYS0U0ZEMvcjd2?=
 =?utf-8?B?Wk1ndFdEQzkzVndUaDZ6VDYzdjJOYmVJMHFuYzlNSEYzSFowOVZ0ckJqN1BL?=
 =?utf-8?Q?3JTGuyNY/a54eImg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EE882646ABC8B4AB864A8043C4CB0CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9665a0-973f-407e-fff7-08de5514f23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 15:35:58.4840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bqZTi3Mjf0qYmQAHVBS9MrB0Q3adJJxCr+j5nAsnR80p2AjwMi/Dvvno0vOBk8KZl1+5D8/ZNBhebtieYOSocvm2zpFHD4wJO5P4MxH6As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8141
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAxLTE2IGF0IDE1OjAyICswMDAwLCBOaWtpdGEgS2FseWF6aW4gd3JvdGU6
DQo+ID4gVERYIGRvZXMgc29tZSBjbGVhcmluZyBhdCB0aGUgZGlyZWN0IG1hcCBtYXBwaW5nIGZv
ciBwYWdlcyB0aGF0DQo+ID4gY29tZXMgZnJvbSBnbWVtLCB1c2luZyBhIHNwZWNpYWwgaW5zdHJ1
Y3Rpb24uIEl0IGFsc28gZG9lcyBzb21lDQo+ID4gY2xmbHVzaGluZyBhdCB0aGUgZGlyZWN0IG1h
cCBhZGRyZXNzIGZvciB0aGVzZSBwYWdlcy4gU28gSSB0aGluayB3ZQ0KPiA+IG5lZWQgdG8gbWFr
ZSBzdXJlIFREcyBkb24ndCBwdWxsIGZyb20gZ21lbSBmZHMgd2l0aCB0aGlzIGZsYWcuDQo+IA0K
PiBXb3VsZCB5b3UgYmUgYWJsZSB0byBnaXZlIGEgcG9pbnRlciBvbiBob3cgd2UgY2FuIGRvIHRo
YXQ/wqAgSSdtIG5vdA0KPiB2ZXJ5IGZhbWlsaWFyIHdpdGggdGhlIFREWCBjb2RlLg0KDQpVaGgs
IHRoYXQgaXMgYSBnb29kIHF1ZXN0aW9uLiBMZXQgbWUgdGhpbmsuDQo=

