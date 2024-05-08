Return-Path: <linux-fsdevel+bounces-19133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C68C063D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 23:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043721F233CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 21:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914C1327E8;
	Wed,  8 May 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bfilkXT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A08131BA5;
	Wed,  8 May 2024 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203555; cv=fail; b=nZlMq8W08NdZEAmHg1GUj90tdXXXVZuk5Z4b5wF7uSYLA29LKkSr0cwhBhih4Xihze4DEaOgSEMag2l7ydkAkFyn6UFfjBE0E976u8AA3MTg+PjfAWcUm9J7gK/i66TpwAKRTZ4kwp7y21sATUub8UdEShq/vytUZEwwgOqh1Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203555; c=relaxed/simple;
	bh=l6VfTOotfz6Rldz6LgFSlN7nKyf2BuKuTko3UgREFck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kbi6hGcMt4ubV3FzYIcLc5RQCc596/8Z2rVFm5uMXMFiVXXBjLHRX+PS3QTRPITnYZXD7oJmeIhDUgquIrUE184bV4CUKUgs3HzvN9jKW52T50ieshLqcTKKRWB9At9yN1QrgxqfH+X2xu1SiO/3PSwFMLwGny3dLjPNPtv7fw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bfilkXT+; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAWGDhPE46U+L7P9i6ggktS3AzE7G+t+t9844EkFSJPNq4Y4EvWTsB0cJOKnZnIjlLEbXUlvW7yMLxf0sMw568nKUfoBWkNjpDpKkOtkIBcD6DxIJY21WkgEkgpJcBGQk/vsAb3sXwayMIio1SN6yfoTEfKGCefRTCKm/W0Ao+ms4XK5A6VdNtoHT4KnGDxC8Yjvj5ohtE7pYrpBRJNpyER4u7qtQj8LVB46tgr+/oOlqu/9vg716SJ9+EWVJnWKmHlfb6N63T4jq4CxJIqhTgu4Hkm0OTZw2YQGsfVdsQo3L8BcRdN8VTk3iixHdx2+ZFFNOP4TJqpJQbFuxk9lZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nZte4yQVtEh8kv8G4Ka6Ch6mvl+712ncrj7FsCY+og=;
 b=e6DHftMcik4KRIADueTLyvRZSrZ8mYMXYs94VzX072XqvpOFOSOGVYUxO6b2e4FpXvBkoa0tENf3ohfBPPZMtXnAvL1hH7fxx9OWHS3dR9tZhoy2cpTX275SjgnNbqci4tw2V048+xFYzCV4jV/BR/e6BQT0c34YejbpxvmWVAcquCUibfidsS9ST8fiEF7Cc5cKY3HHJcjExi6pwYbhtCaDnb/PQf80oayOTdz/LJYAzCQ2zjaMHr+Ge1MVuys7BmUEsw6wKXFAONTqqqyFCwQ/A3QWgvohXlw3cGKzsVcea7jsHGBj6NGr4IuySnQIOon5D1XR6MzkFYLTDEY8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nZte4yQVtEh8kv8G4Ka6Ch6mvl+712ncrj7FsCY+og=;
 b=bfilkXT+B1pyDnAlZQh8fEKVnYdIeVYGbqFYszDMHW4dYuybL9RuBfxX1gl1G6i93Dh0VKHhImdOjQY9rNWL7LVptPVdQkryXjtItEZAoG7GlgjbjLta0ztPXFSUd9WAoYUC/pTrqbULVpPJZ2ZHeMe0rg6Ib7gQRsbEtaEvZ++8ZBkYcJ5kxedaYoQlmo5PahQ3NyoCNyPOG/ryyPgLnVqZiZeGFcJrrpY5/aVwscARniT8PcUIK3iqVjF4M9sI+Wa1c0YEzqAF3T8DCpNbmcdvwQQ8AeqqjmIe8Yyi3nzV7C+KybOnXvKG1z5xpfeaKumZG2erptEe53/gONOQUA==
