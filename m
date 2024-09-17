Return-Path: <linux-fsdevel+bounces-29584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE4B97B043
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1BA28779A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABF173355;
	Tue, 17 Sep 2024 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3reR2PxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140943150;
	Tue, 17 Sep 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577011; cv=fail; b=Td9mmRCoNeDkt5AhFOSJUr4SERjfkIGY0zJQY+CzTeIB+QPhzn71l2ga7hmXxWARsSHp68Xyk2iOcA9fiGK6b8CXcS8fOCDQI1FUDcWF74+eK1PXMwARTwdIQzr1mfKQ0ZLbL2uDwdaWijwvomr0gcFBxAw1i3zl5RNHLXsOn5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577011; c=relaxed/simple;
	bh=h/fKBuCOZdRLxKH+lR+w9s5UywzOYybYojgbe6JPPAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdFgb1NfhTeAyqaUxs3tIuddFsn3uPbQOqy+KXJCxpI+TsDnoJc1k/iRQcqOOGRJBS1HWvfzY1XU8zfNqQYoGTxVgn1/Di8VtagOWHyBXXvM4yW6/z3OVlF7z1VOrBVXjAt5+H8i8xEhMUITvi6IOJ5c3OO1RURcVoXwjoh9yPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3reR2PxY; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEjqOZ3k5pyIxbFdmzXCq+DedZLVXP1t5rqKrEavwKSIn8SSuHFlcosChxaJrIMNwAKQEb12scK8P3bCigZ2uZD7crmKaiiiuCrEHp+zsaxfIqoWVqAvr01/3NykzJYpVnRwxRK61+WmY3U85CgclMRMEGQCZsMfLpCPGzdwjNbk6rzuqixyMRmJzcjLXfC6OTR4+MkiibjHE/1GliZGC3FU2WMBAPaVpu1b6Dz2wxaO3nQJHRHVfE3libp1gGl0HZhlTF5VBF0CGpIosxVXhqxNvQ1h8orki+abEo+3lbJHd0u9sjVd1tqz0UwhRP7VJxnLmey2opn6NZZao5U3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CYMhQXhVdNu2EXw9c3l7Tj2cyqAX7l8pKgrLPvOuZQ=;
 b=EH1NwXLZ+QvCABRvu/TlECcgHphzsJx/v8GGkPIVA8FIloHWd2XkIC0BCQ0UtzI5iOs8Jbp06gdGOr1syjvZUtd/+1zut8w+ycTZN8FP9lRJ15/JWPKu25g0fStjQ6Gki/ONM7bcn9u5UTlHUUK7o8LaPyLsFuBEbjzJl+y1p/NHwxl6ybJWbNnOxwwbc54xqQG07jMgb7wraq+Kr4VgwDwxSlnBmT3nChl/pUfGFnPxlhW0iLLJ3pm35Gwun/0kAFB+HuH14vktzeIoia4xUH3SDxN5EyfBf+3PJfDa4RI0veuHwWcdwOJ06s882LLE1wEE5+OYqVq1ojBgeb3lUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CYMhQXhVdNu2EXw9c3l7Tj2cyqAX7l8pKgrLPvOuZQ=;
 b=3reR2PxY0oYtms3LaKo+V8sPBKx9x3DEMuTd3cyKtbj2+Vw44xx+bxzzhwgQX4tbSlbN6iK5f1Mwb4aEVKNW/5bAnaozaJ/61qgokFSvHvQmnPshhU+P4DFWsMLfyg8iYGhem01Zo/V0taNHGnjYlTtAVEK8lWnQ1e0Rz74Fjvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 12:43:26 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 12:43:25 +0000
Message-ID: <e471ad3c-daf1-4a21-b800-9934d1d3d9df@amd.com>
Date: Tue, 17 Sep 2024 18:13:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] mm: Add mempolicy support to the filemap layer
To: Matthew Wilcox <willy@infradead.org>
Cc: pbonzini@redhat.com, corbet@lwn.net, akpm@linux-foundation.org,
 acme@redhat.com, namhyung@kernel.org, mpe@ellerman.id.au,
 isaku.yamahata@intel.com, joel@jms.id.au, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, bharata@amd.com, nikunj@amd.com
