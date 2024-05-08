Return-Path: <linux-fsdevel+bounces-19135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE98C0678
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 23:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D61C20AA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402E132C1C;
	Wed,  8 May 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CPOu9RYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717284D2D;
	Wed,  8 May 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204507; cv=fail; b=fOrhpvi1zbquS00TukRpgL4Ofg73Jf74Pa6140E6vvc212BxETy1JQAeRULq46twDfBS3ZdWoSIsSgi79+iikmTYirhTNIe2UpMEbiR8D0r2REkjxPEeR7zuCI3W6u8vE/6hIgwZXXgWPLDTg9k5j5YTP376My++x4qwgLD3Tlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204507; c=relaxed/simple;
	bh=boXRx/eTzdZbhfU+DSXAduXQYT/PbU2cb+8dejAlLNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lCQZjgQ+6JbbAbheXIHfvhNrZ93MHy0ve9K87B0yHOjqE3wv01oFq2bpmEGsptbyaGSnuUS5m/v8/8GaGiW4FuM2AsmZ+jcX30urwwa7vE5zkOEjNFTYFokQooTLmmH5nRMSQiaKqfCFhO2tDdKNVL0Yp0xm14U2JHzBAgvFPQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CPOu9RYl; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8zf/FVGRWen7PRaUCBM5liAeFWpqbSa8QQj4QV+mCGD0njRN0Z9vLWVsQ0AK2atGchtg5ESQcA6NBa7vrMPpZHiOxg2d+ZNQlVOyQmLNfNYyy0P3yTBKknqsPyxD6IDvkYtbKf8iVkogTWZ7kMc1avdSFdO1uRScgo8upaKEUHX3zXNqMGeXml8QtbYNASgXO5usJmWhunQgCSyjNfAkvi+FXM71MN104nyQN7b3oR3HqQddvvCjyqpwt+AtI+IfGgZd8x4r/WoYHyPGNy4OqRl4qyC8GqC5SqjFn4n+/0eNWHCM6xonTgwE54qE4Nn9ePWt3TwLDkutGDVF4QMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlIIGAQPcZzV1QVj1fLa7XKdLklbquz2YLOJaUUAhSk=;
 b=mLVHLm/i33VmB9E+aHcKN0vnXh5lP11IXxfQS4aqaNb3n9XBEz3QhN63D6Bv5T/8RkzDWVY0X2mnVpNL5Md95Eb8PRNUBxdXihdZYhrjTc7t59XaQ9kOoSjqDFyUWHahxh6weyA8r3jtNtMEANjXAFrMAvwixWBZjr3aj/TmkDZiDtvPQECfNWIzzxfxX8BG7OPnYzxsT9+/vWAajUikAQGsmilaDBAkbKPC2REGf9jbsy7n2K2tTD67xaMQxKaKdO0DEX3vbm1KInH2B7wktrxgToB5cDj6WybTygL/+K0E6M2Tc8ijrpLQHhy4i8H1rt3Le5MkuAESmEM9Bmlb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlIIGAQPcZzV1QVj1fLa7XKdLklbquz2YLOJaUUAhSk=;
 b=CPOu9RYla9pE7q2ifNAvOpS3IFRZ0a72Z2VrkGuBvc+KJa/RX1Hp85laDcQ5E4QN2NU9Kn/BJ8MaeLSBjsE6Mz9G89ckhDKaL1IRCJlEOcoJolhdNfTi0z7CETrVx2xJAQPwHmbKv6awqrjc+9MdRICJ9/77OvOC/8UPcYHSaymXdXUA3Pn9exxEeUfOKHQmUSQUzvMCEZHQCmaFEpbl/m5+r5aD8Gx+Aa7PDLDpstTIL6ySxdw2ZOCjYY7fZilkYSrSw/HQ3E9jidS4rNzaaEnX1hmbzp1eTN6TzONhNYmR4q5aS3BeHf9rYq5nRI+wxQ1Zb3cJBgejMl1BbmZ9Rw==
