Return-Path: <linux-fsdevel+bounces-70436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A349FC9A5A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 07:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D31C4E2532
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 06:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473293016EE;
	Tue,  2 Dec 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGSR+ybs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35681245019;
	Tue,  2 Dec 2025 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657682; cv=fail; b=OBbg5R/mQ2Hz77b/TXx7XkDA2oQAvOqdo0yX+TCQSC2vu3gB4QLq1k4Exf1rHXUEusyR8AhEuWzRIh+/GB7ZZIJFSptnSTY2E4tCPJnRT3n5JX1SkcGvc/CxyBgvk1ltrbHrYo9sn1+JQSkL9S5h4D9QYyzOuooduj/pKCcBI7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657682; c=relaxed/simple;
	bh=4fSnmamSVAIaLYiDcZcrAZjRgn0lhsFq1Y4EQtTCHH4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=u4J5fxUQA63wODO/QnOnrv8sZa18qNXjJXm46Y1PscIqTFUK/6Uuu3X8y/Dy96SPyTnB3xJN5z+LA6wSD4/xUWYizk5XsB1kBUgGsoelW0C9JKsZBuP7XbTrRCjWR90aSiMjTpTIfxj2KiNWDkGOW9P6BD6ZqKX7yHFXdxPqDZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGSR+ybs; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764657680; x=1796193680;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=4fSnmamSVAIaLYiDcZcrAZjRgn0lhsFq1Y4EQtTCHH4=;
  b=RGSR+ybswELiog6fmtnewAVH+ycrFHD8+SD/szajwc78ivz4uBYwxXUc
   kLl6YkUnxPQw5rY8ByeyfcwA2tD5IIw7LB9L5SsA8fsF95YEj2BUlMZmM
   ls9xOXkNP6WMo5FZgskiHi5e81pUMSXB0Suag/kgVihapiCQv/kV2rCg5
   z11srV3dVKGpcWBaTNiG9nVp6fuf1h1KdPD/r8/oKIb9jqj1voVCp2ulo
   /+ryDOsdYD1V37tqgcXZPnOWn9ezu0wApD/p5isIebUL/LiuSvKyWtKWs
   IcWVzD26HL1DIS4j4nPNuW6Vwa2/sCO40LRpjVgGyh9LmMwOZFGqDnaSQ
   g==;
