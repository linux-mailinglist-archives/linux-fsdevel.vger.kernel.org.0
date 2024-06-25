Return-Path: <linux-fsdevel+bounces-22366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10713916ADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8569E1F27EF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822D616D4D6;
	Tue, 25 Jun 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p5et+gbW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CB169AE3;
	Tue, 25 Jun 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326718; cv=fail; b=doe41pHN1Q6dCqufCFmJsGS7cdGKBD0VttlSlixp7wGZrH8zQfs2lW5eba8FEMYdanevkgRD7Rw9TPn5mPFasfsC3yNv3atkF+xmiyYKWlxXp+NRn3y091aLQO+GyITJO3s1HyuD8N6Zv5kbtCaSke5wYTbXrhXq7hH30TmSb8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326718; c=relaxed/simple;
	bh=HntPeAgPvae03M9USZUhJrelvLnXqxlxxWivg+euDww=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=JRwJqis2A23inFi3QiOcgaWU9/mGu80FAzCNT20/pxGT7kfMpdXbhRB0VFQA4RW9RBefkgSCqfSd1KtASndmyA5iv815lEQ26hr1TLOdkeWaazRVaNs2bGovPKl2Q3oY7DbBdvabNNuYNg3gC+UOQZXZY1UTbx0A/2y3BOsJadE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p5et+gbW; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za+MkTsLqHerhCXTdh4C1sBFpXzMVchALoOXENNYUMvmK6ePDT63BosizYhb97wQi2k6vNmLX+ezoplWKOHWk5GbOz08q7hwMaoWczYaKy3zcSrl/XWp1QNuVaIKOhKWUxjSehS+Tqm8+VfRH7DctdFzsC4MyCrp/976kmVjzkmOJytmzEGQJVNhgfHubltPdzuFrxYhKhITjbb7uIAWYpOSjUCLp89P9AL54KogNsaDoZEAvA1hRKg5J6UgCsWYw0HikM/z5h8poXn7ux/6hhszA3sbxTIoGfpjX5OqybUCsE1kwZom8Zd8d96Xaz42s64mOxTEz8Nu87m0q5OEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxE3ecCSAbvbrjwb7MMdMkF9hEwn1nK5pFjIEFCZ4DQ=;
 b=VY2FHhTYxxgsY6AWVgnzndJZcMq5QXroGgbFccNanFoa3T3fgfTAhijZ+4K13SK3esF1qGFBdw2gJSBHb4y1hFUbytCzBonedRd6TyXHa8+ibtWuIiHftNZ8I54zfeJd/Q5e0oJgNIGGMopDujyFKQKRSiwRheYhHlkx0WEYD+ik45e1Y8Z0lzDVPIeZzuyAQ+dhdkU9F+CnDEqINcmVT3ywZMqjp7uUG4bdhWDXFlvxRSsxM25HG8cpWCMAzHosbCh4od4bEXtXc6CJzt30I7UmsfuB+bQMr3dtgqQe2GYA2rg7pwE8yO0wp4WBO1AEtqE4+r249Bs2UfSLQqkUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxE3ecCSAbvbrjwb7MMdMkF9hEwn1nK5pFjIEFCZ4DQ=;
 b=p5et+gbWKaVYGEKAqqBWuPzNXB3kM1WvveO+QO73zg+j+Z64vx+dH9iU72RfIlt6MP+/3RCHHe4pzd/mGL9MpYogOwximsHQZrRZWN+/bY8JNqTmMheTWT5AAbaIZn/pYVOaJCF4IMBa8a6SgJHqvmSbeUbg7Bs6TKcapPUTxCvzxbcW+3k8+TulyL5sT8C0Td+LAVp9GMUwrWrOBUDrRWgpsJbLSe9jP/b6zJAZ0z/R3CjImubgYh0ULjBnoyWFDYdNrFJ4BuW2/rzraSmBzwdzybMsnDqlO90FpYT0c3J0KfczEsrn+cImutqU0ffQg4S/52TGSmEF0S5Is5t8dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 14:45:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:45:12 +0000
Content-Type: multipart/signed;
 boundary=1fd1ed04c75a15afd2d18ae0f55824d6b86577c57315f5b9ee97094a8fc9;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 25 Jun 2024 10:45:09 -0400
