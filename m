Return-Path: <linux-fsdevel+bounces-51761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E333CADB1FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44760165126
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D11433A6;
	Mon, 16 Jun 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PdMrWSSw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B+4cYNNv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4822BF005;
	Mon, 16 Jun 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080748; cv=fail; b=kq9lDN8tH3KIiF/4z4CcXLUxtB/1nKMKIZKGIfaSHikL/mJS+krlv1QxiWB8pg0IPwHDC54oaMUAjwk8ZySCPlWYAkNnvfhFbWPsA/Wfp4LNy4BNFioczAhVtMFn/FeqKoaCTpIEyO4BVrqG6HBaWAI5wFq6NILzeV3tWDBk+1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080748; c=relaxed/simple;
	bh=u45G/sF8S/ui+sPbUWnoVszr0vTMCXlmyzAylL+v0d8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iDClYSsbzkAykmQWYRsA+OdaRMvkiovbA0W4NBJtoqxTDVs6WbZDxRPueN/8AHbww+LjyLDWnFOC/YVkdgYaKTkBosk1gdesn1eMJLnqfQiU5vQP2LIcy2fHllXZFJ8+4SuVarP101JSQoyo4kfZWWtMnBJYUHLGQlKn2+mAlyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PdMrWSSw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B+4cYNNv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7ffdN009100;
	Mon, 16 Jun 2025 13:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=45KEOt2qlkoeT8moq49/88tm28JGnK1lCc3myHdbHUE=; b=
	PdMrWSSwvHZP7EQfY669cAM9jRYC5y7LVh+Hsf4nj6UEgI6oDfBzSe45xaMR9Uqs
	+tAo20rrjjGiqdRHzNDvStV7cP2M+1ocbWmmBRaBCBVKRIc9WlHV43vKIPbfgKk7
	TwaXnVPZo1jMEPOi9aFtKjR7PVgENTpR4jgTuQO/X73lwTu8Zz3Da6sRvZmBbXPe
	4RDLSd3cYOGBqSd4uQt5h4J5d9E91o2/kWmRFNVx+H2vn7UCtn2Ht7/O8+cdVyrd
	YMig986kmcCE1BpDxA9G1vWMANZCri6WSod6lo9wPVwOE7/2f/bP2nxnGuoDpbap
	FX4qTv5x9Bc/1UZ9s5orWA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900etj3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 13:32:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GCjLhR034462;
	Mon, 16 Jun 2025 13:32:22 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013063.outbound.protection.outlook.com [52.101.44.63])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh7p24f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 13:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7dJszxX+lhf4ieCR0nuL0edjgJjz5qcpUNHiSKifcCp9U2jeTEuJgGgqtUzqd5vuSdnHoD8YTnWWz/pvMYpx4XRgwUJ6SGemwskALY7P2mk+7T7SxIcLamDeNRMSp8vLpccGrV/K6ChFg64avxFW2yhP4RMFGbqR7mpnqY76+gIluQSo8+fnrQs57QamaPXGV+anhlVKKB564mvIjPb/F65yXEStj0JMWt97hGR6mGg/0JAnYi27ZlY++LBB4te2bJwUVmz5n069p5axGxHq2SQihmv0QhcGgCIf6LFECXN2UubMbIdxkveTJ+QKhVojlbCcph+B5T4hKBTLzWx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45KEOt2qlkoeT8moq49/88tm28JGnK1lCc3myHdbHUE=;
 b=F2T15qdKXiU+nY9AZtqR8UhsIp0td0MDapyuCFDp5XhV15jZ6/ZHiNR1bcnnzuLTapFXbLd0U5Lj6Zlkdvkev4E9ZW5p7zIu7GAXwXhjfxL7ygc6qVjhfLirFCKjQbxWrLo9QQ2sGtRYRHl7H3KcE0SC7HsM7lMTyDk7DVrqUcl6dPSYeii7H0Zf+GOvHcyMrkhmRw8bumPAHgT7CdBCnVNOc6esjbdcK9IjQJ/BpUCECSaYxI9H46a3YKQ3mVQ3lgLD35L0VETAEcNtwFwrT2NxINleu0EqXPdQAGSreUPI9Olrj/ONArNsnVjy/ZMLgzSuTHLAtXCcZCRx+pdZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45KEOt2qlkoeT8moq49/88tm28JGnK1lCc3myHdbHUE=;
 b=B+4cYNNvKSpvVFs35c32ro0Sr4+X5ljXr1QlfFXrGRlb4ixLBXB1Thegs/6nEhiB6ZL87PeKMbyjn8+pPIlHQ2XHmwlRFS3G+CBzUyxnyEMxoEa/D+k08oLb6MNmNMf25CfbDKSOhKDd/+VKNthbubVlkfXnRSWMZ+TSrc2cOnQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 13:32:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 13:32:17 +0000
