Return-Path: <linux-fsdevel+bounces-39336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA10A12D5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 22:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1481885462
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7FE1DD54C;
	Wed, 15 Jan 2025 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G1dBD5d+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7F1D88D7;
	Wed, 15 Jan 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975255; cv=fail; b=gpO/4FKowe5dQ0k+nnivH7QwJTgfszXSOGJZwIrD1X7+EECa9Kov+ySasbbj9fa7KztVkopP6E8iHze9ECITkebTQWHeLZMDnAg+jShUwRKeTmj+FJvpTgn4UvEWEWYrpo9Sjm01YI1AoTnBXS1OxZZyK61Yo/RL4kKr0LfKhNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975255; c=relaxed/simple;
	bh=q2z0d9AHaYrIa6/u5aTMcZyK6moW/1ZH9kveojHwyMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1jY/pj+sIQYIAWyk30opGlJP/sdcOko+Pc97+sQAeBvQfAOsW9mEUPH7q/CIhDYWX8IlPe+IzMHnQWMDSLhAFRtMhudxlW9TDLCDIQg1bDl3MPSSjDJCRFWdh7RkRjWL32hU9nR3NRq5UWiuFTzmOyoYGTZSwq0mtqhZdH9UAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G1dBD5d+; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCVg8h4zD2mau2r9RD9GLFB81fi/gQOeOMw4efCYk3yzffx9VhmBk6/rJCcibPkhdkwvgkJCH2PJATQpguNwyruCzPfaOeVdnxJHKs6TraPntAbRPOonEPxKq+AC7IsGExWM5q8Fwpd8UFgQUpKkLS7oa1Yvo6MHyhLeRFPMrCuc2R6BOV+BacMiA2zmZ2Y2Jw6Vl8lZMzt39Rzarfg3I0l/dwkcX2u4qThw26lC/srDRjDtCJyxYTblmlZMUJ0EHKcqEGFultV1WqtneqVExaAZBTNXPrhKtykMHcK6zszfRdInY1ubY8NJJL1MPzTqABoAzonqwgqr9WFd/hbzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2z0d9AHaYrIa6/u5aTMcZyK6moW/1ZH9kveojHwyMM=;
 b=P3WYIqUcLWXCTBtLHnS4FFlr8b9IJ8k1zPsXMngb7807Z9Q3KuqYzdIs2gdcgg9M3tAZAe61uWHTeAjJnOS9C/Pejw6lAmVgTxKvJ8AdjnbcgrhfsxnyEgGMGrse+VN1YLQRTrq44hzVw/VM2h26vGndgb01A9ftNncY0TEjpurCxLkPmfR3hiEFj2iencppP7AfM3Kk0zYFE8gQivOiRoJL5ECjgtHEmdvOUWK79sXEFSPP7FjpkfFOo3z/rwipDvt+jnR1QJh0nSCP+hwJ/bI0eBihiiWsMLfrYT5C1gW4YFIs5qjwfFvJwBTuhkZIZpo4l7b56oT0fbso0Ndo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2z0d9AHaYrIa6/u5aTMcZyK6moW/1ZH9kveojHwyMM=;
 b=G1dBD5d+2LcZ7mVvkTEd/8BfWrphcD/DBsPHUwWG2jLScPMsFoNtg383AJx1XRRw//tdhj/dYvQMl1hAdDy0aGX07tbe0mMGMA8rEKWA3eFbjtvzf7BjJ6v5ZRY1fbBOqhICCutK2izoc1a0GtRzlRb1zRk5Rm2lu0F8GllLOvX3kufHN6LozoFLpREHdYtreJIxm7r+lq8RSJ0GHwBWAx54gnC1PN2LC/M5tLNSRwn/qg07wZQPgc6g2cUC+BJgjD4OkLLPHgrpwzQI7U//PomjLz1ITPGS6KM02iXQuwRWqso8GNoQQo+GV1B35BSNgTjbCr6Cw0t9HXygdqwkLQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 21:07:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 21:07:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>,
	"djwong@kernel.org" <djwong@kernel.org>, "yi.zhang@huawei.com"
	<yi.zhang@huawei.com>, "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>, "yangerkun@huawei.com"
	<yangerkun@huawei.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [RFC PATCH v2 0/8] fallocate: introduce FALLOC_FL_WRITE_ZEROES
 flag
Thread-Topic: [RFC PATCH v2 0/8] fallocate: introduce FALLOC_FL_WRITE_ZEROES
 flag
