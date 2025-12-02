Return-Path: <linux-fsdevel+bounces-70485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC9C9D31D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 23:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 741F54E43E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 22:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12502FABE1;
	Tue,  2 Dec 2025 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kszV0P6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B72F5339;
	Tue,  2 Dec 2025 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764713988; cv=fail; b=nRt/t7L0L3W7DgmIZ9LJqqV/ZruzqYla38OOOsHgBwR/kLTrzD1ANzj0+1JxIIXDTnTFBx8PN41RwXOHot/b2bgYRxZ5ljzDuknDD6stYM7zRiQmEenXESsbeWfTWf8InKsc3eiKj7Sy2zcRDOIxYzRWvji1gxrTzl+rJ8JN50A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764713988; c=relaxed/simple;
	bh=eeFAXQ7UWcvhl5xeshbbGLAq9MQAZ58pFbf/DiLrL9c=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=mpt0rSw5UoTVq2J5uXL2ZBkpeDnqI0kZ+cFqxDrtfFLR7359880naJ3NmWe/GP7M8x2WKC64a5K8tIXRevFR/NJNgbXWOdlNPdgBUg7EfeN9dLAXs1cZ6A0grIpktAUefwS+MGroEnwu1eRu9gZJ+QRt0OtBu22DfTl7GgUNcCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kszV0P6E; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764713984; x=1796249984;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=eeFAXQ7UWcvhl5xeshbbGLAq9MQAZ58pFbf/DiLrL9c=;
  b=kszV0P6EzimAbnwuX6it3+YXJHMvVgN7g6r16hjBNgZrAHLBI34xCb/m
   qtLNQYl9M1sTLrbtreOWLQHP/nFe+8aHzBzaBdnDDNFtzPVAIeVX7R+pn
   XO7kV/OcaekgzMcL7uafjShX3EbzQoK4K0HkuzT8uIkUP7zO8GW/RJj88
   H+Ygh6Bd7uSHEFPBqOZSZHbZohaLfSnWA15cqEtZMykhO8so0aeri4JgM
   fV2F6MDBwn1PAcL7b1HYxIdpXn8s/1FGPFq+bexM897qHBYolKi2eulEC
   By8Cf+dym57izvVWRPSDutdN68i25rPcbJ9RJnH0HAEKGjmx8czzRQadS
   w==;
