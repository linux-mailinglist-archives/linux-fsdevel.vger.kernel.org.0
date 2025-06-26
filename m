Return-Path: <linux-fsdevel+bounces-53106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8788FAEA3BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE6E1C4148A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 16:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355382DAFB8;
	Thu, 26 Jun 2025 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qpKaf3W3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F41D9A70;
	Thu, 26 Jun 2025 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956513; cv=fail; b=p342sPwi9E6/fB9A9wWT4P7Mihm1NOPaacNBaCNLSJC2/Mtrfsivr2s/36WtGCeXsw2pWkJfXB3eYob56X/8DF/xqFmq5UXvxW93Tvnst5VOQZgXjAw6ebVjiROfX3+espg60ukTm2ELlBKWVVPet4Y+Y8WGY8ZtO50fApWBhbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956513; c=relaxed/simple;
	bh=yBoTofI9ySBW4YNf9yQRoVKEWruvVM7yu1z8oj+7v1U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d6qA2DCyiw0jGoupWeK9UM+ibO9Kq2nhT+J4jf5LTyAKWnlh1FaYDr3Y4on9nTiKBFm00jduCtbEfVXFR/AqDrCJoWe4qg+VzEI3kEXp8WRZXNoDbRh/CHR3XlaNtfgh4EneapNdgU0OGZey62Qle2iC0vpR6cVgDj76V9SjjwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qpKaf3W3; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1E6sa3Fh84T09CDqOJp03VJj/0dyjOwoqVhCQfuDPbsKBjsKGl350H+w0Rgq5cuqZoM35d4KHfbIz2yzucQVC4812/onpoIoXNgaqIXb3l664ZfCgCaRJkV2QbUaw3tx6PiPXzlLy3HXxgCiQYBH5FtWU7xke+Db2bGJoJRIi9TjJSyT7v1EomhWHcRqO5AuFI0HFd5JjX1Rz4esJtx9G7LWki+M3TtLi09NQroFoj9EpybAE6LgbRmLgC6IJfv1L8pmhArqEf2xPMxdnZ7dRe/ovXUOqZP8R3vseANdyM/DrGt7L66FQJ1RUwpXRu+UFyV5fw+F2Y6O7J1F6Hbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piCbMMoacvjqcA3Vz/x2vygoQje2/8IctuF/lOC6rAM=;
 b=VrifuWuZe0EQkecjdyYXbM5hC5RrI2vw2RHh+UdH5sRBIp7stP7o5eIrtW8vldZ3EdfmNrQCcz6+JrrUQx4krqQcsvfkMp/AQayYAJYxmFyRWS9PsggGjS6ECn3mDs6m/A9yppEW9scX1/8/+kmzegsCE7DSO5cESrYQxaaJuvmcuHnZwQGbNit2S49hwTlab52vtvlHv0Ltyzbpxp1hHIkqkLGf5+WjX88b1WaGlr3GhwZZIswAyF1dqJ7cjkObK0eHZjmKtnr8PRAIzRkIFJRDyMmM+WubqN2Cetlhq2PKyk1M8xEhNWQfmbchWPeTVCOFD/MJH2KVPYZa2C6ZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piCbMMoacvjqcA3Vz/x2vygoQje2/8IctuF/lOC6rAM=;
 b=qpKaf3W3MvTqSDiAMGMtdBwuBGCaGQB02ZnJ2J1BLXYoAYUqThdv4opbWk5fbbRCPX3GcQZDchPpLLXzhFVI0WlD44u23W2dKBSo1OF15kaU0AyV6TrS7bRmBDp5LmdTy0m6PdKNjZFGKPOcutnffAvzYPWubv2sCSXOkyXFEjAR08yp1f7KdNc7kcNYhjamtL8+SkWDxLjYAOtzff6HUckQ2ceIu4T0r3NADRHSl7RDpaT0hvvm9W0LwXUpHsu8cDIHUBGnbhluhiMWx9EvrCEL4cs+RanVZZNIZC8GuRa5wDjq6xCAkjlRO7AsqBXqIJGOZK/LbW3XyOFeZLLLgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6430.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 16:48:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 16:48:27 +0000
