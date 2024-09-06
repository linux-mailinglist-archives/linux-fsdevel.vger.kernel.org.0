Return-Path: <linux-fsdevel+bounces-28841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A570296F26A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 13:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A951C23F5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92AA1CB32E;
	Fri,  6 Sep 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D2kECHoM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D2kECHoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908C1C870E;
	Fri,  6 Sep 2024 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620904; cv=fail; b=d6ybnaxbS5r6/t8AH/5578GDRxSbqLf7X2bdQd5Dg2mQbuydcYjg7uGOnK7uk5fJCH1/2/ZmmfOwO/sfn7t1js1/mGBU8hnrKfZjljZmUstvcyksJCCbjIiTCgij3L04OiNnyJ/3yBvnU5at0DB2x82K1siC7BrYR4xCIzrqYGI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620904; c=relaxed/simple;
	bh=IDQcveTj3Z7tsYMYd/U7PkJLwxrIQ7zK1XUC72ksgDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oYB06Nv8+Qu0je1I1upHQIg3dcTDD9oiyxKjjO4vKowIWDceuAjS22i8LrWHz2Oj2JN4qrNrZ9TABxvxEtug1fKXuwLsTTs4tjdDp84pixqbHJWDYJVHHLUoodoUxj5+dj2AkKxVNZHEIzycie+VoRoSFJx+qvUzvxA3gT2LjK8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D2kECHoM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D2kECHoM; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ShqBId6juTWCOrizhl1K5zcBZpZmgVv9JpeJGxzCzfUUj8ZzWPHbxocvs7MEAHnzX+6BatQ2jZjEcCUBaJm6Q5huhYFU/dW8AoXgF0RZQy4HY67ztfyRd+ZeUZ2Gr142ksc/egLRMdE/KlhrhDlrC6oms77h/tBh95Y1Mj3f6lv0hdDtEjzqVcvIvL7szkG3yRGDZIq17SY2VKc6graL78iWlTN3+hqOFMAaTxunDUksNkYroOXYgOo2Zm9D9AO6ds6/ACBrBGI4esn2ZiP8h8TpuIQiM3ayj5e22dXqzFqcgIsWbqfKMHzDhsCOe8pm3pq/wvlz3GWhWnM4bCoBIw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuGZavkWIIH1h02+xTDKXt3DJz7tzsCjDU++TkIxlUI=;
 b=Zh7aRiU1VB4iTFCO8KSm88+tzsErwKYrv1DF+VeL3r8SOYS8B+rdRSZq44haEbAJX/89ospKoSnIwloV8CLS7blLwjm08lMDjH3WkkJm2ZNWbg4WHdlZ/3kz3vTSpz9CLAhGcVVqfNXuU7vv8jz3xNQtl5y9vjm3SOe+imoaQ5uWjhm9h1rF4Xg55FbAcxPXI4/wlNoMft/aATIynB1cSvubML19MkV4yZ9yYVaGkDezzuVKENt2G+1OXei00CInE6/zk1+Bbo+T45+m/7xL9Hlk/qQeJRnnPppDzcprJt8CQOeqOgFNY+uoqM/xypvydFXb2D9B7wNBuKvLafx6tg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuGZavkWIIH1h02+xTDKXt3DJz7tzsCjDU++TkIxlUI=;
 b=D2kECHoM21OD0D0NzMlAsSasCHhz643+AitqPdswj4VnuDfhi9IY91vT5bthBJxR3TO5JJTbwmp+q8OLUK2Wqyy5sfwjtKDc8HaSRtJyxEmexXT8tyuMsEnWKANXDqyfo6K+8cyRpv5jn5+DFTf31vCkRMs8OTgCSnD9sMP7nAw=
