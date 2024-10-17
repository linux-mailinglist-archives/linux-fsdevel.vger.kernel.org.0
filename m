Return-Path: <linux-fsdevel+bounces-32245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099309A2B18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B0F1C21E52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822C41DFD92;
	Thu, 17 Oct 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T/RXy99d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8681DC07D;
	Thu, 17 Oct 2024 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186632; cv=fail; b=GeRlooQR3uqVEHuQrKEIqp2vIWO4nurSfgtiD3qVy7ghg1NpLw7Rjg4C4nLnwEjLLky4t7ixUhvuJalAFvKs3G3rbl4narvsOv4rvXxns9stl/fpU5CWVVwT4mctvRFevTudGSb24Q5CwHjVue+jDTKFrnSIzHuu/MJoJS4XWGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186632; c=relaxed/simple;
	bh=mH7XBTLllSJJiA/v2feUd99WJcNgxQPmiV9ozQUTb1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HQJyVPM1Z6S6pangq+BwNTgFqenbTLI9mQ64B0uHWsnnty250hN6IXpQt1TvZPokmKlUC1BP+AsOhH5wojkQa0miGCQvRDG2hjJotnkQgc0XfNDtAr+u6TsiR6IVEpBQ4l5XGEheC8YGAkYGPxgTc1cvh7zpLGRGH6QM8MzNBKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T/RXy99d; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NShmYzFYX7gxiaHJYZkwHau7yQat4rdG8HW6NQ93FMJGE0zruNiUdPvOUeeOcGHNUSCfyKmwLtK9QJ198eFEbh37/i7VhWIUYxHmhm9r2/px8Pdjmb+YUDZZGDKSKeePorTq+sThnw/Ce5PoqxgBREZ/xq7UIpizx/dF6leCb13UnzU8S5N7/t51JpZPNN05vKhJhb/reVUwPQhpESu7Ol4grWtksUb1PIt/AYnS11zdyhnu+IG9qQ6FnrpaTSNTL3dHIiZBHLxpE5ZHipOR4KRFz5Aaa0i3xGn3F34WrHfJc05vQ1d8y56g/LevieUB5PGInwulbucjJA7LZ3x78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju3dckONUjofCedQEvcgaW43hnWQQhZqVm31/WlnKmg=;
 b=FhwBY8Q8MO7/TT/YAHOZx9p76CzMSwKJxULy1vO2v+a8xhdy6CU2BklvtdXg+ijMcoRV6C09wF6O6FayUJ/MTHpOtyEQ6Ol2KcpoJhPSfZJKqYnXc9i4SjQrkTHdAwk3kenvavN3To/m5w18sjitBlq+wU3zywCia6lXnXL8y43mi6bgOw61/k9HC/9ZnLFQzKj+cXgvcHAFpLU7x1iElNVyAjy9IXxDCvqruSFKAfsvP3Y+rHVswLJ+n0JS+WRsA+3gTraeobv/pIC7e/moU7xlvP8wkEo5LDRqQQrXa/u2FuIuY3wcBH8REsaVPB8EBraxQ5Iq+qbm7REgKKFyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju3dckONUjofCedQEvcgaW43hnWQQhZqVm31/WlnKmg=;
 b=T/RXy99dmHvzIZYf5Lp7o15tCf/K489CdvusXh3EAsGwQFjxzONQX9QSvEbMAphukPK61zcm7TNh5P8BfT808LLvxA7co7k/Fw59ou9+HMqUmwsPawGj1ZD1j/yoq0D21yV/s5+1v2L6ol27/Vcdfumxr0O3Ds06oTyDyaYSdLf3WTP5V96WHmGtZ/aOU9rTbW4RwXHSwHtVXNYRiBLzMS3yfMYiYh8QDLC+cvQkiL1P3ICDv7vAGVNHcoBtFLOi3wYbYGNavi89LoXIbFW//KkctjdHTA0Fv+XLqHQOqsZ648ePybwEme8pvjmGYcTSbuXDBIQPieYv2rVxJHJpEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 17:37:05 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 17:37:02 +0000
