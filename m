Return-Path: <linux-fsdevel+bounces-26369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E4C95893F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93551F230D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6581917CB;
	Tue, 20 Aug 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="4ubXbf89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A529D19;
	Tue, 20 Aug 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164116; cv=fail; b=Mrj9AfAs8MSF9mP2XGSnkbp983oBYokPZWHhjVV6ZgvsGWQIODUBtBkcnlb8xUGb3TaEg2Qk7DBCnLjBIUOYLdsh2zH6dgyyG+/174Dzbsrc0VcZ3hXgied+k52oLYFVbt2GRG378wgENnmy86qqCU2sBkyGX2DddW12Co+sUvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164116; c=relaxed/simple;
	bh=cfCg7+V+bDh74G0nsJn7vWZxrvAhilgPoUFsDRlRRiU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pdYVN+IPirCHS4tuACuEtLN+6V5e4OJ1fy07qsQXTRrav9Dg2DNsomjz/iC4fc8Unsh4XgwVToyf3+c9UhciH+xr6RCMPzXBVRT960KP3+GeCHC4XAKOzvkc+fjTgz7Y0ktZx9PdgXwqEvQmd+CctBuOLRBmkgtwjGGy4sxXMKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=4ubXbf89; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1724164115; x=1755700115;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cfCg7+V+bDh74G0nsJn7vWZxrvAhilgPoUFsDRlRRiU=;
  b=4ubXbf896dJkccc5n+VW85AVzQy0nu/bHOcYyaNx8Q11ILGl2wRpzhSw
   ZDSvoZwg/tBmS0lziOjyI/LPyv62oNG74LnENNOKqWMKJYo4iToISl8RF
   sgn0rpwTqE5gmD7qAbadKq0Xz0ZP88I1ZPi/xvx7KntMwVe2+WUNbaJJj
   U=;
X-CSE-ConnectionGUID: qe2Q5d3bQvKCpgg13s+D0Q==
X-CSE-MsgGUID: fpshwW6XRhCqdNmO82Z6dw==
X-Talos-CUID: =?us-ascii?q?9a23=3AzDNjSGuTO4bouWOkGlBpLkXi6Is8fyfkkXuLKXa?=
 =?us-ascii?q?mKk1xR7LMEkTT1Ptdxp8=3D?=
X-Talos-MUID: 9a23:ZZ/F6gjOctiYIc3QzfodBcMpOt9z47uRVnA3kb4ft++BEnwqCWmRk2Hi
Received: from mail-canadacentralazlp17010002.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([40.93.18.2])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 10:28:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB88/dxG6thRQhPDLqpOOiWFVsXVJyyOA+/c+OvdselnYbEUGZJbWmcgpHVkL2R06UEI4km9MYaImM81sUFwuKoK8qk/rz/QxfYbrlW/HP4oHN+kVhPW9kmlcgg5rOFN5yVfnXUtby83Lm/UT9OItwHSUp4DgNvmz5hegjDz98rUgp15hOrtD3bgLEo0lj0gKwSd0rwd6UdfXe41bGzvOzWz+P7VW1pU+farl3oQI5puGTSdn2R+k05JTVR1QYTyvp48BkVHyNuwNFuhxH5hsqMa1XjODQE5JbqhE3FYGoNcorVA5godH+/Zed/8p6Z1IOHHY6RbLLEU8G+fYKQkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp0cwmdj+ByNxSWCYszhPQFNdhiC6Ngt1oYUIAyKIxI=;
 b=dfUZqUYPToKIWV7mvDfSLP3zTzJlHOXotiiMI+pNNrkuarmJNskCOa76MCiRseBeqhXptfsVHQQoZMI+r9oCT7WW0NoiZrLwkxlgsZa6zGXyXjgak7CRSjSfIiJBEzhxwVLmR4Nfwqh0YJoCF2K96oGXt/R6bFHiitzjUcwkDrklESDvLH7ehSk5iKZ1RRN3KLMxWbkXFngUo8c26eNfxIZKe2STn9/67StUvBAnlM/NKhiPhlzNFsw7JWOhGgr4InXSFbesGY+soPAv8IaP/R29gTtl6m+KNfJKIWish63IyVVtazThcCYOhgeDSwzdpdAZ4wGA6YluJ6GzI+FUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQBPR0101MB9327.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:62::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 14:28:31 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%4]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 14:28:31 +0000