Received: from AM6P193CA0046.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::23)
 by PAVPR08MB9434.eurprd08.prod.outlook.com (2603:10a6:102:318::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16; Fri, 6 Sep
 2024 11:08:14 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:209:8e:cafe::c4) by AM6P193CA0046.outlook.office365.com
 (2603:10a6:209:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 11:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Fri, 6 Sep 2024 11:08:13 +0000
Received: ("Tessian outbound a13c34f08745:v437"); Fri, 06 Sep 2024 11:08:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0a912932261d8174
X-CR-MTA-TID: 64aa7808
Received: from Lb668a72e7cf9.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9AE62DB3-54CA-4EB5-B219-749B3FE139D6.1;
	Fri, 06 Sep 2024 11:08:11 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb668a72e7cf9.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 06 Sep 2024 11:08:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmrVnQETqhcT1uAlEKkasOnHhTf9PcOIHgaJHfe+JyL+MtMsYpd9lvjaz3ARbdGE5rXqHPHVUTbYs91wC8S9smf9wsGzrKxeTnF2Z8KqsI5v6m22EF1nMXiZRNkjgoXI/Ee+5WDTEL7GyL9GfT9yZj1O7uK7pCg9qnQbcIzXpBBglptISmMMpI8hL/XIX2MC11FNkeaJAsld0irpDuV4bHvbYx/ci/PeXBBI1QamFYXzg+ksV3jAYhLKhVK4c3NfTbYkGRSqiSlMrGbUYg+YFy4EOLvofCtzNNJpKJsx21Neb0Z0j5A0BPyqDp4bcNYsAFN6rDAZls01iNYkRw5fxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuGZavkWIIH1h02+xTDKXt3DJz7tzsCjDU++TkIxlUI=;
 b=l9omlfwFvI1rqtOAGIwyM5iFOk/Yus4ZSk7O0Mpn9jSMDRNiN6HOQ9R90mudAaTMMPIMdU/NkyHRXe+YPwyydyiSITHJ5K8q5VODVAIyHFpkR5F4ZpMzPQs+J5j44OhKAmOcGe444cxMbG+WT5Xo0SoqMtJJU+66FjzwPs+vMfvFm2Ad20uAYgaLEfWeyAAZhdURRHjn1/lZDzDCN7zpasxcZpNsIQuYXLr4u/7Quw0CTgfKVlM4rxVQUZwlA2N9AqZ8UsgY0aKZXCEppVwNWdrBxwrl8YKCpFjTPPNKT83JsyezFUnk8JuSPKzRuoM/GRsK6FkrhaPSmky4QzpV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuGZavkWIIH1h02+xTDKXt3DJz7tzsCjDU++TkIxlUI=;
 b=D2kECHoM21OD0D0NzMlAsSasCHhz643+AitqPdswj4VnuDfhi9IY91vT5bthBJxR3TO5JJTbwmp+q8OLUK2Wqyy5sfwjtKDc8HaSRtJyxEmexXT8tyuMsEnWKANXDqyfo6K+8cyRpv5jn5+DFTf31vCkRMs8OTgCSnD9sMP7nAw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB10269.eurprd08.prod.outlook.com (2603:10a6:20b:63c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.9; Fri, 6 Sep
 2024 11:08:03 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809%6]) with mapi id 15.20.7939.016; Fri, 6 Sep 2024
 11:08:03 +0000
Date: Fri, 6 Sep 2024 12:07:49 +0100
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 21/39] arm64/gcs: Ensure that new threads have a GCS
Message-ID: <ZtrihWQFyb2/XrQV@arm.com>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
 <20240829-arm64-gcs-v12-21-42fec947436a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829-arm64-gcs-v12-21-42fec947436a@kernel.org>
