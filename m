Return-Path: <linux-fsdevel+bounces-19141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718288C08C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 03:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DBE1F22001
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 01:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ABE41748;
	Thu,  9 May 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mjjYm74W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E608FBEF;
	Thu,  9 May 2024 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216667; cv=fail; b=cVIptdx4sY9oewavT5PLAIeJ8uHKuYm6NY60WRiozoHFxREwHSlHsrTZtL1usBxvZ5fP+l0xdBCyxjf7TI9ntFEgk55G7MvRrbSrDXKI+K+VLyAHQ6jCLt55EQNYK9zNAcM1khyAe8WarkeSompkfn+lIn3A6H8/lXEZR55mzmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216667; c=relaxed/simple;
	bh=IBVK3rIKdWW3fCLkuQF25b4vcPNrURKJqfnPddfb8o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UfKkmdQMO0JtRKvgBaJC6fNhGvyionddBwpsY4/sH/JUvv9O8mwhjHKdrCty1BEsA1FnTjelWf748DCwDSWEz/bgEMpspcYCAAYJP2M2MEwRAgdGC4UKXng28GTc4XVJk07mTMcISY+xBf1vZocExNUxuX5xK/2emk1/EFrynTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mjjYm74W; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfGIfBjFLbV3QAYoX5NSp6I2e0xGZqvZdwTR2UQPjUORwSCf6mG3zaVMmAmUP2ccPaI5JSIQ1qujB9VH2ZyIMAojlk3r9Jk2uonlaiVaFCN2oHRqIi2HDrj466Dn+IuEnbn18Okxn12KCgUmWN0Tg5EFFUXpOdB7U8MDE2QcqMUCN3PwUUhwckonNNbASuSnGPwR3X+MWw4P+yvci0L9p+1Y2dPjV+DryQgzfe2qP62y9lbsN4h9qPHLxorPPI94sR6AwOEDy6CsC+Ulpq9EM+VW6Rz0EcNdqSVv9+4F+WXc9efPsXyVVi4CZIVbAKWu+vn7QftvXhnrGNoiYCetnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIdFRLbe3qiBNNVpFNSCkinob5/WXfdpDRpOh92Qjss=;
 b=INnefU5TkWWCfnhhZUGr4+W2dDRwcfMMXcNPseYVg7VSN/jB9LWO5fiucy+P7Y6Wi6O9Ra/pcYlZxJTnNdqMQPhFEeigyoDyCSQ35Jnunli46v87IiY/mi3bLSAgMfIBzD5UOMVl0BIk/TaNc1pvq9zcr5HJnXGWVLXHax2A0HsiPrMHfTJHoee+Ngg7otgY0ZKgmLMQz1FKCv8KbwVkUkeTEfQt0vyfjDMhLvektgAr26OxkEA3h2ZXZy6alxzWKo8+dbZTtGI4e5bv35ib+StlvNfR4/HG3nW/JvXaVTVSyg60PBrMcUz0DtRFF2yJaAwinWqdYm6AMg/wU3jmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIdFRLbe3qiBNNVpFNSCkinob5/WXfdpDRpOh92Qjss=;
 b=mjjYm74WQX3FWOesc28YdpvpTjyGEjvJMpW0LSR+NEp27IVxf3D7uqcpD+DXiWMb1nz0MTseXg4eqLDI35f9oDArbahGFrvZ0PpRxWKa+pUUdqR7c5fP+gims5UDCG9CXVkFdzKyCh20gcSAEGupV/AJh25L8FO5XvQjJyAXk/ENENWqfTXOGHowiCtdCijvRcipK2pzJvnYKPU7t7AYCtFxwmES1HjfmknV0fqxgBkTYOa4rMMC770gm56jxWCVX512d9QP26uO/TQEUqd7AQQLOPdCU8VDu5aaOTSS2tu0a8vqjlcHYQLkQDf0a5wTnBp+Yi9mK8+38V7DuT5VLA==
