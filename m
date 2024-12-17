Return-Path: <linux-fsdevel+bounces-37599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4169F42A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC77188B2D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED7B1F4279;
	Tue, 17 Dec 2024 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f/x2m0i2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368918A6DB;
	Tue, 17 Dec 2024 05:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412552; cv=fail; b=fqT2ZfoHisUCNJl9xFjGPhq+o4K9r+nFYX4RhIf8+0DX8xOLBh5a/hFEWlIReq2ECxVQSylOs7/BtXpNY+TyILikV63jlivUNyQOWZy8/enQQyE9oo8MD0c4w0Pgpi5pJRI+KcNUmGlYr7ZBox1oOwYwqtyuvQToxhQmZl9T2rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412552; c=relaxed/simple;
	bh=/Csrylkm2NidU986QPWqaDZpz+jU+FcWBDetRvEORiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRgRi6RNG/6rBxucwACEgfbbm9Lc4K2tv5jjVBUILX9rj3BZBzNj64FXjVGja6LJFpd34G76snhA9lEAulrGTQFIKnaTgVACKGXbLSKcVQjoi1Y/p1NCesKyRqq/3lgXII1shJdrL26iL5Bv/sQ/dLnZYoBrGrVB+28n4hsej/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f/x2m0i2; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvBUTQWwTKir3Mmhh2kRCoUdrEAwlY4T3vWCkbMYvfX94iMwNS+GWSuhewrYepNCTrHzXge9KX8ppPIPqR1WPr8H5fdsMcuFm+PT38hMTeBYUB5V5grmngKwunEU0UXOM4ku3n7pEmN+T1sHTUzzjLvJ1J0oQJ1Gs4TWdyan5GclJGpRtPSdIWGBKdEYQI+PakjZB01zgtXyZPcY57Br6oKWzEwuMc5ssVM3Bud3YO7LWpSikeo/aB1gcEl1kYCfOrXJAyqJshRyaODGfHirhgZNBMEvvRR7VdfB8wC/aGDxSlL/gVhMaXlyUp9phgAQt27sDxijSgBgZTEQ+fFubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANnS9ugPhWXEhOP/c+FzNHxXqu35Gn0O+fqlriZg1uw=;
 b=tHsHJF4D8w73O3tOFYzxBhTdIQuPYr9FmElXFnJR3gfUvw0TAwCdLXWdZasjK+0NkaQ2Z7pZXW/3I3+C3ENs7ooh1zqWWy8fK09yOsp9vYsR0KH92Elgjst2YP07vOSpmzF/rfQCzusa0BKeGawY0w6XGXZDm8meDYmQoqdMvD4pQ5dznfVQGJJmo5PQm/wcrT3VaPj5vf4yUDdQENL/qphtUi8OMOFL5qQYl6wsB94XGAh3mxnK04ICI99jh0cesQYQzkJeY5IF3MtCTrRYXUIcEEPyMAhNnH4Qq68KwPJ2Gsohg7T7IDcZPmkR6MnaLcwwtdEW97vGWgkIaAZFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANnS9ugPhWXEhOP/c+FzNHxXqu35Gn0O+fqlriZg1uw=;
 b=f/x2m0i20+SIkEJeGdmYa7Czv9/lOVCWPcqimzb/pQI1cT7nUQMHUF/3XgDmQcbIZ6eacCuBYPSswSXZ/qR3XCCMe3+duqI9HboHKU4NerGCTzhJGNkfhushCumt9cZecLr9wzz5RWC+kdGnKrcfOgwNZGkZlJbkJ/R9ZBtxXSwa8CGzfWvKXIGT57WuvVsfOWbS+esD1sL7Av9QmHL5kqCCAme3zz/qArFky4ggr4lleRpNnFCbmwlMZEpp/QPEfBVUE5nQX+yt5M9mRWC41zkft7ge23lnmA0a5k6B6yYXfDkguNmkHK5ab0R5DU/a5hj4chYqIM6XJZkhTpwyYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Tue, 17 Dec 2024 05:15:48 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:15:48 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v4 25/25] Revert "riscv: mm: Add support for ZONE_DEVICE"
