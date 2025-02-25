Return-Path: <linux-fsdevel+bounces-42586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A81DA44696
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B627AC321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6C19DF4D;
	Tue, 25 Feb 2025 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rz0CVkNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BB194C9E;
	Tue, 25 Feb 2025 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501686; cv=fail; b=px0VUf0W6Umt0TE+uRhNWHNqPTFb2s1uNTxyo13zLoNtxVtVBxi0sOTo/Fuk0hStOlWZ/mqnKTTlJyQ6xo3gtDK2FPbMef/XIaK5Ermrhn2H4eKeQX+46iLdyFh37oeldQOj+kYakuonmv0zRdzPl18/LYignTl8HiCDeERMQkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501686; c=relaxed/simple;
	bh=zny2H2JkmneDOEtAdzTzXEkCGtSExc7fdjA8bFFcw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N3bxroBpMKN8oItFgSIEIMPjpTuviCTTgweLO6KfQC6askSYneHUDQC7QRTGFYQQxSxXEKiEA1qZQ4i4MZlH9yMk4ZJjKb/K8DUl1e2bC2Z0eyTLfjvb9CO8rQWI5sax7SC9AcGI93xIfxh9BFFcJBpCMXgGrj2E/KvQ/H3alAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rz0CVkNX; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntndbm8ALjjY3npGbrw+6tBdQBrY0EBHwmvbcBgiTDc7WLuuEpq7Gk312MsVyF10sYIPhM/J4T5BVBJaivi2zR/Eqgug4RQnAyiZzs0xm4WWIN2ydfsBMWCXiRepS3WItmQSIizChsXEsuqZvxBqVXj8Kpt/stSXRNcmpJiW7gb7MxgeVIH/OcLVajsYA4yqU3723mznq7GpaSHxZezBCiWgCexyUXnGP3MEXjKys6QDailNAlIYLD+67W1OI+Pmi2JIi7m5cU9Fv2Ubd23M8ybOmI24AZaCZdAlg79Dd+0ytMcJCJc+p0loJCrHoDsIFi9N2hqIQ38eed0gMKSY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zny2H2JkmneDOEtAdzTzXEkCGtSExc7fdjA8bFFcw8U=;
 b=rKIRsz30VoUbaMxrezYfr4ONXPs8wefT6Cvu4/Xk9SMn1805C6k/GhjcytpQu4COyTw/TIhvTf+Qs3UQgKLqpzLG10gYe+0Dgsj58UasPW2rAp6ORx/10JAm5wsBJiywysqBV1u+c4errNypbFEzZVv5hXTzB3hG0f3HXxHg3TqtcTrH4Ibxd81N5Qwth2CfCe/5MPiBGnjL2FbMKqb82rE1Zv/3iHG0OMc6cXMPByesTa6ZGZ+8Y0MMHY+YxnKn4gTLl7B1MW+eUzW6w4E/aFGKSruq/SfugijHroKR/J1gDtbjWEdSw7jes7uNu3DioZae6H2DuLM1KQi8Fl+1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zny2H2JkmneDOEtAdzTzXEkCGtSExc7fdjA8bFFcw8U=;
 b=rz0CVkNXGNTGEZ2Z7r/zR96bkDG/OE0whG4kvzjkqN3DhT895voie1brdsBOp6ssyyGHTfYO2rcItw8EhhRG8OGEsXgS+168uea9nN9IGikIHIx97kd/jZMXZi781RzI0D66Wv/xi58Yjow6LWUXeR5XXg5IEG28MliBenNWmm+GUpI2ak5ByUy3xmsshcGBGHukgCMZ4Fqw+hY/yTTxMXOoOnkxsdGYAlTujpNlYVmgli9xqD4fUqg/UWbjBmtA56zU7luzrvSfiA1PMlBMQ61IdPCfzkVOf1QnLOIn7+m3961+BtmuemjJGG9sBBXlKu2DC+UapNfrqNKATljxXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 16:41:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:41:20 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
