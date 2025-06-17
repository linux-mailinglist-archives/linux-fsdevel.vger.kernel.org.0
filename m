Return-Path: <linux-fsdevel+bounces-51856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC43ADC2A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483D116B1B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9628C036;
	Tue, 17 Jun 2025 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CmPdz5tp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uMacBaiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8D2BEFF3;
	Tue, 17 Jun 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750143510; cv=fail; b=E9b6ghuJgaJJeKyQeSGMx0pODNvVp1JYT/a3YABBdgDINTQKBCN/0k9tp07Lyoe67S8xNFGUA9LJuILYQq5yhhnAh89B2oV6OM56jxLmgh0bKYKxSzDzT/KyN5d3TRHMTBcSGmoOfVlN1Rx0s6O+i8ApAGXU1K7OsHUpEaw4R8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750143510; c=relaxed/simple;
	bh=Vz8QafctSVWPpvhcmHFQ6SH2tK7gwOv/peLOMkShx5E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tDNWRRz+XS+kidmZeECdMdW9o2kZMRGTbALXwqNaz1mkedxG8eOIq+WP7It5TKdEbJdCPptdQ9HrfP+pbwBxYPv9+SdB+kdeXHMJ3gvh/rokxrt4LQAeL3HhWuPnrdzbPrXrWfJAxYa2cPoOCJRmGAt7GKVdmUyPfqwZzrUd2eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CmPdz5tp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uMacBaiB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GNG0MO025107;
	Tue, 17 Jun 2025 06:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e+WIkdXlb8UMCjzv4L17GE+JfPfl2wnq/HwPdIMMEQE=; b=
	CmPdz5tpd8vU2YuImq5cvjqaGkN3LNEEg6PvLl7TqKng5UaVbbhRkN9UcsyHXTPc
	PUFZKFTUe/brMduuEDqJxLrAlMI+mdSFmj5sxebqUbWtyF2Acp5dEQFobPEqZ+L1
	UlWWMNBgo2jXrWmWC4iIvjVwUxS7f7K7XZRcHF4q2VrmRKvuPm0UugQCcWgTn6ya
	7PfIQIdUhf8JqkgyuQ6IyBFiph19W7M/3HJ/rd90jAn0y3ZUpStfe1xQK1u0J9xn
	6gM3TzuxomzZHfJ54AnrWjDz+u6lLIS4CS4tsO+YJsKIllb/3n4/5ggzL45AHhUu
	H5IF820aeWBjdVk1b5E36w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd4n06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 06:58:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55H6jpS2034466;
	Tue, 17 Jun 2025 06:58:24 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh8m4ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 06:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2ojArMQcBAAF2qCfTl3P1fsiELAI2rN8KraocK0dOnmr9BOgLoi7x7pySID7X+NIGnj4E9Pai6yX1TgftsITyfRSAaRfBavD+DcAEF6hQV3cx9s47caRnksYtKm4/4aBvllGv/A/DDSTmm0NnH2sIUIggufMf4sE/QCUAgU98t6CSIAHeLw8erKAoogGWkrMf7UPQQXd7HdYd/vjJc8NpACvLz7csQHuoreFM7HxXK0K7TF0T8ANW0H73Zrd+WEJOpetpwOY6GcJMf9pPvsUWGDs3z3Exap81PbPSGzklPlAfmby0SsVN6GDI0EkqeoOGOtP2qMmbanxtm9W4hvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+WIkdXlb8UMCjzv4L17GE+JfPfl2wnq/HwPdIMMEQE=;
 b=wkpTUEnPOkWNMPlJ+ZBdUT0O7280Yt6iA+ngRU6v95quo98eB1QS006o4ydA1z5s7w2Ld30jraERsv+7LBWAnL6+hZwJIKFitSpJ7UJ/BMuo/ICc3Yh0lNCMoO8mDSH1HU0bURbos1LSPliNSsmma2l6eExO9oMu3alDDscsh37dtE0BKLcIQTklIU902O85QXoHtmk0RXXCSIwFWcJ8K1nwKEZkydmyqiuicYBL8tiaC9xdpQobCESbxqy919dwxUVn00jzr7j1FOcaPyaNLi7SGksrr6+/1BOW0nZutLa3YqL3UyHZ7srH1++zXoH0f6G+bznA21DwRpapY5vMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+WIkdXlb8UMCjzv4L17GE+JfPfl2wnq/HwPdIMMEQE=;
 b=uMacBaiBjtVOQXyzqoqqxdV3odayX2Z2knXpijsucQDI+JM+vtXwYBVKZj6P01QR1MoqG3GUJ0QQ8r2+XcDCfgDxMp9D9oae8g3Cy1JiZUd10FGnVNa9Jk8LjJrbvcb3R2Yq2KTWBPlAMf9LRLCv9U7GwscYX1OiwmS5J4ST2jc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Tue, 17 Jun
 2025 06:58:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 06:58:16 +0000
