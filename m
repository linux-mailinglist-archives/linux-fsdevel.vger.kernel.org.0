Return-Path: <linux-fsdevel+bounces-51699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B319BADA551
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 03:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C557E188EF7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 01:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F61A16A395;
	Mon, 16 Jun 2025 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qujyGwuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C79F9E8;
	Mon, 16 Jun 2025 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750035723; cv=fail; b=jnnS+40JXTfFYOHUIvg8dhTgJBp6dptzts1Xf6y1b1LDewmhj52EyRtQi9HzXMlc+UNpaQbA6yQ3BtMmBnQOuqtFZJ6Y3kSXyDQtD2PwVJxGV0mlVBo+9gwKQo75qvoQA0rc3qTEAgMFKIsyXqOAZclMkoTKdQtVg+C97SvBxfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750035723; c=relaxed/simple;
	bh=IXJN0u5ALELcgIpZ1mlzOt56U4GGFRLxba5T7eQ847Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Km96CRbQNOkVM2sScrlCaOVPSHVUJwbPcnsMlZT2OAraryuw4AQIVv5HR8fDpYcZxoy1JdpcF5DiptvOBePBthMvKcq6viT4T97qEo2Y/806MdHv32mvfBVjJQjQn8MGIBAKJb8Bb1d9mIgjjRmhkEyUPWOxth+nAGk7IVvu/dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qujyGwuQ; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1750035722; x=1781571722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IXJN0u5ALELcgIpZ1mlzOt56U4GGFRLxba5T7eQ847Q=;
  b=qujyGwuQiul959DZudtUZvMJjID7l14z1OBa8q8ArcMq2iI8gCZRKaF5
   t+NYokt7cB7tCVFKiTqE/FFwRvoW98TvZkLlZnYBouA+yXD3McpNJRheG
   jbacdX5nESoOfRNMI/6lEY3kPUWbl86AsPrCD4kjhFBiDxksq2ZJXy7q9
   z+skRFDFdL042SSKKdzf8But3ZI58zSZ1iQs7NQDX27kRR2kbAyvqa32m
   +VGpC7OWn3dcvJc/YYHthw+cvMtV+teWWaTf+NR+M2I8903qCxpyGHxQ6
   zm0nXxCGoMTUE6wBDzbsyeZkDb65SPJrcqxf+WmRO5Nng97Qfs925OhEa
   Q==;
X-CSE-ConnectionGUID: AzAj1cPvRlCBmuY4LgVsHg==
X-CSE-MsgGUID: VJp1Za/mSqm25z+C1duhOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="158669963"
X-IronPort-AV: E=Sophos;i="6.16,240,1744038000"; 
   d="scan'208";a="158669963"
Received: from mail-japanwestazon11011037.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.37])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 10:00:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyhj6dObU7PONavKVbNYQPgSLR5cUcZ7hbxOTgLEPyRHUnkBQMa0ATA8a5xVrPP4sIxyfLs9ljWTZ4HSLw3bpZQ7hYr/SLMUBVO7aCl6/SbfWxgSHzUXDv4/GC/nfouExyzWm8s6LOqoLsAuZlgC2YNnFSWCVNXNWmR1Y02lvkGVcwOpjAvD8VRbN1Lxl1hQGEU9eukOHcLWUQqBrHig4Bo64JvvEnxTaSZOWYpnb7Rcbont41kjumnwZSfcgtjtxB2BLvlt8oQhsFhpXI9t1QBLxIxJ3mHnrNQSLJSNjEem+zf6ZbjqkzX991euAjIrVOqVx2c0YTLICYTHtNtSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXJN0u5ALELcgIpZ1mlzOt56U4GGFRLxba5T7eQ847Q=;
 b=oLW5ru80iHUB6zpaCn1n1Z02Kl3gZr0Tw0+pyZFheyI+sztj2FLdAjF9hbIZbFB3yyNsJEr2w6FZQmffUt+8hVdJmEVW1dmn64NbI/NdLmBde9D1KFBavA/B3sH4VF9dzVN8auEl8tOuUepqd3Gz/UhThxI77h6iED5KlspqsI7TBcExvDSGWIc6U2yzwFwDXX8utE6woeHWktEq+IoJVoBL7HOiNynmeARuCRmWKYVB0vI8kAfC+jZsVZZTX58Ld4+8dN0wkgOiY1xOEepgjbpsQ6fzbJ2GdU3Eon89R+r2mjiBQFl5UbAUjMv9EMH6BCXJXiHdlAD+9OWHtmY7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com (2603:1096:604:3a3::6)
 by TYWPR01MB11218.jpnprd01.prod.outlook.com (2603:1096:400:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 01:00:39 +0000
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0]) by OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0%6]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 01:00:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 0/7] Add managed SOFT RESERVE resource handling
Thread-Topic: [PATCH v4 0/7] Add managed SOFT RESERVE resource handling
Thread-Index: AQHb1NWu79RVwSqVXEulodtbceqNDLPyr7WAgACsSgCAEa54AA==
Date: Mon, 16 Jun 2025 01:00:38 +0000
Message-ID: <e4f6c5ec-a91e-4396-b13a-aaf30d895ac5@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <a1735579-82ef-4af7-b52d-52fe2d35483c@fujitsu.com>
 <4aefad72-e8f3-4ad9-9f8f-fc32612358a0@amd.com>
