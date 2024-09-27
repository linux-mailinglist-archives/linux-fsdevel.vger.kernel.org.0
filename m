Return-Path: <linux-fsdevel+bounces-30238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4A988254
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8851C229D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A581BC9E2;
	Fri, 27 Sep 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SnyHwP52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021132.outbound.protection.outlook.com [52.101.100.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B4482E9;
	Fri, 27 Sep 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432429; cv=fail; b=WGDZQk7uPsHNo0HWntqIX+D3/qY3aa2yfPdmeCOuJLZqJmfgqe8zhX8j+Cxjy/eTGtcDsskgE50V5br2PCbXl9gJGtAs4b6X+zz84QDwUukhb+ixv8deVSEY55TPX8xEfLMOc6F806fhlDJ3s5rQe55gwry+ju8OdU3xlvsPS/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432429; c=relaxed/simple;
	bh=Fwu787qUw5ijadhzrbvyynMAwKBuylutKSj3Lj8vnrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oAD0CAOv+uvoMN+AFxr0JRN+v8sRT39f8p/jsrGKUsd8lLkcKKZSazzG9EYwUQqJ0CA83UT8iX1GKP+1Up3EfOdVdg0JWtxhH0RFpJSfLfn+klKJOv4mxEjums56pvAoudboyl9Wg1abYGAk90694GMDWL6y3RQhKQVw/ZBA4/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SnyHwP52; arc=fail smtp.client-ip=52.101.100.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BixxjOkHR0A8TClZnjsVL/GpIcwfaEDWyOhenrHHjCU00pVZkhAoizlokkY+zkqWWy6eKvfTbXdI4lh8SiKSzj8lmi/lptD+iqc+WVRzu7py11j1xnEtpSt9YTvk7iO6b6EvaOnGd0HWFtL47EqDdWeRofZ/NYIk83NmIRTKWbLhPXEme1YUbHpIILyLgxYAfdfyRNn7G9fog3P984e8G2CVrq5530QA48rMWk+i7Sn3U+JwuCSR/zlA05CY6O8gDFHwJMBMM4FihlqXkuLt7rOpVe4SLzNXRvZBBP5WXF4gUIp6BPJjCMaXyr1R7b+jfk8dfPfRou0Hlj8dI8h3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQxFLM+ls/Fgt8a2aA5DmA3o3rvSiDnUSSoLi9JRqck=;
 b=R/Pcpo8Ff84lkShidxFHFeUdJ7/I1cyQqcQX13cR4rwlmhTXchvvbL98G0MVRNsXIF4d88KK90ODqp0Uqh6LrX3qGIZqp5mzR37t9fcXP50KElWz+9Zjwz7a6o6n1uUqwdndBz9b1lmgO49J5V+IsJiooxpOCu0m3j0yrlrh+PoT0RCjSazUks5T5aWcwqaGfOqPhFjCirmQtzxpfWpu1JmhxowQBrH4XEhwBOBy1qGgMK5RGWlMf+IPi6MPu4sSRxxu8aMRqu5JzVXTxopf6Ukhb8bxKwUtrh+sJ/j39laPphp7dL07MXsI7VlCTmRNHRa/d4tn//+R1O4uRqubvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQxFLM+ls/Fgt8a2aA5DmA3o3rvSiDnUSSoLi9JRqck=;
 b=SnyHwP52cUBkTw+fhSwkTnPRuz62HMNC26a35QEzzlrd1u64CZRexwgm5S7gJHy6AKIWFIUCyflLfjA7s5nOys92L6Bi8UL0BluUN1xK17Gp4bc5QYY5cyJBSTk/kUhdMX3Q0CspR1SEqU2+neOgrdfdkePw0owExJbXoHG3Zog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB2794.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 10:20:24 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 10:20:24 +0000
Date: Fri, 27 Sep 2024 11:20:21 +0100
From: Gary Guo <gary@garyguo.net>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, Miguel Ojeda <ojeda@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?=
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
Message-ID: <20240927112021.051bcc6a@eugeo>
In-Reply-To: <20240925135904.GA654417@mail.hallyn.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
	<20240915-alice-file-v10-1-88484f7a3dcf@google.com>
	<20240924194540.GA636453@mail.hallyn.com>
	<CAH5fLgggtjNAAotBzwRQ4RYQ9+WDom0MRyYFMnQ+E5UXgOc3RQ@mail.gmail.com>
	<20240925135904.GA654417@mail.hallyn.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB2794:EE_
X-MS-Office365-Filtering-Correlation-Id: e935ac02-2b5a-495c-dd81-08dcdeddffc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S202dnlHZlRDci82OGZyV2E3R0dXLzdKSkkrY3UwdW9HRDlyT2FJMU9qRTBG?=
 =?utf-8?B?TldXUDQwcUVYTEI1ZGQxb2ZBYlNYS3h6NWRUZlhlZzJzSGRmYVhiMStSclJ6?=
 =?utf-8?B?eUw2aUJ2dWdGcmdPeENEekxQYjZsQ1lJRTRuM3llUDR0RVd5c01kSjRlMkZF?=
 =?utf-8?B?UE5CYytuWTNURVBWRkJXeE9TUVBEL3lxQUNwRU1scWxweU5hdHpVWk5YNjVQ?=
 =?utf-8?B?bGlmZ25YSFZDVk4zWWRSWE9yc29VanNHdnd3K0FDOUFjTWtQS1pVN2ZsK2k3?=
 =?utf-8?B?NjFqajR1ZHhvSDhsRWt6SlZIdmRjS2Z5dlgwQ2ZHem1wQ1JGa0IwWGM3TC9q?=
 =?utf-8?B?UHQwMU9FL1ExMnFiZmhTK3d4VGlUdG9rU2V0MlBYQjU5K0FQQmNlbFJGb1pW?=
 =?utf-8?B?b2srWXRZN2tWNEMyb2s5TG9BTGpVN0dveElldnNLOEUwNWVkZXlpOS9MRER2?=
 =?utf-8?B?Q29lOTcvSGt5cEhhMDdYbThnUjIwYitBT3A4NTFUK3RNWDZiVGRiZlhZeGVY?=
 =?utf-8?B?aElUUCtTYmN4VmtoUlYvZUpkaUNzOENJb1ppUng5RU56VWtCY083Ykw3TXND?=
 =?utf-8?B?TFVEaW96eDBMSFp0U21CNXVyNENreGU5aXRpQmJHYU1helRJOEY2N1Nhb3Va?=
 =?utf-8?B?VEdxcG5sSGtUMUwraE9Sclljdyt2RWV6ckJZRTVPdlZsMzJQeXd3Q1Y1VWFO?=
 =?utf-8?B?QjlHakNqcGI2MkpIMjNVNzVsZzJXaXNDSzg0TnBzaFVqMEhEbXY2QnhXSDFG?=
 =?utf-8?B?UDFMc1NiT2luaTNBdU5lWGE4RGdwYVRhdS9PcDQvT2l5WUZTTUI3ZHcwenRv?=
 =?utf-8?B?c0U1RkVtOG1oMHQ0NHJ2Q1dOcWFJcWFWRFh2KytZRjhycHgrMGpORUpUYllX?=
 =?utf-8?B?QVQ2eDZ3dXVadlc2V0I4WlVvM0FybERIS1E4WkpMdzUrUHlRR2R5MG56dHdI?=
 =?utf-8?B?NE5XYUVoNzIvWVhCWUVGeXNDMHFaT2pDZ2M2WVFqRGxna0RzUzloUDFtVDAr?=
 =?utf-8?B?dE9SMDVJbjNXMEdwS1ZJRWxJOVN5N2szQ0FVZWJxOExoS3F3Z0NuZG51NEJM?=
 =?utf-8?B?ZjU1cnFBM1RYMllNWnB6dVJpbW1nOXdSS3RnT0QwZ2lEd1FoNjNvd3huaFI0?=
 =?utf-8?B?S1FuQUtzYXYzR29nL2tlV2VmYTU4M2hhbVhNZjVFTWRvQXNMdFV6QllUVnNa?=
 =?utf-8?B?QmowRlAzZWZOM3JhcjRTcjFyWTZpQkd3MDB2U0VKMmhuWGFkV3lYMjJQd1Rs?=
 =?utf-8?B?Zm5CQjY0cmZvbjE5OU1HdWxVUmgzNnlWNzlvOG00V0dPb2crYmJXSkRiSzhr?=
 =?utf-8?B?b1JjaTRhZVloZjhMZE5JeXdwK3NKallIYXJQWWg4b2c0M2h3NHBSbkJrcnFG?=
 =?utf-8?B?d09uMGJHdHd2QUM1U1hqZnAwTkhWQ29sdWMzc1hKVXdDSnhSRXduZ2RWUVJi?=
 =?utf-8?B?ZWRHeGJDbnRrTkJHVUE0enB5RFVGVHJoVnBOcVR3cE4rbGlGMzFJampNT0hH?=
 =?utf-8?B?Vm1ZUEkwbVJZaStoYTM1Y0E2eVRKS2NwaWFNUzhpMVJuUzB4TEZaOHhaZ2Y0?=
 =?utf-8?B?UTR2MGZRc0dTNkhBRzFwNi9tcGo0SXFkVVJGd1BudHBxK0FTalpqTkdpSFpa?=
 =?utf-8?B?ZHNsUVdPRE9JSnVORlFwVnUzUllxdmVCdDc1eTBaRlE5c2l2YkMvVkdHWTNM?=
 =?utf-8?B?VWp1c2JsYzFoNDg2N1dIQ002dDZGQ1l3N2ZCdkNNZ240cVpyNlMxd1dEZi9U?=
 =?utf-8?B?Y3lpWnpuaWI0VjZNWmdjeHdaRVpyeUNQRG9aWUk2ZTV0S2QvSTFlNENzTXRv?=
 =?utf-8?B?RzNaYlkya2paVGdCQUVhUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3U2eEY1U2c4WVVOTXpEMHFoZ2VZUTZtVnNrU2xsbmJmTC94MUFjOWJHQkNQ?=
 =?utf-8?B?SmRXbzNrb25BbnRGMFRmNEF2QzNOVDBKT29Fb2VCeEdIQ1U2OHdJVDJEY1hq?=
 =?utf-8?B?NCtrNlZybzN6cHcwTXlseW4rdURHU1J5Z2UxUkFITTN0eHI3TU4ySFF3Y0Q2?=
 =?utf-8?B?SlJ5di9pbGNMWHpxWk9pS0ZnOWpveEo0U1orVUNwdkZRYWxhOWF1ODhQaHhs?=
 =?utf-8?B?RzhPdlJ6YmxETFhmcUdJSmsvTkdKSFBoUll2cmFZWnBRQzM2c1FSdDgyMkFR?=
 =?utf-8?B?amkrcURLdmEwa3JEaFVSY0xFUzlyZlJZNWZxdjJKMi91NVNTSWV6SWlVT3R3?=
 =?utf-8?B?Vi9CUmFUWWRtYUpIY0ZPSDlQUk4rV1dCYTliS0tkVnFYNmtkSnZ4dzl0Snlq?=
 =?utf-8?B?LzVKcTdVSHlHeXk5VCs5dDRlMGMrMWxDNSt2QVBDS0hlRFpiTW9VL0ZGajMz?=
 =?utf-8?B?endGQ0xyeE1LUVNvUzdiZnhkNjhjVGxHUkRteFZCQmJrenorRlo5dTdrOUVH?=
 =?utf-8?B?cGpSSWE5MmFkNEJaQlNVd3BnL1MzbGxJUmZMNWZUS0tKR2tLMkk1MWpZMmh5?=
 =?utf-8?B?SiswQkNkMFZOSjNoazZsMnJxTGkvKzRoTHBLVTcwdmExSkNtR0s5QlRjeUto?=
 =?utf-8?B?SlgvY3FjV1lkK256UUNxNW9Bd2JhWE5yMkdpaWI4UE5sa1dVYS85YW9UQ3I4?=
 =?utf-8?B?eXE1WTBjd3ZxWXdaUkpMQk96UHdvYzdXM0crMVpoM2RETnRpSEhEbjAzck03?=
 =?utf-8?B?R21BOXR5Ukdsam1HbEU0d0FuMEZwbWhmMXNGeDMxU3JtMzM4aW13YkgvZW4w?=
 =?utf-8?B?UFlDMjNjVUxMYmFZVVE5RXB6NGhhSk9TMkxEUHNabW81ZDMySFA5TGMzWFF5?=
 =?utf-8?B?RTBMOXh4aU9HazNKNXN5STRjQ2pkQ2VYVmU4TU9VUk9nQndOR3lZYmVMVllm?=
 =?utf-8?B?cmdlQ3pnYWhxdkRqdFNEUmQvWWpSUEQwV21oZDlrTXk4bmxWbmttaDRQT3Nt?=
 =?utf-8?B?Z0ljUUlZT0I1VnkzQUhCTytYUHFqREgyWVMwVFpEdCsvVm5ZSDV1aFdFeXNk?=
 =?utf-8?B?Y2pmeUl0VHU0Wk1mckVCU3RxVmFWTk00SERBWUFyaUJUR09jUkhyTW1WaTRq?=
 =?utf-8?B?Q2pPSm5SZ2JTYUtMa1cwRmYvUnhnMW5OUXE3cm1ZMk5lMXJuYiszZllCZzNK?=
 =?utf-8?B?YU8wL0NoT25PbzB1Z1JkMWRmNS85Wi90dmJ2b3lqdzQwcndKN3VYLyt5V3gx?=
 =?utf-8?B?a1pmU1dIb0ExdzRxUGZsaFZiczZmK1d0Y0cweU1sQXg0Rmp0dytzdFRrdUJ0?=
 =?utf-8?B?M0I0cDI3b2M0UkNPaytHanV3MlhEQlJvbXB4QTdZUlcrZ1ROc09PeXdta2ly?=
 =?utf-8?B?VXpZcmN2SXZuaW4zSXlOekt0OGRtN3ZiUFIrQWVJQzRRTlMvWHZmelozSThT?=
 =?utf-8?B?eUhyM3hqdk8wTXhRVWNtcVRmc3A3ZGdzMkZYbHlhVVhoK0ZGNlRsVU5nZ3Aw?=
 =?utf-8?B?YXJYb05kZlJnbUx5ZHQ2M0FFVVhXM3VVdXpxd1k0MmRTelVCV1ZET3BnTklO?=
 =?utf-8?B?RWFVaXlJZWJoUGVSZEdlQmZlRzdiTmxDUXBEM2tWV2FCVG0xLytzSXRnakp1?=
 =?utf-8?B?VEV1MndPbWY3MTd3NXFVV1dKS2poaWtzNEF6SmlqbmQ0ZjFJMVJGZ2E2SEVn?=
 =?utf-8?B?VGFJVVZYSllMWnlEU1dxUXpEbS9tMnlaak5CTmI3TUR5TGdXVDVIek1NN0Rz?=
 =?utf-8?B?TnRUbi9sdXdIdytXZEtDaUlyWkJ1WVpHM0xqRXJoNkEvd1dncllvTUlCR1VV?=
 =?utf-8?B?T3Z2WlNqNmNhRVBjS3dwZitwWklCdEV6LzR5bTdaYzFYZ2pqT1M2Zkp3UWha?=
 =?utf-8?B?eUNaRmpmVlpMbFhWYlRJa0VIeDhmbkpNdEJYYmFHYjY2RTNjTk1aWVJPaDJq?=
 =?utf-8?B?MmJ6TDN5dkZVRDVHckYwTndJdXhmVGltSDk1a2RlUDh5MnlTWm9Oa0E4dGR0?=
 =?utf-8?B?OHVpUDgrMWdnMktQdWNoYkN4d3hLS3NYQjRnN3ZXTEhteHdIWkQrb3pwV2pC?=
 =?utf-8?B?QXJnN1FwZVpRT2tjcGF0OGxNdTdYK25QZUxIY3lrMGxIQjNLK1liYUNMYzlJ?=
 =?utf-8?B?Mk1mRVpBaXBUd0RFbm5KNlhnbkVvRUJmUnRGbnYzNU5MWnB3ZFhaa2pETzZT?=
 =?utf-8?Q?VF2YCMuucPMNgI0jcc+/6MmLBsNzsSFby/NPW6lWFROe?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e935ac02-2b5a-495c-dd81-08dcdeddffc2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 10:20:24.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L6BJ1ZfKfTd0BovxnxXKI69fewqS/+lQ8VFANLuST+nyZXJYr4jyK0bzPW1mdsq8SMv2oBxy8bSPyRzrTIYDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2794

On Wed, 25 Sep 2024 08:59:04 -0500
"Serge E. Hallyn" <serge@hallyn.com> wrote:

> On Wed, Sep 25, 2024 at 01:06:10PM +0200, Alice Ryhl wrote:
> > On Tue, Sep 24, 2024 at 9:45=E2=80=AFPM Serge E. Hallyn <serge@hallyn.c=
om> wrote: =20
> > >
> > > On Sun, Sep 15, 2024 at 02:31:27PM +0000, Alice Ryhl wrote: =20
> > > > This introduces a new marker type for types that shouldn't be threa=
d
> > > > safe. By adding a field of this type to a struct, it becomes non-Se=
nd
> > > > and non-Sync, which means that it cannot be accessed in any way fro=
m
> > > > threads other than the one it was created on.
> > > >
> > > > This is useful for APIs that require globals such as `current` to r=
emain
> > > > constant while the value exists.
> > > >
> > > > We update two existing users in the Kernel to use this helper:
> > > >
> > > >  * `Task::current()` - moving the return type of this value to a
> > > >    different thread would not be safe as you can no longer be guara=
nteed
> > > >    that the `current` pointer remains valid.
> > > >  * Lock guards. Mutexes and spinlocks should be unlocked on the sam=
e
> > > >    thread as where they were locked, so we enforce this using the S=
end
> > > >    trait. =20
> > >
> > > Hi,
> > >
> > > this sounds useful, however from kernel side when I think thread-safe=
,
> > > I think must not be used across a sleep.  Would something like Thread=
Locked
> > > or LockedToThread make sense? =20
> >=20
> > Hmm, those names seem pretty similar to the current name to me? =20
>=20
> Seems very different to me:
>=20
> If @foo is not threadsafe, it may be global or be usable by many
> threads, but must be locked to one thread during access.
>=20
> What you're describing here is (iiuc) that @foo must only be used
> by one particular thread.

"locked to one thread during access" means it might be `Send` but not
`!Sync`.

What Alice has here is something is neither `Send` nor `Sync`, so I
think the `NotThreadSafe` is a good name here because it cancels both
guarantees.

Best,
Gary

