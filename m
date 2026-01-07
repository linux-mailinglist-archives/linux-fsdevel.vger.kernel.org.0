Return-Path: <linux-fsdevel+bounces-72677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C09BFCFF53A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 19:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21D783003FCD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1269350A3D;
	Wed,  7 Jan 2026 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ijDJ0W1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021111.outbound.protection.outlook.com [52.101.100.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0253502A2;
	Wed,  7 Jan 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809567; cv=fail; b=oq34mRDjZtSmHR4dizNd2R3kCVvJfjkN+7CDbo/iHqOygm/okEICUPDH1BcMof6Bp6XaZMGRKltVQXUlsP+Libpx3F1lAw194eawqYQjHl3J9FOpEfb85j0qiZUHjtiwNz+9NGpu5cV5MSJNXatkyxMIqMDaamEEZZGNhaln68Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809567; c=relaxed/simple;
	bh=osYr1gWEb/bBYGc1m0FXN9Uj8eJ5NriUE/c7zXWai0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S4sRaql6RwQds0F8/zNdT9yqou7UotahXBPITaD1CnQvKIGVsWm8RolCoYLZLPTVGdTdBDr5z656l4ag+4b+yYYokG7E9HNFTnwuH67luYXXwZbllh5KDwJWdFHASkpWv1Z1yDj3mmM8EQArWOxhZDxPSlLe5c6oDF6MZjzMRHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ijDJ0W1F; arc=fail smtp.client-ip=52.101.100.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERqnsGxUNtIwaorIOnic+3bzU8OxAWTfIQJcDNostytduksUpkJXM/u19JziyZNrokwz2eyM62AHsjkPt2n4N/WggjcBlWnCJJtohkP3ownC1+/Er+HxXLchLVXJRVfJX1kNitXBiBiIjrJEY5Q9usvJMqP7YtoJ66w/zNlnBa6bF9DciS3RXG/LaTftr9iCjQphTd8MTCVX3Wj/jeQF3tuynXKJqmVfcl5PpPFD87FF7mhWH1HvPzJ85ZLqgPRl4Y9KOk+nzXwRLmijmPTzruKZ1CaoQgTEcklpDIuqoAdsusYmJPvB2p3q2A91LrsqF2i+icydFdP5rumZ01a2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aKAuHswVQqKqy0m64bX6Fq4G0FNhGdutcE5rwMefkg=;
 b=pKJtnWkYn9LyPUI3pyesYs5X8uDMgXxU4kx4VXENTSbslV4Hrw/C7dM37Xqv/o1QNGFJtU0MO31/0a+jbwzwtf9EUiV6n4Ew032hBJjZelbdsemDsJTxECyQfj9Ft84dXfbWVw1Djnj54xfSQebDBjVbymZ3bYI2GxwoYw83GKUyd93ZQmdm1Ty83gl6avDy5Bm+vamdsCOTHCpP3LTJiatE7OdC3lJeDQskp9Nvy6E2SPWG73J/MlARdkrEPAQdlGlY6M38lw5mgCj6VHP9Dkx3e1kKBBv4YZsBTy0KcoaSAQG7hL4s9NhbYeeOeR/7tCDrIeqIrNZqSCjmFMKVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aKAuHswVQqKqy0m64bX6Fq4G0FNhGdutcE5rwMefkg=;
 b=ijDJ0W1F2t1Swv3EpcTxO5JIXI2xrdXXAwWPSoslDVKa9JimVXVQrbewRUcpYwtYrg1DCAnS/tAANKKfvZRy5R6hVROsLxQzuLPr/C8YztWioXTafPENZMHPMJZphxNxhS67vLG4I5ulqmnERD3Gi8UiHtWQ2X/ZWRghzKEVSXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB2332.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:104::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 18:12:42 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 18:12:42 +0000
Date: Wed, 7 Jan 2026 18:12:40 +0000
From: Gary Guo <gary@garyguo.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will@kernel.org>, Richard Henderson
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Mark Rutland <mark.rutland@arm.com>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] rust: sync: support using bool with READ_ONCE
Message-ID: <20260107181240.4be8aa65.gary@garyguo.net>
In-Reply-To: <20260107083327.GB272712@noisy.programming.kicks-ass.net>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
	<20251231-rwonce-v1-3-702a10b85278@google.com>
	<20260106124326.GY3707891@noisy.programming.kicks-ass.net>
	<20260106181201.22806712.gary@garyguo.net>
	<20260107083327.GB272712@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0289.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB2332:EE_
