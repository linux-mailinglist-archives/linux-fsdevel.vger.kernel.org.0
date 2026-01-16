Return-Path: <linux-fsdevel+bounces-74194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD2D37B0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C71A3159EC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435739C623;
	Fri, 16 Jan 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/H7Q9Mp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CECE283FDC;
	Fri, 16 Jan 2026 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585909; cv=fail; b=OsymjCZnKo/vDWieEKrqNoM5OMf7TRbqOsxW+AWIqAbRBcppy63BvbSSgsre5kcojZT//GlFUXj24d39NpTGIV71SpRkx/zgFNKewSsLMe83p3y6Mjozrf1tkcXndmEZJvykvL10NMmBxa7Tmi/6xHKew1nrXHlkN1C6B/KEANI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585909; c=relaxed/simple;
	bh=voWWZNVjInwwP4/q4o5QYwAfRBJAhe5wBmY7wRz2sxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k0lKKL+8DRI4E8O8eHMXH68k6opMn+c5m5dLTk9TLVm4aSp7fbw2SNt3aQ3nXUivZMTKVPP7iakhbAgdt67VVmEp0QffUhmYUgOSIX409BY7UDSEvCUG5/YWIt8cBuyhpjQpfmEaE3kGUsEfVVAsQzr1bPrGZI5zhNExErCGkRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/H7Q9Mp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768585908; x=1800121908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=voWWZNVjInwwP4/q4o5QYwAfRBJAhe5wBmY7wRz2sxE=;
  b=P/H7Q9Mp3PtfEyXv6/7lAX/N3kzBP5Q8yLCgqTjaMTxIPKMJ5dw31s+f
   x7jrMsmeOhD4srYhdvrGfNMT4ogIps68pQLVGyH9PbFXEhQcqObCv6MxC
   Wd8IS/TiFMwH/eqvovrjTfCLVRG4ORT+dYySnwhzAKvS/9XxMdcua/8qb
   OckD8pLeqHVOwiWNItuRsYKvCOzD9JixLrSTImWhNvV4jQPv6QY6OhxEH
   3/2wlyfsNYHTmI3WvxX6cg2arIlpkom1RSIFz2Qw2yrbDMbKYhgdF3mIu
   upezjaR9nZog4fKzlsPTIH+fviQNH+3bumFlO1vUwSTkosoat6oj33ayr
   A==;
