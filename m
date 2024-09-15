Return-Path: <linux-fsdevel+bounces-29410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE397979C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 17:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA751F2148C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991831C9875;
	Sun, 15 Sep 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="AFlw1Xks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021103.outbound.protection.outlook.com [52.101.95.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A061DDAB;
	Sun, 15 Sep 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726414737; cv=fail; b=aYB5gpQy0aYDl2ypnXiV00CiRfsw/vpoNfW0JpsJx653RJkzHBmtj7J50nf+7Bp8sCg3HGMfHAsi1fVuSEzqkPsjNvxVA7butVwL5CeOE+pd9eEsYl5r/S0SW8z0YU3oU28gkGc/S1wkCmdrDovlQLRJiJlgigsXI5voJGi4Q0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726414737; c=relaxed/simple;
	bh=3zh4UHcV5izd5SDPuhnn1QrR+HInS6F4JUpnawGhhc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mK9M8NWg/zILRi9jAqMqrCkMLrmRedZVTwGOILRkuRmQTw5SVlRwAT73n2pWaMfTjCSQ2CEI30LNTCHludvlNrNQjaNO430xzOauOEIfM/fmgUdHK1HeaC6hbFzOb3HB+HF64HIRtYp5fSFv1xUN/To0BpyOw9VtqEFOhK5Ho8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=AFlw1Xks; arc=fail smtp.client-ip=52.101.95.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be+L486E/W/W9jvz9KjabWtQOLC7miVkQZKKWaDPaG6XHP2ySOOZpqGj17ct9i+YlLtggorUukXB7ySPrmtuHcs8d/JtBliReNwuCsHV6oX+S3eczwwhEQ/2UiU/1wXzYjq3yYq2voO+Lr9cmobWErX1I2NMFF9HZ0ZFW6J4zVPCfDlZq8OKqD3MLL6/J2LccWzFS52XlcT3tyiqxGqiE9MTwt5X4gGQX69g0ySyS4I2j3kBD5jYSe5lPY150deN1SBxd7ilvGZ1vMRUa5k0OR14fz88nH/OqqjXo1D/vqaHn7dxptjryug5iXtw9t7HtRg3+FQW6icgjsg+mNWehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpDcIilK8USYpGKQVW5DU2d+6eARH3dFlWZ+Sa+WdLg=;
 b=RTQS4hyKQRpH7jUb2cQD8/TycvlMn0BAYDwu84cE+JeHkvIHRMnRFYDdBxF1aJAAkZzNsectIBvU2KePG2nGzpLCjhzR/dDtLcav6luouA8Z83By0rLiLnIzMeoTaui/sFBzlKKRgt8fCK36GmwbuGbrx1w/UDeLLDBeoSUVgog9+/uv8qNnU/XfDuqCp6oyfsrZyaQr50kZVqZnBfFILIcjCLA87Z2//CCQPY1h3N0usj3JkkH0p9N1yB+61EDyALawHjIuWGBUDXkC/EuBCBOKJWAyAUQxGGf5x+fFUAdzJEafbhKo6frVNIh1izaYsKnDZEtsgGB9gs8uVTeefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpDcIilK8USYpGKQVW5DU2d+6eARH3dFlWZ+Sa+WdLg=;
 b=AFlw1Xks4qzebIXutMwpf1fzl2BnV6qCAy97ASaFdiLWiHIwCUWbHlfuxspj2OQYXbrhtSt0QoIueCWImKYlHEv1Dkcj6CcCkpZjPJLIn5R3zF6hZV6SRlWSLV5o5qI8E8q/w76i1Isml7AZoBanM+fMJebK+3arAqESWo+mQMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3192.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 15:38:52 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 15:38:52 +0000
Date: Sun, 15 Sep 2024 16:38:50 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?="
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
 <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, Martin Rodriguez
 Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook
 <kees@kernel.org>