X-CSE-ConnectionGUID: 9LXc8AArQp2H4hBtOaeAjQ==
X-CSE-MsgGUID: FYCsXVe9SkmYuCl8q21K1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84097111"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="84097111"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 14:19:33 -0800
X-CSE-ConnectionGUID: bMrZszbkRYmhSOzg+bB+vQ==
X-CSE-MsgGUID: d7pUUNGvQO+EZN5WKsbjRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="194491995"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 14:19:33 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 14:19:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 14:19:32 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 14:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx3i7grHJYJNVrWMk1hSicy4CbmydSr9Wt1bxQozO3KRpPSenBvReIWBdgwyDWglRfQarjavpnsnOiaPeDF9g3kON5uCJbBvCDQPyWzHsFQ4p+J4X7vb6fCw2GfpaIiy0ih/vrUMVSE3m1zacSFBoy6K25lGiZrltdcERJKz1ItlBSIj0VH7JD2R4dTPX1+kQEwThYb7rSK2bFHsEXM9Zk15KuSW3gCDB/9e9RSASds27p9oEHUwJfnyTuI8mLIXiZk0LmEylqPUCdq1mKpdUEwIwNt2cJTpqWlkVEG/9Yh5/WUqU6ReIxLmLn+xSrN0c156W1vW+8vuLo1SQNKLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5vNP+hnimRjdHgKqcgCDAVyXEJVhdF86O+1Suayq9A=;
 b=TdtfuWDmvwE6eFnzCVDB3PMDuZ3lmq7fuLn0U/vE5RkrhQ66QddpO7VyqhxxSzHp4ETp3dqhDNepKB66L2jVD3DDpxk7rhZipo1N3yIXSPZu6WZfrpJ4ptRaCFP+tHMK6U7hTyKAp8ldreiPGD38r78KMaO4FfeaeWe0rEefHY3fyzWZR3j5n4kmev1B/H6RwlFvurIlVqNJfHyQuwgpxy0Fuz/dv7QmGK9TrElQztDoeKNB6R2qfTBI6AEnrCYD3WEZG9ogUleOQSSWZCmr5nUAlc6BHvP8VQQYjJWZbhyiPy3tUbZcPzM1vsfk1TfHpJnOG9Px917ebAK37rFVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPFE99BD3AEE.namprd11.prod.outlook.com (2603:10b6:f:fc02::5d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 22:19:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 22:19:25 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 2 Dec 2025 14:19:24 -0800
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <692f65ecb5603_261c110090@dwillia2-mobl4.notmuch>
In-Reply-To: <20251120031925.87762-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-2-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v4 1/9] dax/hmem, e820, resource: Defer Soft Reserved
 insertion until hmem is ready
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPFE99BD3AEE:EE_
X-MS-Office365-Filtering-Correlation-Id: f2764ce9-68af-41c5-d97f-08de31f0da14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjR1enB6UEdnN21yeEpNeGFaR2Jiejl4VU9MTXVSZWZwV2xTbE1oendxZndz?=
 =?utf-8?B?bzlpYlpibXhNK3BGckNQd2VHK1dnZFI3WFVmWjRXRGg1K2lTZHRlVSs4S2Uw?=
 =?utf-8?B?SytzTnIzU2gyVFFhWHVCKy9hYW5hTW9hUG01Z2VQb2F4eEg3UVphZVNTRFVF?=
 =?utf-8?B?YXRxNW9WR0RXMjJoY3NCTDNWd3VpR1lKdDV5dm5DVW40eExJamlJV3ZOdk9s?=
 =?utf-8?B?R3lYOFg2elY2QzlYb1JFM3NXUXZTMDQzK2N0MWlOY2dEbTA5TEs1QVdTY2Vi?=
 =?utf-8?B?QWVLK3VISHZRaUtSSU1FaDBsUWJjYVNKWnBHaFBmdG9BT1JBS1lPKzdDQUY2?=
 =?utf-8?B?M1FZdVppUHJ4c1IrZW82VUdXaUJrYk1VdTNxcnJSbDh1ZmtybVdaaS80WnFZ?=
 =?utf-8?B?V1pTOENHdnBsZW12YkRqR0wwSHArdEJpU29GUmc4RzB6V3d2Z2JsWkZCN21C?=
 =?utf-8?B?REI1SmE0ZXd1SkVzYzN5czNBNlZjUGE4dzAvcXZwalhLSkdSQk9qeGd5UDlZ?=
 =?utf-8?B?cXAyZWJUd3JGVG5aM2xDWDY1WlNaa0l3MnNTamxacS9ZMlg3MytVVlI5UENj?=
 =?utf-8?B?ZmhKMjU1TWlYdnp0dzVvWkYyWFVhVUdzNEorbGh2TXNjcVIvcFFiMnE5a1Fa?=
 =?utf-8?B?cmhWSDFHM1RIZzZ4TXJ0T096SHhiMEgxaXNhNHRHcTBxNDlYbXN4TzdTR0Vx?=
 =?utf-8?B?amdBUW9KaCthWW9wNVlqMThLcXZKSjlZNWsxZnMrNmJSUHhoaG9NSXB3bytI?=
 =?utf-8?B?VXZvbXM1ZE1rTEdzbkJQU1h0WlBOcU8rNEVNcEFyV0RRZDRGVVE1dzcwOWlM?=
 =?utf-8?B?YzZtamFXRW1TblhYN0NrS2pkWkNTNG51L3luZkJlRk11RVlkUkp1NlNzcnRT?=
 =?utf-8?B?VmErNXJSYXZKend0aUFtblpVU3p3dlJyd0ZPOWF0NEpTTmQwNSt1OXlOL0tC?=
 =?utf-8?B?NEF4V1FKSGNZOWhqWEZyWW4yM0JBbkpFZ2ZYVThkNlB6ekFObllHM0tvQm0y?=
 =?utf-8?B?em9XelFIWUxtak9CVzlLem5LN2dOZTNiUEZSQVMyTEF0b1gwRXl4bGpnQUEx?=
 =?utf-8?B?c1RGU0NGQnVHVDdma1paNjNXaWxtbWNRbHZ4SlVyaXpFdlBabmhzSlkyYlZz?=
 =?utf-8?B?M2w1VExzUm1wMEJUc3dTYTFEUlQ3RTBDc1hibGlwVTgySnd4SUI1bnhSOTBN?=
 =?utf-8?B?U1RwM2xVOGZ1YU96ejhPdVB3QWpsUGJwZy9FYXhVbUJzbUVsNC9QV1h3YWln?=
 =?utf-8?B?S0Q3eXFjdjlEUXYyaXI3bXY0S3NkdFRkeFBEem01WkVHQlpTRk1zWnZjQTgx?=
 =?utf-8?B?bDIvOVRUak1nSkE4Smp5NXFYUGJlS3ZJNzNmTmpmM3VUN2FlWXNDUXlkbVJZ?=
 =?utf-8?B?MXhES3VkL1o1WFJRMVllNExCTTlEZUxJZ2F2R1ArK2ZQNzhDc28wQ1JrZ083?=
 =?utf-8?B?akM1bWdvdy82VG4ydWZoOFZsNUNqLzZvbTFxeExuZ0RLUnduN01jYmhLZzJz?=
 =?utf-8?B?LytJZE5jQ04wMmRRbG16ZDZ4R0xXMGNmWm9SRU9HdGtUNE5YVjRqTkxMWi80?=
 =?utf-8?B?Z3ZTOVlxek1QNFNTeTRkbmNKai9UdmVRV2dyLzFBVGlMSWxiUFRDVzdVeE1M?=
 =?utf-8?B?aGhzWDlxMzVjMmNlNFpQZU9XYThTUGRlL2ptclFmR0JNZ3Z3UDBXOGdNbGFM?=
 =?utf-8?B?TjkyaVVWRGVyODk2RS9kTlc5dWZRS1BHQWF4OGJ0am0rN1RxZHZvOTl5SW5C?=
 =?utf-8?B?Y1RuU0ZjR0ViUHg2NzR6NUUrZVpwcXprN3lmRW5yTW9ZUWRzcFM2T2pQdlky?=
 =?utf-8?B?VGVsa1RFUTRXd0tqZ1p0Wnh5SHZRWTczL3VyV1h4SW1GWjZlSTljYm5iTmRV?=
 =?utf-8?B?dFVhNUFpaXZzMU94NGlGN2pXeTBhUlRkYVVtQXhHbjlLSnh6ekZCK09GcW5n?=
 =?utf-8?Q?tSYVPVLAOZ0itu8yaVgDNkh9yJo1mZ0m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1KUndvQmI2RFNvYXJLTi85R2srenJOcDZoMjlKaVZqUHZHdEVMcFZGVHk5?=
 =?utf-8?B?VlBLQzM0TS9FWXdSckZER09hWlgvNzBDRzFMbXJBUXJVK3dPb0dVQU1RQ1Uv?=
 =?utf-8?B?dUdnOHRWMTlKYUd3bnhvMlhvQ01MdW9iUWhTU3V0eFRKSHV6VW14Z3lrei9H?=
 =?utf-8?B?MXdaWWxIRG0wencrTWxDRTQrQ1gvRmdMd2JoeDRnb2VHWS9VSXVjTkJWNnZn?=
 =?utf-8?B?WEVkZWxMQkY5aGozR0tKb2dSeDFwKys0UWJwWnEyUVNIdUxWVXY2Z1FHdVFP?=
 =?utf-8?B?aDRoZmlSalIzMFA1NG4xNVphdURjYWVLbWtEcWFTdlhwZnRCVHJFQXQ4TEk0?=
 =?utf-8?B?QXE5SXBaVVRrNDRIbGdkenkzRXNza1paZHh5dW9RT2JOSHRsY295bHlWSVFW?=
 =?utf-8?B?WE9TWFpUOVFDUkRDaWx3a0pYa2loU3l5REtOcjBzZHMraDgvVk8wa1c1aDEr?=
 =?utf-8?B?M1ZEenFZMENXZTJUbWp3SjdwNWk3SzBPUTRlaDZGYmwvaXU2eCs4U1U0RGgv?=
 =?utf-8?B?czVoQURsSU1nczFzbjZsUUlUYnNTVUlpalc1ZllpT1Q2UmdXWm5MYmVmcC9l?=
 =?utf-8?B?Z2tFSUdVTm40ZHZSZWlMREtlSjE0TWNyR3RxQ0V0Rk9kdEJ4QW1JTnR3UjEz?=
 =?utf-8?B?OFN4alNBS3VNaUJhUDVnT3VzT0F6L2s0Rm4yOFVvNmZTNlNlUlVGQkExaTMw?=
 =?utf-8?B?WVNFLzBMK2wvTUJoQTM0YmhQZzBmK1o5QWtYbW1jMUVsbXZXci9wbi96Y2Zy?=
 =?utf-8?B?NTBOZXUxaEJvWmkxWWdFNWNFbWE4VTRhOXNNTGJsR2g1aFV4L21LN1dKemFP?=
 =?utf-8?B?TDlXZCtFeGRjcUY4bGw3NWNxSVJEV1IwNkRrUktaMTc3L1RuYmZNcDdpdVBl?=
 =?utf-8?B?VWFWS0pkTmlLK3pWbm4ydEVQVWtWQ3J5aE90c2Q4bEtxeWdEcUV2R2ZlWVJz?=
 =?utf-8?B?enFUN1pDZXVvTVA3U01FajFsaUNxdEtsc2k0VloyN0VyYWtqdjdPdXM3Y0Ix?=
 =?utf-8?B?Qks4T0hxMUNkQzhFdCtzRTFIMnArbDl4NklRRWZrRUh6MmM3a1Uxa3h6UzlH?=
 =?utf-8?B?TmdUZG1rVERKQjhsVkdNcEFrbEtqb0dManpWUERVQnJiN3VydlRGL3VCQnRQ?=
 =?utf-8?B?ZnJ4UGthcTYwUy8xMUJTUENyamJ4QndzZlJqZS9HdnpObTM1RnJQeUQ1R2Nt?=
 =?utf-8?B?U3ZqUTgvT0xXczlRbERneTR1NC9Sd2hIK0s2aDlFalZEaDk3dUZVRklrTGVj?=
 =?utf-8?B?RjhVMnp0QXlpdnlwVjk3b2VOVUJKU3I0aTRocThhNHRMenFBU3dYNCtHTkND?=
 =?utf-8?B?S1FxL1FibHlWN2ordFFoZ3RFd2xDRkROcTYxMTlOYlNYYW15Rko3dkFnMEhD?=
 =?utf-8?B?dWlpOEpWTHozaWxKZ1RoSUE0cWFVS2I1L1RnNHY4cUEvNFFmSHdtRS9vRWc1?=
 =?utf-8?B?bjFmc0s0QW5FUUk3UThoTU5nQkhoV0k2UDgrZTluUk5hMWUwLzk5d2J3Vys3?=
 =?utf-8?B?ZDRmL21taUM2NWpRM1pxT2RkZkdWL3RYVXZjNEF2dFo2M0NmRk1YUkZ1aVAv?=
 =?utf-8?B?Rm11WDNSWXA1amxoMGNPYjZOamttV0k3V1d0aW84Y2xpeFMzQjZncy92OEpq?=
 =?utf-8?B?SzlUR2dodDZmM3EyKzZJR2RZbkRlQkFydUdWYWdKZ2tNNGpxaDNCbVBrVHJY?=
 =?utf-8?B?M0NVcDljNWp4V3k5T1Raa29qZXg3bEJTVlJ1UHdMMUNQSDFyOExZRU44aEZ6?=
 =?utf-8?B?U0NPWEk3bGRyK1RtbFgvQjdRZG4za2RsbjNYdFE0Lys5M0Iyc0RkOXRmV3l3?=
 =?utf-8?B?QUZCUXBjbHVtVUFhc0ZrQ3FueVZtdXArckI0L1hXckRNenViZ2JFN2tRWFRF?=
 =?utf-8?B?K3FMUmVqRk5YSis3UHB0bVRFdnZBZ240dVB0eFZoUkRla0dCZHkvK0E1RDlE?=
 =?utf-8?B?d0xjU1RkTS9XZWdFQitQWlQ4VkpvZjRRVndEbEk4Y2xjZTZQcjRmTndFVU1q?=
 =?utf-8?B?S2E1T2J5Yk9wU3cvV3MvQmM3UlNzaFpMUTFvNmg2R2c5YmU0M3JqeDJCcXF3?=
 =?utf-8?B?TDduTHJodmYyZTR2bUxCSEl6SHVXMDZIYWJXdGNNY3BPVFIzNjZyUjFDcGdE?=
 =?utf-8?B?b3pjQTJxemJRVnA2RUlDbnZOZGRlakFRMnZzdjBlME8xL21VWWRpWThucjFO?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2764ce9-68af-41c5-d97f-08de31f0da14
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 22:19:25.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zYcrLeFuLp3N8tj4ESdXjGd8Yvhr22uAFHkI9XdFQKLottjqXYm3lU/OBdVrCoeI/ZP+kh/wE3aIDIWVWuI+nvXr06SsHsQxTZQT2csCKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE99BD3AEE
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Insert Soft Reserved memory into a dedicated soft_reserve_resource tree
> instead of the iomem_resource tree at boot. Delay publishing these ranges
> into the iomem hierarchy until ownership is resolved and the HMEM path
> is ready to consume them.
> 
> Publishing Soft Reserved ranges into iomem too early conflicts with CXL
> hotplug and prevents region assembly when those ranges overlap CXL
> windows.
> 
> Follow up patches will reinsert Soft Reserved ranges into iomem after CXL
> window publication is complete and HMEM is ready to claim the memory. This
> provides a cleaner handoff between EFI-defined memory ranges and CXL
> resource management without trimming or deleting resources later.