Message-ID: <3c7543a5-891b-4aa8-b6d5-32afb6835035@uwaterloo.ca>
Date: Tue, 20 Aug 2024 10:28:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
To: Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>,
 Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jan Kara <jack@suse.cz>, Jiri Pirko <jiri@resnulli.us>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
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
 <4dc65899-e599-43e3-8f95-585d3489b424@uwaterloo.ca>
 <20240819193610.5f416199@kernel.org>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20240819193610.5f416199@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0272.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::24) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQBPR0101MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: c19fcc31-f2f4-41b4-3d44-08dcc1245d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a24vb25BWmpjSElSQkc0TDVPSEh5aU8wQ2VVcTdaMzE4ZGxBaVg2dFZUNzhU?=
 =?utf-8?B?WjUwUjdjNjJMbmJYM3JJbEM0NGpOeTc3Z0M1VFdZTTBvQXMzZ01IaVVoTWFz?=
 =?utf-8?B?ZU45bDliSDRMK3NCMjNjOVkwU3hMWG9oZm03bldoTnN3dTgydkRNSnhEaDJw?=
 =?utf-8?B?NTBkdnVoY1RVRU9pKzZTc1ExeFZDRGU1SmZpRkNIcXhFYVhkSmlYNUxIYkNr?=
 =?utf-8?B?SXY1alNIenNmczFwZjNCQ25uSWlxKzVZUk1BWHhya0JpQXBiK0IzOG42dXh5?=
 =?utf-8?B?eUVJMXE2cFBxZU9JVFV6MXY5WmFZTGFmbGd3SE52ZllFeDNJMDdiMEtyNlpQ?=
 =?utf-8?B?d1Jib0hCeXZSbGZCMXVnWEJhV01vK3VMbGtBOEJERWJYRFRYdzRtK1Zwcjc5?=
 =?utf-8?B?ZDhYTzRrR2htWTV4aXhaS0Y1NTVPT1lWNzJqZkY3SFVlRElyK3pYUkQ0T00y?=
 =?utf-8?B?VTgvOVZzajhvd1ZqTXhBM1ZpdnlHM2pvSngvRmVZNC9BS2pUWkh4bEFMT0th?=
 =?utf-8?B?RGFKeGViV3k2eTkyVW5URURYdTVMRk0yY2lvVU80aTVpbXg2RlN0d0JNU3VH?=
 =?utf-8?B?aUJqZkZ6elE3REVQU0h2N2pBQ1AvV1RQTUtET0JzVm93QUlEdTNldkZmMlox?=
 =?utf-8?B?ZVM1M1VGZ2ZCWUJtdkdramNqQ1N2SVY2cno2elhYcG1qVktkLytyTllaQVFC?=
 =?utf-8?B?LzRUbmJUdS9SWTJhKzlVRUltOEp1b0dKcThxZTlGRkU3VzluTGhKZmdsd3N5?=
 =?utf-8?B?UkhUQUl2R3hJdFoxQXAwcFprU1R0SnFRektFYTdqS1V0aCtNdm9QRGU0b3Qy?=
 =?utf-8?B?cVJtVm5iWVVyU3RMQzJGK3lHOGlQa3k0OGxHdllIVmRmN09ZbXUrc0xybVg4?=
 =?utf-8?B?R1FzOEMzZ2Nha2tlT1ZlOEd6RllJUVBwdDhRWDY4a2gyb1BkOTJiTmxmMXA3?=
 =?utf-8?B?TlVidythYjZGalB6Ym1rNURqQTFXWU5vV2R1WHhCRXk3Qm55Z2xlektVL0p0?=
 =?utf-8?B?WFdqcno5NXZrUXdrYUJ5RFh4bFp5ZlcwS0F3SE00bDNvcnYvMnVTcHVjemtU?=
 =?utf-8?B?bmM2b2RNb1BBdGtKV1JPOHAvbWVQK0pkRXpYRVRObktOZkxtRnBUdHdaZVM0?=
 =?utf-8?B?akxCSEZKNDVvWjF2eDRFZGYvbklvRHphWFVQMS9FalhqT0dranVDU2Frdnpa?=
 =?utf-8?B?OERvdEpseWtXakpuSWhXRFJMbE93UVlacnFNeVBiR3hZcEFNZWF0a3VXQWlX?=
 =?utf-8?B?b0F0Y3dhTXE5OFR2MlFTZVlvUnVvL3Z2RzFpSjJyVk5Bc21OZXFwRkNoVWdB?=
 =?utf-8?B?elAyT3ZBQUIrR0x4aVcxc3I1YmFaaTVqdHR2b1ZqYnBNMkF5MFZ2RVluWFVP?=
 =?utf-8?B?QVpwd09CQU9wR1U3bmpDVTFmSDYxaEFraURQZWJQYmhyelVrRjVYbnRlUjFr?=
 =?utf-8?B?SGVMMzUrL1UvL3JGbkVTUFM4Y0RtOVVwcmEraUY2QzlRTEFBTWNnQ3hVeG9W?=
 =?utf-8?B?bHFMZEZONm5JWlEzS2cwclRZejN3WnpwSUc4SDlFT3EzVlVIaHhReFBrUm0r?=
 =?utf-8?B?VUl5VFRwUzhJajVQclpzQ0dMWWVhN1k5SWFybVpNY2pQM3FpMnhiRkttY0lD?=
 =?utf-8?B?NGpHS3VZZHFMYm9NYmVUNFZIUzBiUERObDZBa3dhMlNiRGNOYWJvdWhodVZM?=
 =?utf-8?B?YVV6VEdUUFJqZGQ5VXdoRlJGV1ZZZUZnb0lEeWNDZWZ4TnVTSlp4eFY3ZzJx?=
 =?utf-8?B?OGVVRzlWb2Iyb0N4Q3RoZWw5T1hVS0Y5d1FHY2krQytlN0VxZU1nZ3llSTZM?=
 =?utf-8?B?TUlyUmFWS3E2RjlDbzU3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWpJakxUN3dFUHI5Y2FwRWhaUzhjS3VqQXZxamtrODdGalRVVXJiTFlKMVZl?=
 =?utf-8?B?MCtJbE1UV1ZBeUR0V2w4eHlzUW1XT2RGejY3SDl2S040Mk5DSG45ZHVGTVlT?=
 =?utf-8?B?VUFMd0FodjVJdG9IamNIVmxVYmZ6VktaTmplc29OcllGYUVZSjhLSEo0eFE0?=
 =?utf-8?B?WnlMZWRKVFg0T21JbnRSL0Q5L3JMU0ZWMVR5bU5FSkJkSGtFdEtrdC80Smc3?=
 =?utf-8?B?cGE4MW5XSE5UOWZYVVUxa2sydmZYbGJLSC9tWG9yTXBITjVwMUZ3dGlGcjJC?=
 =?utf-8?B?ZWNyOXphYVdkNytZZ0c0eFcvakJYcHlIaENrYzlaYUtQTjdRSmlyaER5Q0Iw?=
 =?utf-8?B?NkNOVjZ6M0VQRWdOZ1E1SXdXVFZOQzFOWjdoTnErNGtyTk5YSGxOdjdreTBI?=
 =?utf-8?B?d0dnT2FieUpJQ2Z1L1B3VGxxbldmMFlEb2swM3JIK1NQWUcrUHhFa1gxemd1?=
 =?utf-8?B?MzBIaDdwWlYvaTZNeWVnT0g4L3QxZUlBSWFmN00vK2FBSmZvdTlzcyt1QnJz?=
 =?utf-8?B?Y251RkpzWHF2aEdQWHJ0bDlISU9wbkdoMnNOQ3VIcXUrdFppTEZnMUpJYklT?=
 =?utf-8?B?Y1RRMEhhSmVXMWRjd0VPT3NrSVIwa2JpQnhoRkh1SHFRSVhhTHhybS9tVjVX?=
 =?utf-8?B?SzlKTENud2p2b05aWm5BRnlzbHFSRXFhZi9uVXNzWXM4Z3g2MUZVZk4rR2Fj?=
 =?utf-8?B?Zms4c1lYV200eGZCaGxTRlRNVXIwOFl0TUg4dVFsUXowK0pYYkZhNy9OT29N?=
 =?utf-8?B?WEdJejJ0YkFScjh1RlA0dHBrY0VSRmFkZkpVaWxQcDF3MGlIVFlXT1crNDdv?=
 =?utf-8?B?dXNYbzdJTG5VQjRkRysyc3lxMFBaZjF6L0orL0ZrdXg2cHBBTnF6NHBaWkF5?=
 =?utf-8?B?NTQxQmluN3lIMExnc0pFbExxNzlzMDdlWlpYUWVneG93ekx3TFZORktpdFRD?=
 =?utf-8?B?TFFJWTdpemlZWEY2RlZjOEFxdU1WdW92dnNvWWwvUjRkdGFtcjAybWFnWFVU?=
 =?utf-8?B?ZXNNWmhnVjNqVmZ0cnBUT1dkK1d2dFh6ZlJlWVRUZkJ5ZlBJeGVZNjZqZGhH?=
 =?utf-8?B?OHNoc1ArenFpRE1TSllyYldEK05zbG1aNXJYM0xRTUt6RHNSZXh5QTlqNWkx?=
 =?utf-8?B?S0tTeWM4dktQZ1ZLcFNCSm1nR05nQ0NYWU03L3AzT3pNSVoweWRKdmxyK1lJ?=
 =?utf-8?B?OFhrWW9OY3hyYlluaXEySjcxelFCSitMS25qZU5PSHZNTjB4VFdGRzlaWjFo?=
 =?utf-8?B?Nit0RENIUzJwUmtmeFFoRVhYMTRKZHVuVDRnc2RPY3YvMkQ4UTYyOWhoNnJB?=
 =?utf-8?B?VXZPa3lhaTFIOUNMVHZrWUp0c0ttL20yVkxHenpIQWtIYXBsM1podHA0ZU1G?=
 =?utf-8?B?bXVYRkJCTDU2aVNabXNQaFByUnJxczRSNFFwMEdNWUdaeC9BdVY4a2o4bkNF?=
 =?utf-8?B?QW5tVUcrdW9Lc1NuRlFwV1VUNEZBNEVlVVhPdkpsMzR1TDhtN2FTbmJ3SkV4?=
 =?utf-8?B?VGt6Y0hJamk2UHNwYmdna1BYVGJpcVBERmdyRVZnSkVOSHVxVlhhb3RWcWNY?=
 =?utf-8?B?NVVVVk9uR0xic1N0ZSswanZFNFdLZUxFNjgvemhpQzhEdHAvSWwwMk5WZ2RX?=
 =?utf-8?B?TXlVTXF2emF2M0pscUN3VERwNXN6VmkzRGtCTGhPU0ZtSFBMVGxaWTB1WDI3?=
 =?utf-8?B?UG9keXJDcjhXZzl1aDlxUWY3NXdsWnNINHNlWUdvV0x2UFlBV2dudVYvT2lI?=
 =?utf-8?B?Z1BxWUxkQnNyMGNqVElZZm5ybk51UTZSV3ovTEVORTNUdStCeDQ4Szg2Y1FR?=
 =?utf-8?B?QzcrMml2aUR1eXl4K0NFL1ByK1dpQThJZTZsN2R5ZHZjQ0Qvakh1SThWYnRi?=
 =?utf-8?B?Vi9xYnEvbmhRTldFMUhYRXd3RUppRFhjTzJOUXBXRll1K21CMWdNTkMvdUQw?=
 =?utf-8?B?dkova1ozQ2d2a0E1cWxnajZ5cGg4ZEVSVGo5bldwUGhocGs1ckZscVdnSmZJ?=
 =?utf-8?B?R0xzeC90TzRzSVR1KzVkRzJzNEFhQ3FmRzNQMWJyc09HazJuWFZSdXkrUjVv?=
 =?utf-8?B?Zkc4bWdveityMlJSL3U3amhIY1VPWmx2SHlWc0FMcDFpcXpSTG8wUGtOR0NI?=
 =?utf-8?Q?i8d1Y2TVIOiOCanXBXtUiNiyC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DHmbRLWkY3e4wSUZudA2rfF22IBihe5nk01E0EQC28YFGkNA323PsiVl0zXeJSNEgch5TlrRf7nbsCm2xnefl9ADpdW6R33ehXM2tn45aOjdyFDA88/7e7CkGeNsh8rhtWZzeRn8V0Q/8pn1WRMZSVvtpUCLoDLkFTu4GBNhIzED7uDPfeAMqCUzYGIXCjro3BCWkqBup5/BHIIu1WxwnvUQVPLRo82bY5zsbC7KRtfgGLiGQ6Tw/MavBRorWQ5mQAzkzZRCCcKzLx+SeQUklfvZA3OMuxvpdw53rKo3UIuJv2mvBKyzg+9dx/dp1fjTU6oMGqVUtK/hpWDzwrhtSPl0i5XzOI2yR61/Si60Bt/m1r28NQiS7N8HiQwf3jTGkMWDCXCiNUCv+wHi+FJV80IztK+BWfDsB0mp2Y0xfK0bTDmcEzN0WW1FG3letpYOf2yfOEBhbbWEndfS95+1IxlbdbH6CdqVnnm4WPf/vAhElgthNe4Y2Sra/Ne9IN4VAwX1CUahgthg4PETMQXT6rgoIgR0yk1fS6gdzPKIkeYyhuUg5iJZmPrOd01YIcXvsH887q//YjCGfw0u1cEevwk+J5XPhuTTCR45Rlfzw+3FFVE4lSm1pu6G0GC3xoU4
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: c19fcc31-f2f4-41b4-3d44-08dcc1245d75
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:28:31.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/wu4DPNCP+tQtsJR8JbT3FXQ1lP8/Bq7Wexy1Z92D2ps4ll5yX+sFw4j+Hy6LrjP0A1Qw31gfP9ae12295avg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9327