Subject: Re: [PATCH v10 1/8] rust: types: add `NotThreadSafe`
Message-ID: <20240915163850.6af9c78d.gary@garyguo.net>
In-Reply-To: <20240915-alice-file-v10-1-88484f7a3dcf@google.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
	<20240915-alice-file-v10-1-88484f7a3dcf@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3192:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac798d0-0106-47c7-79e4-08dcd59c806b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1p3cTBrdG50eEFGajRzQ2R4WmFBWElScjVDQU5IMTlRbERzMkhwWVhxZ2lS?=
 =?utf-8?B?VmdEZ0NWcHBseGh0amJEeGVycC9rVHRyVk9HUGI1cXlZcFBvMlBWNDVsb2JC?=
 =?utf-8?B?K3J3dUZWL0ZmZkxNL1hxZWx0eUpzbEpISWtOcGNNbFp4Vy9IbE5qRzByWCtv?=
 =?utf-8?B?MmRoa2pmSGcxUWlGNC9aU1VsaFBjK3E5ZC9HTjJJZFFWWDVCbXF0RVNWeGpO?=
 =?utf-8?B?MVMzeFN4Mk1TQkplTkw3VXpKVUh1anNhQTY3OE1CeVp0UlNxQ0ZkcVVBclZW?=
 =?utf-8?B?RkMweG1hbXcxdjFWR3l0VjRWZmZHYnAxeCt6WkU3Wkt1ZVN1QWIwVzh3Rjlq?=
 =?utf-8?B?aWhDSTBWSHJ1ZUNjQ00rczhsRnJJQitmSnNPa1JRWFV1dlRxL21YV28vR1BC?=
 =?utf-8?B?M29FSGJoQjhLdUpvWjBmMnBKOHBmMzBwUGdzbzM5bUJYWFREQmtXNUNyNFlU?=
 =?utf-8?B?VVUvcU16ZkIvN1h1ZlFIRysvcUpkTWliNjZiUExYMGFuekJwdWxsWXZPcFVm?=
 =?utf-8?B?MVg2ZHJJU004ZGcxbTdyeDdSM3dkZTkrUFU2MzhVSVF1WURoNkx6a2ZmeXhM?=
 =?utf-8?B?c0s4RHpTZWs1L1NMeUVNem1FYkpEYk5VUXR3N3FXeTNUWGtqNjhXUXNwNmVn?=
 =?utf-8?B?TUNZTnJyeW4waktmZUtqMHJOODRLRTJFNXQ3R0Vnc2VBMHhOeGh1aGdJR3JE?=
 =?utf-8?B?ZTJ3SW1hTDBuRXhUeWtjT0NlT2xUNFU0WXJYRk9KQjlMeDgyRTVxSCttZ3dD?=
 =?utf-8?B?UFNVakdLQTdwcERCNjhGclZIaVlnUGUvVTY0NHVEU0gvK2ZQK2ZraENSTXE3?=
 =?utf-8?B?LzViQnprY0FGYm56Wk91R2VYdkYyaGtnMGZOb2xSQXhtSTJUY0pBUjM4TmMz?=
 =?utf-8?B?bUUwQ2s5TU03TkhUdW0vdWw3SU0wSHhwTmJJSDA3UTVJTk5IM2pwcE1QVkJT?=
 =?utf-8?B?dE02TjRPYTVGT2Z4L0djSXg0akpMQ2laSEVMQU1FRDZaeXJnTW0rMHNPWGxE?=
 =?utf-8?B?aC9QLzJSSUxWa3dsK3dHanA0UEVZN1NrbENvWXJGdENDdVRvbVR3TmhyaFpC?=
 =?utf-8?B?L2JMMVhsTzdLU3lkODQvbUcxMi9TOEJBdlRWTkcvajhHUzVCS3VmMUUxR3dO?=
 =?utf-8?B?L2M2dVlYSldzbU9lOW1ub2lTNVRLTXpzT2RvdVRnU3FRSWJOeWRRbGluWm1Z?=
 =?utf-8?B?bW9tOXU2SmRpTUg3OWIvQTMyOXlQM21odHVOTTl2WjBpWUVJcmJLMHFyN2RY?=
 =?utf-8?B?Y2xGVjdYczE1TndwcmJ3L3lUdUhXNkVidmNkYi9vbjFsdzBtQmFaMU5zWHNG?=
 =?utf-8?B?S0Y5VXpKWk40Q05GOW14QnRrSXVqblQrYzRHcmdsQTFsMVdwZFFBVW1IUTBh?=
 =?utf-8?B?S1FNZ3Zudkl5RE5pcTNmcG1HMGlUTVZyTGRjVDhrU1h1MGFQWEN0eE8wOTNY?=
 =?utf-8?B?UmNZelF4QlhydU9YSVd1TzdTUjZzd1RpTDhyditDMGNxVnBLQ1k5cE1uSE80?=
 =?utf-8?B?ZlREc2p6SGtHbnZjZjlLaG8yMklIaUtzN2VvVXh6ODIveXVBdUZUbjl3a2Zq?=
 =?utf-8?B?czZlWG92SDBhS29kMzA1dzZPQmpPVnI1RWZnd0J4Q2VKS28zY0FtNlRnVDR0?=
 =?utf-8?B?SUFzY25vT0lMRFlDQ1MrWUhBblhYWUJlYTB0dEtvK3Q5bmxhbkQ4dk02Nlpp?=
 =?utf-8?B?YTlYLzdVclBmM0xOMDZHTDA1b2ZFa2xkU0MrZDVsY0RqODQ1d09ZSjZnWUNz?=
 =?utf-8?B?Zk96M1JKQ0trTU12RTFubmlJYUxCbDkwUnNNK2dNeTlpalU5Sk9tNy8vdVFi?=
 =?utf-8?Q?ZX0ecGD1NGUQXvxu5lleamgHMWT2y1LGkKkcM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUxGaHorOHFycnlGbVppQitpL0xqZ3JMNE5QZ3BJcWVOd0RrYng4TWZVWkU0?=
 =?utf-8?B?YWxJUDIydCszd0RLZW81OTlqZ1ZxMXNJbVdPc0FENGNqY0JDUDViRm5nck82?=
 =?utf-8?B?RjlwNUtsdnhqakFTTmRDeUxLMGZjR1dsWFNVbENoL0xzUVhhYnJZbVFQdU83?=
 =?utf-8?B?a1lrQVpHeE03czExN1V1eVgyTWdCMldsVGsxWEVYN0xmRlB0TWpzVnl5MlEv?=
 =?utf-8?B?L0xjMGtPYUpnNUpXcW5rYThaejFqWmFKTmxCd1daRGJ1NVhmWFRMb1RuNWps?=
 =?utf-8?B?MmRGTzc3VVc4Z2ZJWFhxTW05UEFwWUZXRmVuTkZxcnVQUHhaRGk5UW0wMk5R?=
 =?utf-8?B?MGNmb2lQTnZEcEc5clVRMjlSY3o4RFZLNmJ5Z0ZqWlhKZSszcDQxODVhYmQz?=
 =?utf-8?B?Z3NSclFWb3RsTXNleVFmT0NPL0ZqTTZZeSs4TDliODhMNnlRSTFZSVpCWWVq?=
 =?utf-8?B?NGNQOXpFbmFjWE1SQmVFS3FxZC9sMDVZSHcyWWhOOWp4VXgyTDBaMjY2NFVF?=
 =?utf-8?B?b3BtYWhsY2J6bkRjcW5hSnJEbERyNGFnSms5N0g3alE2TEw0M0RNV25rbTdH?=
 =?utf-8?B?ZnA0b3Bld3RKYVE5ai9iS1ZESkFRVWFBZENDK3dxK0dwSDJjR1F4dmo4cmRG?=
 =?utf-8?B?R0lDU0hSRDhmQjFjazBCdUZIem55WTd0SEE5cC9pdzJNd2hnaVh3bVFkTk1M?=
 =?utf-8?B?RkhhNG14bTQyM2xPdHRpZzNZL0o1bUtNeUVEem9YUmlZL3g0V3RVa2JwdkxO?=
 =?utf-8?B?RWNuOFRTY3kydVJlbWRFdGdsMElObkxaOVN2YUdLRW9CSC85T3JlRFlBV0Vo?=
 =?utf-8?B?WHpnRFlSMzRxVnIyM2JNbWhOeUJla2gzQldLaXQwd3ROOFdwRWVGTjBINVM0?=
 =?utf-8?B?dmplcTZVcFo0dXNoSFVoL1grL0RITFpJVTI0RlJpQlRGVW5kSUdWbGJZOStm?=
 =?utf-8?B?cXZJMWVUV09RbkZzck5ITGJIYWZIQnJ1MG5VZU41eFN0WkF6NElLZmdzNGVl?=
 =?utf-8?B?SU4rME12MUxKYmZ6REpwZkdIQ2FILzdvNmhteUI1RmgzZUpMb3V4YklySXNj?=
 =?utf-8?B?Smo4Q0k5d29oZ3VsT3h6L3lBU3cvbldTWjdRcmpybGl4ZFZBR2NZVm40WGwx?=
 =?utf-8?B?WkxVVTByWkQ0bUYwbzRDWERxNm8wNm1wUkY2OFR1K2FGY2pBNTExNE1Ub3Ri?=
 =?utf-8?B?UDJaSUd2bTIyUDkyVkpzYm1aai9TZW5LUzZyYXhqM2xDK2s1NkdrcDhrNkw0?=
 =?utf-8?B?TUlaRCtEdVdDSCtxc3dUdWdVWU1Xd093d1pBdVRIeHFLaDh5N3p6ZjNGR1BZ?=
 =?utf-8?B?WVc1VG5nVHFjOWZ4THJyZVFHK1JudzNaMDNZYXlYZUowSDFuQWl5VGVDTThn?=
 =?utf-8?B?MFQvVlR5Y1JkMkpuZURIQmw1MjRvNVR6dDlhZHAxNGhNNURPQ2VhcWhFVWQ4?=
 =?utf-8?B?bjUvcUx1Z3BPUlJLcXJWMzVkRFpxVkhHb21pOUxPc2V0REJML2d2VVZmZkZl?=
 =?utf-8?B?dEVhMWFkajdUSkpHbFo2ZVJTSXpUQjZVRS9RZWRXVnEwaXhHazI0R014TjV3?=
 =?utf-8?B?eStNcDFiNFR4cnMvQ3JNV1FoMnpWUmdmZU9WbGM2eUtrK3VlZUIxK25GOElU?=
 =?utf-8?B?bUVtODFCNXIvcHNtSlpUQkN3RkRRY2p6dFdDN0J6ZXlrYzBSSTdmRGZ5Q0Ja?=
 =?utf-8?B?ZWs1emJnem1rMVVZUUM2WVhXcTRJa2REZXRybHRQSlRIY1ZmL3lkTFI0aHR0?=
 =?utf-8?B?czlMODFTcFBKSkNUVlRzaytkamVscmtqNEVQemEvZ1BnS3BRWG1yb3A4Y1Jl?=
 =?utf-8?B?aldoemJldkd4Z3Rzc1pTLzhDMTduRVozK1drRi9EeXA2N1ArUERKNkxZUG90?=
 =?utf-8?B?MDFGajR3Yng5UmhCTTdCTFRQakpJRms4UHQyZHFpc3VFUXRheGp6SUduakQy?=
 =?utf-8?B?Y2duaVkxM3FOWTRQRnc1OG5IUmhsMHV2a3ZFWmVnSFNMWmNIVmpOQ2EvWkVt?=
 =?utf-8?B?cC9SZjY5TUNsUlVHNHpoVklpTVA0SVdHcWkySjZ4MmI1R0JmdVhCY0NqVWsr?=
 =?utf-8?B?MlB1UHdHcnhFdHozSDhxWGtsKzQyeStFWE5tdnp1MHFkMUFFSDg5UFZwWElT?=
 =?utf-8?B?OVI3SzEvc2d3Q2JlUHFmVUMzS1lubzg3ODV0cFNEOGptUllocTBhM1NKRC9U?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac798d0-0106-47c7-79e4-08dcd59c806b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 15:38:52.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DvB8sQipW1Ly7e3V0mvxxhS0m81bsKMImRPN3l2w5+pqm9kYiQ80xs/a6g+qm9zkthUdGumgdJFRwYm343TQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3192

