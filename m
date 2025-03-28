Return-Path: <linux-fsdevel+bounces-45181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B8A741A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 01:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBF0171653
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327F523CB;
	Fri, 28 Mar 2025 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bIX909An"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8F36B;
	Fri, 28 Mar 2025 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743120451; cv=fail; b=cqmb1VNrgOmfKI9w/TPbjtPe1WgvZhafQWVuY0q9hoRgnG3aOuby67oBaNe2SQCKyp/YP65QI7twHvUJoQ5kS6DcvX3je3BdkkOp7wmbf23ntA2SDN7mOb38PzoPD0yeOSHj1H+OH+P5pziWOmHpI7kCacRL2wXxyw85WCfozTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743120451; c=relaxed/simple;
	bh=My5uihLMw55Yb9MZdFha8SuODR0+LZ5MiYJMxj76OA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1NjisStiaCfLyCeUvZSOceL+Fn83Jz7hYLx74ifUpxBLC+Qja/PigwEhD+BngI/rj3jqASQqczVNgy3qvtdUW682/7/nAjhxYsbDesCqqn9KzzD7RHNF9RtA1Krl7PEuRpPc2L/BcxgxaxNzsnuud0jSmjmPP9EvOZAnXbHN+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bIX909An; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtFDVS/iFWlsNxqCbKq+77Ntt5fwnYJGS9oO32FpaZ52RgnHjEbk6c5NqRLnzatqo2AgvnEcWLkTzlTGHAdjMiNgMR3rKYZ8+rfvYllZt1yfJJmNZ1YDaoiFWcyhATAqOIqeawH/CW4EVCOPIulr1Z+zZC5woAI14M2lcGFxNaPBIjGrmv1c1qjQgXLqkxATBNUWlC0wHPsWpp7UlfIzWhsX7bhk8rtLwGJ3CgMYGhXZl8/qs8ADdOyMfx7KiUT7IyeBTcVzD/zcnXhik1QWdCnorEtZWe7OYhswxG7U2U66s5tCtprvf0Ke4nI4cuTVdJkWffdvpwfadQz8sWczgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tudb6pweeQeVX04DyanZXRWQDU/NVStQQPIl2hCS1a8=;
 b=vsxMtfiCK77O+7eBRNRM/IqIprtZ5A0DzJmmbnR5wx3jwO+5VM6gTAx48WvLdvr8Tus5xu9/XtNAR3Tgx5Q94TMYTe5iKByxbj0dNGRKQZBeGNCtN1Oex1+0QrVEGRiWjTzFEPDEhWo2ShvJfhvRsP9OQpLOxSVU6bttKvEQCGOp5tn80jBvMB9ih/2dFTuvPG4+fAh+NH6aehZj7sdr575umGONFgySa8SiQIBnuAvnKTW2g/Ood6DLTbNpoJHSlIGO0cIkdk6++iOVc8gPhbBc3VeEhshdDIBS253jTEmyIOnV1kN4w4GUGzw/g/+ZaiQhTtFJJU4N0sH4KU2ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tudb6pweeQeVX04DyanZXRWQDU/NVStQQPIl2hCS1a8=;
 b=bIX909AnvYeZB6iCNfQ8SQOP9UfRpf9dAeWbCoRtUDEVN2kv3rrc7zDxHzHnSJ64drawibduv1irnjCMBj+I+dcWaNijbzA7dvQxmkR9x0sIQN9KEPvxCz9bdBtBoEclkQbYf6Tqp1QEN7AR3fEIuddwK1dLeHG0JpP2tmoB7JnJvIfSDw01SH94smaYrYxHw59CEpfmR/t/PJLcuZcu9N++TqDrku0h5Z8oxt1nNqT5Gnvk4pclqxPmIMBZNG6nnnFUMdcVApVpcdcE0pIpRRAhGrSQNl05Z3AYPr2e+0j6FOSpIFVvcHzo7AiR1sF4UFtu1izGXDAFtYZTIhsESQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 00:07:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 00:07:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/filemap: Allow arch to request folio size for exec
 memory
