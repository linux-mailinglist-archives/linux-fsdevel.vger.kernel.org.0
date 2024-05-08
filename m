Return-Path: <linux-fsdevel+bounces-19136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1AD8C068A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 23:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE0AB20B6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B99132C3D;
	Wed,  8 May 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tls2THxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D2131E5D;
	Wed,  8 May 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205022; cv=fail; b=PP+xx2dG5bwJs92wQuCKpm+MC9yymAWzv0cbYWkxtfXEGS9WvXXyIIuPnI6OsmMIpdlYptUret3H2DDmS6qrsYqPtQycy/PCbUEwghjdq8DJN3xBAyb0F4c9ieghpKWQhOinx2Wp4GcmRjh+8/ClZRSTxUk0MGZ0NgSomZCirQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205022; c=relaxed/simple;
	bh=3FtpswgFysEazPqqLYJAEgnZAp/e3t1CkGcaVApCjbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I9tA1OQPC+U/8Un2jS85t3KvKhCaz0KJfictbOw2HHvJpsL9V5FFZqZBPIw4Kgh9l6YzmTr9bgcYQxoIDWdTb3Au5Ks4zNYhKmeQbVKG3QHoW1rz7+poaY1d6HnuD+zlhfVCRSga7T6awP9az36xn4u+BEVu7NYuVBs3PI3TmU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tls2THxO; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0hhxlTouN/WpJF7AJKuQU8hKrfLkTRhVl+vS73arsnsrzWkTvSAKGzuTeHqjN49b6/JjFrTwBdqQg6+HnnOiRtl8lK+W158OIdFI5aBt+EfObEvyLlKk9/ooJQH//VdSBn180gMGNEiwcbetzf1wUnfL9m4AlDzu0HISj6tPi1QNTj3peTJu+iCxI3NiqqvpOba0/UYnb6W1MYOzJaZ341L9XBP1w/tIKemwIIyxZN59mTJTX9X+zojJlXEKL1gPFoL3tBu31wcEEUrHNBpLHQwSGFyM6Mo5NBJ1FLY8LlhbeG4Fyk9Y+im+NY2m3/2i+4HRH0OoCVPQaJfH7KC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZAYbzZs2d5zns1VgtSIcOYD3tZDUrh9H34juSE5sxQ=;
 b=X9jwscKSlbx5NOyAqHdprqCK02URFBT0+q4pYhA5X2ApnKb74dh4UeUuCZCnAhwOL48jQHkxbuKMe1gEgL0LcPqSOvDEaOoURYqDBQahEbLEvKAw4JiaTDg+UuVorB6OUMdFqAXLWci+vPbgfWk/bcl5CKkRkq1PpHKhBXNWnfNrRTDAKnN+UscAre8C3l9tywv7RAnogFFCYaxrY+XKIIt67P+db6waMIAt7i/UKoDSjnCJjsr7/LDTta/j9aK4fwvyAYk4StfHnBD1NdPcKLyVU6lDedQP9jB9QGS3o1Lxq8kzMPy1pT5k3jEp2HZUx4HCXad8wrACa5ntlSAzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZAYbzZs2d5zns1VgtSIcOYD3tZDUrh9H34juSE5sxQ=;
 b=Tls2THxOTcBGz58K1EJAhijdbNXOicdAxP8MjN+jDHYNUiigVgm6fzJvi0nXngcYxz4CzE6BxoTx1nq3O9n+xqs0kfQnFDnN2YzzXTdmSe+IICTwiPR0s6TSdBRq957VNx2q+32nm9sis8Cg7IWXp+R/0Q+XixmL1dtugAuDgbkrEmMLqFToIO4Mq/7lfmxe2i5+/p8QvzQ/mGqYkHCWfypewc33Sm6vtN9iilNhmwktNCWj3w00R2FOIbpRAZPP4aS2YdlpHvpaAbfyeu6mq4waJm8i+4SponED4+Gq88tZRHscovgA7is7MADDziqkUisMQgHdNfNJ6Jzj+Je52A==
