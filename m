Return-Path: <linux-fsdevel+bounces-57927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CDBB26D37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75019563214
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315761F0E24;
	Thu, 14 Aug 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U6hcEwSe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6563B9;
	Thu, 14 Aug 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190883; cv=fail; b=QODfaOqx6vDyLdAS1p3r5kSezsTYqWn2qFBFxGRnu/nphz/i5/fcbCnFiXtyEGqSJ8Z1opF4txqqxxKE6x+nEsQBjutIt4j/P6WPLzdeVcyarByY6BYRjDuzweN5z6BKudoXbfZM8FXbPtIolHqGCoe3vgU+ImFkKSv3AtlN1Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190883; c=relaxed/simple;
	bh=CpIb8p0XbPxqwkEbDpg2+U46eDJgmewSu6QChW2g9w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S0q836LuDHYvAKGtyiYw7p03aLHRAIYqMjGCuXiLcTSYaDQ28enU+T9ecj0xrTx9eowp/nIjZlgUX+cN0kmxt/fB4X1/xgUMIwCiKEBGj4nZtNJna8iWFA/pV/0BLqdUXnS1TojnSzHAmOYVxPOj5JrUhX7wimmOYUjncPf9Sf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U6hcEwSe; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh22yPO4G6dEPoHOOzlmvfS8vd+/3FC1QB8TyYE7Gl1wM5EPOmXR82uTkdGvWKwezJim9I39OF8AcXZ3b4vVTUc3sQUMIC/OSzT09/Nikm67JgLCjke1FIgB+d1Mma0UwzzSQNuG/D7mc775xzm5il297CziN/NZ8+2R/DaWruf0Og+H83mHKW57CGz61+zFeq/+9kSc6AQD+XiveGI9kQQhoaciZrN6pR12r/aY8fBZzXukV2wsh2iMKUsP/Dw94sQKalZ682h0p9VZkMh/C33hSTvcZDuloZZBKf5pmVa1CpNrWRbKU9NGqbHLPPHopxh9LP7GqXKwTQWGMQST6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAkHsODm7sV5wSKxt5sDwbzE0aBbA4TyFWzR3Rav4J4=;
 b=J8nc0blOQwwbG8qsGnTLKE/iuJwQ2qqGql9v/XKKJhpxqe6nuxiIUtTZtbZCS4PbI4hvnIhowovCR0Lia+C2wfmMio/UyQSx3YaPxMdkspJOJnTH4yftrr9Hy+EpYqKcxVKW6q0VF0USE4QYiGsVxOw4uqOZqNArBkjQ0ikXNPiux7WpRQCk8ga3eyUIlCyyzq1n1PnUikjzgaHv5ltf2ZtV8iMqDJkucwivKgafNx9CdPOsloaC9ELkF9rzKp4S38L4j0IgmAfQeHgE9lJmukwx0fxcXRtx832B3Wx0iy7pMlTNsSnJxT+8ow3F++YDv3uyRGhSVOW25J0hg72lHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAkHsODm7sV5wSKxt5sDwbzE0aBbA4TyFWzR3Rav4J4=;
 b=U6hcEwSe4dOWlEry64r9g1UEVi7bmOITvrHEWirTXDyG3p+cOnHnPwM/bdpKZbOVK7VBkKQfmVAAA0cA+YkwtVFS2Yv3XM6srqJIbB8lf0tY9OGehcD2kPB/sdHV1rIC2STKTbiCz+MNVxBKvXn+2QspqGC3q73jofYgM1nnHz+gN1fSNh1W5dSM29NPT4VsGJ9fDpL1W/kSNvluStXlrB882SYfUadNSONVZ+AN2pdpzFSUm8alSVEVPReKl7ciCuK9l4Y9LsoGdRqJCxyXfS5hcaDZQsgVX+Yrs0PL5wdEgV96tnyS6n+B1jYHGkX1Aqd2Qtw3+GPjuEm6dvKXNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 17:01:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 17:01:18 +0000
Date: Thu, 14 Aug 2025 14:01:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
	witu@nvidia.com
Subject: Re: [PATCH v3 07/30] kho: add interfaces to unpreserve folios and
 physical memory ranges
