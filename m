Return-Path: <linux-fsdevel+bounces-20655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C48D66CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51FA28BFC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B7D158DC1;
	Fri, 31 May 2024 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Lfj0THfk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Lfj0THfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70880158D8D
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172894; cv=fail; b=phW2rLzrxttyUv3e333p4lt/jmDatb5tFB/l2dKiEEJyDEbSA3JNveCD7ZxRjQ7unf2RSpHfcjohmbt2YHpb3iKjDpS3nDEvnv15eX2JDG67jnN2mFK4g85TS1BtAbkLO3b5SEY1oLmPRzbhYK+KQI/KmEkVtW0P8qEheL03YoI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172894; c=relaxed/simple;
	bh=M5YejkYP19wuqNIbsiQKllttvji9t77tAdoUr8agYpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bbR18Sk34JynvGnIgJo/3LAtJoPytQlxJP7yUPcCj6o8o7h1AWq3kfw9vJHqXXCNnWHs8sb/zC2DBKY6Yx1tTkEsBEIJWMoIIuupLZyuMGYeh+RU/Wo5s1RCK66EtGCX6O+3ITCGqNksGE9Q0Jc8TxrHPcTbBKAnm71TopHDars=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Lfj0THfk; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Lfj0THfk; arc=fail smtp.client-ip=40.107.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=FEuE/vCpfOqTBG/1s+mryGj7DoK01m+5kZDNBJ1Sv0QDfjzEsMPcbfmpAqISWXMxaS3Qo7uBYDd0zqglYHuZjIsCl24InYHL47g+RSJ1UcamR+wWN4xgtFMYwd1CEYTq6JLWoo0tkR4q1A+aIFXAvqHhq/3hi3UzA7BSA+pZg0x3EICCd84BQ6Hj6WjTK0Dyyk3cwdduVH9TFRuH4bOFdT5TFQku1rbpP+6Qk+QCRd2XqyrVWKIainx6Am3/g0EVbGRAQ+p3VqRGxcP7e6ornmAvEDNH9kJ1x4GA9MwdvreQhdnokfsMTz9RCFSS4gTEZUp17N7myslhDF+tffQZIg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/kn/zHXt6gVzEQJw5AhtJAJkce3Y+lTdMX6Rnr75uc=;
 b=iSEFB6LHIJdzky4CbQTph5WVVr6JVVqjggH1K308RBVsC+zen8LaFEz093jq7RsANwO5Z91lRf/kwJPxAG2vxsCgVXECdb7c3zgdXdfN+H0rK3ScdB6pt+sgqbDYntS7YhII3AhQbJmnmGjk1q0JOBrOIp1UzkvhQyQUV8aVl3TEZZPZFga6cHUZJbuDgls69N0uIE9l0L+jQQdLRgdPNzMPOMGp+Xy68xN7oBmhVq05d0Civ+n6l4WxzFFWxn75zWz5IuOpVig60RzLaVkpEsXNQhWyWbeuQIPDZb0WMcqjuhRrOIB9EEWpw1m55f4Ce8wIH8r8cW7BWFPOIkiq3g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/kn/zHXt6gVzEQJw5AhtJAJkce3Y+lTdMX6Rnr75uc=;
 b=Lfj0THfkcXU+tUgJiFdIC9gN6uf3BubapL8UJ+FFRmv/9z9qh5BtOTBl/gOYT8YlTxBEONOY+ixzoSV1IVlkt4TQsuf1S3cmFfGOVgC/NV8NrNTDDvxKkoRE/3zmXAEuD/P9hQcZU69pN6M/ZDOMyqPh27pPQKQxPAuiG35LRRg=
