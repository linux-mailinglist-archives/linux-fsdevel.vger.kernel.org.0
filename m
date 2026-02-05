Return-Path: <linux-fsdevel+bounces-76452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP5gJ5ychGmI3wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:35:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B2F3546
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33F3C3040773
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446302264AB;
	Thu,  5 Feb 2026 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="UjZdQGuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021123.outbound.protection.outlook.com [52.101.95.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB71FC7C5;
	Thu,  5 Feb 2026 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298387; cv=fail; b=jM5SX4WScUZ9XSGu6zqvHwr4lENJWpYI0wTwwzIGl2/x+L8o3iSD3rXifuDo1fYTNVio8kuV675rSJx3AoaYHhyKvH2K6I0gaBm/kdEyCWd2qJ0o4JkJtbGQhmc7mwaQvWgFOsNrETDC51dgdqY1oFnY5HH+ia4m2oLX7ARe/3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298387; c=relaxed/simple;
	bh=GaoISbTX4hwecukKg2i8cwnvAODktnQQg9MGVyNICCA=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=acemFY/qonicfiTvkgBog/K1tDEFjTKb6DG/r+Mg90d898+aSV2bJ6Ounle3UamEULlLLXmBh2IV2jZiUoz7KQ872uyV1r7eAJcMlqZhhddIEzRIsLeGG71o8MQIWxmTEUymQwQAH9zTFXkzz9/PyGUQ2bcb2Y9bB2x9yMOtrgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=UjZdQGuD; arc=fail smtp.client-ip=52.101.95.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wm3aj969ih32fonFoxg6yUk0NE7ZEp5ChfmKyhOF/jW4yIvVPomi4XeIeJTHc7Nw6dvnnrcqjkDmfNmmlZdE900K+kgBCCaW9xGeZePrPhd0EbhJyVGgOu9K1/zr154y/My8VpOwKsMpThLPGqWh8NyWIYwW1GOplFdqeMXvoZhXhJBr/GZUVe26jt2mGxekAYG8nFUzbMs0Kto1QDLrs0EWYGUFCRENU8rgpYtoGn4i9hrplxuz1O1fjkfEyii33xEGF9sNutUEgWNipGYPdGFxU1+qF+m6MEZFY7CAOAKsA3g4EeCYHzCxkVOe+CRkbMSUdloX8fztBG+dGyAjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVHmHa51jeVgdklIdP6n7PWGZr4QgKQM/wvm4hFdIJQ=;
 b=ohkcRwVMaE34phc0alqKqQtdhbK0qxKJQBOO0FY4pmT0fvvtf109gOSRrChvk1AKV4fyf9RpXlF39518Q/E896tA7F8xv4WkJ5f0NNspED3cJSoqHgIPaxhMLCy2HllB6rBzdYo1ivsMUoJnscY8azSWXIIJM0EnfDbQIbuS9m7FL7gj4lnkST4k0NAadr6NPWc2ZooAffaJlsKDeMBh3I0ssA1D/7cSZtZ67OFEP/Rpcxwc2Ob6OM0KWhDvVCDdwU7KWs7+IWiV2yWVtgSDhdr4AmaXALp9uLpdLAbbDCa9KY7pG7pmSV6y/+AZmiK/J+scxGRB5umARNer8inVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVHmHa51jeVgdklIdP6n7PWGZr4QgKQM/wvm4hFdIJQ=;
 b=UjZdQGuDFUWGGw9e0HKAuTZLUq4HaMrir3ghvXcs3zN0zCce08bQreUIJH+VHphDg1k/aoAhjG0zezdtzxYewJJRNvwiCm8TmlEKjkhPQHdo45UxXf//F3IJYih9O+Da4/qXX+8xb9Xt5KFgjUshWQHhluvC2GaHLSUAP5xSQ84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2604.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:14c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 13:33:03 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 13:33:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 13:33:03 +0000
Message-Id: <DG72EHZAAM5R.2HQMCZGCQFZQ4@garyguo.net>
Subject: Re: [PATCH v14 2/9] rust: rename `AlwaysRefCounted` to
 `RefCounted`.
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Paul Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Igor Korotin" <igor.korotin.linux@gmail.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, "Oliver Mangold" <oliver.mangold@pm.me>
X-Mailer: aerc 0.21.0
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
 <DG72CY2P36F9.2O7OIN36KW8F8@garyguo.net>
