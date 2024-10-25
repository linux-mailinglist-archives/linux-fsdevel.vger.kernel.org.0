Return-Path: <linux-fsdevel+bounces-32916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF26E9B0BE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B5A1C26096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF120C31B;
	Fri, 25 Oct 2024 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MxuiSKmc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96441C69;
	Fri, 25 Oct 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878091; cv=fail; b=maM5a1OEbXwL0fsD1muw/kOuvhZwcCXkawLppd/qbmji7qx2ELnKerEJMJq3cWRTjRipve5f8CabrMjqYk+71ouY+vEFMeuNSIMxdl2xViGMaAYdOxZLa467vvtD4mDaBSbnSl2sBnGvzf9RBuZSiG7a3pZwbS/VtHGoOOYevp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878091; c=relaxed/simple;
	bh=sy1O5QTfQrLe+0TqJ3nglbHvD7bz2mXEqYQ8cCpfin8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TXyJK909Qq8mZSyJh3yPF0pudjTT1H78LKoVr2lXthy1E8XQLYr7Xn6Xk+LLPMsQQOtNSfvHrMrUUMqI32pxhsQzJyxKUqyST5XIDKsFVOs+rlV2jGUO1t34G/7R+Ejkmn5HUrAAe3WI7LV3g+rwltEQIoZIY24NWDWLmVzCS1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MxuiSKmc; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4xN+kU85Ky8GBtAnGmqp1D4GIMjm/b9gtFSgmWDdizQ8aAQxy4vGiLdGbuveMPcy/WybGBo/QCUeD48A1WJVNWWo49wPXvLDH4agreYzNkuu8xTrX5glctuLIBbPxEiCbcyg4xIHIEBK7mgG71HwDswXxOFm+OPEdA/v7PnCr9S4c79/Ld/dpXre5RonCRrNubccK6nfNUvKba8Z9Nfj260+bmPPVNlSBi1s4oGNSyQDRkK8nzl1Bl12CIkYOloVVIYPd0jMe6D4hhQ590TTJrfh3ly0TH+98ND4lsHGbXWJ7jyQkb3+niSzqmGLd8Tu9fA0Cp6G6iDgdyyGFx+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByawjDxFXNR8pWjO4kNahnhJ7C4ZaRu4fW3wOzHhtn4=;
 b=xlVeNYwxyals+MobeJb5qRWP2ev9eCG9RQVCxfbC+lBwV+P+3N6rbBy0AxwDu81tsi5FFqCxRjOTsK2msyuo3+Rfn5KIWNMt+zb8BQ+G2MyJ7o2BYYL6I0Y3BrqU1YQemf/6WHH7USy6XCftaK2kCmLyUdHTFTnpXdlmTAhPAKqcmptoCv9q8br8jF94HmzPGxc2dM5FIhNDWIVz0m9FcKGA71jpNLepDLpK0E17sUhUfp/G80+euPUcifW5V38NJ6YVmH126WaliRHpBSUScw0jeACYJMqjq0m2LbOZpd/tbF+uE+egnpHPEnuOcidLM2ZmJVWegd/Tz6avaa+PYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByawjDxFXNR8pWjO4kNahnhJ7C4ZaRu4fW3wOzHhtn4=;
 b=MxuiSKmcFYthHpvaYCR/pP2oEX10Xm3s0rI20sXSqicntlG7Xzv7eg7/x3hJakOII06+2RlDkTXOcmfKY1hPJIhWNhG6Sld7Hp2U5TB+wu9n/FuQiUsDvi1PHu11ZYT42R2PfocXx22CRs56rD5PpALBwLI953eDygQEV9pM/Vhvla1VksOcrJk1nvqlBc99taBSEp5UQMuFwIGtZ3S8zf/6UmMB8/QlKf7AkdJZ9l3kCIFrmIQ6sU9iKxHXmhxYqvup8AUkbOU9tosbo9gg9nV7opPR7794vqLZShDZJcdezlj9TcknQxyULW7cNv2lvXyCXnCnygNLGXAnBw3WGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 25 Oct
 2024 17:41:23 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 17:41:22 +0000
