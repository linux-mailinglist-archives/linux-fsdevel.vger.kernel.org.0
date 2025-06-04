Return-Path: <linux-fsdevel+bounces-50582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FDFACD751
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB883A6FEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC712620C3;
	Wed,  4 Jun 2025 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Psn3DMJA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Psn3DMJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690552F88;
	Wed,  4 Jun 2025 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749012860; cv=fail; b=QQx74HgY+OUBD8+GUdag5hZsywp8lBtnKlBdL2nAkAejxQGOFKVOb6+7nft1VtMsQtlqytSNE3unXKyeY0H8DNMwZr/KuATCF2QOH/6OwaCwbDO9FwbmHCaHLipLfdU0vUffiyPauH35HyXDIk4sxgfJcLPUtVTVo4l6V6YWUO8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749012860; c=relaxed/simple;
	bh=Y2vrKx8eoDCknGgQCvPrtYD0hVxn81WFPde4oKQ1cKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gi80DWBZPBEU5KcBMKpSQTOkEUrqK6dVOzeJ0WAMS11hHzABlIO6n8bC6ymgVSK/3InIPDEN1LyRrWrV7zwEw4ucbXKt8dZV0eOkM5P/bJseG4rLolNJV0bhFPKqvzt6VsXJ6/Ups2VnwtU2UN6TRMg27NE247I9fmn/leumR3E=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Psn3DMJA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Psn3DMJA; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XHfj6CjaaCBP8M+E+uTENLZrGnb5qxr5zKmHSdoWWr/cz1qAKyGYO7+NSBFAAB+lWlG4hf+H06NRo0LES4qojTV8Mo9yI6S8u92O4RDDgMqJ3n+WXCPp0WP8r5kD+hk/JlQ6nAkVvTJ7rXTePcgw3JnHAh75YApWGbSqkN0LJ+wSj4txsVjgOGeDGZdlrW+fe3AuxOWwFfKilw8mK9u3gzzfcXjWxlqViMLhvNHv/t7BhPkiRw0pGyKUFF1PP2I38lsH8QAecLG7gRma/ny7ocWj+zezxaxCpWGQCnxbIhl/9R0USEAam5yIHreGmFYiFV6X/cytQk5IxCvkz/HbXA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZHAgMXhZvyX2TUl4l43vzDQJt722dA92M/DA+xXbVs=;
 b=J+mrkJcWvvbdRU3ecEXxJvtojvwE+meupAf+jC3Ss4LuP8wtTsMBusSwt74QghDfmvSOqwKDYsdZKzxfE9/Ilqh4xGwsx5MQCyB4widyRZyWXyn8mInQq3gkmSrO7iMWrS8lA+maRGQRfUdbo4IL2MKqanFuoXxFgbP3ipTiEzaIHPnBf89rPiI5hUIPf7mUkwO3hgd8DNc6sbzPcpnCbFNw+j2YQr+tmkPh84eQamcxDp966SebYb8QOnOQXAeEbVd4w7YpLVg5tUMnW6MWElcL6NKXEdhzApMNOTzhlsVwRg5NKWEPkzvBgnUBijFeQeKiAwciCLcAEQfOivb6Iw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZHAgMXhZvyX2TUl4l43vzDQJt722dA92M/DA+xXbVs=;
 b=Psn3DMJAix8koc8Me8Hln8p1CMdSKo+6Ls70oZVHTXnrbUIo1z8y1PUrEUbX1bLIQVipCYLA3p9kHh3QX+ggomZ6uZov98KCp90PH03dEHGP5bJI9eb/s3/GEJRWx9U8wcMZZbfQH9Q3PGwgMmAOgWK8zKJZ3FiK3Z/yG4CaFdA=
