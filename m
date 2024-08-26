Return-Path: <linux-fsdevel+bounces-27112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E595EA9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7D0286E37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB7139D0B;
	Mon, 26 Aug 2024 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="ErOvkNCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89B12C53B;
	Mon, 26 Aug 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657744; cv=fail; b=jSPsfubN/j9nYQCo8E+HdeDtfTZspo57GFbPjenDZISdyEJcRuG7l2NGRlIgtpg35LsVhOJmAU1jWMh7/zDnv3R2KAUIgGK5XLJGQyaMBjdxjEJDHmoBH1NMOJnK334eGszIkKmLAEfp7YLcNW3AucfCCLeelThfJFvMNNUKFks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657744; c=relaxed/simple;
	bh=dhkr7dryrZsXGZsj/wQvcXChlEyzj/6pRtFt0E/ePok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jAiwYxmqCWqr9xHO67ipwdH77aHCHS469bmQ0KjOLR62iMVn4a09RZXmW9rROqeZgqVOjqazChm/8gqgg7DIeGzmuCN+ISAThuE/Phl069n9SvjK1a2nxH0uortc+X05x/Vj9qZLg11iFw7w+cjiPHBSyOp6ABRKGWl1zJNrh9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=ErOvkNCK; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbDYD960bkweMwwhEwCPLWy7P21bZVFlOhFuV9a8bGqZo4AH76EWAoGwA7zOy4b+Ummyi6knRwOjOVy+5j3lfsMb3r3aXxoeGWOR5/kK7kIM/jneffWma/WxwuXVOscbiwooPIf+Mny0nzWqw3HHQkx867afPUBNt8TwUFEA5UDuDJRpwxoKUI5h2d9zJQ3Mr6/YNQCay6sNyfPX28+u9c7VDbnsoQdb4VMCX2djrSn1YbGazZ2WQqZGUQ0v+haeAqzKJFyvHqxX9wxucCyeqHuZUzMc87K0eC3q0C+oF7Fd7irqXJYs/5YXuOOkKzx/n8rWfIcdMOKj02lXTQh4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhkr7dryrZsXGZsj/wQvcXChlEyzj/6pRtFt0E/ePok=;
 b=zE7PkHxGeUZeCm+FDTu0ZualOypqew/07voWoylbh/z6ucR/oKEtfb2PDA4SKkfpbIyzWNL0TSSEEHf5q2p1LNTTInxUbLHPzDMgsiSp3Wb01Xpma/6NdGygi4wBOAgj2l7ej5hQYJXYnqwGEEtEcW/3K/Gjv37uYCV1T7qf93KdY/UC925xvrJ5nTL43ly3EsNMXRkRYmTQn0GpPvS415jwQJfZB3xBqWtKfucibr2m4A8Uhu7OrW9qCfRhIdXnYm46G2T8BfmPyMMx9c8UQgE2qb3KmvZ5JPOAxGLfLk2tDYJEo73a7hdpwbJL+HXSKBhv0NMwHlM+eEn/bn1rsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhkr7dryrZsXGZsj/wQvcXChlEyzj/6pRtFt0E/ePok=;
 b=ErOvkNCKWVmRIFhulP11AAVMBr1wepVbfv88Etfl8o+hZyLwiRwaAfAFlnd5v5fUZ2IrG8bcW6iR49OQ/LuM28NjOB5pcOu+MB0AGrt+TljtfHYQloJcKqgf7J0HnykezzMJfzEsfSakHPqys7ohDM4yOwnFXpZg41tnQRQNSymncL6h6LFU9znJmiZK/UV6pFNGBBg+PrInrxG91gen5sCTF/4pKJR/XqzBhcjGC1k9JnjSqG4x19QW1iszI2L6Q88BYdWh3iMQzx8LG2VKqlz2vcx6LU0pvhYO8BI+JLUCarYbSbhe8UdwOJ0TfPM8cSQGAI+3xIJTctoJPcnflQ==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by AS2PR07MB9231.eurprd07.prod.outlook.com (2603:10a6:20b:5e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 07:35:38 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:35:38 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Subject: Re: [PATCH v2 14/17] selftests: vdso: Make test_vdso_getrandom look
 for the right vDSO function
Thread-Topic: [PATCH v2 14/17] selftests: vdso: Make test_vdso_getrandom look
 for the right vDSO function
Thread-Index: AQHa9GLVdeO2A8ki90Kh8hSwc26V2LI5KmEAgAAB74A=
Date: Mon, 26 Aug 2024 07:35:38 +0000
Message-ID: <07ec9ebb-eab6-4350-9353-a58ebb06000e@cs-soprasteria.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <04d1de23a2ff14e2709edd8b75e27b81d703bc57.1724309198.git.christophe.leroy@csgroup.eu>
 <ZswuqjC8T8TwF8LJ@zx2c4.com>
In-Reply-To: <ZswuqjC8T8TwF8LJ@zx2c4.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|AS2PR07MB9231:EE_
x-ms-office365-filtering-correlation-id: bcbb0ae7-4e15-447f-db1c-08dcc5a1ae35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0pEVkQ0cllYNzhXcWN2NmFtZVAxN3pnQzUrSGN5Y0FKdlJYeDNGODJtVWJl?=
 =?utf-8?B?bWxENFJRQXlCMVRibmRjaHBMQ1hXa3lkeGREanNJSk5yTzYzeXBqNVdFNXdl?=
 =?utf-8?B?eU5jTzhRcnVyU2g1QkhUTWNLUXdsYjdyMjBzTytuSElhOE9IOEtJSWs3Um1a?=
 =?utf-8?B?Z2xYSkYwdmwwZjJaUDZrbEdXUWJqVUVpOWhpblBqWnZqbnRkSVVQeFpETXpy?=
 =?utf-8?B?S2JTYWZaZUwvb3NDT1FHVldnUG9HNVZIblIwMTlGQVM0TEVVQURIYWJYb0JT?=
 =?utf-8?B?bFllZE5VdnFVcFYreWV5WS9UUm1RZjBWY3lpVFlIVlVjdmpOcnNIeWloZVI4?=
 =?utf-8?B?MHZYam5hMWh3bEZKSHh3V0ptK0hSRTBOUyt5L3dnRmNmMEw2ZS9sb21Za2VV?=
 =?utf-8?B?TXRnNEI1b24ycGMvUlgvbEZCK3lkWFBtZ3Y2UXcrTm9IZkNPQlRVbCtUOUpv?=
 =?utf-8?B?N2VkUmgrL2NzOXBVa09HdlJlTDA3L2VoVlFnK1NZZFBmRUFnTUwxMGEwR04w?=
 =?utf-8?B?aGMwYTJDejUzMldBU3FWWXo5cVh0aHZYclp1WlRrTUU5WUdZVWZkaFhjYXhs?=
 =?utf-8?B?dEtvR0dFZFBFWDNOUjRqeWVWRHJGTkx0S0todEE0ZHRjeHk2enAxUDJqODZm?=
 =?utf-8?B?cld3WEhBNHJIZ0ZFMTM1NEprT0hoaXVXdTBwT21wYytHQjFiV1JtbkxXWHNW?=
 =?utf-8?B?L1AwSU1nRHB2TWMwWjRMY0J1NHFNd213bnFqbUdzYzU2OVl6RlpxeUtCVEJn?=
 =?utf-8?B?WGk2RW01M2diWWZDdVNFb3VTRmxTN2t5QU15dWpOMG92Qm5GWmUyaEd6UGhT?=
 =?utf-8?B?ZzNyMW1rVnZoQ3RBeVByY2FmRTMzMk1IOWV6NmhBdDM4UlVyVVlndjRwY1Nz?=
 =?utf-8?B?cVdaRUEvWWRSQmNtZXNpTFFMb0ZHS2d1WWFNelJzelBjdVVSZjVvemtETlZO?=
 =?utf-8?B?MHFsOFdjUlkyWDJvYUdBOFM0cDVuMjArY1U0OE1GaGxpenJ4ZDh3d2RMcThl?=
 =?utf-8?B?UDduM0tPUXBBUUxEQkFlTnVBSW81QSs1TTRJZGlCWktlUE9aTGkySTlRK1NG?=
 =?utf-8?B?QWo0dU84MTJJZVFINks4VGJXV09rVHo1M0RvVXRrOVRHa1JlR1JSYjBoMklS?=
 =?utf-8?B?MlhYQjhTVW9TNUZtSERSMlVxeWxRb3pkdEtSRjJRWkpNR1FoUDNBem9hd1pw?=
 =?utf-8?B?SEUzV3pVd1E5b1g4WnBDd09XTWs4NTVYb3lhWFhSWm51cmJKb2xvaWxxcHJP?=
 =?utf-8?B?dWpHZVd6VW1yU0prQjhDN3VxM01aa0tXYTIxblhpd2lOU0Z2VkxsTFUwcnky?=
 =?utf-8?B?RUh2SXZLWjlEYWRvaWszYU9rY2JQNjUrV2E1MU1FVDZQdGdieElGdW81YUx2?=
 =?utf-8?B?U1duR2IzdmdkeVJNMzQ1Sk9QQ2FUcDM3WThteGxwNndpbVI5L2I5VGpUazZw?=
 =?utf-8?B?bXErZU1kY2JOeHlRRnlzU0dXcWJ0aGVTM3NSNjNha0F3QlN5K2ZSZDQvcmtL?=
 =?utf-8?B?Z0ljaG5HaHZrS0FWQ2FTSFNhaEtEZ0swMHNGZzJKR09yZ0VzRmFlaDZ6bkdl?=
 =?utf-8?B?WXhGYmttRDVyYnNYVlpzZHVic3FRQktTMFhxSnVDd2xmMWdHTlY4b0w5blNU?=
 =?utf-8?B?Sno0L3NJcVo2UWdwNUNDd2tDTHYxRW8zVVo2d3VQaktDN0VNNGZJMHhCRnUx?=
 =?utf-8?B?YlVYZG5ieWxIWFc5ZzhocjRKblF2Ui9jekl6RGttWXJ3alhEbGNadUp5Y3Yy?=
 =?utf-8?B?SS9SR0Y5VHZhOFdvQVBRbkNMM1MvS0FDbUJUYjgrcmh0cFl1ZjE0Q0dVUWJF?=
 =?utf-8?B?QkZsSS9UMld5RGduakI2bk9LSExpSDFqTFBtYkNTQ1BYR3NPbHl6U2M3VTll?=
 =?utf-8?B?VEQ3Nk1rdURDOS9hT2JKd3FBOVdWWk9Ody96ZVVlNE5tM0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0hQLy94UFdqY1ZvTytCeGE2MmpxOEEydytZRFZ5bGJ6QXRYVjFvTUYwMjhY?=
 =?utf-8?B?eTFlalg4N2JTcGxjN2NPLytLRDRvNlN4WHZPbjVxNlNEOHdremtZeGVqSUI1?=
 =?utf-8?B?NC9WZVdKSHQ1eTZvRTRYby9Ia1p2eFBlWmVLdUVHcWRGV2pSZFpJYUhYNUlv?=
 =?utf-8?B?aEwxL0pMTENlVU5DcGx0STAybEl6R3Q2WTdid3ZqbTdhQnZ2a0l2enNNSVJa?=
 =?utf-8?B?SE5YQ0tmUmJaTlVGUll4UDluMVUrbWVLTTdBRVo4b1FDR2Q1eXRNS1o3UGd4?=
 =?utf-8?B?L1VZWUpNcGVnT2xuME5RcVBHMmp6MGg4SHpoaHNLVnU5NHJvSnU5cUd4eXla?=
 =?utf-8?B?ZzJNWTZLZGFqSU5EUStQb2xoZkN1VmdoRUhhbmxCU3Bwcks5WWdsNytybjM1?=
 =?utf-8?B?OGFrMVQxeWdMcmFXNk9PY2JXbnJyS3RkelFqWDdMNHA4aXQvZk1HbjlTc0ND?=
 =?utf-8?B?MkFaaDVrQVVoV0RwZlRPS09WY1oraEEyaFo3bmljaDByYVR4Y2RXdGt2QzNQ?=
 =?utf-8?B?S1FhOTFJbmdKNzRTR0NtcVVyRUtUTXVXOU1DaXAyV0QrNTJYNmZwYUVGVDNL?=
 =?utf-8?B?b1Zsamx1czZCRE5yUVhGMXBPaDVKK1h0N1UyYVJOTHFFV1dSREhmVDlMY3ZS?=
 =?utf-8?B?ZzR3MmxNanVNZC9uejgzYUxsSEI5MEFYRytHSld4Nmszb2NUVGtDNGdQRGor?=
 =?utf-8?B?aVFjN2NQeGxlaHAxMHVVTDNFUCtOY1E3VmdjNUFyS09XR3dERzFyN0pvVUE3?=
 =?utf-8?B?S1RFcDNWRDQ5d3lUVHlWdnBHcG54V2U0QWF5S1BIbDRKNWdQZ0o3WWRmNXE3?=
 =?utf-8?B?aW16N1k4VkZjTnR6eHo0OHlQQmVmdzNBOXNWYnRxMmpwbkFnbnl1cWdvWjlI?=
 =?utf-8?B?UncxRTQyRW1UL2ljL0N0dEYwMlY1Wmt3dG8yOHlZdnpheGRGZXR4dEkwZkh3?=
 =?utf-8?B?MVhwTERFOE5tbEYxK3Y0SktOMHczeHZpODZQOEVKcjhMcHNCWmlUK2RVWVBH?=
 =?utf-8?B?anJMUXN3Mlp3cHByR3JCMVF5ZDFSZTVHOWR3VkcxS211NUZzampVb2Q0UFZZ?=
 =?utf-8?B?N3UvQTNaRzlkQVZ5K0pQU1RScTlSTUI3N2I5SVIyeXA2ckh5VHUySithejNu?=
 =?utf-8?B?M0tkbitOL1pCQW1hZC84U3VKZUJPZCtKRjd3UVc1MUFtK2tTQzQ1cGM3ZWxQ?=
 =?utf-8?B?Wk9LT3VRS3RQcE9ENURVYWwwYmt2STgvRFgyN2kyMUt2bGNjQmpEMXdBMEkw?=
 =?utf-8?B?dXBvVm1vcVBaRVhOMHEzRWpkZDJWbjc3Um9VVW80cWhtYjR2TlJXWHBQRlQ4?=
 =?utf-8?B?ck5DNWJObFJLZUZuNk41WmJ3VUhVWHJQOW44ejRTeVhvU3ZRNFpCWEFuWFJ2?=
 =?utf-8?B?Z2lHRDhVWGlrRlM0NWhyRW5NZjlrQzdlb0trajNVVi9zYXdKYXdoOVlEYmN5?=
 =?utf-8?B?aTZVWEc2TEltWWplekVoUUNLWkNMMU9HMUhGQUVhcFpMS2lCUnJLMy9ZOGdi?=
 =?utf-8?B?K3Q5SCsyeXBKcUEwUHNHWEZuQm1mSlE2L1lkZDRsMzdicWRPVzA4bkZYUlZM?=
 =?utf-8?B?VVkzc1ROcy9XN3dOVGdmeGR0VTJmdWtYdmtTb25kbE9uVS85VFBSeHNZMUxS?=
 =?utf-8?B?Z0s3azFtZGVuUjNIR3p1OURieG9GNkNocE1yU25MU2ZwMllHbWxURW1JbmdS?=
 =?utf-8?B?Qk1wOWppZ1ArTGo5aElRK2k3NnZmZ0p4R1ZqR294Y3k2SG1NNjU5VVdqaDhQ?=
 =?utf-8?B?U1g2UlZpNlR4REhSemhXcFFzcTBCZERhdy85b0dPWXBRbnRUUHRCZW1obTZI?=
 =?utf-8?B?eURxVlRPd242YXdSY1g0RThqVzkzSE1KcnlIbUF0ekFlRWFpNFpQZkhjLzZz?=
 =?utf-8?B?UkNCUUNQbUFrbmhLNy9aMmgybUcySlI4VEYrV0FlRis0V09ZRTA2aFljQ05a?=
 =?utf-8?B?bHZyYU1JbFljZSt1M05GSFdLdzdKalYxcmhtdjVjeWhqU1JvcmpYRVlhVFhV?=
 =?utf-8?B?MzRtaGZSaEZXb3FZTkxBMjJNTmY2WHRxT3RTbUdHUGtPNVZvZkI2WGdWQXl3?=
 =?utf-8?B?aHR5cUFwQmwxbmZjenJVN1c1aTRlSktuTS9VUFArNjhGS1lWZjZnWXZjRVIv?=
 =?utf-8?B?bnkyL3I4bXRaeFdqZmJYbW5JVkhtQkp0MUsxeDRKWnd0SWx0Y0N4RzAwblNu?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <444325FACA25A84396F5A9163F67A69B@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbb0ae7-4e15-447f-db1c-08dcc5a1ae35
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 07:35:38.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BP1KE5eYlOotxo6D215H3SCs6s4zaPd52NMLbFEWBVv6InvL0taFdpTchbu1lgalYwF4TUnZueiNJargxykBFqzVzy/b8duHHi3W3gmmhzy459BD8i7o0J1JbvUwHloY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9231
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
X-OrganizationHeadersPreserved: AS2PR07MB9231.eurprd07.prod.outlook.com

DQoNCkxlIDI2LzA4LzIwMjQgw6AgMDk6MjgsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBPbiBUaHUsIEF1ZyAyMiwgMjAyNCBhdCAwOToxMzoyMkFNICswMjAwLCBDaHJpc3RvcGhl
IExlcm95IHdyb3RlOg0KPj4gRG9uJ3QgaGFyZC1jb2RlIHg4NiBzcGVjaWZpYyBuYW1lcywgdXNl
IHZkc29fY29uZmlnIGRlZmluaXRpb25zDQo+PiB0byBmaW5kIHRoZSBjb3JyZWN0IGZ1bmN0aW9u
IG1hdGNoaW5nIHRoZSBhcmNoaXRlY3R1cmUuDQo+Pg0KPj4gQWRkIHJhbmRvbSBWRFNPIGZ1bmN0
aW9uIG5hbWVzIGluIG5hbWVzW11bXS4gUmVtb3ZlIHRoZSAjaWZkZWYNCj4+IENPTkZJR19WRFNP
MzIsIGhhdmluZyB0aGUgbmFtZSB0aGVyZSBhbGwgdGhlIHRpbWUgaXMgaGFybWxlc3MNCj4+IGFu
ZCBndWFyYW50aWVzIGEgc3RlYWR5IGluZGV4IGZvciBmb2xsb3dpbmcgc3RyaW5ncy4NCj4gDQo+
IFRoaXMgaXMgaW5kZWVkIHRoZSByaWdodCB3YXkgb2YgZG9pbmcgaXQuIFRoYW5rcy4gSSdsbCB0
YWtlIHRoaXMgbm93LA0KPiB0aG91Z2ggd2l0aCBvbmUgc21hbGwgZml4dXA6DQo+IA0KPj4gKwlj
b25zdCBjaGFyICp2ZXJzaW9uID0gdmVyc2lvbnNbVkRTT19WRVJTSU9OXTsNCj4+ICsJY29uc3Qg
Y2hhciAqKm5hbWUgPSAoY29uc3QgY2hhciAqKikmbmFtZXNbVkRTT19OQU1FU107DQo+IA0KPiBJ
J2xsIGp1c3QgZG86DQo+IA0KPiAgICAgICAgICBjb25zdCBjaGFyICpuYW1lID0gbmFtZXNbVkRT
T19OQU1FU11bNl07DQo+IA0KPiBJbnN0ZWFkIG9mIHJlZmVycmluZyB0byBuYW1lWzZdIGV2ZXJ5
d2hlcmUgYWZ0ZXIuIFNlZW1zIG1vcmUgc3RyYWlnaHQNCj4gZm9yd2FyZC4NCg0KWWVzIHlvdSBh
cmUgcmlnaHQgdGhhdCdzIG1vcmUgc3RyYWlnaHQgZm9yd2FyZCB3aGVuIHVzaW5nIG9ubHkgb25l
IG9mIA0KdGhlIG5hbWVzLg0KSSBjb3B5LXBhc3RlZCBpdCBmcm9tIHRoZSBnZXR0aW1lb2ZkYXkg
dGVzdCB3aGljaCB1c2VzIHNldmVyYWwgbmFtZXMgDQpmcm9tIHRoZSB0YWJsZS4NCg0KQ2hyaXN0
b3BoZQ0K