On Sun, 15 Sep 2024 14:31:27 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> This introduces a new marker type for types that shouldn't be thread
> safe. By adding a field of this type to a struct, it becomes non-Send
> and non-Sync, which means that it cannot be accessed in any way from
> threads other than the one it was created on.
>=20
> This is useful for APIs that require globals such as `current` to remain
> constant while the value exists.
>=20
> We update two existing users in the Kernel to use this helper:
>=20
>  * `Task::current()` - moving the return type of this value to a
>    different thread would not be safe as you can no longer be guaranteed
>    that the `current` pointer remains valid.
>  * Lock guards. Mutexes and spinlocks should be unlocked on the same
>    thread as where they were locked, so we enforce this using the Send
>    trait.
>=20
> There are also additional users in later patches of this patchset. See
> [1] and [2] for the discussion that led to the introduction of this
> patch.
>=20
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQf=
WIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@pro=
ton.me/ [1]
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQf=
WIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@pro=
ton.me/ [2]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Miguel, can we apply this patch now without having it wait on the rest
of file abstractions because it'll be useful to other?

Best,
Gary

> ---
>  rust/kernel/sync/lock.rs | 13 +++++++++----
>  rust/kernel/task.rs      | 10 ++++++----
>  rust/kernel/types.rs     | 21 +++++++++++++++++++++
>  3 files changed, 36 insertions(+), 8 deletions(-)