On 2024-08-19 22:36, Jakub Kicinski wrote:
> On Sun, 18 Aug 2024 10:51:04 -0400 Martin Karsten wrote:
>>>> I believe this would take away flexibility without gaining much. You'd
>>>> still want some sort of admin-controlled 'enable' flag, so you'd still
>>>> need some kind of parameter.
>>>>
>>>> When using our scheme, the factor between gro_flush_timeout and
>>>> irq_suspend_timeout should *roughly* correspond to the maximum batch
>>>> size that an application would process in one go (orders of magnitude,
>>>> see above). This determines both the target application's worst-case
>>>> latency as well as the worst-case latency of concurrent applications, if
>>>> any, as mentioned previously.
>>>
>>> Oh is concurrent applications the argument against a very high
>>> timeout?
>>
>> Only in the error case. If suspend_irq_timeout is large enough as you
>> point out above, then as long as the target application behaves well,
>> its batching settings are the determining factor.
> 
> Since the discussion is still sort of going on let me ask something
> potentially stupid (I haven't read the paper, yet). Are the cores
> assumed to be fully isolated (ergo the application can only yield
> to the idle thread)? Do we not have to worry about the scheduler
> deciding to schedule the process out involuntarily?

That shouldn't be a problem. If the next thread(s) can make progress, 
nothing is lost. If the next thread(s) cannot make progress, for example 
waiting for network I/O, they will block and the target application 
thread will run again. If another thread is busy-looping on network I/O, 
I would argue that having multiple busy-looping threads competing for 
the same core is probably not a good idea anyway.

Thanks,
Martin


