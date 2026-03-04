Return-Path: <linux-fsdevel+bounces-79311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DJ/EkyLp2nliAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:30:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB71F9666
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 02:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41C87308C117
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 01:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B821C33A9CB;
	Wed,  4 Mar 2026 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BcLaauwk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F92322B83;
	Wed,  4 Mar 2026 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587674; cv=fail; b=h5yMBj1u/r/dVYqT99e35KgjUeCiaaGWMWUHDGyCqYzMFmSi/Fa2xEy8vr3gcrtYlZkusJcOJEQF9OLOShQIJV1aP5v/A+rNQZSEf+LhRtrR+d6iJd7Y7Dq+6jT1pZjkTZukbOllpKJLV/kwYxTXIS7tDcrvmZDLeLJtcG1EwIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587674; c=relaxed/simple;
	bh=feGbH0xgVJzpoJFDtEE9x1ZTUea2RjK/fNdHGM1s+ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHrZjNn0PgHAwWa8gjzeLyeBIlOEuU7EKXmZetRCuoOiZKltZet+fh42jegkQp1URx03vhw+tVjcTHK6IuVLAJXE1LSIoxnXJkO2os5xiX8KAb42jzyd3MuuAIodHd+i0TTNZS+hmuVtjBYVPbT6PD04BmPMKFglJstgTlmodEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BcLaauwk; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0iVu0oRaYnBStX5V8zWh+or4vWzHPgcub3oSl70gVTAku0eXa+wS7ZaokJV0JOpd3b6vVz0dN2qddQSukYjzihAj7ddsBCPuQ3m+nVA3zAqSFqPy2ODUTRALkPhmo5h9yqj/mUOYJgBUMDN0q2Rkk8cU6CfF3ESsQ6KEq4DhGrlgwDb8W7kPPtRd3nldKuqgofcw9tsrZ/wFOY9Xm9fHf9sRmXc6DlA3y4/twcROxQHZ5pWD4QG6IErGfN9YRqDHTZoqS1azy2ZEr6cgRm2n5riH4hwGF0LpNKHMHTtRPD4ZfIxl2sLtNQgHLVu8B4Ud5h0W1zgR4kwkMQ1GSgkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWX3eT6p4fXBUeVs633dJyml1vlPH261gl8a3ZsnfQE=;
 b=Iq0i1J7WAdCIRWFUWB/18M1c9IdovuuO8vG2ZPlYNN+gbxRF+8lgDeZieQP1SUQfAq5ntar37mIwgfn5Oz3BbbLcjtFIl21Dosv+zqrk0EWcXDVCTvBc/IqdtxbHIsNXGKUxlc+S2r9WHvVYyCptLPICYZfIhz4aR9gE0zEpKwGDUo0rBKDdRu52mnsyyGzwh/MhO9A3FMw1V8ILClnhl0TtdRrRoyAhgr5ajA72BYWTg3oKLOium7FuSxKh/nw0cyBKtzQ2SDfVyd5ttpFYPOVIik6TMJOChPJTp3qF3yeDF6uI8TXWUm8boIyA9uygiGHY/oif6cD8ohjD6LY6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWX3eT6p4fXBUeVs633dJyml1vlPH261gl8a3ZsnfQE=;
 b=BcLaauwkyLA4YizK5LZX6K5uYlMqOdSo/X1bo/atutQ/ejAjm06+LnIEG3WjB6/SIwAoUs7UXj89LYzVct1TDD5CdvI9VX87crwkk9xwoXGqmMoKIctGoIYhbP4qAvux2O8BH3ZC5qxZ18mutsyM9uN29N5bTj3NNW3NPmCmKk5joDXpRmFlIOB7tCPWk1aOuWoe3wRsAbNhWiiA/AvqzkS72+DhvV60Wx7KBGzrXNI1oIYd49N8ScgyaWPzSOUDn/dsEYmPZe9uvs9Z4takJtSXXGwil0U2ScZczN1r1zN9/Q8I6rEOKXGq6plfJp+nXxB6wJGF6uWXY6plp2BpdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 01:27:37 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 01:27:37 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Anna Schumaker <anna@kernel.org>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Carlos Maiolino <cem@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chao Yu <chao@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ingo Molnar <mingo@redhat.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Simona Vetter <simona@ffwll.ch>,
	Takashi Iwai <tiwai@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Zheng Gu <cengku@gmail.com>
