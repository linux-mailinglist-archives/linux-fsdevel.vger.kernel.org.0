Return-Path: <linux-fsdevel+bounces-72683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB2CFF93E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 19:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ECD03017876
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE2355035;
	Wed,  7 Jan 2026 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PS8sjblm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E1342CAD;
	Wed,  7 Jan 2026 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812103; cv=fail; b=dJx0YHlUIYDMcB9BPONfqvUKgMJLoL+A/qcmIOStWIink+nvA+A7r4pIGBuP5dhj2K3WtNvlxH1QDLcsd9acwu1BKq8n/Mw5PW1XrVbVpAqKfBp5Gvp/7OdF/GFm9Z+7P4rPB8ypyNB0mjuE4mXqshrLEUMoQRS6Pd5IdIuVSHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812103; c=relaxed/simple;
	bh=t6L3QvaDzkxifxCtAms08ALjicfkDe8Q0xYJH4wy0ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jhygwPPZJ5CoaQ7dvs5sNRtzYWOw7/JYCTzbMcxGR86o0m111A3AmVcPtX/VW0WnW7qlxoZU4q4hLwc7ncg5VBaNjZZZb89BbH/RofbgIIqm+FRqoYtGcxZ6ptEOr0wL4jVhbzFOSN/o2CKj5kt1EArXVyr6ls838/3xNiBFqoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PS8sjblm; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zaz+72AbJEnkpN9w9gdA/3yZ1tzSbUpNyzKjNq6CpLBUK+wWB2t416Z27twgu00B2n/Jw60oweQBk9J/tdMoZdWKZ6OPqqUaqP/on1hpDmplDrtkTEv6ZP+DiueEHMQCGrAQjBCszz1CXiqPiXkbdpbPxwvWv+zNwXyUMRoYKF5GZVk9zkFXXFDI57f1qc8rLAg/tSNewVBZmW9gRiDm0WrxTXJY9KaRxCXLAYgx3pS5LfCMtvhAfWP/su819WmVnq/b5OS7dWwEC3qhnKGgLlqW+x4CHIhtbYhhcwLg3HuQ/EeybM8XMJ+qDyLMKERu1uYXSOtuVumTtfuXLFSeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6L3QvaDzkxifxCtAms08ALjicfkDe8Q0xYJH4wy0ys=;
 b=Szm/K/lgDO0NePQUYKz/41r7R9gj8QKIUWvNyH4r80qmtX1DWmZz1Thw0pecyfDW64ln6EjG5Wm6XevXLoNkrI0GW0Z8pLX/5NseJ8o5N7TOEm8PZuZrygg7RNpZnSrp+0sOPtUdxUT+fZXmCqolbZkF/Aa6YKEn8kwsvNYCTa/5CRTnUXD7T/DTXV340kYJSrqM8n7Ma08l+ln443ugFBJzZ5Cv4n1b7aRIMaOPzzPrHy6G7z+f/2g9cUhnQ2Zd6jiMxdlsKOq1ixE9axWRuMsEJggtu019DQA02s3seQqfRWZPDg96hMVQgEhavbVMttPkj4+TLShQeRIJpGov9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6L3QvaDzkxifxCtAms08ALjicfkDe8Q0xYJH4wy0ys=;
 b=PS8sjblmp5LPfweDIGDuFuaV7LqzqXZlQpgud6bIsUweJ9sONzmtw9k35ZbASjf0U7F+gfq5E3AlJ6vsWszNtHWJPLolkZ/c6K/eqmh1BVJZT5pGoj6A5aQBC4+LTL5lQPKjkxn2NUEHxDeO9THum/3P+lOhyrjVpfyOb7FwTf1PFbIzJDXRVeSB7yXErdi6GaM+GvVNfHcROKg/XVqxwrywk8KHj2LM/EcWSlUupkabXWW9W0kqB9R9VXOlNxZrAdMZv7WzVlJD3o7xtaPZAk4SsddSWQHKGbSCtCZ0Y+r8f0nwJWaCltY4U2STc+feGiP8QGWFHSE1Xs0yaJHdXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 18:54:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 18:54:55 +0000
