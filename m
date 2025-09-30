Return-Path: <linux-fsdevel+bounces-63069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEBFBAB469
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8662E0243
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032B7261B9E;
	Tue, 30 Sep 2025 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V4UQMxps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B724729C;
	Tue, 30 Sep 2025 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759205003; cv=fail; b=HI1+1yEpAGvz5gwFAOscpvgD3CXbEdFM0XplFBOC81DiG+zMxXqHAyvODuK/RogzVFIcbOfAHyiMpuPsMFfQ19tM0CKPBB3cXGT4+1n52GAUw0lMO20L3HjHOJsub2X9DgWcelgFL91h2Eb2e31b/UyuqbUHv2hMH6iP/+X0n9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759205003; c=relaxed/simple;
	bh=alLMZVhrj6q4UDJj0wtBq61VUHWI80iWqOSDPhQn8DY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YWjyTIV2HyYcv9JLXugSRN0VKs4oXyojWkMUMu6QG4qyaG5JPnn7nqrmr/m4Bosu6zcJvt4e+djN26s+sqzXZjbzvQJhDniasDa8aeQ+8qc6aiblgWW8AKyqmMjDW0S8hdxKQmdHzKJrbigmpiTZtlrwXtppF7HHijfgyiyV2+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V4UQMxps; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUly7rjqEUZawtunG3rOy9S6AUfjbhmWjvKsxRbvT+1aXdbK+Z8Y6h9AZ12+W+Aj4fqP+iPQUUA0N0MrKwEOY9F/irTb70ozNLQDgWRGp901Z/Vy3g4w+s/mclZgIzbJuVOF2goBQT9UaVfBctwvDb/n6I+CHbyGPsGRh36jD+8DKYk5x1Wmb0uUyS90yQhPmjHPTNycyXoT9tTQsU1DQ+qCCt3cysOdrgeqBcY2qEIGpVzwI3bMDhdem0st17C3UoeNLPMwge2nTgYMav4TAsYl7oYSYY7Ym6Uuh1SKYeLlDsL0lqgjmKXOuN6b7kldg4Cvbb//SfS+fnxiixvzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj/KyiPnhw6gFzXAgrmR88ZcJl9nRpU92mhqCij7g3E=;
 b=WFpqLRZiq11oRbRwvwxwfLITdvMMOiU9dpXMObS3xxUcNUYDS9hdHgiXqdLcYCnOIq1COOny3izchy4C18I0RXkPXgI6MayBFE1ufQ3rDk/wSPS7+Co9IpigV3mB0VC+SdnBrgS4b8yeDyk9jBW7RhwkdI6zgS2w2f64g1W1MCZAsERHqzO4E1hbzlBi0gedkUC4U8+xEqh7iKdF/nItA5RrnUTapbnFmKJSmY9/WFQ2DUa6ATdzWR7D9VoiGubrQ2wJQ/9RtWsWhaWMroRw3N8nIklvbbU5yDrlqvLO/yUeQPJaO2ByExe8PWrwZ6cqU9mYTCM+NDvQmjZj28mCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj/KyiPnhw6gFzXAgrmR88ZcJl9nRpU92mhqCij7g3E=;
 b=V4UQMxpsnINkLsG4EnuHyIEhgcuz1lDN5C9T3qWqY2i/G5Fq+anQn4CDHbV7YEWXqsUhX/owIIxBqDcgoSSyD1oJ9s8thQ59RRpRi/PL0n9Ovj0cxHqXaYtmRsTIrvlKzh+p+Jmwj1B55+KBHXAH3jIaQDZo0wugKdIx3PNz+ZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:03:19 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 04:03:19 +0000
Message-ID: <b4efed14-7e26-4c25-b834-e15a72e4eb10@amd.com>
Date: Mon, 29 Sep 2025 21:03:16 -0700
User-Agent: Mozilla Thunderbird
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Subject: Re: [PATCH 5/6] dax/hmem: Reintroduce Soft Reserved ranges back into
 the iomem tree
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-6-Smita.KoralahalliChannabasappa@amd.com>
 <20250910144136.000002e2@huawei.com>
