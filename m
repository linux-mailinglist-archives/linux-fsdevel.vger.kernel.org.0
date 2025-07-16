Return-Path: <linux-fsdevel+bounces-55090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42784B06D89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC091AA84C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 06:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D7B2E8E04;
	Wed, 16 Jul 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m4hINzMC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9F1CDFAC;
	Wed, 16 Jul 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645691; cv=fail; b=k0ZozwAiDRq3WlSihLUIrKgqCYvogUG2rBOysrjcEkC1z8PeFeOUG2WZxzpJYbutjPkQVKs1ONzqL9p9hCi+4jCpci14XIoY2Fvr2qShkepKmYGRVj4RHnmFrVdM05Oonqtw9cdrtTmQ8N1o37ROJ1AObd9HBtdpgDzundvKVgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645691; c=relaxed/simple;
	bh=dmJtPnI/RyH2ORyBc3nuPjuGTEzDwOTPnRaAk1FDyfg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dIuLaunzjFuF5hRcXAI1AxB1mFm4txlspKbftxFEA7IKLz3fxEtosTJydS39Zh05z7r68TaA9kWggbRigv3iMzvb9ZLjY97PR33s14CtIXQ2j1Al7VwML3OCK9DiQ+Gb6Th05pvrVKIw7G42dfRqLkaCXow9WPL9d8smcblSsAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m4hINzMC; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dos03FOqwxnPJigCHSLVCMO4/xeK0LPqXEHVWkCJnvNFb24/leivUgPsvjnF3dril/V7BjcB0r4H5ItTOBu5KGSaA/UxHlawry1UllU0v0WEweBBJ84HJmchpbRHYyKsUEj9KTMYqHzyWtQm58mn6mvbL2GAXFocczSUFkKWLzDZh/fXkPrLXFdgaGuTPo6acYlbkrKMIl3nhinLueCI5W67cLCZqOQmf4D4swfQiV8L+HipWEMJf1+c/igKjgGkhJMrmavum8dbE12u014MP8mb1hnb9LlmaiwGyeE40rsML9IMBCygMXA2AedZVXSv4SfIo8hJcGbLFZT4WeU0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNUQ1zBA1KXDnR4MUNRCpfKV4aNAYWDo4sFRGsvMbuU=;
 b=mwwPnbnVRqnlTAgaUtfNd15LLTkvW/TMrcajeWuViEWtwiverzS/SLjMkr0o7SY5lbzf9v0DUCUjELTo4POdSI9ESlp9klPH1ov4xK1Q85vQ1ZCfGiBJWerwMCuQu1HvCJMCww7+OCi0/LT6f377NMf8Mp/jh8VvkPEd3TV9qotLYlrqAaMCWVDPZRnF1cZ2dZ/YMies4iw916kCSzwieAZrU3mOaUhnH8S9cQLTmPKHReMzKq8miQ9d0au3uokzCB5pa+OgDQVTV7ptmCthSqcWbuD8YUr0lv2d10sXBGs+jqoIf3IImt45+iqoz6PnUNfKVmWdX6bvDQhunzgNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNUQ1zBA1KXDnR4MUNRCpfKV4aNAYWDo4sFRGsvMbuU=;
 b=m4hINzMC5qXJ0w3FL8PEck/Rz/RWZAMMw8IpKiOP73ieZSNKy0NX/4fU1QtaONb7MGuOrDlp2GxlgZJDj3yaFyEqctJrJ7Qqy5K8I8Q6fH1ujdwc/imlgUer6hddXFxYSErtvZO/INrPLXkN0O258dzSW76L/wFOrk9GhWZSTug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 16 Jul
 2025 06:01:25 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 06:01:25 +0000