Message-ID: <913b73c7-cc88-4c70-bb53-c0f8cfc60d68@oracle.com>
Date: Tue, 17 Jun 2025 07:58:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve read ahead size for rotational devices
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@vger.kernel.org
References: <20250616062856.1629897-1-dlemoal@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250616062856.1629897-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e835cb-41bc-4457-0661-08ddad6c55ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE5MTHFGTzBLZ2RwSGlsWWZRQmE0RXI5aWl2SkN1OVlzNkhPRkNodUMvRHlO?=
 =?utf-8?B?ZWYzMnVBNmtTT0RMWmN2US9IdHZaM25YY2pEd1JuZEJXOTVBNDVGSENKUUxP?=
 =?utf-8?B?RzFWMTNHN1dVUHdqdmxQb2RiL3U2V3NScFdNRVhRRHRySUhhOStydDc0aHB3?=
 =?utf-8?B?dVRZVXphQjhacDRvQzhBL3k4WVY0RCttZk5uZ2VkMUtvK09zM0JINXhKUGla?=
 =?utf-8?B?S3ZySmdMY2NjUTdzci9Sd2IzalR2S3h0eGxDUkpibTlCQjIyNUNSWlpKUi9t?=
 =?utf-8?B?MFhQUElyVk5MeG0zb2pwbm51SWNmRUVQYjhUbnRFSit5dTR6QVJtdWV2a2Ns?=
 =?utf-8?B?WURNRkt3WFBpcm8zb3NrR05Ud1kyTmFYeGlBQWZ6Uldxc09CWFBSQVNUNmdB?=
 =?utf-8?B?TFFnTFUweWRjY1JaRzVjMWtmTmx6R05aY0MxTVNrRGlIWks4bW1wdjN5S3Ra?=
 =?utf-8?B?OGl6L2ZieDVHV0JaeGovY3F0anJ1Q3BZSEU2eHFVQ2VJUnBKKzVqVVFGNXlT?=
 =?utf-8?B?dGx1UVpyRUpISmUxT1lGN3FPQmJ6QVdkUitFWmhqNFNUUkNCM1ZwRzZuRGpr?=
 =?utf-8?B?R2ROTEM2enNEU09lVk1VZ2ZJMWU5cHNYMzlFQXlxWGNETlVsZk9YektmK21B?=
 =?utf-8?B?VkcxYXplYm5kY2JNUXRya290RnQ1dU0ybU4xWTVCaHRReXYyQi9sWit5Y0J3?=
 =?utf-8?B?QTB4K1hFRlI1V2NMRGprL0lqSktlREZKWk9XemYvQmdSMEwyY2hiaFgvTFlJ?=
 =?utf-8?B?KzNYbEs4NERPWW4yRW5CbmJOY3paYUhhK0hpU1JDK3A5SUhKUzFtYXZkS1R5?=
 =?utf-8?B?MHRFUlp6K3diTlRBN3J4U0ZJNWNXNGtCSisyR25BcEowQnYydzhCNHpiaEVV?=
 =?utf-8?B?SzBkNWFZVW1YUVhMdUZUa0EwY0RaaTFiWkRBV2RBYW5DZzhmb1VnOXR0c0N4?=
 =?utf-8?B?YVVpbXFCOGRSajk1MFF5M3RSL0o2RWxIZGUrZjRIVWJWV1l2QTZjcHRBUkJB?=
 =?utf-8?B?VW1tVGpUNVBQcG9aYmdCMlZReDdyYlRDY3BJZW9JRXEyZ3NXaGppcUtHZDZT?=
 =?utf-8?B?NElicTlsY0VFTjg2ZFJNelJEZ0RXYzRrNGtsR3o2UHlyWXozb1BkTDk3Vm10?=
 =?utf-8?B?LzZaMGtlcEpjU0xvOEl1Z2RCcmErL2YvNk5vS0lQZW1UM0JwVGN2TUFjSGF6?=
 =?utf-8?B?Qnd5bWdHenhoVVdRUEFtcWhFNlg1YXA0M2dUSTlUaVFuVXc4dWZ4LzFFMWxy?=
 =?utf-8?B?V2F6VUxTNFNCNnFOSTJsSDRBV2JmN0E3Z0tyMVBVZ2RHMkhLUHdHZjdlNGVT?=
 =?utf-8?B?WXM2aVFCK2Z0OFp0SUpwbHZpM3c3eXhYZ3dvdWlvRkRKZHlOY0RPTEIyejh4?=
 =?utf-8?B?QUVGYnVPYkFRcmR2T0xzVlcxaXVLUWNpN0tENWNDSmg5VmFnQURGaUlKNnEy?=
 =?utf-8?B?NXNmcUdLQWVITTdjNGJqSERiL0NPQXpjWXlEbkJxUTlod3RMOUZGeTNxWG9j?=
 =?utf-8?B?SElWZStYUWVGazgzc0JWTTEvUmFyMlh5bFJlY0FVV3hjMXV6Q3FuaFF0ZElu?=
 =?utf-8?B?WFI0cTdScXVnZHJmOGc0VHIyZDlISUZ2VTlPVE1yaElnVmEyQXI2UVQrU0ZV?=
 =?utf-8?B?ZHRKVndQVk9EZEJjRW9wYkMvVDNGMW5KZGRKOXpmSUJWaC9OMEFZT0dBN2Rx?=
 =?utf-8?B?ckwzQ1RBa3NFQkFUVXlUb2U1bmNOVWxkU0l6c1Byck9aaDdxYmZUaW1Ia1gy?=
 =?utf-8?B?cXUycnZCUnU2dmRLeWg2R1ExNXlGY1diOFBBR1p6TFJCMkpNajZsQk54VjhP?=
 =?utf-8?B?SHZVZmx6akozM3NkR1R6L043aFplYnpVaWNWdlVycjZkNFhKOTRrNFBWUURm?=
 =?utf-8?B?dFRGcGxhUDQrUHR4ak9JSkVyc1NybVphMTFmaWJxQ3BMMnQrRC9SUWs2RTQ0?=
 =?utf-8?Q?3CejbU7jS0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z21RNCt2eXphb2JsVGpsTnhkc1Q3aTZLbHhUK21kMzJMY3BYUWJHc2VtN3RL?=
 =?utf-8?B?ZXo4U1hPUWI2ZVlFYU9Da2xaWWZ0a2Jwb0REZjAxTUptZ2NrbGMyVU8zQnVT?=
 =?utf-8?B?b1J5WWdSQW5MOVFjQkNPL3NHblJMampXU3VGWEczSzk5V3JLQU8rekdaQjF4?=
 =?utf-8?B?L1E2cTRHZWpHWU5DczYyaUs0aHNMODJVZzBBc2lxTC95Q0N0MmJtMUYxNWpE?=
 =?utf-8?B?SFVqa1UzN1duU1ozS2Zwblc1bTE3UnU4anI2WnA1QVJDQStZVytYTnZpRTBY?=
 =?utf-8?B?cmtaMlg4QXRCYVFJKzRUa1pVSEJNWEdJaHNvRDB2S212YmZOdm5mMGh1NFl6?=
 =?utf-8?B?d0xVRzY3UUs1VEFJOStyZm04MFRZU1ArbjRObTlISDhIdkZSc29JMW1Gd2dH?=
 =?utf-8?B?a1B3QWdyRHlkRWRYbmw5OXBKVFhSZlBvbE82aFFBWXcya3Fja3JhNEhCYzk1?=
 =?utf-8?B?aTl4MlMvS2E4b09FdDhoRElzS0JYMGxNMURPTnp4WkFWYkI3eWN6K2ZySXlQ?=
 =?utf-8?B?bzRHQnlIZU9JWlZEK1BRd2F2NE1JY3NyYUFtaG5YeXpleHhqaUhNeHlncmU0?=
 =?utf-8?B?MTNyeEFjRXpNcG1FcE9VQ0tSeW8vTXgyeDErcURXS3h2M1ZNaW9BUmJITWVv?=
 =?utf-8?B?L3pFRVNhM3B4YlNGN1N4QXQ2T05FZ21YWHJWYnl3M1ExNkhwaHB1M3puT2xI?=
 =?utf-8?B?VG8xRFErSkQ3eE44U2xrN3dpTGpGMm9OblJ2SWNKSWc0d1BIaGFEOGYxb3FH?=
 =?utf-8?B?YlZ4SElyUlUva2pmRm5Hait6VzlEd3ZUSUEzZTBnaXF2NW9ublJpNW5mSGZG?=
 =?utf-8?B?eEFKcjNpWkQ5QVJmSFByT0RhZlRHZnZVa09SbVhCWmVuNVhJblpseXhZNGhO?=
 =?utf-8?B?K2VIaVpOTUxrWGErTlZ6MmxPTUdiZXpRcjdieVhLL3ZjMG53TDh5d21naGVP?=
 =?utf-8?B?Q3B3dzJLbDlvTHNCeENHdXRoRDlrUitheHlTVXltMm5XeTVZejlOSlFyNDRo?=
 =?utf-8?B?dmpObFhoemV3QkRWTGpYR0NOQ2pQVXhrbE9qc1pXeEI5K0hrK2xQNzRPbFpq?=
 =?utf-8?B?eEFNSy9CbXhOVDBDcjZudUZqV3dCOHFlZUdJYWlpUS85WnBpTzlrNkpPdDh3?=
 =?utf-8?B?dnpZT3grYVBmbzdyNFVzZG84bzlCTW1FUW05RjhIMXhlT3RVczhzMGRQQ2pI?=
 =?utf-8?B?NDFYQTdCd1E5U0E5UHBuMWFKcEpjY3RFSStKYUZkNzA5WW1zd0I2NDFiM1RN?=
 =?utf-8?B?Tk0rSEJLR1ZtaWtsd3B0aEhnaXhPQWJpNkdrakVUTUNuM05iNmtVWFBPVEtw?=
 =?utf-8?B?eVZkZjBrZGdOVm40L2hmQWM3WkhwYmlscmt0aW0xbm5Qc0R0QUNKTytaWkI1?=
 =?utf-8?B?VHorL0dMWllrRkdOb0ZkTS9ZZnhMQVQ5cFZPSHd2TVhXUWhYM3A1eS9iNVNQ?=
 =?utf-8?B?bFgyUnRuREtBaTVNc0VHQm4wTll5WnZwL1VWaXQwVU5tMy8vVFArVGkvMFhY?=
 =?utf-8?B?ZGlYbEd2VWtBWnFOWjc1TG1lRllzdHM3d28wVitiek9XT1FBaThYL3BXRkNj?=
 =?utf-8?B?S2tpc0FVSzBBMnVMWEVkb0dOSEhJbk1MRHNIYVBJWFJiMXBUV2M4ZExocmtG?=
 =?utf-8?B?ZTh6cUswOC9KaFRuM1ZZeW9FblV4L2ZjN0pIclJYRTBaaFRBcGV0SURxcytk?=
 =?utf-8?B?NjV0dzZ1MHJMdFpUNk1CMVJMKzhsSmRuUk1yeTRqSktWdndJMVdVLzdVaGF4?=
 =?utf-8?B?cGJBM2NmMURSaEJpZDFMR2xsU3pKMmNlU1UyN1Zad01EbFVUMG53dW5LMWY1?=
 =?utf-8?B?cUk0K2F0RGl1Q3R5bXRVSlJXQVRtRndMcVIrR3o3QWdWTnd4eWRTaHZxR1kv?=
 =?utf-8?B?VXVyR2tQVW9QVVRIQ2JhR01jemVTcGE1SDlkUHFONEw3MTZncm5tYW5jN1lB?=
 =?utf-8?B?TlovMTRVSFFVdEpaK1hCeWlCUm1yRVIrYzkxLzhVV0FsQkQ3R0c5WW1EVEIv?=
 =?utf-8?B?dmdsMGliR09VZVBLZkdnZlFWZWUremJLVVkyN0YwcnRYOU5vcmZHT2NGVWQ5?=
 =?utf-8?B?djBiNlBFOFV2bldwdmg1SlN0Y3JSRXA4eTBMNnJhbmFLd0JlYlNjTGtZcnND?=
 =?utf-8?B?OE5ZRVJnZ0cwZDJ6WjJBM1VsSWdQUUd1U3MwdExxZFZrYmZxTE1Qcm0rSksw?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	op0run/VDHFzsw60ixQd56eloMP39bi0RbDHJ8bTPOghU1ttmEb7mfjXcRQluMP2viauD4b13YVsjghPQO6XIQRGj0RwJ8wbYQJjWo8FIDe+D3C07OS40StRFal8H9fbttdFydOA/cnT0Xby8fxta4tmc+6cyVbzOWCgWr28Q5DDajTEgVMohiiacz6dGTQQ6tzG08DXmLp22Esj66h24BGkjN7+YgujS6v7nV460RGG8Gl9iNLWi4B9nJUPPwJjPfxO71BciBu8tDAzf4syhrRroRzoaqE/gQCAXTUE+IIFvYVUvV/MSR/+MUG0qUDFfLnFUszgM4+sqdN9qpk1MuMm2/RuxhG8yN4Xu1iM8VeirHdlK+xBNSVpeowX+7kgoR9lTRbIQ0NzKCouHbLGDMjnCfs9T440RbKlcnt8Uv6nfFllIFjLhZJGuITBAQSl4GxvNkaO4vEX2WFkgvFnzFxLNUT3nx3FJGgK9CsaMBqT/P1p19+WmoaFqlgyoeF5K5yxjiFm4KSoHeZ1J4y5oA8sjJuhtH9ZD4JB9rhH/JMF4zEsOzhIEhJyH8seAazClGQ3eACc7bbO18/hsIQxv++q0ZNszs/HwnhuZiEIfuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e835cb-41bc-4457-0661-08ddad6c55ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 06:58:16.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZrCVnJinBG/wA6zTy09/qa87PmOZHQy4zsSyyeDKDKm3ZjF5EkHWdjplOGllE31unp2gK5o1nrNe2iDTBGiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170056