Date: Tue, 25 Feb 2025 11:41:16 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <C643A2FC-316F-4AA2-8788-84E5D92793F2@nvidia.com>
In-Reply-To: <af6122b4-2324-418b-b925-becf6036d9ab@linux.alibaba.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
 <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
 <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
 <37C4B6AC-0757-4B92-88F3-75F1B4DEFFC5@nvidia.com>
 <655589D4-7E13-4F5B-8968-3FCB71DCE0FC@nvidia.com>
 <bd30dc5e-880c-4daf-a86b-b814a1533931@linux.alibaba.com>
 <af6122b4-2324-418b-b925-becf6036d9ab@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: ada58dfa-9350-4237-4f28-08dd55bb3b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnNLTWc2WE5CcUMwa3Z2dTVCb2VEVTh6c0dxVG9xRFFHakNudFBDcTVQcVdt?=
 =?utf-8?B?RjF5OUh1NDFpNm1EOFh1R3IrUDhKbmVFcUx4Mkw4dWIyU1dTRVI5QUs3VU40?=
 =?utf-8?B?Z0dwc2FxdlpQM2ZFV1hXNk8wc1NvNjlQbCs2OXRXU0pWd1ZzYTh6MjNVb252?=
 =?utf-8?B?Vm1OaEJpSHBaS090UWIvWVVPLzN0U3p1c0RieDVvc1UxSEhDWkQ5NUpBOUx4?=
 =?utf-8?B?NElCQVloWW13S3dQNFhlWWM5cDg0cnU5OUF0SGdYQklDejEzYlJjTE80bFlz?=
 =?utf-8?B?NHRDNjFsUUxpQUZZc2Vkdm5vRDlNOHdoZjRaRmc3S1gvQlBCZEN4bGYxa3VD?=
 =?utf-8?B?alh0VElnbzhCdC9sM0gwVUloT0JaeU9wNEhQWW0rUkgrNS9oL3YyS3gwTG9K?=
 =?utf-8?B?RkY1MFVERE0zdE94TkJ0SGc0eUdzckxBRHVaRnk4YndqTkd3cXNOZjFNVDRh?=
 =?utf-8?B?TVMySCtjdHRyUmYzVnMzRzNsZ2JUQ0JGaWRzQitEWURNMG8ya2cxeW1DN0Rx?=
 =?utf-8?B?NnplZTg2V1pNQ1crNm5WSXVzaUQ3ckdQY1ZHaXpQU1R6bHl2RGg3ODBxaVRh?=
 =?utf-8?B?Yk1EZ21Gb29ETUhxYmk4WHc3RE9QaEZoRkV0em9kOVdDZ0JvWVpQdG83WTc0?=
 =?utf-8?B?UHZaUmVBVDQwTDVqZHRLVldFRzlhWE9kS0RONk9OTDUrdEhOS0N6NzBxbStH?=
 =?utf-8?B?UURwWG04Q092dTZVVWhMZmJLV3JFNUFoRU82QUl6dllQNXVMTDFZVEU3S0dY?=
 =?utf-8?B?WkhXTDNaOW9wdTFwb004YWx0KzF1VVN5N0t3bDFld1RkSmdpbXVxSTA0OTMx?=
 =?utf-8?B?TENpTFJJQzczN1gxMEVRTEwrYlJSOXkwUDJSRVdkeGdlZzVidjRrNEZ2Q0RD?=
 =?utf-8?B?YkFSOWQ4bjZ2ZThHdzMvTllldnBDM2prYnVpWS84QXQ1aG0rTmZsQUw2NVNP?=
 =?utf-8?B?MldxdEhPTndKK0o5ZzZXTDlpSDY1R0IyR3VqVE5YSzdYODlKQW0yTC9QcDEw?=
 =?utf-8?B?YmtLSExCSHZZSkNCaDN3N2hQMGI5d2dvT2k1MUpLSzh0b2hscUpTNjNNeGly?=
 =?utf-8?B?MlM0ZDhUYmFNWUlQLytrUVViRVo2REVCZUZxQWZNcWRxM3RRbmE3dXA3Q1FF?=
 =?utf-8?B?OVRSbG9ac0lpQmMrOTFFbWFsTTNaWDlHRmVXZnpTZmtRKyt1RFFlVFVJbEN2?=
 =?utf-8?B?OHE2cnJtc0o5NVNneFM2QkxVbkU4cCswck50ckI5RHNTNG9BSm5nbmlXSnJv?=
 =?utf-8?B?VTc2UHZEWldFWSt6cFlPZElYUGlSblk0d0ZHN1Q5TmY1NERUeUFuL3IwbnRa?=
 =?utf-8?B?TmdwQlpObGMzN2U5elpUUlVpaThyMWpOUElkMnh6OCtNVXU4RFp0TjdyZE9j?=
 =?utf-8?B?RnlQUzZsejhmc0NnTHZKSDVCMDhZcWo1MjZKREI0amVUbFVDMmFEUVZjNkVM?=
 =?utf-8?B?VzN2QWhzRnczMVROdnIzNUxpUWNyR0lrQlBIc0d4Q09wbGNPRVM5OGpUTHZO?=
 =?utf-8?B?eUt2Z1JOdG80TzkwWWJPb0dvV1dGaE0xMlNwSGNuQkdpaENjUnl6QlpKb2dY?=
 =?utf-8?B?WEwwdWtMb1gxRFgvVlUvSjZUdDFoektTRi9MUlpxRGFva2EwNnREc1o0eG51?=
 =?utf-8?B?VHdlUEl2Q1gwaHNvQ2YrUWtmMk1YRy9IUEtIRmlrbndPckVLbWdHTlNaTHBx?=
 =?utf-8?B?N3NxVk1xbmxtRy9wV2RnQXdkYUJ0NnFLOThMeWc0aGFVV3JKTkxjdDFiNTd5?=
 =?utf-8?B?ZU9UZ1VGWWlIRllVdTE3bFQ1T3djSmM2d0lpQUVFUkZYb3FJQVdhT0dyWUVS?=
 =?utf-8?B?RGwzYnVPMitqc293UkcvRXRyZEgrZktMSGl5MVlYdUlScE5lakVQeVJ6aUI2?=
 =?utf-8?Q?z/2PiPBTJpJWO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHZIMTF1bi81S0Rhc3AxZzdoMU84Y2UrOWkwZERHclFydk5SWktPeTJxRUow?=
 =?utf-8?B?RFFMR1FPV2tjS3hwb08wL3dTM2VCU1ZqSTljMVpFODRCaWZOT05YemdmeWdz?=
 =?utf-8?B?anJSb1BKQ1pDZnpQM3RjdE1jODhsWVVjS1VUMXVpRWdjQWpiRnJNTVo4QUZr?=
 =?utf-8?B?WlNzVk9BbmRCdTRDb0FMbHBqRG5CeVFodW1uYXdhY21PYXdISkc1RW10SzVL?=
 =?utf-8?B?dFAxN0xJcVpsYmExUThnbmJMSnFUMTI5WUhmMzRvbU93cUx0eG00R01ZN2ZW?=
 =?utf-8?B?OURweEJGWG1FTzVXeEhHVmFGTWorNmdXR0dVQ0pnZm9DRG9mdVVpTktIK1d5?=
 =?utf-8?B?UVNJSzByODZOalJyZ211TktMc2Z2TUI1Zkd3UjNhWkVUTGhPOUVUcGY4TzFk?=
 =?utf-8?B?Q0xpVDdRRDc0eFlTN09FMUs5dFJQQkRoOU1PZFZxYkNyWWtETTArM0hmQVRF?=
 =?utf-8?B?VDd4MnBja0Q1bm1RTktZUDN4dkRCWkhXNWx1UjVEd0hlU2VqbVlWaU5rZW9q?=
 =?utf-8?B?eFN6SldFS2VPMUlaY1A1TDdkWWNNRGdZWEFDaU42OUgxZVc4K0NmOUgyMFh1?=
 =?utf-8?B?RDRTVExjUjJBa2pldjcrRCt0SWg2YjFPQ3BDcjl5b2JjNENrSmNoZTZBVXRs?=
 =?utf-8?B?Vm5NT1JRSk80V1IrYTRBTDRKZFVVTGo0VFNESE5oSDlCQm1xeXY5LzlWa1o1?=
 =?utf-8?B?dW5TRjVjbnM3czNNRitLbHBRNHkydFdGZktCUER1ZzVIcDRZRzlNOER2UWNR?=
 =?utf-8?B?SUR0SGFTTFRleXVMckw1VjJtbFpidUJObmRSSjFGMGNMVG55NitVSVAxemxn?=
 =?utf-8?B?WmxKOWEvQmh3VGRqbUtuTnFJYUtscDIyTU5nd3VjTkdjSkRUb1NjMkw2ZnBF?=
 =?utf-8?B?dkVmUHl3ektsQlg5TEVZSWp6dmk0Vk9mVTFhV1lSUUk1RTA3MG9TUXZRU2FS?=
 =?utf-8?B?MnBlL1BzNCs1Q1VFWTJpMGdPcU5FQitZSStIRXdCUk9DalducEEyZmVuMERH?=
 =?utf-8?B?eHBuOHJqaTFid25uWmNTSjBOUHlxWUg3bmFWYmpsSUxKL0NyNEgzbzZDbDRF?=
 =?utf-8?B?U2lsNXRQZDBhR05yZzZoUE5wbytYZ1ZPKy82ZENLN2xEWERQalAyVGZFT1lv?=
 =?utf-8?B?NWV5cXVka1RkeFZxNFZ3SjV5QkNmWWFHcjVNdDZFV3V4d3dnZllPYTliQ0JV?=
 =?utf-8?B?S0tBWUpXUTJYTFFUMkhEKzVSemE3aGF5MjhReUFXbzNRSlRvdXRJMTVrM2J5?=
 =?utf-8?B?Q2wwVFMvSkhWZWtVYkVmbCtqN0xDdktkbTVGSDV6czJuSDM4MmVLMEg3TEsv?=
 =?utf-8?B?ZzZTcXdaTnFIN2RsQ2RKc29BWnhPamhzTXBnWm1aQTFUQ1pQT0p0cjdXVG82?=
 =?utf-8?B?RDlYMXEvajg5dWxtc2xpSDVXYTFZcmNDWmhuclF5ejJDOVpPaTdXMmZpbXgz?=
 =?utf-8?B?QUpBZjF3K0k0L08zeFBhL0taYVBqR1FaeDUvZEZLWE1QNVpDelZZQUkwMWFR?=
 =?utf-8?B?cEIzYWRZanBDeHhHOTh6ckMwOHVhb2RSa2pZTjkzTkhMVHpETkx1ejVuWlhS?=
 =?utf-8?B?MmtyRjM3VU5MQ0E5VFZ5M2RscWorV3R0bkVPZmJXb1U1NC9HVE9lQkhxVm0w?=
 =?utf-8?B?MEhpSithT3AyRHE0VVJad2NuM1EzUXgvei9hOE9MZjV3b29TNkpadWRmdlQ3?=
 =?utf-8?B?M2t1b1lMZ0FySXJYdEJaWSs5UWpURWQzcy9rZHREWklDYmhQRk1vUG5xWUp1?=
 =?utf-8?B?NWMzbm1NenZFM1NCRHBOUDNVRnViOTF4YkU2MVRha3hkTGRzckhyQ3MzOFpi?=
 =?utf-8?B?QjVYUEM2di8wL1FoK2pTcTIyQUs2S1NoL1UwUmxhQkw5S0hxcS9JNnpiUE5y?=
 =?utf-8?B?SE9zbUR0b29CS2VmMlFiV2Y5Q3VtUVZlcUhDSEl4MTNneEdRQW1xa05YMDYy?=
 =?utf-8?B?NVkrdTE4cTIxdlNLeElXVWdiQmZ6Zlh5ZmFuK0h5L0hDUmhuR2loS3YvM3Na?=
 =?utf-8?B?SHp0VHZTVHF5bHpzKzBSMmZ3K25tdEg2WWtqMXQvOE80NXhqQVQxOWJBK0p4?=
 =?utf-8?B?a3ozOHN5QjdoNWRUemR1YkdCVXpjYlVleTRKbG5KOW9YZklyek9DZXROSDhS?=
 =?utf-8?Q?v3H/W2wePOwYLF8C8eJrAFHRt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada58dfa-9350-4237-4f28-08dd55bb3b80
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:41:20.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4JQ2Z4xyoJZZHenh4shSp347PfGz/O3YurOFYzmFix01iMeTD1ZoNmu1QLigfHB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569