Thread-Index: AQHbZ0QJnN9JMxAGd0WQ00eLUDP5bbMYVG8A
Date: Wed, 15 Jan 2025 21:07:28 +0000
Message-ID: <ccebada1-ac72-468e-8342-a9c645e5221e@nvidia.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
In-Reply-To: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB5714:EE_
x-ms-office365-filtering-correlation-id: 26fd8b49-665d-4509-c083-08dd35a89eb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1ZrRTNiZmhHckowZWo5bW9QNkdIblFZUXNSMWNzZkpBZ20rOUVzcS9LZFVu?=
 =?utf-8?B?Z2dwVjE0S2dhRXhPbXpWTkxFWE1vc0NOU0ZJNW9YV2JZUHVzT1kydUhxekJt?=
 =?utf-8?B?MldNL2EzRC9GaElNajBsVGZRZWhSNk9ocy9Vc1J3R0puVm0yV3l3Sjh1ZFJP?=
 =?utf-8?B?WmFHRzRmbzdIa3BmT0ZFZi9TTVlFT3Uwby9iNkRQc0lGWlhGRkFVd245YzFE?=
 =?utf-8?B?MnZZZnpkcXBXVXNWMnZTYUdITWwvUXV5ZlNjNk1OMytIbEVMVmp3TDF5OElo?=
 =?utf-8?B?NDRuckhLcnFGYVIvRDBubGR0MW53QXBZdVA3QVlEOWlJcWgzQ0xKMGx0L0xw?=
 =?utf-8?B?OUNvbGdLSVpXQ2lVcngvZytQS0lUTWVlc1BCOU91dlB2OGNtemJyMmM1R2xk?=
 =?utf-8?B?N1R3UmF5N0NxZ0FEeG9jN0tvUk9lTk1DTndoYjl5K25paFR6OW1PWTExSHBB?=
 =?utf-8?B?dnVsYXZjN0ZPc3BFeHdhSzgvMWtJUWE4UFN6VjN2bk1acjhTOUh5N1hnRnFD?=
 =?utf-8?B?bVBlTERDNnEzbzMxL0diMGZXSGdwQzd5dUZLcnlDV3RzdTU0L2ZkNmI2YVpY?=
 =?utf-8?B?OEkyYVVYWDVRc2IrYWlOYzFXY20xQkpjKzJhSWRSdG83V29SOW1raG52NGky?=
 =?utf-8?B?SVc2NnUrODZTSDdvcmZleitvNW91Rk0yVm9YekdoYVVxcHNWOE5pMVRTSHNY?=
 =?utf-8?B?c1dxQUJHSVlPMUxjbStPTnJCNzNJek5ZeDRCeCtJVnFkYzZqL2tKa3p3WkVV?=
 =?utf-8?B?UmxWK2JyYUt4MXo3Mk1Xb3E3TjdyUDVIMFhJbGwwODliMjNGeUpVVzI3R3g1?=
 =?utf-8?B?dnBOVGtwWDFzWnFJRUhnYnltS2lrKzJ3U0xxNUVyeE8rYzVjYkluSW80N1Y1?=
 =?utf-8?B?YTFCZHFXUE5HZDdLUTRiUnVWYWpkdHRpNkdQRS9tKzl0RTE3VGkvdSs4MXpR?=
 =?utf-8?B?eWtDMXZkQWU1eFU0ODE3TXVVR1BscmdwMXR0bXBvbFNWKzBkUndDa1RJckZm?=
 =?utf-8?B?NzZqeFpBdVFBajVEZ0l3ZnRQUlpFbFc2SFZ0QkRiRnBZemdlQWJqTjFTMW1s?=
 =?utf-8?B?d2lnenZXcHpWL2tTcCtOTFg4QXkzQjY4THFFc3NQOTk4SHJTSFErdFhFdldx?=
 =?utf-8?B?Q0ZOd2lod2VsNHJZMTRoQ3RKR1B1TmZZSTVMVVkvMW5zczRSMStJM25HMGxz?=
 =?utf-8?B?MGltVE5xSmpTY05WRnBiVnVEWVlBQllYVzZvNmFUbVNLYytoRHgzK2Mvb0Y5?=
 =?utf-8?B?SndISFNlVXBtU2pyTCthc3N4QjBURGxKS3pyQU5jM2ZvNVlhUjgrd3RjYlVC?=
 =?utf-8?B?VDYzamllNjNucDVxNUE3QzM0QkdmS25XSnNGQ0p5VTBCb050WVcwRk41Ukda?=
 =?utf-8?B?U0ZpWW4vNHEzcDlUNTgyU05vTkNNRUlnNjZwaW5qckhKTnNETmZvVjRlU0h6?=
 =?utf-8?B?OU9WVVhzRzlmTy82TG54ZzN3aXEyQ0cvZVYzRGdxdTdmOVFjWHB6Y3orU1lZ?=
 =?utf-8?B?TytLclptWnhZSlFTbEdpa2tkMGZEL1h1SWJVbXg5Q2t3S0VmOGRRb3BjcStw?=
 =?utf-8?B?NmlJSXhzT1E2SXFVVnBtUHlTYTZSMWJzbHRCcyt5eGwvRnIvTHZoYmZvYStJ?=
 =?utf-8?B?WlFEazF0dEZ1K3BpL1N2MVB5cXlhenYwTi9CK3hOc2NiU2JqSG1LUDBoMndD?=
 =?utf-8?B?NGxENDdlV01KSWVRRXVGQmMwYnBmdDZ2eFlJOFBvVUhjYlUxQVp4OWdPRVJ5?=
 =?utf-8?B?UUN6ZTZJY28zb2ZTWmhHQWREeHFTVW5Wcm1obEZ1UllWdGl1SEdTWXkyWC9J?=
 =?utf-8?B?UlpGeWFnT1hjNmQvRUZmZ0k2YkZKSzFUUlQrcWFLRCtQNUoxTjBjMFltUE1K?=
 =?utf-8?B?YjhtWlpiTS85dXQvUEVFTk5IY3dwc0RpSWYvQ2I2ei9CbGp2TncyV3d0ZjM1?=
 =?utf-8?Q?TEkVGbEvwTsjdRF+ZNz6F8qlObd7U6rz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T21xSW1CZ3NNYlZ5bFRUK0l4ODFRd3FUZnYvR2pUUVBvNFlmWFNhRmJXWW9L?=
 =?utf-8?B?cktraG5LaFVIOHo2YndNNW1sWjF6UzI0NjcvQVMwQXZ1Y2FBUXU3TmlRODFs?=
 =?utf-8?B?NDdVdEJZeEVIbzlLa0xINE5TWW1ycmxrblh4Rk4wZ0ZpWUd3OUVHM3lwTWJw?=
 =?utf-8?B?aDV3Vm1XcUZxMDFHUk5CS01HMlpmSE84UDVLSG5zRWp6K2tiTVhTdGhadG9G?=
 =?utf-8?B?SnpOLzlGd3ZGTzJxelloWUtLa0d2RU05cnhaNTAxaXVtbDB0TW1ueCtkYjNa?=
 =?utf-8?B?c2QxTWhjQXNqRndHcThFZTRHeHFoWDZSb1VXVXErZmJSRkNxQ2piRzFjQ0ZC?=
 =?utf-8?B?c2oyNnF3WUJCWVRLZlBVd0F5Wjgrb3c1VHBMZzg1WFhNalRza2JnZmVkSEtE?=
 =?utf-8?B?c2wranIyQndNK1VvdXgrYWdDVzVsbUhacjZzcGZVOXc1UnNMSTgwZTlQKytC?=
 =?utf-8?B?NkFKQ0ZKS0RkNnNtbkVRUUkvQmExL1dkV0duNGhSc2gxZ1VQa2ZVaVU5WCsv?=
 =?utf-8?B?OElXSFgyRHhVQ291L3oxaWl2anVDbmo3ZXhhY3pTL3lIWkx2VVk0dTNCVWRq?=
 =?utf-8?B?Q2Z3UXprUUo3c1hBNjZ3T08wUWc0ZDNVVllwa3M1cVcyTTJ1eTltRkw1clhz?=
 =?utf-8?B?U1MwUDdFVjlXSnFIcDBQOGZuZlpMdHRCRVZ5cXJpUjl6K3ZlWkdvSDJWMWtu?=
 =?utf-8?B?YWs5ZC9HaGk1TW5VRFNaaUtrRHJ5UTFKWVFOTldBRTNwTmJwV2xrNHhQaW9j?=
 =?utf-8?B?K3hsSHNsbGJydjFEMmpJWjAzS1o1alhYZ3NCeDRxWW9zWlRSZGUvaHRYOWtw?=
 =?utf-8?B?SkdqVEorcHc4SWx6RkdWS1B6eXlKRzFWdlVSMDR3Y1ZXVzh0REllR3ovRUFT?=
 =?utf-8?B?RWp5Q2xSbmcvNTdGdWNuK2hpS2twYmxNUmZVMktxMTRCL2hEV3pHZzNzc2pn?=
 =?utf-8?B?RVdWNlNQeUJUT1hHeTF6N0c3Qng1Um5QcFR6VmpMYmFnbi9remthVTBkMzEx?=
 =?utf-8?B?aW9rdjJONDdLZEVyOWRWRUtweW5CMUt6b2N6SVF5Z0swZm9NQ0VNdUR1K3Fa?=
 =?utf-8?B?bk5RSVZqbG5ZUW53REZqTFk1Q2ZKelFPbzNRczMwYVUzK0htZUtZbFFZZXpw?=
 =?utf-8?B?L2lVUFpVeHM0dHhtaW1kWEdDdmNHbHEzUGtQSm5SRFlwUk05eXlKdmpWOG1h?=
 =?utf-8?B?QWVPRlFPcGRqZDRrY1dMTncxakVXMUVjVUNTaVpadFYzcG82L1VUV013cnd1?=
 =?utf-8?B?amo4REFFd2pmTDNLM0EzSzlUVHhEYjVzWHV5bDQ4bnpleXZ6WVlGZ2RiUjdh?=
 =?utf-8?B?UDlBdjNvODlUWk91eGliSHdVRGV0d0ZEeVBZTU5CNlBzSFhqNnBEL21CLzlU?=
 =?utf-8?B?eWVWUUtnSkFrcE9tNzlySlJoVGRsSW91NTNMK1dZaXlmQ1dLQTRYRGNQTUhX?=
 =?utf-8?B?NG5iQzFSY05NZGlYa2ZWK05jaGwrWFcrYitTcEdxTjVtZHNDSENseGl4VVZB?=
 =?utf-8?B?eXJVN1BSNmRRR05nMjE5SDIzQzVLY3pmWGFZQTUyd2ZYMXY0aEU1RTVCSTRP?=
 =?utf-8?B?dGZFRjVrc01LczNMRis0K1RsZEovTlN2Y2NLd0RYM1pMZE01eHZYS20zUEho?=
 =?utf-8?B?bGRKMUlOVFNSMDFiOGNpYTd3UlR6SlI2NDJRUEZBM0c1SXFaelU5Q3dRaVp2?=
 =?utf-8?B?TGcrM0NJdzkzSjYzeVJLNjhvVUtNckMvYUQrMWtZZ3YyVzdpM2ljYkNha0Y0?=
 =?utf-8?B?UDZSZGhvNHcxbWtqRGdNbkVlY2JycDg3UCtxZytORmpYNkx3QUZxMzNOVGQ4?=
 =?utf-8?B?c0lLTlZXeFVza0hjczZ5RGxpbXBqU1RTYnZBOS8rdCt6MUpVR1M2RzhkUHI0?=
 =?utf-8?B?T1l6Mk1wVXJHU1VoV2xmejUxU1RYN2VHSDNWS09LRjJJZFEwZFVPMmlEMXk1?=
 =?utf-8?B?Y0hrT21tSUtpWVJlWlNIWkh5T3lTMFIzZTVmMDBDN3FmUUhOMEdpdm9paFlt?=
 =?utf-8?B?MnhLQk9MRWtkT3hvay9lcFJPb3c4ZDdhQk84dEo2ZTV3UFB1NGcycVVON3lM?=
 =?utf-8?B?bW5wR0NMM2VCSE9tWjhOeTl2b3pieEZ1WTVTdkdZYStUcXdpOEVObWcyd09M?=
 =?utf-8?B?d3M2VEFVRjdWYjBMcWFxWHlHYVl1VElQQm9WRSthdnIydXFDQmEvN1R6anRE?=
 =?utf-8?Q?+5Zh2YE+6wiQXqMi6eO1n7iqqBu0+RQdUhjmC49WX77S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B800232B8EFEEB48B658525552E22516@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fd8b49-665d-4509-c083-08dd35a89eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 21:07:28.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDbssn+JkdEFfHC2LfDe765AEyMLnAu8tcU+qslTW/nI4osTS8GYKkuk0MAWeP2thaBq8U+VOQqSDS/Ok8S/Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