Message-ID: <c170414c-f3a0-46cb-9bce-7277a8496172@siemens.com>
Date: Thu, 26 Jun 2025 18:48:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] MAINTAINERS: Include GDB scripts under their
 relevant subsystems
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org, Kieran Bingham <kbingham@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Uladzislau Rezki <urezki@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Kuan-Ying Lee <kuan-ying.lee@canonical.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Etienne Buira <etienne.buira@free.fr>,
 Antonio Quartulli <antonio@mandelbit.com>, Illia Ostapyshyn
 <illia@yshyn.com>, "open list:COMMON CLK FRAMEWORK"
 <linux-clk@vger.kernel.org>,
 "open list:PER-CPU MEMORY ALLOCATOR" <linux-mm@kvack.org>,
 "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>,
 "open list:KASAN" <kasan-dev@googlegroups.com>,
 "open list:MAPLE TREE" <maple-tree@lists.infradead.org>,
 "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
 "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>
References: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
 <fynmrmsglw4liexcb37ykutf724lh7zbibilcjpysbmvgtkmes@mtjrfkve4av7>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <fynmrmsglw4liexcb37ykutf724lh7zbibilcjpysbmvgtkmes@mtjrfkve4av7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 865d3b92-3d26-474c-c43a-08ddb4d145cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2pqSWhkNlN2cjh4TVNQbWVnZWUyQ0JTbi9VdUJ4TjJiVm1KOW5Cems4SFpo?=
 =?utf-8?B?ZkhmejU2ZEhRTEtLRU1KdE54bkZNbWpRR05VRVhzNm9uVU5jUm9PdzVpQ0Fo?=
 =?utf-8?B?aHNQTTQ3UnNaYkxrZmwraUVmWk1GTHZkTnJGdXhiVzJlckNRVlNRM3ZlWGF1?=
 =?utf-8?B?aDZmRCt3Umg4Z0trZGV6Y0NGOWtUaGRicXNTMFdDTzJNSWlYTEVtNDM3Slk0?=
 =?utf-8?B?MG9rVkxjTk94ZmcrTktmTkpkVjZlVHpZMFFVclZSdE5jRm5tb2U2MXZzNUwv?=
 =?utf-8?B?RmpSL3VkSnJ5YlRKSnlwbzBsajNUNEM0d2lNN0RMdExXN1MwUEZ1VUlyQU5S?=
 =?utf-8?B?TFFSQjRyY25VRyt1UkxDWjhobXAxSVY1bDV3Z1RyODVXUndpSG96cmoweGpw?=
 =?utf-8?B?VU9uTUxLZjlmcVoxN2lvMUhmUFpMaTZaaVlML2V3Sy9EV1E0aWVzVHFCbDRu?=
 =?utf-8?B?clppVmtIOVVWb2RGQUJTZWVMY2cvVVdBRGZPRVZXVVk5SWtOeVpZRlc5MFJC?=
 =?utf-8?B?Yjc5UXNxbUpGdnYzTHhnWmdCdHAwM3FpNklsRy94ekN4SC9UMWd1bVcwVUgw?=
 =?utf-8?B?VU9SbTFyOWsrS1k0dnhFTjU1c2hQbW1wNzFiRm53bjZVSjBKVXRNaGs5Ukd6?=
 =?utf-8?B?RnBNclM3aVRXQ3hvMjFlWTJiTGFROGMvK2kyNmhwZmdEWXd4WjdoWERCelpr?=
 =?utf-8?B?a1VqaHFreUhQLzlvOTgwdTZpZ0wrWVRHUEJkUjVhd1lCYzF3ZjNxT1h3M1VG?=
 =?utf-8?B?bWZFTlMyeHFOcGI0SXhzYVAvQVRhaHlYM1lPbGdVdTM5eTdpM3g4WGd3TWov?=
 =?utf-8?B?NVBxQzhvYjJvYWtTcjkzNDlWbTRvd3dvS2s4T01TOHhmY1dRS0lKbG5hRmZF?=
 =?utf-8?B?NWc2bWJubmxzekVXSitlV2p1WnF3Y2ZKNkVINTV1cXhnRzVIc0NRdndIdGJu?=
 =?utf-8?B?bjdhdG53Q3RvZHd0aE84SnYydk0yelNPb0Y3OC9VZi8rY2szRWxGN2twMXUw?=
 =?utf-8?B?MW5SMmZxdFB4K3R1MFlaa3BnNVdZa1JZSUVJVWNBbzlBcWNMeStDOVN0eTlV?=
 =?utf-8?B?YzlGdG9CbVZnUkFwY3FWVDE3WS82NUhhSGlYQnVWRkxMVldUQkZJeE1IdERJ?=
 =?utf-8?B?UVVLK0xramZrS3VKYUEraFM3R2NReEZOVjJReHM3RUFsZU9oQUprUkVzZVVX?=
 =?utf-8?B?WW5RTXJaNStlYmpKNzBPUmFDZDN1WlR5NmhLaVhQVHVsS2hZRWZwTU85Nzhz?=
 =?utf-8?B?Y0JkMVhnLzZHN0lqZ0d6M1kzdEQ0aWxMa29hNGo0RXFKL2t1eVpGc2l6L2lj?=
 =?utf-8?B?dDRVQStDc0NSbWNyazRzelVZV29IUk9WOElPL1R0aHkzQVh2dGVFb3VLc3Vt?=
 =?utf-8?B?azZ4TzlxdDR2M3B5ZFh5Mkl2Q1ZjWG00ZnlMRk0yeEFINDNxK2FHTDlXck1T?=
 =?utf-8?B?VTRBcHl1a2gwRXlMY0h5UWd6MzdVeE1KOVM0YXVGMW1hN3lZUEdaTW9UVW9y?=
 =?utf-8?B?b3hmMU9TYUxZbFRjVGVxbHBqUHBUcmp5QXdPY2xSNXJVdkxiRFNIajFZbzJ0?=
 =?utf-8?B?VDBsZnVsRlR2UjVZeEtRS1NHSUNGZXFrWlUzcjcyWU1xVXZnNXVLaGYzVU95?=
 =?utf-8?B?YVYzR1g5UG5OdE1ockluRHlqa2NNSHR6V0JXY2NhWlc0YVRhZUVmdFlTdkJw?=
 =?utf-8?B?MnNuaHYrVDVCN3VqQS8wbW91a1IxNXZiN2dodGhvREI3VTNwMTRuOFBhZUJI?=
 =?utf-8?B?U0NzUEo1ejJQSm9hT3VqcDlHdlh1NWtnNkhYRFhZenppSXhiQlVzNEE0RnVr?=
 =?utf-8?B?eU80cGwzWUpsa0pIeitzbS9zUW0xQ1dvZ0VNTzVaSTBJWVhGNlJROUJYUXVa?=
 =?utf-8?B?NzJNSEI5MVJsUjR3cFlCRUxHYWQremxzdm5KcDdITlA3cFhZeTYvQ290VThI?=
 =?utf-8?B?dUJGMzliTk5mU0xOaUxPSVpsYVZ2NUJ6dTN4T2g0TmFPZzBNNCtWNkJFNS9C?=
 =?utf-8?B?OFNEcDF5Rm1McEg0by9MM0xBaUFNNUNaZFpLWlBqSXJtbnI3VHA5V0d2UGd3?=
 =?utf-8?Q?gZhDhQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTNyZ2RuWEl2YnBjcW1hdXF5cWJBYjNmdWZhUEFsN3JjU1FiVFFFZGJZSHEz?=
 =?utf-8?B?WGwwWHlSa3JFMGtnU2xKc3c4elFFblE3TWNRdFYzTitVSXI0Q1l2RlVUVTNy?=
 =?utf-8?B?MlNUb2xQeWVWSng3YjFwOHZkWk5tdURrVi81SGVMQ1l0eFdHRFZUdHVZRlNi?=
 =?utf-8?B?M0xucUlzY2wyMlN1d3V0ZTBsTWxNOE44cFh4VllXeTh4c2hUNS8rSXl1TWJ5?=
 =?utf-8?B?eG9yRm1PVzRnSjlWbFlrdmU5SVNtK2NoTTMzS3Rlc2g2SWM5RlRQMFA4ZGNl?=
 =?utf-8?B?RGM5VGhXN3BOSm5QQXBrdXFtcTZLT25uSDYwcld6cXpBU2NQVnZ4VkRuYzJn?=
 =?utf-8?B?NkhUd3VEY2EybW5VWEJzUTBwck1qamxRc3RCNzk3RzE2dTBuektKN1FyS1pn?=
 =?utf-8?B?UHZWV1dIR0tBMUFqalpaWmNlSyt0LzZJNUt2YlBKTCtnNnJUMDdWZ1daalhB?=
 =?utf-8?B?M0VYbkdkNmlUUEN0bHNqdWJROGp4V0hYcG5sRE5aNlNtYUpPelBhbGI3Y3NN?=
 =?utf-8?B?eTJDNFY1RHUwZCtPSW1NN1pRU2YzcEF4VE1lUjhjSFVDNy84QmtwOEgxSUgr?=
 =?utf-8?B?b2F1Kzd6RzZIL2J6WCtaZ1ltVkllcWRiMk84VWZSZGRrNEZWZElUcnNNL215?=
 =?utf-8?B?RDlaMC9jN3NTMWh0NllpVm51SXJXbGd3T1N2eDhNdjdHODhsbUVRQ0toakJI?=
 =?utf-8?B?UXlLMVJXSzFmQ1c3TG1JcjJuNDZVdjVob0hlNHNhRTRJdVFQY0ZMUzlPY1pH?=
 =?utf-8?B?eWRzYXNhUUI3TURhVThWckxqZllBblNkcWFoeDFpTUJDNjNLbU5teDNib0hB?=
 =?utf-8?B?TEhlMmc1cVNOS0VibUV0d21IUDV3Z0VxQllYWmh0bW5ZYUt3ejczaHBvQ0hP?=
 =?utf-8?B?RHhLVE9EMVBPd3NqSlcxdThLZjViSE56L2V4aDdDQmNkUXpRZUFaMFlOc2tC?=
 =?utf-8?B?dktkRGErOCtZRjlsRFNHUGJGdlRpbWFLWjNDeHZKWDJab1A1dE0wMHFaT3pB?=
 =?utf-8?B?S0phQ0FUOVczZzZSTmw0eTlGT3A5aVQ1VmdRVnN5ZEZnUkl4K3dySVg5NGNO?=
 =?utf-8?B?R1Viakc0a2tTcGdGb3ZXM2Vsb2lEbFhBZXIwZzVUYm03QlhOamNYNmtLRjhK?=
 =?utf-8?B?UERLenNpYitOd2ZYdHRjaVlMdHpLUVl6UjVxZDRXNzd0U0NEZXROK2dFWkhY?=
 =?utf-8?B?NW9QeXI4aTlZU3JXaHE5UjY2bGRnZ202dHFrcVJ6cmJkS1FwZHZySjJFQmpx?=
 =?utf-8?B?MTU5ZldMTUdGemNvRXIydjd1YVZZMjJnby9ESHpoR0Z0M1NIL0J6dTEzaXpp?=
 =?utf-8?B?d01GZkRER0M5VnV6TzZJdDZKT3YxRDUzcEFneksxOENwSFpwTzhIOUsrZnVY?=
 =?utf-8?B?QUxISlhCR2pscHU0clFGWk51Mk44QzY4WU9JeHkyT0xsZ0tXZ2NaTHkrcFVV?=
 =?utf-8?B?RjlUNGlTTGs3UUt6VncrbnQwYXhlU1dEc08rUVJibmpsUWkxTndPTHZad0lO?=
 =?utf-8?B?RGMwTGpDbXU0WVB1RkJCWlRwR3ZrMjdKUFlvdEpwK3hEY0JJTnhtQ0NhZHJs?=
 =?utf-8?B?Ym9PbDlNMVhyWVNlQ29GRjR0RUEvbmhaSktUcDY4VGtSbXBVRHVnSzEyYXFo?=
 =?utf-8?B?ZnhhbUJVWmw5M0U0b2xBbnQ5THhKTWNZaEEzSkhLVUhqSG96emsxbHlMVEJK?=
 =?utf-8?B?dzhJcTJ2TGdvc0NaTHhjSHNRWmRISVlqQno5bkxSaHFzUDdBN0ZqTlkvd3do?=
 =?utf-8?B?dTF2K0NwOVRaV3RuMmFuSmNURmtWMHQxM2VXV0F1SHFmWEMyVnZKRnhJTlFD?=
 =?utf-8?B?RXlFSnhmL29CVnUyQUJ5VFJMQW8zRjZBcmJVTllQVmc2N0ZDRlZraTdidGl5?=
 =?utf-8?B?MWo1RVlWdUFNeVFUaVJNRmd4MGFOeExHd2ZnNHpWbjNsTTg3K1lEUkVBeVQx?=
 =?utf-8?B?aWhlc0tFc1RaLzBnQVlGeWpOeVF0bTNQYlhZODM3N1BBZm1QMWxIc1RKUVlW?=
 =?utf-8?B?OERTSjlMYm85WjJoTFNrT29TQ2tZalpIMUhQMno5MHN2bHFyRXZsR0tYZ1J1?=
 =?utf-8?B?WEptdi9Mb2tUTXMycEorUm1UNnJPdmNlUFZ2dWplTkROYnJhRVVlbjdMclQ4?=
 =?utf-8?B?cTR1clRwZmFIcUdvZ2VETXFoMGhVNVVZZDVhdWZBK1NaT3ZYM3dDUFdRWkhI?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865d3b92-3d26-474c-c43a-08ddb4d145cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 16:48:27.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVEaU6czsOOqwx8EJgoHxg8203Ah8ZBe6+0c6pSYx0w6WR/jrhQcWUn5tAOyz5A3AlI+qQEsa+IAJaCpOAlHJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6430

