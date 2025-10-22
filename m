Return-Path: <linux-fsdevel+bounces-65052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C88BFA229
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872E25655F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608352DECB4;
	Wed, 22 Oct 2025 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jnZ43QVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90A23AB9C;
	Wed, 22 Oct 2025 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112673; cv=fail; b=Es0Le5y2CNzbkrKAAOIjETpwOCTuKnskpXQy0XGSf/HDUExk0bLtwSNJap8C/92EfHg/gZ7+O9CLidwDIDSwh92BU/Efr5QaY6aWv1WNZ1Mbt+f48kFx0zgBZgWV0pfxoNwnF1lcIIDI1D83BeuFkT7QPxieCrTrwzMYD6SK5qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112673; c=relaxed/simple;
	bh=2mz+jUyEnl11KDfe3E51gnRGnIj+ffd03jNDjG0pltE=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=UEn+0qKzsMdSWD90IRT9KpYrGfHK/CDNo9udWXKOkB9B+f5coXJQFFxwWz9QMhvVpewOjPdRRSdJErnKZsuwdcKaGYbIT/fPWjtAXAehAKEfRYjRAVgEx5l9z0yBYgbDrqyw82VgQNds/p1VvKXllgS8M6Pc+Af/l7fqRVTiNQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jnZ43QVK; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp0ow31WRUJLcjNpzShoc5EzDnGJ/8dcxsctxWZnDlh0qQspwiK7BaVpemMSgxa3+cZ/w/43/H2oZ8tbCHjLe/VoYhnKlhKyXaTp0GQ45OoyJ5sv7wTkKCqKs6oFcUbhCPbh07iSs2EEX4IS5WYuYkg4SjwxU+qt4Hb1/Js4xdzPdTY7PR+iKMH39Pon/3Xi9DtkvsOAaazvp53HyviJwV+DAi4HKDPS+3XlfgfsmMlG/IQUwybA4BnUi2z1q/m5UXvCXDbTAfvNjpiH2fkWITZ6BN612JKEi3MxeEZJ3pQqvgIctNSNWZJ2twVE2ETQHovUypp/Yna51zL/S9IUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc9sI7c7WuV5GghJMsnKNX7id+BjmR9FhZam2bzHBq4=;
 b=kGZJDme/r/Q5y06UEBRbribHtqnO2LGY2eLQQT7IFFXA3fp5/hfEdKYotBqKKFqdniqQeUmd1noeoZKKaNnYc7Pa+mi7CFPYSaXYkwOJW3tq6BMvf9P8JA6EAJDODJDdjFy5/ZgK7N9mOWpLs35y2AjjghnjR60a7x4h3EGxEH0uYHLgo7Z3F/zFQpu86JRuqiriTCHcJBRyLtCgRy68LlOYLUc5kfU97mbPzF2Ye58nDuVbw7i6cHoLGZDnkktkY7KcRcPPInOs3eYiFIEj3k7Sv911D3T5oAuKvGkbiOchLkzfc1R+LqnXoINOW1n3+Y9VnfQwiKUWaDNzzqseTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc9sI7c7WuV5GghJMsnKNX7id+BjmR9FhZam2bzHBq4=;
 b=jnZ43QVKgUw9X1ySVugHMP3rbYpkmpeKB0PzJXgQpFcYALyJmbyN7/FqHptsDE/GsDmjrsdq79C2NGT5MKOF2OkKKsbvjq9B37IHvXwm2wdky/7u+V0ESF+5Lje2Yy45doegWKp+ORxHn2DjvDtSlApagCRhNqZsg1UavprHYbgtC6thqdO8Nhvyoetxw8UlDsYtTzru3Hyw8//ApOC38MHpeIVyWud/wtDk9Ba4hlLZq71GLbiZttTweyoS7xK7GZntrVYeAaDctCSGiwmJh+CrOD3E2YuUfg/4LBNvAk3xs/lGwYt3JmT5CADzK2xSi11sUCzjuVRL0ti7guA6rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 05:57:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 05:57:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:57:43 +0900
