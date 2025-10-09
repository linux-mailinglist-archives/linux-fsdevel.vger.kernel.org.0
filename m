Return-Path: <linux-fsdevel+bounces-63662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F4BC9A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 16:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E08D4FCDC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB62EB5DF;
	Thu,  9 Oct 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UMlAkQsv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2DA1991CA;
	Thu,  9 Oct 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021310; cv=fail; b=MHWWMXI7cvAb9noOWuTcJS7Xomtnz69q2+JLNaeOdFkeQ6e1H9Er8YokkoLUWtpzQlLzsdsG5zkwKaDX8W2UuZi5r7Cs4gmsvtUsMFCwGBf9//kIBxWqjTCN+6iSXMooHuQKHCsE9/Z+66j++wfnNNGPtftmUOC9MtNMifKMh2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021310; c=relaxed/simple;
	bh=QdHACiER1bK/KPWs/W4RFHQYamVfdFk7IiZPQWEsc4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JVqbO6tnGrhl6ueE0wEnbLx8+4cqrR9m0e0GVf+UkN/Ag7kpR0yos/tr1DX4afDqPzLi3p3/6H/JMPqOvITfnxTGiV1i2sY1U8ycsPumGwFhOIedSCAx0oaXqv5sRxq735CBp+H8x2z3huggStRAmt+qXWhWnvDfdXDLFuOd9tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UMlAkQsv; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJ5jVp/IvCyf6C06HcMQ/o/QbLVfhmpnkedgbk2jOj5g9oM+O6rSC4H9el8TlcTagfUmsf+YnRaq6BlQQN0jbkHE5Zy/EVudxVsVclHCUyJNYDskPxNjo+QcAa2LctRKZ0liWZcaBuLLIsykp4ObxzY4rgdT1DwbrwcyStBu/FiKRR4NyFm6cmke+SxJV75a2boHYr3y7M/Y2dklwh2lTXNprnXDJipiRGcxaztX6F2sTdHgvDXN9ECvQbGExfOAXvrqjunoOySAwE5d4l6fHfeDc0QBgDIYcNFoIUO2OspedJWdE55NyKwPvj+ZN9D2fcQT4dyWhDn0s2VB5HxIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6D3FEynlubYKXHXQPCYyRjPH86zjCm5TssKixQcGI2E=;
 b=isLQPq+E7hjouKeITgbMYzXstEk2CjSaXUXX5FLVyK0otzndhdIX9AJm5tIx7HD/wI0ZTHXIs69fzUfL8iqd6OVSf/9Yo3XupKXek+eetUrLXP1U/2Wz19ssDdh3q41bOzALo42Exhtr/cONwttGX8H3jvCq671JYpvX7LvMlie24c0bSq7MwLb+3FIZbUklDncUqEs7LFJkbX8MZwR7uux0NFlHXIQxJp0UkqFjfRcayItrrkujnuS/ylc63wCs3/Rn9nQk0enhTMX/uiW0wuetIxbBy/4mJFyWWUteaHz+7zeGx2Q29vJOMhPeDB1LIjuPaRuyjefHtZlqAkfQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6D3FEynlubYKXHXQPCYyRjPH86zjCm5TssKixQcGI2E=;
 b=UMlAkQsvSz0Cr7+PRFAgFiv+WLiQfB8FMxxDZyd6/cR8v1NDM6Tbs99M0MqEdUOWgrBVPGAuJSWBs8fhgpYOM0JbKPWsQWyIPfHz0ZMjlzj0MCtClmjjEB8qw9UIVv2hDZjAiGzMWbDlDG0XuiJJFta+xpZOW2jE9wPvV4Xm9UW4pY0SGNvBegO7v2htIzGdyKsrWZzxau2iRMT7QdX7XEnewkHH7XiqS6LkTn5IH4ZsVZtN+PGRAwVPHJ+vzRQb5ZnW09OqJmUg/f0Bl9+CBxahOZMTs17RPWR6OckqbzNMIgYuDlZjShB/MTqpIRJm9uIuwf74HJ97BwlNSOVVhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 14:48:24 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 14:48:24 +0000