T24gMS8xNS8yNSAwMzo0NiwgWmhhbmcgWWkgd3JvdGU6DQo+IEN1cnJlbnRseSwgd2UgY2FuIHVz
ZSB0aGUgZmFsbG9jYXRlIGNvbW1hbmQgdG8gcXVpY2tseSBjcmVhdGUgYQ0KPiBwcmUtYWxsb2Nh
dGVkIGZpbGUuIEhvd2V2ZXIsIG9uIG1vc3QgZmlsZXN5c3RlbXMsIHN1Y2ggYXMgZXh0NCBhbmQg
WEZTLA0KPiBmYWxsb2NhdGUgY3JlYXRlIHByZS1hbGxvY2F0aW9uIGJsb2NrcyBpbiBhbiB1bndy
aXR0ZW4gc3RhdGUsIGFuZCB0aGUNCj4gRkFMTE9DX0ZMX1pFUk9fUkFOR0UgZmxhZyBhbHNvIGJl
aGF2ZXMgc2ltaWxhcmx5LiBUaGUgZXh0ZW50IHN0YXRlIG11c3QNCj4gYmUgY29udmVydGVkIHRv
IGEgd3JpdHRlbiBzdGF0ZSB3aGVuIHRoZSB1c2VyIHdyaXRlcyBkYXRhIGludG8gdGhpcw0KPiBy
YW5nZSBsYXRlciwgd2hpY2ggY2FuIHRyaWdnZXIgbnVtZXJvdXMgbWV0YWRhdGEgY2hhbmdlcyBh
bmQgY29uc2VxdWVudA0KPiBqb3VybmFsIEkvTy4gVGhpcyBtYXkgbGVhZHMgdG8gc2lnbmlmaWNh
bnQgd3JpdGUgYW1wbGlmaWNhdGlvbiBhbmQNCj4gcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gaW4g
c3luY2hyb25vdXMgd3JpdGUgbW9kZS4gVGhlcmVmb3JlLCB3ZSBuZWVkIGENCj4gbWV0aG9kIHRv
IGNyZWF0ZSBhIHByZS1hbGxvY2F0ZWQgZmlsZSB3aXRoIHdyaXR0ZW4gZXh0ZW50cyB0aGF0IGNh
biBiZQ0KPiB1c2VkIGZvciBwdXJlIG92ZXJ3cml0aW5nLiBBdCB0aGUgbW9uZW50LCB0aGUgb25s
eSBtZXRob2QgYXZhaWxhYmxlIGlzDQo+IHRvIGNyZWF0ZSBhbiBlbXB0eSBmaWxlIGFuZCB3cml0
ZSB6ZXJvIGRhdGEgaW50byBpdCAoZm9yIGV4YW1wbGUsIHVzaW5nDQo+ICdkZCcgd2l0aCBhIGxh
cmdlIGJsb2NrIHNpemUpLiBIb3dldmVyLCB0aGlzIG1ldGhvZCBpcyBzbG93IGFuZCBjb25zdW1l
cw0KPiBhIGNvbnNpZGVyYWJsZSBhbW91bnQgb2YgZGlzayBiYW5kd2lkdGgsIHdlIG11c3QgcHJl
LWFsbG9jYXRlIGZpbGVzIGluDQo+IGFkdmFuY2UgYnV0IGNhbm5vdCBhZGQgcHJlLWFsbG9jYXRl
ZCBmaWxlcyB3aGlsZSB1c2VyIGJ1c2luZXNzIHNlcnZpY2VzDQo+IGFyZSBydW5uaW5nLg0KDQpp
dCB3aWxsIGJlIHZlcnkgdXNlZnVsIGlmIHdlIGNhbiBnZXQgc29tZSBibGt0ZXN0cyBmb3Igc2Nz
aS9udm1lL2RtLg0KUGxlYXNlIG5vdGUgdGhhdCB0aGlzIG5vdCBhIGJsb2NrZXIgdG8gZ2V0IHRo
aXMgcGF0aCBzZXJpZXMgdG8gYmUgbWVyZ2VkLA0KYnV0IHRoaXMgd2lsbCBoZWxwIGV2ZXJ5b25l
IGluY2x1ZGluZyByZWd1bGFyIHRlc3RzIHJ1bnMgd2UgZG8gdG8gZW5zdXJlDQp0aGUgc3RhYmls
aXR5IG9mIG5ldyBpbnRlcmZhY2UuDQoNCmlmIHlvdSBkbyBwbGVhc2UgQ0MgYW5kIFNoaW5pY2hp
cm8gKGFkZGVkIHRvIENDIGxpc3QpIHRvIHdlIGNhbiBoZWxwIHRob3NlDQp0ZXN0cyByZXZpZXcg
YW5kIHBvdGVudGlhbGx5IGFsc28gY2FuIHByb3ZpZGUgdGVzdGVkIGJ5IHRhZyB0aHQgY2FuIGhl
bHANCnRoaXMgd29yayB0byBtb3ZlIGZvcndhcmQuDQoNCi1jaw0KDQoNCg==

