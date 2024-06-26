Return-Path: <linux-fsdevel+bounces-22471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A423D9176A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 05:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08351C21336
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215954907;
	Wed, 26 Jun 2024 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jeC89dNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25242AB3;
	Wed, 26 Jun 2024 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371386; cv=fail; b=lEfyLteidyyQr3TzjK/PY6NjUIllFfLwKtrqOGEBkG5773JYzRFSLCgCfc5bIDmJTFX+ZSMa5bYLsdw6L4ShHrqqGr4Zf8RYMkNUjMzOj6BpobYDB5GUZ3IkYLOyWNTKQ9C8/emLADj47EN+h5DPQqOuRAZ/N319+jItFhEJ+QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371386; c=relaxed/simple;
	bh=LELguH4DIVVM4zJxWBkSFtYcZds5apJ73aW+InAJ16s=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=b8V4LjMmfDKtfw5zow1Z2kcFjBY32Ip/+W33CjjQ2+wE/3GavTzbag+1s3y9c/95cFC1TDDw9pA/AhSeD8gNi3fDsa+NJ7a+/ENqiFgc6bixOpZYEiKcalcwxbTkLwZNvIXcsXIPgWgfSeo65ZmKn08K82y6VcuN8bRPgbhJ7RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jeC89dNH; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CS/qd9xwvF2BNjVRk3fTnOhfBajahHo7Pkino9vt56pdhLDKnhxz6rXs1awRNncZ8Kc/cW6qj8pgZenh2pUMBYO3xJa13htvlAJ1400Ti92AfB0ZPq5n3ocxMB775GaXiC+eT53XW2Hpzm0KwMaMQ7tM6CY+UQU5a6+2XXWrPZQ+epIHdmMgKWFLNepWg71d/7OZyhhyeukgO9mD6peQ9TWRa/fYysayWYry8OHHLMigHDL9zUcugDv3MgxLn1f6zY5wD8EexeQdiC/bqtOmb8RktrQemlpNx6oyGWSbtIhWCE+f4+SoWbA2eJ9RNpHeBBDDpkwt7BLMT1V0RMOUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhiTUtCRc28m2+jSz/9A7EZRtVIqVmwSqe6FP5Q3PSg=;
 b=ciw3XoFqFHSrZK6lWOdTsLWt5bNAzXsWIwh9jyCHSmtYxbgoxCHeljyr/pFRYlBe/L5gwSMFYI8+m0ML7sRlaAmST68kHnF58im6f+GNDlaHD0raVlwNVeLNHpwydO3iQ8e/oDOaGs6QkhASlvmuEgyvS84mMjcHe3/UgSueHOdyES6bza2EK5tzsFtuW39LIcyFEaYeTEuzdAihQ7nY6VeLnMlRngyusvc+Esjr8/0i6ba4dYv6nOmmAHk6I2+/tRwgJ8Wubank6Ks5vWerVXjizzuqm5Dx5ZGjZhug7UX2cDfbYr+xf57TJftq9M7ie0acfCiGRJ45TlVwczQuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhiTUtCRc28m2+jSz/9A7EZRtVIqVmwSqe6FP5Q3PSg=;
 b=jeC89dNH8UQS2oyV6I2xVdjOElBSPcKZUA5kD2/O/CqsapZhdiS/1+8nSyRW3Cm2RpZDJv4zoklLprtyDSWDKa7esP+cujH/WbZEa5ojmmPPjwMixBjRBNB+km1toynWGfxHiqG8h4kX95jmiK7eU6+X3fhuiKe1sICBlr6p64piUKMYvmu4qaW81J7rBIr5MJKITu2zakpM7bfMjiyJhT1VTSaPorUq5n5iecm2f9OByWoZCBBqdzlrk2su1KvDR4tjkt7VnvHeRRQFTuSdL/k8Ydba5iUaeICnVelL0EuHYbXifhcxoBnldDRwuTuZFk+wbSFYoVngy21WEIC3bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Wed, 26 Jun 2024 03:09:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 03:09:40 +0000