Received: from AM8P189CA0028.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::33)
 by GV2PR08MB9373.eurprd08.prod.outlook.com (2603:10a6:150:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Fri, 31 May
 2024 16:28:01 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::23) by AM8P189CA0028.outlook.office365.com
 (2603:10a6:20b:218::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23 via Frontend
 Transport; Fri, 31 May 2024 16:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Fri, 31 May 2024 16:27:59 +0000
Received: ("Tessian outbound c528c7fbb6d7:v327"); Fri, 31 May 2024 16:27:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7366e6efe3ddcea1
X-CR-MTA-TID: 64aa7808
Received: from d362836c4795.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 02DD0AC8-7D2C-4EA7-B564-1BB6BED8F992.1;
	Fri, 31 May 2024 16:27:48 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d362836c4795.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 31 May 2024 16:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlqpQAQsVLplNdzfMZnrrU5zZ3W0wck2+RNWcxGh4P5hwsmvE+djdTBS+sjcEj70lIcN3PLXIF0kulznRekIhFAPpKmJxD/RypWSy7c4NVU4EDctmWdpGQK70e1ZxVB4YSpA2VDBkjvsIlshmwl2d5Ps0EUN1VAC4o/sBV2CvVG1zUUAFLagHA7iCjx8FKpjd9f+yUuVRsNB1CfXE6Mz7quj5dUr4bFVFcfo5RCKwlNulJRGPg4w7BtRGnbN5nTJBfFWeEMs3xfgCjbShNtYwEOwv2OnXPOdXh/34FSY5BCH41uJ9StBCVjqNjAr6U30RumnpWSnyUpp86kxM2POiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/kn/zHXt6gVzEQJw5AhtJAJkce3Y+lTdMX6Rnr75uc=;
 b=ifCMjfci/LdFa3lx8tQy+vd5yPOgkfUBSnh2JI5pINpouYnZlCn+IEW+fIF216M1vaRzd9BVhG0T8ymIbUFvbckycib0Jfyf3oRr8AHb9apJgcjH7n6+B9bQUWvSyNE9btsPqHB1zQH+iUEluDyQqrAIH9DFlxGCuMXG+agLa1RqhVc6e0J3S55r2ppsgECQnKKlxOzS/n4HZVC5WVYIHUzGQ8AIEVpHeHyMNe64ROgllF2gQJkWmBL4D8bShRY7GtuyVrRqjE2JSD9C4k728K9392CBrxFk/UqiGGrEytSnOwQj3Jt7b03mHRIu7MtkLKFBqXe7GVTCP+cJJMVfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/kn/zHXt6gVzEQJw5AhtJAJkce3Y+lTdMX6Rnr75uc=;
 b=Lfj0THfkcXU+tUgJiFdIC9gN6uf3BubapL8UJ+FFRmv/9z9qh5BtOTBl/gOYT8YlTxBEONOY+ixzoSV1IVlkt4TQsuf1S3cmFfGOVgC/NV8NrNTDDvxKkoRE/3zmXAEuD/P9hQcZU69pN6M/ZDOMyqPh27pPQKQxPAuiG35LRRg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM0PR08MB5441.eurprd08.prod.outlook.com (2603:10a6:208:17d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Fri, 31 May
 2024 16:27:46 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809%5]) with mapi id 15.20.7587.035; Fri, 31 May 2024
 16:27:46 +0000
Date: Fri, 31 May 2024 17:27:30 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Joey Gouly <joey.gouly@arm.com>, dave.hansen@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, tglx@linutronix.de,
	will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev,
	Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