Message-ID: <79f70ce6-f2ad-4fa6-90b9-6a0a936669e5@nvidia.com>
Date: Thu, 17 Oct 2024 10:37:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
 <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
 <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
 <97b6a4ea-d53a-47f1-8e64-5b9558f194c1@nvidia.com>
 <28184c3d-3c88-4f8a-a25d-7b5268b55c93@lucifer.local>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <28184c3d-3c88-4f8a-a25d-7b5268b55c93@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: e28277fc-4023-4a35-436d-08dceed24f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnRWZS9GaDVUY2MvNTFqY1krUlhSNEw5Y2JCcjhXRDcxdlhKdG9PK29sZlhX?=
 =?utf-8?B?QXQ0cFA0MVl5UlhpQWhJZzY4WWFPK3ZnTmV4NUp5UHFEYUNic1RZdVhrcmkx?=
 =?utf-8?B?amZwY2xTR0xvcHV6a1dBTnJNaFRhMkpzZG5sdXQ1UHRGQXFGNldYcFBsZUgv?=
 =?utf-8?B?WEpkNU9ZalFuUCtHalIvV05CVk9Jc01rKzB5Tkd0d2ZLNm9SWmhrdjVyRGh3?=
 =?utf-8?B?NEpnRUJCTmUydXptMDZhRk9aRDVpZnJDZTRza0kvYm1Ob01vQ2duTHNieUlr?=
 =?utf-8?B?c2YyNHZLSmYrNmZCYUsrbFBLY3V0WWwxdkRUNFh5b1hLRWZJb0s3MncrcmRT?=
 =?utf-8?B?YkgxZ2xOVWdsdXJIaWFuZUkwRjM2YUtFT3Q3NEF5Q2FDVEE4UGtIMXVyMTRI?=
 =?utf-8?B?QUdSQ3Z0VGlLdS95SmV1TVhyV3NHUmowSGlBR1Z6K3dxVlRYWGY3eEpPVDVN?=
 =?utf-8?B?OHRjbXIrMm5qd0dvVHpZZkxzUmxrUjhkV2ZqMk4wSmxjaEhsOUh5bHRnNWZQ?=
 =?utf-8?B?b1d0M2diVG5LeXJHWU9DVFZqeUhObWlXY3ArM0d6RGtTU3MxRmplR0wyb3JD?=
 =?utf-8?B?cWZvS1U4VGRXQjJpRnZDeWR3S0VCQXBxaXhWUFZLSG1rUE1ZOGtNMC9XQmNU?=
 =?utf-8?B?WjFNRkNJZS93amRVamZ6Nm0xS1RJYjNtVXhJaW85RElmRjBWeVdKSmpsVDN3?=
 =?utf-8?B?d2VuNFU4WXNIeFRUYkdqbjVkM2xNWGc3ZkVmWHh4UFVLc2ZGTkVJekx4YW1V?=
 =?utf-8?B?clA0TG40MWwvaFNHUHB3N1hDcVhRRDZmK1MzWWlJNTZtT3JteWVPZFUzTENh?=
 =?utf-8?B?YW9SV0RSeVRwTjZpc0pnT2dMbVh3WlRQZnJDUWZRNEdJeVM4ZUZDMkpZeVVk?=
 =?utf-8?B?UjZJVTZnS3VoM0MrK2VwSjlzRWVTYnhOWWxxUTVzRnp3L1QrbFdhM3grYTFl?=
 =?utf-8?B?dFdaQlNzQW9USEZjRkg2ZHNhbk5kaHNsamJOTWY4VUR0WjFUWkpaeWR6MXBG?=
 =?utf-8?B?Q2pibmJZcW5Db0EzNlJHN3pDUzJiYkhWaXV1bnYreDJOVCs3V0pFc1VKVHBt?=
 =?utf-8?B?K3BPSFhGRXFpaUVVR1JmaW1Xd2twSHVHMm5GTlNDOUhVbzVKdVg0ZHpIazRQ?=
 =?utf-8?B?aW1hY1RYYkJFVEdCRmZEN2RNSWdZZ2hoNWZoMXFabTJ2TFZRTzlvUTN5V3BM?=
 =?utf-8?B?MFZrNEt6WndMaDFHdWFZYWxTMHZ6QmtERDVidWQ4ZjhpWGxXOFdhdmxuYStW?=
 =?utf-8?B?aTR5Ukxvekl3dk9TeDRNMTQvZlR5U2QrUDNLRFU3OS9FMlQvL3p6b1l5R0Qy?=
 =?utf-8?B?Q2Q2QkpoU1ZPbVZmM1lodnVBM25XMzJXeTVOTFJrV0FsYlN6V2JuUExrZk5y?=
 =?utf-8?B?MmU2MHd6dU9vcldZbU55OGtxUHNjK01SUC9hTkRsL3lyWUJodnFhdVNOWFpN?=
 =?utf-8?B?aklKbkhaWTE2Q3ozVW1CdVBoNUtLMWhpaVkzc3ZnQmRETkVpTHZROGV4R1hL?=
 =?utf-8?B?UlRrWUd3RjdWK1lHVFJpaWNuNHdibE55WFVnaHlyYkw0U092K2pJVkRVZ1pk?=
 =?utf-8?B?QzlSMzlQNjJ2ZEQvNzhpWXNWTmZabjAwY3RUdXBuMlRJTnhLb09SM0hGRlRF?=
 =?utf-8?B?YXVOMGsxN2ZMUUYrc2NCdXpjVGt4d0p0ZnpRVk1sMEZGSFJNRzBNcmd2aUoz?=
 =?utf-8?B?a0Nva29xTkgzWisyMzhhbW9ob0QvdDFuR0VTamxFNEdMajdRQ2hmUmkzMVhP?=
 =?utf-8?Q?qchpPRO5X+WfCGnzU3rQNNrOQG0hwPqbSjiWFl1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzBnSUVOSG42eG5CK2RRSlhYcmNORFZhZHEyMno4VTZYLzlCa3FIYlBIWjgy?=
 =?utf-8?B?V2V2bkhYNEdyam9zZHJVSlBBU1VabVc1NkF6MEszamVBdUdEaE5VZ1oyOEZW?=
 =?utf-8?B?ejdMY2h2d3BtMC9DbWtsUkw1RGQzUlcwVHh5cGZaWjQ1UDJiTUZxeVZpRWx0?=
 =?utf-8?B?bzZZUWx2RS9lcXAzR1Q2WXFzNGNDY1pXQjJRcG5MWklHL2VNcnFUbUN0aHdF?=
 =?utf-8?B?V2VKeDFaMUxYQ01YSUhGU1hQZ2NqcFNaa0E1OGZ0djFmZ2VaZ3hEZVIwbEs1?=
 =?utf-8?B?bnFJRzFIUE0zV3FaL0ZSejJuaXRhd09iWERsekxKaVZUbVBnbnZCV2FjNjdG?=
 =?utf-8?B?cnR1Q1graWM2SnIwSUtJbGxCNWN1UFFNUXcwenlrSFZUWTFtSDBrOUVVU25C?=
 =?utf-8?B?MHdMcEtWcFVZM0pvTWJaY1EydHRTTUpkR0pRbS9GNzRCVjZvcXJ1aGJ6bVNv?=
 =?utf-8?B?UmxkRmdDbWVwN25UMHNVdUE0Y0dIUmlsTVpvTWtDSjZQQWZBQmZCSDFWK1Jn?=
 =?utf-8?B?NXJVZi9EV0x6cDlzejFxMDNEckZmS3p5SlpSdzZCWC9aY2o0MDBjWXFKaEN2?=
 =?utf-8?B?SXRIdXpGZ3JnSDV1Wm16eE1zNUhlZmJvcm5aOUpHeVBxZEpveldwcDVKa2tO?=
 =?utf-8?B?TGpwRTdwTUU3aTlPMGxmWVExQmJHazM3UmV0aW9YZm4xeFQybitabVV3SFpQ?=
 =?utf-8?B?WVB5WmI3ZThyaEFXYnowajVOUXNTdlZpemhTbWhPSFN4R1F5QlVRckk0YXA0?=
 =?utf-8?B?OEJJZnppamdob1pjTzlQYWNibUd6ZWJXTzB1aUZZTTBtMWNUQm40Q1dIUHBJ?=
 =?utf-8?B?eTlRTUlMbWJnZFRWOFVZU0JNa01hWlQzY05xOHc1NVFWdjRyVkhEYktjajYv?=
 =?utf-8?B?MXdCRlN5eUY2YVExK3c1NDdHMlFEdFpBa1FLZkN3TTAwSzR6VnRmV0dPQ0ZP?=
 =?utf-8?B?OWlXRVh2Z2tHaGJZZUxacDJHQU9OWGJDN3V4NkZveXh3UDk0b1M1UHBpalBG?=
 =?utf-8?B?enVqOWUwdCtYbjhJS3VmRmdRUytlMVhZbDBvUE1SMHc1RVVlQ2o0R04wempL?=
 =?utf-8?B?Q1pOZGY4Nm1ZYklOWVZzR1A2aElpMyt2L3dNaGxDT0lTMXNqSXl4eE1jMVRM?=
 =?utf-8?B?dUg5dmJucVNUSVo5dzRlY0kvSW15SHJQQm0rb09sMENQQjZFT3JWVjBWYjJI?=
 =?utf-8?B?NWZXRi9QM29POVM5Q1poeVNNMkV1UUNPTUhxdG1sYm8xMUJVTnNGdlZ1eCtz?=
 =?utf-8?B?eDcvd2lvUlJOTk9veFRRVlhaR01PRlRCdXlFOThGbmlUNk85MVFWSnFxT3lV?=
 =?utf-8?B?QzRteTVkMkVzZGdOd1AzTXdXNVB2TTR6Qjk0VTlHSFJRbW50Q2djRjB1bkxM?=
 =?utf-8?B?VlFJTUhoL3E1bmpCWWZlc0VvZmhHLzlIMHcrYldpU3E2ZThlajdhNktnbnkv?=
 =?utf-8?B?VnRsQ0tGQTVMbytNUnY3Z3Y2SHVwQ1VhS0hQTmc4bkEzVkFBdjFhUmpsdFFG?=
 =?utf-8?B?TTczUk1JalpDUUJTRkdPc1dFVEVmcGROLzB2dnFHTy9sdHNQbXhYWVcvN2l0?=
 =?utf-8?B?V0NjanY0cnl3MVJ1aGExNk16bzBEbE1yRlE5cGIxQTVOd3h3aS9hdVlBM0RH?=
 =?utf-8?B?cGV4TVV3aEFwMXJvSk9KTVJ6UGVnd0pTZWZpWURNUDRuVU5ncXgrd0wvOGwr?=
 =?utf-8?B?d1ZHSExPNEU3OXg2Ty9QQ1Y2N1BUT2t0WkVEWmZWRHJmWHYxZFprQk5vMlRQ?=
 =?utf-8?B?UHEzSGhqNC9oODVaSW5CbHJXKy84eHlQWnNOeUJOSktKc2QyNHFha0srcHhm?=
 =?utf-8?B?SXRUVHM0MjBaa0JOR2VEa2t2UDQxSkVBRll2S1BpbW5OanZJU3p2TnpOSnAr?=
 =?utf-8?B?UU43REw4NU1LZE0yb2tYNEF0bDZkWS9SUVRYNllOMFhiUHJua25lY3VxQk1D?=
 =?utf-8?B?WDVsRVFUN1B3WW1XM1I4ZDJ0aVpPeEw4YzV2TFFjdUlQV0ZaU0JVSVVUS3ZZ?=
 =?utf-8?B?KzNSbCt0YUk0cWZLRWpaN01LYmtUY1piNUZPSGoyN21PYzliWHlmYm9SMXow?=
 =?utf-8?B?bHd3RUF6NnhGa01hUUtDN25LOURLMTZrUUJSZm9GNC94NDJ1K2pjVzNVcWNJ?=
 =?utf-8?B?WE9mZG5GekJueUdPeTRaTldyS3JQUU80aXJZSW9Dd0lVQzNBMHlOb0UvQ3pk?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28277fc-4023-4a35-436d-08dceed24f38
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:37:02.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0cCfIiarzpdwM5wiRcwmARG8Aj7VdxIpqydPI6uEsS5oTZFfrTTRXcqs1Jo48m96zPdRNt5EjzqK/ZqMw0uXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671

