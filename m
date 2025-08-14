Return-Path: <linux-fsdevel+bounces-57912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF9B26AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AED603892
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551D21B1AA;
	Thu, 14 Aug 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uLQvOu30"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015EE21256D;
	Thu, 14 Aug 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184503; cv=fail; b=RHLc0EPWHPcZWhRvYgU/spxCTkVCPZ/zsUG0j4vMKVdxCbgPgj38gmulTkZYxv/4FM/p+ipSVBWDmuNa82+DrKNX3TOAavUADKf67/T7+C49y8scPmpuwgjco8X/OZXtcRoZ7K+ycQ9TbVWapQf5OdTINrJWctxBoNCTdp/nq0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184503; c=relaxed/simple;
	bh=MYQmK9TH9tEu5N7mvo8Yqi0lhKT335Q2WPMx57mCh8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPfaRhPiMXwOxBg98C7baQkPojNdlKvzPwUoqBkgeYNPQLqfXnz8b4kAsdCNiNs58BxuDHfCtiGPAb+MoSu8jORZgo+ZYyMWtGsYWIo5SMfADbJCXLkj4bbaocsHlm5sotVieGsNlua4KqqdYK80Wqsrkk5rITFeBo9kI/CnVz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uLQvOu30; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4kGRUoNuKfkkpQKssXF8F3jv+YityuLHicsnk993mraLlWCQtLCoYXEUxAdTlvKvIUTKR+qT8ZclKkRtWSglxyP+hrhe2oXQNl2vCaRHG/6HERTmE2YgrHGfBaSiC7MVDVDJQOgnXiUnRIf5VN6jqtgxS5DcQdNwarofHHzw+ArjsxO3F3JbodgFuMt9fYUhA8ntT401n25ivPfoT20K9e7V+4wboWDz31Mru61OC39jvqhYP5qyHHAyaF/KT5K2X2XDKCflXUdBUZdKOXCTi/fU43M6RqznoRubhgDbTPStEtdHyLtRQ1Aso+4ZLsvspeQQzjSmDAwZzTbw5e7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t6KslPj3SAtsgptsUnrxpGW4FenpxFpxGwUINluNNs=;
 b=nCmElgISKEj9PdTGpUYXHQHM1UKzjxhOcn3ehgsohTH4RpJhDjLZo7iHp9Cb96H7bmoMIKqZ9ReOeP/6LAnAOHEzke3ce/F+Heox0mjT2HIyVfAi7jm53HvgEWwF7TSs8VhF9Myi8AUmOaWWc0vBtV+ZzR33I5M0MZtFP5sKt1Us8lytte7uBEn90EeWBpWOQYYvYytIFU0tpbNGbyhhXIdq5cRTprajoxQNnrvj8jjOUW8eRSm6Bnj0cGGJ+4FSmMSQ7LvK2orKMXlWfzqNdR2ghGSJqLRyK6CzFIns12IVrZno8XezWNPNvgd2OW5ZWgOLtbToCQXxjYZX6aFlvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t6KslPj3SAtsgptsUnrxpGW4FenpxFpxGwUINluNNs=;
 b=uLQvOu30pLKBkn3L+9B6LrUBGhsBN3zIA7u1MZ+x7Wh6U54sufoI59X6Mk33O7BVP5oaooAgbVpl2osa/LA9a48atqEyoHxUi8YPhH8Y4AF2sx1ffQp4YRUONSDnDGwh2Q76qmSgcQbinTNRpCGN06695lpi33Xc71QyTB6lQpVbWmE7ZuFrFewjmhBF9yDvDvdsJF+cjMaAaF8Oa1vsAiibTQg17PQ8fCZIXXjUzPMHYCk6FWCU5FVwsCkBSBHKhAMm2jbQSnWhMv9gjw8AvZSuvFl/HIxgbuICewZl5fXJrG9f7Sno8s7fOZL8nLzrxjVYqfYfvPc2/0z62feDPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.16; Thu, 14 Aug 2025 15:14:55 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 15:14:55 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 3/7] mm/huge_memory: respect MADV_COLLAPSE with
 PR_THP_DISABLE_EXCEPT_ADVISED
