Return-Path: <linux-fsdevel+bounces-60287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956ECB4448D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 19:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F67BF6C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D4313E2D;
	Thu,  4 Sep 2025 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VnBQxi8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE1312802;
	Thu,  4 Sep 2025 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007281; cv=fail; b=V9EnVx8KZ6DgnXaxRL1nFqoOYJiNXmVRQlaCxuDEk8sq7GbjW5nKG+tUKWCTrZknCAG3A5Jdo2b08g+zSbAOMaydwSFw5F4jbWlfmGhgmq+ytkL6VBJor7apZeznst4tvrfhs7Br27SI8Fu6xbhRnKSdOP9zMVxwvywpFvjgHgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007281; c=relaxed/simple;
	bh=oXvrpJafdKQ0iSat79MpXL96gHtyPd/JpZ5v9ELxkaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bf9/dDr4P5PUI43hqUnmvSK5KvD3VEI/FV09eaCGhm3JzVvZQ94oY5JU5h0vIHc2ORIQeYC7nAbrPL2kzJxVA8gEbjYkvEIrI3VvOq/KV+eooL3NpqNCK0RZI2ACOmQDf3cI6CYEBHE5GzN0eeT904iS+EMXwhAozbWgnwFHjMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VnBQxi8b; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekmqO7Fm7SSlw8vRmNX3H500JRzpNBemIvtJwSSUPANOxdmNW5y4WoFrk49m3k8cO4qZgQFAZz/yOdrT3BGK8QUtmkKe5TL1a2OwnlF2/uGAYpAmE/cna25RCNFDQSUV/RlEBOiJFpIXSPEMii+guqQ1MbH0EScJLwyxO8EXkTf/Js8jBcCBPCbBxnhu3dqybZb5w4we9dbaf98K58XpSW4aMa6g39LKhvLAEDfQEDbtji15/SUXU/u4YOBE4r33QwzfO66Mz6h3E1BcH1MTfVT7mU5SB3X2MYZRCFntUM/auIGG3GFZvE6RxUALw4Lg/nY6meqQVgTE+q5ShCjDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+J8omS1gnNZidD6HpQBltWpb5njgr7U1lD1TVKcTk4=;
 b=WifC5NqVCWMfkVXnPU5oXYHOIDJ4nRIVy/GSwkddYrCnqV1DxePkl1BMRfYEjYhzoWkSvSUjb/xD8PMexCMThIUOFAELQ3VO6//bjrPHuTYeMHFYYp0a+wsB8hEYkHjvie2/IRQcHVsrz/OmCkBkPKhkm82lZD7Iz7QIfd+t0DdVeNOIY0+A88kzhk6DCsr7o2bYut6bTNqOXyX+j1FF7Z484QObX7emeyCRXdVDtGLPorGxX9QpOVIdPdYEXu1CpY3xXfDhCEiUWqoDnTTMFx51QKcgeUMgdxzy5mR+LgXOXaP+yOB24vxl5+Sp1KmOpRuMSEv7G3RkVcwqhULE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+J8omS1gnNZidD6HpQBltWpb5njgr7U1lD1TVKcTk4=;
 b=VnBQxi8b8QPmXq+r5dOWzRaoi9QfAhDmLq2ggqzJsipyS65MvwVlnR8LNMw5T29V0XXzzsRi4Dp5nHXoDSX7jt8TTsKIgzdM7M6UZkWS//cDRbHwHZDwfUm+4pSotUzfv/SEOSDgQUAZA//uZ8wtsTd9b1Gn6QIcZFFgBor1kgqLjbuGV2bwrmb9Ij588MQOaK01uHL+NayjtTlwOBX704UMTTUnngkyR6EPRojvzb/EBqpIWpDKmt3plOV5tcSOUIe5Dykq+CPtEB3sDM1dVng7iZVQNSboPP7e5H2qzwBk0YA7C/O5yULVxkjwgrtwv89MWtuehNNQjEEiMYth9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 17:34:36 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 17:34:35 +0000