Received: from MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) by
 PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 21:25:46 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::30) by MN2PR01CA0047.outlook.office365.com
 (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 21:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 21:25:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:25:26 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:25:23 -0700
Message-ID: <dececf86-9fbd-4b55-9db0-05550cd45a87@nvidia.com>
Date: Wed, 8 May 2024 14:25:23 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] selftests/sgx: Include KHDR_INCLUDES in Makefile
To: Edward Liaw <edliaw@google.com>, <shuah@kernel.org>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Christian Brauner <brauner@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, OGAWA Hirofumi
	<hirofumi@mail.parknet.co.jp>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren
 Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, James Morse
	<james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
	<yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Anup Patel <anup@brainfault.org>, "Atish
 Patra" <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
	<frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, "David
 Hildenbrand" <david@redhat.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
	<mic@digikod.net>, Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton
	<akpm@linux-foundation.org>, Seth Forshee <sforshee@kernel.org>, Bongsu Jeon
	<bongsu.jeon@samsung.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
	<afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Jarkko Sakkinen <jarkko@kernel.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<kernel-team@android.com>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-input@vger.kernel.org>, <iommu@lists.linux.dev>,
	<kvmarm@lists.linux.dev>, <kvm@vger.kernel.org>,
	<kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-security-module@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-actions@lists.infradead.org>,
	<mptcp@lists.linux.dev>, <linux-rtc@vger.kernel.org>,
	<linux-sgx@vger.kernel.org>, <bpf@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>
References: <20240507214254.2787305-1-edliaw@google.com>
 <20240507214254.2787305-3-edliaw@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240507214254.2787305-3-edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b61ab3-fc69-4b2f-db04-08dc6fa56c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGEyNTJGUit0NWRCMjZPQ1BkOGxhYXdabGhTbkxCSWZ2b2ViOTZmSWMzb1A2?=
 =?utf-8?B?ZGNXdE5MdnRFOEVYUXNsRWVWZEprVUtlZGMwYlBhQW5BVy9FUHBKK2txWFph?=
 =?utf-8?B?cStpdStRQTI0b3NJTUNwajRvOGl3R2FobnpzTjBBaDU3a0kvK3QzOU5qNHRy?=
 =?utf-8?B?Q3p2eW1UWm5TcXhPSGtYT1BWdVRmamw4WUYyYzRabWVFci9YdjlqUHF0RHdI?=
 =?utf-8?B?UTlDZ3pMaWI0aXlveWNEMmdKbGJrdTBRSDdUa2Y5SjZUdmpETEt4U2habk5y?=
 =?utf-8?B?NGpIVWxLazdrQkZyN2FBREVnMmVsYjdGLzBQZFUyWDA4RVQ4Z1NDSnN4Nndm?=
 =?utf-8?B?RWJXcnFuMFlVeG1Ed0pVVk14LzU3bjNydTI0QUlER0N5a0dTOHFlVFpSdllo?=
 =?utf-8?B?UjFQS0VrUHE1TTNTNHZ1TTFFRktHTElQY3NVRzJPL0RuRWd2N01ueXI2eFBY?=
 =?utf-8?B?U05ET2tpTWVvSWpvUVRkaHpERWdzTGxzMXFhMm1vZ0tpSjFocXF2ZzJERGFV?=
 =?utf-8?B?bzJ4Y3FqU3E2U2JlK0NkWTZYeXF6bmFEbTN5dUZYSUo3Z2pLRlBLWkdaQTR3?=
 =?utf-8?B?NmpZVHZhMW9pc1RhVXJMMElaUFphTTVPbllLSmYxQWpmVXIvd2xRVUlTd0py?=
 =?utf-8?B?VytrV3RvZDJjTDRlb0NLSW1aK0VKcWNIVkhsOGwrZ0c0S3cwWUdld2ZuQkJN?=
 =?utf-8?B?WDNiY2hETnVQem1ncHlnQUtBNDc5TEsvdXNwb3dVNzFwYWJQL0VZTytJazF5?=
 =?utf-8?B?dC9UZDVpVHY2Q0NLV0s0Z3cxWnBKWjRjbFF6QVpJT1VPRmozWHQyOFBUT2Jr?=
 =?utf-8?B?RVRtWjRjV3EwWWU0bTFlWHFCNnpIcGo0Z2ZyZTF5K2UyeEtJeUdEbm1jdXQ0?=
 =?utf-8?B?Sk1lRkQ2Z0VkaWhNcUF4YTBTUVdjK3J1YldyZm9ubGxwaWpaTFRKaFJYaytI?=
 =?utf-8?B?V1R3bkR0dFhvMFpxU0NseXk3RG0xOEtHbHhaMWRJS2ZNN2hjc3ExbnlLdTFh?=
 =?utf-8?B?cWJoWFo4R2pZRTlxVWtlQlgrVng5NlR6WTN1VVlBbGN0Vk9CZWRQWDVZaDdh?=
 =?utf-8?B?SkFLemErZ29jRXFJRFB4Y01BbGl1Nk50OUdhOEdISXhXQmV1eUFSVis4RzU1?=
 =?utf-8?B?cGQySDRJZ1RhNlRGeXo5T2ZrRG1xNTZqYlY4TTNVczFEWFpRTnJUa1JHNXRk?=
 =?utf-8?B?L1JkWWhHTDdrSThwOFlUd1FWbjhVRk9YWEZsTTgzRHdDRnQwdklvS0VCZ09o?=
 =?utf-8?B?UkNzdktOVzNLMEpSRG1PRFhkNnc0TXljaW5WWUxWdk9Fd0JHYnZtWCtjenlV?=
 =?utf-8?B?L2N1akt2cW5lcFdRTXp1UE5jSEp5eDlTbDdlM3Rxai9JVXdscmpWQlljalVl?=
 =?utf-8?B?R0ZtWjFHOGVjTy9va3RndHBUa2FKenAvOExQSTRGSG1qNVYvSmlsaVl4SXlm?=
 =?utf-8?B?MTF2VDJIWWM4WnhwWWlrSkRiSVRCWjV3a2N3U3h5YkM3b3lxeXVNWFJDN0dB?=
 =?utf-8?B?dWhyeFFlaGJKMTZZenlLNDdrMG5pOURoS0dnQU5KenNTd29SaHFwK0NwQ0Vq?=
 =?utf-8?B?M1RxRkV2azhrQUxUUkxBMFl3MEZtNTJRcy81SUNMWGZ1Yno2Q3ZycEhxQzJG?=
 =?utf-8?B?Q3Q5VVl4SGliVmxMMCtVNWFqU2o3a0RtOUcxeEpHTzlKZHNqWCsxSUM5RmRN?=
 =?utf-8?B?YklrWmF4MWNBbExaSjBpbDFBVFBCeU9IV3BQdDVTWkdwWHNIb2dxUmxKVmFY?=
 =?utf-8?B?VWZhQnJvZW05YTdxdFlyOWxmMTdNMzhxZDJVRUZMNUxjNExrSUl5Tm1hNnpq?=
 =?utf-8?B?Tkd3T0ViTk9UaUhkeFVobHZqdTVCQnA5TWIzYXJkVFRhVTlHYkd1WVhtRWZ3?=
 =?utf-8?Q?wj6OSL5Nx2ST2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 21:25:45.5720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b61ab3-fc69-4b2f-db04-08dc6fa56c57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139

