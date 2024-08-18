Return-Path: <linux-fsdevel+bounces-26209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C9B955D09
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 16:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3118CB2143E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE313B783;
	Sun, 18 Aug 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="hsNyQB4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE845007;
	Sun, 18 Aug 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723992679; cv=fail; b=aK5TPo4Tdva/0zapym/oXr7tIuJxxg3pamgunqsYGqLGvGMFFf0Bo7YdLvXbAkGLrnco+lIWHiqQVfiN+0aOcshnT+XM/AZxnpxHIfIu839Bnu7Q1tf3tYf1V7H6aAjPj2T7Et0nSbA/hH83nTJG3yKgUxZ0R2yRQS/UBpGqK5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723992679; c=relaxed/simple;
	bh=ne7n1cc9HZ3nZBUZhvruRcd13PPdvTyOdh97tAVyRDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ktvkffS+fBLOXVgOft4HMiu4sjxhML5ThmnWRSdKb7GDkNROc8CymcDpTriprkQK7XxFzlWd65egXQWTo+ckkzl4P/pOJdj7RD2+iJm7Gp54eVKSrOfgtX6S2LUAn1NQW1KYYfH7K0jCLShPz/Oc7YMukBvf6pUOXUumRmBfOvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=hsNyQB4K; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723992677; x=1755528677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ne7n1cc9HZ3nZBUZhvruRcd13PPdvTyOdh97tAVyRDY=;
  b=hsNyQB4KkfkwN8GCjjK5NaXsL90sMSsgdQ7vS3xmZSCXoUMuIyH42svd
   aoj0dDdAoU2qBNp5OSgudnF3wvCJAN3udxqIbbGQyipmNbCGDAGLZocdc
   V6OUYY3AM8YVb0TCsNPspYHwfpsRb768VeM6b8WiYXH9wuB7fll3YZTFO
   s=;
X-CSE-ConnectionGUID: K8hR5+3+T/+/D1xFYgT8uA==
X-CSE-MsgGUID: J5xG0ZqVTcSwKYNfVztlCg==
X-Talos-CUID: =?us-ascii?q?9a23=3AlTqVCmnweDAAk6UrWuYfQ8Ae3QjXOV6NzE2NYBT?=
 =?us-ascii?q?7NSEqD5HMWXGh9580juM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AHkN8DwxPgAnRQRY9Wj86r8+YOECaqIbzGG9Vo4w?=
 =?us-ascii?q?4h8K/Kg9BHTmjniizaYByfw=3D=3D?=
Received: from mail-canadacentralazlp17010005.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([40.93.18.5])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 10:51:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO3CmRnI17LqNp9KLNaoioPIBl/qj7gprAwYXZMPFfjf/3qds3FBO71kf0KF52yY3urmXZ1EJ3Krwy3qkGpGwjUgBmDtbSX9wWSTZ2gLpyOcuDaDSAnO2x3x+Zx71KBNgNTbNon1VwhK+MZYFvwLFax0ZmrfNLCGPZ6V5TpXTy+XDG1LpljKWRyQh2AO+pjSqploY3d1qEXFEbAVmf3QFl70yGwQOSiGWdphzQrT4L0OlV36RK8RjokXy8gCj3CFOeBrJOOxFi4lSylEjsRl8STD050IoUh2q8lXJosMQ2KSuYvT7I9CoWxnmUK7gvb+Z9yzB/g+tltG9OAnVcOToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOpmF2/uyjwmOnFArLsZr5Iin4ZslICkE9PIhbedFUs=;
 b=upVCRyB+ygzlYTEme5OyG17QlDhWuFfPGoBMFJ5hbuyCxj/cqeHjwbupvAjabH6aNe/7djjs6pcBeXHmlwosVcbZvHaTCxjJaa0+iyfr3WaXewoTDkCiAoLwZpKeGxDwg3sPQtF6yZUo1mhslCOs3ADgqcKjKOvmJabjNwH38Sk3HEgAxVw1pemUyFV0ct4MkAL8gf0j5qCsTvXI3jNPGYE3+hW41SWukDI7tDuohqbU5ut53RZ0n7+ZllLOS15udVFK0iw9C7l72wnZyWoJoCpY/eWs+7I3H5/ttFaHYOP7NMsSE+H6n3Y7LlTkaD/VQ0r7O8Da6xnH1xa3CSczcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT1PR01MB9099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ce::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sun, 18 Aug
 2024 14:51:07 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%4]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 14:51:07 +0000