References: <20240916165743.201087-1-shivankg@amd.com>
 <20240916165743.201087-3-shivankg@amd.com>
 <ZuimLtrpv1dXczf5@casper.infradead.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <ZuimLtrpv1dXczf5@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::19) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c81d9e-d293-4687-3c40-08dcd7165148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzBMdXp3bWNlT2I0dGZUbXJUS2tpYzZxY0dlMTV3ajhIaTYyaDBrMHZXSzFy?=
 =?utf-8?B?YkZPbkw1dWMyTkw5THcvSW9DOTVmdG1wbFE3T0dtdkNySitkRW1PdGgwN1FH?=
 =?utf-8?B?UkZVR3ZoOExoY201bHFxWkNPRHVOK3VnOTRrUzNEWkpJM1RHQ2xmRFpISmpQ?=
 =?utf-8?B?a3ZKQnB3dy9kRDlVMWRsMkRhS2xvaUdxc2lwYWp0U0VBRVQxZ2xXOEswOUwy?=
 =?utf-8?B?NVVsVENpRzE2U3BlZG1JdWdFQm83cFowVVlWMGxoS0VuTGM1MDBlM2dSL3N5?=
 =?utf-8?B?U2ZxOUVFdHdranY0RXg5VFRaUTFCZTNLUFYvd05WcHJ3a052SW9zZlFKeTBk?=
 =?utf-8?B?SURCcjg3Rzc4OWozVHRCR1djaVlQZW1kTCtwSnJIUzQza20reVZEL3JYWnRO?=
 =?utf-8?B?SCtFUkoxODd5Qy9pa2trUVc5NlAwQ0JVM0hDYy94RmpaTHJVdGY2MEpxbEZa?=
 =?utf-8?B?NGtnZS9BRUJweTdIay9COFpkT1h3VFlVUkJ0OUt1M0JwdEgzdTRkL0ZZbVBv?=
 =?utf-8?B?WjBDc3NPcmIzekt5cXZZdi9ubXZzcDV5VkpLRm45TFh6bGpKeVcwM0JTUGUz?=
 =?utf-8?B?SUZwS2hBN1dmWnRDMy9PRW8wUXRmQlR4eEtLbUZsL2o3KzV2b3A0QXNhdUZw?=
 =?utf-8?B?ZjNGSmpoY29tNUJFY0J1L3ZHR3ZoQzNtMVRlV3ZFN3V0bSt2SEpvTW9kZ0pt?=
 =?utf-8?B?YnZXdExVR1A0cTJnbGJ2eGd6M3h0SWYwZm5nQTJwSHRaRHUvbHhJRDB2QWdK?=
 =?utf-8?B?YVZwVEEzaU1CL1BlUEFkZmJLR0x0WnJ5QXp6SjRKRzJsQnBMVll1UzZLcW56?=
 =?utf-8?B?WVpSRU54dm5lYzkxNmsrSVlnemFjcnI4QTg3cDNMMTE2bE1tUExOYUs5ajhT?=
 =?utf-8?B?WWhnSUhxSlF2LzVwdjJ3VVBad1libUE2T1N3RFV3U1ZQeFVNM0llcjN5MXBh?=
 =?utf-8?B?U2JGRXlqOGRKSTRyU2IwVFV4RzRRNTNKd1phU0V6M1E2MHg2RGFnd3BGQnlx?=
 =?utf-8?B?WlMrbC9zMUFRTVpoK3pFWmJyZHJ2aUxvbXBqSHc2dmZ0czFWRlZiVmJsT1lF?=
 =?utf-8?B?Ums2MGsxQzZsaktiYUxNeHhJaTMxQkxvdGVYa3dTaWt3bnBqUXB3UEV6UmJM?=
 =?utf-8?B?Qk1KZFVCMUN5R1EweVhlTk1RcUUrVWRLMWxQallpVklySVgrcEpNbDJHV0pF?=
 =?utf-8?B?Zi9BS1l0MG4xK2g4dzlYejIySG93YkJoYTN2NGhsSjlJeWV4NWRCbXp0ejha?=
 =?utf-8?B?czFBdnIySWp5VWdrMUh2akM1YytaTEtBZEx6U2NpOXBqODlrRkJEQkZoT0F2?=
 =?utf-8?B?M09pL2h2Nm9tWVZHMjNIbFF4ZWtjY05LVVlsOEJoZlp3MG9yUkJOY2xsZU5P?=
 =?utf-8?B?eGxLbkdvQy82TTNSQ1BrRUR3c2daQ3FYWVZGWWh1NHQ1cmV0bVYvbW93ZWo4?=
 =?utf-8?B?aWNSVVNpZ0Jhb2hzZEVlNDhiRkpWUitLMjlyZ0NEUm94UGw2NWtPVFdFMUhG?=
 =?utf-8?B?ZThsUklDWXI1OVNFdDJva0N0eG1XcW5pMGc5MlppSVRMWTN5VU1WdG15ejBt?=
 =?utf-8?B?WFhUN1lEbDZ2algxL0RQM3hWb28zc01XTzRwTU5KUHo3UkwzMkdCZ1pZcmhE?=
 =?utf-8?B?STZ5aUdhakZuZ3RJODlCR2xGdWZxMlZOMTBHR045eCtscVpzdFF1Zm1aS29C?=
 =?utf-8?B?UlNISmd2NFJ3ckVLampTUmdLTkdFTXlLTDlVTXpITVd3WHZNNE41WGRHSFBv?=
 =?utf-8?B?RUlsUzhPUXVFeTVXcjQ1VlFxT242OXU5SlBOckMwVlVvQzhmMksyaTROWUNW?=
 =?utf-8?B?ZzBOa1hsWTNRU1BBV1p6dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlZKOWpiTVd0OURQa0pyamlwYkVWNW54am9LdndpNUcrWElGeTlTMmRMS3Fl?=
 =?utf-8?B?Zm0rZTk1TG9qWE81Z0JNSnFLZkZxTXBFQzQ0aGVoQmc2ZitjbllXdDVjeG1G?=
 =?utf-8?B?WjQzSkJKQmZ4R0JqWkpySXZ5VFpKWVZhRDNNWUtWZmp3MlJkekkrQWR0VSs1?=
 =?utf-8?B?U2U0eVY1bnFkVi9LMm1MdE4wNjRjeDl0NmdUeDNtOHBXdDRHYzM5MXZFMTE0?=
 =?utf-8?B?UkVxSHErQU94Ym9IUVIrVysrUVB3UE14OEhDVCtvWnBXN0lwZXVxbmpORllm?=
 =?utf-8?B?TVZUL3FTeU1BZHdoYk43QWpNZjVsZVd1Q3ZFRjQ1b1VaLzR4SVd0c2R0ZGls?=
 =?utf-8?B?d0JtcGFCd2hxQXdFWWRrVUVuQml3UzJmZXNrL3JORGhza1J6ZkkvZXYrOTNS?=
 =?utf-8?B?ZEV0ZlRNZXUwWno2WDdzYzIrYmlndDVZZFBjRm95NmcrU2pBZWhwKytwTDho?=
 =?utf-8?B?dThlVXpwTHRHVWtqU1N2bURwaDc2YXpQOHBDMnNqSld6VGtmNW9HWVRQNTRD?=
 =?utf-8?B?NkwrcXdtNGJoQUtSVzc3dEdwQlJJRXhJa2lKVDE0UGJHUnJGS3pjajlnVmEv?=
 =?utf-8?B?ZVJxSXV3dE9YNFRjYWpvZHRIaVBTNDNLaG5mUko4cGl0Y3VPazAzMnpsUmo1?=
 =?utf-8?B?eU1UYlcrUTVPZ2Y0dlV4dm42WUNvYzdnMlcyc0RZeGt5SmtSM29EWTFQM3FN?=
 =?utf-8?B?S3Y5a1RuT0tGZWZlb2J2S1JPakh3T2RSMjI5NU9EUTlJZkd5bjFHY0Y4ZTlp?=
 =?utf-8?B?MXh5anVvRFM0V2NyeGduUDB6d2Y2WWJKSmxnU3FxMzQxclF4dy95UjJROFJC?=
 =?utf-8?B?NEN1ZCs4Z1FXOCtTVWJYUlN2T2dQYW1BK2wwVlo1NzJ2WXc4NHlKVmFodnYr?=
 =?utf-8?B?blBXYURHYXpTVEdKQ2dFUGREblVXWTdkeFhoYzlDdjUrbkdqcFNLSm1CV1NM?=
 =?utf-8?B?RmQwUHNKQ3haeC9OZjQ4L0Qvb0Z2NDI1TWpQRzdIM0FpQndpQ3ltOGJMSWVQ?=
 =?utf-8?B?dEVja0ZqbXVUNERhTnl2SS8xN3IzeWFkV1JheDdZNnV0N0JwSEVvR1p3NEpX?=
 =?utf-8?B?U3hQYUhQdXRBc1F3bWpYdnhFK214c2hucHA4TUE2bFdvZ2Z6eGk0bzJTSzJ1?=
 =?utf-8?B?SE5HK0xrZEJSUXRRTm9zQ0hZY21Bby9wUXdWc2c5emxsZDJVRTU0QkVZR0da?=
 =?utf-8?B?bUdNUkxNdVg0eXJWbFJJcGtKb1AzRm9lTFo0cjdtQ1pnT2doblptcU15RGdN?=
 =?utf-8?B?TTlwNndub3ptZmpOcFNRRXFCbTBYeEVBRGMyYUtXa1pGYk9hckJ3T1QreWV4?=
 =?utf-8?B?UUhxdWg3OG55bGVYUW00R1JTbEFMQlVVZ2crNEVpYStvQ2FsZ2FCaEZ5OEU0?=
 =?utf-8?B?RUNCdUdGczFMR0RRVnMydmxka2pGeHFGSEhYaVRabDBpTXBZZy9GU0wxcU9B?=
 =?utf-8?B?WW9LYVgzYUhnT1FRQlhBZUdtYXFNMVZCUUNlZ0VhTE9LamhwZkRZNU11bGVX?=
 =?utf-8?B?NHU5Z2s1cGt1WVZjbTR3aXFBeCtJRVM3aER3Yy8rdHhKcG9HWFk0Q1BHWWhE?=
 =?utf-8?B?ZFJOQVFBZHltZXRyNitCYlV3U0VHZkFNRnh1djg3NFRHMENHMUQ1eDRoWmVo?=
 =?utf-8?B?L1hKelVtb0tSaGJDWnhBeC8yKy9DbjBYb1c1R1E5ZWFHRXd6SXp2SUtyVWZ6?=
 =?utf-8?B?cUpYeHVuZzIyTmRFQ2c0VGg2UnBxa3pKcGtpbXRVQ1ZtSnhwVkZWL1JjMmxr?=
 =?utf-8?B?UzduNXdOY0xmVEc1Nk9TRmlzQVMxZitQM2F2T1FlY0NnRTgvMG9ud2N6TUVG?=
 =?utf-8?B?UnMvUW5VdnRuelFuSlBUQjlMcStjM3BlUDFpa0hhZ2N2R0RTbWEyaDJQNlBF?=
 =?utf-8?B?WE9Xamo3Z0ZRTy9PY0VMWXJuOHNLei9MdUpxSG40cXpXWFR1NG9iNGdtS0Er?=
 =?utf-8?B?Z29QbHQzTjlXTTNiQWovaXFSWWt2eEQ3Vm9BcUQzTkE4NXF6OUYyVkhqOFl2?=
 =?utf-8?B?ZUZuakJTdmx5Q0ZEdE5OalRUR1FGWEVSQkhtaFJsc3ZSK3E4TndTenY4YUky?=
 =?utf-8?B?U2lSRGNvck54STJYUVFURnJ6UkVxOUQ1Rmg2TmVBWTc0Y1hBWjh0L2xXRE1P?=
 =?utf-8?Q?R+1yAo6oM7cFlO4mNYq12ZbRo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c81d9e-d293-4687-3c40-08dcd7165148
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 12:43:25.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhZTtnsTg29LkTpGLugeuiIuei1qSnCJJHShrxTEpjKqyWn/y88JELoe7IpCF889qnnatG1R04oTpFU8ZxWFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