Date: Thu, 14 Aug 2025 11:14:51 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <365027D2-9BB3-439A-9080-2684E1795B7F@nvidia.com>
In-Reply-To: <20250813135642.1986480-4-usamaarif642@gmail.com>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-4-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:36e::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: f100202c-baa7-4fa2-07ec-08dddb45532e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RllHcndMQmtnaU9FMGd0VC8vdUhWelFqaGRUQVBYdkkxTlpGWW5PcmRLQTYy?=
 =?utf-8?B?ak1weW11aldzQlFMQlo4c0lrWmV2THpUSUR2U243SEFyQ0tuVVl3VC9Mdkl4?=
 =?utf-8?B?NWhTQmJtTUNEa3RkdmxJZFZPMDQzb1pveVdsWXBRMTVHTEMyL045U1QrYXdq?=
 =?utf-8?B?RloxSnFLbjBwbEcyRW95NWJZeGRPUGhEdlBGSFIwcEgvSWwxbjA0Y0dzcGFM?=
 =?utf-8?B?UXlVaEtkbHhOQWltNktYaW9KKzlHMmRDSGpYMzNnS1UwUXdKMzhMaGs2Rlpw?=
 =?utf-8?B?Y2U3TmRYQVRCMGdLOTh2MXFyaFp6emRpOEhyUmFndm9wMFpFb2I1RmVlanZP?=
 =?utf-8?B?dVF4WEVIWlZVZXlJUERZa1I3NElXWXZLZ2xRNVQrUExqODhJYWVnNnpKTWRO?=
 =?utf-8?B?SUJKRisvSUNadURYcjZId0ZtK1QrM0ZhYi9wLzY1bGw5L0NRclRCaDhmNDVB?=
 =?utf-8?B?Y25vNUhFeW1hbTdmR3R0UDhnMjBDNm9JSUJUSFdLVHE0OVVSYTBkUElnY2ts?=
 =?utf-8?B?MHdUNVl5QkZVVGlWLytlQnA0d1F4VUdkb3kySHpCWGZxZHNROEdWWnBFYW9O?=
 =?utf-8?B?MmhicUxGUUxjYnB0ZEdDa0liWEdUSFlVdVE3KzNmT0ZkSENod1AyWW85dWY0?=
 =?utf-8?B?Vy9ETlJSN3hoSEpmeXMwZ0JIMy80MFFqTzhCd1h5djBIZExzcklJOEkrMUR6?=
 =?utf-8?B?V3lMSDFCN3VvVXZDbTlXUnFnNXpyYmpOd1BubE5QNkJmckxrTWZIbDFySGNp?=
 =?utf-8?B?K3grK1lPZWF1R2ppbnpINCs3cjNWYzErVjVRSDRkUHp5SFJmUE1qRlRjTzZr?=
 =?utf-8?B?ZGdnbmtUNUh1ZjBDQnVqMGpOZHNnZ1I0OWVKWVNrbGlsQ3VOWXFnTkxCbXdy?=
 =?utf-8?B?S2ZvMzUzemZPWXVLNkplTWJrNUloQkt4dkxVU0Q2NDdqb09aSEViOEtRUXI4?=
 =?utf-8?B?cXVGZE9MYW8xWmd4Vm9PMzA5VmkrcFpUcmlic3FNZHZPSGlNUHdmQ1pwaFhW?=
 =?utf-8?B?VTJYOEw4OXBqcC93dUVtZnB2RlhqcDBrY24yenAwYWQydFFvUlE1NXN0NnlE?=
 =?utf-8?B?MlRXWDJ5VDRTYUNVL2NzSUxiQUdOTlRZVHNSSkJua3NpUEhHeE5LMHphaW14?=
 =?utf-8?B?WTdoQzdtNXVmZjFTNlZiU3hxbFptaDNadGpKdTR4K1dQaEQzMXo0V0M5dVo2?=
 =?utf-8?B?THluSUJLUVNZemN0Y2IxZ1NxYkRHTXM3a3pzOWluVUNmbzZJbThMc3AzSmkv?=
 =?utf-8?B?RWg2UEw4dFduMVIybUtSOXlkS3E4V1FkTG04ZjJoOFUvWm9oKzZxYkFxZVU0?=
 =?utf-8?B?QnI0a3hxeDFLUHJCYTZURFY1SUx1L1B5N2t3dXBBb290Z0RSQkYxMytJdGFn?=
 =?utf-8?B?dms1M2VabU1XbDg5d2JtclhRSCttZUNxMUFWeWlnY2haODdqYTBZQiszZXh6?=
 =?utf-8?B?eU9MdlpWdVdjRFBkdi85UU1YMlBwNG1EbjNjVTVCaEFJMDA4UjFTczFCa1Zp?=
 =?utf-8?B?RTFtd3FmbXQydzNpeXBINmFwa1pJTUpwSFBhNkR5TTM2dU1Xb2tkQi9qWEFY?=
 =?utf-8?B?TWVYRk1ZSWlWNWVtT1VIUXFEL1dsQmhGZW04Nk5UcGIvL1FNbnJNODZXQ0NZ?=
 =?utf-8?B?Wlh2dGhFZ3hLNHZMVVVMdnFsaFF6bkQ5MkpQTGcraHR5dlZMWlVaaVoxRU1R?=
 =?utf-8?B?MjRIOWdEaEREMjFkcVZjODRFTXBlNmRHaXdFdEYwaDVMc280NldXT251R3Y1?=
 =?utf-8?B?ZmF0N2k0UXIvRENJMzAybGtUWVpvZXdiTGQ1bWI3ZFdMTnptY0NzUEtWMGV4?=
 =?utf-8?B?RXdkdm1YcFduaVNQcCt1eHE4Tmg1OUVaUXlxUzVOUlVSOExKdGtCVExrdVYv?=
 =?utf-8?B?Mk1TQjZ5dDJScmFKaG1NOHFCbURVQ0RaNlBvczBsMVVXYUJMQ2VtNlg4cE03?=
 =?utf-8?Q?RPBOrHjibMA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Kzc0RUJWczM4T0hKWWJIZzB5emM3bEFXZkZQSzQ0MllyMEZrRVkwQXZnZWpr?=
 =?utf-8?B?aHBWa1NGQlYxWGpwWFZrOGNsRzlNS3E1d3liWHpRVU81U1BURUdLQWtnYVBl?=
 =?utf-8?B?dHNKVjNSRkJiUWl5VFFXMnF4MGNIUE00aDdsK25VVGk1ZXNKWHdxTWhYMzBx?=
 =?utf-8?B?MGVPTVVzbTNvSExESnhWSFc1R01RdlYwRTVzNmIyUUtjUUc4aFcxZXRsYjJ1?=
 =?utf-8?B?RytNNFF0NnFGK2h6dlY0b0ZUM093N3NLQlFLbjdQUnRyMElRZU9iTTE2amw2?=
 =?utf-8?B?NGU0QWRSSmZ0S1pxQ0swblJ4ZnpvclZXVUFWbld5K0xrRUJCbmh4QVRyN1hB?=
 =?utf-8?B?Ukdhbk10aldZOXlqckh1dEoxb2NGalRCNW9wQWh2bGFueUUwaXlqQXF1M24w?=
 =?utf-8?B?ckxyK0VINUtEWWNaYzN2enZINEFrTzZUT1hWYjk1T0FVTy9pdmpKM3N2eHA3?=
 =?utf-8?B?S0ZMMzFvOHlEc1BGMGJsNGZXS3h1MjMzMFNYOHQycUp5RForNmhkUVBDUUFK?=
 =?utf-8?B?b05HR0FERy9ZWHdXU1l4TXpZZXZ6SStGRFVVMzRtakk2N1kxOU1Pb1VzcGlv?=
 =?utf-8?B?YXE1YlVGU3VaT3djbVdQNFZhckU4ZnZnOE12K1hxdjJwQlpoSkkvWldteVNs?=
 =?utf-8?B?Mld0dUlXUGZWUmpHWER1Qm5aRHBUUU93SFhMUnhzV3NxekgyNEJsSEYvT0d3?=
 =?utf-8?B?L3hyWnRNM3BVSVVodmxSSHZRTnZ0U1ZxWnhlbHk4Ny96OEZsODVUVkxPMjZ2?=
 =?utf-8?B?bG9lV0pTU1BEQlVRdURDNTlOSTNMTStrV2V3Rzh4elZ1VDlZdFJkd01CTFZi?=
 =?utf-8?B?UStlZjZiVTVPSC9iSi8vSENiYWd1TlRqWGZ3a3B3SGpjZTBSczg4aHYwZlhx?=
 =?utf-8?B?bEdCVTRtWUlJS1dveVY5M3l3QkhUbXgreU9wdHNSMVM4OU5LcUtlRWxOVzFR?=
 =?utf-8?B?K0pleGxDWEVlY0JBNUNxVHlnYzNTWk9BOFZ0eHFXZEJLWjVOU1V5RkVWbzI2?=
 =?utf-8?B?VmdXeWxxcWVld3NYaTVWTWllWkI1bk1Jb1pNV2F0a3c1TzZWZ2NaSXQrRjh1?=
 =?utf-8?B?NENwS0F3Z2VKTFlrcXJJQ2ZrL3EvaFJKaU1ld0dicE9YdmxGdzdqOVliak1i?=
 =?utf-8?B?UUVRcXlIdVl1cGRaV1hPaGpkRjFyd01JdXlaWHRHcXpQZ1J5Um5RZm9nU1NP?=
 =?utf-8?B?bUNrODFFc0xJL1J3WmpheTMwUGF6bnVHaGtWZG5laEZNZW5BbUhJeUp5cDJI?=
 =?utf-8?B?VkhZT3JIYWNmNVFmZG5FUURKcnhRMWtQUkM5UVowMUU2SHBSYlMyVmhjZFVs?=
 =?utf-8?B?TnJpcXNMdEhBT1pHRUs0dlpvV3lKQitKQ2xVNkNreFVsb0VBU1JqN2pZbWN1?=
 =?utf-8?B?TU03dE1EOGtuemtsemhOYXFldENybnZpOGZ5U3BjUThPNmRqRndMMFpSSjll?=
 =?utf-8?B?eW1QSDZIZ3JobHlrbWloSzZUUVhVRnFna0RYc0N0VlhCU2ZzT3E0RGFiazQ5?=
 =?utf-8?B?OVVVK25pZUV6bktkL1E5bVlmOWxIVmVVZElMV2t0TTY2MHhoKzhaQTlmVlFm?=
 =?utf-8?B?QnNVQU0vOGdpdHBra3lUT1hTN3lMTnZ6NXV5OGZ5TTJaNVlqMVhSdUl2Vmc3?=
 =?utf-8?B?Y3NmcXFmYmxSVGpmMDlpQ1IrK1UxdHFYUFZxeS90VzM4dEhCbmkyQmkwNHlx?=
 =?utf-8?B?NHhIbjBuTWgxU0J2Mmxzb1VwU1kyYzlvMWpXQ3F5UEFGamRlaWVETUVISW5s?=
 =?utf-8?B?SXBzb2orUDYyZzlyK04zSWJ3TmpudmNweDNtYVYzVWs3YkZOa3ZueWt1bmUz?=
 =?utf-8?B?RGs2S1ZFelA3Mzh1R1BGbW8xZ25YTmppTGVQNDlST3ZuSTZ6MFk5UHFSK0hC?=
 =?utf-8?B?SkFtNDFUQnpUTEpjc21iMndhd3lIcS96NmlHODlZaVhLSENHNDlSUlBQMjd0?=
 =?utf-8?B?REY2M1c1ZE9IRlEwMkNFbXJRblc4M0o0Y3FEeWdxRDVDMXRqaWJOV00wakxa?=
 =?utf-8?B?elU5UXlpclB6Rko0eEl0YnhRRFM4MEM4THdSWTlsd0VGaUxIRWFCMDZXNkhr?=
 =?utf-8?B?emtab3M2WW54bWllYmpER2FPeVQra0dCSnJOalN4TmR6SUhJcjBIWWJPbUJB?=
 =?utf-8?Q?TnmmR1BpX72spWjbu6aZdyemL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f100202c-baa7-4fa2-07ec-08dddb45532e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:14:55.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3cLb+zaHJ0CDiYds/vtyhIQCP2iy0uOx08CTazAW12h1nTpanbv3NigUV9I3yr/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

