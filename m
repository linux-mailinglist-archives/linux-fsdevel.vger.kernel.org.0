Return-Path: <linux-fsdevel+bounces-23804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42672933902
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 10:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932A4B24253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595636AEC;
	Wed, 17 Jul 2024 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIahZyvH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E61CAA4;
	Wed, 17 Jul 2024 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205072; cv=fail; b=l6ERvIcy9ncD/zSVGBA1BrORPrfFK6IdxipLgcgl01XIK/Fm7ct+sYO/DCABejx/0QYSUV+LXyiIID3K65G3hgXOpWYZkUPS7t3aXh0F78d5bg2rq6SYRlRoCpQwsxUoMb528Fis/QjX3hsMa0hVch86dOLYgtxy4WKePZIuiEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205072; c=relaxed/simple;
	bh=3XST1oMLMPo1ezxEHTB0St4DwVRJ1rHC7fXD2qlG6RQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qS0sY1I+c3vZUesEity2QsWZXA9l70LCrvwwDxjPfJCVd9koLCBTxtMTzGG+9zAAC8kgLT3Znn3vq4WLmS0qXm37HMNFiZ0aa65KSz/GHZg1Q+gOipOLgcLJMPoLpgtT49bPGl4ChC3p1YPt/3n5N1gtNjoQynPO8RRDGa0vTqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIahZyvH; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721205070; x=1752741070;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding;
  bh=3XST1oMLMPo1ezxEHTB0St4DwVRJ1rHC7fXD2qlG6RQ=;
  b=TIahZyvHs5ZOzqxSCULn/lxDSLzftsOnUkiFa+9cxdfLLDp95uTWgOA3
   G5MJ7QD9jSvFbawKIOejxHuJzyuf2N000S32ugjcJSkDooipV9SgVUWRa
   b63ePk3SMaEpyQBlnRMORnOCE3h7jUB/EG8Y3drETcxcgCaSmmwW16Ydb
   1OtYwugpNToSSMWMjNUNfgHCosppNav6oCa450kun0819R0m7zbzg5KNm
   /CIIAlU6ioMBvyKUhwNx5c3NX7aAQO98Vba05a34d9ENgldHf29UWX+Sr
   xFQgpf6s6mQIB4lGvqVfn6okP1GY5k8n6vMafIObbUuoRUD69sPiYCcQw
   A==;
X-CSE-ConnectionGUID: g3sRZ6JvRjO2jR/BM7j0GQ==
X-CSE-MsgGUID: JKYKTebeQCqHZzsLZN27LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="36129411"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="36129411"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 01:31:07 -0700
X-CSE-ConnectionGUID: fwTp8/3sRbW5vtmrtd31TA==
X-CSE-MsgGUID: uqxeR0K1Tbyhi/iUaVgboQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="55168212"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 01:31:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 01:31:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 01:31:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 01:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIEXq9IZLWWTPtRa8c3xrQissR+Gsya8Xutxc0nRzN6v7bfbZNthajOmjkVKWMwiADygT/h05aVkMD6fz/vC7sF0wnqrxrt+VwRSJ1iOmY70e4CwPI/JLaAhTPAVHOHjtEiFFpEeQz4ZrRS1ubRmPiV12nOacJ77cS+IPreR0mJZWGoM66a5ds/unLOyp2q+uzmvTNqbD6+0T39OKjhTL5DE2BZakaKgLsj3VMm4lAIXkcuNNQVJX0wkFLuYs9t/jeLDSKyqGX/hmSMy9j6VBLnwVm0QjHK2QsKyNdJcpOqNe3HW+Z05QdoTPnXEUmZ4ZrystqBhoYbjLwfJh6/v/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9gtazU7vs5hc4sSL/qMO7reuTlbWin9DPE4nGbPjSs=;
 b=vMY8S3xYRfiPKBclf7N4aS7KHtggF2l+Z5JSpl33Xa3mTbqJzyPlTCOLTI8IhmZ889HHlUMWI40dfsm9xnujaL5RCFHaEWvXRyXvur9yTbvSz1ICl8iq+x8+LjaL0Sj0eeVnCsdTPZU4q/MuuKPrfUXP30SRrF9N3r49AsVApGY4axe6Jra7qvLoqGWMclVyHHTx6vYmocwD+xBkRSOrQb3qCp3QkHw6XbeL3bKaYdRzKwMKiBg0bBpVQZnsHtEJ0P86vG0tlKxNL6ToyZ9CLDROZgr/pEqEtvJfKrZudkqUr/esmaOAPnLZMT7cdiTx8OGLnBMARogAWnuC1k/1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 08:31:03 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%5]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 08:31:03 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
	"syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com"
	<syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com>,
	"gregory.greenman@intel.com" <gregory.greenman@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Korenblit,
 Miriam Rachel" <miriam.rachel.korenblit@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "hdanton@sina.com" <hdanton@sina.com>, "Berg,
 Johannes" <johannes.berg@intel.com>, "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