X-CSE-ConnectionGUID: Y/vQWxsFRz23GYZe0puhHg==
X-CSE-MsgGUID: apLLYYbSRAqPBW9DTRX8pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66688887"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="66688887"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 22:41:18 -0800
X-CSE-ConnectionGUID: sxE7gXV1TFGpeAdNmTy6BQ==
X-CSE-MsgGUID: lLhE/hXlQuGoO2YbWidYTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="194505802"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 22:41:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 22:41:18 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 22:41:17 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 22:41:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z55xqnenO3vJprw3Une23egTT91luPdfpiSPaNpjkWQl136FK+YSH90SRaVQu9gxm6Q/mQxKQgOhbZVJvdfoTDwtATJu4zLLlQN1XnrYq9Dj5w2jTNzJLjVR6xAiWWfiw2PQL43MEIPgn4lU0uS5mVRf49UGy2NTVZZRAxZbNEvd3vj/jyVDfKTrTzzFGjm0c5MUEeLAaGICPrQD8KwTrAnJy2H67iSgy8i/UJnt2uJhfh+8m9xRVqt3HP6TJl6tIgk/Y0erzLh7whP8YqLkNQAhWpawZQ5fWH6GhZSDmbUP8otUmKsbH9GuNt9tLzr4hqePwdOmZ2voIH5S2ac39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fSnmamSVAIaLYiDcZcrAZjRgn0lhsFq1Y4EQtTCHH4=;
 b=tHZDBOHAHZEWjijtZSH5l80jluai7wSVVFTFWYKA0SH9Bv0loEZl9fFcJZOpjj4fCnDNJLEtpMkF54F1DTQS99zQTavfPvFol2Z8D9TDSxwJ6dqHskYgQQZ8WUb2uPRH1tSC5IN3SAcHm+/oWJ/KdXrW+s3vwjbibDbFWeQyv3eJjYrl+vmL+wckZiqx1wY3QAQUFG373Dpq60jZl+5rc8y9oOE3xhO7t0utYPrt1cfI7N0knejECjtCz1NTT1+yLbwOy/ocuUceinYWhMRReQCScRyYiPYxwT3PgsY6gtX/iUpLLzsY233L9YRC/Wesbv5Yw2eiWr/PXB6wy5tiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 2 Dec
 2025 06:41:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:41:10 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 1 Dec 2025 22:41:09 -0800
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
Message-ID: <692e8a05435a1_19811009a@dwillia2-mobl4.notmuch>
In-Reply-To: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v4 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eed97d6-a56e-4039-44f7-08de316dc79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFlXUDJDd2VTSkY1TFV1WkNiZmE0UlV2NzljTUV2bmFQTURhbk0yVjQ3ZWxi?=
 =?utf-8?B?Y0tlMXltbWhBNEtrM0NWbks0MmdOb0hlN2VVNkY3SHI1RDUxSXNJM2w4aUpR?=
 =?utf-8?B?UTVqMjN2dVhod3hocXB0V1lZNVBhT1NlSTc3cnRiejUyL3U2dXJVd2hnSjBI?=
 =?utf-8?B?T2JRL2xmbHhieUQrS0IrOEVzVFE1VXhra0lHUkNZWTlDZTBZQW1pOUFFWGFM?=
 =?utf-8?B?RXBKbmExQys1N0xQL2pkSW14SWFPUDNiK3k0SE5ZWHNRbzZhQUJGTVRkVG1o?=
 =?utf-8?B?ZU5qYUVTVy9pU0M5TWIvWVQ4elQ4WGlIN3ZiSFRCQjNYRWpXREFBOTRQb2Zs?=
 =?utf-8?B?M3JLL2xBcWMxNU5aSGNYVURNcEdJNExYVTJDYkRWZFpnWGt0eXZuUVlwYjlo?=
 =?utf-8?B?OTVIaWYyMTYzTEY5UEhjTU4rOVFTV09ab3RGUDM0RVBScDdFOXl2ZnBjSVFO?=
 =?utf-8?B?STJSelNRSkd6VWIyQUVSZ3lMY2ljN2w2bXJjamlvSzNhTjZkM0k2dXlkY3JE?=
 =?utf-8?B?ek1TQ3dVd0lTcVVaelZZdm5MNzVFRTRXaXU2ZTYzd0MzYWkxY3FYcWliWDlp?=
 =?utf-8?B?ZzA2dWtNM2NIZkJ0YmprcllWVHdlb2JLZ051NUcxS0RPcC9TQUhmczJlR05D?=
 =?utf-8?B?UERTYXZTWlFYVml4Z1NQS1NaTGw2dW8yQ1pVUUI1TlRJQTdmY1ZVSTBPdVJX?=
 =?utf-8?B?ck9RMlNVd0dtK1p0Sk5LS0NnUk04aGtaNzduRXYwenFKQTFlOHdFbzF2OU1L?=
 =?utf-8?B?dDFraHpROEozUFBLS01tWkl6ZVdGUzUyRENNemRCVktKTXVCcjlQaGNpNzRJ?=
 =?utf-8?B?RllIdFgvMXdLTnhnTUdrdUNNd1lHY2x0VkYyR1VMcU1MWDhzaGVuTGplRVRN?=
 =?utf-8?B?aWdLbTh5bW50Y2JoZHN1anBTc21PM0tCVldjNWovNmdGSnZSUlpmSTJrVVdM?=
 =?utf-8?B?aXVhYUp6cG1GSWJpdE9JYXBUQ09wN3RGWlIzSldpakw2ZVBlaWI4Z3p6My85?=
 =?utf-8?B?dnlCc3FKeDZrYW1Od1pkaXlIelpaMjFhR3l6WVBVa2lSeGlYL2ZDU1BDbjkw?=
 =?utf-8?B?WG82U0Q4ZXppOHhGMnA1N1BPV1hTcTBveFVhdDVaYTJqSzVMNmRkd1ZORGVB?=
 =?utf-8?B?S0Q1Q1BDOWtoOG1ScEcvbjhpa3Z6dkxEeSt1Qnp2cWxqYjcvNU4yQUo1MVZD?=
 =?utf-8?B?VUlWelJHWExYd255ZWZNOWdhTnNqck9JQ3h0dXZGUWphUElDVGFqTkNEK0ZF?=
 =?utf-8?B?S1pNbHZLalpVbUJHdlQyVlp0MExpVCthY0t2bFFmRXZzZTV4OCtTQWpzQ1FP?=
 =?utf-8?B?WWdMcEtsRGtGMW5JQVRRdjd0OWJrMCsvSkpTcVNLd3FLK1lQVTF1UVRtTTNo?=
 =?utf-8?B?WlhaZmNoWk1YTmJVb2J4bUppREdxUmRpU2tBZWpucVVNSHlkM0taemgrNzFM?=
 =?utf-8?B?TnUvcmV6V3R0N1FnQ1RWcjNJdzZJazZjTUppL3FlWURiMjZPSlF2MldzVE5s?=
 =?utf-8?B?Nkg0UWNLL1QyTTRsam1GV2VZWXlmcG5IVFZOT2RNUHk5M1NzWkdVbnZSSlNX?=
 =?utf-8?B?UUZXWjNxdGlZNUNpV1hXaGI0VHh5Nmw3dGVsVWgxRWlZaTBqSnBUZEV6anNa?=
 =?utf-8?B?NTdSOHA3UWZwR0Q1dmJMZ0gxWU1yd1FvZjgvbS9TZU83bnJtZ2NlMFQ3WXlw?=
 =?utf-8?B?V2p5NmNpKzVUTkRqLy9ud1lHUUlrL3I2WmoxMkl2SmppT2pzeUdmOVVQQTFh?=
 =?utf-8?B?aW5QaVZPMVFlOE93ckdtOWtoMTJmV3FGNUptWXJDeWlsSklGMEpJb0FUZzR1?=
 =?utf-8?B?ZXE1MVJrVnYvT1ZvWlhNOEN4TjB1WUQyKzE1MlM2REt0ZUhidFFSNDJteDYz?=
 =?utf-8?B?amNBNXFpbjRRbnNlRG5hVXpMWWFHeCtBK1Y3eVFiMkZ0MWFLeXVKNHl5REQ0?=
 =?utf-8?Q?/yzd6BUX3ZsmhiwgeHWv771E9etGyY+A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0RKOFd5OFRRdFFUdmthcDVTWjI1UGdkUHhDWk1HSml2SGRBTUdQZHVSSVFG?=
 =?utf-8?B?RmU0V3RoWjBhSXIvQ2lsT2ZDeTVwQkJLTHZxN3c3R3htOENoMmEvNFJFQ3FO?=
 =?utf-8?B?eEdPcnFmZUpxUWpaaHZ4bUE4SUw4eXZMYS8yVGNtY1Y1UVJhWEVpMS94N3lO?=
 =?utf-8?B?RU5wZDJHSnNJT3BBTWppZEM2YmY1TmhpaWJabGVhSjM4clFYS3A3N0kvRFdW?=
 =?utf-8?B?RWdxUjV6c3VjVjBHVkVUaEdXMVY4eEtXeXVNYmtZRmpxUUR1Q2ptTTliNEVN?=
 =?utf-8?B?QTlSZG1KdTRXQmZWOEh2VVc0VCtGYXBMYmFHM3duOGY4eXBXT096c1B2cmxH?=
 =?utf-8?B?bGVYTlcyRktiR2pZMDJMc09rNjBLNlo4TElHdmVWM3RTWVQ5eEN5aC9OS3o0?=
 =?utf-8?B?eUNRbG9hWno4aDhycjdVUFd2THJEYlpOS1hFZ3laNmtsTzdaWVUxWTdrYlpv?=
 =?utf-8?B?ZHU1Q0FHcDlZeXdPWnM5Z0tSSFB1MTNXT2pHSXRUd3JCUUw1SU5zWFhZZklj?=
 =?utf-8?B?YjBHckVLUmtFWnZaSlNybkx0cWZESnVIa1A4U09lN2dabkUvY1BGRjhpWWFs?=
 =?utf-8?B?b1FTdUZsVGJLdXNnc3FLbnZoTXAyQjYwcUtoU0wwWWplU0QxVlpZUGxYNDE1?=
 =?utf-8?B?Mm50bXV2TEI0NXNOSjNtVkVMd2ptd2k0d1pkSWFkRCt0NXNyTmIxbVVYODF2?=
 =?utf-8?B?clUvd3V4Tm9LRlBTU2pDWUkrcktMNjh6bUZSQ29ZVVJOOWNuc0llQ2hDK2Rr?=
 =?utf-8?B?czU5cU1EdlVRQXpnUEt1Q21RZXR3TUpEZW1va0Z3S2ljNldoYjRYM0JLLzho?=
 =?utf-8?B?cmlPNmNZZHhRZ0NrZm5KYlBlNXVLQ0NHSE44aHI0SEErZnRybEFzYnlTL3hv?=
 =?utf-8?B?SDdIN0gyL1htWVd4clJlOHd5S0dxZzBLMXFRNXBzYTFvcGtFRC8vMWIxbkhj?=
 =?utf-8?B?T04xRldzNUtaWWsyU2xrK0J4bUdDdWJubVVxeFNja045Q0xFUFQ2elQ5aE9y?=
 =?utf-8?B?aEIwcnM1akdYQ3lzN3Z4T1gydjVLMEYvY3ZBdVAvRWo1bXcvNlRFS1RqaG9X?=
 =?utf-8?B?K0haZnR5WUVqMEVlUjhWWGg1a1JwNlRjVm8rUHBFMDV2STM3N1l5cWNSM0NB?=
 =?utf-8?B?Zmo1cTZUZEVTNHJOYTRYS2RWQXNsVkpOUlVtaXBWeHhnSlNFVlVUcmw0YUpn?=
 =?utf-8?B?Rk9OV3dEUTZaRlE3NlFIa0JTcXhLczBwMFZrMm5ESzcwWTRrQkVrcHZXbUNh?=
 =?utf-8?B?c2xTT3lMVHgvODdQcDhDbExvMjlXaHRMMG9aeWZXWEhuK2J0QUJSbFFkbXU5?=
 =?utf-8?B?dWJNWXh5dDkyTHl4dnlxWG5SSkpXcXUrblJCc3NiY2dTWnJwTjZkMkhLQTlB?=
 =?utf-8?B?dDFYOXFRK3ZTMy9kK2NybUxzRk9sZUliTURqMVdsb0FnUVJoUy9pdEZGczBz?=
 =?utf-8?B?U1VXR0EvQzFrRzJkSjdiUHAwYUdMZk0vY3RMelF5NUZZdmcza0p3RjNxczk4?=
 =?utf-8?B?YitVMzFsMno0b1lLczgzRXlZTnlpOWJsZDZwZWw4WDFDdkVKZWFRSEZ5N29S?=
 =?utf-8?B?OW9LNDFjNlVVdVJTN21XVWwvLzQ1R21HZzgxSkpTRGVIbUhTRlYwQVpMUkZm?=
 =?utf-8?B?NFhGNXlyei84M040VmRWZU9IMEs5OE55ZEJYY3VzZTdPWWhLTURyZjRpVkxE?=
 =?utf-8?B?Z2hnWkhWaDdLUnpVTlpXcTRQWkNiajRLRzd4T3owMEMxQ2NzeG9ONGs1U0JF?=
 =?utf-8?B?Q0o1K0pJM1ZFTUMzdEZpRXB2a2lDZXAvSS9Ud1IvWjA0R2NMbjBaNGE4eHNU?=
 =?utf-8?B?bjM1NWhmeEROVWRIZEFMaUEzNGh2bDlYWmtJUWRQWVJ2QTVldGR5WFBzVmgv?=
 =?utf-8?B?MjYydnVCV2JmZ2pkTzlBdzBoTDNGYjNMa1ZFcnRhU1pjVU50eERGbzJMamFD?=
 =?utf-8?B?QU5tSUd0N3FOTVYzM2lXL2RCTXlzNHNySlZjdzNWRHZSS0hCYmF2SFNOM1lq?=
 =?utf-8?B?dEVVdDAzY21idjdMcFNyWkhsc1BXVWpEcXNJMjZBUlh5ZWdDSHRhMDV4L3lD?=
 =?utf-8?B?SnRhTHd6SkpYNFNzaG9mbEs0QnpZUVhTeDhlWWlWcnZ1Vm53VEpXc09YZnBD?=
 =?utf-8?B?eVRwNDZrdUQ4OG42aVlWTHhWR2VrcmRzem45NnlHWWlBWnVFWVo1dFlvck9Z?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eed97d6-a56e-4039-44f7-08de316dc79d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:41:10.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFUDqvqAxLFLghRbCXTEH5Y2mpYas8cDUgDbGS9DUhkI/+UkBPGveDNALGvfe2v+sSzYj8onY7VefHzTgpavFepjgKW3Fy0q0BoOrwIwGkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
[..]
> I initially tried picking up the three probe ordering patches from v20/v21
> of Type 2 support, but I hit a NULL pointer dereference in
> devm_cxl_add_memdev() and cycle dependency with all patches so I left
> them out for now.

No, we need to get those baseline patches in, there is no ability to
detect an sync point for "all CXL devices present at boot have had a
chance to probe" without the synchronous registration changes.

I will push a branch with finished patches rather than RFC quality, and
you can build from there. The order of the series should be Sync Probe
changes, DAX HMEM, protocol error series, Type-2.