X-ClientProxiedBy: LO3P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::9) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|AS8PR08MB10269:EE_|AM3PEPF00009B9D:EE_|PAVPR08MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 4929e13a-5830-4ab0-2aac-08dcce6433be
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aTBoNDBnUkp3R0IvTEVEV2IxSHZKQlZRVE1JNW9ndFcvdHFTWThjRGdLeEU0?=
 =?utf-8?B?dzMwWGxZbGhXTHR2YUwzK0lIS2pwUlhqOWdkckpsaC90Y3pEeXdCbDUrMFVm?=
 =?utf-8?B?WldpTUVaT3Z5VFAwMGljRlU0bGh3Z3owK3RVekh4ZGVXNFIrNWZrZ1NnaFlw?=
 =?utf-8?B?NUpoQUVSTmVqQ0x1ZXhRT2FEdTRlTlptZ1ljLzRnMmJhVnpIMkVvc25HZHhn?=
 =?utf-8?B?UjJ5aitlekx6bTVnc09rQWJWSjAyalUxUnVURVVhR3FGVzk0MjZZZHRFRlFI?=
 =?utf-8?B?M0NTbmREc2FnVlNnakQ0Q0NLaU5MMU8vQk1DM25YSnJCTFltUWY4Z29Lb2Vx?=
 =?utf-8?B?Qmo5SXJtNEhOYmZpaElENDdpd0NyRWNCS095NnpMYnRHQThKMm1EUUEyVytn?=
 =?utf-8?B?R0RPYzdXOWo4ZWZhWG5sN1NQODJ4WnRVSzM3SGJSSWhlektDZVp4QnduSlBl?=
 =?utf-8?B?VEI2Nk5IbXhNMnNWV3IxcnkvdFBPc050dFZoUkZmSjE2aDVBM3czME5rYkNH?=
 =?utf-8?B?a2tKaWl5cVlEaDNUMTFSWkZCc2ZnK0ZLT0VsYk9uVnZuWDlLbFNaUllJNkdn?=
 =?utf-8?B?SVd4ZFd4N3AvYjZMWFgzbTBpcmw4VjBCdTdWU3phK1k3MTNCeW1UWTFtWXov?=
 =?utf-8?B?aGxtaU1EdkdzSGNqRk0vck1JR0dneURhdmpuWStGaFAxbU9Edmk3ZGFyU0c1?=
 =?utf-8?B?ckJQSFo1Nm45ajJDeEN5Z0hIcWJ3dmdsek9abW12SGZwL1dKK0crcHEwSUJl?=
 =?utf-8?B?cTJCZXh4My92bkJJb09jMy9YWk4zNDgrQUJVZG45SVhndm10UmhBb2orSHRE?=
 =?utf-8?B?Vk01YVNrbjRXcmpWSHZrM0FZdlQ3bVdaTUJxVFZZNlVheGozcVdyZlEwZ1dy?=
 =?utf-8?B?bHd6SlQ3NmxOeXhzeHl1TS9MaENOQ0FBelZZbVJOOGNMcklJcTRiRHVpMHFO?=
 =?utf-8?B?OUYzV3RLSFNpd1R0VjlDZllFOG14aW5aTnkrWnZ2UklieFFnK2tkM2FLSTh5?=
 =?utf-8?B?NnRpMEtETkVlUVJqWUxldUFSb2JsVS8yQ1h0TFl0YmZJaTlkK25QaFkyNlh1?=
 =?utf-8?B?SnIzMEorSW9aZDJTYXdnUzVFL2F1dGtqajN0TXpqQTVvNk1xVFhja0xLaExB?=
 =?utf-8?B?ZW1Wb0VSSWk1QmhtRnNWQUxNNjIxeU4vRkhGTGtaVFFGQ05GZU5mc0c0TXF3?=
 =?utf-8?B?Q2xWREtXTm5tRzl1R0l4MlJtNGhhUFhqakRsdk5LOE5VNVd2WERUNTNQRXht?=
 =?utf-8?B?S3FqZGU0b25NYlBoaEdYSVFxc1luQVpyWUZ3WU44UFc2d0cxNkI5ZUNMS3da?=
 =?utf-8?B?V0FmQVltQzFTSU4xeWtOMHNhRStnTlEzVjVFZmMwNnVOdXhpK2dxaHk1aWJL?=
 =?utf-8?B?TittOForc1ZnT1llZzdqcnhNSWZNcWlrM29DMVJYdzJaVzArRWh4aU5KVHlT?=
 =?utf-8?B?N3BNUW9ZeWJEeUJmaE8vZmdvaEhqanlJK3NCQklNMmt5QjNRTWdXQ29iejRp?=
 =?utf-8?B?SXhqK29GR0EwdW5GNksxc05OOHVSSnpBOEhINWl6K1AzSk9jMi82czFHNHFT?=
 =?utf-8?B?K3hvVUo2UzI1ZC9QMjRvcDVSSnNZbEtIeGwyaDhjZGdybnBhVGluV3NVME5v?=
 =?utf-8?B?alZWcEhMQmZMN0FTbnprMmp4MFp4bGRqQ0ZFSFFKNjdENlNGRzlmUVdjN1dk?=
 =?utf-8?B?Nnl5bjg5YlV6SUVnSmlQT1VzQmphaEdwaGFCb1d2ejNBRW9EcTdpRGk0SFM4?=
 =?utf-8?B?M0d2QlhSd3lOSTV3MmQvaDBmM0hFM1JXVjlkRlcrVlJSZERML0xJVmVlRnk4?=
 =?utf-8?B?Sms5ME1KRDRqd2ppV0xSUU5JczVVRHdsTEVNTjdQWUpKQXcySm1MTCtYV09Y?=
 =?utf-8?Q?EkULOeDYPt909?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10269
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:2cc::19];domain=DB9PR08MB7179.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8663ad94-83de-4d14-3bb0-08dcce642d17
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3orTjBlRmZTZnpaeHBkNVYweXFIWXdid2p6eUxPSEJaM1l1Q2tPd2RvenF6?=
 =?utf-8?B?Ylc2MGNSdDY4dWJ2dmlFRXU1N1luTXV4TjR4K0MxVGpINHhwYWU3K0JnM2J6?=
 =?utf-8?B?WDIvNHNpbHpqTDNkMkh5R0NWRHNiQ01qWEhzZzFkUWhwL0xkZFFnSU5zdkQv?=
 =?utf-8?B?ZFNqbVlIODJQeWFoZFlTNU1XaWtpZ2NVZkcxaEsvRURpcm4xK0VuSFlhbDlv?=
 =?utf-8?B?ZEdZcU9ScUFneG1ubyttd1RhR09xNlI1T3ovYVA1TFRBem5FamNSUHY3OVds?=
 =?utf-8?B?NllDaXROS2FWRjRqRXc2RVlhY2V2V3MvMnZCWHAwVHJqeG94NDBXYm9UWXdB?=
 =?utf-8?B?UVk1elFGdXB4dnZnWnBsR2Z5STRqSEdYd2xhc3Zjb2FTOXBiZm9oT2hxRGds?=
 =?utf-8?B?VzZRYkN6Q1dmWGNHYncxSHBFWXhpOUZNY2pxSmFYU0hvODF1SXcrTWN1N1dP?=
 =?utf-8?B?VkxkT3diVTdiazBqQW9aeWp3eXdwOW0rZkx3UGlLaDh3OHE0RXcxNStFck5H?=
 =?utf-8?B?OXVrT3kvWGh6OWhuVWZJOFg3OEcxRVZQYWNWbXJDTGxuQno2VmpLRmN0TlRH?=
 =?utf-8?B?U2JPVnBId1orVWpsSmczckVDeWRUc3UwZTA5MmYrdm95bFpxZ01Ma1d2WTVY?=
 =?utf-8?B?SG1Ta2lrLzVBVTZEaFdFcmxteVZEbThsbkt2UHZseWFidjV2QnFoMi91WWZG?=
 =?utf-8?B?dURObXh5S0ZDQklRWWQwL3RTSU1FTHM0OTAzVjVkQkFSMHBMZ2pFSkU4TURh?=
 =?utf-8?B?K3poU0hOZ2ZIZmtFQ05kVEY1VE12Z09aakUvMFYzRitmQzFXTXorZzc1aUMw?=
 =?utf-8?B?dGt1dkkvNTJPa21zakJlREM2R0dDKzkrOUsySG5sWmZLb2V6bzc4cnFsOVhr?=
 =?utf-8?B?dXBydElvT1VoNnZPVDRFNURsZm5QSVhDemNJZXRRVVlwQ3V6T3N4dVNiUm1X?=
 =?utf-8?B?RXgwOFNuWHVuTXdxTTgveXVXTjJwLzRYRWZ5K2JJQVNmb1JzcStwbWY5T3g3?=
 =?utf-8?B?bCtWeTIzS0hLVEE5TmhPcnZONmFWK212cjhWbjlkeHNNRlpwc0F6Nit6L1Va?=
 =?utf-8?B?cmY4QkhTM2FERFczeEZUeGcxdkV3NmJpMVRkZGhmbGRDOWRZQ3BYcXcrNmMx?=
 =?utf-8?B?R005aWY5b3lscnZKQzl1QVY1YWdmWjdYbmFlY0pPVWlpWTd1cmloRkNJR3dC?=
 =?utf-8?B?WkdaVEE5bHhtbXFBbUtEaVJud2t2MnpNUFZpYmdOWHBxWVRxaE1SWHhTYWZs?=
 =?utf-8?B?Z3B0ekVLeEQrcnZKdFNDN003OXN4WkIvV21yOXQ5REp1dkFIMDRsTWNGN0Vy?=
 =?utf-8?B?TnMxKzllcFl5K3lSSkZ1dDJqSm82MmNFL3IzamEvQ0RoMlVsSU1yTGZwckdk?=
 =?utf-8?B?aExCNVlDMkVvSWJEcDJaY2FFRTdiOE9wTmJxTkptWUN6MzlJWTBDUWZMTFZ0?=
 =?utf-8?B?ZHQrdHBRSTFGOHI5SXJjVTM2NnJ5NnBDMXV3MXRnTmlHa1BicGNYOUlTY25H?=
 =?utf-8?B?RWZyTy9FUW9qRG02ZVIxTkNzSU4va1B5aXk1S0xFQkpGOFZWcmpQZUd3QVpW?=
 =?utf-8?B?dUZGL1lsNUtzNDZNbEt0U3ZtZzJxMHJNYksxMThleHJ3MkI4bkdIVytacDZH?=
 =?utf-8?B?d2NiSGxVQmFVMUlzeStxeTlBZ1dwQldzODh3SExFV3h0QTRaK1hrakdvajN1?=
 =?utf-8?B?aXZwQjlZS3NoUVhqckJHNjFRWTErblYrZWYxVWgvOTI4bVRhM09hbkc2cGlY?=
 =?utf-8?B?M2JkSU1qMEVjaUhQUVZ1dG5ka29SUUZGOFEvNUhGS01Bd0dWZGszRnBTSnBl?=
 =?utf-8?B?Q2xtN201WlBWTnBYdDc5Rno1M1JVaC9jbTlpUjFWb3F6cVVILzRwOThXOWZY?=
 =?utf-8?B?MnUrRHVNVCtTb010YUNtRTk2QVF5T0NRUExyK3NSUmp1c0o4VjM2NWh0Q3FS?=
 =?utf-8?B?dnhXM2Z4MjRzY055ai82RkU5Z1A4WVovYnIrOWpmU1ZiN0d2bUpqcTJGUHpv?=
 =?utf-8?B?REdObExPVVJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:08:13.8357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4929e13a-5830-4ab0-2aac-08dcce6433be
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9434