On 25 Feb 2025, at 5:15, Baolin Wang wrote:

> On 2025/2/25 17:20, Baolin Wang wrote:
>>
>>
>> On 2025/2/21 10:38, Zi Yan wrote:
>>> On 20 Feb 2025, at 21:33, Zi Yan wrote:
>>>
>>>> On 20 Feb 2025, at 8:06, Zi Yan wrote:
>>>>
>>>>> On 20 Feb 2025, at 4:27, Baolin Wang wrote:
>>>>>
>>>>>> On 2025/2/20 17:07, Baolin Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2025/2/20 00:10, Zi Yan wrote:
>>>>>>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>>>>>>
>>>>>>>>> Hi Zi,
>>>>>>>>>
>>>>>>>>> Sorry for the late reply due to being busy with other things:)
>>>>>>>>
>>>>>>>> Thank you for taking a look at the patches. :)
>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>>>>>>> During shmem_split_large_entry(), large swap entries are coverin=
g n slots
>>>>>>>>>> and an order-0 folio needs to be inserted.
>>>>>>>>>>
>>>>>>>>>> Instead of splitting all n slots, only the 1 slot covered by the=
 folio
>>>>>>>>>> need to be split and the remaining n-1 shadow entries can be ret=
ained with
>>>>>>>>>> orders ranging from 0 to n-1.=C2=A0 This method only requires
>>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) =
*
>>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>>>>>>> xas_split_alloc() + xas_split() one.
>>>>>>>>>>
>>>>>>>>>> For example, to split an order-9 large swap entry (assuming XA_C=
HUNK_SHIFT
>>>>>>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>>>>>>
>>>>>>>>>> xas_try_split_min_order() is used to reduce the number of calls =
to
>>>>>>>>>> xas_try_split() during split.
>>>>>>>>>
>>>>>>>>> For shmem swapin, if we cannot swap in the whole large folio by s=
kipping the swap cache, we will split the large swap entry stored in the sh=
mem mapping into order-0 swap entries, rather than splitting it into other =
orders of swap entries. This is because the next time we swap in a shmem fo=
lio through shmem_swapin_cluster(), it will still be an order 0 folio.
>>>>>>>>
>>>>>>>> Right. But the swapin is one folio at a time, right? shmem_split_l=
arge_entry()
>>>>>>>
>>>>>>> Yes, now we always swapin an order-0 folio from the async swap devi=
ce at a time. However, for sync swap device, we will skip the swapcache and=
 swapin the whole large folio by commit 1dd44c0af4fa, so it will not call s=
hmem_split_large_entry() in this case.
>>>>>
>>>>> Got it. I will check the commit.
>>>>>
>>>>>>>
>>>>>>>> should split the large swap entry and give you a slot to store the=
 order-0 folio.
>>>>>>>> For example, with an order-9 large swap entry, to swap in first or=
der-0 folio,
>>>>>>>> the large swap entry will become order-0, order-0, order-1, order-=
2,=E2=80=A6 order-8,
>>>>>>>> after the split. Then the first order-0 swap entry can be used.
>>>>>>>> Then, when a second order-0 is swapped in, the second order-0 can =
be used.
>>>>>>>> When the last order-0 is swapped in, the order-8 would be split to
>>>>>>>> order-7,order-6,=E2=80=A6,order-1,order-0, order-0, and the last o=
rder-0 will be used.
>>>>>>>
>>>>>>> Yes, understood. However, for the sequential swapin scenarios, wher=
e originally only one split operation is needed. However, your approach inc=
reases the number of split operations. Of course, I understand that in non-=
sequential swapin scenarios, your patch will save some xarray memory. It mi=
ght be necessary to evaluate whether the increased split operations will ha=
ve a significant impact on the performance of sequential swapin?
>>>>>
>>>>> Is there a shmem swapin test I can run to measure this? xas_try_split=
() should
>>>>> performance similar operations as existing xas_split_alloc()+xas_spli=
t().
>>>>>
>>>>>>>
>>>>>>>> Maybe the swapin assumes after shmem_split_large_entry(), all swap=
 entries
>>>>>>>> are order-0, which can lead to issues. There should be some check =
like
>>>>>>>> if the swap entry order > folio_order, shmem_split_large_entry() s=
hould
>>>>>>>> be used.
>>>>>>>>>
>>>>>>>>> Moreover I did a quick test with swapping in order 6 shmem folios=
, however, my test hung, and the console was continuously filled with the f=
ollowing information. It seems there are some issues with shmem swapin hand=
ling. Anyway, I need more time to debug and test.
>>>>>>>> To swap in order-6 folios, shmem_split_large_entry() does not allo=
cate
>>>>>>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
>>>>>>>> error below. Let me know if there is anything I can help.
>>>>>>>
>>>>>>> I encountered some issues while testing order 4 and order 6 swapin =
with your patches. And I roughly reviewed the patch, and it seems that the =
new swap entry stored in the shmem mapping was not correctly updated after =
the split.
>>>>>>>
>>>>>>> The following logic is to reset the swap entry after split, and I a=
ssume that the large swap entry is always split to order 0 before. As your =
patch suggests, if a non-uniform split is used, then the logic for resettin=
g the swap entry needs to be changed? Please correct me if I missed somethi=
ng.
>>>>>>>
>>>>>>> /*
>>>>>>> =C2=A0 =C2=A0* Re-set the swap entry after splitting, and the swap
>>>>>>> =C2=A0 =C2=A0* offset of the original large entry must be continuou=
s.
>>>>>>> =C2=A0 =C2=A0*/
>>>>>>> for (i =3D 0; i < 1 << order; i++) {
>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t aligned_index =3D round_down=
(index, 1 << order);
>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0swp_entry_t tmp;
>>>>>>>
>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0tmp =3D swp_entry(swp_type(swap), sw=
p_offset(swap) + i);
>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0__xa_store(&mapping->i_pages, aligne=
d_index + i,
>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 swp_to_radix_entry(tmp), 0);
>>>>>>> }
>>>>>
>>>>> Right. I will need to adjust swp_entry_t. Thanks for pointing this ou=
t.
>>>>>
>>>>>>
>>>>>> In addition, after your patch, the shmem_split_large_entry() seems a=
lways return 0 even though it splits a large swap entry, but we still need =
re-calculate the swap entry value after splitting, otherwise it may return =
errors due to shmem_confirm_swap() validation failure.
>>>>>>
>>>>>> /*
>>>>>> =C2=A0 * If the large swap entry has already been split, it is
>>>>>> =C2=A0 * necessary to recalculate the new swap entry based on
>>>>>> =C2=A0 * the old order alignment.
>>>>>> =C2=A0 */
>>>>>> =C2=A0 if (split_order > 0) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t offset =3D index - round_down(index,=
 1 << split_order);
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0swap =3D swp_entry(swp_type(swap), swp_offse=
t(swap) + offset);
>>>>>> }
>>>>>
>>>>> Got it. I will fix it.
>>>>>
>>>>> BTW, do you mind sharing your swapin tests so that I can test my new =
version
>>>>> properly?
>>>>
>>>> The diff below adjusts the swp_entry_t and returns the right order aft=
er
>>>> shmem_split_large_entry(). Let me know if it fixes your issue.
>>>
>>> Fixed the compilation error. It will be great if you can share a swapin=
 test, so that
