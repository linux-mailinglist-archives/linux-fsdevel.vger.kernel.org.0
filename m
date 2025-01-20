Return-Path: <linux-fsdevel+bounces-39727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E4A172FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625BE3A1434
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3F51EE7BD;
	Mon, 20 Jan 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Alz4FQjU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63428479;
	Mon, 20 Jan 2025 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399810; cv=fail; b=Ozsx3RhylAAxyy00PRRh1hudG1gwZRDvXsygWze2dyx9fVd/+58qguRGNXSg9gnt6xXmJliG5cT3DBttMls4feC5XI8k9CY3jr2VS68Z5UFfent2tbpSTAfbpLBrBLryABwfAf+ikjq77X2P1ikJ9PTJZRLayGzTEy6NMb0TUns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399810; c=relaxed/simple;
	bh=aHJylc7LYUxyGdvbTIJmDeS2eQhRwnmTH5DqsIkgacs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PJkLaMX0KXSvWGwDrYBmYOVDc/pTGarb9JZTSFyWgEMidxsxYL4rmRkMVOL0oKICHgim48b9VXHGEvHrlbj6JM4ogS3BpkfoARYA+xkaqODhtY1pbmHacvsAogcUtaxCsgLkCO1EoGsN3ON3UTAMckkgMnHiJAV69KJ1NLQrgnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Alz4FQjU; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvGuiXA2wGmJoJ1wlkmqRMusoxOEmmIlwWLGW8/CG20Sdox2jJ8BPV4rH/6SBpy0SEQzFxqpbvRV8Ggxmn47ghOSTcHGxmLkpu6/ebkn28W/wP/pmNuFGB6ajX5TbGc/3zprx7NjawNBfhIjmPajVL3wTQti0A7KwcSdLQ5/uc78nvlHtl3FrI5Z8EhR7AiYQZyZQ1hG0Sgo5rV7PRSidlFi82lNOEzHLOqX6DSntLDxdWGDaR3RqotsunS3CXj664DstnNoNXPJicKl9t+85v3cpmgEpo0jRI46E1l9GEdfFHoPJi3TuZ7AWvp5eISaQCXC9FB0apulC6xXIoOE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfozJLpnY7OIS8IsnCChXwJuGlDflVA3w/AUWHL/ahQ=;
 b=i3U/e+n715Jse0sBSa+Wv9ajB8nEP+wxWnjULvKj1Q6UvrrkfRbHLVgWWDaXq9DoKclfqSWcGZPb/MrPAgZqkS2t3BORuNM1UYbSxB0ZfWdbQiFkJJ1IS3kB7/3B1wUfDzDhFSv5p/R5kvlykyzO1PR0N/qTALuzdkyWM44XnLe417b5XUlaIkXoYvWDJVGwX2mKuV9BecZgP5tFCfZuHr6tcAyltZfz+DJstxCWoV81BNu7GjR5gEZ6XSP2J+6fOMXXRK4NepP52pGO/iB09ztoE3p7oWi/M3lfUkxe2dN11Y3Mh6fGbToYP2fPo3wqXz3DtQh3/be0vBGbp8XgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfozJLpnY7OIS8IsnCChXwJuGlDflVA3w/AUWHL/ahQ=;
 b=Alz4FQjUu87L3WK98pK8ZJ3E52bgw+9R4n3REydRQG7LaOhkrL8jjCQdgeZuqvo+o5ommFosmHTifu32j9CDoUs8m8JosJShIpWW0Q7bYrRQ/Zy4G65FgW2CLEsyhyztlYwDur11TNrMdRtBaEpDqPSrZVDE6WHHgGU0VKVW3ecbplGszru+aABmvdtgIamHJS+f/Xgot5shUMFMVKo9NLAL8QtshSsdJ+2WqHTch1N5w3oAC6aCxRCr9j3x/F30BuPthtr1K5+peoVywzd3EIic/5NtbONIA6/zBk0r5Sirut9yPYOdpH0q/4fawVMgo8nz2NSKoJUGH78P6geIAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 19:03:24 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 19:03:24 +0000
Message-ID: <60a88ff2-bc03-405f-8a26-3808774dfd6a@nvidia.com>
Date: Mon, 20 Jan 2025 11:03:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving iov_iter - and replacing
 scatterlists
To: Leon Romanovsky <leon@kernel.org>, David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
 brauner@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>