Content-Type: multipart/signed;
 boundary=b5312e7e7a1599e3635d211094ec59b259802efc5434ecf734fd1469613c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 25 Jun 2024 23:09:37 -0400
Message-Id: <D29MAAR3YBI6.3G6PVIR1SJACO@nvidia.com>
Cc: <vbabka@suse.cz>, <svetly.todorov@memverge.com>,
 <ran.xiaokai@zte.com.cn>, <baohua@kernel.org>, <ryan.roberts@arm.com>,
 <peterx@redhat.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>
To: "ran xiaokai" <ranxiaokai627@163.com>, <akpm@linux-foundation.org>,
 <willy@infradead.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 1/2] mm: Constify
 folio_order()/folio_test_pmd_mappable()
X-Mailer: aerc 0.17.0
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-2-ranxiaokai627@163.com>
In-Reply-To: <20240626024924.1155558-2-ranxiaokai627@163.com>
X-ClientProxiedBy: MN2PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:160::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 0854809d-ef00-462c-f895-08dc958d6b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW5tMWhEaHdCMWhzeDM3WWU4T1J1VE1BL0puZWZQcThrQituejVyNVJheW5i?=
 =?utf-8?B?a3QrTHBDUytwS0cyKzAvMzNVckJ4RCtYckVMOGZiRkI2bzRhY2VXRjZyRHo5?=
 =?utf-8?B?L2JybEJwY1RTVVhaemlKcGNqTnpUMUQxRkptVW1yT01OQXZqK3dLM1h1U08r?=
 =?utf-8?B?UEM2RzJJMXZVaGc4KzBOOHlPTCtneWQvM3JQU0c3d25pT3ZlRU0zWnczMVFZ?=
 =?utf-8?B?QmJ5TlBIMGNyL2puTHd6WGYveVBrNFNqRHBxNUh5V2NLTDgraGN4c0xVU1dC?=
 =?utf-8?B?RFVUVGpUaDU2TWdPdjdJTmFBNVo1SjB4TDFFTUs2Sk5RZytRSk53N0ZTV01K?=
 =?utf-8?B?K2wvaTlnMExhby9KcGJ1MHc3bWQvZDZuTnVlSG15K0hFenJFOGZZdTlxWUVG?=
 =?utf-8?B?WHBoVEVEbldSZXdabmZNZkFXbEZwSitLSDhvL1VPYlJTS2s5cHpaN2pRbXQy?=
 =?utf-8?B?ZmZGTUxQcUFUUXcrS1BNdXNBbmwwUzJxNWlXZTZENHYvSWtHZHZXWnpUZTlL?=
 =?utf-8?B?dmpUR2MvV1dFTk9tY2hxUjdPcjJLRlJJOTJZRmFCQ2pDSUhWMmxCWHNaVzBh?=
 =?utf-8?B?UDBiaFdIYWZOcmo5cDhBL3lrSENzZ0JaTE1KOGdMejVzTXF2cGdVSTNlRWZx?=
 =?utf-8?B?cSsvT1ZkeGs3T0NpRks2aUdDSjFaNlZuQllERGw3dnVLWCtIbGNMdHUyQlJE?=
 =?utf-8?B?VmlBSVNvZmtQcmpsMnN1SlBVRDNYd3p5di9BTURwQzhJQmZQTjhYejRtWGg0?=
 =?utf-8?B?TDhpZUxObW01VkxDRkhOL1ExbEt3bFRXRjJld3lZUnhhTnIraTVtWlg1TmdF?=
 =?utf-8?B?NktlaVBPT243eUowellSNGZ6eVR0OGF1VCtqMGdLaGthZ1VyMHdzQkQrZjQy?=
 =?utf-8?B?OWlsWUY4ZHY3WmhvVWh1am9YOHZrSlZrM3JXbGIvR1pGb01QSlNwNWZpalp1?=
 =?utf-8?B?eXNSTWgzNVphZ3FWaEthdURXWUladUpnK2dxQnZZdUFQcldFckRnallrSEhr?=
 =?utf-8?B?aFRBWXErVmdjL1VBTWtzR2Q3NEVYS1pOVjVZd1MxejZQTS9RdG5ndGVFbXd3?=
 =?utf-8?B?cFVLZnZxWWRiWldwbEtzUkZIOFFiYjJWVkZXMktVVDMwVEcyVGszcGV6dlQr?=
 =?utf-8?B?ckpwWlIwUERNQVFIVHJ4cFhaajVlWmUyUzR6SU9SY2pRdHV4c2lQVDdoazky?=
 =?utf-8?B?aTZtNnFMRi81eXVML0lGcW5vZ3JoK2FrQzdLY2srd3paQjB3MXFNRGVkcG1z?=
 =?utf-8?B?Z1I2Rm00d2FTTmxYVjhzSU5NbVoxRldubFp0RjJ4V2pRd0l0TjgwU2xHdEds?=
 =?utf-8?B?WFdBYXNhRU1LUm5uWnI5a2ZQR0VmTzY5K1ZOUVNPSG1rd1QvRVB1TzNGYnRF?=
 =?utf-8?B?SE50eGhJLzVMN3lIbXVGMG5aL0VBUDRPM3d4SmVvcG1PSEFEZis4dmVsaTIz?=
 =?utf-8?B?RHBnWm1ZaTlwamtFZzl3MlM1djkwQlRiczVlVW1ybkxyZ3VZZVBpOE9jc2p6?=
 =?utf-8?B?d2pZNlNUUThyRk5TcVlDSHNFaFRCQkFLQWN3ZGpVb3prYmdsYlNJRWJFVkRC?=
 =?utf-8?B?ZzdDdk96SmpmS1RYT1FqUDdOZmJBRDNFTldFTUlxK2NaanZTb1VMNFhHNUxH?=
 =?utf-8?B?THIrUnlTUTgrNVhCR3pvcjdaOWRpN0ZUNFNzZmxDMGhtVE9vLy9DSEVxUTZj?=
 =?utf-8?B?Z0xkMnpCaWlEY2szMHpPSFhZYnpGY1pwclVpSEEvRzdRQXRqYXJBVmhLSVNR?=
 =?utf-8?Q?TTCHhDTO2rzPRdOKAmnKrBbC1ni5zzXMxv7hy1w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHZqbGo0M094ZzdIVFpTdHhkalFOeEt3eERFNi9BSEZranVzREt0TFFJSlRp?=
 =?utf-8?B?MVNURklUc0wwd3kycGtMN0NhQXlicTlJcjloUW9lT3I0eW9QYk14THBaMkwr?=
 =?utf-8?B?b1EycFBTL0FmTW5Lc3lzekpwZ0FTOVJmN3FKN1NEU2Q5Yloxa2ROdXdnY2kw?=
 =?utf-8?B?QVRnV1FhOW56Z1orRU54V2IrdW81MXJKL0lzbDRrVm8rS1lWcDgxRUpydkVx?=
 =?utf-8?B?UzkxOHo0cFZGdUZRcU9ZaXNXRXRERWdQR1UvQmVWZlVxekhtU0hPcDZ3Vkx1?=
 =?utf-8?B?aE5tQmVmcnlkZ084Nk9IT0lMTE92M251SFZnZFB0QTFxMDBSTmJUZXBaVUFF?=
 =?utf-8?B?b3IwOWljMDR4RFhLbVA3alpoblhvUlhDelFHUSt4Zmg5U21YMHM4UGl0SnFS?=
 =?utf-8?B?bFFOVE5aNEZSV0lQN2FRRFNKWU5ob3hZSDY5QUt2bkVSL2FJVWtpMFdXUEIr?=
 =?utf-8?B?Z2ZROUtmMlRiSzUvTHk3TlB2Rk5nUWEzQTk0UGpEM2NlSG90TVJhK2VVVktT?=
 =?utf-8?B?bkovbWhnSGNXTkxPTTdkUk4ya3lyM3p6YnJBREh1L1hIQnNaVlhSQVFJUG5Y?=
 =?utf-8?B?dHJaMEVEKzByRjZ3UFdKUk1uaEFrTFhoMGJqQ1VxcnlLYTZYYUpPdVFuOThF?=
 =?utf-8?B?QkUrVDZJUTdCMDJoTmxOMFpqRmNjVjdwdmFCTUlyd2kzc0tONUhXWTdEbXRF?=
 =?utf-8?B?VFRZbkZJSiszZklYSUM3bzk1SGViRzRiQTIvZ0hKYVQ3RFVOZlR3eis1NlRE?=
 =?utf-8?B?TzdQandRaWd1VzJFd0tzSkZ5Y0ZMclJOMnQ2OXVXSDJXT2M3aEtwaDVWQjY0?=
 =?utf-8?B?ajk0L1dGWUpjQkRNZFc5RzZuMm1qeXNObkUzNCt4UjVtcFVBNjNNSFFNTzV6?=
 =?utf-8?B?S3ppaXdTWit2U011SXJMYkV4L3BSUVh4aFVqSU9MUU5ScG5qSnZpWE4vTkt1?=
 =?utf-8?B?Q0FpempOcmtFZ01DQ1RlUmpVV0dqbXFLSEJ4T1FMK2JFSGZVelhnSDF1S2Vp?=
 =?utf-8?B?N1M5cFoySFAvVXpGNFladGlJRzdQQWxuN3NWR3F5WVdYbisydVZuc25ONUlR?=
 =?utf-8?B?QVZtWU1IOTY2R1RLb0poMU90NnZqUURFS2w4WHJwR25MOVJHeUl3b2Q1TTlk?=
 =?utf-8?B?SXE4dWY0enJuYVh2MTR3NDh5ZlFMMFJvTlNPRytjTWg0RmlUU0dJcEk3bUM2?=
 =?utf-8?B?WTJwUXRFZ3NjcUVyOTFRN3B1VXB2a3ZMQlo4NTVvckd6U0cxYmtPdlBiaGxu?=
 =?utf-8?B?cXQrbkJaU2QxcnBYVExwaXY3T3Z1c1BrbEpMZXZncm1kZEJpcmpGWlpaMUZE?=
 =?utf-8?B?cGsxcGE4TklITkE0Q0V5bDlJZFRoNHV1eDdBTGF1cW90WWUySlBvdHE1WVlq?=
 =?utf-8?B?L0Mzc1FaSTBmRTR2bXN4aFF0Rm1FTmRBYWtBbSt5WkxkV2pSK2lJMTZQamNT?=
 =?utf-8?B?T2ovdEtTR1hYZ1Z0b2M4ZnhnSTlRY3NNeWZCeWF5K0l0MDFpTUVpL2Vvd2t0?=
 =?utf-8?B?VjYzYnpBa0FwTkJhVktnQUtuYXE5KzVvUEorUUxxSDE4R2tqSjJZUFk3Ymw1?=
 =?utf-8?B?SmF2RHNLcUx0SklFY3pSalRHT0xFQWRNeUM4U1hFeHJjeWVmZjlUSE5BS1hw?=
 =?utf-8?B?Vnk4R3NSOGg3ZEc5WUIvdnVtTzV0SGxwUUFzYWtCOGRMeDJ2YmhYRk5hcEZu?=
 =?utf-8?B?ZEV6MmFoUysrVWNjd2RkL3NKdkN1cTZPVjl1Zm1oMmVURWtwM3FNUVI5YWQw?=
 =?utf-8?B?TEthMElJNVFEeklvRlczMExJaTBrUFNuelFBY2hUeHprV0x5VHpwWGh6NXlL?=
 =?utf-8?B?UU9YdE9DVUducmJ4OEhIMzJwRnl5M2M2aExSVUhPbFdjbUp6TTNpSjMrWmlu?=
 =?utf-8?B?M25IRTgvQ0FnQzNzaXYyVDdVaW4xaDJvWDhrUUNTSW9OZzAzNEd5SHllTU9N?=
 =?utf-8?B?dXM0ZzZSRHNyZmhPa1FONnhJL2lmRW9CS0VyRmVOL2lnT1JRQXlrSE1rcng4?=
 =?utf-8?B?VDV0VkdMaFJacDNiOFVueDN1Zy9ZTEFrYWVsL0V4SFovNjRkVXNKTkNpSHky?=
 =?utf-8?B?eWtuSGJKUjhneUwybVpIUU10S21HdGhEWUdkeEcrSTB3UUliVkFOamREejha?=
 =?utf-8?Q?wsxEW2NknA1zjqorE/JTUL7ar?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0854809d-ef00-462c-f895-08dc958d6b10
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 03:09:40.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erX/7Gs5Cu+mY8mVIfDCWcPEE7LqAIf4ykMfRTX0TYuKVSXYAlNwCPnkH2BykkzE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950