Received: from BN9PR03CA0301.namprd03.prod.outlook.com (2603:10b6:408:112::6)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 21:41:41 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::9b) by BN9PR03CA0301.outlook.office365.com
 (2603:10b6:408:112::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 21:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 21:41:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:41:24 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 14:41:22 -0700
Message-ID: <ec8ab737-a841-4cd5-8ec1-e0a777744262@nvidia.com>
Date: Wed, 8 May 2024 14:41:21 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] selftests: Include KHDR_INCLUDES in Makefile
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
 <20240507214254.2787305-4-edliaw@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240507214254.2787305-4-edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: ea344455-08c6-4345-a4cd-08dc6fa7a5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|36860700004|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3dVQ0IxTC8zai9PQVhRRkY1blk4YS93SHdROTNXTXBWd1VIWlRsb2ZsdlRt?=
 =?utf-8?B?ZGRVbGpMMGJmN2Y3bjlNRzBOSXBQOHVwTTJIZllIV0I5OGdWQ05sNS9vTzdX?=
 =?utf-8?B?SzUzdEdvL2lLcVo1VGk2M2Q3R3A5N1ZYbXFIK2QvZldYbXJzbkxxU2N5WE1J?=
 =?utf-8?B?QkJsSDBISjBxWTh4bFNOajg3RCt0c0IyL2UxeFJmcEZHWWMrcXNVMVg2WFZF?=
 =?utf-8?B?ZmprUnlDUEhhMG4zTlpUSmVqeFE3K3ZGd1J3aHZTR1BsRFRRTGpHVjQ1TkZV?=
 =?utf-8?B?alFUK1NPZzg1V3ZzSlJ5U3dmSWVYN29HOUZqbnJBd043RU5mQ2tCenY3TnU0?=
 =?utf-8?B?Skp6b1U4OXE0YnRDRkNOWHNsVXE1cmNYMDg0NmNHZUpUZnVBdDJXNWtRYVNV?=
 =?utf-8?B?dmFFNFVjVWljVE1McTB3Q25DR1ZGbU4rL29Dd3VjQ1BHRE1xU0xQN3JaR2d5?=
 =?utf-8?B?dTRObTliQnRrZUFqS0VKYXdSR05DcnRLZmZSelhMdzhQOXE5OFNGUGtqc1Bz?=
 =?utf-8?B?SVNXZkpGN0ZpanpQRUhZZm5IK0xDQkkxcEFVUUk2QkR3cU5ya0cxR2JDL3ZW?=
 =?utf-8?B?MTAzNm1EUlFRM05LVEtxaW5McnZrWTJnR2pHTDhORTlzT2RLTDlSSmU4cXVX?=
 =?utf-8?B?SDhwVWNFSnY5T1Z0ckJwUU8yU0ovVTVsTkZGYlFXQlYraW9NamplcTBYTEo1?=
 =?utf-8?B?N2FVdkRRT3hZV2FiNmVscjFoRGVWVDB4OUw4dnlxRnpYdHhkaGEyOUlZekFC?=
 =?utf-8?B?eTdhbmV1MlBkYUNJQzlQNUFhUXg1eTlWSDZDTmE5WVl4c2NQbmF4S2hkTDBo?=
 =?utf-8?B?eHI0Y0Q1ZTl5UlFUcHJnWXhxZzBtNUF6QnNWU3lRcU11bnlGckFpaGlERndQ?=
 =?utf-8?B?djhGK05yK0NsaHBiT3FLemRLTnJrTlVqd3VDSWVvMytzNVdmanBLd2Q2L0l0?=
 =?utf-8?B?UDYwQ1I5L1QzWk1CQ1BLMFhOQU9DdXZpTTFzOW9iZ2srbWhaTEVDRElyMmFO?=
 =?utf-8?B?bHA5TmZKMjhDQ3hDVTUvRlZ4WDk2cFNmTUErbG5zcEVBWklEMSsvenk5UldI?=
 =?utf-8?B?YTRXMndDNzdyYUtjem11dmZmc05vaXRPTU9mUkpwR3VJdmZ6Q1RoOEZ5UGQv?=
 =?utf-8?B?Wnc0eFh5NGQ4UUhJaTVpbkhKK2RpWm5vcEc0aER2TTFvTGlGRFhLcjRCeXRs?=
 =?utf-8?B?ZU9UaittanpJUXlTL2pjWTQyczh0OEtFa2NoZzZFMnNRaUNHOTgxaXJqVGs4?=
 =?utf-8?B?V2JuOE44dlJTY1lZZzgyL1BvS0xDZlFjSzYxYUcxWjVMeWQwYkpGb1BvSUls?=
 =?utf-8?B?azdVN2lVeFlxajd5cGo0R0lOalJlUitZTWx2SzFIdTNuL1Q4L2JQU0ZxdzhF?=
 =?utf-8?B?eG5OREZrdmpvQUJDZGIxNUhWYm9OVFRuSGZMYlB1USttcHd3RXRGb0xFckVS?=
 =?utf-8?B?SWNKVzNiSjFtdnBhNkM5SFFHaVQ0SEJ2Q1RKc1RJS3lrTkhBK1J2RGtSc0dI?=
 =?utf-8?B?N1hDZnJSWmtpaGdPYVJ4cjdXMXp5S3hVS3NyOGhHWWdwb1puem1YRElyTnR5?=
 =?utf-8?B?ampqYjgrK1Nwd09IcnZPQ0tzbDRZV21LdUVITm5JNkQzeFdKbVhDYlNUQVVE?=
 =?utf-8?B?RStJS2x6MjlydGlJSzYwdFFGYzNTak5NRjVGUnE2L3hpeHlSSjc1ZXFlMUp0?=
 =?utf-8?B?ZWRuTkI4WStreU1OTGpSZHdlZmVVS0NHakVrK1VKelJzOFJzZ3l5YU9lSzJO?=
 =?utf-8?B?dm0yblI3UVUxYm9OSGZlaEx5Z1psNlVSOWJWekZFU2NqLzRoWkRrd0Q0Slpu?=
 =?utf-8?B?Z01LSWl5R1l5QW4xZzVtbVdSQWFUbU5aV21yYzkxVzBiaHJ0VHlYT2luTmVh?=
 =?utf-8?Q?TexE0MEIDVlz2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(36860700004)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 21:41:41.1993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea344455-08c6-4345-a4cd-08dc6fa7a5ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429