Received: from SJ0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:2c0::6)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 01:04:21 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::f7) by SJ0PR13CA0001.outlook.office365.com
 (2603:10b6:a03:2c0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 01:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 01:04:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 18:04:01 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 18:03:59 -0700
Message-ID: <e2b35876-db4d-4646-908f-1e7da1814d1c@nvidia.com>
Date: Wed, 8 May 2024 18:03:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] selftests: Include KHDR_INCLUDES in Makefile
To: Edward Liaw <edliaw@google.com>
CC: <shuah@kernel.org>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Nhat Pham
	<nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Christian Brauner
	<brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Kees Cook
	<keescook@chromium.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	"Thomas Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
	<andrealmeid@igalia.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, "Andy Lutomirski" <luto@amacapital.net>, Will Drewry
	<wad@chromium.org>, "Marc Zyngier" <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini
	<pbonzini@redhat.com>, "Sean Christopherson" <seanjc@google.com>, Anup Patel
	<anup@brainfault.org>, "Atish Patra" <atishp@atishpatra.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, "David Hildenbrand" <david@redhat.com>,
	=?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
	<serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, Seth Forshee
	<sforshee@kernel.org>, Bongsu Jeon <bongsu.jeon@samsung.com>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, "Herbert Xu" <herbert@gondor.apana.org.au>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Jarkko Sakkinen <jarkko@kernel.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kernel-team@android.com>,
	<linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-input@vger.kernel.org>, <iommu@lists.linux.dev>,
	<kvmarm@lists.linux.dev>, <kvm@vger.kernel.org>,
	<kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-security-module@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-actions@lists.infradead.org>,
	<mptcp@lists.linux.dev>, <linux-rtc@vger.kernel.org>,
	<linux-sgx@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240507214254.2787305-1-edliaw@google.com>
 <20240507214254.2787305-4-edliaw@google.com>
 <ec8ab737-a841-4cd5-8ec1-e0a777744262@nvidia.com>
 <CAG4es9XPLhHhH-Hfm3_m5zLLtiB1zme8pAazMhErMpHqJcAMmw@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAG4es9XPLhHhH-Hfm3_m5zLLtiB1zme8pAazMhErMpHqJcAMmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 929b3f3a-f4f2-4fe1-03da-08dc6fc3f599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djdXSnE1eGNCMllUVVE3QmwxQmFLaXF6QlJINTl2TzZBMUZscm9sUFdPZ1Nr?=
 =?utf-8?B?OUhiQlBaQ1F4VGx3SmVOSll0aTlzMzNDdisvUkNxTE5CaXlvZlZUaVF2NitC?=
 =?utf-8?B?N0ZHUUFuejlhV0JwMmUrRmZQM1NVL2JXTlBVeWVUZVgweUVHWjZBOUI2STZi?=
 =?utf-8?B?YmtkWDBWcVBieS9hcThpSGt0L3dlemJrdVlZNUtrSUtkM2FlWDhZSlZ0Y0lX?=
 =?utf-8?B?aHM3VnFIV0RlbzVoazJhaEwrbklkTitUTVArelJQNHJUYXR4WnE2cVcvSGVB?=
 =?utf-8?B?SkcrVWtZQU5pQUVXWkhzcXpjWTBtaGx5czFtQ21ETzRuRlFIdjhtU0hFSVcx?=
 =?utf-8?B?WmRpL28wNlM3ZGhiOHh4Mk9QeW5hTUlkK3hYaEJwb1RQWUFFU1JBRi9kVlpr?=
 =?utf-8?B?bFJWeG1udGdOczhvZE9oeExXc0doU0hLWTVKL3V0WXhwNDVxeURWaktvV0M2?=
 =?utf-8?B?UmtQSlBkMCsxUzhZNUhvbm0wbHRiR29OaWZvVnBZMjJxb2Y4d054RVJQejBU?=
 =?utf-8?B?OGJpSC9mSkJIeG5tRzh6bUk1KzR5R3lqMFJ0bUZjblBDeXBZSS9EKzJWWThK?=
 =?utf-8?B?cmZDMnNmSXBUb1VleEh6L2RpYVhvS0RERTJ3ZFlhTkhFYUVGTWQ2aUEwZjJS?=
 =?utf-8?B?algxaEJOcUhua1FQQ1lKMzVOYmxwTzdDRmYvTE4zUjErODB6YUVwYUh2aDk1?=
 =?utf-8?B?NklSckM0Z05jOEVyZkFSL1BSdWkvblh1YlUwQUlkT09aNHFma3E4cEpzWEc4?=
 =?utf-8?B?V3pzYncyMUJnREpjT1lOTFhYM2xHbVUxN3c4V1RYemNvSmo1NFp0VWxJNnQy?=
 =?utf-8?B?N2RvOHV3V1E5aGViZk5HcDBQbGdqT01hQkgwSzcrSTR5T2xjNTRkSEhpVUF0?=
 =?utf-8?B?YkJFRWhRSmZaTnBMTWpIRnpaQVpFYkFEcjBTNFJUWmU1V3ZtWUtKQXA4UDMy?=
 =?utf-8?B?LzBjOWZ4MzdZZXk2Zk1rSk5GdE5vU0x3MjdHQkZSYy9hNngyZkxELzdSVnRj?=
 =?utf-8?B?endhV1ZnTENUdmFsMHlaMGZMa3cwaFVCbEh0d3BPSUc2MXhoSUc1TGYzTmZs?=
 =?utf-8?B?cEV1TkUrSEtxUVJJbklhOUF4SFFhTXdrRnhJR01yR2E0YThRMzhlTFV4TmV4?=
 =?utf-8?B?VG42Y1J3MW5sQnhacmlab0c4R1dYcEgwcDljemYvUGM0NjBmSHZPdENpZEYz?=
 =?utf-8?B?dE5CZGdEaHh0c0QyZ2FyMUZVN3RIZ2VTK09qSGNCbWpCd1hiTXZwRWJqNEdH?=
 =?utf-8?B?ZWxPbWhMTFJZb1F2RUt6L2wvNmNwcnRIdkF4YXF4QmdSR2wrYU1NWWx0R1VR?=
 =?utf-8?B?d2FTdGNaTmFTOHRDZGQ4ZWY5Z3paV2lxa0djd2VmaHpmWFlmUWFGVGtGMUpB?=
 =?utf-8?B?LzFXclhsRnd4TnRKMElDbkdMREw1WFpnMWxBcDJNYjBSUEhhUTNtTWduc3hO?=
 =?utf-8?B?c3NZUUE1RHAxY2Nic05FdDNEOEtnbW9pMGpJMXBTOHAweGk3SWNLY0ZOMmNO?=
 =?utf-8?B?R0dHUlFaNjU5eEJKa3BHZTk0emhUNGhyTVJMSlVHcFp4cTJLcVNDNUxneUxI?=
 =?utf-8?B?dzk0SExUeGJFY2NySXh6bnBIWnNBUk9KellVSk0yWk5WQU1Mb1dkdFJHd3Ns?=
 =?utf-8?B?d3V5Wk9Zc2NtMWJTaG0wTUNuRm1QTm1HajJ6aFFUNzh3N3IwNFZSV2pkMGps?=
 =?utf-8?B?eUxFa09tTFQ2OW96cjVYa3pxdHVOdW1ySkxsN21CNE8vemgvOEthQy9zS3pO?=
 =?utf-8?B?WUw0QTRTOVJ1bWk3ZFZEQTlsQnpCWUVndXJDUTVIQStXRUtlUFdYRFNjcVVq?=
 =?utf-8?B?K2FwN3VrSGNJcDdWc3JLOEdQdW5XRkM0Y0NLeWxNZHBFK2ZUc2dpQytiNnNZ?=
 =?utf-8?Q?+0aBELOIR1jqk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 01:04:20.7800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929b3f3a-f4f2-4fe1-03da-08dc6fc3f599
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662

On 5/8/24 5:29 PM, Edward Liaw wrote:
> On Wed, May 8, 2024 at 2:41 PM John Hubbard <jhubbard@nvidia.com> wrote:
>> On 5/7/24 2:38 PM, Edward Liaw wrote:
...
>> Seeing as how these all include lib.mk, and all use CFLAGS, is there
>> any reason not to simply fix this in lib.mk instead? Like this:
>>
>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>> index 7fa4a96e26ed..df72610e0d2b 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -170,6 +170,8 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>>    CFLAGS += $(USERCFLAGS)
>>    LDFLAGS += $(USERLDFLAGS)
>>
>> +CFLAGS += $(KHDR_INCLUDES)
>> +
>>    # When make O= with kselftest target from main level
>>    # the following aren't defined.
>>    #
>>
> 
> Or how about just adding -D_GNU_SOURCE to CFLAGS then?

Yes, that would also work. I think either one would be good.


thanks,
-- 
John Hubbard
NVIDIA


