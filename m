Return-Path: <linux-fsdevel+bounces-25728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7A94FA89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A9B1C2227F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 00:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BECA34;
	Tue, 13 Aug 2024 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="85fU3MZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E518E;
	Tue, 13 Aug 2024 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723507468; cv=fail; b=fuh1JJpUrx/9JXgfJ9rcv7JrngN8N1qDlqCT9pFLvC7V36X4CWxHBIkHW01qBxnJ594fkJaccl5+z0A61A84AJyeI22nvu+BW5RDtBisZmBlXjWyoI8utV3GPogeDzx+QVrGtfNiPGPEXIlEO+XGgyn6z3pzqXtIhZzTtH7qsng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723507468; c=relaxed/simple;
	bh=OiPvRqHcFng+zQdDkxqv27uruCSmoqaRZGPrLXQNJsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aFYtxh0IYp694dPfcJAEWh+IgVRoJZ5iZv6XkL1zBttW6l3f4GYYJUlQqtwhBMECX+Lc4XDT1Wud4h9BtRjQu9ZIgq5kR9zgE3302D/+l/53WycqqG5/oZUvhOGQ/cmR2Hjx5W+vS92TbFMPCk/n/8svCY1LmIIm+Ufc+ogD8fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=85fU3MZV; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723507466; x=1755043466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OiPvRqHcFng+zQdDkxqv27uruCSmoqaRZGPrLXQNJsw=;
  b=85fU3MZV36wndmDpFUfiHa70iqK9hCK6uxaV1fpjHr7Ns7jvLOwO2MJb
   tkwY+26PLEIHEW6bVnsla98fYC3pKeRQT0eLHPzfWgIV0FypFntLzOq+z
   ChMP+M9pjEqc3epcKU5jmsHsuDP7S2VvBDnKY+Gi106jTKgreDTaXogQl
   Y=;
X-CSE-ConnectionGUID: Z2B4yre5TP2k20o0uEXGfg==
X-CSE-MsgGUID: dugHXx8xTUGvP+T47WNtVw==
X-Talos-CUID: =?us-ascii?q?9a23=3AOn4ttmobF6PIVy0kcFKxw5nmUfJ/WCHM1nqNH3f?=
 =?us-ascii?q?iCjwxT+WIZG+/9qwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Adxd+QQ4W+63HmaqWhnUhIsIexoxk/quOOFBdgak?=
 =?us-ascii?q?7lNe8dhAsZAi7kAqoF9o=3D?=
Received: from mail-canadacentralazlp17012026.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.93.18.26])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 20:04:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuYPNHub+kdNa2xQlNDhLPDCsb/ByPjTonE/maPr+IFcqskO6pYpuTl/lBSXn7OG9Qw5FFf0dNJFa7MjAk9Jh5xFKSYgHSa2KLcrJj+78E+N75VbeS/jQuHm1SeBgOkuC8y8SA6mZ9/rc/9fPELB/UfgstpgcEV829vCS0WxiHnsxVGecSq1lFv29A1i2BzbinZp2Li71uVQRXsNXvcu8DVKH5lqh6hjbSh1C8lFCQ2LjygPmLDln6nBEYc68k5xdOZ7O53eYdnz1DlTT2gVThtDxzC7Akj82c69H/nQ4gvh4f2PQO0uq10dGKTzzopUmd3jpho1jS0Gz9vEf/k2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4j8DCNV34X70t0CpsXp5/V9yxYkgSzsSBaIofLuQas=;
 b=FRX817mxcJwdGdB6Xa4j4Kn4gm2710UQho5M7YtWJ8FbIzGfIxvCV31/AT3FmkjMGQspWVLoN6spTI2R24S8LL4bOYG0WT30zEI/wxjDX/UZxfOGeyQxM+7IiFeFW68xyFGc906l1rZwzCz3PwGlHrsUssSzbtKR86R2Qg0PB5NKDlTCwMR0V1Vl2UjEZzpeRkclkU0WnBNXL+RkwUaQq3Qm59eGIcJe2XP6gBkhaQxbbvmvGo3kIo5o0Xb4KmEw/WHTjtVNCylWa+zxbQYvKpgFZh3LGMI1ObfoT7HNudQaSMy4g5tnTe++gTHB4FfrMfZzp0kYTA4WPC9TFxjh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB8518.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 00:04:17 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%6]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 00:04:17 +0000