Cc: Yury Norov <ynorov@nvidia.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-block@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	dm-devel@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	v9fs@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org
Subject: [PATCH 7/8] drivers: ALSA: use rest_of_page() macro where appropriate
Date: Tue,  3 Mar 2026 20:27:15 -0500
Message-ID: <20260304012717.201797-8-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304012717.201797-1-ynorov@nvidia.com>
References: <20260304012717.201797-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:408:ec::8) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9eaa48-d77e-4968-6465-08de798d3708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	DVvXGtpxfjOKO3JcfP/1ZiRzhs9ZKXlzfZMNW1FYLjT6r9fA83fociKxHtkhHPPXH1Laowy6Er5gdxeImIg/VU1+8k/e9vZp+y8pxUrybsO/KhnSq9ppK9VtQenR6kteXnB2+9tPq4ETxUqGumgdQ3o+WzTDj9B9YiV7ID4PtuUfzYdXriE4h/nvEUFzEdAVe4oDv/fJXOJ0r+KlDUFRvvOtwvZjDAVb9NEkWfpdREqLD1ChwA3XChMPDazqlLDI8l5AfExkCwVw8LHHAVxdPhF4vytGe6yzh0HJkLW3SjhT98h8S2wEBdUhOwASPxYJiTFAvkoxNnO/eXvRiwmMvYjrWJKnN4d0ROUmrWLBSKfwrmDWrgD0mIDjVyC2NnwzN5ciKvdC9OVnHbHE9UGxRxALxlI16U8aN6aRHWnUBVKtjRLWxWzQpEqj/KyIz58lrP+ME9oXzSHSlmxJfMJVYNJ/iXZB2Id/2RTx3E0yOdagTGmOpndWEar9vVOjThDYQBIVWf4LlKiH+ntnxUrqIHivoQbusk2832vEtwUfnb216T3w5Rad2DBkXcIIZiRqLpC7UAXr+sgKdJWD/JKnvsZ58m4zTqMNLR/7vpfUE22gLni8cCQpTGMbNshIDpwyMdgRb0wHfTn+ujt/pHYNkb5ynHReoHEIVBd7Pqau9KTiZuUoEVCJJRViRUxKR2BSG2FcdNIwAFTMRC4E7NQbXrWV4K/bm07CECCQj9tZbwVDAckHkv3+KpD3re+YhN2RSxqztfvvHcGlPDbixNe3vA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CuB//gjPgcLROadOGKRtUXfVSHyEdOq3e93TKy5P7oo+d/6f3bYBrO1hJjbd?=
 =?us-ascii?Q?54AlyTbtDnwuXkoqw36xJUmBCQ09uz1nN589lRtiiy/PlvqEP485wGwWFbyH?=
 =?us-ascii?Q?yGVa9JToxHfpdyC3ugD+uXBbA/TQc/4a/MzMMm6uw+oJd4tnVhOWBOmNOOEy?=
 =?us-ascii?Q?Vk9GMZJfwFCyykQxAipF8O81Wu4ra5FiLijq69qf1Kxs70v89rzKfLtP6tVB?=
 =?us-ascii?Q?Pe1e0Rg9N5aH6A2/Sm6bZdb5G3XYXa6Y4LAKyLJBG3ZlddeCPBlq/NPOGzuV?=
 =?us-ascii?Q?5qdTgFwMICAs+JsJbm1uJaCQA2RVTEhqNsFX54xWMM1ljH/CPN2trFPF1ef5?=
 =?us-ascii?Q?tquk7oG1NEpazaMAgPzpnHJ7kZpfpo+iDP0J+2Ux98laovbRNqfSXUKl+bgN?=
 =?us-ascii?Q?NXrQgAqSpwTfW7OMeZqnFWDFz5XkaoCw7yuI/VKrBXoZNPa/NTB0cfhY11Hw?=
 =?us-ascii?Q?WUXi3Yg+dZvJ0qc/4hsYbX/RmRRT+OBMvLNlR9xk54MqTLREuDtasryeMafP?=
 =?us-ascii?Q?TStpUn2Vd0DeG6oVjdWH5PXUVpd9cusIPdK/UN0UhmCtIlLYF/wnTSvtfdyG?=
 =?us-ascii?Q?2BC5ct7sn8jwVt1imnmKJJ9Bq5cbtL3ahaybm63z+gUD4Gr6RzSUXgJWneg4?=
 =?us-ascii?Q?kNhe7/SlNbsefYQ5R9GfmYZ8QzOG3MVw4FapejeFtzm6pMUoqKMNlpcL8GBH?=
 =?us-ascii?Q?FLcyvI+9NP07888LOyEmouSV/a9I3BzE+YvU+9FMX1yY7nRveGNuHHSX07DQ?=
 =?us-ascii?Q?HrMJBq9URvjN+BhVZj7diiBuo5NPZEcAQXqlzqBcVWjT/B6l6h538sqlmIqf?=
 =?us-ascii?Q?5UJL7jEBGp04qNUOOoFQV9c1iBFGeJpJWnmVp2Y02eijs6wn/I5jJOo6/YTz?=
 =?us-ascii?Q?6wA9uzJ/b+uROHELdgveEM7Hs0u+Jl6YQSEbRWoyUmS3GmBNQtBxnOa1TVuH?=
 =?us-ascii?Q?nP6uJbhYo1aztNCT9N1xDhd9OdLmUD3a117YZVrq2mB2prNYKpoFcu+I1dN1?=
 =?us-ascii?Q?2mPMthvMjTrFLq9Ql/vi+o+uLRStForK1tQBDWwodzU7ALv1PlEqfrTKuNe9?=
 =?us-ascii?Q?1Y4widhDe2Z4eH/U/qwuzFF8/AfGB6gv8copnksFADEDbpYEBEuh5iHcrefH?=
 =?us-ascii?Q?CY0K+K2BkowA9e3Y1AEW57jS4yUUuFGj47n+vwCZa0AoofK9nt07Ii8A6xOW?=
 =?us-ascii?Q?3esRVmKgpE+CTX0ZDxgBiy2LhTRP8X3S0DoCB9aatK+eCriX71wWxFb8TN0Z?=
 =?us-ascii?Q?eh4Av017KJHX6+M0JF0mG9pqsYay3cQNDs8KvtqHprMx/H+6p44UiE8Uqxkk?=
 =?us-ascii?Q?U3MXMId8cDQ35XWh4sjsNzOO0UfcHHcMR41/M5O8X3YOFL3LhQDQYTzg1e6O?=
 =?us-ascii?Q?vWJIm/q+j0oOwE0vtAzaNe/YcgHZQeNpdJIh9m7cix8ScH2XsgMwY95UvviV?=
 =?us-ascii?Q?BrDsqdYQXAB7WzNC9GG7irTJGj7OLmK/rj8efEB65JVQvZRNkQxoTTat/B2i?=
 =?us-ascii?Q?EQaAMeaaBcjW6sx/BvsI9mYv5zDqKawWHlyYul+JllfHECrqUEWPRaYPHh8h?=
 =?us-ascii?Q?g1ZABhiHDDmuzHSQo9AkFtg2iV17xtm1IOCHhmc19qWSzBINaZJbnwwTuEqz?=
 =?us-ascii?Q?CYY0NU676LNxu5RHwcZOguS54jscNsBWVSVlZ6K4JNFlTZAcq8Nod1tgoZgJ?=
 =?us-ascii?Q?pvS0QTW6aACzFprvsawc6QzKixCpaxA4XVVF4rpQkmo4IhxKuQZzcU3L64vZ?=
 =?us-ascii?Q?Ml/LLzxHIB2aS2hJDL5CE0lLtrTQGapFMTQViuXPiEODk2SSYHSb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9eaa48-d77e-4968-6465-08de798d3708
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 01:27:35.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68bWaQ0b1wdGjpLS7Z+T5PtKeLUxcw+8APaV+plAbdN09V3AhKcwleD8x1xus9zTUd9zSYRS6/cp9gGSTmrIPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
X-Rspamd-Queue-Id: CEAB71F9666
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,davemloft.net,redhat.com,mit.edu,eecs.berkeley.edu,fb.com,linux.ibm.com,zeniv.linux.org.uk,dilger.ca,lunn.ch,kernel.org,opensynergy.com,alien8.de,arm.com,linux.intel.com,gmail.com,codewreck.org,linux.dev,google.com,gondor.apana.org.au,perex.cz,kernel.dk,ionkov.net,ellerman.id.au,szeredi.hu,dabbelt.com,infradead.org,intel.com,ffwll.ch,suse.com,ursulin.net];
	TAGGED_FROM(0.00)[bounces-79311-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[86];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Switch drivers to using the macro. No functional changes intended.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/block/null_blk/main.c         | 6 ++----
 drivers/gpu/drm/i915/gt/shmem_utils.c | 5 ++---
 drivers/md/dm-pcache/backing_dev.h    | 2 +-
 sound/virtio/virtio_pcm_msg.c         | 4 ++--
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f8c0fd57e041..89e9651b09a9 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1147,8 +1147,7 @@ static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
 	sector_t sector;
 
 	while (count < n) {
-		temp = min3(nullb->dev->blocksize, n - count,
-			    PAGE_SIZE - offset_in_page(pos));
+		temp = min3(nullb->dev->blocksize, n - count, rest_of_page(pos));
 		sector = pos >> SECTOR_SHIFT;
 
 		if (null_cache_active(nullb) && !is_fua)
@@ -1181,8 +1180,7 @@ static void copy_from_nullb(struct nullb *nullb, void *dest, loff_t pos,
 	sector_t sector;
 
 	while (count < n) {
-		temp = min3(nullb->dev->blocksize, n - count,
-			    PAGE_SIZE - offset_in_page(pos));
+		temp = min3(nullb->dev->blocksize, n - count, rest_of_page(pos));
 		sector = pos >> SECTOR_SHIFT;
 
 		t_page = null_lookup_page(nullb, sector, false,
diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index 5850adaebf82..9a0a6f67fef0 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -99,8 +99,7 @@ static int __shmem_rw(struct file *file, loff_t off,
 	unsigned long pfn;
 
 	for (pfn = off >> PAGE_SHIFT; len; pfn++) {
-		unsigned int this =
-			min_t(size_t, PAGE_SIZE - offset_in_page(off), len);
+		unsigned int this = min_t(size_t, rest_of_page(off), len);
 		struct page *page;
 		void *vaddr;
 
@@ -135,7 +134,7 @@ int shmem_read_to_iosys_map(struct file *file, loff_t off,
 
 	for (pfn = off >> PAGE_SHIFT; len; pfn++) {
 		unsigned int this =
-			min_t(size_t, PAGE_SIZE - offset_in_page(off), len);
+			min_t(size_t, rest_of_page(off), len);
 		struct page *page;
 		void *vaddr;
 
diff --git a/drivers/md/dm-pcache/backing_dev.h b/drivers/md/dm-pcache/backing_dev.h
index b371cba483b9..17e83b38b845 100644
--- a/drivers/md/dm-pcache/backing_dev.h
+++ b/drivers/md/dm-pcache/backing_dev.h
@@ -96,7 +96,7 @@ static inline u32 backing_dev_req_coalesced_max_len(const void *data, u32 len)
 
 	first_page = vmalloc_to_page(p);
 advance:
-	in_page = PAGE_SIZE - offset_in_page(p);
+	in_page = rest_of_page(p);
 	to_advance = min_t(u32, in_page, len - done);
 
 	done += to_advance;
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index a5c4e7027717..5d1b0dc08234 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -56,7 +56,7 @@ static int virtsnd_pcm_sg_num(u8 *data, unsigned int length)
 		phys_addr_t pg_address = page_to_phys(pg);
 		size_t pg_length;
 
-		pg_length = PAGE_SIZE - offset_in_page(data);
+		pg_length = rest_of_page(data);
 		if (pg_length > length)
 			pg_length = length;
 
@@ -96,7 +96,7 @@ static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
 		struct page *pg = vmalloc_to_page(data);
 		size_t pg_length;
 
-		pg_length = PAGE_SIZE - offset_in_page(data);
+		pg_length = rest_of_page(data);
 		if (pg_length > length)
 			pg_length = length;
 
-- 
2.43.0


