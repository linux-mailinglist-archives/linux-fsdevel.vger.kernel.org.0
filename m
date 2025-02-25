Return-Path: <linux-fsdevel+bounces-42603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0BDA449DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DB13BA52B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53519CD16;
	Tue, 25 Feb 2025 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LlCb/xCw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="avmPtxSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7617B1891AA;
	Tue, 25 Feb 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506880; cv=fail; b=DHKL2lWy69HlbVLiJgKQoheuB9JqSU8cRJTvdHJqP6G1H763v9Qfd9kwCBkYvcLZQuWQK7bBSNGs/J/+7xM7bma/Xms0niYzolh0KTTeARAxcxonnoK51ldOz/pwD9jgneQpBOYBIkAL93nwbbJ4OcDfFkuEGop4ohIjtyOoz4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506880; c=relaxed/simple;
	bh=ap4Wh+OWGpq1Slk1UO7Yv7l+IXtnh53tmKEkmhD1vv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OECAzSa9k57ChkziCEJ/B/KfZ3PxA+vH7Oly+eoIOijnkK3j0Kwrs0R5FfJpPIzvovBdrUGj4JuGDwtf73zaxF0LEQ1dHFuNcecN8mwPxUGdbF32IBe4X5LFCR9f3a5YhBz9KvGzWuu5Zc4cIsjt781oG/imn4UVHVU88g8zOxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LlCb/xCw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=avmPtxSc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHtaRq008556;
	Tue, 25 Feb 2025 18:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mcTKyLO5IBKmwSJPRhEnTjGeAvrx4IL4ASGGNFqpCPY=; b=
	LlCb/xCwtLL7RHZu7koV3GUbRAfN3WvQtf18qkNRvQhEd2WLWpT6Te/fjF5PSnMi
	YDe7iJebFxhDiTSxJW2OjbSJ2eYxehoqA0Xg8fq5cA5iip01U9mPCIZOg9GxyHnD
	2sA42fV3hj4cSkzrWAalghIoNBryjMEYm9ELEk4Jb+gboIlTo7TF2lH4G98WQcUE
	XDwLcYJJOVuU6Zddw38caSjWoThEZf0gqEMIx5lbCdJIFnuQ6bPk3jbjba/ZNuVA
	/Qq+QB9Lnh+DCfJRJTyAtBFFXZ1aBgkH7zPgJFeGsRGvW/F+yAhQfHPlp+2wKgSR
	CKsU6tvRkKxnKm+rdOR+vQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2e0h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:07:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHnqDT024414;
	Tue, 25 Feb 2025 18:07:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y519mnnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+06C4emhu8yPJnqCUUMlb+m9N1f3jviZG+vFpaomPacAz0NbcDS5cjgWQrjtC+Dyera/A0eoFe1rjwTLREooCGSNe5OQ8MdVqoRMkFrvO8/cPqX7d+Gt+23QrBRsjl6Xgy7jRmY3bGXHGH9Sm8VqsSiy87Qm8Vay15F3s/tj+vw08OtO9G5e0C+cvgVOvEELGaUh4HvNbu/+w+qdXPIesqSlsMIvb5OH89W9H3o8LP4cjes0qMdjDuioz/RW93zYpFq0DZoNsZiSpYCNcHnhz5qKlce/oWnsRgayQPImY1HWgAmvrPiRN1cYYruLepKQdZEbOtOQWviO/Eoq71q2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcTKyLO5IBKmwSJPRhEnTjGeAvrx4IL4ASGGNFqpCPY=;
 b=Tq3aMqONxAzRlrRB5FDah9OFTb2xb4oWSahXvQUKyW7o5lcaA3C2+6LJcBT+trD2tkMmx0nhXSvrimBjSIKuiLwlMaMCmH3lt6vVXHy+WCBwdrQEg/fnWPGVaJ68GMOeaLdrLiN8uZo9Z3bJqGjspYQekhADHv4N7g1pra0sqRZmCEPtORk5CwGKaXK6R/nqMwND1c03uplmLN6OTLVlZ9P/rHGdEJoo0kmv4a2oBc5T2mQrVVrM9E/y/vUTMkutBBqRIwfGSXM/mKPbVgZ0pkV40clxHL6EGyST8LvDqIcHdPXj8YLdkObPckeEbkfCMOHA6nTKRD7FWGPyS2w4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcTKyLO5IBKmwSJPRhEnTjGeAvrx4IL4ASGGNFqpCPY=;
 b=avmPtxScQrZTCh1NN2+aFWPaKZqszCO9h62CwyzLkyB60qMFo+/nHQ05UN1W4HqWoIse6cx+Onln2dhLICmCZTD4WTu4OIjjOqmK9OqfCFg3Jdb5Ud/Vtok04RkVOdj911W3elEEM/N6dkCxChcuGnjsGUx86SaPeM9NBjdHwMk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 18:07:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 18:07:44 +0000
