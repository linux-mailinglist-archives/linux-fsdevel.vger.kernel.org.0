Return-Path: <linux-fsdevel+bounces-78843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M+WC6o+pGkMbAUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 14:27:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A43221CFF2C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 14:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355B030210E7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD9B32E126;
	Sun,  1 Mar 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Se1ukJx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020087.outbound.protection.outlook.com [52.101.196.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7431327C08;
	Sun,  1 Mar 2026 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371582; cv=fail; b=UMwFC0mH7u480dXCk/+DWz0DqvnUXhnZ1rPUXs7Hc3vtFFvDooa9gRI2dKsTrV2iC6cK+8Odr8az+D8dEkkmScV7Kg7JtN/28hhcgoxwQCFTKeysHefKZZ8u55AAwuBMVm11bPsTSIXpvCRqV6hCB/9vg6BGkHl2LIiKxXWM1X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371582; c=relaxed/simple;
	bh=SabPlY97MDTqwed4UL9138Wiz9nWMG0T+S9M9FXSUfU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=CNWWVbg7sQl777fehl5u3KFA6hkfbx4Fo6vWO622ydYOcWFJ62hLjQIz7NKxBJrVm/7pxqgT8KbJ6motmERBZo/NYbZLuxZdqFOyqmMIJiMYtnNp/UK9UUwo5gubhUnBOquq4SgXkwO7/emvVie7vtuxwHoI7p+NvigqqWloVnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Se1ukJx+; arc=fail smtp.client-ip=52.101.196.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Az72xLEE1mi1Yj3AyQQTEtLaJLa080h2nKM9DWz6/MsqtuOQpdAGOfzZOpYPvPGSTfsaNHYbHRCCKrgmnFUxjaOx/8HGfRgVUNBORgS1LT50oRmXwoYWomngBlU2FNx8rnFS5oO3M6r6IkE7CGk+PrvecGTmZPe325LF9+TZWx49m2+MJbHAsqW9a1e35+f1zt79gs+SfYeDToR317UiSxEi5gwjGk0/oR51qw0uCxzyYf/QSO3IAmyAajxsvz8X+fdYtQS2YBip9wahY12klW2boWXrEVt5TME7oALkqut1hsUtsDHXLJnipHgn+Iry9jDOmj168URXfHyX1ABHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+g/lR3Xw+DDAZVO+yaZkupin8NEPozqTdB7sa1zk22o=;
 b=RXX28GDABlICIVLb/gQRRaLk9bzTZAzGyeLsE+s5Nzf38fBs4lvCMvbVwzWNvydoL5347MfTmLWr4EUKKypFc/wS05HcPW/sj5wYQQwuapvTuOgUANQH8ezP7c3Cp772GnpBfZB7ju1aXtv2MQTcbDkiLtZ1B5c5W+PdIXLKlHMAFGvD0/tyieEbBjpYnyUCnoNf5Okpko0IVSwn1YaXBLb5pD1RXL6ZmIFPACNpPIXYwSv7oT0FrcXbO3ftAVZu5d/PiKtoKk5/izek8bYWqzN3QxICpU7BB47ZAYon7E37UwKI2nRml+pVPbZqWSgLBQuNxgTDIdnp5EnmFaRWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g/lR3Xw+DDAZVO+yaZkupin8NEPozqTdB7sa1zk22o=;
 b=Se1ukJx+SnZ6383OleWh1YOxUyT20flP5coJ7KnwOMfJA2FWYg8gqKhtsZ0UOxhRAbfYeQNI7u8cX00qTC5VNWpIX28RRol92tV0ikjdnSQODmJhJipv7uZbRdLEFqaXL15NZgppoP0ySbVlZYZCiuDv0dAPolBO2THA7DtNoOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB3647.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Sun, 1 Mar
 2026 13:26:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.015; Sun, 1 Mar 2026
 13:26:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 13:26:18 +0000
Message-Id: <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Serge
 Hallyn" <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Igor Korotin"
 <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Vlastimil Babka" <vbabka@suse.cz>, "Uladzislau
 Rezki" <urezki@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org>
In-Reply-To: <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org>
X-ClientProxiedBy: LO4P123CA0480.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB3647:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8fb033-a2c8-41cb-d0fa-08de77961f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	GFWpL0xljursFFSK8xcXUJ2sfAMA7oOgG1HLu+Y9yQ75CSpN3sglPzNhOWKJFQhZIAfyGiiQNnfbKngNKutvH7lV+iJBKftqjpl995oa/yUYkWnhcT45IOEKgFooy+10+885xQwXr4HPDigRDjsRtzP31CsTtDJt7E9TCr/TyVpIsqZj7G6OJ6LMxIpbLT8+gyon7g8i7aw8s+Wd91QRvH2QIvtEYUevmAMfauYAYIAAJ/Br82alsghHrsp3fMmsyHfyr7mvfKIEAU+qnCq+TxgfUrMipRf5/Yp3f0S4NDK9lOXFSluxTpSu3wFIjVK6sH2T41wkJ7l0WVm2SHz30PZmHH4IC7RFP7vKqkKna0YPs22pgipCoyRdwConIsPjHtR/PCcCuf1t04WqLFFwYEbu+b7GdPsPuLE99YHpXbfXK15HGzUafp/nDja53rZhmf+QNY+FI9G4stFPVgFfzYlQEFf9IFlRCkWicCgXg4SHmzHT4bvcL53htScU2Jp4Nl9SrCW957rYVek2+ilN1QTJ46iIjRxV6XVrN4/sgOBeO9USn644c8SmmRJBmFF/5dvoxtf2x+HLOBdg/RQdhA5zrK35hoSqCew+wr9T9It9yKUve+vFgyfRVbr+3GwDobZDdo2Jhbea9MrxAeyKMWAXBJmhdUDdwP2lisS2HMFj5dUEb2+ECSX/oKE8I6yfFhwOdiFn3BUBVLpWBS/uhmpstCv8y8ERb+g19Ib2ucnnjWgTxYmosJQYk5J9hHVQKluvh05HtaeF7djTal8C/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWpndU5VZ3hEZXN3eVp0S0RsaU1EcldlLzJxS0JoMnBSWFdZd1A3b1M3ODUz?=
 =?utf-8?B?NnliNjd1NElrOEZBak5ra1hYVUtVelhKRGwzaS9YejJROVkwS25UUzhEcVRF?=
 =?utf-8?B?TThoMXV6Z2FhVURycG92QVU2QTJsR0ZXNDZkTnZGUVNwbHdneGIwMXdMQzhQ?=
 =?utf-8?B?dDgvWm4wLzduRUQ3Smo0aVpLZ2d6c0xJNTQvdW1BL1NtUHNreVBONG9SbmFM?=
 =?utf-8?B?OUZFd0dSR2hkWm5zMDhmNFZwc1BBVUg0QUZ5TmFpUlprM2xBSFFydUNrV3Nt?=
 =?utf-8?B?TmpSYjk0Y21PK1FFQUgxVHcvbWtWdzVOb2MvUFJERkFFK1dtZHF1RGgxSVRl?=
 =?utf-8?B?OUx2MU9ZN1VoVHgzbGYwRll4OERRMEhxZUlYVzBkV3NMTFRKUk05TVlLdEZ6?=
 =?utf-8?B?ZUE3ajAydzVkVEFZcGp4bXQ3TzhpSDhGS0U2UGZSZklVeFExVlRta2NjOFlD?=
 =?utf-8?B?ZnROVGRZUlpHSHUzcTQ0NkFOSG9WVi9Fc2tScDlEUFlINWR2cDBoejJNQnBB?=
 =?utf-8?B?TnVnYURMQm5jM2hraDNNUXQ1dkFaakJGTS9hZ0Roanp6U3dMczFzeDd2OFQ3?=
 =?utf-8?B?dllUcFdBWXVvNXFSYzJJQXZPOUd5U21icU5CZTkyN2lnTHFDeGRwVEFnZHhJ?=
 =?utf-8?B?Qk1KTWlhenJCbmJjWFUvd1c3UFVvYTRvSXVOR3E5VW5MYkE1THlVZ0UvVlNu?=
 =?utf-8?B?Z1VUaDJRQngzU1BUeS8yUDZ4ZUJrZkN6UUY0SnQ0eVJjUXpwcU0zTG9NN2tU?=
 =?utf-8?B?TURZRVJ0M24zSFdDNW5PWWF5Ry8yUk1LZXZVbHVuTkNjQmlEQWRNdFl4Z3Qz?=
 =?utf-8?B?QmI0TXdPMFpoaXJoWEFxNkIxZzZrbWtLQnkxZXRldi96cm4rU0xQaHNXNnZa?=
 =?utf-8?B?aDdkeWVGR3RFdGpMUytvd21pbStiUmN1TDU4T2FBR0dveHN1aSswQUo4NEtK?=
 =?utf-8?B?cXhabllXNmNubnpmV1Y1VWkrc1JJOVU1OEFlbVQxclU5YTQ4YkV1dG0ybjlG?=
 =?utf-8?B?YmQveGhCZDRjMjVqckdIbUQyMmVOV1dpT1RId3BoM1NwbmJpLzRrR0k5RmdK?=
 =?utf-8?B?MituNklHMVE4d251S3ZuSmo1NFJSRDI1RWVnZHRTeHlud1NzZCtoWTYzd1hR?=
 =?utf-8?B?blg0Qzg2NGJQakgyK2w3ZmtUaFBzVUNCMENMZzVkSENzYm9KV3ZyWmxDMlla?=
 =?utf-8?B?SzlvZUJOaENPNHpENkdtREFlZjNiaGtmWXdCVHd0MDhRZUd1SGZOQU12ajZJ?=
 =?utf-8?B?OW5STjY2aW16ZWNKM2pqTHpoeXB2U3RFRU04aVBMTFhnUCs1NlRpTlVNMXJs?=
 =?utf-8?B?dU1rWEZLR0J0UU9wcldPMkpCTTVINk5Zbm1HdTFxTUZvN3pxcTlxOWlKRHVV?=
 =?utf-8?B?ZHozSnpnWWY2eEtDSXNVUHlEWEYrU0tHS3RNdSsvcSs5eFRsZFZaVjJkTWJ0?=
 =?utf-8?B?U3pNY2habTJoNFFzUjdDZkYzMHo2aVk4ejd4Z2kwNGltUTdaK2RFeXBzSktw?=
 =?utf-8?B?RE9Icko3eUlZaWY2WEptazVjeEFqWUdWdlBudW15YzlZckFTV2hpK2dVRUxh?=
 =?utf-8?B?a0ZHOTc5dUFxSm9mMVZBK1A3N1FoaFM5RFdWajRFN05uZ29KaEIvdGNKMWZL?=
 =?utf-8?B?OHFhNy9JdTlHRVZmSTFXVGM0WVl6eGlIRnlrcWx6QU1paFdHcU8rZkxsbVlY?=
 =?utf-8?B?UmZ0Y3Z0Q0JRaHhuNzlxemJrWUt2cFhsZ3BzRS9QelFaV05rZGtFWXlZbk41?=
 =?utf-8?B?NVFOLzd6ek95cjU4aVVMTmJmUjNhOWVxYW1hQ0M2MjhEOHo2VjdXUSt2ZzRB?=
 =?utf-8?B?dmFxcXBaV3VDY0V0bWNYVjhQTzRudklNSjlPaFp6cFpIVWZuQklHMCtwOENJ?=
 =?utf-8?B?RXN5bHhORlNMZ0Fxcy9BSVpVNUJQSUhucHpuT0ZsY3lHb2RMU1llNlpRaUZz?=
 =?utf-8?B?T2c3ODladWVDd003cTBmVFVZTlhTL094d0xocmZlSFFZaTl4SXFxekFoRUth?=
 =?utf-8?B?cGk4a0d3TFdDUGpWZ2YyWEJZcWVScW1lOXNWUHllSjNFWXdzeVJHaEpDeGtn?=
 =?utf-8?B?TTd4ZjlBTVBQeUYzOWlEV05DeUJpK05hM2JFRFRzcEVvcmQrTWdqd291empo?=
 =?utf-8?B?d1dGWTlBVGk1d0wvM1Zvb3RzNHBHODVZTWYyRGpGVWp1M3hwNy9kTXlVb1lY?=
 =?utf-8?B?V2RnM1RHNDUzOXNMVVVoMzZNR016d3NTUDZwenJBSy9NM2E1blh1ZUo1cUpp?=
 =?utf-8?B?RWNvU090OXpzRkZzZ2E3Qi8xQ2dOTnlRS3NWaE8ydVZxSnRBdExWVm1zRWdw?=
 =?utf-8?B?anh3R296SFVJdXdnQ2tzY2tnSDlJUTNRZUI1ZDAyRk9obkVjc1Y2UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8fb033-a2c8-41cb-d0fa-08de77961f76
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 13:26:19.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsjA09eLwLNYItAwdRFrk5Hgzs8cZIN2JCPna+hBPlvajL7oa5/fFN1+v1TKkAp53esO/yksqbVs6ymGcS6SfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB3647
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78843-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A43221CFF2C
X-Rspamd-Action: no action

On Tue Feb 24, 2026 at 11:17 AM GMT, Andreas Hindborg wrote:
> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/alloc/kbox.rs | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 622b3529edfcb..e6efdd572aeea 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -213,6 +213,14 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
>          // which points to an initialized instance of `T`.
>          unsafe { &mut *Box::into_raw(b) }
>      }
> +
> +    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.
> +    ///
> +    /// Like [`Self::into_raw`], but returns a `NonNull`.
> +    pub fn into_nonnull(b: Self) -> NonNull<T> {
> +        // SAFETY: `KBox::into_raw` returns a valid pointer.
> +        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
> +    }

Hi Andreas,

It looks like this patch and many others in the series are missing `#[inlin=
e]`
for quite a few very simple functions. Could you go through the series and =
mark
small functions as such?

Thanks,
Gary

>  }
> =20
>  impl<T, A> Box<MaybeUninit<T>, A>