On 13 Aug 2025, at 9:55, Usama Arif wrote:

> From: David Hildenbrand <david@redhat.com>
>
> Let's allow for making MADV_COLLAPSE succeed on areas that neither have
> VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
> unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).
>
> MADV_COLLAPSE is a clear advice that we want to collapse.
>
> Note that we still respect the VM_NOHUGEPAGE flag, just like
> MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
> refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED,
> including for shmem.
>
> Co-developed-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/huge_mm.h    | 8 +++++++-
>  include/uapi/linux/prctl.h | 2 +-
>  mm/huge_memory.c           | 5 +++--
>  mm/memory.c                | 6 ++++--
>  mm/shmem.c                 | 2 +-
>  5 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 92ea0b9771fae..1ac0d06fb3c1d 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -329,7 +329,7 @@ struct thpsize {
>   * through madvise or prctl.
>   */
>  static inline bool vma_thp_disabled(struct vm_area_struct *vma,
> -		vm_flags_t vm_flags)
> +		vm_flags_t vm_flags, bool forced_collapse)
>  {
>  	/* Are THPs disabled for this VMA? */
>  	if (vm_flags & VM_NOHUGEPAGE)
> @@ -343,6 +343,12 @@ static inline bool vma_thp_disabled(struct vm_area_s=
truct *vma,
>  	 */
>  	if (vm_flags & VM_HUGEPAGE)
>  		return false;
> +	/*
> +	 * Forcing a collapse (e.g., madv_collapse), is a clear advice to
> +	 * use THPs.
> +	 */
> +	if (forced_collapse)
> +		return false;
>  	return mm_flags_test(MMF_DISABLE_THP_EXCEPT_ADVISED, vma->vm_mm);
>  }
>
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 150b6deebfb1e..51c4e8c82b1e9 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -185,7 +185,7 @@ struct prctl_mm_map {
>  #define PR_SET_THP_DISABLE	41
>  /*
>   * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
> - * VM_HUGEPAGE).
> + * VM_HUGEPAGE, MADV_COLLAPSE).
>   */
>  # define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
>  #define PR_GET_THP_DISABLE	42
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9c716be949cbf..1eca2d543449c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -104,7 +104,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_ar=
ea_struct *vma,
>  {
>  	const bool smaps =3D type =3D=3D TVA_SMAPS;
>  	const bool in_pf =3D type =3D=3D TVA_PAGEFAULT;
> -	const bool enforce_sysfs =3D type !=3D TVA_FORCED_COLLAPSE;
> +	const bool forced_collapse =3D type =3D=3D TVA_FORCED_COLLAPSE;
> +	const bool enforce_sysfs =3D !forced_collapse;
>  	unsigned long supported_orders;
>
>  	/* Check the intersection of requested and supported orders. */
> @@ -122,7 +123,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_ar=
ea_struct *vma,
>  	if (!vma->vm_mm)		/* vdso */
>  		return 0;
>
> -	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, forced_coll=
apse))
>  		return 0;
>
>  	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
> diff --git a/mm/memory.c b/mm/memory.c
> index 7b1e8f137fa3f..e4f533655305a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5332,9 +5332,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct=
 folio *folio, struct page *pa
>  	 * It is too late to allocate a small folio, we already have a large
>  	 * folio in the pagecache: especially s390 KVM cannot tolerate any
>  	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse an=
y
> -	 * PMD mappings if THPs are disabled.
> +	 * PMD mappings if THPs are disabled. As we already have a THP ...
> +	 * behave as if we are forcing a collapse.

What does the =E2=80=9C...=E2=80=9D mean here?

Shouldn=E2=80=99t it be:

As we already have a THP,
behave as if we are forcing a collapse.

>  	 */
> -	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags,
> +						     /* forced_collapse=3D*/ true))
>  		return ret;
>
>  	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e2c76a30802b6..d945de3a7f0e7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1817,7 +1817,7 @@ unsigned long shmem_allowable_huge_orders(struct in=
ode *inode,
>  	vm_flags_t vm_flags =3D vma ? vma->vm_flags : 0;
>  	unsigned int global_orders;
>
> -	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
> +	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags, shm=
em_huge_force)))
>  		return 0;
>
>  	global_orders =3D shmem_huge_global_enabled(inode, index, write_end,
> --=20
> 2.47.3

Otherwise, LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi

