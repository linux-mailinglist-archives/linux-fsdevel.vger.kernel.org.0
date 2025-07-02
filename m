Return-Path: <linux-fsdevel+bounces-53746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B8DAF6661
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 01:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1877B00F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E25524168D;
	Wed,  2 Jul 2025 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5NYdCs/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8F2F42
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499943; cv=fail; b=G9IT5FLjNFlrGj4yMPGyKcOeOE3y4Kc9WLTgTZOT/8Rwsgvc3EkhgoFoq1+PZ+5VbiaQ3CQcEwmBegNN7MKmjwZictAv+n7svCXsY3H9iypHBkhZR3+jumEw8Fc9p12t6KlnBDWKH/ksDt/IXmx+YuOyFPzsYQMfdPTgfpcDZIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499943; c=relaxed/simple;
	bh=+SefkRxGJcQBp1dNud1S/XzXrN25Ev27RYnh6aPg/18=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HdogAUQUdguQMABgTbtBvAkppY2Bha9HYIIOeNHoFrjoSL7ou0ZM6zb4JpU9mjqcQ48K/FqjdWNopXfy8cdBcs2SfXU7H72/j+lJNfKS5PqBy8FlR+3U27tvLfwJchK7SFONzrWcy/8cGufHB3phoKM7Z6gRu9//g/FFxl6kv5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5NYdCs/; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751499941; x=1783035941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+SefkRxGJcQBp1dNud1S/XzXrN25Ev27RYnh6aPg/18=;
  b=n5NYdCs/yPQdEJ90OX6zEwnJKRA4zYK9G0HVvtjdaprLc/VuzWjlf8a8
   VDNqDbaer/FJinA8gCG56aiA+bp6nsOasAioVNm4O90FlOc21NoKbCc5Y
   BIw9Z6In+GTnj6rTYgMbpJ3Nu6cE0foRWHA6m2FihS9CO4aLrCAE1J74R
   azq5C4vzOjSZnpI4bKrrATk2UXftG97iv2V3qrpdU5UZcXwcWVuy6j39A
   SkkLjOUqmltpsaoEmSJ7UDTAqZwHdBqVHLkoHNhuhXNCddRfWiUi7cbuu
   Jzvaellp0Pf1VTW7AHnhZePcYKdubP4CpTIPcpWEe91r8KGbjhGTt1/0z
   w==;
X-CSE-ConnectionGUID: Z02GThkZRUKJCBDAOFBNWQ==
X-CSE-MsgGUID: 6mnFqidzSx++m7UtXPYVFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57489872"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="57489872"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 16:45:41 -0700
X-CSE-ConnectionGUID: TVwn56cLSLOGgfHeMMRaxg==
X-CSE-MsgGUID: 3kwCNbBBTay3+1dmHviRtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="153625247"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 16:45:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 16:45:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 16:45:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.43)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 16:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kgh1gYE8jXsj2PmAhiXC0ORxBZi7MaDEgKuQBosI+h7jTzHivzQ3YzCSPiYXZ0VS0lW2CygtzGGrhN5wGD1K+FLUgfYJ/KwiigyxiiwoKh5cpC41pU77bg1FRMBe/QfA5gTeaKYAZ1sGFOa2Crg+Jj/HItMNWax64HxTfsXYEp5cD9Qgb2FsmerXQ0nAD4I3yPf6I95FFFHc82vFuQ7c5CEEkTvwN+PtyBRzOl6KUHv67knsrDQtLosk/HrcB4wHi+dIhLWrobqO6YeTDx3ya0Ei1OXTL4y1S3YpH7KdJ3K3Og4jXMAskVNCtbJbphfIANPHiT2oOC+2NbpFMf3N0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2WzWyDohaRh1JjG1CRxcdS6k4lYNlA5pwz36RjDWTU=;
 b=Y1ylD8jBkw2qZfnvaabKMbjUeaKdyanv+SX2MHbyJ4Z/MoMqMgVRCH9mkAS6+dZn/FHfJK3arScbU0NIjSJUqDWjvc8NqxT9mEbDJ4Fx+GTRqBPCMamw9209PkZT3keKHbG9luYMFpAm+PW4T95xVs66IPFtssjEQxs1isI0P9PD7/Af1gH0t5kW39EdDqIIo9eEfkeyq6HbZKCplt0mBcmD96mRwbr1b1ARhqe9GOu/gtB+J/D3QJD3ZDIanEZTDud7KmheFtDJEEMYA9HF9I0xFuG7egaUDL3WXVkokEvTUOeHREBq/4GWYcZRg8atGF+P15zfK8ymPkMjxre9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 23:45:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 23:45:38 +0000