Message-ID: <4dc65899-e599-43e3-8f95-585d3489b424@uwaterloo.ca>
Date: Sun, 18 Aug 2024 10:51:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>,
 Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
 Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes.berg@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <CAAywjhRsRYUHT0wdyPgqH82mmb9zUPspoitU0QPGYJTu+zL03A@mail.gmail.com>
 <d63dd3e8-c9e2-45d6-b240-0b91c827cc2f@uwaterloo.ca>
 <66bf61d4ed578_17ec4b294ba@willemb.c.googlers.com.notmuch>
 <66bf696788234_180e2829481@willemb.c.googlers.com.notmuch>
 <Zr9vavqD-QHD-JcG@LQ3V64L9R2>
 <66bf85f635b2e_184d66294b9@willemb.c.googlers.com.notmuch>
 <02091b4b-de85-457d-993e-0548f788f4a1@uwaterloo.ca>
 <66bfbd88dc0c6_18d7b829435@willemb.c.googlers.com.notmuch>
 <e4f6639e-53eb-412d-b998-699099570107@uwaterloo.ca>
 <66c1ef2a2e94c_362202942d@willemb.c.googlers.com.notmuch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <66c1ef2a2e94c_362202942d@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::29) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT1PR01MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: d03049da-3965-44a6-a18d-08dcbf9530be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm5qVE1SUGg1QzNGVXFIb3UrcFUxMUsyNi9QZlNtSnc1a0F3M0ZNZE03aWU0?=
 =?utf-8?B?VkRWclVoMCtmMG9VcDJVQnF6TitNRDdRYUduUGNDczRETzRJQUFNdFVJMzFQ?=
 =?utf-8?B?T21KbURXRlVjUmQxUnlJWk1iSjdrNHJaRjBrN3ZZbHg4WjhuNS8wdy8yMUZ0?=
 =?utf-8?B?MHZ6K0gwSC95TkVVY3RwdzJSWFp2OUNPNHRGVWZZeStXdnVBQ2JkSzRScWg3?=
 =?utf-8?B?ZjJPR1NKZ0NPU1BvMjIrSHZqenN4L3k0RHo2amNIVEluN2JTTFlJckJBWVA2?=
 =?utf-8?B?anFlZjNZNVZ6cG9idU9mdEZiVUY3U3loT0ExV25GRnVVS0l6K1p2MG00V21K?=
 =?utf-8?B?WUt4NDQyR2FDQm1DRlRiYzBoaGdlY25vUENDeDRzTzFGNlJYcGN6d21tdFFr?=
 =?utf-8?B?N0JzcVMxaG11YXU0d293UENRaSt0bkFsYUEyRytKMEx2V21HeXgrRkhoOGZD?=
 =?utf-8?B?ZG5aMVRxL2pHdGdKdkVBaDUzc3pwOUJ2NTdleDNUR1ZRaWJoVTZ1a0tUZVVP?=
 =?utf-8?B?aCs2MmgrNlZHazlDVFNXaUJpTGhEZUZQT0V6UUIyczJnZDk0QjBlVVVISXY0?=
 =?utf-8?B?WnRpRGYvTWZNY0RjN2ZKeVVxc2pLOXZTZG9Pc1Q5azloQ0JDM0VpUEN4cko1?=
 =?utf-8?B?WXJMVDQ3UGNkTW1kSGtTK1Y4cFZSVGJKQ29vLzFrRkVqcE1SQWxZWUhIMGJJ?=
 =?utf-8?B?YVgyVzFQeW9GT0c0M3JhZCtmZ0lrZWRLbWpOSzI2LzhlV2o3Tmo5STRhaFMw?=
 =?utf-8?B?VDNMSXBzSE0vemowM1locVFmRG1ELzFHUm53Y3lhZjhkc3dzQ3ppL1MyQU5u?=
 =?utf-8?B?TzFJajhZN3N3ME0zYUdWMXdUQm15dkJCYVZ0bEkyenAyeXkyOFFobzlVKzh2?=
 =?utf-8?B?ME1ERVptMDV4c0VVeC9UMlJ6QUtibHNhNE9NbTc1aW9jZ045eCtNT1QyaGVn?=
 =?utf-8?B?NUlKNCtGcloxNmI4WGM1ZmMwaVNmdTBpbHk3enJ3NlNDbkZIUUVoWllMT3Rw?=
 =?utf-8?B?Umd3ZmlYS1ZhRHJxQkVLZEZrY3ZsckN1ODdHUHBqU2RrZnFaUUZrMlk4UmlE?=
 =?utf-8?B?TlFvZURlUnUzVXlFOFd5c2xGMndmdHRqaUhYU1BkdWRzUnNUVXJCWjgwdTlP?=
 =?utf-8?B?Vm9mbUNCNE43MzNtcGtLenRLVXVNa2FRNDhqM0xBU1RNaG5tVisxRU1NckVV?=
 =?utf-8?B?dFlZZnU1RzJHNHdndk1mUzJBVUsvdGk3RU5hMGZ1YXdVTEF6dGJDWXZaSEtt?=
 =?utf-8?B?Sjg4NSttTUFXai9BRitiN3k5UXVtcEhuSWlVMnJ6YmYwUXFERGNvSlJlemQ0?=
 =?utf-8?B?cGZNcys0T29yNXcydDdjNjZMTWVwVnlHSklSTGhBNUZwRzRWeS9pQVhnVWVp?=
 =?utf-8?B?NkdaRGhSSTlZTms0RVl0L1crckxkdmxLQWNMQytGN1lnc1BWSS9veWt4YTNF?=
 =?utf-8?B?eGxDU1M1eWkrNmRWOEl5SndveENvbFlIblVIZzVZTWFaMnIrQzlhdFdWWVMx?=
 =?utf-8?B?M2VtZTBSelVmMTd5bWd1VFkyRFk2N2pXTkx4SWdSMWU5dG5VYi9IVVpKeHhu?=
 =?utf-8?B?N0d4NzNIbTBYQytucS8yUk50Yk9rbHdZMldRRVFqUExTc0V5ZFEyUjlYMkQr?=
 =?utf-8?B?c2F6cGFsK21hUTl2NjNzTHplWlNIS2lVOWNnQXRmck4vQWdmUm9QVkwrYzRy?=
 =?utf-8?B?T2pvbzdLQmdoOWVtcUdFVmY2OC92YTc0KzJDbUs1ek5KWmxQbHYybmZMUkM4?=
 =?utf-8?B?b2hVUjJ4WVNVQXRLZTkrWUM1aHBOVklnaVRFSCtRbWptZzY3L0NWeC81MmU5?=
 =?utf-8?B?c1FlaVljM3FNenFmRGFkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1l0K1dibGZDbWk1N05yVXRxNkVDUUw4RDhRNlhEd09ScG11NlBzMG9uTzlI?=
 =?utf-8?B?SlpySUg3cVZLVE4vaC81WkdBRXhJamhacHkwQlFmOE96NFlCbzNVeCtKLzVq?=
 =?utf-8?B?OERYNlprUDE2dDlta2FCUVFaTThnM1NMQkVIYnNWUFBDak9CeXpmWmFtMFh3?=
 =?utf-8?B?TFBVRGNFN2JqZ2gyVmIxWWlwem1XMTBmZmtaYlhBMW14b29xQjl2dHIrTzBM?=
 =?utf-8?B?QmxmSDNiRDhQS2MwLzF4YnViSTFrS2JvTkZTM01SRHA0VzMyckM0UHUvZ2Vp?=
 =?utf-8?B?MHpwU2tRMndwT0hnc2ZGWHQ4azF2WHUvMGlTc0RqZHVFdm9TMEpWMEN0Vi9m?=
 =?utf-8?B?LzlpTjhzZUVFM0xFUzkveUVkbTU2akx1ZEVyTXRWd1hiam10QWZlQnRWZGty?=
 =?utf-8?B?Vk5KMWhuODd2cVN1bWRjTXJzNVpBRCs3VUdtdUE1U2pPVEUwekx3UEVPL3cy?=
 =?utf-8?B?UUtlZThPaGxOK1FINmNLeTVSTEwwRnhEdjBNODRsNzBaL0EreU1MZnhIcm5J?=
 =?utf-8?B?YWFmVkw4UERYZGtpbE43SGRnSDRKSUwrUTZqeXlmSmthK1AvWElqc05tU2lv?=
 =?utf-8?B?NGxrbUYybG1qREc5K3Z0eVNwa2ttNDB4SGtBNnUzT1NmMjMrMWYxSmd1ZVdU?=
 =?utf-8?B?ejQxTVh2dy9ZTFJWSjZQL0tRdDBMRTVUR0c5NWlEaHpEWFU0dFlkZkxnQnc0?=
 =?utf-8?B?MFJKNGFrZWtUWnVmMzhiSjd0QlZkLzNXYXJaQVEvY2dSSnJUcXplMEhBR1NU?=
 =?utf-8?B?M2V1SzNKY3NTc3RjNzNhdGM3azFNQVByTkRVNmVQakh3dUtEM2I2ei9uQzhY?=
 =?utf-8?B?aSs3a29tcnNOYitTckNQTTFkK08xZW84dmpiWGhTNXNTSmNlNXY4am5ySzhx?=
 =?utf-8?B?WkJSakYyVFFvRzZnYUlkOUNSaUExdVRaUjZqM3VaN25JQ0JwaEF1djRlQ0pv?=
 =?utf-8?B?enFVakRwUkYrdit1NFl5bXNmdWNLbnJaUHc1Y0hLM2RaV2kvbDFLR0FYUkR4?=
 =?utf-8?B?U2oxUmhlZWpHWDRLS2NxaGtIL3U4dmdsZk1lemorNjZHVkxGRFoxK1RKQllW?=
 =?utf-8?B?U3o5T1Vrbi9vVk13SHV2aUdYcVNhem1UcEgrbVRDaFA4UXFzaDl0Z1dWcEdn?=
 =?utf-8?B?MWxVNnRsdVFPY0xwTU1DUllrNHpSRXdXWm44cnA1V1BkcmV3ZnR3QThzZjJV?=
 =?utf-8?B?Y1AzWVBCdTZrZ1ZQM2pOd1hJOGpiQXN2Q2VheGR1QmU0a2dnaEltSHBVajJN?=
 =?utf-8?B?ajJNeWR0ZVdWZE9qTEQyeHUvbEJMQzBROGVJcFdmY2Z1NnhwOUo5bGZyYmFt?=
 =?utf-8?B?bWJRYVNQVHpra1JhaTNEZ3liWFUzSkt1SU5qdXYrOFNFaHFpYXlEN3NKVlQw?=
 =?utf-8?B?R3gvck84RmNRNHlSZDkyc01tVUhWYWtJbGh0Z2ZvZ2NST0ovdUJBbmgxbGFj?=
 =?utf-8?B?aGhEN2t3QVRoL25XNmVQNi9pcGhoeUlqcVVMT3FnLzdRTlNqUGpxU2xZOEhE?=
 =?utf-8?B?ODJKWVJ4cjFvZVFwZlNFay9VSnJVc09Ta2hwQWJ2d3NVeDNYRDNndmxRRWVi?=
 =?utf-8?B?d1JVdVdMdGVna3RrVUtSTUcrSTJOVmpFMithWWlyTTBETWhSMmt4WVlUeitC?=
 =?utf-8?B?UFAwL2xKbTd5WVBsTCswK1NTR0lZZHZMcWswMnhyMGloemV1U2ZPTXA4aFp3?=
 =?utf-8?B?VndxOFBuSmJRQXlGZFAxK1VoZWNLL0RSNStEZkN3U1ZTdEFRYTM2bTBWZGk5?=
 =?utf-8?B?NEJOZW5ZbzJhYnUyMEFnOXVKM2pSak1MdE9jR0dEdUhSVHAyL0loaVVXZ2ti?=
 =?utf-8?B?T1pWUEJlZkdVMmppN1BrdmFDaG91N2s1c3BxWlNFdHIyQ3pnMnpVUmYvM0o0?=
 =?utf-8?B?aVdtWW9UYy9PVTc1eDJUK0J4UDJiYk1oV1E4VXBYUjNVTFUxOXpEb21sM1dF?=
 =?utf-8?B?ZWV5OE1wN1Q4NWcwZllCYjRFRGQyS05TY2ZKdnB1U1daSHJ4QjYyd1grUEZO?=
 =?utf-8?B?Wm5nc2dVbEplbEFMQWZaSFJmRXMwS3h3dzEzOEdkRVErREJrSkYwQVRpczFM?=
 =?utf-8?B?SmxiTXVhNmM5STVOYjVBSnI4NHU0QnZvSy92TWFzUHBFQm5Pd1p6bGdkSVRK?=
 =?utf-8?Q?C02GudLs7zGiaBXu4VEiT87Ip?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SfjB1jWTPTPcJeFfbcGf8omPiA2J6aBMWNjE0CT6FH9zj+babwCbTtSYthwas2MNz8BX0gXttOANGpHyoQ9bZKFDTDIU58WK/AOmIRszCoe8Am9mjdC2j7d7qbl7hGqqehRKx4gx9t4boFmYBFyTo3uES/65MteG3NlXyI03ocSfE+DsoZiTmY6r39O86iMGhbxiJ/MNBHWL6gVtwNIUosF87vAK/LVvtC3hz+HGCc+8qTwToHKbDn5WrV+DnX8gGB9+FdQy6CH98URPbQxhEbjljcfQMYq+W2lzBJmwC2oC0qyFN1dsFKw4P0YhqmXeWB0ZU7MRYCoUxoohKZVAI0YLnd7613lNEmH3MrbINd8j23MLXBF4c92jaTIeqpsXN+Y7GH47P1yyg+AtJxj66DAsdPvYkE1KduTmMgkcjFZ7AiLJ11xiIIgoV2MsX0QVStuBueXXuKzsi96xcBKgtph2hUoIU0VGY8pKbeq5DMTRYJJCQjvkPaPXJ0n/fwpUwFlnKrrASUcXUk+8shtXbpMJgZedNFzUjHCiUQJn7F9SVqI5BmjHTrQr4FwG+X11qLfoJP18/rZ3vbQDIvFRkgDt9KeFu1ANbIhWZPOJt4ugFyRRlHskoej21XWcTJqp
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: d03049da-3965-44a6-a18d-08dcbf9530be
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 14:51:06.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecNhwR9EmQ2BYdjUo1TYheBggHZbRGQiWtK879m9LfHg440YuguT4ImaML3wq272m/qEMD+7UKP72o1+dj9tfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9099

