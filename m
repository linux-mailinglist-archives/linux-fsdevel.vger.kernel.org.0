Return-Path: <linux-fsdevel+bounces-50112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B4AC84CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 01:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9895D1BC430C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018C21FF2D;
	Thu, 29 May 2025 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMCmax/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361120B806;
	Thu, 29 May 2025 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748559901; cv=fail; b=fY1E2H2yxqYN/tF1AvsCh0R2yzJNfu/U0/1Wakn+33ExLqgjU8+q3iO8tyrUj0PzAZCSmA0N4uwnVy1I6P967zUYq6YXSXgQRK1kasHmytr9e3tCtqlZKK46CPc1yogvdtWVRm5f3aFDHKHhFgIwWQqPShIXJDKBEm0H1yVOCAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748559901; c=relaxed/simple;
	bh=mrsCPbK2I+mxC1+Myhqkj6QNJXt0KQPyRKhLJ5ItL2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IaGLxtjVESvUCp7URX/GM72R6Lec5SfxvOeGzWP1IW3aVptXGfxvrLIxAKu3kmGeQDNCDyqke32sE/W2apqLH+joHlyp2svx81mF1A7EuW90KL+FwNQ/k+3JUzlO6j2uRLPp3QnSPaYq/Gc35b3lxBT1t7qaxyPXE+CSR7CyB78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MMCmax/G; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXByJCkldMfTo8KBYzctS63hVesYSk4l0FrIfSOvN5BedYRTE4C4eTQ4wqqPPk6neHY4e7i2DzTD2LCjEcCHc6Q4gy6mvBCnliIqmDOPXnlw7VP4r7o/yZJm4DjCvjakjKJGx/CcIAyO76lczaOcBRv4duU3oabsfF54neUe7+SZw1taXY7YhtHjclFjK5AiSC7msSfGJmWGxG9uAAuEtYl3Y9CN7mmzRcofLj8QSC+roF6oE5PTpxYP21K6We9gRG1HKt051KX2S3xLyxRldNoPMpy3RqsbYC+QsNVoRPtG85/Gl4jdx96K2q/ysVq5HBjiI5MBzhzTbhPMuF2cCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB00Fz4xoNy/0xzkWbI2SpSdQpLt0v3AUORZFO5OYPM=;
 b=dIR5mpHTpVYcZy50T/kCm6f/W5tJyeYpr2uVsuGKDke9kLsvVvjqsAl7pQhmxLxWwRHjEulPniZfpurMx6I2Lf+KpcAM/Aj6D0ThRljcjbf7nzJR78QFivExyKGDw6PCvWPAREPAMGBUUOeXHWqb/Nl01lIrBRUuV0xAvhqXMmMJIivY78VbBE1wEYf3eOoBBEwgTWkm44CXUjcEjqH3vd5DDVPpp9xlacBs9hd9JJSFNh+uTiVaMwQ7G8if15n3Zw1iAZ+IxWJ/i6cSaLhuh1lZlpiKVGtdqnqjno/yh8bjQD3yjDf7sWAIejFpyjtDrnhZUs+dIRgitK0g1g9Fjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB00Fz4xoNy/0xzkWbI2SpSdQpLt0v3AUORZFO5OYPM=;
 b=MMCmax/G7O/g0KKMknhd+eg+RanrM4do9S2zSSOHHxGVe5BJ1fGv16u6a5qaMXKsycjdAZhINEntf2nXV+jQUU7KVVc0QbYRH6eLXtwiVqTDr4J30iIdYFOiyUensB7kOXNOer+q02fNYBT07iTR4PGKoyQ/QSGkUJwgb2AoNjZooUnhIViauYDQxCgmjQpc3rBF7aUQieplv73y1LdzxRKHSLndDinmALy6sQDtHdBfrwZ/t58iHXfll8/7UkwKkjwQXlJa7mImoJc7E7oz1K4kiw6x28pdrRgGAhcDgy3oaTUfQrRRUsMDp7HqsEuLlh82eyy+dZjre45FF8WuHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Thu, 29 May 2025 23:04:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 23:04:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: <akpm@linux-foundation.org>, <willy@infradead.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <david@redhat.com>,
 <anshuman.khandual@arm.com>, <ryan.roberts@arm.com>
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
Date: Thu, 29 May 2025 19:04:53 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <DB991DB3-A3AF-4D4B-B198-F116A280E5A6@nvidia.com>
In-Reply-To: <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
 <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:52f::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 41345700-5c99-446e-d5dc-08dd9f053a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NldLR21ITUZnWVFqZC9mbnI4QmFTMnhkejMxL3Rxa3R2M1JuLzhucS9HK0Y5?=
 =?utf-8?B?NVBuQzl2WWhvYXdMYSt2a2JsVDFoZFRKa2t2aXoyL1BWcHNvOVhtcHhGSTRF?=
 =?utf-8?B?TVJWTWRBM0lvK2VyZXdHdXJnTStjVDB1N2JNSmpTVDR0Mm9KZW1hRnNvTk1t?=
 =?utf-8?B?Q1BlcWNXSXdYMHRVaXhKbFNwQUlmVVBMMFBqWnNhZXNWRGFqSFhLYzNSakdI?=
 =?utf-8?B?R2M4aEZlY1ExZ1RCajQwQVlQOFo3SFhSS2JJTGxFUDVTcnArVUtodk9Cczdn?=
 =?utf-8?B?ZXBVMDV1R0pkK3lOenFrYklXekRpTXk5MzFCRkErd3RFY1pQTjFYaWltektO?=
 =?utf-8?B?eERkenZNb1c5Mm1wY2J3dGRhbm9DYU1KN1lXWmhrOTJzZFI5V21aYmdReWVv?=
 =?utf-8?B?Y3RYZXBQYWFOUVdkVHV0WnZpcGtPR3V0YkNwemtVdHBnNHhNK3B3anVXaE1r?=
 =?utf-8?B?b1g3T1M0TEUzZWJmVHRsTkE1NnBPRVkrc3QvY3ZnWkJYVjM0OHhwcytPTUUw?=
 =?utf-8?B?aDB3WXZhSTFqUGhRVHprcnZqM2xEeDVDMHhCNVFrRGJUcUlieVI0SWQ2TmxX?=
 =?utf-8?B?c1FqMElBZnRHMVNZSmI0MFg4QlRkbHpkck5TYUpRMmtpVUh1MXJoVmp3ZTVy?=
 =?utf-8?B?ajZaSzMzVS9MN3UvYzlqSExrcStHaDA4ZklMV3dNclpyR01PRDBYK3pDd01x?=
 =?utf-8?B?VUgzNGUyRElnYWdZOEltT1cvU1NSYktSTzE4eFM4NHJMczVkc0g4QWQ3ZUdZ?=
 =?utf-8?B?ZmFrTEFyVEw2YlhZby9YY1RUZWhYeXo4VlhrM3BML2haMmM5dDRTaTRjNU5y?=
 =?utf-8?B?RER2RE5nMHZ3UkZjQjRvWFYxTE5Ic3ZNcktQeEpYNnpxWHpWYVBoeGhjamtG?=
 =?utf-8?B?eVZhdFZ1ME01L2NuZTh6TlFVdW95QllOeG1uM2Nwek52aDVSc1k1OERGK3lY?=
 =?utf-8?B?aDdPSmg1SnFxTjZrUm51NVYyMjhlUzVsdS9ZVGFmWk4rUVZxYmVpN2I1ZDA1?=
 =?utf-8?B?R1FEQ1I3OW9FWjBrR1ZkaWVpN0ZUY095MEZsRkZvblN0UXhzWXFhanlkRlpN?=
 =?utf-8?B?c1JVbml4elp0K0Zqbk1UbFFVTU93Z2dIMkN1NExDUllUQnFEc3kyV0k3NHJz?=
 =?utf-8?B?dzNuRDZCUTFjV0ZaUFB3cDdyWjM5RDIyWFdGU2JCM3pqK3RtOXJYRE9yME9Q?=
 =?utf-8?B?a0h5N1o0a21YcmhrYWgxdVpzVFhSaTdhNnQwRjc3c2RCWnphNUVrQUJuclBn?=
 =?utf-8?B?ZXRHN0lzdlRTZkIzUDlabEZaeE90TjZXVjNaMWE0RXdXNytJWkgyVG1LREtl?=
 =?utf-8?B?MjZJNWRSZEpnV3ExYTR6bDM2cUdFSzQzSVZuSlhtWFZEd2M4ZVpwSEtWS1Rp?=
 =?utf-8?B?TVloS0ZtMnpqYWlqbWZsLzdKZklYQ1hoZzdkYWJkQWZtc2RYRkZkY0ZNMHRO?=
 =?utf-8?B?U3QxeVlUekRIcmt1cFJGN3lGRnFnSDJjOERjaXp6ZElaRWFIWUo0YnFFQ1BN?=
 =?utf-8?B?UU8rSFZhUjErTkxLekVDN1BlU3k4aHp1U1VzWWozREVjTFQvRnBWRk16VjI0?=
 =?utf-8?B?WlRKaXllVCtTYlUrMWNSdi9BQ2lqQ3orYUhUQVZGVWlIaThVUUY3TmF6RTY5?=
 =?utf-8?B?Nk1BbFZmQ2RYYVFvMlNSOEVVY29JTHpWR082aTFwVXk1dmZDQXA5c3dpaG5k?=
 =?utf-8?B?WXVmeVdFQk01LzNaMlkxTlJmbTJ1a0psaW52eUFYM05qOFcwNE9lYXhkYkM5?=
 =?utf-8?B?Um56bHc4YW5VUXU4V3h1RnIrZ1Nubm9pcklMaWl5TndxREkvanM5NWNsbDBi?=
 =?utf-8?B?bHcxT2tQVk56YThhMkkydFpDSzl5bUxYa1lNYTRPQUVPZnNpVkxObXRYR0VR?=
 =?utf-8?B?dDlvejBDa3djNXVaZ3JuOWhtTElBZ2xOLzdwdmI3U3lXZUdIZG92V0c2T09a?=
 =?utf-8?Q?VrlbBu7ILiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmlHUGdUVmp0TG5IK2plSGIzVDY0NDJkNmpKWUJnUVRVdUN3YzQwUUc3VFFo?=
 =?utf-8?B?TlpndVA4YUMzdVlSNDdUczdqL1g2VUd2RjgveTVuMEVXZ3VzeUJQblJmNWgv?=
 =?utf-8?B?dWx0YzZ5cXVGSldUMWVBbjY1Y25DamdlY0cvTllRdkhQaFZIT2h6TEFQR0pK?=
 =?utf-8?B?bG45YlcrZDkyblRjZDVkak1RTHJjQVFKZ080OVk4Qmw3c041U2ZzTFNPK3BS?=
 =?utf-8?B?aGtqVU5lZ2IvaXhLWi8weTM1NjE4dUZQMzdtczhCbFY2eU9FVnNPMWlZam94?=
 =?utf-8?B?cmorM2ZYRlgxaWVIeEhrbFRRbFpyNGExNzlHNWRFY1NxeERlWWxkUU1mTnZq?=
 =?utf-8?B?Mlk4UDFZamJoSUsxQW91Wkt1NnFCV0Fxdi9jZUNzWldLV3J0Y0RpK1d1R3R2?=
 =?utf-8?B?QjhrT3FkOWxPbGo3WTd5Vkg1bkFYazFpdEVGNnJWVW1hRWpIcFJHaStPNjc5?=
 =?utf-8?B?ZFRpQ05pekdRK2ZtMEcyc2wrY2RkK1A1b1BDWVJTcEdLeC9nYVNhSTcwRE8v?=
 =?utf-8?B?bEw5Tkw0c3JSbFROSjlKY3ZmNWhPUWRLVUJRNVU5NzRPRFJhMEhSOC83a1Jl?=
 =?utf-8?B?SjF6U2NvRkZ5QUFmYnVLK2lwUnpLL3YrOUwrTEx4N0hqRjhJd00wenQrOUpl?=
 =?utf-8?B?T1A4K2tlU3ExcGRUOFBDMTkvNDAwaUtBSDE2MGJ2K210bXh1NEZ0Y0Y1UlZQ?=
 =?utf-8?B?dERkaFlJM0I4R1JzNU00clZ5OEVaU3pSOHBwNTZPL3FSVkhUdnE1RnVkRVVV?=
 =?utf-8?B?azNmUW1rY0xqZXphaEtkSnFBbVFyTHVjclZqTndwa1Rwd05mM3h2S29BSWF0?=
 =?utf-8?B?b0I5ZmNNc1FBNWJtd2tvQ2dmSERyV3d6RUV6a05WbWtmWUtGNkxheDl1dm0y?=
 =?utf-8?B?b1F1emVLb09vZjA3OVoyMFNjT1U4VVQrZWJWam11WEhHV3dnaTRoY3NTaWdi?=
 =?utf-8?B?d1lHM2FTaDFSTkFFUnArL1pHckYvNVAyYk9ybG1ic0cwdWlFSk1XMHNVQm04?=
 =?utf-8?B?eXpMbDQ2SzlvM0s1VzFYYXYxMk9pay9TSlkrQUN3aTlFQ0lxRzc5bnd2Q1RO?=
 =?utf-8?B?WXpRVmZ5VUIreVpONVRwYk9sOUJxRjdzR0pzdjM2TXZITDJKL1hrb3ZtNVFN?=
 =?utf-8?B?Z3RxRFpJQ2REMHpHRHpxMHdTd2JzZmpLTVR6dU9ibFhCNEFOeW41MWF2OEV3?=
 =?utf-8?B?bTQrVUsxVXQwOU8vdGhzUDJzZGFETncxaEZ6c1B5dVMwRHpWNTRzcDhLY1Q1?=
 =?utf-8?B?Tk80ZVh4cXpicGhES3Y5aFZ1dmtjd0JDamN3Z2Y3UTk2ZWtrcW1naVBrVUdt?=
 =?utf-8?B?SlA2bWI4VStEcWI5bUVPUGk2dnE2eTRDRmlmbW5Kd2hzMzRaS3l2QU94eEUx?=
 =?utf-8?B?YWVUY2Vqb2ZNd1MxK1dDSlBYSnB1Qyt0WlhHa3VGbUNFc3VubmpneEs1TENX?=
 =?utf-8?B?UGREOWhURUpMdFhUK1JTRGh0QTBZd2tObnZaRFNtOEdKUFFVS0FkaEw2cjlF?=
 =?utf-8?B?N0M1MjZhWXZBbHhZbEY2YnpiejN5TDVjR1pUVnlBUDBrRmRlZCtDSWtPTnJ2?=
 =?utf-8?B?R0JhVmhFZnZIb3ZmNlNtRmprZitLdTdSZGdZaXE0eWlIaXkvN3NEUDZCZjJF?=
 =?utf-8?B?OVlVZFhvcW1sYzMvT2RPMzJoQ1hiQ3FGWkIzMVo1cERlVFpHWnd6bDFUVk1L?=
 =?utf-8?B?aExVaVFTOE9ucWZDQmhHbExOYkwzdG04a2VtTGptTk02Tlg0MTZ0dEN1UWJ0?=
 =?utf-8?B?Nkk0QW5xQ1RONEVLVFZSdE5odSt0Z1hvZWZTM1YyQ1E1dW1Qb2E0NlhjdndW?=
 =?utf-8?B?czRDblUzU1dzbGU4V3lIeHdDUHp1alNPR3RjVUpwa2xaVFJvQUdKVkxxem94?=
 =?utf-8?B?NTNOMmJTWFNyd3ZjWGswczMxajFqSm1NVkhPdHQ5dmxNdkZMSWIyejNUa3Ji?=
 =?utf-8?B?VkpaZFhDNEFCR2ZiL2JCR0diV1d6aVl3TzBhbDI4djl0QTZpODV1eHc1Wkw4?=
 =?utf-8?B?cXdyVkNXbUkvUmtUTktmOEVRR0J0VTA2aTFqbktNK3U2NEJEdC9LYjkyMDB4?=
 =?utf-8?B?ZEZZYW85cld6dnRYRUgxdnBTVlRuaEVCcFJqYWNzSlEvRG9kenJIK2ZzZU5Q?=
 =?utf-8?Q?ZW1PP1Owsf/l31SbNF9Gtqrrx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41345700-5c99-446e-d5dc-08dd9f053a6f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 23:04:56.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGFYfbuXvUgnHaW3CxbsrhEB/A4kihQbg07DwS40XDsI+DzsgPi+EDGPQKX5eb2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