Hello Matthew,

Thank you for the review comments.

On 9/17/2024 3:12 AM, Matthew Wilcox wrote:
> On Mon, Sep 16, 2024 at 04:57:42PM +0000, Shivank Garg wrote:

>> +static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
>> +					pgoff_t index, struct mempolicy *mpol)
>> +{
>> +	return __filemap_get_folio_mpol(mapping, index,
>> +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
>> +			mapping_gfp_mask(mapping), mpol);
>> +}
> 
> This should be conditional on CONFIG_NUMA, just like 
> filemap_alloc_folio_mpol_noprof() above.

+#ifdef CONFIG_NUMA
 static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
                                        pgoff_t index, struct mempolicy *mpol)
 {
@@ -739,6 +742,13 @@ static inline struct folio *filemap_grab_folio_mpol(struct address_space *mappin
                        FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
                        mapping_gfp_mask(mapping), mpol);
 }
+#else
+static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
+                                       pgoff_t index, struct mempolicy *mpol)
+{
+       return filemap_grab_folio(mapping, index);
+}
+#endif /* CONFIG_NUMA */

> 
>> @@ -1947,7 +1959,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>  			err = -ENOMEM;
>>  			if (order > 0)
>>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>> -			folio = filemap_alloc_folio(alloc_gfp, order);
>> +			folio = filemap_alloc_folio_mpol_noprof(alloc_gfp, order, mpol);
> 
> Why use the _noprof variant here?

I've defined the filemap_alloc_folio_mpol variant for using here:
+#define filemap_alloc_folio_mpol(...)                          \
+       alloc_hooks(filemap_alloc_folio_mpol_noprof(__VA_ARGS__))

+++ b/mm/filemap.c
@@ -1959,7 +1959,7 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t in
                        err = -ENOMEM;
                        if (order > 0)
                                alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-                       folio = filemap_alloc_folio_mpol_noprof(alloc_gfp, order, mpol);
+                       folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol);
                        if (!folio)
   

> 
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 9e9450433fcc..88da732cf2be 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -2281,6 +2281,7 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
>>  	return page_rmappable_folio(alloc_pages_mpol_noprof(gfp | __GFP_COMP,
>>  							order, pol, ilx, nid));
>>  }
>> +EXPORT_SYMBOL(folio_alloc_mpol_noprof);
> 
> Why does this need to be exported?  What module will use itI've removed this EXPORT.

Thank you for the suggestion.
I overlooked those details and will post the replied changes in next version of this patchset.

Best Regards,
Shivank