Received: from AM6P195CA0079.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::20)
 by PAVPR08MB9508.eurprd08.prod.outlook.com (2603:10a6:102:312::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 04:54:11 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:209:86:cafe::11) by AM6P195CA0079.outlook.office365.com
 (2603:10a6:209:86::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend
 Transport; Wed, 4 Jun 2025 04:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Wed, 4 Jun 2025 04:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqUrcijLj4dgqV2gCRDhJo7OAEH1MYMaRd4XbTq5x1rSFkSJZMJpXR33oPdaBrmx7NrUP2IDX1me+lf702T/aBzM+EMtGWxUfb7DmqFa7ehhPtAHA54LsHdS0Z8yf6vY7OUXw9IvegWvZPg3rCe/JbpqoevrDghT0e9OoJGE4ut4GOEKiUEs+elXfHEuKdPz6Q69RerXaulMKbTVOcmQm2wJnOVMlBcl1ew8dHAsy44dYpFOzOF3Gg8wBrVWpQQgu9LEivQYHbV0zpo+i54U2Ls7WV0fNQMRKTOFKmKwqzV0WAoohZcO7aHN9HQZzM4ysA3KX8Cy0Zh0nOXY7qy0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZHAgMXhZvyX2TUl4l43vzDQJt722dA92M/DA+xXbVs=;
 b=FCXqA97kGSU0/EuHxzOOt/gcKg+FhMgon4M/69QktwqvzEaocQpLWR693IuVTTYZoRvSf6G0Pxg3sL77ALKocr8ARVtlu0nTTIfbcCx2YLodzgOh6TaoRrNRgbSxjzaMTh5Q9WOCZgmzped3UsgfJosvnP8HRRg5/1ySpvt1nTBmV+x3ohe0s+krtKRv4LkvFv+1dWXtIKwzYOyByS9zkD4cB1sJPYUN58FBXtqUnxXYP5Sav6o8yqN6a0d+81n3LFU0yUZ/lKxISIAcmdY5VcTihvtfuhtIzBLoWJQJSJ87N1nLUIrue+RxMzW3UimUW27MtYftgUb6Ny8xa3z+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZHAgMXhZvyX2TUl4l43vzDQJt722dA92M/DA+xXbVs=;
 b=Psn3DMJAix8koc8Me8Hln8p1CMdSKo+6Ls70oZVHTXnrbUIo1z8y1PUrEUbX1bLIQVipCYLA3p9kHh3QX+ggomZ6uZov98KCp90PH03dEHGP5bJI9eb/s3/GEJRWx9U8wcMZZbfQH9Q3PGwgMmAOgWK8zKJZ3FiK3Z/yG4CaFdA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS2PR08MB10055.eurprd08.prod.outlook.com (2603:10a6:20b:645::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 4 Jun
 2025 04:53:37 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 04:53:36 +0000
Message-ID: <35449e83-11f2-4414-abdd-41f6cd68b4c3@arm.com>
Date: Wed, 4 Jun 2025 10:23:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xarray: Add a BUG_ON() to ensure caller is not sibling
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com, ziy@nvidia.com, aneesh.kumar@kernel.org
References: <20250604041533.91198-1-dev.jain@arm.com>
 <20250603213338.7d80bbe0e021052c20e1c5f5@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250603213338.7d80bbe0e021052c20e1c5f5@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::10) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS2PR08MB10055:EE_|AM3PEPF0000A79B:EE_|PAVPR08MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e88f58-1817-4119-512b-08dda323d78c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Q0dKRitEMW5LS0VuY1VkOEZyL0JYR0xGSG14bVRrSmFjL3M3d2xOY3kveHZ2?=
 =?utf-8?B?a0Zsa25OcDVEWm4vR0NPZlV4VFBOYmg4OUFUd3ZSekd4L0xncS9DeE9ERFFX?=
 =?utf-8?B?djFLT1lKbHpEcm5xVlRmaG1FdXdhSWY1RzA2Sm5zWmE2NHNVS05NdHNzb2Ri?=
 =?utf-8?B?aExpRStJWFEyb1k4VytkT1ZuU0VqbElGb3o2VGFPMkpzYUoycUdsZ0krUUlS?=
 =?utf-8?B?SUJETTNCUk1WWFpoS2h1eHNwWEZxZXFmQ25HenFNYTkwbDBMTGhVdmpVNU8z?=
 =?utf-8?B?Ti9Jd0t0YUwyNUxJLzhwZ3J1cjdtRk9CYjlybHZGL1FIYzIyOGJtamFBOFQv?=
 =?utf-8?B?NGhwQy9sdGMrdGJGU0k3eHNqVUtKZmVqS2R5ajBpMWNhb01nTWVqOTBVOFNy?=
 =?utf-8?B?Q1BOSmdVa1lUa0xTc0F2OWlnVTl5TEVFS2dyNGMwZWsreU9PM0JNcW93bGR5?=
 =?utf-8?B?M1BhN0o0eFlTTzEwTExWNGt6TWVBQ3B3SU5BWUc1UGpQd3Ayc0NUSFVoazZr?=
 =?utf-8?B?V1JMcUxUNlhpVFJGd1VRenZjQVZmV3JhWTlIVmQxL2hNTGZibFg1SGJTc1RN?=
 =?utf-8?B?clpuTFQybGJkcW9IelpWeFVwUzF1K3doSENxbUxiL01SOGxGQVp1QWx0eEtr?=
 =?utf-8?B?ZjQxTEQwT2txQllLL2MxVGtXaFJTUnUydnFXVjFQZ2RaMVJjeUxoYmtkdW1w?=
 =?utf-8?B?dnRXVnoyQW5nMy9kcVVzRzA0U0hldUxmY1NoTThpOGZRSnVnWU9KYWs1bDB0?=
 =?utf-8?B?OEVYRXVyQklHd3RudU51M25yczR2d3JpNlFNcVNVRnBZUUNyTFVOSSs1dkNC?=
 =?utf-8?B?K1ZBSzhnSnd0YXJub2RHQWpqdVNQQStUbHpnaEgxMUJETXN4blB2SmlyUWFV?=
 =?utf-8?B?clNzSEtyREx1ZnV6eTNXUU1BOFYwUjZSQWd1aEJ2bVlWQUhoV1ZoMFQzbHJk?=
 =?utf-8?B?R0I2RmpCclZnVEZ3cWdDbXVWRHNMc0VGelR4eGIzejRlUlpiWmN4QUpVZWNX?=
 =?utf-8?B?YStjZy9HMmFzYWVyaVczeDRpaHU5NUtzYWtLRitiNlJTRmhBWDRWeGRmR3Rp?=
 =?utf-8?B?OWN6YU00SEpPRWRJN2NnbG9Rd1NBVmd6OWk5cmtpM2ZPdzBJaFdEdDBRM2VX?=
 =?utf-8?B?eXRRdVYwNVhndlNwc3pjK0R2SVRodmQreDlYUlpUdTlTTHoxdWRiVFZsSllu?=
 =?utf-8?B?dFJuUnlROUFtRUxndFVuSVBxdEtueVg5Wk51bFhvcVU0aXZVY29kMHVsSTlq?=
 =?utf-8?B?cDhHSHRrZjVNaVJVd2hobEYvQWEvbC9sYlh0T3l5WURtWUJ6eU9EZElBbGtT?=
 =?utf-8?B?WGd2ZEpHM21wVkJUdFNBSW1vR2dhblNlTWRwenlBdGZqYnFCTUxOMk1YRVdQ?=
 =?utf-8?B?KzRsNDVaZ0xaL29FbGE2bGVzeHlGOC9TdFFWZ2psZjBnY1NQWG95OHFoTS8w?=
 =?utf-8?B?ZDJoMXc5bG96aHQ4SXl0YnlsaEhxOU54YktsRmVpMmlQVGNJL0lna1c2ak4z?=
 =?utf-8?B?SVRmTlI3U2IveitPVGRJMzhPc2o1U3ZzenltQ3NCamMxVVZIcmMwVDd0bEx2?=
 =?utf-8?B?ZE4vb1RjaTF4Y2lXVXU0UjJHZ2xRdFhJWkNRV1pmY3RXMGNJUlpYTGVCdjhV?=
 =?utf-8?B?M2IyUjdIVlFIZVZZWDdaT205dnI1TFArUHlqbnhacFB3TWJYVmVWV2lsaDha?=
 =?utf-8?B?by9aZDNVUHlDRE45M3dJd2wvdnVJbHU1NHhDZTMvNlQvM1kwbEhFTGRVaHQx?=
 =?utf-8?B?SDlHTlFnZlZ0a2c2MDlDVTRiZGQ4RTBldHJ2d0ZGZGNKTFVQMGQ0UUJ6dEJD?=
 =?utf-8?B?dlhKZFJJMlR6SU82eEp3TnI1c0xHU2N5SFRKWHRTb0ZrMDdSZ2JGUXVxd2xa?=
 =?utf-8?B?cnRoWkJ5RHY4b1VtY0xEMlIyZ0NxalVOT1ZmNGJhOEQza0JSbER6RnRxcHNI?=
 =?utf-8?Q?1kKcScP2G3I=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10055
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8a48b867-ee9e-4cbc-642c-08dda323c3ec
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|35042699022|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3FZRzB0Sk1oam9DMUZ0TFZnMkNUMGFKK1JXd2dVVUNxSjdQRDhWaW5PZEJ6?=
 =?utf-8?B?clFGbnIrcStxK1JvRk8yMXNtaXlFaWs4RHppWVVlNHpKbFlGUlpjVVA1bGdz?=
 =?utf-8?B?OTFwYVlHTjVNcDFWdnI0emk2ZGNpaU00OWMrbVhobGdIQ2E5R0xDRWZHZzh2?=
 =?utf-8?B?Zk5rdTJ3WVVLc3JTV0ZVdHhEMUs4YUJsTm1iRlB6WkpZNGppQVh2U25HWGtm?=
 =?utf-8?B?RWJjZUx3M3FXQ21yTW05TFJ1M3dhMjFkT3dCSkhsQVAxYktXWVlRVzA2L3hh?=
 =?utf-8?B?Qk5aMTR5dWZFMHdaalQvZytpZ0xCb2hud1VJVTF3U09JbVZIdmpkN051TVNp?=
 =?utf-8?B?cUlkS2dPcTVMdi9TeHNUZGxaTGJTVHYzeHk5ZU5VRmk4c3VEZXlWUlpBRjEr?=
 =?utf-8?B?KzFvYy9YUHNDL25BWWNzNkFheEF1RlNtYTBJVHdvMGZ3cE04RlpGM29OR3ZM?=
 =?utf-8?B?MllyOE05SjlxUFBzdUl6dFh3dUFFUVgzeHJQOFI2Y1QyV0JXVS8zb1pYWFY3?=
 =?utf-8?B?ZTVFMU5UVWU4TVpvSVFGOVMxbkRzUXljdU9HbjlvRmRGa2RVc0hBbGh0K3Uy?=
 =?utf-8?B?TTRUZXJnREhlNEpPbldTWlVLcEEvQ1VadkhzRlcxM3JKRUJvaEcrRGQrTlgr?=
 =?utf-8?B?bVVZS01yTVFzTEVpQk8rbFNESkFZNkFHQ1RLdG0zY2ExVzlBOVhSaFVOaTZZ?=
 =?utf-8?B?aFFnR0hReGdMWXRPbXRmY0l2Tm95SDBCbUVLVjYvNWtRRXllRkFRamZLblhZ?=
 =?utf-8?B?K2g2RjRmRzhHenFuVVlKZWpEM05GcG9oSFNuVlZFN1lMQ3RKcVlvYmxMbFBD?=
 =?utf-8?B?bnVtZTJTNDA3SzdPMkUrMEVvNUM1bDFkc0Q1NjNWY1J0MUJqdk1ZdThpOFJ1?=
 =?utf-8?B?SDRiaXpPMWZuZlJVMmhDc296WUpweFhhN2JGNnc0TXU2OXNRd0t2d3VWVTJT?=
 =?utf-8?B?bFg1dnZEVlkybmFvT3ZLbEtZdi9LWElJNktIemV0eW5oaUpPaUw3dWhDdnl4?=
 =?utf-8?B?eVhMVjhoTTAydzgxU3JQUEl3azhlY2ErSXNHQmlWU1YzSExwVkc2WXFzNDFD?=
 =?utf-8?B?bHB2Nm1xTG0yYVk1R01rL2F4Q2xCK1NlYjM2RTRzc3FRa3ltTHA1Z29vWVo2?=
 =?utf-8?B?R1F5Mk1iRlpORFJhSkxWVUNlWTdWTUpQZzBQY0lTNVVyOUJqRFJySytvVW1s?=
 =?utf-8?B?dngwSTVRQnlZQUZLZ2l4MXlUODAxT2F1TjVOM1pXWHZ0Y1M1Y0xRSTdjME9X?=
 =?utf-8?B?UjV2UGxMVG1qS1h5QVZ3VS95cllrYUs1TW9LSVVNWG9haCtKdUhzMnlSWXpL?=
 =?utf-8?B?aWprc0ZXb2cvYWFXV3EzcEVOMm1TbFdkMlg1RFZFbGw5VDJFZy90YUdyU3By?=
 =?utf-8?B?eUg1bEFlOElNd3dJdTRyRHdBYlZzcTFiT01DVVNoUEZTd2cyaXZzeXdTcUV2?=
 =?utf-8?B?a21IZ3E0SjRZbXlSY1k1MjhWRjNMc2JEdkh1a2dMT3VyUXBvMDRBYVlDMTRW?=
 =?utf-8?B?Y3RPVUFNRDZ6bDZLYXBTbWg3d2ZtWDQzM1c1a0ZEV1o0cTZFdWdxT0UrSFZF?=
 =?utf-8?B?MWxXbGdPYlRnQjNyNWE5aEtUZ2h6d1VCWUMxb1lYbVZpaEZHbU1XY2JFV0xw?=
 =?utf-8?B?NDBZMEgzcWgzWFBFdEoxeU9Pc3IzcDJxUzg5ejN0NWhVeTl4MkdGK1h5dWdY?=
 =?utf-8?B?ZHBwSklXRldpZ2p0eERtN0U3VjlLSlV2NlMxcHJZbEVyQWw0ekNFQXJjSk5R?=
 =?utf-8?B?MkZnZlVTSk90UDg5R2R5SHZla1J3aGg0czRnTzBPSXVvR2RTVTROUnVqUmox?=
 =?utf-8?B?SkZXcXZ4S1RrVHF1bkgweXZkaTNrWkhwSnNxbGFXME54MmpaVS9SdElsSGRa?=
 =?utf-8?B?MjRyY2MweGtuTGw1UlJSb2FOb2Z6aGtRd1FBV1J1K212UytPaEhtQmJ5b0ZG?=
 =?utf-8?B?UFJ6VWxaZXdBeFRHWWEvZVJYemJtdlNwU0hsWXF4MTZRZG11T2Y0ak4xSlVs?=
 =?utf-8?B?aUIvZmVlbEN5Vnk0andkK0wyS2RVekN0QXlaalQ3MzJmRjZ1d2dDa0tyV3NV?=
 =?utf-8?Q?yH0GkS?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(35042699022)(36860700013)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 04:54:09.1061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e88f58-1817-4119-512b-08dda323d78c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9508


On 04/06/25 10:03 am, Andrew Morton wrote:
> On Wed,  4 Jun 2025 09:45:33 +0530 Dev Jain <dev.jain@arm.com> wrote:
>
>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>> Then it may happen that the computed slot already falls beyond the batch,
>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>> order. For example, suppose we have a shift-6 node having an order-9
>> entry => 8 - 1 = 7 siblings, so assume the slots are at offset 0 till 7 in
>> this node. If xas->xa_offset is 6, then the code will compute order as
>> 1 + xas->xa_node->shift = 7. Therefore, the order computation must start
>> from the beginning of the multi-slot entries, that is, the non-sibling
>> entry. Thus ensure that the caller is aware of this by triggering a BUG
>> when the entry is a sibling entry.
> Why check this thing in particular?  There are a zillion things we
> could check...

Well, it jumped out to me while reading code. If the concensus is that
a BUG_ON() is totally unnecessary, I will at least prefer a comment.
I just thought that there are XA_NODE_BUG_ON()'s all over the place,
and they must be there for some good reason, so let's follow that.

>> Note that this BUG_ON() is only
>> active while running selftests, so there is no overhead in a running
>> kernel.
> hm, how do we know this?  Now and in the future?  xa_get_order() and
> xas_get_order() have callers all over the place.

XA_NODE_BUG_ON() depends on #ifdef XA_DEBUG(), which is defined in a tools/testing
directory...and in the future if this changes then I think that work will include
removing all XA_NODE_BUG_ON()'s...



>

