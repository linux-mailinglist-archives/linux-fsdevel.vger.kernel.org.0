Return-Path: <linux-fsdevel+bounces-27115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87595EAC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C60D1F21BBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E123A13A888;
	Mon, 26 Aug 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="17uhBHzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84512D052;
	Mon, 26 Aug 2024 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658522; cv=fail; b=sV1WEz7ZD+edhS7jHp7f7ABPjWGaFpyn9JxnCv7iiPdu+nUXMxC4xgPjWpgSwPl+edrSOWphWHUfil8vir6wfhFl7z9a7hp+eeypUKP6HTwj/uztRy11ykpWH3je8Qm1BeVaoStVHFWcw3r2bJPqL0hSW61o+iwaSPYSiCuussI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658522; c=relaxed/simple;
	bh=yMyT1Gpsj9hC/LgDCeOvFKVvHSq7Vy2C8Ls7JdHJGoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAtRByuztfvRBFJHnBtZ+hD8ol7l70L9CWRXS5lP1Ga89KCbAfYRgruSnFtamG8EcafSblLl6SN5Q5Km6hDtNTFcQFFMiJ8EU4iISyGtZCSlZNmJ1A9T4m6nPD4bQ9Nfzdx0pMRclcxsZFRsv8D0Nq7ZMAlINJhiGsdeaXwTgOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=17uhBHzS; arc=fail smtp.client-ip=40.107.105.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpoFhmWLwq1G1V7wfwYEKTULMtIoxwm22+WXEdjWzUJ7L6RWji0UDTLhQzKW/FT8L9TnOKtSQ+HgwF63YKXKAJRhcYczNg8Xrp5O6k6dGKm4KOqMEr57U2kQSotVR8ETgK8fVzgSqJukQmbq5kIKMO/2a3H47A4FGnAJZ9srhD7h0OxsauZ7aM8JLtf2ex6g9CfYTt/2x4lFXCpL0j9cpHwZYC0wgymlB/n9+7DniFE6OyyoKIKk0khBQm+oiEIu4j7wMk4NimjdpU+O5kZgRdKn+3Uc7wT4sbFFX8quRVcU+/35MzGk3bywhPneed3QKQLRS60HhaZjtYViHEybwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMyT1Gpsj9hC/LgDCeOvFKVvHSq7Vy2C8Ls7JdHJGoA=;
 b=MLZDLgnCjzZIeWJvU1zmWW+45uhzSJ5oN0rv4/k+SxwwjrAlo1Yd5F/WD/JO1UVrJtqxvFCR0yZLzqfuQVqYxuTK1FXLswBoXbLvJ1wEk9iE6ZnMM7xTLsvokgB9kY0Q8w3Fv5Bmw46Sem4ksnYIJgczkqqiaGG1vdkfdUG0O7CiyL5bjVPkgDBc2wv6eAj+MjhOw83dCGUm5JeqZpI/YBY/JpUcEXbKCy66u0LtnTqSTPzR7shh5/c4vXMS+XTnSZ3+7glnYoN+l4nil+4nsrbhjPV1CdcIGBuI1OzVrE3VtLoieTx4Tx5PJwOjZ85m+kq6IW5CZPAkZ7zN8prpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMyT1Gpsj9hC/LgDCeOvFKVvHSq7Vy2C8Ls7JdHJGoA=;
 b=17uhBHzSbVhNGUr/RITI3Jj/mkOJmibBHMnTnyxgPycPnR33FRfzwU/CrY5vmSOXj6u7ROWGr05ITwjQo2LRofActu7FMWYhQ/MMc2H6jIqHX3G1pxxDrcr61H5AtH7Yco6UjXEiD0LYeprfSydFgS+7tfDvYE9k9PJkrop+Ts134MNf1u+YCdPQ1JtmUYoMrzr1XxnKUWs3NGXBSfNjXHdQQPF77ORT6YkN4A95m+n9VBlgYxlvZ71kJUyCc/CNeZQAF412bOwOZ5X4nSJIYmMBaEL566hD7gBaCSTcH3Rp5t+ysdyxfc1EqQPK9flijFE40QskXoM2xRu2g3lwZQ==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by AS2PR07MB9230.eurprd07.prod.outlook.com (2603:10a6:20b:5e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 07:48:33 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:48:33 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, LEROY Christophe
	<christophe.leroy2@cs-soprasteria.com>
CC: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann
	<arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 16/17] selftests: vdso: Make VDSO function call more
 generic