Date: Thu, 4 Sep 2025 14:34:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chris Li <chrisl@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
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
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <20250904173433.GA616306@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <CAF8kJuPaSQN04M-pvpFTjjpzk3pfHNhpx+mCkvWpZOs=0TF3gg@mail.gmail.com>
 <20250902134156.GM186519@nvidia.com>
 <CACePvbWGR+XPfTub41=Ekj3aSMjzyO+FyJmzMy5HEQKq0-wqag@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbWGR+XPfTub41=Ekj3aSMjzyO+FyJmzMy5HEQKq0-wqag@mail.gmail.com>
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: f3260731-1526-4e39-1031-08ddebd950e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aurMXdrr6LKoVLcTFvS6PfF5mZYp6DNE3iP2Oru5onkh6xQtycW1/F3PZtsS?=
 =?us-ascii?Q?+2KdryoeJqPae4dzFvq5CPdCNf70QeMpJzyTfP2g+CZr2rR4fpkoutjzVycd?=
 =?us-ascii?Q?s+F7bKfY0Kt4chuRCSbuLCJMYPfDSsUWJirnFSOtcabjEAuNKsJON0cIi/Ul?=
 =?us-ascii?Q?IKRUnPHMBgiI0eCOBlEti9OeCYh38cwhWr+3gdVvg7CsgjWFxrsKKAjyW7m5?=
 =?us-ascii?Q?9SahQmKscdbXJ5c874q/h9K8pNTyDqR6/z40bbZ60oPVwsRqFXpRCKzHNmZ0?=
 =?us-ascii?Q?Nime2qB3URGaxzlBZrPSBdZISxsnfZWcmKcz1tI6RfO9q6xJoHaBfqNIKiGV?=
 =?us-ascii?Q?atToe79gvSE4n3f5R8aMWO8aTVnyobxkJU1FPAY65t604cmBVrmJl4xRbnpx?=
 =?us-ascii?Q?Na4DPvmSz6ZxQdmE4n4h7xKXDjXB3+DUMbW2HfhEmT9c94r/DLz0vrlemrGX?=
 =?us-ascii?Q?pHkZi2trGBHlCepBfSL6edt4jN4C01tMlUp5RIctNXbeVkFAlm57hSn9EygG?=
 =?us-ascii?Q?XjW7nPfdOC3CPLP0bKNhQRzhTbTsvp97zEq2m01ExKys4LMsb7E9A8kG3P9G?=
 =?us-ascii?Q?O5H5JUmd0W23UhJp8GpEvNuB8ckQ5CbqaBjDuZvH+HUXZqV1DKRdIqOhu2oA?=
 =?us-ascii?Q?iEpL7oExaxPXsgADYsijNzxdbnhPPXsIw+o6SMAL8GYi1wwu9b2W4kWHh4dq?=
 =?us-ascii?Q?aVFaxY6wZcRNyGTd0J7JY2VIM4cz8lM2Wk6njAfsWm+B/EGmQtO1AdCQZkD/?=
 =?us-ascii?Q?Jj0UewhBYjrHOm0RVMbF5dCpY3ToGO/QbR7pP3h0DUcoAD1QIzhwNJJzppad?=
 =?us-ascii?Q?xEk9kRlgeWU1pBiYHMQmu2cZ0xWc+JBIdJV/zi+MHsx2lioXn5tH1yI82bwU?=
 =?us-ascii?Q?fpyJ0mpv5xkt1vSW2vhgMGCRzFpV9yUHGdbFZAWny/pkQX1v0TgbpoH91und?=
 =?us-ascii?Q?QBGpTYz6yp2gjYuO5GnRve7R8VKb2WLmhnBX82oRS2QDz2BnFdaJ6RIafARk?=
 =?us-ascii?Q?dyApT01q5PsaHeXC/i3ZfF625JMcRGlUdAGx+/W6OUTWYH6PFCPe6IigL406?=
 =?us-ascii?Q?XZ70EdMPFbNzxuKSjqiFRVuX1+9DafQfO/FpYYw2vO1vt/1f8G9wkFrnKpUc?=
 =?us-ascii?Q?esMllAytk/zOpFCgsK5NoQnPBGJE3kKEOc4JcCfmti/ganpgJP0r5D8MZo2M?=
 =?us-ascii?Q?Ya9ndB1p5HtEnFdIpwYTo5Ho0xqHv2fXn2u8POCPf/bM48UwqkadD5ZD1qRv?=
 =?us-ascii?Q?J0bmTgRMA1KzH7inRW10PmtKaDO8D2fqHqZfE9sEpHgiAYIb2oo0kswWujFR?=
 =?us-ascii?Q?WiOjmi8Dh2Mnz/HrROP35bn01s3yTgkBM/guodMjLZhyKy1A2F1i1R0VEJGI?=
 =?us-ascii?Q?K54QkO/Ei4PMg6QPb2ePQ+Rm9+WX661bt+6f5eXa1EHoL0Wy+aC509C5A95g?=
 =?us-ascii?Q?SkTPrerPgN8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hCv7NbxP5ogWB//mMoMseWsizTYVmg73lt3Xl4+9TZ+UdRCEojeAClmVxb+O?=
 =?us-ascii?Q?2+YnuFaKvrxLqWRRWWislSovHpIW7l7AO0rP1MZ/7KJuhALMNrOhC64ixTGH?=
 =?us-ascii?Q?5BObFgCVNaxKDys2Cs2Q89IOL5EJ5NbOfQbs9tojW0DrP9F776n0jx+OG7/h?=
 =?us-ascii?Q?Rq8kwWC6el7Pg653jBA/Dcx/nLEAc8Fm4tGURj4MlxEXd810EPk4O1zCfJxe?=
 =?us-ascii?Q?qVjSDtq9I72hZ4n6ZR/Ss1ULi1DkFrYweATXQ6Z2UymhtPBnhZWz7Lz4fsTq?=
 =?us-ascii?Q?3JtdqFEeFlVAzLVkSG00ErcAFSSOJwm2p8O+xMO/Ec+sZXh30uQt42kujLY2?=
 =?us-ascii?Q?gFD84RV7/waWE/lMe3BZilRNJ//q9FVwIqv6p1RfzdIN7aAzisRto1h4WU5U?=
 =?us-ascii?Q?t6yylBcysp6/B3yZ9bg4gamW8PwIGh6ZrvcnxPRqh8r3zZTnu3Gw38iI0DVB?=
 =?us-ascii?Q?hIcHpCo/jdkfeyWLhoYEscBMvrluFLND41TmYoep5JXEPGlIlVWJtjyDW7rM?=
 =?us-ascii?Q?k42B5efZd+w1802yJEDu+OVfEYyivMd2Od19PcLD6o/bXr7Eb03GKwtDMqfo?=
 =?us-ascii?Q?eGDLeXBNNpLHvMNCvgHlHE6XIQMOI3F2autGP3s0QaBQhDyHbTbc/Wcpw7BE?=
 =?us-ascii?Q?Cx+rJ2Kg50XxgBPXYRJdRNm8O2eWdSKWzOsmEFT5+VoubFPxZ4eHOu2skzan?=
 =?us-ascii?Q?ABvoC+NYoxTzs6ex/Sr3/kg3+Dfw3Wj2Pmd44LSBIQ7qjeX7ASb3UD+qJ3N2?=
 =?us-ascii?Q?8LTM3KUsDP+68bLl1x5kKwAgF57r5Tf33PFiLArM+9GeuXkztSXGYgcxme8P?=
 =?us-ascii?Q?2+ffCk2HSbAAr4J3nkskBBW7wFg9KYtmuzISVw+pEZ3rn5/WyllK9jVInkqj?=
 =?us-ascii?Q?uOMCK0t4jUqZxVodgaOALjCdIRFYq7ocgiooVVo0o4v4lSsC4OVYwB9TJChg?=
 =?us-ascii?Q?ufmtObtU1VKUPa7LopQ9xXt0Ug2hLhdUoP+TovRq4S4+Y37GAfbSIG/DDP27?=
 =?us-ascii?Q?pvUJksvidkqoEr139asDalLjzwafmsq3Eqjknwv4Cv4GleLy1e6prEGK/RBV?=
 =?us-ascii?Q?9yJuy7vyIVsnO9Mb89zJPyf7hrAGFMoZNOL5XCe/QpW/VP7cl2+VOnr5ePaE?=
 =?us-ascii?Q?nU52A92xxTqnfseB/K5fiLwHSj4ar9rfVZTs4pW7swmZ1rNiMCBnHNVnjFIr?=
 =?us-ascii?Q?uH2o3tGeat9IM0NR1qFRi5GY9ky7i4HXhovhzZSSpwihuSY7H06J70de1yzL?=
 =?us-ascii?Q?OfRXfnxWQSiMaaFCBKngHfYle/mPuTLiicVLnCDSs+5eXCjSvEoRzgKUE/xT?=
 =?us-ascii?Q?3n4nJrrSdV3JgxL9Xh1jKZw/hcpCTBir83oU6uYciOQAUueg5M7xmVlRphMi?=
 =?us-ascii?Q?zXWenecppGI5Bx8I0pDdQNH7tjL5iVYR9UqSgM8vsoKRuLKloyO9FGhyoequ?=
 =?us-ascii?Q?XJQHQsHO6eWxJUgXTsi4f6+b7wfV1eNPYt4P3go6JdsL90xnWNkgGEfQmt6M?=
 =?us-ascii?Q?sQW3XCnM5v0SmcKnKa84gLlmiv9hvnddZeuBNVo5RqNDKwZmwmGzqHmhugCu?=
 =?us-ascii?Q?lbhin1k6pfexo5px+gI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3260731-1526-4e39-1031-08ddebd950e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:34:35.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M544s/fY+8S+xhI3kLyf0nuab/zepz7raQD1z0T7q8AXqazPi4rr3RRD83r0Omz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647