References: <886959.1737148612@warthog.procyon.org.uk>
 <20250120142217.GA153811@unreal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250120142217.GA153811@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bb8897-7906-4d24-eac1-08dd39851d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2M2UkNCY1MrWGpaZnA1YXdiemx5WnRiZjdleHNLa1lMbURtaXM2UVpaMFZ1?=
 =?utf-8?B?NGxQSGJXazN1dExaZERSRnlJeXpzZTMwOXhhVWpLTkN3NGEzQnlscmdzZjBl?=
 =?utf-8?B?elRMOFQybGkwVUorUUZTcFlvZUpTSTVTa2pxUGFRdEZUcnFFUjJWamhzM2F0?=
 =?utf-8?B?VlJ2dVlpczlPR3Z4bjMxU0lhQjdpWnBMODlNRFh2cER6MU5Ga2ZBL055dHJn?=
 =?utf-8?B?eUQ5VlBRWW9VMy9rQ3dONVRZTXJCVXRvTkdoOHpYdDlkYTkwRnhzV1RjSWxr?=
 =?utf-8?B?RXA1TzJXQjBRRXZiYjUvZXNTUHJOWktjN1BxbW9YeDRwVUxKMHQ0RmJqdUR2?=
 =?utf-8?B?VkdLaytxeTNQaG94WXJuWUNPRWJiSDc4eitkT1c4R2dCRmZsMmhyS2Zia2Vz?=
 =?utf-8?B?R2Fmd0U3S1JBSWdIK1F2bm8xKzRYa0ptenhJcThyUVBmS29pZmpodkdqNU1r?=
 =?utf-8?B?OUkrS256ZnhDWjJtc0hRdkU2ejhHSUJ2RGRpWkNELzlENDZNWGFwZlJ5d3Rp?=
 =?utf-8?B?ZzJjbGNGOE5acmJ6WExnV2FNOWJYdEFoWHVLOFFycjNSaXdIeHpVbm1mVnhv?=
 =?utf-8?B?MHNRZDNJM243RGtUcHRPUTNoV1JUWUZSdFFHcWc1RUU1MHJGN0E3Q1kxUmk3?=
 =?utf-8?B?SlVkV2VPWUF5T25FMmlsQnVZdUV4SEFEaGRMb0VUaUhuSjdiZ3hpbm9IMHVy?=
 =?utf-8?B?NkJNVFNqUys5eHlUSmx3TXFka1BacnZaSUZzSDlFMm0zRnlZUC9NYTlrK2NU?=
 =?utf-8?B?T0hZdUY4dDRKaGszZTZNeERPZzN4VzYyM2gxWkN4a21aSUJSU0tuTy9KaDhD?=
 =?utf-8?B?M0ZBOHZIUFBFbVNic0pWWVczZ2tFR0RzN1RrN09sM0kwdTcxQ2RPdDFxV2pQ?=
 =?utf-8?B?SlRKdzZham9DMmwrc0tiM3FOTHpUMnBYelJEMnRUSjlFckNySlVHbEpsU2Nt?=
 =?utf-8?B?Q0M0NDJBY0QzQzRSUzcxVjJpTlRON3ZLYVpYRHZTWUd4MWZSZkRvbXptRzVa?=
 =?utf-8?B?bW5lcGtyL0FYVFNVNHB6OUhwendpUnBQWVZrRGM2QjB5cFkrZVg3eW83Snht?=
 =?utf-8?B?NnhuMlVkeW4zbitEa2N6eW5UckU4NmRrZDZhbmNDWHUxWTI2MGZ1Mk5XYnR4?=
 =?utf-8?B?UkNVazJGcmNBYmVsejlSdzhSdGVLcWFRVnpNQWlrQlVFL0R0RnJ6TmZwQnRZ?=
 =?utf-8?B?YTlqSHluS0hKdldtQmZFZHNMNldHT0ZXZmdhTzBGS2Q2N0QvbndYMVlmL3lz?=
 =?utf-8?B?MW9yeHpnYU51N1FZYXcxWmJBM3AyQlZMK09Uei9zVGxOYXNSTGUyNnN5S1dC?=
 =?utf-8?B?azZSekpOdERCQjEzV3pqQUEwa1paclo1OUliOGhmQUdXTjdEdWo4SWpUcXJW?=
 =?utf-8?B?WUVORmpNMjVxQ2xpbi9DMm5XdXB5ZFRtSWl5MUdXZWV6d283UGplMmQ4M2t0?=
 =?utf-8?B?R0JlbTE4UWZwZUZ5Qk1oRFhRUWZ6SXJPckpqT29GNEMxSFpidXI0NXFWMjZI?=
 =?utf-8?B?Q1I0cTNDR3U5ZjgzdnNScnBmOHpOZER5eUp5NGJ2NURBSmF2YUNNdytad3F1?=
 =?utf-8?B?QmV0alhoQy9RQUJpWit0dlMzTWhaMTNmcEc1c0NUaUh5MDVQZmc3QTBuanM5?=
 =?utf-8?B?Sk1hMWlycE4wMTM1TGc5VWthdDUzd2V2ZncydzVoczlzdzBxM3RvODlGODAr?=
 =?utf-8?B?dWdpa25FbWtNRTB2VVRWV3RPclU5b0VaUUxHK0xhejRBMDVSWDU1R25INDN0?=
 =?utf-8?B?YW9YSyt1enNvbHNnaG11SmJmTTgzYThONzRJSllsNVhlV1BCUzJoQURSRkxR?=
 =?utf-8?B?YjR5aDZQaWVVSDBKMkdDT0s3cXRoWnZ3SStMWVhqY25LZW9ma3lBWmtpV1Zt?=
 =?utf-8?Q?npVt2rkDk6cNH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVpkb0QwdXgvMUVBdEFBL0VMeGtnOUZHMHdXa29NVkx4dEJhRk9XRklyMUN2?=
 =?utf-8?B?NHJFMUI0YWsyUStDdVpWUE1jM1A4YWtOYW9YM0Z4ZklGNXlxdCtvSmdBUFRF?=
 =?utf-8?B?V3JKSW5ZbGFSaytPOWozVWUxQmt0VkdJajRZajNiMWxYU1NkOTlzVGQ5NFdE?=
 =?utf-8?B?bm9rNVhCTDhpU0ZtdTdFdEt0OUh6RnY3c2JJWURpd3dzUUNoZDFIZWtGMTND?=
 =?utf-8?B?dnY0LzRnUm9aV2dhQTJieEVJYW9xQ2NHWlorR005TnVWTWRscjhjWEdsZkRp?=
 =?utf-8?B?Sm1NVzZFakFFMUJwMW5VdXFKbVZJeEVTeEtGY0JmR3pPZXhneVAvUzhmUFQz?=
 =?utf-8?B?cVdLMDRoclE2N1B3d0tLeW0wZkJCeUlES1IwdE4zUCtSZHlyZk5Lek5WeGRo?=
 =?utf-8?B?T3k1c3dLVEhGS2lFUTR1dXc4Z3BrTTRTZGozeld2a09kb1EzS1FKL2FTbmtF?=
 =?utf-8?B?MnlQWmhSNDNVN29zSm10OVNkSVNYSk9pQlVDTlF3WDZnUWFSazZQb3lJcStM?=
 =?utf-8?B?cU1ESkpTK2p6YWpnZnFQTWtmOXJYQnhjdHdURWI3dDVaK1M5Z0E1bGlPZlZQ?=
 =?utf-8?B?aW9QMlIvcGxNayt4UmZjeHdhdVJMT2cyMDVQNkY5bE5NSElIOWVaRk5xb1hq?=
 =?utf-8?B?M0htUVFTK1ZFeTFGK3ZsSjRJV2F0V0VLOUtRZllYdllzUWhMdWo2SE9EbmZM?=
 =?utf-8?B?Wi9UdWxZdDVzOFBCcllkWElLT1FzK2FsSHhKcDVCSEovQXFBVVIycFVyZXB4?=
 =?utf-8?B?ZmpTN1Z3Z1A0UklVTTJIZWExeGtFR0wyRzAvNEM0b0ZHM3lRTUFXOG1Jd2dF?=
 =?utf-8?B?dUlXNU1ZK3hUY1dmNlFYbktOeE0vRXljcjhEY1BLT254V0VQemhWY2ZRVkU5?=
 =?utf-8?B?THNQcEdtQjh4clZxUnFRdHl0K1dHNDhrcUQ5WlV0ME93WjZqbUROeWorOUJw?=
 =?utf-8?B?TEVhQ1k3YmZaMkRUVmZwTUVITFBVVGd5QTBMdEVwZFk2MkZDSlNyQ2M4eVRR?=
 =?utf-8?B?VzZ3R2xmcGg4dngvOUR1TGhLZHRIOHVXVSttMmVSeGgzS29OZTY4R3JNZEJO?=
 =?utf-8?B?MThpV3VuSlVDYjFFbE5LOWx5WTFnOC93cnNyWmw4OFJJSE5zaklibzlkTmxJ?=
 =?utf-8?B?M3pvYXlVZkowMDdPYm1TNC9MbmRRc3hYelJMS2ZhMldMc0hwRXlQd1VQVk4v?=
 =?utf-8?B?QW1RS2xlN3hFeXRVVytYZFZ5OFpKWkhFUUpHQW5SS25tSnNacjdpbWJwVGdZ?=
 =?utf-8?B?bVlOZWhlM0laZTYxd081Q0FuTnFlRGZ1T01MMmhiOEJ5OUgzWTM5UzR4S1g1?=
 =?utf-8?B?SitvdmxXQnByUkxWRHpCY0xadjRQbTB1ZE9UTDluWVBuNS84U0J2RGVQa2o1?=
 =?utf-8?B?ZW5SazluODZXTjJwWTBHblBPNlZBZ2YzV3IzZExCbThFR2tjYVZuTHZxL29W?=
 =?utf-8?B?SWh4TmFpNUdOdkdEZm14OGp6TWlCN0g2VmVsQ1o4ZEp4NnR1SjdRMU5jdElY?=
 =?utf-8?B?Wm1MTjgwem8wWlpjaVhsQUdYSDBXa08vam1YVDl6MFphYUQ4VGFyTUVtbHNW?=
 =?utf-8?B?M1VBTmU3bTY2N0gweDMrQ3BpNGFIUEpQMW9jZ0FXTDFpY3RTQ1NQZVIxVklE?=
 =?utf-8?B?cFU5enBCRnNtekFQcVFITi9icVRUY1U2OWFTV0IwbUtRcC9ybTJ6TXQwclZU?=
 =?utf-8?B?U3pCaHE2RzNPOGpzSDlvUFdGZWc1QkRJT2FQM1RhQmZkZys1OWR6NmVCamQ1?=
 =?utf-8?B?c0podW5XREkxdExPdlliRWhwcW5BRDA0dnZjWVUyOXVWdFZ3NU5Gc3BlRTVU?=
 =?utf-8?B?YUlzVGdFdWFlNm9VU3dlSlQ4T25jUUNGQWM2N0ZJaU1qSUhQOElLakJyYTNh?=
 =?utf-8?B?WUJCTGhTNWtyY2h4NjlSMFBzTHJTWTM0S3ZUbVVZVzVWdFY3bE5tNklYQVd2?=
 =?utf-8?B?eDF6dHpsaHkzcWluSHRWemp6UDlnaFFGLzlEYWJHRzJxZ2VpOHcwM2tUQmxv?=
 =?utf-8?B?L2ErRWQxeGZ2VjVRZjlWOWlIOGw5SGRaUHFyUzRWbEF6ZHQvak9LN0NxTzhp?=
 =?utf-8?B?S2p2MzUvalEvYnpiY25XSzhZcDVBOHFNWnFZcVR6cmpuRmNHSTJlQ3IwQTNG?=
 =?utf-8?B?V0pqVDdXeFdYdTZXbEpHOGFKZ3pLai9Mc2h3U2RPWi9wbk1YMDl4dHR4T1RI?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bb8897-7906-4d24-eac1-08dd39851d5a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 19:03:24.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bERBL3yxk4zzvrmChBTkd5XNiUaWaEWQL8vDoxUFnI0EChqqEqx4ev+hotUgOhuoEhr3sERDDQzxnlWZuoGnuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237



