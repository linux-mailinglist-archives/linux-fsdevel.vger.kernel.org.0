Return-Path: <linux-fsdevel+bounces-50021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ACFAC7665
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 05:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779497A981F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 03:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F52206A8;
	Thu, 29 May 2025 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PiVRCPSX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PiVRCPSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9970019AD70;
	Thu, 29 May 2025 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488721; cv=fail; b=ofXxVQzJlxHgFJ6PHg8wCJgxST8h5vdgvm+llZKlQcfsJ8uOvW63nz4RAh9+zeKJrPs0WKLjehKGKpflZqyhnrTXRWXii7nEqjRZIEJqJIJ3sGsmH3srIcLDzpdwCLG4rvgZmeYgbOYnjkWuf5+SThB42veAtyClG8+XLfDqHcc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488721; c=relaxed/simple;
	bh=kfzPwC7HhOQbfBwbe2Y5lrxi0dDd0HTPURS2heiknWc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WUruwyoldeHvK62lPyVq+5KVFBHY9DpySFtfAF9uldJY2qY/dujBqvuxh/UjpHLw9U5CBS9WIXbjN2fpbX1N+CrcJi0QVkEL9UKyfO0Hmc14VkNZcJkbw73yccUCHQvAC3MruxO2vBqYLeWIOYyIZhPiTLeCOM/8oQ9BW/FLgc4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PiVRCPSX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PiVRCPSX; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bb7oiL7JU3vTe7X73GF1mMNamhfUm69MCFBo2gF8ODT3JoHa5ABOzD6yy/oVmBnovc7f23ywyWd2RAzti/OjytcmIhif/cZmZ8KgWeKU357ccpj5z8lNFY7KR6oxmYcTbp6gGdXH1SyHbU8bP+CuQH8F9bOjXypftB7Nzkiz+1BlZo9YMV+IwN3GeCcKXClCNAy7kCSMSPGLygTEr25bqP9pP2zTsrlOU420xxLaeiAzpTwK/a4ZDOiIeMoBkLEWfXyxZ6lSs8l4E6Dx0q7ST9ufuUQR2h2kXmozWLMKnuHjAWjLPuoVLqbp5eigRxlpL4V26UxY6f/nXHrxJtkvuw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnedoxCrpI1DRW6Ssi7WNpbAjOX9ua34do1t/aZcQDc=;
 b=y4EDx3hpkzLrcyMIHv8R203x+/LlcJGPKGCOeLscEPn5EF+mCb4YXMyORDkLPD6raXzWlaHswVkdDSRogsWkvR0sQXksyim4/o9SKj/+7/aqjcAL/38v/t+CVZD9/QTYPBCfFUpCj6umNKWtyEWGf/4BRE5UMoe38vR4IHa/WDFN/C4M6l4I9mrqTQmhMQbjp4WPILYhuCny2UO6IutxFiuidy+eU73WXz4FESwMKW7sgyngrgGrfNehY6iapSEOI1P2irnvCCszENJQAvqnJMWsESEJ8t3KCfgTWUkTZvk4ssqZdsp8FcfzmAttd8zIG3xy8z7J5HtJFx602TOwVA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnedoxCrpI1DRW6Ssi7WNpbAjOX9ua34do1t/aZcQDc=;
 b=PiVRCPSX7KcVD7ktxHbLQ5kai9GflzFqPftLBM/eo2IJUYmfh3+uvT2dU8Mh4pAHLFblvbiRgoKNgz08R3UwmnbVjsbOQLPoPxQktG5yWC1HK0Mrm6qAJvQlJj34EU9B7ttGUbhkUsonOGQ19Tx0UAlazjKz29vW0I2wsNzvfK8=