On 2024-08-18 08:55, Willem de Bruijn wrote:
>>>>>> The value may not be obvious, but guidance (in the form of
>>>>>> documentation) can be provided.
>>>>>
>>>>> Okay. Could you share a stab at what that would look like?
>>>>
>>>> The timeout needs to be large enough that an application can get a
>>>> meaningful number of incoming requests processed without softirq
>>>> interference. At the same time, the timeout value determines the
>>>> worst-case delivery delay that a concurrent application using the same
>>>> queue(s) might experience. Please also see my response to Samiullah
>>>> quoted above. The specific circumstances and trade-offs might vary,
>>>> that's why a simple constant likely won't do.
>>>
>>> Thanks. I really do mean this as an exercise of what documentation in
>>> Documentation/networking/napi.rst will look like. That helps makes the
>>> case that the interface is reasonably ease to use (even if only
>>> targeting advanced users).
>>>
>>> How does a user measure how much time a process will spend on
>>> processing a meaningful number of incoming requests, for instance.
>>> In practice, probably just a hunch?
>>
>> As an example, we measure around 1M QPS in our experiments, fully
>> utilizing 8 cores and knowing that memcached is quite scalable. Thus we
>> can conclude a single request takes about 8 us processing time on
>> average. That has led us to a 20 us small timeout (gro_flush_timeout),
>> enough to make sure that a single request is likely not interfered with,
>> but otherwise as small as possible. If multiple requests arrive, the
>> system will quickly switch back to polling mode.
>>
>> At the other end, we have picked a very large irq_suspend_timeout of
>> 20,000 us to demonstrate that it does not negatively impact latency.
>> This would cover 2,500 requests, which is likely excessive, but was
>> chosen for demonstration purposes. One can easily measure the
>> distribution of epoll_wait batch sizes and batch sizes as low as 64 are
>> already very efficient, even in high-load situations.
> 
> Overall Ack on both your and Joe's responses.
> 
> epoll_wait disables the suspend if no events are found and ep_poll
> would go to sleep. As the paper also hints, the timeout is only there
> for misbehaving applications that stop calling epoll_wait, correct?
> If so, then picking a value is not that critical, as long as not too
> low to do meaningful work.

Correct.

>> Also see next paragraph.
>>
>>> Playing devil's advocate some more: given that ethtool usecs have to
>>> be chosen with a similar trade-off between latency and efficiency,
>>> could a multiplicative factor of this (or gro_flush_timeout, same
>>> thing) be sufficient and easier to choose? The documentation does
>>> state that the value chosen must be >= gro_flush_timeout.
>>
>> I believe this would take away flexibility without gaining much. You'd
>> still want some sort of admin-controlled 'enable' flag, so you'd still
>> need some kind of parameter.
>>
>> When using our scheme, the factor between gro_flush_timeout and
>> irq_suspend_timeout should *roughly* correspond to the maximum batch
>> size that an application would process in one go (orders of magnitude,
>> see above). This determines both the target application's worst-case
>> latency as well as the worst-case latency of concurrent applications, if
>> any, as mentioned previously.
> 
> Oh is concurrent applications the argument against a very high
> timeout?

Only in the error case. If suspend_irq_timeout is large enough as you 
point out above, then as long as the target application behaves well, 
its batching settings are the determining factor.

Thanks,
Martin


