Return-Path: <linux-fsdevel+bounces-21780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF54909DF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 16:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D50281E94
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D3912E47;
	Sun, 16 Jun 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="x4rsabIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2105.outbound.protection.outlook.com [40.107.122.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256D19D8BA;
	Sun, 16 Jun 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718549590; cv=fail; b=Jk1CMoTlsw0befxykdjW/Kj5IhZqjTxBGw8gz5rGwQb6Rd8voimvNm++q4eZq+1t/ZbhEn7bw0HnwgtWyBiDjnBWzO3VvxOhAUOMps966lZIcivaO6IUiq+4Mt73sCTfmiY4KCA8OLesCdNXsYM0p2ZGLhJxG2Q592Me7uisCSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718549590; c=relaxed/simple;
	bh=5A8LSqDaMC0yB5/XFUM4BEC3MN/7ZxXTEfh4o7vkUHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FHmM43p/QgaCf5/d8/D+rEDFaY7b2vY5qH0tygAe9HXqEXOMpZztfRj9HIQtJypNbdVZxTz0MKjSj3UsxmRDXAGvQsKOdfeDq62QcvE30ZcWohjQbpIBTDH/suJ8p8uZX1fHSlPGYNjwfdSm6zHbhkpENT9yFHlH/1BFuKZK1ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=x4rsabIV; arc=fail smtp.client-ip=40.107.122.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltImT5B8+WOqmUiqdejtZ++omPkfrNAb2/M4EUpC+U51VGek407tIdfXbiU1BseyVg8USJLlWyM9NjKI7YsnEpzSaPek/DssHxgU2FYDfXsoKiO+YOQhRe213YM/NjdvIYy0BzY/NjkA4VQ5OPUnJjzc6FXvdLg2ispIkxvxqd8MOASSGHb9XouS/xrtnEpoltjSPSrJI/qvEqpvfGDXbaUlpe4AEVcH1tP2TVEtFOYET3MLkpCPUfLnDZTPUaQGefkJjTMkBgb/BbFDXIwO9NrL3ICXVGkrUN+/Itp3W5X+wXgaQW7slf9xIIfuLcWfDJpDjFkgaob2Zhmdu5j0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeEzi1qbLpcRxaKpxn3nh3kmnN0u+Emoo+gkXbGA67c=;
 b=U+wHpP4pAaCBfZMgJ/iwD8kfmcTNU8gQam6/rC5ZnGBjStqcdhjoz9cnS8Agx854JpukWF/Jlj++YUZsTXJgQ0UFkgR/KC/3YNgrfv/KeuKhtTNzCjcwwhPo/r7B25iFe2uc4GrmIyA2gKDV026IluHkP+NRx77iGQQsr8vKrhE2xmFzU6xoVJoTbRH3PD1QlJhyymEKy7980ZTtAuEuLKsgYaAeX6NSScafxtY1nEmn80lH14BEONF3PiK9es5QXI3jTJrdgZtgr0WVxFZaQSiDNvZ+0DiL//MQWqyALYwI8gUHfsxV966uJYINjDfukY7JMTPf42IcjsrsN+SFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeEzi1qbLpcRxaKpxn3nh3kmnN0u+Emoo+gkXbGA67c=;
 b=x4rsabIVATn4N0810wlYdBoNeLJQUlmfIgxuwQ474cFKqRT1PsD/df5mk6IxK/4vPicxHf3wBlH/hyH2HBP85a+CngQ/eK+12JAftB2X+Ml14KWe6yjFgi9e/LPD6YJ9AXS8QrfwJfByddQvqKhXAMbJO7YLkPC3OQ+TZEJVMrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6177.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Sun, 16 Jun
 2024 14:51:52 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.7677.027; Sun, 16 Jun 2024
 14:51:51 +0000
Date: Sun, 16 Jun 2024 15:51:45 +0100
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea
 Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David
 Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc
 Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel
 Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>,
 torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>,
 dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <20240616155145.54371240.gary@garyguo.net>
