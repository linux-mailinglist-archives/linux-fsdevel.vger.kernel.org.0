Return-Path: <linux-fsdevel+bounces-77088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G23MhPXjmmhFQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:47:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 385BF133B2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 331A9304BCCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5C0312837;
	Fri, 13 Feb 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="q5i3pWgf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010020.outbound.protection.outlook.com [52.101.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67A1C862E;
	Fri, 13 Feb 2026 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968834; cv=fail; b=QpMjfw16MA5Pr6r0Y8Bnsp5ds/Cx+ie/GzLYV3Eh8AWvFucfNr/Ib0goY/F2nmEKcKgXhsAmCrNBIfrgztZoZ0WxPOVFVliIIbxUAlXk7ON+qAR/MqAutWt78+gluCKWaQD/XU0jwEPBNYRXMdspg66siX2tw0ZeMQeZTOeCHzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968834; c=relaxed/simple;
	bh=hK2PwnY/yYODbSQYuUcO2aAqQTWSrw+OYOLjJaj+NNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D6Rt9ynu20KcK1u7bPJnrDGrhp+buknhz1dGMeAc1m4a3zMof8nG3TDtMMQNLKZdnwhsspvSxFjI0iwCZ8ueWgcUIyS6lHhDI9SWvMU+i93AntODCgxxX4vfJin7LWeuHAI4f9cCygud+XbLksaTBCyd3WiOk0xzmdS1SGfNtTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=q5i3pWgf; arc=fail smtp.client-ip=52.101.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFxeGbyZQ/OvGRkbynqxZhZwgAMC1kLpWljMTm1S9S/F+PdjjfJFMCbOcdN0dJ1/CLwxUwUkTht+rMAfV69fBLFlWuPonWkmtmQrXowhODNz/rTh5gD8PRh+M+SF0rytSbjt+lwIZsYzsVU1ebW30mW55D8iEPXyizXBISHZ2kQZKbqXUiaJCvofz6RCKE/Q3qSWW833/Zh7V4VlMyShYqvGzsy14M7R+vucoQFrS0a5meBdTVQyv9u7rRGMO0qA5mADyw7ESLwh+FCNKufX3lXwYniOmy6614Tt30xDAV+YXTZ59z7MYLSmleojEaYNrjXhGB2+y5PfPn5hWEuPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK2PwnY/yYODbSQYuUcO2aAqQTWSrw+OYOLjJaj+NNQ=;
 b=TdLZXT8A852ejjr/PEfQe3xlgibL9KPM8Ry5G6Koe5ZBZXW8yTAV6Jc4jLGDtYzqQ9fJzE3FtCjEGefBkat5kylDOwW9bzqUAarrNBHD9KGw7vTiRWYlyU4w64RSZwjFP8mNShFogxfaVu+Z+kDz3TGKlI0OpL+wAoB8LNaH77+xqBbbkwuSr76f0N48cTvTHjEnDhARYdwx7uRL+bjV6ftNvYNymcOlR4q8SbyhHXQZvvCiv+hIL4bNByY5R21Y3PxMDhcgPm3QmJixtFWYIkZDGtkzZyI35cuEog6qqR3d6vhlOya/rfetck+uYL/J+Fy5W9F7In2zkDB8cz9O8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK2PwnY/yYODbSQYuUcO2aAqQTWSrw+OYOLjJaj+NNQ=;
 b=q5i3pWgfRjD2RHQ+1p/RPwbK4gfirfab246qwhHBKqi90wu26DDneoG/gFRP9pFV2FaIjBDmGImkVQujWbXs/oypNZv0Ai0Vsm2ayyAA09n8TJorZ3yOSUJkxC870CkqQ6ZZtlpNca07BnA4ATrgdoHGkDAd2nrMvAIO7/o3RJ7RrsMzLy7AgPAMeMWtW1QF4FA/Ptm4jQmowl/VbKjEql8PTjA6DJNFoHclGivUJsZ5ieDv8H1Spr2YIqK/gAwePgwYCpFFxviXVW50mIwAAa3rI/mckhMNHUI5/u7ttiOkcuJ+KhWEgrUH4NUr7JRYrk2IGx6/9mV90ksrk25VOA==