On 26.06.25 18:17, Liam R. Howlett wrote:
> * Florian Fainelli <florian.fainelli@broadcom.com> [250625 19:13]:
>> Linux has a number of very useful GDB scripts under scripts/gdb/linux/*
>> that provide OS awareness for debuggers and allows for debugging of a
>> variety of data structures (lists, timers, radix tree, mapletree, etc.)
>> as well as subsystems (clocks, devices, classes, busses, etc.).
>>
>> These scripts are typically maintained in isolation from the subsystem
>> that they parse the data structures and symbols of, which can lead to
>> people playing catch up with fixing bugs or updating the script to work
>> with updates made to the internal APIs/objects etc. Here are some
>> recents examples:
>>
>> https://lore.kernel.org/all/20250601055027.3661480-1-tony.ambardar@gmail.com/
>> https://lore.kernel.org/all/20250619225105.320729-1-florian.fainelli@broadcom.com/
>> https://lore.kernel.org/all/20250625021020.1056930-1-florian.fainelli@broadcom.com/
>>
>> This patch series is intentionally split such that each subsystem
>> maintainer can decide whether to accept the extra
>> review/maintenance/guidance that can be offered when GDB scripts are
>> being updated or added.
> 
> I don't see why you think it was okay to propose this in the way you
> have gone about it.  Looking at the mailing list, you've been around for
> a while.
> 
> The file you are telling me about seems to be extremely new and I needed
> to pull akpm/mm-new to discover where it came from.. because you never
> Cc'ed me on the file you are asking me to own.
> 
> I'm actually apposed to the filename you used for the script you want me
> to own.
> 
> I consider myself a low-volume email maintainer and I get enough useless
> emails about apparent trivial fixes that end up causing significant
> damage if they are not dealt with.  So I take care not to sign up for
> more time erosion from meaningful forward progress on tasks I hope to
> have high impact.  I suspect you know that, but I don't know you so I
> don't want to assume.
> 
> Is there anything else you might want to share to entice me to maintain
> this file?  Perhaps there's a documentation pointer that shows how
> useful it is and why I should use it?
> 
> Right now, I have no idea what that file does or how to even check if
> that file works today, so I cannot sign on to maintain it.
> 
> If you want to depend on APIs, this should probably be generated in a
> way that enables updates.  And if that's the case, then why even have a
> file at all and just generate it when needed?  Or, at least, half
> generated and finished by hand?
> 
> Maybe this is the case but scripts/gdb doesn't have any documentation in
> there, there's no Documentation/scripts or Documentation/gdb either.
> 
> Can you please include more details on the uses of these files?  Failing
> that, perhaps you could point to any documentation?

FWIW, I once wrote
Documentation/process/debugging/gdb-kernel-debugging.rst. Hope it didn't
age too much.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