Please, when you modify a patch from an original, add your
Co-developed-by: and clarify what you changed.

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  arch/x86/kernel/e820.c    |  2 +-
>  drivers/cxl/acpi.c        |  2 +-
>  drivers/dax/hmem/device.c |  4 +-
>  drivers/dax/hmem/hmem.c   |  7 ++-
>  include/linux/ioport.h    | 13 +++++-
>  kernel/resource.c         | 92 +++++++++++++++++++++++++++++++++------
>  6 files changed, 100 insertions(+), 20 deletions(-)
> 
[..]
> @@ -426,6 +443,26 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
>  }
>  EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
>  
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +struct resource soft_reserve_resource = {
> +	.name	= "Soft Reserved",
> +	.start	= 0,
> +	.end	= -1,
> +	.desc	= IORES_DESC_SOFT_RESERVED,
> +	.flags	= IORESOURCE_MEM,
> +};
> +EXPORT_SYMBOL_GPL(soft_reserve_resource);

It looks like one of the things you changed from my RFC was the addition
of walk_soft_reserve_res_desc() and region_intersects_soft_reserve().
With those APIs not only does this symbol not need to be exported, but
it also can be static / private to resource.c.

> +
> +int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
> +			       u64 start, u64 end, void *arg,
> +			       int (*func)(struct resource *, void *))
> +{
> +	return walk_res_desc(&soft_reserve_resource, start, end, flags, desc,
> +			     arg, func);
> +}
> +EXPORT_SYMBOL_GPL(walk_soft_reserve_res_desc);
> +#endif
> +
>  /*
>   * This function calls the @func callback against all memory ranges of type
>   * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
> @@ -648,6 +685,22 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>  }
>  EXPORT_SYMBOL_GPL(region_intersects);
>  
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +int region_intersects_soft_reserve(resource_size_t start, size_t size,
> +				   unsigned long flags, unsigned long desc)
> +{
> +	int ret;
> +
> +	read_lock(&resource_lock);
> +	ret = __region_intersects(&soft_reserve_resource, start, size, flags,
> +				  desc);
> +	read_unlock(&resource_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(region_intersects_soft_reserve);
> +#endif
> +
>  void __weak arch_remove_reservations(struct resource *avail)
>  {
>  }
> @@ -966,7 +1019,7 @@ EXPORT_SYMBOL_GPL(insert_resource);
>   * Insert a resource into the resource tree, possibly expanding it in order
>   * to make it encompass any conflicting resources.
>   */
> -void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
> +void __insert_resource_expand_to_fit(struct resource *root, struct resource *new)
>  {
>  	if (new->parent)
>  		return;
> @@ -997,7 +1050,20 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
>   * to use this interface. The former are built-in and only the latter,
>   * CXL, is a module.
>   */
> -EXPORT_SYMBOL_NS_GPL(insert_resource_expand_to_fit, "CXL");
> +EXPORT_SYMBOL_NS_GPL(__insert_resource_expand_to_fit, "CXL");
> +
> +void insert_resource_expand_to_fit(struct resource *new)
> +{
> +	struct resource *root = &iomem_resource;
> +
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +	if (new->desc == IORES_DESC_SOFT_RESERVED)
> +		root = &soft_reserve_resource;
> +#endif

I can not say I am entirely happy with this change, I would prefer to
avoid ifdef in C, and I would prefer not to break the legacy semantics
of this function, but it meets the spirit of the original RFC without
introducing a new insert_resource_late(). I assume review feedback
requested this?

> +	__insert_resource_expand_to_fit(root, new);
> +}
> +EXPORT_SYMBOL_GPL(insert_resource_expand_to_fit);

There are no consumers for this export, so it can be dropped.