Content-Language: en-US
In-Reply-To: <20250910144136.000002e2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: ede8cdd7-a37f-43f6-2141-08ddffd64a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzc4aXAyZ1JaNnQ5alA1dzF3am1qeHNHUmxEZ09hbGZtTkVENnhnZzBENWgv?=
 =?utf-8?B?VVFUbzV4d0JyTlBTZm0vWUxJS2g3enY4VGh1NEVPZDVYNllDSFkvU1Z0dW5a?=
 =?utf-8?B?dGl0WmhJQlgrRVlFbllYaW50ZUlMUmJyN0ZFMmZkUGN1OFBjTzRnS1JHSEhL?=
 =?utf-8?B?TTJyb2VwYnJHQklIazNFTldFdi91NFIvOC9BOXh6OW1hMHdRUTRCMDdrZ2VD?=
 =?utf-8?B?cjVNZ1J5dE9pWURVckp2S21DTnp2b01nZGRGSHFkSTh1eDMrRTdEeFNDWjlh?=
 =?utf-8?B?b2x1a3NxMHMyZDNzbzRRdlpEMHp1VEpoSElSV3o5UkVLV0YyVWRiVVB2VDR5?=
 =?utf-8?B?V1NXYlBpQTVwVEtFbGwrM09oa09Tak42a3pmVUdGbStjS1E5VDhHZW40RUFC?=
 =?utf-8?B?U1Zab3RHZWQ1NUNZVVhSMmVWalU2azhpSFk0VVdKSUl6aFQzTG5TRkVqaDVl?=
 =?utf-8?B?MTViNnNza1g3Rk9SdFA0WWJMVXlESiswTlIxWFRKM0dlZHVmMUZHeTBDdnZp?=
 =?utf-8?B?dHZ4cTQzbnVscVB4cFZRRDlyY1gvMWh0eWFDUlp2NmlRdUYyQlpmd1NqS280?=
 =?utf-8?B?Q1lhZGxoR2luQjBqN1hkemtSV3RzWjhrQTZyeXpkU1NPV05LVjMvUkxKZ1ZD?=
 =?utf-8?B?bUhKa3lxSjQ1TDNpTnhRQVdacjhUR0NNY21Ycm56TVMrd3N4MmJWaEZkN1FE?=
 =?utf-8?B?MU1QM1RtT25Wdk50b0ZJRjdsMTNuN3kybzVGaDVMVWlXYXE1SmpDOVRyS0sv?=
 =?utf-8?B?SE8wRlFzaUZwV25YbW1HR0hvdHlSUEYrYjE0cHl5MERDeENYQXIzMGk0Y1pL?=
 =?utf-8?B?K0NSVlY3d1JhR1ZpZUxvYnh1R2dDUVhZR1E5MkNQb203YWZHM3U3b2xQeGIw?=
 =?utf-8?B?TytqODBjYk1tenF4Sy9ZcVA0eFZickFhQmE2UDdVRVNVZURYL3cvcmJ6cWxt?=
 =?utf-8?B?UzdNS05vbXZTcXAvK2JKaFdMbjdyZDRTU3BPV05Db2JhaHNZcFFPdkZGSHhW?=
 =?utf-8?B?a29LQVpmb3NxR1lFdWRvZFJRbWM2bE9FL0QzTlVFbEFxVVg0Qjh2aWlPVHh2?=
 =?utf-8?B?VW8wNjRkK3REQnF0V0lKTHd2Y05tS0lKZHduZjJ2ZFBNZGo3d3JYZW05Z29S?=
 =?utf-8?B?R0cxT3M2ZDNLR21CVlVoWUc3d3NjZkVkRm1BVmZleU9IUjNnejFQSjdpa043?=
 =?utf-8?B?NmxqT2Rsd21Na3A0ZGx5TDYyRUVvb1hCbVFDZndEdE5OZkxJcjFVUGNTVXFQ?=
 =?utf-8?B?T3lZZ200ZjlqMS9ZNG5vdWxPdEE0cU5iblV1UkMxVW9CN1p5Z2tCcXoyYjht?=
 =?utf-8?B?UkRBY1NIMzIvcGdtbFkybkVOUzkrdWxhRC9RN3hNaEhXRlJyL1lWSWpKNG5S?=
 =?utf-8?B?bmhSSFpqbHVVdWErVkd6WFVDWUd4UC9LUlIyb04yeU1DZkVYbk45NDBhTHRz?=
 =?utf-8?B?QXFoeUwyckZCekJDd2FqS0ZPNWtpNjErYkFWcUtkWHVCVFVvOFZoWkZUc3VG?=
 =?utf-8?B?a2xhdmUxNE5iWWtGS3dVMko1bjMrcWFEVTRxaDlMRXNhNWVzeEx6OVJTL0tV?=
 =?utf-8?B?VmtaaUYycjRYM0U1azl6czNEOG9RaytQcHBiK0VmeGlKc3hKSUxLblFSeUsr?=
 =?utf-8?B?dlZ5WXRUS3Vhd3RrNlBrek41OC9XR3FOaG4wNHVWc1o0RlVrMW9Zc2ZMVUJE?=
 =?utf-8?B?T1llR3FhaWthUk13akttdHJmQTcrREp0ckp5enRwREp3TW1aN2kwZ05TMXNx?=
 =?utf-8?B?OEtCVzZnMXAvUUhBK0JEdEVQN0ppemN6SmtIS3ZyTXZ3Tm11azl2UEVFc2ht?=
 =?utf-8?B?cEZtbHVGYzBzUDBEL0NXT2JISFF1OUlleDZPNjJqWjdUQ2M5VnpCelRiQm5P?=
 =?utf-8?B?WlNzZ2NPeFZkZXJuNUYweUplZHdsenNzTFl4cE5hSWcvd1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlF1U01SZDBKNHBVR09xaDU4ZW5IM1dMQXl4emkwODNqTzdJMUFmVkV6Yytw?=
 =?utf-8?B?RmRYOUlueFducDRuc2Vxa3VpZ1NIdWppd3dFYnpqUC82STZkdjJHUWNOM093?=
 =?utf-8?B?LzF0V3U5T0ZwVW9aSVJ5NitaTVRBZXRieVFzbW8wcXRGT1RXUkxYR0JRQnZH?=
 =?utf-8?B?VU9PdFFYOE1LVmZQTkwzeStSNUxMWjVZenFzTlh6NzVJb1VKSVZkNmlmcWhy?=
 =?utf-8?B?STdoL2dTRDJsaUx2N0NWeEROZVlNUHZEZ090VW5Vb2VsOE1xWEY1VXU2eVFU?=
 =?utf-8?B?QitvbHVERU5vcWhOcHZtWjZhTTNaNmZCRVBKQVhyd0ZvcC9aQkZxR2RzMXhU?=
 =?utf-8?B?SGtzVTV1TDBnMUFoa0w2QzVKZ2ZWKzlOandrczhnenFYbU1UdnVsbmxsN0F4?=
 =?utf-8?B?NFNiL0lXM2YwalRidE0xS05kZjRrQmhoc2dzZFVYbExBTE1sNms4d2hQMStN?=
 =?utf-8?B?VUlJYjVIWlVCN05HS2x3V3lOZDdScUlrOEt2b2ZoaWRLS2FyaXNZTFZQdmNY?=
 =?utf-8?B?TldmRTFmQlBEZGRTeDdJMkNIMVRzVTdQZUEra3VYZkhVOEFYY1d6SndiVUJ2?=
 =?utf-8?B?OHFsS3Z2Qll5M1hKdkZTR0pPMmhXN1NPNVErNVh4NUQzUlk4ZERGQUo0em8w?=
 =?utf-8?B?SE1NUzJlRjhnVTBXc1dZV2hrVDcrQUFkd2V0elYxLzVINkRiSXFMOVVjYU0y?=
 =?utf-8?B?a09iclpJNGxHWlAvZ01iTGhKTGxlSlVUQnZTbTZsb2Rra1p6b1JjQ2JvNi8w?=
 =?utf-8?B?alRuQTZRelFpM0lsZkE3WFFCZldtTVV2SG55MjBXWHMxSEdQTmpTVERCR0U2?=
 =?utf-8?B?SnZvSmVyMitvRllWWjFkWkViN3RoaldwRDBhcDNaM0ZhZzZ6cmt2TmNsNlhC?=
 =?utf-8?B?M1h0bzZZU3hyM1E2UDAwSHFGMEI2QzF6OHBtRm80L3c2d1JGK0cwQ1cxQlht?=
 =?utf-8?B?Sk5ZSEtJTWNvODU4UDFvWnhJOUh0citKNzVhRGI5dENBS0xPRWQ3dERiNGpu?=
 =?utf-8?B?MmZ0V0Viem9lb2xhaGR4VXRrdHlxSWZVbGhYWXFueTF2TWc5b1RTZDQ5V0p1?=
 =?utf-8?B?M1czNFIrV0l2a3c1c3ZwOFNQMVdIdk1xTjR0THAxMHJrY3VDZ1p3WStNOXFG?=
 =?utf-8?B?U1VxaUNWUUNBdTRXdjkzL3NkVU45L2R4RHNSSloyMWsrYU85SUkvcVlnWGJJ?=
 =?utf-8?B?OFVmdXJ3Z1ZvRjhxa3Q1WjJBdWNGQ1dNbnhxdUZDNFo2Q0RTYlBVNEVZYmty?=
 =?utf-8?B?Tk1qdWU0dHJ5MVhic29VSVZNRjc0RW1tMzZwWEYwWnd2bmwzMElLN25xYVBa?=
 =?utf-8?B?eFZsRkpZWVVKQU1FZ210NjF1eU81eFZicUErWFk3c3drWEFtSGJVSC81Z1dV?=
 =?utf-8?B?cmt3R3lTdm91MUd6UXcwdGlMM2VnY1YxcTEwNDd5c2MxL3dpdUNLSWhOai9q?=
 =?utf-8?B?YjArZ2pBQ25NZUo2UlNRS3RWT1ZkUVdqbWVtUEhaUHRYaU84Q0Y1dmUySHkx?=
 =?utf-8?B?eHY2YngyV2M2NDUxVExjbThEZVk2ZWVzelFVZ2lUenNvSitod21nOXBuL0gy?=
 =?utf-8?B?OWRXOVg5Yks2VWFEclh3bEVNblBEaU16WVFuUFRvYUYySFkwNkR2TmpjTnJn?=
 =?utf-8?B?T2YvUnpOdWdsNysrMm1vN0pZSjczU0tsQmoxSHY2S241dzcrSHFHQjZYUFhR?=
 =?utf-8?B?WHdnbm8vTDVPb01QbUNRUVNqM1d3ejlCaXd0YWlTYVdrajhOSTF6bWsrRVJI?=
 =?utf-8?B?TUErQS90SDh2OHBEVGpvZktuZkgwdlVLYzRHdHhwZjUzcWc4ZFdNZVFYbE9J?=
 =?utf-8?B?WGdEdngyeHljZE80RGNpY3FvRHliV0NSNHJMSlFyRVU5SGZjTFlwaWF6czBp?=
 =?utf-8?B?RUg5Q3JmQ0ZmaUdHQXVuRUViRFVpM0FndVZuZjU0ZHp6Sy83L25PNmNQSkgy?=
 =?utf-8?B?Q3VHVHJCUElvR1hWSXd0L2Y4dlcrcU1qKzZ6dGIyVE5kYkZCNmp1REZtM0ND?=
 =?utf-8?B?Mk5TQkFxWmVZRVAxRC9SQ1RZQ3pNcTAzbGhXN1pKODArNmhDMWg3RGhqRmxJ?=
 =?utf-8?B?RGVjNktNSDZJNGpVWEJsMWd0QWJveUNiMmlDOVZ2L2s4Y1YyQmlobU5SMjEx?=
 =?utf-8?Q?ZimaUWnTY0izvEp0apuI/3NMf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede8cdd7-a37f-43f6-2141-08ddffd64a21
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:03:19.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hYJ9W9msA9RC/bWd8CbiQtZsaNT7zV22DsYiQ3Dqi7PIeI0DmROHXgmuT3dNi0lBDWfkBDZsxwoSOfqyA7ZJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572