X-CSE-ConnectionGUID: tBkBLwMQSW6AaCZSlimNLg==
X-CSE-MsgGUID: XyCc/eFtSAm7UHHiOReQqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="80625479"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="80625479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 09:51:45 -0800
X-CSE-ConnectionGUID: Ey3S0jL7QY6yvZZ+/wlqeQ==
X-CSE-MsgGUID: 9YOk8CZYQfO680xyS6yKVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="209782925"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 09:51:42 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 09:51:40 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 09:51:40 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 09:51:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQG0cLczelRxigEGkGYX6C9/A7M+4i3BrntwgpaiDjXs4vbmePemgoTuq//Jd7i5uhAPlVGbTgtxz4bcV6Z742zmEOh6MpNJN7SxD33GKRlRb7orKRUs7BeGbb8s/uIre0N8TmjtSvTu7LYCQO+aLcJPqpbAW/j7oo4wCyXDipMIBWiS6yt45KH0eU5/3XxMCSO0ABmZyi/MX5Sz2QGzGDEn1xooztW0bkUxeYbpV3QiFUpYvFhIttNLuNr7vqDZADLC8inUoCtbNjTtOxMLmaCrD2pZhDRKyVsuqPi0RHCQk+EkEPWvY+CfZTifEjspomlOyGg7x/N70irdT1LurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voWWZNVjInwwP4/q4o5QYwAfRBJAhe5wBmY7wRz2sxE=;
 b=vzK//lMrY/0M/sAZQT9yAZsEVtqvWPTMoJHwm2MI+R78Rr9lAjfYEWFm0PX+BjzU0GEJSjM17g1eKo0PQklwQeP9mu1AJ4M1Ip2uy/Fy6wArDCxKRIeb6R0Eq5JSkimVJ9UzFtFLCh/oH83B/B9weVh3P9mL1+mZWpV9aq8v6LR34++ugsqpLCrnjW/23+Bl5TIFAgmrYQPrT3wPxM+rnPuxSzHQqSuC9uwg7YwzR+qt9OP55fqp/NgUWW+LocA645rsfHDv38pKLMexcGbcMiyKvzVQ78phSRohkHTMVPa6nh1Gr2/8WsplCx9Awin0AH6G+yJs7XywDAfdkInzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 17:51:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 17:51:30 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "jgross@suse.com"
	<jgross@suse.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"surenb@google.com" <surenb@google.com>, "riel@surriel.com"
	<riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org"
	<maz@kernel.org>, "svens@linux.ibm.com" <svens@linux.ibm.com>,
	"ast@kernel.org" <ast@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"pjw@kernel.org" <pjw@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>,
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"jmattson@google.com" <jmattson@google.com>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "song@kernel.org"
	<song@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "kernel@xen0n.name"
	<kernel@xen0n.name>, "hpa@zytor.com" <hpa@zytor.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "jthoughton@google.com" <jthoughton@google.com>, "Yu,
 Yu-cheng" <yu-cheng.yu@intel.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"prsampat@amd.com" <prsampat@amd.com>, "kevin.brodsky@arm.com"
	<kevin.brodsky@arm.com>, "shijie@os.amperecomputing.com"
	<shijie@os.amperecomputing.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "dev.jain@arm.com" <dev.jain@arm.com>,
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "jackabt@amazon.co.uk"
	<jackabt@amazon.co.uk>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
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
	<linux-fsdevel@vger.kernel.org>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "jannh@google.com" <jannh@google.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kas@kernel.org"
	<kas@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHchnGR8zlgd593vU675Y8ML/1Q0bVT2boAgAE04ACAAAZHAA==
Date: Fri, 16 Jan 2026 17:51:30 +0000
Message-ID: <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
	 <20260114134510.1835-8-kalyazin@amazon.com>
	 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
	 <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com>