On 5/7/24 2:38 PM, Edward Liaw wrote:
> Add KHDR_INCLUDES to the CFLAGS to pull in the kselftest harness
> dependencies (-D_GNU_SOURCE).
> 
> Also, remove redefinitions of _GNU_SOURCE in the source code.
> 
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@intel.com
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>   tools/testing/selftests/sgx/Makefile    | 2 +-
>   tools/testing/selftests/sgx/sigstruct.c | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)

Looks good, and also still works with a clang/LLVM build (that is,
with the whole series applied.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
> index 867f88ce2570..26ea30fae23c 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
>   endif
>   
>   INCLUDES := -I$(top_srcdir)/tools/include
> -HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
> +HOST_CFLAGS := -Wall -Werror $(KHDR_INCLUDES) -g $(INCLUDES) -fPIC
>   HOST_LDFLAGS := -z noexecstack -lcrypto
>   ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
>   	       -fno-stack-protector -mrdrnd $(INCLUDES)
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> index d73b29becf5b..200034a0fee5 100644
> --- a/tools/testing/selftests/sgx/sigstruct.c
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*  Copyright(c) 2016-20 Intel Corporation. */
>   
> -#define _GNU_SOURCE
>   #include <assert.h>
>   #include <getopt.h>
>   #include <stdbool.h>