In-Reply-To: <4aefad72-e8f3-4ad9-9f8f-fc32612358a0@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14468:EE_|TYWPR01MB11218:EE_
x-ms-office365-filtering-correlation-id: f1b269bc-62ec-44c8-a972-08ddac713580
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2hzR3JYb21QbkE0alVDTG1SY28xanFaanlsRzBjN21GWmUwUnBqaFNHa2dU?=
 =?utf-8?B?M0ZEdUN3K2VIWVNlNEVxNkpiV3RPbFA0RW5TZHJsc3dlZ05MM3RhQ0JrSktz?=
 =?utf-8?B?Y25HdTBKTkNZMHNabnhEdnA4TUVGOXpScjlQbTBJYkJMTm1XbkdKdGtPYVRw?=
 =?utf-8?B?VWU5Undnd0g5NWhnK0JzNklzTVk0dHN0QUNsc2kvc2RNUzR6RldXd1JwZ21w?=
 =?utf-8?B?V0pncTgyQ1NZaHRtbUhZSldhSWZQNy9aQXQ1RjRRdDhNWEpKMVU1bm1Ca2Rq?=
 =?utf-8?B?U01YZHhGU0d0WnB6aEJFRzZ2MnpGWVY1cXFWZThmRTY4MTZEa3VOWVEzVjdx?=
 =?utf-8?B?ZW90ekhXR1VSai9ibDRxVDV0dDY1RWRyanBHLzYxT0ZYSXR0dnM0RnNoS2J2?=
 =?utf-8?B?aVMzaEtoZW8xc21aTFZqZTlvQWQ0RjRETE1mOHloY0JXMnRQbnhCQ1pYQXZ6?=
 =?utf-8?B?RmdOMXFXWjc1T3B4L2dxVG9zNFpVT2JUTTBHempmeXU4U0pSbk5kaHZIU1g1?=
 =?utf-8?B?VVBHVnM2ZmxxVjM3UTgwazQwOERLZWczeFZ2aTI5NUltZ0cydjNDb3h3UU1y?=
 =?utf-8?B?eCtuZHN2c2FQdS9uUXZHYkdUU042aVo5Zmw0RS9PWmU0Z0xLU1pkbEVmeHJT?=
 =?utf-8?B?NFBYT3VKMUI4b3Zxc00vQkpUU2VuSWk0U0hxZjF6K0FNQ2tuMTFyUHlVaDUx?=
 =?utf-8?B?eFNEOUpoeTQwTWVVcmNIdkc0R3k5eFdJMVZXWTMzU1NqTUxaSjJDZVVjUHV3?=
 =?utf-8?B?aHVLWVFhdmdkdk9MMkZkaDF3TzB5dk9xM0h0RUJpSy9wN0MwTm9zWC85b29z?=
 =?utf-8?B?M2NvZjhNZjdCUFVkdkJwWGN3N0N2QlVrT0lqU1hQUnBQVXlKZUhpWkdQQTBU?=
 =?utf-8?B?a3pSMnFrSDJhRXNiNjFSdGI3TmQwZm4wUk9KVllhbTJ3V0FpL1ZhYnE0WG9B?=
 =?utf-8?B?ZDJiOVBLYXp1KzBWWHpFN2hjUTlhRExHWGoySnc1TWRmWEJ3cXE4K0J5Tm00?=
 =?utf-8?B?R25oN0JUOUtwUzFCdkN6cm1vL1NsclJDSHpOQXpkS3ZvaldpcG42SEdmb2lt?=
 =?utf-8?B?dU5DMm9yZUl0RDlhMEdHTVZVNTNFY2ZmckJsRkhvUEtTOWJ2S1FGcEZac1Fk?=
 =?utf-8?B?NCtLRXk2WFlNYU8wZWJKdGV6bXJtRElsSDE2emVVR2NnaFNXdzNkQ3Qwemdq?=
 =?utf-8?B?RUNwRkZaWVVSRVVHZnRwaDAyZVE2WjViSU52WFVGOXdkaUdyN2lnR3k0OHcw?=
 =?utf-8?B?WE8zMFNrR0tNcmM5QkFwV0RKVlMxdk16UHdMYjVabUtNbHoraVIrUDJVWTdQ?=
 =?utf-8?B?K1VLUlA2Tk1hVzlpNWdMTW4zNmprRk9rNzF3N3dQcUtlR1ZuY2paWGdpYXhl?=
 =?utf-8?B?RVZuUDhKV3ZYSEwxWW55Qi9xSVAySndoaStsVjhPWHVSV01reXhpdWtxaHZD?=
 =?utf-8?B?RURrdXhCOVpwZXhjMVVlQm9vOEN1c3JwY3kzU0VKRXhIT0V1REdKaVlHL2ZE?=
 =?utf-8?B?bTFuV3NkYlYwOEpKdEZuanlVRUQxanZHdVQyZ1ZNRTdsZTFQVHF5QjljUHlW?=
 =?utf-8?B?cEVUNktxalBvaE5nZncwMnJqZGMzaUNMcXJ6TDgzVkxERmM1Ni8wbVMzbHdz?=
 =?utf-8?B?WmpQSGVKRUxLRmFPVldBSWk2QkZwV0ZQbXRKelQ1MXJydUNVQ2Nma04yUzEr?=
 =?utf-8?B?QWF0RFVnNVllQlptNDhleS9oa0o4WEErOTVKdkpjcy91VktKL1dCRWhZK2hT?=
 =?utf-8?B?dXcyNUh6L291RFFtWDFQb29qNXNWNDZDZndobWJmcWtrbzhFL0ZGRE5DSmNy?=
 =?utf-8?B?aStWNnJFd0JKMW5tUHpmK2FDOS8yWUxvNVZDVEpRVWw1MzVEdFhHTE5QUHJr?=
 =?utf-8?B?TWZrckpncU11N2h3RmRTTmRUbUkrRHA2WG90WkwxUnRkZDhSYmpPVDVWTXNW?=
 =?utf-8?B?am1FQ3ZhdWRpK2RiVWEzQTVGYkpsdW40TDExa0tpUWt6NG84Y3FGTUJyK3Bi?=
 =?utf-8?B?b091Z1U1RFd2cDFsNlp4cVJ2WGtGbE8ya0h4UW5zNGpzd29qQVlhY2lXcnRL?=
 =?utf-8?Q?2yNnqi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14468.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTFibnFveHhJK2xES1RjZ2Ztd1dRYi9HWTJ3dnhuMXZtWS93Z0NFUFBhQkNo?=
 =?utf-8?B?QmZnSVNweGZvSzNLVmYrNUdPYndHZDM2Q2I0Vjd4UDFrMU1BTG8wR25QdCtw?=
 =?utf-8?B?RUtTV2d0MW81bUxydFNHRTRGTHVDUW9JUDVXdzNqYi90MVY0THNpR0xpOVV5?=
 =?utf-8?B?WngyaC9UZlVwYVdMYXpIYVc5ZEgveEhzTjNCR2F1VDRhTk54cExBSUlUZCtj?=
 =?utf-8?B?dTBqSUZCZXBCdE1qVHdRa044Qy8zb2pDeHpCdTZwYkphTlN2U2M1R2ZwSzZk?=
 =?utf-8?B?K0ROMnU4ZXB5R080SzZlQ205UXV1MVEwdzVKcEFCQzVaNnEwZm9WeExpOHBW?=
 =?utf-8?B?dGtIaDlGWndDNUZsZWVzZGp3WWthNEZacG9DY1hzNVNpL3ViNGVSTnZqVEh6?=
 =?utf-8?B?SndKMm54VHNmay9iK01XM3d6cis3Yk5lcUloTkcrVklnQTF3L1RERjNHTkZk?=
 =?utf-8?B?b3E4TkZ5UHNONXFJWUFzRERtVW4rTU01YzZnbnJ5dTlHN29KMVRGWHlGQ0dj?=
 =?utf-8?B?SFdWYnV5RVYrMGlXWFVMdk1HTWRCZHlKNHhONXNQdlBvU0pjcnRoa3lHcGU2?=
 =?utf-8?B?YjVKd1RCTENKZS9FeFFzSkVlenFNOFp0QW4yLzNHZ0dKQ01KRlcwZU9jTkFr?=
 =?utf-8?B?bllvS2FjZ3NSdFhKTk9kLzRiVjBTcEEwNVFpK3o0THdXT0NnaEE3WFRveVJp?=
 =?utf-8?B?aEM2R2hFbkN5VTRVeUd2c3ZacEIwZnA4MXVoNHhEdVZEZHBlMGxnQ1I1ZWdw?=
 =?utf-8?B?OHV6TFh3NERmSjlFa2FYNzBjdE1XU0VhWXBsa3ZyL282QlNBZ0NxdHBYMnRC?=
 =?utf-8?B?MFBNYk92Uk1TOHo0VmFyQ1FnOFFOMVc1TkdGSm5UeUd6V3pXOHpuY1N1N1VI?=
 =?utf-8?B?UkF6MmdIZldtN1dET3ltenJodHZaNGJaV2xzdEI1V3kxa1J3WkZJamYzbnJH?=
 =?utf-8?B?YThvbEtnWkUvRCtQeEVCb3hNeGlvdmIxVlNrQ3NDcDVuMVhIazlHUkJjQnh2?=
 =?utf-8?B?VUYyWEZZckZyNkg3RlFIKzBzZkFwalNLV01KcEx1UC9mY1l3bjNDWWJEcm9n?=
 =?utf-8?B?MzJ4bTZibDhUOUw2d25UM2VlTkkxSHcxdWp2Q3JGR1Y4N2ZXZm5WenQxN3N0?=
 =?utf-8?B?dWhmWndSM3U0L3puRHNUU2hWbUdBYnp3eU5mMGI0ZktZRWNqTjF5a2F3VTlM?=
 =?utf-8?B?bElYVHR5ZnREMXkwaW5kRWc3dytHTGRxdXpvZC91VmNGRGVXYUZucmFrZzc1?=
 =?utf-8?B?Qy9mR1VMRkNqblUzcS9LV01FNlc2bXZ0blNoYjl6WnNqQWRiekdWVWxQWjNK?=
 =?utf-8?B?aTNkbGVTVnRTOVZTaU94MkZ1VmpUbDE1cElFWFhVZGpqNit0ZTlNRUM0N1Fn?=
 =?utf-8?B?NWtWN2V1N2xpZnBFbGZNVUpTUkRHc2RhQTRxQlZ1Y252TGNIcWkrdDdwMm1m?=
 =?utf-8?B?dUNVUDNWeU44T0ZIb2tjdU9kNDR5QTZVUkhBTzJBeE5PMnVKRzRicXFvc2ov?=
 =?utf-8?B?eGhPYysyRkI5VlNLQTU1ZExFeG5nMW4vSHlGUm9tbDJVQ005dUY2cFF4WG9s?=
 =?utf-8?B?V1ZRRDhKZE9FNFYweDJJb1hJVEcwOTFrVTJxZGtEenVva0J5Njc4eGpURmE2?=
 =?utf-8?B?dDAxRjgzVjIydTlxcXh3ZWo4NVJNZnU2ZUF1VDRDOGMzOWg1Smx1V3VSYVhV?=
 =?utf-8?B?eEc2QTd6MlNzRGpKakVvb2dBZW9SWHpTZXEzY0tBTjNGajVHbU53eGhMU3dR?=
 =?utf-8?B?TlNXUDhXNHVzalBOTTdMZ3g1YlRYWDNTSWQxOVJqNEk1UVFVdjJmVmRqbExh?=
 =?utf-8?B?aHVPRlZGNjBlQ2gyR0tIRTRIa1ZDWEI0djI2a2h0RUorUjVKYnFKbmY4ZmdM?=
 =?utf-8?B?TjZMbkJvY2sxT0p0WHBVWnpacUhPVkhRVGhVMmc0Wm03aWRyLzE5b05yRk1V?=
 =?utf-8?B?Z1FQWEJDeXVtOEg1V0dLbC8zbktFbFJGZEFMeU5NWUlKVW1mbDRlcEZHV0xB?=
 =?utf-8?B?NU9zenB5bDdFQlRZazNNeHppMFVwUm92SFE3UnIyWGhLZXIrNXRVb1g3T0Iy?=
 =?utf-8?B?YjVYa0d4cm9sUVFvZVlMWXI2bGZkQ0FuaEprdTc0ejRIZ1ltQ0FLNTRXWDdF?=
 =?utf-8?B?akdZc1pJeTI1NW5vYzhOMWIvTDA5YjRRVkRUdHIrWThORUdsRitwdXczSUw3?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACED570425FD4844BD2AB41AA5FF6AA1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cyw8QN/EK/GexWGIjMqm50tIkGf2iCRbKzOG4u+Dn98tDGd1V6WUwm67nQWWOOy88DD17yBnijGJpQ0Rf0eiB7RXNhvfgFlDxBxhQp4l+bp+D9c2ZudX2fughP61f5Dz8nz1pVY1WEadfL1XRmiQeqEUq3q2AYT6op1AGgj/Z6vH0zub28MSgkFvQ691iNXvKaEf7gTFAjIecrnDZRtNWruL0P7PFrox4VzmyxZ4JsvxrRY5XYksZcNwxDC8QELmxVxb+6+NsT3ScEF8fU0cT8avqa0dEo9J45blbSWyMA9q/CG2TBsKti9a2Fuir1Ymd3h2tmqf2sFDlewb/YeInn1jZ6KfHK3m2wMztoB2oi9pl9JOH+0Dm99OcsH52yfcCbWzE0nE1gCr667n2o/inwvhRKn+DjV75K2hGDjiB1cP8/qFKmXiKKOipfRYLxnQsjSY36kK3gSJinDIes607Q7XNMVtCGVD9z/sMmA5eK4Abn9j1zufFiy5NhAYyScjJJVx3huLlqj4r3fNp6d9ghJ76IxIFaNwKAZuyUdPf6aZqPUuYKDG9v6N7Z44pmc2gemlmLtAgLoXfq5uofYC1hYF/lly52FjU9boFZsYw4P3M5/LnrBgzaHe6Fz8k5JZ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14468.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b269bc-62ec-44c8-a972-08ddac713580
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 01:00:38.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3G1swhB52uViX2MkuM5vq9D502JUl0Kz0TKn2/poxXJQNwVcuZFtk6aYtSlowf0tZKSRmVMmyipLYXDiJG3wjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11218