Thread-Topic: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
Thread-Index: AQHa135rCbgxLDEJf0+CnikmlyC7SbH6mFKA
Date: Wed, 17 Jul 2024 08:31:03 +0000
Message-ID: <b12aebd3b89bc0b96e11fc83d67aa697dffeb99d.camel@intel.com>
References: <000000000000a0f1fd061d5cc101@google.com>
In-Reply-To: <000000000000a0f1fd061d5cc101@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|PH7PR11MB6031:EE_
x-ms-office365-filtering-correlation-id: 734b57a8-b602-418f-025e-08dca63acbaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHd0K1RKRTg1RHVKbS9VK25SVnQzM2tra0JpekR0L0JucWFkK1JGNk8zdVJO?=
 =?utf-8?B?dVRyeVVIN25haWFIMHNtSDVyNlF4cENFdm9NSjdwcUFnR3ZzUHgzbjNRRzlI?=
 =?utf-8?B?a3doc29rbDJPc2RaUy9RZi9pcmVsYUdLZUxkaUtxVkZGc0JpVWZNOWJpSytv?=
 =?utf-8?B?TTVpMmZiV1lXa1ZXM21XR3daTDZDcWN3VUJ2QUgzaFJqanhqNFdaT0s4U2Zj?=
 =?utf-8?B?VHJOZ2pMU3FzT21vQlcwZ3N2TWI3d2VJVi85NFJybTBqQ1NKVjJXUkhIZzZI?=
 =?utf-8?B?WnRHZWhJL09DMUxXRUU3YjVuQk1DWkdoSUYzMUEzcFlUU1dQTFJaQ2JqY0Va?=
 =?utf-8?B?RDduMldSOWpuOXJlUi9SSWloOXIwT0pEYVRIYkZqeUpueE9OY0p4UVE1R0Va?=
 =?utf-8?B?V2x0QzZMN3ExdDFNTUF3dlFJVWhyUnMyc29OMzB3S2k2RDVkTTlCR011NWNy?=
 =?utf-8?B?WFNjTEtFcTZhRGw2eXdzaDU1d0dRVlI2ZExQMU1NVDZpVFNMdjMvOTR1NlEz?=
 =?utf-8?B?U3ZaQVVlbHRiZFFqd0FWK0FDNW5VSWhTaitvcUVzUWIxWjZIdHBEM2tTS3I2?=
 =?utf-8?B?Um53cE5YNWpXZXZ1eTU0UHN6M2k1cmhkMDNOMVNjSFdsRkh4NGlISElTTGZF?=
 =?utf-8?B?SUZMMkQ2VXE5QVRxQ1B5NlNwNHFMbm9YelhlRzZjZjJSb1VNcEFQNHB1QXdj?=
 =?utf-8?B?RjFPZmZvRkVrWjQ2WExuWmlYdVlLaFNzUFFWL3dSQ3U0S1hUR1NLcDJheVdG?=
 =?utf-8?B?RkJXMWxkd3p3K2d4MXRTQWZhU1NHMitaR1JwTUNXZGZhaExmd1ErTU5idUl4?=
 =?utf-8?B?c3FJU3VJUElRTkx3aVdydVNNSVlselp3K1lTa3NnenZHclpFQ2JPRE9CQURK?=
 =?utf-8?B?M1pveWNFbjI4aEtOYmYyVXh4QjBtVGtobEs5R3pydXI5VC9FWlBaMzNoTW5w?=
 =?utf-8?B?Z1J1RFJwdHJhaVlObk1hb2lRdXE3eGQ3RndXaDk5N3Q5WFhWNEpmQ3FBQ2Er?=
 =?utf-8?B?enE5ZXVFVVBpMmJmYjc4cWhJN05JRkdhN0ZyWS95ZDVHTGluelFMcGFmcXFZ?=
 =?utf-8?B?SWVPbUY5MHZuWmU2eUJkU0hJcVgvdzBFMGV5RVlMVHdtNXZ3SWdjUjZmKzRX?=
 =?utf-8?B?VkdzWGRRVU9CQ09oamc1U3Z2UkVhZnRBamlobVF3d3d1QzN0d2JsaStEK2Ri?=
 =?utf-8?B?czFHdHE0NXhKYWFQNjhHUHZYNFNxRkFxZDNUVTc5bFV4T3pxKy9aU04rSFg1?=
 =?utf-8?B?bmJUZm01dks4VDRyaEh3TmJDYnd4RDVyczhRcGJuZzhxVWpVNnVRSGs1RGZF?=
 =?utf-8?B?elRKWi9MWk5ZZkxxUFZuaW03UE5VbWwzV0tJMHlBSHBNMjdCWlZWYnJNVHNk?=
 =?utf-8?B?dTFWeUt3VUZWbEpJaGJBOU5vZFRoQnlJS1NIOFNWM0ROY0VlWG92OHpWaHpk?=
 =?utf-8?B?elZHWHJOdmpZbWN0L2tnMnlmcVpKQ3JNTENzMUFDV0NLbkFENXR1eHBsS0Vv?=
 =?utf-8?B?MW5VQ0JucXZRZThPcmc3SjNiQ21lYmtwRUd3WmVDZWlIV0sweGdQQ2pJYUM2?=
 =?utf-8?B?UUxORnJNTkZpVWZqMVMwekNpL29qcDNFY2FSYW55VG1aT3o4ekJtNlhmM3lE?=
 =?utf-8?B?SmZaTW5ZZmpKcWZXYVcrcklvWmgweXk5bWRnVGs3QU81UDhQWG1XU1FCMmNv?=
 =?utf-8?B?NlRSV0h5aCtrbjR5aXl5QjNWWWlmWmRTdFdEMXRFVllFYlZHU2JVRnlkaWFo?=
 =?utf-8?B?cUo1U2JlSGZBZFUwdEY1RGd3Q0E3SVAwNXJwSTFUSndoeTMya1ArQ1lDaVBB?=
 =?utf-8?B?Nldad1pkM1g0WEc4a0taeE9DNlIwdE03SFFFR29NY3JPbVdHbmpma2h6MFFH?=
 =?utf-8?Q?N4ckFwh2c4WGd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1VQOG9JSHo4dWsrYVVKMExuR2s1OFRJV1FTZ01wWWYrQzE0QURQYmtDZUJH?=
 =?utf-8?B?WTFtWUM4MmRWRWU1K0l0VXlDQ2pZeE1iTVoxb0NoL2FlbURmbzhQVnpSenp0?=
 =?utf-8?B?cVhDbFh6VzhLTVhUUzZyeWI2QytpK0dwVTNRc2RnU2ZsK2NUYjR0M1pQdEFy?=
 =?utf-8?B?QTE3TTVjUlZzM0ZwbHNYWGVRbzFpNHdBSXJHbGxxc2ZhY1JqOXNlOWhSMGhp?=
 =?utf-8?B?NEdFNDEvODNVbmdEVUEzc2x6MlMxUHl3cTZQZ1V6bDZLcEJVZEdtcFJHeFlu?=
 =?utf-8?B?b091SGM4eDdLa09mVmsyc0QycUIrMmQ1K0VJam1JVW13djlpRWNqTW8ycndH?=
 =?utf-8?B?MXBFcC92TFBGejZDUmE5cGlVeXY5cHBkVGozSlBtUjBVeGF4VlYzV3crWktF?=
 =?utf-8?B?cEFSWXFsMmpLYjNwNzBUL1lpS3kvYUdMOTJLeE4xZDFCalNvaG5rSWdDUjFM?=
 =?utf-8?B?RFNyV25mekdaKzY5L01FVGxVcWpBaWlaenpFNDEyMCtXWHF4bFNVNGhReXMw?=
 =?utf-8?B?cGpFMXp5YUdQN3JQTE9XVkhUUis5cTRNRHVhbUR6dHM2Nko3V0p0dEdSWEZN?=
 =?utf-8?B?RmgwaFBLVUs4eTJWdGN1bSttWVhkbEx4amJmdk5zaXNLVWRNbE1CUk5mK0hW?=
 =?utf-8?B?czd1ZFliSVdwczd0THpIbnpib0xWeHFRUFl5L3JJNS9WMG9rZlpJRW45dzd4?=
 =?utf-8?B?VnNWV0R3Q3M4MW5CWExLcFF1VGRtWDlERTh3d2t4dWMrSkFGUDl1WGdTeHBP?=
 =?utf-8?B?VWlmc0JvaG1CcklRWGUrMmRyWVpuL2lkZ3BRTm9VNmhGSVIydUtkOGozYXMv?=
 =?utf-8?B?VExNbG9takpEa1pjcmN1a2Z3bXNlQnNJMXY1MmhEZForSG1EU05EWUk1K0t2?=
 =?utf-8?B?ZyszY0dZUldqNkxoZUlldXY2QmdmMjAwN2htaXl6L25lb2NoRTJlMmxIcVdp?=
 =?utf-8?B?YVdXbWsxRXdjOS84dnBtVzNkRWdMTS9PNllFb1FnNXBneUV2WTV0c3ZVdVk2?=
 =?utf-8?B?djREM2xhNk55bTU2TCs3bXBkYmdFTUlXYTJDS1h6a2k2eUtRTkxpMWJoK3U5?=
 =?utf-8?B?TFpQL2d0YWZVTWlIZFU5VS9QS1N4OTF6VU5KN28zclZ0WHlDTmRlTDBlOTh5?=
 =?utf-8?B?ZEQ3VGl4TXJUcE1QMG1jREFMNkhLRjRpREZIRnlONEJ2a1BUTkV6bDZEbklq?=
 =?utf-8?B?NXlneFI4Ni9BMzJtNE9Cc3pKUzZxRVZKWHJ5b0E0eHdzM3lEeTBvRFAwaldS?=
 =?utf-8?B?ZkFuR3pYZ0dkaUcrNjlUeEpJS0xGeUU5REVWUVVjOURiRURpLzBQZjl4aHlU?=
 =?utf-8?B?NDAyZ2pRUGlSZDRtSHZFR0xTRDFCSldtaGRDaHA5eU93WlBoRFJBSHVZNGM4?=
 =?utf-8?B?dFpDL0hNQnZta01KYlpUa2plTGd2TjRwQ1padDBqaTBoams4a1pRU0FpUEl5?=
 =?utf-8?B?RnRtOGsyR1JLTjdmb1gxZ1BVZjBGWGp4dFFDSzV5Tzg3NTg5QXZNdXUyNFhi?=
 =?utf-8?B?bmNIejJYcFNHZmN1YVNac1lNWG90STV2dUJrQVU0S2JhVUp5NGtUMzYweFps?=
 =?utf-8?B?VTF2WVJzZnk1YWxQU2pJVUhtOGFhbENRWXNPL3YwNVJTTHVjR09rWHB6bEdZ?=
 =?utf-8?B?dGl6MVFvcjNtSUhBY0ZFd0Z4bGFiZkRQR0RZRS9RZnRRNGMyeWw1Z3U3Q0NX?=
 =?utf-8?B?YnRBeDBKUnpLT1BpUlM3YzFzb1JUdjBsS2Z6M2c2dkpHdjluM0hPeEVIN24w?=
 =?utf-8?B?bU9GaHZucWdoaU55OUk4T3FoUmlWa1NuQTNLbmpmZkJNSXRXYUxCbC9FREdX?=
 =?utf-8?B?VHJDb0JlUXpheFdNalQ4VEszbWNWd0RvaHNSR05NZklRSmZKeEN0b2tnUFlI?=
 =?utf-8?B?YURSZGQxOUZEWUpCcWlkR0tSQUdvVzVMeTFuQXBtTXBPc3dBczZUWldVSzRN?=
 =?utf-8?B?bUhBc2FCS0Z6N3RwejBqcGljbmM0N1U5TG5MUXE5blpNWkhhN3FZd29Ecmx5?=
 =?utf-8?B?b1JLUUFxY0w3ZDRXR0hYQnRMeW1XRmx3Nk1uOUpZR2tNTkx5VWpMT1MySEMx?=
 =?utf-8?B?T3JoN3lQRHVPMEJWUHVrU1VJc0d4VisvdXRjZXJRdGx2K3o2L0J6TXRUQUZx?=
 =?utf-8?B?djVUYXA0L1FZRm1QQWNYL2V2QjRhdUlpeEJBOVR1NGZ4WFpwOSs3b0w3ald4?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <914C3B2869820546A5B0E08BA1FF93EF@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734b57a8-b602-418f-025e-08dca63acbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 08:31:03.4934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkAT1wiDwTsHJJsMUNndtIcy8+w2XSV10m0erxQ0UIPOdFn0LG3KCEc/xelJKpLARJpABmLQoZwObwjPzY8/dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGksDQoNCndlIGFzc3VtZSBpbiBpZWVlODAyMTFfZGVidWdmc19yZWNyZWF0ZV9uZXRkZXYgdGhh
