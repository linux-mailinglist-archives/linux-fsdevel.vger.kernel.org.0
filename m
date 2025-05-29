Return-Path: <linux-fsdevel+bounces-50111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A92CAC8468
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 00:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4497C167544
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 22:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1421D3E2;
	Thu, 29 May 2025 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NhfHGj30"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90632629C;
	Thu, 29 May 2025 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748558854; cv=fail; b=c5speLbyHv58iZzmzc8lTpCQLjfTp/MtyNNHdCpEGqj8njH9H4KKUp5f0uFZ0XJrmHg61uVtJKdDAL/Ebtl6ZyPUrOrmhdii4qK8/xV5U4yA6x6/QEnd8GpuYitzFrzydmFGSrSe807shg/IS8dl3TO82Bot/BeRQr0S+bQHVz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748558854; c=relaxed/simple;
	bh=a6ZVmsbb7Rr34BeUZcTJQ4jDLu/uuUH7L+ArtWAwBRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQ6/wLZLmyMkltjJaxfEWTfqCCzJCdoNryRZ8nMyxX8u+odEgVWDAckkZzxwUdWBGEOfwS+/qwubxQOvavYKpO+oE6vWrU/lvbIIajt8nwOnzvFckBRAQkSotZY4FsJhoRpAnpjiikaRt1QQ5bondcd6r5oP6Qj77tkp2dBQAOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NhfHGj30; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPpsjoKI+8XhOMKGG+BjrTa0kfLnPUy0MDLVOVdq7VrJ3DBnWGmJdstqkQCUxwR2yOyTTU68ePDjpO5pnOU/EpLDjC/L1DupkvBCF4P64E5WxbdRT0fxXqlVC1kx8e1YPoaze7gZVGP5rJyqtnaImTdBVeobmac/MMBt1S2AxJHQAqBqmBS0n27VSXv70Vw9dk4D7r/ENJPFLyEWivu3eBjo6SmXYQeEyzTG6qNKCF5NW514ZoZardODw3t4AbjfaKaiDzLyPS06TqQd7PAbnRE/2/ou0ZuyUHB9YHJomng0w/b1fqC2eHksHvHhaakKUINJeUN/3H9hb9RMqS/rMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEJxDL1nGKc3uq2YULhUi+YDB9COFSvbMGg8GNotpnk=;
 b=tEndwAMqWS+pMvPTRCV1i0EVia6L4s2zeP/o5ll49OYoy8P4U8s/5mba+jgSJhJZgv1UbuEiM5FSYOfksZPXudTcoBGP8sBixqUwQ/16+WRCDTdxDzRNB/b1JolWOx7H7/gVT0V4TvJ+AJyV1Dehq+15X77T8nbMSWfH8XzUeR24VuJiYPpoTBzhuzJvbjpZSbYQv4sRUFc272kq78EjXejBz8guPrqSv1ejiDiGPzeiurXqs4w2nFROveNPcrIYDEeWVUJIU3FIJuf5PubASqRTJY93cNRFSUwlcJulJV4biRZUoSn6KAX2mqYUwTG1+w2ZnoVcoVyaTY1C8ZENLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEJxDL1nGKc3uq2YULhUi+YDB9COFSvbMGg8GNotpnk=;
 b=NhfHGj30To8PJ/qL01i62SPwe44+k/eKJFJPHBHuL3bbGsqE8HBKzI5zg0YENxdzAMbza+LIeDCek3QJkwfdIREHEKZWYhCSK/t4qdxRirVPK0LRDvv02aVuzisxgvwmnTkVbo7uavhBsa+UNAUCbCBfPDohTH/NrTpf1XrM7BGsRuKnNzq8Pq3NLflcoD5euM0wv08W8BILOqfyyj7VQawFmnFlkjoBnSOzCWbynKvQLNK3wO4FdOrjfiKION7JGBpLZ99yQictvd5LEKuKG8IszsIJSRPO37kLFLljXjf3BqH9MNOq4BnJZTXdiibrjnuJ0gxu4TPkQmJwOKg9Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Thu, 29 May 2025 22:47:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 22:47:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
Date: Thu, 29 May 2025 18:47:25 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
In-Reply-To: <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:208:32a::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1138f2-8cb6-4ee3-3932-08dd9f02cad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3dsU1NxN01BekJ4eWRNdzZGR3NCbGlHdEhMZWZjUHFaeFoyYTJOc2w3WFVr?=
 =?utf-8?B?WkFWQXJaZUxDOEszSEh6NzUxTStBKzV3Mndsd3A2cHdLaW02WkNuZHdwUmp1?=
 =?utf-8?B?eGhTRmwvbU5sK3duKzA2ZXE4V3AwaWNCN1NYaytlYVM3eXBQU1pkUkptRnJK?=
 =?utf-8?B?NXpDd0ZzZDZ1Zklqd2hxcnBZako5QTVmR3VQL1NqaExLdGtueWFJdk5xdzdn?=
 =?utf-8?B?Zk1wUXFYeTNUOVR3SzhNMnErNWdQbnNpaEVGaHZSbXZ4ODdONGlreklzVlJI?=
 =?utf-8?B?Ui9oTzloUnQ5NmJDTi9CSU1qNGw5QkFNQklQSTQyaXRiTXl2ZzZUSlRndjly?=
 =?utf-8?B?aUFTTWlwUnRTSnVrZjQzRFRLcnA2TEVDNVovWnJaTEZLYTM0ZTAvU2hsVWJ1?=
 =?utf-8?B?VlpLWlJkeWNVdXdZSkJPWnlTRmhiOHVWQkd3UDNpTWpPUXN1dzgzQzJyVEIw?=
 =?utf-8?B?TWpFOUZISVRXTHB0MTZPWThrRDYrRlJYQ2VMT2drOWRic1JEMCtLNDNLN3FC?=
 =?utf-8?B?RVpKT1Rhc3MzZENML09qZVZDaGFBaGsvWi9Gdk05VTNzZ0wrem80Ymx1NnVI?=
 =?utf-8?B?VzZnVk4veG1tNUFVTjhaWTNDcWRMUy9JaVJScEFLcWtHZGNJWndrdFp0bElX?=
 =?utf-8?B?cE9jVEhkczRtMWhDTW1iSmx2UjFLNy9EWERoaHA3VnBQUXc5QU9SQkVLeUNR?=
 =?utf-8?B?d3oyTUlXdmkzbkF5RytCZi9HTWJLbXFtTk04a2ptL2F5b0ZhQWViK0YrbkpF?=
 =?utf-8?B?YXlrcVV5QzNLRWVOVkJNMFNiZWlxTDd4VHhqRy9tcVVka08vYTE0TG9UeVBG?=
 =?utf-8?B?amx2ZURHRlNnT0xRbmdMbUdCN1hFamdGL2hXOFlaOFYrMGV6RHZVU1hlcG5l?=
 =?utf-8?B?YlJHd21wTnJsNk9vYU1QeUV4QkVENEczVXZHNWZLR05BeWlOdTI0dXo1blc2?=
 =?utf-8?B?ZzZoUys4WDIvbnp5ZHpQaFhobUwxRFNYR2NqSDJYQWRmQlluTHJhbm1VZ2dE?=
 =?utf-8?B?OUE4QXhxdGZQSkcvVkZrUzZodmtwOFpINTZsQkl1UHpSOHdLaTRzbTNsTEhI?=
 =?utf-8?B?dGpkQ1JHTmZuMnBiRnhybWpyKzhqb043ZThTYVBxbThTRzJHaEcyTXhNMzV0?=
 =?utf-8?B?VG1jeXRNS1huQTk3YjZQWnpLZHVBSXJsbnVkU2h3NWpmMW1KY0lJUHN4clU4?=
 =?utf-8?B?Z0xsRWd6YmRub0JjQ2owbHc3dHdINUtZZjFPNG1pck4yMjdmcE5GbHlXWC9n?=
 =?utf-8?B?SXcxdjFkNFNyVDRxMUVrUUJvOTNTL0JjVUw3L2NFcFBORHhnSHFMQVhCblZr?=
 =?utf-8?B?U0V4ZmVZQlJVVDJjT1djZ3F3c29HZHhjOWVVWmdzeEZMdjV4b2VZN0VaaFNN?=
 =?utf-8?B?WDA2cEpqRHVCSjM2TUZ4NWJBKysrNzdERmNHMFBjS0xHU2Q0QVpWcUJXdUtZ?=
 =?utf-8?B?WGxKenYxcEM3L2NyNVZ2UU1YMTdtUHIzaGx6SlhaV0wzVUJwYjFyaWtzMXZW?=
 =?utf-8?B?UUxETlU1bDR6R0NpTUhBQjkwL2NiTXlzdmVzSmN5NTkrWlZmMzRHeXVRcHd2?=
 =?utf-8?B?dVJKN1FqclVlMkRFUnJCc0ErVytOMytQNjRTZ1JWRnBFL1cwRjJMUTR5YlRV?=
 =?utf-8?B?dnZ5dU96US9HSEo5K2U5TVJ0SkNHWkgwdzF5Qi9QaTZNZGVLUHZhSC8rY2pp?=
 =?utf-8?B?TXFuZlVpSEdNdG5wdjU0am5FSzd3V0NsNkdLNDU4VFFTZEZvb2w5bk1ZUEVJ?=
 =?utf-8?B?dXVCUTEwQVQveFpkcitmY1hrYzFZMjRFQzAvaUFIZ0dIN3JoTVRSTTVYNTNJ?=
 =?utf-8?B?cjRFUk85T2VhbkE4MXJadzdXZXBKdnh4MUZ0R0VjYXBrdnFxTG1mWHIxWHhX?=
 =?utf-8?B?NFU5THhMbGRzcEZjVkhiNlVsVG5MTlpya2JrVGUvaVB2SVFYa2lqK1lMWTNP?=
 =?utf-8?Q?zaO4flblHsg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXJhVFh4aU13SjJiOGFoelAvVEtZVy9GZzVSQ3ZWbVVtMGlnRG9wcXdNRXZC?=
 =?utf-8?B?NGU0ckRZSG5YNndwTTlzaEJzaEJ3djBsMHg0dDJ1cFZ2RXYycGp4VHRMTWZY?=
 =?utf-8?B?emR6TTgyRFJONGR1bDFIM3QzRGJyK251WnlLMHNTS0N0LzlPRFlSRkllKzlP?=
 =?utf-8?B?K0lTQVp0L2lKelV6R1ZHUXZSUm5Ldk1jaDR0L0VkSmxrR0FSdDhzTEY4RGR0?=
 =?utf-8?B?QlB0V21uekhQR0wzd05xY1d1eTkxaHRWQm9zMHM1eTdLdVJPaHQwb1cxdlRM?=
 =?utf-8?B?SER4K0oyMmFxeGY2QVErem1sUXpqVFRHVWhKc2RFR01GVXdvYW56WjBnMFh4?=
 =?utf-8?B?cXRGMDVDRnVXaHFacG1jL1RzaWowOUxlbWZsaWU0MW82WjdWVHhSNkM2aDNS?=
 =?utf-8?B?WVBuWnlOZTVhRjVpMThJc2xZMmlyS1ZyMUFOWWp5SmhPdWJuNzdRcHc5bDho?=
 =?utf-8?B?aE95UjZvaUxUSGo0VTRMMDJBMmRNODVYZGY0ckRkRDVUVUZzbVMxOHZvK0dJ?=
 =?utf-8?B?V0dKeGNNdFcyNDB5NWJJRmt2QUw5ak5HbmswbFBYTXJqLy9ON1UxUUNkL1Nl?=
 =?utf-8?B?cVZhUFMxZEZlSDFydW1zQlRnUW9LTGFXVjVsVUlOR1ZZS3BBb0x0SitSLytw?=
 =?utf-8?B?WSsxVmZsWmlyVEpKMktVSUZGTVBuNnZWTDB2MS9PeUkwamVIREFqZnhkYytN?=
 =?utf-8?B?S0pZenIxQVZicDhqTFMxeGsvSGZsZjRIUFR4MGdjRmd4c3JNT1J6OGZwUzZp?=
 =?utf-8?B?SVlvampSdnZhUU5NWG9mOTNHV2JaR2gvOHpUeWIwUm9PT21pcm5taHhTR1I2?=
 =?utf-8?B?dG54T0VieWYrNGVKd1BLWDAzVmlnZ1p4Q2J1dlpjOXo0U2tvRU95WnJkd3Z2?=
 =?utf-8?B?S2ZwSnZiS3JDc1d5enFQVmNVQnQ3OE9POUNVeTlRSjZ4QnBkUTMwK3RGTWVm?=
 =?utf-8?B?OGc2Yzdobk5saTYxNjlQQzJGWm1KTFhvVi9uZ2dhV0lkVXFEUERVcmRpYUtL?=
 =?utf-8?B?aXVQanFRNUZjMHRNZTVlVGFyWjdWTERkYUxrYWJqVENhRThaYmttOERUSkp1?=
 =?utf-8?B?SkN3ZU8rZVdJSGI4Sk1tYjMzU2sxS21xdDRHRXBpKzJUOHkrU2EvU2RFelFD?=
 =?utf-8?B?SjVJZCtCQm5Ecm9DeEthTXVPS3UvZzRYT3dYdE12cW45MkEwb0p1NmlCLzMr?=
 =?utf-8?B?OGF2Z2NMTzFkeFhJQW9sWmNJZGpTYXFiZDZZTmVEZU9rakJnY1ZJQjNaaHZr?=
 =?utf-8?B?cTZHRnBKWjh5QUozOG9YcTd4SEZWb3N5OTRwbEprYnlDTjhtcnNpV0FadFBR?=
 =?utf-8?B?cFFLWXhOUUhMR0RzWG1QeUFyRXFndVZQSXJLUytSc1Vvek1WMUtDNzlPYkl0?=
 =?utf-8?B?a1FsSDhmU0RRYlhsZHIraitQZTJEaEp0a3B3T3d5YXNIcTNFcGY2alhXamlT?=
 =?utf-8?B?RkRkWlNoL2d6M25Mc0NvTlUzUEZHSDJ2VHdaa0lITjI1OXRUMExmRG4xcDFr?=
 =?utf-8?B?Vm1UeEdFdmEzSnA5SjBKMVczVTBsQUtTbG5sbHlreHBISW1rWTBnaFZtandN?=
 =?utf-8?B?czFGajNnOGNBZGsvWVU2OVlmNkNFMGZCSEdqRmRkREtaNE1vVlFYYWxpTE5Z?=
 =?utf-8?B?OHU5dGVteU1qVXhDOGtCSk41Uk11S0gvVW1kUVl5cjhlMHR0eGx5ZEtpNkJ6?=
 =?utf-8?B?RGVVNVJRRlVYRWFDbk1aT0xiRE80bFFZL291d2lVR29BdUcxQWxyZ01kWlE5?=
 =?utf-8?B?WGlueGdST0hCZncyaFc0Qy9HSDVGdFQ0NGFJRElvV3ZiWFZjRmlmakZsRHBY?=
 =?utf-8?B?Tm9OT3hVYytoRDhYMTd1UG1qTzNGd0MrQ05Nd1JJRlpDTjBLdHFIKzh3cDJt?=
 =?utf-8?B?RUZiRk41UGRKVk1TVVVXZ2dQZnMxSjVFUnkxVlE5NGNsb05qKzR1blVDaFFw?=
 =?utf-8?B?L0lHanRWV2YrNjNUNnNXN3BTbVVSNVVVYUxqVFI2OHQ3MEhYbm1zbmIzR2Ni?=
 =?utf-8?B?SkZOUm1hMjNaUGVSYlRVM3RsWTNsRzUwSXA1QTk3R3pZYlY4WUlwZmQvbG5O?=
 =?utf-8?B?RlYya2hCSmtUeTErOWw1cEtHRS84TTNOdWozVVRYWGRrY215cndFQzFyWVhB?=
 =?utf-8?Q?LkzA5GRAX4JifWAJub8sRM5r4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1138f2-8cb6-4ee3-3932-08dd9f02cad1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 22:47:30.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PudJ/n9TvMF+ilRqgzunE0BWINe6E63p2t8WSm4pNn0fY4BR4FXaz2Gub1H2kvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208

On 28 May 2025, at 23:17, Dev Jain wrote:

> On 28/05/25 10:42 pm, Zi Yan wrote:
>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>
>>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>>> Then it may happen that the computed slot already falls beyond the batch,
>>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>>> order. Thus ensure that the caller is aware of this by triggering a BUG
>>> when the entry is a sibling entry.
>> Is it possible to add a test case in lib/test_xarray.c for this?
>> You can compile the tests with “make -C tools/testing/radix-tree”
>> and run “./tools/testing/radix-tree/xarray”.
>
>
> Sorry forgot to Cc you.
> I can surely do that later, but does this patch look fine?

I am not sure the exact situation you are describing, so I asked you
to write a test case to demonstrate the issue. :)

>
>
>>
>>> This patch is motivated by code inspection and not a real bug report.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>> The patch applies on 6.15 kernel.
>>>
>>>   lib/xarray.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/lib/xarray.c b/lib/xarray.c
>>> index 9644b18af18d..0f699766c24f 100644
>>> --- a/lib/xarray.c
>>> +++ b/lib/xarray.c
>>> @@ -1917,6 +1917,8 @@ int xas_get_order(struct xa_state *xas)
>>>   	if (!xas->xa_node)
>>>   		return 0;
>>>
>>> +	XA_NODE_BUG_ON(xas->xa_node, xa_is_sibling(xa_entry(xas->xa,
>>> +		       xas->xa_node, xas->xa_offset)));
>>>   	for (;;) {
>>>   		unsigned int slot = xas->xa_offset + (1 << order);
>>>
>>> -- 
>>> 2.30.2
>>
>> Best Regards,
>> Yan, Zi


Best Regards,
Yan, Zi