Date: Thu, 9 Oct 2025 11:48:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com, hughd@google.com, chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
Message-ID: <20251009144822.GD3839422@nvidia.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhSP=ugnSJOHPGmTUPGh82wt+qnaqZAqo99EfhF-XHD5Sg@mail.gmail.com>
 <CA+CK2bAG+YAS7oSpdrZYDK0LU2mhfRuj2qTJtT-Hn8FLUbt=Dw@mail.gmail.com>
 <20251008193551.GA3839422@nvidia.com>
 <CA+CK2bDs1JsRCNFXkdUhdu5V-KMJXVTgETSHPvCtXKjkpD79Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDs1JsRCNFXkdUhdu5V-KMJXVTgETSHPvCtXKjkpD79Sw@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 5809c0a6-62e1-465f-01ac-08de0742e643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUlXTUdqUUJoVjlXTkNUdmhQSElub0Yzd1YwYXBjeGhBeXlMeUNySTlpWHFU?=
 =?utf-8?B?ZEtXWHA2SGJrOHg2WlJWdkk3bHpUSUdQQ0RYdWJ5VmpFVzVBbFRvSjNSVGxQ?=
 =?utf-8?B?NlpVcW8zY1M0a2ZhdHhRamhWTW04aXBSSGN0cDJZaWxyZkJWN1RkRDZoZ2Nl?=
 =?utf-8?B?ZWhvVTVtMXFVSFBEZkhqZDVlenNSakhtRm9vdWdPdWpFR284dUNIb2s5ckFE?=
 =?utf-8?B?akpQL1FDbU9IWlU5OWd5RE14bjhmajlrZk9IOURkZXdQMTJQUzVub21iN2Z5?=
 =?utf-8?B?RmJ1QnZEQnp3QUIzSU5NN3ordlNhUjNQVXR6U21sSVNHU1NEN3dnRUtubmo4?=
 =?utf-8?B?ZU5mRTZQbXFjQ1VGRGc1eHVrdTNQRENjOU1mSWRNdDFyUHMzYUszZ1BBZGVq?=
 =?utf-8?B?enc4R1pBd2xjQjdYckJiMUxIQ1RaRFEzZ01NVkl3aEI5U1JLSzhnKzlNUFdN?=
 =?utf-8?B?L0l4WlZZdDM1U2FEOWJRaEl5THlJVjIwUTV0d0JDZGM3WTRYVTJoTUpHMytn?=
 =?utf-8?B?aEJ3Z2FvZ2tOSDhPOERhMTFRK1cvMC9ZWWtqUERuNlkvRWk3VWZsZGNkQU5N?=
 =?utf-8?B?cSs2OXRwUzRXREZaeWdzaVpGSlZtTjBXRytMR2QyNjVxOE1OaE84VmFISWw5?=
 =?utf-8?B?WjRMbUh2VmFQNmNiM2s3elZ1MTFlM3RZZ00ybFRuTEZnTFVSN2FqRHpzRFlh?=
 =?utf-8?B?Z0NvM3ppUE1lbDYyTUtPNmpvWEZSRGxKdnhsTVY5V2Zqcks2d0F3eWdvVU1F?=
 =?utf-8?B?bzFZMnNiODhvQThnVTZZYnYzUjJWMm95eHdYNys3S1dFV1hadmRJV0FnNGQw?=
 =?utf-8?B?bTB3WjZrSHRyeTk2QlZJOTNIOS91bEttN3ZIZDBWT3JMeG5kUXVzWU9RdzJQ?=
 =?utf-8?B?S2EvVGZSRjByZXJqWUxyOTAyaXNvTjVsZ3h1blh5R0RaM1ExSHVaU1RwWVF1?=
 =?utf-8?B?RnNMMUg0S2xUcWxOMC9DK1ZyVHp4RWh4aE01VStuOUdLV2VjcEMvSmJmaC92?=
 =?utf-8?B?c1pYcGFjdktBcnJKaDlxV2JiNUF4ZXAzQXpHVGNNcHAwVVorckZZaHc3OHpK?=
 =?utf-8?B?MTdUSGpoYW42YVdseFM2T2h0VDhrcUhyaHRhY1djZWJKTWpZV3RxT2dpWWpm?=
 =?utf-8?B?VFJTa3luZGxQRXN4eHpQc0pmYS81SThaQVRzRzZkRzFzYmxvMG5nR1JEWmV6?=
 =?utf-8?B?UTJMZGtRK3NTM0tTTFdBV1ZLQ1pPS3ZhTEhkNXdISmMzdXJuN1BXeDZMaGFN?=
 =?utf-8?B?aVk4cTRjL0VMWE1Od0loZDRXV1pVbTNGWkdkRytIaWx4YWR3ejRaR0kySGo0?=
 =?utf-8?B?Y3lOOFpQclJyaG5OVG9IeCtldWJqblhJV1Jva01sS1JJaUNqQjU1VnlLUzVv?=
 =?utf-8?B?a0ZhMlZVS3RGK2JIZG45cjI2MFRtUW9UaTBnY3ArTDk2L3RoY24vb2xQZWtl?=
 =?utf-8?B?dTJDbzRaYlNYalo2eVcwQW9EOXZUY2ErVVhSRlBadExVVXlRdWFKaXJMc1J4?=
 =?utf-8?B?UUdBalJVNnlnM05wcE5UTFlFYUI5SXpTdE04ZFB6aXpzanNhYlZIYUhYdTZs?=
 =?utf-8?B?eWJxM29OMkdTcEswYVhGVUw5ZlJha3JTUWdycGNVUnpJcU9GS3FuakFBb1JV?=
 =?utf-8?B?VnJHTHh6Q2paWW8vWGdnd2xhRS9JQ1ZPQWRIM20ySnd4UXVucS9PTlZjYVFL?=
 =?utf-8?B?UllyQnR5MVcrZEtwRm1UaW5ZbnJYamZKdkJPTmg3dzR3ZW1ZM3Z6K2xtSzhV?=
 =?utf-8?B?UTdWQ2ZkK053UmY2Qk8rQXkvQXV4WUhjejZzTGdGZ3NFckwwMnlaUW9wMzA0?=
 =?utf-8?B?Z040UDd3cUNlRVhaRXAvUUJaWnBZaFZUY3RFcUE2eVJTMW1yczl6UDRsdXVZ?=
 =?utf-8?B?eHNjYlpmZzFyeHFxNEdsZHdLRXBJSnNoY0MwZHNYdEcvTXFuSG9CYTlFb3RK?=
 =?utf-8?Q?wbctpof7x2Zyrad/LKwVBfrLqo826dhN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1BtT05UUUNDUUxKek9yZENyczhFNHZTYnhBRDVzbzEzSXdjNWE3VVo2bjhX?=
 =?utf-8?B?NmJOaGxpblFtMk5vdUQ2Q1FBSWJSYUdoU0Q0UXZFaW90R21CSW4zNEZVK1pJ?=
 =?utf-8?B?bm9ETjJnZmE4ZW1WTFpzY2hwSXR2Zk5QT2JwbnhUM1pNbXhUV3NJZXRlakVs?=
 =?utf-8?B?TXM1VjJMV1hmSzYxeFdYOE4yS0dBQ1hlb2ppR1hSb3dBQ0lCVUtsdk4xNWJw?=
 =?utf-8?B?dmRxcHAzZS9jaDFQR0tXekp6REhTSVI0VnBFUGtqOXZJR1ZsQ05vaThSakNn?=
 =?utf-8?B?T2N4eERhdUczTEJRYjQwQUsxaTZwOGVJRVNtUXNPMzBKNnZCeFpYVVkwRXdX?=
 =?utf-8?B?ZUZzRjkyOU5Fa2xlT0tXb3BBMk9mRGhUeWJPbU1rWjdCVEpWK3BRZ2FTK2tw?=
 =?utf-8?B?a0tWUDlXL252ekhtQUhXQkgzUUprMUpMbFk1TWpGdURqUXRVallsc01LYkl6?=
 =?utf-8?B?Nm5HejB1TUFLYmFxVHI2cEJKd243dHdLNFlERTlaYWVLTTNWd0FpbTBMNTVS?=
 =?utf-8?B?bndoLzJxZnpVQS9UMlRoaElna29pZEdsbnY3SDZBcmxDdE05b1JQSFNlSGlK?=
 =?utf-8?B?TGloeFdxNXdKZlhnZWFxSXpHbFlndE1TRE0yUldsd3VvR2JjTGJiN0hBczB2?=
 =?utf-8?B?ekZaZmxURFJGYXEwNEdlK0wxVTBLQkt2UmxuaDgrOW5QYURCSDk2WE5mdkIy?=
 =?utf-8?B?ZzFWMDlyZTRzYWpmZngzeG52eDRmR04yenlqZFZkTlRZK0RhSzAzaVAwSWMv?=
 =?utf-8?B?REpka2FYVWVXRTNza2xNbmtDQzJwZ3FPczVtb3NBQlhlNUM0NUlJVGNhSlIz?=
 =?utf-8?B?U1NwS2FQMTdRVkt4NVNBdEttVnhkNTBKMGtZSkd6c0JpRXA5M0o2d0RGNjRZ?=
 =?utf-8?B?WmNPaGlQOXgzWHFwOUNtR3I3Z3JOV0M2bUJ4bTFSTkx5TVQ2OVdvK1VDWVh1?=
 =?utf-8?B?aTd2TXRHMTBMNS9qdmsxdWd6VVpOaWcrZzl6dzhndWFHeHAvTDJ1SkIza2x3?=
 =?utf-8?B?OHhEVDE5S0ZYUXFIbDJyZDFXbGxZSTE3YU93ZmluNzJWZjdLWm80aHYwOFFX?=
 =?utf-8?B?V2g4R21YL0tWRnR6dUtmWHIzdkdUdWRDYXpKMkhRdDVHaXU0dERsNnl2b0hm?=
 =?utf-8?B?SlVxcmtQc2VuV0toRTFBWjBITWZ6R2xMR1BUenZtMFBGenk0by9JWnZRYWY5?=
 =?utf-8?B?anN6NjR1RlpXL0pQY0dNNGRyaGtkMzVuc2ovZG1GZjF5dDhGOVJCRDkvYS9n?=
 =?utf-8?B?ZmxMdmd6RGRHT3hnS0xPZTBrQ1FFNWVwRUdqR2VtalBudGd2SFMyTmo2UnJk?=
 =?utf-8?B?b1c1d2JoYnp2TzNNWnBsZHd4VXNiZStWblpTd3EyM2tSMUVLNXVIUHhlZmox?=
 =?utf-8?B?ZnRFY1BVSmJrU1EwQ1l6bm9wVG5YNktoNkVBUURnS2VPU2REYzBlOWx1OTNY?=
 =?utf-8?B?ZmRMTzNBVzhPRkpNcytLQnJXOU12a1VqYjlWaWxleHFDeWxvanFZZTdwKzI4?=
 =?utf-8?B?dTRXcVRLTnUwSkkyS0o2d0U4NE9GV0VEREpuL1M4OGJ4WHlLK0tQZVQ3dE9F?=
 =?utf-8?B?Qnc2TEw2Nm5TRko2TVNsYWY4YWxZa2FhTjlhUE9sK3hobndocENTR0dEc1Bs?=
 =?utf-8?B?OFVUbmdTR2NzS0dqWVVOYjZhemU4Q2RkUkhTWUtSNXFKLzBBWGYzekVXR2VD?=
 =?utf-8?B?aG1FdUlNbDh2ZGtXTVJFMDR4aWJuNGR2SXU2R0ZlaEFaYmF3elJQQkZxUU5P?=
 =?utf-8?B?ellTbHlJR3RwRWdhY3NjelRwSGVBYzBiRVhpVkM4VXRFUHg5YzJDUDJxeFBi?=
 =?utf-8?B?UGQ2UDl3TEZFWEtocDRZR0pSUnFUVXVpU0w5eUNhTjRtRFZWTHJYS1Q3U0or?=
 =?utf-8?B?RDREZHF5c2xJczhmWGFobmJ5OVI4aW5ueXc0QTdUQ0VOaVJRaWJ3WS9jODhj?=
 =?utf-8?B?OHIvb3I1bnZSdHpZVi9oaW9qWWtxUXcxTHNReE5xMEkxdXJRZ0trRDI2eUJB?=
 =?utf-8?B?R1BIZzZIWHpMQzlneXI2VTBQKzNuK2JsZGQ1cDN6THM5YnU5aFBhWlFpRjQv?=
 =?utf-8?B?d0Vkek5zQ0NqNDJUZ2Z6NmE5MENTdllCUUlab0NlTGpaVnRvOGRTaTRkU0Nh?=
 =?utf-8?Q?ebX1DPsLMSpxoLN0Nd16WfKkD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5809c0a6-62e1-465f-01ac-08de0742e643
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:48:24.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGl70PdplLV+UurQDGzXwuMEvCQoo3s2b/xY5e2zw5dRJ1uA+w8crv1EpWH7YXad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6