On Wed, Sep 03, 2025 at 05:01:15AM -0700, Chris Li wrote:

> > And if you want to serialize that the optimal path would be to have a
> > vmalloc of all the strings and a vmalloc of the [] data, sort of like
> > the kho array idea.
> 
> The KHO array idea is already implemented in the existing KHO code or
> that is something new you want to propose?

Pratyush has proposed it

> Then we will have to know the combined size of the string up front,
> similar to the FDT story. Ideally the list can incrementally add items
> to it. May be stored as a list as raw pointer without vmalloc
> first,then have a final pass vmalloc and serialize the string and
> data.

There are many options, and the dynamic extendability from the KHO
array might be a good fit here. But you can also just store the
serializations in a linked list and then write them out.

> With the additional detail above, I would like to point out something
> I have observed earlier: even though the core idea of the native C
> struct is simple and intuitive, the end of end implementation is not.
> When we compare C struct implementation, we need to include all those
> additional boilerplate details as a whole, otherwise it is not a apple
> to apple comparison.

You need all of this anyhow, BTF doesn't create version meta data,
evaluate which version are suitable, or de-serialize complex rbtree or
linked lists structures.

> > Your BTF proposal doesn't seem to benifit memfd at all, it was focused
> > on extracting data directly from an existing struct which I feel very
> > strongly we should never do.
> 
> From data flow point of view, the data is get from a C struct and
> eventually store into a C struct. That is no way around that. That is
> the necessary evil if you automate this process. Hey, there is also no
> rule saying that you can't use a bounce buffer of some kind of manual
> control in between.

Yeah but if I already wrote the code to make the required C struct
there only difference is 'memcpy c struct' vs 'serialze with btf c
struct' and that isn't meaningful.

If the boilerplate is around arrays of C structs and things then the
KHO array proposal is a good direction to de-duplicate code.

> It is just a way to automate stuff to reduce the boilerplate. 

You haven't clearly spelled out what the boilerplate even is, this was
my feedback to you to be very clear on what is being improved.

> I feel a much stronger sense of urgency than you though.  The stakes
> are high, currently you already have four departments can use this
> common serialization library right now:
> 1) PCI
> 2) VFIO
> 3) IOMMU
> 4) Memfd.

We don't know what they actually need to write out, we haven't seen
any patches. 

Let's start with simple patches and deal with the fundamental problems
like versioning, then you can come with ideas to optimize if it turns
out there is something to improve here.

I'm not convinced PCI (a few bits per struct pci_device to start),
memfd (xarray) and IOMMU (dictionaries of HW physical pointers) share
a significant overlap of serialization requirements beyond luo level
managing the objects and versioning.

Jason