Message-ID: <20250814170116.GI802098@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-8-pasha.tatashin@soleen.com>
 <20250814132233.GB802098@nvidia.com>
 <CA+CK2bCbjmRKtVVAok7GH8xvh8JWrga5Oj-iK-p=1M79AqvhRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCbjmRKtVVAok7GH8xvh8JWrga5Oj-iK-p=1M79AqvhRA@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0280.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ccb198-01fc-44d4-873f-08dddb542fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3N0RktxSElES2Y0aDRYeWpWWjI0NHo3ZUZqYzBBZlFYakZLcERyME0yT0lI?=
 =?utf-8?B?SE9LUmM0cnMrOVlSQmw5SUJaSVZDZ0xycU0vWHNseWpZb3QrRGRORmJxYkdX?=
 =?utf-8?B?QkJwZE5seHBBaTdJSUltNmFjSm9jakV3TENzVWJ1T25jYnNZSkRuRjExck9O?=
 =?utf-8?B?T2wvSmp1cHM3eFdpSEJaVW96eVJ2K3JIV3NBMWN3eGpRejhhL09JWlh2bFRL?=
 =?utf-8?B?NGF2RG50ZHMyZVNpdEczenBpbGVYTjh6T2JpNTQyMS9uSEptNng5SnJUemhp?=
 =?utf-8?B?SDV5RDBNR25lVHBZRkxHbEtmOWRrQ0hRV0t1bGJ1OHgxaHVDQzl2QXYzQjND?=
 =?utf-8?B?c1RTdWg4bmk2eVpLV3JzWXhPaWtBTU1pNkhKVFc1STFkNzBjTml6SGhyRFln?=
 =?utf-8?B?cHhDZGlRbUhXUFYzNFFCWVJPUDlRMW1uMDlRVU1UeWc0OFlEMWc4Y2dFaUp6?=
 =?utf-8?B?RjNFbWxUbkNrWThvcGNxSElJSTVUMldhNUoycys4K3dSazdOcWZJSlpDYnZE?=
 =?utf-8?B?VGFudHpKeHlLakRCZFJTOHljaGdrWlg0RXBNRTZuT1liMENlZzA5enFkU0d5?=
 =?utf-8?B?Y1p5ZjNuelNhZDZhNVNJQWYvVDQvaE9DZ21sVWVnQ2I3M0FMc0N6Q1lnNW13?=
 =?utf-8?B?ZWJUR3JURFpHNFZvdkJmckpIWWZHMnd5ZzZyUHRzYnJhYXJTZjZqOElCUlhT?=
 =?utf-8?B?RUlRdHkwY2labnRWSkJXQVMwUDZmYnErNmJIcFY2Ui83ZUNWa1NpNDNueTZD?=
 =?utf-8?B?S1lpdXJsakxIVkNNN2dGTVg0Qk5LdWt5Mis5QS9LUURIMStBQ1ljUVVwT0x1?=
 =?utf-8?B?WUtaL01LZ2lCL3BydFYwdjI5cVdFYXlYU0VYVHBlRk1VL0xqSFFBRVYzNGw4?=
 =?utf-8?B?OHBDOEJYblFUaktGTksweTFLM0NsQnN1MklqQjFZcnNSYmZxbS91dUR5NlZE?=
 =?utf-8?B?M3l4QXBDc0lrZnJKSzN2aUxZbWZFOWNjSzA1S2d1dlRIczQzYzJ0YWJ5cFd3?=
 =?utf-8?B?S0pYMjRFM2VrbEQ1RlZRb2Z1V0Y4Mk5lVTdEcmh4b0dhcUhYbDI3NmErempP?=
 =?utf-8?B?K3dFOENHNndabWFVSWI4ZFhodHAvRmI0QWV4VnZKYjMvSGtnb3N4UFZQeTUw?=
 =?utf-8?B?M213RERXT0l4SmZxMEVuUU9FMk5tSEtZMDYyTGorRDUwYUpJZjdFTUZ2K1Rr?=
 =?utf-8?B?NnRNa0h0R3JxWk12ay9KM1ZzSUNpZGswWDczcmdxdGRObnkvZ3RhTFVKS3k3?=
 =?utf-8?B?L2lIWU9BUVpYY0lycGxMTUFqN3duVVlMbDJtZnpvcW1VcTh5TlRvWXduQmFR?=
 =?utf-8?B?bTJoTTB6SUQvNFF3OStqamdtUDJzTHBSL2ZaeG5CWlIxRDdmTko0SkE2ZHhK?=
 =?utf-8?B?NzF2cW1DUHB6ZXVRbGcvQWRzbnQyOEp2N2x2aEthN2ZmYWZ2bFV4azcwSEFM?=
 =?utf-8?B?VkFRcTBXem5BZjVodG54dXBNd05wc2xlSks4Y3E5Mk9qVXBhZWZCdGlENnhM?=
 =?utf-8?B?eStPdHVCTkJGTnN0KzF5RUlDWVJ1WnNyOXhKNkJSanVBS2hYZzBXMTZsd0sr?=
 =?utf-8?B?R1o5dlZlVHcvZFkyeEhDSm5VWFR1MVJLaVFzamZnS2JyZVV4K1BBU3hsZVVI?=
 =?utf-8?B?bGc0WFJMTGh1dEQ4WXN3ZVQ5V3ZwRnVHeitpNzBSeFRCdjVrdnp2eDVROFBi?=
 =?utf-8?B?SXlUQktLb3lvcW9sSTJ3V3pzRVY2M002M29FZEZlRXRraG0xaGJJNTFhbGtR?=
 =?utf-8?B?eXMvYWxwZFVmQU1XeFpWMmlNYjgwcHg1VGVIbFl3ZGxwSksya0o5cnR3OEp3?=
 =?utf-8?B?QWVKK0dUdkhTYThKL2hCTzJ3MmcwaVhwTGIvTnJyTURNdEtVSXhnOVZWYlZr?=
 =?utf-8?B?Q29hSytuc1M2dWJQejR2SHg4WURDMkpWdkxGVENaYWM3WlpEaHNBUVZ4blVy?=
 =?utf-8?Q?1KNVGaVQglE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFCbTZIa1R1VHlqK3RvR1M1ZG13Zmw1Y3VGb0NrR2pGZ0E5TVl4WVFzemcw?=
 =?utf-8?B?aWEyVG05TDBwK21NTjdqblF3WFduVk1FcEo3aS9qNXFraDRpR0VWWjl4RWg0?=
 =?utf-8?B?VXh6MmJ3VnNtTjdoZ1d6Uk82RGh0WXRlWWVjK25ORWZEU1ZJQjd3a3Z3cDBL?=
 =?utf-8?B?TEhyekpQb01yVzFBcHZacUdNWU4yOU9ESFdETFlzelhzTEltSjcwMi9lV2wx?=
 =?utf-8?B?KzAzZERMRWVOaHhCbVRNSThGbmczaE9rQ0ErSGRIQklBS0Rqblp4b3kwQk1B?=
 =?utf-8?B?VndMWkVUUHovWGwvOGRacEh1R1dSMHdxYXdLcUdvVEo2U3o4MldyRStzMllT?=
 =?utf-8?B?WDgrSytWQ1k4N3JzT2JSMElUMnZGNmJiOTBjUWtMU2VJYlZPTUpUOGR3TWdw?=
 =?utf-8?B?anJ3V1F5Qk5pWmNMcWJnMEZDbjAvVUMwb29IS251bnVxVUZQdmNldEdFa0gy?=
 =?utf-8?B?ckxUdndmRGFGNkdKYk12OWJpZ1JvSGx0VG1FTVczL0xISktHaDJVM2s1S01I?=
 =?utf-8?B?Q01Ud1d4ZWNkMnNEN2d1WjBoYXYrL0xtRzg3NDBGb0ladDZTUzBMbDdnQ21H?=
 =?utf-8?B?aERoU1luQU5xLzhISUdyaWJxL3g1YXhQN2dJd3l3eXJzOWpHS1JZT2JBakZI?=
 =?utf-8?B?KzBBc2dMOGxPN3ptOWxqdU5XaHlVRXRDNEIxdFhjNUVRWDEwUWt0WWFMYnJw?=
 =?utf-8?B?V0lOeFNJck1ZQ2kycDZFWDBoRkd4UHZXS3p3M0srb2wyMHIvMFNTTUpNZzBw?=
 =?utf-8?B?c2ZoTENsakNJZGJ5dEdmRVM3a0NENGU1VGZleDJqTTBRNzF5TGsvZTVzc2Ru?=
 =?utf-8?B?UmM3L2lNdXdHekp1KzdQZnljWlJlRVFPV2N5UzlJZHB3SUNjMVp5WVdaTzZ1?=
 =?utf-8?B?VHlFeGNoZ2txRXVaRnUwMmZHdnUwek9aeGNiZDNna2xOaWZma2pmQWpEMVEy?=
 =?utf-8?B?V0toT2svMlhsYTlYSGVSMVVXODZUZllZNEJ0T09lWXBqVTU4citLcFdXbzVJ?=
 =?utf-8?B?Qi9Lb2tyVTJqTEttcUs3d3IyT01HTnlwdkhPcWZBRmx2Y3o4MERrcHltWmhT?=
 =?utf-8?B?dGVoRjZZUXJZWUdjTmdlTEJCanprQjExUUwyKytQYlcxN3hlZUZtd3I5N2Zn?=
 =?utf-8?B?MUh0U0swU2JoU0JJb1pGdXQzbFA0V3FiU0gweGt1ZnNYbmdIMUU5YndCRk14?=
 =?utf-8?B?NFlKT2ZIT0JveldyNUJsVUQ0NG5nWXludFZiNUNGNUhxUFRqR3hERDdaMHFS?=
 =?utf-8?B?azNLdmpueGkyR1VqVExwODBiNUNJWFVsN0JJeFpHT2xLY054S1JpK3VQSnJm?=
 =?utf-8?B?ZTM0QnRaaUltMlJENExLNkNDTjIxVXViQTF0c1VZMVlmTGFyc3YwMEZmWkZ5?=
 =?utf-8?B?MTZuR2djZlhOVUo0VEcxQkQvUTRlSllMVVF0VUx0LzBHeURkOFo4SHcrVHFI?=
 =?utf-8?B?TnpZWjVGMzNRa2xETUVUQ3VKcDhrQjdDK1RFeFBZSmludFc0Z1BNSEdSbmtZ?=
 =?utf-8?B?NEtLN0d2YmdMQVpzTGU2ZFBQYTNrQ0Rxb1V6NXZJM2E2QUw3VUlLaVJwUFVY?=
 =?utf-8?B?L2x3NHI1SXkyTkx5QUxlT2t2Y2VSdWd1QTV3UGJnNzd4Y3VaMTRKNndGaG9B?=
 =?utf-8?B?SFVRVTBwK2RJRWllRHlKdDBkUCtwdHhJaW5LbnNBWlJ2NGxER0dibXBmZmN2?=
 =?utf-8?B?QjJGYjd5L2dVUGlsNHExQThhcFg3VUpUZmhCZ1JvWGtkbjM2L2lEZnhFN1Vw?=
 =?utf-8?B?ZDBFdm9vRUkyWkZ2alZCVlg3Tlh4RjJlaW8vd1pnc0VWcElOVjBGTWRyU0V5?=
 =?utf-8?B?UnRucGRUTnIxYU42ZXBxT29mY0dBWnRxNzU3eDRGUVEwZzJqbGIyWTRpTUpX?=
 =?utf-8?B?Q2tvMGJsTnlBRzBWT1BtUm9RV24wVVFyekJqVUxMQTh1aFVhZGZ1akZOTHhY?=
 =?utf-8?B?Y1hGRTQ4aldTdUc0eWphZTB0dHRQYzNvQUU4ME1zM2NzMmJzSDV3OHd5cThU?=
 =?utf-8?B?YmdWajhYRHIwYWN2ZlRDV25WRmQvOGdkemxUd1A1R3hycGlrWVBBb2NTVmpo?=
 =?utf-8?B?bnR3OTRLMHpPN2d4QmVUQkpVb05KOEhObk9COHRyeDFWOXRXOTFQUXdOZHpO?=
 =?utf-8?Q?nvyM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ccb198-01fc-44d4-873f-08dddb542fbc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 17:01:18.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaik2LEhNDqeZzZzWbhJLR6iWzrhkxR7gLl4F80QV8LmdhBSqF5NDNqGNahrHs88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

On Thu, Aug 14, 2025 at 03:05:04PM +0000, Pasha Tatashin wrote:
> On Thu, Aug 14, 2025 at 1:22 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Thu, Aug 07, 2025 at 01:44:13AM +0000, Pasha Tatashin wrote:
> > > +int kho_unpreserve_phys(phys_addr_t phys, size_t size)
> > > +{
> >
> > Why are we adding phys apis? Didn't we talk about this before and
> > agree not to expose these?
> 
> It is already there, this patch simply completes a lacking unpreserve part.

This patch yes, but that is because the later patches intend to use
it, which I argue those patches should not.

There should not be any users of these phys interfaces because they
make no sense. The API preserves folios and brings allocated folios
back on the other side. None of that is phys.

> > Which is perhaps another comment, if this __get_free_pages() is going
> > to be a common pattern (and I guess it will be) then the API should be
> > streamlined alot more:
> >
> >  void *kho_alloc_preserved_memory(gfp, size);
> >  void kho_free_preserved_memory(void *);
> 
> Hm, not all GFP flags are compatible with KHO preserve, but we could
> add this or similar API, but first let's make KHO completely
> stateless: remove, finalize and abort parts from it.

Right, in those cases we often warn on and mask invalid flag

Jason