On 1/20/25 6:22 AM, Leon Romanovsky wrote:
> On Fri, Jan 17, 2025 at 09:16:52PM +0000, David Howells wrote:
>> Hi,
>>
>> I'd like to propose a discussion of two things: firstly, how might we improve
>> iov_iter and, secondly, would it be possible to replace scatterlists.
> 
> <...>
> 
>> Rumour has it that John Hubbard may be working along similar lines, possibly
>> just in the area of bio_vecs and ITER_BVEC.

I do feel the need to apologize to Leon here, because I've been mostly MIA
ever we talked about this at LPC. Perhaps I'll actually be of some use in
2025. :)

>>
>>
>> [*] Second: Can we replace the uses of scatterlist with iov_iter and reduce
>> the number of iterator classes we have?
> 
> <...>
> 
> I would say yes to the questions.
> 
> Regarding rumors, I don't know, but Christoph, Jason and I are working towards
> this goal. We proposed new DMA API which doesn't need scatterlists and allows
> callers to implement their own data-structures.
> 
> See this "[PATCH v6 00/17] Provide a new two step DMA mapping API" series
> https://lore.kernel.org/all/cover.1737106761.git.leon@kernel.org
> and its block layer followup "[RFC PATCH 0/7] Block and NMMe PCI use of
> new DMA mapping API"
> https://lore.kernel.org/all/cover.1730037261.git.leon@kernel.org
> 
> Thanks

thanks,
-- 
John Hubbard