On 5/7/24 2:38 PM, Edward Liaw wrote:
> Add KHDR_INCLUDES to CFLAGS to pull in the kselftest harness
> dependencies (-D_GNU_SOURCE).
> 
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>   tools/testing/selftests/alsa/Makefile                  | 2 +-
>   tools/testing/selftests/arm64/signal/Makefile          | 2 +-
>   tools/testing/selftests/exec/Makefile                  | 2 +-
>   tools/testing/selftests/filesystems/overlayfs/Makefile | 2 +-
>   tools/testing/selftests/hid/Makefile                   | 2 +-
>   tools/testing/selftests/nci/Makefile                   | 2 +-
>   tools/testing/selftests/prctl/Makefile                 | 2 ++
>   tools/testing/selftests/proc/Makefile                  | 2 +-
>   tools/testing/selftests/riscv/mm/Makefile              | 2 +-
>   tools/testing/selftests/rtc/Makefile                   | 2 +-
>   tools/testing/selftests/tmpfs/Makefile                 | 2 +-
>   11 files changed, 12 insertions(+), 10 deletions(-)

Hi Edward,

Seeing as how these all include lib.mk, and all use CFLAGS, is there
any reason not to simply fix this in lib.mk instead? Like this:

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7fa4a96e26ed..df72610e0d2b 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -170,6 +170,8 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
  CFLAGS += $(USERCFLAGS)
  LDFLAGS += $(USERLDFLAGS)
  
