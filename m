Return-Path: <linux-fsdevel+bounces-76451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFi0LqKbhGmI3wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:31:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7538CF347C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91B4C30182AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D24C225397;
	Thu,  5 Feb 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ij07Oqvq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021117.outbound.protection.outlook.com [52.101.100.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD013790B;
	Thu,  5 Feb 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298266; cv=fail; b=mDsEfFOTvMnlkDDM9vu9lBE+UInTWcEK1gV/e7N+n1XonPNhuTxxaHrC0DdFWKFkZN/OCwFnKZYQh0Ny9eqPxVLFdtaqV9L9Vc9xmjk4dZBtOd2Y1zPNhXdERgXYjakNi8hfBERoLAUU19WYAzfnZS6WqOpuU5PRpUWPdHms1Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298266; c=relaxed/simple;
	bh=6n4nhSUrOOIepFMkBSThEOCoPIm6esLaE6IK+uLH/ic=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qS8kNkgjRQshcraXnHqOV/L16w6b9Sutr02imBmUtPI8OP82ei/hSqRn2EM8t4zxkxfQjP1xIGuFKTXIuKvNNMqR9sns1svoynnawEQyNbjXQEXc6FqbeVBDtwVt2A6dnbOjjXptKo8vB25V3mM1ftHutfkdhI66ywjAM8t7ZkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ij07Oqvq; arc=fail smtp.client-ip=52.101.100.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd/0cegOTFpga8q2Ev3IcgolRsx1I4s/sOuWCOU7Od/9iEbS1W7l1O/8ur4mHM11gtePo35TohoU6npx0W/E6gDoJsmsEqGmAbO1kKS1OwMXXh5+4y01pvil0kFtV27/5alpjUlRAoIMs+TEMbjqBY2tCsI9qiurC78UUWI3Ukw2Qw3demAdB3RDkLAlSvwd/+T1XhsQt2rHvte6ZI8hEgFQ50dNWFgSSTyOKktllGrQPyaefVQmfM2I4L15GH3cz+OvaK5w0Q0WmvroE82ltSnu6/NWWywu5dEuZxK1A0AFMyar9rQG+Y8/YjWAnCQL0ilbqS3WgCH/mcPSIzDvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzQL3SjmhbNO5ZWds9bJeQJUFWhBvTar75NOP7sPiQk=;
 b=o2NSKfynL56FQFM/k2KIRKqfXXlMjU6Zn+wT9MCqROfhCDm7/s0RYkq7/fsIjaNvwPKgoeIdBgTE/cY5664T31U3Tw7I8vYlPXun9WBJCgKLo6Xi0+SwTomOB8bOuGQDrrR8c7fKoXbjqjT/imNfTsZBoaPRbhN//zNBRkyZBZb7bfaJqXFkuR1qa8OVtnCraT9AjRuyWrY7YAaUfe9AyCgQpOKYkMKpvSaIhNTRjiEnsOVa1AR1u/me+06c3c/tMoa15Qtx9Msi+uj6UYN4XmK8U2ar/m1JdjjDGjKB3PhGYSWzdWl0B1qX28E8yxL7VsIRKxag+uEUeXiUGto7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzQL3SjmhbNO5ZWds9bJeQJUFWhBvTar75NOP7sPiQk=;
 b=ij07OqvqUK8yNFiUZntKNVvBJD6BaoY7i9W5jcxcKwMlIjX1RkruvLEqDotihNFtgrYS74ZwywOLOZw49kDvqnnP+uIGZueOlNINanFTNIzZyZl6chIOOAu0E8LjGZfuuQaY41TNqSQ5TJgxyLvHuchKq3DCFCZmcj+GIki7CA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7711.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 13:31:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 13:31:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 13:31:01 +0000
Message-Id: <DG72CY2P36F9.2O7OIN36KW8F8@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, "Oliver Mangold" <oliver.mangold@pm.me>
Subject: Re: [PATCH v14 2/9] rust: rename `AlwaysRefCounted` to
 `RefCounted`.
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
X-Mailer: aerc 0.21.0
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
In-Reply-To: <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
X-ClientProxiedBy: LO2P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e0138c-6900-45b9-58f8-08de64bace46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2hGeU85cjY0OGxQalgrbkJTd3JJbHBweVRFVDU3WXhsUGtRMVdFR2tvVlo0?=
 =?utf-8?B?NlZNd1lSSW5JVXlVSFUyRzBFZnBmN2JYd2pvZ3N1SVhvZXlVMFI5c1M5QXQ0?=
 =?utf-8?B?aW9vbSs3Sm8yMzM3UzYxZi94a3JBT3cyaW5IV1V1UkVQaGNWNllHeEJNdlNw?=
 =?utf-8?B?cTVmMkplSnhmRmpWTHZibDdxV0FDL3A3RzQ4c2NFdjBmRjNicFZRVDNzaUp1?=
 =?utf-8?B?Y3VyaWRWbDVCMEpuaTlnZjdkOGhlZnpjWHBpUUNSbzVUNlJyZ2RmZkYzV2tN?=
 =?utf-8?B?ZThDc3lldWxUMmxjNDdPQldrdVkzSC9nZnV6MkZTYkpNckFiOTlVSEVUOVda?=
 =?utf-8?B?eVRUTGFxdDVPYUtRK202RzJaSUQ2Q0hRd3Q1a2I1b2I0TDYwQWFSaWlzUE5O?=
 =?utf-8?B?a0kxcnJFQkQvYXhUS1FCNFlHejZ4bUt3TUo5ckxXK2pQZHhPTDhLN1czUlRj?=
 =?utf-8?B?eFdqNHg2MnhlRkJGVyszVEFnWVo5TCsxWUVaSHJpQ2ZQbUdyTzRIblAyOUZG?=
 =?utf-8?B?RXgrUDdMTlRVZkRJSWZVRnk5bzl2aUdtem5kODVCbVppZkNMY2ptSVU4M24z?=
 =?utf-8?B?VC9uMVU1ZWpWOVliQk00WkNnTmM4Sk9JcFhoN1JnbzlQWEdIUGdkOEV1ZlMr?=
 =?utf-8?B?ZEh1dDh2aWhGdForVFh2V0M1NEd0NXVoenljMkVEVUdwbnpCaTRtYXg0K0c1?=
 =?utf-8?B?YTJZT0R5a1RmZTQrWStrVms3VkNHWnhzTXdxSWx5blBuTEs3OGtHY3NlVHhs?=
 =?utf-8?B?ckpFYnVaS0tpRERERVd0THlBWGNMdEtLb2hJS0NpQWtIaDlJcjlqWFMrQllC?=
 =?utf-8?B?Yll2SFBLWkJselZKLzVSM1hKZ05FOTlQS0RsaG43WUR1Wk5ROVlLcy9yV3BL?=
 =?utf-8?B?MzUzcFRiMnNrbURaUDJGU3JKOWxkZFJ6T25lWWQ3WXYzU1JyTEpPN3FzMlZF?=
 =?utf-8?B?NGx2eEdRMEJ0V2dkUHBPWmg5ZkNXbmNwRS93K3ppNzRlMHdDK2QxeFNQVEh5?=
 =?utf-8?B?VUJxeDhBb3dVZm9FNElKZ3lTZGlFVTE3c2VUaDgrOGRRS05YUDBUZjlmV3pP?=
 =?utf-8?B?QVlqNmFySE5ic1JRREgzeElrOGRZZHJhODhKN1lTeUdnZlFoallXUmVQeFhM?=
 =?utf-8?B?cnU5ZWFNYjJmUkdad3lUN004ckJ0NzNOTXROK1RqcTRhUXpwVlhGTllyNUlG?=
 =?utf-8?B?Ykk5UG5zVEowWkhqYm9TQ05MbjJDSm9YbkQ0VGltbmY1Y1RHT2U5UTFYMlJj?=
 =?utf-8?B?RWpjZ0lQQzBlMGZTYUpzOWcyVW12L3p5QUtCMDliNlRhNlc2azBlbkRJK1E2?=
 =?utf-8?B?L1VkZWRkN1lDWGlSQU5vVjN0NkdqMHhBWnFweTN1ZGJqSHcvQ3R6M25MTXlS?=
 =?utf-8?B?bEVsL0dZNXgvNTZoU3Rac1REQ1diWmYra2VCNFcrbTVONlFEdCtpYWtvb1My?=
 =?utf-8?B?d2pmNlhVOVZXL25TcWdLYUxFcWtVUStVUXhWalRkTjNjaHQrRCt5OW5vSVJ5?=
 =?utf-8?B?V05qSGZhUXVuKzRuK3NiSGJ0dm1RQkhZQ3ZVREVUaGNKOU5QQmVLdThVQkZO?=
 =?utf-8?B?aTFBemdwbTJIeFAxeHlJZTBqVlEzRWtueVZLUm4zc3ZPZFB0Q0pNUCt1WExV?=
 =?utf-8?B?Z1ZlaG1jQnlZZk91VDJZTTQvai83S1hMWTJmMW5Mcmt5TXhHbXY5dm42YWJI?=
 =?utf-8?B?eTZYVVlrQ0J3ZFcvNVhTWkZpYXJVRFBYUXM0bVVIYXdmZExHUFBhV040YkxD?=
 =?utf-8?B?c1NrTnJZSExmVWExaW9tVDh1T3JDWjltY3FoU1J6ZDkwMTRPazBXNTlsU21n?=
 =?utf-8?B?RFRoZkpKMEhNODhNdTZHYVdFdzNyaDZEOWpPd0JaTUp5NjRkTlh0aThNVGNZ?=
 =?utf-8?B?U2ZqK2ZXcXZtcHVaSnpFZmhxeURNYTU3RndVcy9pU281d2hCMU1BYXhnYmE0?=
 =?utf-8?B?a3hXT3Zxa1Qzdzc3RUZxUE5laEdMQ2Y0d1hZSDZQNXJXVU5jc0dFeUxnQWtO?=
 =?utf-8?B?T1NkSWRReHkrZmtSUEhpSkRRdHBOQy9FWmgxdHZxV2dTa2R3ekdCb0JGSHFr?=
 =?utf-8?B?VFVWRXdYRHhZZVB5L2k5TjV4MFpiRXc4NThUU2lPM1F2cTBMQTVSR1N5TWFC?=
 =?utf-8?B?Q1JBekZheVpTdHJDNTBZUXdoOTRPZk5Ma1FQVkhuRDJpN1kxWnBMam9xMTVq?=
 =?utf-8?B?aFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTV3U1dCRzRwM25XTEVzU1VIUy8rdllLY1V1dDJMeWpZRTc0K1EybW5KN0xB?=
 =?utf-8?B?c1RaTmtRc1NFTExOWlU2OUdrNkNpRzlxMURsakkybDFJSzRmem1aaHZLWk1Y?=
 =?utf-8?B?SXRiSVNTenREZUVsMWRBSXh2bk1ZZW5qWWpqV0NreXNnZTg5K3lDSUlUMlNC?=
 =?utf-8?B?S2JqRFRvSkkrNkxvZngwZUdUaWxybXFGMjR6OFR2NFp4TTZXK1BuUWdDUmYy?=
 =?utf-8?B?dkxwa3BGMkcyaEpXTm9BU01kcjJaQndXbFVSQTU0SHgvc1k0T0NHL2piUHBL?=
 =?utf-8?B?cG80MFVGR2kxcFNwNDhBaHpoZlFKK2oxQ0FQbXIxVkhKOTFJQ0NyU0VuRCtx?=
 =?utf-8?B?TGNoZi9VQzhWWmpWc281dlBuM1RqSkxtTkxGQURuSFJSTHBpRysvS0poRStM?=
 =?utf-8?B?MHk1MWVoNkdxVVc5azJjVU52T3lPNld2Rm93eFh2OW10V09SOEV0N3J1Mmdu?=
 =?utf-8?B?ZVpLT2s1R2J5OU1UYmVBRitSN2xHUGw4VFpZK09rZ3pLT2JPdG1GaGV3R3pn?=
 =?utf-8?B?czl1d2pzU2lPUCtIbll6RkoxeXV1VWQ2U3paTE9Hd0RzczVNM0NZdTl5SCt6?=
 =?utf-8?B?M3lrMmRIOEM2b0UvdnZDYjZ4dmhBUlB6S3ZRZkhLc2kzREl4OHk1Skltemlu?=
 =?utf-8?B?WWU1VExPd1h4L1dVS21kOGs2ZmtUSWpiM0JCTzAvajh2djl0VmFnR20xd0Jj?=
 =?utf-8?B?WndiYm5xSVBPV2JVOEdBdVlnYXcxK3duZkxZVm9FZ1o1SWIvdmpDQ25rQTJ4?=
 =?utf-8?B?T293MnNnL0N1N2RobnZnMDdPc0YxNmlBRUM4OVJFYWtxeFEwNm5TTlduYXZs?=
 =?utf-8?B?NERvTGllOGQ0NGorL05wa0U3SERQazd2UXRYMWppSno1T1B1bTNrMkFGOWNj?=
 =?utf-8?B?RTlJUkhGSStjdlgwL2Zjci84WnZUZlBwVmhYdHJYQlU5YzlsQ2hWcjdzSjdj?=
 =?utf-8?B?eDJTUllmVmFmWmhmckc5a2FCaHZ6dmEvYnY2eUZPNFM4M09lUWFaM29NenZy?=
 =?utf-8?B?NU1NMjAvSTRxMTJtQjY3U28rK3B6UnRNM3lOcjF6RHMzdFEyN1Y2OHJ0WWdZ?=
 =?utf-8?B?Wk5ERys3MjFxUUR2T0lhSC96MjZkYWl6dmhIM0lnSjdVdG5mS20yc3dpSGhZ?=
 =?utf-8?B?bVZwYThNQWkyTXMrc1dmQjRVaDdwNC8wMmxlWGlJOHNLSm5NRFhPZk5Zakpk?=
 =?utf-8?B?OW5qS1g0TURPYzFvZWp4R1BhM1pIMG1wSysybGpwWTNoVEwrRENHZWRuUkZK?=
 =?utf-8?B?UElNTjlJM2w5Rmp2ZG9NWk9Obk8xV2hWVG5QM215cFFEMHJlSk90SU5nRE5j?=
 =?utf-8?B?d0FaSWdIREZ0czVlMzhLSnV0ci9tNnlDU0NSZUp4dGJVQ044SlZiMjRzcVZX?=
 =?utf-8?B?aWdCVkxRenhIYStBclJKMzJSM2FXNWdpbE5leGpKSERCSVFOYUtEQ3dWZGc0?=
 =?utf-8?B?Mm40NGU1SzltTTRNbHBDY1E5dzNHYTJ0aHZ4bE1FQ0l6WUZlV0FISDFTZ2Jz?=
 =?utf-8?B?M3JSL25MZ2dySjA5QUxiVU42UTNVY2RWQWtTckxDeUkxVnFqNXBZN1hGRFhL?=
 =?utf-8?B?b2puTlRjNWtRZ20yeTRxTHZ5K2YxY1R0QkFWYWRyTm5HR3NRN1VucnYvbm1Y?=
 =?utf-8?B?ZWNTYWN0RzcwdWlBa0NHU0lDdzU5eFJaNVlyaHNjK3BIa2JyekR1OXN0ZlhO?=
 =?utf-8?B?VkxqNE1abmp0TVJONjdzampxUnpmMnZiN2tUMVpKN1BtNUxHaFFINDg5aW1z?=
 =?utf-8?B?N1BWYTlyWTNVK2wxa0dXV29QNG10OFhIU2ZhZUJuc1poeGk1YWVvb1F0Mzcv?=
 =?utf-8?B?dnZ3OTIvSlk2ajlzSGNjd01FMkNsZ3lOdHRYV2hvZVREY0ZlVWpBdjdrL2o4?=
 =?utf-8?B?WXhPbWtEcERwcVV2UWFPdmtpazErQ0ZxNmxUYkdKMEpvazFWRWF6bDRIanVq?=
 =?utf-8?B?Snp4TlRhOWlOWW0zNThOY3k4TWtaRXhrVUREWkNnRHl4R0NrSWMvOU16Q3B2?=
 =?utf-8?B?R3hZNnY2eDZQZDBoazNBNE1HWENDNDBtMVp1MUJhSDFiRG5DMHZRSnIvRzYv?=
 =?utf-8?B?WkYyMGQrbHVYNFl0RWpXVUxVeDNQQ1lQL29DVW5mbXVsRWNoWTZNdVF2YzFM?=
 =?utf-8?B?T2RFUWdTQVZ2TVJvUk5tNWwzSXV3Z3NIdzJ4NlUvYnM3U2lRK2dEYWV6cFBN?=
 =?utf-8?B?N3pIWStucjlrS2dtRENVQm5jalJLczFMZ2xudXB0WDArVDhpQVVPWnNrY0lT?=
 =?utf-8?B?UWpUTFdlaWtSb3lZSmhCeTBhR2FPenZZUXNkTXlDMUkwUUhiSnFkMnRGcSt0?=
 =?utf-8?Q?0choUfQRI404RbCh1c?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e0138c-6900-45b9-58f8-08de64bace46
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:31:02.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9PNgxIXqltwjE2AplAnl+NTevzW+5of4cFUswiA5syrUyfx9bEUPifEtNEluALH0FUR5/Sw9B0aslvLETkkUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7711
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76451-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,garyguo.net:email,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Queue-Id: 7538CF347C
X-Rspamd-Action: no action

On Wed Feb 4, 2026 at 11:56 AM GMT, Andreas Hindborg wrote:
> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> There are types where it may both be reference counted in some cases and
> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>=20
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the type is always
> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
> is possible.
>=20
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>=20
> Original patch by Oliver Mangold <oliver.mangold@pm.me> [1].
>=20
> Link: https://lore.kernel.org/r/20251117-unique-ref-v13-2-b5b243df1250@pm=
.me [1]
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

I think you also need to update the `AlwaysRefCounted` reference mentioned =
in
the `Owned` patch too? (Or perhaps this patch should be moved before `Owned=
`
instead?)

With that fixed:

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/auxiliary.rs        |  7 +++++-
>  rust/kernel/block/mq/request.rs | 15 +++++++------
>  rust/kernel/cred.rs             | 13 ++++++++++--
>  rust/kernel/device.rs           | 10 ++++++---
>  rust/kernel/device/property.rs  |  7 +++++-
>  rust/kernel/drm/device.rs       | 10 ++++++---
>  rust/kernel/drm/gem/mod.rs      |  8 ++++---
>  rust/kernel/fs/file.rs          | 16 ++++++++++----
>  rust/kernel/i2c.rs              | 16 +++++++++-----
>  rust/kernel/mm.rs               | 15 +++++++++----
>  rust/kernel/mm/mmput_async.rs   |  9 ++++++--
>  rust/kernel/opp.rs              | 10 ++++++---
>  rust/kernel/owned.rs            |  2 +-
>  rust/kernel/pci.rs              | 10 ++++++++-
>  rust/kernel/pid_namespace.rs    | 12 +++++++++--
>  rust/kernel/platform.rs         |  7 +++++-
>  rust/kernel/sync/aref.rs        | 47 ++++++++++++++++++++++++++---------=
------
>  rust/kernel/task.rs             | 10 ++++++---
>  rust/kernel/types.rs            |  3 ++-
>  19 files changed, 164 insertions(+), 63 deletions(-)