Date: Thu, 27 Mar 2025 20:07:23 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <731D8D6E-52A0-4144-A2BB-7243BFACC92D@nvidia.com>
In-Reply-To: <Z-WAbWfZzG1GA-4n@casper.infradead.org>
References: <20250327160700.1147155-1-ryan.roberts@arm.com>
 <Z-WAbWfZzG1GA-4n@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0406.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: f09f0cbb-c977-4caf-61be-08dd6d8c85ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnVmYzdPcTVZNVViMXlWam5vZWxCbUQ4b1VMSXJrdHYxU3RvM0RmY1VHbXFt?=
 =?utf-8?B?NzVHME1DeGNpaW9aclNyUWtYVi9iWDRldVRkZTI1TlVBallmcXF0WDZ0ZjhV?=
 =?utf-8?B?bGhUTU80RkJIYUl6QlNwdVJ2Q2hoc2l2dXdoc0lRbG9JNXR5bkVkdHY4dDla?=
 =?utf-8?B?Tm96SjJqYytEeWY5elVVNThoM3JjY0dPb05TM1hwTytTTUdHUEVOWkttTmlC?=
 =?utf-8?B?MmJweTdRckRUS3J4WjRWdWc2Wm1pSWdlM0djbVB2L1NDbjVzZW9JMW9CNWdV?=
 =?utf-8?B?UmxCY3g3TW51RklaWVdoM1Q0U3o2ZmZXaVhWcW9PaktRSjZpNlVTSW00Skcv?=
 =?utf-8?B?SjBTeTB6b3ZnN3dxUDJoNE9TTFlMZFVHdi81SDkyYjlTeXNBN2NCSWlSc0Vs?=
 =?utf-8?B?QUhoVEZBQTlSNXJwUFdIN3lwR3paa1dhbk4wZ0lEVUh3K1E2d2ZsbGZJSTFE?=
 =?utf-8?B?Tis4TGw4UWw4UjQzOVB4ZGovaTQ0ZnYvOGxmUmVXUmg2VWJrdHJKS1NNbS9M?=
 =?utf-8?B?VjdzTU5MMWhLVzZMRVJmWVY4Yyt1enQ2WUZpUkQ0UEI2OHJzT1BzTGh5M3Vy?=
 =?utf-8?B?Wk5XYXF5R1hKMGJUdk1NWDd5akxSckordXVSb1pCR1U5clNtN2tFTi84eHBE?=
 =?utf-8?B?VlBRb0tUNHAvZmVBU21KREhTelEvVXgxQ3lvWHd5WnZmaHZaV08yTVlqWFdT?=
 =?utf-8?B?ckd6UWxIcWdsZ1oxV3hxUTVSZ1Y5bUQ0R0h2OHJUV1BEVGs4eXI3dFYvQU9H?=
 =?utf-8?B?QURTREpRVzg3eldzQkc4WEx3Wm41bEVtUVBxcERwb0V0MW9DQ0hLVjZOR3dq?=
 =?utf-8?B?cG50M1ZrTUthQnBPWjdyN2Y1RXN4bkI0MVJ6eE90MWlFa0xGUi9UVXFnaFNx?=
 =?utf-8?B?SGR3Q0Y1R3pWOStoSzZWK1Z6Mk5tZUN6RXE0VWFEY2JHbmVtZkpKaVo5aUhQ?=
 =?utf-8?B?Yzc5SW9QeVd5WkJ6OWRxYUVIWG1JVzcycVdCdmVmVkdnbWRJV3huV0tnU2RU?=
 =?utf-8?B?ejRBdmY3MGNYdklZUnk3UU1DK1c5KzI0b3dnYzBrNGZ1emRPTlM2eWt3Qi9Y?=
 =?utf-8?B?ekx0eUVBZExCRzRHTXlzOHVqZU1QN1ZFWkR1MmpjK3NvajYvZ0p5ajhUZkh5?=
 =?utf-8?B?UFZ0bFhycFJod3l4Y2ZGQ0pSeVJXSmFockwyVzZXS1llL1lxVTV5WENLVXlR?=
 =?utf-8?B?czRRZ2RXOUR4azdBbVJEN3Y1V0tpblpaSHl5aXZ3ZW9iaCsrWGpra1RVWlpv?=
 =?utf-8?B?MGFnZFZWWWFXaWk2b0lYeTlTR1BOTno4NDRpVDA2YlhhNnhZNk5IdDIzcFQw?=
 =?utf-8?B?OE1wSUI0RVN1dG0rL2cvUGRpdk12Y01xVTJzSHI5aVdNQWFXbzM0d25XVTdP?=
 =?utf-8?B?YStlRzRDNVVmUE81WktFL2IrQ2VETzl2V2t0ajNaM2VqQnJhOHk3eXEzblpD?=
 =?utf-8?B?SmhqVk11UjcwcW1aUUtlUzE5V3lPMlROaGVNbU1HWEVWRmREam5taUJmQnhz?=
 =?utf-8?B?SktLUFl6QitXYkt1TzBvdVpPQnRPRUZiTUFLSHR3cVZVNDRyaERMQVFXWkt3?=
 =?utf-8?B?NTY3MzZmS2JTT1gxbE9QY2tSQzF2c29tS3g5ME5GNnNjT0dHOVppVlVzaEgw?=
 =?utf-8?B?RVFwWlpqeXJKa0EzN0oxR2xJbFhjMTlYSDg1WHdFd09VcitMZjZIb29FQTNi?=
 =?utf-8?B?am9maWxWcS8rYVZDdHM5V01pdjlpZkV5blp4TXAvT3B4bktPVDd0bWU3Vkt6?=
 =?utf-8?B?bVI3SWp3QVg3bzV5SVpaQ05EMVBQZ3B5S2hXbkpEenJiTmF2SmNVRjJZV0VW?=
 =?utf-8?B?SHZSQWZhUmMrNmh3TXNFaHB1b2s2dGhyelhTem9uT0lhWGJkcDlJSmQ5akJO?=
 =?utf-8?Q?DFajrL3tlld1B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UCtPenpVNi9ybjh1TmxQT1pSYU1tWlRNQ3hlYjhWOTkwR05GTHNhT1ZRNGhK?=
 =?utf-8?B?YVVNc1RRR3lraTNhbGVZTmNCVUxXTTNodXZEWkZVVjFYaTg5MXRLVEtFOVJj?=
 =?utf-8?B?UTdxczZ5OVRjcUN3OTBPeWlNRG95ZG5PSWNVU3hWYmxpQjdWdEFhU3haSDZo?=
 =?utf-8?B?T2tqV0tvTmtLYkRIVmZLZURoeTgvRlFIZHQwZlBYVDZXbEt3OGsxUHJFaDd5?=
 =?utf-8?B?c0hyMGdzUWJVYnpxK2h5dXFMaGN1Mmx4cFlxWjBCb3E4bHlNenRsUS8zemJQ?=
 =?utf-8?B?MWJJQW11bnRRamxNWWtnOUdIUS96TnZDVHlBRTNpTUJ2ZG4rejBzU2JsaWht?=
 =?utf-8?B?Q3YxQTV5RzZ6dnZ0UUZCYVZXbGUxYVgyMS83cEUwdnZkK2NMa1pLcUZqTjNE?=
 =?utf-8?B?RkwzVXNGK1c0VzliL1Y3WnlXTGY0UHVxYTdYT1JndHZ1Rzk5bU4reFZKejhK?=
 =?utf-8?B?RnY2WldoMHhpM1RLcG9TNGNWMVlDMWdnWjhKeG92WWNEb0VFN0ZwWnFhNkJI?=
 =?utf-8?B?RU1XT3JjVmo1a3pGNHJZbnRxMEtCVDdSY0R4WWtqR1UyR0c3bGRoWGw5SlRt?=
 =?utf-8?B?T3E2ek51N0YrY3VPQTNMU1Baa2IrSkpJTERMQlkxSFhsWE9OWW94Q050MnZU?=
 =?utf-8?B?cVJZY3YrUnVCSS83NzRCOGNZeldpUzhReTltM2FKQ0VNY3RTWjFZY1laV25q?=
 =?utf-8?B?M1dURFdFNFA3UTNaeDB4MXI2UDJSYlNVbmVwOGxtNVg5L1A3OFpnUXRMaitt?=
 =?utf-8?B?L25qWnQ2andjNE9INEVySy8vN01IQW5Wc25oTUZMN1k1VEJTQjlzME9VMFVG?=
 =?utf-8?B?SFA4ZDcxUm0zRmU3emkvNzRIUlcyQS9pSEg2WVJob3RDL29XdVNrYU1zYUJ3?=
 =?utf-8?B?Umd1QmtDMXZYK0tmeVE0YVpaTktmQ1RGZ1haSTlRN1lLQXo5YU1mN0ZPT0pm?=
 =?utf-8?B?Yk83SnV3THUxQ3JKT0U4ZlFnRHFuQjVKNzlEZEJXZ2VaUUNudWVxbUV1WDFh?=
 =?utf-8?B?Zk5IZndLa243Q2laVDNxb3RWVzZGaThzUVBKc0xkaXBoZzhIcTE5YW5Id2xG?=
 =?utf-8?B?aVkxUWhHS2NOYWI0eW9HQlB0Y3NzUmZWdmdHd2I0NG43dittOTYrR0dVeWpE?=
 =?utf-8?B?Ymh4cnJrc2RRM3FnNzQ4R2JlK05wbkxUL1JHVGUvY2R3VkpqaWNlMWFSQjFE?=
 =?utf-8?B?bno4NitYbWdpR3Fxa0p4SmtKODV4NFQ2VGJ4aG1wQWI2ZjJIK2wwVnJ3OWVX?=
 =?utf-8?B?c3lVdHR4N2trMGZXRUdwMEJpUVhyTFZhMm1oampsL0k1YVVKUGYyWkhhTTd5?=
 =?utf-8?B?cXEzN3RSeVN4cjQzTHovR1AyMmhiQ3BHeVRvVHl3ZVhUZS9aYTFmK29FdGpp?=
 =?utf-8?B?eEFkMGpRVG5XZ3dUYnB4a2d0V2tuS2dsRGNpeVVQSFFsdEZYK2dmcjloOC9G?=
 =?utf-8?B?cnphWHYzWlV6YU5QVkZJUVFTcEtheE5GbHVTRWJ6VmJ1ZEJTeXYyM3pnTWp4?=
 =?utf-8?B?U1NtNnZjVEZJR3d5Mno2cG1FMHZZUVlNOVgxQmFQckFDVENVcEcvTXVmUGhS?=
 =?utf-8?B?eHQzSzdnRlVCSVdybm54T2RQWEI1Z1hqNUxJTFdyR1FTZ25NZzVQeUhab1B0?=
 =?utf-8?B?MUxsR2tpWEdEK1Bpb21tKzRrSVVCNzNmd0t1YllnYWVLSDh4dWJ1VmkrdHpj?=
 =?utf-8?B?QUZlV0FHUCt4OGxsUnhPZ3RNOVF2Y1kxYVRPUDloNmN1cXFRYUZabkR1VTk4?=
 =?utf-8?B?eXBYSERZZGxsOEtIb0ZxZTNESnpRTS8zNXpYbzRJZTVRRjVyai9hNG95Umhk?=
 =?utf-8?B?R1BVb0VVektBNHEvVGkzWkViSEw0RDEvcGFKdEtPcll4WUpyTklDQ3JMOTJh?=
 =?utf-8?B?WEQvSE1pQkVzNXFkdVBaaXY2U2ppQ3BxWHJoTGJiMGZUSXlVQzhNa0c3ally?=
 =?utf-8?B?R2EwMWdjM0QxZmRPY0FnZUdKK09OM0pxU09tOW93dFNPbU5iN1hKVGYvYmtx?=
 =?utf-8?B?YWY3QUNwdzJGVVlvMno5Tng2Z04rTGdtZjU0ZjVhYzltRXUxVUlYcUFIeXN0?=
 =?utf-8?B?VXZEa1F6NDRsc0ZMKzBRRUxUSHF6K2IvSzh6VzQyekhtTjVha0t3cHZqdGJx?=
 =?utf-8?Q?PNGRPb2SL/HqjiW9jo5VgUH2U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09f0cbb-c977-4caf-61be-08dd6d8c85ee
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 00:07:26.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EL26Pm9qROiYi+jpKf0L8UA93skDQ8ar4ECoUPC42wtdQCSBQ6G3rRpfHwIMN7tL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