Message-ID: <5dc44ffd-9055-452c-87c6-2572e5a97299@oracle.com>
Date: Mon, 16 Jun 2025 09:32:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
 <aEr5ozy-UnHT90R9@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEr5ozy-UnHT90R9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:610:33::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: c008620c-0b82-42b9-d7fc-08ddacda3686
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SWpXUjdiZ0dTT1ZMWU5ZWXVhc1U2TjJzV0JUSGJPMHIyMFVxck1GNWJic1Ur?=
 =?utf-8?B?SWY2YW10V3ZCU1JJN1lkRFZVZmcxR3B5blR4WG9GYWg3VFY5VDZHaHZyTUNY?=
 =?utf-8?B?QzZCNHM4OTVQVW1sbzdjd1ZEL0FhS1JmL2RiSUJmN2x4TVIrcEpuZlJmaTFQ?=
 =?utf-8?B?cmRRZzBxelovR1NoT1NWYkt6aUc5QStpTmtzQmZ4UDJjcEtMcENCZFI1Z3I3?=
 =?utf-8?B?OWY0U2JOTENpRXFRc0NLaWFiVGxIVjlaOXR3b0FjOUtobWhRZ3pHQUtNdjJi?=
 =?utf-8?B?alkrSjZNeHp6VUZFVC91UThDQ1M1aTM4OTRRdkIyc3FGVjl5eG5kNU9rR3J5?=
 =?utf-8?B?UkJUQUUzU1hjSVZOMzJWTjArTjVkcnRrRWtPeFBQWk0rMFZWM2Rxckxmc1d1?=
 =?utf-8?B?amdOTkQ3T3FRdHBhZFpRVC81Z0grdWh4bU9RdFJDc2pFNm5CRm9WT241RzYr?=
 =?utf-8?B?cmlKS3pNWGdWa1Z0MXNvZExrM3VOSmpzOFlYTC9YMGxKRm5ocG8vTWxzSzBn?=
 =?utf-8?B?cnJtR2paTjNhNVNEVkNmMFdwaGQyTkRxdTltSDZqSHRNZ2N1UmgwU1lqS04x?=
 =?utf-8?B?N3U0UEZNdVNKL2lOdkM1d0ZTSkJBa2YxMEd4Rzc4Y0Q3WnRQdGNEeGNMbzlY?=
 =?utf-8?B?eFR0cnhFcGlkNmcwQlpjRUFXMElXY2tUNnpDT28wa1E3QlRhT1JML3A1OXMx?=
 =?utf-8?B?OWFLWW4rVFdTU1hDbDBvaFVmNTd6Q2J6NTl4T1dqQlRuNFRlVGNiamJ1SGVl?=
 =?utf-8?B?Y0EyUXNjMkY1VEtZNFlMTXM4WGsvckdlZEZHR050WmVMTDlRYmt5bTBUcldT?=
 =?utf-8?B?aThUSGIza3pGWDBDR1ZzUEdOa1kvWE5uSlBKUEM3MWwyb1huRjJOdysvUGg5?=
 =?utf-8?B?Q1pSZHdKSE44bXVVYlVzZzVQbFl3NTVkWkhmRzlQUWtiais3OVdLTG5QazZI?=
 =?utf-8?B?ckYyUm42SlRrZkFGeXJPZkJ4Y25RL0FIdkl3UisrT0w5MVoyR3ZWazRJQnRQ?=
 =?utf-8?B?RmhYOWdZSHpqcHg5YmxUTmxjeFVsZnN0MTJtU2pCMG5qUWlXaXRlcmVCcE12?=
 =?utf-8?B?bmNiMmp0SHYxN0N6QnlKNnprTVBYZWFNQ01MeFFPWitvdkpxdndpbDJZZ0xG?=
 =?utf-8?B?N1RaaksyRDlFUHdycUdndmZuQkZLU0ZXdTVXVXkwamVWY3ZTWnlzSE02WlJs?=
 =?utf-8?B?bGxDMmdIV2Z5dUpaRDVvTkY2ODdKOG5yNkltRERVaXl5OWhqWStZM0ljTkQ1?=
 =?utf-8?B?aWMwUTgrbGNKVmV5VlR4OVFZOEU5bDBhN1QzeXpGckgwQWxZeG5nSmVza2t1?=
 =?utf-8?B?TEVTM0NNUUZjL3pzeHRyazFkWnIvalR0VlRLZWQ5YzdvMEpFaUNHckkrejU4?=
 =?utf-8?B?UW1McVZ3Y1BGang4dGFHclRYTi9FdEVNaFRHYlpTMU5YeFFHOUlrSlFaYnB1?=
 =?utf-8?B?R1E0ZVF1ZDNtM24zMmdUc29CelRiaUhEMXZ1ZVh5SXIxQ0RobWdJTHc0SVRP?=
 =?utf-8?B?UnhmQnJxekxPRjhPKzZkZ3dTOFlwM2pHR1E1Y1gyS3VLd1JpYjloeDUxTVlV?=
 =?utf-8?B?VWhGUThyY3BCcmFHb3FGTE1QRDYvcXJiVkJkZ0ZvbE5zQ2tHV1hRWU1zLzVR?=
 =?utf-8?B?RkxSZnM2K1dKdnRXT01GbitkZWltdGVYUzNQc2dMbDZiSFFzSEI2a2VSc2p0?=
 =?utf-8?B?K2VnWENPSjhOS201cmhaUG16VnpPOHFlZHBKMUhzeEdQUllxaHUvSzV0YmFz?=
 =?utf-8?B?OEVobGJnQTUyakNSdVEzbDR3bDVzNWJNZms5YjR1emJrTVN1TXNHMWZDQkgr?=
 =?utf-8?B?bTBXbnRnVWZZLy9EM2tQcWZaeUlwc2ZNMGNBNEJaeStHVU1DUmplRFREd3dl?=
 =?utf-8?B?M0JDd0h3YnFvQjQ2Q1NlVW9LbFEyYm12c1N6L3R4RkZNaGc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S3RMdXNVZzc3dks0OEJqVmhVUDRwKzIrM25WTlhIVTJOQzFIY2dvOXRiNWlu?=
 =?utf-8?B?eEdKa1NyTGo3OW9KOEFTUDE1ejlrUXJQUWRmZ00rR3hYaDI2dVA5SU1oRDBh?=
 =?utf-8?B?RFYxVzd0MDhxRTBQY3g0SmlxVzZyMUVNSFRtczVPZ0ZsZFdMaWk0RERaUmtz?=
 =?utf-8?B?QWpOVnNaelhDam5Vd2lYTlFLL1Z6UnA0ZGc5aDRKalV0TDY2UGNURDRwWitw?=
 =?utf-8?B?QjZ1VEx3T3k2cmZoTCtXRlhqQTRiSEJ5VWJHZG84Wmg5cEx2UkFTOFlJbTMw?=
 =?utf-8?B?TFE2T3plb0xUdXZPanB1VFk1NVF6ZUp1Y1N6cXE5RzhiWm8xZHBmSkJGNUNJ?=
 =?utf-8?B?ZmhaUlZhSmVyc3VEMlNCUGdxZURYbHU0SlR0TTRnK0ZxTEhEWHVmWlZaVnhL?=
 =?utf-8?B?QVlhRVZ0amhLdFpJWFdXa21qWGZPV1VwMks5ekxBcHZRVUxZOVBOMkMyVlE3?=
 =?utf-8?B?WTZLSXJMdU1UK1M5ZWUzcWxHT2VoaktXbDNHd1B6aWJ5R1lvOHo3NVJDNFo4?=
 =?utf-8?B?VjBFTHp2ekRPMThUOUc4SXpkM0lZeWJIQnZvSTF4NUdzQWNDVnVMbnU5WmpW?=
 =?utf-8?B?K2dwSmpScTNhaXEzcVpxK040bjlFTzZVVFd4M2w2dFZoV1Q0a0RkaUs4YUZI?=
 =?utf-8?B?MmRHZHNoSStJcllpUmR5cWVxQWJhbDVuTFNmc2dIWWxxSjJQM2RpN1hCOGwx?=
 =?utf-8?B?TmIwaGwzeFZ3UGpGV1RHdjR0ck9kVkVINWlLaVFCcDI3OHJ4ZXJjTjhJU2c0?=
 =?utf-8?B?UlZQc2E0REJUTmNjbkZVWURDQ2svM3FsMHBkN0J3bWYzOXFDM2ZYZjdjL0Ny?=
 =?utf-8?B?MlRraG8wSVNCRkw2V0h4dzZvUjFJL0w0bnQ1d2VOaHRqOWVZNVZvb3pKL1pX?=
 =?utf-8?B?ZC81TTZvbkQ1bXlxMjVIZjYxdXBRclgxOUdzcDRIQmd2NTUrWnBZakIvZm5w?=
 =?utf-8?B?aGNEMEc1cU82Yk0zem5CMFRWTWNuNk1lMkE5eGhLQkgwT0Fkak56ZUNSUU1X?=
 =?utf-8?B?RnBBQlphNHVyTm9xVWw0SU55Q3ZXV3B1UFdoNlEvSnFDdXZuL0RxWUpYM1l2?=
 =?utf-8?B?ZVNNUzRWSlErTStOQVJVU3Z4a3lMY0xGU2p4YVo0akw1cVhITi81UXY3M0NX?=
 =?utf-8?B?cjBIdUtCVHFBd29QeGxuVzVFajQvNWVTZnJzMG1lbFBMeHpvUkxBb0VWeS9Y?=
 =?utf-8?B?ODB1eHVPdzFybTJpeDBCSGI0bnQwMDZibUp4K2l2ZmgwbTVDU3dnRk4wTytx?=
 =?utf-8?B?TUF4VndMNkplVFdEYnExUTJJZVNyMGtoWXc0NzVEY2NNWTRvTVh4dCsxMUxo?=
 =?utf-8?B?dE5sajl5endBZmxvdUhGa3d1S1EvQmRPaUhyQXFQbkhjdEIxRHJyYU5jdU9Z?=
 =?utf-8?B?ZjVqdWhKa0dGS1pkR3dibXdIRDJ4dDdjZE04ZlFvVG9TSjVnSDhzc0puTVpq?=
 =?utf-8?B?OHNJeXZvbnBBaEZQNyt4cGREQVM5QU8vOGVzVkxhUjdwdnR5MkZYY0JQMkx3?=
 =?utf-8?B?V1ZiOVJXK3JVRXArd1J2N011TnAwZUNhU29KcEt6NzFDMXllM05IRWl4emRQ?=
 =?utf-8?B?YXdnY0VoV2gycUlBUGlSb2ZJdk0ycjZ2Ti9ieUUzYUg4dXF4Y2dmL28yVDNU?=
 =?utf-8?B?NDlRbXZkcEE0Nm1vN2M5MHp2Qy9GWVRrckxQa09oL1pTZWtTd0ViSnNHNFgy?=
 =?utf-8?B?VmQxbkpZbDE5MU9hRFlJRk1SaHFXaUozdnpTckV5T0FtVDJlemZlbmkzdXJE?=
 =?utf-8?B?SWRFWWZVR3M2V3FUSVpNUXdUKy9zTUsza2h3OHJ6eElGYTBpNzl5am10Ri9r?=
 =?utf-8?B?dFltc2xqRjJUMU1FY0NKZERhbEhzMjAyb1VqSzZodVNuVzlMdGp2bFFDbnp6?=
 =?utf-8?B?SFRwYTVSRnhQdWgzWEcxbTZxZlJMSEw2c1dqU0NCR2VzU0lxQm1KYXZhWG45?=
 =?utf-8?B?alNUYUNjdWF2NDNxam9ySUFxRmxEd2lYTjRCdElpY2VlZnVxSGhkb0xqM1I5?=
 =?utf-8?B?UFBxRy84TUdYMklDbm1IOXRDQ01GT1BVM1JCUzBKQXNrZ002aFdLK3hudzVT?=
 =?utf-8?B?KzQ4OXk2RGRCWVB5Vll0TGpJOUpHWVB3emF2R0g2elgyNCtOTFlnOGdBa3hO?=
 =?utf-8?Q?vv2blc/Y2xplvu6yN6E6KFRNS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	137f1XUduZuRj3FRrcIe6twibgZidBH2qsLrr7Dj8L5as9sv/OGhvx7dBOqof/I7QwTC6HfIVcQoLNrkLnLjQDZ/ABVz8uXgw3vgMH9LQ53mRS0UhrlOtgvqMtYEFDxQ52DJcrQ2eY/NthUOIps6IgFeemjio5k8g2z9tliznAfuHuZSLfCM0QJOSiRsp+C4R5NtXb02H3XNjUT0HFtUnmu4yMhoVtey6iHUFigPthvYiMWYGvNQCrsYgJLKsDj+GPxL82/OHtjhnkZhcVN/ESZvNS0hFf3nqyvL1vOlHy4EUFNcIiEp4jaVOAV4QAfoCiolzskyaAC8xTmnUw+JtbDh3b9E5tDDeiu6ziqck20FcgLtBKkEciqPXMTF49jamyrRmt+pMnLB6l5DK82TGjXiGL52U2YTVYTcNkIHqaEYS/5Irky6xc8vjwlnx0BceguUNJiro0vm4GJAHiomeLOJmNa5WqB8GRbeVaBxMC9M//REvBe3+DkjKOwj6B3kYQKLu1fSzJufBI7w5f5A4NwM4Ud0i37VIPuNZ6CW4KzAd5C355N3yPWTM2bsnoFvHWtFJz75MbCgghU6laZ0W46M5cH1PrD3ptwubSA7H0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c008620c-0b82-42b9-d7fc-08ddacda3686
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:32:17.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBFS0vtVJjT93XK8INBiFXbQRv9TLGRDXbKGfeQeSx3+H1PgVkhscaxRR31o/UIp2MuYlUwpP5CmKHnDPhy/NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=891 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4NSBTYWx0ZWRfX5oo8bhHUuOBM g6WPN3qkvloo7rS/Sa7WA5dj89hZKlZLYFP2GOCTZBZnKJv6eA0NDwPCK/Rw+8qu2hqEpbUO8EC 3hmJmOdkq/rnEswN0Kk1DLJIWlFwjoaAnHlJmEnBhKqGCiNfhYABBkTdLJjrdlsYw7Sv1IaBK3T
 G0SCi7NeE0X+RE4E5WE2/AGeE/s/NrRa7jwIhaUefentPzSCugH3BmLsEF/jZqImTlbQGthcESW eRDphz1rlrIhKkHvLkICeNTqRBjGYzLTvjPXiE3jVsjKg4siQQT+Op3469HhKuA2Xgo4p1ai3IC OMESL6GVuEsfDqUYO+FeCIJYoqFOWWVCZ/JZRwvbGMvLWLH9T3NdrsFhyhDJuF6Yireiqmflc3R
 di4cwmT/BTuuCOd4kplpfYxuX5o1YfQFXzNEVqlN9RZI9nNHA3GaMT5ATOja5wRngWG82Sua
