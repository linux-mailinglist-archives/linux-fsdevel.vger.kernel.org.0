Return-Path: <linux-fsdevel+bounces-57999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B0B27EE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0145C6080D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 11:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF92FFDC3;
	Fri, 15 Aug 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJpm/oAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C02798E1;
	Fri, 15 Aug 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256303; cv=fail; b=e6k49U7lGYOUdkEjtFMC7lcbu8YwWrSWYUPY79emP50ZRdzhsbWMAeBBTpSL3Uz2LLor8AgUsmXZ8KM/HKdsMZwv1u85WN79e26rlFxbvzfCVg3+ioxPjq/NQdarxYjMyom1p7vTki/1NzhPCDzVknVHpTbDvh1bNOXnTG/0bZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256303; c=relaxed/simple;
	bh=yihez3eyo8+/NwGFKZ5gLLxi/zMjR0x/lNYUEmBb/RY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=EzTIkSQ9YLVwMdcABnO/J0tv8AmkIlLeGfRsPdRJ1cIEljReNm47RzQxryMs1F8cPI4EprzIFiLQR6g8qEnGUZKJVpqX7SoXBlZf6Zux0y1uCgpF3Vq5ewDDn9NGSwUR0Ibu6i88ZcUoR6oB7xRXRuGs2Jp/Uy7e1bJ936VXDdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJpm/oAw; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXOc6YFVVBwmfB5O6KVWCNQgbtlbc6H6jFR1qFI4Ba94GhxhbgpU+6nFETTtnIb0SP9OtjJWlThSXciwVzfnXa4yLtIPWAn8oTEGsyd5k68PJGzJWaGIO6NTplXn4KgLdjidAVrkNlX8XcMCfgaDzXxTuSLubza88+a08YBLTR7JBarINFsT1KusV8Pya7cXZoe3wT9TNkA2YpTlukl99MjDYRDf04/8pidgHx8vY/aeE76hUhT0THvcd3RamJe5qWe8O39yyQmXDObCsvPBTHofbjvMKMylYgSolEvM2hghRZJVy3Yjz5JwmeWkZMaX8CIx60RUhmCg57qGmAgskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yihez3eyo8+/NwGFKZ5gLLxi/zMjR0x/lNYUEmBb/RY=;
 b=LL3NDhw0jMFkkwgjGbusPnvhSlwqfgh5I4eebb1Vf21V1lITFCvAP8FL79j6oATzTiQ3q2q2liVgbP0zw8dNc8vZwrQSus8Yhgtk+N8ETQzOQe5CfYTGTc1MJEwib/p/Y8JyQzxvFt3G3eKS22kG3JG2E2tv10kGm2xsWQgcoVPBPB2iMzmvBrPpFtiuilRCa5ryoEdXeJIkkH6ea00q4h2WxqlEKLtnVJF4h3RlD3S7DGYSn1bLV2ETAcTuYc7R8oIPXDjG5iEn9ggBD/N5pjwl7UcfUkaHAIIwY8GD/472hqCeKShHG0Pe/Ehuz+9zb+ECfOTvy6JLVvR8ataYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yihez3eyo8+/NwGFKZ5gLLxi/zMjR0x/lNYUEmBb/RY=;
 b=SJpm/oAwW5HimXMfwBC+4DYDCkfH/B9Nl0BBtORLl8hRAbq1aGFtQ4HC5ernja3xtHfgWsTXmS4EpTylu8yKd212mXbJU1p9jMBXnhamzSVPMP6ztWLt4LFSCoKzX1y2/twJLL4O2VqHkM6zBVV2S319hoYlRwe40+hMxIzPXS+Vjs5sA6F8i8LqNOv53FcFUMD22n3Ggs0VvNe+4w/5ZQQDVYOhMZO8PPKc7337YNdL/2hhuXekbV5KSS5o6iyLe9RoZras7f/rn5pMT8EVf1lbazCofWklaV4ZxES80Mb6rH7gSx9fJBovd/IoI6sM9L2ggmm6fbMwtBIkErl5Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 11:11:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 11:11:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Aug 2025 20:11:34 +0900
Message-Id: <DC2YFDSUSTT8.1K6K6M8OY7LUY@nvidia.com>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 02/19] gpu: nova-core: replace `kernel::c_str!` with
 C-Strings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Tamir Duberstein" <tamird@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Russ Weight" <russ.weight@linux.dev>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "Jens
 Axboe" <axboe@kernel.dk>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Liam
 Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
 <20250813-core-cstr-cstrings-v2-2-00be80fc541b@gmail.com>
In-Reply-To: <20250813-core-cstr-cstrings-v2-2-00be80fc541b@gmail.com>
X-ClientProxiedBy: TYCP301CA0063.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9acb7e-1242-47f4-bb80-08dddbec811c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cENnNHhCeUJGZGlnZmhUeGl3N2xyV1M4d25vb1haempJNTFZWmsyZlJsQW5w?=
 =?utf-8?B?R3ZnK2x1Yy93aHM3c0RtMnRCV1ZhWVdUMnhCT005ZE54TGFIQi82c3RmUVNz?=
 =?utf-8?B?Rm1Nd1pab0pMZFNvR1pDRnRENXp2YWo3V0RyYzZ5SVBCQlByL3FGdUZ3TVdM?=
 =?utf-8?B?SkRRdlNXclJqb0p6M1FpK2xIZ0crMjNBcjhnS2V0SmMrenlCK2U3YnF3M1dH?=
 =?utf-8?B?R0tKRzZHYzE2aVowUmkwTG0xZWNrL05QQnlWRzZKWGFyQVlSbjN2K01nenN4?=
 =?utf-8?B?SXZ5OXNacWpYbmhPdlczZzdGckIydzNwQVVXS043K0VxQ0NhRHJicWZyTkJr?=
 =?utf-8?B?T0xscndveFhGZzcxVXNRaUZFbmxaTVhrZjNxRWlRdmlBcDVKYytKT3lTZW9R?=
 =?utf-8?B?Wlp4dGFPUTJUNHRreHFZYnlPdFBKUU4wSG40U1dxSHFWWVdLc3JrVFV4Wm9I?=
 =?utf-8?B?bnAyU3F0WVdYc001MVp1aUpUbVVyTDBvN2txNDJ6YjU2WFFuSVZoVGpKd2l2?=
 =?utf-8?B?Z2VkWm1xNEExUnh3V1Bkam5XNTVEamY1RlJwM2UrWDExaEZ4QUt2MTNtZG16?=
 =?utf-8?B?cW5TMlkxL01xR3JqNTF3ZEVZS201bUNkcGgvYzlWMnF5ZUp1V3ZFelZ2WkNU?=
 =?utf-8?B?QUFxR0xqM2w1SHArellIZXVhaWJmTE5uTHczN25WVmJGOVcvWGJRSEdaRUJj?=
 =?utf-8?B?UkdzV0FuQW5EQnc1YzJVUjdlQWE0TlVNV1NJbHFBNEF1RmFLMHUvN0xhYm9L?=
 =?utf-8?B?T3BjYTVadFNZK29OUmNGdkFZb3FmM0hYSEhMYkpyWkRGSC91b0dOSGFBSWor?=
 =?utf-8?B?emdHTzdzNlMzRUFBTW1kb0tVdXdXTlBlMTNURktFR3B6cHVTUXhub3BSU09M?=
 =?utf-8?B?djc2RVRzQW05N1Z1TmhSbHdINTAxY0szQVJRVmt1dzhieUJoay9sRzN2eTdx?=
 =?utf-8?B?ajk0MWpBRkhva2lTQkljVFRVZFgrYUYwQnl2elNsM1BJS2R5UHk4cm5pM25k?=
 =?utf-8?B?MEprSXZ2VU55bHd5bGpBTnZsNkkwNmdJSHhSOWl1ak9OZnA1R3lUM2pkVzgr?=
 =?utf-8?B?R25xY2VkbFp5VDFQY3loeWY4a3M3NjV2RUV1WjZIT3NHbXZtaVA2RUJ4SHpH?=
 =?utf-8?B?dXNUTzNsai9TM0liZkppNzJzVjNYcGk3Y0Rmc3kvd2hsT2twLzNLR0hiMzdo?=
 =?utf-8?B?OVBwdXFxU2lYZXIyTjdxbFdKV3BzdW93MFFoSlN2d1hYZnF3c2pZbTlzTWJP?=
 =?utf-8?B?UDNJSGF5L1YzaHJwZU1pTEhKZXlVTWlaUGZMcC9rRFBOaXQyWXVaOXFrTnJC?=
 =?utf-8?B?bXVhYS93TjlrZGh4VkFwd2VBOHlFL01sNVNZQkx6dnlsTlA1cEI1TDNoa0Y0?=
 =?utf-8?B?cDRCS3ZHVzFudGx3R3NSeUg5YkxOc3g2Q0dVUFAvNXQzaVRONkh0b3hWTFhY?=
 =?utf-8?B?N0VFajJRSGJIUTFaYWJTS0V5Mmt6L2EyWDY3WXJRelVlVnlTelFHeGJub3Fn?=
 =?utf-8?B?MVVGUWNmQWJFTndQT2tZVEprYTdMUXlIUUJoTTdmQXltYk1rRldDTTZDVUFK?=
 =?utf-8?B?QjFuVmVyYVk3Qm5MR1FtWTRHa2JBYlVURzlKWFQ5ZkdKL2MyNUVVNmd3ZVNN?=
 =?utf-8?B?SVB0Vlk1ZmNtRkRwOGZQYmMvZFk4aUhEQ3E2M0RyWncwa0haV2F6ZmxrdVoz?=
 =?utf-8?B?aGFPZ2hzUFVacEVPbTZRdUE5N2l6TTR6SkJhVmh6TzNpQUtUQVZUOExZcm1E?=
 =?utf-8?B?SEVpT2RPaVNkdDQ1cndxVDM2N2pMdk9la1l4c3VldWFJME9BZStKTVZ2S3Bz?=
 =?utf-8?B?TXVEWnJUK3dxT3hNdlpKQjJZYVJkRkNIT2xFYWNybG9mbWZuRWtGaUhBQUFq?=
 =?utf-8?B?dFlpLzFQUUVWMzBVaWhnVnAwV0FvbHVNL1Z4MEY3S24rZmNHZDVxRk10eGxh?=
 =?utf-8?B?U2tQeUpxWTFQeXE4RmNtdnlnN0d5d1VzVkFpOHZvdFJjZWpnMHQxdDZIL2Z0?=
 =?utf-8?B?KytGWE0zdUpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWpLUG9kMjExaG1tNlNkNGFIdVkwaVlIRCtQWkMyeTdUTXNyVUUvN01UTVlH?=
 =?utf-8?B?Y0NWdXk0cVladXpUL2V3aThIYXhPVHNpdlpjd3NYSEIzd2NNbGZrSERRZFJt?=
 =?utf-8?B?VVg5Rjg2ZlpZc2tDZjltSzFtWnYybG1reFU0ajNGZUtuSUdldWZ0TGpSa2VC?=
 =?utf-8?B?QTJMa2lxYTRxSktpdkxYVW5wdmFFaDgwREFKYkd4RnlmOGZRampCWXR3VFhM?=
 =?utf-8?B?U21VcnR3bFhJWVphOGtsUW43akdWYnRQOGZqVlZmUFM1UGdza1BxRy9NMHRE?=
 =?utf-8?B?WUxDVTZtcmVBbzFpTUdISlZKdkFvTDJ5NkJFSEQrbHhNY2tYaXNERXBKb3JG?=
 =?utf-8?B?cFc1RUQrOHVUNCtOdkNKZ1VBenJqcWhjaktvRVpxcm84eFl0R09IUW1sTmt4?=
 =?utf-8?B?TTV4M2lIUWlpeUI3TW1hdDJBYzZyUDFic2RsVU5KOWJ3TUNwL1RzU3oyRU02?=
 =?utf-8?B?akRKYUtVQjNnQUtNbG5WbEM3STE4U01DOVpVY0hPUW9oaDRtVjJicFVoVWY3?=
 =?utf-8?B?aWRid0J6bDFPRDJjNXlJMXc1RFdXdjdTQmZBZVNQekdpK2wvZ25LOXp5UE1l?=
 =?utf-8?B?WEFjZjdEd1ZPUmFLVGhEaU54TDJiRXE0UjQ0UGJvVnBQQldickJKMTNTNDlE?=
 =?utf-8?B?V3RIcW5hWklXWVBsNytMdDJ1V1MzK0Y1Mld1c3BwaXp5UTdKS05nVklDRFVO?=
 =?utf-8?B?R1JhR3VkNjNSRmZURDA3TW5BSDFNZTIwVG5sS0NhNGI1TGZYUU1PNGFhMjFY?=
 =?utf-8?B?TGhkc05tTXJFN0dNQ2tnNXkyQ0h0VnYzNWo3OXVzeklxVlZkK0Q2aDgrM3pq?=
 =?utf-8?B?UGlqQlMwUHV3SjEzVXJYNVpPSzl1MTF3dFdyS2VxdVJuV0hSUzlRTy9aVTlj?=
 =?utf-8?B?QjZrZVhTQmtFMlEzUGdOMWJ5bGpZdk40NXZWcjEydG03aHRVdExGZkRnQUNW?=
 =?utf-8?B?eVR0K2FsdkJKL1ZIUGxYay9XVUZHaGdFNWd6eEZ4Qm5hR2pkbGp5SXVxOExz?=
 =?utf-8?B?OEFkbHZoN05zTW1vVHF4UUdBRWZiVXhoSC9vczJySUh6cWNTK0hiNU9RdWVn?=
 =?utf-8?B?UEhkZEcyR3dyQUl4OGtZQXBFbVRCNXVCR3grbFBLNS9nUGYyZTdvMWZnajVn?=
 =?utf-8?B?M0Nidzd3YWVta0s0UTN0YzlPVk5RNmYzdVcwd09vckdEWWN4TlkyMlBRVDl6?=
 =?utf-8?B?ZU9hMFpoVjRzS0IyaS9jdlFtc0NtTStuTHY2bWpidFlFamZXK2xvTVFDNlZp?=
 =?utf-8?B?VEVFcHJrRWwwSkJ4MWpZM2cxZWFPNkQ5Ty9rOFBteUlmK1YzYTc2aDdDeDRN?=
 =?utf-8?B?RldTZm5Qb2ZnRU9vclFLQStMdVI2Tm1aTXpKeWRzQ3NHVUlCbXZjVFIvT2J3?=
 =?utf-8?B?S0h2R0xoMUphcW1zZ0QwRWlFd3N2Q2xEV3paeTJpaTRFYVNOanVzbWhBc1NF?=
 =?utf-8?B?QW0xRmVZdEM4YXpTcVlHNEdrYlBDMmxKeHFIMjkzQWpTQS9QSlArVHZRRGRX?=
 =?utf-8?B?OWpmQ0M3U0RsNUw3Tk1xRUJzS2paTFMyK0xXZmFSK2c2M0dNSmY0VXg4UnQw?=
 =?utf-8?B?bzNIY284TDhKM3hrU09PMWlqSGtqak5xbkVXMDRlUHR0dUkxT1o4RmdoNUlY?=
 =?utf-8?B?V1N3K1A0SG1YL3JLeDVxVUJqZmI3RWlONURtZzdUZzY3MHEwL2Rsei9lUVYv?=
 =?utf-8?B?Q2dweTI2a0c3N05VM3poamd3Q2cxdTI1T01VY3ZaOEpKK1V0a1ZEQitVeFh0?=
 =?utf-8?B?dENCK2tPcTlBWFV2OUIyN0xoYWdqM05BRlJwRUp3ZjRaeG5ManRjQnh0Q0Vi?=
 =?utf-8?B?WVhlQUYzV24rT1BvMjRPRUtTWnBETmFDSXZ2K2RNVEd0b1FEbittQjBUUU5u?=
 =?utf-8?B?OHVhVXNhNHZEeGpoOVJWWDFkTVVWbVl6YnRqK2JEOThMM0IzUjdTU2JGa1lR?=
 =?utf-8?B?TGdhNlVjNTNnMnBnQkZ0VWJUKzk2L3JjcE1iM3JFUGFrcFVGWGprUldzU2dZ?=
 =?utf-8?B?RHBLVlNZMzBHU25nam5DczJtVUErbUhvb2lDZyt0d25WcmlKeGlsay84TXBG?=
 =?utf-8?B?SjZzTTJlcEN2VkEwWWNqY3cyR2JQMFJlMWJSZGYwcFlmanRQMm5GakxCRXNC?=
 =?utf-8?B?cUFkb3k4M0hHV0JRc3BJdnhSSmQwM0tEYnduNVcxK2ptVkRsam0zVHlRMEZw?=
 =?utf-8?Q?ZPpeq9nNj6326kp6nBQnhx+QgxF4GbyDhJgQ1KUUzt8G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9acb7e-1242-47f4-bb80-08dddbec811c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:11:39.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbHFvGyCRGmg7MGMx8njWWHRnixiLERfGlLNUvVmcVitUSt1bIk8IuWxsipxZGuPK7bMMw1wU693kys8/inQmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714

On Thu Aug 14, 2025 at 12:59 AM JST, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