On 10/17/24 10:28 AM, Lorenzo Stoakes wrote:
> On Thu, Oct 17, 2024 at 10:17:54AM -0700, John Hubbard wrote:
>> On 10/17/24 5:06 AM, Lorenzo Stoakes wrote:
...
>>> 	#ifndef __TOOLS_LINUX_PIDFD_H
>>> 	#define __TOOLS_LINUX_PIDFD_H
>>>
>>> 	/*
>>> 	 * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
>>> 	 * work around this by setting the header guard.
>>> 	 */
>>> 	#define _LINUX_FCNTL_H
>>> 	#include "../../../include/uapi/linux/pidfd.h"
>>> 	#undef _LINUX_FCNTL_H
>>>
>>> 	#endif /* __TOOLS_LINUX_PIDFD_H */
>>>
>>>
>>> Then the test code needs only to update the pidfd.h file to #include
>>> <linux/pidfd.h> and add a simple $(TOOLS_INCLUDES) to the CFLAGS += line in
>>> the pidfd self tests Makefile and we should be all good.
>>
>> Yes.
>>
>>>
>>> That way we always import everything in this header correctly, we directly
>>> document this issue, we include the header as you would in userland and we
>>> should cover off all the issues?
>>
>> Very nice!
> 
> Thanks!
> 
> I saw from your other thread the idea was to take snapshots and to run scripts
> to compare etc. but I suppose putting this into the known-stub directory

Actually, I'm not running scripts, because the only time things need to
change is when new selftests require a new include, or when something
changes that selftests depend on.

> tools/include/linux rather than tools/include/uapi/linux would avoid a conflict
> here.

This is the first time I've actually looked at tools/include/linux. That
sounds about right, though.

> 
> Or would you say the wrapper should regardless be in the uapi/linux directory?
> 

No, not if there is already a better location, as you pointed out.


thanks,
-- 
John Hubbard