Thread-Topic: [PATCH v2 16/17] selftests: vdso: Make VDSO function call more
 generic
Thread-Index: AQHa9GLXAFWke1SH0k20S9z+pV7MXrI5LPUAgAAC+IA=
Date: Mon, 26 Aug 2024 07:48:33 +0000
Message-ID: <2d4e5b66-3aee-40d9-acd3-394e4100ecf5@cs-soprasteria.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <bd05c8faee64972a9e01f9497d1870dc267a55f4.1724309198.git.christophe.leroy@csgroup.eu>
 <Zsww1IgALClDUf8g@zx2c4.com>
In-Reply-To: <Zsww1IgALClDUf8g@zx2c4.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|AS2PR07MB9230:EE_
x-ms-office365-filtering-correlation-id: 2b102b46-fc58-492a-ec47-08dcc5a37c49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2JlSWdwWFJJV1Q3TkpXYmJiZ1NGQy9xaGVZSXBwYlpHbHl2ZHRHZ2o4Q1Zv?=
 =?utf-8?B?SDZwU2JFVTJwN1EyWSthQmVLTWc3NEpkYU1TZUJWVzkxMldYVllOWmdQTHdh?=
 =?utf-8?B?YXNTeThhY2h2cDBpNHViOXRHWE9jWllyMXBKc3NFK2JrUmZDV2N3d0tZMytR?=
 =?utf-8?B?aU03UGZERXRNWDg4dmc0YkxLeTF2Ri84RDBxY01CWENwaVd6Zy9CVVhNQ3BQ?=
 =?utf-8?B?UTNPUW1qMXBvSjhFUEhvVzZHdndBWTIzSFY1V3RkMERSNG5RUXNhOFEvV3Aw?=
 =?utf-8?B?di9HcXdpbk1vdjJrb2JOK0NMZ09xbHplU3d4bmtrZjY5Z3ZXdnlJQnBNVERq?=
 =?utf-8?B?a1JTVkRHcEU2SXlkWnJ1UG1rMnRNalZSaUxBWTRPamhNd081OVlWbzZhMmFz?=
 =?utf-8?B?WWF4anIzR1pXNXg3ZWFRb2NFSzRaTU1Ea25NMXd0b3pBQ1U3d01YZG01blhv?=
 =?utf-8?B?UExpNlZxUHlwUEtmdXVwdU5CUTVWSmNYQWZVR200ZGhKaFdDUWp1WFdDZ0F5?=
 =?utf-8?B?VklUMmd1bjF4eDJ1T0ZkK0JubmZDTzBYL2YvRk1LbDZHR3BoMStiNnlMeTUx?=
 =?utf-8?B?M3FueWcveUJKZkNRNFR1SjJoRDRBNkpjaWxFWDY2R0VWQ0NzK3FKd09oVzVU?=
 =?utf-8?B?WTI4UUE2L3AvY1FhUnR3R1dmSjU0REdCemtRVWU1WS9uSjZuSTQwaHcyaXU3?=
 =?utf-8?B?aDlxRWtKMmx5dUl0RFp0YUNidmkyVXBPcVNBVm1jMjFaUTBCQjNocDE1c2tu?=
 =?utf-8?B?Q2t1YjlYbFhmOU9ibTIxTE5qOEV2THhBQkU2cmJiV3NrUzF6eStDMytaaG5Y?=
 =?utf-8?B?Q0dIMjRqY3RDVU1UdFAxUHJXQXlHY1VjYllIRDlFY2hlTUFzWFZhU0RPREg1?=
 =?utf-8?B?L2xubG8yWHNtemVWSmNiY0l1d1ZmckVCVXoxakpaYUZ3TU5nZjJFdWJOWDNx?=
 =?utf-8?B?YmNCa2ZtR0tBbG1CMHd4dTROcjdHeERVWTV1SEdSVW1xY05IcEl4R0ZlbnNF?=
 =?utf-8?B?YzhnSUtiWlVFank2eHVuTVBqOVFhTnVaNUxHWmx2MUg0RmJ4bUZRQjJ4d21p?=
 =?utf-8?B?QkkzZVNwY2VkamNnSHhOTFVzQVVZZ3I0ZWs1dFJtTmVrOWdrUVN5SjdnTEph?=
 =?utf-8?B?UEY5VVdaM01CY1lXL2JQWFVmNXdqb0tWMTVCZjExTEhPTnRDdnpLb0RBclNS?=
 =?utf-8?B?cFRaL25vcTBid2pBS0R3MVY3QlNEUDdBMHFqcXg3QS9rcmdiNDE5SHJhdzUx?=
 =?utf-8?B?SFhsSU1lRGhaQ2tpemNVeGI2NWlHdTlUazRkNDdHMWUxUEdPNUtjSGJOeGlv?=
 =?utf-8?B?ek5GNTdheXV1b1pZN3EzZkhjaDdjZ3pRM084MVgvZGVIVzdsS2NMa0t5U3E5?=
 =?utf-8?B?ZDdKNzY1cHFkdk16WWdONHZWN2JNdThGaFNtMC9zWEgrNytxZ0VDdEhNakt0?=
 =?utf-8?B?RmVwSjZKS0ducFlPRFhmZnlGTTJVejRNeng3dXBsaHE0T1FLUjNuM3RndWg0?=
 =?utf-8?B?RG5MQXZFT3NLWFN3WStJNUZPUU9zT1BUVzlqalIxTUFneFZ0L2VmL1RqaW9y?=
 =?utf-8?B?YlFlWWZmOGo3Vll5L0RWV0lBZGVtRy8xZEdrTHNTeThBT092bnpQN2svTFc0?=
 =?utf-8?B?N3gvL0RTOUZuYnZJbU92aUxQc0JQMmh6dDRmeXo0dm05eE5vZ29DTlFDOWdD?=
 =?utf-8?B?N250d252Y0c2WUNJTVN5YzBmWkJhS0ptMlFQcXl0NDhmZ0tzSFc2ZEx1T1Zr?=
 =?utf-8?B?VUd0ajVDOUxaM0gvS1V2aHZQbFZLbWh1TnMvYlJpNEp3eEFHSUh3M2NUaFE4?=
 =?utf-8?B?Q3V3RWNlNm94UEhYWnoyZFM2S2dEYXkwbEVFOFNFWWZBTFlXOWxEcWplVzgw?=
 =?utf-8?B?c212TGhMU29YOHgyTWFPdm9KbGwyT2diaytNZmVUQ05uR0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WitKVFZWWmcvclJJUG5sZml3Q3FuOUxDUGREWWpNdFVNYUt2YnZJVUI2QUs4?=
 =?utf-8?B?T29ZMTRWZVBYbFRuUDFTUzdtZThWc1ZrbVE4Q0NrZDMyMWlZNEFZbmhCQTU5?=
 =?utf-8?B?K1g5cWh5VlFRRzhLRVBjNzUxYjQxdW5YV01mUUtLWTkzcjRERmhMdjczanpm?=
 =?utf-8?B?U0pPV3JEM2k0NXN1Y0g0ZCs0VUw5WWltNGZxYXJJSjQ3djdKTkNFby8vVnB3?=
 =?utf-8?B?cUlRalVCcDg3WHNxTnU5UVd3djJWcWNRdmpxeUpsNlcyNThlckVreE1zTkxW?=
 =?utf-8?B?SURwU2hVVGlXWHEzcDI1SVUycEZsQzBBZzIvMEI2Unk3WTVoRm10WWtmWEFr?=
 =?utf-8?B?N1o1RWlUeHIyL1l4RlFMZTNjS2hncnIzdDdkSHJHenc4RE5SVmd1bkx0dGxK?=
 =?utf-8?B?TGNpWUR2SWJLQTFhRE1IVWJ5ZmJlTjl5NXZTUnE3c29qRkdKVlV5KzU3K25l?=
 =?utf-8?B?a0hCRXU2SGRENk82TTQxakFQcXY2cGxZT3IyUHZkMk1lS3Z5aUZsVUN1S3F4?=
 =?utf-8?B?endYMnVlc2JtdjRlK0NNbkhod0tMcHhWMFI5ZzVDdmpzV0cwK2Z4YkRTUmI0?=
 =?utf-8?B?cUpEVUdBbFNUU0oyN1BkWSsvc0h3WjN6VjFaamJQODl6bFBCbXRRN3hEM3gr?=
 =?utf-8?B?U1F4MDRyZGtUcEI1SENmQ1Z6Z3hGZG1NQVIxWG5pTEtucGV5UldPRmJFTDBN?=
 =?utf-8?B?a1NqbjRSTW9lV204WjZIR1NBeEhHQWFSdndVTmFKOWtTZlRVWGw0RTZNM0k5?=
 =?utf-8?B?ejVaZXBYSDdRL2hIYU1pMXdOMVlsa1crL0QwVEVSaUgwbHlXdGIvcVhSay9E?=
 =?utf-8?B?N3VjOXJxS0RncFd3VDNPelZDZFg4WVFuUkxibFdmSmtjUk1rNDRvRjFtTWFq?=
 =?utf-8?B?QXo5YkMvZ3dUSko3K0YzdWE2aUxGUGdWT1RGNGJZemhCL1FJbS9mWkNTZ1R6?=
 =?utf-8?B?YjNYcDE5emVDTDRMU1pNcmF1K2hIQUw3Q2pZdmxxUFNVYlU3QXNUSGJ0VFh0?=
 =?utf-8?B?c3lpTjZ3Q21EMkpOcVJzRkN4a2hUWXdxS3lUdjBwTHFsdEg5SjZRcGJxY0hG?=
 =?utf-8?B?ckpMQ0x5NGZTaFA4ZVhJOVhmMkl2aDA5a1NWTXN2cWI1dTY0dnhGV1g2UVgx?=
 =?utf-8?B?ZURGZEVka0FpMTNUQVN5elZFRjBKTi81WEF5bkY3VzhrT251dGNSQ21TbUN2?=
 =?utf-8?B?YTFaRkl1MnZYejhJeEUrR0dtWVhlbzVwaTlKOUNQN3plVEk0d2luUEU3NlJx?=
 =?utf-8?B?TlZRTVpxQUpweUo4cmZpQU02cHV3aWl2YnRkNjZyMktvOWo0WlIrWk9iREpD?=
 =?utf-8?B?LzNXZitjVnEwV3cvYW1DUjU1SjBwSTNEVkNZNXU3MmQyZTMwZHFjb3ExTWZn?=
 =?utf-8?B?c0xYQVpTN2paV08xNjFuckFFcXJBQ3lXNUd2L3JaOGVVbnZubU11RXBqL1pu?=
 =?utf-8?B?Und5ZCs4WXdtbUxWak5mdE9wUXBPQStmNksxeDNOM1l4a05GN0w4ZTBETUlq?=
 =?utf-8?B?a3VGUHpueGl4Z0pJQzBsODVuRzZ3d0lhRSs5TGZHMTUwcUlJVGJ2dzcxcTdk?=
 =?utf-8?B?cDYwZ3RQUktIMU1ORmdJakpKQS9XSTV3YTNaRW1pa21ZZnZpTEdxVnpuWDdy?=
 =?utf-8?B?VW5LUWtTdVR2ZE0zVUozMzAxZFhDc3Z0SVUxdVczM2wvYk9NSE1XNC9BOEVk?=
 =?utf-8?B?c21lTjFJelkrRjY2MWlkY2xsK0tXT0JGMnJkeGlnL1FrN3RIdWxOVVFSMzVK?=
 =?utf-8?B?RUpDQnBvU0JPOFljL0w3UnF5cXQxUlhraFhtY2p0eTUwMDVDeU5oUkZoK0hQ?=
 =?utf-8?B?bDNuekh5R1FvdzNtTXRKUmN2cXhONENDZEl2Nlc1UThld0orNXprUmd5SjJ5?=
 =?utf-8?B?eUZhV2psTXZOVitpZFdJajloOFVTc2d5OUlGZUhGaTJTZC9kMUdISWhzU25M?=
 =?utf-8?B?WlM3M243ekJOcFMvQzdkMVQvTDMwaTU0ZUFvcEV0RmNZOHlWMUtxMTJVb2lo?=
 =?utf-8?B?T254dFZvc2k1L3JBZmN5VXd5akZsa3NadEhibFd2Y2JhS1Z4Q1NxTEc3SVRt?=
 =?utf-8?B?UjNqYzhOaWtDaW1MQWI0VFg0QW5oTDUyS0RDVHl6K3E1WlZPUWZGK2RSNmZn?=
 =?utf-8?B?MkorNGo0UzNnNW5FdmExRzBRZWJ6cXhkME9EMitqMThFT25VWm0xMnFQcXQ3?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B8085106973BB40BF97A20155FB3386@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b102b46-fc58-492a-ec47-08dcc5a37c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 07:48:33.4865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGdXolA+68NXdMqyvSq7Q6Pstfe3rLP/WfW4z1EZ3Zk/FpiBCNBEBNtPlqqiItcZNRafuD0RFnfEVhIAhwWg4AAugk65Tw374Xjj+p5xooJHIsuw+syrhNMF2UY2aAXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9230
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AS2PR07MB9230.eurprd07.prod.outlook.com