In-Reply-To: <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6242:EE_
x-ms-office365-filtering-correlation-id: 9abe4b5c-aac6-41a9-53e2-08de5527e14e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UWg5aE9KS2M0Y3ZRRVpxc3hnVHp3R3JFTGUvVElUU0UvVWg5UjNYTVhCUmp3?=
 =?utf-8?B?dEs1NTlYeHdPRXhsOG0vcXUzM1RETFBGeG4xd1BUTDZOa2Q2SThFUnNubktI?=
 =?utf-8?B?Y2s5QndLWTNXYXBrTktQYkNNeUNRWlA3MTlvQ0RKR1E0dTdQVC9MN3h1WWVC?=
 =?utf-8?B?aEY2ODZuVjljd3BnVXl4eUcva25XVDhUa1p1WjBBNWJOVlloYW5Hc2dxSzA2?=
 =?utf-8?B?KytJNlFFV0tKRGtjbGw1UmI0SG94NEpKYy9xeFYzT2xLd1lQc2JmVmdyNmN0?=
 =?utf-8?B?aEJwL2pmVlZKeUhPYmhoY0EzVXlZMFRzWHdMemt3ZTFMdEV1eHdEZEJMMjF4?=
 =?utf-8?B?L2dFMjJubHdJcDRCSk5idDFRbXlrNlhydTNBYTRCSkF5aEo1TnRhZUlnWlJI?=
 =?utf-8?B?QTlPK20xR0UrZmUxVU9GdEFYNEZCOGZZZWYvNWNUL3lzT3JpU3pFWlRwZy8w?=
 =?utf-8?B?NG1kK1pFa1hVNVBXVVAydGZEdmFBdklodjhmYjVSQU9MaFF5YS9QelViMXJl?=
 =?utf-8?B?cUNMbFdnSTJzTnN6WDFmTytuSGtPYjdjdlIrZG5jbURmRlhIcGpiUkJHM214?=
 =?utf-8?B?Um00enRJbXg2aWJMQzJ3QUlReUdXckRyL0RTRG5tR3BmYjBqOCtMN3FKQU1j?=
 =?utf-8?B?a2V5bUxLaVJYWjhhUFplU2g4TzRWWHBzUGlTbDlXZitKWm5uTHNIRUxZdU52?=
 =?utf-8?B?NXd2VWh4VStlWEpUTnhsSSt1dkZvN3VLb2plamNTQ3gvTm5rT1JhczEyZ09X?=
 =?utf-8?B?azlkYjdCQmJxMmZESnFBMy95UWt1ajlwRy8zUTZlb25vNTdEQnk2anNUNU05?=
 =?utf-8?B?cjNRdlJoMGxvSkNBSFJ2UktNcUs5TFJCUXBxc3BUMGRDenZDSC83emJWMzBm?=
 =?utf-8?B?U2hzaDFOODJLWWZnenBsU3UxeGxHRkp1OWNBRHVWYitmSGZaVWllOTlEZWtx?=
 =?utf-8?B?a21nMUtuUVhHeUxQK29XSEE4em5mSytpRGlIMWFva3g1RnA2cFkxeHVvRXFB?=
 =?utf-8?B?TXZsMUZaeXNQbkNjdkJaeWJ4NlJhdmhhaUZqYXUvblhXYXNGS0JsWEptME1X?=
 =?utf-8?B?WklFbE5XT0tEQ2VsRXp6VFlJQ2FNSHlsZkVYWERCR3RnZUd4d1lwaUlsYnF6?=
 =?utf-8?B?bGhsNGdHbGV6QnZpekJpMS9DZGhXTWRlN2pqdjFSMm9PVDd3Zmlqd3RtRUs4?=
 =?utf-8?B?VXBUazlRdy9mcUtlT29ySW1HS1hOaVdZeTJ0VzV3VENoTCt0U1hTLzNMSm9i?=
 =?utf-8?B?MTdEcmRBU2xEWlBIWkwzT1ZxSVYvZ0RSQjQ5cjRaS2RPWXkyRFFZeHlNcWdX?=
 =?utf-8?B?OW5lalFUQXRUTjB4cWgydDU1M2lVWXV0bkw0TEpTcS9tWGJpdDlkblVaeFFn?=
 =?utf-8?B?d2x5TnlzeFIyY3Z5YkZKYTFYSnk4OUpsZFkzNXJLY1FydjZNZDd2Yll6SVJx?=
 =?utf-8?B?d1UrOHFtc0JIR05EZUpESVliL2RaQTBicVk0RGR4VUVpZURUYjhZblBpVmxy?=
 =?utf-8?B?VVVuNXRxYjJzT0hvd0dHOEgrajNBNkZ3NzF5dUFVTjdaOGR2dGZRQzFaSEh0?=
 =?utf-8?B?c1pZank0bmRUeHBVNUpqVmRHc2pZRXgwRVErdzdRUldtUEl4VTlnaUtCUWFy?=
 =?utf-8?B?ZjdyUUErUGExdEozeSt2dUFMMmZ3dUhvU0NLKyt4aUNIaTdLM1E5NWhzYzVw?=
 =?utf-8?B?WGJ4dk5EcXBiemIrbnpsMDdLT29OWmc0MXpCMXVjK3kyRUdzOGZyQmZxTkRy?=
 =?utf-8?B?eFUrSWVWdnBIbVlPWUg1aGdIWmRTMFkveWxjcFBQRXhmUmdVcnBWQlZxOTQ3?=
 =?utf-8?B?WjFXN2pNdERBUDlXTGJ5UTFFRGRPaHUxQ0JYY3BTRS9kWDEwUmlIUDJpeXdF?=
 =?utf-8?B?M202RFM4ZjNsVEoyVksvUnhWQ2Mvd0FmNGxJWU9hRzJRMm5sb1hnQnNhNU5j?=
 =?utf-8?B?c0lqckhrWWw1QVBob1MxWEZyVmdOTzY1TWtEQkpVZ05pWCtFSmt4UjIzaXR6?=
 =?utf-8?B?UWFZTzdscVFHT2VWV0c2TjZYMDhXOU1XV1MyWXBRRDlMOHJtTHMwdWZmT0lF?=
 =?utf-8?B?VW0vdzRucnd6QnJ4d1FFaXk2anFkSnZrM1FDOEFJVDdVYnlwTjQwalphZ3Qz?=
 =?utf-8?B?YlhIWS8wL1lBT0taQlVGMGFVNitXSHI2TjRqQU4zNmp2NSt5WFYwTWduVHV4?=
 =?utf-8?Q?wegaIt5Wf4ETxHdW97EEhF8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFpRMStra05ZUjJvaCtwVGJkVjBxOXJiNjBwOXgwMUt2bjY2N1RLcU93TC9q?=
 =?utf-8?B?b0hVcjhrZWJ3aHdCUlE5T2Jza3JWODQ2QlZwTkRyaVhvazFMM3N1RE0rbnpW?=
 =?utf-8?B?VWRZWW95RDV5N3c4eGxGT1VzMXlPcTJUcG9KcnI5aWwzSlFYR3VkbFRnM201?=
 =?utf-8?B?djVLRnN5R1JPS3JBTnVabkV5akFmU1FpTE1qRkxsV1QyZ2JFenpsc3hMeTFy?=
 =?utf-8?B?Ykt5YU03aUVlQ1NGaUJkS1F4OVFCRU1tSTViRi83NHkwQnNoK2p0bTdGSFZ0?=
 =?utf-8?B?eklNdDM2UkpyS3FZQW1YRXhjaW56Q0wwRUU1aDlnSGdmWkFiMG40QXBuajlK?=
 =?utf-8?B?djk1Q1FUMm80dHdZQmhqakFZcUdMeEVyQzhRaDRpY1hPUzhKTU1GRTZ0cXpL?=
 =?utf-8?B?VktpaWR2UDdWaDlJRzM0S2g4eWpETEVsMDZnRkx4UWFCTnlsWlVia21OTlZU?=
 =?utf-8?B?QUZSZ0pYSGc1WDZyVWdLMFBjY0UrajdFanEzVHZnVUM5dTk1MG15R2d2eUxW?=
 =?utf-8?B?VER6MDgwWllyTkY4dU1IYkQwYjE4bFZTRHpGRWVLVmV1YVJJSU94bUlsZ0cr?=
 =?utf-8?B?ek81VlJoVWszZ0l4c0tIOExQTWpUS0lJNnIvSGlKcnFxd05PempTRklpbnVh?=
 =?utf-8?B?V2pkNU1FYlFpQWh2MVBZRE9McS9wdk8xZmVza1hLOGx0VFVJMnpIcys5SnpY?=
 =?utf-8?B?MFo1djRSQlVLODdBMCtGeFQwek1RMjZkNU10UjA0K3lvUmNCQmIzVnh5Wk00?=
 =?utf-8?B?eDZ5OVZqK3pYNzZKMjVMRFZ2ODZXV1lRMW9KdmpVcTVjeHhFRy9uNFM1cTNs?=
 =?utf-8?B?VER0Vm5WWlVSUnhMandWM3hWQlplcnhpM1FzWFpOK3A0UGxCOVAwMGYyM1lO?=
 =?utf-8?B?eUxnSXVqeDg3MkhYNUVBTFBPS21yYlg5QlM5bGxneTlBNSt4MUJieGNZV0t5?=
 =?utf-8?B?NHpvTStEUmtvRHBTYVZ4cEhhV3RBSzd5VUxmaGlmQkozbklaS1VUV2VIOG5Q?=
 =?utf-8?B?R3BaYUNxQkxDOUdjYnplN2JQTkJ3ZGQwbEFEUHR1MnJ6MWREZ1kzSDZsa0Fz?=
 =?utf-8?B?a1BPNExCK3JHMGFQaEVrellaNW5uZ1liT1hlR05sUzh1NElnamtkSk5ueXND?=
 =?utf-8?B?NWU3aHVucUhBRmwvaVFlOEFnUkxHS0JraXc2TFJ2N2NuVFBBWjJHSUk3RXAy?=
 =?utf-8?B?cTB4M2syYmxSc2VRWFhwWVhKcU42c0drdklsL0UvWlplTnJzOStEaWpLVGZZ?=
 =?utf-8?B?dEFJNExTRGZVR0tRQ2ZFMGYrOWQwbzZ2YjQ3R2dmandZczl1dC8yNWYzVUM2?=
 =?utf-8?B?MlRjZSt2Z3BLbVZ1U1daTzFqSURXVU9Bdjk2NStQazhpNXBKVGljeUhYV1Zp?=
 =?utf-8?B?OU1JeXMrcm41VzNIYktUQ2lYTlNVQVhIWDhJRmZOVVJ3NUpsU2NFV3krajZN?=
 =?utf-8?B?MTZRMGhmNlBNWnFuRlY5amhKMnZBSEtiSTlhaUZuOWh5eWIxbXFBeUthbDYy?=
 =?utf-8?B?ZkVsbXRlcFpiNUtLZ0tMaVBzcU5jRmpJcndHbnU2VnE2dWRaK3BKVXZMcEh0?=
 =?utf-8?B?L2xjd0p2eGd2azl4ODVOYWlNeTBKNGZURHQwODdGMHYydkRweTY4RmxiYWRB?=
 =?utf-8?B?R3pXY05nd1lIWHRpTnlhdis0M3MxTDBXTUUzZTkxNFcwR0M2R1V3eHVJbTZX?=
 =?utf-8?B?NEcyMTY2aktlUkh0V2p1bTduL2craDBqcEVKNFd5QktRSjBPV3VWQTlhQmcr?=
 =?utf-8?B?V2ZMeXRpRXV5SFR0Q1NFRVdJMGNhWWVzOHZaZTJIaTI2WFhlc2RsQUhzeWdj?=
 =?utf-8?B?WFdtaFhhelFOR0wwNFVEdXJMZ1NmVm10SEc2cnRaWWZnUEMrbXVVeldYcjVY?=
 =?utf-8?B?UFRRWHpFNWNzLzFaUktONzArLytLK0JGUjVKVk8rOERvWmlEeW84dEdBY1BX?=
 =?utf-8?B?d3dFNk1XRFYxa1dadzBReFFXTUxDdlZjN25kUENvUm9yVlNHQUhmTGxTdkov?=
 =?utf-8?B?dmVqMGxId1dHUjM5bzNULzRtUGV1cVh5U1lzTjcxalNRTEU4eEo4MzZub1V4?=
 =?utf-8?B?dktnM1hyblRyY1U3Uldtc0xGaWovMkdvQUwyNkhJNWM3ZUlKVWdtQ3hwb0RD?=
 =?utf-8?B?RU1GL3JhQXJTOHVDRFRwaHVLdUtiTkIvWWlkcnRHOTE2bkV6OGIyOFJTZ1kv?=
 =?utf-8?B?eWJndjBpaC9NT0RKcGppcHMvWnBVRnVaeUZUZ2ZzRUs3VldEcktVVVBhN3Uy?=
 =?utf-8?B?NVZRU2Y3YjhCSzdnMVJ0Rk5VSXR5RURzYUxlb0wwUnh4ZTRHNktOelU2eWhV?=
 =?utf-8?B?ejg5NlNoVnBoaHFkOG1xUFlIbDVHUlI2N1lHWmZxZDFVeGMyVW5XRGJwam9t?=
 =?utf-8?Q?u8zeTvPpLkFXbUfo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DCCA42740129047A90686FED244A08E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abe4b5c-aac6-41a9-53e2-08de5527e14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 17:51:30.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0h6tK4vSC5X0pEP2g/1zStQ0cpffg1QOLciZp6tm8VE/wyrMXwx0RxwYDV8fAowuDcszf7NCIL0nOSilEX7nFzJ5Urv4hHPU+zk3QLlzGTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAxLTE2IGF0IDA5OjMwIC0wODAwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiA+IFREWCBkb2VzIHNvbWUgY2xlYXJpbmcgYXQgdGhlIGRpcmVjdCBtYXAgbWFwcGluZyBm