Message-ID: <Zln6ckvyktar8r0n@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
 <ZlnlQ/avUAuSum5R@arm.com>
 <20240531152138.GA1805682@e124191.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531152138.GA1805682@e124191.cambridge.arm.com>
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|AM0PR08MB5441:EE_|AMS0EPF000001B6:EE_|GV2PR08MB9373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8166d4a1-b149-4515-1ddf-08dc818ea303
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dmxJMnZEUElMU1lGRDQydmRJRzJITnBMOS9WWXV5UC9UYlBMTjRqT1ZCaGhy?=
 =?utf-8?B?TVBkODhzUVRjYUIrOXhNdlV1OURLTnFYNlUxeWpOUGR0L1UrSzNYNGJIbHBX?=
 =?utf-8?B?ZXBVN3ZLR1dFZElmK2FYaVVzVFo0cDF5b0wzTkJmWTBCODZoVE5RTW96Tkxr?=
 =?utf-8?B?T0wyYUY2Rzk0cUhiSXNEcEZsTWVrWjVyMWN6R0xsN3Z6VkIyMEt6aEdGQ0tm?=
 =?utf-8?B?WTdBQU5hSVdua3VpemRFeXM0TjNweEVxalYybTc4NUIvNzBkTjNZeGxydmhR?=
 =?utf-8?B?UXZqc3V1Uno4cDB5eTRsSld3cFhkM2w1ZnIyeWYwKzhvazhkNStCa0s3U0xI?=
 =?utf-8?B?QW91R0RVVm5MZkUreUhsYVBVWUlWZFc2R0hQdXhwZHBiQm02ZXJDQjd0eFlF?=
 =?utf-8?B?NmFBS2N5MmlHTnJ1OEJjaFBjc1AvbEJDNWloSDNtVlRmaEtRa3cvVTByMHFz?=
 =?utf-8?B?TUh2aUliZUl6NGI3TkJUc0pDdy9WT3dzVmJrR05GRHVreGNGdlhmZkhVdTlu?=
 =?utf-8?B?Mk03eCtUdTZNOGtNTXNRemhqWXFiUmFSZksvOFNmZmFaKzBISmNNc3pmYXFr?=
 =?utf-8?B?SzlUQmlLeW9rSmFWbmhLZEY4UEozSS8yVzhBY3VVSFpERDNMdzk3allpSXdi?=
 =?utf-8?B?VzRIWWdhMHQzdTVKaUFsbnhBblhsRVBmQTFTU1djN1I5K2dncFM5eGxBM3Rx?=
 =?utf-8?B?MVBMR3JuUzRPM2g3akw1OWVZc2ZUUENzVTMzNE1CMzhUT043VW0zVXlxMXNP?=
 =?utf-8?B?M0RTQzhYZUtqanhyc29xaEZOZzFiVUFmc2kxKytnY3U2L01NYUZLQ0FObTVJ?=
 =?utf-8?B?RXVLbHJjVkpVVlljSGs4Y3BpVkE3N01LQkRwMmhBcE9SeEVWNXdrdlBBcTVG?=
 =?utf-8?B?ajdxNWk5UnRIZmJKZWgxeFlCMFkzZWYwSDhnZVp5U1RmV1FvWE1GaVBWUTZB?=
 =?utf-8?B?eEdYamR0QjNOMlhvVWZCcWNwY2g0MlQwRWFTRGxobEt2MXlvell5bThtY01y?=
 =?utf-8?B?eVZza1hQTC80VldCeDVyNkRXaTkyWW1hWmF0NHZIM0NFZUt2ZEJVTlQ5aUti?=
 =?utf-8?B?bmY4YkVDZU83VUFPbnVXdDc5TDJsaEZEcmwyRWRLUGwxMEM2UWpEUWJqYTIw?=
 =?utf-8?B?ODY3L2pjbk4yMWxzSnZnK0xXZWg2Y2F6U1BYVElxTi9UeSt2SmdVVStTNHht?=
 =?utf-8?B?dkhjNWJpZWFHZk9CRHhNOW1tQ3RlM1h1VDYxa2lUZllnc0dsZUhLSDJ4Kzg1?=
 =?utf-8?B?NkZpb2NIWkxaS1FtVWNycWp1SlJFWGdIbjh4Nlp5N2NWRlRtYWNjdE9YQjdq?=
 =?utf-8?B?dTVwajQ5eVdZbDhBV09hby9rR0QzSFhqb0lSWXlhcVdPcVVqRDJqVkVoSmQz?=
 =?utf-8?B?QW92bHpXTExKTHQwYlUrMFJHb3ZuTkFOTVp3WlJZYjNrRXBvSk5XR1k2UlB5?=
 =?utf-8?B?TEdDclZmVk1BblBXbXYxVWRJbkZleTlFVE1LSHAycFZueS9YU1BTV1ZnQjlq?=
 =?utf-8?B?MDRCV2NxSU0wTGpEZ0l6RG9KNXBHb0NURWdCMXkzelFqNzZOV0xoUlpGdytJ?=
 =?utf-8?B?RnJvZHFJUVdldUNHdGZXREhncFpaWkZjb01DamdPUzhSblhqM2tDZUV3ck9i?=
 =?utf-8?B?Q21xd2h1WUZOcHRYQTNaaTY1dDZadEplaUpzYlNlcTdxdnZJNVZlR2MxYXhV?=
 =?utf-8?B?VWFjWHllYURRa2NuU2JVaDFNVHpLVzRqMFQ2c2VhVXUzNUFJRENQYzRRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5441
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fd97360e-b982-47d8-3fb8-08dc818e9ae9
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|35042699013|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGV3cEdIL3VsdURyYTNaa0ZvTXNRcEExeTE1cmE4MSsyY1JiQi8wNWN5eWJx?=
 =?utf-8?B?dTYydmxpVTBETTIvUE5PL3JGRHFndUViU09pTUV0KzhOa291Z0Y1WHpqWHR5?=
 =?utf-8?B?dW1uL0J6UGhKYWdoZ2VWYVpoQUcwcWFOZ0ExcWhRR2YzeTJPV3FKY1FkNkpX?=
 =?utf-8?B?dE9PTDRzalNyL0poUGJjeUJZTEVva2ZINlRFWTlCTDRjYmZzcHZkRnVRaWFK?=
 =?utf-8?B?Q0lTR1VvVUxyV0lndERIZTkrTjRyeUV4dEVWS1A3ajZnRlVFdnQzT0tVSnZq?=
 =?utf-8?B?akFBUk1JQ2tWaGRtUjh6YjZ6OWQxR2J3UUF5WkhaMURLS2M5Y0l3a3lwYjh6?=
 =?utf-8?B?R0NKaDh1S3Y0SWZ2ZEs5ZHhWVUlPRGU5bW96UFZmU3A3NkJOY3VUMFlxMDdF?=
 =?utf-8?B?elQzWVY5T3BOLzhKdVZYamhaQXZ1ZUdWUkdhdXFLajYxa3lLOXhBdUNGbVAv?=
 =?utf-8?B?QUtjcnZocGdMNkxhQzUvNnJ3MXFzZXVubDE2NVR5eEVzK2lDOWt0ZWd0SkZU?=
 =?utf-8?B?WmsrMUwxMlowQllCNEVYTFB6blFzZ1dYK0VDOTlTaWFWZjlzai9yaDJvUEVF?=
 =?utf-8?B?WG04UmE2aHlyWHkwUU9yN1R3SndXb000YlhxeWdnUzNQSi9QOHNJQktzbUdU?=
 =?utf-8?B?djdNOHZocWMzMDNFb3JmTHJUR3pnU3lzQnppMWdQanlpQVAxNmZJK3Z6RU9a?=
 =?utf-8?B?NTJNblprSFVwZ0w0OVRuaHpRWmhuRXY5eHI5SFBYV1NsQlVYMmEwcFF5MzRP?=
 =?utf-8?B?Sklsd1gyUENDcnBab3dXNE9NNDFPQUp2WDVNRitOK2pYcnkvM0tYd2FKZWdH?=
 =?utf-8?B?dE04Nmcxb2pEZGxkUUIrcXhYbVNGbGgvVWUxc0JMYVQ0M3l6N2U1eVFPNlNM?=
 =?utf-8?B?ZFpnOTlxQVp5OXhxeG1OdXkxcjZwZlZyL3hLQXNuVUg3RHdRdVdvRWx2aTdv?=
 =?utf-8?B?RzN4Y1hqOXVvYzFCL21scmtDWE9OM3NaR1ZJdlpEWGlmSTlETHNQeWx2VjJy?=
 =?utf-8?B?UjQ2YlMyYU03OThkSjBzQUdqYSsvak1TaWxFa1JRNWVKbEYvQVZ1QVJLY25D?=
 =?utf-8?B?VTh5aDdaTSsvdGY0N2pjZExsWkgzOWE0UENET3ZnK0MrYThDTnphRzJlQXl3?=
 =?utf-8?B?L2gvUW41MjdlencwZGJHZFdvVHNlNllyZTJYWmpZUlRXbS9GVm9YTDNPVUxR?=
 =?utf-8?B?Z0ltV0E3UTRTTmFPMVFLbVJMUy9QMmlOWlFyUXlEUDM2NysxVDk2R1E0REgw?=
 =?utf-8?B?YWJzMUpXN0Fjd0ZLRlhCeXlpenBITFhwVUUvck5WbTBBclNQN0t4SmRqZlo4?=
 =?utf-8?B?M1MwaFRwRXRaQVhZUEVMcEUveE55RERYcmJBRDZ4ckFCc3UxMzBUVW0xcnVx?=
 =?utf-8?B?aWt0TEFMNTFVZER1dUtUdDFRUE4wRXV1VjRZa1oyNkhsdUlZa05UTHlzdUdo?=
 =?utf-8?B?VjNEWCtiOW9qU3FUaU5xSUkrOCtZVythVWpvNXFISHlFaitGM280UkViME94?=
 =?utf-8?B?bG9XOENzTklVRUVsdDFseks5R1R0RXl4QmhQcDBqRkphZmlicTNYWFpXMHVD?=
 =?utf-8?B?UXVHY1QzMDhMdDYrdTJxalpEd3ZHdnp0S25lY0N3MStIemIyd1lIc3AvKzhw?=
 =?utf-8?B?dTA1UVByaWZMeU1WNlAvR0FQN05EbXZBa1plSTJsQTZDeEJqQ0w2dUo0YUlS?=
 =?utf-8?B?b2hhMTlHWXB2SHpjeng2NDhEbUpaZS96TnNxN3cxT3RpQnQ0RzNVblhxRnlt?=
 =?utf-8?B?Z3FaclZKcDNiRisxaUNBTldjd3pJR0NtN2VwRElmZ3NBQmUvbWFiQlBjK09I?=
 =?utf-8?B?YTBPYkhCNXI5amRPZisxM3VCeTNrMkdhbFpraUttZ1liK3p6QzFhZGQrcEpt?=
 =?utf-8?Q?0edAudVhCKPs0?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(35042699013)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:27:59.9528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8166d4a1-b149-4515-1ddf-08dc818ea303
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9373