X-MS-Office365-Filtering-Correlation-Id: b153da85-dd55-4987-3c83-08de4e185978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MCM4O34kTEMqk9ypP5fVCzJ46gRBxg8gbG33QH6dzw83EQIjXcGfQzTBt/Pp?=
 =?us-ascii?Q?25II2qYcAZXHptAd8p/t7/1YGyF1c8ID7AdG56zkzmrL9u4Rg0s4XNobXB0y?=
 =?us-ascii?Q?hWYu42KDMZotz7I40Af4rXl6OQyTFBJMCkDia/4kAq/TKlQg4xbMS3liFcSo?=
 =?us-ascii?Q?1BcY59CmiTNAZno6gYGP099xnNtt2R3hlY6oP7PF6UmwKxQ7x7oNDzng8UBo?=
 =?us-ascii?Q?UU3t06qUihDXQHTRzffZqAmi/aXVYT9FEMrRes6Znluf8a9ixnNJZ6PpTSRt?=
 =?us-ascii?Q?BNFVYlTY2TVT2YHpojIilWZ5gnuBNtmFend/hkq0F4+2Gf4bysXCRPIRqs3L?=
 =?us-ascii?Q?Y+t3+oIvjpldj9ps3iw6OYy+dhSXPXmm4QAyN/Y8MjNOmdIUkN/R+WEMr2qZ?=
 =?us-ascii?Q?lqhW1t3xqa/8SE6/BcYv9umnclqmCI2W2Lb8LvcLxf0QvcPrpu3x2+uNgQLr?=
 =?us-ascii?Q?kNvLA7WmnliT+hj3gzLi57i8e7Pgt4pYoJewpfSOLkDAi6wI4JccWhF73mYZ?=
 =?us-ascii?Q?mvrFxAqyhaZhBTMtZIiPlNLlE3FSKEwbXWmGdCTYkjegf3doQOuSaFw+T/rS?=
 =?us-ascii?Q?Op6FhB38Win+mAIUQtlGrHA2lwpZfGNqaTa4FNr+Ux5+/tU18f0tMzyucFyc?=
 =?us-ascii?Q?wSic0u/ieq3XJ5n57MD89ozBBB1rRzmrzVORN2JsAfx7cGVrZw07QKPkm0ry?=
 =?us-ascii?Q?Th8y+4xCjXMC4AM2hgN0/mh+4TxUP9Y5DeBUQqjLxzYwpnoU2UT+yoF9n6qV?=
 =?us-ascii?Q?q/JiSIRebk5lJET5YEqYIN0uiqEUlGeiGD0Qf7BEMo15xooUvEH0sHxcB+7P?=
 =?us-ascii?Q?vIfmSNluDmw35a+BeIoeLsswPY1o+zVIIwloKbulf35IRuzvSToD+ORNg0aO?=
 =?us-ascii?Q?WwQzcK7j4DqMncza6167J1ml9LkO6gS/mirwJW6po4rpVQSEf8J7TVO1MhwT?=
 =?us-ascii?Q?Pzy24lezWC9DK81bUVU0QnOQJGTZ+SI1Yhx0u8aMubmnfxhupNCHbcAiGDVX?=
 =?us-ascii?Q?efU9Bcqek8KgpMTSsjL93NV4V6RC48Uk2NCY1JGxtZtwLoksVEfNGJllyoLf?=
 =?us-ascii?Q?vvxPkiqvxZ5f4t2l9aJxmGcmLerUL496bp/xxsZaWjkmFVy2q/NqmaVFhwdJ?=
 =?us-ascii?Q?pxiPT8mGdPY+PCD8oGeztcFS4DekhQ7zlGak46NWWTEwuFQkrS5nZsEG2PU2?=
 =?us-ascii?Q?/1FHT4DzS21d4ijF6oBN+QhEXpaoAGtEGv57vUNd4gW/N+IJHReho2rTd3yo?=
 =?us-ascii?Q?36IkPtlAZ5JyCdTDQHod5rYtYzw+uzIRQTu/uvhfID5fXwY2sGGUb5OOscgq?=
 =?us-ascii?Q?h689bG+7guaheg3SspzdkugTc4SIm/xsPLm6/oNvEqWEQikeTiMY/1Er5IE4?=
 =?us-ascii?Q?0tezeyoXCuUr0U0VNEejmtWOi314ecT9q8GHQL0p8FcnAWNHn2u9ruLXOa/D?=
 =?us-ascii?Q?UTG/OruA9TKNYAs89tWsq+oVWWXQxf9l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MiY+5L9/eLw8hAQLfXoTSCnhfaiJkUo7ENOEyTGN83ikpr9vcHc6W1IFj+TD?=
 =?us-ascii?Q?Mu6AzZ222ons31pM+LEDonooARAb7wDiLnirGyVRv7fLz6U4rCVxawv/GYMY?=
 =?us-ascii?Q?mgsKtDAgU5hggDlRzOJ1KkUen+wvCu8fkJ61fkzdhJxqYRNVBFwl1dEgh0Nw?=
 =?us-ascii?Q?Z8XLmltSl5FTaCAmfMT0XYt/yi/3cg5xznhcIwxe79w/bBVL+hES3teBe5QD?=
 =?us-ascii?Q?xXYUbiOZQNk3xWtkIyec2BNJjH0GiIyX3W9UBXKAJrDc4UgCFHbOTgnlPeY9?=
 =?us-ascii?Q?ReUngPNoFCCogiwFOtjQHEK9U45b+LEo4jmv+MD46iNLxmK6s3CEhgO1wnY/?=
 =?us-ascii?Q?iUAENla7zArfnEY+2ajUM/ny5naTrWQfsYbxeA+2pX1BMlLurqvPDVC6iBYi?=
 =?us-ascii?Q?SDEbXNJzgrH1N0j6VBX2eCkfxmvpu82qGJhYfxiwMcfCN2rcKR/qXX3rRlY5?=
 =?us-ascii?Q?ckeuFjZ+Pv1rl/AEgFyKilSUK5S0k1PIKNAknUOERJyq2UzbK6tq9ADofu4U?=
 =?us-ascii?Q?HuANlT60SsjxBJkq7GNdNzIT2VTWdVNSaIrRwsy5/aIlCtZgFDoew27vcvUY?=
 =?us-ascii?Q?/oGyWzRE2AXDxfYZrGS9YEU4nDFerKNFzJUE5Ff8U29h1Ugaoz4kVDqTqXe0?=
 =?us-ascii?Q?GHBvwAuKbvcOXGoeR8dVfVsLkpaDQtayPkarTdvpMfETiL20dWnE2utWAf3u?=
 =?us-ascii?Q?IzXvAOBeDTFvXWIaFtFGLnTt9UYrV9YG17lEDUp5mKKOecTvGeYpVDlUZFF1?=
 =?us-ascii?Q?NMgJrZrGqWl4jNqj9hf2b7RXoHkc/JtnbTDyZC7MrIoBXUXKvLgU0HZsbVUn?=
 =?us-ascii?Q?OAZSVwRS7T7fV1mdP5RWg2bDgcBLpK/zgYd2EJSMmHjhxu1S+vCy5xy/YBJI?=
 =?us-ascii?Q?r4BTmiQOn3lH32zyYhQMwST0cTCNmmCjs5x+KWPZzfkHbIMUKt6ckAUvtkIh?=
 =?us-ascii?Q?C8abq9Ux/CiiZ75aTaV8jjNLZ3enJ5EHgboQ+RYtECwXRhKnugVouGwiLtJf?=
 =?us-ascii?Q?Zeq3+5BmrEe4S3ye+MA+C2vTgHnNAEBH7tvLO0fFqCLGHRHE9DD3UnIGi+ei?=
 =?us-ascii?Q?75tEDMr9G030mQdqQu20m3eK6TfKRmc5s6P7uxc1yqmCP6tQHsgjdB9gcTFG?=
 =?us-ascii?Q?a/zhPtOJfJImwKOR5uiNdTuEH0eq+gAMkhJXQl3reihpsiBVQVE3/RRxuNnj?=
 =?us-ascii?Q?398K0edzq0pI26jOhwUOxRErGNewLGrhHTkjxs7WBUFKGBe/6Ls3KlzL2etg?=
 =?us-ascii?Q?6de1gEOmoQHXa5sPZJEVuBlEpg5AYcF20Y4V9cR+CJoDfajDb/t7CnZQ8FX2?=
 =?us-ascii?Q?u2JDf+8tLwaTpJG418hcMwxIyvoBbBOeR+FYGOhcsK0kAGlPDu8j1Q3n8n+f?=
 =?us-ascii?Q?d4e7Yf0eMkeo/zjr/lzZjkNp5ZNSNdlIrhMQfpF8gtrFEv+qrePVq5QEhxVP?=
 =?us-ascii?Q?2frbGh3A69/ZKVL5qEbMyxeErULWXiJ6Bz5aEEkiXxGR0SGRG1mUHw+aHs4f?=
 =?us-ascii?Q?yzwhC2SB4OYoKn8CbReY+TDNxWNY0tn5D7GaqLpMj7hp5cclEt0NuFpEn/nH?=
 =?us-ascii?Q?TCQzkZ/eMn9l+neMD/0DHKcth2HLmDyHxmVclRXW3ChXmZJObzdVaZcca4wg?=
 =?us-ascii?Q?xNOd1XQY0UJoFuJS59kKhiS7ZwhoA595vIkerz9RlHk+1ys7RhzPc62HjuP9?=
 =?us-ascii?Q?s4sGwKWfJ+GCxtXlZAHHjFfrGMCZ5bMy9m5iPB5aFqJcma3nE+NwB25sC+5D?=
 =?us-ascii?Q?/ETqjjw9MA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b153da85-dd55-4987-3c83-08de4e185978
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 18:12:42.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +azaKDy90V6t/MeSWWT8473afXjwKUwdvETZbjwJ2PFgynpYDSNuhHrk3hJzJDdu9b34bA5KtJ6Fxc8SPgosZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2332

