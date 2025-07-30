Return-Path: <linux-fsdevel+bounces-56348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01EFB16468
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 18:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA39620829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D082E0936;
	Wed, 30 Jul 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyDPA0n2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B732DC345;
	Wed, 30 Jul 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891858; cv=fail; b=jU2IkbNhF1MidMqi7g5yq2UHXzxCqasPZvv+rfz7mGCm1tHUNnQAR0Bzw2BcEiqZUZHMl2p/35GIoCzZLYZNaZa5FT+ffgu9NGXLz1mQ+BLdiTCj9KnB3r6mNB8hXOG3n0RwGrM2xBdxA6DHuY+CGrf1kKpV58PD0SXtJGSVRjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891858; c=relaxed/simple;
	bh=EiaYd2Ca0nYwemSrZxfx6k4oFUO42OIhNKYH7a2JYVE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=QpQp7GmSb5sCS9NAQOfpOkX/QGyfA7B0XF+HDZLfAQmhPrAxzosQqpwnI7pv221iLaE/c2qJ+4ctCS13JwMUEmPhH3anxCu1ooMMrc60SS+ylfjoZzX3pSX+gcaCvIzuqg3dfct7XNJ22lKInuiXd9Zu5Wu34YnlnM2f22SuUCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyDPA0n2; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753891855; x=1785427855;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=EiaYd2Ca0nYwemSrZxfx6k4oFUO42OIhNKYH7a2JYVE=;
  b=RyDPA0n2CdLdgq39g9/OrPOsshzIyPPmAMgQuiNhG4/GT3M+MP3uO2Db
   ijHrYS2Ac+SKubLMa2rjagKJaEb4v8x6wsHOKMeC09ftbGtQEgGF1+EoF
   tT7/f24taUMpM/4/8AwTocVaLQuKNe6mJsgrojuMX71GtJO2vBn8M4BEK
   9Vo7gerxD+agzK/f0vNWHpqkQ0HdBF0zqIZO1Aq2QT0i6T7cgzcY7ESFz
   WVCIQaooUadD65osrY5nrR1U/Zfc1StqM6wR51DBh/JkJc7Vpvk1ZW/Cj
   h/oZ0dUaOLKpGmSALVvlfwRSE+GfLvS5KXlYtA3KvWm9WWol+ibak4Qsa
   Q==;
X-CSE-ConnectionGUID: hNb/Wr6gR8+jkzP/I+J0EQ==
X-CSE-MsgGUID: 6uchbxj1RGi6SosNFzRcEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56132677"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56132677"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:10:30 -0700
X-CSE-ConnectionGUID: zyrpL5daQEyCjDofZpgasA==
X-CSE-MsgGUID: ObC2P36DS2CEYZLgAhx2fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="168319206"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:10:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 09:10:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 09:10:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.81)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 09:10:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofnWB3jDy629GehkWr9NxuiJZX5ljVJhSqbJfsMMuPgocZOs25kSe5MUbQ8kz13vFMiXNQ9aZqWap5r1W3eknB96xcZhVStoNY/tl99do3od5UeX+mHBhyUA7Rudn7QoOlCZ5a0ajvQlvOCoRifZY1hvxPf0DyUh/BCaqyQ8sX/QxBPQIUMLX6QCPM/Nr9lnvhJzVRY8Mv3NoJy/cxEpEyRZY0WCbCO+umBhiEpYK5k8iL0jLLY+75V1YaX7y/fDHdwHlSYb/9YFlg3gcxu3ChakTivpUoCa0YIADmh5UhOAK96Q08S9OxCjMqBugIeGDiT/ZewCorJXOMGoYTxgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzXlVrQM/9f+lSh4EFEZHF0WKGa9wWC15GgcmNOS8rQ=;
 b=ZhrL+u/j4Fv17KC+ruZv7fHjSAFAOVFW4ziqouKqaHnIRSkP6EwB0f4x8BQHHPeemkJha/20xZ0kHB9IW5GUxrR7d4KWnPwLCqsENinb3ht6c219mC7OjmPvzGaisLWMghesVm55xiWyRlxJBUiwB48UBKM9gY3NflvMVJrwUcIooWD1vFJ9jJ59zVN4bcwTVRrzSs862WmbeTmnHsstfOf1oYv0ppzWk8tG1a2TxKG+41e0ortOO6fUwvOM7FIuEY69XbP63so5VLLdOifUtwE4NWFScDzBVA48sZp7G9KPsuFISoTFS4I4V/qfbimMtRwHT45riLK8piENoGQrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 16:09:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 16:09:55 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 30 Jul 2025 09:09:53 -0700
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Robert
 Richter" <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>
