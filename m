Return-Path: <linux-fsdevel+bounces-60663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E1B4AD17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E4F189CD7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 12:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC962C029C;
	Tue,  9 Sep 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="UFT5YCRJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFD2FF65D
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419220; cv=fail; b=MofBBnqlXiXkbZ0oJyB9dOzlyaDzvR4aoqqQODFJyH91msrUeKeiDcC32tDJQp3RBjD2HlXaCUBm+ztZ7PV0m+xWCIxn4sGMpo8/NVZZZ+p+izrFHQKELR+Pgk42MwHV1kBJ5yVhkmbHIw4EfIfGHJJdNR6zsVySWC8DtsNzOWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419220; c=relaxed/simple;
	bh=MdCfLOyYAeCaun8TR4HFsHvhI4BmKqeFK66ce068adc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gWKLfaf+AFCJJrw39ORFOjl14LEy9qvp+nDW0ey9qyVhK+C8+AeHcnijH5qf3cK/tqPzfcHuPAjAGU9t/Dl846uHyfpEl+bNzPeMJsyfSAuOr4j3nKgsJ4QWOMl8PtrYPNPQyieJDuUNtcl89HOAZdkH+aXzqYKz8oEaeQBaMHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=UFT5YCRJ; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2090.outbound.protection.outlook.com [40.107.220.90]) by mx-outbound13-117.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 09 Sep 2025 12:00:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvMVNReI4j8pqUpxFKJuWijE8mK26+w7/1tsTS7nqgEhIjjCptto/R4ZNchX+S4UDhaxDSYv0tJAOdcbANNnqdjpfTFHoupeRVohk+mRrbCq4Fw/ABvfwqdQcgjp3OmVJdTbhG0eG6b7CSK2vxS7ytkD8/AHHdBQCLrSgUTUorNCtLVy/v8KYAPAcwfofE44V+/JZoXZ/1+RDP1Y3Ue5aA7vpL8rpB+3FdooM/GE63nKcB50C5c9C/yPfw1CUG7b+x70t0UB8M6v5XEadhvMp/hQN6UsPTAtKIl6Ob8TH6xK21vYGlRmQQEJD0nUKdHqtmDI+rOBWwwAcIGz46Em6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDm0hg9oguHy6UsElED+T0/WAXSxQPhfYK6ICHk3rUw=;
 b=ZU8VA3WHNDuiHTm1JuanXyBtROdC5zIvOys1M4OpngcXqvdIeCVubpPhcHv4o2MrxrtSoU60GGSQlkViaoQOct+7xyhxumm5GhnU+tUinrPz8bGOpUMEJhhsQBgXr+ZNfVz4dBVn5m+a2QiGBvllzYulonRqh+gxrrGDnB/RDkCAcKt5IWZjlSnfy/0HFST8pH1sRzV3zYJyxk1tDpjkyeeOplmwkPvnQ33M6W2ugVqFZs7ANuWQzh2xQi7mqAk1ETCG1s/oLpEPUrUY0SHCbWwZOKbF4kYkZB/GKPqSkqZe440T0DgkIgn7omJdldhdE3OBgg9yxG/x3hp+4JQNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDm0hg9oguHy6UsElED+T0/WAXSxQPhfYK6ICHk3rUw=;
 b=UFT5YCRJbWSl/28kIfwyWtYfSLxIEhzruatfozD6d99IGuFW8RzJOUXZwGeBdzv+cSyEH2Eo67rUi3VJ/kn5IXDpI1f1Pe5KoASAamMRPkxi7sqDnkOxzC+ktrRO3beHEI37n4YZKHM9sHT5LDgb3vhPczg5IDwfDshVW3ZnaG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SA3PR19MB7585.namprd19.prod.outlook.com (2603:10b6:806:320::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 9 Sep
 2025 10:25:32 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:25:31 +0000
Message-ID: <c6417bf9-77c6-4dc7-a5bd-9b2aad5822d4@ddn.com>
Date: Tue, 9 Sep 2025 12:25:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/fuse: fix potential memory leak from fuse_uring_cancel
To: Miklos Szeredi <miklos@szeredi.hu>, Jian Huang Li <ali@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, mszeredi@redhat.com
References: <4a599306-5ef1-4531-b733-4984d09b97a1@ddn.com>
 <CAJfpegs2YGe=C_xEoMEQOfJcLU3qVz-2A=1Pr0v=gA=TXrzQAg@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegs2YGe=C_xEoMEQOfJcLU3qVz-2A=1Pr0v=gA=TXrzQAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0396.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:399::12) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|SA3PR19MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: b888417e-3ab5-4e21-aadc-08ddef8b3444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVdNZ1hIRXkyV0VXRDdVZFlGNER2M1cvUEFNdmVXUVdPb2h0NkNoYXpVSXds?=
 =?utf-8?B?Q29icU1DbncxaVZQaTJTVHpSUXZpWGxKVHBoZjNVQU1YN05PU0tLZjVXZXhJ?=
 =?utf-8?B?UlJ6VHljNUZ3NnBxZmpkUk5jcmNibDRXUmlvckhadEhDSVlDMTRkejBPY1NU?=
 =?utf-8?B?ZXRvTVhHcnZKZkF5ZkNGV1VwSWpWZ3lwelB2RWhxK2dPeVFvSGEwbjkvenY5?=
 =?utf-8?B?OXlxM3lZNlFGYjk4UmdtNTlTVzgvaDRMdHRQejlsdnZwNWxhOVpwWlFEWTlW?=
 =?utf-8?B?b3pmZ1d5WWlyZ2ZvODdQRzhSQkhhVFQ3N1pHaVpEV1kxSG5iUWdPcGFqbXFO?=
 =?utf-8?B?elR3dEFLRU1PSklSZU0vcFlSWGovWXRqaEtIQUVrNkoxaGZrMXpHYUNMaEZh?=
 =?utf-8?B?cWhYYjRycWNkL0JCOHB4bGxRc3hDTTRJclhIUENMUVQwb09LU29Sd3lWUXhF?=
 =?utf-8?B?eHliOUhqSWNVZWlXQjdqemhnMTZlcWVxTUs3bFo4UTZKajR0NnBKeEV5Q0c2?=
 =?utf-8?B?aWNIZlZXQ1VJdXpDWU9LNjlXVjlLMDA5YjNlSkRrTlkzVTNVeHByOEswb2VP?=
 =?utf-8?B?NE43czhLMGZTU3hZODhQTGRMTExmQ2pneGwvdTArZzNwOTBrZkg0a0o3NW01?=
 =?utf-8?B?VzRYbWRMTExKc3lUTnhlVm5oSE1MRW9ZVGN0K0x6VzhzTU1jWlQxTkpJMDI2?=
 =?utf-8?B?QlRkQkxJaUR3SnBhS3VWZXpFNFllYnJUMHhjdFcyakpKYUxNalMvQmJSOVQ1?=
 =?utf-8?B?aS8rTUl4M3h0TTcreWNNdzdmdDgxdDd6UnZIeGkyN3Vtb1FJUjk5RVUyQ0oz?=
 =?utf-8?B?TURpdmdONEdGK1RObEJESXdEYzd1Qy9DSWFUaENCVzMxQ0NNeVoyb05oMGR4?=
 =?utf-8?B?Z0krc2VyYVo0a0oySjh6ZGFyWTNtdjdCaUVmTDBsVDFrNzIvWm1Vd1h6OC9G?=
 =?utf-8?B?WGVEaDdRYzNteDhIVytZRVl4OVhQN2twZDUwSk5XTnRCdDRKLzlOOEhVSmUv?=
 =?utf-8?B?MVBwMkp4YklPWG1qN2tRUnBoRFlYM0pjOTkxVEthM1lacGVQeGJINWRRNG85?=
 =?utf-8?B?a0trd0ZVdVQybWZpbTMwMmpDVDdqODRJM2FFUjV2N2lCVlYrTXlHVHZhVXlH?=
 =?utf-8?B?WXZiK3hhejF5WkVkMHN3eVVaL3F1UUczSDFXN2dTS2c4bUhTeTZTSVppVzkw?=
 =?utf-8?B?MHdHUFZZOVVHMm5KdVVXS3BVUVoyV3hkYnhxM2V3L2kxbW1Nc1VxVllVNVFY?=
 =?utf-8?B?RlFrYks1dkNHMm1ITWtTTjR4VDgzUjdMVWQ0K2c2bjNMV2pWNVU5SktDc1RY?=
 =?utf-8?B?dVRLVU50aXJVUG5uZ1djRFlnak82dWdxWjNiTGFxZjJwTHZPY0xFc0JtbU14?=
 =?utf-8?B?KzkrTWVwcVJXZG8yOXFLUzNlZ3dETlg2KzY4Z0VkT3RKc25VdVordnNxMkgx?=
 =?utf-8?B?U0pSb0g2aUdjYzhyWVYwRVNEOUpzaE1GUzdFaXgrOVg5czJYSTJHd0pGaDM5?=
 =?utf-8?B?NEsvVk5EWWNQaXg2K2VWR0dHdklJMHhSUWJ4MGdQcmpMZU45R1B2SVVOZURC?=
 =?utf-8?B?amtDOFVFODM4Y2tUSmFxVWozNkFlRGJRaXFTMDZHcDVTSkZRTG10SGlBOGJL?=
 =?utf-8?B?UDE2SFljNlhxN1RtYUJ3Qzh1ZEJIc29lSG1lMzZGbUNsZFk5OXEzZjc5aEJz?=
 =?utf-8?B?MVBpYy90enljWlp0RFVxVzZDUi9lUUM0ZDBkYVhQMDk1eGU4VGlocjl6YjhV?=
 =?utf-8?B?WWdyRXJwUWM5UjJGOXhOZWsrMW9rUm9XOG1RaVYxOUNGcit1V0pDWE9NVnpk?=
 =?utf-8?B?UWlVeEFTRHhqeW9tRW4rUXovSlhkVVJ3emJXaXF1TTNSR2JtaFkrSHZRdDdZ?=
 =?utf-8?B?bkZzcER1WjF1SDcxSm1ha00wdWMxYzhkSzlSSktKdEFZeERmUkM1WTJFcCtq?=
 =?utf-8?Q?eettWp+qlWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2tBSGIvSjFncm4ybWtpVWs4RkM0R2dDa3JRbmpVcWNFeDhXZDlqbXNXRmow?=
 =?utf-8?B?ZmR1Q2ZuU2hjYjVsTVNna3YwK2x1OUwzMVdOMGhqajYyQzQyWGwvcEpDaDdp?=
 =?utf-8?B?QWlNRWFZU3lUbXg5RlJJejRET2wyODVOU2lzVFJVQ3ZjdTdiVEE4Vnh3R1Vp?=
 =?utf-8?B?S3A3UnZhVEpiQ21LeVZub2thUEpKM1VnVXhudERncUk1eXdETUg3MkU5QmVB?=
 =?utf-8?B?TUNLY2hpS0EyaEYxZ200MWVaMEVwK05NcEs2Q3EwTCtKcEN5N1RVQWVQNStN?=
 =?utf-8?B?ZzkvK2N2eEFWZGtXblF5SlJxMW5lUlpkR2txdEV1Vkg4VlhHNFVhbE5DQjNw?=
 =?utf-8?B?QlB0cWlMam1rQ29LT0lyYVhaMStXcXVaaGxPc3JmdEp0YU9GbkFDVVRZcHZv?=
 =?utf-8?B?cXN5RFBWU0pNQURNamd4NmFDckZpdnIyMDBBSFlnMkgzeXJQNGpUSFU0QVlD?=
 =?utf-8?B?b0t0ZTNLNUs3aDBrc21ZdzI1VExpTVBIR2ZZTjFDc0x2QUd1cVhWSHMrUmJ1?=
 =?utf-8?B?eDd2L2FvUHdxZTErUGNzRlk2c0x2SG1UeU1hNUZhYzljSklwVXRPbkdUVVdy?=
 =?utf-8?B?WWVsd0lRVmx1NlhXTGxmSUNXQWNCQW9KMGl1dHZOaVFVQUw5S2FDNWk0N2w3?=
 =?utf-8?B?aHBXQzlvOHlIZWJFMUNpdDRMMEtoYXZ2TnBSbDlJV2NSWGFUdkRkWlVtS3kr?=
 =?utf-8?B?Q2NCTDQzK0RvK0RXcjkxUkd3bzU3bFZ4SkpqYk92TmdGMFNndmI1QWxrQ1Rp?=
 =?utf-8?B?S2NkSUh0dVVEcnRoREtjc1d2cTVFc2t6OWZPU3JpZUQxRitTTkw3L3ZrR3RJ?=
 =?utf-8?B?aUJ5a0RvWndYb1VuYVN0aVVhT2V1aitVbDNjSGJVNERrWmg0dHArVjgzaDlT?=
 =?utf-8?B?NzMwUDJPUGxKT1pUUW9UaEVwekk1WVk2QmpReVhxV2JGKyt4WWg5Ti9YcVpz?=
 =?utf-8?B?RTJUNUJ1SFVJdDBrOW51ZDFFdWlyd0JxUC90eFBiQmszYWlOdUFmVXRIcjAw?=
 =?utf-8?B?blMyWm83WW1LU2VBNWdrTTJFeTI5Q1ZKUDNicm1TUGtkSVRvaUNHdWVKQWFW?=
 =?utf-8?B?QmRZVG9heWtkUTRXbU83SG5ubE5xQUlLNFNBbGI1YWNRdUhBbzhYekV1V0FG?=
 =?utf-8?B?WU5xRVFSbWtGdWhqWkVMWHRxb1V0ZTRzWS9JYjVwVmNLdFdUR1lTUTJOdFdJ?=
 =?utf-8?B?elVyZkNQNG15WVVDQ09EdGFCNWpBMkh1NGJML3hqaFBhN3dPRG1hU1NzNi9Z?=
 =?utf-8?B?N0pmRzNCZWZ0SFZ1RzVpcWsrbjg3R2VSZGVVeStQdGNxYVRuaS96WUFXMXFj?=
 =?utf-8?B?SGdvQ3daY2E4V0doUHlwQStrdmVxbXYvbkZsWkpMOFJKSDJBRHFGb2ZLVVJ2?=
 =?utf-8?B?OEhJMFpDYk9CTlVnSE5GNEtXTCtPTjRoblpyM1JkVUI3RmFFN2F2cHpOSjNE?=
 =?utf-8?B?N2M3ZGhCYXRTMzdUVnJkUjBvNklkWEx6ODl2blJVN3NKVlJLQTBvZXdXcWZH?=
 =?utf-8?B?ZERKWk42cWh6L3dUazlCYStSYzM4K0hXRnNyVWx6MEZjeUJUS0tHMEswaEdo?=
 =?utf-8?B?dllHSExzeVMzNXVldHRaQThFTnhXckg2eTM3ZEIvMmcvdVlSMlhJMCtaYTA0?=
 =?utf-8?B?MDQzVmhrd3J1N3ZyQ2ZpWElqOFFaRzlzK2VCVVQ4QlFIUW55ODA5OFZHRHRS?=
 =?utf-8?B?aVZlVDFjekJmMU1RZS9xeGxCdGQ4S3FuOWsxTDhsUzNWL1JzRDVnWHZnb2hU?=
 =?utf-8?B?ZjBTWVRYMlRYNjdVN2FHRnpIMmlqMnp0cGkrZXNMQTl4Wjl4TXB1c1lPWnpJ?=
 =?utf-8?B?VU54anIzdjRrSXVPYjI1R25Sc0l0cHkwZmJkUWx3eUgrcHh1bFZFbEdyYVFm?=
 =?utf-8?B?NmZnMmFNN1BLTjlqVTJldW5qemQ4TEoza2E4dDNZeldBL2NvY2d5anlUTHI0?=
 =?utf-8?B?cTg5Nm1QemVlZmc5TTdZVkdVSjBiQVVlMWlJdVVIdDFYM0d0VkNtN0lsVTZt?=
 =?utf-8?B?NEJ5aHpISkpZZ3BWYTlGVmQ5UVVqZ3BEa0w4UEg1bGVkVTVyRnJSVmVhSHNa?=
 =?utf-8?B?NTZML3d6a3BFV2xNemxCS2dNVHFWNkdVWFJDZmorR0FuQ1Y0cHU1dFJ0REg0?=
 =?utf-8?B?T0ZwKzFRR0NHaFpDajBGN3VPU0l4bUFSUnpyMFVtSEpCU3Zic1MzYVc3cktp?=
 =?utf-8?Q?nP/UEsP5uV1RBLAHKdQrHY6qezdOHi0m65J6nLnv93i7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ob7Y9DLJT7Wnz6fVN+fOsesZF/g4WeTEnZsQXO3cxUrdwGG7DUM62JFtao8SPaR7B64IDeM1eVSNwRPu8U89hcbcFo7abtRTKOvTE1wlV1ha9c09vGSk7Y1DPkLDHOYCCVPklWm5CMNsI3fg+hAi5u6RiFaIJIBI2zR1gUR6HPKV4KkRvql0fjYxb+ftS4Wwkxr+uhCdZbsQHM+pHL/io+EMOc23BtSFVYj2e5LnjafrRIwOpGyZspKWZ16DJCmfM15AtUqm4MIQJuULXUnq+h536gVSNJRfTD99ax7j1VoVypUFtsrOjVHngbvH17Tph+ATgV3DLZ7cS+bj/A3bfoeLC9o605SmdjuBK9WKztkjPvy4yTz545Sb8AHVcjSrxWNFacK2jBrk/sSB7n9ZrIyqeD4ZUioRd0n8u+VZvIKUIi8+SrPvaKyY0LqYYtiHrXBFsxEUDz9tziE5HbRTCXabGr3PMKLg9NMqzlxTqjxFgZ2p9GO4kEcu+y247drF78ivsKzU0fbVTOu8T0kCXm/L2YTjY2ASDmgR1w6VUuxKdFsxeXmPKDJjBuVIETRa8RoRAfbtPVI/y60xU4qIp/zxuA44mBvtFMYmf5GHbE7ZAVwLCz60B5dTpc4Vbu8O8Swusf2Cr1/E0HwjRem2SQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b888417e-3ab5-4e21-aadc-08ddef8b3444
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:25:31.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /imXB5y+yI6BJD8umIfOSLwq7PWkhmom6Ndf6ivKbG/6KfxsV2Hry3+VkZAqaUJT62XrFGVSFsGqyo+ecv9y4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7585
X-OriginatorOrg: ddn.com
X-BESS-ID: 1757419216-103445-7643-53-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.220.90
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGRkZAVgZQ0MgkySzR2CjNPD
	UpydTYyCQtKc3IMs3UxNzSNNnA1NhCqTYWABLpnDJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267358 [from 
	cloudscan14-167.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 9/9/25 12:14, Miklos Szeredi wrote:
> On Tue, 9 Sept 2025 at 11:50, Jian Huang Li <ali@ddn.com> wrote:
>>
>> fuse: fix potential memory leak from fuse_uring_cancel
>>
>> If umount or fuse daemon quits at early stage, could happen all ring queues
>> have already stopped and later some FUSE_IO_URING_CMD_REGISTER commands get
>> canceled, that leaves ring entities in ent_in_userspace list and will not
>> be freed by fuse_uring_destruct.
>> Move such ring entities to ent_canceled list and ensure fuse_uring_destruct
>> frees these ring entities.
> 
> Thank you for the report.
> 
> Do you have a reproducer?

We run with 2 more patches to pin the memory. That pin slows down
startup a bit and then it becomes visible with xfstests generic/001. I
guess it could be artificially reproduced with the current code by
adding some delays into libfuse.

> 
>> Fixes: b6236c8407cb ("fuse: {io-uring} Prevent mount point hang on
>> fuse-server termination")
>> Signed-off-by: Jian Huang Li <ali@ddn.com>
>> ---
>>   fs/fuse/dev_uring.c   | 13 +++++++++++--
>>   fs/fuse/dev_uring_i.h |  6 ++++++
>>   2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 249b210becb1..db35797853c1 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -203,6 +203,12 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>>                 WARN_ON(!list_empty(&queue->ent_commit_queue));
>>                 WARN_ON(!list_empty(&queue->ent_in_userspace));
>>
>> +               list_for_each_entry_safe(ent, next, &queue->ent_canceled,
>> +                                        list) {
>> +                       list_del_init(&ent->list);
>> +                       kfree(ent);
>> +               }
> 
> Instead of introducing yet another list, we could do the same
> iterate/free on the ent_in_userspace list?

Yeah, would be possible, but probably hard to understand for someone
reading the code? At a minimum it would need a good comment.


Thanks,
Bernd



