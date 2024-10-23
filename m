Return-Path: <linux-fsdevel+bounces-32634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738C9ABB41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 04:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D102847F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 02:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1E2D047;
	Wed, 23 Oct 2024 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROmN5V6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E78467;
	Wed, 23 Oct 2024 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648879; cv=fail; b=iyxZYXwsPIoZqwgQOZuOJZ23NcC8dBc2p38f9QOKvDev9AnpXJzV/svgueDQ7htCQoMFtft6hK4wdPbPZCdguHBVH+moXuPGW6fC8rdHWN2sxWFi5hjINncLrAvsVZg73dbNQAcmXygyPfdXlsgi86ef1L6TJgE7gcITUQ8FfdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648879; c=relaxed/simple;
	bh=T96PMrsds7xEcYVnVO8QNFiXm1rx0Tc8n76ziP7Z5lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ex1lHc3R7H89DZ+aJKDk4SHDw8KqyqfYjRVQBjhHpOvsasKhfPWFqEoGQc2WoFapaQbhy9ZWroHEtSSclIMWBgGH4kBroUZNAPj2L2IGyOUUUTILW+obOdux2W+nf2O5x3LBJULBb2qhl1Q8pbePshC4Mesi1dMa61mnhji2mYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROmN5V6Q; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729648877; x=1761184877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T96PMrsds7xEcYVnVO8QNFiXm1rx0Tc8n76ziP7Z5lc=;
  b=ROmN5V6QctguzwWQ2wriyI7GtoXeGDfsJndyBsMFqy4cHTsawGILM9Iz
   MI2sFHo5kGQ5dsw8OZudK7EHQ25AEZcg7jaC1ebfPlMVTv/DNx0kHHhzH
   4eo+ReuZjiUtEIzDnMmiGy7onWfZ40p0Dkm8MYvBUVJEcY7nBCWt0aeQQ
   HbGTraJ5NQ3Ra/agZ4mwuiDM6AmCaL338BOATLc4QetsBzT1eBwBWeLn+
   Lezbi79w4scivHsVB+Jgw1o8K0rbG5lTMfls9eggk7x4rGN67U+rmNol8
   kGMr1PZsYW6JJmRRueXeY4UVVA2T2G8B+WzJ5FPw1w5G/vpT5g1Aa8cBc
   w==;
X-CSE-ConnectionGUID: 9QxFFF58RKW1QmYWZYSapg==
X-CSE-MsgGUID: KblQKmvJRgaUgs2rLsocEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="33031018"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="33031018"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:01:15 -0700
X-CSE-ConnectionGUID: MhBB3iRTTIucoMiw6efz1w==
X-CSE-MsgGUID: 2ofe+daCQJyef8iQ2Qr5VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="103341080"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 19:01:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 19:01:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 19:01:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 19:01:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHbO6jqlgUyaNbZFL4voJTcFHBYjV8C8xcZ3ITMfH1e7sM5zVCghzXoRS5sP7/9XJOUjxmA6mzuxsza5ckJRhHYVPfeaSsT62UTSlXlbWU92s0jKHHhSaRcdh2KFrotSdWhVr80xcAM592N321jqsTtnXrsmRQ9AM1mzwS9f9WnTR8V4t4go8DJFjT7xT1h3TMtQuqrHpa8cFId68YL/TqAoGTDumSMI22E/CY5oaZAz6l/AogTOqdxMOvQ2XKVu1go/F64+itDrRokD5Zi6daQvhMk9FJ3rXdQ0hsLO8TP+naAHz6aTPne30c+UDLGKxC56nYpoBP32jhAPKtTaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T96PMrsds7xEcYVnVO8QNFiXm1rx0Tc8n76ziP7Z5lc=;
 b=nXEbQSSSsDQ9PxMlFB6tW2sIUdFLXyqT0GoZA8nBwrCA8Yt9WLkdic46OrwDkw1N2GjmPGO6KQZHjob6SS/H3+lPxm8k/VryZVJGada0b36QpGo3ieEORSOzuqFh8E5JpOmm8IeGV9eMfqxAQCpo8ImxIantmzQeRpbOw3pJZj5ZJMubVZ/b6R4kYW4KX6igyp3ufSfQHmOSJfl5Zjj+6Pg4m+vX/LKMWeWC4dk1CqQmBll9PbAQnBAE+fvlk0bSScvGa0cgryxiPXkuWbdFatA/dQ6dJadGVpUfwenhXqx4muNiW0gy6wjrzUtiY3dJLHVRgJeq+fygzaqF943+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 02:01:06 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:01:06 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, "ebiggers@google.com"
	<ebiggers@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "surenb@google.com" <surenb@google.com>, "Accardi, Kristen
 C" <kristen.c.accardi@intel.com>, "zanussi@kernel.org" <zanussi@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "bfoster@redhat.com"
	<bfoster@redhat.com>, "willy@infradead.org" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [RFC PATCH v1 04/13] mm: zswap: zswap_compress()/decompress() can
 submit, then poll an acomp_req.