Message-Id: <D296GAEAQVJB.3FXBQ0WEUJ384@nvidia.com>
Subject: Re: [PATCH v8 04/10] mm: split a folio in minimum folio order
 chunks
Cc: <linux-kernel@vger.kernel.org>, <yang@os.amperecomputing.com>,
 <linux-mm@kvack.org>, <john.g.garry@oracle.com>,
 <linux-fsdevel@vger.kernel.org>, <hare@suse.de>, <p.raghav@samsung.com>,
 <mcgrof@kernel.org>, <gost.dev@samsung.com>, <cl@os.amperecomputing.com>,
 <linux-xfs@vger.kernel.org>, <hch@lst.de>, "Zi Yan" <zi.yan@sent.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 <david@fromorbit.com>, <willy@infradead.org>, <chandan.babu@oracle.com>,
 <djwong@kernel.org>, <brauner@kernel.org>, <akpm@linux-foundation.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-5-kernel@pankajraghav.com>
In-Reply-To: <20240625114420.719014-5-kernel@pankajraghav.com>
X-ClientProxiedBy: MN2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:208:23e::11) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: c269520c-4aa6-4667-a390-08dc95256b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011|7416011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3dXK0VBbE9MWUpreWkzMk9PNUNGa2JpV3JhdTFKMTdhcFViWFppekxQZzdD?=
 =?utf-8?B?cmEzUGlsVzh0aWtvRU9HQkpNV1NzU0lJYng4UDJ2Ny9Da3RpcHJHRmZ5dVlO?=
 =?utf-8?B?YzBzQW44VkhEcHh5R0ZhcTVVNWRta1orWUR1ZHhaVjM0WG95Y2E5RmNMdnZC?=
 =?utf-8?B?ZVFab1E1bjNhK1Ryb1A2bGFQNTFxbE52ZmJaR24rZm1LTjl0NTBTWlhuTEZy?=
 =?utf-8?B?TmV3QVdwUEFrd2ZpN2ttdDFxcmpvNHBPZ1NEQXVBcXlBcjhNWjkwZ1hOTTBj?=
 =?utf-8?B?RWVJZCs2Wm9uU3h1VkVCZ2JMNVptbU4wdGxTWVd6bURacTVxbUVSR04wNGh6?=
 =?utf-8?B?ZlNWRTZ2U2phVkFDSmEzSTNEUkpaZmw5ZGhwVng1ZzdtMzFjYWNRYStvbkYw?=
 =?utf-8?B?SUtlUGZ6M1dwTHVqU0Y5U1pXQThyOVMyQUhRWlhWTit0aDg4bmsxSGhNNW1X?=
 =?utf-8?B?SmxSNEd4RmR5Wm03YXN6T1V0MHNWLzlQRlZyZ3NpUis1N3h6OGY0SUhmYVFJ?=
 =?utf-8?B?MXdIMVN3S3FxZWVDYUVNaWNoRW1kZ2JnMkw4UEozSnVPWFBvNTJ6T2tCdjlG?=
 =?utf-8?B?cS96cTM4Q1BuK1hQOTFGTTVHdkYvb0Vyam0xUGdBWDh4RmdrVm9pbE8xVWts?=
 =?utf-8?B?dVdzM3NpbnJXdzl5czZ4RVkyTzl1cVA4NTRFdUdjWE1sNHFZZWJaS3Z3NFlQ?=
 =?utf-8?B?Qjh6eWc5KzloaGVVbWliZlZnYlM0KytMU04vWVN1NGxwUkdZM0xmWnBDTUh0?=
 =?utf-8?B?Qm5Jd1kxWjlkLzdwVzRqeTdhejg0OVhaaGZGS1BMOGFIZmpVWnM1S0RhNVRu?=
 =?utf-8?B?SXJaakMzRm9aMGpYSWpMUHpUTXAxdGhXYkNIdkZkL3RtbTdrR0pYWDVFMEJH?=
 =?utf-8?B?cnc5Qm8zNXFLTEFVWTRHdHprQURlV3hBUnMzVkJlZEdjT3FleWNudFRJUzdW?=
 =?utf-8?B?VmdsQVhFaVN2a0ZwNmQzK3hNZW5MVGRzemNoVExxaVhtNjVxbis3cEkrZW1l?=
 =?utf-8?B?NFhSNlFCN0pIQjRQWmovTVlEYWZseGU5V2hmdHg5K20yUG4rU2dieFU1MXpE?=
 =?utf-8?B?TEF4bk9WRjNMRHVRcTRFenNuUE9zVmQzUFJiSGx5Qm5qdlN5Zm5kNUdGTnVu?=
 =?utf-8?B?ZWZGT1B5MmRlNzVUR2dtb1RXeHpxNDROcDA1d0pBemIxRFJ1YU5mLytGZ0E5?=
 =?utf-8?B?aU9PTzRvcklOTy9zV2l5Ni9FRDhvR3h4QkJ1MExuTFp4RHhveVpjYkI2dCtp?=
 =?utf-8?B?L2ZLVkkwb2F4SWdSQTdrUkE4b2U4RkZnNVJCODh2cW8xOW1Rd1RvOGZuN2VK?=
 =?utf-8?B?MStLU2RSQVFKY1dEQ1FmQXhoTERYVzA4U21UTXdFRkhqWTU0Z1VndjVZeGlh?=
 =?utf-8?B?d0xJcjAwMmI1ZzdlaEE2OXdhY2RydkVySVF0L0hTWW5WVURIeWM5WDBuZk16?=
 =?utf-8?B?SWhwVmI5V1p6elNxZ2lyQmdReFBwVndxSXFxSmtWUXhaMXlBV1cyYXAyVDEz?=
 =?utf-8?B?ZzRWRWV4MmZjUURsdll1QUFCNDdwS2RQMkdJYzFUeU50dHplRHIzVHZYakJr?=
 =?utf-8?B?ZWRCa0JlU1VEbGh6OVB4L2R2M1U0bkpqbHZqdEducGx0anZLbGdQaHEzR0F1?=
 =?utf-8?B?NHJsVHpNNnkyQmhlRjZLWnJtSm8yYVJWYjEyRW9Id3NIZDgxU0UwLy9RaWlt?=
 =?utf-8?B?MGNHVFRuN2hxYVdNdlp5ZkxwaldXd244SXlYZlFlK210WWJoQzNDUDhYM0FH?=
 =?utf-8?Q?9uH6dSKtWkbeYexFpM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEoxNmx4RklUNlRhQXkyTFY2VjlaYkxEMWpFNEpVTFg5RTAzb0crV0tnV1h0?=
 =?utf-8?B?TVYvNGlPR2tWdkVuWVZEQm9ZNVovZE10SGd3ek5UbFdUVmdEYXJNeUJ1TG82?=
 =?utf-8?B?blpPMTI5RDJWUzlUYzBhYkQxcHIwVmw5TkNZTXYxREtQaVNyQjBPUTgzcDA1?=
 =?utf-8?B?Qko3TEJpTlZmVjlNbkh6eklJNkErajRWTkpkZ2Q4bjE5cnNLSjJ4ZkF3N2Qy?=
 =?utf-8?B?SE53V0MrVmdZdkVDQUJmSlZneHlLVThraW1DN3JGMGppdmxrQVFUTTdEeG94?=
 =?utf-8?B?aW9kYURyWkZUTWRCU0w2UlZBaVlnbzdYeW5sZWZ0UDdyRkgvaUczVkYyR2R0?=
 =?utf-8?B?OXFldmI5alhMYm5tR3F2d0VQMGdxQ0hXVmVqYkt1QU9nTGM4UjJhM0VNL2N6?=
 =?utf-8?B?aStpajBLRjNKWDZaYTZUb245R1VmOTVhZ2xTUFdQWVk0S2Z5ZmpIQmxYU1pk?=
 =?utf-8?B?TFhiUGhhbmU5UW1UNnRxNE5mOFd4NnhKeHBFZEZBY1JEbkxSQ2xpU3hzQkhM?=
 =?utf-8?B?SkpVMXpidmkzVEFlVDkwTlN2ZW9lWUtyV1lCL2x6clQ3VnlBcXpiclRGS1lI?=
 =?utf-8?B?YytjdlVrdFdQN2V6Mmg3dWxEQUVVOUNRN2dKZEpVWHFnOGtvK1FlMkxJdlB6?=
 =?utf-8?B?WGUxTnRwK25SWlJ0eGtVYjk3T2hxdXpjWWo5dFlTbXVxaTZMV2wwbzRLY2Fl?=
 =?utf-8?B?OVJGbFBnSEs1dlVvOEVLMkdvNE1rcFBtTGxuK01nbDJjWHEwZ3JxVDlEbVc2?=
 =?utf-8?B?NncxNFh2Q2s3by9ESnkzcVZOdll1OWYyblhPdFB2clg4OXE5amQvdnBWaEU1?=
 =?utf-8?B?M0hUS1k4M2JyUVY4UXVzZEkvNnBhQ1NKWHBrK1oydDJPTm9lamtOVnZrdlg0?=
 =?utf-8?B?NC9qM1pWaGFSTXFGZnFmTVJPUURhb2NENSs5VDFSUFo0RTVuU2pGRGE2cDly?=
 =?utf-8?B?NVpNQjQ4V2k3QnB6dXBSZElISWxyZXovbFdJU2hGZnBja3dtcG93cUZTRWp1?=
 =?utf-8?B?QmljTGNlenM2MVlKM3RMdjMrMys4dHNGNVdaK0piNFp6eld0dUpEclppZU1O?=
 =?utf-8?B?aTZCd1k3Z3JHN2xSV2hsZTc0UEVkWk56anZ3R1F4Zk9IOVpNRFBra1BIZVJw?=
 =?utf-8?B?Rys1ajB6NVpsZW94dXh5b1ErZVE1dXI3UXZUSTJYdGRyT1Z2SWlqOVFSNDd6?=
 =?utf-8?B?TFlxMmdoT2JlcDVvbWxHLzJpUit5VHhFem5wRG1Wa2NBUURHSWF2MkZ5bWJK?=
 =?utf-8?B?MXMydWxhZXNZbUU3UUFjNjgxOTRyc3QyRGF4a2krdHgvd2RtTjJ5ZGdUY3Zi?=
 =?utf-8?B?RkdCVTRxRU5yTTZhZUl2VXNUbzE0V3cvWnhCaVlyTktPenVLYlQ5NXdYRkpY?=
 =?utf-8?B?MFpseXVna21TWXR4N1U0RGxneFJOVWlOVGxYdmswU0V4cVk2M2JDZVdjTVJ0?=
 =?utf-8?B?OVFOOUpxa3JmdXJjY04xcXJUSGtLNWtiMnFsYTUrd3lkV29QL1pwdU1VRFFE?=
 =?utf-8?B?RkdENWdOYU1IUms4ZFM2Mkk3Tmo4MVVTVVFSZlFnTzhGcHZnM2N1Qk9sWnJE?=
 =?utf-8?B?elBTM2pOY1lkM3lRNGtoVUI5NUVGVTNoOHQ5MVJBR3paYlpldm9Qczl6ckVh?=
 =?utf-8?B?NGNCMDlINkRRMzB0VEVwUHA4aTE5aEduUnRyMXFwUDV3MkJCSm1LNGFweG9M?=
 =?utf-8?B?UFZ5cloxdldoMFJSTDBlWG4xeS8wSTdIbVZSdmZ6NE1GczBueGhXY0FxOWFv?=
 =?utf-8?B?REt4VVBzeUxKVFIxNytYajJRNG94RzQ4WFowS0JaNFRFbTV4YkE3c1JKZ21Q?=
 =?utf-8?B?Tk9zU0lzSEJHbndFU0xqMllkUkJlQ05qdjB4MHJadEFIUzAzSStqZXRJVkJZ?=
 =?utf-8?B?WjdCNWJtVUNTa1VMS1dIdnN4SzNYbG53K0s5SWJHbFFmR1VUbjlhMVI3VTMv?=
 =?utf-8?B?KytubXJlSkRSVGV2WGZzTGY2LzBOK1RYL3R0UlpaM21nSU9DRlczQ2p6Nzl4?=
 =?utf-8?B?V3Ivb0p6NE96RGVFcW02b05sREtWeXhqZTNRdnp4b0NBdEVzdUNCSGdQTGhF?=
 =?utf-8?B?djZRWFc2Y2dZRnAvVmVNRGh2UGNxdUpPVW54NWZsc2g1R2Z2b2JoRVBSbmJO?=
 =?utf-8?Q?GB+Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c269520c-4aa6-4667-a390-08dc95256b10
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:45:12.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sff3zpKJvz94IwhM+ApRTmYxKS+NT09NIcDg4lJ4SAaawDjasdKD0RQaEDiRcDi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937