Message-Id: <DDOMC4F138FF.30W347U04XWZ8@nvidia.com>
Subject: Re: [PATCH v2 5/8] rust: debugfs: support blobs from smart pointers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <mmaurer@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251020222722.240473-1-dakr@kernel.org>
 <20251020222722.240473-6-dakr@kernel.org>
In-Reply-To: <20251020222722.240473-6-dakr@kernel.org>
X-ClientProxiedBy: TYCPR01CA0113.jpnprd01.prod.outlook.com
 (2603:1096:405:4::29) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: b11bd237-35f1-4bdf-4e7c-08de112fec9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mjd6UkY1UGJsZURPUHpRL05EQnhzdDhLbGxwNy9YV1JsRjQxUWxpQ3BjaU5m?=
 =?utf-8?B?Y0RTa3A2dEZOSkpZdzhsay9kRHRsd3hQWW11cXhRUlIxS2d2Mm4wa0hpdU1J?=
 =?utf-8?B?cFBMUjVXRmgzbFpPV2I5RWRrVkhZMjdjZkFLTFEzZE83dkZhT01rdmpjbnpv?=
 =?utf-8?B?MjNzN2I2NFBIVXFubFo5akdiOFV3bWVVaWhTTU56cExiVnp3ekE4NDAvSWFL?=
 =?utf-8?B?QnFRUjR0UHRTUGdHVWNwdU9vM0dqRkRSaHlHR0Y5N1NGcFp6aVFtQlY0MzNt?=
 =?utf-8?B?K0gxMmxDdEYyMjVYSWIrdjVBKzJiMXFPNUh1SkdvVldUMCtQN1hxUWE4aGV1?=
 =?utf-8?B?OGdTNElYQzZlUXdrdWw4YUUwczl4UDlYYVUxdjZNaWZJUWNTV3NSVEY5ZTVt?=
 =?utf-8?B?M2FzRk1DMDBDMkJvS3QyUlNZQWgyM3U3aEJsWGxMTnZSdG1JNDV0a1A4dk80?=
 =?utf-8?B?Sm9UVkVOYThaSmxaU0dHM3BHcDlya2dpaWF2NGVYUEZyenpQU3FGTEZOcEUy?=
 =?utf-8?B?YzBuNmpBdzVRYm1nREMrK2RMS3dtcjFRT2h4NzVqWlFnZzZGQXNSL0pXRXd2?=
 =?utf-8?B?NDYyalk4T1grMTc2WExGaElOSVg5UnoyYi9IOEd1Qk9VeUFBVzA5L0VQbWxX?=
 =?utf-8?B?RFJzK04vb3dKTmRJckR6aERtZzJ3VDZwQ1BNNlpQTjR2dGs3WGFObUIybUVO?=
 =?utf-8?B?Z2RFQ2NveCt2YXdLdE9YN0tjWWMzSXRyNXZPM0RxWml3a2oyVENYMVlYaVM5?=
 =?utf-8?B?NEs3OERubENRZnhsNS92MXhLdXB6NngrTUVjN3RHWXMzcTJTTlo3NHNJSzBG?=
 =?utf-8?B?akVGcEJuWW4xMW1SQW5USzFEVi9qWDVOS3cyVTFXZS9INVBmVFhHRHhJdUcx?=
 =?utf-8?B?bXYvVnNsL0RpNVJ5N3ovS3R3U2FnaWZvVzBzNmppMnlCbmdOaUlHTWJPb1J0?=
 =?utf-8?B?eEFRVmFwZ3l3WElnSFJxN3c4Vi90MXBIcGZDMkc2bHJ6V21iYUFWRThqNTJI?=
 =?utf-8?B?cUk3Tkt3RGlGbm16eEZGc1BVeUJzalNOM3VDcGk3aE1hM3VZZ0lkOTJjd3c4?=
 =?utf-8?B?RStPYURaaHpEZllmSTcwTjVCa21adDhMYVV4MitUS0xweXV1NjhHL1FsNk1G?=
 =?utf-8?B?Y3lFN3RPNDVEb2xtaDlSOEZLR1FLVXkySlIxRW8wMHpDTXE1VHRzejFlQW1O?=
 =?utf-8?B?L0g3NjdJQ2o0ekRlUnJTM29CUjhieDFiN1AxYStyV2dKaGE4NTc3aTNQb0NE?=
 =?utf-8?B?U0dsSmM2MisrbzdvWDFPdUdYNmZxN016QzFXd2YzK3UrclRoUHphdG1Zb0tS?=
 =?utf-8?B?d21ZNlY0V0h3RndaVmZHcFozRFRNNmZBcGlKNTljUllSeVBRSHNRRnUwQkla?=
 =?utf-8?B?WXV3aXQ4RE85YlRmZzFmNFJPVU1RdzZJWEJ0MkpoZTNBSm1pbTY1MnYzMXF6?=
 =?utf-8?B?VEpMYzlpYkdTc3F6TTMrNitiNjA4Q0YxQVJWd29yc1I3MHRpMWJUakR1bHFJ?=
 =?utf-8?B?N05EMVhVZzhCTGR1NnBGbE9tSFU5WDd5Zms4cU16bmhBM3hEUVNvUWpBSnZT?=
 =?utf-8?B?QkdnQkNWWGdWQ1o0V2RpekdXVUZ1enNiZzB2THVnRjZFTm1GeGpGNVYvTFdO?=
 =?utf-8?B?YTliaHFxRzdhVysyVUFQYWJ0U3NxTEQ0TlRzVXFObFZvcXBkL3J3Ni9uUjJy?=
 =?utf-8?B?MmJYZC96eVN4T3NsWnJKVWl3WnR5bzVoYUdXc0c5U0RCM2o1MlpZRDNIaXNy?=
 =?utf-8?B?Vmdnckg4b1I0OFNnVHNLYUxpcXZxNEk3Q0pjY0MzUG9KZzVRK2F6RGFVOWJx?=
 =?utf-8?B?QVNhSmFFYW50YjhFVjVmbWt3YVpveEx5VlQ4cXBqQ3F3akp6aHZ0U0I1aERv?=
 =?utf-8?B?a0JaaUo1SUw3OWhBTW1MczUvK283bi8xYkovWERHS0Y1cVpiZzBNSXYvUms5?=
 =?utf-8?B?M294L1JjdDgrSHQrd2M1Smh2MjVyNy9RbVA2OERIajRkVXRuVGpYNUhsMU1m?=
 =?utf-8?Q?OENMyQ63RNkGHyrHe7QfUTQyJLZKDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEluL3VDMWp5bk1Xbi9HOFFOS093L0FNUG54NnhyNjJ4UG14cEhpdUMxbHZF?=
 =?utf-8?B?N0tVRmxkNWJ1V3FvcE5nWGFBcmhQK3ZxczR0Q1BFa0ZaL290TjR4RGtTSkd5?=
 =?utf-8?B?dDlrU1psSWNOYWZLRFdhQWlqQm82KzdiU3hJYmNjeTNjNmowMXJXYnBiUzZ4?=
 =?utf-8?B?Z0QzazdicUJkSHB0VXB5ZTlDVDZibUdQL2RJazl5cFhuNnlxTXU5ZjNTSzIz?=
 =?utf-8?B?SmMyQSt4WGhkNm1melhPQVNyVlZkcXRpRzZZanRDREdEM2U5RytZeE1KWHVT?=
 =?utf-8?B?NDdETDN1QzM0VGVpbHErWWxnaTdoL3oxeVBhRS9ydXFBM3VDbVJMMWhDN2Rs?=
 =?utf-8?B?YWp2am1GNzFNQlo1SzZCeFp0aU02eE4vS2NmcEczVlN1dUp6aFFGMmlVSmxt?=
 =?utf-8?B?TTFsSHR5TGc1aWcrMUVyc2VYWGZwMitkMmJWWHVqanRXYWtBYXpiNG95bWtm?=
 =?utf-8?B?Q2d6bTU2RVRCU2ZkQzdVUjB2RzVKS0tmV01sdU9zYTc5WlVFNy8zUnVDSmwx?=
 =?utf-8?B?UnhQcGw4cnhOV2dwUG1MeFh6djNGMXpzNXFLelJiak82cGhqVlBQZEE5MGhQ?=
 =?utf-8?B?VWUrVGtRbWFKTDgzSmxmOHMzSXFEaGZjbG50U0Rza0thVDArWDQyWnJVTCtO?=
 =?utf-8?B?d0NvZHFRN0JTVDdKLzFRRWZyM2ljYTF1VWlBeVFXajFya3VIbEhyMXJYWUNw?=
 =?utf-8?B?Yyt5MVZ4WktpanZxcDhiek9wQXU3RXpFR1pDSG9SZ2Z6R0ZvNXZRWEU4N1ow?=
 =?utf-8?B?Qy95RUY3dU95eFp1SUlDUmRaSUc0ellqUjlibnVkV2VZK0R4VW9GbzdMdGRx?=
 =?utf-8?B?WE9ua294b0txaGlhN0RSWUxxTEhvTjA5RndKMXhteFhQa0hpNUJxTm5CekdF?=
 =?utf-8?B?WXd4b3JMaVJlRG1JbHhuaFdSbisrcGNFQlMzZFp0QlczOW9tOVdreGtla3dS?=
 =?utf-8?B?aTdzRklpQWl2SGpBVVFyMjUySmlLVmJVU0ZHbGxTQmdGK3hjNHQrVGt3NW8r?=
 =?utf-8?B?NjE5SUFTMEJnUTVZM0swb3VMYzh6Tk5LbVRDaGUrdjJNdmtxUjBXT2VFQTdw?=
 =?utf-8?B?ZXpnUGwwQjJVNXlWZWxaZTdiaGpMOG9WQkMrR29xMVhVSjNLNDF5NnBKeThS?=
 =?utf-8?B?R0l6c3BqeTdoTTJEdTFGbFQvK0pqaFFyck5aY2pXVlBCdWZtR29xeW40KytP?=
 =?utf-8?B?VzJHSXVUcGwvaTZLR3dPVFExSnMxYjNlR0ovR1dCVmZCL2VXeFBRODhvelFt?=
 =?utf-8?B?aW4zeUhFY1BFbFN6dVluSXM4M095bW1UZ3Vpd2hsQStFR1FjQTR4SEJSOXA2?=
 =?utf-8?B?Mmh2RTNLOHN2VU82eGEyZzRhWGtRR2x0bGVCSEE5SzI0Q2pkZEFxOHlZSnd0?=
 =?utf-8?B?QU5ZSkFycWtQLzNCMVQrVlp6aGtkOXpacHJRSG1USWkxU0JDd1Fyd0liQ1NJ?=
 =?utf-8?B?UVg2Uisyb1Bua3ZUL3FFL1pjMDEwTTNkbXZ1UTVVclY3R2cyb09GR0hRYVJL?=
 =?utf-8?B?d2hKOFc4eTB4bGFMRlIrV1ZuSld2S21YYk5VcUFZRTQ5N3Q5N0dmWHFzRDhn?=
 =?utf-8?B?UDNISS9RYUozZkMrUWFVUDBKSmhEUmNmUTdlWVg5NWdsUlZBNVFwTmwyNHZS?=
 =?utf-8?B?djBoR2xITHZiL2puV2tsMG5tTDFjNm5mVDREQXMyTXVSTjBxdnVpSWJXUHFq?=
 =?utf-8?B?RnkwY2hmQmRSYkNpSVNyVjJTV2RrWWpwVjVaZnlYSndKQVgrY2NLQ1E0RG42?=
 =?utf-8?B?TXF6ZHpJMnFzVGVEZFJTcFlBejZUR3NrSzhJamhTR2FPcDcvOEVDVExaMXZ0?=
 =?utf-8?B?Z2g2QUJRQThpbVYwNTRVbjRRdjVuSTE5RUQxY0ppV0RaTFZ4SGFEaG8vZ0Ro?=
 =?utf-8?B?MjIyYUJOTDJsTVBVMkV3NXZWdFAzaVJ1czIvQnNMRXpuMENyMkNtekdkei9k?=
 =?utf-8?B?TkdPUWhsQm9vWTE4bTBsemYxWkNJWnllamRRNVd0aEV5YkwrRys5YVRFd1RF?=
 =?utf-8?B?eno3Qm9sYXQyalR5MVpGTXl6NHRQdktRS3VlUzVvdnhpUFMyNDNTZVNGcStR?=
 =?utf-8?B?d0dTcVNkbnFJMXhObmE4THB0V3h6dTM2aW1VeHg3U3NVN0xCSVdFMm5KcTdr?=
 =?utf-8?B?OVBQR1g5VW9mUHhGODBQT2VNaklITEhYbXhhV1Z0cXR1dG84RTA0Z0VaT3BV?=
 =?utf-8?Q?9Fqu1pxTqxoDu5Z95kIvLXtIzgm1zoIqN4bgA7bJvW2p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11bd237-35f1-4bdf-4e7c-08de112fec9d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 05:57:46.8475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJF6P84bpLscUmKfJ5TJ+1kfuWZNhj9Fn83Dt1s3iwfrSZzApDP4VUZEVpgFa93nXv5SN6KzZQEemjxHHrlyfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