Message-ID: <4ac55e2c-54a9-4fab-b0c5-2a928faef33e@amd.com>
Date: Tue, 15 Jul 2025 23:01:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add managed SOFT RESERVE resource handling
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <aHbDLaKt30TglvFa@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <aHbDLaKt30TglvFa@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ee4b19-858d-418e-d343-08ddc42e3272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWFyd3JmdDB6T3ZpQ0I5ZzhpOXh2WUhTaGdSVXNyelBOY0V3dStoakVaVlpm?=
 =?utf-8?B?bkZoUjA0NnptNVNMYUdGaUhEOTg5Uk9ZZDRsM1RYcUlTeStINkRVQkUvbktl?=
 =?utf-8?B?dFZEbGFYbHRwdDNBOUY3eDZHQmhZM29QeE5BZGFSdmVXZS9jN2FPV3FQa2JU?=
 =?utf-8?B?UW8xMkFML0xYcUIxSksvOU5JdGlrdVdST1dqYUJCOE9tK1EzZ1dZTm1obXdM?=
 =?utf-8?B?UlF5OEp6N0NBUkhUNy9QTlZ5ckRJbnozT1cxeVRhTS93Zy92UkVKVlJpcCsy?=
 =?utf-8?B?UUxVSERnMlFxcUQ2U3hsQlpOUVBaamxjRmk0U1lxOW1xVCt5NnlXSVpKWTlk?=
 =?utf-8?B?dzVsenQwWktYSm95cWwweTIxOFBCdkFzTVRhc1ErbmNHM01LNjExcXdkMFZI?=
 =?utf-8?B?MFoxUGNiU3MrVXlFTWErUnlkaGZHZ3Z6L0JnTXhYRmprV0Z2eGcrd2pCckQy?=
 =?utf-8?B?bm56c2p6bUpDRS84WVliU201MTFWRTFQSWZaNFh6Q0hmZGt6SUkzeVgxSlhp?=
 =?utf-8?B?cFB2VnJTT3Z1dlgzUUVYNDQxQ1RwTUlxNXptQ0dhbWlhQzRNWDF1TFdDSlhl?=
 =?utf-8?B?eVJwNkx5UjF5Mm5jeDFqN1BkU2ZLNW1UbWczU0pLUnBYSXkyMlp2OTF4NUt1?=
 =?utf-8?B?MWorZDEwS2t1dFNyd3oyZFRRQ3ZTaGlyWU90ck1ERWZINzJlaEcvV2Z4MjBE?=
 =?utf-8?B?OGx0dzFpQlJHQjBGQnE2cWFVb0ZkTFowZjhGNnZuKzRLaHNXOWk4cFpMVldM?=
 =?utf-8?B?Sm5ZNUVPRFNkN2NJaXRoZkRBS0RWVnlldWpXcFk2a0VCaVk4RTBDeElHRkVh?=
 =?utf-8?B?MFRPRXplWGUybHZyQkltUzIwTUtQbmFzSWVQeWtZditQM0o2eC9XSWZTY2FW?=
 =?utf-8?B?L2Y0SE1kS2RzWGQ0WkF2eTc4Z1d5QUlObzhUbWQzci9BZUhzbnU1NThoay9X?=
 =?utf-8?B?UzVPRVZVb1pLKzB2YUR5aERnTisvVEQycUZCL0lqSWJhYXp1dVJ1TmZYdFE1?=
 =?utf-8?B?NHdteFp2bW5QUW9NOXhSbGFIL1dpa0NQenZnRkVZY1ZXOExLS2xJVHZndmhC?=
 =?utf-8?B?SzIwcm5TVFRMd3NPaitJZDBYQjhXTVRoSW1JU0JxR3JnYW5ENXRhNVdmVXp2?=
 =?utf-8?B?ME9IWW1OSExvZkpsYWgwcnNHREFWb3FzcDc4WG5tTU5XNmZYK2tLMFN1TWFF?=
 =?utf-8?B?NWhzMTN6bDErOUg2TGR5T3krUzUvcHY0MVRla3dna1NKS0kxZlZvTUFQWHVW?=
 =?utf-8?B?cWVXbnR3MXg1blZZd1QrVXFIc0lXSnUvY053Tm14NVB0dlk5bis2Zlg3b3Vt?=
 =?utf-8?B?YjlNNWNBNXd3Q0h0ZU8zSERpdmVhTHFwVm9RMDNFZkhXVjhNVFNUVjJxVnBK?=
 =?utf-8?B?WjJWZi81Q01PSTRvSm40Yy93SVc3U1FHdm9CVnpXNTNFTFJaL2FMc2VMY2to?=
 =?utf-8?B?SEpNVUxWL1ZaQnJzL1lpc0o1emtVeFRuWDdOZnU0RnJuU1NkNk5ueUFHRXN6?=
 =?utf-8?B?UWxsY3g2WGxpWjdJSTFERGxCbUtXVXc0c0dTWUJzY2lmVkd1UXZiR3RoUFRC?=
 =?utf-8?B?QkhURy83MXplMEF6NE1QR3F2Y3lWdHRvTUxrc1Y5K2piU0dYOWUwdVJkRnNZ?=
 =?utf-8?B?MHJ2R1J2d0dBeFNIWWdZRkNKTDZnY042U3ZKbUc4cG1HcUE4V3E1YnhnV0Vt?=
 =?utf-8?B?L1pFOEN2Nmw4aU9xd1pGRy9PVTM0b1FlREtjT1pZdVlTb1pJZWErdXltamt0?=
 =?utf-8?B?T3FxdURRNzJDODJuOE5uY29WSnRpT241QmFCNWw4ZkJFd0xtczgwYjBEODV0?=
 =?utf-8?B?cTJDQVVIWXRNMGczNkJ6VkM4OFlNL3k0aTV3N3EvbUlXR3BtWTdTTjcxSENU?=
 =?utf-8?B?OFIwekprSEZHRXNseXYxYlZsV0FFL1hKdGppV1RFWGFBSVp4QmlOQmpMUTRy?=
 =?utf-8?Q?gLtCf6mhOlY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0YvYVFYSEF2RDViREF2d3RoeXczYTVMUUxvU2ZHaERpRnAyK2ZGakt4M3d2?=
 =?utf-8?B?NW1LZWU5QWZXV1U4azNEYnp2L3R4YkVwaWtrWWdiZ2NIK3FpVGRRT1JOWnM4?=
 =?utf-8?B?K1RpaDFrR2NjM0trWlR5NnJ3S0lsM3REazVMalhzVDQxUGRDbXBHVE9PQVE4?=
 =?utf-8?B?ekI4U0JFYmVQTlN2ZDhKczlFRnBPdGdmVXR6b1FUUEliV2l3RmhZUFhkY1Zp?=
 =?utf-8?B?U0RYQy95UTVrOVk3Q1RRbDZkd0E3Wm1kaU9nRzI1WXBkMWU3dXovc0FwcTRv?=
 =?utf-8?B?WHBDRGRiSDdBcVRWUmM5Ym1yMThaeHI5bDBWSC9xTmdVeGdsczRpTUJaU1VS?=
 =?utf-8?B?Rm1wOTRweFVmaEJZRkZqbWN1MDZEaU5BYnllSk9mdFRNS2Ruck5Id0tPRmlF?=
 =?utf-8?B?bFdXRThBT0ZpM1RMNHFudGZUdlpNZ0JGUm1tdVhSQkdaTFJPeWVLOXlISnpI?=
 =?utf-8?B?WHNBaDlwd25Qc1hvL2hVaVpHbEpFQkZCUjlEUFRobnlaelRZb1lTZ09Wa1pQ?=
 =?utf-8?B?SXdpTzRLTmpveC93eHY2d3BzK1pGQkxmRnJGTS9qWC9yZHJZVmlWZU8wZEl2?=
 =?utf-8?B?Y2Fqdko0U3RqZS92Q2h2RkswUW8vRGdKaE16aElTUUxRZzE0U1dYeUcwQzA3?=
 =?utf-8?B?Vlh6NjRiRkx3YW56NC9KY1plUmpCUE10SFNnelVacGkva1RvZkg1bUdyci85?=
 =?utf-8?B?cmt4NHNsTncxamRnbEJMcGR4ZGpiREFOQUxZSFo4eWhmczlvT2lwVStDc3hX?=
 =?utf-8?B?MUNxUXVOSkEzUy9LR0ExZlhtZXJRREUraU8ybmtmbTUzeEQyWno5L3lBQS8x?=
 =?utf-8?B?cHpyN1paWUhDS3prdWlEOVhSRUZxRGpKdWJoYVNBcVBGOTNkbjRrcEZ6Ykgz?=
 =?utf-8?B?Z1hoZVFzMGJ4UHcwU0pIbzlBVVJOVWNRakNacEt2VVFnN0RqeU1TSGNiWm9T?=
 =?utf-8?B?VE9FUysyNml2Vmh1V09Od0Nvd2RUVEV2WHhzY0N5QUFZT2haaHlFVzdzaWI4?=
 =?utf-8?B?NTJ5ekhsQ3RiZzNrdUhzY1MvdVROT0d5T3R0bmRTcGNKQ0NXOVhia0prUGVX?=
 =?utf-8?B?aklxWm5LOUg5YVVMNjFUazRENkw2eE5UMTBEOWR1U3QyZ1I0cTdrSG02KzRS?=
 =?utf-8?B?Ri96Nk02L1ZKS1A3VlRrTk5lWHNpbENCalZPVW84N2hKUE56aU1lR2o0SS9y?=
 =?utf-8?B?ZjVOTTRHa29NeW9XVUdyamRScXcrYzNJZWZKZ1lIakJqKzVJaDNtemZjbmJy?=
 =?utf-8?B?VTZScGJNUEtUcUNydXkxaG0vbURNa3V3QkNydllqYTg5QnQ2VS9NVFkvaWFW?=
 =?utf-8?B?UklPU1RZZlVkUjhxU2pzMnVTZUtZaDNjRmoyTTVTVUc4bjJTY0s3N0txZkxh?=
 =?utf-8?B?cTRGTlo0VkYxYklGUnlKa1FSV1BiaWhFSGlrY2drZFlYRjdvTkRKRGRqbWxk?=
 =?utf-8?B?Q21US3hNMHBVTXRWNUUyWFoyMnh3cmxiV0EweFJycTlWc0FHSXprVmNsV21D?=
 =?utf-8?B?dTdoQWMvQXk3cFhvekpERDJsM0NYR1BLbE1jVm5qbk1TcWIzdUdYWkpSSTBK?=
 =?utf-8?B?T2tSZUhNR0FJSmVKdkljV3hCWHRzWXBaZ3d2WFQvbkJlVnQxVDZSUmFNQVcv?=
 =?utf-8?B?Z1EzMTJmV01TTGJWZy9aMnQvRFp6SmtZWk9oV0FOMEppVDNITTJlOU94N2o3?=
 =?utf-8?B?Qitya2ZsMUZoc1FPOW9LZHAwSElVaEpySmhkaUhQVG82bXBYWERqck5hTnpw?=
 =?utf-8?B?bEFER1AvcGRzY0hrOFVlaVVxc3BNRkcwYmZ0cWNjNllqNFRQMjRRK2ZvaTJF?=
 =?utf-8?B?cnV1Ny9NT09uZzl5YVZTS1ZqWDFjMkp0YXN4U3lLRHgrY2pER1U3dkxHc1Fv?=
 =?utf-8?B?R1R0NzROY2xDSXRJOCszSnJPRG5lZVN2UGYyTEFvSXFTUzBNdWhNTk9DekMy?=
 =?utf-8?B?YjZqZGRQRnhsNUpBUVIwV2t3WDBUOXJGUVY1R3g4UWpBSllIeHNUNXlRYXZp?=
 =?utf-8?B?MWpSSFk5eE5zMjduU20ydkgxWiswU2hvVjhHakQ5b1VLK29HbUJpZ3pBTStq?=
 =?utf-8?B?dndFWVVnL3QxWjBFdkVGOTNJOU54VDJaY1RDYjYra01PbCsvNkpQL1c3WEdK?=
 =?utf-8?Q?DTcPgirTfzvydiTA/ShYQ48ZU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ee4b19-858d-418e-d343-08ddc42e3272
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:01:25.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFT7QclyIW+bJtHdtym9Y+8Wrt52v+B+Ea5AZ4xmNU0bPrCQskYRVWWAcRiBYR1qBzf3I98VIP6Ad2fuDeKvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

