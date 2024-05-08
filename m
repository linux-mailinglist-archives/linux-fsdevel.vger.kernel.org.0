Return-Path: <linux-fsdevel+bounces-19132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814BC8C0634
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 23:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA1D1F232F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 21:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C1E13248E;
	Wed,  8 May 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="psPKObxQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0C12BF23;
	Wed,  8 May 2024 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203419; cv=fail; b=Q0Ofb2k8JiQ5BlNGGpxtnn0oZtLXj3nxKxfcDm5FeaiNJ8bDfsPSnsJCx6L5PRHXqX/JtKJ3OjlTB3MztznmUlmnmGlLLfE0tl/WDkUnuDUYswzcBdFm3fEnCvDpVM6e1P2BPVkZEbKhFwrBXxxPtWjOZL8edxNaEZHRwsVdUvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203419; c=relaxed/simple;
	bh=1Q8o/yPbXZ1c1kX6urJFvrXbJw0nYGkYCIRTOwENeMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jInmQvwphZa7V1AVIUnDrjJusjBv/0enqGr9JddSleoRDhfic11B03tlwvGgYXI+0Af1qL8NFd+iBtU8dCik6Ooiq+FrvTs6FYD9PkjyjwFv7cajUoedXMw1RtWz/4oKkI2bjiVKxgrn8I7pMeUhXBeeJru+hGV2KS5n2DAJS3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=psPKObxQ; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANe4hHjJ/53dF/sABv6nNxv4gMj3H7J7I9387QmpliI7VZKZUeYmkX9G9zxSm1rmYwkq4i8pTrPYkVtY2q0uXFXARNao1/CrOzPMUlQu5Wr1hcxXzTyYpXwCtJdyLDqLGjOSCt1Wn4GoQ3NYN5JvELGSVn8aCmI7jsZPqT+NYtGlqLMwYAwxCZxfgg0/BEk/zr2f8jg4rWWX3V93YqoT9wsZl2An/mUB6lU765BQaFGqQcclslsb50k+j3JX7Kibk7E636nZGLvvaxDzUWwKjGOUbwx8WhdqegyR+ivlMTqMG+F7jxXEsgmBdeUJvhJEJHHxFr5MSB2CypU+Ej3EuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cuVI8nLklnsaIy8DNNA4KfuSqGhFVXCYf9GP8tFTcg=;
 b=ZykZd2OmIIQxN91XQWfwxbcyPocqgaEN9xa4/CLDq36ReDFbIRgjE01DdnVtYnVY9VISYBJpgzf52Q5H93zQDCBx8NBqxj0qEN9w8UKKCahkgl2mTYf3aMJoM8bN9NpBg1lfSPbOfKm8KUrIdx5bolVi8Na/MYeVeik8Z77QUN8iA53XaS6G9ZhrqrHNbWwsEAMp9gX6Z/cHgl2LqxMAms6F7MMzt5YHl/P24Ubd4/sS7JHsi/u6fAxDmta4cIYY26IWM1SS3tpfn3LXrXJDO7+gZnt3l4tKZlWdSe9B7b3iSvi5UAVP2oD26y0o/+pF0/IxQD0XMS4LfXTcRhekQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cuVI8nLklnsaIy8DNNA4KfuSqGhFVXCYf9GP8tFTcg=;
 b=psPKObxQgEi38/D3LYE2hRQ/gIgJEz0RWCwQeUZY2ulUrztApivMnF3HXW+iLMqdL0TnPPXs9jo7WY+UifIZbzHJNy2E0pN6u89Z+plRAnNhtSyYV1NbEoVHlf+3Xwarq4YNE4Zpg2lXI1xEgron8fcFhNB3Hcxy7XyDnftrO2Wb3J39X6O4kbJ0DWnhjdvR90egkvKMJ4Nb9mG2zUpe9Qh08H6hQwyFh5FGFtlj/IN2f8/TkqK7wZWwi1O9H8AiHmWkVMTGIIo9Znt++NYGyOnCuzilPSmxjYATCtfpQfZs9O4VBsOv+Oh7358ONSWJY5XN+QkwAuSfXBUJn1i7HA==