Date: Tue, 17 Dec 2024 16:13:08 +1100
Message-ID: <f6340f6527b6eca57ba423e3159818eb63d3a165.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYBPR01CA0070.ausprd01.prod.outlook.com
 (2603:10c6:10:2::34) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f1d358-a91c-40a8-27f5-08dd1e59de38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDZFY2VEUXpLYWVBZEt5K0RPUlVoNDllQTBFd29iVDdNWGJUTHJ3UnhIS1RX?=
 =?utf-8?B?cXNPb0JjMTBMc2pJdmJsUzJxMmFRdC9JSS9pbG5QejhJYUR3bXRlREJYbVNV?=
 =?utf-8?B?VS9na3ZCMjNLc21HNkRwV0F4Nll5NTVCRFVSU2h6ZmNoYjU4ZzlmYnV6OERw?=
 =?utf-8?B?VkZnSDBBTkIrcWtwUS9pZGhKQzZRVytDWTNLNDNPZXdwT0tLWVByS3RNdDhB?=
 =?utf-8?B?Z0lhTWdOcytkTDg3TFlOSGZvV084Zzk2V2dmbS90a3NkNkJTd1FzcGRMZS9t?=
 =?utf-8?B?cnlYT0laRklnUkJsRE8xL2tOMmhaNWx1dGFMQndzSzdpRkl1a013dVJscFdx?=
 =?utf-8?B?SGM2ZkJabTBkZTZvVU1xK053a0p6eDYyeEw4cjlCNGJCSlVweVordTRZN0Nv?=
 =?utf-8?B?RDJVWGFkYS9ndEo5NVRWRmhOaG1kZmEzcGY0b2pDT0lkVFV4Q0QzS0F6SEd2?=
 =?utf-8?B?d05pZlpSMFpITEt1czFpWEY1bGNjTjZEcEcxYkd2NGFYaXBzQ3d5bGwvU1Q3?=
 =?utf-8?B?emQ2THl3djQxMWErRUxzYnlCVnMvUEdwbkJudEE3bTk4SnVxaG0zMnVmRkI0?=
 =?utf-8?B?RTlLN2YzbEtuZjVXKzczcG5HQUNZcjhZUE5FdDdXWEVhOUttajNPcHE2NXF0?=
 =?utf-8?B?bWdRU1JaNVd2ejhqZkEwR01SRTZtTnBmbGtsRE50dWd5OWNJY0ZFcjBVWGhU?=
 =?utf-8?B?RXA4VUxIVEJrT25DOEpqaERWeVJlMHlQREg1QjQ2MUtEbzVmQlNPeHFqZkFX?=
 =?utf-8?B?ZWJCRmNiVmMyNEFLL2V4RHY4L2gwdWUydnlSb2FVNWQvbWEyRDNrWmhDQ2w3?=
 =?utf-8?B?c3BtSHpNUkNlelIzOUVJYUNYcG9jMndyVlpPcjFxcGdKRHpBRkc0UWlxc0Iy?=
 =?utf-8?B?MU82bmFUUXpqOXRGZ0UyempQaGlxT1hGOHpqWWlTdEVoSWhHK2EyTFpuWGh6?=
 =?utf-8?B?andFck1PTGMycytVaFkyeGd1MzdCYkY2a2Rvb0ROYlVkWnZuM3k0clBRSFg1?=
 =?utf-8?B?RENHNEdXSThiRGxQWEYvWHhHL0g3MW1BbzNDMTliZ1BNeXo2UjMrTFIzTk42?=
 =?utf-8?B?UFVmRWFrRlZBb3lkY2NxR2N3MDlNWDZueHk1Q1JSNUdSWm4wNFJCSFYvblkx?=
 =?utf-8?B?Rk9RRC9PY2o2cm12R1NPZDNyYitHUDVkc1JTRUxQNUdLS2lVSEIwcDZBbjFw?=
 =?utf-8?B?RGxMdm8xdWNXbVlJMmxYazIxL2ZmNkRIRUJuOUxIcnBQTDQ4dFJLMVd0aDNG?=
 =?utf-8?B?V0NaZ0FoNDFNejUyNjZ1S3JSV2QxU2o1TVBMLzgrdmNSYzZJaThkR1hJdkt0?=
 =?utf-8?B?cDRubFNSdDIyU3l2YWFndkFvOE13R0ppVUZIaUpSOU4xdWd2QWgxdEF0R3Rv?=
 =?utf-8?B?WCsxaWZIYWcycS83YkhVWmtnajMrc1pDQnB5WEZDWmlGSCt0ZzZRNkw3NlNS?=
 =?utf-8?B?WG52bVpURk82YXdmK0xoYVMvb2Jla2plOFdzN0VNYnJ0ZmxKRkNIS01DQlhN?=
 =?utf-8?B?RDc1bVNJeFl5UW1WZmt3TitnRjdnbUNad0NhVTZpTzMzb3MwWU9RT2FnWW1H?=
 =?utf-8?B?S29JYUlwVXI4dTRSRmU4d0l0ZmR1RlB4QjdCM0o1bnVVYUhPekNFWlE5S1Fr?=
 =?utf-8?B?ckRaMU5UekRKeW1zWU9YZEJ1emIrUlB4QVN3R2Z4UTZ0ek9sZ05JV2duMytY?=
 =?utf-8?B?MU5ZQnBBcEhVaE9YVXYraXB5NndOa3N1bEtXWnJxb0V3M2FVRTNGRXdnZGdz?=
 =?utf-8?B?cm5yT0tnaDRXeHl6ekhaZ3pUV1VZc3UwaDNrOE1CL2FCaElBR2hwVWs2Y0Vr?=
 =?utf-8?B?cktqbG94NzJaTUJwcmxFMzdLZVY4WnFmM1BGWUlMUUdmWnhXZzFxYlRHcmRz?=
 =?utf-8?Q?KfpUJPTsBPLxM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG9Xd1NTSFVzVnhycFhpRXlqSDh0Q1JxM1BTZVc1TVBJT0tISXhWU09VTzFj?=
 =?utf-8?B?WVlkZ3UzMG55REZkV2VVM01YYVdDK1RyYlgraEF1MGJ5dFEyazhVQWVSbXcv?=
 =?utf-8?B?Y0NBMUNnL1d6WjMrZnNBMEVIZWoxUmxuTWluT3pjWUR4MXRrMjNrZFdId2wr?=
 =?utf-8?B?M3dpRjZZOURHa1ZVS2ovZHBtYXRWS0dQaU9SdStlWnkxY1IyK0Q2SUJsc1ND?=
 =?utf-8?B?VEVGaE4xMndmSk5YRmdXa1lMYlVrQi80YTFCQnhnYWNFWXpWTnJiZHdJaXhT?=
 =?utf-8?B?RWhHMWJaME1ueGxoQ0dsMUZLOXYwZ3VvYnNjcVg5UFJzK0ZwY1ZlZnRka3lh?=
 =?utf-8?B?eEpXY1k3RnVzQW52RDBtSy8xR3JvNHJFTTY5djlFT1dGbzlmT0tZdEwzS0lL?=
 =?utf-8?B?VGZPK2tZdWhhUEMxcTZaVUR1MVlGTGJ4alRGS2JmVkx0QUJNTldReXl3TDkx?=
 =?utf-8?B?Q3orM0Z3ZU5zSFhrcmR2cGRzaEZ0bE8wRVJ2NWVldUdWT3ZJOFdXeENyZXZW?=
 =?utf-8?B?Z09zSHFRWS83L2o1bFVBUzZTMlVaTmlEUVJIdWZjRmE1UmNkV3dDS0pCU1Nk?=
 =?utf-8?B?VWpyU0VTekJHalljQkNoMVhVdDFOY201Q3RTNjBYd1pIOW5pbk5Va3pkNjk1?=
 =?utf-8?B?aHVrV1M5SkZyOFJ5dDFyd1N1Q2JSYlo0NWt3TzJza1RtMVFha0ZidnlHeC9i?=
 =?utf-8?B?ektoVEUvMnlwUStEcjdyMjBrcUszNS9TQVNmYW5IWDB4NVE5OFRham1pZ0Zo?=
 =?utf-8?B?SmJQSmJkelVBTGw4YkRFZ1AzYVRSVVJWaS9JVlhoMlZrYWNYOGNYSThiUFUw?=
 =?utf-8?B?Q25KR3hsSzMvWDRJY3lHV3pnR09OU3pNQ050R1BMNDRJUmFYUVB5aVI3WGhr?=
 =?utf-8?B?bTREUm5IY3g0bU5oL2xod3lxU21lV1RmRkxaNFppZSs4eG1KbkZCZTh1Y25G?=
 =?utf-8?B?RjZYNHhMalN6ZStKd0hLVkZ5aDlDa1pBRS9BTDgrMVVCOHVhZEpCcmFJTS9U?=
 =?utf-8?B?b0ZzQ1E1bEhrVW1jMFhUbmhlNEM4dSt2S3pYNjlhV3JQYUJXNkdBRytZcjFJ?=
 =?utf-8?B?bUliZlRYamFjUWJZTytyZ1FmYkNMRTExOC9mWHUwVUVWcHllU1lXWXZ5cDVM?=
 =?utf-8?B?SWtIVXFod3JvdHZ6eXRqT3MxUC9LbG5PZ3R2NkJoOTBWVjVMU3labUx5c2F3?=
 =?utf-8?B?ZGcxdUxsR3JadStJSHFWdGlaTkJ2MUg4TUhXdlpPWks3a0FjV1hIaUtDaDR6?=
 =?utf-8?B?YnVIU0Qvd0hUci9tWjJKQzBpOGQyZGxwTlI3VTJPTzRmdlNZbGV5MnJDU3JY?=
 =?utf-8?B?V1JRZXV0Q3lIVW5MS2FLaWtsWXZFS1BkQU1MR2JqSFJLV0NjdEFyd2JsdVNy?=
 =?utf-8?B?THZWb2ZtT2pPOTFrdElPRzZsUk5OUHphU1F6WktXcXR1K2FWMFE1SXVkdVVU?=
 =?utf-8?B?LytOUWp2ekZlbHRhMExxbWtrcVErZTN0eHcybFZPZmY3Szl5SEtMM1JCMk9G?=
 =?utf-8?B?UlhYNTR2LzE1bS9nMXI1N1k2Q09GVllwc2cwODRxaG8vdE00clZHcG14Y1lW?=
 =?utf-8?B?bkJYcWUxK3JwdmRleUVvOFpSR1h4SlV2Q245MWduNXdDczBEYzhzL0N3czBn?=
 =?utf-8?B?RzFGUWFrc05lSlVVOFFyK1RhekU2QU4wL0o5dDl1blBpaFNLVW1iQkluVXNW?=
 =?utf-8?B?L1NBY21DVEpFbHdVRjJxMWdtQnNTTWZDaGdHakdUeTFnRzg3Q1JiRlJHWDQr?=
 =?utf-8?B?Vk9mbDdScC9LQWQyNEMrUTF2OWhsQWkxRzNOSEVBWkNHRlJZWTdMbmRocXRj?=
 =?utf-8?B?TzEzeVdRTnpJUWFwQmRNSWgwc29tQ3lKWEJydHJkdnhEMkxyS1FkVGF3aFJp?=
 =?utf-8?B?bTV3bnU1Mzh4NUt2d1ZFWmJWa003WmlMcExuWmtoV3JHSzZEMVpVNmVJTnRI?=
 =?utf-8?B?NzU4NXZkdENNcVhKdlhSSTBzeG1qMTIxM05SSkIvMEpQaEpIaWdlQkFaYjNE?=
 =?utf-8?B?cEpnSEpLR0RNT1pCcjBQamVYRXNZbExoT00rU1JTaEk2ZHZLY3h0R08xMEtP?=
 =?utf-8?B?UVliQm1OeFFmNDFrb0t5MGFjTHQwREtrOEZmTThPb0RYOHh6QitYeWo3aXE0?=
 =?utf-8?Q?o70eIojJdGc8LqUapNoIbK6yj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f1d358-a91c-40a8-27f5-08dd1e59de38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:15:48.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bmnmlltikPBk+zZkAjZXgIdfqrni/a275gORI57E5PuOhe9lQuodMq0DUHl6G4v1hQGBaQrsGgn4m9WZ29YeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