In-Reply-To: <Zmz-338Ad6r4vzM-@Boquns-Mac-mini.home>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
	<20240612223025.1158537-3-boqun.feng@gmail.com>
	<20240613144432.77711a3a@eugeo>
	<ZmseosxVQXdsQjNB@boqun-archlinux>
	<CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
	<ZmtC7h7v1t6XJ6EI@boqun-archlinux>
	<CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
	<79239550-dd6e-4738-acea-e7df50176487@nvidia.com>
	<ZmztZd9OJdLnBZs5@Boquns-Mac-mini.home>
	<c243bef3-e152-462f-be68-91dbf876092b@nvidia.com>
	<Zmz-338Ad6r4vzM-@Boquns-Mac-mini.home>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0463.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 21595375-e5fd-4173-4712-08dc8e13db43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGtwTlR3b3NrUjYwaFA2cmh0aVB2Q1FYRkNKOU1vaWhaTjI1SGgwY0E3M2U3?=
 =?utf-8?B?c0dUVkg0MXdRZ3MxMTRESW1FVFFxSzM0MGwzcVRiSm1CQTdna29DbFI0dUND?=
 =?utf-8?B?ZUJiVmhQbFh5NVRWYnc5cWgxeHF0eC9UUmVPazNWMXJXaVZMemR1Qzl2NDhj?=
 =?utf-8?B?VFpGazNOMFlITzIzQTViVHZISEdUOEpRRUJVcFRLeXBWYXdPUjM1Lzlwa05n?=
 =?utf-8?B?cGd3Z1JhalQ4Y2d1cnNwaG1iTVFmbk42V0xOZlBEcTRidCtCZEJjNXIrcE4v?=
 =?utf-8?B?WTdEekw3RTBnRzNST1haa2NweDcyMGFuTVpzREFSNWZER3RmNWNtZkJ6eUx6?=
 =?utf-8?B?dVdFN2I4Y3JjanBCWGdKeStrSTFkcXN4eU9GY1RvOHlLRUF4cy9PV0xwU3N3?=
 =?utf-8?B?QU1XQnhFVEl0UG1iV080ekdneG1pSkI2bFhsU3hnK2FpTDB5L3ZwRG5UY0Rh?=
 =?utf-8?B?U0IrbDFvc2xTZTgrR2FQK3QzTDkzdExjSURmTCtCOWVFKzI3em04NHhHeVZJ?=
 =?utf-8?B?SmJZWWI0S25YV21jd1V2SHNEVDFVZndUUEc0ckNkcXpVVlI3MFhUMkVUbk9p?=
 =?utf-8?B?Q0pVYTNITG82Zi9qTUtoQ0tvdnpweFlnSjI4K3hvd3ZLcVBnMDJnQjdzdVI0?=
 =?utf-8?B?NTIxbmJJdWFDT1VvKzg2ZXF2SW0zNlM3ejFoMjFDWHA1U0ZOVGEzcGFDUnNq?=
 =?utf-8?B?c0FPclRDZ2R1dHlCRnFJUTdjMGpDN1pUWVdPNzRxbEdZRW1GRGRzS3A0OC8v?=
 =?utf-8?B?dXJYTTVQOVFWUHhrY2JUcTdXcWhTS1N4M0x2ZzhjUEx5RTc4d3hUV3ZiYzlz?=
 =?utf-8?B?T1ltQlROTWhSRzBlbWU2UXFIcVdqTGRTQkdHelNWUlVobVNVbDVkc1dSM2Nz?=
 =?utf-8?B?aU1tT3VtVlRyd2Z6T1lvSlpWRkR0Q1J5c2haSm93M1Y3R3pEQnlWM3hRcWdI?=
 =?utf-8?B?OXF0d0paNTRxZ3lXakFUY2JaVmRXTGhPWXJGUERZSzJtL0NOdUNsL3lLMTJG?=
 =?utf-8?B?Ly9hS3ZUVXVHZElkQmw1VjF4dm81ME1wazhqRnJGVXFrZmRMN2JEbzY0TGtX?=
 =?utf-8?B?ZUpRdDc1c05XWmJkejFjZGljY1pPQmZqVnVRZGZRVzllZ3pOMVRlWXloVE9W?=
 =?utf-8?B?SVRidXNGYnRQMzBqTnlKMzRVWFVzMDVSbG5QOGl6UEY5ejZueW9LcWhHaXBx?=
 =?utf-8?B?bEMwN3E0Ui9pRGkwTHZPWDJodm1lYWJHcldKanEvUmJNK0g0K2s0ZURFM3VD?=
 =?utf-8?B?MC9Zekx6OFovQ0pXVzZIR0owaHNPOGJlc2kxTlZQM3ppV29SN2g4RERUcTZj?=
 =?utf-8?B?SDgrT1h4TXFsV2pFcWh5UU8vUytGR1RZYW5pdXhuUkZIUktZODJLZ2MrcXZ1?=
 =?utf-8?B?QXdmb3FaV2tPbXZRWFlTTTZoTUxMdmNkeld2dzk5SVV4eFhySWNFT0U3bUJD?=
 =?utf-8?B?OVdTWTZCOE1LRjQyQ0RsRnNEeHRXYWU0NTZBMlBVdUIyWWlQNWZpeWZTUzdr?=
 =?utf-8?B?MVdOclYvbVUvaHIwWExxMVRnaWFNbmZkTU41MGtwOEtYY2NtV3lTRUZjNDZQ?=
 =?utf-8?B?enpTZlZNSisrNlpXTndNNzYvbTk2cUxpWkl6UVQwUG9xSUI3N2xJQ2pWd3Mw?=
 =?utf-8?B?N1MvM1FzQmFKTUg4UFdNcWNOYU5aclJpVWJWZkNSRkwyYUswbXRhdTZYa2ps?=
 =?utf-8?Q?0n8HWJXB1IUfQFcm8OgF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVJRL0pJdUE1aUZrTGUydStKRXY3azJjN0kzWjBVQXpiU2tyNVFrK0RuQk5p?=
 =?utf-8?B?b1RnTHp1ZnAzbklMREpxbFR2TGdWc29IbVJNTnZVVW9uNnRTclNEdlFWZlBR?=
 =?utf-8?B?SURObkJBL0kvbUlWZGRsSjl3VjlpTFpOdC8rS0s2KzFGNlNzbWJ0OGE4R0pF?=
 =?utf-8?B?bzd3NjRQZFJKTDNEUmdGejNwRlpJcEtUS1NKOTFSVFl4Ny9YMzk1NVZxQStk?=
 =?utf-8?B?TzdKRy95T2NTSGdYQldtLzFMaXBVRHc1Nm1ROEx2Nnp6cWhBdnZoNnJybVQv?=
 =?utf-8?B?ZU1XODg2aHgzaUxpZ0gwd3FXVUNUUmRNSmhydnF0OFNLY0xaM0FMOUVRNTdW?=
 =?utf-8?B?UlJXQXZqN0lMV0wrKzg0V0JtL1kwNnkzRGFQU2NNQ1ZpTko0ekJocXF2WGo1?=
 =?utf-8?B?L2l6cWgrelluTjBqbmhHWnV5aEZYU1FaaXE1WTRXSXJYUEhKVldPRUNGSDZZ?=
 =?utf-8?B?Y3RKM2V4WGxWdlZObkdscHRIdWwyYklpcm5wNXhFYVBod0lkTmZjTzN5Nm54?=
 =?utf-8?B?eUdLVHB0Smh0clkwbFl2V3h4U01NeWpDa1NhZDdMWEswVS9UT0FFOTFpWGU2?=
 =?utf-8?B?dS9FZHRSY2JnVmRiVFhvMEZMVkdQUnEzdklrdXJDVkU5TE9wa3JzTHJZNEN2?=
 =?utf-8?B?MkhuSmNXTjhHMXBVVWc5ZVVXU3IzVHZ6QUR5R3pENTlRQmF6VDlpclVERnVW?=
 =?utf-8?B?aGdTSnBTMFVVbGIzV1JGVlRNMTdkdGlwRXMySC9XQ3dnOWVSNUUwSUgxYjVR?=
 =?utf-8?B?NzJVU3hmSDhaNWNZRjluZXFvUFJlMWVtVkQ2K2pNL0RDaGNGbEkxM3NxTjlq?=
 =?utf-8?B?NHIzOW15SkhyVS94L0tVQjJLODBQaHlKUzN3bmRYbzJDS0xzaG9NU0l6bHE5?=
 =?utf-8?B?U1lGR0huUjBObDAwWGhtd05zdUw3V2txeXJMb0VLUjlnYk5iaWphRWhObloz?=
 =?utf-8?B?U04yRWhrN1Y0ZmdBTG1GRElJMHFTbEorR0RwdFRUNHRNald6TnJ4KzdLUFdG?=
 =?utf-8?B?YW1wU3lJbXBnQW1wam9PbmhtMG5PcmJJMVI5Rjc3cnZjZ0hac1VWWVVGZWNp?=
 =?utf-8?B?VnE1RE15Q1NLVjk3RDJVMEtybUNTbVdzYUZnSG12UUJFUWtrYXNNV25FanVF?=
 =?utf-8?B?bXlRc0JXMG5ONC9kRGZvbTlUenR6bjQrR2NxRzJhM2NqbllPMm5BQXlEZHNr?=
 =?utf-8?B?Q1owYlhLSFdHeU0yQ0syR1Z6MzdqK0NkVWtPV0ZiT0lxZ21jU21zeXRvcnR2?=
 =?utf-8?B?TUUxaE1JOEh2cEJTK1IrWXJGelRqc3poV05OZjFMSmQ2Znd1WEtPakgrQml0?=
 =?utf-8?B?UkhHczJsaHhUcmdrbmxsaXJ5TzZLMEFQQ0lmZnpIMzhSemc1N2JuWVhtR29O?=
 =?utf-8?B?bDB3Y0xoaHV3cTFuRnJEWG8wV2R6WGF3eXRzd0tpazBQaThqb1lzdFhVeHht?=
 =?utf-8?B?OElDRjErUXc2dVpBK0ZUWVZIYlc5V0xRMlorYUVQcGg2SGhNVkluNGQxbTR4?=
 =?utf-8?B?cVhXKzdKTmNTQjdyNFkvaWJSdHoraVJCZ2RZQUI1KzQ3RStNbDBYOEt2aUN2?=
 =?utf-8?B?NVFvVnczZnFTaE9DSFc3di9yVkRaa29jajZ6dUlMVnNDSFlZcXhRMnhYdVNI?=
 =?utf-8?B?S2MxMTh4RVVvZmtoOU9MR3FHYjBIdi9ySXE1R0g3U05nREpZcUxBcTJFYUlU?=
 =?utf-8?B?UGlBeDdKdktuVDZKK0dqcGZHaWRUend4TTBvMm5iRDh4aFgxeVlSNTRUeTRU?=
 =?utf-8?B?c2JjQjRXM1JjTGhhSmkyTkJYaGNqbGdVaVBzbkZaMDQwZ1VaTlZ5RHR1aXJw?=
 =?utf-8?B?OTBFMnJHZStJRXZ4a2NzOWhOVko4Mm9UK0FJL2dMcGJqOEtzUE8yNlhlUjFB?=
 =?utf-8?B?cjBUa0xDYnVhdEpZQnhLdTgrTEZKR3JvMVFzZld6Zm9NWXRNb2NwNVovYzlY?=
 =?utf-8?B?akFoWi9FbWYyZ3RqU1licHJUcS9nbnFMamVkZ3Y3MmNUSU5XRXlPNHlTMDRl?=
 =?utf-8?B?VkRnMHBRa0RBdUpNOExLeFBtNWxBVGVmVzR1WUswdUpMSVUyUEc4STZndDVs?=
 =?utf-8?B?YVNGMGpHVzRBZllSNG9GaC9EajVwN0lzOTVSelFVdGV5OFZRaE1EK0tvWHlY?=
 =?utf-8?B?eStKa2tvWmVvYVRjU2dES2FaWXFieEJkcEo4OEp1aEF5VU1oYTB3YVJoYzh1?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 21595375-e5fd-4173-4712-08dc8e13db43
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 14:51:51.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHIEABzX1SXSFmq1n5lEj06x/kwwQoVF6peHUeWyodGYsyTNYzNvXYcrlVh8il0e8M9ZGfK9yOM8kQCUXQcRXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6177

