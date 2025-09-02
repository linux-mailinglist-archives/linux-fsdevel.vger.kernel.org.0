Return-Path: <linux-fsdevel+bounces-60012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC3BB40DF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0A21B638FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4212E6CA2;
	Tue,  2 Sep 2025 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VRSQxfPk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oRIXwirS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C722DF152;
	Tue,  2 Sep 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841810; cv=fail; b=ZFYpC8Sq9zrynV4DhgPLWqbrKu0xaSFPsEEkw/h2/9qxpWxPog67RDLNhQ2INvNVkagsWVggNAU8OjN/rNHu/6j0opw9uAdeqOT5s/qny1Xw9q1YDAvm1HLjgWSviaGaYAZn+B8I9J+IiV6LGjLBvYuXSb2oW1/AuP0RwQsaf4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841810; c=relaxed/simple;
	bh=RdFvVV+vkZmKEi5KdI6OnkLbv9UQLCGeQfTWzetUMEM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PKUTgLocrnopq951FdxJiu+gnXKdxbcG3pGLRWnwYg0smfJAnUcGkD6hXGZ5a3DdWXEXL+61J91vu37pdUEBWH8/aXK2dqMuUrYu5ionJh1ZJM9LoDS2uuTzt/+VEpz2bctM+kpEZ3dtWgMrEuwKUbXffDh1sAUSoo1XbXUOeFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VRSQxfPk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oRIXwirS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582JNRk7007557;
	Tue, 2 Sep 2025 19:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QBSlJkxCw9Ey+W8WdaR8UWWRF1A9uZiZRBWROigzzD0=; b=
	VRSQxfPkY6EOlYqKTURQ4bjlFGE/W0xYgKy8R/gp5cqS1hTwS89fCBeSlQShNHei
	+uj/VBwp04clbcU5QTdU1pcATd//FYNX0PxZjFh0l5xM9IFb9hEnUUe4RvnGAS5p
	KEVMEElEHoXHFN8f9ViqSY7CZCiRyh0El5aQEVy8Rgyl2mbah6zZg2cIsHYkvszl
	b9xOND43lMs0FAROIOJBsgKtEy+8I2nwNLUZfBZaA93xx+oVrUENUIiAWN2qw60F
	4+Bg5vvH5UbAYncQ8DPnDz7wq9Xin/efKOjEnPyVHo1GKERvba+aZbjv4C1+/n8Z
	evOwlrej2pd0GLovv0GVPg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnctqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 19:36:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582IVII3040758;
	Tue, 2 Sep 2025 19:36:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr997fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 19:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yo1S70j2/hT8PKwsm8b0CCOLU+AEwtnmHQTf6k8fmj1UMXE0OLdwbx/onRtD4+evoL9yQ8oVlG46hS+z/0uecT3ZQ23PgGZ6KskQNbmaf9PhaulFhhryAXFnQ5j3IURfx6KZdWgcBzRPXNvxLOtt0M34cf3IuOrA1YlX5g8VSO5QWqvXdhR5fWH08Nq/mxdsUaTJ4W380rRjCBp6tfuI0cwRDiudvFN1g1z/gRNMu1rQ5ZtXF9PNyTVHQIKCn91mZPRZ3ba+kZzOmiMQwnm+E7m5r9fLOdVb7UatZ68K7DoWnp7l0e9ZpmTjXQ0yKiZ9fB8yavOmf6nJTam+bV8GtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBSlJkxCw9Ey+W8WdaR8UWWRF1A9uZiZRBWROigzzD0=;
 b=ulaWgCMpDVGVLrzP6sV4fI8I91AuTui49ZkEVgUbccQdydr5QTHeEbKn5npEC7hoD+XoyC8s2E5122MbjtyJZUi6DQBeffeDSAypbWmtKD7IfBKunSH5sDL7F+1w5neoywxF7qJUwQSvZ5f00ipZE0P6VxVmDkxAMN3oIB4uhQqYvn1fYExfYK+E3Sjv/a1ypmuMxJo3i9ueAXI7fPCbU2zvv/3wbWr4T5y92msosVt714FdNM4NGn27qQrUiVKnn4Bv+cWpMhyPPFV/PxgWn6b2OP9ba4ke+Vp8OI4cMcyUpF3oG54feJMVH5m23textG861I6ZZU3gspGdCQsWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBSlJkxCw9Ey+W8WdaR8UWWRF1A9uZiZRBWROigzzD0=;
 b=oRIXwirSSd1/CSm7UPoB0LlUaaDgUWBX+vIBHzZO+EAemhMui0uMe2Aa0JmReTBGMtf0s2HEkywy5VFglgMIOyZGXpE0qjoFoZsWPJdhF7nqkH1XwtoeKOc0LzvRIV9jW2IwhHhaPpkhltLRdLGuDrX8i+RKSremM+XWcScE4ng=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4649.namprd10.prod.outlook.com (2603:10b6:806:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 19:36:26 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 19:36:26 +0000
Message-ID: <bd2804ce-2d81-4a39-9623-32fb2fbf5351@oracle.com>
Date: Tue, 2 Sep 2025 15:36:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] maple_tree: Fix check_bulk_rebalance() test locks
To: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
 <20250901-maple-sheaves-v1-1-d6a1166b53f2@suse.cz>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20250901-maple-sheaves-v1-1-d6a1166b53f2@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:510:33d::33) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4649:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac08a5b-1fa6-48be-5572-08ddea580180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWxIVlZ1VGtTM21xZmhxbDVpTjBkbFR2N1VWYVd0ZXgzUE1udFlYbTc5YTdT?=
 =?utf-8?B?VFJ1UStSelBCbkx6dXhxNFMzblBSRkVyajdpT3JPby96RmRPZjF3OFpkRHhr?=
 =?utf-8?B?QUtvcmhZYmZ5SjVsOThpUjZVT2hscDdFNFluOFhHSElDd0ZtQ0QyRktoZXhO?=
 =?utf-8?B?aHdNdU9XZnlYRzBFN0JhSW5nTndzTTZpWFcrK0ZCa1hreUl2NjlSd2UxNjNF?=
 =?utf-8?B?dWtDSXpXSStUNDhtVEdRbnA3eGxhM0I0eEtsVklEOXhLL1BMN2hoR0hzM3NK?=
 =?utf-8?B?RTRXdGNnV2hsQXlYZjRvVndlVWVUNkZEdVNoR1dlalVhMlRhZWl0NHBTVFJ5?=
 =?utf-8?B?RDEvNmNHZTM0azcwNmNTNlViTmhNc3p2b2FnTFV2OG1tdDYyRDk4OThMa3c3?=
 =?utf-8?B?RjNIK0xzdUxHbzZTbno4eGxjUVF1dmRUOERpdDhoK3RVNHV6eDI3WVc4VWRt?=
 =?utf-8?B?TjhJcnJ3TktQNHhDRmN2NmhENG5yalZlamtKRSt1VWdDcmRMMkh3SVZnVXlU?=
 =?utf-8?B?MXcvZUxXeEV0bGVjUXVtazZWVTcwVmEvVFNTZXhTYTVPNzNTWGFTc0p3cFJZ?=
 =?utf-8?B?aGhGRk1rdk85cnpQblhKeC9XY2pIN2gyaXIvZEVtQnhEczgrL2ZjMkl5MkNU?=
 =?utf-8?B?QXFubGpNYlBPUVFXV3ZXTDh0T1Zxc3hTUzAvbmdzdkJ3RUUwSnhXcmJRQ0Ns?=
 =?utf-8?B?SDlVQnlrdTBGVU5Ra2FoSllIUUMyZnZxZkIvSzBiRFpsK2xYbS8rbENoRUtt?=
 =?utf-8?B?UjNyMmcvTTlBSzRRTEQ2RW5PRU9xYW9zL1U1YzJlTVFkRVVHZDc1NmlLTkhO?=
 =?utf-8?B?SEdveTZIbVhIbUNlZW5RanEzWVFra0JmUjRTSzgyZklrTUJxSUc3VzlKcTJ1?=
 =?utf-8?B?c2FheGFjcFVVRmRKanp0RjZ0Vms2Qmh1SHUvOVVsa2UwVTd0K2FrTnliVDZH?=
 =?utf-8?B?Z3ZERWIvbGk4REJwdStsY1p6UkdPQm9Hcjg1cVlLMmJCbjFkZm5jVnU3cDFv?=
 =?utf-8?B?ZW5xOGgrQy9tM2NBTkUxamF0eFdkR0FqMXAvSGVTS3NDM3ZQd1ZZV3ZSTE55?=
 =?utf-8?B?RGlTQUhWNElPam5xV0phRmpuV3k1bTNFTndib21UaUJYWFRvRi90NTI1cUhu?=
 =?utf-8?B?emRjbU1pc2QzQVQxTXBscUNWb2ZiL3FhNk9CU3JoZHhvdkg3M21NbjRTYTJ3?=
 =?utf-8?B?MkhuSkROb211QnJBTGVTUTRNQW5LeGFUVGdCbUF5WitjdXhIK0VEQTF0bDMr?=
 =?utf-8?B?SE1TdHE4WGdYTllwazdjLzZhaDF2SW0rUU1wd2VvWXNkZ0JEd05SZDM2alhQ?=
 =?utf-8?B?anJrRmZhb2F6VzdTWU5mclRZWmpCZkh3a0NBUjFkVldiWnhZZ25xcEUwck55?=
 =?utf-8?B?K1pYbFhVUEgvY0JBTTl4WEcydVRQS2haUTVmeTlzbUt1L09zSlZSVEc4OVY2?=
 =?utf-8?B?WnR2NDdpd3ZuSFlZSkt1S0lBait1YXhDeS8yWXZJUFNSSHRDTVNuK1YveEVC?=
 =?utf-8?B?a3N2T0dNU1RXTEVaTGlMOHYraVJZZDlpWC9XYUVmYnhKVWdLeUVTWTBEMDB4?=
 =?utf-8?B?VmFrYU1zZHNuT1MrVXMvUE5LbkhOVVN1YXFOeC9TQ1p1WE5hSHpVT2Z3KzJq?=
 =?utf-8?B?OUUyMGFGWGJ5UVlybE01RkVvYlN1b0ZxbmtpVURabHZWUkE2UkJNNzF4Lzgy?=
 =?utf-8?B?TzlLdFJVWXhmM2Jqa2Ftbjd2Sjc4MElTTG1MYWQzZTlJZ3VKSG1nMzFxTTZt?=
 =?utf-8?B?a1Mxc3ZPMnUvdzZ2ZXZ3Sll0RmZ4RkNNUk5VemZES2VCdGZvdHAyRmJVYzFl?=
 =?utf-8?B?UzdUVGttSHI3RkRXeFVsamtFRWFPV3pPWkZMR2RsOGJ1Vm8rd2dlSitJU1Fu?=
 =?utf-8?B?anFqdTVZSjZQdWhRRDNjeGhDNVJDMTdTSERHWnRreEpYei9acm5KbjFWZE92?=
 =?utf-8?Q?XG9QrUVjmqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHh0czdLQTloZGY1S1ZMZG5WL2E2c3dyRzdJMVA2N2dTbWJUNzRwVW50bnFz?=
 =?utf-8?B?QVJSTElJcVNRMjBwN29RSlNZNEFOa1dZMklicTkzWnJReFpxSENjODRScyty?=
 =?utf-8?B?dkdGcStTRGZMblU5Z1lKQ3cvRHY4NElXNDE1MmJFK1NlRjE2SUIzZDZMVEN1?=
 =?utf-8?B?ZmhvM08wMEFDZFlqSjFyanduMVNtZ3g1YUhqdmxSL1VTRkR4Y3phNDRoNnUy?=
 =?utf-8?B?MDhoeHh6UE9WcExwVGJUVE10TVFLSWdFakRyUmhNVWlRVWhvN3Q3MXh2RnAw?=
 =?utf-8?B?L3Yrc1lqbnpOZG44YzVab3k5aXB2WTZ3d2o2WWl6Wkc3dVljd0FPZVJKZG96?=
 =?utf-8?B?Znl4eHJVNHFFeUdUUWoySjhLV3pPUFFLZVE1aFZBd0FUaGdzdURYY0FuU3VL?=
 =?utf-8?B?emJSRE0xS0JPRmVteFNFY0t5SlNtOXlMVXVESU9SUDRLUEdxaXVYR0xva215?=
 =?utf-8?B?N0hXd1VkZ1BuWkE2NXQ5cG5vSmpEU1lHQW5jL1FZcXc1REFlOGV0YXFQSFRm?=
 =?utf-8?B?SnQ3WTFOVFUzQUxPQk5VclhEVkQxeStXYkRFNm4yT2tqbGNUVVpiVlFlcWF3?=
 =?utf-8?B?WHN1UERkdjF2Q25GYXhuQWF1TEs1TjBKazlaQkl2UVNnSkxrK3NGeWVjbEw5?=
 =?utf-8?B?cnVqRnBxTWY5OEIxYUFxRnlyQVZlcUlxZmgwYXF6WnVDaWdRcyt1ckdBUXFC?=
 =?utf-8?B?WkpwUmlCbDRoOUdTUG5JTzFWSEdQTVNRQnR1Vmk5MUlsdkoyUnZManlXSG9K?=
 =?utf-8?B?T09tTjF2U0NTUEFTM1NUV25IR2ZFS3E3a21DeXJUZ000enB3eDMwYTJrcWVw?=
 =?utf-8?B?OWFRTndNYzhpNS9SU25qSklick81cmlZcGpQaHJtdTFPekRiNlNpNHBlR1Fm?=
 =?utf-8?B?UmREdUJleC9keDZqckJYZEp6MTRsemVZby9RS1A1YndVR29qZE5MY0h4c21R?=
 =?utf-8?B?NXFJMFZPU2VhNWtoY056bURGQVM3Q0ptcHRLeloyV1JsaVZGeXZhWWwrQ0xX?=
 =?utf-8?B?ZWRHMkVPNnR6ZFZ4U0RHN1ZaNlJmQ093cDF4U2NDWjMraVBjREVzWTcrUlRq?=
 =?utf-8?B?Z2NJSDJRa1ByakZQeXI1VjRjSi9IWEhORUZsaUZhWW1teHJ5Smk2M3N1dUxT?=
 =?utf-8?B?b01zeE8zOTRXaVdXMCtrS1oxUVBrNUY3SVJCcDR0VERxN1VkNVNlRm1LZkpt?=
 =?utf-8?B?bjJaRFBpT1VsTG84aVM3WE1VK3pZaThldzZ5dnQyZDZLV1RWbGwxaHlLd3o4?=
 =?utf-8?B?Q0JpbGtrRC9MaFd1L2hKamlRZERiZVA1OFdEb1VLMGhtMTBDWGppejVGWDk1?=
 =?utf-8?B?b3dDVnB2dEg3TzFnOGVwRVcyRE1vcXlJM2FJSTQycG5Na3NZbzVqVm8zVzZT?=
 =?utf-8?B?QVptODJMZnVDbzZkZTZhSFNCWHNrZ0t1MXZnL1R1eXlVd2JQSzdCdy9laGRt?=
 =?utf-8?B?T1RQSWsrK2VXRXM2b3hySkFLMVE5SGZGYUNRVDdmd3luM3VxYzhVV3J6S1BL?=
 =?utf-8?B?NGdVV25UYlh3UHRtVTlYeVJDRVAwRmY2clJnYnN6NHh6S0dOSnNmZ1JCalFF?=
 =?utf-8?B?V21mNXJUeEp2WkV3dXU1MUxrb3M3OTZ1ZXJTTVRTRFp1eXBQaXRIcjhkZDhv?=
 =?utf-8?B?a2diSmZtaUVXeXJwUGwrZjc1Mmh1OEVHMkxRUGRvZ0JTTzBwWnIvQXlHQlhr?=
 =?utf-8?B?bXFURnBhYWI5TWNWSTZyTXZJcUFzTFA0VklxRnBXemtKRjFMYlVDRk5BTktx?=
 =?utf-8?B?aFQ2YlpPTWxheUM0VEFSeG9zSlNxWGlBc3lrVm9pT3RpdHlsWWdOOTVxQ2dX?=
 =?utf-8?B?K3BhcmVQbHZGczVjNld4WjhDSW40b1ZXc2Zvd2dKRFRMc2VqWmgzSWJtNFdH?=
 =?utf-8?B?R3BXYktnaGpER2FCajhTSjBHNm9uUzRWZGg3UkcwWUJnUUFVN0VEeXd0Slp2?=
 =?utf-8?B?enlleC9pSllYZVZBaThzY2NsM2U4dzczVjIxZEZzb2VKOWlqWTJzeDlwcTdt?=
 =?utf-8?B?cTFsYzJQRGJ1Z3ZpVUFQeVBnTFBSMTlhUVFaY09sNCtRSWp0dzF5T2s0Zm5J?=
 =?utf-8?B?aWlORzRSaVNOQ0ErTzVKbWpvR3B2RFo0K2k5OU1JZHlyVDFNM21FdXVzdEZC?=
 =?utf-8?B?OElCdlBLeWg0TXlvOHpYR1dQVnlmU3dwVnNGQlMrRE14KzhGYTFaZlNNbUNm?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q5mHVTyiMHXZtrV5KYNMZ/GkJoLPUzQppaak/gE9StCfjUgy2BwWjtFIbPpfwzSHlMNBCveasXWioKyHL9Ob6qPEhQCfzKG6XCbZ1oEZ5Nvs2U45sK8nDkaj28ZJfoVmI8H84SNO+sXH9HGS2TZAelZucOI+7EgQmLIwUikDZdC8tsv6WRsirt79msXZAQ6RexglqXSbn3bbi/hS0GZYAJcS3Pjm5KQVkUDyL4ZwR1vA0hhVn80IwOBJZwUiSw2jtzu890hVc4SKbCPdmD5xEyYte/zbEnavT0p2H9SXGNgWPlGmhBxpDeqagbV5jdXjZxfzEW+pTST+uq9+qnD+TwOu1ir9AoMeeo0Stj6Ii5dRzWP3nGuPq2xAe5ApCH4QhixopAw/XGpcdMjzd/LqUrfEosgLAPk/dskqL6d0rSORqgbr8BdEPMWgqKN6wleTY4iTE+8QdlV1W9ovhdygo9OckLoPIDZRdbT1EKMC7acY9kSZlpdsbl+nA7bY5IXyUrrQDJJBdkuyIn/4EMINPeApoT05wDOz6PMECy39CmqUCditTX8HSUzTN949GcMKMUVoo+FKvBGWROf9+V6THDc1rH7RHtldA2nBDT+UPE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac08a5b-1fa6-48be-5572-08ddea580180
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 19:36:26.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7ZnTJh7bn9T/gssMNPkWs8MY6AV6VEY2ky20iFUmgj44IByX6hAeIdL1cK9cMjtfzeDfIh5yRYQ6bE+JCKIRKOPim6OYpidEmb2ac0u5gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020194
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b7473e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=j-QNOd_GMMRpenwY-0kA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HY7aQTC3skS70qsccKsZDl4SpExdFjLG
X-Proofpoint-ORIG-GUID: HY7aQTC3skS70qsccKsZDl4SpExdFjLG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXxeun3ffYDXcX
 ZCL3+KJvjIP3mJqTf1zCaFzJU8+8sUE9nXato1aSOEaAepF1812bO+Z7Gq9IUIEmy7ZUP0Eml4i
 MRplXWXC9FiPHHFXa6dlkMleigNuF0sSRLT6BVxSeKfYHE7ZEVewxlbUF3Y14jeMcwiugXgXGFE
 wozOh7JxstYbRJSDecM2wNeq99LYZaRQe47sQdBy5qOIz40KMF5He9dZ0J2NgdcV42bXYB4wHuV
 p0+5+dH4v1hhTJeUZqTDJKg+uUVClvCBARIfIE7KdTWBFtc1zZN6i6GAsKVLOigaiAwNGI/ULaM
 vppFOLusR5G5ZoTAyGROtp2KFMbN3CCCG4WQ5L7sLyE3ybJ42cNzToVou//8qe9DftH8DRT/N8S
 0ksbJoYA

On 9/1/25 7:08 AM, Vlastimil Babka wrote:
> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> 
> The check_bulk_rebalance() test was not correctly locking the tree which
> caused issues with the sheaves testing in later patches.  Adding the
> missing locks fixed the issue.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

If needed,

Fixes: a6e0ceb7bf48 ("maple_tree: check for MA_STATE_BULK on setting 
wr_rebalance")

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

> ---
>   tools/testing/radix-tree/maple.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 172700fb7784d29f9403003b4484a5ebd7aa316b..159d5307b30a4b37e6cf2941848b8718e1b891d9 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36465,6 +36465,7 @@ static inline void check_bulk_rebalance(struct maple_tree *mt)
>   
>   	build_full_tree(mt, 0, 2);
>   
> +	mas_lock(&mas);
>   	/* erase every entry in the tree */
>   	do {
>   		/* set up bulk store mode */
> @@ -36474,6 +36475,7 @@ static inline void check_bulk_rebalance(struct maple_tree *mt)
>   	} while (mas_prev(&mas, 0) != NULL);
>   
>   	mas_destroy(&mas);
> +	mas_unlock(&mas);
>   }
>   
>   void farmer_tests(void)
> 