Hi Alison,

On 7/15/2025 2:07 PM, Alison Schofield wrote:
> On Tue, Jul 15, 2025 at 06:04:00PM +0000, Smita Koralahalli wrote:
>> This series introduces the ability to manage SOFT RESERVED iomem
>> resources, enabling the CXL driver to remove any portions that
>> intersect with created CXL regions.
> 
> Hi Smita,
> 
> This set applied cleanly to todays cxl-next but fails like appended
> before region probe.
> 
> BTW - there were sparse warnings in the build that look related:
>    CHECK   drivers/dax/hmem/hmem_notify.c
> drivers/dax/hmem/hmem_notify.c:10:6: warning: context imbalance in 'hmem_register_fallback_handler' - wrong count at exit
> drivers/dax/hmem/hmem_notify.c:24:9: warning: context imbalance in 'hmem_fallback_register_device' - wrong count at exit

Thanks for pointing this bug. I failed to release the spinlock before 
calling hmem_register_device(), which internally calls 
platform_device_add() and can sleep. The following fix addresses that 
bug. I’ll incorporate this into v6:

diff --git a/drivers/dax/hmem/hmem_notify.c b/drivers/dax/hmem/hmem_notify.c
index 6c276c5bd51d..8f411f3fe7bd 100644
--- a/drivers/dax/hmem/hmem_notify.c
+++ b/drivers/dax/hmem/hmem_notify.c
@@ -18,8 +18,9 @@ void hmem_fallback_register_device(int target_nid, 
const struct resource *res)
  {
         walk_hmem_fn hmem_fn;

-       guard(spinlock)(&hmem_notify_lock);
+       spin_lock(&hmem_notify_lock);
         hmem_fn = hmem_fallback_fn;
+       spin_unlock(&hmem_notify_lock);

         if (hmem_fn)
                 hmem_fn(target_nid, res);
--

As for the log:
[   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting 
for cxl_mem probing

I’m still analyzing that. Here's what was my thought process so far.

- This occurs when cxl_acpi_probe() runs significantly earlier than 
cxl_mem_probe(), so CXL region creation (which happens in 
cxl_port_endpoint_probe()) may or may not have completed by the time 
trimming is attempted.

- Both cxl_acpi and cxl_mem have MODULE_SOFTDEPs on cxl_port. This does 
guarantee load order when all components are built as modules. So even 
if the timeout occurs and cxl_mem_probe() hasn’t run within the wait 
window, MODULE_SOFTDEP ensures that cxl_port is loaded before both 
cxl_acpi and cxl_mem in modular configurations. As a result, region 
creation is eventually guaranteed, and wait_for_device_probe() will 
succeed once the relevant probes complete.

- However, when both CONFIG_CXL_PORT=y and CONFIG_CXL_ACPI=y, there's no 
guarantee of probe ordering. In such cases, cxl_acpi_probe() may finish 
before cxl_port_probe() even begins, which can cause 
wait_for_device_probe() to return prematurely and trigger the timeout.

- In my local setup, I observed that a 30-second timeout was generally 
sufficient to catch this race, allowing cxl_port_probe() to load while 
cxl_acpi_probe() is still active. Since we cannot mix built-in and 
modular components (i.e., have cxl_acpi=y and cxl_port=m), the timeout 
serves as a best-effort mechanism. After the timeout, 
wait_for_device_probe() ensures cxl_port_probe() has completed before 
trimming proceeds, making the logic good enough to most boot-time races.

One possible improvement I’m considering is to schedule a 
delayed_workqueue() from cxl_acpi_probe(). This deferred work could wait 
slightly longer for cxl_mem_probe() to complete (which itself softdeps 
on cxl_port) before initiating the soft reserve trimming.

That said, I'm still evaluating better options to more robustly 
coordinate probe ordering between cxl_acpi, cxl_port, cxl_mem and 
cxl_region and looking for suggestions here.

Thanks
Smita

> 
> 
> This isn't all the logs, I trimmed. Let me know if you need more or
> other info to reproduce.
> 
> [   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for cxl_mem probing
> [   53.653293] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
> [   53.653513] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1875, name: kworker/46:1
> [   53.653540] preempt_count: 1, expected: 0
> [   53.653554] RCU nest depth: 0, expected: 0
> [   53.653568] 3 locks held by kworker/46:1/1875:
> [   53.653569]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
> [   53.653583]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
> [   53.653589]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
> [   53.653598] Preemption disabled at:
> [   53.653599] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
> [   53.653640] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Not tainted 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
> [   53.653643] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
> [   53.653648] Call Trace:
> [   53.653649]  <TASK>
> [   53.653652]  dump_stack_lvl+0xa8/0xd0
> [   53.653658]  dump_stack+0x14/0x20
> [   53.653659]  __might_resched+0x1ae/0x2d0
> [   53.653666]  __might_sleep+0x48/0x70
> [   53.653668]  __kmalloc_node_track_caller_noprof+0x349/0x510
> [   53.653674]  ? __devm_add_action+0x3d/0x160
> [   53.653685]  ? __pfx_devm_action_release+0x10/0x10
> [   53.653688]  __devres_alloc_node+0x4a/0x90
> [   53.653689]  ? __devres_alloc_node+0x4a/0x90
> [   53.653691]  ? __pfx_release_memregion+0x10/0x10 [dax_hmem]
> [   53.653693]  __devm_add_action+0x3d/0x160
> [   53.653696]  hmem_register_device+0xea/0x230 [dax_hmem]
> [   53.653700]  hmem_fallback_register_device+0x37/0x60
> [   53.653703]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
> [   53.653739]  walk_iomem_res_desc+0x55/0xb0
> [   53.653744]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
> [   53.653755]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
> [   53.653761]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
> [   53.653763]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   53.653768]  process_one_work+0x1fa/0x630
> [   53.653774]  worker_thread+0x1b2/0x360
> [   53.653777]  kthread+0x128/0x250
> [   53.653781]  ? __pfx_worker_thread+0x10/0x10
> [   53.653784]  ? __pfx_kthread+0x10/0x10
> [   53.653786]  ret_from_fork+0x139/0x1e0
> [   53.653790]  ? __pfx_kthread+0x10/0x10
> [   53.653792]  ret_from_fork_asm+0x1a/0x30
> [   53.653801]  </TASK>
> 
> [   53.654193] =============================
> [   53.654203] [ BUG: Invalid wait context ]
> [   53.654451] 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 Tainted: G        W
> [   53.654623] -----------------------------
> [   53.654785] kworker/46:1/1875 is trying to lock:
> [   53.654946] ff37d7824096d588 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_add_one+0x34/0x390
> [   53.655115] other info that might help us debug this:
> [   53.655273] context-{5:5}
> [   53.655428] 3 locks held by kworker/46:1/1875:
> [   53.655579]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
> [   53.655739]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
> [   53.655900]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
> [   53.656062] stack backtrace:
> [   53.656224] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
> [   53.656227] Tainted: [W]=WARN
> [   53.656228] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
> [   53.656232] Call Trace:
> [   53.656232]  <TASK>
> [   53.656234]  dump_stack_lvl+0x85/0xd0
> [   53.656238]  dump_stack+0x14/0x20
> [   53.656239]  __lock_acquire+0xaf4/0x2200
> [   53.656246]  lock_acquire+0xd8/0x300
> [   53.656248]  ? kernfs_add_one+0x34/0x390
> [   53.656252]  ? __might_resched+0x208/0x2d0
> [   53.656257]  down_write+0x44/0xe0
> [   53.656262]  ? kernfs_add_one+0x34/0x390
> [   53.656263]  kernfs_add_one+0x34/0x390
> [   53.656265]  kernfs_create_dir_ns+0x5a/0xa0
> [   53.656268]  sysfs_create_dir_ns+0x74/0xd0
> [   53.656270]  kobject_add_internal+0xb1/0x2f0
> [   53.656273]  kobject_add+0x7d/0xf0
> [   53.656275]  ? get_device_parent+0x28/0x1e0
> [   53.656280]  ? __pfx_klist_children_get+0x10/0x10
> [   53.656282]  device_add+0x124/0x8b0
> [   53.656285]  ? dev_set_name+0x56/0x70
> [   53.656287]  platform_device_add+0x102/0x260
> [   53.656289]  hmem_register_device+0x160/0x230 [dax_hmem]
> [   53.656291]  hmem_fallback_register_device+0x37/0x60
> [   53.656294]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
> [   53.656323]  walk_iomem_res_desc+0x55/0xb0
> [   53.656326]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
> [   53.656335]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
> [   53.656342]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
> [   53.656343]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   53.656346]  process_one_work+0x1fa/0x630
> [   53.656350]  worker_thread+0x1b2/0x360
> [   53.656352]  kthread+0x128/0x250
> [   53.656354]  ? __pfx_worker_thread+0x10/0x10
> [   53.656356]  ? __pfx_kthread+0x10/0x10
> [   53.656357]  ret_from_fork+0x139/0x1e0
> [   53.656360]  ? __pfx_kthread+0x10/0x10
> [   53.656361]  ret_from_fork_asm+0x1a/0x30
> [   53.656366]  </TASK>
> [   53.662274] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
> [   53.663552]  schedule+0x4a/0x160
> [   53.663553]  schedule_timeout+0x10a/0x120
> [   53.663555]  ? debug_smp_processor_id+0x1b/0x30
> [   53.663556]  ? trace_hardirqs_on+0x5f/0xd0
> [   53.663558]  __wait_for_common+0xb9/0x1c0
> [   53.663559]  ? __pfx_schedule_timeout+0x10/0x10
> [   53.663561]  wait_for_completion+0x28/0x30
> [   53.663562]  __synchronize_srcu+0xbf/0x180
> [   53.663566]  ? __pfx_wakeme_after_rcu+0x10/0x10
> [   53.663571]  ? i2c_repstart+0x30/0x80
> [   53.663576]  synchronize_srcu+0x46/0x120
> [   53.663577]  kill_dax+0x47/0x70
> [   53.663580]  __devm_create_dev_dax+0x112/0x470
> [   53.663582]  devm_create_dev_dax+0x26/0x50
> [   53.663584]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
> [   53.663585]  platform_probe+0x61/0xd0
> [   53.663589]  really_probe+0xe2/0x390
> [   53.663591]  ? __pfx___device_attach_driver+0x10/0x10
> [   53.663593]  __driver_probe_device+0x7e/0x160
> [   53.663594]  driver_probe_device+0x23/0xa0
> [   53.663596]  __device_attach_driver+0x92/0x120
> [   53.663597]  bus_for_each_drv+0x8c/0xf0
> [   53.663599]  __device_attach+0xc2/0x1f0
> [   53.663601]  device_initial_probe+0x17/0x20
> [   53.663603]  bus_probe_device+0xa8/0xb0
> [   53.663604]  device_add+0x687/0x8b0
> [   53.663607]  ? dev_set_name+0x56/0x70
> [   53.663609]  platform_device_add+0x102/0x260
> [   53.663610]  hmem_register_device+0x160/0x230 [dax_hmem]
> [   53.663612]  hmem_fallback_register_device+0x37/0x60
> [   53.663614]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
> [   53.663637]  walk_iomem_res_desc+0x55/0xb0
> [   53.663640]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
> [   53.663647]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
> [   53.663654]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
> [   53.663655]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   53.663658]  process_one_work+0x1fa/0x630
> [   53.663662]  worker_thread+0x1b2/0x360
> [   53.663664]  kthread+0x128/0x250
> [   53.663666]  ? __pfx_worker_thread+0x10/0x10
> [   53.663668]  ? __pfx_kthread+0x10/0x10
> [   53.663670]  ret_from_fork+0x139/0x1e0
> [   53.663672]  ? __pfx_kthread+0x10/0x10
> [   53.663673]  ret_from_fork_asm+0x1a/0x30
> [   53.663677]  </TASK>
> [   53.700107] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
> [   53.700264] INFO: lockdep is turned off.
> [   53.701315] Preemption disabled at:
> [   53.701316] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
> [   53.701631] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
> [   53.701633] Tainted: [W]=WARN
> [   53.701635] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
> [   53.701638] Call Trace:
> [   53.701638]  <TASK>
> [   53.701640]  dump_stack_lvl+0xa8/0xd0
> [   53.701644]  dump_stack+0x14/0x20
> [   53.701645]  __schedule_bug+0xa2/0xd0
> [   53.701649]  __schedule+0xe6f/0x10d0
> [   53.701652]  ? debug_smp_processor_id+0x1b/0x30
> [   53.701655]  ? lock_release+0x1e6/0x2b0
> [   53.701658]  ? trace_hardirqs_on+0x5f/0xd0
> [   53.701661]  schedule+0x4a/0x160
> [   53.701662]  schedule_timeout+0x10a/0x120
> [   53.701664]  ? debug_smp_processor_id+0x1b/0x30
> [   53.701666]  ? trace_hardirqs_on+0x5f/0xd0
> [   53.701667]  __wait_for_common+0xb9/0x1c0
> [   53.701668]  ? __pfx_schedule_timeout+0x10/0x10
> [   53.701670]  wait_for_completion+0x28/0x30
> [   53.701671]  __synchronize_srcu+0xbf/0x180
> [   53.701677]  ? __pfx_wakeme_after_rcu+0x10/0x10
> [   53.701682]  ? i2c_repstart+0x30/0x80
> [   53.701685]  synchronize_srcu+0x46/0x120
> [   53.701687]  kill_dax+0x47/0x70
> [   53.701689]  __devm_create_dev_dax+0x112/0x470
> [   53.701691]  devm_create_dev_dax+0x26/0x50
> [   53.701693]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
> [   53.701695]  platform_probe+0x61/0xd0
> [   53.701698]  really_probe+0xe2/0x390
> [   53.701700]  ? __pfx___device_attach_driver+0x10/0x10
> [   53.701701]  __driver_probe_device+0x7e/0x160
> [   53.701703]  driver_probe_device+0x23/0xa0
> [   53.701704]  __device_attach_driver+0x92/0x120
> [   53.701706]  bus_for_each_drv+0x8c/0xf0
> [   53.701708]  __device_attach+0xc2/0x1f0
> [   53.701710]  device_initial_probe+0x17/0x20
> [   53.701711]  bus_probe_device+0xa8/0xb0
> [   53.701712]  device_add+0x687/0x8b0
> [   53.701715]  ? dev_set_name+0x56/0x70
> [   53.701717]  platform_device_add+0x102/0x260
> [   53.701718]  hmem_register_device+0x160/0x230 [dax_hmem]
> [   53.701720]  hmem_fallback_register_device+0x37/0x60
> [   53.701722]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
> [   53.701734]  walk_iomem_res_desc+0x55/0xb0
> [   53.701738]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
> [   53.701745]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
> [   53.701751]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
> [   53.701752]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   53.701756]  process_one_work+0x1fa/0x630
> [   53.701760]  worker_thread+0x1b2/0x360
> [   53.701762]  kthread+0x128/0x250
> [   53.701765]  ? __pfx_worker_thread+0x10/0x10
> [   53.701766]  ? __pfx_kthread+0x10/0x10
> [   53.701768]  ret_from_fork+0x139/0x1e0
> [   53.701771]  ? __pfx_kthread+0x10/0x10
> [   53.701772]  ret_from_fork_asm+0x1a/0x30
> [   53.701777]  </TASK>
> 