On Wed, Oct 08, 2025 at 04:26:39PM -0400, Pasha Tatashin wrote:
> On Wed, Oct 8, 2025 at 3:36 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Oct 08, 2025 at 12:40:34PM -0400, Pasha Tatashin wrote:
> > > 1. Ordered Un-preservation
> > > The un-preservation of file descriptors must also be ordered and must
> > > occur in the reverse order of preservation. For example, if a user
> > > preserves a memfd first and then an iommufd that depends on it, the
> > > iommufd must be un-preserved before the memfd when the session is
> > > closed or the FDs are explicitly un-preserved.
> >
> > Why?
> >
> > I imagined the first to unpreserve would restore the struct file * -
> > that would satisfy the order.
> 
> In my description, "un-preserve" refers to the action of canceling a
> preservation request in the outgoing kernel, before kexec ever
> happens. It's the pre-reboot counterpart to the PRESERVE_FD ioctl,
> used when a user decides not to go through with the live update for a
> specific FD.
> 
> The terminology I am using:
> preserve: Put FD into LUO in the outgoing kernel
> unpreserve: Remove FD from LUO from the outgoing kernel
> retrieve: Restore FD and return it to user in the next kernel

Ok

> For the retrieval part, we are going to be using FIFO order, the same
> as preserve.

This won't work. retrieval is driven by early boot discovery ordering
and then by userspace. It will be in whatever order it wants. We need
to be able to do things like make the struct file * at the moment
something requests it..

> > This doesn't seem right, the API should be more like 'luo get
> > serialization handle for this file *'
> 
> How about:
> 
> int liveupdate_find_token(struct liveupdate_session *session,
>                           struct file *file, u64 *token);

This sort of thing should not be used on the preserve side..

> And if needed:
> int liveupdate_find_file(struct liveupdate_session *session,
>                          u64 token, struct file **file);
> 
> Return: 0 on success, or -ENOENT if the file is not preserved.

I would argue it should always cause a preservation...

But this is still backwards, what we need is something like

liveupdate_preserve_file(session, file, &token);
my_preserve_blob.file_token = token

[..]

file = liveupdate_retrieve_file(session, my_preserve_blob.file_token);

And these can run in any order, and be called multiple times.

Jason