On 27 Mar 2025, at 12:44, Matthew Wilcox wrote:

> On Thu, Mar 27, 2025 at 04:06:58PM +0000, Ryan Roberts wrote:
>> So let's special-case the read(ahead) logic for executable mappings. The
>> trade-off is performance improvement (due to more efficient storage of
>> the translations in iTLB) vs potential read amplification (due to
>> reading too much data around the fault which won't be used), and the
>> latter is independent of base page size. I've chosen 64K folio size for
>> arm64 which benefits both the 4K and 16K base page size configs and
>> shouldn't lead to any read amplification in practice since the old
>> read-around path was (usually) reading blocks of 128K. I don't
>> anticipate any write amplification because text is always RO.
>
> Is there not also the potential for wasted memory due to ELF alignment?
> Kalesh talked about it in the MM BOF at the same time that Ted and I
> were discussing it in the FS BOF.  Some coordination required (like
> maybe Kalesh could have mentioned it to me rathere than assuming I'd be
> there?)
>
>> +#define arch_exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
>
> I don't think the "arch" really adds much value here.
>
> #define exec_folio_order()	get_order(SZ_64K)

How about AMD’s PTE coalescing, which does PTE compression at
16KB or 32KB level? It covers 4 16KB and 2 32KB, at least it will
not hurt AMD PTE coalescing. Starting with 64KB across all arch
might be simpler to see the performance impact. Just a comment,
no objection. :)

Best Regards,
Yan, Zi