DQoNCk9uIDA1LzA2LzIwMjUgMDI6NTksIEtvcmFsYWhhbGxpIENoYW5uYWJhc2FwcGEsIFNtaXRh
IHdyb3RlOg0KPj4NCj4+DQo+PiBUb8KgdGhlwqBDWEzCoGNvbW11bml0eSwNCj4+DQo+PiBUaGXC
oHNjZW5hcmlvc8KgbWVudGlvbmVkwqBoZXJlwqBlc3NlbnRpYWxsecKgY292ZXLCoHdoYXTCoGHC
oGNvcnJlY3TCoGZpcm13YXJlwqBtYXnCoHByb3ZpZGUuwqBIb3dldmVyLA0KPj4gScKgd291bGTC
oGxpa2XCoHRvwqBkaXNjdXNzwqBvbmXCoG1vcmXCoHNjZW5hcmlvwqB0aGF0wqBJwqBjYW7CoHNp
bXVsYXRlwqB3aXRowqBhwqBtb2RpZmllZMKgUUVNVToNCj4+IFRoZcKgRTgyMMKgZXhwb3Nlc8Kg
YcKgU09GVMKgUkVTRVJWRUTCoHJlZ2lvbsKgd2hpY2jCoGlzwqB0aGXCoHNhbWXCoGFzwqBhwqBD
Rk1XLMKgYnV0wqB0aGXCoEhETcKgZGVjb2RlcnPCoGFyZcKgbm90wqBjb21taXR0ZWQuwqBUaGlz
wqBtZWFuc8Kgbm/CoHJlZ2lvbsKgd2lsbMKgYmXCoGF1dG8tY3JlYXRlZMKgZHVyaW5nwqBib290
Lg0KPj4NCj4+IEFzwqBhbsKgZXhhbXBsZSzCoGFmdGVywqBib290LMKgdGhlwqBpb21lbcKgdHJl
ZcKgaXPCoGFzwqBmb2xsb3dzOg0KPj4gMTA1MDAwMDAwMC0zMDRmZmZmZmZmwqA6wqBDWEzCoFdp
bmRvd8KgMA0KPj4gwqDCoMKgwqAxMDUwMDAwMDAwLTMwNGZmZmZmZmbCoDrCoFNvZnTCoFJlc2Vy
dmVkDQo+PiDCoMKgwqDCoMKgwqA8Tm/CoHJlZ2lvbj4NCj4+DQo+PiBJbsKgdGhpc8KgY2FzZSzC
oHRoZcKgU09GVMKgUkVTRVJWRUTCoHJlc291cmNlwqBpc8Kgbm90wqB0cmltbWVkLMKgc2/CoHRo
ZcKgZW5kLXVzZXLCoGNhbm5vdMKgY3JlYXRlwqBhwqBuZXfCoHJlZ2lvbi4NCj4+IE15wqBxdWVz
dGlvbsKgaXM6wqBJc8KgdGhpc8Kgc2NlbmFyaW/CoGHCoHByb2JsZW0/wqBJZsKgaXTCoGlzLMKg
c2hvdWxkwqB3ZcKgZml4wqBpdMKgaW7CoHRoaXPCoHBhdGNoc2V0wqBvcsKgY3JlYXRlwqBhwqBu
ZXfCoHBhdGNoPw0KPj4NCj4gDQo+IEkgYmVsaWV2ZSBmaXJtd2FyZSBzaG91bGQgaGFuZGxlIHRo
aXMgY29ycmVjdGx5IGJ5IGVuc3VyaW5nIHRoYXQgYW55IGV4cG9zZWQgU09GVCBSRVNFUlZFRCBy
YW5nZXMgY29ycmVzcG9uZCB0byBjb21taXR0ZWQgSERNIGRlY29kZXJzIGFuZCByZXN1bHTCoGlu
wqByZWdpb27CoGNyZWF0aW9uLg0KPiANCj4gVGhhdCBzYWlkLCBJ4oCZZCBiZSBpbnRlcmVzdGVk
IGluIGhlYXJpbmcgd2hhdCB0aGUgcmVzdCBvZiB0aGUgY29tbXVuaXR5IHRoaW5rcy4NCg0KDQpB
ZnRlciBzZXZlcmFsIGRheXMsIHdlIHN0aWxsIGhhdmVuJ3QgaGVhcmQgb3RoZXIgc2lnbmlmaWNh
bnQgb3BpbmlvbnMuIEknbSBmaW5lIHdpdGgga2VlcGluZyB0aGUgY3VycmVudCBjYXNlIGNvdmVy
YWdlLg0KSWYgdGhlIGNhc2UgSSBkZXNjcmliZWQgYmVjb21lcyBjb21tb24gaW4gdGhlIGZ1dHVy
ZSwgd2UgY2FuIHJldmlzaXQgaXQgdGhlbi4NCg0KVGhhbmtzDQpaaGlqaWFu

