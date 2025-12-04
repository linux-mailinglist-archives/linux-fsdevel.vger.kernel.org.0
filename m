Return-Path: <linux-fsdevel+bounces-70689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D152BCA42E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 16:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0A3A3186E06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A22D7DD0;
	Thu,  4 Dec 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="k9ymjTNT";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="c/WP7gz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeBI195.fraunhofer.de (mail-edgebi195.fraunhofer.de [192.102.163.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17C2D1916;
	Thu,  4 Dec 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.163.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860724; cv=fail; b=CG44Ff/Xmj8P5AvPoEPI4Xp7oFAymLQfaQ5UlOuGd/MER6B5J4UDIQEMkk2qNJxLppcrPaofcK0AsylgmTi6Os3SIzmV2MvZVFPUTJ/t2XvZUq6qAgVVLO6ZPuHx/JgTUUFBvJ5Jo3Szl5KssBgULEu1JTLq0KVKGJQO/zdFYYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860724; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IGD+Q/5LBieKGKAmKVO+TYbdBNOevjGNiTRSC20GimjygEnp6PrwBeEBuscwSHFsdbg+OtShx+zZN91BTLaMDH872Fsd/TmIODJPByjd+OGXqxctjsJtgl5gMMPuveszE+cgXOCvxikCBCtC+QgU+eV73ZRGtXZOwPEpdtHnZds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=k9ymjTNT; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=c/WP7gz2; arc=fail smtp.client-ip=192.102.163.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764860722; x=1796396722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=k9ymjTNTNMClLEo2aoKPgCWzc3L7LJEEZbe9CPy2Z3YqGCNG8xVwKihR
   dGB3KBv3/h9E0qIGcrYpJNypZXLDhpEwAUvXS7jMSl+1lr2Pyh9FD1/vg
   TN8t0NJwpuiitFmaWFh0eisrYOnYpHNrZCJhuMEaSlWJU6/QdBo8Jj0Hr
   7e0Lf1PkX3c/n/NqxJ/c4d0jrZoMQ8NVys2otSdqE6/wgYAIrXX0W+zvu
   laZ17ukQ0Mk/2DXizs1g4kL57E5he9uPNevIYYHIoS70Qn4BqDZhwd8f1
   FCwaYbVPkyRF5znmrilsiLp0JZ4aB1lPohvqdzkfI3+jruSwPwKoi3pIk
   A==;
X-CSE-ConnectionGUID: I2B+lTSNTl+F8z1cCs7qjQ==
X-CSE-MsgGUID: F+CI9lRWRreAzqb2Skf2Vg==
Authentication-Results: mail-edgeBI195.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F8BABMVK1o/yYE4gpaglyCQEABgiWzOIJQA1cPAQEBA?=
 =?us-ascii?q?QEBAQEBCAFRBAEBAwSFAAKMJyc3Bg4BAQEBAwEBAQEBAgUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWBjIBD?=
 =?us-ascii?q?QEBNwEPC0YxJQYOBYMCgiUEEgM1u1aBAYIMAQEG2ykYY4FkCQkBgT+DfIFwg?=
 =?us-ascii?q?mQBhHxwhHc2gVVEgUqCdT6EWDiFd4M8ml1ICngcA1ksAVUTDQoLBwWBIEMDN?=
 =?us-ascii?q?QwLLhUjDzwFLR2BJ3mEFYQfK0+CG3KBdUEZP4NTHgZrDwaBFRlJAgICBQJDP?=
 =?us-ascii?q?oFxBh4GHxICAwECAoEQEAJuQAMLGA1IESw3FBtEbgeTd512Aa9rNAeCOIFng?=
 =?us-ascii?q?V4GDJ9nGjODcQGTbpMLmQapFgIEAgQFAhAIgX6CADMaJIM2UhkPjl+DQroxd?=
 =?us-ascii?q?wI6AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
X-Talos-CUID: =?us-ascii?q?9a23=3Al5eBAGrc7JJGzkIGCuEJsp3mUeF/WD7Z8Ez2H0v?=
 =?us-ascii?q?7JzZ7Eba+UgCJ+poxxg=3D=3D?=
X-Talos-MUID: 9a23:7CaCjArFIb2bIaFbE7sezx8hH+Y5556RMloAuIcfsZO/NiIqBTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="15622133"
Received: from mail-mtabi114-intra.mx.fraunhofer.de (HELO mail-mtaBI114.fraunhofer.de) ([10.226.4.38])
  by mail-edgeBI195.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 16:04:09 +0100