The 05/31/2024 16:21, Joey Gouly wrote:
> Hi Szabolcs,
> 
> On Fri, May 31, 2024 at 03:57:07PM +0100, Szabolcs Nagy wrote:
> > The 05/03/2024 14:01, Joey Gouly wrote:
> > > Implement the PKEYS interface, using the Permission Overlay Extension.
> > ...
> > > +#ifdef CONFIG_ARCH_HAS_PKEYS
> > > +int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
> > > +{
> > > +	u64 new_por = POE_RXW;
> > > +	u64 old_por;
> > > +	u64 pkey_shift;
> > > +
> > > +	if (!arch_pkeys_enabled())
> > > +		return -ENOSPC;
> > > +
> > > +	/*
> > > +	 * This code should only be called with valid 'pkey'
> > > +	 * values originating from in-kernel users.  Complain
> > > +	 * if a bad value is observed.
> > > +	 */
> > > +	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
> > > +		return -EINVAL;
> > > +
> > > +	/* Set the bits we need in POR:  */
> > > +	if (init_val & PKEY_DISABLE_ACCESS)
> > > +		new_por = POE_X;
> > > +	else if (init_val & PKEY_DISABLE_WRITE)
> > > +		new_por = POE_RX;
> > > +
> > 
> > given that the architecture allows r,w,x permissions to be
> > set independently, should we have a 'PKEY_DISABLE_EXEC' or
> > similar api flag?
> > 
> > (on other targets it can be some invalid value that fails)
> 
> I didn't think about the best way to do that yet. PowerPC has a PKEY_DISABLE_EXECUTE.
> 
> We could either make that generic, and X86 has to error if it sees that bit, or
> we add a arch-specific PKEY_DISABLE_EXECUTE like PowerPC.

this does not seem to be in glibc yet. (or in linux man pages)

i guess you can copy whatever ppc does.

> 
> A user can still set it by interacting with the register directly, but I guess
> we want something for the glibc interface..
> 
> Dave, any thoughts here?

adding Florian too, since i found an old thread of his that tried
to add separate PKEY_DISABLE_READ and PKEY_DISABLE_EXECUTE, but
it did not seem to end up upstream. (this makes more sense to me
as libc api than the weird disable access semantics)