The 08/29/2024 00:27, Mark Brown wrote:
> Unfortunately plain clone() is not extensible and existing clone3()
> users will not specify a stack so all existing code would be broken if
> we mandated specifying the stack explicitly.  For compatibility with
> these cases and also x86 (which did not initially implement clone3()
> support for shadow stacks) if no GCS is specified we will allocate one
> so when a thread is created which has GCS enabled allocate one for it.
> We follow the extensively discussed x86 implementation and allocate
> min(RLIMIT_STACK, 2G).  Since the GCS only stores the call stack and not
> any variables this should be more than sufficient for most applications.

the code has RLIMIT_STACK/2

(which is what i expect on arm64, since gcs entry size
is min stack frame / 2 if the stack is correctly aligned)

> 
> GCSs allocated via this mechanism will be freed when the thread exits.

i see gcs still mapped after thread exit when testing.

> +static unsigned long gcs_size(unsigned long size)
> +{
> +	if (size)
> +		return PAGE_ALIGN(size);

no /2

> +
> +	/* Allocate RLIMIT_STACK/2 with limits of PAGE_SIZE..2G */
> +	size = PAGE_ALIGN(min_t(unsigned long long,
> +				rlimit(RLIMIT_STACK) / 2, SZ_2G));

has /2

> +	return max(PAGE_SIZE, size);
> +}
> +
> +unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
> +				     const struct kernel_clone_args *args)
> +{
> +	unsigned long addr, size;
> +
> +	if (!system_supports_gcs())
> +		return 0;
> +
> +	if (!task_gcs_el0_enabled(tsk))
> +		return 0;
> +
> +	if ((args->flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM) {
> +		tsk->thread.gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
> +		return 0;
> +	}
> +
> +	size = args->stack_size;

no /2 (i think this should be divided)

> +
> +	size = gcs_size(size);
> +	addr = alloc_gcs(0, size);
> +	if (IS_ERR_VALUE(addr))
> +		return addr;
> +
> +	tsk->thread.gcs_base = addr;
> +	tsk->thread.gcs_size = size;
> +	tsk->thread.gcspr_el0 = addr + size - sizeof(u64);
> +
> +	return addr;
> +}
...
>  void gcs_free(struct task_struct *task)
>  {
> +
> +	/*
> +	 * When fork() with CLONE_VM fails, the child (tsk) already
> +	 * has a GCS allocated, and exit_thread() calls this function
> +	 * to free it.  In this case the parent (current) and the
> +	 * child share the same mm struct.
> +	 */
> +	if (!task->mm || task->mm != current->mm)
> +		return;
> +
>  	if (task->thread.gcs_base)
>  		vm_munmap(task->thread.gcs_base, task->thread.gcs_size);

not sure why this logic fails to free thread gcs
(created with clone3 in glibc)

other the gcs leak, my tests pass.