X-CSE-ConnectionGUID: t4woIIQCTZ6dbdVVabLdsg==
X-CSE-MsgGUID: s1FNjZpbTNSen3H6jhjJpg==
IronPort-SDR: 6931a2e9_vAY214W1iA9m6Yqend4JjGu7Xtt3zmWSOZtNut54MVK4dmS
 8MVTMzmlaWWACh+TuNMDbEhS3/Rkh8F/AUnCrkQ==
X-IPAS-Result: =?us-ascii?q?A0BABQBMVK1o/3+zYZlaHgEBCxIMZYEjC4FuUkABgRyBC?=
 =?us-ascii?q?YghAQGFLKVoglADVw8BAwEBAQEBCAFRBAEBhQcCjCYnNwYOAQIBAQIBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEBBgWBDhOGTw2GWwIBAxIgAQ0BATcBD?=
 =?us-ascii?q?wtGMSUGDgUigmCCJQQSAzUCAgKtNgGBQAKMV4EBggwBAQYEBNshGGOBZAkJA?=
 =?us-ascii?q?YE/g3yBcIJkAYR8cIR3NoFVRIFKgnU+hRCFd4M8ml1ICngcA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBIEMDNQwLLhUjDzwFLR2BJ3mEFYQfK0+CG3KBdUEZP4NTHgZrDwaBFRlJA?=
 =?us-ascii?q?gICBQJDPoFxBh4GHxICAwECAoEQEAJuQAMLGA1IESw3FBtEbgeTd512Aa9rN?=
 =?us-ascii?q?AeCOIFngV4GDJ9nGjODcQGTbpMLmQapFgIEAgQFAhABAQaBfiaBWTMaJIM2T?=
 =?us-ascii?q?wMZD44hPoNCujFEMwI6AgcLAQEDCZNnAQE?=
IronPort-PHdr: A9a23:ZRkBlxzGmkuKdofXCzKPy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk9yJy3f7QzRV5vqtAnmmdNM9XK6L/CnU6oEYiq8y
 YwzYwTotT4GORw/+23I358V7upR9RnmmCQgzJyOYaHFJvZaT4H4YNY2TlVHffdSWgUYXbizc
 ZEDF80nA9d06Jm+gHYrnSSUKBuGNsPx2CFzvEHRnoZmjvUhMRvMgT15Ds8j91vl9sSvJqhCU
 MXo6InL6S2bMdp9+zmisbjGUzBw/7adZb0gLeTLyhczGg+VqwyOtqP+JBeQzsRQmHKktvgxb
 P//h0M7rDhviTOS5MF8j4aO14AszUnj/DtTnJYuAIjrAF4+YMSjFoNXrT3fLYZtX8c+Fnlho
 z1polVnkZuyfSxPzYgu7T+GMqDBfZKB/xTjU+icO3F0iSEtdLG+gkOq+FO7gq3nV8ay2UpXt
 CcNjNTWt34M2hCSosiKQ/dw5AGgjB6BzQnO7OFDL00u063dLp8q2LkrkZQP90/EG0fL
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vJriK6l21ASw6Z2k4HGsVLeWGnnpDfIk3DAbv31ZSRFFG/Fw9v
 rCoB1/73SftN9/YgBCpTn+AtjkfZqxz/FICOoqTNWftWvd2FdARbsKhbcKqAeAJ8SRzIBgPT
 0JScRD4dTLfDxHsfo=
X-Talos-CUID: =?us-ascii?q?9a23=3ATwh0dWrntlQGiVwrSH35p+bmUdx5bXr87U77H33?=
 =?us-ascii?q?mBWxldoOcQ3uc46wxxg=3D=3D?=
X-Talos-MUID: 9a23:WhosNwnB+fPnMFVVtC7idnp5belO4Za2AnwrqpgA4OnaNyxyGS+S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="29869705"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaBI114.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 16:04:08 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 16:04:08 +0100
Received: from FR6P281CU001.outbound.protection.outlook.com (40.93.78.1) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 16:04:08 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVmj6Z51tPMVpbd0Gw1ID2btopkbhRAde8u4qWVV+tAPItXs2jDfUJJpAac0WMLBg5yaVbaW1zjsEw2TGQbHSWI9ACB1ZLd5HFwfD1YXAMaihxlMVfEbhReLbyx8FUmYwnIsdZ2tVYoIh5p4x8H/5BLTSp9/09KswwpT+dtk22I33RrjE11pn2FWGIUnzcFtnkpEaSXYViUHoIwMsoR3lemXCka4/H+q1IsROeb+gKlMh9PUsnJJ5xr4RSEt1by4mjIRI+JHcs0C0ifMD/xPk3EId2mcOLVfi2Xqe2H3wXOPIcTEB5H2uaLTJPhgcBge5YDf0o8epzJU887nYMJlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=VnH98zKhRLG+3ykSyHso53fwi2N4g3w9JuEQYwdMkh74rwRg67MPXxsvalyne/SYZQsTkSfGLPHMy58ZhAE9wPoAqz9ah1qub/o3FvwbZuZcKcJ1bmVf54YRKhrSlHWKKYmdbtYaM4Yi4a3MQM5ApkShryR4Yd7ZfRlasUImA41xCtIlUvnTa+XuRC9XA1hzDdl9+IHYUg3GbdB2u1aHeEd+LuXLQzMu36gA5PrgP3h0Kfux/ileslGt9xbMifeUBsOA4mdJka478fiRm1sIOFgtY5EvbU8uBSvkAUEWVIcwpKt2LKQ8t122gaD6Bk8GEgwhGFeuT9sdUU+7PSIirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=c/WP7gz2iH8zdLYJMumDcWnKYkeA17SgvrdpONVYD/x+OEMXWBEzBZHvzvSRVO+C45yhHrb5Y1yuE/GY2y2zg8iM5LHkLp06ACJf71XfIH96/yPg84Frk6ted8M1vwGssLmpH5CrW1z9Qu8dEtoQvCcUJn8mg/9jQoqOavB4xsM=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR4P281MB3697.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Thu, 4 Dec 2025 15:04:07 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 15:04:07 +0000
From: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
To: <devnull+debug.rivosinc.com@kernel.org>
CC: <Liam.Howlett@oracle.com>, <a.hindborg@kernel.org>,
	<akpm@linux-foundation.org>, <alex.gaynor@gmail.com>,
	<alexghiti@rivosinc.com>, <aliceryhl@google.com>, <alistair.francis@wdc.com>,
	<andybnac@gmail.com>, <aou@eecs.berkeley.edu>, <arnd@arndb.de>,
	<atishp@rivosinc.com>, <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
	<bp@alien8.de>, <brauner@kernel.org>, <broonie@kernel.org>,
	<charlie@rivosinc.com>, <cleger@rivosinc.com>, <cmirabil@redhat.com>,
	<conor+dt@kernel.org>, <conor@kernel.org>, <corbet@lwn.net>,
	<dave.hansen@linux.intel.com>, <debug@rivosinc.com>,
	<devicetree@vger.kernel.org>, <ebiederm@xmission.com>, <evan@rivosinc.com>,
	<gary@garyguo.net>, <hpa@zytor.com>, <jannh@google.com>,
	<jim.shu@sifive.com>, <kees@kernel.org>, <kito.cheng@sifive.com>,
	<krzk+dt@kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<lorenzo.stoakes@oracle.com>, <lossin@kernel.org>, <mingo@redhat.com>,
	<ojeda@kernel.org>, <oleg@redhat.com>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <peterz@infradead.org>,
	<richard.henderson@linaro.org>, <rick.p.edgecombe@intel.com>,
	<robh@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<samitolvanen@google.com>, <shuah@kernel.org>, <tglx@linutronix.de>,
	<tmgross@umich.edu>, <vbabka@suse.cz>, <x86@kernel.org>, Andreas Korb
	<andreas.korb@aisec.fraunhofer.de>