Received: from TYRPR01MB16276.jpnprd01.prod.outlook.com
 (2603:1096:405:2f1::11) by OS9PR01MB12180.jpnprd01.prod.outlook.com
 (2603:1096:604:2e5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 07:47:09 +0000
Received: from TYRPR01MB16276.jpnprd01.prod.outlook.com
 ([fe80::464f:166d:23fe:e8cf]) by TYRPR01MB16276.jpnprd01.prod.outlook.com
 ([fe80::464f:166d:23fe:e8cf%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 07:47:09 +0000
From: "Yasunori Goto (Fujitsu)" <y-goto@fujitsu.com>
To: 'Alison Schofield' <alison.schofield@intel.com>, "Tomasz Wolski (Fujitsu)"
	<tomasz.wolski@fujitsu.com>
CC: "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
	"bp@alien8.de" <bp@alien8.de>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "huang.ying.caritas@gmail.com"
	<huang.ying.caritas@gmail.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"jack@suse.cz" <jack@suse.cz>, "jeff.johnson@oss.qualcomm.com"
	<jeff.johnson@oss.qualcomm.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "len.brown@intel.com" <len.brown@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"nathan.fontenot@amd.com" <nathan.fontenot@amd.com>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "pavel@kernel.org" <pavel@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "rrichter@amd.com" <rrichter@amd.com>,
	"terry.bowman@amd.com" <terry.bowman@amd.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "willy@infradead.org" <willy@infradead.org>,
	"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>
Subject: RE: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Thread-Topic: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Thread-Index: AQHcmljeqGwxci4vD0qX6xZEB4t9YbV8TuqAgALYgoCAAG4nAIAAnjxA
Date: Fri, 13 Feb 2026 07:47:08 +0000
Message-ID:
 <TYRPR01MB16276AE76EB8585F3786510F59061A@TYRPR01MB16276.jpnprd01.prod.outlook.com>
References: <aYuEIRabA954iSfR@aschofie-mobl2.lan>
 <20260212144415.10418-1-tomasz.wolski@fujitsu.com>
 <aY5DpvAvqxqWZczR@aschofie-mobl2.lan>
In-Reply-To: <aY5DpvAvqxqWZczR@aschofie-mobl2.lan>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZjYwOTg0YzAtMDU3Ni00N2NiLWJhYmItNmYxYmRjYzg3?=
 =?utf-8?B?NGI4O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI2LTAyLTEzVDA2OjQ1OjAzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB16276:EE_|OS9PR01MB12180:EE_
x-ms-office365-filtering-correlation-id: 2c0fcb2e-ce8e-40a7-241d-08de6ad4174b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUgxbG5rMFFiZ0NBVXNuWXM5V3pWWUVxcTZKYjBxRy9aQVpwNC9kanhUemMz?=
 =?utf-8?B?WHNKN08yWG10Z3FoMURLb1Qzek5YR2dzcHo4Q3Ywa0ZnUUdOZFRRUENUU1hh?=
 =?utf-8?B?bXhPVFpyUHFKYVowK0RHWmhCU3hKUEFYMGFKQTdqK1hWZ2Rjb2dXRXRkRVpa?=
 =?utf-8?B?eS9zS1NUdWZEcVNxOWFIT3lxTURnV09mTDFXcWNzTVpYNHFlaHB2SDJHRWdG?=
 =?utf-8?B?RU0xWWU5VElYZ3NSVzBKRzk0d0FubEZ1Z09vV3hNTi9rY3c2WHA3ZnVxeVFK?=
 =?utf-8?B?MWR6RDhMN05xc0VmU1crcHcwZWxycHk0bzdNMEtSakZPcmZwSWsxU2tQOW1h?=
 =?utf-8?B?aFV1c2VxREpoTXRxcnBBRlRtRzI1NlRraHlZZFkyOWpvOUpOY3ZwdDBpd1Qx?=
 =?utf-8?B?RUtIbXBwU2lMaFVYMGUyV0tmYW55emxlWnRDUXBZZnRUOTZ5amROWDlTcWVs?=
 =?utf-8?B?dWl2WUhBRlR4aytPbFcyM0E0RjhOVUpPMzF6aVhKN2pWZlZHT29LSDM0SEYr?=
 =?utf-8?B?V1VGZFhJSzEwYlZWZVBqUUEvaW5OL0E1U0dxemphNUxvblAvVEV3QjdCNEty?=
 =?utf-8?B?cml4SXZiQi96aUQ2TEkrYkpqcTlNZEJ0MWVURWtCNVZsb3luS0hiOERFdGRy?=
 =?utf-8?B?SVpxVGppMWxGM3E1TW1EWThMOHdPTEs2azMyMkNlSXFoNlpaMWdqdXhLaEYr?=
 =?utf-8?B?U1ptdWdYVGxVL0s3UE5WTk5tbXlkQnFScjdiL3F3aVlOTnA2aGVhRWdIREk1?=
 =?utf-8?B?T2FOT3liN3RNaElHb0c4eXRzSjR6RE5BanhsYW5oUmtnbXZRcEdHQ0MrUTEr?=
 =?utf-8?B?TTlrRjR1emZFNDVNcVlNRFovd3VMWTkxTUx1d2FaNjJoajF1NDRBUE9LQ3J5?=
 =?utf-8?B?QThLcjhMcUJ4VEFmVW9qSFVNaDVMNEI0R1hJTEc1ZURPMGYyUHI0MityMFF3?=
 =?utf-8?B?a3hhUDd6Q3pJREVIaGh1UC90VHd6Qm9FcElLelRJblVLazh2eFV0bGlNVXkx?=
 =?utf-8?B?T1NFM2dkazRWSmpzYytyWlpITk1USldDL1ZvY3AxNU83dVlFcHAxL0ZMaUN3?=
 =?utf-8?B?Uk9IRUpieEM2WjRUem5xZFR2azNUeEpXMmlwak1QeCtNYTNxS1FSQjNlUEow?=
 =?utf-8?B?OG1rTm9IZ2hrRnBTTHJtOFBETmpxYmtCWkxCZHBWWHpia2U0T3RGbllHNFVu?=
 =?utf-8?B?c0RQdFkyUVlzR1YySkFxQXRrNGo2YWhYSjJSZXptVVFsQXR1VlpTU3B4dzBG?=
 =?utf-8?B?cUI4WXk3Z1FBcXZHVmVJTzdsK01lVS9WUkxwMkVzTHBpZGVMTy9UYmZkSmxw?=
 =?utf-8?B?dGIvaFFsdmJoZVJ4TnZrbDRId283elRET3loM0thS2NaSGMwN3puOTlwYUVT?=
 =?utf-8?B?NzRhbVBGUEkwSnpEbU43aDUrM2NUZHFNVkk3dnhac0lLcml2WEo0dWlOVlpt?=
 =?utf-8?B?S2kyTVhVTDltMnlURnlpdGpkUmxIOTQ2UUxOVk1NMTNNd2lneDRpRWp1b0pQ?=
 =?utf-8?B?a1Fnd3VuS1BrbUFjSHRoeWI2S3hHaXI3WXpadk40WTZVWFJKVUlCdWZtb3VH?=
 =?utf-8?B?ay9wNkpEODJOODBjdXh4elVmaEtwYmRJRkMrQTUrRGhIT2xrSk55UjhUMEVt?=
 =?utf-8?B?UXQvVlAzeDhHQVByZHJnUmd2RjhUSXNBME9LRDQ3c1FKd1N2b2RVMjk2bWhU?=
 =?utf-8?B?NGFBWmlZbjlpZThjcUxFVEJaTmk3U01OTHFIK1ozcWZFYnltaHEwM05ES0hl?=
 =?utf-8?B?RCt1bE4rOFp2bmtXWVFPU1FzNlNleHIzUU15bzRBSlF3T2xCdTVidFBkYTBO?=
 =?utf-8?B?Qm1ocUR5Z0tlMWpidVBCdFpWTFV2cC9Wc1B1clpaUDF4UHMzKy84NHprNExC?=
 =?utf-8?B?MkR5VW5FSjFmU0NQempSSzV6a2d2R0RKU1VrT0xHcTFQZGRXZU9LdTVPSVF2?=
 =?utf-8?B?d2Z0RTR0ZjVQeThYalJwZWtETkZ5N0pDcG9mcTNLRnB0RGdyNFlsUytONnk3?=
 =?utf-8?B?WWdoVGFVOUhHSGh6MUdpeXEzMFZLNzZlaFIyRFRkcm1sWmo1L2FiVUkyU0pj?=
 =?utf-8?B?TmlzZWpPNzZmV0hZQVZTVWUrdFVYWFJjcUNnekVrYlp1MDdsUy96RS9GVVlN?=
 =?utf-8?B?dVlWMnE2c05nWUVOeXJHSllTeVlzRUhZS0YrWEdoRUtuY0lBVEJIeGxSdHhE?=
 =?utf-8?B?YjNxMlhuOGMrV1doRXlGT1pwdXh2M3MzNHdudjViektFc1piYVIxRGN0VG00?=
 =?utf-8?B?ZmFNQUZrZVlsUkhCaGdCNUhLTmtnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB16276.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1U5YzY4OHYwbTI4d29QMFZTVmNtRzlPMWsvVTdnZ0FCdjdCOUdMZE1LUWRo?=
 =?utf-8?B?d0d2RVhyYnRjM3RtVXRWdEhEMjkranBrUG9STGtCU0duOUZsa2VZNVZOdkR0?=
 =?utf-8?B?bWdMaHhXTWI1NUIrWE5ReXg4aVdocmZpQnBoek9FUCtNdTJvTURhTGZVK08v?=
 =?utf-8?B?LzN6UXF5bGtPZ1FJakV2ZERycWdIV0JpVHRDUXBtTDNQR3c0TzRSbTdkSjJs?=
 =?utf-8?B?a0d3UU1qTVM5UEZqR2Y0N3krUDN0aWpCSk81LzhEdFVPUUNTcnF5VEJObFdE?=
 =?utf-8?B?UVk2WnJJU2V2TmoyV0RpdjZxU3NvMzNNeG93UU16eWRJQTR0OXZMYkkzMU1K?=
 =?utf-8?B?anZlbU9Ed2tMRUQ1eVpVMXdNSjRWRDh1cFlCYjlwQ256VE9pYjhseGY5V1Yx?=
 =?utf-8?B?QktNT3VWNEJUMUlxZjk2K1FGWWdhK0V3RjJJYXlBT3ZEZFRXODhHMGtPRi95?=
 =?utf-8?B?TWNFYlcxUW01ckM5TVROQmZMbDJCTG1qN2M3bmE2YXErRGsvd1RTRjBiZG90?=
 =?utf-8?B?eC9IVVkxeExGeGxtZSt4Q0tXdDl6a0pHQlg3TVB5U2FJaXpTNE5HRXVIVWg4?=
 =?utf-8?B?NjNvTFk4Vk5rY1Q1UXZ0Z015TDVBam0vaEhlK000L2REVnhmeXkzU0h0eC92?=
 =?utf-8?B?U0wyL3cvWmJ0QUpMUm5aUXlscHRDS1FtV1lsVjdZaXFMMVpnd3JMcUJNeXZB?=
 =?utf-8?B?bkU1VUFlVmxRTXZUNmkzY0JFd3dhU3BRS2VkME5PeGtFWXNhNmRPaFZTdCtV?=
 =?utf-8?B?cE5OVVpHQ09CTk9BTHdEcnF1blNaOTVORmN5bFVVU2RVdzljd1ZOOEllQzNC?=
 =?utf-8?B?YjJ1U3hWZ0hqeFlTVG9ZL2hVd2RNZFBYUTd4TWJSajZZb0R3TkgrMzdjSEtD?=
 =?utf-8?B?cTd2Qi9YL1R2ai80Z3RKS093N3MzUzYwQzZSQ1VHRWxrNU1jcUdBUHI0Rmp6?=
 =?utf-8?B?NVVSdFNHYnpaYXlLcDFVV2owUjBFT3prRktUU0U4K3l1N3p2ZmV2eVUzdnh3?=
 =?utf-8?B?VmhPUzdRUGFjQ0FLUFM2elRHNndqSkxTSG5vUm5BMVJXa3R5UzhTZzczN2RU?=
 =?utf-8?B?cUp0YjhEV2ROdTZEWXJ2LzZEWVhJWDZpcklhd09EUWVMaGlzN0I2a2FSazRS?=
 =?utf-8?B?b2F0WEhjTnRlVS9vZWUwd1l5aVBjTjZJV1dJSENaaW0yRzRFQlhwZzJ1MFd5?=
 =?utf-8?B?S3RFMTJ5QnJCWkxoNWtCelp2VEZNanc4MHp5Qy9wZTdoRk9XQllnMzlzeCsy?=
 =?utf-8?B?eHZqM1ZFZTdMLzR5YVFtT2NzNk5wek1Wa1hVdFJTR2c1MkFMMEt1QlQzQzJ4?=
 =?utf-8?B?QzZRK3N1N1N2M1NmaWxyMlU2TTVpb2tSRGg5TzJscmNkaDRNbG1LY1JuRzlO?=
 =?utf-8?B?bEtSRUNMQXFpTzR0bFFpTVptbEs0NVBBRXpxM0tZRWN5a0pQbDRNTkZqM0pB?=
 =?utf-8?B?N3M1U3dHUzhGeVNEZGhNY0VCalI0ZWpkdml5aGUzazBJaktldjVoRVNKYjUr?=
 =?utf-8?B?QVgyRlp4YnF2YXdoTmV4cUFYcmxnaisvV1EvYUNodm4zWDZJUjliWjBUem1x?=
 =?utf-8?B?SmE3djhFZmtFdGNzSXUxK2RlN1ZQS0tNbElpM3VzNEFqUnBQb3BKdTRtTXhN?=
 =?utf-8?B?dmhqSEVSUkNzNzlzUDZ2ZzltWDhWZ0RURXRqSkN5UUNyUURTRzlNdlR0a2ZL?=
 =?utf-8?B?Zll0QjVUVVVDZUh0VGY5WWx4STU5UXhDN0QzWGcvMVk3aERoMElqVHAyeStT?=
 =?utf-8?B?ZW5CL3FDQkhTdHBESEk5aytvQ2dTdkZVVGkrM1gvdDZORUNhWFJMd3ZGdE84?=
 =?utf-8?B?RGkzWFRKaWdpZkNVVmR3NjNvNW9nczN0dlg5TVFuaGZvdGhuUEVqbUNpOUp3?=
 =?utf-8?B?cndFakJmeUFBT0Myc2FDK1lReWtaTzNYa1Y4Ly9GT1h6NllJcUxvMDlrUDR4?=
 =?utf-8?B?c1VPbGhPMndieWoxallzRjJXeXZrbEF6NE04MlFEZXJxTEQwNXZUaTlsaXo3?=
 =?utf-8?B?eUdQbm1kOW93cVgxazFJY1VxL0JMdGZXOXVTRjdURWdpMFRDMW1tUEF2eC9F?=
 =?utf-8?B?V2RiNDM4WXROdFpZcStGdFhwdXZhVWxXUUxFVFhPcG5aSlE5aTJoK2cwTHR3?=
 =?utf-8?B?UTI2STJKays1NlJuVDFSNGwwWXFYRTNrc2QwSURKTjBhWnZMZFhKL3F4TFlu?=
 =?utf-8?B?NVNOVkxRMXIwQncxWktYUGd0WFJ1Ty85SVZDR2UzcTZmSFZEM0lFK2FwNDBV?=
 =?utf-8?B?SGZDb1M5bEFQS0dkNjlPdWZMRmdWRFBQL24yeWZUUCs3NnNIWnhhWCtFdGsy?=
 =?utf-8?B?NGxaL1lxMHBDWWJDVDNDb2dXRnNqSi9nSjNZdlNCNDZhYjV2ZzZDZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB16276.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0fcb2e-ce8e-40a7-241d-08de6ad4174b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 07:47:08.8743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBnVdZCQw7cPypnPMz27t8JpMFfXlwPTHIaBrY+r6RmZbwnBIW83ZpmR8ZGyTg78ohSF7jRK7LulSlyz08IFQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12180
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77088-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[y-goto@fujitsu.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,alien8.de,intel.com,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,fujitsu.com,zohomail.com,lists.linux.dev,infradead.org];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 385BF133B2D
X-Rspamd-Action: no action

SGVsbG8sIEFsaXNvbi1zYW4sDQoNCkkgd291bGQgbGlrZSB0byBjbGFyaWZ5IHlvdXIgYW5zd2Vy
IGEgYml0IG1vcmUuDQoNCj4gT24gVGh1LCBGZWIgMTIsIDIwMjYgYXQgMDM6NDQ6MTVQTSArMDEw
MCwgVG9tYXN6IFdvbHNraSB3cm90ZToNCj4gPiA+DQo+ID4gPkZZSSAtIEkgYW0gYWJsZSB0byBj
b25maXJtIHRoZSBkYXggcmVnaW9ucyBhcmUgYmFjayBmb3INCj4gPiA+bm8tc29mdC1yZXNlcnZl
ZCBjYXNlLCBhbmQgbXkgYmFzaWMgaG90cGx1ZyBmbG93IHdvcmtzIHdpdGggdjYuDQo+ID4gPg0K
PiA+ID4tLSBBbGlzb24NCj4gPg0KPiA+IEhlbGxvIEFsaXNvbiwNCj4gPg0KPiA+IEkgd2FudGVk
IHRvIGFzayBhYm91dCB0aGlzIHNjZW5hcmlvLg0KPiA+IElzIG15IHVuZGVyc3RhbmRpbmcgY29y
cmVjdCB0aGF0IHRoaXMgZml4IGlzIG5lZWRlZCBmb3IgY2FzZXMgd2l0aG91dCBTb2Z0DQo+IFJl
c2VydmUgYW5kOg0KPiA+IDEpIENYTCBtZW1vcnkgaXMgaW5zdGFsbGVkIGluIHRoZSBzZXJ2ZXIg
KG5vIGhvdHBsdWcpIGFuZCBPUyBpcw0KPiA+IHN0YXJ0ZWQNCj4gPiAyKSBDWEwgbWVtb3J5IGlz
IGhvdC1wbHVnZ2VkIGFmdGVyIHRoZSBPUyBzdGFydHMNCj4gPiAzKSBUZXN0cyB3aXRoIGN4bC10
ZXN0IGRyaXZlcg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3IgUUVNVQ0KDQpU
aG91Z2ggSSBjYW4gdW5kZXJzdGFuZCB0aGF0IGNhc2VzIDIpIGFuZCAzKSBpbmNsdWRlIFFFTVUs
IEknbSBub3Qgc3VyZSB3aHkgTGludXggZHJpdmVycyBtdXN0IGhhbmRsZSBjYXNlIDEpLg0KSW4g
c3VjaCBhIGNhc2UsIEkgZmVlbCB0aGF0IHRoZSBwbGF0Zm9ybSB2ZW5kb3Igc2hvdWxkIG1vZGlm
eSB0aGUgZmlybXdhcmUgdG8gZGVmaW5lIEVGSV9NRU1PUllfU1AuDQoNCkluIHRoZSBwYXN0LCBJ
IGFjdHVhbGx5IGVuY291bnRlcmVkIGFub3RoZXIgaXNzdWUgYmV0d2VlbiBvdXIgcGxhdGZvcm0g
ZmlybXdhcmUgYW5kIGEgTGludXggZHJpdmVyOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtY3hsL09TOVBSMDFNQjEyNDIxQUVBOEIyN0JGOTQyQ0QwRjE4QjE5MDU3QUBPUzlQUjAxTUIx
MjQyMS5qcG5wcmQwMS5wcm9kLm91dGxvb2suY29tLw0KSW4gdGhhdCBjYXNlLCBJIGFza2VkIG91
ciBmaXJtd2FyZSB0ZWFtIHRvIG1vZGlmeSB0aGUgZmlybXdhcmUsIGFuZCB0aGUgaXNzdWUgd2Fz
IHJlc29sdmVkLg0KDQpUaGVyZWZvcmUsIEkgd291bGQgbGlrZSB0byBjb25maXJtIHdoeSBjYXNl
IDEpIG11c3QgYmUgaGFuZGxlZC4NCkhhdmUgYW55IGFjdHVhbCBtYWNoaW5lcyBhbHJlYWR5IGJl
ZW4gcmVsZWFzZWQgd2l0aCBzdWNoIGZpcm13YXJlPw0KT3RoZXJ3aXNlLCBpcyB0aGlzIGp1c3Qg
dG8gcHJlcGFyZSBmb3IgYSBwbGF0Zm9ybSB3aG9zZSBmaXJtd2FyZSBjYW5ub3QgYmUgZml4ZWQg
b24gdGhlIGZpcm13YXJlIHNpZGU/DQoNClRoYW5rcywNCi0tLQ0KWWFzdW5vcmkgR290bw0KDQoN
Cg==

