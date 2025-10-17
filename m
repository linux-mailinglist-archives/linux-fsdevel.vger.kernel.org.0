Return-Path: <linux-fsdevel+bounces-64499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BFBE8F97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 15:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68955188D075
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B24D2F6928;
	Fri, 17 Oct 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Kru8cKT/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022089.outbound.protection.outlook.com [40.107.193.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158412F6903;
	Fri, 17 Oct 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708505; cv=fail; b=MlGB6U82j8oEUB+hsHh8yzmn1MDXk86zR8UHXyPVOI7RCawOcHpDp90XlzReVTNz3Qlo/AH8hxv8/7NcbiH7MozzQdizpG7WBgxmJYdXnqa1xkWxiCNqmhCcFkul8+Qq6RmCQkPIFXpX40lwh+tqdc2dq3HqtVwepCq00fG6sM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708505; c=relaxed/simple;
	bh=NSemkYLe+LXVTTPmkbAl8ZREXV9Whh4h+PYZmJWmiLg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tfl7CXGbRsnuXeTwGcpABcqrWCSnkCmD7Q/jXj0kiSMaKKf+O+AYG2278JCtFEc4Wo1WBCM45GpLKp0TaVuDWcbKh0AWtEzt/aVV86yKtUgo8YEjLP1dO0mybZzpDiS7smrCd77zOETja2+kNMJK5/A72mlsVkYGDfLfB0BNITs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Kru8cKT/; arc=fail smtp.client-ip=40.107.193.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+tDq+b8WxiFREvkqdCCEBsSnu8HLp2XBDUOrHVQANc71gAu/k6s5TOzebhQthp0AJ2iK69YG3csihFNw285usehkSTUaimtSgO/dpJmL/81+0tDs1psA6qFPASlOEkGC4esbEd+cgqh7tLd8OMoGWU9N/Htj5GNl+u4Y+oYOmW+h4uTM/Ovn+xCEbRt5AGerhy2nR2ANHNX9fxt7tLA+7l6XH2f0WXmJvgx3rN9X806SAEPDJ0jd9CmhvfmTvsuI7cv72ttsQK01b2HYeUQIWB7C/TG1rWYY4zGQ5l3351FQ0dsnO2sKJKYkcQ5yRxmE6KS+fB0oAPRgj3l4hz4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl7yWbP675TgXtyIXaRAQdfswzSBiztOzdZ3bFYA1oY=;
 b=bZyaJb7hj5ld+P8oMrMG7S92G3mFrCWFRxaVsUiUrpZS/5Isy5XmmVEExKFFkNcUaNmvWnShEDoDPrfsE+bFm+ujJFbswh3XIykkgV5sJZ4Lz0zqjAdyuw5qtmT3Wbomh05V8pjTdd7YaWWIf9L+KuY8WjVBV24yejcpcC35G1TwXA9FASiYYGOUufSe6+OKrAcsy6UAzbWjsU8vie9+hzyAq9TfZKkZJl3SZG6GCETBfelBCe3ppE7mE/+XWNjqcGCC/rtaEOBXePnNkaFzO+4W+GTWq9PcefBSGgzbIK0WagOhTb1U+JmVE2PsXdwTVyQ9VEnTNbdJelYcKW60jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl7yWbP675TgXtyIXaRAQdfswzSBiztOzdZ3bFYA1oY=;
 b=Kru8cKT/Q/56TZHtwVqXC/DdN8N8lcnEJ7LQ7+kOa+ZpNmDJtLPSorStMMgwIE0Lxvq/hBryw+299t+M1sQe672TssG+SEpddQ9ZZ6OJVht1SVlrkJ4gKd2lCyQwfYviffwc7/gVH9cKiiCvMFQOeBMXGxZzAI6e9hD3SuksmFArq4dAcAOtv6xGNS9PvUnONrOBBVPV29AX2cW/0ZWe05cbc61kJI9lChX2YW52mcIjzs4JocFR7hSoBxspDIHm7YqSS6vSmC44SRzfcVMTEu4iWw75aryUc777Y4RZKG26wvlNKWdDRQc50N1a13JyHUmdXrumxyyQi9E3hY1Rgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 13:41:37 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 13:41:37 +0000
Message-ID: <eb6c111c-4854-4166-94d0-f45d4f6e7018@efficios.com>
Date: Fri, 17 Oct 2025 09:41:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 08/12] uaccess: Provide put/get_user_masked()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.315578108@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251017093030.315578108@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c29c143-4215-4b01-de49-08de0d82e4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmk2SW9ZZlJOS1V4YXBQaWhFcEZaQVVMTWxhbkJEWlBjemRUMEhqcElSc1No?=
 =?utf-8?B?dnFRaEU2a0ZQV0d1YlhKNlVPUXM5MTU3RVgrK28wWVFhT3RsMk1OcWhZQW1o?=
 =?utf-8?B?ejRaRFFkcXl2NUpIOGV6cUExU0hoTWVlSnpNYUY3aktnN3RxS242dzZpM2ll?=
 =?utf-8?B?empEbXVucWF2ZG90dTM5YjVDRCtsRmZRUUJSWDdzK0VLOHR1anRRdWN3dHpZ?=
 =?utf-8?B?NVBNd2dzQnppQU9JV1JRbjAyQzlvd0pVWUxacmY0Wi9taWpOa1RRV0IrR3c0?=
 =?utf-8?B?UDkzZU9xTWIrUUZCcGRTZHNsRjdFOU9iclFzU0MrS00rTGd1MWF6eTJ3M2Zk?=
 =?utf-8?B?OTVQdERVY1o0NUtJcXRWY3dGZk1xY1RGeEtEeE83Tmh6dVAzRnN2dnFlSHZi?=
 =?utf-8?B?dUZoVmxKaHRRbHhnM0ZDc3ZESXBMQWV5dm05QXVvNUJVbEVCL1UwK0lXck9r?=
 =?utf-8?B?T2JQdkFJcStzZCszaVRKNHVYcU5DZHFsL0hXeGFodzZuZFh1K3BMN1FnYUZX?=
 =?utf-8?B?Q2Y3VDl6ZVNBc21CQWV2K2ppcjNib2hocDV6L01FRi9xbDd2T0R4dTNiN1pl?=
 =?utf-8?B?SmwrRklOaEpMMjBKTjB2R3YvbitXV282ZjJ5cUhsL3RmRjR6dmY5ZUdwYy9t?=
 =?utf-8?B?WnlTQk40WmE1Y2Q0M2FiVW9mUFdVN0o2M204QTIzV1U0UHA4UE0yOHRzM2Vr?=
 =?utf-8?B?UGF3L1FrcU5ncFVTVkJWcHVPcy9jOTA3ajRPMDdIcStJN0NYVDlGN1doNlJH?=
 =?utf-8?B?VkR3V2w5WHFZRjRhS29nMkRLeUdLUHR6SDFVYktVSUlQZzZPZnJxQ0VLbXNU?=
 =?utf-8?B?dmNpZ0wzL09XYlRkWlBMeDFNWWZqMHpEdzFTTUZIN3p0MU5OSXdEczYwWUVQ?=
 =?utf-8?B?VXhWQkY1SUdKRG1EZE9jS0ZoTXVhNG1uZlQ3cC95Yy8wNDhnZStCU2dPekZX?=
 =?utf-8?B?Tmc1NGtmL2pmaTlhZThlUmVQUFc5SlB6RlBMbUlHMS9DNFovUDJGb2padlRO?=
 =?utf-8?B?NHZuanM2c3hUSTVxUzJNL3BacW9JRStNZnBSZzJaSTlhZkt2SVVZTHQ4R0NS?=
 =?utf-8?B?TW1acGlyTkZNOVJFbVl4QUZUcXVEZnFUdy9FN0RPOC84QXhXd2l5Z2M5ZzdW?=
 =?utf-8?B?QVZCSnZoNmZqYTBsK0FaZmZyeFBFRjRmc1dZVXZXOFEwMlJMQ3NnTWlGSWpw?=
 =?utf-8?B?aVE2ZUdBSXl3d2pubHNGYXlBOXR5OEVwWU5iZk5MbmY2WEVYckdJRENhVko3?=
 =?utf-8?B?N2xDc0V5aWF6YjMzc0ZWODJqNlVnUmJjZWNOWEVwNkNWVE44cDRiaTMwYzAx?=
 =?utf-8?B?WE9VZ2ExQmJrZkt3enkvc1c1YXVPZXZPbTFmcithQ0xDT2lCN1FUQ1NqQi8r?=
 =?utf-8?B?SXhqRUlyZXh3LytBclJKWjZpMWNkc1c1eXJQMUVJaHF1WjkrVlhMY2J6ejRM?=
 =?utf-8?B?cWw3b3FjbWtPM2c4RTZMbW8zb09SK2RFWE1JQWxhNk56WnFGaGpGTWo2R2hC?=
 =?utf-8?B?SlJid29hWFNNNHlwSTdTT2QvclZ0UnlBWG1XTENOK2hWTG1qYlFnMllzSDBD?=
 =?utf-8?B?dk8zZ3BLWVRNS2Facng0YmpZMGZmbW11aDRJb21UbWt4V3prTFhjeGZrOGk2?=
 =?utf-8?B?ejF1UmhuMmhUVVRoRGZiQko4NzJqNjlYakx6M01QZ1YxNGF5T2IxclhHZm03?=
 =?utf-8?B?YnhCblNTc1lYSjllRHpRQ2loUGZBWWl3VElLcXduaHNaUzVMMHZaS2JUMzdp?=
 =?utf-8?B?L0xBbU5peSs4L2xsWVJqWUNHdEExYklTQ0w0VmJPVzAwZWpKZWNHQVJqWndo?=
 =?utf-8?B?ZlkyQVN1T1gzZW4vUGt1M3NtbStocDZhN3ZoblhsTWFabFI5dy9GNXNwNCto?=
 =?utf-8?B?YjF1bTI1akRHVGNsNytDeWlSTTlGU0dyQkx5RkFhc2tyb0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXUwMk9pdU80VDFTVzd4Q0t5TzUwYnRiMjFjdnZoOUxiSG1GUDNSd3p3TFJV?=
 =?utf-8?B?QnRFU1Fjb3owYktkeXBSZ1JrdW1iZURLQjFiY2pGTkFBRStma2N4bldyRU8w?=
 =?utf-8?B?M1pzeDBPNVRXUUxDK2Y0YjcxSW5SQnpOb1VxVElyQzB2ZU5iM2lpQ2FCMndY?=
 =?utf-8?B?YmNnWi9DRzRObWVHako5N1lnV3VHUzNSTEMwM2dQbmc0aS9rd2kydjJLUUZ5?=
 =?utf-8?B?c05tT2tJeEkwMGZzc3VSbFRGZkU2U2E3b1JIdmh6RkpXdE9NdkMzM0drQlpx?=
 =?utf-8?B?SjQ3dUc2eEd1ZXpISHNJd1I1VnBBMXJncmdTTXFmV1p2QXZaR3FoTWJYL1lu?=
 =?utf-8?B?aDZoYmd3Skc3UGV6clYrUXRzSUh6UUZWbkxVQ1Q2bWcwMG0vN3VXSHFqeVBD?=
 =?utf-8?B?TG9FQkRQb2RRMTdKZzRRQlpaeUZTeHI1OUYraU5lWlhaSHhCU1J6a082ZVNR?=
 =?utf-8?B?eHp3T2dtWUROVkgyK0RQYVNmKy9lY3FPUHZjejJvcFRNRWQrcVVWRmk0ZkZW?=
 =?utf-8?B?MEhSZFZEM1NBR1BoRkRScEtCdTVETlpreTB4VHpUOVhrL0N1cy9zNGdCZmpo?=
 =?utf-8?B?TTMzTmlVVURkbWJuQUhrTFhzMldRYmNYOExGVDFZYTRXenlJK0lWZkFTb3Bl?=
 =?utf-8?B?QS9qMDhxRkRBaXRMR1RINHVlcGJJUURKb1U1NE1oSHZDc0RhbXMzT2l6Q0p6?=
 =?utf-8?B?UGpOY1l6M3FRSFNQRFAxY0xKaUJybzhJT0QrLzV4RTdDK2oxTGdMVXZJNUIy?=
 =?utf-8?B?WUpRZGJVRTNxcnNOempOWllDajgyNlRxRStCU3N6Qm1ZMlJpWDJQcFRVUVhl?=
 =?utf-8?B?K3dSeVgrbFQ4ZzNkWHRiRWpHT2h6cVJTSlRvamx5WmRMc3dMZ3R0RUMwU1FT?=
 =?utf-8?B?MnlYVWhpZWU2NUtOTlZRdzB3enFmUENFbmZ4dlhLVTdQbGg1SDViLzZERGRS?=
 =?utf-8?B?L2lUd3hWemxiSkpIYmJwT3dUeXhGYXpESnY0Y2VDb0VNcTRxdUdnYnF5ZDhm?=
 =?utf-8?B?SWNXT3hPMThLK2sxODFzSmlYVXlJOFdVLy93T3FteUhxY2JMK0RqaURPd3ox?=
 =?utf-8?B?LzZUQ3c1T0d6a3gyb2pqeStMTlVyMjQ5L1ROVW1tZzhZQ0NYSTdoVWYzZjE1?=
 =?utf-8?B?VnBWN1NzWGhQM3F1TkpCREdUUmRwNDE5UFp2REdIR2Z4MkRNSzRBbUFDTERh?=
 =?utf-8?B?dXNscStMNWEvc0RuamEzYkgwL0pZaHQ1ZGI4QVQ2UlBjeFlsQnRqRzRsY1ND?=
 =?utf-8?B?WmNQOERqNitqSE1CMDUzcVE3VmhTOFpYRFdiMTNrNldXeWRhd0h1V25zNUtP?=
 =?utf-8?B?Qi9uRVBwVjgvbFZPMlZCK3BiSzlhdFoyMkxNai9ZR0xRU296Ym0yQStwUTdG?=
 =?utf-8?B?RHhvOHRseVltaktQc2ZlcWcycnVTSE5iR1hIWEZvWmR3NCtTTnU3ZC82WVYz?=
 =?utf-8?B?VnJxYWNtb0xGWUhZeXVHWUR6M3pNMzF6N2txS2NWQ0xQaldtU0pReUNJY2Ny?=
 =?utf-8?B?dUNXMWszU29NVVRldTFyYzlhM1hEaUpyREY4c0g1Vk1DQnovdXNYTlh2eGVM?=
 =?utf-8?B?N1VZa3lOTHF1RFZTMEtQcDhNZkhlWllnZXpLMzNOVjRjUFZTbjk2VjhPRHd3?=
 =?utf-8?B?MjBKSlhhNWplaHlUVVdUNkRpUzFHUk5KMnpiL3ZvMzJqVFFyQ3FMTndKcUtS?=
 =?utf-8?B?QlN5UUszQ0VSYnZVVnZoaUhLczd3RXUwS2lrd0lvK2gvVVBvd0pnZnpDVmlI?=
 =?utf-8?B?YXYxVURod21MVnVka2hwNTd4cFNwMVQ2ZE9iMDdCcWhZQUtGWVJJWmlEcUxw?=
 =?utf-8?B?eFBmeTJtWGdRRE1xaks0clBsSUkyeG1xKzFzTEs3bnN3SmdmZ2xGNUdKa3hE?=
 =?utf-8?B?d093ZUhCTHVmM3M2WHlRSVpzUUh1bWpGYTlDbGVsZG5pNStPb2NKT0JSSGRr?=
 =?utf-8?B?NTNxMWsvSDlKZ1kvanNGQnNMWUduOCswejd5OUM0Y1dldnhGTG5VOUdWZE9v?=
 =?utf-8?B?T3RrSDhGRGh3U1hOZUhrVXNUcWJEdHZyNTd4em5DMXZnNGJBOWp2TE11enFj?=
 =?utf-8?B?blRRcXZFSGRGbzlBSU5MUFJxWFBCMGJVOVBpT0I4YWNLdkwrWTFMOWdDMU4y?=
 =?utf-8?B?NUZFNUd5UlBhb1hQRnBkSHBuUjIvVFJYMFkydEp4d2tXNnNQcGNwdU41WERv?=
 =?utf-8?Q?mLJ86evoePLRALk+kfxGc38=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c29c143-4215-4b01-de49-08de0d82e4e1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:41:37.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xc/L86BH8zAUDNdqzlseI4xK8pMC3rS9LQ+t9Ueijl8CSbxCiNDQHF8+Alri6wFvLwgoDGxJbE8wFwCFj4x62LBBAPNqDJg6VmOoCGFTosk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6572

On 2025-10-17 06:09, Thomas Gleixner wrote:
> Provide conveniance wrappers around scoped masked user access similiar to

convenience
similar

> +/**
> + * get_user_masked - Read user data with masked access
> + * @_val:	The variable to store the value read from user memory
> + * @_usrc:	Pointer to the user space memory to read from
> + *
> + * Return: true if successful, false when faulted

^ '.' (or not) across sentences. Your choice, but it's irregular across
the series.

> + */
> +#define get_user_masked(_val, _usrc)				\
> +({								\
> +	__label__ efault;					\
> +	typeof((_usrc)) _tmpsrc	= (_usrc);			\

Remove extra () around _usrc in typeof.

UNIQUE_ID for _tmpsrc ?

> +	bool ____ret = true;					\

Why so many underscores ? It there are nesting concerns,
it may be a sign that UNIQUE_ID is needed.


> + */
> +#define put_user_masked(_val, _udst)				\
> +({								\
> +	__label__ efault;					\
> +	typeof((_udst)) _tmpdst	= (_udst);			\

Remove extra () around _udst in typeof.

UNIQUE_ID for _tmpsrc ?

> +	bool ____ret = true;	

UNIQUE_ID for ____ret ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