Message-ID: <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
Date: Mon, 12 Aug 2024 20:04:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
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
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <ZrqU3kYgL4-OI-qj@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:32::11) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 17318e65-be45-4362-b021-08dcbb2b7934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnVrN3YzRjZncC8yK2FCanNtbkpIZGxEaEs3L0RlR3llN1J0dmxQRDFSZzly?=
 =?utf-8?B?UFFJMEg3RWxXdkh5TDVhZllRaU9PemtEaEFBUTFraDJzeHlvZTV3UEZkUncx?=
 =?utf-8?B?L0psWStxLzhBTVQrQkZLbEZjblRlK1Uxckl1YXA3eFpLUW9uelBIRGkxQVpj?=
 =?utf-8?B?dS9pSFY1NEJuU2IwbS9DSk5RN25sekF5V3YvclZrTEsreWJTRzJ4VzhiZTZ1?=
 =?utf-8?B?cVdYRnlpOGhPOG1mQUtCYTRXY2REMEdvaTdCS1pXWEYzemk5RTZMc0puUjhD?=
 =?utf-8?B?dXhZWHZCSjNsUDZ1TmNUWHkxaW9mY0ZVS2xQcDZtQUhURGNHcFlBbFVmUjQ4?=
 =?utf-8?B?SldxTEtvRlgvbTd2TTFIVWRxWXBqU2N0T2UwcEgrYWRaeVBmQ2hGektQWXRM?=
 =?utf-8?B?M0IzUjFZeC9TeDl5aUZ5U2ZYdXlPcjZSaFlFc05qOWEybFBrSWNrZ0x4dGpV?=
 =?utf-8?B?ZXlnQ1p4a0tGQzlsb1hrTk9SSEN4M1EvYytwSTRwbG4ydER5ckxDUXdqSWhj?=
 =?utf-8?B?QnJkeHJldjhSVno4T0ZjTnBmNm9qb3RXSmR4TlIwTmdISnFLWllPbnpHQTdm?=
 =?utf-8?B?NjdRKzdpdldUS2xPaWFKZHJ6THhxUkh5dXdSVllMZjkwQWMrdDYyZGh3dHBx?=
 =?utf-8?B?TDhpUkk0dERNZUc3RWI1Sy9uZmNnK1k1Y2ZDeHU4TDdKT3UwRTNIeEV0Mi9W?=
 =?utf-8?B?cSsvMkgvenR2cVpYd0xpbU12VUYyVVFFVk55UkZhM0lDRUdFK0c0Z1FRdUtk?=
 =?utf-8?B?UFRBWk45cFhyYStsZjFxSHdVMHFZSmtpOXI3MklzaHIrR3BJZUJNbWNtdHdm?=
 =?utf-8?B?d3UrRm5GQi9RQmk0M2tBRmVjdlZEbGFWN0RSRHZQckJiR212ZnFsZ3BDZGVt?=
 =?utf-8?B?VmMwbWltNzF2a0E3Sk9nbWJOSmYwVUVXMkZjM2xOZUo5M2VGR2lmcFVBckwv?=
 =?utf-8?B?ZWJ1bExDM05RdHhjV0ZaUm5HT0lneVFHZjNnT1Z5VGpvZ2pYckZBa2FZcXlQ?=
 =?utf-8?B?emNPV1I5N0xvcFV4VEtNTGNaVVIwc3NSZnE0dUl0V1d5Qkt2YlE3b2RIdmdC?=
 =?utf-8?B?cVRseXFyWXYvY3duU3FiclhRYUwzd2hHL25LNDJPcWp4TUF2bVRHcCtIeVNt?=
 =?utf-8?B?SDlHUEpraDZlb0lhMnhrbDJIdEhYN2VJWE5zSlJNMWwxRFgxYVAwQUo5V3NG?=
 =?utf-8?B?TVhyY29MWjg3Q2JmVkVVY2ppMXRWZThiYktXQ2NERUNweWEreDgrU0hwa1c5?=
 =?utf-8?B?K1h3UFI5WGlaRm1zdWdXekxSck9KSnd1ZFFQTXFUS3Q4cGNza3RCemtDNEpZ?=
 =?utf-8?B?OFcxY2hxWGdzVkk0c3NZeW15MjZOWkxVMjZKSmZEdmxoM2ExYWkzcFhIVnNz?=
 =?utf-8?B?SjlYU2pWRzF5UHNTbE9na2dTbUdFZjlKQjY1YlNjQitiOUR4dGl0NFF3cXR4?=
 =?utf-8?B?TGpSV3AzdFBGVWMvN2tVZ1FmKzRjUjA1TUhNL1Q5SUtiQVU3TEcyVVo4S0RG?=
 =?utf-8?B?MDJzZ293QncxNE5YNzBMUEp5Rmh1blY1NmpJZzdxRzNMdGwxWnMrRmltbGxR?=
 =?utf-8?B?VVVPQ01mZUtSdTg1YlplcDhhK0N1YzcwejRRRzFnNHoxdnRoa2JCYWsvYmNr?=
 =?utf-8?B?SmpkMUxuKzVPdzNwTlhJQnZhZEtEYk9RSUlyWDBkQ2VZaWhIb3phR2Y3Y3c0?=
 =?utf-8?B?czlTTGNYMWczakJBUFI2Yll2Q20xZ0J2UlVZa2tRZVU3cGxOVlUzVDhXMUtN?=
 =?utf-8?Q?1rUBul77C5A9T0Qn7AGKE2TrnlfevukPnAaxc3i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGtBTjBBMzFXdHNUV3cycGdvc1gzNE1obzd4ZVg3S0Q4K1pPOHNqUytoaWZu?=
 =?utf-8?B?bmdaeTh3N0NoYXlpbmhoeTBSOUxYLzlrVlEyN3dDTHBCenp6eGRyK29za2Ft?=
 =?utf-8?B?cDlJTi9nWStnMzBuTmU0RC9PbU9jRmRtU2tneE1oczYrcHd5d3VCcmxhR0ds?=
 =?utf-8?B?YkZUWlFlOTRzNGdzYklrRHNWZ0FUeUV4V2FqeGdGc0dLNERsSm03NC9rQ3Mr?=
 =?utf-8?B?N1JSS1hnOFB3WDVxaFJKSWRMQWpVelZFaW9HVmphYWxIQThWS1J6ZldaWkds?=
 =?utf-8?B?Z2lkN3R3NVdTWGFjQng1UjAxaUpMam9QdVZZMG0rWWMzeDRwY1laUmxQWUU2?=
 =?utf-8?B?MVl5UzY2eDZuY0VuQ1orTFdCSFo0RmpldjFSZ2o1OUY2dExKVGlYNEM5YWww?=
 =?utf-8?B?T2d6Wjkrc09QeFg3LzI2NGliU1NKTTFjMjg2dzhGei9qbjJwM2gweXluSnY0?=
 =?utf-8?B?dnM0Zmc4bGY4RzMvOEdiemM1TElFM2FTejhRZFlzU2VhcFI5NWxJb3F3QSta?=
 =?utf-8?B?Rmo3Y0ZZZUxXR2NrSGR4a0g4MG93T1h2MGpISWVzWnR2bG9xeiswL1IrR2NZ?=
 =?utf-8?B?R28vUGpTbExUUm1Dak1aNzhzcllxcW1KNy9GVThuMjFveDNEYzVWamFpcU9U?=
 =?utf-8?B?cUZCbkNrc0lXNmZ2SlNCdjhJWDMyaHZEUE9MLzFCc3JXblA1TjZKMll3N3k1?=
 =?utf-8?B?OVRWSUpsaGNIQjR6VGQwcENVQkIxeWZkNk92ZFNaN3lLVjVrdEtybmRyYnIr?=
 =?utf-8?B?V3ZVSEc5dUl4cG1yOERCZEdGcHhONTZPTXZpbCt6K3F3YzY5MVU2bTRkWHI4?=
 =?utf-8?B?aHA1eVROWWRqQ0FPMEppTXJsaWpWVE80TEdxUmM3Z3RwUTlUQmh0MFpmSVRY?=
 =?utf-8?B?UzV6aUYzTHVBQmFZVnZ0NXJWZWZUamgya3M2c1NoYkRJS2lDSkJHUHZZQktq?=
 =?utf-8?B?UlJBZmE3TjdzSzRUeU51Vk1kMS9vUTBpRlRWcTk3YlpzeVJoQlFsVnhtTnRj?=
 =?utf-8?B?RUZMdEx5aERPRkJNZk5wL05pQXp1ZmdEYWwvMjRJcW95eERiRGRVbXozT3lG?=
 =?utf-8?B?cmY5SzhCdEZKeVFnR1p0S1N4OXpqVG9JM2t5d0hBWlB1NTVKNzJ0UktnWXlj?=
 =?utf-8?B?dkMzQTc5R081UFF5MU0rbHJWbUplNHlINzdmYXdMZExLeGVXK1E5Ym44UTFk?=
 =?utf-8?B?OGFXbm40cWRsaU11Wk4zeVoxQms1QllyWkNuSkFGYmVyM21YaTQydFoyU2pr?=
 =?utf-8?B?YWZocG42ZjlyZW1GMHY5YjdTRUVJL3ZPd3JQVi9CY1RrNm1UbTEvM0pHeVpG?=
 =?utf-8?B?NU9PcHpKL3QvU1lBV1hmTWs5SmJoMWRkaVVrU3JaUWhnNXM3S3B6S0gyUkw3?=
 =?utf-8?B?ZFFLWHg2dGp6enF2bVBnanJtbnRhWWxpVWdlU0NJOU9Ia1VRVnV1QVF4VVhB?=
 =?utf-8?B?YUYvaU9rK3NFMEtGR0NaY3NxL1Iyc1FVc2JLUjl1aUdXMjZNNC9jR0hoT2Fr?=
 =?utf-8?B?WEJyZGJsM3NIWW5sZEZhTXlzVU14T25ZaGlOcVUrU3E0bDd5dEJtWDZEeS8y?=
 =?utf-8?B?VFIyU1huT21Tbjk1SFVKZC9zazRqdStFditKZHNxRHY2Ukh4ZHRML1FUZTFS?=
 =?utf-8?B?Rmx4dWxqK0xtazdOcnJmVEo4RzF2MjBPZmpjWVFKQXltZGZ2c0NyMVplM3g1?=
 =?utf-8?B?MDh3QzNUTmMvZnFhWW1ZNmEwSGtHWURqZHRHaE9tTmlzbEhXK1lIaU9sdTcz?=
 =?utf-8?B?SGU3SUxnS1RQM29DWnhBSmJyNkJ1Y1hKTm8vWUttaCt2dlI2dzlaaExTaEZW?=
 =?utf-8?B?N1NlRVZUYXFOUU94R0R4VHR6OTNJOU9wYm5qUThKSGlyOS9jZFlieWUwcm5u?=
 =?utf-8?B?dnRpY05lVWVKNk1qTk5NSVRxeHBlSFJNS2hJV1hRWUpkOEVsUzI2SGYxa1Fv?=
 =?utf-8?B?SExtRnh6ODMwRDcxZDJFamYrdlNINTJaWFV3UVhoMjhrRm9GaWUxRkNLUy80?=
 =?utf-8?B?d0MreHhDNXBzSUlhUVFxUzc0cHdUejNWU0pjcStaQnc4N3VHRjd1Qy9nY1ZE?=
 =?utf-8?B?SEhiL1JzeVlRNjdPK2Zqb1pEQjhqSmxWNkdvUS9EQktRMEpNVXROcW5FTVNa?=
 =?utf-8?Q?Ts2MAp9KErt339U9lZtHQM2Wv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W135T5s0mPa3cgXXfKlcBsvnMVyVuPxt8EUYfZmosg7AoVXtQRVGoZ75edJRdeu40EXoEYsrVt3sEf23BhnhsWR32pYs7Qm1NrJeVrcH1jyGRpaapwykB960G8XatqyVVAJ+DuMGvQaupPEiqpcc9eBwEpYfRo46L+v5VYt0thh7q39x4tuKoDRLclcwqMF61wQ4KqjqEfQ9ZJh5o+nb1hqnSIEFTNpB+xcpGQmMa3EVn/C1dqPv/N4UYg7RHCsPjIq8Zm+xIkS3bnKRzuYAJ5wQAQ3wa0tSAiiindpFL09OcUQdOLZk+1RdO52bViqn5Lltan1xX7t4t0rZXvgzhMCF/RxXGfZT2wMF7D+XnA8R6vDdghhWLisieYhLfA/1CwdNb1rvga6faq27NJkedf/ENNR5pZ0ir5aQ7NY7QSROLexpKc3U1Dhio2OaOF87cPJJYV8va+vbarB0l5b2CxjhGIoeI8n7c5hvRaYq1nBx+nOhfEzK5+GpXqPNjkId32QjaD+pt+MXfZUXlbkcLccLC3N2yT1vY7nquoL0X+93BA1Myky1DELqEO2r3Dm1oLK6YNr5b4Ij7P97t6QSlaWxtUi8nGPqcYmtewUz8S0uNPBFUQ22IZ1iJhhsOmhO
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 17318e65-be45-4362-b021-08dcbb2b7934
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 00:04:17.2360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSEcC6gUh7S8BNP1bP0+Bjmy7KbN/b4DM/N/qGqL0+lhRm+1HIZgaDIokb1JmmbuqGAW/HrAdbmGlWXhPTt8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8518