X-Proofpoint-GUID: 3UAzhjcb_vRNi1CfCXimO-__1vg-DDqx
X-Proofpoint-ORIG-GUID: 3UAzhjcb_vRNi1CfCXimO-__1vg-DDqx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA1NSBTYWx0ZWRfXxiXSt1pDfH/U yaFfV7b0NgWWxePOKB8lAh2223mi06XUzto3LU0RFss+0lN8i2LWIFBGmB/sePDrWNEUIRydJA5 H/ym9W75noTs8D5DaDtkNPZfp8csxonMFJBQfabNlU7VnoPj+ugPwXMelOMlTER+NhSVGeN896u
 5BRHqjm9fLT07kVCJ/Dyl5ymTR2FUf/Ff0SC4u+i1cU8g9toZ0xVpiFdJpNvOpny/JS3kfr9Q7F rxL9S3vru5iS5u52aj1vvjIO6gLgf22IpMC3YT71jLtO1cLNINwq+tm1/qp7+a7tHJuGpZWoxBM ePN1Y85myfXaYDMKWsnj0mRymhHTVfkHpsKsh/gWZXklYP+sFwmbZ4mn2k7zyHXpuR9l+F2/Aj8
 rKPQzA46BDCf6tIy5uLUtB3kXs9NI1qQ/lHo9AmIZUlSba6ueHsLbJH2vx757b7V0aoYWs66
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=68511211 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=oNYz0cR-678NtK923Y8A:9 a=QEXdDO2ut3YA:10

