Return-Path: <linux-fsdevel+bounces-25322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAED94AAD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209ED1F287CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5381AB1;
	Wed,  7 Aug 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pBLw2wmY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021082.outbound.protection.outlook.com [52.101.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0904F7B3F3;
	Wed,  7 Aug 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042646; cv=fail; b=bWaWvD/DjODBcDiy1sNyIfYYa+3UneGOSIIKI27/GMgLDfqNb5MOK2g6GbyV1xouUuHvltcbuFjAM1LM/0n2JWUBqz+73WTC1l/W/vR2l0z+RBvJYOob4y1n6e+YutbpiXkxVNd3uswCzH9ozaAdwhjghyND329InMr8Z5wZSH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042646; c=relaxed/simple;
	bh=AK8Hm7tGpPSkBLXddY2U/wIEj4Ln2g8c5LdmXp/EdJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fcZNRAoY5+O6K9acPJVj6ti5VceJl7X0GrN4/foXKDe5YuSewZPk3h3HNdG+XDRROLItZhX2+fADQ2IZ2d3gGZTGcM5Ikm5rlWDatdyjMSPH15zmFQY7XQQjIOz1wQkGI7sxGxY8tFKg8eSdoXmgID76phgTDc+nDnp4tL6dQmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pBLw2wmY; arc=fail smtp.client-ip=52.101.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpJwG+TN/VGStmghV5fSlLJbHxe4M4RdgIru95pN76aGhEsswzj8Q5HSUtM2pCdC4fxFnIrj+8WxrHe1aYI1gMPzkZSrCLVMzjya4ytAeK/sKBZfnDnxCPvawvmOEi6rIGeB00VUwRc8QIFQL/EE7ui42mg1tXc/WSCQkYUN40iZmikQ84Zj8tJ5IZk9ZCio9EuUbg+m4YqIN6gdIjSSvt8y0hVnVfsAWFs1zbWLrMft5IYMeiuhx7jdERwoyCOQ0eBCpHEvgGwwYKhANTyv4/LMUkwcRztafsFganjrzSWuutLSj/K9RO8eI+KE+u4oYcBSO3RbD4HjVW0is09AoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfO3vQAR9MZfaLWtyPC9fREnrWtcxFyrdl07USqhVMg=;
 b=DsD8AJhR7Kt2vKR/cne+gwwOMwHnNYPeIG+57xRNZFmo0sxcnOnHehGdJAx5pQxFavlvkf0ZW5eJYVHli34mAp3jMPOyHOoCulsklGroikv5ko361Kn5EtzCNuPyM6oFBjOxwvUUI9IxfZmkmxIKCgJEey/10jqo0z9gUbC63YosYTd23z4wJz2787RMyAZTVaU3C9sHlyTWUlA3n/1JQTc+8L+EiLdxL03iGLIsw6xc9ShWxHt49BCS/d5NiR+DtKdJA57MbMY91ic9l7l1/xaRDwOHhK3LNt+TVlOhYX5dk7GB6TO5pD2rDT3nCxKqt1T/fjpeI6T5r9D+i9pkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfO3vQAR9MZfaLWtyPC9fREnrWtcxFyrdl07USqhVMg=;
 b=pBLw2wmYtS4wuCREwf/5aKTPftKgGzdVCSRmCnITlTLRv5UHLJFXd2CXz4eDHoOSHsNDPhR5KdxUf+9IzCDsFkJ1fXIaZF4XFvmewcs/DXwdplmlEZ8izpCHil+Fi5A/rUFcE3UNS/nxseh5WsTTC74OjUmc7+AS4ZvHLU30oLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB3452.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:16f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 14:57:21 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 14:57:21 +0000
Date: Wed, 7 Aug 2024 15:57:19 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Xu <dxu@dxuuu.xyz>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook
 <kees@kernel.org>
Subject: Re: [PATCH v8 5/8] rust: security: add abstraction for secctx
Message-ID: <20240807155719.005d9e74@eugeo>
In-Reply-To: <20240725-alice-file-v8-5-55a2e80deaa8@google.com>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
	<20240725-alice-file-v8-5-55a2e80deaa8@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB3452:EE_
X-MS-Office365-Filtering-Correlation-Id: a69b0c46-ec90-4e32-4826-08dcb6f13d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?so+UOBoRZfC2dJyjNllQW96RyEXYqxRmJChuSc4Hw6IhnyKWXr4ADodjxPlr?=
 =?us-ascii?Q?sMF0caKbie2Wo0EBql5ZKPrHWqW6NMWBxQqQVpXLIQYS9Qpq4xE6CvKZrcNZ?=
 =?us-ascii?Q?r8MIxibBTJG+Ifm4GA9GbHo9QXNj6n0AYy3YXfllz+GTXTGwSaLNpohZOjqo?=
 =?us-ascii?Q?x6fQN9A07o8vLD9LLujfXzgu6OXrCcTr32eVGDdZNj4o/sbD653lKD4Vh2Lv?=
 =?us-ascii?Q?l4k2h+U8ZnPkAXGqKxcfGor1PVB0ooMmIoRUvmg1lnxbYHcGgVgECtVQdtop?=
 =?us-ascii?Q?oLDvwetrNI2pJcdKI+PbTjKYPuxyl/1HNEEMzIqQdXZWDxf6Q0aiaSpadVaQ?=
 =?us-ascii?Q?SixEEcAMwGdBHkij4OfcanElauTWEHi9fxElGeLRftGC1Iu9WtEHG30Qolic?=
 =?us-ascii?Q?8kzqV3zaRsa01pr2WJ2JdMzRoTKHkb/86AEgCw9chXmJe64tXxH9WCgphzET?=
 =?us-ascii?Q?HkOFX5C6WQ4rCoxut4SZIc8HrmE30cxl8Gc+V0VjZQKBcAhxlGXZcU3s0HKm?=
 =?us-ascii?Q?O5/GN+zmr6Ikiow1nuxBvA9uidIYed5BAQYKbCJKERAQhx3rCTKVq9SJMAIc?=
 =?us-ascii?Q?/vcQ7Y7c6g3/meKiAKGv9SOa+WejMYfuNzUqeFvhXAwMb79LtDheyXQ5euzF?=
 =?us-ascii?Q?/ewrCVzs5jMlysvoNdxNflnwmuIehG3MbT27yCQXz0AEzV5vUYKYNRDvDOV3?=
 =?us-ascii?Q?TqA4qGRpIdHsArTmbiiGpgUuhtTL6EU2ZfQmqZaNy8pugzCjUUDVBuHaSrxX?=
 =?us-ascii?Q?Z9QPIR+3lWwuL2gArQOPRiYR5HceMurN3qvDiRIA2gqN6WydN+qd/Y0ERepq?=
 =?us-ascii?Q?FtEQJKI7fIg7xMISA01yPqdkhS79TzxLDf1nxvQlMt3dotFhuPHoHoqBc16g?=
 =?us-ascii?Q?+JRNRhRKiOeuuInPgaBB85I/2S869nrAOuFdZvRjaB+UkVjQ1pAoLhjlQSuK?=
 =?us-ascii?Q?5a0q4Hp4Hjl+FR/z2QM3qvluPstZVhJt0d2hDxT6JZFJ7hDx2DEGs0mWgRZF?=
 =?us-ascii?Q?Qxh7tGwbGwJCZNl1dmwa0jLv6S63jMB3IWNrKnY5XJdErqpePg1pfJNyyU0v?=
 =?us-ascii?Q?SL++EDSmAl6EAKcDqb1HJ7Op4vvWorWz+5pxOjfINQ11trVsw0ca/aPln8cf?=
 =?us-ascii?Q?FKJMRVB0IM+T0rdTZenwc9mCtlow8ea2a7/bn45HpLDLc5a286mAplOJ6Wk6?=
 =?us-ascii?Q?vOm2Jn21l9lFvT1WEE6j3EQxmDOMZp58GKWfEEyyA8W6x5N0yL6tqxXZkVXs?=
 =?us-ascii?Q?mOwQ0NvW7DvR7ZbSoRLloXVwfi1UYmTUhjDSB3L/7cRiJx7pMMpCpZuG8kP7?=
 =?us-ascii?Q?iFZf60KB70MpukD8+UsKWeSyUYcoZ05lSNJCkAj35Oj+pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/2iHngz1AMDhh2Zojlp88pfJdVk93gcrkpcJl9rhWl9FaqFUQZLMztpAjbR?=
 =?us-ascii?Q?iIxZZyFH+aJiDOgQBKUyrZKIRsdA1GHBLGypxTsoS5ydS6Nk6NvmZO1LVkWR?=
 =?us-ascii?Q?O//bmBpFoXrcfjOB20Z4Wk19+8YeZ9FCvK3qiKq7c7U+qGUtY9cuo4DdwflX?=
 =?us-ascii?Q?pUEksCfUCUnIuQv7xYOLpkyS4lHcuFpsOqBMvJZ+ysj0DJzGXxs8HxMb3MwU?=
 =?us-ascii?Q?FvIK80sNq2b9aHHlMyBn0f8HkUCXENjaiN4+LE0TIxGtPnLDrPwbblTiNQ5C?=
 =?us-ascii?Q?VOep1iHQtsxE8tGTfLGIA9uO93GM9ltHHL2BovPpgR6nBKP91RnKeV+Itxgd?=
 =?us-ascii?Q?GrMd+5dOYhnQBuluQSzNFtP7Tu2htbWYHRmGCSCorjDLrYa128NeR4LgoU3M?=
 =?us-ascii?Q?RGpNZA1OP6C2p2YxZEmiE8w3Qu/VhqX9SwDj/AQBkBiecrnsnip/7NcuoGam?=
 =?us-ascii?Q?/6NTJ7IuDkZEE09GcZ0eq7xO3557ozy5XZsa0OK1+P6E6haF9dmAXwpwUtJ0?=
 =?us-ascii?Q?HE2FM84WD8uAkR3Yq/KIGIjM6VObSI6VohWiu/mIzdYxktHWfyFk+jrBulAw?=
 =?us-ascii?Q?8HKbVNCcRVB12srq28YxtgozkZBRUgWJJ3gyt8TZZiodkjztx3NV5138Egoc?=
 =?us-ascii?Q?1GGUjRHz6j9RYjIVs5WdraOsl8tKRTwN6pdOg3PN7ENEaBTN2k6fhgFNRZpl?=
 =?us-ascii?Q?WICpdQyHWO1JrAb+xWwyqcbaJCx9y6he3cB9G7j4i2dG4mivgDT9q9Uj1F6z?=
 =?us-ascii?Q?2VaN+vQCrveZnABl61VahLPkWdX+yzCynil32YtAFbCG/3RXMwagSxYsTZoE?=
 =?us-ascii?Q?qwz8+ZEAYHvwl/KImWIUA87ifYioSAGnSBJu4vPiMtrGaPMcm4aGrQ2/agI3?=
 =?us-ascii?Q?3MRHkaNHGOPc35XYv9zmRRyhxV0wP+Z1PPD60+DLRbCfRRHlEXesijcCeCFi?=
 =?us-ascii?Q?Nr2pi5Usj4TEI3Bw07fOAUF+JyvAZQ5a/cyoi4grVYlJKHUul408AveXT4q/?=
 =?us-ascii?Q?Yql/SvSjBmDwsfOIBXpK4VlTmmjFrOOlck88fb9cI4ijptfu8T/TxGHn91OS?=
 =?us-ascii?Q?1NBpYZCHSkRCtwjHtyOxkXNVxnntM4GtmHXAF2F08pG2PaRryQ1q0YbKt9MH?=
 =?us-ascii?Q?CO6XzOixXPFSXEQbk++x2JY6Fg/umDQTKTO21DDMnmhxWRvup516sNUqYaGS?=
 =?us-ascii?Q?ETp6PoIfLERRzDxHyf9O2eAoNdvvTZWIY1KGHLrjUlEK6TKlU344kbPUr2Az?=
 =?us-ascii?Q?NRPjm3RO2DocCIPF30wXOgOG0hf3KoJdIbPeXvJqIfOPgaZl/Y3/eqTnQW1+?=
 =?us-ascii?Q?RJdxMiFuQBSvXviAmlCyu4j6Ay/7ue1R9HXlHiKx95OUZOnoIQDs/SFCwaDQ?=
 =?us-ascii?Q?ERnB2srwrtiXVCyuW1muKlZKmh2yJGUU3yBoTKmsZcqwziHjL0mE7PMjuOpf?=
 =?us-ascii?Q?bgLepGb0SNct/r1hihg5fRePFJds/cJSPc1SWGIdB9IkncsF/yU+UAElA5IH?=
 =?us-ascii?Q?6pwpm+osyXuLzpUmLnb5CiaCwXJoza5kJXSsjSBfEv4yYSwQzJj2oUergG6f?=
 =?us-ascii?Q?ZXYlq9cYaUl4AYwUYkGMxUIxlY0qOOfmuIm9Y2v4?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a69b0c46-ec90-4e32-4826-08dcb6f13d61
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:57:21.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1NbRSnIekYC6rYcjv7aMZN6WtZVAVVCY0lQXkdFr0A/GD+GoXf/gT3CU79BCvAGwlqRkD4sK9BEJaOIIOfQ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3452

On Thu, 25 Jul 2024 14:27:38 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Add an abstraction for viewing the string representation of a security
> context.
> 
> This is needed by Rust Binder because it has a feature where a process
> can view the string representation of the security context for incoming
> transactions. The process can use that to authenticate incoming
> transactions, and since the feature is provided by the kernel, the
> process can trust that the security context is legitimate.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers.c                  | 21 ++++++++++++
>  rust/kernel/cred.rs             |  8 +++++
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/security.rs         | 74 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 105 insertions(+)