On 29 May 2025, at 18:47, Zi Yan wrote:

> On 28 May 2025, at 23:17, Dev Jain wrote:
>
>> On 28/05/25 10:42 pm, Zi Yan wrote:
>>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>>
>>>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>>>> Then it may happen that the computed slot already falls beyond the batch,
>>>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>>>> order. Thus ensure that the caller is aware of this by triggering a BUG
>>>> when the entry is a sibling entry.
>>> Is it possible to add a test case in lib/test_xarray.c for this?
>>> You can compile the tests with “make -C tools/testing/radix-tree”
>>> and run “./tools/testing/radix-tree/xarray”.
>>
>>
>> Sorry forgot to Cc you.
>> I can surely do that later, but does this patch look fine?
>
> I am not sure the exact situation you are describing, so I asked you
> to write a test case to demonstrate the issue. :)
>

IIUC, you mean xas needs to be a non sibling to make xas_get_order()
work? I wonder if you can use xas_prev() to find the first entry
in the multi-index batch then get the right order.

>>
>>
>>>
>>>> This patch is motivated by code inspection and not a real bug report.
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>> The patch applies on 6.15 kernel.
>>>>
>>>>   lib/xarray.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/lib/xarray.c b/lib/xarray.c
>>>> index 9644b18af18d..0f699766c24f 100644
>>>> --- a/lib/xarray.c
>>>> +++ b/lib/xarray.c
>>>> @@ -1917,6 +1917,8 @@ int xas_get_order(struct xa_state *xas)
>>>>   	if (!xas->xa_node)
>>>>   		return 0;
>>>>
>>>> +	XA_NODE_BUG_ON(xas->xa_node, xa_is_sibling(xa_entry(xas->xa,
>>>> +		       xas->xa_node, xas->xa_offset)));
>>>>   	for (;;) {
>>>>   		unsigned int slot = xas->xa_offset + (1 << order);
>>>>
>>>> -- 
>>>> 2.30.2
>>>
>>> Best Regards,
>>> Yan, Zi
>
>
> Best Regards,
> Yan, Zi


Best Regards,
Yan, Zi