DEVMAP PTEs are no longer required to support ZONE_DEVICE so remove
them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig                    |  1 -
 arch/riscv/include/asm/pgtable-64.h   | 20 --------------------
 arch/riscv/include/asm/pgtable-bits.h |  1 -
 arch/riscv/include/asm/pgtable.h      | 17 -----------------
 4 files changed, 39 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7d57186..c285250 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -43,7 +43,6 @@ config RISCV
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
-	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 0897dd9..8c36a88 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -398,24 +398,4 @@ static inline struct page *pgd_page(pgd_t pgd)
 #define p4d_offset p4d_offset
 p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pte_devmap(pte_t pte);
-static inline pte_t pmd_pte(pmd_t pmd);
-
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return pte_devmap(pmd_pte(pmd));
-}
-
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
-
 #endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index a8f5205..179bd4a 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -19,7 +19,6 @@
 #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
 
 #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
-#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d4e99ee..9fa9d13 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -399,13 +399,6 @@ static inline int pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_DEVMAP;
-}
-#endif
-
 /* static inline pte_t pte_rdprotect(pte_t pte) */
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -447,11 +440,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DEVMAP);
-}
-
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	return pte;
@@ -763,11 +751,6 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
 }
 
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
-}
-
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
-- 
git-series 0.9.1