dCB0aGVyZSBhcmUgbm8NCnN0YXRpb25zLCBhcyB0aGVpciBkZWJ1Z2ZzIGVudHJpZXMgd2lsbCBi
ZSByZW1vdmVkIGJ1dCBub3QgcmVjcmVhdGVkLg0KDQpJbiB0aGlzIGNhc2UsIGllZWU4MDIxMV9k
ZWJ1Z2ZzX3JlY3JlYXRlX25ldGRldiBpcyBjYWxsZWQgYmVjYXVzZSB0aGUNCm1hYyBhZGRyZXNz
IGlzIGNoYW5nZWQgYW5kIHdlIGRvIGhhdmUgYSBzdGF0aW9uLg0KDQpNeSBodW5jaCByaWdodCBu
b3cgd291bGQgYmUgdGhhdCB3ZSBzaG91bGQgcHJldmVudCBjaGFuZ2luZyB0aGUgbWFjDQphZGRy
ZXNzIHdoaWxlIHdlIGhhdmUgYSB2YWxpZCBzdGF0aW9uIG9uIHRoZSBpbnRlcmZhY2UuIEJ1dCwg
d2UgY2FuDQphbHNvIHJlY3JlYXRlIHRoZSBzdGF0aW9uIGVudHJpZXMgYW5kIG1heWJlIHdlIHNo
b3VsZCBkbyB0aGF0IGVpdGhlcg0Kd2F5IHRvIGVuc3VyZSB3ZSBjYW5ub3QgZ2V0IGludG8gdGhp
cyBiYWQgc3RhdGUuDQoNCkJlbmphbWluDQoNCk9uIFR1ZSwgMjAyNC0wNy0xNiBhdCAwNTo0OCAt
MDcwMCwgc3l6Ym90IHdyb3RlOg0KPiBzeXpib3QgaGFzIGJpc2VjdGVkIHRoaXMgaXNzdWUgdG86
DQo+IA0KPiBjb21taXQgMGEzZDg5OGVlOWE4MzAzZDViMzk4MmI5N2VmMDcwMzkxOWMzZWE3Ng0K
PiBBdXRob3I6IEJlbmphbWluIEJlcmcgPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPg0KPiBEYXRl
OsKgwqAgV2VkIERlYyAyMCAwMjozODowMSAyMDIzICswMDAwDQo+IA0KPiDCoMKgwqAgd2lmaTog
bWFjODAyMTE6IGFkZC9yZW1vdmUgZHJpdmVyIGRlYnVnZnMgZW50cmllcyBhcyBhcHByb3ByaWF0
ZQ0KPiANCj4gYmlzZWN0aW9uIGxvZzrCoA0KPiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNv
bS94L2Jpc2VjdC50eHQ/eD0xNTBlM2NmMTk4MDAwMA0KPiBzdGFydCBjb21taXQ6wqDCoCA1OGY5
NDE2ZDQxM2EgTWVyZ2UgYnJhbmNoICdpY2Utc3VwcG9ydC10by1kdW1wLXBoeS0NCj4gY29uZmln
LS4uDQo+IGdpdCB0cmVlOsKgwqDCoMKgwqDCoCBuZXQtbmV4dA0KPiBmaW5hbCBvb3BzOsKgwqDC
oMKgDQo+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwb3J0LnR4dD94PTE3MGUz
Y2YxOTgwMDAwDQo+IGNvbnNvbGUgb3V0cHV0Og0KPiBodHRwczovL3N5emthbGxlci5hcHBzcG90
LmNvbS94L2xvZy50eHQ/eD0xMzBlM2NmMTk4MDAwMA0KPiBrZXJuZWwgY29uZmlnOsKgDQo+IGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PWRiNjk3ZTAxZWZhOWQxZDcN
Cj4gZGFzaGJvYXJkIGxpbms6DQo+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9l
eHRpZD1kNWRjMjgwMTE2NmRmNmQzNDc3NA0KPiBzeXogcmVwcm86wqDCoMKgwqDCoA0KPiBodHRw
czovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLnN5ej94PTE2NThjN2RkOTgwMDAwDQo+
IEMgcmVwcm9kdWNlcjrCoMKgDQo+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVw
cm8uYz94PTE2ZWQyNGI1OTgwMDAwDQo+IA0KPiBSZXBvcnRlZC1ieTogc3l6Ym90K2Q1ZGMyODAx
MTY2ZGY2ZDM0Nzc0QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gRml4ZXM6IDBhM2Q4OThl
ZTlhOCAoIndpZmk6IG1hYzgwMjExOiBhZGQvcmVtb3ZlIGRyaXZlciBkZWJ1Z2ZzDQo+IGVudHJp
ZXMgYXMgYXBwcm9wcmlhdGUiKQ0KPiANCj4gRm9yIGluZm9ybWF0aW9uIGFib3V0IGJpc2VjdGlv
biBwcm9jZXNzIHNlZToNCj4gaHR0cHM6Ly9nb28uZ2wvdHBzbUVKI2Jpc2VjdGlvbg0KDQpJbnRl
bCBEZXV0c2NobGFuZCBHbWJIDQpSZWdpc3RlcmVkIEFkZHJlc3M6IEFtIENhbXBlb24gMTAsIDg1
NTc5IE5ldWJpYmVyZywgR2VybWFueQ0KVGVsOiArNDkgODkgOTkgODg1My0wLCB3d3cuaW50ZWwu
ZGUNCk1hbmFnaW5nIERpcmVjdG9yczogU2VhbiBGZW5uZWxseSwgSmVmZnJleSBTY2huZWlkZXJt
YW4sIFRpZmZhbnkgRG9vbiBTaWx2YQ0KQ2hhaXJwZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5IEJv
YXJkOiBOaWNvbGUgTGF1DQpSZWdpc3RlcmVkIE9mZmljZTogTXVuaWNoDQpDb21tZXJjaWFsIFJl
Z2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIgMTg2OTI4Cg==