Received: from MN2PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:d4::30)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 21:23:33 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::d0) by MN2PR04CA0017.outlook.office365.com
 (2603:10b6:208:d4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 21:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 21:23:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:23:20 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:23:17 -0700
Message-ID: <ac8c217e-4109-4ca7-a7dd-fc4fc8b0a4de@nvidia.com>
Date: Wed, 8 May 2024 14:23:13 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] selftests: Compile kselftest headers with
 -D_GNU_SOURCE
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
 <20240507214254.2787305-2-edliaw@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240507214254.2787305-2-edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 583a5497-99b4-4096-1a3a-08dc6fa51d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|7416005|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bytMZXpSOXR2cmtpOXRCU1BHMnpWaEdjcW1lVUFXOHFMUU15NHN4UUs1NXd1?=
 =?utf-8?B?eXcrWitXam1XZ1N2cW11bzB3eWdNQWdOUEg4Uk5xa0VHQmtLSWRHbms1anBh?=
 =?utf-8?B?QUJ6SkFFN1N4Y0xrTHlzWU4xbkNCUWtNeGZZU1MybVZwZUlQam9nLzV4VFQ4?=
 =?utf-8?B?L2dSakFnTHJ0aWw0MU5QUm8vaW8xejNHQjBUTzFBcmdlNWZ4ZlI2WXl2alVZ?=
 =?utf-8?B?bVp5ZVhiaG52eUZKNTc2dnRjWHFzR1REejY3SmFsMXVNelNqMHhkbkhTQmdN?=
 =?utf-8?B?UkNRLzc3NVIzNUk4enZTQ3ljUzFJbUQrUGoxQVZYa1dMNE5ORjVrZXBhQkdy?=
 =?utf-8?B?T29WNTYzd0gvUEQxak1FMWZDMG9Jem9EQ0dRQy9aOG1WVFhNMFIvOFhVMlNO?=
 =?utf-8?B?QmI2K0xzVWVrSnlxQmFFa3ZKN3RVOC9ySEdKSWptUjFQYmZDZ2FtMWFTVDNZ?=
 =?utf-8?B?ckZBVVdWQ1lRQ0xYbTgrOVBoUEVUdlhzMjU0Rk1KV0lmRUdZci9aaHRnMWl5?=
 =?utf-8?B?MUJmMTRNQkZ5cXZ4RytNWWtGUm9aWVJValZZVldhY1pEaWRLS0tIT0o0RG1W?=
 =?utf-8?B?RW5XVUdYUTJDQW1kT2hFUHo4VmJ3dHBZNkNVeTdoSFhGLzFBQ3ZlbXNrVk9p?=
 =?utf-8?B?NUVyUmtyeEJRVVhNYmt0ZzBZVjYva2Nocll2VHYvSXNLYXFjSG9BY2Q4YmZh?=
 =?utf-8?B?UzNQRDNvbzlhWWZpSlZZbWF4eDM2YkdCbXRmbzMwL20vWFF6aGlpam1nVG95?=
 =?utf-8?B?WW4wNWFDN2JreFhRdGFLNVd6QVNxNXZLL0dndnNkNnRmNGRCSTNVMmJxVVV5?=
 =?utf-8?B?NDYzZXR1T3hFVVIzRm1sdWVBdkg4L2FacERMeldockd2RDJlVUdPOEJTL0FE?=
 =?utf-8?B?VWM3UnBmODdlS01XZFNTZDg5Wk5IcDRxTkRNV0ZQVHppY0NyK1RwTnR5bmFU?=
 =?utf-8?B?YTQ0R3BzVXZ1Sk9Rc2t0NWwvYjhnZEpHSGZmSjRSMzUxQ2NaUHdReXFxbC9Q?=
 =?utf-8?B?Ym5IRlg1S01senRWNjJXMUlTS0F5bnhDS2dHUEw4amNDcnpodDdLRDZHWGc0?=
 =?utf-8?B?Yi9sSXNMTDFRV2I2UFg3dmk2YXMxdGxoTGdwYzZ3YVAwTnRHb1dmRkZmUzU2?=
 =?utf-8?B?cU9DdHA3T2lBVm5DU0xsZ0wvTnFVdmtDaWIyd1NVWDRMdlM2Nko4Mmcvb3RZ?=
 =?utf-8?B?RkdSZHhjVjVpaVhZekxhaXoyREJRUXZzVm1zY1VqWjNxT215ZmdURnRna3ZF?=
 =?utf-8?B?MG9icHJraWdtZmlKM043WmY1YmtxcHBIRnRNeDA4aVFMaXErc2svSFpHbmll?=
 =?utf-8?B?RW1KTzFzVkM1YVdkRnNQQUgwbkNlVVJKWjVKUXBOWTZkSHVqWXN3RW9SNVFr?=
 =?utf-8?B?U25vYTVsSzF0bDNwQXdSdnpnZjRWTFp0TURCeHE5d2JRajB2NXVaaC9EMkwv?=
 =?utf-8?B?Q2VnYTZ0eDZ1dUhVRVVUZzBIMzd3YStxQ3cydVNSRUIycUsxKzRyRjQrSjdS?=
 =?utf-8?B?RWEvaUxtdG1rTDNianVBUld2TGExa3NBZ0dKRWhHWGhkR2c2R1VlV0xtc3dZ?=
 =?utf-8?B?dVU5RzdFOWplSnpXSStPMDZMcCtxSnBEZTlnZ0pPN29MRElZVjUwUFBVdVEw?=
 =?utf-8?B?YnN2M3c5Qk9SNlVZRXQrN0VKOWF3ajdGYmNEclB3ZkpJdll2MFY5ZHNwTGdJ?=
 =?utf-8?B?RHFrTFdudjdDNWx4Smk4c0Exb2hMaFl1UjRIZGlCbnVOOHB3eXdlM2w2eEtl?=
 =?utf-8?B?T0hpS2Jqd0xzTFduTG12RXplMFpBVmhWTFpRSFZQNnNxdUNBZXdZQ2VXdysx?=
 =?utf-8?B?OFhLSkc2RlBsMEJpaGw4Q1pHcm5zVlg4ejVOT2hhTUpxenl0YjBOaFNDZU1t?=
 =?utf-8?Q?kcyOIn2L58iU1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(7416005)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 21:23:33.4556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 583a5497-99b4-4096-1a3a-08dc6fa51d96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