Message-ID: <d022ac8c-6ef5-4f3e-8788-d3e2a5d4bc7c@oracle.com>
Date: Tue, 25 Feb 2025 18:07:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] xfs: Commit CoW-based atomic writes atomically
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-10-john.g.garry@oracle.com>
 <20250224202034.GE21808@frogsfrogsfrogs>
 <b2ba8b64-be86-474d-874c-273bbeb4df00@oracle.com>
 <20250225175014.GG6242@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250225175014.GG6242@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0024.eurprd03.prod.outlook.com
 (2603:10a6:205:2::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a34cc33-b45e-4581-69fb-08dd55c74da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?USsxN3RCTmlRbXZkNC9mL0RHMGZiRnN6cnNNTmI5R1FhZkpRV2FnR2R3dEdh?=
 =?utf-8?B?S2lTM1dDYW96VmkweFNpUHY3OXBSYm05K09odUdvdGI1dGRGTlY1ZUZ0bVBm?=
 =?utf-8?B?OXg0b3FueVJic1Q4YTRlbzd6cTJyeVNJRklGR09ya2ZQMXNEUjlBZDlmUzJ1?=
 =?utf-8?B?ZlhBUjdTRDQ4NFU5WGhDSmFXdmJRenpXd2g0UEVNbUlOSUh5cHFJNnpkWjd5?=
 =?utf-8?B?ajl2Y2R6Q3RsWjFQdkRxakMwdlhUUE12ZjE3a21mZGdDcnpITVRUVXlVdmZ6?=
 =?utf-8?B?bDBUdnY5UXo4ODlhaG1TVnpDYXRGc2lKNzFMSlFZR0lreDBlNWNNbVN6QWRl?=
 =?utf-8?B?SkE2V3F1dGRPanZTQXBxY1g4aXJXRjZ3alNpYmdLQW1WQUxJS2xyTDhWbkk3?=
 =?utf-8?B?SjRkZHlheGxmODZnQzMwcmZyMzVWSGNaZ04vSGs2WkhzbVNQcnptbTBhSHdU?=
 =?utf-8?B?RDQ3ZmVoeTlBNDNqZGo4N1RFU0RGSjJsdmlPeGkxdGpUWEhTV1VzNVNwdTRE?=
 =?utf-8?B?NmpQZmtydTVCdy9WNGFoQURWU3IwTzFDemVPcjM0NmZtcXBJWlVHYmRyMWNI?=
 =?utf-8?B?Nnd0T0c3Mm5YT3lCek1uNE9ENlVJR2lndThNeHVxUE5vNzJoVzhWcTJaRWU1?=
 =?utf-8?B?d0tFMnAxYVZWYWFPUzlpdFNDa0JhOGladXJubENzU0JITFdoQ25CLzh3bmVO?=
 =?utf-8?B?SFJrT1lNeTBTNklJenhjWWp3eVJWK3Q1bVU5REZqL0tBc255amtXelFRQWNs?=
 =?utf-8?B?b1pWZU5xSTYwQjB5dGpFOFplTmVseHpTRGhPaHpoYnJ4dVBEU1FUUTBiVlBN?=
 =?utf-8?B?WVNQS05GSVJmVi93K0NPaVJ6YkdvZ0kzL3ZraTFTRENxaXZ5ZHhLcGNWZmpN?=
 =?utf-8?B?UDFXUDE0UElxZGdod1duNzVyVzI2bHAzVVRLT2FKaUpzRnBEN1RDOGdIeXdD?=
 =?utf-8?B?WEJkSWxuUDcyRFlLRWdkaEc5VDdBd0RnZC9DdEo4RzJ4VkNtazVvS1ZUTllv?=
 =?utf-8?B?R1JWMk9Ocm5HUEhEcis1UTh2T1pHQ252MnlKcWtaNElFd2QrNUlMeE9Sek01?=
 =?utf-8?B?NHNlVlJYQ05Tb25DMTBUNlJ1cXZJZVdHbnhrUXJEbkNYTmh6bTBDQTRFbkta?=
 =?utf-8?B?NUQyK09GQjR6OUZJcUFpYXJVaG1IWFhMckZHS25Sa2RZMHl3OHJxTWRuaGxX?=
 =?utf-8?B?YXRRNWdFWVloTmMydXVmNzZ0WGZoa2MvbWIzYXZEeWZlamFkUW9oMTZtejhQ?=
 =?utf-8?B?bGhmaUwyTTNNWERvUnlXZFZRZFZGKzBnWXJXRWRvVS9vYlU1M1FBc3BjbnRP?=
 =?utf-8?B?L0ZOZElBdW1zUVNnSm9PTlRHL1BQK2g3ejBvOHVyeXg1QlRuaFVGL3d2dC9z?=
 =?utf-8?B?SkxvbTl4OTBtQmRPSmFheDFoWUE0YTJnUHd2VEI1Z3dFREorbUdyVmlNNDgz?=
 =?utf-8?B?OGVWOUp5L2ZtS3dCdUJ1TGNLYk9seW9QZ05aNUpJQ2M1NUlqV3o2SENJYUI4?=
 =?utf-8?B?Mlg3Q3Yza3hxSUhJUWl5ekxxL21LSVAwb0pDbjQwa0F5NW00TjYwWXhOdjMy?=
 =?utf-8?B?MjNyMzBNMVdxcFZRRFlaWDcwRmsvVjU5NzVrbGZhMDM2S29BQ3hBaDdpS3VU?=
 =?utf-8?B?d1ZYNUdqbjIwQjBCbCt5TTFrME12NHdGZmM3WkcvWWEya3FVT1VmV25va1ph?=
 =?utf-8?B?L0Z2aExURGt1Qy8rRkYwMUlJNFdSNG5IMWNONFIrK1JIU1VwczFTN3lvNjcz?=
 =?utf-8?B?elFuemc3ZTZlWlI5MmRVSHZlY0NEM2tucDFNOFo4elQwRFoybnRQOWtxUVB5?=
 =?utf-8?B?a2dpcStwcEtXTGpoMUFTSDlMNXhuZWNVVWNnME52WHJ0OFdPRUM0ais4bURL?=
 =?utf-8?Q?ecqGqorcDvXZD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzQvd1pTbDVreldjZG9OSUxvb1IwOUNvY0RFUC8wUDY1bVNmR1dFWXBPZGZD?=
 =?utf-8?B?aHdXSjRqWVgwOC9hdUJyZmQwWGNvbzFZcUN1NUFFSUU0YVUzM1hCN3lTM2hr?=
 =?utf-8?B?bW5SaGhTNWNkNXphd1dPVkhqVkNsb3ExbTdTWGdUMnM1bGVoWUJVaUE4dEtY?=
 =?utf-8?B?RUFaQkRFcUN5TGpYNmEwdnhsWktRRWtrRUU3RjA0anByQmU0Q09RSDVZbUxO?=
 =?utf-8?B?NGlIcDdTcXhMdkN2K3FFczFVV3N5V01EdG5rL0NKRmxoZFFySTNMRnRpQ1Jp?=
 =?utf-8?B?ZjdJWlRPcS9DYzNlU25MYVd6cG9yUmVDYlF1UmNNQnJiOC93NFhwS0pmS3Vi?=
 =?utf-8?B?MFV0OWphc2s4bVlQMXZKRWp6cGpEaG5uanhMRmFxS0pXL0NuNitWT2M0djlP?=
 =?utf-8?B?Y1I5czFYY3lrTnozdFA0R0RJWnRNYWV1NFAybzQ5c1Z5VFZ2a1ZVaVUzemdD?=
 =?utf-8?B?L1U2Q0hTNGVUZ3RSQWxUdlNWc2hRY1NNK1Npd1BqekpXU0F3OEtZVmV4RGt0?=
 =?utf-8?B?UlFSQi9hbnY1VXIwSGpQUVdWb1JVeVZFMDZlVkRUUUZxWlc4TWJnazhaellL?=
 =?utf-8?B?R0lldVNFV1V4YVhzOUJrTiszVkdiemZFUy9rY3loUFpuOWJlMzU1MnFiUXR1?=
 =?utf-8?B?V3huNnV5QkFndTlzVDcyMmJsR1EvVEx3NWtWTmxRZXhRK1hSaDFCTGYxcGlC?=
 =?utf-8?B?QzBQU09UZjJRYnRFZ1Q0VW9rTEtRckFYMFRVOXFuZkhVV0RhOU51d2FycEN6?=
 =?utf-8?B?dndkaFZ5eU5Za3ZUeXNtd3QzV3M1dStQamY2dFpNN2NwNWJSY01JelVuOXFM?=
 =?utf-8?B?L29ndVdSV1dyVkFTMHVXcXFqa2FsUjZmVGgvakxLVGlMbERqZEk3bnVjeFN0?=
 =?utf-8?B?ZzZrWnByR0FyNE9TMUh6SGtIOGl1bU03WnRURmEyZXdIUVBzLzd5NUhlWGFk?=
 =?utf-8?B?VmVCUWgxbXVXclhVZWdoOXpISkZGSTYrSndQUHZxdmNhMWk5dHJEUDUzK05l?=
 =?utf-8?B?Si8wMFgyVkZzYlBGN1VBNWdWcXhOUUFNTTlyVzVjMEdqVVVDYWpXWUhVN1hI?=
 =?utf-8?B?WTZOUDRoaFovRW80UDZIUDF3VEtqZ0h4ZXZyMlpXaENhUGFrTWI0ekpPcy9Q?=
 =?utf-8?B?Ym51ZlJOVEp6Ukd6OHJtNVVSQWVpc1h4azI1elNKNGhaQ1NhSzFWU3IyUFpP?=
 =?utf-8?B?cWkrNElyRDE5VGhVTkwzV2xKbVVpbkMzbjlBU1VIQTJFMmUxNFgxN2d5c1k4?=
 =?utf-8?B?WW9TMHdpcGw2dkNHRUFBN09uajlxY0o4QlR4UXpTcVN5cmxiZTdVUGh1Y3Iv?=
 =?utf-8?B?WFdkMHNGTm9kOU85ZG5CZHpweWFtR1NVT3R0N2YydS9CS2R6M1IrSjI3VThq?=
 =?utf-8?B?SUo0akQwdHRSRE5IdlloZ0JqQU55UTBDU2ZmYVNMZElUSlkvMHVDcHZ2anpG?=
 =?utf-8?B?WFIyTzRHcnRpdnJybFVvVTdlZVJUSy8wZEU0NmYxcTZpSzlBNlVKL0p5Rmh0?=
 =?utf-8?B?YncrZy9xcW04ajFDcXZlQ01zb1BWdUtUTWRyNnRsS3dkTUZ4SklCVFNpWU1I?=
 =?utf-8?B?UjlXWHluVjVLSE5TUkVITWtpRHIvUHVyWnhiNzdrWEQrVVhqUDVRSTI5SGtr?=
 =?utf-8?B?MEdPdEVkNGl0MUh2WXNBSnErejM3S3dQbnVuN2VaY1dVaERCWG9ad1hVR3Fa?=
 =?utf-8?B?b1htQnhwSHdiTXNwM1g3U2xKY1VtNldmSUhCTWV1V0VPNWtvMUdrY09waWIw?=
 =?utf-8?B?WGdYTmF4T3l0OXZsd0tuNDNnN3drT1A5Qk5ueWxqelhDK1JBTUFHdXI0eThS?=
 =?utf-8?B?ZWZ4aEZGMERxcTNXQWFGQTNkQk4yWVV1QzlwMUFqR3VQdGVQYUN3R3dsaUN1?=
 =?utf-8?B?M3FoTFliVGtDQTVKWUF0TmJBd2tUcTVHNjNCSUtFKzNTVVkwNlNJanJZWitp?=
 =?utf-8?B?TFY1bDByR2tYTGhBQmNrbzdzTjNBT283ZThZYm1YRjlaRXh4b1dMWWdvQnIy?=
 =?utf-8?B?eVJ1d1pqK0FzaXB1dElLUkxoSXJpMXJySGI2enBHYllEa2RuZWVDcmJiK1Zm?=
 =?utf-8?B?eHp3Q2hySlZnbTZvK3JYbm04TnQrUE8wQjhqamg4eXcyNXBoK1hVU2JVNTlF?=
 =?utf-8?B?MDQ2eU1qVVh1bGdzeXgycFdaS3pvR015ZHg1RUJOMzUvTTE5cXQ3QW1WUWpH?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jd+2JSSztr08Zthzqs3LPkQh0Xx3yppcS680G16hyssSfA35LRjtSOCB5h4sIANTB2jvxMOajNJSjgQNnhLSeiDoa+KN0EORAmpIl37lkmCdVNfiZMAEuLwBWuzZdW8MdpkcIjYs3gTBSqFhO4VXukyUmCUVNi5TeuhSDq2cL/v3hHXZiKegWsYsavmaVgX81ojPojGGc3Iao4jPdZx2KQ9/dK6HLobQxpvHsTnih+2zjEBYv6CwwL5aJrKaTdNE3x3UY/IQ3v7Z0lz53ea75+2uDavGTbt+LsNF+mb4p5nUXPXkp8PJ69+yP/XHajtN0y3wqB/qYi63UZr/16qpN74ORQT990RtXkDENHOSSlob8oQFgiFJQgpTvDw3xbAuf5ooj5/z6J7uzlvsZCs790DSoKR+YquZJ/3oW+651yLbdlOJTvI4YTIwI07tCf2eqgMM1imuWYrmsQ49B+RBhydfD0MD4ucLvf2KybU64co26N6D3HVb5HXhRdV5eeBh3K6rlK7wuGM25aHBDpl+QB9tFp+WH3gJ31FmnSyVbIyiMt3qCEOB2Azv/cvkUnmYSMsqAxd67RDAzWj2sQKb2I8YHZKue3RlwJz8nyfYvKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a34cc33-b45e-4581-69fb-08dd55c74da6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 18:07:44.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsQ6lL7DGuSTPTTc9Y02FUDY4BZEZ9pTTaVp5M5HIt3iUI8vJNEgETzM7xFjpdAnAfeuaLLqSg574JuJWG1ULA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250114
X-Proofpoint-ORIG-GUID: XcIsRZJxwIFp8JetWTJHWf90k38XSAfl
X-Proofpoint-GUID: XcIsRZJxwIFp8JetWTJHWf90k38XSAfl

On 25/02/2025 17:50, Darrick J. Wong wrote:
>> Can you please check this versus what you suggested in
>> https://lore.kernel.org/linux- 
>> xfs/20250206215014.GX21808@frogsfrogsfrogs/#t
> Ah, yeah, that ^^ is correct.  This needs a better comment then:
> 
> 	/*
> 	 * Each remapping operation could cause a btree split, so in
> 	 * the worst case that's one for each block.
> 	 */
> 	resblks = (end_fsb - offset_fsb) *
> 			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);

ok, fine.

Cheers