Received: from DB9PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::8) by DU0PR08MB8884.eurprd08.prod.outlook.com
 (2603:10a6:10:47f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 03:18:33 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::ee) by DB9PR01CA0003.outlook.office365.com
 (2603:10a6:10:1d8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Thu,
 29 May 2025 03:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via
 Frontend Transport; Thu, 29 May 2025 03:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhCjtPNQ8BNLmuzk8CAX5QqWQJa01LsiAuDTSOWmPsOak1NZM3nF4kwHwJkY0+ioO6egBRzX5Wms6+U6keYpRvxL7NZMiZNqlu2NpdXRTjPOc1WHTYPhPthk8ixxhmWpAXxZBtjs98mJHf3A2vvz8u3eKIwFTCDMCK0E8q75g+jgmCcbonCxh4Y8KtNtEPK9Eo7SDdulO76BV9beYIq4Y4VPY5nt1jT3i6ZHmcFT62N6udGcMT4reP3aaPrza8uPutyxYNjFVPONjSKM52Ph2PIv1BnA8s5TYi9SfDwNC6nca4pVcLZeR5adZGhhWARUzWcYswPxko23E7Eei0qzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnedoxCrpI1DRW6Ssi7WNpbAjOX9ua34do1t/aZcQDc=;
 b=nU1inYdzT2jEAzlLI/DvA4AWBkvtI0zBAgYD2BobjV8EdrTx1N0b/NkkiDRnWUqWe9wyR/67Z9CZ3LaY1R59q0bhHrHzlEDJTqngvxEy0B9WYFRcN6TpstEfiz9oqNNWm+7Qm/OSzbLBtZQanTJNQBIzlanNat39xqkl+rFjf4Mfsf4SA6hZlkvwlSJMwnKGQ/l9a4KmUrVdsCiBc7pqiEPwhcx0w/Jy2C3PtP0jQmuhC2IwBaGcxr9LoEg/15/UdpNy2pM75FjJAXljv0TLHt2szkXZ8Py3up3IELvp+DWnA9cpnOw5Xu0+dp13hfeEA6XBqNY1kMD4yxri43vAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnedoxCrpI1DRW6Ssi7WNpbAjOX9ua34do1t/aZcQDc=;
 b=PiVRCPSX7KcVD7ktxHbLQ5kai9GflzFqPftLBM/eo2IJUYmfh3+uvT2dU8Mh4pAHLFblvbiRgoKNgz08R3UwmnbVjsbOQLPoPxQktG5yWC1HK0Mrm6qAJvQlJj34EU9B7ttGUbhkUsonOGQ19Tx0UAlazjKz29vW0I2wsNzvfK8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DBAPR08MB5782.eurprd08.prod.outlook.com (2603:10a6:10:1b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 03:17:59 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 03:17:58 +0000
Message-ID: <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
Date: Thu, 29 May 2025 08:47:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::17) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DBAPR08MB5782:EE_|DU2PEPF0001E9BF:EE_|DU0PR08MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6add7f-ed56-49fa-6c7e-08dd9e5f7d70
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dzF0QlVNMVIzMmZ5ZmxLYmJPVld3S3BZQWMwMGJtcFBFQUZrOWg3MWx5U2dQ?=
 =?utf-8?B?MFhWejNkbkJ5OS84Q0hBSDcveFpJaVI0dlFoV3RiZVQxajc3NlVyTDRuM1dG?=
 =?utf-8?B?NXVaZnB4U2VmU3pFbVZNb1JlMk1yWklVaWE5SUR5OFZyMVp6QU1QVkJwQWNL?=
 =?utf-8?B?TXZmN3pWY0FRVzY2VllpWXN5V25LbFR6VGlhYXYxZEZqYTNMdjdXQjFYRTNX?=
 =?utf-8?B?K0ZmWWZhdS9MRC9pK3J4RUlQMGl2WHJHR1JHN2EzZVZ5QnlkaXBwc3Ewckxu?=
 =?utf-8?B?R2x2c1ZDNVpCTDZXR05sMGVmVHgvaVpIM2ZCQVl6WXlmY3k2STNOM2J4blQv?=
 =?utf-8?B?WUxHVTFuemVKdjlRQ25Eem1JekcyV1V3M1h5YkJkU1dwYWVtRzVOMU1adUJS?=
 =?utf-8?B?MHRNV2RPai9kY2FIbDdjU2dTa2Nhd3JwNURYVU00VERQUEQ2N1ZVSGlZdytM?=
 =?utf-8?B?YTc5U2FCWGEvZzdzWUFyRUQ1b1BXL0J5OHk1eHlFMHRkTzhkYXlvTmpGWi94?=
 =?utf-8?B?ZUlIeElydWVmRExZdWQreWpHRlpPeURMam5EOWFXa3NRdW1aUzZJVU1pWFJB?=
 =?utf-8?B?NXZnSjZJZzV2WXViTUtiS1M4dUhTd2ZWTk1CcHh1SjlQTWdlTmpwNWhMUUFk?=
 =?utf-8?B?TUFkcFkzMkV6clRHdHYzMGN3V21KTkgxM0lsUnRqL0N5UUVQL2FvaS9XTnlP?=
 =?utf-8?B?bDZhbTJ5MWh0cTAyZTl4VVNTRm94c25zWEJBMkk4bzEzWmFvYW5LV2ZMbGlL?=
 =?utf-8?B?VkRaUWIybVpORlFDRzhiSDZEZVAxeFJqYUhPdzA2KzQ5ODNQQmNjbzBnNWQz?=
 =?utf-8?B?TXRyVUhrd1NrbXNqS2YwY1pvaWo5V1l2QmZsZjd1MWdDSU1IcU54Q0h6SG96?=
 =?utf-8?B?UWlOb3d3NVRUSWVwd2RheHkzQmhhOG1KRStoNUdLUXVWVVBLcm9QRkxGNmti?=
 =?utf-8?B?UDNWcEJoR0ZxVFoza1hYdlRDbmpLbDMxekpmbXA4cFJTQWVZUHlIM3N1OVNq?=
 =?utf-8?B?RERWRlprUFhNVytTcHdnTWdTcWtuajNEMEQ1R1puMkx4MUFBQnQwVDgwanRF?=
 =?utf-8?B?RlIvZi9KVDdrcVA2ZjRYa043bGluUmJxR1drNldxQ2pkRUpzTkpiZ2plQjcz?=
 =?utf-8?B?TWs0c1U2RlhhTFcyd0dWbTRzcDRUenZmTkVEY3RlVE9FNU1mbDNkU0NsbmRD?=
 =?utf-8?B?RGJ1aDU1SWZoS2JhQXI3TXdqdE9QVllzQnhsUElIK0l4NC9CT0NhdCsyOFZ4?=
 =?utf-8?B?NFppQXN0QlIvcG9wYmtMNmpRcjBZbk1CQXRSNjJxdU1qZytXbWpGemxiOTdq?=
 =?utf-8?B?NFU5M1kwb1NZcVNBMHZZNVJQRjNNbFNTUnZnM0pNMlNIZTU4QlE1bS9qbmFV?=
 =?utf-8?B?S1R3Y1RhUFpuc2JwMDRkQzBzTExDcHdOYmVUSHVtcjZQK2JsSVluQjlLRU5V?=
 =?utf-8?B?TmsyZmpZVkVCZ1VIdGNFckdGTWl4VlRUY1dPcGE2Z0NIWDF4WWxqOVVlOE1B?=
 =?utf-8?B?YjdoRmk2YjZaamR2YmIzNkJkM0tUVy9Qa3Z0TmxMbkcxQTQ2czJQVTRDSUti?=
 =?utf-8?B?dU0rUVFiQm5sNkpXYzFoWGpQNHJXUXdWSyt2Sk5HYU5NVUVxalB2QzZaV0pR?=
 =?utf-8?B?TEJQRnpKR21uQjR1YXN2Q0xsRDhMTDF6ZlpxVElzc1ZEZUUzNGh5Uk4wY1RW?=
 =?utf-8?B?OXIvenk5ZjBXWmZKcThuYzExbXA3b2lqUUZkNURkTzBvOUJLRzMrZ1JkMUwv?=
 =?utf-8?B?cXpreHlWdlN4MC9lRkJOQnpBd3o4Q2RzT3g2TnZjSTB3V0tINHRGQzg2R2J0?=
 =?utf-8?B?RzFjYVZScHVHbzVxQWZFYUNxY0dNdjI4NG1uWUtJNXpZMDc0VjYwdjYxMW1z?=
 =?utf-8?B?VURlZXBvdE5PRmJxMWp3ZWtLVDAyVHVBdDk1MGh3REtIQjEyVmdDVlVMamtC?=
 =?utf-8?Q?UyWG4NsX92Q=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5782
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	027a2803-0e72-4915-cd21-08dd9e5f6958
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|14060799003|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VndUU2tlS0hOOXdyYnBKVmw2VXN2UzYzR096aEp5L3JWeWp3VUh5K1Jjc0ly?=
 =?utf-8?B?TzJaTlJIeFFxaWFUenhHcHdjVzlDYVlIVHlhYkNQeGppL1VLUFBDNWEyY09U?=
 =?utf-8?B?U2lOUWpQNHV1dXQ2SFpJcDd6aUE5R0c3YW1OWFNxL2hEeFRPNG5Dd1R3Sjgw?=
 =?utf-8?B?dU4xaTBjZ2J0RDJZV2g0ZU9FNFE4WVExY0xabktHNjBlS2Q1U1EyZWd1WnQy?=
 =?utf-8?B?bStyVUdvMzZkZjRYby9uOGcyZVhUWElOTWZsRTUrbkg5TkJtWVdqMElLT2Ir?=
 =?utf-8?B?WVhxY2FGQU1aczNFSngzQTdCUGs1dTl6bVJHUWQ2MlkvRUxoeDFyaVJDdkxY?=
 =?utf-8?B?OGdDY3FRZGxLazZaaUpvbGtwR3dBcWJlTXVmTEFKMldXOXZub1pZR3hyMjkx?=
 =?utf-8?B?T1hsc1M3ZE5ZRGF2U3pYdUQzdTNtWm9QL0pIWEVBSFNQWnptbTh5MGgveDdq?=
 =?utf-8?B?aDAySmVqYi9TOFEySVhzN2hJOVl0aG84YnA4bVN4aU4rOFIxVDFIcU03Tzcr?=
 =?utf-8?B?bjBUd3dvY2NXQUZTb0ozTGxtYUQrSFA2amg2VHpod2t0ODc2cGFKRTA1WXBi?=
 =?utf-8?B?TE9aODN0WW5sQmpkc1FDTHYxdVFnQ3RnZnphbVI2bmxsb0wvUS9uZ05FYkYr?=
 =?utf-8?B?bTg3WUlrcW5DL25ZeFZaUm13Q3RCOTBHZnRJOTJQdGZ1cUZwVDMyQ2dYeTFE?=
 =?utf-8?B?R2NHcWF0aVZLeFZlRGM2MmZkVyszb1NTWjhtTXZrcFprVnRlRnRVNTIwZlhY?=
 =?utf-8?B?b2x2cTgyd2YvUjhZVWdTSmFyOHRsaXdQN1FYWldSUkNReVBlRzJBUWwwNEpV?=
 =?utf-8?B?TFp1QWhaaFdRNWQyTjJNZWZENEhidzNaU2NvMW9lOU5BdG4yUHB4N1RuLzdJ?=
 =?utf-8?B?NU52YmhsdzlDNUdidVZ6aHBWaFU5NStLMzVzMUVRZjlkZDZiUnJER2U2c2Vn?=
 =?utf-8?B?MWxvWm02M1RxUE56VVNNMXpkK29KMExyZ0Z1dEluTVNUZGpqbGtMTW5HTlRR?=
 =?utf-8?B?dENuU3huZ3hLc2Zyd051bU15MU4vVGM4VXFZN1ZwYzYrcmRKUkVjbkVwTmVp?=
 =?utf-8?B?MndNZ0ROM2dTNDlmVEhLZCt1OHVXWnB1cHRuWTdOQk02RkxjTUpxNER1MFBP?=
 =?utf-8?B?RVhxYXR0T2dtVk9kNTlXM1ZDeXFnTWhpbzlKamR5a2dJeENJNkttS05OSGhw?=
 =?utf-8?B?cDRaSjNSZkgzSnJrNCtPU2orai9rYVRIWnVqSDJhOXZyNk5VN1JwRFBJams2?=
 =?utf-8?B?YkFMTWZ5emgxaWhTLzZaZDVWczdHTTIxNjZUTW1kNVRtdEs0V3ZlWmFVMFRv?=
 =?utf-8?B?QnNLRC9Ock42VlpYOEF1Rkp2bmllNXV4VjJ3QWE5MDBpOWxpUjVHRVZDMmJG?=
 =?utf-8?B?SndMK29uVXNHSE83MG85S002blpQczFIUVJKSkFBaVpCYzlpQWtCaDhDanI5?=
 =?utf-8?B?MU4zb1REbnhGb3RncG53aW84ek5NSWRUKzR6UkdJSWV3bkVsUnBxSTRpRXFT?=
 =?utf-8?B?TkcvUG9GWm10Umg5dzVjc1VucjlSZ0hXSk4vVE1BNXN1bTRFbE9ONmhOR2Qy?=
 =?utf-8?B?OXF0c0RMSkM4OUNVZmh2a1RWbkl3dDNveHZTYWxmUlYraTd4NXFlejVicnlH?=
 =?utf-8?B?aUZXZVNXTVYyQ3hhUnBqMjZwZjhNQ0tmT0RVbUl5disrRHhRbVc4aWU4Y0Za?=
 =?utf-8?B?VENjS2YzZFQ5WlQ0dmxrTzhmdnVMRHJ3Wnk2cnp4Mk4rTjFaejJZVTVmL25L?=
 =?utf-8?B?SitXVUlnK2U2Zm5GTndrSncxaHFIQThoU2ZLZXhwSUltN0M3aUQyQkxqUnBr?=
 =?utf-8?B?V2Y0dk9qTEpQbWZoMDBXd3VBYTkxTGxmeDZFbER2MG5tL3FTbHZ5aEd3aDI1?=
 =?utf-8?B?RzJ5Wi9hMUE3WCsrMmI1cUJjeWRicDFJbnQvRnd3eU5ud1lJK2wzaTByTnkv?=
 =?utf-8?B?VXVwSkNmN3FWRWJibzNuTlJNbTlrbmxJbENBM1ZTK21CNWRwRGM4V0YxVHRa?=
 =?utf-8?B?WHB4VzdIdHdWbTdWVFJHeWlUQ0I5djhKNURJcTRPUWNsYmp4M04vRDd2d3lR?=
 =?utf-8?Q?sbSojh?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(14060799003)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 03:18:31.9068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6add7f-ed56-49fa-6c7e-08dd9e5f7d70
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8884


On 28/05/25 10:42 pm, Zi Yan wrote:
> On 28 May 2025, at 7:31, Dev Jain wrote:
>
>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>> Then it may happen that the computed slot already falls beyond the batch,
>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>> order. Thus ensure that the caller is aware of this by triggering a BUG
>> when the entry is a sibling entry.
> Is it possible to add a test case in lib/test_xarray.c for this?
> You can compile the tests with “make -C tools/testing/radix-tree”
> and run “./tools/testing/radix-tree/xarray”.


Sorry forgot to Cc you.
I can surely do that later, but does this patch look fine?


>
>> This patch is motivated by code inspection and not a real bug report.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> The patch applies on 6.15 kernel.
>>
>>   lib/xarray.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/lib/xarray.c b/lib/xarray.c
>> index 9644b18af18d..0f699766c24f 100644
>> --- a/lib/xarray.c
>> +++ b/lib/xarray.c
>> @@ -1917,6 +1917,8 @@ int xas_get_order(struct xa_state *xas)
>>   	if (!xas->xa_node)
>>   		return 0;
>>
>> +	XA_NODE_BUG_ON(xas->xa_node, xa_is_sibling(xa_entry(xas->xa,
>> +		       xas->xa_node, xas->xa_offset)));
>>   	for (;;) {
>>   		unsigned int slot = xas->xa_offset + (1 << order);
>>
>> -- 
>> 2.30.2
>
> Best Regards,
> Yan, Zi