Thread-Topic: [RFC PATCH v1 04/13] mm: zswap: zswap_compress()/decompress()
 can submit, then poll an acomp_req.
Thread-Index: AQHbISi4e5vjS4f/MEuKUm64rE5wFrKTiE0AgAATzAA=
Date: Wed, 23 Oct 2024 02:01:06 +0000
Message-ID: <SJ0PR11MB5678486805FB008DB5CF6EBCC94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-5-kanchana.p.sridhar@intel.com>
 <CAJD7tkZPuMGB4=ULd=znbVqk1LL8oL_gdxi8q-K+vAub33nHgQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZPuMGB4=ULd=znbVqk1LL8oL_gdxi8q-K+vAub33nHgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CH2PR11MB8779:EE_
x-ms-office365-filtering-correlation-id: 58ca567a-7ac8-434b-8d39-08dcf3068e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WFBXVU1XbkFCVjJoVDZzd0lIc2lxVWpzYmMydUNMaVFoUWhXZlBUL0xYT2cx?=
 =?utf-8?B?MnlkL1BVejUreE5NOFQ2d0tVRUQzVGVMNW95OTFxeVBDaXFrOEtTSE0zcXh1?=
 =?utf-8?B?UTZJRzJLTjBISUtvckpha0NobVd2QWQxSHliSlZFN1ViVzBpV0Mxd29Gb3FX?=
 =?utf-8?B?bGRzNlZKUUxTb3dFY2pjeisvVGtpa3U5QmdySktVZXE5RytEU3ZmL3NnYURU?=
 =?utf-8?B?akc4Y0xtenVJVmxmWXFJSGRETnlPM2pmLzVUZWFjak5wR0RZWE1ZNnhBVFNl?=
 =?utf-8?B?M2xkUmpTeGh3RXZLOHFiQTBoMU1ydWJIdUFkTVhBc2QxT2tPS1pRcnB3RWJ4?=
 =?utf-8?B?SmxvWW4rVnpSRGJiQTNWSDVMdVJPSThSRGFrcFlMUnBWQ3JJSGljbWt4OU9V?=
 =?utf-8?B?OWZnTVhCd3ErQUFiL01RSXdsY0l6c3BxTkYwZ0lVVUppcGMwQXFMQndsRzc3?=
 =?utf-8?B?ZFJTOGgzRVdlV2EzUW1UaUhRcXY1OTB5THl0ejV5eWxkUndqZ2tZbWRUcGRP?=
 =?utf-8?B?ZEdxSit3anVuY2FDVy9odHhEOFQ0VW43WHZZR2NOUTJYNk9XQS9DUUtXNnRz?=
 =?utf-8?B?RFN3b0RiL1Voc0x0WmlsRCtvaHU1dzA0UnMxaTl0eDlIbjBzRGhOTE1oc1NP?=
 =?utf-8?B?N2ZieENyYjR5cTNVYlFFWHZJcHZKME5BN1llYWpSWDVhMmxkdXh2WHFFRWEv?=
 =?utf-8?B?R0dSeFVvRW9UcithMVlNUmNIdFVtcmZZM040dWxjZXRqajFGa2FaZ21mNEwv?=
 =?utf-8?B?eXB2Z2htaUc3ZGFGbUg3SFF1SmJHOVpKbDZTMmk0WEdMUkhMUnhnOFlTdjg1?=
 =?utf-8?B?c0RJdlVtUnJSbVlXcUQwcVdXMmFxOFF0NElGL1ZJOWUrd1UvOUhyTCtKUXl1?=
 =?utf-8?B?UUpTVWkzaHQzZDBzUFdVMSt1U1dIWXlCanZHd1NNQjJnMGpMcHU5cVhMdnpV?=
 =?utf-8?B?WmgrV0F2VG5objFibzh1TVFGVlRNQXNqUFRRV2krTmplQ0N0QzdMTitKVVRI?=
 =?utf-8?B?eFNZVXN2a3pQWkY0bWVKRG90WVlWdFZWRjdRMlp2Y1ZKbzd2dzdvNmRPTWQz?=
 =?utf-8?B?UHJXMmRCUjI4OGF5UUVIOE0rcTNBL1oxU25ObjN5bmpzeDZQWWorWi9LUTRp?=
 =?utf-8?B?ZVA1Z0p6Q2JNMVVNQ0Y2eXk3ZnlqWE1sY004RHNpTUpMeXdaRjU1VEdpMXFB?=
 =?utf-8?B?SFlvdzdyVUlFd2o0TXIySzBCR1hlOGEzRTdZcmluM0lSUkY5aXBLUmdub2Nm?=
 =?utf-8?B?OFVUeDBvZWFLTDdYTnY2bUFGT1lYSWF1ZGVkN2hibjJvOEdnVGY5Ui9kSzFk?=
 =?utf-8?B?dU1oWkxpR3kvMUZPMVlpajRUZ3MyQnkrTlY2djVwcGlMcTdLS2tEU3EwdjlN?=
 =?utf-8?B?Vi9sanVoZk9jSGQ4ZWJ3MkxIQkgzQ09seEQvOUpRWlJnN3NuYW03WXVJSW42?=
 =?utf-8?B?dDlwa0hDWUF5Z1RucEpESGtUYndlTncxK25jNlFQTldSVXpxb3BpUzV1bFBV?=
 =?utf-8?B?QkpmVDlYbElsaWNFNk9DZ1ZFNWFPYXZ1bm5MdEQ0VTNVK3ZhakNlWGFkTkY0?=
 =?utf-8?B?ODgzVlJQN1FEK0YvUU83K2RoNVN0TVhXMWVibjZrdHZHbEtDazh5d0dlRmtm?=
 =?utf-8?B?WlVIZkM2WWplYnRmdzBpT1pycTNBMGRyK21Yc3hDUjI3SHFFWE1IYlN0SVdq?=
 =?utf-8?B?ZkpDYXFLUzlGQzNaenVNSDJ1K2I4UnRNSi9DR1VRbTd6MkQ2UFhmVnRIUjRX?=
 =?utf-8?B?NE84WE5HVjlDQTFUdkpRM2QyaVJ0WFE0aGJWcSsrYk0rSGtyK20rbUJORGww?=
 =?utf-8?Q?2ucp4j3imv+Dus9FPO1R93W+Hej452nyVB3Ro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTlpT1VJS3hmbjZ0dFlra2haOGJTY1RzMVBtNVlGTmdwdWtXdjgyZUplR0NU?=
 =?utf-8?B?MVdqb1RQcFRnR2tzVm5FSEwwdU5rWjVXei80WnRVRzV0eUF1Qkx3NlY2aTlK?=
 =?utf-8?B?TUptU0FaUUxPQ0IyL042dFl2WHRwT1lSRytHbnBnWUVBd2VXU1VnVWgxTit2?=
 =?utf-8?B?RDhUVTZjZXFMUUlPVlBKQitmSjJ0NXd3ZGJQOVdENWNndkRYMHBsbnZnbkxh?=
 =?utf-8?B?L2F3WS90eHVWOVR2YWh3MGkrNmdPQXpySHdzMnhUYzltMXJ1a3ZGU1hKaUE1?=
 =?utf-8?B?MGpkcHFESXg4TDBsRVczTFlxTFpUYm5ONUZRRDNxT3BmVzFiWGJFZjA0cjlK?=
 =?utf-8?B?UHZaRW5SZ1dJaVVKdmdkYWRQSTJvRDR2d1d5TXUyUi9iZ2RoaVJBbGdQOVhr?=
 =?utf-8?B?ZjlML1lPNUU4aDZjcFZZZzJuTHFETzdHc1B0NXpRelhET0htbnYxTit2L0F6?=
 =?utf-8?B?SG9GOE9MWGZzcTdnanZ3SVo3ZmFBWFFaUlErZGd2dExEQjI3aVE4V0lyVFhD?=
 =?utf-8?B?eFd1eHJPKzhiK0xHcUw0cXJ5YVhEMkZaN2lMUFdoRU5QWEV3bS96UHhEbC9n?=
 =?utf-8?B?d2IzYkRObHNheDFra2h0U0lsSG1FMUtudTZQWm9Dcm9mb1lrdFFZVEIzS1Vx?=
 =?utf-8?B?VzFURm13azFWanFBcU9vQVF6eTVBVkdsUFN6MUxQZVYxY0Npb1R5RWt2bUgw?=
 =?utf-8?B?N2lRZ04yMHMyQnFmczF3dithZlpDVDVYMUp4ekJ6NnErZVJJQ3hoZFpJRElG?=
 =?utf-8?B?ckwyQTFrcDFzMWhCdVNKcUt1Mi9iUGZZUXZxS2E1aUR0VWNvTTZnWFFSSVFZ?=
 =?utf-8?B?eG1ML3l3cjJMZGJtUnhMMDJ1WmxVS3U5VE5MU1AzQ04zY05mRUYvUnIvZWxO?=
 =?utf-8?B?T2lnUmpqdVViQm91WklwWVprOWxtZWRCbTBuS25hWWFGOUdsQkI2QmEwb2RT?=
 =?utf-8?B?blVlS2hnNXlJR2dlcm9tbkUvbFFwVmpwMlBMTDRuQ3ZycnVsNWtOY2pGSndx?=
 =?utf-8?B?eGh1dkppb3djYWNuTHh2S2ZDR1RHeW8zekk4UVVvU00rMEZyYkh6MzZLSCt6?=
 =?utf-8?B?aFYrMDJHd1hqS3FxdEhiU0djQXNHTG9HWmdzTWY1UHFyeUhQYkgrRlBFUTJj?=
 =?utf-8?B?ZVVSK2NTdC9IRHM3ZzMxWWZKcE5NTytRQkNXZi9KbHRrOHNpMkJDdjkxSU1O?=
 =?utf-8?B?T2pteHVDTGtVbHZ5ZGkyRzM4TThkT0NkU2NOWTdaYmJ0aW5QUkZBbjd1S2xR?=
 =?utf-8?B?a1hkdVZMMUxXN2FUdHZLMWE0MkdlQVI5eGs4eW9aYmFQU1ZCYklJd2Z6c0xT?=
 =?utf-8?B?ak9TeVVLdTFDbVgxRU1Dekw4VkY0U29Xa29NK0k2UElCUWRJbXpScXc3bTFK?=
 =?utf-8?B?d1RWMHZwY3VUVFpEbU5IY2FsRkFQUVZES2NxcEYrZ3N0aEMvUGVHblVrRk1r?=
 =?utf-8?B?SXV2RW1LeUk2RDZlT284RVlpOHpCTDlXUGMyd25obFBWcG96OHdEd1A5UGxz?=
 =?utf-8?B?YUlsR3ZDNGJvRWsyem5RM3duOUdlOFhaS2hDL2x5Nm1ybkZWODhZTHVFQ01n?=
 =?utf-8?B?cDJ6SUNEQXNwQVBNcno0T0o1dC9KZDMwRHFtYnFZbDc1bGVncHdhRnZrd3RX?=
 =?utf-8?B?a3FPUEhKbDdhdE1jOFU1bUc3UHlkaUxEdVhLSzc1UzlpZFVCUVM2YnoyaFQy?=
 =?utf-8?B?TFJkNSt4VWo0RG96dXl6WVhzaDdscTJ3d0pqYklDTU1USUxaNm1MK1JGbVBV?=
 =?utf-8?B?Z3B1MUYvUXNUR2tha1NoWCtENEVsVXVDTnJkL083TkhkREwrMkhKNjJRUFUv?=
 =?utf-8?B?L2ZyRnlBUStoSHR2S210aWxHdVArWU5sb2ZQL25mbWlCa3FOVEUwOTU1eGw3?=
 =?utf-8?B?YmNlL0FaRkpBTm1JTEtDa29rOTRSNnRZNTJpSXRUdlBEeU9BMlNoL2kzR3lK?=
 =?utf-8?B?bTM5OUpGRnJFUE8xZWtHcEI2OTJkNDl6WmV0N1BOaU5uOXNJdTlMcmFFRXFW?=
 =?utf-8?B?clRVWWZpcFprTW8rd0RlSDdSSzdWTzlTNWQrODZCTXZ2NGdmb1lWVUxHajJy?=
 =?utf-8?B?bk9pVC9Ba0pCM2JFdE1VbzRaemVBMU9leHRpR0ZXYWxRMWdhVjZkZEt6VDRw?=
 =?utf-8?B?cTFwOWxvMjRBdElnUE5iTHBsbkJ5ZU84Y2NZMFBrY0FFNTdWZzFTcUhsNkMw?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ca567a-7ac8-434b-8d39-08dcf3068e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 02:01:06.6661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnwWHGB0zQkKyowO2QeLrY78xphkfN2RmAvguC9lBjOErRp5UT07BIBEXhe3rEVz6rNhHL8bwvvF5iOkI1PWaCrnlunQm4bfkryvJ96BYF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