Message-ID: <688a43d1b8fca_11968100bf@dwillia2-mobl4.notmuch>
In-Reply-To: <bf47567b-3277-48a3-a500-81b444cd165a@amd.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
 <bf47567b-3277-48a3-a500-81b444cd165a@amd.com>
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c61919-d190-4828-259b-08ddcf83860b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHR3ZTNMaThCRzFmdWFCUGtNQVRNOVFnNG1GbHJIME5vSWtaL09MMjNKN3pD?=
 =?utf-8?B?TnBtTTFhMkMrQXNDRmJyRjZXSjg4WmRMWGNxOWVUMWs2S2E5aS9NVTdiQUNw?=
 =?utf-8?B?Sk0rU21kS2RmWlFlV2NmbkpVRW1EZklQN3p5b0JPOGFOTGlyVm5vREkya2dU?=
 =?utf-8?B?TFltZGc4ek9vcFdsdDZCK3NySDVkRzMveHBmS3VzNFYvUzBGUkw1TWRNMVhU?=
 =?utf-8?B?Tmw3UXBEcExId3MyOE15d1hoMWZ4dUs3ZXd2SnJ1MjRVd0ZmQTNIbUJCWENt?=
 =?utf-8?B?M042LzAwSDNac1FQZ3NKei9QblgwNnlaS3NSSzJYUmNRY1NXdE9GQVNHR2E0?=
 =?utf-8?B?RGJrdWRmbjF1dW5mK21nWjBGMnVaU2NieklRajVrN2M1eG9iemZxV3pDcVU5?=
 =?utf-8?B?U2VNVU9rZGgxYUxzVjdyeEM4c2ZvQkh3MGQ3OVlKWUl5WEQzcnluQWlWUkdj?=
 =?utf-8?B?UHUzaWdsSkJUWVRuZ0Rha0xBenpRNmEvb0UzbjY2dklGSXgrTk5lU3FQRjdH?=
 =?utf-8?B?MHdqRloyYUNlVjhueStBbDlyQ0l5UWdPMEEydWJQSFgwUTA5YlFtdzlyeWt4?=
 =?utf-8?B?aXAwRHNIcm8xb2RBMG9jdkRRaU5uL04vVVhEREFhM2U4OURMWGhjcGdCQzNn?=
 =?utf-8?B?aitRZHZVM29SbWtqSjQwQ1dPRjZFVXFmV2MyR2JiYXloYmVWYlJLVmU1Q0xs?=
 =?utf-8?B?WXpyM3NVYUFWaXYzVXpjdzc0bVUvZUVWWmZRRGo5VnBjaDNmZGsrSzF2YW1M?=
 =?utf-8?B?aUxhSVpYTWtMVUF5aFpORk9SRFJYU0JBNVRDbDhxNEZPcEFMQjJTbkZ3aXMx?=
 =?utf-8?B?ZnV4eElHQnoyQmR0SjlIYUp3NVovR3AreTV5MkhHZVVnajZsY0xYQjROSHQ2?=
 =?utf-8?B?SEdUWUpwSWNlajFCUEhSVDFEMktpdW5Icnk3NTlvd0FDMVNFU1ZLVHJRVm55?=
 =?utf-8?B?bC8vYnV4TnV4VmY0V29FUE5Pc2ZKcWsxTlFPdy9mcDAyejN1MS9ydUZVaDFO?=
 =?utf-8?B?b01ncDJIejF2Q2V3S2R2djN2R3FZd0Z6NjJ4Zk5lS2wwei9TSHYzYVQrSmtx?=
 =?utf-8?B?bDlEMmxDOGhjazVFMkVLMmJqOFhBMi9pQmZtczU3bDlBTU1vRW1FVkhhQlZP?=
 =?utf-8?B?eGdEaEVpTVljNkExcm9jOXZJdFoxeUlYY3l3alNOTjBSSFRmTit1M2d4UWFT?=
 =?utf-8?B?QVBQa2hXeWV5RFRlclZIbmMzSEh3aE5iV002c2ZJOU9RUDV5eXMzZ09xZkJv?=
 =?utf-8?B?eC96UjIzR3dPcmh3eHlhSE5WWFlhcUl1NEdxQmY3RWEzUWRSYk9qVEt4Mk9Y?=
 =?utf-8?B?aW1lMWdBRkdNVWZLUGlNbC9wNkR6YTcxeWtteHRrL3BBRVlYUDYrNTJHREF3?=
 =?utf-8?B?K1FWTmd5Q05BbmpNRTRMdzBGeWxSbFQ3cU9RMllnRkFYY2czd3VjUDhKdm1n?=
 =?utf-8?B?QTRWOGdDS3FaWTdiU1JYVlN3VUx4Z1hYRGZKd2pSQWtoN2IvZWtFOTF2Z0xh?=
 =?utf-8?B?QWVNUWtHVlFwRFEwWUxNNG8yUHdBbCt0SDQ3WUJZTWRSaFgyWmE2V3hUTmg0?=
 =?utf-8?B?ZG1ZY01mdG5xbEdaQmp4NFJ0V3NFSmpVSEt4MS80UFd2SG1NeEJBMHF5WXpT?=
 =?utf-8?B?TFJkL0RaRi9yU2RsS05tNGNDaCtnUUdxQTZaQ3UwV3FiaGppMGVoSElyc2ts?=
 =?utf-8?B?d2VqZ2FIYmZtalZ0MUpaM3orTnNpTk1ZVzlKeE1ySUdQTDEwQVBzRlVJalc5?=
 =?utf-8?B?MFhDY21YZWl2Mk5GUWx2d3kxUlArbFBXb0h0d2NYZjlKL3lQSUJFWHpkWHVQ?=
 =?utf-8?B?dWcyd2M4YnMxcWFwRG9RMDlPMkc3ek5VODdPdTZFM3p2WlRDZDJpTlo0U2Zq?=
 =?utf-8?B?Q0NhM3g5WnViN3JldUpWcFc0cTBwSXJsUkpTeHN3NFkzZks2VjZTYVpKV3lt?=
 =?utf-8?Q?aMCaO43F1RM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1U4YlRlZnlOOHcxMUFLclVHQndtOVhBWTlxK2t1QjdYNWEvakVTdkkzNk03?=
 =?utf-8?B?Vm5KVkpxRWNkTnZNZ1RNdnpXcEh4U2grTXJ6d1ArcWtoNnVZenkxbWRjQUh0?=
 =?utf-8?B?eFRCU1JhT2VEYzFuRUpLWmVZekluaTJWQXk2SFU3cHJwWFZYN3piQVQ4UTgy?=
 =?utf-8?B?ekJVZmRvS2RwUFF0RlIvYnFsUDZlMEtVY25CbEZwd2FubmJ5RktiQk1NODdl?=
 =?utf-8?B?N2FaeWJobEhLbENQeDNDNm8ycmpacFZpbFBucmNxR25udUk2d3VpaGNIWUZj?=
 =?utf-8?B?SUhlNjJwSFJ0TncyVTZsY1Y3Mkg2eFhUNXM2MXZ5QVppR0FSQmZDOVg3VXpl?=
 =?utf-8?B?OW5XT3VwSFg2bTZzbzdrN2hXcGh6VnNjQ1JOTVdBL2hYL2wrV2lJOGJIZUtS?=
 =?utf-8?B?Mm0wUmptQjdDYzlueWxzWlpjYUp2ZVhWRWNkVUtNWW9pQ0ErODcvWEsyWW5l?=
 =?utf-8?B?dU5FM0d4b0hMQVlTTkh6R2lTVmc0dGptYldBMm9sQ29LSXFiMlppMEVIb28x?=
 =?utf-8?B?aFg2RkxBY3BTY2ZCRnZRMHArc25IWUFVUkQ5VzBnQmlndmxHS0ZlbG45WkQx?=
 =?utf-8?B?NXZjTHFuVDk3cGVzOTdoV2xlVWxvZ3paSnRKZVlWN2llK2Y3dHJoaEQ4SEpk?=
 =?utf-8?B?eURQeVNkNHBqQTJwaTB6U09BUlozLzAvZHJGdWVyMEJVUjZob1FzVXVuWXBI?=
 =?utf-8?B?NmhZci9iRkpLQXVhRThmTERUSkhvcG9EdVBHa2NsYnlxYXp1ZTBabkV6UERk?=
 =?utf-8?B?dStYa1VlVStYNFFIYmdKVmsyUHFBVEpTdnhzaGFQUGZsVjU4RklKUE0zZWhZ?=
 =?utf-8?B?QU1ITTI5KzIxL3FJcWRIVUVzK0FkNjNMdllwVWNUenJaWWcyanFVVjBZcG1O?=
 =?utf-8?B?R0xnMElQL01JcHROOXVoSW9RbmZOeGhCTll2TG11dC94K3hMRWQ0NnAxSGpV?=
 =?utf-8?B?bUZTWkxVQ01hRWdyUHUzSDdlek9NdnJOc3gxU1VrcG9mYzc3NmNGOGFVRWVZ?=
 =?utf-8?B?cGlKaG9sdW5ES3V3TTdteGxacStvblRoUEQva2lvYU5yMXpWYUZ5OE9SYlQw?=
 =?utf-8?B?a1dNbUJGeU1LTUdRWUtHUHVqMGs5ZEg5ZUI3cXZrMVVTU2VPL1hiVW9LZi9w?=
 =?utf-8?B?T2R3WDRHM2preHhHUTI4eDJyelFtcFAxSm9FakgzeWpUbExEZXdTY21ZcXhJ?=
 =?utf-8?B?Nm5sRDdHcjAvYjdHZVY3VDRXRVpoZVVQRERkcHlYcjlCbHlTZ2lVR2owZ2lh?=
 =?utf-8?B?dTVxK3duMG9WRUxYdU9PeEdVVFREQW91SHJtM1dSRVlBQXhmU1pubkFjM284?=
 =?utf-8?B?eUt3TWtITUw0SjV6ZEx3WWExNXhVQkNyQlZpZ1dFRFN5RjQvMUc2LzBqR1Uz?=
 =?utf-8?B?cXAralNJZmZ0bkRDZ1oxa2RlMXBaWWdseE9BaG95bnVuV1lpYkovbE9ZUEFJ?=
 =?utf-8?B?dENtL2ZlK3Fmb2FIOEZGdTFMQ3NiZnU0b1oxaTduM0ljNzltYTBVcm9uRzN3?=
 =?utf-8?B?blpMRWllNGNuTThPUVFGS3pRNkZDemh3UFlzZlFyRS90djd2T0MwMzdYY0Vh?=
 =?utf-8?B?UHgwY09VMDlvNHZJZVFsQjNwTXlIK1lxT3lNbTNsZVJJaHdZOHUrZnoyN1Rj?=
 =?utf-8?B?elBhTzh6K3NJZHUycjk0b2dlZ1dxNGlSK2JZVGdBdEtFRmxVeVNlTjVad1ly?=
 =?utf-8?B?MmwyRGpadHVHVmhsSGxoWVZ5T1FydGFXOGU1V2p0bmx0OSt3ZmJWOHJhSkFn?=
 =?utf-8?B?K21ZUzNPdmtGOEhJaHVnR21GS3RxZmp1VGJWc2pISnU0dUdrVXB5SE5rekVB?=
 =?utf-8?B?ZTlUYjhEdnhFTjVkSVcyc09oZWNvT1RaYzhpUnVDVEdaVHdrc2NGOUN0UXZo?=
 =?utf-8?B?UDVNMzRnejlNeHgxZVJPUFJLMzU4WkorUVNFenFvWU9tMy9JRUJvcjJ1TzhP?=
 =?utf-8?B?b28rU25leXZEWDFzOEVoT2lmVDRtdVg5bDRYV055VFE5RUpyVHVkTzVBVDRh?=
 =?utf-8?B?c1ZOajFlOFNDR2s4S2JadlgwdVVUWC8xTDArd1hlM29GMXdxMHNidXRlWkMw?=
 =?utf-8?B?ak9CK1B5c0o3dWQxVEZUMTJRcmJWQ1E5YmE3alZOdkZPWlp6NUp2YUZEQ1dI?=
 =?utf-8?B?NTBFQTNmK2xQd0RRZy9Td2JReitiRE1HSGcrZW5YNW5WRFlmd1hrM0dSb3dx?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c61919-d190-4828-259b-08ddcf83860b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 16:09:55.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omhd+he3fQdAQXOCkU91WMvwPVXnuZCtZ9zpcmFqprNrNMz27RfB92fFQWIs2nrNU3lQ+itmm/HKJiGWOnOk9Ni1pQA2UEGnfQIZ/v40frA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719