Hi Jonathan,

On 9/10/2025 6:41 AM, Jonathan Cameron wrote:
> On Fri, 22 Aug 2025 03:42:01 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
>>
>> Reintroduce Soft Reserved range into the iomem_resource tree for dax_hmem
>> to consume.
>>
>> This restores visibility in /proc/iomem for ranges actively in use, while
>> avoiding the early-boot conflicts that occurred when Soft Reserved was
>> published into iomem before CXL window and region discovery.
>>
>> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
>> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> A few trivial things inline. Not are important enough to need a change though.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
>> ---
>>   drivers/dax/hmem/hmem.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index 90978518e5f4..24a6e7e3d916 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -93,6 +93,40 @@ static void process_defer_work(struct work_struct *_work)
>>   	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
>>   }
>>   
>> +static void remove_soft_reserved(void *data)
>> +{
>> +	struct resource *r = data;
>> +
>> +	remove_resource(r);
> 
> Type doesn't really help us here so why not skip the local variable.
> 	remove_resource(data);
> 	kfree(data);
> 
> Though I'd rename data to r.
> 
>> +	kfree(r);

Fixed in v2.

>> +}
>> +
>> +static int add_soft_reserve_into_iomem(struct device *host,
>> +				       const struct resource *res)
>> +{
>> +	struct resource *soft = kzalloc(sizeof(*soft), GFP_KERNEL);
>> +	int rc;
>> +
>> +	if (!soft)
>> +		return -ENOMEM;
>> +
>> +	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
>> +				      "Soft Reserved", IORESOURCE_MEM,
>> +				      IORES_DESC_SOFT_RESERVED);
>> +
>> +	rc = insert_resource(&iomem_resource, soft);
>> +	if (rc) {
>> +		kfree(soft);
> 
> Could use __free() magic here and steal the pointer when you setup the
> devm action below.  Only a small simplification in this case, so up to
> you.

Sure, I have incorporated.

> 
>> +		return rc;
>> +	}
>> +
>> +	rc = devm_add_action_or_reset(host, remove_soft_reserved, soft);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
> 
> Trivial:
> 
> 	return dev_add_action_or_reset(host...)

Included.

Thanks,
Smita

> 
>> +}
> 



