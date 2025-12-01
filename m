Return-Path: <linux-fsdevel+bounces-70393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973DC9960C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA473A449D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427CD279DC3;
	Mon,  1 Dec 2025 22:27:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022143.outbound.protection.outlook.com [52.101.43.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D6207A0B;
	Mon,  1 Dec 2025 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628031; cv=fail; b=FS4uMAMree5JYSGM8nFTk0yAzPPI7zq9UBvkx2uxSqINMWLsjEnxe059VU/iNzFbO3OcuuRf005eBmEJTlJQ+8SXG+DkhHGE7un8iQgj2i4bsMZ39vA4P1upbHEyMIgxR5XVZ0q43wY24k1BfLd4IjhIEfA98xcYbV0oaoFy90c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628031; c=relaxed/simple;
	bh=fO+uhjNLdmoBv7fP+SKAzcjvMxRhsYsqm4QVEJ6Sl+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LUlZls9zBDbcoDMS8aO2j5S+T1nv7FJgYYE30nzWak+pNKJveEYhlWqBEe7KsJ98liS6ZtDXjRQpRqoRBloY8gfS/op05WjymSEk5vdXv+RaATCOYdF+3RDBpWR5ADOQwmLSpW4xZ3UBcWLOC3ajcRhSrskWIUr6HxG2oOKdWrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.43.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzamJ8cFhj9fG1VFEt+ZrsFoTj6y7LWZDTpvUq93rX2scLnDAL78cWDBaOy6kfjVvi++RVALal6YV/EsNYEBsYtucwyxMc0cuWzkJW4WY3rEz72Ft+7ZUUtNueHzb8kEIEjkZXnxRHB23qGgkxO6fgKV3WVmWkYxO6xJnt1baM8E/fIR7rAiTAnXKCKCetsoiPXaEMpgI9Qi3NRGSpywH8m+iTCcnPL59iDJi6aUXfSroAlCi8/ITy8Y5d9AF4cWJegZQGfcSoPL99xGn63F2OVQSgKSaiVMUTMeycwp+CahuQ7Az4yt5Mwn9DxMB17ef30DRGVAkN6UUTRvCGNRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTAebvZ2Ir1HzPRX6VC/p1GOqyb7amb2C3wK49Pk3tQ=;
 b=Mj/Q3bbF0YTCAa57WpDtSTZOepdxw2lwgoC5lZN5E1wY2zaI42iVW6d6D9A9yRET2HKjW657RA3pnrYW9Jdj/vEPnvbwSRSwXeOtcviwnOw6TRrLihB41Ndlw07JIyL+nuSmi5/JQZZGFy3GvpCLFBz6bFxiWD5Kyp+ET9OJV64q8DV9tkGW+n7EbuYnFu62l77y1D0UnNubm7bWmFSPYE+VK/GvYF7ukZ92UnfYpJD0LEo4QVKO5Hi7bw0N+NPLli0XqMTZTxFzBSHIozst6YoCXNdDewj5H6ZqN6zY38kXQk3rFr1KOQ1yXWmTlP/QO09s951fI4YsMOvWI/6CGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5151.prod.exchangelabs.com (2603:10b6:805:bc::32) by
 PH7PR01MB8467.prod.exchangelabs.com (2603:10b6:510:2f6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Mon, 1 Dec 2025 22:27:07 +0000
Received: from SN6PR01MB5151.prod.exchangelabs.com
 ([fe80::9be3:7323:b360:3ce0]) by SN6PR01MB5151.prod.exchangelabs.com
 ([fe80::9be3:7323:b360:3ce0%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:27:07 +0000
Message-ID: <5057d4fd-1449-4f68-b847-f8b791de2be6@talpey.com>
Date: Mon, 1 Dec 2025 17:27:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] cifs: Miscellaneous prep patches for rewrite of
 I/O layer
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Shyam Prasad N
 <sprasad@microsoft.com>, Stefan Metzmacher <metze@samba.org>,
 linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251201094916.1418415-1-dhowells@redhat.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <20251201094916.1418415-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:208:32f::31) To SN6PR01MB5151.prod.exchangelabs.com
 (2603:10b6:805:bc::32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5151:EE_|PH7PR01MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 2024785d-536f-4a2d-85a3-08de3128c2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjR4K1R6NWFFTUNyRlQ5akFUdGFUSG9ZTFUveENPRjM3YUZqbVNLVktCRTli?=
 =?utf-8?B?dEg0NE9WbFViaW1jdldjQUtHRmZLTkRScUVtRUxhYXVsNFB3N3hpQVZRNG1a?=
 =?utf-8?B?S1ppZmg5K0FHc0ZMeDBRaGxuSU9TK0huT0txa2ZsNjlVZEdGOVhnQVJTWDEv?=
 =?utf-8?B?QWpCTU9VYkQxNlVpZ3g5WHlxdExiWTZSZGFSRmoxRm5lZWxRMEZWNDd5U1Ru?=
 =?utf-8?B?RGZuUjNvdDZ6dW12R0ZaZVpSZlkzUDVRaDJsZ05FT01sM2dQVEdBeHg4SVEy?=
 =?utf-8?B?ZHdvdmhETGlpc25kODdLL1dMSU8yTXlwSGVHQjJvMEJ6eVlkWm5UcE1xWTdn?=
 =?utf-8?B?NU5KWGFCU3FKZnVXYkViWWYvcFg4NklVblI1WkJhajQ5ZStNZ2VXU3BXOUtl?=
 =?utf-8?B?d2pXQ2luVmlLcms1aUx5NFJLSkZpMXNlU1QycTFxVFFxVVVQRzhSSGRRV0tC?=
 =?utf-8?B?eWZOVmo1dDg0MHpCQUJ6ZnV3NUNvS0Y3NTluMHM4b0dmRXZ0WWFEOHF4Z1ht?=
 =?utf-8?B?emZIMHB6RTI1d29qSXlaMWJ1VGZ4UHhsTTdnRWwwVm9lNjlseHN4WktzblBU?=
 =?utf-8?B?a1d3U1M1WE5TM1A5NUxkWXhDUVUwMGkvTHlnMVpOdDdnR1Bhdjd6VHpjb1RJ?=
 =?utf-8?B?T3RxczdNUHVDWlJkNHNLV21PcnVXaCtkVHRkVmJWNU5wMDFLd3BHYUkzL1da?=
 =?utf-8?B?S1VwdEFvM0hoakNSQ2Q2N013dmtQVUV6dEJJOVlxeGd0VklkSW5QUk0vQUtu?=
 =?utf-8?B?YVg3TTlidy9kTCtsT0VIMy9QWGlna0xPSU9GS0JXcS81UlJ2WUREYTJIb3li?=
 =?utf-8?B?dklwektDd0RpK2ozTWs2YnpwZGg5YkorZFpZM3QySmN1UzFMMG5WanBseW1N?=
 =?utf-8?B?NENKRURpTTJUck5tZ09EZlZkLzczZ1JDd3ZoMFl5M0VDL2FKeVUreEF0dVBG?=
 =?utf-8?B?UE5FOUdCK0FNR2tKRkdjU3B5SGVER1g1RWFUTVJ4d3FiM3ZRYW9oNWpDTVpD?=
 =?utf-8?B?Y0xub1dkblR5R3FqNldsd1NIeSt1eUdRYlBxME90RkdmZ0hBY0lXcWZhVldL?=
 =?utf-8?B?aG5vZHVLOWEvMDJHeTN4ZFRjVGsvR3VTN0FFTUlwOWdRWTJ3SHlkdmJENVRn?=
 =?utf-8?B?RTdrUHQ5RlYwb3dpS1NaVEZVS3ZEWC9tYmFuRmNCbkNIY0xrNCtuSWcrME9K?=
 =?utf-8?B?SEVyWEI0cHd6c0E4OEp1OHlyRHJwZnFOZHpkQjhnSUdHY250NkM5TEp0Qnpv?=
 =?utf-8?B?VTNSTVViVTVRcG9RdGdnZ3R2S1dTWEp6WVp0L1NYbDFpZkUybFFDby9ENDYx?=
 =?utf-8?B?TUg4UjdQajBsd3YrQ1phQlRGWVNiVXNyaENQemozNm5zMk5naWZ5SUQ1eVBE?=
 =?utf-8?B?dklQSi9pbzFUZUF2b1dDY3lRMWVXSVRYU2VabVpnQkJuaGZ5RUtocDVlNnN6?=
 =?utf-8?B?SUt3ZlhjN2lFcGZER3BXMUIyaU1TczRUb0ZwM1FHRTEwVEIyUUZid1Zhc0tl?=
 =?utf-8?B?WjQ1aGVqT1d4QmhBWVlnbUxiTHFTamIyL2l0Vzltem5wS254L3ZZNUd2QzZO?=
 =?utf-8?B?S2FQWjh2eENVVnV3Z21rcTFPWDJRSkhhaEZjNTYwekVwOXFTcjZXaGx0MkI3?=
 =?utf-8?B?bzJTU1JEckIvaEcxMFJEWXBwL0hTY3NBL05VelRjeUdXcy9kZllreDM3TkR6?=
 =?utf-8?B?cGtVdi96eDBxcjV5QVRCYkVnWldPcDFqZ3l1em5uZ2NFbnAxT1Y4cTYxR3VY?=
 =?utf-8?B?OU03RlZQZFNjY1dBZ011THpDWU9iNXJ3WlpkWkxkY3dobmlpS3ZOdlhuU05Z?=
 =?utf-8?B?UXh2VjV3cHB4ZE1uMTlYUi9jaW4rdWV2SFQ1QUVtekRxd0gzRzNZQ29icnl3?=
 =?utf-8?B?Z1V3dUtTTUh1cW9Rd3F1dHRzKzJWTXQrTzFwMy95bVZXZng0WEswc2drVWFa?=
 =?utf-8?B?OUkva2hvYnhLYlZVUjQ2bHg4WUFuUjhnYjR2anRnRFNZR080eVZ1SnpYZG03?=
 =?utf-8?B?ZjlEWCt2blpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5151.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEFtdlhONGJWT0ZEN01Oa25rdmcybFZ3TlYyMSt3R0JsRU5hMStGZjJXd3NB?=
 =?utf-8?B?anJnb3NZYyttaTZGVDJnRUdXRkw2THVIakVHYWt0VzgrMVA5RUhjRTRBdWNG?=
 =?utf-8?B?dDNZNEljVGlaRC9PdE1JZ0owcmp0OC9rODkxWXZ4NmQ3RnJVa0hRZlVHZ3VU?=
 =?utf-8?B?c2dTcjFtUTA1cTdRZ0lDOE53elprem9kcGx5MHJMTUMrVC9GbEZsYTlOb3Ey?=
 =?utf-8?B?SDZ5V3l5QnpDQ1lUSlRkUjcrT0Z5WkYxVWVxTHJBSmNsYjc5UkNkU080emR0?=
 =?utf-8?B?eGd3Vmk5aDJxK2J5R1ZJQUNqVkdvUE1TWXBleGpuK0VlRm9vb0kybjhlRnhl?=
 =?utf-8?B?VkJvZHhQd2dFQXAzbnI3Ni9HLzV4Zy9rMWd5cEx3WDRvV1MvWS82NnExbnp1?=
 =?utf-8?B?ZFkwMzNGemR1cHRCdkwwTkcvcnpkdVpvSzlNSUdFcmFKeXA1eWZsejFteGk1?=
 =?utf-8?B?eDNVeFNpcWNtWmFTZElQaU5nTmdDcjdGaVkvNDlxdmpRQzlYVDdaSk1HWFJh?=
 =?utf-8?B?OFdkbXN4cnJvTlpBVnliTWRiRUE0SUNpWnhFUkVtbVJmQjVVS0FtLytmRnla?=
 =?utf-8?B?aVpFd3pQUExYWHRXTU8yd0R5Tzhubm9aNXhoOS9RRDd0ZmFPUkVweWpwOXJ3?=
 =?utf-8?B?YmRzUzV4cTRFNnhzN3Fqb3FYd1lTOWJvWno4MUV5RmxydHdpUnpHYWpqVjBZ?=
 =?utf-8?B?RG5La3h0REZQSnVnY3VIazVkWW1TS0Z5OFIwbkNpTSthQ3NhV0hqMVNSVTBx?=
 =?utf-8?B?ZUtHMWlWeXBxVENVQ21zU2FOMVlKdVZxRTI2d285MmxvTDYwYWxDSVBPc21Z?=
 =?utf-8?B?VlZuYnNtVnJ5UU9qQms0LzluNGdGVWwvZnloaC9KZitDeFVvM3Q4MHdrQkpD?=
 =?utf-8?B?bE44TURLZlVOQ3J2Z2d1a0tTOUdoeW0yYXpoczJlUTZsaWJ3UXlQY2RkODMw?=
 =?utf-8?B?N3BvY3ZCZHNmRDhvMkxScFowU0ZuRWhGWDl0ak5FdkFCdU4wbEZTem1VY09l?=
 =?utf-8?B?R1V6YjRhSTI2ejhZREwyandabHc2R0s5ZXhUVUlDRExkRFFBUW42Q2tJeE9V?=
 =?utf-8?B?TWpIeFY1ekxFWTRuLzZWSU5uM25iRlJITmxCOHlQeFZyWTlsNERvTExMTkVz?=
 =?utf-8?B?Y2tqc2Y5RjE1NkFtRHM0UU12RTIxVmVPTDNLZkpCWVY5RW94TGNoZVJsR2pi?=
 =?utf-8?B?MmVDUWVEaFZDQ1dJckxtQ0JyWlUxOU1pMzJSVTZ3cDJTNnZJTEdLSS9RQVgr?=
 =?utf-8?B?dVlXT2dmdGJsQTI1V0VBRlhOVGZmckJ4STFHdVdPUTFHMC95cUxzKzdqemF0?=
 =?utf-8?B?cXk2Zi9lY000R2s3d1h1WGtQZ1MwM3VzbEZvMlUrd0puWnRBMmE1T1BReU8y?=
 =?utf-8?B?YzNoMFBXZW1lUGdHYXlOYjRtSlZzdkVVVUtYbU52aDM3RitYZnlKbVlGRGs5?=
 =?utf-8?B?TExNWVgzZEJBYVcwejdlU0lzQnZEZTFnREduai9zWHhoUG1FcHBrUXJMTkt4?=
 =?utf-8?B?K05Db3VnNXFXUjB5UVZ5aDFhcFJoSlcreDRqcVc1M3M1YVJQbThzV01uZXFp?=
 =?utf-8?B?NnhQR0c3QmVNaXVJdXc2WjhxdW9mOWw5S2RGWkNQc3lNYms4ZmNGTHBpa3NO?=
 =?utf-8?B?OFFXWGFBSHlXeEluY1ZydzYvK3BUQ2tDQS9qSzkyRUcrRU1kRXlFejYzTFlt?=
 =?utf-8?B?bXREMllPMy9FZlJRVk1TenI3d0VOMGI2SktOcnNVL3hFNjNMaWtvczV6dHh4?=
 =?utf-8?B?K2hKeTV4NEpmeHY1R0ZaeUJlT3A1RmtOSnpBUTdMa2dnc29hKzFlRTQwNW90?=
 =?utf-8?B?aUE3c2p6K3RSdlFnV2htUGpuSzdWcmxpaUw1ZFZ0dTNSQWdoaVVNNkhWWVls?=
 =?utf-8?B?MGxVa3AwL3hkbnhhUlUyVVpMaHJlYUZ1K2tHMFAzdU96dHVacW1mcnRON0dr?=
 =?utf-8?B?SUkvV0ZKRUdVVmlJdlB0MFh0Tm5lMDVMbFpNMzdqbis3UUgxbXpsNFFGNmwx?=
 =?utf-8?B?ZmVHMDZHdXRMMlgzYjlEcTNJazNRM0hvNUF6UVhEMGd5d1lIWWNJLy9WR2ZR?=
 =?utf-8?B?b0RpdVRMdzRETVcxeGpsQVYvS25BejQwanJzMlJJbDBxazBhVnFNREZyVTZ4?=
 =?utf-8?Q?fdovanWX1mdbflqr5l09pJFr5?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2024785d-536f-4a2d-85a3-08de3128c2c1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5151.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 22:27:07.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fF5rJUzpSWhWD9sDi1542JQmD+C/NE+nW+7ZzCYMsKyNf91X1k+bTrUjNk97rcwa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8467

I've (re)reviewed the patches and am ok with #2 (which I already gave an 
R-B for), and additionally #4 looks especially good. These changes are 
very appropriate for the previously missing layering.

I like the idea of #1, but I'm a little bit on the fence on the code 
impact of the rename. If Steve's not opposed, I'm ok with it.

The others are all worthy.

For #2 and #4: Reviewed-by: Tom Talpey <tom@talpey.com>

For the others, feel free to my Acked-by.

Tom.

On 12/1/2025 4:49 AM, David Howells wrote:
> Hi Steve,
> 
> Could you take these patches extracted from my I/O layer rewrite for the
> upcoming merge window.  The performance change should be neutral, but it
> cleans up the code a bit.
> 
>   (1) Rename struct mid_q_entry to smb_message.  In my rewrite, smb_message
>       will get allocated in the marshalling functions in smb2pdu.c and
>       cifssmb.c rather than in transport.c and used to hand parameters down
>       - and so I think it could be better named for that.
> 
>   (2) Remove the RFC1002 header from the smb_hdr struct so that it's
>       consistent with SMB2/3.  This allows I/O routines to be simplified and
>       shared.
> 
>   (3) Make SMB1's SendReceive() wrap cifs_send_recv() and thus share code
>       with SMB2/3.
> 
>   (4) Clean up a bunch of extra kvec[] that were required for RFC1002
>       headers from SMB1's header struct.
> 
>   (5) Replace SendReceiveBlockingLock() with SendReceive() plus flags.
> 
>   (6) Remove the server pointer from smb_message.  It can be passed down
>       from the caller to all places that need it.
> 
>   (7) Don't need state locking in smb2_get_mid_entry() as we're just doing a	
>       single read inside the lock.  READ_ONCE() should suffice instead.
> 
>   (8) Add a tracepoint to log EIO errors and up to a couple of bits of info
>       for each to make it easier to find out why an EIO error happened when
>       the system is very busy without introducing printk delays.
> 
>   (9) Make some minor code cleanups.
> 
> The patches will be found here also when the git server is accessible
> again:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-next
> 
> Thanks,
> David
> 
> Changes
> =======
> ver #5)
>   - Rebased on the ksmbd-for-next branch.
>   - Drop the netfs_alloc patch as that's now taken.
>   - Added a warning check requested by Stefan Metzmacher.
>   - Switched to a branch without the header prototype cleanups.
>   - Add a patch to make some minor code cleanups.
>   - Don't do EIO changed in smbdirect.c as that interferes with Stefan's
>     changes.
> 
> ver #4)
>   - Rebased on the ksmbd-for-next branch.
>   - The read tracepoint patch got merged, so drop it.
>   - Move the netfs_alloc, etc. patch first.
>   - Fix a couple of prototypes that need to be conditional (may need some
>     post cleanup).
>   - Fixed another couple of headers that needed their own prototype lists.
>   - Fixed #include order in a couple of places.
> 
> ver #3)
>   - Rebased on the ksmbd-for-next branch.
>   - Add the patches to clean up the function prototypes in the headers.
>     - Don't touch smbdirect.
>     - Put prototypes into netlink.h and cached_dir.h rather than
>       centralising them.
>     - Indent the arguments in the prototypes to the opening bracket + 1.
>   - Cleaned up most other checkpatch complaints.
>   - Added the EIO tracepoint patch to the end.
> 
> ver #2)
>   - Rebased on the ksmbd-for-next-next branch.
>   - Moved the patch to use netfs_alloc/free_folioq_buffer() down the stack.
> 
> David Howells (9):
>    cifs: Rename mid_q_entry to smb_message
>    cifs: Remove the RFC1002 header from smb_hdr
>    cifs: Make smb1's SendReceive() wrap cifs_send_recv()
>    cifs: Clean up some places where an extra kvec[] was required for
>      rfc1002
>    cifs: Replace SendReceiveBlockingLock() with SendReceive() plus flags
>    cifs: Remove the server pointer from smb_message
>    cifs: Don't need state locking in smb2_get_mid_entry()
>    cifs: Add a tracepoint to log EIO errors
>    cifs: Do some preparation prior to organising the function
>      declarations
> 
>   fs/smb/client/cached_dir.c    |   2 +-
>   fs/smb/client/cifs_debug.c    |  51 +-
>   fs/smb/client/cifs_debug.h    |   6 +-
>   fs/smb/client/cifs_spnego.h   |   2 -
>   fs/smb/client/cifs_unicode.h  |   3 -
>   fs/smb/client/cifsacl.c       |  10 +-
>   fs/smb/client/cifsencrypt.c   |  83 +--
>   fs/smb/client/cifsfs.c        |  36 +-
>   fs/smb/client/cifsglob.h      | 197 +++----
>   fs/smb/client/cifspdu.h       |   2 +-
>   fs/smb/client/cifsproto.h     | 200 ++++++--
>   fs/smb/client/cifssmb.c       | 931 +++++++++++++++++++---------------
>   fs/smb/client/cifstransport.c | 438 +++-------------
>   fs/smb/client/compress.c      |  23 +-
>   fs/smb/client/compress.h      |  19 +-
>   fs/smb/client/connect.c       | 199 ++++----
>   fs/smb/client/dir.c           |   8 +-
>   fs/smb/client/dns_resolve.h   |   4 -
>   fs/smb/client/file.c          |   6 +-
>   fs/smb/client/fs_context.c    |   2 +-
>   fs/smb/client/inode.c         |  14 +-
>   fs/smb/client/link.c          |  10 +-
>   fs/smb/client/misc.c          |  53 +-
>   fs/smb/client/netmisc.c       |  21 +-
>   fs/smb/client/readdir.c       |   2 +-
>   fs/smb/client/reparse.c       |  53 +-
>   fs/smb/client/sess.c          |  16 +-
>   fs/smb/client/smb1ops.c       | 114 +++--
>   fs/smb/client/smb2file.c      |   9 +-
>   fs/smb/client/smb2inode.c     |  13 +-
>   fs/smb/client/smb2maperror.c  |   6 +-
>   fs/smb/client/smb2misc.c      |  11 +-
>   fs/smb/client/smb2ops.c       | 178 +++----
>   fs/smb/client/smb2pdu.c       | 230 +++++----
>   fs/smb/client/smb2proto.h     |  18 +-
>   fs/smb/client/smb2transport.c | 113 ++---
>   fs/smb/client/trace.h         | 149 ++++++
>   fs/smb/client/transport.c     | 305 +++++------
>   fs/smb/client/xattr.c         |   2 +-
>   fs/smb/common/smb2pdu.h       |   3 -
>   fs/smb/common/smbglob.h       |   1 -
>   41 files changed, 1800 insertions(+), 1743 deletions(-)
> 
> 
> 