Received: from BL0PR02CA0084.namprd02.prod.outlook.com (2603:10b6:208:51::25)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 21:50:15 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:51:cafe::56) by BL0PR02CA0084.outlook.office365.com
 (2603:10b6:208:51::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 21:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 21:50:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:50:00 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:49:58 -0700
Message-ID: <a28c1e66-db47-4ec6-8481-a114eaab78c5@nvidia.com>
Date: Wed, 8 May 2024 14:49:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] selftests: Drop duplicate -D_GNU_SOURCE
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
	<linux-sgx@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240507214254.2787305-1-edliaw@google.com>
 <20240507214254.2787305-6-edliaw@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240507214254.2787305-6-edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 885375de-c2c1-45ee-7b50-08dc6fa8d851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|82310400017|376005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzZFZDRHVzNtbG5adzk5Vm11TEd1a1JCSEliY2gwQ0NvRXJnUjZZZXRjSGVB?=
 =?utf-8?B?TmliNmREY2twTlF3eXhZRVlZNklvendzdlhsaFNaQWdUT0QxN2cweWtCbkhx?=
 =?utf-8?B?VEFpUzEvTW9DU2R6QUNvcXZITmkxUFZYNGorMHp0WkgzUkRaYW91UWkvanpQ?=
 =?utf-8?B?RnRsK3JuSVAzTjh5cCtKZGUzL0JSSGw1YXdMM05zNUpHaUVsTXdXYTRaTG04?=
 =?utf-8?B?NUM0UmNzRVlIdzhmQlMybDFCOXoyczNOdGtnTnY3YWd5SkhyTXVpUFpHYUV0?=
 =?utf-8?B?RE1PY3VIb0VkT0NKN0RpRk9jZWlNU3M0QWkza3htMjhkZUoyYWorb2xKZ1ln?=
 =?utf-8?B?REcrVnplN1piMVRpalpZY0xPQ0J3NGhvMWVqcktoaHdsd2d2bXpaVDIxSThJ?=
 =?utf-8?B?eG5Ydm5vN3E1OE81bnVXR05Db3RacUFIVTJjb2tnL3dHemtSZTBRY1V5ZzRW?=
 =?utf-8?B?ajZXZmdDQVpXc0ovc3JBcVNkMkZYNzJsd0s1RUxlTmcyK2hwTFJ4NUdjSVhL?=
 =?utf-8?B?SGdIejFBMUdiaVVuUEJDNzBjaUNVTkJBOGJxVDZ0WUhMdTV1NGtyb3owVmQ2?=
 =?utf-8?B?YTZTK1hXdmhZSmpQVGVNRHRlMHB4VWlnSStPYVIyMFFYeXZnV2h4V3R4Z2V4?=
 =?utf-8?B?ZlMyMFZRQTNGR2JWd21PVG56YjVaUkx5anZhTEdYVUxIK2puUVpqZ1ZsUUR0?=
 =?utf-8?B?dzZia0FWcVFuaktnQVMxRWFVVEZueHlHTjMvUDhtWmp3WnhidDFWUWZSYlZM?=
 =?utf-8?B?M0FOM2JETGdMUHFuSDdlcWNiekdIdUVwclluMXRJQTVpN0lXYmN6djBuaUZv?=
 =?utf-8?B?ZGtQeVprekx3ZWprbmtwcmhZaHQvZFpyK1g5MzY2U2xnb21uVmllak1SWmdl?=
 =?utf-8?B?OTUyZVhQSUhDMDVNN3duQWtmSWc4clZNcC9rMDBqa1E1MU8xZWNwZFFpZmtO?=
 =?utf-8?B?QWU0SloxNmxBblp2aU1ySmN3dUhSWk9xVmw1T2dXREp2TlhZQWZwZFUrend0?=
 =?utf-8?B?WGxiU0dDNjJjTWMxL0dMdlJiN1dqOSs2alVkNE9LaWcydjNJNmI4NDd1NVVh?=
 =?utf-8?B?ZzJiaHovM0JUVk1ISENhSzNuMXVIcnRvV1A4TTVwQ1NTS1p4NVlPNS9tYjNr?=
 =?utf-8?B?ckxUaE1nQ1N0TjZxN3Y3dklvRXgzYTdiL1lTaW5EbWVGaVNnRlNPYm1kQWlI?=
 =?utf-8?B?Wkxsb3VqSTYxdG9YcUdUdFVXajRXRzQwUElSWU9XZEpvSzlxLy9iK1R0dFU1?=
 =?utf-8?B?UHgrKzV5RVNkQzEySStBRmN1L1RCeXovWGNENmJJbXRiT1RCZXp2TmptQVI2?=
 =?utf-8?B?ZThXSlo3dkFSYnJRQmcrZjZsYSt1L2tZbXRyeTAxOFZONXFhTGY2aFZPVlRN?=
 =?utf-8?B?ZUZNNjRQQTZWQVRWZ24rWklJTTZzMnNpWkRyWjlwcWp5TGY0ZnhiRmtzOGs0?=
 =?utf-8?B?Q0R3U2UzczVhTklCZktoVjh3N1VVcWcwMzZrV1Fad2lRV2Fralg3a2o0Y2Ja?=
 =?utf-8?B?aDR6TDh5bGpqZDIrYXlnTDVEd2djeHNaZWNJMjR2RC9pbCtncGZvUDNXT2dU?=
 =?utf-8?B?WHhpUUVPeUc0NXNZd294alYzeTQvS3NNenVFQzIwcVB6R1NjZGU1czJrcTJn?=
 =?utf-8?B?Z2d5bFBCOGNpbS9OOWdOK2VrTmlzdkh0cmM3aUMwOXN6WXRYNlNtUXJvaWY5?=
 =?utf-8?B?Zjlwd1cwbUxGZWtwRHBNaHppLzdnOTJ5Mllwb3RhVmpjb1UyVmh6aUViUy8v?=
 =?utf-8?B?THBTazlXWWlDS1VFd2Qxc1REK0lHM3gzaThXQW9qUlFwOUEzZHc2Q0JlWjIy?=
 =?utf-8?B?THd2MEpCVWtEODR0ZXA3V25yeFJSTENoamhlU25IVzJJb1M1MXZyZlJSQ0NC?=
 =?utf-8?Q?fhRuRJiDVAqDx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400017)(376005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 21:50:15.1206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885375de-c2c1-45ee-7b50-08dc6fa8d851
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

On 5/7/24 2:38 PM, Edward Liaw wrote:
> -D_GNU_SOURCE can be de-duplicated here, as it is added by
> KHDR_INCLUDES.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---

Most of the churn in these Makefiles can be avoided if it is possible to
take my recommendation on patch 3/5 [1].

However, as it is, it is correct, so if the above does not happen,
please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


[1] https://lore.kernel.org/all/ec8ab737-a841-4cd5-8ec1-e0a777744262@nvidia.com/

thanks,
-- 
John Hubbard
NVIDIA

>   tools/testing/selftests/futex/functional/Makefile | 2 +-
>   tools/testing/selftests/iommu/Makefile            | 2 --
>   tools/testing/selftests/net/tcp_ao/Makefile       | 2 +-
>   tools/testing/selftests/resctrl/Makefile          | 2 +-
>   4 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index a392d0917b4e..f79f9bac7918 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
> -CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
> +CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
>   LDLIBS := -lpthread -lrt
>   
>   LOCAL_HDRS := \
> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> index 32c5fdfd0eef..fd6477911f24 100644
> --- a/tools/testing/selftests/iommu/Makefile
> +++ b/tools/testing/selftests/iommu/Makefile
> @@ -2,8 +2,6 @@
>   CFLAGS += -Wall -O2 -Wno-unused-function
>   CFLAGS += $(KHDR_INCLUDES)
>   
> -CFLAGS += -D_GNU_SOURCE
> -
>   TEST_GEN_PROGS :=
>   TEST_GEN_PROGS += iommufd
>   TEST_GEN_PROGS += iommufd_fail_nth
> diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
> index 522d991e310e..c608b1ec02e6 100644
> --- a/tools/testing/selftests/net/tcp_ao/Makefile
> +++ b/tools/testing/selftests/net/tcp_ao/Makefile
> @@ -26,7 +26,7 @@ LIB	:= $(LIBDIR)/libaotst.a
>   LDLIBS	+= $(LIB) -pthread
>   LIBDEPS	:= lib/aolib.h Makefile
>   
> -CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
> +CFLAGS	:= -Wall -O2 -g -fno-strict-aliasing
>   CFLAGS	+= $(KHDR_INCLUDES)
>   CFLAGS	+= -iquote ./lib/ -I ../../../../include/
>   
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 2deac2031de9..5073dbc96125 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
> +CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
>   CFLAGS += $(KHDR_INCLUDES)
>   
>   TEST_GEN_PROGS := resctrl_tests