On 16/06/2025 07:28, Damien Le Moal wrote:
> For a device that does not advertize an optimal I/O size, the function
> blk_apply_bdi_limits() defaults to an initial setting of the ra_pages
> field of struct backing_dev_info to VM_READAHEAD_PAGES, that is, 128 KB.
> 
> This low I/O size value is far from being optimal for hard-disk devices:
> when reading files from multiple contexts using buffered I/Os, the seek
> overhead between the small read commands generated to read-ahead
> multiple files will significantly limit the performance that can be
> achieved.
> 
> This fact applies to all ATA devices as ATA does not define an optimal
> I/O size and the SCSI SAT specification does not define a default value
> to expose to the host.
> 
> Modify blk_apply_bdi_limits() to use a device max_sectors limit to
> calculate the ra_pages field of struct backing_dev_info, when the device
> is a rotational one (BLK_FEAT_ROTATIONAL feature is set). For a SCSI
> disk, this defaults to 2560 KB, which significantly improve performance
> for buffered reads. Using XFS and sequentially reading randomly selected
> (large) files stored on a SATA HDD, the maximum throughput achieved with
> 8 readers reading files with 1MB buffered I/Os increases from 122 MB/s
> to 167 MB/s (+36%). The improvement is even larger when reading files
> using 128 KB buffered I/Os, with a throughput increasing from 57 MB/s to
> 165 MB/s (+189%).
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-settings.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a000daafbfb4..66d402de9026 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -58,16 +58,24 @@ EXPORT_SYMBOL(blk_set_stacking_limits);
>   void blk_apply_bdi_limits(struct backing_dev_info *bdi,
>   		struct queue_limits *lim)
>   {
> +	u64 io_opt = lim->io_opt;
> +
>   	/*
>   	 * For read-ahead of large files to be effective, we need to read ahead
> -	 * at least twice the optimal I/O size.
> +	 * at least twice the optimal I/O size. For rotational devices that do
> +	 * not report an optimal I/O size (e.g. ATA HDDs), use the maximum I/O
> +	 * size to avoid falling back to the (rather inefficient) small default
> +	 * read-ahead size.
>   	 *
>   	 * There is no hardware limitation for the read-ahead size and the user
>   	 * might have increased the read-ahead size through sysfs, so don't ever
>   	 * decrease it.
>   	 */
> +	if (!io_opt && (lim->features & BLK_FEAT_ROTATIONAL))
> +		io_opt = (u64)lim->max_sectors << SECTOR_SHIFT;

I'm still not sure it's even possible that lim->max_sectors << 
SECTOR_SHIFT overflows an unsigned int.

Anyway, FWIW:

Reviewed-by: John Garry <john.g.garry@oracle.com>