Message-ID: <36094bb2-5982-472b-b379-76986e0c159c@intel.com>
Date: Wed, 2 Jul 2025 16:45:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] resctrl: get rid of pointless
 debugfs_file_{get,put}()
To: "Luck, Tony" <tony.luck@intel.com>, Al Viro <viro@zeniv.linux.org.uk>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20250702211305.GE1880847@ZenIV> <20250702211408.GA3406663@ZenIV>
 <20250702211650.GD3406663@ZenIV> <aGWjig2vNfmtl-FZ@agluck-desk3>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <aGWjig2vNfmtl-FZ@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:303:dd::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e846fac-c74f-4f43-5637-08ddb9c28c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDI2TDBUSDZUYXFqZDBIM2dNRjFoYlFDcWxZdGQvNnArM3F3RVhzUVVDcGZx?=
 =?utf-8?B?cW93RGVRWnVRb2lCRkM1VytHRzlnUU91UGtDeUNZclFhUEI0ZlUyeW42b2oz?=
 =?utf-8?B?enhBZHFvNW9SbC9nZURQSlpVWUw2T3dwcis3SGp0WUdJQXo1V2NITDJ6Qmxy?=
 =?utf-8?B?L3I3c3h6NGw2OUdOaXdWQ25XRlpVZHFYZnpkTDc1aHhaT0M4RE44YkN5MTJY?=
 =?utf-8?B?NG1QQS96czFpZ084d2RVbGJoZlJISW1LOUFneklFK0N0N1BzbHRsY1JUSVJS?=
 =?utf-8?B?YmtYYTIxcmhmNGtxbzluTm1ZREtIN201YTZuUU9sQ09YVlRtSy8rbzFSR1A3?=
 =?utf-8?B?REpiUkVtYkVkUzQ4OFF4bWg2Y1BPSkhpUS9sMFNZL3l1SE1mdEVkc3gwcGVr?=
 =?utf-8?B?cEs5aFUwYUlYM0wrVkRrbFRZQlZaT0N3MDJvOFZTU25aaStlMFVzZDVLeEtD?=
 =?utf-8?B?Rm80cFFLTXZXay90QVV4SUhVT2tva3UyUzNGWnp0NWVqVHZsaGdtdTRnN3Ru?=
 =?utf-8?B?bFREVXZjdy9teStmcnoyTHdIM01TSUM0dmRtM0pBV2ZwMmZ6SkRsa3VjR01z?=
 =?utf-8?B?cmR5dUhYazYzaFRhWHRSTWtNaFV3cW0xMXNoSXREQVEyMnJPckRBcTBKQ21u?=
 =?utf-8?B?aStNWkJ3eHhpbjlQN3FEMEU1VlE2Yjh4WndsRjU5Q0NXdEZJcXVhdkswcDVF?=
 =?utf-8?B?eXV0bXNxd1FjTXhhL2Z5TktiRUFFb0xIM1VjbVphS3dGa3BzbzlTSFhhYjR0?=
 =?utf-8?B?Y2gzeTRCSzllaVVWeUVTd29FSW5OeStneHlZOGJFVGVCbC9HS296TjVCR0lD?=
 =?utf-8?B?U3hHZUJYK0s1RHVLYVlJcGwzOHpyOG0rSVpGRWNuMGRlQWE3N0RCQzFCNkxI?=
 =?utf-8?B?YmE1c3lDOGtTU2E1NzRzc2JtTVdLREloZytzNUN3NTZqT0p4Y3ptRHdFVkM3?=
 =?utf-8?B?bEg4eWRxbk0zMEFlaUh4aGx4N2ZKSmMyUlBjalRzYW1ZWkxRdXIvV0FoYTVv?=
 =?utf-8?B?b3FsSm1YRzZ2SFc1U2VQU3dnV2c2MDhMNXFxeitzbVl1UXVBZVFRUVYvMW9m?=
 =?utf-8?B?cGNOUXp5SjBuMHc0VVplb0hIZVpMaXA4NEJoUHppaHcrTGloQlhudnBKZFIz?=
 =?utf-8?B?T0w5cjRxZWs4TWhodG1MZXc3UlAzTzBKeVhBdHJlZmMzQUEwYUpYaFkwWXpt?=
 =?utf-8?B?dUZXRU84Z1VNMGhkdlZGYTZTQ3NRbENEenhIcHE1U1lEdTkrU0xjOEJwM2h6?=
 =?utf-8?B?QjUxa25KQitaYjFqVnRINkRBRWVQS2RMdDVDbXRocGpiZDREN0JQZmZjaDdE?=
 =?utf-8?B?aUhPRW1jU3VKSm50U0xaY3VMYlk1Nmk2MHpCZkJrR3QwNjZjMVptbmNXcFFs?=
 =?utf-8?B?VjJBa2N0VmZGajhxWitQcjJ1VzVBdHZzdnQ1L2l0T203OFBybkt3VmY2N1pQ?=
 =?utf-8?B?ajZ4RHoraTBQRXBaNnFrR0RJcVdwNFlBV2tNRTBhNWFiTmZoTHpURlljWnpJ?=
 =?utf-8?B?OHhwR1pwWW5Gck95dG9DYjNqeUdZN3FVOCtvQlNKcHhZekkrL1JhTFdFbk9n?=
 =?utf-8?B?bzZWcVROSnN4NXJTK2VENnJGVVVHSENFd2tRSHY3S2JLamo3YjZqbVRsSzVV?=
 =?utf-8?B?ZVZTeG9KZFd1RGl5MUpyeGVyakJaMGNFWHZMMis3eXQ2VjBGUEplYUN0ait3?=
 =?utf-8?B?VGZqcmhxbytUYml4UGVmd2RMdHFOM0xRVUNSNGRNOFJ1RUxoK2NsaEIra1Aw?=
 =?utf-8?B?TWl3bCs5WlJiNEQwanQ2SkFTY1g0UFNQMzJJQ05qYTl4dndTN29vTEZnS1Rz?=
 =?utf-8?B?VGp1NEZoamoxQjQvSXF1Nm04LzJEaXJKZ2hyMnJ2anRQZDd2UmJHb0dJZUFs?=
 =?utf-8?B?dlhndVNXdXFqNUs5S2taTzROMzUzSGIwSklaeit3VGxNYXl0QllxZXFURkxn?=
 =?utf-8?Q?kiP/90O3+vk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhNcVRINEpUZndHSVJtZ1dhQ3NYT0VneHBzK1c2c3JKSXVCZFVpellIRzhQ?=
 =?utf-8?B?MTJJUGRaSGtpVWNtU2N5dnZVenYvU2NWR2pSY2Mzb0N5eFhrRkRYd2h1K3li?=
 =?utf-8?B?KzhKdDdYRDYvdzhneGdZT0M0MWhCeWxYUWFSeGhpRUZxRWE1dUVIMlRaeFdN?=
 =?utf-8?B?N3I0andRV2d0WVpoNVU5WVV3VFJ0OEh1aXVydXNZMEFGVk1lL2gwNTN2cy9r?=
 =?utf-8?B?RnFWWWFyck5ZdW1TQ2UyYkpuelNFR2IwYkxMK3BHN0gxeGRRMk5MWkxoazQw?=
 =?utf-8?B?akxyV3FpaWxmMjZlbnh0aVhNejh3QkVKd3phN3c5MlczQU5Rek1md0Q5N2hL?=
 =?utf-8?B?ZkQzeVVmbGUxNHhjd1BKWTZYbENPTUE4SkVTQ0VRN0ZncWxWN2xLejB2ZFlJ?=
 =?utf-8?B?RzBNUEx0aWVkeG1qNXl6NzJVZVR3emJIM05DRHovZlFMSlh2cDNkaTEzbmhD?=
 =?utf-8?B?RVdhV3FkeXZEcnRDcGhCaXVwNnptb292ZjZOSThOZXYzeG0rNnpLVHFRamVi?=
 =?utf-8?B?bFFCQ21uWk9lR3pTY05qdGNzRWpXRW1jeEsrWnUrQ0lYUGtrdWFOT3dXZFo2?=
 =?utf-8?B?ajIyVk5tM2g4cGQ0dXE1Y3VPZVJGU3QrRER1YUNZSjNlYzU0SHhGK1UzS0Fu?=
 =?utf-8?B?aEQ2aU1wMDVkTzQrRkdRaGE4NEowOTFzSUlid08vbWZNZ216a29UaVNSUTBa?=
 =?utf-8?B?NGFxTUlYdHpqbVFqakR6VGcwQ0I0VWN3Z2JGMHVUOFloNytNcGZmc09ZSVRJ?=
 =?utf-8?B?d0c2MVF1N0VpZWdXN0ZvZHJrT0hzSmkzYUR2QUk1QyttQ3JrQkdpQkc1R3Vo?=
 =?utf-8?B?U0VGSXErR3BFbDFkQllvWjVNQ3BnY0treFlNcFF3QUJFK2dVdUtVaWxabU5s?=
 =?utf-8?B?N2dxTUJTOXhPYXFXVlpBV3UveC9nNmpRZzlHK21IajR0ZVhtSGtqZHJlK3Fw?=
 =?utf-8?B?RnQzYm5ocTJrV3NDUW1FSTc4cHRCQ3A2cURjMkV1Y01ZU0hPdUxQRnJTbU5w?=
 =?utf-8?B?SkNOZ2hGV0dlZzNEb0hYOGs3WEtPWG1MTGMxanY1bmQ5NjVvdS9JVzBwTUp2?=
 =?utf-8?B?d2gzT1pmU2lmNlBkVU1NOWVYV3ArNlN2aWV2NC9hMjZnZ0NaOENEYlUwcmg4?=
 =?utf-8?B?aVNJMGh3VmFPd1F3aXplTWxIVGVDdlM1MDhrZFQvOEp0Z09hMEorRS9wWE9h?=
 =?utf-8?B?MTdlTStlbTZobVlwQXpzN3lyQXVhWXY0d21HYmk2MWRMREt3eUp3bjRqbkRv?=
 =?utf-8?B?SWJGUFBiSWtqaTdmRHR6QVBpRmxwNjR5N1VKcUY4cVNLbmV6UXZWWnM0NUd0?=
 =?utf-8?B?bmxPUUlad1gwVXgrM25JVnBXR3VqcUkvWU45cVYrMTl6L0VsVkZXWjZJWTYw?=
 =?utf-8?B?SkxocW5LZVgvVHFmL3ZLcEVqRkw0ZFVRRnJUeXZPSG9nd1RLVEM0Sys3Vlhk?=
 =?utf-8?B?MCtlYnpQa1VUajNFYTVZSm1DZ2VMSFVoZW9yVlR3ZjVadjdiWTk5bS9vUlRs?=
 =?utf-8?B?ODEyeldBMnJHTjRPNWZQUHJvemlmZmpXOE5jSkRaQ0s1elhuaCt5djVCMW1u?=
 =?utf-8?B?c083aGpZcFIzUEI4dy9XRXZlY0NMWFdxMGVoc1RCWFlrdHpUaHNqWmhjOTFa?=
 =?utf-8?B?UXhDcXpWTGpEendVRGpCN0JDMjFaOUZ3WmxNS3hrRk1qVzFpQ0E1K0NNcGFF?=
 =?utf-8?B?SU9ybHBTTHNRT3pJbHBqb094RVJWbnI3Z09zOHhvUnhpOVZPZW43ZGkrNmoy?=
 =?utf-8?B?aGw4UEtHYlRtRFFPOThmNnYrdmpxZGpxQjZyMkVLMDA1bWs2VlBVTzBEdE4z?=
 =?utf-8?B?a3p0Z0NMVHhqcWgxMGdBcnJBYmNQNWNhUVVjTDVDOWY4eTlBSy9IRThsMzlJ?=
 =?utf-8?B?aUlzNTZJcnZhb1VjckMwYW4zNmFUa1ZucnZSeUROYTJ0V1ZKVUVqNEdDeDBJ?=
 =?utf-8?B?dlRJNTE4M01IeVQyWVVhSHlRTm1hQlRhZG1lTTFYQklDdUlMTDllU1RyV1d1?=
 =?utf-8?B?YjRzdFNoMkZibVFFTXlXSkxjanA0T1g2T25UK2RndUpCZVB1NS80NFlpQ0RW?=
 =?utf-8?B?TnI0MFhpTnI3UkpRa21XdDV1UU1QY1haYnJtOTNReDIzek1TVHFEQUJNRjhq?=
 =?utf-8?B?UW1GU0Q1UnpFWFQ5T0orQTBHUncwa2xMRk5VV0dPaUI0dEx2YmgzTUw0bDdy?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e846fac-c74f-4f43-5637-08ddb9c28c09
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:45:38.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hybN9xUyL4kWbOBSTlrhX0ujKIy1xebskJF6Qeukv4SURGf5vpESo9C68ScpwhzJwx65hGgv0z+/RgZF3UNHMwCbK7QMtyZcl0y0hmSY7wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6792
X-OriginatorOrg: intel.com



