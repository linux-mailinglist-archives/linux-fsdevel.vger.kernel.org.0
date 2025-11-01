Return-Path: <linux-fsdevel+bounces-66670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E58C28105
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 15:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F0194EA346
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0EF2F6562;
	Sat,  1 Nov 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pPAg/znQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFC60B8A;
	Sat,  1 Nov 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007247; cv=fail; b=ZIIISK0oHvuKsmi1/N6qCX/xy6HElDOet41SrBsZ+7F10wi5rtdopGVGHJnucGAOZc5fOrKZp21XNiBpyfuNB/GWePdU+6MbwNydL4uRcw6U6jRs3dT3W/DsvYsn9SwxsFXh1LEzxfe2q4O88r3FEf/+1260kB4SF5pWUXIytts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007247; c=relaxed/simple;
	bh=u/9JZ4p+nDAtlxVjAsMFKkb11/zY/9hrTxQYJp9B0ZY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=a50z0zbJJRw67dsWWXKiaHt594zTlPJrrCxmNHm2J8TvCTapTBLb2wSqKotosKPuXYR5eiXwDvKenmx5v9n0Ti1qOC2eM3+DcQaHreInx/M+HdjRnhMlbHcgCrhYzKm/3CLXgZdenvvTfWYqR7tyukWWguyQ+KacLZJPke7HmRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pPAg/znQ; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6WPaLoQQmFxNI7IL10OK+szAX3EBDlHz93e+oDI/zIQTm65AJE4NO/QE6wkxUhgaueXkSIIhUxpKB9fk+T9Xb4DUjrt+EQITLuGx7RtM9YgWNVC46BHqVLVRDGGLu0/qmOBfYkVbqEx+rcpI0KtIxYgdaOuesAiQFm6mNPqddYDdcPvSfBhYYLb8Qe1ccMR7mfOdRS2cdAmXyoJku3nQ2I2TViG+Bx9HiAdFWpEOyG8Vc68ScXxUsfAeehiiBztwJMGZL/qXExxREBfBHc3rBpYJAWgK+LDT1GDDVv3BGuf9XpenDxUBGEBZPA/k6ty7zawnnU2TO4dXi6bM0+How==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/9JZ4p+nDAtlxVjAsMFKkb11/zY/9hrTxQYJp9B0ZY=;
 b=AMXQvKHbrx7MqjB+nwQTUMLRvjPXtbUc0qY9iJ24K7e5DarVBNG6GqEpBXCgDNNd+yjaJmEzRJ1ANU/rMSlAFGtdlU1soaxwXW3nwSni8b770XKbrwJhy+ydgNKFWzavp4I1dHoWdz8AE/CJmep+b6QvuCwG11jC9fxH7YRf251xeGNLgJNfhQ+/Fcm5wAVJ3ZgsULjsHJrTM9SmwiOLFldGdX2vAoChwTqHMP+3/z5cXXi+PAGYMPkHVj6mM6gP1/S+G16hNq8CgeMZSbd12x7KE80gfzEl3tI1g5Q7GChNLKLUPcBPaJPfr+S5o6V7BnPbrunkhF5cnSHr7vnr4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/9JZ4p+nDAtlxVjAsMFKkb11/zY/9hrTxQYJp9B0ZY=;
 b=pPAg/znQYeduPsJgeapYJ5UUoYiNwdV1SlwwaEXUG6KN8hxxik95BO1cClSUhCNz323KoDAFyPSg6uv+jrC9UxiiOTvI1H8elgca6hROTWV7Q7xZaxpz8MnbIe2Al6FePykHmbwsTCjiC39SwdYTKmNcMHJpolrljYw7FHpCBiQigVON9Q5YRSNgjS70Wv8lxu/FWeGMYV24A9i2BZkEgJW9t67OnSVzvRl3Dt5+iH9Fi89e8hqzhbcaxK2YmzG6+aCZT8QMWnuQcY69hDPJzC4+Ounu+X62eKSG7alRxZCx9ggAn5WUBQB/6dGs47t5nqRQ+hHmBA6H48wMt403UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Sat, 1 Nov
 2025 14:27:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 14:27:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Nov 2025 23:27:17 +0900
Message-Id: <DDXFFQCZJW8Y.3GMX8666EJQ2I@nvidia.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add
 UserSliceWriter::write_slice_file()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <mmaurer@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022143158.64475-1-dakr@kernel.org>
 <20251022143158.64475-6-dakr@kernel.org> <aPnnkU3IWwgERuT3@google.com>
 <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
 <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>
 <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org> <aPoPbFXGXk_ohOpW@google.com>
 <CANiq72k8bVMQLVCkwSS24Q6--b155e53tJ7aayTnz5vp0FpzUQ@mail.gmail.com>