On Tue Oct 21, 2025 at 7:26 AM JST, Danilo Krummrich wrote:
<snip>
> @@ -51,12 +54,14 @@ pub trait BinaryWriter {
>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file:=
:Offset) -> Result<usize>;
>  }
> =20
> +// Base implementation for any `T: AsBytes`.
>  impl<T: AsBytes> BinaryWriter for T {
>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file:=
:Offset) -> Result<usize> {
>          writer.write_slice_partial(self.as_bytes(), offset)
>      }
>  }
> =20
> +// Delegate for `Mutex<T>`: Support a `T` with an outer mutex.

I guess these two comments belong in the previous patch?

>  impl<T: BinaryWriter> BinaryWriter for Mutex<T> {
>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file:=
:Offset) -> Result<usize> {
>          let guard =3D self.lock();
> @@ -65,6 +70,56 @@ fn write_to_slice(&self, writer: &mut UserSliceWriter,=
 offset: file::Offset) ->
>      }
>  }
> =20
> +// Delegate for `Box<T, A>`: Support a `Box<T, A>` with no lock or an in=
ner lock.
> +impl<T, A> BinaryWriter for Box<T, A>
> +where
> +    T: BinaryWriter,
> +    A: Allocator,
> +{
> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file:=
:Offset) -> Result<usize> {
> +        self.deref().write_to_slice(writer, offset)
> +    }
> +}
> +
> +// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with no loc=
k or an inner lock.
> +impl<T, A> BinaryWriter for Pin<Box<T, A>>
> +where
> +    T: BinaryWriter,
> +    A: Allocator,
> +{
> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file:=
:Offset) -> Result<usize> {
> +        self.deref().write_to_slice(writer, offset)
> +    }
> +}
> +
> +// Delegate for `Arc<T>`: Support a `Arc<T>` with no lock or an inner lo=
ck.
> +impl<T> BinaryWriter for Arc<T>
> +where
> +    T: BinaryWriter,
> +{
> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: file:=
:Offset) -> Result<usize> {
> +        self.deref().write_to_slice(writer, offset)
> +    }
> +}

These 3 implementations are identical - can we replace some/all with
just an implementation for anything implementing `Deref<T>`?