Message-ID: <828674d9-e862-4438-86b6-61977f4cf3b5@nvidia.com>
Date: Fri, 25 Oct 2024 10:41:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
To: Pedro Falcato <pedro.falcato@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
 <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
 <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:332::12) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: e6999662-a2c8-4f84-07d6-08dcf51c3de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0t6S2l0bGRnL0JmMnBqM0ZiOTBxamZkUXZ6SUlDTlQyMkg3STdiamwvZVBh?=
 =?utf-8?B?R2ZaYzFHTGpxeFpYQXZCWjV5dGJYeFVEdGdXaVdlblBFQ3ljTlBISzhtRW80?=
 =?utf-8?B?Mzd0bDIzWFdTZ3FkemVGYkNSb21VL0hxcVNQTzJ1TVlKbkVrNVlGOEROZnho?=
 =?utf-8?B?L2p3eGVrZURCOTcxMGlVRk9oblVrcTZHTGlMOXltOGl6UEoraWlxaHRHWDA2?=
 =?utf-8?B?Z09sUGZHSkIzcGVpRjNDNlBSanBwMGtFbExZZVVtR3ZYMU9tZVNZNitaS0cx?=
 =?utf-8?B?ZkErcm1OQ1BFNFRCa1JkTEhJdjFGYld1Zy9iMTNscXJmUmpUOG9Ya2pUMDFq?=
 =?utf-8?B?Wnl6WTZZYnIxU2F2a0gvQnhDcDVNTXVNNWR1NnBQZHVwSVoxMERUWXN2Z3RL?=
 =?utf-8?B?MU9nWFhvbVphd2lXUHJ2OHkzMlRyVFpETEZUbldRd0k1SkJONWw3WklZSDUz?=
 =?utf-8?B?UzhKZVFjTDRHWUtLMVVEUHFPUlJkVzB4ZkxHTXNOYWFzOHh3Tko3dk1naDh1?=
 =?utf-8?B?SE5DK3dSN3VWTE9GKy9pSmhkWTNFMnlBbnpYWEN5YWx1M1lUUXVkQmUzdWgr?=
 =?utf-8?B?bGVIWEJRaUs4enYwb0txanVxUzNQZnRQVk9FaG53dzZTSlkvSjlaU2hkOXRH?=
 =?utf-8?B?MlkrTXNmdUZFb3Z5NFFHeHc3WENnTWhQcHRTY3ZQRjQ3OEZrRlJ1c1Zya1M4?=
 =?utf-8?B?K05scWRCWDROOHJiR2ZEQnk1WHBBWWNMTkxxWTMzMmRCK2UwWW03aXpxbyt4?=
 =?utf-8?B?bDd1SG5uYURES2wzaVFlUzN4cjYyd25nL3c5SmFSRWFtQ282R3M3WGFOZ0c0?=
 =?utf-8?B?SHpPWFM4SExBU0N2Ukx1M0cxeHZ5Y0NieDYrb1VvMGs0UHIzZ0IwaGZoVzdv?=
 =?utf-8?B?RC9XWVFrTm51Z1NuSGszSUxDNjZwb3JIV3NHZVdHL2IxOU1QbU1RREN4N01a?=
 =?utf-8?B?dlJ4RDNjUkd1dnhlRUw3VHF6L2duYmRZL0daUC9YWGRpVXRhMXNudmZKbDhJ?=
 =?utf-8?B?aDI3MDViVlJZR1pTM1BlUFdRK1dydEFXVzY5djI0WGVqMW00eXFHRnBhWHQv?=
 =?utf-8?B?NGdBRVR6RVZsc1RmQkhEdnVET1VTMm80SjBRZFQ0eXR3QUsrRHNBb0dUOEFm?=
 =?utf-8?B?TjFaVFUzL0dVUHFUbkI0OS9wRndaSE5rQi81ZDFuMDY3Z1NCTzhOT0UxQ3Rw?=
 =?utf-8?B?eXZYU3FUdlZhU2c3aGZaajFmRkFKd0JHVW4rTnU5VzB0WitXOFUzMnlVQ2lO?=
 =?utf-8?B?RHMwOXdxMTUwWlh5WUkyTTdpWUpBNm1oeUJtcWZIcjJTSVU3WWllanB2b2ty?=
 =?utf-8?B?NVVOWENSWXhYYW5QZ3ZGSC9TTTZUOGY0Nyt5MnFNUkdYNjc3YUV2c0VBWllH?=
 =?utf-8?B?dXg0bXlpTVIxdnQ1NE42OGM5cTVCalNBNjhuTFZ2cW5kQ2hPc3pkanlQWWxj?=
 =?utf-8?B?czFPNER3d255TkVzQWhQUHJuVGhnbjRoUytYSjlucUMvVlZaNDFJb1dydTg4?=
 =?utf-8?B?TDEvUzFEdkIyZ2diMys4MHl1UWJSTGZxcmRiWUJxcWI1am9CcGJiQ1lEVnY4?=
 =?utf-8?B?dEdDa29TbENKSWw4d2JzYlRpUWYydUJzeHE2THFvaGRyWFZhREN5SlRPN25j?=
 =?utf-8?B?TG1DRXgydW1mWFpvOCtsWHptL0d1Qi80dE5mM25NbGZmaWsyT2M3azJob1RE?=
 =?utf-8?B?cHQrQVRpRDVNdVo2VHdBWlJWOUEzK21XQzRpaTEyMHFtN3cvSEpyWm5QQU5S?=
 =?utf-8?Q?DO84CDn2d/Xet4nkittL7V86NGEWThWLcpazPLL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmtkWkNFRjJ1ZEs3eFlseUlpelQ0dHhnanE5NndwMnRhajlKWkFYT21tU1V2?=
 =?utf-8?B?K3hCUll6UWczQldyQnVwU1NjaGU1NXVFUVVYZDArbGtCZW9CTlhhWGlJamhL?=
 =?utf-8?B?TkJiaytQYlJUYVA5Z1BydVFwYUgwT1JMR1YwN3RncnVHSFFRRmVOL1YvNXBR?=
 =?utf-8?B?dzhJTEdnMVVybVJoeVc3TCt4QUVvTWwrMC9xZTVuYzFkTVpwczNyOUtnb25G?=
 =?utf-8?B?QUF2Yk9WalVDSDc2a3hMbDRNSWdkNXpyRFRqbnpYeVZTMjlzcW1DcW00RHRi?=
 =?utf-8?B?V2JGRjlCN0NrUDkyd1I2ZWZjL216Qkl6L0dKMVdLSVl5SklmNjY3VkcyZ2FQ?=
 =?utf-8?B?S2J1U24waGphSHhvMXdDa1Nkb21nZHZDdWZDMVBZTytzVTIzUVhsd2RTZS91?=
 =?utf-8?B?VmxFZDJWVFBDYnBXdzNUZi9udlI0S2c1ZGM0bW1ibzFHM2FoZjl6emtEY0Zu?=
 =?utf-8?B?ZXI2a1ZSaHV6UjlFbzVrbW02MXJOQUNObjNXejVmWVZoc3YrRXk1aGt1N1cr?=
 =?utf-8?B?THdqak01REZuOXdBcnAzNi84SXRiSjFVU2RKcXFvR3JZQ3RhMG5xaG11Qkh0?=
 =?utf-8?B?UXc5YUtNUUg3NTNhb1JzaGV6c3YySng5bkJsNHZsWGZIMlIvQVV4bVNqQ3Bs?=
 =?utf-8?B?d2EyamQ2N2tYUnpXMFBPNGNEenJ4S3VXS2trdjlUNjlhZWJ0VHZHdWJmR3dj?=
 =?utf-8?B?Z2tHaW1zV3hueXJ4VURZNjhidCtIVTRrNHZiWFpYOUxaQi9VeUdYaStMWW9h?=
 =?utf-8?B?ZCtjOFpBbXgyU2dvM1dNS2EzZlBMRVhPQ2RDM0Rac2ZZeVpKUXNhdEhhSGt5?=
 =?utf-8?B?NVNQRUxSekNnUzRHeDh6VEovVVg1S2FtY2pULytjYVJtdkF0VlZTVWJqWVVq?=
 =?utf-8?B?dHRhMkhLem9CQjluaW1vT0tuKzV3YmNvQ3ZzcEtybjNnNmxHbXJKdFNPRnhL?=
 =?utf-8?B?S0hSaWFqMDFOdVhaZ1BrNTdwU0FuYk81WXNZZEI2cHNWdHdsM2prS0V2c2d4?=
 =?utf-8?B?K2I2UWFaUXRvYlkyMkgwcGQxd0ZEclA4N1pzVmhwenpFZjhzbUtHNVVJMm5J?=
 =?utf-8?B?aGZPdjlRbFNyRGhVRk1RdkRDOXdoak1GbXFaLzh6VWJoSUtpVmxoa2wzRjNW?=
 =?utf-8?B?VGY0eElHSlJaVUlpRUNQSEFkS041cm96TlVoSXNsMFF0UG81TzZtMmFxTWhH?=
 =?utf-8?B?U25ST3hTU1JtY3pQZkEwakhndmQxZ1NqMTE1Y0ZweEJtWjFteVZlV0RPb3Zk?=
 =?utf-8?B?UDNXMjN1VVA3UEU3WnU4RkF2UWlYbkNIdXdiMG5yOGVicXFwazBvSHJYNnJ3?=
 =?utf-8?B?cVhmYjdhUVlaY2tueWRDd0JUOWtId0g4T1Y0UDJLbFozVWZPWUthSmVNRzJh?=
 =?utf-8?B?MExJc0dWRDBtNW5EUkx2Y2tINkI3MDVhZU9KWGVDOUFCdXhxc1BUSktSRWUz?=
 =?utf-8?B?Y3Y4ekptNFBvMks0WFp0QlNheUhtYklwdjNBNEdXUG45bW5JTFZ4em5UNGcr?=
 =?utf-8?B?Y3NxZU5iamIwS01xZ2F3Yk9JNWhwbTVkSGw4WllFVWg0MU41VmhXRG5oTEFJ?=
 =?utf-8?B?S1V4OHR0Z1lFbi9DaTBWOVJldklOdUQrOU45UHRQeXBpQndMQ0VPRVUyL09u?=
 =?utf-8?B?WWxFU3plM3hKWFpuRUNXSDI5OXZnbE1YM2F4TWJvMUNTUHk3aHRFWGs3YVA5?=
 =?utf-8?B?NTI4aXhVdjBXaVBnSU0xSnNZa0gxYWtoNG5Qd05vbjRVYmJkeDFoVGtrT2hH?=
 =?utf-8?B?U24xV3BadE9tU2VHalBYangyOVJ0TEVqYUR0QjI1UzBmYzZKdHlhOGM4MzY4?=
 =?utf-8?B?NzBxUXFYTVk3T085cm55dllXQWRQVGZtb3YyYzA5ZklnaElja0ZnbFcyRUtY?=
 =?utf-8?B?OEpCVUxHU2VtbElJTkg3WjQxVEdvWllnQWpJcjFZQnIzODVBd09ld0JqSjFk?=
 =?utf-8?B?S0N3UlIySUhuVFl2M05WYjliK3N0Mkl0YjB2ZGpZQmNOTVE0T2V1UnF4akE0?=
 =?utf-8?B?MmFsbFJUTzJZK05NTkdoSGVaQXNWNlk5T2xBOWJ6N2FneFFyOVRQZkdoeDJB?=
 =?utf-8?B?d1RWYkthOGVTbEF6akdMUHpYSFkrVTh5M2swNmJiYVViVjF4OUZUbUMyTnEr?=
 =?utf-8?B?Ukp5R1BHLzU4RHE0VXowVlNsR0l2bjFjRVpBTWFpQWhLaTFjeXZPVGdvY0dU?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6999662-a2c8-4f84-07d6-08dcf51c3de0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:41:22.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ptx8FbLDhurYjf5+0HgeXJshx2qxsjvAE8dsjfSMp1YBB6ZbCsvD2JQc3rxsOkD0httrSy4nJVKM0usGQaX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199

On 10/25/24 5:50 AM, Pedro Falcato wrote:
> On Fri, Oct 25, 2024 at 10:41 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
...
>> +static inline int pidfd_is_self_sentinel(pid_t pid)
>> +{
>> +       return pid == PIDFD_SELF_THREAD || pid == PIDFD_SELF_THREAD_GROUP;
>> +}
> 
> Do we want this in the uapi header? Even if this is useful, it might
> come with several drawbacks such as breaking scripts that parse kernel
> headers (and a quick git grep suggests we do have static inlines in
> headers, but in rather obscure ones) and breaking C89:
> 

Let's please not say "C89" anymore, we've moved on! :)

The notes in [1], which is now nearly 2.5 years old, discuss the move to
C11, and specifically how to handle the inline keyword.

I think it's quite clear at this point, that we should not hold up new
work, based on concerns about handling the inline keyword, nor about
C89.

[1] commit e8c07082a810 ("Kbuild: move to -std=gnu11")


thanks,
-- 
John Hubbard

 > <source>:8:8: error: unknown type name 'inline'
 >      8 | static inline int pidfd_is_self_sentinel(pid_t pid)
 >
 > :)
 >