X-OriginatorOrg: intel.com

SGkgWW9zcnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWW9zcnkg
QWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAy
MiwgMjAyNCA1OjQ5IFBNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNy
aWRoYXJAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtbW1Aa3ZhY2sub3JnOw0KPiBoYW5uZXNAY21weGNoZy5vcmc7IG5waGFtY3NAZ21haWwuY29t
OyBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207IHJ5
YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZw0KPiA8eWluZy5odWFuZ0BpbnRlbC5jb20+
OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gbGludXgt
Y3J5cHRvQHZnZXIua2VybmVsLm9yZzsgaGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1Ow0KPiBk
YXZlbUBkYXZlbWxvZnQubmV0OyBjbGFiYmVAYmF5bGlicmUuY29tOyBhcmRiQGtlcm5lbC5vcmc7
DQo+IGViaWdnZXJzQGdvb2dsZS5jb207IHN1cmVuYkBnb29nbGUuY29tOyBBY2NhcmRpLCBLcmlz
dGVuIEMNCj4gPGtyaXN0ZW4uYy5hY2NhcmRpQGludGVsLmNvbT47IHphbnVzc2lAa2VybmVsLm9y
Zzsgdmlyb0B6ZW5pdi5saW51eC5vcmcudWs7DQo+IGJyYXVuZXJAa2VybmVsLm9yZzsgamFja0Bz
dXNlLmN6OyBtY2dyb2ZAa2VybmVsLm9yZzsga2Vlc0BrZXJuZWwub3JnOw0KPiBqb2VsLmdyYW5h
ZG9zQGtlcm5lbC5vcmc7IGJmb3N0ZXJAcmVkaGF0LmNvbTsgd2lsbHlAaW5mcmFkZWFkLm9yZzsg
bGludXgtDQo+IGZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBGZWdoYWxpLCBXYWpkaSBLIDx3YWpk
aS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsDQo+IFZpbm9kaCA8dmlub2RoLmdvcGFsQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjEgMDQvMTNdIG1tOiB6c3dhcDoN
Cj4genN3YXBfY29tcHJlc3MoKS9kZWNvbXByZXNzKCkgY2FuIHN1Ym1pdCwgdGhlbiBwb2xsIGFu
IGFjb21wX3JlcS4NCj4gDQo+IE9uIFRodSwgT2N0IDE3LCAyMDI0IGF0IDExOjQx4oCvUE0gS2Fu
Y2hhbmEgUCBTcmlkaGFyDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IElmIHRoZSBjcnlwdG9fYWNvbXAgaGFzIGEgcG9sbCBpbnRlcmZhY2UgcmVnaXN0
ZXJlZCwgenN3YXBfY29tcHJlc3MoKQ0KPiA+IGFuZCB6c3dhcF9kZWNvbXByZXNzKCkgd2lsbCBz
dWJtaXQgdGhlIGFjb21wX3JlcSwgYW5kIHRoZW4gcG9sbCgpIGZvciBhDQo+ID4gc3VjY2Vzc2Z1
bCBjb21wbGV0aW9uL2Vycm9yIHN0YXR1cyBpbiBhIGJ1c3ktd2FpdCBsb29wLiBUaGlzIGFsbG93
cyBhbg0KPiA+IGFzeW5jaHJvbm91cyB3YXkgdG8gbWFuYWdlIChwb3RlbnRpYWxseSBtdWx0aXBs
ZSkgYWNvbXBfcmVxcyB3aXRob3V0DQo+ID4gdGhlIHVzZSBvZiBpbnRlcnJ1cHRzLCB3aGljaCBp
cyBzdXBwb3J0ZWQgaW4gdGhlIGlhYV9jcnlwdG8gZHJpdmVyLg0KPiA+DQo+ID4gVGhpcyBlbmFi
bGVzIHVzIHRvIGltcGxlbWVudCBiYXRjaCBzdWJtaXNzaW9uIG9mIG11bHRpcGxlDQo+ID4gY29t
cHJlc3Npb24vZGVjb21wcmVzc2lvbiBqb2JzIHRvIHRoZSBJbnRlbCBJQUEgaGFyZHdhcmUgYWNj
ZWxlcmF0b3IsDQo+ID4gd2hpY2ggd2lsbCBwcm9jZXNzIHRoZW0gaW4gcGFyYWxsZWw7IGZvbGxv
d2VkIGJ5IHBvbGxpbmcgdGhlIGJhdGNoJ3MNCj4gPiBhY29tcF9yZXFzIGZvciBjb21wbGV0aW9u
IHN0YXR1cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEthbmNoYW5hIFAgU3JpZGhhciA8a2Fu
Y2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgbW0venN3YXAuYyB8IDUx
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL3pzd2FwLmMgYi9tbS96c3dhcC5jDQo+ID4gaW5kZXgg
ZjYzMTZiNjZmYjIzLi45NDhjOTc0NWVlNTcgMTAwNjQ0DQo+ID4gLS0tIGEvbW0venN3YXAuYw0K
PiA+ICsrKyBiL21tL3pzd2FwLmMNCj4gPiBAQCAtOTEwLDE4ICs5MTAsMzQgQEAgc3RhdGljIGJv
b2wgenN3YXBfY29tcHJlc3Moc3RydWN0IHBhZ2UgKnBhZ2UsDQo+IHN0cnVjdCB6c3dhcF9lbnRy
eSAqZW50cnksDQo+ID4gICAgICAgICBhY29tcF9yZXF1ZXN0X3NldF9wYXJhbXMoYWNvbXBfY3R4
LT5yZXEsICZpbnB1dCwgJm91dHB1dCwNCj4gUEFHRV9TSVpFLCBkbGVuKTsNCj4gPg0KPiA+ICAg
ICAgICAgLyoNCj4gPiAtICAgICAgICAqIGl0IG1heWJlIGxvb2tzIGEgbGl0dGxlIGJpdCBzaWxs
eSB0aGF0IHdlIHNlbmQgYW4gYXN5bmNocm9ub3VzIHJlcXVlc3QsDQo+ID4gLSAgICAgICAgKiB0
aGVuIHdhaXQgZm9yIGl0cyBjb21wbGV0aW9uIHN5bmNocm9ub3VzbHkuIFRoaXMgbWFrZXMgdGhl
IHByb2Nlc3MNCj4gbG9vaw0KPiA+IC0gICAgICAgICogc3luY2hyb25vdXMgaW4gZmFjdC4NCj4g
PiAtICAgICAgICAqIFRoZW9yZXRpY2FsbHksIGFjb21wIHN1cHBvcnRzIHVzZXJzIHNlbmQgbXVs
dGlwbGUgYWNvbXAgcmVxdWVzdHMgaW4NCj4gb25lDQo+ID4gLSAgICAgICAgKiBhY29tcCBpbnN0
YW5jZSwgdGhlbiBnZXQgdGhvc2UgcmVxdWVzdHMgZG9uZSBzaW11bHRhbmVvdXNseS4gYnV0IGlu
DQo+IHRoaXMNCj4gPiAtICAgICAgICAqIGNhc2UsIHpzd2FwIGFjdHVhbGx5IGRvZXMgc3RvcmUg
YW5kIGxvYWQgcGFnZSBieSBwYWdlLCB0aGVyZSBpcyBubw0KPiA+IC0gICAgICAgICogZXhpc3Rp
bmcgbWV0aG9kIHRvIHNlbmQgdGhlIHNlY29uZCBwYWdlIGJlZm9yZSB0aGUgZmlyc3QgcGFnZSBp
cw0KPiBkb25lDQo+ID4gLSAgICAgICAgKiBpbiBvbmUgdGhyZWFkIGRvaW5nIHp3YXAuDQo+ID4g
LSAgICAgICAgKiBidXQgaW4gZGlmZmVyZW50IHRocmVhZHMgcnVubmluZyBvbiBkaWZmZXJlbnQg
Y3B1LCB3ZSBoYXZlIGRpZmZlcmVudA0KPiA+IC0gICAgICAgICogYWNvbXAgaW5zdGFuY2UsIHNv
IG11bHRpcGxlIHRocmVhZHMgY2FuIGRvIChkZSljb21wcmVzc2lvbiBpbg0KPiBwYXJhbGxlbC4N
Cj4gPiArICAgICAgICAqIElmIHRoZSBjcnlwdG9fYWNvbXAgcHJvdmlkZXMgYW4gYXN5bmNocm9u
b3VzIHBvbGwoKSBpbnRlcmZhY2UsDQo+ID4gKyAgICAgICAgKiBzdWJtaXQgdGhlIGRlc2NyaXB0
b3IgYW5kIHBvbGwgZm9yIGEgY29tcGxldGlvbiBzdGF0dXMuDQo+ID4gKyAgICAgICAgKg0KPiA+
ICsgICAgICAgICogSXQgbWF5YmUgbG9va3MgYSBsaXR0bGUgYml0IHNpbGx5IHRoYXQgd2Ugc2Vu
ZCBhbiBhc3luY2hyb25vdXMNCj4gPiArICAgICAgICAqIHJlcXVlc3QsIHRoZW4gd2FpdCBmb3Ig
aXRzIGNvbXBsZXRpb24gaW4gYSBidXN5LXdhaXQgcG9sbCBsb29wLCBvciwNCj4gPiArICAgICAg
ICAqIHN5bmNocm9ub3VzbHkuIFRoaXMgbWFrZXMgdGhlIHByb2Nlc3MgbG9vayBzeW5jaHJvbm91
cyBpbiBmYWN0Lg0KPiA+ICsgICAgICAgICogVGhlb3JldGljYWxseSwgYWNvbXAgc3VwcG9ydHMg
dXNlcnMgc2VuZCBtdWx0aXBsZSBhY29tcCByZXF1ZXN0cyBpbg0KPiA+ICsgICAgICAgICogb25l
IGFjb21wIGluc3RhbmNlLCB0aGVuIGdldCB0aG9zZSByZXF1ZXN0cyBkb25lIHNpbXVsdGFuZW91
c2x5Lg0KPiA+ICsgICAgICAgICogQnV0IGluIHRoaXMgY2FzZSwgenN3YXAgYWN0dWFsbHkgZG9l
cyBzdG9yZSBhbmQgbG9hZCBwYWdlIGJ5IHBhZ2UsDQo+ID4gKyAgICAgICAgKiB0aGVyZSBpcyBu
byBleGlzdGluZyBtZXRob2QgdG8gc2VuZCB0aGUgc2Vjb25kIHBhZ2UgYmVmb3JlIHRoZQ0KPiA+
ICsgICAgICAgICogZmlyc3QgcGFnZSBpcyBkb25lIGluIG9uZSB0aHJlYWQgZG9pbmcgenN3YXAu
DQo+ID4gKyAgICAgICAgKiBCdXQgaW4gZGlmZmVyZW50IHRocmVhZHMgcnVubmluZyBvbiBkaWZm
ZXJlbnQgY3B1LCB3ZSBoYXZlIGRpZmZlcmVudA0KPiA+ICsgICAgICAgICogYWNvbXAgaW5zdGFu
Y2UsIHNvIG11bHRpcGxlIHRocmVhZHMgY2FuIGRvIChkZSljb21wcmVzc2lvbiBpbg0KPiA+ICsg
ICAgICAgICogcGFyYWxsZWwuDQo+ID4gICAgICAgICAgKi8NCj4gPiAtICAgICAgIGNvbXBfcmV0
ID0gY3J5cHRvX3dhaXRfcmVxKGNyeXB0b19hY29tcF9jb21wcmVzcyhhY29tcF9jdHgtDQo+ID5y
ZXEpLCAmYWNvbXBfY3R4LT53YWl0KTsNCj4gPiArICAgICAgIGlmIChhY29tcF9jdHgtPmFjb21w
LT5wb2xsKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBfcmV0ID0gY3J5cHRvX2Fjb21wX2Nv
bXByZXNzKGFjb21wX2N0eC0+cmVxKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGNvbXBfcmV0
ID09IC1FSU5QUk9HUkVTUykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRvIHsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBfcmV0ID0gY3J5cHRvX2Fjb21w
X3BvbGwoYWNvbXBfY3R4LT5yZXEpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKGNvbXBfcmV0ICYmIGNvbXBfcmV0ICE9IC1FQUdBSU4pDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIH0gd2hpbGUgKGNvbXBfcmV0KTsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsg
ICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgY29tcF9yZXQgPQ0KPiBjcnlwdG9f
d2FpdF9yZXEoY3J5cHRvX2Fjb21wX2NvbXByZXNzKGFjb21wX2N0eC0+cmVxKSwgJmFjb21wX2N0
eC0NCj4gPndhaXQpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gDQo+IElzIEhlcmJlcnQgc3Vn
Z2VzdGluZyB0aGF0IGNyeXB0b193YWl0X3JlcShjcnlwdG9fYWNvbXBfY29tcHJlc3MoLi4pKQ0K
PiBlc3NlbnRpYWxseSBkbyB0aGUgcG9sbCBpbnRlcm5hbGx5IGZvciBJQUEsIGFuZCBoZW5jZSB0
aGlzIGNoYW5nZSBjYW4NCj4gYmUgZHJvcHBlZD8NCg0KWWVzLCB5b3UncmUgcmlnaHQuIEkgcGxh
biB0byBzdWJtaXQgYSB2MiBzaG9ydGx5IHdpdGggSGVyYmVydCdzIHN1Z2dlc3Rpb24uDQoNClRo
YW5rcywNCkthbmNoYW5hDQoNCj4gDQo+ID4gICAgICAgICBkbGVuID0gYWNvbXBfY3R4LT5yZXEt
PmRsZW47DQo+ID4gICAgICAgICBpZiAoY29tcF9yZXQpDQo+ID4gICAgICAgICAgICAgICAgIGdv
dG8gdW5sb2NrOw0KPiA+IEBAIC05NTksNiArOTc1LDcgQEAgc3RhdGljIHZvaWQgenN3YXBfZGVj
b21wcmVzcyhzdHJ1Y3QgenN3YXBfZW50cnkNCj4gKmVudHJ5LCBzdHJ1Y3QgZm9saW8gKmZvbGlv
KQ0KPiA+ICAgICAgICAgc3RydWN0IHNjYXR0ZXJsaXN0IGlucHV0LCBvdXRwdXQ7DQo+ID4gICAg
ICAgICBzdHJ1Y3QgY3J5cHRvX2Fjb21wX2N0eCAqYWNvbXBfY3R4Ow0KPiA+ICAgICAgICAgdTgg
KnNyYzsNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4NCj4gPiAgICAgICAgIGFjb21wX2N0eCA9
IHJhd19jcHVfcHRyKGVudHJ5LT5wb29sLT5hY29tcF9jdHgpOw0KPiA+ICAgICAgICAgbXV0ZXhf
bG9jaygmYWNvbXBfY3R4LT5tdXRleCk7DQo+ID4gQEAgLTk4NCw3ICsxMDAxLDE3IEBAIHN0YXRp
YyB2b2lkIHpzd2FwX2RlY29tcHJlc3Moc3RydWN0DQo+IHpzd2FwX2VudHJ5ICplbnRyeSwgc3Ry
dWN0IGZvbGlvICpmb2xpbykNCj4gPiAgICAgICAgIHNnX2luaXRfdGFibGUoJm91dHB1dCwgMSk7
DQo+ID4gICAgICAgICBzZ19zZXRfZm9saW8oJm91dHB1dCwgZm9saW8sIFBBR0VfU0laRSwgMCk7
DQo+ID4gICAgICAgICBhY29tcF9yZXF1ZXN0X3NldF9wYXJhbXMoYWNvbXBfY3R4LT5yZXEsICZp
bnB1dCwgJm91dHB1dCwgZW50cnktDQo+ID5sZW5ndGgsIFBBR0VfU0laRSk7DQo+ID4gLSAgICAg
ICBCVUdfT04oY3J5cHRvX3dhaXRfcmVxKGNyeXB0b19hY29tcF9kZWNvbXByZXNzKGFjb21wX2N0
eC0NCj4gPnJlcSksICZhY29tcF9jdHgtPndhaXQpKTsNCj4gPiArICAgICAgIGlmIChhY29tcF9j
dHgtPmFjb21wLT5wb2xsKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IGNyeXB0b19hY29t
cF9kZWNvbXByZXNzKGFjb21wX2N0eC0+cmVxKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHJl
dCA9PSAtRUlOUFJPR1JFU1MpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkbyB7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBjcnlwdG9fYWNvbXBfcG9s
bChhY29tcF9jdHgtPnJlcSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBC
VUdfT04ocmV0ICYmIHJldCAhPSAtRUFHQUlOKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICB9IHdoaWxlIChyZXQpOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICB9IGVs
c2Ugew0KPiA+ICsNCj4gQlVHX09OKGNyeXB0b193YWl0X3JlcShjcnlwdG9fYWNvbXBfZGVjb21w
cmVzcyhhY29tcF9jdHgtPnJlcSksDQo+ICZhY29tcF9jdHgtPndhaXQpKTsNCj4gPiArICAgICAg
IH0NCj4gPiAgICAgICAgIEJVR19PTihhY29tcF9jdHgtPnJlcS0+ZGxlbiAhPSBQQUdFX1NJWkUp
Ow0KPiA+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhY29tcF9jdHgtPm11dGV4KTsNCj4gPg0KPiA+
IC0tDQo+ID4gMi4yNy4wDQo+ID4NCg==