X-Proofpoint-ORIG-GUID: j1YbFTLpeelLqwAQLdEYJP2e244Jth3o
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=68501ce7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TRtTYcYt5kwXhoch:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=mtFmyOCVLDM-hNY-JagA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j1YbFTLpeelLqwAQLdEYJP2e244Jth3o

On 6/12/25 12:00 PM, Mike Snitzer wrote:
> On Thu, Jun 12, 2025 at 09:21:35AM -0400, Chuck Lever wrote:
>> On 6/11/25 3:18 PM, Mike Snitzer wrote:
>>> On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
>>>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
>>>>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
>>>>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
>>>>> or will be removed from the page cache upon completion (DONTCACHE).
>>>>
>>>> I thought we were going to do two switches: One for reads and one for
>>>> writes? I could be misremembering.
>>>
>>> We did discuss the possibility of doing that.  Still can-do if that's
>>> what you'd prefer.
>>
>> For our experimental interface, I think having read and write enablement
>> as separate settings is wise, so please do that.
>>
>> One quibble, though: The name "enable_dontcache" might be directly
>> meaningful to you, but I think others might find "enable_dont" to be
>> oxymoronic. And, it ties the setting to a specific kernel technology:
>> RWF_DONTCACHE.
>>
>> So: Can we call these settings "io_cache_read" and "io_cache_write" ?
>>
>> They could each carry multiple settings:
>>
>> 0: Use page cache
>> 1: Use RWF_DONTCACHE
>> 2: Use O_DIRECT
>>
>> You can choose to implement any or all of the above three mechanisms.
> 
> I like it, will do for v2. But will have O_DIRECT=1 and RWF_DONTCACHE=2.

For io_cache_read, either settings 1 and 2 need to set
disable_splice_read, or the io_cache_read setting has to be considered
by nfsd_read_splice_ok() when deciding to use nfsd_iter_read() or
splice read.

However, it would be slightly nicer if we could decide whether splice
read can be removed /before/ this series is merged. Can you get NFSD
tested with IOR with disable_splice_read both enabled and disabled (no
direct I/O)? Then we can compare the results to ensure that there is no
negative performance impact for removing the splice read code.


-- 
Chuck Lever