X-OriginatorOrg: intel.com

Koralahalli Channabasappa, Smita wrote:
[..]
> >   static int hmem_register_device(struct device *host, int target_nid,
> >   				const struct resource *res)
> >   {
> > +	struct dax_defer_work *work = dev_get_drvdata(host);
> >   	struct platform_device *pdev;
> >   	struct memregion_info info;
> >   	long id;
> > @@ -70,14 +106,21 @@ static int hmem_register_device(struct device *host, int target_nid,
> >   	if (IS_ENABLED(CONFIG_CXL_REGION) &&
> >   	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> >   			      IORES_DESC_CXL) != REGION_DISJOINT) {
> 
> I may be wrong here, but could this check fail?

It can fail, but for the case where ACPI0017 is present and CXL windows
exist, the failure cases would only be the extreme ones like OOM killer.

> While request_module() ensures that cxl_acpi and cxl_pci are requested
> for loading, it does not guarantee that either has completed
> initialization or that region enumeration (i.e add_cxl_resources())
> has finished by the time we reach this check.

No, outside of someone doing something silly like passing
"driver_async_probe=cxl_acpi" on the kernel command line then
request_module() will complete synchronously (btw, should close that
possibility off with PROBE_FORCE_SYNCHRONOUS).

When request_module() returns module_init() for the requested module
will have completed. ACPI devices will have been enumerated by this
point, so cxl_acpi_probe() will have also run by the time module_init()
completes.

> We also haven't called wait_for_device_probe() at this point, which is 
> typically used to block until all pending device probes are complete.

wait_for_device_probe() is only needed for async probing, deferred
probing, and dependent device probing. cxl_acpi is none of those cases.
ACPI devices are always enumerated before userspace is up, so the
initial driver attach can always assume to have completed in module_init
context.

wait_for_device_probe() is needed for cxl_pci attach because cxl_pci
attach is async and it creates dependent devices that fire off their own
module requests.

As I noted in the changelog MODULE_SOFTDEP() is not reliable for
ordering, but request_module() is reliable for ordering. We could go so
far as to have symbol dependencies to require module loading to succeed,
but I don't think that is needed here.

See that approach in the for-6.18/cxl-probe-order RFC branch for cxl_mem
and cxl_port:

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.18/cxl-probe-order