>>> I can test locally. Thanks.
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index b35ba250c53d..bfc4ef511391 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -2162,7 +2162,7 @@ static int shmem_split_large_entry(struct inode *=
inode, pgoff_t index,
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D inode-=
>i_mapping;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XA_STATE_ORDER(xas, &mapping->i_pages, i=
ndex, 0);
>>> -=C2=A0=C2=A0=C2=A0 int split_order =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 int split_order =3D 0, entry_order =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Convert user data gfp flags to xarray=
 node gfp flags */
>>> @@ -2180,6 +2180,7 @@ static int shmem_split_large_entry(struct inode *=
inode, pgoff_t index,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 order =3D xas_ge=
t_order(&xas);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_order =3D order;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Try to split =
large swap entry in pagecache */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (order > 0) {
>>> @@ -2192,23 +2193,23 @@ static int shmem_split_large_entry(struct inode=
 *inode, pgoff_t index,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xas_try_split(&xas, old, cur_order, GFP_N=
OWAIT);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xas_error(&xas))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unlock;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Re-set the swap entry after splitting, and th=
e swap
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * offset of the original large entry must be co=
ntinuous.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 1 << cur_order; i +=3D (1 << split_=
order)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgoff_t aligned_index =3D rou=
nd_down(index, 1 << cur_order);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_entry_t tmp;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D swp_entry(swp_type(sw=
ap), swp_offset(swap) + i);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __xa_store(&mapping->i_pages,=
 aligned_index + i,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 swp_to_radix_entry(tmp), 0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_order =3D split_order;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 split_order =3D
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xas_try_split_min=
_order(split_order);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>
>> This looks incorrect to me. Suppose we are splitting an order-9 swap ent=
ry, in the first iteration of the loop, it splits the order-9 swap entry in=
to 8 order-6 swap entries. At this point, the order-6 swap entries are rese=
t, and everything seems fine.
>>
>> However, in the second iteration, where an order-6 swap entry is split i=
nto 63 order-0 swap entries, the split operation itself is correct. But
>
> typo: 64
>
>> when resetting the order-0 swap entry, it seems incorrect. Now the 'cur_=
order' =3D 6 and 'split_order' =3D 0, which means the range for the reset i=
ndex is always between 0 and 63 (see __xa_store()).
>
> Sorry for confusing. The 'aligned_index' will be rounded down by 'cur_ord=
er' (which is 6), so the index is correct. But the swap offset calculated b=
y 'swp_offset(swap) + i' looks incorrect, cause the 'i' is always between 0=
 and 63.

Right. I think I need to recalculate swap=E2=80=99s swp_offset for each ite=
ration
by adding the difference of round_down(index, 1 << cur_order) and
round_down(index, 1 << split_order) and use the new swap in this iteration.
Thank you a lot for walking me through the details. I really appreciate it.=
 :)

My tests did not fail probably because I was using linear access pattern
to swap in folios.

>
>>> +for (i =3D 0; i < 1 << cur_order; i +=3D (1 << split_order)) {
>>> +=C2=A0=C2=A0=C2=A0 pgoff_t aligned_index =3D round_down(index, 1 << cu=
r_order);
>>> +=C2=A0=C2=A0=C2=A0 swp_entry_t tmp;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 tmp =3D swp_entry(swp_type(swap), swp_offset(swap) =
+ i);
>>> +=C2=A0=C2=A0=C2=A0 __xa_store(&mapping->i_pages, aligned_index + i,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_to_radix_entry(tmp), 0)=
;
>>> +}
>>
>> However, if the index is greater than 63, it appears that it is not set =
to the correct new swap entry after splitting. Please corect me if I missed=
 anyting.
>>
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Re-set the swap entry after splitting, and the swap
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * offset of the original large entry must be continuous.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for=
 (i =3D 0; i < 1 << order; i++) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pgoff_t aligned_index =3D round_down(index, 1 << orde=
r);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 swp_entry_t tmp;
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tmp =3D swp_entry(swp_type(swap), swp_offset(swap) + =
i);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 __xa_store(&mapping->i_pages, aligned_index + i,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_to_radi=
x_entry(tmp), 0);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0 unlock:
>>> @@ -2221,7 +2222,7 @@ static int shmem_split_large_entry(struct inode *=
inode, pgoff_t index,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xas_error(&xas))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return xas_error=
(&xas);
>>>
>>> -=C2=A0=C2=A0=C2=A0 return split_order;
>>> +=C2=A0=C2=A0=C2=A0 return entry_order;
>>> =C2=A0 }
>>>
>>> =C2=A0 /*
>>>
>>>
>>> Best Regards,
>>> Yan, Zi


Best Regards,
Yan, Zi