Date: Wed, 7 Jan 2026 14:54:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org
Subject: Re: [PATCH v8 00/18] Live Update Orchestrator
Message-ID: <20260107185454.GH293394@nvidia.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
X-ClientProxiedBy: BL1PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 63be3ad9-2476-41a4-41d1-08de4e1e3f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oFuTuRjp6i2EfW5vB7bhzX/wZLBBshNTll+8RDiu1Ts8xTyOIrCQnjUxSZqs?=
 =?us-ascii?Q?jpvtxAaqzZN/dx9il92gjy9tdxtxV36aboAvFTE7FA/diVWBtWVyDTnWn6mp?=
 =?us-ascii?Q?WqAfwfvXRBI/JQEzrryqoQmIkvKMSwmTmxx80vE7lZW6PgEfgcmgffxnCH5K?=
 =?us-ascii?Q?1KrRxqaIKIbr/0IeIyt5zLpdOYqpTTNRn9f6bRoBhHCfpAS6esD9e4H2a/yL?=
 =?us-ascii?Q?Ldp6DTvE169MF/pxGHmLNpi7/qA5gLNf0ezEQfuKc9MkLyaAMZbddK4emfc9?=
 =?us-ascii?Q?6o2dBZK+Lre9/lQQ+Ki/p6DppHphLBW4bqBRBK+yLKT/19b2XGm05IRbt9BK?=
 =?us-ascii?Q?+tbHzrcwgi4J3Zz/jdB8JyqW9ys5Zfx3UpD82LowCmJ2wNevzd3mKdYrKAF+?=
 =?us-ascii?Q?dd+QhjMdJLT8k1Nq4qSI/W3gy1PG+dJJA+6ekv3F2rmqUu4gmuEzyGIRtzzg?=
 =?us-ascii?Q?enbHgbVwgmlvnfpnEgetjuYDh6AiN8BoloCbmoDL/p97cODBY6g20LahimeZ?=
 =?us-ascii?Q?UFZW1Drs+W3sjssdXN6mFQoGkN2M7lKaJA1ebmscofiO7drIujrMwmnaEikc?=
 =?us-ascii?Q?3Fu2QykbcR5Iaw+K5mrEf8qYuHgnqamg5pVot5LStfEOJuW65gWT1JrvToJc?=
 =?us-ascii?Q?OyaTrb++QkkJsCiL5pdfjOrAlXZlmWXBScXse34UGBouqJPlG3aWYUygicWj?=
 =?us-ascii?Q?kPnIgI4F5dvmjR5KEIyaYmzUFLkiUf8noGtpAB7O+IqqwP0pVbAUgEv3Lwm0?=
 =?us-ascii?Q?va0yUXXz72gxws7lbqAGo6nLW0uNbmLSwal4QfvUFehTURTkTGJAMEjAMx5T?=
 =?us-ascii?Q?nU78y8FG5PrNJw5ASv1V1EvgGxVW1Rx2SSYvJ3HUeFaE6Wo24kJFapiMsUNZ?=
 =?us-ascii?Q?7mrmyxCzesAZYukQBBDCpMMOi/JvokFeqC6gkR5vF1UDmzNwuNnuLWTctU5r?=
 =?us-ascii?Q?6PJpz54jQZdsnNKaH0b1+1JtW3q2um4mSCPm9uQf9m8vdn9Dc/61wfUYM5Mj?=
 =?us-ascii?Q?K8xD/2wgrHB3TJgqaNt5Nyls6cOpmmnyVcGIFacqYJLQfnpasPVKyIlvW8Z3?=
 =?us-ascii?Q?Whvc0QHALAdqV4btaGptRjBoHHPsDjaoM8dM4xd7ZMzHBNz8sOeMLtwLvn4+?=
 =?us-ascii?Q?s5xmdCsjlWsbdqOhHlaUwS60OL5U4VSysBhLNn+bz0VQMspoB9hn+7eEokYF?=
 =?us-ascii?Q?h/lpGj9GTNv/j2+esoX7MJO1GkSX4lUgeodhKj/m5EeKtZdYvUfaqJwLNiDX?=
 =?us-ascii?Q?eUuKHhRoR+3N6C8BnJRE9TVlwd1vYc0QFuEMr6lXBsnta+dUVf0X0NyBTD9P?=
 =?us-ascii?Q?6x+CzVBbYnWKKRsvOADrjv+KEWn6yeez5qi1inr22DAFwuHi8NyLn428V5fw?=
 =?us-ascii?Q?+3NWjovAExQDu6XrrVvvLT/ZD6ttDGhhKbBlepC2RJhXBcWEd9YnLARQIk2u?=
 =?us-ascii?Q?FkcZnhqko2TM+WsT08EJ49lsbpZwmsgN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cdLE8nmCEyynsJ4/7t1kL1JeltnL0gmbSHWf+l3ET6pz1j+bhUaiMJ+pS86S?=
 =?us-ascii?Q?8/H8wYYPtVbNzv1/YJGYpLCzJTprniiXrk2FhrNQVoVURaqcag4qY8UnIMbi?=
 =?us-ascii?Q?QaW0PTkVymoaqLq0ZD//MAnjrqbXddxuL+oRsQ5cxCYpZTZhC23JyyWW6hi2?=
 =?us-ascii?Q?qSO8ek1X4zKyIknN3m4ad4+B3Z/ihng1pTfwGr3fy+5aGGf+E3nH/ZEuoi4K?=
 =?us-ascii?Q?giv2FmHgPVj2i3koHoK2jTrRMPt240Juw+YOqrvzo9QDPamoo3B9omNhORYm?=
 =?us-ascii?Q?10WQvbRF8HOoQPcvMJWXY6J2zS/OSrVEtVkBulI2w19/rnQOQQU6/LrQmq20?=
 =?us-ascii?Q?mHyvehMuCa3INqS+e/cJbsrqglNCo2qsgVBcpLiXmv2b6PDBeHn2BX37IitL?=
 =?us-ascii?Q?BLw+05ThfoTqV4twajW8JEJsap4D6hlb8aufva2w3GjYnM/RtCnsF176ZK+b?=
 =?us-ascii?Q?PZuSK7LydTbCJr8rppNGB9i2+kxyoIkB+w5ckTag/DoYrB0s2w5s4PoRebLR?=
 =?us-ascii?Q?NyisLtM7I604v7SYY7dwIfC9z7+20kSg/ofgxkX0KbNWzCZEF+uSljofUcBp?=
 =?us-ascii?Q?csLxYD+f5fBiShUCsfv+K9CrXVsQj0Go7GC6rJvB93at7jwCdUnv5VhLzM5e?=
 =?us-ascii?Q?sas6kevGTAgBpwGSBQJtMHYnsHVWEmoCgLF2FgHXGuL+SfdkGsbP+zujnqpc?=
 =?us-ascii?Q?r6G7DRwFradlqNc5uRhR+S/kIe2UiZnQm6FwSPpdCHK5+pvA1tx1IOTg+M+3?=
 =?us-ascii?Q?yTfgrAo1NwCX4FVtc8VNl9Uysn7gGWycb3InQM5p9ELIW5G0kyDmxOb1EwFG?=
 =?us-ascii?Q?4wcIL58vI1oGp+4oo68ANeAJHQ6bIp8ObFZ9qJKmgFLyVqZpqrpl4XJdRr20?=
 =?us-ascii?Q?MEV3EVKRV1lcmXilyum7VsrbM8rSN/Tw9ewQScW8/AyqjG6AUuAM9+0nxe5z?=
 =?us-ascii?Q?hbHygvMtQdIeSzJLnpvPKpEj4NQM5zy55trMUiqijv00h90Sj/lUGz5HWOgu?=
 =?us-ascii?Q?R9wRupARjV+qcKWT0G4JZNUtG/jeFCEOxH2DQ5OIL6u6PPXbJBtJj4zOtFlH?=
 =?us-ascii?Q?JGIYz0Pend2tELeLF28eD9B781gNaKKm0/DzUghm7aAsFNecsNq+1InF78Lt?=
 =?us-ascii?Q?vup2w+fkEIEhOg+SD7U4dsX0c8G/mGlbfUNaCz09oSJgyPNOLBsnjesP24eg?=
 =?us-ascii?Q?sn/WL+Pix/NsYiWGNkmeeWfaHHEOYzyQ/hHgERvv84Gcats52Yn3MAnfJUMh?=
 =?us-ascii?Q?WEdu4jO5IkBo5LSUEt4m/ii64Tzozlad94vrzOcZBgzI7+oB8r2biwOFQI+b?=
 =?us-ascii?Q?h6909lyRv9KpARQFfJDMCQ//qr6X3/tr0qT04VSRkrhHKSEVXfCalh+lgj6T?=
 =?us-ascii?Q?xz2WVtHXeV7uxMo1DvZsfDls63ltVCaa5ElSwS8XXNSi9lEaq8XCSy0VavpK?=
 =?us-ascii?Q?qnc7MbakPzumN3E4IJrsTdhk27V+2zaB4zGac+ZBypJjdO32S7/lyxTvGHZ2?=
 =?us-ascii?Q?0XyWHRDscp+oypRmHq2xeEmiE0SxEEWJLSJTbEtN6c5NfMscZxPiXmEYU3ax?=
 =?us-ascii?Q?Aw5xNpJUTpJH1LJR8VMdSVXI5Dy6rIr3fwAvZruH4ZbF1HzVqbltgi5UB3dD?=
 =?us-ascii?Q?dvRS54OsV2o2n8OZDEbBMPpTZ2PXo00g+HmVHStyzxSS3mtz16jJ1X7dBHPm?=
 =?us-ascii?Q?KDrGqLao/Havo4uhI3Z+Mns7gRv11c+uWVjI2kyedicLZn9Jj74C3QMNmfQk?=
 =?us-ascii?Q?qyLYLITEuw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63be3ad9-2476-41a4-41d1-08de4e1e3f5b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 18:54:55.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJcG4XHg70YXR32AO0mCJsmbz6YzAniSDLUuE/J73+BGDrO5101NRIGn3ob5qTv1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

On Tue, Nov 25, 2025 at 11:58:30AM -0500, Pasha Tatashin wrote:
> Andrew: This series has been fully reviewed, and contains minimal
> changes compared to what is currently being tested in linux-next
> diff between v7 and v8 can be viewe, here: [8]

I didn't closely audit everything, but the overal design and operation
looks right to me:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