DQoNCkxlIDI2LzA4LzIwMjQgw6AgMDk6MzcsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBPbiBUaHUsIEF1ZyAyMiwgMjAyNCBhdCAwOToxMzoyNEFNICswMjAwLCBDaHJpc3RvcGhl
IExlcm95IHdyb3RlOg0KPj4gT24gcG93ZXJwYywgYSBjYWxsIHRvIGEgVkRTTyBmdW5jdGlvbiBp
cyBub3QgYSBzdGFuZGFyZCBDIGZ1bmN0aW9uDQo+PiBjYWxsLiBVbmxpa2UgeDg2IHRoYXQgcmV0
dXJucyBhIG5lZ2F0ZWQgZXJyb3IgY29kZSBpbiBjYXNlIG9mIGFuDQo+PiBlcnJvciwgcG93ZXJw
YyBzZXRzIENSW1NPXSBhbmQgcmV0dXJucyB0aGUgZXJyb3IgY29kZSBhcyBhDQo+PiBwb3NpdGl2
ZSB2YWx1ZS4NCj4+DQo+PiBTbyB1c2UgYSBtYWNybyBjYWxsZWQgVkRTT19DQUxMKCkgd2hpY2gg
dGFrZXMgYSBwb2ludGVyIHRvIHRoZQ0KPj4gZnVuY3Rpb24gdG8gY2FsbCwgdGhlIG51bWJlciBv
ZiBhcmd1bWVudHMgYW5kIHRoZSBhcmd1bWVudHMuDQo+ICAgDQo+IFlvdSdsbCBwcm9iYWJseSB3
YW50IHRvIG1vdmUgdG8gVkRTT19DQUxMKCkgZm9yIHRoZSB3aG9sZSB0ZXN0IHN1aXRlLA0KPiBu
b3QganVzdCB0aGUgZ2V0cmFuZG9tIG9uZSwgcmlnaHQ/DQoNClllcyBpbmRlZWQsIHRoZSBmb2xs
b3dpbmcgbmVlZHMgaXQgYXMgd2VsbDoNCg0KdmRzb190ZXN0X2FiaS5jDQp2ZHNvX3Rlc3RfZ2V0
Y3B1LmMNCnZkc29fdGVzdF9nZXR0aW1lb2ZkYXkuYw0KdmRzb190ZXN0X2NvcnJlY3RuZXNzLmMN
Cg0KQ2hyaXN0b3BoZQ0K