On Fri, 14 Jun 2024 19:39:27 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Fri, Jun 14, 2024 at 06:28:00PM -0700, John Hubbard wrote:
> > On 6/14/24 6:24 PM, Boqun Feng wrote: =20
> > > On Fri, Jun 14, 2024 at 06:03:37PM -0700, John Hubbard wrote: =20
> > > > On 6/14/24 2:59 AM, Miguel Ojeda wrote: =20
> > > > > On Thu, Jun 13, 2024 at 9:05=E2=80=AFPM Boqun Feng <boqun.feng@gm=
ail.com> wrote: =20
> > > > > >=20
> > > > > > Does this make sense? =20
> > > > >=20
> > > > > Implementation-wise, if you think it is simpler or more clear/ele=
gant
> > > > > to have the extra lower level layer, then that sounds fine.
> > > > >=20
> > > > > However, I was mainly talking about what we would eventually expo=
se to
> > > > > users, i.e. do we want to provide `Atomic<T>` to begin with? If y=
es,
> > > > > then we could make the lower layer private already.
> > > > >=20
> > > > > We can defer that extra layer/work if needed even if we go for
> > > > > `Atomic<T>`, but it would be nice to understand if we have consen=
sus
> > > > > for an eventual user-facing API, or if someone has any other opin=
ion
> > > > > or concerns on one vs. the other. =20
> > > >=20
> > > > Well, here's one:
> > > >=20
> > > > The reason that we have things like atomic64_read() in the C code i=
s
> > > > because C doesn't have generics.
> > > >=20
> > > > In Rust, we should simply move directly to Atomic<T>, as there are,
> > > > after all, associated benefits. And it's very easy to see the conne=
ction =20
> > >=20
> > > What are the associated benefits you are referring to? Rust std doesn=
't
> > > use Atomic<T>, that somewhat proves that we don't need it. =20
> > Just the stock things that a generic provides: less duplicated code, =20
>=20
> It's still a bit handwavy, sorry.
>=20
> Admittedly, I haven't looked into too much Rust concurrent code, maybe
> it's even true for C code ;-) So I took a look at the crate that Gary
> mentioned (the one provides generic atomic APIs):
>=20
> 	https://crates.io/crates/atomic
>=20
> there's a "Dependent" tab where you can see the other crates that
> depends on it. With a quick look, I haven't found any Rust concurrent
> project I'm aware of (no crossbeam, no tokio, no futures). On the other
> hand, there is a non-generic based atomic library:
>=20
> 	https://crates.io/crates/portable-atomic
>=20
> which has more projects depend on it, and there are some Rust concurrent
> projects that I'm aware of: futures, async-task etc. Note that people
> can get the non-generic based atomic API from Rust std library, and
> the "portable-atomic" crate is only 2-year old, while "atomic" crate is
> 8-year old.
>=20
> More interestingly, the same author of "atomic" crate, who is an expert
> in concurrent areas, has another project (there are a lot projects from
> the author, but this is the one I'm mostly aware of) "parking_lot",
> which "provides implementations of Mutex, RwLock, Condvar and Once that
> are smaller, faster and more flexible than those in the Rust standard
> library, as well as a ReentrantMutex type which supports recursive
> locking.", and it doesn't use the "atomic" crate either.

Note that crossbeam's AtomicCell is also generic, and crossbeam is used
by tons of crates. As Miguel mentioned, I think it's very likely that in
the future we want be able to do atomics on new types (e.g. for
seqlocks perhaps). We probably don't need the non-lock-free fallback of
crossbeam's AtomicCell, but the lock-free subset with newtype support
is desirable.

People in general don't use the `atomic` crate because it provides no
additional feature compared to the standard library. But it doesn't
really mean that the standard library's atomic design is good.

People decided to use AtomicT and NonZeroT instead of Atomic<T> or
NonZero<T> long time ago, but many now thinks the decision was bad.
Introduction of NonZero<T> is a good example of it. NonZeroT are now
all type aliases of NonZero<T>.

I also don't see any downside in using generics. We can provide type
aliases so people can use `AtomicI32` and `AtomicI64` when they want
their code to be compatible with userspace Rust can still do so.

`Atomic<i32>` is also just aesthetically better than `AtomicI32` IMO.
When all other types look like `NonZero<i32>`, `Wrapping<i32>`, I don't
think we should have `AtomicI32` just because "it's done this way in
Rust std". Our alloc already deviates a lot from Rust std.

Best,
Gary