In-Reply-To: <DG72CY2P36F9.2O7OIN36KW8F8@garyguo.net>
X-ClientProxiedBy: LO4P123CA0694.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2604:EE_
X-MS-Office365-Filtering-Correlation-Id: fc563ab8-1ae7-4efc-29f2-08de64bb16c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkV3ZjMwSVBFdmtvZnc1SElsR2dGWitCR1g2OTlKTUNFMkk1aHdSQlFxNUti?=
 =?utf-8?B?dFFQbzkvNkVUZDc1RGlLWFFIMkRxQ0lJSzNjUWJ4U3N2SVdsbTdURmw4blZX?=
 =?utf-8?B?Q1h4U0wxR1czd21WeWtjOWpJcFppMDhDYWNpeFVlbjYyTG8wTkJxUGhvd0xm?=
 =?utf-8?B?R3Z3TUtKL1RGOXdNVzYxQlEvckNBb3crQXhkakFIb1NwRXdtVmQ2c1JFbUJv?=
 =?utf-8?B?MFkwT1hXQlVqeSt1NEYvak5YcVJZREFLR1hpdnRFRzFEN2N3WllpbTUzNjlk?=
 =?utf-8?B?MVd1MGpyeE8wRG1WNDZVblFKUk1vWjNRWWVxUDQxWVQraTAydXNGVERYeGZj?=
 =?utf-8?B?VTVYWE14d0laTkZjKzc0eGYxYTJERThBOW9CKzEyaXV3TVZWV3VqTCs4NXlN?=
 =?utf-8?B?bGdJdEFGOU9lTlJVbmxLcExvOE1qdVlnZWhRaHZ1eG5QVS9LdUt0L29ma1p0?=
 =?utf-8?B?Q01sTjllTFltOW9MQlVRY0pMU09FWmM3UVllTDN3VlFGUng5eWhSWnI1T0l5?=
 =?utf-8?B?RU1Qb3NZVWpHTnNRK1E4a2ZqTS9xMGszZUx4eFljZ1QydWZpRU5yeHk5MkN0?=
 =?utf-8?B?WkVxek9CbUlMS1dkR3YyeWVTN1VwTWhrUTNMekY0TWE2MDNqM0dReEtkN3dK?=
 =?utf-8?B?RTlYM295M252bDVsbHZCUnlpLzJaVjZ4djlpUjZIUEc2d1FwYklqTS9iYXhp?=
 =?utf-8?B?M1Z4ODVmUzlNeEE3dnJsT3FZQkNobEhPcWttSzRRN0FHenQ2ME1NcjlaQ0dT?=
 =?utf-8?B?N3hMTHpNcFg3L1NnQjRUR2ROZ2xvM1JEMzV3NEFFdXJnWG8xUmh5OFpUSVNQ?=
 =?utf-8?B?ZUVUdzFkcWxXaFNKS0Z4WGMwSE1ybHBPUVJzcGYzbnBua20xQm5HVnhvS05O?=
 =?utf-8?B?V1NER09zV0dWRVpNNTFXcC9lVjlyZEVOaUpJV2g4R0VBQ3hMT2d5ZWtIMGFs?=
 =?utf-8?B?czRSSlY3a0VTTGxFdWFUY1owejNZSkc3WGtSZ3BROG5VNFFtN3lFRityYk1Z?=
 =?utf-8?B?eXNZelRNWGxKSU90VXVkT2l5bjg0MkM3SFpuc0lPRnlLdVgyWTRyUXk0eW5Q?=
 =?utf-8?B?S1ZwSDdhV1V5WTdJMWhneG4wOGpDSGd2dXp5SEFlckU1ODhmTWJSTWllTGJl?=
 =?utf-8?B?V0RiVmo0alRBanEyUjF4SHBEUmN4VlBWMzdzbDNmbmZxTDNCbW9IdmVRMndu?=
 =?utf-8?B?YUl1ckZTSXBlRzNxL2hMSUVsWFlHWUJuWmpWYk5pSm5keXU4WlFMNnUrbnVS?=
 =?utf-8?B?NkFKTStxdlgyNDVyKzVnZGJPazZUSHcwYVB6cUF5S0tOeWs0cTNYd0dGVjY1?=
 =?utf-8?B?NE91WGdGVjQvK2tRcFBXQktuSXFmempaRnJFZHhHMS9jZ21BY2hqT2JyUktE?=
 =?utf-8?B?NkhWclRJQUE2ZGtVak1xVE4wQnRTcnkwbGo2dXZCanZFb1hqV2hBMGErdDlL?=
 =?utf-8?B?YU9YSlBDRmxsZWE0bEJrN1FPQ2NHeWdwOERtSHgrVHcxUndPLzNxcG94NnAy?=
 =?utf-8?B?VjFMZGpuMGhMVUI0WjhzL2MzTmRwclBZQVpjM09BQzJkZk5xNytXV3ZGTWk1?=
 =?utf-8?B?cWZVR1pBQVR1a0NCek1lU2s2c21KZ3BZTWR0Y2dDamg2aTZtZzRpZmQ0U0Iy?=
 =?utf-8?B?WXVsUzcwNGNGQXcxd04rU1liWXhhcFVzeXFSWCt1QUVDMzNiTUVJc21qdTA3?=
 =?utf-8?B?SkdDV01hQU1RaTlHTTA2NFAzd0p5ajBKR2tJTkZLYnJFVHVrSFM4TE5VL21B?=
 =?utf-8?B?Rm5yYVJPd1h4VWVqZjRmK1BVNXlCZTRkaVJDeXYwQW14VG0vdUk2UTllR05j?=
 =?utf-8?B?Z2Uwcld4QitpR05COFVTY3prQ0VuNWYxNm44dVRQc2YwUk1BY09JUU9oTThx?=
 =?utf-8?B?dWVuQ0RKRWpMbzNSWm45dGMrS09YVG9HZEs3blVJaGlxSGJMdnFpM1FWMGYv?=
 =?utf-8?B?aGhRRk9LRmY0RW1VVm5wc001WFNzTmYrU2Z1MUIvVEJXU2s3SzcxNEcxMkUr?=
 =?utf-8?B?bzF5dHA5MUxWbkhQeWRNU3B4b095T2pYMWcxYmJtY0RueDBad2lwYy9oK0pR?=
 =?utf-8?B?SlVGdmI5WjYxYmZUelY1a3dNSHNUOEJFYXpzZGVDdHBGWjJxendLeUlkdTZS?=
 =?utf-8?B?L2JnNDB0bWlHQVBZcU8vVlgzU0RPNGpmNGdaWkV1SFY3VFhFUFVEZC9oSFcr?=
 =?utf-8?B?MkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WitFbGhNTTRZSm0ybVlkUWFVZWVOZXMyQ3B2amIwTFVMckV2dkZtL29qT2NW?=
 =?utf-8?B?R3JlUnZMSnpZbFRYZ05ZSHFrOUZBU0w4bk42V2xNVUdpR3hlMGFZREFtTUdW?=
 =?utf-8?B?MTVWUXRmbU9tL0tQVko3ekVjL1l0MmtORld0UzFRcmpRaXZZSlQ3b21YaGw4?=
 =?utf-8?B?SFpBMkk2OXNxQmNWYnhDR1VOY25sMlVxanV1VFZ5QVBZSDhLMUhwY0Z3bG13?=
 =?utf-8?B?MkNsWUJTejRiR3FtakxyOXp2aUU5QU1RYUxMbVVGYVBtOEgvck9MbjBrL3BB?=
 =?utf-8?B?blVJNEtyS25hcHo4N1poTmxsYmtQMWprcURJUUs3UCsxM1d4eENUcE82QlBs?=
 =?utf-8?B?cHJISjgvSzR0NWRUZTRrVjNzV25tVEJ1OGF6M0lrdjlxL0N2T3Y4anJmc1Rt?=
 =?utf-8?B?ZnlOVEE1Y3V5Mk95ZmNMdlhGNHpuQytjUFVFRm1xUCtRcE11VjNsb05NUmhl?=
 =?utf-8?B?dzk4OWl0MXhZa0ZnNWo5VkVhbCtJcmVKcU9YWUZ2Q1NJd1J3TGpxWU5pUklq?=
 =?utf-8?B?ZGVBS05QRktsTUhsVmhTSzVzTFZIYnhlWGI5cjJHUlFNSTByclNLUU1CL2Jl?=
 =?utf-8?B?YlBHN2x5b2c5WHVvUytsMWZ5RGJtamJuQ29VUWVJNG5BSzd6QS84VnFOUmNJ?=
 =?utf-8?B?RS9MSGhnY1JWWEtBSWVwcXNWRVd0MWVGWC93Q3VHWURoUnZDK25tclcwWkdF?=
 =?utf-8?B?UG1uQXlSaVFncjhDNTBrdDIyNE8yYkZ5VlFwenYxMkZHWm5Od1RoaU4yVWM3?=
 =?utf-8?B?S0Zmd2Nla3VjTkJFb3NSakdZUHBhcGNpTFh3cWFYZHlNajE5QlhVOGZ3ajdN?=
 =?utf-8?B?MnloT2ZwU1BUdDNpcGZwR05idDZ2N0p6cXZGdFJ5OVY1Y3VscStMVHplb05q?=
 =?utf-8?B?RWs4VVhzdjcydjVMSnVLczJINEw2YkhrZTZyaFNFVHpxakc2QndsbmViUVE5?=
 =?utf-8?B?NEpkN2ZhOEVqOURRd3c3Z29vYUVwVXBOUUY0VC9mRWlYQjR0Skt4R05IKzRE?=
 =?utf-8?B?YjJvUDh2QmZtMkcyU2JWWVlkaGZ2dS96aHV2S2cvR2dEWFdNeW4xYWNmd1V0?=
 =?utf-8?B?K1J5c3RMSy83Y1lodWNMNGJnUGpodWFNUG9OVkN6dXhrWERlb3k0czdqSHAx?=
 =?utf-8?B?LzhqZm1hNVJaRkJQdjhGOStYL1VPa3RYbjlkeWtqeXpMR3ZWdDMvcEw1MGl5?=
 =?utf-8?B?cldxc05SZGJ6V1NKbGN6Zko0T2NmMmtGVmtVVkNxSUhaK3hJUm5WYW11RkI2?=
 =?utf-8?B?YzdrcmJOYk5tdUJyRHNEVXJGVkcweFVCcXE4b1pNS3ZUcSszOWFONkU3ZXRB?=
 =?utf-8?B?UGxKZXh5Qk9KU2pVSk0yeW1OQURMUkVKMERVNHdZbEQra3ZUalBuU3VNSFNV?=
 =?utf-8?B?OW9CdDQxUE9VWjRZT21qNUduY0J5d0VBT0RtYUt3YTYvRkRnRHJLZElJMndC?=
 =?utf-8?B?bUViSHUybUhFcmQ2TXh0dGh1aU1XV0dwcGtvRXQ0RFNNcDRIS1lxZXhjM0hG?=
 =?utf-8?B?eVlIcWFLQXk4amRvL0oxYVljVVBwOXlSMnNVZ29sL1B3cnBGdDczRVhZZ2tv?=
 =?utf-8?B?MFIyME1CUStVTEhWOVhFN0RiQzJ5ZWMvOVVMckJpRmxQdlFYYkc2aEEwTmxv?=
 =?utf-8?B?MzV6SEtERlNLS0VhV3pROVRzREJQOHJnQzJZQXhENHlDVmJ2UlhYUTVXbHR3?=
 =?utf-8?B?ZUJ4aXpDWHk2ZjM3NUw0U1lvK1I0S1E2YnRHT28vRTVLK2dMb3NNc3VwUG9V?=
 =?utf-8?B?RzVrcVNkUkVISGVwN3hCTWg5c3RXeDZkYkJEelphUDE1WDVBL3JkSXpQOVFu?=
 =?utf-8?B?dFBpVzF5MnZNYWhqMFd0VnF4MUZGVyswVzg0ZDFiSmQrOFpqeU82Z3g3QkF3?=
 =?utf-8?B?aDYzWm5lejlHWFJ6K2s1Uk5rb3N0NW9STnNZS3Iya2hPcy9qTEU1Sk9qSDV2?=
 =?utf-8?B?NisvT1NyWURHWnV3ZGRlVklaazF6UUNwa1RZUDlud2RyUWxaak1sTkllVWhk?=
 =?utf-8?B?ZkxKdXFnV1VCb2VLR2E3dS9ESERRL3J2azVHa3VIcklUK0NBcTRmSjZuTVVS?=
 =?utf-8?B?YUVtaGRkUFNHRFd6UDFxTEYyUTV3bzIzdFd5V0dhSTNiZ2dLTnNJdnZ6a1hC?=
 =?utf-8?B?bU1zN1p4eGZtb28zRkZnZU13Y0RZSlNQaVFrbjBUSm1TdWpJKyswRG5DTW9s?=
 =?utf-8?B?V3J4UGxFLzVSZDhBUnFyb21CbHRlcjZHS09Dak9RMG9jaXJtaUx3RGkydUl1?=
 =?utf-8?B?ZHNkSVhyVnFrbVowYWJ0Y3FpREJEY1VHRElGTDB0a2poOXY2aFZmSUVralBs?=
 =?utf-8?B?UEF6RkJlUmhWZGk4bENpbGUxMEFiUWJHeTVtUGJiR25PaWFWQXBxdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fc563ab8-1ae7-4efc-29f2-08de64bb16c8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:33:03.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tIjdqD2/J1vjANjvER+zE8+xGf1pCMAu/AsKOImnoohiwqbSWN6NPtslRrzGkLqNlRaYK9iDe1yiCTBF4gwDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76452-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[garyguo.net,kernel.org,gmail.com,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm.me:email,garyguo.net:email,garyguo.net:dkim,garyguo.net:mid,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 027B2F3546
X-Rspamd-Action: no action

On Thu Feb 5, 2026 at 1:31 PM GMT, Gary Guo wrote:
> On Wed Feb 4, 2026 at 11:56 AM GMT, Andreas Hindborg wrote:
>> From: Oliver Mangold <oliver.mangold@pm.me>
>>=20
>> There are types where it may both be reference counted in some cases and
>> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
>> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>>=20
>> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>=
`
>> would require) and a marker trait to indicate that the type is always
>> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversio=
n
>> is possible.
>>=20
>> - Rename `AlwaysRefCounted` to `RefCounted`.
>> - Add a new unsafe trait `AlwaysRefCounted`.
>> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>>   `RefCounted` implementations. This leaves functionality of existing
>>   implementers of `AlwaysRefCounted` intact.
>>=20
>> Original patch by Oliver Mangold <oliver.mangold@pm.me> [1].
>>=20
>> Link: https://lore.kernel.org/r/20251117-unique-ref-v13-2-b5b243df1250@p=
m.me [1]
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> I think you also need to update the `AlwaysRefCounted` reference mentione=
d in
> the `Owned` patch too? (Or perhaps this patch should be moved before `Own=
ed`
> instead?)

Actually I re-read the comment in first patch, the text indeed should refer=
 to
`AlwaysRefCounted`. Please disregard this comment.

Best,
Gary

>
> With that fixed:
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
>> ---
>>  rust/kernel/auxiliary.rs        |  7 +++++-
>>  rust/kernel/block/mq/request.rs | 15 +++++++------
>>  rust/kernel/cred.rs             | 13 ++++++++++--
>>  rust/kernel/device.rs           | 10 ++++++---
>>  rust/kernel/device/property.rs  |  7 +++++-
>>  rust/kernel/drm/device.rs       | 10 ++++++---
>>  rust/kernel/drm/gem/mod.rs      |  8 ++++---
>>  rust/kernel/fs/file.rs          | 16 ++++++++++----
>>  rust/kernel/i2c.rs              | 16 +++++++++-----
>>  rust/kernel/mm.rs               | 15 +++++++++----
>>  rust/kernel/mm/mmput_async.rs   |  9 ++++++--
>>  rust/kernel/opp.rs              | 10 ++++++---
>>  rust/kernel/owned.rs            |  2 +-
>>  rust/kernel/pci.rs              | 10 ++++++++-
>>  rust/kernel/pid_namespace.rs    | 12 +++++++++--
>>  rust/kernel/platform.rs         |  7 +++++-
>>  rust/kernel/sync/aref.rs        | 47 ++++++++++++++++++++++++++--------=
-------
>>  rust/kernel/task.rs             | 10 ++++++---
>>  rust/kernel/types.rs            |  3 ++-
>>  19 files changed, 164 insertions(+), 63 deletions(-)