Subject: Re: [PATCH v23 24/28] arch/riscv: dual vdso creation logic and select vdso based on hw
Date: Thu,  4 Dec 2025 16:04:00 +0100
Message-ID: <20251204150400.15051-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-24-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-24-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR4P281MB3697:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a9738f-9c2d-4c8d-17ce-08de33465f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2daHjK3sicP/R31dowtpvGTYluVh2DH2kmUEBsUM5nj1jnihwmsnzLQWDcqi?=
 =?us-ascii?Q?UohO5eaYnroGeERugvHPaJvFME/pcfeXgPBdiq3TlhsJDk8NR3CCqDuYRWQ6?=
 =?us-ascii?Q?JRrwVn1uxg9poLuVS+bHOm1vL4TfoES46ufWA3rsFhGyrL/8SMDjvJXpqOTs?=
 =?us-ascii?Q?NMsirVuhBucbK62dF3/dAgkQloHI44RRu6tskWzUx2Q+Zmak0Ei07COQYnsh?=
 =?us-ascii?Q?MdWyCAiwRnOSXQekglDpFPldlE8mzY5WytMuAPBrDYnniKxXrFvPuNyzcGua?=
 =?us-ascii?Q?Ju62m4Z+zCVEorWg2VqX32VUi+qFffJjlgxL3kOwboeNvPH5DYIJEOGQzRfm?=
 =?us-ascii?Q?p1NaATyj+UHjqnEhyWtjcHLAYlOJJmQuLrv2MOBh62pKZ1aL7BwVoSDkumEr?=
 =?us-ascii?Q?rERoA9uqj3nCxXqtiNiAdizhsqy5CN6NidnSB4jmBsQbOlOTojVrQ9fGUJwh?=
 =?us-ascii?Q?IUE42zxVYaBhOdHwjFhAJeC6Xj3MrNkCRXTl1u2B3z09F4M+FNqS6tgipdJE?=
 =?us-ascii?Q?2g3/0+Lef89K4JGtoswqC73jN9a8O1Rv7BugRR+bqGiFYRY4o8Ov80JHZN1Y?=
 =?us-ascii?Q?nPDXSSCBBuhcRkk1/qR7LjZKNi6VpZOw2MzTVO4uC8ZLGcP5hxj/6nw+9LIo?=
 =?us-ascii?Q?bY0mbsPELPbb3vh6q7QgabTVPnNGsSFSvzor1s09AdAv9MExlDsItswOLGS+?=
 =?us-ascii?Q?4xryR3Sjm41aZ3bpF4Rc632MVUZb6EXzvXif+mQR3v/ylAaHb1gKPJb0Vx0V?=
 =?us-ascii?Q?NJs2KZJwW/Cc1cox/PJQG8WjniAf+0ADZJKk/OY5zwldafm7fnZzesf9F5yc?=
 =?us-ascii?Q?67wawwaYlSmRd0O++U8og9Zoa5pG3scC2l3Xw2lkg9k5I35GG/Db8IMgEjFt?=
 =?us-ascii?Q?JVPZF7UpuE5U4O1pvkoBTzzIDp/NLa6YszlD3wJqKyYR8Q+spEtn85lqTy/b?=
 =?us-ascii?Q?eJGKE3rUJUjV+arxhtFYgzIBvGybAaFH1MXBIEfySwaL4VCe8Tivp91tBOdu?=
 =?us-ascii?Q?CVRapeHCpAP38p7sFHhQvDZHmpNEWe3GxINxmOquszHKSLQlYMtsKGvnOYFl?=
 =?us-ascii?Q?C7QMLe/TNoJwI3Qv+KzsAGdgG8zuuymym5jsjh2FTamyFgFeE3ttNcjzdVF0?=
 =?us-ascii?Q?wXvYbMUxQJn9c4hI/JXCR/C2UGztxnmDeK6HBpeqSDxU+OmctamNI6POHKGu?=
 =?us-ascii?Q?5DqNuheVkf+wn3DW7u/LlAD2cgrZoYCNgZoe3SjnKoeep5K8rj/xsshce/Fk?=
 =?us-ascii?Q?yiCVbsfDm3Ii2w7xcfOtomUdk6kl1F1VEi2n4UiHvQLhBEULnFjTppqMIQDu?=
 =?us-ascii?Q?ZA8uqnVtYhA9XsAft7/2XN5WFozuzRlC1gcnVy/P92bQNz4Jr2zZ4jLbH4LQ?=
 =?us-ascii?Q?ivUb0+GL2C8Xf3NQ7dTOAgwB7BNY8YeoId3TYlQIswutLQwXPP3D6/LEM2dZ?=
 =?us-ascii?Q?iyHuEZfEWAR3y63Fle1P4MVQjbQjMiTQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j6eOUwA1RvRL7/YugKvVW6/vaIkonT9i2HgkI3s3MF4S1a7Otju5X8imJsj4?=
 =?us-ascii?Q?hfuQrMCi+EzR270p9naMxfff1rjOgCmEkRIC6iqfT+mjldbfxyaecO7J6NeZ?=
 =?us-ascii?Q?Xv6xJaxmrw70ddcp1OkLseMiPr1AOOqYBIe+tqMWdluYE12Y+ljaEqWRt4SJ?=
 =?us-ascii?Q?7ZGClNFnl1Las9xxBFqnD/tdUr4cz5s4yDU090eNpIhLhM0MNWH+4giKtBTm?=
 =?us-ascii?Q?3M1Uke8UQ/f+Is59qGEN8YGigcGcexcmVcf7mJ06sHXArGzlNgq8a2iHfu8A?=
 =?us-ascii?Q?ydy6Qq5FBMfHMfm53lBSpXMHtF49GtL0AeHbrwfXtII5nQPuHLwPUdyZW2b1?=
 =?us-ascii?Q?w7JUqBYhCWl4QdO2+S3Soyy0R0PGh3zuyq6LeTjkQ2b5ihf1x1xYw3l2yT3m?=
 =?us-ascii?Q?+2pUTVXw0fl8zBiwnk2KkJiNE8i5wRS6WCQg9Uh+Mc7uT0DnO1zVdDkgCRMl?=
 =?us-ascii?Q?Z7XefKnfDMq2/uxx4TbK687eUBEpYAYQ/fIKrNkn7uyTTyEW5n4cjGJsE4vQ?=
 =?us-ascii?Q?AT3ZdZmF7PA04CUjexSKM0CdQBDIxPzwObjOQDMkuXNM1l+CTrAmUc6Tolyu?=
 =?us-ascii?Q?vV9duETb5PuijOW6dZJ773V9vOwJAh7EwYFPkwYPMdMDbgv/A6i9C7t88OJq?=
 =?us-ascii?Q?dxb/BM6tfc8HjnKJVdV/Dfp62+irQ5+7Y0ZKvAtKF+XEJhg7A/WwSUK7DHZa?=
 =?us-ascii?Q?74mx2CRnt4SeMbizPbR02D/6QS3/P+lm3IAdUJp+agYuY1AxSPGNX06aDB4S?=
 =?us-ascii?Q?g33F5Nb+v4tvkdGFIqHbBsphKbQubBUTr9F/hN/FgsImcmGYB+fHxjJxy3Y1?=
 =?us-ascii?Q?hL1+4rRmLMIYWLQONpeTxkAk57C5Lw5ZzromqugULx3cgwWz2Z30WufJb4VK?=
 =?us-ascii?Q?C7zmj4Bk84DiF2z1+bnByzCW1oT0nTH0Nc9PbxCfk6W4fLe8W0Y6t1cU838h?=
 =?us-ascii?Q?gFR7cdni4qYAkU7YNCGix9KAHQrh8Io+OehDBvDO9t72hqlizq2njd3UFbFk?=
 =?us-ascii?Q?e63hTkFKwteSM6757Cr2BIZww1+CjkY13Fo7SZ9/PNYzLquVp5VPGLohEpgr?=
 =?us-ascii?Q?oed7KYnwX/1fVE61lFXjWCbzY/OBQ+D3G1BCudKehA3nMUkCjAtfD8tpHtZt?=
 =?us-ascii?Q?+frk1iRT60UR8Tmntt6OJapCYu+3Axm6TLWdSrCbOQKJ7e+00vms5zGl2vcM?=
 =?us-ascii?Q?B1C+1czyZbTjhYxQRG5feknbi83O0e03FkN2g2BtdDS+GjHthHLkzxHnq2xR?=
 =?us-ascii?Q?DgGcIEE4aftQNgHBdx4tAS5CojU7Chm5jGc6rJeHiuDNXX7RamBYPdZFBXlz?=
 =?us-ascii?Q?+lcS9K5BwOIqIbI0BEoQynjHveBhvgnrE1/BNV74PAbYZ0tjeO4SOC0QN2/c?=
 =?us-ascii?Q?ua02JUCeV0yQbrIae7k8oyhYnA2s0LIRyQu32zmvuxPCD8mOv1wfA8TeKETg?=
 =?us-ascii?Q?s5un8SIl4RBLL4j7zb7UrT6X6Gao904ADeFJFAUEAVxbL9PE6sbQ5IjNRS8P?=
 =?us-ascii?Q?oH3aEPFprfQ1TyGiuZ1X+qMYM+moLeYD+exx4sGwKeNmlGq1wZUlvR7lFZYE?=
 =?us-ascii?Q?tXTIJRIEGtc/LfhR4KMSTwLuBhak463UPBjsZbOBmfILjvZ+5t4Y7jmgNdWG?=
 =?us-ascii?Q?d1FErhvl/yEXdZdcozypLpA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a9738f-9c2d-4c8d-17ce-08de33465f1d
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:04:07.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20HJhD6bKVndeg+Xd528M9sox571e1LOYdOySL0iT7uk/puwjJl/UmqBcM8iU2TRbYQXx5747dHm8DU77mFkE+18Sl7eLPfzQGLy/CjOtOa0DQ8jHroK/2HTmZ7xKRPZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3697
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