--b5312e7e7a1599e3635d211094ec59b259802efc5434ecf734fd1469613c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Constify folio_order()/folio_test_pmd_mappable().
> No functional changes, just a preparation for the next patch.

What warning/error are you seeing when you just apply patch 2? I wonder why=
 it
did not show up in other places. Thanks.

>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  include/linux/huge_mm.h | 2 +-
>  include/linux/mm.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2aa986a5cd1b..8d66e4eaa1bc 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -377,7 +377,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *=
pud,
>   * folio_test_pmd_mappable - Can we map this folio with a PMD?
>   * @folio: The folio to test
>   */
> -static inline bool folio_test_pmd_mappable(struct folio *folio)
> +static inline bool folio_test_pmd_mappable(const struct folio *folio)
>  {
>  	return folio_order(folio) >=3D HPAGE_PMD_ORDER;
>  }
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9a5652c5fadd..b1c11371a2a3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1105,7 +1105,7 @@ static inline unsigned int compound_order(struct pa=
ge *page)
>   *
>   * Return: The order of the folio.
>   */
> -static inline unsigned int folio_order(struct folio *folio)
> +static inline unsigned int folio_order(const struct folio *folio)
>  {
>  	if (!folio_test_large(folio))
>  		return 0;




--=20
Best Regards,
Yan, Zi


--b5312e7e7a1599e3635d211094ec59b259802efc5434ecf734fd1469613c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ7hnMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU2x0P+wStfyvgeWsksehBZhObBhRtiU3r4C5QAWMP
wdbFaXaE5a4JT3PkQaV7dN900Iz3/39aDjCuKJf+K8edx3aYzHIZxahJ0LGfQVBq
RNVLWSXokmuUNuY9LenX4So94qQLBJcvNRQz10vL52mmwtOUF/Wp0fMS70YXgU/X
UE4EpVB00QM8bF1rbdHPqH3zGZwkh4/8kYd5Xx20vRyBo6UtYQC/Hrc2lRFZmxPn
AQhY8NSeGX9aFGMjsG/+Bn58bAvo9RczZWChwkEwptoOEP2Ky5zVZyIEh/MqVEV9
qx3fX8lICm4EXdnMZaNcsQzJ95T3QXujLraGwtewb/uTsShoMd0/IgLlhlV50ZpX
fzs5qneeCX+bnJYlN+Mct6+P+OCeSEbbcFegHd/OUsDg/tb/7rMoKudZd9ZlMQgd
rlPTSa2DLsHWoHJTYsYheLY04XGoi+ZgZ9dJKmg3/K9yLPqDjgUZHfG0+qajz9nD
ZE8khpMDxDE75K2a+ADT5yQkMfYbbTS1iQH/iHOpDJGUZAX5zHP7+4S+iPIhxxxd
3I7KwrxkkuqyVQk1mZd2cJAlT0BtBhTfONqZYPPYV1UTq5O4tFsk3hA0XvUed8jh
Zq1Y8N0geIFG/bStKR3Zb2SjdWgSgPHTLp/pgF1wxfGHjO75a0GSdAiD/cG8aH91
VdtGhagQ
=4odc
-----END PGP SIGNATURE-----

--b5312e7e7a1599e3635d211094ec59b259802efc5434ecf734fd1469613c--