On 7/2/25 2:24 PM, Luck, Tony wrote:
> On Wed, Jul 02, 2025 at 10:16:50PM +0100, Al Viro wrote:
> 
> +Reinette

Thank you Tony.

> 
>> ->write() of file_operations that gets used only via debugfs_create_file()
>> is called only under debugfs_file_get()
>>
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> ---
>>  fs/resctrl/pseudo_lock.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
>> index ccc2f9213b4b..87bbc2605de1 100644
>> --- a/fs/resctrl/pseudo_lock.c
>> +++ b/fs/resctrl/pseudo_lock.c
>> @@ -764,13 +764,9 @@ static ssize_t pseudo_lock_measure_trigger(struct file *file,
>>  	if (ret == 0) {
>>  		if (sel != 1 && sel != 2 && sel != 3)
>>  			return -EINVAL;
>> -		ret = debugfs_file_get(file->f_path.dentry);
>> -		if (ret)
>> -			return ret;
>>  		ret = pseudo_lock_measure_cycles(rdtgrp, sel);
>>  		if (ret == 0)
>>  			ret = count;
>> -		debugfs_file_put(file->f_path.dentry);
>>  	}
>>  
>>  	return ret;
>> -- 
>> 2.39.5
>>

Thank you very much for catching and fixing this Al.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

How are the patches from this series expected to flow upstream?
resctrl changes usually flow upstream via tip. Would you be ok if
I pick just this patch and route it via tip or would you prefer to
keep it with this series? At this time I do not anticipate
any conflicts if this patch goes upstream via other FS changes during
this cycle.

Reinette