In-Reply-To: <CANiq72k8bVMQLVCkwSS24Q6--b155e53tJ7aayTnz5vp0FpzUQ@mail.gmail.com>
X-ClientProxiedBy: OS7PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:604:24f::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 783a1f0f-bcdb-4026-fa63-08de1952c469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUV6aDFud3ZUcjdQWlRvY09vc1hoOEl0NWlQQlpOR0w4cEFnazBESm9MZGNF?=
 =?utf-8?B?QUE2bTduT3lrczg4dmpyQk53L3hQTHB5Um5IWjE3THVJUTdmZDVTYUt4cUlP?=
 =?utf-8?B?aURiWlcySzRmdHBZZjdEMXdJRE54MUlFbTFXN1lzaHR4b1FtK3Nuc3BYYWtn?=
 =?utf-8?B?cERnbjIrbFVhVGd3OURqTFdqckxDUUppaSs0aCtYN1hud3hzekxqbzZvTm5J?=
 =?utf-8?B?aE9HV1cwSmZYTk8xRnYvTUZNUlBJbEJETU5ZelZQQ2swcEJtbmdncnlVR1FV?=
 =?utf-8?B?YmdtMCs0MVNQNDdCbWNVdlVRV1N2VHdsd1UzL0gvMHdUK1pVcnlyL2RrNU0v?=
 =?utf-8?B?SnhIWkMvV0dkdDRuVk1GQWRROTEzeFNwMnFEK0cxSnUreHJaRVhvWHBFNks0?=
 =?utf-8?B?UUJNQlBUUktDaTNYQzhyOGZ1clNVT1pUaSt5UnR1ZEhiN1J0OWZHczZYYWZt?=
 =?utf-8?B?bGxuSVYxTkQ4WWlRT0NrQkl2eDF4di9qTlc0eGE4VE9oN3NNRWdKOFJLbGI2?=
 =?utf-8?B?ZTRhcTlYVjErdkJ2amxRa3AxdzQ3b3FJc1RiZldRb1VOYng1bkNDa3pRdTJ1?=
 =?utf-8?B?b0lVNVFOUmdpeXljS0wrenk4M0MrdUtXYlZwNUtXMGZBazM2ZHozT1o2V0pV?=
 =?utf-8?B?WGltWFRJMkYzbmtlTk03MHNRS2RNZUd2TW1ZUTFhNXNERUFsMkxHUVNpbm1u?=
 =?utf-8?B?MnE5VWxRRGM4YWl5TU15UWtWbzhkQjRxd0t3ZHovK1R0Q3MrMk15MzBYMGtI?=
 =?utf-8?B?eGZwcXdHM29wUzlOZ1ZEOWd5dHZPMk1qb1FNWjdRTjFrWERwdE1UcTcvVmNR?=
 =?utf-8?B?dVZVZnV3UWlFZ1ZjeEFBSFo1Z3F3UzJXZG11REFLNzFTZ2RDM0N0L1F3czNo?=
 =?utf-8?B?c2tsUmwrZmJPSjVwYWRlcnA2Z2xKb25KNFBiZmZpeFRpUG5jQVY3TklmbDZ0?=
 =?utf-8?B?cVYycmRaRUFxcnpJUUowQnN2dmdXUmUwMWJXMlc1Y3hWRzMzNCszM0pEeXY3?=
 =?utf-8?B?VEpsN1N1SG9tQ2NsbnZnY0k1U1I5LzRrUzZkQnFmckNjVmYybzdsSWRKN0RR?=
 =?utf-8?B?WWNxVGw4T2RLZUQ2aE5kMDg1UFRjVVZQUGFISnc0TTdzRmcwUGxDV0ZsQzR1?=
 =?utf-8?B?TDArSXNIOWc5cDVIbitiNEhGYnVlVG1UL1I2cHV5V0VCWGtSR05VV1JrU1la?=
 =?utf-8?B?SW9hOHpSc2R2enplMmtkRTIxdDg0THFvVHgxUmdITVl5MlFOMVNtTW1UUWxt?=
 =?utf-8?B?bCtUMVhsNWNTcERvaDBaMFNUYXlwVEJ4SmRHMkxFdFM0M1M0S3R4Y1JpMXA2?=
 =?utf-8?B?ZlhXTDF4dmg5b1VLbVpwQlpCTkZ3ek9aVDc2MmNucktUU0cwYVhEVDYvT1RJ?=
 =?utf-8?B?WmlicnRkYUNBNk9ON2ZmMjNXL3R3bGJxWjEwZVh1Q0IxS1FEMi9zSVFpejZC?=
 =?utf-8?B?ejM1TWdyZjBMR0JPSEpMcHZqTk9LTmpFdE5yWm1ON1NEdk9DSGhPc2NkWk1E?=
 =?utf-8?B?SzI2K2drck5BNEZpQXozaDdhcUsxUHhsdmhMaWlicThydDc5WitJeXVWNGxs?=
 =?utf-8?B?TVV2WlVrM1F5YU1LMDNDQlczdFVYb1Z5QU9Zc2FaS2pzTzhLd1FFSzF3Tk9t?=
 =?utf-8?B?MjEvTTBraDJXVS9EM1FFMCt2Y0YyM3h0MHpSWW1nejNoQ0tKWTJzT0FlaUdF?=
 =?utf-8?B?R21zalBPUENkaXhNVHQydDR2Z1NnL0VrUkJBaDYzeUg3SXZOWlFIOVJ0L3gw?=
 =?utf-8?B?TVp3SW9ERkp4SFQvL2pRbVlmWVNNZzNNeG5HS05UaTdXTFhjTGdRbnh5Tnl4?=
 =?utf-8?B?WHJoOURzczFvL0cweUxkdUpwNHJrS0QyQ0YvSGQ3bEpkODRwa2l4N3R3V0d0?=
 =?utf-8?B?UlpvVWQ0d0c0S1dmeFpkL2pEQ0xaeXZhOXArVkg3a2ZDcjNSampUOXhUR2cx?=
 =?utf-8?B?MjYrY1JKOGY4MlQ2MFQ1TDdnUXFCVU1ZQlJYSWpSWFV5Sy9WcWtMSXE2anRO?=
 =?utf-8?B?SlBNYWU1WjhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXRwMnhIa2F2WlJ0eWdUUzBXNW5qODZDQUdkNTMzb0NoWXJMSXBiaGtMNURK?=
 =?utf-8?B?Q1Q2M0RHSXZyTFdwSTlST1VYUUpldVdBTkVSd243N1AybFo1SlYvbWlaMGVZ?=
 =?utf-8?B?OUU1U2lXOGFZTXpITkhOUU9GT0FXVTg2OTV3emkvQVVHOGNLSkpBZjNqNUNN?=
 =?utf-8?B?OEcxdTUzYm9PYTRLdGlkUHpHSExIajI1ci9uSGx2a1BtcmtzTjE2ZXpPSUNL?=
 =?utf-8?B?akV2Slc1Qm04bFNDdzV0MXBTWm9xQ0pBVzBzbGJNbTdFa1NQNE9Lb0NqMmdj?=
 =?utf-8?B?ZnpTbG5IQmgxUVVjb1BweXVvc1dRWGI1VDA0SEV2THl2emZjS3E0Sm9MWWQz?=
 =?utf-8?B?eTdmUUlUd08vUmc5bGpFbVAvVU1JbVY2Ym9nSmQ2ZUd0OHRQT0l1QXdUbjdr?=
 =?utf-8?B?UGNEaU9MbWdtdkEyNyszVCtzWHYxRnZlOUsvdWJVeC81L2VBblQyY2xiTEl0?=
 =?utf-8?B?TUR0SVIwQ2EyVVprRXFCSkVuMTFST1V1dExMRFB6bU5ZVldJaG9tY3EvYmZO?=
 =?utf-8?B?cUV1MWdWY3REbDhJaG5nTGhpS05lNkNYYVlhMkJnaUt5cnptWWtid2dnRDd1?=
 =?utf-8?B?TTJmakZ0WEZOWXI0YzAzZ2gySW9RN0ZpT0tYYmp6QWNSdVZOUHhCekhoVzVG?=
 =?utf-8?B?Z2hucUZTR1N2d3pTRUZuUE5Ob0x5RTFEMThSQW0wbVhJQ0ZWL1JnZEFDYUMz?=
 =?utf-8?B?aXI1SFc2Q0VDOUVEejJnaXprVUlXcGc4ZGYraFRzdGtLaURLQUJINTZLQlBo?=
 =?utf-8?B?VDlyUXAyVnFZNXdrUlduZnVVVERSdlFNRitVcnpiN2lnTitzZTU1SVVvSjBs?=
 =?utf-8?B?d2Q3NXplT2ZqSmllSnVrTVNhQ2NrMlgzdytrTDFMSTFVRXRiNWMvL2J3cU9P?=
 =?utf-8?B?V0hLemxCamlVamlGTjBlNXhQem4rTGx2NUxYVGx0Q3pWQVVOWUE4aW5lUVov?=
 =?utf-8?B?MWdid1M4ZlFzNkFpM1p2QldDSGk5U2pYSll0azVCVm1WWWZ5QlZyS2NvUTRR?=
 =?utf-8?B?bW5kbXhHQXZtWFZZL0ZBbmFaT1pQZGFzdnFWUTBveFJ2OE1YUExMdDdOdm81?=
 =?utf-8?B?bXkwYUhRK0I3SlZaWGREaWd5amY0UEFKaHNHK1M3WjFrWlVkN01jbEtOVmNu?=
 =?utf-8?B?V3YrVHpZcDdJMkpucnVNTXBCcFdoQzF1alk0dzVJYlgzVUViUVpHZGVSR3p2?=
 =?utf-8?B?QzV4RWJ6WGNGckNtNHpxaTloR0E0LzlVMTNDWTRNZ1dYektpUkNCK0lWRis5?=
 =?utf-8?B?bDJSMHAyeUFCTGJiMVVvMWc5U09SMzhqOHpUd1g2Q0cwK0QxdWk2dFZMS1Fh?=
 =?utf-8?B?L1JCNnNFdExaaTJLTkV3VllJWVRWQTY1UDk5WGFiNmN4QitHcTlmZ3ExbTBl?=
 =?utf-8?B?NlNIbnJ3RUNKNW1oM1E1ZVB5UVg0bW5LOUlLQTJHWWYxUHVkTXRTTjZrdzc4?=
 =?utf-8?B?aWJQMEN6NndCMXh4aXhOdmJzU1U1T1c2STI4UkJzeGJvYjBPSUtnZGxjS0hN?=
 =?utf-8?B?RHVXeEVmM1hPRlg3YXQrMDdtenBkdU1xUUhEbzEwa3lBQzVQeGs5NU5SYXA5?=
 =?utf-8?B?T3RGR2haVHJjRlpZRVRub3ZtUU1BUjk1WGJDdUhKNEIwSEtSV0U3WFVNNXRX?=
 =?utf-8?B?clhTNjBjMzdCbW40ZzdMSTI1QmJPY2NGdjlxajF0eVY5RkVMcHYzT0l6d0FB?=
 =?utf-8?B?UDRwQmlwWWViTEVKMEV4KzFqcEluRWw5L0JNWldRS0VhQytuUThOMkhQSHFQ?=
 =?utf-8?B?eWdHVWN4ZzVGTmZMYUN3RElIa2dFOHJNMnFwU2E2cFNoMk9xdGtob0RyU2xQ?=
 =?utf-8?B?eXFkS0xtYkVxN0xEM1hLYUk0NXRNUS9ERU9pZmQ1amptNnplblhnSTc5dDVQ?=
 =?utf-8?B?RFJCaHU4ZytyU2hHdTJxWjExRkgwTmp2eFAvWUswOG4wV1cwVU1EY1VmdGFV?=
 =?utf-8?B?bmRHSThYOW0yQWVUakpQbGRGVVFrdlFvcHNqT0hRNkcwVXAyWXk1VXhkak1U?=
 =?utf-8?B?azdnK2RueFdFeEZYa3FHNHBUWkFzRFowRTR5dzdxWTZJbUc4QWJ1SGpTajZQ?=
 =?utf-8?B?Z056a0FqMURlazVJdlJTblNVWVF5T2hsaG5XWkRWTE5TL3lTMlJDOWJtRENX?=
 =?utf-8?B?MlBFOW53RnFwclhLU0tadVJueHJSbnJjUVpXMk5zLy84WGNWanV3bDRMTGE0?=
 =?utf-8?Q?0BK2JZq6Gu0gmKQxiJW0GuM39JEWsYUpgGPuLOxjEURB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783a1f0f-bcdb-4026-fa63-08de1952c469
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 14:27:20.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZRA3Xn1naaWkcn3QhLLnXa2dNvdeNSEjbToJISYnq5SDOAbLCwHY19s25g4q6Ie2gYBjKRJn60dAVVbXQxKeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776

On Sat Oct 25, 2025 at 3:02 AM JST, Miguel Ojeda wrote:
> On Thu, Oct 23, 2025 at 1:20=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> I would love to have infallible conversions from usize to u64 (and u32
>> to usize), but we can't really modify the stdlib to add them.
>
> I don't have a link at hand now, but we already (recently too, I
> think) discussed having these "we know it is infallible in the kernel"
> conversions. Maybe there was a patch posted even.
>
> Otherwise, I will create a good first issue.

Are you referring to this discussion?

https://lore.kernel.org/rust-for-linux/DDK4KADWJHMG.1FUPL3SDR26XF@kernel.or=
g/

If so, I have posted something along those lines:

https://lore.kernel.org/rust-for-linux/20251029-nova-as-v3-4-6a30c7333ad9@n=
vidia.com/

We planned to have it stew in Nova for a bit, but I don't mind moving
this to the core code if you think that looks good enough.