b3IgcGFnZXMgdGhhdA0KPiA+IGNvbWVzIGZyb20gZ21lbSwgdXNpbmcgYSBzcGVjaWFsIGluc3Ry
dWN0aW9uLiBJdCBhbHNvIGRvZXMgc29tZQ0KPiA+IGNsZmx1c2hpbmcgYXQgdGhlIGRpcmVjdCBt
YXAgYWRkcmVzcyBmb3IgdGhlc2UgcGFnZXMuIFNvIEkgdGhpbmsgd2UNCj4gPiBuZWVkIHRvIG1h
a2Ugc3VyZSBURHMgZG9uJ3QgcHVsbCBmcm9tIGdtZW0gZmRzIHdpdGggdGhpcyBmbGFnLg0KPiAN
Cj4gRGlzYWJsaW5nIHRoaXMgZmVhdHVyZSBmb3IgVERYIFZNcyBmb3Igbm93IHNlZW1zIG9rLiBJ
IGFzc3VtZSBURFgNCj4gY29kZSBjYW4gZXN0YWJsaXNoIHRlbXBvcmFyeSBtYXBwaW5ncyB0byB0
aGUgcGh5c2ljYWwgbWVtb3J5IGFuZA0KPiB0aGVyZWZvcmUgZG9lc24ndCBuZWNlc3NhcmlseSBo
YXZlIHRvIHJlbHkgb24gZGlyZWN0IG1hcC4NCg0KQ2FuLCBhcyBpbiwgY2FuIGJlIGNoYW5nZWQg
dG8/IEl0IGRvZXNuJ3Qgbm93LCBiZWNhdXNlIHRoZSBkaXJlY3QgbWFwDQppcyByZWxpYWJsZSB0
b2RheS4NCg0KPiANCj4gSXMgaXQgc2FmZSB0byBzYXkgdGhhdCB3ZSBjYW4gcmVtb3ZlIGRpcmVj
dCBtYXAgZm9yIGd1ZXN0IG1lbW9yeSBmb3INCj4gVERYIFZNcyAoYW5kIGlkZWFsbHkgb3RoZXIg
Q0MgVk1zIGFzIHdlbGwpIGluIGZ1dHVyZSBhcyBuZWVkZWQ/DQoNCkxpbnV4IGNvZGUgZG9lc24n
dCBuZWVkIHRvIHJlYWQgdGhlIGNpcGhlciB0ZXh0IG9mIGNvdXJzZSwgYnV0IGl0IGRvZXMNCm5l
ZWQgdG8gaGVscCB3aXRoIG1lbW9yeSBjbGVhbmluZyBvbiB0aGUgZXJyYXRhIHN5c3RlbXMuIERv
aW5nIGEgbmV3DQptYXBwaW5nIGZvciBlYWNoIHBhZ2UgZ2V0dGluZyByZWNsYWltZWQgd291bGQg
YWRkIGNvc3QgdG8gdGhlIHNodXRkb3duDQpwYXRoLg0KDQpUaGVuIHRoZXJlIGlzIHRoZSBjbGZ1
c2guIEl0IGlzIG5vdCBhY3R1YWxseSByZXF1aXJlZCBmb3IgdGhlIG1vc3QNCnBhcnQuIFRoZXJl
IGlzIGEgVERYIGZsYWcgdG8gY2hlY2sgdG8gc2VlIGlmIHlvdSBuZWVkIHRvIGRvIGl0LCBzbyB3
ZQ0KY291bGQgcHJvYmFibHkgcmVtb3ZlIHRoZSBkaXJlY3QgbWFwIGFjY2Vzc2VzIGZvciBzb21l
IHN5c3RlbXMgYW5kDQphdm9pZCB0ZW1wb3JhcnkgbWFwcGluZ3MuDQoNClNvIGxvbmcgdGVybSwg
SSBkb24ndCBzZWUgYSBwcm9ibGVtLiBGb3IgdGhlIG9sZCBzeXN0ZW1zIGl0IHdvdWxkIGhhdmUN
CmV4dHJhIGNvc3Qgb2YgdGVtcG9yYXJ5IG1hcHBpbmdzIGF0IHNodXRkb3duLCBidXQgSSB3b3Vs
ZCBoYXZlIGltYWdpbmVkDQpkaXJlY3QgbWFwIHJlbW92YWwgd291bGQgaGF2ZSBiZWVuIGNvc3Rs
eSB0b28uDQo=