+CFLAGS += $(KHDR_INCLUDES)
+
  # When make O= with kselftest target from main level
  # the following aren't defined.
  #


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> index 5af9ba8a4645..9a0ef194522c 100644
> --- a/tools/testing/selftests/alsa/Makefile
> +++ b/tools/testing/selftests/alsa/Makefile
> @@ -6,7 +6,7 @@ LDLIBS += $(shell pkg-config --libs alsa)
>   ifeq ($(LDLIBS),)
>   LDLIBS += -lasound
>   endif
> -CFLAGS += -L$(OUTPUT) -Wl,-rpath=./
> +CFLAGS += $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./
>   
>   LDLIBS+=-lpthread
>   
> diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
> index 8f5febaf1a9a..ae682ade615d 100644
> --- a/tools/testing/selftests/arm64/signal/Makefile
> +++ b/tools/testing/selftests/arm64/signal/Makefile
> @@ -2,7 +2,7 @@
>   # Copyright (C) 2019 ARM Limited
>   
>   # Additional include paths needed by kselftest.h and local headers
> -CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
> +CFLAGS += $(KHDR_INCLUDES) -std=gnu99 -I.
>   
>   SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
>   PROGS := $(patsubst %.c,%,$(SRCS))
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index fb4472ddffd8..15e78ec7c55e 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   CFLAGS = -Wall
>   CFLAGS += -Wno-nonnull
> -CFLAGS += -D_GNU_SOURCE
> +CFLAGS += $(KHDR_INCLUDES)
>   
>   TEST_PROGS := binfmt_script.py
>   TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
> diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
> index 56b2b48a765b..6c29c963c7a8 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/Makefile
> +++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
> @@ -2,6 +2,6 @@
>   
>   TEST_GEN_PROGS := dev_in_maps
>   
> -CFLAGS := -Wall -Werror
> +CFLAGS := -Wall -Werror $(KHDR_INCLUDES)
>   
>   include ../../lib.mk
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 2b5ea18bde38..0661b34488ef 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -21,7 +21,7 @@ CXX ?= $(CROSS_COMPILE)g++
>   
>   HOSTPKG_CONFIG := pkg-config
>   
> -CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
> +CFLAGS += -g -O0 -rdynamic -Wall -Werror $(KHDR_INCLUDES) -I$(OUTPUT)
>   CFLAGS += -I$(OUTPUT)/tools/include
>   
>   LDLIBS += -lelf -lz -lrt -lpthread
> diff --git a/tools/testing/selftests/nci/Makefile b/tools/testing/selftests/nci/Makefile
> index 47669a1d6a59..bbc5b8ec3b17 100644
> --- a/tools/testing/selftests/nci/Makefile
> +++ b/tools/testing/selftests/nci/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -Wl,-no-as-needed -Wall
> +CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>   LDFLAGS += -lpthread
>   
>   TEST_GEN_PROGS := nci_dev
> diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
> index 01dc90fbb509..1a0aefec9d6f 100644
> --- a/tools/testing/selftests/prctl/Makefile
> +++ b/tools/testing/selftests/prctl/Makefile
> @@ -6,6 +6,8 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   ifeq ($(ARCH),x86)
>   TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
>   		disable-tsc-test set-anon-vma-name-test set-process-name
> +
> +CFLAGS += $(KHDR_INCLUDES)
>   all: $(TEST_PROGS)
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
> index cd95369254c0..9596014c10a0 100644
> --- a/tools/testing/selftests/proc/Makefile
> +++ b/tools/testing/selftests/proc/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   CFLAGS += -Wall -O2 -Wno-unused-function
> -CFLAGS += -D_GNU_SOURCE
> +CFLAGS += $(KHDR_INCLUDES)
>   LDFLAGS += -pthread
>   
>   TEST_GEN_PROGS :=
> diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
> index c333263f2b27..715a21241113 100644
> --- a/tools/testing/selftests/riscv/mm/Makefile
> +++ b/tools/testing/selftests/riscv/mm/Makefile
> @@ -3,7 +3,7 @@
>   # Originally tools/testing/arm64/abi/Makefile
>   
>   # Additional include paths needed by kselftest.h and local headers
> -CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
> +CFLAGS += $(KHDR_INCLUDES) -std=gnu99 -I.
>   
>   TEST_GEN_FILES := mmap_default mmap_bottomup
>   
> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
> index 55198ecc04db..654f9d58da3c 100644
> --- a/tools/testing/selftests/rtc/Makefile
> +++ b/tools/testing/selftests/rtc/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>   LDLIBS += -lrt -lpthread -lm
>   
>   TEST_GEN_PROGS = rtctest
> diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
> index aa11ccc92e5b..bcdc1bb6d2e6 100644
> --- a/tools/testing/selftests/tmpfs/Makefile
> +++ b/tools/testing/selftests/tmpfs/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   CFLAGS += -Wall -O2
> -CFLAGS += -D_GNU_SOURCE
> +CFLAGS += $(KHDR_INCLUDES)
>   
>   TEST_GEN_PROGS :=
>   TEST_GEN_PROGS += bug-link-o-tmpfile