--1fd1ed04c75a15afd2d18ae0f55824d6b86577c57315f5b9ee97094a8fc9
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jun 25, 2024 at 7:44 AM EDT, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
>
> split_folio() and split_folio_to_list() assume order 0, to support
> minorder for non-anonymous folios, we must expand these to check the
> folio mapping order and use that.
>
> Set new_order to be at least minimum folio order if it is set in
> split_huge_page_to_list() so that we can maintain minimum folio order
> requirement in the page cache.
>
> Update the debugfs write files used for testing to ensure the order
> is respected as well. We simply enforce the min order when a file
> mapping is used.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
> There was a discussion about whether we need to consider truncation of
> folio to be considered a split failure or not [1]. The new code has
> retained the existing behaviour of returning a failure if the folio was
> truncated. I think we need to have a separate discussion whethere or not
> to consider it as a failure.

<snip>

>
> +int split_folio_to_list(struct folio *folio, struct list_head *list)
> +{
> +	unsigned int min_order =3D 0;
> +
> +	if (!folio_test_anon(folio)) {
> +		if (!folio->mapping) {
> +			count_vm_event(THP_SPLIT_PAGE_FAILED);

Regardless this folio split is from a truncation or not, you should not
count every folio split as a THP_SPLIT_PAGE_FAILED. Since not every
folio is a THP. You need to do:

if (folio_test_pmd_mappable(folio))
	count_vm_event(THP_SPLIT_PAGE_FAILED);

See commit 835c3a25aa37 ("mm: huge_memory: add the missing
folio_test_pmd_mappable() for THP split statistics")
=09
> +			return -EBUSY;
> +		}
> +		min_order =3D mapping_min_folio_order(folio->mapping);
> +	}
> +
> +	return split_huge_page_to_list_to_order(&folio->page, list, min_order);
> +}
> +

--=20
Best Regards,
Yan, Zi


--1fd1ed04c75a15afd2d18ae0f55824d6b86577c57315f5b9ee97094a8fc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ61/cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUQ/EP/i1foZOqoBGierVUAvBCjoCKlGBmFm0GjxzC
+4ZjAh19b7xO/zpekThkGG5Zdgw5Qie1KsL/f2zGz+ZV6RYM3j3u9k64CNiT5gaI
kFjynuIJTfjY8qX6/FawzgOTz5mzeCttM3ubMQYW1z4/E6cLlNAh7HflOR17c6Cr
szUt79PuWjvt/OVTqKrOjp8Ml69THQTO2xSSBYUz4Z8pDA2CvdEWC/KQ2Waudshu
SW6bkHdVTpbvgqOSux3X1mNAJMtqJ+ikwiDHFBKW+u25VJ8lFFH+GCslJPAoRDHu
Ob0ixX0ADxIGFluhKjiWvyKRmEDq9hiC2T2H8uTLUdOPcwYXVMBD7ggQa/NaH+NN
1z88pMm2iv4VJXWnMISZH4WzL+qXP4X7N5pUxXb3tIa+bOJv54D/sJfReVIXBlBF
jq7aL3EpOCvRqAY0OlHqpdvc530FqP76kTjiDiN0HLR+doMDRFKA8EwZdt08i8FM
fZC/XGeGv3jFQ/JsvaMPZ20nV/hWuZZED6WGXZnhUrjo3FvtJCm6+Im9oLxzcsl8
o0q3Os3IOD3MNkjg8ukWW7oxCMJq6pV87Zi4MnStmBNaFnTym/oN5wejtffE7Kjz
jLcN/9K2/JqyQTeQbEcEuNnTvY34j9c9XHt/ooO5vLVWmN0hETMFPE74rsZ/CD1e
fOlM63vE
=iwe2
-----END PGP SIGNATURE-----

--1fd1ed04c75a15afd2d18ae0f55824d6b86577c57315f5b9ee97094a8fc9--