On 2024-08-12 19:03, Stanislav Fomichev wrote:
> On 08/12, Martin Karsten wrote:
>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
>>> On 08/12, Joe Damato wrote:
>>>> Greetings:
>>>>
>>>> Martin Karsten (CC'd) and I have been collaborating on some ideas about
>>>> ways of reducing tail latency when using epoll-based busy poll and we'd
>>>> love to get feedback from the list on the code in this series. This is
>>>> the idea I mentioned at netdev conf, for those who were there. Barring
>>>> any major issues, we hope to submit this officially shortly after RFC.
>>>>
>>>> The basic idea for suspending IRQs in this manner was described in an
>>>> earlier paper presented at Sigmetrics 2024 [1].
>>>
>>> Let me explicitly call out the paper. Very nice analysis!
>>
>> Thank you!
>>
>> [snip]
>>
>>>> Here's how it is intended to work:
>>>>     - An administrator sets the existing sysfs parameters for
>>>>       defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.
>>>>
>>>>     - An administrator sets the new sysfs parameter irq_suspend_timeout
>>>>       to a larger value than gro-timeout to enable IRQ suspension.
>>>
>>> Can you expand more on what's the problem with the existing gro_flush_timeout?
>>> Is it defer_hard_irqs_count? Or you want a separate timeout only for the
>>> perfer_busy_poll case(why?)? Because looking at the first two patches,
>>> you essentially replace all usages of gro_flush_timeout with a new variable
>>> and I don't see how it helps.
>>
>> gro-flush-timeout (in combination with defer-hard-irqs) is the default irq
>> deferral mechanism and as such, always active when configured. Its static
>> periodic softirq processing leads to a situation where:
>>
>> - A long gro-flush-timeout causes high latencies when load is sufficiently
>> below capacity, or
>>
>> - a short gro-flush-timeout causes overhead when softirq execution
>> asynchronously competes with application processing at high load.
>>
>> The shortcomings of this are documented (to some extent) by our experiments.
>> See defer20 working well at low load, but having problems at high load,
>> while defer200 having higher latency at low load.
>>
>> irq-suspend-timeout is only active when an application uses
>> prefer-busy-polling and in that case, produces a nice alternating pattern of
>> application processing and networking processing (similar to what we
>> describe in the paper). This then works well with both low and high load.
> 
> So you only want it for the prefer-busy-pollingc case, makes sense. I was
> a bit confused by the difference between defer200 and suspend200,
> but now I see that defer200 does not enable busypoll.
> 
> I'm assuming that if you enable busypool in defer200 case, the numbers
> should be similar to suspend200 (ignoring potentially affecting
> non-busypolling queues due to higher gro_flush_timeout).

defer200 + napi busy poll is essentially what we labelled "busy" and it 
does not perform as well, since it still suffers interference between 
application and softirq processing.

>>> Maybe expand more on what code paths are we trying to improve? Existing
>>> busy polling code is not super readable, so would be nice to simplify
>>> it a bit in the process (if possible) instead of adding one more tunable.
>>
>> There are essentially three possible loops for network processing:
>>
>> 1) hardirq -> softirq -> napi poll; this is the baseline functionality
>>
>> 2) timer -> softirq -> napi poll; this is deferred irq processing scheme
>> with the shortcomings described above
>>
>> 3) epoll -> busy-poll -> napi poll
>>
>> If a system is configured for 1), not much can be done, as it is difficult
>> to interject anything into this loop without adding state and side effects.
>> This is what we tried for the paper, but it ended up being a hack.
>>
>> If however the system is configured for irq deferral, Loops 2) and 3)
>> "wrestle" with each other for control. Injecting the larger
>> irq-suspend-timeout for 'timer' in Loop 2) essentially tilts this in favour
>> of Loop 3) and creates the nice pattern describe above.
> 
> And you hit (2) when the epoll goes to sleep and/or when the userspace
> isn't fast enough to keep up with the timer, presumably? I wonder
> if need to use this opportunity and do proper API as Joe hints in the
> cover letter. Something over netlink to say "I'm gonna busy-poll on
> this queue / napi_id and with this timeout". And then we can essentially make
> gro_flush_timeout per queue (and avoid
> napi_resume_irqs/napi_suspend_irqs). Existing gro_flush_timeout feels
> too hacky already :-(

If someone would implement the necessary changes to make these 
parameters per-napi, this would improve things further, but note that 
the current proposal gives strong performance across a range of 
workloads, which is otherwise difficult to impossible to achieve.

Note that napi_suspend_irqs/napi_resume_irqs is needed even for the sake 
of an individual queue or application to make sure that IRQ suspension 
is enabled/disabled right away when the state of the system changes from 
busy to idle and back.

>> [snip]
>>
>>>>     - suspendX:
>>>>       - set defer_hard_irqs to 100
>>>>       - set gro_flush_timeout to X,000
>>>>       - set irq_suspend_timeout to 20,000,000
>>>>       - enable busy poll via the existing ioctl (busy_poll_usecs = 0,
>>>>         busy_poll_budget = 64, prefer_busy_poll = true)
>>>
>>> What's the intention of `busy_poll_usecs = 0` here? Presumably we fallback
>>> to busy_poll sysctl value?
>>
>> Before this patch set, ep_poll only calls napi_busy_poll, if busy_poll
>> (sysctl) or busy_poll_usecs is nonzero. However, this might lead to
>> busy-polling even when the application does not actually need or want it.
>> Only one iteration through the busy loop is needed to make the new scheme
>> work. Additional napi busy polling over and above is optional.
> 
> Ack, thanks, was trying to understand why not stay with
> busy_poll_usecs=64 for consistency. But I guess you were just
> trying to show that patch 4/5 works.

Right, and we would potentially be wasting CPU cycles by adding more 
busy-looping.

Thanks,
Martin