On Wed, 7 Jan 2026 09:33:27 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jan 06, 2026 at 06:12:01PM +0000, Gary Guo wrote:
> > On Tue, 6 Jan 2026 13:43:26 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:  
> 
> > > Does this hardcode that sizeof(_Bool) == 1? There are ABIs where this is
> > > not the case.  
> > 
> > Hi Peter,
> > 
> > Do you have a concrete example on which ABI/arch this is not true?
> > 
> > I know that the C spec doesn't mandate _Bool and char are of the same size
> > but we have tons of assumptions that is not guaranteed by standard C..  
> 
> Darwin/PowerPC famously has sizeof(_Bool) == 4
> 
> Win32: Visual C++ 4.2 (and earlier) had sizeof(bool)==4 (they mapped
> bool to int), while Visual C++ 5.0 introduced a native _Bool and moved
> to 1 byte.
> 
> Early RISC CPUs (MIPS, PowerPC, Alpha) had severe penalties for byte
> access and their compilers would've had sizeof(bool)=={4,8}.
> 
> I think AVR/Arduino also has sizeof(bool) == sizeof(int) which is 2.
> 
> 

It sounds like that none of these matter for the kernel?

In which case I think it's good to keep the assertion; if someone is ought
to introduce a new arch where _Bool (or Rust bool) is not 1 then we should
know about it.

Best,
Gary

