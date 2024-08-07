Return-Path: <linux-fsdevel+bounces-25289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA0C94A67B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70432282D90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD01E2120;
	Wed,  7 Aug 2024 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vnSlHrvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021109.outbound.protection.outlook.com [52.101.100.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC81CFA9;
	Wed,  7 Aug 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028379; cv=fail; b=XRE9JMVcHKzzHolIde9r56tyos4zuTXbB7InmJzwy7zCmNnSGN9QJbpHwahwosO9gOwDoDUvd9NL1pI0EdfhUgAO9wF5QoU7vVSmoAKUQKP40bF9o0PqbzN/VlTFq/ovHfz9QEI1Udub2pOdV527mVWd7ShH4mGFAsmoaVv6zds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028379; c=relaxed/simple;
	bh=qiKPHwylW+hYLfnb/RlNFIni538IXNB/+tLs5O+K8hI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQVme7sAHMR4fuhuArtBmuDo37PGrioVJq0TkMeSbxQUqHWRc8X1IP2okM/8wHpFDrzxgJHRXofS2wnQt9hXA9swgeoZK9jzXXKQnqXF/3tpSAYn/Ue9cvk1mrNkVUEbQS0X1TpJXviXmCUQPbTDPBnHbbY9OOzpkrb5Dyqlqnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vnSlHrvc; arc=fail smtp.client-ip=52.101.100.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iiuil0goLyIamPudlQK30PEdOFQkFnoGrWXzY1ueekoVbXIPcPkJW7eESifsG4wcFOOSnb2x+WztwUlpbV1QTj2n8X7u9m0L4I1+cv1LEmgGAw65xn02P9I1WR+QlzADY/bgNnN0SOxvDUI9w8B8TYQ3IRP7V7vjlG+dcmqcUJbJNdFbEfMyqsecYzCwSa8BlFxytOrBqTM0lUabfTyCF1tpm9zRduXSQUTgJ6Y38f0QZEqSPkd7DvTlWQFjyErCigcKFKBAVUqHHcGVqPNHn4xmK4aH3LFBzgVnUxD9MxRQF9PsxUceWJHNIsjcVOGGRx9ccJQ13QfCTC9pRE0iKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpMoJ/P6duDPhxouqCzBfrenk6VbrAJgg77hI2C7fFc=;
 b=yteNgLWrxuqTGlWFsRkS1264mZ8rF77FIo8BWaBUUmD5TwOJETIVJhiM9aJ+BMH3XEgCO/lf0hfm2V2lKm7x90PMFdpenwqdZrQI9B9/LO2YSIPzYWevcdZ/SMwSm4IUSBKaqW+MvEdmBsoUm/vUNjHzW1ElDIBJ/X91BZDhAftBYAf/rTURCIR49rlVRdE54PfQp0NYIrBI0ndodXVt/fBYaCTPaJRY+YLRKWLUIkZ1ittNKtZJtLuEvWfQ9NemoqBNt7or7v8WvBoVLXu9wKXXo3xQohWA5M5bE2qeXA3yRD4oUU64yaWMqey5zT1CMjjb4E21vsGlyiyi0sJ13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpMoJ/P6duDPhxouqCzBfrenk6VbrAJgg77hI2C7fFc=;
 b=vnSlHrvc9j0tJach7/9H0NLIFEKINP6epM77KoOhXwqTYEvsDcIkN07ErdlhBRVC3Xmho4sxhof+bEK35sv/jjZh4O/simqyARCEbI02P1XQj0/Ufqs/qe+fs1qQsL0OdDhEi/t1iS2QCyDsYYgh9GCy/N1ilgHt3vYZ3y20PHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1915.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 10:59:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 10:59:34 +0000
Date: Wed, 7 Aug 2024 11:59:31 +0100
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
Subject: Re: [PATCH v8 1/8] rust: types: add `NotThreadSafe`
Message-ID: <20240807115931.22e8654f@eugeo>
In-Reply-To: <20240725-alice-file-v8-1-55a2e80deaa8@google.com>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
	<20240725-alice-file-v8-1-55a2e80deaa8@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0244.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1915:EE_
X-MS-Office365-Filtering-Correlation-Id: dc914f96-51f6-4d2b-3d66-08dcb6d00577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWZNLzhNbDVJR01XemxmN0xlTDVXZnhuRlZGOFIrcmZoUHNaT3lnVU5oVlVv?=
 =?utf-8?B?RTRJaldTRTZMOXpnQlhHWHJoNVJQUGlDdGRwdW0zREJZM291bWlMR2E2N01D?=
 =?utf-8?B?UDdrN2IzU2pjUHRYSUpxeUpKR3FrMHZvK2ZSdFpVdXJoKzFDZ1Y0bWZwTHBM?=
 =?utf-8?B?RTdyZHNIVGVvUHg1TW0wUENtTlI4RnhXajFrYTYzYmdKZ0dDUkhwbGhEVWJL?=
 =?utf-8?B?RmpVYW5rZzZIY1NoUy9BNFBYaVFZUVRJL0VYYWMzaVpOdkZEemN2dUhOVFNu?=
 =?utf-8?B?aWhSRlpXL2xuSG1NR0ltOVkwSmNzYVowM0MveTRSUitXTWVHYWFWQURmaklH?=
 =?utf-8?B?Nnk4cHNKL3hPYi8xTURhTFNoWG9jVkczSVRlTHhtR1NBRC9INWVCQXpwdmVj?=
 =?utf-8?B?Ym1mK1hONUltbStQbDVja2tvOFpqTXFvaTdtNkVzcFIrM0hoR0FWTHZxM1Az?=
 =?utf-8?B?enJsZThXOHQyaGFQdkdBcnNiZTgrQTBza3c3Zy80dFdydGNhTTNlRGo2RnB2?=
 =?utf-8?B?SUxCRTlJUndLS3V6TFM0UmdtQ2dmMSt3UjNxQUNaeHJVOE5zaWFEWEwyU1Mr?=
 =?utf-8?B?aFhqT0J0MEFlK09sRk5paCtzTWtvQTBSM3VtcSsrZ3RzQmIzaVBTSExHSkd1?=
 =?utf-8?B?dHM3UCtNRXkrbURjZkgxMVVWQ2lKVDhSdExYQVJYNXUxMUNDekJYdXZjT3Zs?=
 =?utf-8?B?ZnhzL3JicXk5UFJ3clp3cVZ5VC9tNTIydlVvTzk5RFEwQWhaTW1iNzNsM3Iv?=
 =?utf-8?B?T1owZmNRUVlCUXlhODhVNEw4aG5HZWQ1VFdWdHBKSk1sUzR5OG4raHphSnRu?=
 =?utf-8?B?Q05GeDVNOUVGdkl0QUhqWlJybWxvbkZ3Sko0ODJFcHJhN3BVUk4xZ3pIOWdE?=
 =?utf-8?B?VnEzMUFyMi9VaVUyUXpqWGNrRzhkVW16aFRXOE5KbmhzV2k2QjhWaGErblFR?=
 =?utf-8?B?V2ZaOTZrRkRJWmFuZzE1Sjk4U0tkN2k2Y0pJQjhwT1lhM2pWYVpOTHhhREx3?=
 =?utf-8?B?YXNIeXROTFlBMjk0UGtPTlNidGRqZTh5YVgybDkzTklBeWV1V05wazZTbUo2?=
 =?utf-8?B?RElzSmYyV2RYdEdyUXJuMk55OXlCQVlBcXFlUHAvMEhJMlBoVTFmNlNYVnh4?=
 =?utf-8?B?UlpRZmlnRmFXYmMrTWxaOTNaeHZmWi9wcGZhdXVtU3dWUGJpbFQ1MmQ4R3hF?=
 =?utf-8?B?c25abDJFQTN5UWRtVVhNdnNORkVnNWlINllrd3JLQ29xZXh2cWluNHdhZU9o?=
 =?utf-8?B?cXc1RVhUVm1oNUkyR0p1MDFndXM3alVuT091REhiNUhQdXlzV0JPVzZaNTBH?=
 =?utf-8?B?bDJKWkF0TzJyNGEyTzhtM296UDFma3BCUFkzbjFicUlrODNoZlhyK3lVeHg3?=
 =?utf-8?B?Yy8wZjVyU1ZETWNNcGQ4OTMzY29udkk2NFJEY2hPMllYQzRLRUpWaHlNNXFC?=
 =?utf-8?B?KzM1UjEwNDJRd0orY0J1bnBqclVObmtTU1gvV2Jzd2g3SFZyL3oySDBGVmRv?=
 =?utf-8?B?YjRtWWVNUWxXM3h6TXlYWXlPbWI1ZzZvcFlkei9pZ0I3endDRnZ0dXY2UHNp?=
 =?utf-8?B?bHUyZUlPTEV0R1BsaG5MNm9vZkNiUVQ5VEk0UjBHMVBuc1oxRUxyNDNiWDBp?=
 =?utf-8?B?L0tTWmlha0Z2dmpnd21qblVMQ2Y2eXVHeDdWL2l5c0hIcUVEcFpFT1hMdi8r?=
 =?utf-8?B?SGxLeXRuSTVsOVlYaGpYNmdERU9KNjQyai9IZWgrTlJlTE5PZEoxV01xTis4?=
 =?utf-8?Q?JGZE9LXlJ0oh6xG9Pk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVNCbUVlNDdsUW5KMHZhcUZvL0lobFliSkJPU0JFVDB1UkxVVWhwQVU1TnNu?=
 =?utf-8?B?aXlJOUswNEFmZjBPa2VndndKeEVWU3ltS3luS3lENVdIUFhOaEh1UDR5bi9a?=
 =?utf-8?B?M3N3YURwdjFwOTV6L0pDaFFRUVJwbFlzMFRpZ2dWd3hSc0J6ZXpBays2WVBD?=
 =?utf-8?B?Wk5TWThIcnYydGMvK1hDSUFxT01yenNCL0xIZ0JRdkM1UlR0bmh2K3BpVVFo?=
 =?utf-8?B?K2ZhSjFNK2ZCdHF1RWhhTDh4VzlZZjVNT0grZmlBSTQwaWZKb0dMY1oxcWJx?=
 =?utf-8?B?WnFvL3VnL2JHY0xmOWFLdC9ybGhuYmFUMjJYS3FKUFhEYTMvNzlWNmRQaWZG?=
 =?utf-8?B?QWNqeVI2bU9PazlLQ3FqcUhKRzZYM3paajRHYkc3NTdaK0RFbVJlY05MeCtI?=
 =?utf-8?B?V0x0WVJucy9OMEd4b3h4M1VESDN1c2VwZzEvS3NUN1piSVgvUXVjdEdaSXZS?=
 =?utf-8?B?cWROaG9IRjJkWFBBdDZYR2RYdnlOV1U5RUg4MkJrbzhpejdES1FaRjdqb3cw?=
 =?utf-8?B?NTRrRGVIa0RVMmF6cWF6TUNZRk5MeVo3ZlMvY2s4aWYrU2ZzY2tCd0syMEVK?=
 =?utf-8?B?OE5KcUJnWURIb20zQ2xQQWMvQTVrWTN6d0FicndmNHNRNnlaaXFJcUlMb0Uy?=
 =?utf-8?B?OWpIL09PWjRzL3ZrMUhDREtJMHRqTENWQXVKcFN0TkZhUDc4R2xlWmtnbWlP?=
 =?utf-8?B?THZEUUgycHlQaURJYnNzQWN6WWQrNmVGZHE4SzlWY2M0b01aeloxZ1h5WWVq?=
 =?utf-8?B?OTVtMmRvMVBtOUI3ZWV3RmVoMklQT0FYMVJTdzhQcFVPbmVQcWd4cUtMZnRw?=
 =?utf-8?B?SThmNXZXd3NOSHNLQUQ5QXVqcnpaQWJqeUhFN2pWSWh1U2Q5SVByR3lhTlNp?=
 =?utf-8?B?WlZXSDVKT3FaMWhlcWM0MWs3SDdxd0dVUHpkV1BiZDUyWlJmT0loMmNwRGt4?=
 =?utf-8?B?a21wNEZEWGp5dks0SU1JcEFQNXpRdUM5dnNwTmRqejd5RXIrVlE4Ty9LZVRL?=
 =?utf-8?B?VllITGI5RFpxYTlsZUlqN3Y1cEV0dDcxZzlaeTA2ZG9aZy9FdzBMMHNUVllY?=
 =?utf-8?B?MklHVTlnMk9wTDJ0bkUzNGJRZ1NKTU9ZTzBTYUZ1Mjk2RkgxVG5RNG9qcm5V?=
 =?utf-8?B?Z1pLTFpxY3NBS3FBYU85YnErNWxBOUQrZTZ0TmVMQUFLcmJZY2tnYlFsb1FZ?=
 =?utf-8?B?WE9XZFpuL0xXWXgwWk51ZXBvQ2JsSXIwdXo0dHUyS1YxQ3IxSlBqa0ZaSnZ6?=
 =?utf-8?B?bXk3YW5SWEo4bUM4YzdEbzFsMXN1S1EyNkVNeStPSWsrNWx3K3ppN1BzN1RY?=
 =?utf-8?B?ZnJIaFE2d04rTThyZ3JjbTBNMDJxbkNpMXZNMitCTmlYVzM4RHBEdERBVmxm?=
 =?utf-8?B?UndiWVh5U3hucURraXRDOEN2enZ1aFZLYkRhakgrZW1sdExkOC9ZQ1N1d3RV?=
 =?utf-8?B?aTVxRWg1MWswbXl3dFk2dzRPWGhmOGRONldqZDZCNW8rMEVaYk9sZ1kxeitM?=
 =?utf-8?B?ZGV2RkxiNE9SNGZ0MXZTd0YxOUc4eHJ0U0tpWTc1cksxQ3hObllGd1JaNFc3?=
 =?utf-8?B?NEphWnRwV0d2Z05FMTlOWUs3UVdIN1lrdnlXb3JxL21kNHpseGc1SUdDZ1pD?=
 =?utf-8?B?ZUdJS0lRbEpjVkNCQ3FRT0w3TmZ4MnZlbzBqVHVoRW51cVE1YWl6djVDeU9l?=
 =?utf-8?B?ZFZuVmRKbEg2RFp2ZkE2QjB0UWJJaVNHRDd4c1paZHZydXdjMEdLTkZoMGx1?=
 =?utf-8?B?SkdReVo0Mmw1MjdCS1p3azRwYW93OE5NbEZjdXBRcXpZWlRhTlFhZDRtN0NJ?=
 =?utf-8?B?YU1sWUxyNS9KQXlwNVZVYTR5dTdGZUYwZVlpRzVGY1JyQ2ZXS3JscmRKUzVR?=
 =?utf-8?B?blZBV2dOUHIrT1pZWk5WTUZtTXBXYXYwUEI5Y1laWGFNM1o0M2xOdXJBSXJC?=
 =?utf-8?B?dEdsQTNkNWxyZFRFbHRLb2RHQTYzQW9UOFFmQ0ZxMUdXNTVrQ2dUV1haWW9j?=
 =?utf-8?B?eGU2MXdWcVRDbTBISlFzY2VFeEZ3NTg4WVdpck0vZGE4bHhlOVNkM2tzU01j?=
 =?utf-8?B?S2JGVHMvcFByaVV5T05oRzJucngra3lzd29BaTZyRXNsaVArd0wzVFllclhq?=
 =?utf-8?Q?bor8KvkuctzoUSB8d4Q5KLUhs?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dc914f96-51f6-4d2b-3d66-08dcb6d00577
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 10:59:34.2282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9wDcB62Vnf7exEHOkt2Ks+3N0pbSqdERWLKsJdxYnB6LApVKAon/wXWKNhka5wS33xPWvwxOM9bOuDekArbSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1915

On Thu, 25 Jul 2024 14:27:34 +0000
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
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/lock.rs | 13 +++++++++----
>  rust/kernel/task.rs      | 10 ++++++----
>  rust/kernel/types.rs     | 21 +++++++++++++++++++++
>  3 files changed, 36 insertions(+), 8 deletions(-)