On 5/7/24 2:38 PM, Edward Liaw wrote:
> Add the -D_GNU_SOURCE flag to KHDR_INCLUDES so that it is defined in a
> central location.
> 
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.
> 
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@intel.com
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>   tools/testing/selftests/Makefile            | 4 ++--
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   tools/testing/selftests/lib.mk              | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index e1504833654d..ed012a7f0786 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -161,11 +161,11 @@ ifneq ($(KBUILD_OUTPUT),)
>     # $(realpath ...) resolves symlinks
>     abs_objtree := $(realpath $(abs_objtree))
>     BUILD := $(abs_objtree)/kselftest
> -  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
> +  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
>   else
>     BUILD := $(CURDIR)
>     abs_srctree := $(shell cd $(top_srcdir) && pwd)
> -  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
> +  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
>     DEFAULT_INSTALL_HDR_PATH := 1
>   endif

Just a small copy-paste duplication request: can we maybe do it this
way, instead, to remove the duplication? It's small *so far*, but
still. :)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index e1504833654d..13a5b11db59a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -152,6 +152,8 @@ ifeq ("$(origin O)", "command line")
    KBUILD_OUTPUT := $(O)
  endif
  
+KHDR_INCLUDES := -D_GNU_SOURCE
+
  ifneq ($(KBUILD_OUTPUT),)
    # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
    # expand a shell special character '~'. We use a somewhat tedious way here.
@@ -161,11 +163,11 @@ ifneq ($(KBUILD_OUTPUT),)
    # $(realpath ...) resolves symlinks
    abs_objtree := $(realpath $(abs_objtree))
    BUILD := $(abs_objtree)/kselftest
-  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
+  KHDR_INCLUDES += -isystem ${abs_objtree}/usr/include
  else
    BUILD := $(CURDIR)
    abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
+  KHDR_INCLUDES += -isystem ${abs_srctree}/usr/include
    DEFAULT_INSTALL_HDR_PATH := 1
  endif


>   
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index d98702b6955d..b2a1b6343896 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -51,7 +51,7 @@
>   #define __KSELFTEST_HARNESS_H
>   
>   #ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> +static_assert(0, "kselftest harness requires _GNU_SOURCE to be defined");
>   #endif
>   #include <asm/types.h>
>   #include <ctype.h>
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index da2cade3bab0..2503dc732b4d 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -45,7 +45,7 @@ selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>   top_srcdir = $(selfdir)/../../..
>   
>   ifeq ($(KHDR_INCLUDES),)
> -KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
> +KHDR_INCLUDES := -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
>   endif
>   
>   # The following are built by lib.mk common compile rules.

The rest looks good. And whether you accept my recommendation above,
or not, either way this patch looks good, so please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA


